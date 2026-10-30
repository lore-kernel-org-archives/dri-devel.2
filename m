Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A46606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DUjnjmz0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988C010E7C7;
	Fri, 30 Oct 2026 08:01:58 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013051.outbound.protection.outlook.com
 [52.101.83.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8892A10E7C7
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACJ/x4vxMMFy25v/uiHPXRJToeDnHXKsANVbCTGLnnJpXEiIHjo+vGiTD7ghP2O5ZQLk1+gJ2blVgLcCOkQU/zYVTmGcMCXFQQ5zaar+35POSwwHUsBHCVpxfqrqDK2d0SvFn9To+nLd8tbVPJYhCuNzSmqfT1oz/Campc2rztI0SqnudQYCVfFRbweGbNt/0Z58j9f+t0ti1NoD+AkBt/rNy/fUaDc05pPIyaz84JBgGRg61drMR8XLXod7J0fu9Wrkzjp3D8xKsEoRExyExuIff9SYZNMhD+Ycq5hJQbVjXjXeMb8XS6/oi2u9vdAu/9Z6egYQeW2g/Fl2As1r4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mL1gV1aKjLMAEs1MfZzAPrCjaCuiUlJKTgSxzYh+ZKU=;
 b=j/5qipl7Tf0p+stYmn6wRxw7k9qMkFGvl73kBKBdQ9Koq8PRYAPU+pg/UsxTMmXxH9R92ZsY/DWU9zsPYPD0QBhLTR7rDbuIswZ9NcPNLmCnIgjDToXyZ5U5t1RgoNQwQHum8WyJeiSWGbxwH6OT/bpLsmKctOVkFqMxQuQCKAXnVmiJFYv/JwlEmTdwQwBK2W+Gu+g/OP18EnobbkPf+oj7chY4jFtdGZM+aA9jLaMv6GQn5Y1rNlGqNRlQ03F0LAqwWtzfxle4/3madCpwnUxLdBArUg47FLyVJojafqlhuVDljAbd0BMGlsGdDMgczgjjWIZ5dzp0EwNt9sGv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL1gV1aKjLMAEs1MfZzAPrCjaCuiUlJKTgSxzYh+ZKU=;
 b=DUjnjmz0p7WqCPPVMTozSdgpNKgLhbwRAZW7QN84pbqeypXUy+G+O4IgNMpKJe2NHT9zqT0U2NJGC/ShpPm59fB7G50uDwgFpib4VJIadzRgypgezqx+0E6jmrTzUEnuHorLkBEhPDNFbWLQCr845qjy+zVg4p0DnKmcykcfyCeRs8p15t623/1D7vPK4tGqRsuUjj2wAEhuEhHQUvXfF5b5KoL1es9C5dUZwzxjNUHDpUnIqLAmavOuJdJHlmWDT+pIrxUbnJ5QLdgK3UIkdEQAVzdT/KSgJk413VBsBHwqbOcDzn5KERSQTCpEB44foAapZWgXljBds5U7EnvHag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DB9PR04MB8445.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:01:47 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 08:01:47 +0000
Date: Fri, 30 Oct 2026 10:01:43 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Simona Vetter <simona@ffwll.ch>, Stefan Agner <stefan@agner.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mxsfb: Update MAINTAINERS entry
Message-ID: <auRN1oUwXKwH6AIv@vm>
References: <20261029180925.26792-1-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029180925.26792-1-marex@nabladev.com>
X-ClientProxiedBy: AS4P189CA0047.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::19) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DB9PR04MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e77c194-6447-49d2-197e-08df365c0b9e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|19092799006|366016|11063799006|56012099006|261009223027099003|261026140227099003|261022105027099003|10067099003|261028144727099003|261021121427099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Yu2iQyjF3XJ11OkKk+gpPvp4dYj2eNNq86kQH8kGAdhh71rFs5vDr+AUxKY/lbCDznn08K05DtcLriGrio/Vwel8hWlGZ3fw9QkuxZTXyzwtcCWgayYDXPyoVpjB4ochrzXlaIKrTBXGWpxuf7WoRyL/sUM0dEKa8Xr2dWRfsuXYZk6WbrwLcmQyL2DFdAkcoBVJj1jjXFYBJSslvMY3cCSDbVqrlXN2fbQ/ddbyQZMAytWUhxPoan9ngDyEz3Y6xdvT0jE9dK1QsZoOkhfxuH2RjXXGSsmHMh1DJRv2Sbnju1ZZwaXugcivz55B1n2HgtkUg7A7xWdyUzl9OFtp1e/2HWURfUYCs7uhtsve95yuJtrpmDjQPvAicv4u14FWZECKfWNGoxvJK9+yQZsuO6jGv4OO58S36Rv4labDZWUdDKrinrVxILRf7r4YbRx1tetpJ7nudOhvoa2T0VjcQoeEvu1GSoez7GcLUxGpchQK1phVJlPUooQQSoYyKQbTPEyZS/aBdcezsl4zuqYDpehyTJu8zhtI6KnpJjNIlH7qpRyx7a+qIx2gfSMryq6BYeR1H57pEjXsMvR8Ep2HoSzddGKx2A4yehgsM8d7Gy5jzpuAT40L4GZuHET+yafLa3zhJ0bgymYP4QO7HdGUcFzH+WIixUESIIDfZR0PqGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(19092799006)(366016)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261022105027099003)(10067099003)(261028144727099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vk3lPvpPw/ZmEKwlhdjYATUej/Tlxk9pU1FC4DVf/AlbBOYGIBXgrn7Lp+Vt?=
 =?us-ascii?Q?q7UIGsRzOP5i4VniPCjoyterufzxgQK0tn5HVNrSF38m1foTXIMsCqkS80TL?=
 =?us-ascii?Q?L1ZtXAekRImGFF+xwq3wRmuNcEPjCN5VPZwPgIHsxoVoHbP6g+NpUe94ZZGk?=
 =?us-ascii?Q?WzJJfy0YgFxjkQ8T7kUS1IeUGvQhdTOyqXLfapDsXrxYqpK/FUaSjtBo3COO?=
 =?us-ascii?Q?HK4bWAYo/zCuo0D24OsrGKfICSukkvajdF5ai9sRvLfXTQd7y3xKWUPIhRlW?=
 =?us-ascii?Q?n1CNbMQ5gym+uSUHHL7WulxPIbTwuLnd7EQUY161AyaRhqYZOsEYG6HBPw6a?=
 =?us-ascii?Q?4fBBzl7tttd3JCLyMdmqQBQkE5xpBg5vx8+qASE34XfT2nLjVxHxO8NUUbUz?=
 =?us-ascii?Q?qZOuJ2h4O2J5qfsijSSckTGZO9oHPRGyuc9AghreRn6wsK6YARXgVbIm2kdu?=
 =?us-ascii?Q?RUMejwkbcSID6JRDsqI02Ubgi0+THkmxyIdB1qVScfV5ncDqnY+mkWHLo78n?=
 =?us-ascii?Q?dso5kYZcYV0ueQd3uGOigpXjueQPCKRjiJ0UGPN0fes07TBfPFz5zr/5WdAL?=
 =?us-ascii?Q?bfxvgBJuWWGIOMBqWFbaciof+dvc7MXRDL7ah/da0z78iPebr7es9lSDg3BI?=
 =?us-ascii?Q?AdHZ0LjIPq0JfalepYloqsleYyidM0upTwLb38tPHT5PcSShJGb++X9EjIEh?=
 =?us-ascii?Q?sIqTWzNZ4N7mjpiIW89F6HeKdXxCoP23HBjVh8L07TYUUU1ABDZXtgsdfzjW?=
 =?us-ascii?Q?S2RFKZr4bg29WH1UzW6vL/Z8hUZ6BOjhRazYXrAeui+cDX2fPoItreC49ah0?=
 =?us-ascii?Q?KFI5Ng5haAriT7YY7JnLXwZ/QP0bP23Bx9WcK4swomyp0qqPwYWEstMrRKQQ?=
 =?us-ascii?Q?78jVDhgT9VKDN7myqH1Wivj2IDhzdyscMbhlL/myDcXNrU/OVMp1R13gemre?=
 =?us-ascii?Q?N1sRMCv8nvlKTBvEWUYsGBXiEkAgwGTZIYq4syaclauTFTOOuNionIXnZYaB?=
 =?us-ascii?Q?D7mXjVHj6hlsFMqRcVPvWcSQ0MUhWr2SsYwJKsy6/f8b0AOfMHMZqMQ46DSR?=
 =?us-ascii?Q?rxaTxsblWdWOXTFkV1UXObAnGmEg9AVmEh80Iz1p85VJWci8ukj1D23Lw0ZL?=
 =?us-ascii?Q?gYcidYhSJCZj5FwxzMRRk5PHfSSXHDWsBuLTl+Y1wmmlJj/chRnYqFJ+7OML?=
 =?us-ascii?Q?QT0dqkdb5wuBifVXeWgKKV9IBKyAB0anYv36LCWZt9kcuo6p7OnJSzZuAewq?=
 =?us-ascii?Q?Zp6g3+ecarq20cxkhrQ6eljFSEvb4pnYrYQn9JC343UGGQqdNvg0V1Oh9hi9?=
 =?us-ascii?Q?hzKo6Q5nxCEUfOl3l7ABQDwVQLHD5YN3pHwn9Od+RZDs6Gig0CxtJCdIHexs?=
 =?us-ascii?Q?Pwf3vR9XifvW1it8pGB+4zMIPwNxTNLM7bqoTcOpNhikqCR31IxSluYyFRcH?=
 =?us-ascii?Q?svN+RJkvhT7SZws8SfDur1PtoN433vDnPGvVcWMdNp0wzC/Q7rIuL/H3cpJj?=
 =?us-ascii?Q?+HKL6BMyFHB7sw/tYoZE0Q2kkY6PLYy3y/aJG8tenBOwafgtr3aG1gHROjCL?=
 =?us-ascii?Q?xQsYzu8YkpjpAUHj/3bF9uqSkIqsCYlZsBKg+nUVXwYp/XYs7v7dvkUVapxF?=
 =?us-ascii?Q?xZt5X6nzvCoSfCK0EqwpK13WCsIMpMSaSgNq2p81z0Dl7MPB5/gCPLZtxsR+?=
 =?us-ascii?Q?DAxU6jJRtK/HggKFxfS9Ug376Td7NLAe35XHrEvHrp1P3XNcgUF8QYRWVs1b?=
 =?us-ascii?Q?SudZgovCbQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e77c194-6447-49d2-197e-08df365c0b9e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:01:47.1993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkcSy9a/QCQPxJFZQGr2VU6qHTBgPX+SG517s+xiLEizxNMcoOkJ+HdxnRtICzFVgo4DI0TgpZWKLpg0nxx/sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8445
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On Thu, Oct 29, 2026 at 07:08:55PM +0100, Marek Vasut wrote:
> Fill in updated email address, no functional change.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: David Airlie <airlied@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 75ef3d1aa9d6e..fa4dee57bcf8e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19168,7 +19168,7 @@ T:	git git://linuxtv.org/mkrufky/tuners.git
>  F:	drivers/media/tuners/mxl5007t.*
>  
>  MXSFB DRM DRIVER
> -M:	Marek Vasut <marex@denx.de>
> +M:	Marek Vasut <marex@nabladev.com>
>  M:	Stefan Agner <stefan@agner.ch>
>  L:	dri-devel@lists.freedesktop.org

Could you please add imx@lists.linux.dev list as well, while at it?

-- 
Thanks,
Laurentiu
