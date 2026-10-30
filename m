Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041E606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=F0yaP9uR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B224210E1DD;
	Fri, 30 Oct 2026 13:42:32 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013056.outbound.protection.outlook.com
 [52.101.83.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F5AC10E1DD
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcCo+NTnWgGFGndYPNaK3OUFJss1lu7d64A/ezurWiyld6SIxyaVnP1WwZLs8UPT6fiQVUF84U9nJ0ciuETKHEu/8WG0Kb4L//IMLCw9RbVWTRQqNR1kX9+LPi3oX1sl6A2K4PufZVPZaDNUbDR6t6bZgOjXVLN4hce9iq+i/okTQ7I6WmCyCqyYapgoNmX2UO/5xoi7s1pHRO+qkEWadNfytlUlGWHR6jdV9KlC06tMDdEWD8mEqXGatu9zyu40Dc04I9WIKRtr853moQM/QrX0xAJp+NEAIlE6sIJEGhV2EfZxtXamEVYOcKDVf2nfHfDXxxTzcEvZgrfej3fZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QajgQ3m8sW51c5RcS/pooZjG7k7Q7MFc2VdADBywgSI=;
 b=E+qbjOXdaiVQ3v/Ik8DGNMBQqFssyJLuXXnX2dmmbzKNxNMeWDrKIKz3WqFNpD4YqQe3+MCa1RMpzFzH8WzG7Wb0Tx4/iRWthbUO4I0NM1SeHI3Y5qwqAsgtitmI2lEOpuL21h6CM4Q2ecPFw0J1b3UASjbAAFgE70dAS9ulh8UGOwyNI/41kFqGo05ib/JRGsIjo51NEhToGeyWeWxn5oKwOIFmD4RbcDy4TmcqsZ+GSeOPD04Ba+aE2FforG1SXDsKO5FQWThnd6mE9MVRUlHgMEClOP1aO87v5CAEGaecgTbcsGj5Pxgal5QaZmpbaPILsnpcsPv+21L8EDB3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QajgQ3m8sW51c5RcS/pooZjG7k7Q7MFc2VdADBywgSI=;
 b=F0yaP9uRmfsPdTe3ZhXvSuRcVVLWh9SoPmzvb+czb6tnap8umPXde1MURAKt4V8bmnJ3emeVcHzyTOrFL0lW6f/0/w6OQTYkSIu2CD6w+XsNbbR8B6uP1lit4+NkTPaCUUSQzZi4lr6g6eMkOqSRXhn/ESlM/nmAWCkcOM3IvUPjv/eGOzIFsdIcvGqLjJMob9DVuOVnRAtRuTcrGCHufr3uf9jyHXArdWsNvqTobMEjUfinzKRSc0aBEuJqeYRrdehzHUej8aboW8R6XhtxFSWPSrm7LSqeiP6iwpgyuGNQ/iLU3v4G1Gqms8alKUPL63YA16QjuDkdop4JomNbew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AM7PR04MB6870.eurprd04.prod.outlook.com
 (2603:10a6:20b:107::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 13:42:19 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 13:42:18 +0000
Date: Fri, 30 Oct 2026 15:42:14 +0200
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
Subject: Re: [PATCH v2] drm/imx/dcss: Fix clock leak on blkctl init failure
Message-ID: <auSeCkGy5qPQDEcL@vm>
References: <20261030083342.1531-1-laixiangwu@cmss.chinamobile.com>
 <20261030111304.2205-1-laixiangwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030111304.2205-1-laixiangwu@cmss.chinamobile.com>
X-ClientProxiedBy: AS4P191CA0054.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::12) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AM7PR04MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: a33183cf-fb80-4b3d-0edc-08df368b9da3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|19092799006|1800799024|7416014|376014|261022105027099003|261022075727099003|56012099006|10067099003|18002099003|22082099003|4143699003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: EcD9CjkoEmVFXHIAEsblRfESkREEEgTz7XzT/XY84Apd/qrBvlJ9CgVaUZNiL7x76OjRfYPHUK+INNlL7RFpDuE6RNnHJ69n+tPTVCcGnQXV7qKUofBUtlooKcfjWj44DnaVbdPWeWfyAvwaibexy1E+lYLSm/DuUbkRxpewmWe4tW9Nvx+eKnaY5ugTvpnDdXY2BZbtFysU2y0FUC3Ej62kaluvic4IShuwTI7ttVYl+rbZ207SmdSn+SNIqNYHWf/xch2vZKoVipCF0bPUQ1Dm3V2wslTgaOrcrSjfZlgJE4t9c5J/WM9srkFBJGo4myUBqOd/8jyZhICLfmWnOnWCHisDbdqpVcetLg8FF9aqMFOtkIv2/MDiZf2BhFssEXZHP8uRmL4FG5KQ5knvIPpEoUkDyEtcHJOxkoVAffbjNjZZRuEo6QMbfp6HaG6Aw//OdGBsWEEDzmRI2xwEshca2+xV/KfFPwJ2vb40zjAg5W0OL60vWdh+DfT99L1D22WblNDjcW58lzOAG327PVbkU3dtTwebciF3bg+zlC+jwXXsz3QnDjU8VFzsFYjYAv3BYZoG7x1M4ONZnc5+T/A37pE1MKE929izPb+H/zMxM/DiijNea3AFq/BfjF8FzOWh+oIScRLyUA96AgratFBs+BIm/uJRW2gMmkQPu48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(7416014)(376014)(261022105027099003)(261022075727099003)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?28u0W85JNRGZdAsVfh1qBlpOkcZjHBD633nvurfsKPX1+tjqaFF2SlezGZLC?=
 =?us-ascii?Q?+qHxWSj5IpmJS5V0n6D0oyLxzFweCekt9xmkEYMatwkw4Tw/vQeu+OGsunPG?=
 =?us-ascii?Q?9PRvidpe0IUa63HAC784+iLZAjIrCqdulIDKJia7Ksw2riKEaztR+iuJFCCo?=
 =?us-ascii?Q?pRQvvIJwNJ64ypodI3b1p47gNq/reIyhvELFnCgY35Iu1eAb2QmjEHIuCp2+?=
 =?us-ascii?Q?lDrSYy9awbQxBrs0J1QqvmFyD/vgHUJfPZTm1t7cA3rTGsHt4ejHUBqSUFXE?=
 =?us-ascii?Q?hvnA256gWXXdRWCP/ClvVni+EOfprwVwcblHjxRDprDpS4Du4+NMgTrct8YU?=
 =?us-ascii?Q?CoEsIeSe2XAha4MyL/SE0ITinYqsXe9Q15s4hmj03YeynXSBL32pxVK5Xeu0?=
 =?us-ascii?Q?LTI5O+veNRmY0Ur/AdhyhJ5Jx3k1orNtmpgpn0GpSRC38ZKZiuWzrJ/XG+IR?=
 =?us-ascii?Q?iMbDsoZ0xmaJnUezwPUtkOaC4CrGcA03LTMdvuzLVabxUqVJ6NpKCAjCTlqj?=
 =?us-ascii?Q?DuGA+2/M77GCR0KQxnqcr25R7mgUqiykzO83XCQsJLHA99iYczCmnzYmRpQT?=
 =?us-ascii?Q?NyLMO4qS6qsIgyhGeoSxL0HD9EuY+N1/sohAxXh6dHvpnyP9GQCeCm/j4E+1?=
 =?us-ascii?Q?Hnb4KKkHiDwe2JKGmyntBTfUW73uPhVfeCRH9ybNWBnj+933a62fumeEImzl?=
 =?us-ascii?Q?rqDtlj+QsAwOdNRAXTf18yyqtfNyPkWHGDDT5krA4hh1o4aF9ROfkRMOVjeV?=
 =?us-ascii?Q?VZZ8FZe852z7K+0f9Cc/C+00ctt2CgHFYtUdHmEkTlHaZf9is4qTySyl5NW/?=
 =?us-ascii?Q?VfVwR+HGGIUXdhARHqC+UmC0p8ML+GDWB4UC7HEi9zvjVT6hm3E+x5wO2+Iy?=
 =?us-ascii?Q?yWqjFL4nNQKv8ZtWngHCQC6K0dnJbMJzQ7XYGLyt3swk5uYBFqvKoCBLTJHn?=
 =?us-ascii?Q?3Mhb9rqWRyGvFbaiHarjGkUSbfNoUqhds/ZgyaS5aL2Hq93ymxclIA0Ug9nw?=
 =?us-ascii?Q?juPZlz4KjYX5+vYQ7n51CDbMm1B7U1FayaxOLER/IluqUxmmGUFztG1Zgp+L?=
 =?us-ascii?Q?c9E5ssgP4O/k4YZbGnmq74yR/Jc0ROLShJXWSXE8nV5CtLJ8hfwG8i8JRr8A?=
 =?us-ascii?Q?ez+8rs77aQXFCzCVTebIgiKRo9RM8flhiJlHNJXpXMiszxy5Kk2HA+bm8+HX?=
 =?us-ascii?Q?ZgNC3pt1mrB4Z1XZl8lT4cyoosXIJsAFHDUFYFDSkH+jdjfI9OCWSj/9Wp91?=
 =?us-ascii?Q?wQZL8iLHuYVadz0tbvDzUca2XSVSlBVZcELeP9K12PmojZgIia09qKapLzo7?=
 =?us-ascii?Q?2YP81zHwi51+BOEeCNPJxuvfHJ6KfzIqTqpVyy+/F2DXNUNMGUQJ657oxV5T?=
 =?us-ascii?Q?vfHdCDS4+2Cy7XPkK9NPVi1fdU3HBccgAgAZLFi9yKLdh+PUGLgDEJlM9sEC?=
 =?us-ascii?Q?tG0wz+iG/KN40EonXqdS1bX+kAXrb8VPx/kOZOQcIHK6+m3C2RLFt8UUzIY5?=
 =?us-ascii?Q?m5iVia6y7bchD3U5OMjFLthtKCScvgi0QlxL7Fe5iOgOZqBlZUk/3S7jUgqV?=
 =?us-ascii?Q?414xOKbbmy+vuiyRAmRGK3d2vRs1KOiMz6vsscsgqOu7xPTHqYuqvFZIQAjo?=
 =?us-ascii?Q?1qOlHbUemJulqqbQT3qeGSLXQnWAHetOCl9tFovDG83p6t+oTu+QPaa1H5QP?=
 =?us-ascii?Q?8EESn5vEKBZnI+z10/HPh+NytuYH/UOHLILq5WhDn7+oaU7Si6mHCTY38orT?=
 =?us-ascii?Q?/9ZnNkNFOA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33183cf-fb80-4b3d-0edc-08df368b9da3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 13:42:18.4885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwyEQT9H7CMqmHcnLHCjzJ2VFYVpMqetXsa0UpHo7hXhuI/ggMaYxp0S2DTbKvv9yvKASmOwZIS3MS9gQNyGWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6870
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

On Fri, Oct 30, 2026 at 07:13:03PM +0800, laixiangwu wrote:
> dcss_submodules_init() enables the DCSS clocks before initializing the
> submodules, but if the first submodule (blkctl) fails to initialize the
> function returns directly, without disabling the clocks again. All the
> later error paths already jump to err_clocks, which calls
> dcss_clocks_disable().
> 
> Since the clocks are only devm-managed for their reference (devm_clk_get),
> a blkctl init failure leaves all five DCSS clocks prepared and enabled.
> 
> Jump to err_clocks so the clocks are disabled like on the other error
> paths.
> 
> Also rename the error labels of dcss_submodules_init() to the more
> common err_<x> style, which describes what is cleaned up from each
> label on, and update the gotos accordingly.
> 
> Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
> Suggested-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Thanks, but the fix is yours. I merely suggested some cosmetic changes. :)

> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
