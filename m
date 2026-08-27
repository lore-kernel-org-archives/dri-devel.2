Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730FBC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 21:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8415E10F1D5;
	Thu, 27 Aug 2026 21:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tPjCZ5O6";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9062B10F1D5
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 21:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM4Qa3uNlTytutAD6at9m1CYecDzPpqbqGjrSfmicDSpl3hBjZV67/YxENpj4pW0v7XU3ZAF+E4gfRpV3Y37qXkVzVFnu4YwbXjusJintuoXhK3dsEDe44v9rPeLFi+DXCj04ctqzCC3NuXOqy8c5knQ18G7bj0z/D2UdZBvyIitIcrcIfwCkSYZEWwFyB9Xt60W1ZsXT92hFfLj1KfvJwxlGhosyZNeTR01KrS/l+RkGLJDwTJqouvwuc9/F6NnEyTPlQGYDausKJGFMUitOKAIzra/0OcbOy2SCzxLxBn27CI/52wai32oaVXbdXHNvncdzQl0x0003I/NoyNM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkROnf4R4zmOTKafZOnzqXyrDFYpM6omdIAN8f8Qmqo=;
 b=jdaVl4rZjNgFY+mkc4x5Jw/bccvKS9Y34CTnGQzI8NuG0yrnAkzWLJqqsWtuy0D7G7hl2OWcuSEXIC2bF5mlu0uYyo9SXKD4rxuyjyBXjgWF1Cx8TFkUmDZUsdV1d5/RoOnM3pCWVocuZ+a1LrGj47OhyzLiuB9HYlQrpiuWwkKMYYnghhU1rQzGsvoH1mvVTfUNSyqKYr3kWhaz7gaVWQUIXoh4di53tmT48oVW6AOnIJ+M/W0zI1Mx8hmiyqDezZkCm2r6bxs20MxyoKqzjFwkK4iIk/iWjRMAMdRD2QyL9mYiRBzz6Oz2btm939OoRO3t8PAAoCUFj+sAc+3bVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkROnf4R4zmOTKafZOnzqXyrDFYpM6omdIAN8f8Qmqo=;
 b=tPjCZ5O6DT0y//8b6LpMibHbNwxlP1Mwf3hspNfHi6ATeB/EDwqiiE1Y5uZSdwtY+hBF++xfzEuhDPFJfJ9BTtR6eshtWcCa1+aAB/1yTWpOgTBP6D3q5zV+YkOJPqfmWaHph3FVyLWqRDHWMzPL+l0KUFs1gYKB5pZ5dZXMPPaXXWzBIcEti16eX2OW/J010XuHg0vrtmHuejM2bMBri0ApL163X9cUKgJTOJLeeY15H+a7aTnYePNTQCa+8XC3srH7XNi7TR0nfI/MBTJg/Z8SmF5oXArZxPi/vh3UBy0vaL3pPWRMDNhHQBJksCLFspRe/qYNgG74nhYlQrpmtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB398878.eurprd04.prod.outlook.com (2603:10a6:800:35f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 21:10:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 21:10:31 +0000
