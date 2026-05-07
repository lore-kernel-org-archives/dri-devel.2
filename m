Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ACBCD3445
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073A210EFDD;
	Thu,  7 May 2026 09:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QMYVC+5s";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011068.outbound.protection.outlook.com [40.107.74.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A9610EFDD
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeUXFGrL5cfc17IWGH8cQSlFuOGDkq63F0WxS8Hhwn75Q8wZJaqt9ML3CV8qOiKCboW02OK1HuZt6S1y0i4v3UztbqNNeXffue/Eoja4ERB6lSW0UwY246iLK7wxo6wgO2UubBY69O4ZJ07P+Er7Cv/FWmtOjIcHcaNNFmZlpGbwGhz4d/ZnYSjd7UVsKYuwO9djvb4KicWgmeIIElI3qoCUG0mN938wd9VjIOTCcZTx4EtKG3jInj8JKrm/gnJI9bIosrQYEsidKxZzAcWns7aJXQfgRrx0jx4P2ACxeceakzG5GpoZcm8VNry2j2tmIckeDP8lFMYWc4C9jBvc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3307vuYUiuDawDvoKai8KdTRpX9R+WT0/aPHsYMMSE=;
 b=qC41KPh/P7dww9KjQ82z1f/U2yJmxJ9OuGYUn2l6+1y+GHtRM3cFmmtZdRJpTcvb976sWFxg3ThI8eRfWL64YfSWsZfpWLsEW1H++Be9OHrSjfPqIZLkV/nuHRSAns9ljYixOzix3vgU4LBP+UVEwTZDqSOiFN6VVmZTezwEboXbIDKnQMpVDRTV17jUa0D21Mzl9lqzzuBXUyjk9bWd/weTqnZV3k6CZgs5fMvd7RnV/74OthdH3OxY1VmaRdVPysq2Ma3a/NiKJj3W806Vipp/FOqHuAmglj8oJverb3EQkmHCdcFnd+0+rJb0zmU/2IfIxu5oXoHdKGJ6ecEOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3307vuYUiuDawDvoKai8KdTRpX9R+WT0/aPHsYMMSE=;
 b=QMYVC+5sqRStx9pWM/YcRmZNOGLfNTIH7XH8mm+TAy/8E+4GtSSAp7mvPaSauQqBcKtZNhPv8y4h/nqzpj3MbVSK5AaOUN7sSeNCpDLGqeJBu8lR2Nq0aKUIJtnBWGs5gLfwDxf9feSnRpmgUpctQM/qY0cENbprx9R5YHsTYSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB13787.jpnprd01.prod.outlook.com (2603:1096:405:1fc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:22:46 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 09:22:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/13] drm: renesas: rz-du: crtc: Introduce
 rzg2l_du_crtc_clk_get()
