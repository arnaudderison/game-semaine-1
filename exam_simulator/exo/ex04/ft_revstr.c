/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_revstr.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: aderison <aderison@student.s19.be>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/06 01:25:18 by aderison          #+#    #+#             */
/*   Updated: 2025/02/06 13:39:22 by aderison         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

void	ft_revstr(const char *str)
{
	int	len;
	int	i;

	if (!str)
		return ;
	len = 0;
	while (str[len])
		len++;
	i = len - 1;
	while (i >= 0)
	{
		write(STDOUT_FILENO, &str[i], 1);
		i--;
	}
}
