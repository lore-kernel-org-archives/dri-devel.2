Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465B9C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8701810E4F5;
	Fri, 28 Aug 2026 12:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EpfRUxwN";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011069.outbound.protection.outlook.com [40.107.74.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF17110E4F5
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 12:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjCoN/GJENnX9twAZUEFIxmTuSXkDgkgkftCgy3ewZbMlI5P3AFXU7qUabySKpcevaQ+mqNU9DP1YHAEpOPwphgHasDpKEpL9TIsOQuz9BHrsdLKbu+lU+u5w1gAeBOFLZ7WVrkHUDve4uuzR7fcaktg4DIYPIe6NtSN7zeEJ8tbqjnjqzCahLGz/r7iXPfd3XEUTWshRTgB43yw7HTB2WjxyuTGw+PUXjQkx7eiQksh8xPjQWkFiixfQ29whoYTMJKk9KgmFqk/55+IyTetNgUe15JC/nFnTs+4zjfLZYCFNyHkEC9Qhyq9sSv4QfSI5iONtHcle0GxcjdmwFz3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubp0WmkUNjYQTSCRtZptbP6fj7NUnigkMWQ1mjSf7fo=;
 b=W4Ka9YO0Tl6enfSMFyjU9c/BaT0LojXtarhI+KYj+2tE688ZcOp9Qrmr4K2ngifnBg/ZSKSOP7Z3A+LEsLxSvnzQsxXJkrbx96Fv2Tn3Rfj1bYEHVBkKLQvK9goLZbf9QHgZWpoVNhbTJI23TafWXek7fTEIla902hF39lNwT2J7RN/9GiRRR4OfClmVa/JjeE0MZHAJUn3kqYMg8DmnI0JOk425PtyukaTV+sIL3rRMSpt+BaN6nnN0Ar7eAnEe844oG6UsAyBsD4SfIeOZIcqe2F/zC1FPDFVm4gMDZcXpRRa6zzekvgPOP+s6ZnP4p226WNNm8PQQF/fM4JwrbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubp0WmkUNjYQTSCRtZptbP6fj7NUnigkMWQ1mjSf7fo=;
 b=EpfRUxwNzLSRH2ccEk65T0jGTUurU7pfTbu+TQCP9f5i6cx1i3b/xYJu5np3I2vFMLfRXRdaYj8Kh/ekXe4AHFeqKxWYy9bVpQyQUShZWYtQgb/gbbWrVZLhGaP6DfkX5TykM1sQyYiFdPCq9JdNUoBazXNztY90u7KM4jgsCic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY6PR01MB17444.jpnprd01.prod.outlook.com (2603:1096:405:360::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:22:12 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 12:22:12 +0000
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
Subject: [PATCH v8 3/9] drm: renesas: rz-du: crtc: Parameterize
 rzg2l_du_crtc_create()
Date: Fri, 28 Aug 2026 14:21:06 +0200
Message-ID: <20260828122113.1426778-4-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: fd987503-ce3a-4ab6-7dd5-08df04fefcba
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: 8ymwSE3hL0zavISpU6RnHOUeY308n5gBTgBdnhCkDzPYqnklcNttlidHmcKOWhz0DsnvFLWsqBypuGBkKFUZW6RbHAdm/IMIin9qKyrEsotnbMyrVUppRgccTrGbFpfT4Pobx5IpN9QufUCOZ692ZWxyXHfxBVrTAX33QGCIa+aUIAAkfcyOUlfNssNS+VyjU9n6yZu9F5feMqFZyb04hsYfgwDnZjEdhWsh7qTxFrNwSQtVnwuKJuFHwofmExRM9N4B1exnL1LvpunnlL9kaSwsTkD+RBzWGf7d8Jg/zTmDiczzi2T7J196BXwVLPEW/nJ2KXq5gcvAkJ/HFOwkDZ+Jw1BQdwI5BYCiAOLwdDqATtLLlgSunNGvVcL0Ee6PdpqA7B3Rlx4h5xUPb2I0sDc7aQ3FXgvwVuxW/MP+p6zQU49IIHWWvZ8wIKdGLzs7ypAbYsnq4QFQSwPqBot4sUxkfBsw3UhaVwTur8E+ndLbcce7K4EvUys1aSnf5lAbyEM3a6CrjER6Qs8rUQmBSrPJmrFYoV/IEqEqxfF13v9EqzRTLv/PSXeFh+FQmnov0dTK7iik/FOrKCBIkppkKVXgU/OECZc4gcUM1VIzXiD/R6KHKeDuTIk6FQYOBfuWOEbCRp25lUi8PFKmyracseKHMzxK7GGgv6XY7AIIaYV/TDl9MSSzI84eau6p31+pK0yNuMvRu5WB48Zvx98CnwTl2afMEo0WMHoFJsTYkac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3IdRySSJ58wKtPIX5uSrP86JscAWc0mfcurUy77M3vrYeoUM/mi4dijNRST?=
 =?us-ascii?Q?SEiXFQDPgTdnFBzA/PRJZowLUvgD650DzYcyzU9OOE4a3MNEdWOLLTx2s66G?=
 =?us-ascii?Q?6qCV2rr8XcoxTLDpyjHaRBIY9Y/gp4gRq05N6uiRr8w+fFPT+NUvLf6MiP23?=
 =?us-ascii?Q?Mw3zEwgxLm6X3r6vSAI/xqSBX/dTsVxwtuzjh1SdeubGHtl/8SVs+uYegcpx?=
 =?us-ascii?Q?cL8vlCsMhLX8ybPsEnzQIA6WS4SuF77N/p3oXomHZXRBAuXDoh558GB7IIUj?=
 =?us-ascii?Q?pQq/G+6QFeJnA59zaVsBNtj4yYRNJEt5oSMOyFWdIW5UZJGAG6R1lKqq6DvY?=
 =?us-ascii?Q?XFnksx+eHfmn7oIpgOknRG9oiRzoNEiL3PKvwZILbcEhjdi/2kSKcAhHa6+D?=
 =?us-ascii?Q?EqNoOZ6H9fz9/rsUZlC3pgsQzs2PzPGXU1RJMaAoualwrhJAibPthOLLbg4e?=
 =?us-ascii?Q?yqOUP/k4pjY1SPryHzXZ5jznrSIVfcQQhHGl26NiR7xIB2wrmmkVAOve7QHU?=
 =?us-ascii?Q?ssgsN2SvU1N0JHAzlveGSflgLHH5m2aoZaDl7/Dt9eh01bhTXPXcs4GWhE2U?=
 =?us-ascii?Q?zAZBOdHm9kQzr8GnAc9Xgfx73behDydM9taHRNOMkUwN867r9vbtUce4z3MJ?=
 =?us-ascii?Q?d/Oi3acLJzNa5/E7XuL9tcx/W66e8d+seZmVma2NeTyxxaMSmffA7PZRtTOT?=
 =?us-ascii?Q?5bBRvgOyPnF2j+v7S71NfXBXUrcr7CAqEStYOZ/LXC8BiYfmvZOjR4K2DRXL?=
 =?us-ascii?Q?ONVcCAIXufMyoX9jl7l4NIA/YffdsrOcatbyYytfjQ96sbnFLkYTFlWkQW3x?=
 =?us-ascii?Q?FlPFxd36JjuQt6p0yNBmRTYB6OVIMC03NNRPP8IjV8MHjRbRIrpyemzShobB?=
 =?us-ascii?Q?wxmmWx+29T7/F7qVxzFdkB3JvalkhIksI9+wgr/V5BXtVHdkJvMubNDFZBAS?=
 =?us-ascii?Q?XQz25Ly2a2T1e0UL/KJsNdJ/vqN0y0sRCJKehBrEUIp1h2uhoZ9AW8asCrip?=
 =?us-ascii?Q?qB7/QbyI9oohatwljrW5uU40yPlpgGAKaWJ5JGumUsCS2kaLK0tlVl+faP4p?=
 =?us-ascii?Q?/0W2hYo0bzY8plZ1bRK5fZ+9Wc4bFlBe11Aekf9E1IM/Q4LV4LkhoWgCyvSR?=
 =?us-ascii?Q?+BrblDznSi/fI3o8m3jgJJspIljZ3wO3piG8D1ejOvGfXmz0x/02ap7nozYN?=
 =?us-ascii?Q?bOxfYwvVoMVyke82P/lX7iwhjHLs+aS03r8gxv5KdhgVIY2EhAB3bHP7Dvml?=
 =?us-ascii?Q?l+62HFFZ6r5lERNEGcmCbGXoKINzaw30Jhxj/u5xvtSKn5HU/kjyt4EaA6Fx?=
 =?us-ascii?Q?NLKgb0sB6vxsbX76mJDVo4yP2BvH6RzQJr6//MtmGHlkcMQl4NJlqFrTyftc?=
 =?us-ascii?Q?m6vVgdRskTaBKOHx55rcT7HyW9p9sppL/SM+dPbOPvBU7H0dmeubsEP+LsMv?=
 =?us-ascii?Q?c6wjTCMbpbTXh0bDSDAp/MGWV2x/ilzS/5ZcQ/ziVaqYciZQB8g7bnpzIm2S?=
 =?us-ascii?Q?JqzNEiETPursWZeUA+6SKp9o/KTXhcGZ36t0dDzR0NX8kpCIasVu0aRkYtgU?=
 =?us-ascii?Q?Wytd+NrTd7Mvs1hqD6WnFnB8VFpJKGSiKYnnpP0vg1vxim6OcrVljNZVpQ5U?=
 =?us-ascii?Q?hhjHv4uqOk65aNNECqD6g1BkGyov+iebYcJt5JrUYorxlPbMypSKmi0wDLH6?=
 =?us-ascii?Q?fKzMBddMm0zUGb+VoN5RBABVq3fYY+5//6aMu6eE9i6ZPTEctEDWWyDJALgB?=
 =?us-ascii?Q?QIBE1PYTllJKn6FVacYCuTL4nz/V5p4dI1INV5Vcfsb7hSSmNism?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd987503-ce3a-4ab6-7dd5-08df04fefcba
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:22:11.9395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qFK4lui2An8fIwy5xd21P2EqywRSPJt7jnYrnmerIunIl4VmhPmO3/Np3elp38F9pjNoy3wa5wxTzqnqrnCZVAiRzZYoxbtHx6ga6v3WZfxhxpFp4R9V5epjUWnC7qY
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

In preparation for SoCs that integrate several DU channels, pass the
software and hardware channel indices to rzg2l_du_crtc_create().

The single caller is updated to pass zero for both indices, so there is
no functional change.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v7->v8
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 15 ++++++++-------
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h |  3 ++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index 3e82a0a2014a..5aecf325e89b 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -377,10 +377,11 @@ static const struct drm_crtc_funcs crtc_funcs_rz = {
  * Initialization
  */
 
-int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
+int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu, unsigned int swindex,
+			 unsigned int hwindex)
 {
 	struct platform_device *pdev = to_platform_device(rcdu->dev);
-	struct rzg2l_du_crtc *rcrtc = &rcdu->crtcs[0];
+	struct rzg2l_du_crtc *rcrtc = &rcdu->crtcs[swindex];
 	struct drm_crtc *crtc = &rcrtc->crtc;
 	struct drm_plane *primary;
 	int ret;
@@ -388,31 +389,31 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
 	/* I/O resources */
 	rcrtc->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rcrtc->mmio)) {
-		dev_err(rcdu->dev, "failed to map MMIO for DU\n");
+		dev_err(rcdu->dev, "failed to map MMIO for DU%u\n", hwindex);
 		return PTR_ERR(rcrtc->mmio);
 	}
 
 	rcrtc->rstc = devm_reset_control_get_optional_shared(rcdu->dev, NULL);
 	if (IS_ERR(rcrtc->rstc)) {
-		dev_err(rcdu->dev, "can't get cpg reset\n");
+		dev_err(rcdu->dev, "can't get cpg reset for DU%u\n", hwindex);
 		return PTR_ERR(rcrtc->rstc);
 	}
 
 	rcrtc->rzg2l_clocks.aclk = devm_clk_get(rcdu->dev, "aclk");
 	if (IS_ERR(rcrtc->rzg2l_clocks.aclk)) {
-		dev_err(rcdu->dev, "no axi clock for DU\n");
+		dev_err(rcdu->dev, "no axi clock for DU%u\n", hwindex);
 		return PTR_ERR(rcrtc->rzg2l_clocks.aclk);
 	}
 
 	rcrtc->rzg2l_clocks.pclk = devm_clk_get(rcdu->dev, "pclk");
 	if (IS_ERR(rcrtc->rzg2l_clocks.pclk)) {
-		dev_err(rcdu->dev, "no peripheral clock for DU\n");
+		dev_err(rcdu->dev, "no peripheral clock for DU%u\n", hwindex);
 		return PTR_ERR(rcrtc->rzg2l_clocks.pclk);
 	}
 
 	rcrtc->rzg2l_clocks.dclk = devm_clk_get(rcdu->dev, "vclk");
 	if (IS_ERR(rcrtc->rzg2l_clocks.dclk)) {
-		dev_err(rcdu->dev, "no video clock for DU\n");
+		dev_err(rcdu->dev, "no video clock for DU%u\n", hwindex);
 		return PTR_ERR(rcrtc->rzg2l_clocks.dclk);
 	}
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h
index 77ec92c4825d..0fa8c4369851 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h
@@ -84,7 +84,8 @@ static inline struct rzg2l_du_crtc_state *to_rzg2l_crtc_state(struct drm_crtc_st
 	return container_of(s, struct rzg2l_du_crtc_state, state);
 }
 
-int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu);
+int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu, unsigned int swindex,
+			 unsigned int hwindex);
 
 void rzg2l_du_crtc_finish_page_flip(struct rzg2l_du_crtc *rcrtc);
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 87f171145a23..7cbdf146788e 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -440,7 +440,7 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 		return ret;
 
 	/* Create the CRTCs. */
-	ret = rzg2l_du_crtc_create(rcdu);
+	ret = rzg2l_du_crtc_create(rcdu, 0, 0);
 	if (ret < 0)
 		return ret;
 
-- 
2.54.0

