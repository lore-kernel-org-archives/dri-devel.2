Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63B0C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE5810EFD4;
	Thu, 23 Jul 2026 07:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="og6Z7712";
	dkim-atps=neutral
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013031.outbound.protection.outlook.com [52.101.127.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1837B10ECB3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBQiXkkYMYcdZr4isJK99lBi2mvE4X0ZjDy6rBQltVe04VFcDuxKoxnU0/OgE9JwYJut+ifcxMrY2u1YKSDngHR5XjtctfwRH0tNy+Y5q9OIPS16cx6hIRLOENwTEXZf24JptlgLJXKY5GuYNNcz0R9P3kbcv2ftEjA/WlTYvr4GLUzgZeAol0fRaYBYjdKxMBNhErD/aGP/KiK0QM7ctprmwhNCNqxIbf5LtyZWEEGWwvNm4CKpvge26DxX3l2UotLskgfA/LUq29a/sC/60YRbIAYWjM9vh9VTUy3aE/f1Sini+KV/A+23pB7aylBC7cqAQPklzwef7R9jPO/tKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIsVzRHDdVCDQgps+vHK8MidZgf0lcjWh4kw0KKtMhM=;
 b=Pjya0puVCio5cYV5ANqY+NDreO0+U997J5P0kus2RCQ85eTNZbSxn0oDU9+Ej9F9qiqO8lArJBkMfWNIp2EFSWgQA88Ss2xB4cjuFRAezY5wKMUSi7mrjRVBkiPxGktjLic2aLddAJtSqEZylYi+JigeYpHIULikUQQ4J7YCh9b3TR+FnTbNgYjlOTWCZCu5ZjlBLINV7TRMhqEip2NmVHED55jfzyhVXnsjVY410TSGx6AUh87XgK4pinb4wzkN3ReYWVFTxj7IPiK0IQ37C0MngWPz2kEa+aA9uUmPfVgdRRVPI/HJKOS/CWrHv1hZktd9dO3cfsZRCVMclJksEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIsVzRHDdVCDQgps+vHK8MidZgf0lcjWh4kw0KKtMhM=;
 b=og6Z7712SePVMvhwgr/9YJK5Oje39DDg2FljQFwFykT/+LugUAOTX8yR4LJFQVaPKs3NapRmDN3ZHbyH3JTJCew25Fo0Ovjgigs0FoiPSJjja73UAqGtz9hCiTpYMBJFyTEExOC2hxdcTwU74REzNHgjT1W6wxO/vcQ7hKLZWMmZf9ziM8a9tJDKhwpLhuHwIIt+8y93NuZ4/Vjnx4XEnpT4oCRlTOAqGwGHRFiYYoMgmgoqKOh+c0P+88nDIbyEssopWt3c4exLSFrL7B0W2nsCkvhu/qrIjwZQZJ2tcbKKyvXGDa3TDXS5U+K4/DNYqatZ+uUC1Eso/6m+7rfPmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KL1PR06MB6759.apcprd06.prod.outlook.com (2603:1096:820:101::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:58:40 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:58:39 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org (open list:SAMSUNG FRAMEBUFFER DRIVER),
 dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 6/7] fbdev: s3c-fb: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 15:57:46 +0800
Message-Id: <20260722075803.570532-7-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd8f99a3-191b-4f55-bc3a-08dee7c70a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|52116014|376014|38350700014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NwUD9Emk9/9vznseLlCfiRaWUv5+z6bvKNSv51s+9imf9eyfPaucBx5lsZIG5Rc4Nn92UdGW1dYjSXEi8ZnZUD7RR2VZlgwc+FgAoW5FxnqYMKIAMk5ZV04fFDUYEgizG5JFhs0E/kGkTJuTS0QqmFWTTvoFVudHrYtNz7HlgBUc1X/9LgAjuCJVv43oJ7Ml2GTGCHqmSLEl9YvGJ0y36Bdo8VnShe9dEhB73MrH+iVGQFJwO9YJjzGsZdNYwtuaAOCmUV/dDeUenzi5p5y1MlTBZhD0dypMGNir9NRyulRGiW1WY3p8MnzjsRC+kK/SaT4PR+J17kgkNqvfosj0a2DDdBCTW4NJn69wfCqzQrkSMDeuAw4GdMi4AiZ050TlQ6RFj/ENrYeHWjEgM9tafNyGqy6fKv2gGPK6GechgUazpcriUbW9RKeDxprswMn56urgwq+n6FuM267Bszfo3uAsO33TkHggjqLoGPqiVWGPiScXoQFV6GpG3l+fJryG2MoQfBxtfElT+ILpk823KEiHo3oTTQ733KLVudEYK+f+ZHXYlwnM53tSUhGrnhUcZEYbR7OTkWRALXq75H6iAmYqjmI0FU9+Iv7CGC1RnkHaLc8UcHxHl/vQPzR+QY/UwUdVp5ANmwifspPN5C3Ywv/BEe7+4Zv/W1LiIK7IyyVSSbSvyol7rrjgkdAvV+R0YX6txw3qWTP6Yjz0XhAlf2pdgVHD2dYjU5MjfaZCMsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(52116014)(376014)(38350700014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uxrcJ0YxPu/BWp8cpAF5D+B0W+ppH/W/p1EAXpopJghgDihLnZUFbVG64LdB?=
 =?us-ascii?Q?Ds3+euAQPXVZARRKPzPNJMTnYQ19/mjsMxttnAe0gXvUZQFo/x0IIiaKkzPv?=
 =?us-ascii?Q?YKl8KDV12PE+j2g1oacrX4W4WAG4u9IvSixYG4YuJCxSgGhxoOeNY2tiwEol?=
 =?us-ascii?Q?BQG8ASe+/BQRCnyvNvpYmYDCrTZ5TtHQ8B8Lx+mDPIY1TOHs07c1Pfha2zJr?=
 =?us-ascii?Q?mEZu12xc1u3cVaZ78JLnOPiSsTv/0jvb/fwbHNy9YDiIKE9xRExTEDCU23T3?=
 =?us-ascii?Q?cvnjjt6zzqeJCafrhUwrf6631CTT8Kc0X8VxKG3M7eexvTdV/9SgO2mGdfme?=
 =?us-ascii?Q?zYbRTZDvMRN6NeWZL5Q6p5YWkY4J/ujLhHXBHDh4C2dblF74N8z2riiIOSXo?=
 =?us-ascii?Q?7RxzCTgT0hqt3N2yK0ZXdnrtSuF7KlJeyy1UsQqTwpuLjyp1mo7Jn8C0udme?=
 =?us-ascii?Q?hyc3bo4pRQLqr9Rlsf6b+tZqTq5ZcmUFg4U786i2NuPIrxFSr6GF2RaujU5o?=
 =?us-ascii?Q?owS+22l4PUSregREZwSTvGW8lSw1r/fR8X9Ul6xpDBwqRLqum0JHzjvPz521?=
 =?us-ascii?Q?Ih1e31TmjqXxWCVWy4zjiUzmFAvQh7Q7L9LwVG3X8cknAW0fD6b1ryKc+Mds?=
 =?us-ascii?Q?bYhOxfsfCSRD7LqyWn3PwM/gLnyPly2fCOvjuLStQyNw7n0lPovTzwlnkXWT?=
 =?us-ascii?Q?B3iSBl0wKxC0FIBdQND5wTPnQctih0SNkM6NgifaxO/wwIhq+TWBsy5GA7xP?=
 =?us-ascii?Q?jc7tkOgRMrMqJvI5RJRCIIqKyPCPCrk0+MRis2Pku1Xy23NsP9uDFAJHhzKS?=
 =?us-ascii?Q?jW74KknZBypDNBKbPsKvF2l94Dkz+gDbfGgUwQRvss/10VzDqWTl/hVryWDi?=
 =?us-ascii?Q?JsR0G6uxyPT0yODgdbA45h5c9KLQnnKjBvcVXsjp0KjaJ+pwFesqnoLh/nTv?=
 =?us-ascii?Q?t/3p16/EsS3q/Q1BodKA21VPBUknb221Ermb2jRsI4TzbYkNDkUEuyB7NKds?=
 =?us-ascii?Q?qu8/jMBC3Tw54RuK8k/7gWBUwPzhIBqZcLQ5OAvVIBoiIZhH4E7AEHDU9fD7?=
 =?us-ascii?Q?WHLUJbAhryolxxX3p6pkjFpMoYDR3vXE2jojiPtRCQzfZib6tvQnmQlAUX7P?=
 =?us-ascii?Q?tq+2vynEVqehcFQHdO88Vi2ndQU3QKleuLKBFKipUEfcEKXm6jSA2Ze2Tn/C?=
 =?us-ascii?Q?yE9qUiGBFRUGFS1HXbyCwo5BhhwSEfCBuSoQAdpIEnIn7hWF0QqatGJd/WZL?=
 =?us-ascii?Q?5YP+6AkrCUghYHuCdqZk+gguDyVc02j3QkMDU194wPrnNOM0lfQsbtj7btME?=
 =?us-ascii?Q?OCUMu7B608VbVsxssb/PoIueE0JrsaVTF3I6vwYoGfHOUXSJHdCq/g/JaW/n?=
 =?us-ascii?Q?04XPvEN7vyek8d3slGKVC/UhuVyBnWo1LgK7HI98Y9C9Kdm/ftpp3PpFAFMZ?=
 =?us-ascii?Q?0iJ2SLFKiW0JjrVZn3/Ts3BqD1Pbt6EgE6WnUfVqyT5f9ctdKxazzoLVOG9U?=
 =?us-ascii?Q?IhyclDBqlzZNAyqB58ZdNWL6pkSV0K2HmOqOgS1wypXiGPUuBw+P1mkqhUnX?=
 =?us-ascii?Q?U/jolhUFCH4jU3X/Qr8al31QoV5K+vwYmpmN6dIWTnY8erK6ZXuI8plY5V+Q?=
 =?us-ascii?Q?xcC3WKEnICa4i2qKl2OGOdZH6LXazLk95/FGMcu90Doyv23EerPRV+59jKXu?=
 =?us-ascii?Q?VrMVJErAe1EbJNSqzu51TPWTzDMxrWzFge+s4qWmVJjKD9Ep6C8l41r1PO1+?=
 =?us-ascii?Q?UD4UY8kJmw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8f99a3-191b-4f55-bc3a-08dee7c70a65
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:58:39.4075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IocaP+eq8UANJldwdaJfSyFy5HJr60/p2dSN+m5mqPx27O9ZpuPymD2CDowzfG4kwO6nr/r6akf6PKvOQaZpsQ==
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
 drivers/video/fbdev/s3c-fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 2f4d707e2e09..82a3bc9de433 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1421,10 +1421,8 @@ static int s3c_fb_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, sfb->irq_no, s3c_fb_irq,
 			  0, "s3c_fb", sfb);
-	if (ret) {
-		dev_err(dev, "irq request failed\n");
+	if (ret)
 		goto err_lcd_clk;
-	}
 
 	dev_dbg(dev, "got resources (regs %p), probing windows\n", sfb->regs);
 
-- 
2.34.1

