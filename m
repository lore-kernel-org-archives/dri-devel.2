Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FA606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ps2R49sp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CBA10E7AA;
	Thu, 29 Oct 2026 09:28:31 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F9F410E7AA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEkQSTPBZdrltbypS1tz3wAma/+/UlRd/4DnYMrNn7hd9FmzjD3YCxBErOyrRRqHS6XZMGmXWWWudWaKINnYyYiy2umkgw8ax7xJf7ae966av6A/Tlw9oyI4XfYkoj8Hk9GZTSn6PHEWEr7aAF6bBo8C85Tz+3+oNiKwwrLTYBa+CSa2FEJLLfM+uMOQ+IbhwPLD1smVezeuuARFg9naZIsfmpamue2Ylj4jAsFfOTjzhtsQH3pxVcYiP7NlinqG3+ZvBCEHiKB06R58+ENECW+u4eGRx96ZT4j2wNHp5NzAyVFEJi2pxT4JHiPq0/4pxyVZM7OJ56Zt2nzkqjlxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pd7FY2topfMzo8SlrOWQvwJovRCW4CJ8tOpMpCQTmU=;
 b=ARAjBNeS8krVVOjXYBfBn13NgwHsodgp6o4Vr/Lt3XXboBproMZoiKmX1pgnx4G6HNZSxG9OFgWxk5e1R7A+zL+Q37fR2L80Dy0ElTefL5Od/QhG9NiWiGrUjVdYGt56KEeCJc1o2uvnZaeDwNklR280H6hrzJ9bdZF8vGVrFNkYuuDSWMGJyz2lO0WvRtVse/4I7OLBZNyDB4kDdL46an4kkv9jljXAtf2IJ0ksiqFZ9vNUF4bEx6nckpDnuh19Jyz1hlTkJsa6RnpjmXZF5tKTEXdEJvokUJMv8vgTSPE8RrhUjTeyY/r3c/yNNxpMIzG45ODsp3V459iGJNM+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pd7FY2topfMzo8SlrOWQvwJovRCW4CJ8tOpMpCQTmU=;
 b=ps2R49spaYfYU0irt4CEkBJ4r2WKKsOkC+ZJO0YSoy1NhgtcaxlTm0fBYqEn68VxnHg6wgScR8dxLTjuxfoTcGlXJhVmGRVZdIvSHRZeIpqi1ipjTI4q9Jhjavjs4qgtlNoFBxJ17FZNhMXiQ98C5CXKWOBC/26fAr81gFtopN3CeXZvVAwoMjKoqbl+OdTtpoM+8ph6/4pfdnDR9xbaPX5LneMopgVgKKjzkvAWhBM0o+Knmavc42rawqu47gm7V0GVLIyp+owvuYwGJNFRpwOROB/NIX/7+7KVGXmfB2al+22h/D12e1adNW8qIQ8GHasRh44uXcNRw1BH5UtyXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by BR0PR04MB935173.eurprd04.prod.outlook.com
 (2603:10a6:2c8:4d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 09:28:20 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 09:28:20 +0000
Date: Thu, 29 Oct 2026 11:28:14 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v7 03/15] drm/imx: dc-plane: Disable plane when it is
 invisible
Message-ID: <auG7pZSz_ypBSePn@vm>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
 <20261026-imx8-dc-prefetch-v7-3-a0b50cc4fc65@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-imx8-dc-prefetch-v7-3-a0b50cc4fc65@nxp.com>
