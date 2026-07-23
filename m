Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C386BC531CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E44710F117;
	Thu, 23 Jul 2026 13:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="Kh5THb4B";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012032.outbound.protection.outlook.com [52.101.126.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E1510E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgRDvHZdMBNGE/HHdn+4nC5jfm7wKBSCf5x8t8sfIBPz+mXr+01x6riX7rhfKJhKoMj2T5PNiKMEdgfguCQk3A3jmvHrm3YoFdEhSys2gq8cdVH2ghb6oLPxRxOjiyVvs0MOxYXq8QLdu/Lm4wqW/+9DsvW0jSglviZ3hBD6Xjm3YaBswGEyHxbb6GBqnpEvSrTaHkR+iO9g/fBgp2NvVklzHzIJ4QWYGA1/m8xWfaI+x4V1LMN73w50MBeNatkxCbIsjB+6u0FbBWDbe6iUCxCSHrahtsurnmQsH2Mvo/VCP1Kk/GaIfVGCqHlev7kMEkgiYqSfDiVzsKVvadVeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feWrnUCN8jJabL6uOtsHwTDWeY20ch8uGaKRqa+aDNE=;
 b=oC4YTDVYu5kahr1SvcyZmnSZEqZJiUIOTaoho4EzKEbxHbVuLjL5vaxDIHT2J5lMht6dccmPQ3abD4CwAgOR3pv6nwPf3fqGJz6rdK39R93HEPJR7XwkEvjtk4/WXhmiO5Q/J31fWms4wzdU1orDCb2BWrzEKEI3Y4NJRZzfvYCfyWroU9X+YxNasHVT+6o7R+PiSrSkfngA4xKI0TNBEwE6B2BysJcP2bk+HUHkp7iVeEc070yoc76NYkB0SJUYDwi6joWW6Q0c3FJ0x3C0xKqpm3H1tKLoOcyjlABTH++zmJiK6L50RsVB+yXH5kSi3PwL94nz6yjfjTfU8NMitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feWrnUCN8jJabL6uOtsHwTDWeY20ch8uGaKRqa+aDNE=;
 b=Kh5THb4BusLLq6pyL0JWK9IlZ6eFJffM0qvmBh80HvFnUcKjHBTMcEXFPDCIZw+NV4YopphzVcgAJhw6k0RUYJbYubvly9tON2o6O9yjNIzPXFjEAVtSp8XBCp4FfL6ygwuw/D5KNn2uk9qlsQ2pYj848HdKjCqHkQ2OdqldMZG5u+dQV39gkTTO08STn00FH64MuN8IeyjbHEZIoQgBBb0lBsKI4Xxy7Uil4B6syETrUyteT4asSf+P9ajSFYoWNt5hh/tuhI57ApxFANktb3PAqYVmJROGa4at/g1/VuRZc0a8dooy71U5B/UdlreZp1FmgWZwdxyGmI+7KTdkyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:25 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:25 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 09/10] drm/bridge: ti-sn65dsi83: Remove redundant
 dev_err_probe()