Date: Thu, 27 Aug 2026 17:10:24 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] accel: ethosu: Factor buffer bounds checks
Message-ID: <apCnwBpxGhkNORfS@lizhi-Precision-Tower-5810>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-7-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-ethosu-fixes-v1-7-346f9ea8791c@kernel.org>
X-ClientProxiedBy: PH8PR15CA0017.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB398878:EE_
X-MS-Office365-Filtering-Correlation-Id: e50d7aa9-b953-4e4f-2e68-08df047fa0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SB70AoEWnrxRocb+yPjnM7S+TK52qwhWsMjHt0eDGo4/sxH1r+IZfcQJClOSg2Al8iBMNk1+zR5JiMHi5b/6aEiK0PmpPCTKl7n9yo7DBwb4TeWs2U44kMg477DVIxPzKihWA8dLQNYhYmUm8wuMEM6vrDr7ycKiS/yixvL4aJDX4pKPABMFn0HgZtuk2VGGdjqrdZiqoiTUFSWwld9lrquP3xnQ5Ju241XMzNq/G67g/IQwTnaOtwG8DjFLQA+AMrdRUEeVnQMkJiFixzC0t63zk2mSRAMXBHI8KAtOFlmRHnWIFEzR6A3y9nGTFV1EtQFdkqwtci7LJ/5AvBLyT1WmlMOnFygxXkpumae4z7XMc1wuPJXluuOjG+WhT0OoYvfCXtfT/XRmYpwiRAkeeKYgWjI5ifkMzsYdEoaVEdPvDJbdgypjNcPgDd8qE2XAwOqiZrsH0LmZR12cA0B5/X7rEfPqK4zJf2vQN4kWy/sRaapyXRViF9a8/qEFUwVqlaPKxJl1jHCwkHr/IyDkyQHNXaRzO397LGoX2ujx5zfofJZY4Z/Pf4I8+Kvyc8pJ5W4ULNVA1UXfK2nx/VKrp8o8I65UY7k5K21LpDqC1wDacNT04yGFtQKgGDsJixRAkQHMQ9ApOsTDjYDjtYxgo3Brcht4IZxAMBB/1vOhxS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZ0oMm3wuocbNaTbuofCnkmwYMNISZBmPYMfzZ7T8li0jUSBSXagjPITQdA8?=
 =?us-ascii?Q?uuK+ZWSeODiL3KfZvDumtBqmPN2ot78m8T9Ktz8r9VTS3jcKCKHNKaKjMwdo?=
 =?us-ascii?Q?Sv4WBDs/D80Yg4zk0HkY/4X/h6xoW6QeRBirlcRmUkrh+UdD2tHxQpoKUETG?=
 =?us-ascii?Q?i4zYe7NXnPu36HNg3fcbgFYQyfbRaVE+/jxzTFiQTehkYThIMeRUeHeLJWAf?=
 =?us-ascii?Q?rLYVEH+RnT+LGvt0WVGe3s/vBjuarHWMHCJC57SfQ4wiJA/cB2lgMslGKlHb?=
 =?us-ascii?Q?HptgTq/eUDGh6y7pKO3rrrVeJgnuXt+iEHe8rrV13oSKPb8wY0LS3mMGglde?=
 =?us-ascii?Q?B03BBXMS1EMLr2dtHvUVyNNnwuIFoObv8KviCUwbLQZC2NPFvjyINB+1S52N?=
 =?us-ascii?Q?Mqtb/uJW83SSBFqMeuwNNxSKTUvwLJwyvTvmdePPM4jmTb9r6kQDyguCY1HL?=
 =?us-ascii?Q?2mzpt+DjB6bQbR4RPC19GJv264aF6Jf6y0fq0JvTORnFVPxZXW8ROSyylMAo?=
 =?us-ascii?Q?hRwlxoHSHT7MMv9+HKTd6A/+MyDAUsYq+WcCjO2TpGiDm5amSTjge6J32/AE?=
 =?us-ascii?Q?AE8MNfqB0NkMLgVSALc3J0FiveY5nnGjG3AFdg8mG7xeyZo7RPDOZ1iiN5fu?=
 =?us-ascii?Q?gcRMDD3FaMfkDc5sUH++OxoXtW0KP3zMstFJ6ZwH+OJiYCs6hHB1R1YA7vm5?=
 =?us-ascii?Q?FCLLQQtz44JHXMs9lub9by24DYVc0P+wDiwvPPrYuDoSPpAvhI26CfIknrgv?=
 =?us-ascii?Q?Lc8U8SeX+JgFpZSB5kn9upwGsAIm0+WM/SJd8SRkWV3swJu0md0vmxUa1Cmc?=
 =?us-ascii?Q?dVaChXSSXNDb/iMGdyjRZmtNb6SesujRBpkY+FfOGTVc2EeSp/4NE0t4A2dW?=
 =?us-ascii?Q?KXjqO8+fKB2kPC+80FZ6wGIg0J1vI/CkbVYTsg2dXe8bpYMynbcRn58iKNlF?=
 =?us-ascii?Q?mYWsdkyrrj1VvQ5oq0cnMMYZM5+ZpV3X0/2H0g2bS2QzcyKiBQj3TQr71a8E?=
 =?us-ascii?Q?WsymWxXmkKwTmMtWwEHkaIFqVZxYkrEcIP/3z8fwYxH1oM4KArRgDd+K5YwX?=
 =?us-ascii?Q?/nvPzyqNobj2RQpFY1bIqfkznI6ewsWjven1f7JHTjx7oRpzhoZEoqtUIVHO?=
 =?us-ascii?Q?QEE2Ptg5cleqa7i0ilQRm9GV5O3uEo84Oj6OmZV9bM7+NpSK7GjpvXsXsGV9?=
 =?us-ascii?Q?xjdQRAlZ4HAGj4xjisHMyRkk0QS2vT/mpd5ZtytuObdCHyoUlIOFBNE2xZBr?=
 =?us-ascii?Q?lkE2a6K0eu5C0VWjl4YnYFqxn+SjPJpTVs6IubogRahpplI5X+6wkrYiAD85?=
 =?us-ascii?Q?4UfNeBcE98qVLcbn4xKTJdQ/s0R38nWPrLiPx51Lana2Nhkgi+K+F6Q7A++R?=
 =?us-ascii?Q?sBBCa1yleytRWnaK9zVjubWBPAIt74SvBW4YXnvdTr8E9kc5Kb1w1DEk5xIg?=
 =?us-ascii?Q?icVXMi7pKb3nWNGWlcHJp+JcfzuBr3JwjBsSwZdezfbD7vQkWMGDLVhthlIW?=
 =?us-ascii?Q?BkrpzeKpvh5EU5gWu/8vjBMRolf7tEghV2dcsqND3ez8/Qm4k1ZMV4Wog6S8?=
 =?us-ascii?Q?FGpm1FXqKNTyk7WCqcvNtYzPOt0vO4BCpbJxuUAWJAKzCpVXoADI8EjVvSKY?=
 =?us-ascii?Q?X7kOIcBI9qs6g2cR3iohmIOozPKfAtUflHAOC5Ynu1D+q3HmmVSB/g/HCOGH?=
 =?us-ascii?Q?/Km93yAuNLlwuXDmO2YyOfAkvPPIOxdrij2YSA3pRPClLRVr5V4hxAcTJo1S?=
 =?us-ascii?Q?nVCUTePc6+tGFUBm29bn2L6AWZ8Y/+qTVrKKIJKQsiTTK6TZzf6M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50d7aa9-b953-4e4f-2e68-08df047fa0d6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 21:10:31.7208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/T4BnzHYrdg0JwNdF1nLOjj3cJuzIGAh5KNqcaH1H2ig7IiGEPevpGgDNP9FRplXvU1CvYLoH4gzjKXmKe4pgrqavWf9Ib/lfKljDwiYoLMLok7nXCf+DMTo5/y4x3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB398878
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Aug 27, 2026 at 03:33:06PM -0500, Rob Herring (Arm) wrote:
> Move the repeated command-stream buffer range validation into a
> helper in preparation for validating all weight and scale streams.
>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/accel/ethosu/ethosu_gem.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
> index eda9f42239be..9fce7caeeb9a 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -259,6 +259,22 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
>  	return addr;
>  }
>
> +static int buffer_size(struct ethosu_validated_cmdstream_info *info,
> +		       struct buffer *buf, s8 region)
> +{
> +	u64 end;
> +
> +	if (region < 0 || buf->base == U64_MAX || buf->length == U32_MAX)
> +		return -EINVAL;
> +
> +	if (check_add_overflow(buf->base, (u64)buf->length, &end))
> +		return -EINVAL;
> +
> +	info->region_size[region] = max(info->region_size[region], end);
> +
> +	return 0;
> +}
> +
>  static int calc_sizes(struct drm_device *ddev,
>  		      struct ethosu_validated_cmdstream_info *info,
>  		      u16 op, struct cmd_state *st,
> @@ -303,24 +319,16 @@ static int calc_sizes(struct drm_device *ddev,
>  		dev_dbg(ddev->dev, "op %d: W:%d:0x%llx-0x%llx\n",
>  			op, st->weight[0].region, st->weight[0].base,
>  			st->weight[0].base + st->weight[0].length - 1);
> -		if (st->weight[0].region < 0 || st->weight[0].base == U64_MAX ||
> -		    st->weight[0].length == U32_MAX)
> +		if (buffer_size(info, &st->weight[0], st->weight[0].region))
>  			return -EINVAL;
> -		info->region_size[st->weight[0].region] =
> -			max(info->region_size[st->weight[0].region],
> -			    st->weight[0].base + st->weight[0].length);
>  	}
>
>  	if (scale) {
>  		dev_dbg(ddev->dev, "op %d: S:%d:0x%llx-0x%llx\n",
>  			op, st->scale[0].region, st->scale[0].base,
>  			st->scale[0].base + st->scale[0].length - 1);
> -		if (st->scale[0].region < 0 || st->scale[0].base == U64_MAX ||
> -		    st->scale[0].length == U32_MAX)
> +		if (buffer_size(info, &st->scale[0], st->scale[0].region))
>  			return -EINVAL;
> -		info->region_size[st->scale[0].region] =
> -			max(info->region_size[st->scale[0].region],
> -			    st->scale[0].base + st->scale[0].length);
>  	}
>
>  	len = feat_matrix_length(edev, info, &st->ofm, st->ofm.width,
>
> --
> 2.53.0
>
