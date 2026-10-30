Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E5606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=D1FrHBuD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C33110E231;
	Fri, 30 Oct 2026 09:26:37 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F38510E231
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqCfx3BmpiSjNom04IoA734vP04dWtIsahr2ZNVrDzmHjKXQmJGZk5LndcMQdgbGjMpzZhtP4WZJlHwqpToCVLAXvF06qkx23v06cKUSAlnRSX6E0DegC1FScP8BRJfS8pF+v4H1EGpAylpeHkj7O3vG4FWNW80FXGSuvWlgBATKdAspQjNzYsILZ6pHkVw9BV5zpHGlFFTTVCPKcONm6HkUWwVcsVQUzaDyigrEweXYEvey7BjnIqhf1Skbl4blfv4kFzrIpkbX1uhWlp2hFVMKSmCoyAAAPyHOs2EJGvIseX1AB+6ZrcYndyWz1tGtMJ0l/EWqtpSe7VRJDVm+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahy0xUmJw7Iw8hPoCL1y6gFlmd60i7ViCyX0v8RePWE=;
 b=IwEmdE1TQ6CCuT6gzIsoXamnnOKsoKtOS2nk4hEonaTORj1j4/vuLVpeUW7HnuA+3jRI30O6xT2yWLtkHP0MMZ528K7ufe5LKInZFtrkpk7L/5ZE7OSV/+U2RcUn8cEQ3rRBWNrrqDNLkc9/fqOxBxkHgyBST+heKvzdaVKpzYOsnlsQ2fS47V3/Cn2QzpNtseXHPXJkHLiBPchEtq1SgazTLrCfvJXA1baaNoNwcUlSZCuCvdoMZY21mAVhf+0D3EDupwd6nGqZqEWC2OousEWqq8Quuwe9rLpzw+cALUWHKmijxOCE2ER65Jj57UsGCQLo3zST/RzCK/Hhiz8uIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahy0xUmJw7Iw8hPoCL1y6gFlmd60i7ViCyX0v8RePWE=;
 b=D1FrHBuDgljUQgAEQVhifap1l8cXIo6Um6z18geQEzDNE1OQxx4CIj5B5Q3K9fr3n2i5jEVg6UrMPcFBgPY99brkVBiJ8iBzRwYm9r6vdp6WlTXa4qFTzGHwZ7CK6xzBT2j5FSpiZXlu4/HDIkZpWNLIkgrBn0+YS1pDBN49N64AMjBXTsCITExz79QzOO57HlKhZ8YJf9N8ZK2y4tL1gkG10mLX0f6aYIfAcMDKeyT/suyGgOZinRWdY5qPg0w2qDzNwsIS+tcseeSymWS7B7k8lrQdTlRCqWHPctoC1CnTaYk9oKa56FonwYMidwb1CRSyMxV9nTTaHhzzf7V6Uw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AS8PR04MB7701.eurprd04.prod.outlook.com
 (2603:10a6:20b:293::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:26:26 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 09:26:26 +0000
Date: Fri, 30 Oct 2026 11:26:22 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: laixiangwu <laixiangwu@cmss.chinamobile.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/imx/dcss: Fix clock leak on blkctl init failure
Message-ID: <auRgElrEh0YlUaKc@vm>
References: <20261030083342.1531-1-laixiangwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030083342.1531-1-laixiangwu@cmss.chinamobile.com>
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AS8PR04MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fdd46f-ae0f-444a-e9d9-08df3667df11
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10067099003|22082099003|18002099003|56012099006|11063799006|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: kqemCdIkRSuYdX5McsLZRmz/vsyDAYBiIpFtBdKeM5a7L1aCFeD/nn1vs6JN6v0WzZyooa/Q63luhOcLafTyRy6osfmJk677Kyyx8XhqeaGMwWQgFjqKOawUX2f+VmHvZQQ70HZtK7FRqLqIRiF9BS6qrjMVbl5SUJA/pKiXIkBIvbXFAlDFhgTEkSl1XInYRQvEvk8MECachvWolNoPMszllRacvomAo9Bg5iI4FcUv3ojf+rHKMOTBgQp+I9E7zaioPhfp+9fXmCZuXE8gdxE38R+a3BKZh81qA7hUNJF6zeKG9UbFW3YXHqgDSRpwjAGuEV/zLVVQ+Q/WPeVoYH1JadeIbAaj0jPt5lL3X949zQx+5nLbZKLSO2xOBPbWvnYSQAHkdJFqWZ++COLoR8DoDL5+j0Wd/CSQqz+Asvg/iUYWiINTPguydBPDaY6oiBvtXpXbj+xaRMmr3MsYBrdxEUfIzotyitw0NH7LA6/Ti/J4tIS8s3/i9ueKeOPN3yrkLhyytp/HriiJHnohXyMSzT731fcF6PKcILqFK8kwVMKxGGoMDnCfhN+DCrzncjjjoftUCFS1rsAYRE8Q/ZOynqIx+GwseqTbVnUk4q3rK7VcoEj4d1WBFHcYE5JTWfE6JTS5AoCWde6he+LGPjPl88qjQErr//oqkbDrS20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F1Fh9nFmidJmNz0ySM4557Z2v9lNfiU82T/Ct+lxY8clbLKOJMVrK3JHPbXC?=
 =?us-ascii?Q?zuvfa/WOe9lhFwt/a/EIXH4lVcwgHFeAdgZiwPdzUyzvSXk8DVAaHUHavIs+?=
 =?us-ascii?Q?NzUKXoNSO9ogRQUONYzEGnUSyuEw6BNJKgth42a/UF52M8WtsFcK5qNCJuxu?=
 =?us-ascii?Q?FhZeVIc4aaxt7GiOnY2hT3tGbSiCHPgv2yfNU7ayU1GUngMcN/OpdmQ7pKNp?=
 =?us-ascii?Q?Ri9WWLwWFB7xhZQo4r1708wpYSR3OsqksVPDKRNHx3iNCIIzLJoBDJFtOUFZ?=
 =?us-ascii?Q?Cm0LjJ0h6Hpa4bvBr6V5hCXPc8oDf38ZGHffFztZVN3H6wxf3BRiXwdNau+Q?=
 =?us-ascii?Q?uVgR7O1wba3CeoozRYqUKe66OZhyqLTycA8h/6a7ZTH1m51jdXuauQ4Dp6Gx?=
 =?us-ascii?Q?YMggaA8OKq5ngdTvj9WiPGfb7gt/SUhWd3ndQgLQMoLvnkOTEieaZfntCWm+?=
 =?us-ascii?Q?WuDJZNTaLskWGj+g8PwE94H488KSl1EZBLV6Tp3h5fJ7nJWIXNXHhBmcXTp8?=
 =?us-ascii?Q?uFudc6Z6uEcpk65IH4PyafRxaj3MWveMJsdnppITfZ58eDg4M5jz98cRbIAi?=
 =?us-ascii?Q?BsBUqqY9ESJZcWRkIgqDFF17Wm1xtntcyvvgGYdrA4O1B1VNGGdzcrMzj5za?=
 =?us-ascii?Q?E3ktqI8eV4ymnKAdIAsLSz0TD2AFDQ4E+4zWig15mZ99gyB2Tt0Knh+sSF83?=
 =?us-ascii?Q?zNVyU0Afc9jrCHCgOhI0skLrvusN568nyJKgWCKrw25xI7tZpH4tG1FbVaUv?=
 =?us-ascii?Q?i1yWtQU9fdZfPlfqUErGgtfVi2Hiiv9OyN2G/gO8jZvqfQX4bYCEk3ZY7GPu?=
 =?us-ascii?Q?GgO44ifeAFtfMbV/al+0QBygsKJUa6rpLo05/33lhqUOUufCHF7OqZaE1duM?=
 =?us-ascii?Q?1ljiBSn6kqiJBDXtJQJ5Bk46ZlYqhmMel9HvCQzUzP1U8H7n6siNup9dur9r?=
 =?us-ascii?Q?oK8G1Cn64ozcPkcZ8Kl2S0WpDn3QAuSr1lW17WdvEppdsY/ZgP5W7Skc+iv/?=
 =?us-ascii?Q?Vzs4J1jakmB37ro7BfE8r8r0BIWtZauWYbyV0i4Hgy8PMHiUvubNHf8h67av?=
 =?us-ascii?Q?sFSWIrVAt8lfaZ5O+JLwb9e4weE2ThxhFp3DRi1QbwfSUqmOnSM2/qaUe3P0?=
 =?us-ascii?Q?r4wPf2WyWK71C3RTPRjF18eVkrH8A2s+rIZLk0lRqy1vV7ahy3xo2b88Hvt2?=
 =?us-ascii?Q?paclpLcPs8wi94zgyTdDyYEneVyIfdmaL1Z4sEkM7YzOlvrYt4cxnedGQS/t?=
 =?us-ascii?Q?zq3nwS8vPwgFhzixr82oQ2AM6W/j1rF8f5UDOqorV7uBCTbaNqshPyHsFTu2?=
 =?us-ascii?Q?uaamQoxc64aZl/+vb6OZ0ETy2D2kVM8tMYk+XLOsEhWn29HwcwY+u6nfYoGK?=
 =?us-ascii?Q?geqInicWItDNf219zQIYyAtm9FWz0v5dJsnTGvmjL6/j1MNUUr+BbWT4kGO3?=
 =?us-ascii?Q?uMGACsFuZzAW5PUrz2X0TlLpN205Z9eA3Pfu418waScDuixRpJP09OgeKJ37?=
 =?us-ascii?Q?pvrEMuxU4+3rS2BixcSGrAevnFOhFjfyd2JNhKwA6B2Q+sTnCmnAeTOXdmQZ?=
 =?us-ascii?Q?9Xo4X9UdHUufTKzEmPSZYstYzeuk9BmYyQIbLSdwMSWOFCqaKSXBbxCaZolD?=
 =?us-ascii?Q?z5VIs4Q8r5Rf9G112T3f7mM0d5f7dexCh34cUQvrdkYFc0eBZReEpogmVYUK?=
 =?us-ascii?Q?yhwVuwQhDritnMBsm5vXy0O7v25YZIyrYcMaN0jBQFojJA4D0x/tEG3n+5dV?=
 =?us-ascii?Q?fZSSOM4dJw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fdd46f-ae0f-444a-e9d9-08df3667df11
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:26:26.5039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHYHlR15ksNwxrCdR31gD1S7qaHYn/5yTlXK4rVRXjX7nhVBDWDvFpNO6NDcgMS6DnTolGfbTsbBU44ST2yUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7701
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Thank you for the fix.

On Fri, Oct 30, 2026 at 04:33:42PM +0800, laixiangwu wrote:
> dcss_submodules_init() enables the DCSS clocks before initializing the
> submodules, but if the first submodule (blkctl) fails to initialize the
> function returns directly, without disabling the clocks again. All the
> later error paths already jump to ctxld_err, which calls
> dcss_clocks_disable().
> 
> Since the clocks are only devm-managed for their reference (devm_clk_get),
> a blkctl init failure leaves all five DCSS clocks prepared and enabled.
> 
> Jump to ctxld_err so the clocks are disabled like on the other error
> paths.
> 
> Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
> ---
>  drivers/gpu/drm/imx/dcss/dcss-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> index 7fd0c4c14..551786060 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> @@ -70,7 +70,7 @@ static int dcss_submodules_init(struct dcss_dev *dcss)
> 
>         ret = dcss_blkctl_init(dcss, base_addr + devtype->blkctl_ofs);
>         if (ret)
> -               return ret;
> +               goto ctxld_err;

With this change, now the label names I chose when I first developed this
driver don't feel right. Could you please send a v2 and rename those labels
below as well?

I'm thinking:
ctxld_err -> err_clocks
dtg_err -> err_ctxld
ss_err -> err_dtg
dpr_err -> err_ss
scaler_err -> err_dpr

Update those 'goto' lines accordingly.

-- 
Thanks,
Laurentiu