Date: Thu, 23 Jul 2026 21:16:41 +0800
Message-Id: <20260723131649.134127-10-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131649.134127-1-panchuang@vivo.com>
References: <20260723131649.134127-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a8a09d-39cf-4060-4fd3-08dee8bcbc93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2bzerTUDjFRAd+i6jq3ZxMG+pN9OcI/lNN4qnnggpzTZB3hFJq0XDfvQg4b8vM+U5Zu2HDQJrE9k149m4cdBZiDJFX8EyU7ZblUK19WW6iezjJTKUHw9kfy+kNMyD1wcz58R0ASP07X0I6T5IUsbiw2FB7RTqi4cuB5MrJO+x2ZyuoMChhoZR3PYzRVY/cze5aQ2UQhL3FzHjUtn07r7qPHRLRiLo3rfZvFAPtHGjEvxo409MM3zZZOmVGUuCKeIM59Hc0InLx/jGUtA2Q2sgZg3hYDMWh4s0GRgKGMyEhz/Sxn+wX/Q3SXgDtfdXaRtisacgkBQdKM2zqYoQY8ge7kdo8pa9frNHEhRS1rF6IihuOkCBzKigS6osggdCAJMPsn8kVkxDyfbHd2JVEzMwn7vLQuYdX+HC/TRQRJ+JsNhBhoTqCixJ6Vx2v6+uOMAFGKfVg5eX53OzaHT6z0M80IORzACxRp9idx32SwY4UQa1NtShk8EmzAqcE606bVh8oMdmD3o/sipKdHCNleQXEKgX8M7qRXU5awOxxs26uSrpJb4975q7l+wDSkh5ST6+YnMgRoyzXJ3xKeJPRT/xuYL23yhEJIR4mEwQOfpjHHawv7l+0IWAGFksLfJYXmTqWfJeWyaOAx3/23nwj8pTXTED27144VnRDcpObrH+2Qo0a1V0mnms0iBWzFiy1mrlig+taveSF5AizzbGUYXvQGn+pUF6bHrz23y69TKjM6obhLCAB2CnCV3X622uexn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ObJWeVR9oUXKkIkM4mKULZBCZ2UokW94EhyozNBrAFy/yxXzN/xvWbXzKxe?=
 =?us-ascii?Q?+28/MjkMYCDafuCyndb04NMMEL39ntzNrM/Wdhum3lgj/aKi/dXQvQbIHDEv?=
 =?us-ascii?Q?rgQZexLfrEZTYT3ZeW1u15kL38RCY61vcKXrhtmTvTqIic2oqrcKAgBpS6Om?=
 =?us-ascii?Q?LLDKFS9XeH6/7yPdz1cRd0c3u40re3rXjkr5+mLPYUYCiP/hqJnZS3JKKt1c?=
 =?us-ascii?Q?bhCwCu9YVoDDq6DbBuZthOaJPETYwmFAr2OwozP91q6mm5FoG7HfK3IwI434?=
 =?us-ascii?Q?1ny8c4RhGqewGiPTP6suc2KPSKiWNUk/WvfZgj8EvTYYeGYw7INkGVuVD+vh?=
 =?us-ascii?Q?/HvysAosINyxZ9HDw6GLSDR+XD7qJb/Z/jWPQia4K5d9YyxmzXtEJqeaN3am?=
 =?us-ascii?Q?mjdL9q+JyUb5eABkylmz6tsolVJynQwQDa+/ehpGpBXhoWscg7UtRAZy0LhG?=
 =?us-ascii?Q?ZiacZF53TCjvdSyy6pwX214EFjJ1JNW2F219OjBCLBCmfQ6jemDvC14d1Yz8?=
 =?us-ascii?Q?fgK8YhFDEVyBSyf10dIcb/amgOttJEqFHMb3obK+aC55Ebb5O8WjtEC84YRf?=
 =?us-ascii?Q?XT7/14xucdYdMp9La63ogn3Gn5ai4cpdVtVJy0gtkbS8ueEIwac8KJRhBWgI?=
 =?us-ascii?Q?uF23uOK5TznUY8CZ9EEberia4xBFHUPX9cnKO0DIqwvCpEbkvvv1wGYCUMel?=
 =?us-ascii?Q?omSrjf5ME0Kx1oxzOpNxiGP+BPpgDHikTlGondRLFdomcvHC5vxAOIfS7a7Y?=
 =?us-ascii?Q?gwI0we07wA2dMWGl04MbMkcJVKlRNPawsekuHJHVWL/Qo68aw2Tzkep8KOcD?=
 =?us-ascii?Q?GHrRTT67Nl5MwOt5zXzrv+tzdhY49OGC+cQeAZ3QsIEkAEccrsG0+DnEIT/C?=
 =?us-ascii?Q?GnmMJkm6Scu1XOoVZ/xvOyydsWaEwuj0fiG2TjgidCOsS5STFWu0P03zu2x7?=
 =?us-ascii?Q?iw4+5cbEIMLxtNT44tvnHyMe3sqFgLyulvsv0p31rjo2DCdrA3MGbJwaLmbR?=
 =?us-ascii?Q?U1/c9+v7et228INSstbuaVjgOPpUmTKzQR7Bq2c6fgC2+62telN2B+Zqt9W6?=
 =?us-ascii?Q?ELiW2UsEvWmnxN5pmU89FeXyrhVZiOblqH0mzAlusnfDPbbS/K0OC1HVmSOB?=
 =?us-ascii?Q?NQ/Zy4vXYbAgV9RIWaIamlb5k59MxugQucYOOSL9S8Khby/kRc2zV2RWr8tP?=
 =?us-ascii?Q?AMOuIICR6qg4VDyiaCgKa29yCMlRLBSfNAYVGy0HtIxGyeTwpSUI3pyCdslw?=
 =?us-ascii?Q?j6hQ0o9NPh0Wcx9bzvTJTXqRRjz/KNqnM/4AvOXI05gEqA6Bytf04nCmnSyF?=
 =?us-ascii?Q?NlHH1sSF6fBlG6wD5euo9ZEj5U+C6yK1Z1Hs7wKKNhDdibB/SFqdaH76rL/7?=
 =?us-ascii?Q?xmO6FqFDsFjXvHrkJjYmUg3ZyQor1eHx8yZglf1kGSVs5YHdjEaRo4+NFErn?=
 =?us-ascii?Q?RSGzW+poWIdkEGBejJFs3qn57PjraM0xk9uwATZg8RSPt2Z0BPJuu1RKiDbV?=
 =?us-ascii?Q?FpusUOLdILeqLMGfZfaS5WIeNsp1p3dZgIKkGQ80PAhClRN7Ge1J8NrTqHOd?=
 =?us-ascii?Q?pZ1fgB/56/OoTI58Pmk1Q98Wj0RewLdAorWerlmKU5eR9cDvSUSfDPePsNUl?=
 =?us-ascii?Q?2RMcRcNjWxZs4Ozfyy/C8N5fv+r8S4O3NGmxSebqW8OLbSmeRLFfzOA+sECz?=
 =?us-ascii?Q?2p6Z58OHb5Zh+sBeRhcoaGZzghTmNKKSfBNyEgq07syu3QdZ7IWrJtXMhAz6?=
 =?us-ascii?Q?JW40pAF1og=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a8a09d-39cf-4060-4fd3-08dee8bcbc93
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:25.0095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvCLnqoX75Bg4XgjcVhnERIWE/gCwma5MGWfOpwHX7W9JPnwf3KNP9aYujSIbnvn1Ip5Zie18pfmjydvfL1JLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8724
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:26:48 +0000
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

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err_probe() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index e6dbe51d0dba..3bc422c9d77a 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -1040,7 +1040,7 @@ static int sn65dsi83_probe(struct i2c_client *client)
 		ret = devm_request_threaded_irq(ctx->dev, ctx->irq, NULL, sn65dsi83_irq,
 						IRQF_ONESHOT, dev_name(ctx->dev), ctx);
 		if (ret)
-			return dev_err_probe(dev, ret, "failed to request irq\n");
+			return ret;
 	}
 
 	dev_set_drvdata(dev, ctx);
-- 
2.34.1

