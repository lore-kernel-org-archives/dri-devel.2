Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3EFC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF5610EFEE;
	Thu, 23 Jul 2026 07:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="GeT8cDUp";
	dkim-atps=neutral
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013022.outbound.protection.outlook.com [52.101.127.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA1C10ECB5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k06KKLwN6XoLiW4+/R1HIp6P05MoDT5E5v+uvT6JcnkfaL+iBSpFs8YVzON/oq2B5oJtc/kQ6fQVCIgrruJEZPzbI44C3csDNn2xpXygNQuwnozINPiBJ5nzfOx5rSDaX9vVA+faOS5CxTyrY8HCRqjIMo3kGOk5S2qCc4xRmknAlp7sNKK7zTS8gBmkmwkW955M3oGkHEAPlMacaLpId4rRHnLATp/Bhai2E0pIF6hX5BpaG+DPksvDt9RosefgO64V6J6KprUX+lE9m577gQRFr4o/LIafgUm8TXV9woto8JHlLVTQePw7yDWXmk2EsQFqWO9HrnxmnwWLq0o6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hosoqBK3vq2aP3yq2fvuN2u1zqCrRb/pvQQJfEfCMHs=;
 b=b3+bZFuLPl9fgARAUmGF03ZpuEUsjwoTFmz/0kcclalsU0prwm192ZKuWa29Z4LZSrrtJU8i1J3JfiPTHyU8qEGwbkWrYWC8sFBvdgAprVtgH4wwJSPhGYPSHRcdqjd/lGRs033anx4UcQ1g531qvx+pjjnSLwL4tDMwLkG/lIgFXdGLt/ujNN+HxnJw4f1BnqF7hGRANd6eN1dWaH3SSN8xxLy1lVH0O8fR5mQlX5EZIzLNRmpu++BV7YEHYdX0cbGu5CL4IKF8DjoBmcMwD81Ql2fegT8gH+bcluVHVUJFWYRUXncrKxu8b1qdbS8vlccZ1cdw60tOpvZbGxXDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hosoqBK3vq2aP3yq2fvuN2u1zqCrRb/pvQQJfEfCMHs=;
 b=GeT8cDUppGHClXKXsy3DKUiXdXSO7aE01+x5xPQWRJidtWZxrh7/oTsRLLt1tAFML5Wgqx2EtGkOKjpWaGx8GJk/bNNlYE8HnuONnbefCSc5zUC8vUmYrLWEfj/Nyc7cJs4bE9MJWS92aReGz2Zwbm7xdD+5U/pFJkxOINepW6V6djaPy03MY0XLD8nuDvXHeoKRnFuQeM6dyKCs0B8FwFF3VG1DCYr8BhN3rDR8eo/4TriErlrBnpdIRQOB7X+9vL896eMdWoGKF66oarzZu/L6PtutOzkLWiyQ02g9RPO7VFeGOFRSIsv8E4U1MW0NIrFVxnBdTtFcw7cbHazx4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KL1PR06MB6759.apcprd06.prod.outlook.com (2603:1096:820:101::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:58:43 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:58:43 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Helge Deller <deller@gmx.de>, Pan Chuang <panchuang@vivo.com>,
 linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
 dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 7/7] fbdev: sa1100fb: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 15:57:47 +0800
Message-Id: <20260722075803.570532-8-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722075803.570532-1-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0296.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::8) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KL1PR06MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b048e9-7b93-4ee7-64ef-08dee7c70cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|52116014|376014|38350700014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aRrq1s5X+nxLCdJBMocMOnmyaBrCUDdS7E2pzrRYUk+rEDBLpqBYPcIuxMVBN/a2CRfr4llMjTLJOxhlXHpMtigXF9iGePwA6Sk7fXUSscxctphuTyFqFHfj5kTcW2Pd+t8D/4xmdZhERpzB+qvjNQjV7SJwJkxukuE3S2UhtAzfcbeupdEouzmJqYc6a20TfOM4zwejwf25ibj/qktyMt7cj8jXKc4p4xg+Ie2gNIoz1O27qvryRbBaLilkJyIf9/z6p/LdBjtEbpFNZGbkHmDM79yL/NxXEJ8tlBGQ2NArHG1Cyep6pp9+4ZeGRUKU+XIsbPc2Fml6J7TN1+haxZBVprll9MbWlT/S3O7LouydEBtioSU0RdRpHfrjL3hYGeE2btOSxqenpuUwyIfcy/++hz+vdNvm+uKL8F9FJIzw+mdoIXwUsqHwmMLM5a++YhLQ5aNv69DQ9PRoy4mrEoGqqvPZ5WK5z8l+tyItRr3BS65p7ekKDVHCuuZJy2kNsmBux6CzBuKyZG9Nj84zlG2HfahOS2EyMBwRWzsdx+1DX83IyItWkX4jNBSRjO5AKdcBqJUtTDoNdMuKbusMkJo1ytljte9enVBosn72T1E9czTy+OblnPmC3UPVuZcJlv1p+rTrAbma3MB3fYytttaUHbpZrupCBJkzYgTwkdqdxiBW3DRs3sVVQHxN2VUzb2N8lYb1CbQPFE9e21bGWgxvF+lrAdPP6ZvjCbWGkrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(52116014)(376014)(38350700014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jrUyVapLwXCUExUDOEB4a36CduJk8TEpXTKLuIeHJ3hcbthrVJymiGA5cG7l?=
 =?us-ascii?Q?gO5LbF3eSOkBePDHAbeHURjbKblaPfNTnBIaeC24GLPuiKM6Y2EtHJnEqZLZ?=
 =?us-ascii?Q?wI8hCW0Z66RfTNpVQgww89qlQPlik38IP3mhMSf2Ej6/LhE/nGPVZVsfyGSL?=
 =?us-ascii?Q?oWxpAFms29dJh6RizoRVlZNcISqClu0sZnq2lCibI36tAqlb2mBjmk33rOd3?=
 =?us-ascii?Q?6cWLrruDanQaWXz8/dYwPV2Cg6Pey1EocrynZpJGAM7vXi0aYUBKvY1A/g5N?=
 =?us-ascii?Q?XhWOATtMscf6td6TuQpH5mbIB/mcZKRkXfTWtq2jGAYgUx/MbWA8mb2PZsEv?=
 =?us-ascii?Q?4TxTi2LxfvFnXqw99ti2xg9f2FphSQ3r1mqMlcXBbCHzCNS8rwMA2sASvgtF?=
 =?us-ascii?Q?Ybn9kmfl+QaNFgS7CcuOaTqN0REjV6Cl6RFAvkepB69qKRYqTb/S4HH0CoCF?=
 =?us-ascii?Q?Zmah1IoqKpvwJ0GE7/N9zk4nJtr2xN+i/Sz280rViywCRTzX35Glc/pawGkm?=
 =?us-ascii?Q?KXLo1FjseBXpRVt924zwYu6Po+bGMmdgWEnWFFSUACCYrdqU0qEKl+SItjP4?=
 =?us-ascii?Q?dLarjOqIh+0M5p3C4yiFPMRhqdxS+ZzJvQOf5DkQrp8LOT+MN2ya6eQt9bhx?=
 =?us-ascii?Q?r//q2IUVA/nCNV5bTDfMXkRO4cli166A1PYy0bxIwUf3z4raFhJsfhB2C8tT?=
 =?us-ascii?Q?P+OChODKu++VgXo0JLfNuA+uytjJ9NslZgbE3R3OtubJpc7o5VZJzhkS/nD7?=
 =?us-ascii?Q?ykivIPEi4mu0VKtjihSnfet6qF/q3BG9y303+Ueb3Prt3ZycIywWEzR4agCA?=
 =?us-ascii?Q?1QfZM5yA7y5S78kTnwn4MveIMjfLrMvx2g6GCe6F03wraHuVMhhWPUeVqzKa?=
 =?us-ascii?Q?+9Xh/jJZLSByVVhCdsgroR54EcPPbtowBXL7mvLIGERFkf0+W8oB18h0LFza?=
 =?us-ascii?Q?dCT9iaOWG7axpHlO6nSgCjJEe2GAE1YX5pTHyTxj4S9Q83GD4mfI7tvYfpAC?=
 =?us-ascii?Q?DP+/ZHo/2agCKBagGV1Dqb9d+wZXJZwxgzsPYgQV++iL9db+GfLZeZYUTGxW?=
 =?us-ascii?Q?0R7pOLQwvpXJh6m2ZQH9HVNpzasMLNgxaWls+8PHeuQiPeDT3yzq7+anPaqp?=
 =?us-ascii?Q?O2lLJXJXk+uZcT0rGinT3p7i94ckGk3lnlnBscpgluZPwZmMt0zSWZOpChLm?=
 =?us-ascii?Q?8OnFEcPy55NwmDouJWcHcVIL3aIKsottiruYfAyneJPkVYzreHw9DJNWo7LV?=
 =?us-ascii?Q?X3wWbADRr3IZ9bSnOlJcXONhOdXYzYE7EnAFNh5LY2w0WlFlaVYt3Ci4oo15?=
 =?us-ascii?Q?xcBnr1ppjIRw2pnyans1hpTNKLCI/6Qpo+hkNW7l4cziYXmOUf22Dc8ea49W?=
 =?us-ascii?Q?+iK/IWLMOz/03IodfPtuTMKDDGT055tt0npwR6T4rYV7lQvD4tGTVgRHHXu1?=
 =?us-ascii?Q?tqERmSr9xPyPyo/Be2/4iDBBccqeIX55i2bwMCHdaZTIa6yQULOc02V4tRHu?=
 =?us-ascii?Q?IZb1XulVbx/EzO09npgr/tM9VeunigtTHR9Yey77lA1WWtr0y95zGlXhgWCg?=
 =?us-ascii?Q?AJC7kjtqXL/xmv34F7tiqG+5oYDzwdcHfzIFKHLOXWUUt+J/ztfdRBX1zSGd?=
 =?us-ascii?Q?QaQtyL/iy03s6CjSH8NlS61cpvuPWkxa8sulu3roRWhv+i8DV6r62Ovj6gKC?=
 =?us-ascii?Q?1xwzJDBGX4lBpb4w9zTctN3yjgDHgcUG9oEVe+/lEn2J9On76HgqZ/v1XC0/?=
 =?us-ascii?Q?X6zIGBeYjQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b048e9-7b93-4ee7-64ef-08dee7c70cd1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:58:43.4482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU4UX8Qmv4uRnVDk/7nFdsiCMAX5naOIEAm3P3HLL7FpjDn8TylpziNzaUIU704zP4a4+fyLAGGK/ZWSw/TVZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6759
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/video/fbdev/sa1100fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 0d362d2bf0e3..fea0172c45b5 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1167,10 +1167,8 @@ static int sa1100fb_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, irq, sa1100fb_handle_irq, 0,
 			       "LCD", fbi);
-	if (ret) {
-		dev_err(&pdev->dev, "request_irq failed: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	fbi->shannon_lcden = gpiod_get_optional(&pdev->dev, "shannon-lcden",
 						GPIOD_OUT_LOW);
-- 
2.34.1