Date: Thu,  7 May 2026 11:21:32 +0200
Message-ID: <260cf4aded1e1201072f04be3fc2b728ff952d8f.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB13787:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c75b07b-5a29-4871-218c-08deac1a32ff
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: FU/h8hjc/EiKpraZq0jlKhCcJY4leQbLfb1QU6+sVgaTWjUaLIpKTHEgn91pK7f4a3Sd/KP6lPuLRwwgTuQJzXzi60uynRumiiQatf4bUxvMBXC4yl9R3ngFTq9XgsNwfYxmWfjQ4ghrmFZs53zZhgSQieyNRrH1LULECHHaByl3R7bJ/INIUelI8zkr7BpItl6+B6xyopnD2LNaZP91ehhBkOhW4x4hZY6LymOOiU3O3utuojYJHJTzzVqhvL7ufyFaQfKnLj52ytS+SMlBaLAgS41yddUWDrtGLvB4yNTtMhuXs9fO8HH8ULIA7gDXuNNf5Eu4RGHYXdeIN+HQfM3jOWG1pShFutzYYiPYDCwRP/g+MTM6yBGR0Wp6wHgnlBAN4EiWUzObkRsBzzL/DUxEsZjsQuFaX8OTw5bNo4Pw7Yg7wuiGmLtTibtRa7mMYozY8DoYt+0H49C3nace//UKTGnjNoo93urq9NhslFB3zjc9NGyskmtUTmMHH/5x3A1lIgNAdp2lRoQKAZHS7BiMd8I//sPfdDQXbRsejvP1dyUCEJWu/268IDj7kBbJw53Q6bvf5rDChDgdF73pXooy8BL8fASlNPeg+5mnlUaLR9L6hFw/NSTeRWz9Z25rt0nK0/j3DkjJAJ5O6k/NATtREGc083rvCXzyOlLtryNZsayRrsDjp3EnC7/OrvRrigx0NVJAf5tCsGENmum/ofnwzy05unJDkWVwvMpgYh/Ci2FZqniyqCutCYnNxUTd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbMp+UM4MNhhHuN+KFLKS0KOq7QIepMq3v0kPstwdUUwrsS5Wo6waPjQK/ak?=
 =?us-ascii?Q?jgsvXCKGLJ9teZOPWLk8O2MT9upQ89l7ZiOSh6eo4px82fr+F1li+C5zWQz4?=
 =?us-ascii?Q?dgBp0PbkFyaZbY6KaH9k7DYqvXBaYMnl+vUsMaK1zb2aXFp6fjEj5EFd0QaS?=
 =?us-ascii?Q?UNtgZTg6Q3rLZYtN7UTXIPq4YiqSSBl4X2EdNfI4g33IMbjOIEgqr26bdykG?=
 =?us-ascii?Q?VCplMTWUSZKVEwjAtX7MQ1OBNvdmWt7c/a7R7j/N1MMuwL5rS80A07pBgx+N?=
 =?us-ascii?Q?ISTI2ZtTzengnxVB5n0IvQ50vqldGIf488pvhtHaQW2jLADMBy33K8xsy3ty?=
 =?us-ascii?Q?Yb5gQlUsbYcZr1CGO8n/wbBaq2Fe8PtdPBUvJSyI+OhUoiV0ez1mRKyh8S9e?=
 =?us-ascii?Q?clqpD0g7OXbKWr/ODPmtfLDm//3tx7iw2jooflBc5FrUsoQzFF45sWtu+X6b?=
 =?us-ascii?Q?vNZYwLD7rjZDa5zyyLmWPpwkAb4M95A8Wn8huZR5xtP22TBTMUtoAAfr03lE?=
 =?us-ascii?Q?x7wTTCLOwQRpiAC9fI8YQsSsVeH3qErg+XpTKNO9+GEpOvxLCGBOz6vxpCMz?=
 =?us-ascii?Q?rl6TgACtjV1IlWmswFGcgsthcj1P8rzgnqbbqVJytdfgelhaikLU9aXW/0Rb?=
 =?us-ascii?Q?4fZ32qOg3QoY4BXGlosDkH7dYkuJN4+kbphhOtFLA9UTcG/5PNrZm4skmLaG?=
 =?us-ascii?Q?/iDWI2EQk8Fo8CERuZZ1k5QsYMxcQcPa6xYCFeUv6DIQx0UCUv9pmr+zrcca?=
 =?us-ascii?Q?mkfFs3c1L/YrXcLDeVtxiNGPh3FcDy1kj6vsZyi+vNOEsmNktemT9Xxyu7oZ?=
 =?us-ascii?Q?YZ60WMdIf7A4sOMjoKTLr+kv+vmwy7iGccVByPnD1TutrKyYRgCoZIZrcHXS?=
 =?us-ascii?Q?JjSmf9RFYBzmO6UyhoJ2BafEl7dexmprfJM+m3anmstN09/xqMjEEutNYAP6?=
 =?us-ascii?Q?UXn/GfOQop5BFRiKrX/CWrdpeepi21S+rO4v39k8CRR2DmaWjJK4CBCibK6m?=
 =?us-ascii?Q?WZZU8ZxuNNr6Tuua8xP5KMCQoILIreDcudKkmC0wiigZ55dtAn6iJg39li1W?=
 =?us-ascii?Q?VPun5NqUxA9n0prAghpQfHSQSSj9vb9WTRRX13LLCjq/kmQaso9tILOdHt9R?=
 =?us-ascii?Q?4wkhEk9IuCwKAs0s9KuttQmbQgnnhgxCX0RtBfu2rfw2GMbDLhU61IJtY9oD?=
 =?us-ascii?Q?GLjmG/2qDV7SCADrOzci8CIU8SX4HVQzc/Caz13UJ6BTIg4iwLpAipgbzMV/?=
 =?us-ascii?Q?rb9Vyv+MwrNK5D9PruD/qacSTIAcb9RM5ROSnquOJVMDQnJZYZaBVM9WNwVH?=
 =?us-ascii?Q?uKIxIyg8EMVHZ1RqcqUGTTvjTzNJDSgM6+FTI4jEVf9cmrgVo48E2m8wres3?=
 =?us-ascii?Q?E+qvk0HCGRwCIeZdTiZvlwB/h5AcfLbM/Q1i+RA1+uIxFSHUAAi7tXJmasAU?=
 =?us-ascii?Q?x73MQguEwctt5Xbsvk4vkk5CsIe9NxB2sjO6I30p+8viANPt8Kkdomr2AiNu?=
 =?us-ascii?Q?O1gM+pSyy0eZSmv65PqRRZP5kyemecmK9OauYiDy3CXluf9jNozsICAq2PoW?=
 =?us-ascii?Q?s7Rv56G7HyblZ7ZnTRbJDgS5InSo7GuzYNp3RChdOxpakrfRqoetcjvSA4zb?=
 =?us-ascii?Q?u4Xdd4mlUjZvzqovUmJgJxUEYUSduN0W3re37PJ5b+a4Lz1YiYdQ6xeuRg/e?=
 =?us-ascii?Q?aX8vPPbYMklrF16FZWgKVe+tNWqkfyv6qgZgLUUJekG4zPs3HcxfCA+nGm6i?=
 =?us-ascii?Q?mMeEz5M8XOCdLFCNw7OsNllGvBKVUvbIe9NC/xZe9Rsi9ch2H3BI?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c75b07b-5a29-4871-218c-08deac1a32ff
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:22:46.2242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33BLvBcC6mrhtJLT4mKbBz2h74bnEahB9TKatpXmExLZfCAyU0pNtClb73qpcETqjW1c1Mt41AH5DTmDs6dj7fHV4xQYRVYtqw1ZplNbFKNk799+VlzsxPAgn7rp54Rx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13787
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