X-ClientProxiedBy: AS9PR0301CA0050.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::19) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|BR0PR04MB935173:EE_
X-MS-Office365-Filtering-Correlation-Id: c94b4ead-66f7-4521-e789-08df359ef849
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|19092799006|366016|4143699003|11063799006|56012099006|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VC5NBnh2wFUzafQcpLf+a9bWcBug5ZBPluE+4m8yLf6mcH31brW0X3qE7c959KG2PxoR5KAm4++sETABh3f8h6KAS+DqD/xG3HpKSRL0JftkUFG3FdSVBLxuNO5wWaNuWvjcB5CS//iXitHQ/D0Y8i8b8llJcqhwt9utNIzHIFs90iAtK6KORO8CpR9qfr0vwBS3PREdLeOPV7HCvSWpmBzpQFD++SyaxYyZBMjY4qquYHhKzDeavukZ+Eq2BU5dId/fR1uy43EtkRGQex5BsXyaeTUvDJXmPWE/HMi4crlbPIf82/5P0JPDjWxDiZwGjSJNoZLUIc2SkKqsKp2U9NqYRr39TngqLlUWRhLAfv64afFxt0xPwYGUJC2Cmjf8mpEb/TYU36IRtgDM0VWYdQokGb5ZnS7ZUZzLRkMzEXVe76thvSDYhOi0KY1V8XNiJOVpqBRJeLP2s/B2aCtmPgXOVrwt4QoPdHfm8NFYFGBE5xUNPY/W1fD+bnFXpGDuLXICRMT8TDIbc/W4pz+eI1BASZC+2AMtx4OJ/h9ekVsJ+ixyipTqtvZ4cTXnPdrT2MliAETH8zGOcQyq0K/b7T5J+XlHrg++aVM5x8so9wg5DXCA2Ptkh7Z6d9HnMJoMhUowy81+6Cfi3yHsqMl84kTRWVdbeYbh6p2SdfCW+eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(19092799006)(366016)(4143699003)(11063799006)(56012099006)(261026121527099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uMyU9HRG40CcOC+uY2iU+k8y0TdzmbvjFFIPwHbBjfZC9FEHY8dbNj5dz9wG?=
 =?us-ascii?Q?SMQD8uuAdjQy9Kdi3yKuu0/5wA6CE2GAY5Oy/R3xTN5Lp0CiCMizokI+Lp+X?=
 =?us-ascii?Q?p89Sgjpe1XCHZypLEGq2/QL2x8X4SLVXUGPwUYYXbvCpMd2pnHgHyOY3pUcg?=
 =?us-ascii?Q?yWnnt1mgPS2wq+nJP06eFGVq22Rz1x9fZ0K/7o4AwjEe5dyUJNinbMUFUnOB?=
 =?us-ascii?Q?yFXRXtFUCtIyP9qnZa7pLhRrSqF3/x9pNCbk+R9p3x6IxdGXgd18Xuie1/W9?=
 =?us-ascii?Q?gzSBnbX0nACG/KyE2bgBwmSu2kK0av+GS/a68Ob7ci92yRbkkzCZo/RsbHBS?=
 =?us-ascii?Q?amm0/4m3M0wGacJ10xW9VxZLFgWwHv/gscd5Gd2hN2qZx0ydrBYjbKZ5Mtja?=
 =?us-ascii?Q?esr2bx3ge3hjrLNJKdPDifwRjadNGTDOUcMS2KZi8m/wrIx48t+wLNYsWYVn?=
 =?us-ascii?Q?4hXyvudKgkTdibwIcKIUCy5N7JyXIEuxRZLfN92wlbcMKBagZpa9rb2opzmW?=
 =?us-ascii?Q?wtw3ox5Y04NDvOHZG4GTGoBGtzJ+FZR/yhbKxZZ04ePybz+LLIi768q3TrUI?=
 =?us-ascii?Q?4u6EmcnYkm44zk2YX/7PzHkB5jOsfO3ps0yj8XKHVVrna/va//TOPWwUWPEF?=
 =?us-ascii?Q?wN6FaFlMgR+9Jz7kdM4eK4sFQqcGxEgVDlZX7dgNb/bHI5/rDBMDdkdi4gfe?=
 =?us-ascii?Q?m6UvodtlQxL4D2RJk5uoHn2877h1Fo0kphCl9bE2x4ddRG0ydbxHoVpiu62m?=
 =?us-ascii?Q?hQrllO30/vD3eYqMaGZCl16vpcOZYJbeNiuad01vbyQxFTRIydBnfELYeVze?=
 =?us-ascii?Q?i5r1GVR/Dcbxzi2MxNHenM8OIJMybpyhWiCFgu5NeiC+G74TQyn5Hac3YpvT?=
 =?us-ascii?Q?UhVgNJeY1ZqZOp3wOodCSx6rqaRveKhHrKP1E3po6PYyvgt9SlrwyGvcws78?=
 =?us-ascii?Q?yP3ZDrJF+yw4WeFZTuNpCwna/zWcU5mkS7MVCOmXavKMd/1CvYKNCp34b+4g?=
 =?us-ascii?Q?rvt9CC43LMiXb0BuuchRjtx/Jt0LxUAUdh5SvprJczVl81qPemFSC58KF36a?=
 =?us-ascii?Q?GnsDAzj6AkZYMwQ2ZFEeIEF5b/6p6FLBByTs5WTMakRqMv6maYVv0g93IMc3?=
 =?us-ascii?Q?yhR2xm3dLLI94QnSmmtglc8QlysVSJ+FiIWY9FD9vxyxF6SzFOKd5v8UR8IS?=
 =?us-ascii?Q?iwqkXa5LGhAG+TvLgF5uBJ5mrPLBiTdyr+2AHBPCFLgNYWlqyzmRPcyHYzzZ?=
 =?us-ascii?Q?yhzRomdeaMeNW2crDRMcxmkTedMsZ/1CTd3M4SJ96LQ1D1Zs9+b78qez9Hri?=
 =?us-ascii?Q?EIR/FYKTrOwWAXN9UJbf4WW7U9w+IxMi75gcXITNr4jeEsACA7V+28ap4fBy?=
 =?us-ascii?Q?+b4hhbTEUkcCCwnFT9N2944t4fe8NmenjIm5udpk9YnyDC3quXllwScSHPop?=
 =?us-ascii?Q?/47ldce1R2yO1e4sY/2nGeT73BOEqOTW9BxIT841gcVQgEyevxA2aUFF46o5?=
 =?us-ascii?Q?qIG8p99dQ4KORASG11Pdm21NUzHIIGaSrDdYGmNfCqk+pbibQ/9+97sGZso3?=
 =?us-ascii?Q?h5wfAcFPP3qgapAQtGQQ3DjUB4QRTVjZoAugYx2b3+8VO3+4rN/tB/iH/r0C?=
 =?us-ascii?Q?J9bbWeKLK9K0alAj7iQjCgH66LT80vP7wxdIEjcFjlwu9fSanpeJFgvPco1H?=
 =?us-ascii?Q?ALnLqr8gm3x7DD4ANhKmlS7Q9ggT4qCxI0rcFIR1rTU7vBe4MmX8Jj44RQvE?=
 =?us-ascii?Q?JtZvEZfPolFs3ekWvGCmvH6Rv6qza+o=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94b4ead-66f7-4521-e789-08df359ef849
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 09:28:19.9012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TE6TmzN4FBZxx1eN/NriMA+Ayal9WfO+lAF1FHTMd43iRGKWRlYtWHL7fSh2XhY8G2eW+tw8kCm4VWhABoO8HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB935173
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 06:05:08PM +0800, Liu Ying wrote:
> Fetch unit backing plane doesn't support invisible plane because
> SOURCEBUFFERDIMENSION and FRAMEDIMENSIONS registers only accept
> dimension for visible frame.  Disable plane when it is invisible
> to avoid wrongly programming the two registers with invisible
> frame.
> 
> Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
