Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC86C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E2610E4EC;
	Fri, 28 Aug 2026 12:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="So1RIDry";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010004.outbound.protection.outlook.com [52.101.228.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A83710E4EC
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 12:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCgo4ipKvr6sV3Q757laKkYG3X4jrjUWi+AfjVB2uw81bsSjjz9g7311SkFsQphk0hlrgK6DT9YORR6xgHU1FF9ILbuW8vXDQ7Pt02+ycsxHHig9unE8t98DR6Vb2MXk7mTf6zEOaNotwND05uos5UISNZharTi2k15BJa5udgXay3nn7I4UtC6CF21YVUYOoVlHzOftFWh9nqjx3qeY/Rttfh7B4+bC3wx7ZzHXzePFBVBOk03Qcfc/cpofqHIZk2kEeP4FC5+ovrpmGA3XCRqbGd9cGZHUiNHeKOERbhLlka1Z/4PpJ98DZ391X0ZeskPE31LsKYdqWQ4JieilZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlc+xy9WuNHiSk6wPXLm7F2zA49OqJvhxlRy6rfLQME=;
 b=cs4+FkjneQcPMgZgJ6ecb1wngXCEjuLp1nQ26zwU65SUToUybAVqP/xMCqsa06J0+7UWl5dUuVkZbvK+x4LS4vP/HRKiXChpqQGxpQ/8smngMIrK/YKSebFKlCWiFikeO+6oXSsBgTKDmgk8vcoNkhDhbEwxJNqNogRNmiVSXjck/mWJpAYtJDA1Wf50rsc2Ncn1odoRtXtVUumK3eC/QEYoUu+zq/Qbmbeoy45eDBQpPYEJXZeI3tJxj6xNC6XqtjXnHmI8F6Hj8Osr5YJfCKFG30fmhhx11dCFUGVGdjzb7dgNTcsFA0RYMLc/AKkz7xBdrbthU8d41E8t4rZmqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlc+xy9WuNHiSk6wPXLm7F2zA49OqJvhxlRy6rfLQME=;
 b=So1RIDry6Tt0Zz5MJha5wWOdKrXi3iLy63N/yoYzTdy7kJM/xZ+cMnM3Q3qHweJj+DJVwhKx6/oSj4eee7rQ0rzwQDKe0h/BGIa+omMc4AjT73rUw98B44UXKww1RK0mN2yVt0nTELpU/+YFzVuuuSRC1cT8kk2PzdJ1odq10Lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY6PR01MB17444.jpnprd01.prod.outlook.com (2603:1096:405:360::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:22:05 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 12:22:05 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/9] drm: renesas: rz-du: Move mmio from rzg2l_du_device to
 rzg2l_du_crtc
Date: Fri, 28 Aug 2026 14:21:05 +0200
Message-ID: <20260828122113.1426778-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY6PR01MB17444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac9f72c-bb7f-480e-5cb7-08df04fef8b5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: LeVBC4oCMEl17pEfisjXzipr7AWQV5G+u44LWdcT+dtRcdftLbzzOpBzw+XnXZCrwOf9QryRnGPLsANQ2g96AivMua7ZoXTfrm2OXYTs5xQICQiXwvl2S2e88+eQD8EwM5d22hTJp+Vc5xwZBLAypq8N0CrPAcLfS+2sC1Mp0zd4hBvt0GPwJqTH1W+NAuouIa7BX8qY0TlgoiHTPz/t9NjEdGMK+XvEJv9D3rc4qSui8azlgI/WcFsosgC0mUVQPY3W901m81s76BMVRdebAaPoIwzUrrGPfJvO2KQfsMx8weg295e9CuLXW4sk1MYY5dsZy7ckWIv4KVbRoAHBRgoYFzwEqaZIAmoHUgNOuUcL6GkclSq5Cs9nPUzJNHCHCL9KAn9M/tPdntZMULsiJXapk93+zA3PiJC8npenfyCOxZpskSfvwIoUPmEmSozfenX51UCsxR97FtUhObI08sbykLF5YJjVhUvKa6sf5Ous07wYj2ffCiN4QBlQI2uNfAbV0MgmvOSFfToUrX23GXw4dhbIuQM7+EM5sOQQUiLjuOLIKfLMQxqZ62sNA7Uk3kO7WOFQC4C/dCnL6cUAF2Og5qBu5YQk32qad3RrLq50d8umvg1RdJJILsN3xnjmZROfYvqHYwDGGNbYZVpbiNce6fHrUk+BNLVRxXmQ5STCXq82dAfyMbPjDc14Dm1KFWp+SCdcEzC2udoshgKpX3nIoIL5SrtCDgmA6bqW0Nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MP9kYrBwjnjDs3C/Q2WHponbcqhD+gH3cLnkSrCVdxfi5Q5Iv4EFOsUTaEyi?=
 =?us-ascii?Q?uc7f9/DZC7S0YzkZd28L2Q+mLVhm51+8GdHrBhJUCaRtm/dr8FfekAT6uNTs?=
 =?us-ascii?Q?Pop8KYALLo9MmPBFRaHCwLaup0ifA4Cm1mOTvCIbcTgUJltl3WDLciYVRe3X?=
 =?us-ascii?Q?hUu6C9iTwVd1/WxMV3RNEOfs+vMMw3vkygbhfBUBSed/sdwTRkBnz6sJ484e?=
 =?us-ascii?Q?W+tC+Zp9mEA8nvTnWowOewaZGyY9XOQAICIDRk+XTktoaIyVl3ZFaJ7ONNO6?=
 =?us-ascii?Q?lp56LNTu9CCMTyDAVF4gug83ZTe4vegoLFoR/LPuz53hna83YYWdKmb7cI+V?=
 =?us-ascii?Q?3GsUyrT13/NHCl/az/2Poj1CZSmriQq+wOLiRvuY4QX/lJBrqXViGh+nyg3J?=
 =?us-ascii?Q?2sSVbmQNt2/khPrqotZxCJgOS49mzrVxW6B+rVYtfxg12UTAqtGtFywBskEC?=
 =?us-ascii?Q?qxn/yqoVvAsKgXucnT6dHHRGsVRwwgJf3/6ZTwAORZRrBBDHj8rD6D93pQ9k?=
 =?us-ascii?Q?W5K+nFl9EPbvh14r4hvJ8A7DN4QtcjsecV1HU94Zz+B2yz+U4QM7oFkTuZc4?=
 =?us-ascii?Q?KaYo7bICgiZE0M0pB//O0RxjeFBRHSRlo+2JkgbR6+rNd3tXKCfC70YEiP3z?=
 =?us-ascii?Q?2OcGVvbLNALPAh+NN20EMoyqt/+Wp88FYLBxiM4j/5ttSWvlpoTHq8sWMlEb?=
 =?us-ascii?Q?/SLmSCt/qjXdnJyEZNcuEETm1G8ooayGtci8k3HCo7NABnZ0Sjpu0xX9aEbU?=
 =?us-ascii?Q?3kHOik3eYcnunUIeNfkLs+Eo2Z2chVH8BbyNhNcXbK++p8P0epJ1q7T4V2jA?=
 =?us-ascii?Q?o0sdW1DhkguHR0/Sqhea+er8PEEvjadwIHKy2GJtuTd7MdAlHn790PA5uSzN?=
 =?us-ascii?Q?aavUblLHn1okGJnA3K8+0stJjanXCc1cldN7kdI8gw8JkkejOaPEMtHFuoFY?=
 =?us-ascii?Q?4YU4CJH+GXnJADsyndhdKJau4LSDIposr9QPQDeI1dVzKS58Wj9Fats1jI0m?=
 =?us-ascii?Q?w8TPQNONiVTCq0MVjgq4x3t+cx/YVvEmEHygZ+r2ZjVsO9OXlffCZvYobe8T?=
 =?us-ascii?Q?sbIX0id1fO80rL3RSfx99YjMJ/TC8XhNKx8oAbjq1PBuMz0SdZgOq5Rq9IzM?=
 =?us-ascii?Q?yNPi42xkfUoivFqgFjARuBv+QkvmgA2QsIKFgkDVrXrTLs7dGoh1K8snQY6D?=
 =?us-ascii?Q?HQLanoUussKv09av7pwuLr/VFtNBX4yCX7uC4eGK/aERfHsAzrpyswET6GN+?=
 =?us-ascii?Q?GiGSt7O+7Fe8lTeiR4ESV8vbH0QdpQJTpnjOBBS13Gpc0h4nDGSx+tNqpqL8?=
 =?us-ascii?Q?lNWtTFVmMVOHeE9EPoSMovG7mJdlTi0aunrYZHa8PNeAOAIv/wLB7aW7Ph21?=
 =?us-ascii?Q?7ECLrtciKFvWzyFMgp9GX2F1jyHdRms9cTC8FhIR27JPeVvbvUGuoGuRrWY7?=
 =?us-ascii?Q?3i37hcbtvyGTER4IycACDZiQm4dgjj2zAkcVcuZqgLvAkAXo7SiIY5gW02kP?=
 =?us-ascii?Q?aKMiNK8h5+sQATZJwP3mxbOVgpB2Nbhmyx39R4g6zmEwF4ZuQGyPFFJ/YvfD?=
 =?us-ascii?Q?qyrnqBrktv3AO+TimxfvPLiuQ5aPDXQ4a6p/s7DBeAbkdNc28vW4HRuvO7wL?=
 =?us-ascii?Q?pKjb82nNYnK/bbftBOERSj86GQ0z+owhGCCX0aACi90UvwTuI7lMNQ0BvECY?=
 =?us-ascii?Q?5LKG7fETunlXSxjkftccPBMwvN9tU9TC77+IT6d5goySQCCj5byE7zGl/Hv2?=
 =?us-ascii?Q?FGi7HCFh97hqbFHz58/Jb2Ru3QlavXjC1NwjqO6Svzt8sVoy+f0N?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac9f72c-bb7f-480e-5cb7-08df04fef8b5
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:22:05.4578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+7te5fCLRwRVC1dyV+C+aAQAt8sxxzKqyxMOzfUhQQa+1nvsbFqZIZyc2ddX7fODj8t1KdjACJm7fqArdkxN09B31yrQTJe14g97r6Dr9Nt0HeT+FWbRGKADPVqGig/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17444
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

The DU registers are per display channel. On SoCs that integrate several
channels each of them has its own register window, so the base address
belongs to the CRTC rather than to the device.

Move the mmio pointer to struct rzg2l_du_crtc and map the registers from
rzg2l_du_crtc_create(). No functional change.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v7->v8:
 - No changes.

v6->v7:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 25 ++++++++++++-------
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h |  2 ++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  5 ----
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  2 --
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index d0f01aa642a7..3e82a0a2014a 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -67,7 +67,6 @@ static void rzg2l_du_crtc_set_display_timing(struct rzg2l_du_crtc *rcrtc)
 	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
 	unsigned long mode_clock = mode->clock * 1000;
 	u32 ditr0, ditr1, ditr2, ditr3, ditr4, pbcr0;
-	struct rzg2l_du_device *rcdu = rcrtc->dev;
 
 	clk_prepare_enable(rcrtc->rzg2l_clocks.dclk);
 	clk_set_rate(rcrtc->rzg2l_clocks.dclk, mode_clock);
@@ -90,15 +89,15 @@ static void rzg2l_du_crtc_set_display_timing(struct rzg2l_du_crtc *rcrtc)
 
 	pbcr0 = DU_PBCR0_PB_DEP(0x1f);
 
-	writel(ditr0, rcdu->mmio + DU_DITR0);
-	writel(ditr1, rcdu->mmio + DU_DITR1);
-	writel(ditr2, rcdu->mmio + DU_DITR2);
-	writel(ditr3, rcdu->mmio + DU_DITR3);
-	writel(ditr4, rcdu->mmio + DU_DITR4);
-	writel(pbcr0, rcdu->mmio + DU_PBCR0);
+	writel(ditr0, rcrtc->mmio + DU_DITR0);
+	writel(ditr1, rcrtc->mmio + DU_DITR1);
+	writel(ditr2, rcrtc->mmio + DU_DITR2);
+	writel(ditr3, rcrtc->mmio + DU_DITR3);
+	writel(ditr4, rcrtc->mmio + DU_DITR4);
+	writel(pbcr0, rcrtc->mmio + DU_PBCR0);
 
 	/* Enable auto clear */
-	writel(DU_MCR1_PB_AUTOCLR, rcdu->mmio + DU_MCR1);
+	writel(DU_MCR1_PB_AUTOCLR, rcrtc->mmio + DU_MCR1);
 }
 
 /* -----------------------------------------------------------------------------
@@ -223,7 +222,7 @@ static void rzg2l_du_start_stop(struct rzg2l_du_crtc *rcrtc, bool start)
 	if (start && rzg2l_du_has(rcdu, RZG2L_DU_FEATURE_DPIO_OE))
 		val |= DU_MCR0_DPI_EN;
 
-	writel(start ? val : 0, rcdu->mmio + DU_MCR0);
+	writel(start ? val : 0, rcrtc->mmio + DU_MCR0);
 }
 
 static void rzg2l_du_crtc_start(struct rzg2l_du_crtc *rcrtc)
@@ -380,11 +379,19 @@ static const struct drm_crtc_funcs crtc_funcs_rz = {
 
 int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
 {
+	struct platform_device *pdev = to_platform_device(rcdu->dev);
 	struct rzg2l_du_crtc *rcrtc = &rcdu->crtcs[0];
 	struct drm_crtc *crtc = &rcrtc->crtc;
 	struct drm_plane *primary;
 	int ret;
 
+	/* I/O resources */
+	rcrtc->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rcrtc->mmio)) {
+		dev_err(rcdu->dev, "failed to map MMIO for DU\n");
+		return PTR_ERR(rcrtc->mmio);
+	}
+
 	rcrtc->rstc = devm_reset_control_get_optional_shared(rcdu->dev, NULL);
 	if (IS_ERR(rcrtc->rstc)) {
 		dev_err(rcdu->dev, "can't get cpg reset\n");
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h
index cbba38acc377..77ec92c4825d 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h
@@ -29,6 +29,7 @@ struct rzg2l_du_format_info;
  * struct rzg2l_du_crtc - the CRTC, representing a DU superposition processor
  * @crtc: base DRM CRTC
  * @dev: the DU device
+ * @mmio: base address of the DU registers of this CRTC
  * @initialized: whether the CRTC has been initialized and clocks enabled
  * @vblank_enable: whether vblank events are enabled on this CRTC
  * @event: event to post when the pending page flip completes
@@ -42,6 +43,7 @@ struct rzg2l_du_crtc {
 	struct drm_crtc crtc;
 
 	struct rzg2l_du_device *dev;
+	void __iomem *mmio;
 	bool initialized;
 
 	bool vblank_enable;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 6c2dc86abc7d..3b868d4ef8bc 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -181,11 +181,6 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rcdu);
 
-	/* I/O resources */
-	rcdu->mmio = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(rcdu->mmio))
-		return PTR_ERR(rcdu->mmio);
-
 	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index e9626ef37cde..3a649fd438e0 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -67,8 +67,6 @@ struct rzg2l_du_device {
 	struct device *dev;
 	const struct rzg2l_du_device_info *info;
 
-	void __iomem *mmio;
-
 	struct drm_device ddev;
 
 	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
-- 
2.54.0