Introduce rzg2l_du_crtc_clk_get(), a helper wrapping devm_clk_get()
that appends a numeric index suffix to the clock name when hw_index is
non-zero (e.g. "vclk" -> "vclk1"), preserving backward compatibility
with existing devicetree bindings for index 0.

This is preparatory work for RZ/G3E that has two DU instances
where each requires independently named clock entries.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v6->v7:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index 88915babca12..622044f994e8 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -377,6 +377,17 @@ static const struct drm_crtc_funcs crtc_funcs_rz = {
  * Initialization
  */
 
+static struct clk *rzg2l_du_crtc_clk_get(struct device *dev, const char *name,
+					 unsigned int hw_index)
+{
+	char buf[16];
+
+	if (hw_index != 0)
+		snprintf(buf, sizeof(buf), "%s%u", name, hw_index);
+
+	return devm_clk_get(dev, hw_index == 0 ? name : buf);
+}
+
 int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
 {
 	struct platform_device *pdev = to_platform_device(rcdu->dev);
@@ -396,19 +407,19 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
 		return PTR_ERR(rcrtc->rstc);
 	}
 
-	rcrtc->rzg2l_clocks.aclk = devm_clk_get(rcdu->dev, "aclk");
+	rcrtc->rzg2l_clocks.aclk = rzg2l_du_crtc_clk_get(rcdu->dev, "aclk", 0);
 	if (IS_ERR(rcrtc->rzg2l_clocks.aclk)) {
 		dev_err(rcdu->dev, "no axi clock for DU\n");
 		return PTR_ERR(rcrtc->rzg2l_clocks.aclk);
 	}
 
-	rcrtc->rzg2l_clocks.pclk = devm_clk_get(rcdu->dev, "pclk");
+	rcrtc->rzg2l_clocks.pclk = rzg2l_du_crtc_clk_get(rcdu->dev, "pclk", 0);
 	if (IS_ERR(rcrtc->rzg2l_clocks.pclk)) {
 		dev_err(rcdu->dev, "no peripheral clock for DU\n");
 		return PTR_ERR(rcrtc->rzg2l_clocks.pclk);
 	}
 
-	rcrtc->rzg2l_clocks.dclk = devm_clk_get(rcdu->dev, "vclk");
+	rcrtc->rzg2l_clocks.dclk = rzg2l_du_crtc_clk_get(rcdu->dev, "vclk", 0);
 	if (IS_ERR(rcrtc->rzg2l_clocks.dclk)) {
 		dev_err(rcdu->dev, "no video clock for DU\n");
 		return PTR_ERR(rcrtc->rzg2l_clocks.dclk);
-- 
2.54.0

