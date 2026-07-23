Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33CEC531D1
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B95D110F0FF;
	Thu, 23 Jul 2026 13:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="cDdMrM3K";
	dkim-atps=neutral
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013043.outbound.protection.outlook.com [52.101.127.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C82B610E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1hn3hKpMq3HAioSazx4V0Ivg8f6RUrTI+vBF0py7kJj30AY+wprLLDXcZntT1TjsFKTDpcSYtcOD1HSivTGjppXrNrNebAPyZEyep3yDVLi+RTvtbV48rR9sSuFzingA8aIRwauHXcc1q6oN3aRR5dbykXtXxyhCIGHXq+a4RDJCkR9OIpTXNyk5vBPoGiuYGGHtQI1UKEpv/Ebu2EibSdHOxRL2RGwVQzcRI+tL6jYPOaYg4bU+ZJSDZTP/ZJXSxbcKeTM2s2sM5/gxZU+p7HQRhp2sETRlMMhpMyR3dPce75O9sm7FGVaFhYaSjG6y5+UbbDIyx6HwgrclzJdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4iecChH+jUICZYH5XXV/kI5DR/k2nBZ3s+m1Q+vKdc=;
 b=Z+lZQprSdiIHf6sfSRUx++P9YKk+f4+PL5kCpSPomO2Qn01/O49OVBsA7rDkirgO+vLxvkRj8Z9YdiaPDHKTpy+1CNUHujzHo879ZiV2uLTOv/7urA1QC7/nomQ0Q0DQUygg+dj9ao2hMDpk9nQstx0axe00YQDQx3ZDZRBD5SD7G0Hf4Hgw2szEg8471m+1kffdDXBsd+kLc/wzieOOgFG9qEcmjzreAUQu+F0wDBlvmNwbBJsf1r5ctK6Butga1u1jrqHNTn3ys1mWdri5KLnPpKQHbNFHIIszqllYUTdwxF43nh/WntKqHUd+nLgs+5nTSOheKF1+UGoVrCuRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4iecChH+jUICZYH5XXV/kI5DR/k2nBZ3s+m1Q+vKdc=;
 b=cDdMrM3KI58M41uH6uNPSEdYOTNqOAb+3H6Y81bxJcw5J8VhK26lRrfQGA2JNwyurnZZFsvp4FnEozrJ+iRlaSyTtUV1mow2gCYVZBaHa/4G1MGK46JJy7pHXmSccdtFzkrzt7/tG39mghE/TP+VWzxXNNsuVN2UEKKePDJQ1berLHoa5z+lIvpErKuOWxK85GOvpCTLV6RzEMvOVlH01uTeH/yByiLgzVk6r4hYcPvM7Pb1kNJc6eraK4jpxnJUnSn1YqGTqrxfFmgKJNhrOMsjqEGS72boV5Yd8fLzyKDqG4MmfAMC0zj8tGMDyjTdA0f99HoDXmTsOjK+hMal3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:19 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:19 +0000
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
Subject: [PATCH 06/10] drm/bridge: tc358767: Remove redundant dev_err()
Date: Thu, 23 Jul 2026 21:16:38 +0800
Message-Id: <20260723131649.134127-7-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b798bd7d-135d-4d05-88a3-08dee8bcb947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cT7m++sVBkIgDAXLOZmRU0xAisHchfUL2NfJSt99/1NfUxDTBUm41a0R5KodgThKycN1jDkJe5vb4HusUrSfHf9/6CUbiDAL3e48inOFd4Mf3cjd5t18gb0tUTHAax98AmV79O1gkmf5ZE2/pUpK4otzebiTi9WwJQJ/WAAWT84CaVccGBqoBkFmRomKglj1I+gjYDl1oacpnTGjGjVYKs60M2XJ1/l8gtZ+iztHDPA4TfdKlePxCNcrWZuQGluTBzHphuB+6GVRwmwbutnBLuAcGEhzJi/wWOWSjd9uG0Y7G/nVuh8uLupLzlRAAbdBJCldusigMerMEgFxTafFUaZz8WNYDqPIrYIXaYygdf1GiiOECR8crACEGdyeveyETA2jsnM9w5V3FQnnzdmUEnpfmBbn3z3nnZvw74WGF1WS7R9GtL5GpjrH2nDSzSm33FNTZzp4vVrP7RX5hLQThtqSET1uJDlVpvbu0Gw+uoecMEwEmV75MdJHB/CGB04Dhze7+Nn7qwtIAeII3WnpGXFb7NaKn4KfyrjrwCOhc7bULBybKqw4PopkqsnU/0zoWdAZtQYV5eWtAa5TTHgJDfJPkIYiulb5y4qxOUv0xonKhPfe7GAUrApKbFYVxSfa1a8neq2HYodE5KsO3concMGyXRZmZUh62UFlEOfJfpky3fKJUmoL4aSrRixYFcmWiVPAnCsuIMHd0c/RjgvZAWtuVLpVpIBHcyqz5kUVLinnMJ1LiRXyuwvJxD81SnLx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fCN/KfS6Vj1KdDehHc575kb+hfKtoZCM9lnt1crQce84va6guy46Xl0UZXMe?=
 =?us-ascii?Q?empCp2kW5/8JDm1pyOB7CNHQ9GPhTnGXVMmKLFDBaxm5OBFuYZVVDrvd4MGT?=
 =?us-ascii?Q?B9CTTJiwwhIeYsr6kklGz1MpckCVa1jOz31TAdIQfjOld3FBtKQ+vTGjF4sM?=
 =?us-ascii?Q?+4uvpSKZb8NJnBNhB4DBGdgMocdWKnYPBp6ftPuSwyUvuoGzzY48ssWIraLk?=
 =?us-ascii?Q?Jlh0+f6xgXPmwMkS1D8Y/DIUGXT6eYDgYkYZBVcui6+j3Hv7VzNWv5f0FHxb?=
 =?us-ascii?Q?p19lo19Myo/RioU28HK64hqHm2fewHF52U+dIpkyg3T7sph0K+w2PUGY4Q6U?=
 =?us-ascii?Q?fqvK8NtpbcxVkNrCWO+mZqsPoFFtO/sX86AX4rk2oq48zJwF2IdOQ7Fg1EA9?=
 =?us-ascii?Q?gum1fnyB0CHs79EXFF9PuUQiebwq7BKiXyp+UP1TW3WPD3yMCUMoOS8s87IL?=
 =?us-ascii?Q?HrzvWpMVFkKBOUj7UCQpPkKfLH3uhrdwDgYt3HJRHdjXrsGmtRl1BqKevbQZ?=
 =?us-ascii?Q?zANXLx3B3fEZ5JLzLl+5AfOdVGeKUIMhJqpLOP1L+2+c33DeE3UID7nx+09d?=
 =?us-ascii?Q?vRsgdonaLMXcwxtAMKUl91fvbF7Kv+609IMiOw6V155LfwiPYGWuEHxCqeeZ?=
 =?us-ascii?Q?CYzhpJKu2HVMxAYsDSdDooEVWkHQiJxWkLq9x2UrYAiRleo9T/l2fNlIkO8X?=
 =?us-ascii?Q?P5KS3yPZGSP4Q0PdQ2u0WblXYGuwmwpnt1Xr5OOHQLJ7mBbtRVDW4XrXsYQM?=
 =?us-ascii?Q?g2dU2R6rF39BLMwV/PLQpMoe4bb6IAWVggvy5H5sto7vqAJG/XkW2PIz2+Rh?=
 =?us-ascii?Q?SmOm9+bDMxOZm4c4wD2kI/L2B7ZPKm8w4bOsaeB9adXZhOoIdc6Vmc6UJ0yf?=
 =?us-ascii?Q?Fj1SNAFopf+gkf3PPthecCAfdBsWQs0Smx2zjqvHG4Pq2Qwiu6FdZAcSnRIk?=
 =?us-ascii?Q?pR3zo/vqL6056bCst738j8n+8ERAO698Wmx5ehBMfAfzOvZc3TRlX8zbE9RS?=
 =?us-ascii?Q?RrkxuZNEWBa9g2OMwM2O0uku6NMeWpCFt1FAicNCPJjY9nvMqXcT+dN0dopw?=
 =?us-ascii?Q?2R/zzico8P3M0TNI/oAPDAHEftmZsElnE2kfPAQXgxsvj99P2sDzia6B6XDo?=
 =?us-ascii?Q?YqthE1OSlbENsVgfDzhF3td/fDulDVHMnCt4eQjK3E6ZQPHTrSbnQWyPJbSh?=
 =?us-ascii?Q?UMvmktBDiVSpRIdvOc8v5/lFvk+Zd7fi0KEn7uV3b/rbYGV0D6aODRcfstvi?=
 =?us-ascii?Q?zDRH2AJKFHZYBas+oSQUfjzr8+mqA6Mgs4wyF+qw64SDwo4Gd825BH8D2enY?=
 =?us-ascii?Q?o77Qp6QyTzV5eqWg7v9Nz2sGO+p989Jp1w8JkBuYGC8cIS2aYahej1B3brsC?=
 =?us-ascii?Q?9TV+5lENJ/rI9OHkrqyWwk+uPIBe73CnmKAV/wYrJTt4wXp2yKH9ah4XigYW?=
 =?us-ascii?Q?fGCjjj83NqhCfHNzNjFUTIS1vFF45HX38VrDYDyNOptAGQtelI3umpyq/xX4?=
 =?us-ascii?Q?yw9gnwmc8dZB7LIQIHr9PFz4A6KwEFvYS4NM8xYQ0h0t+qi7PUW1suXdJbeZ?=
 =?us-ascii?Q?72HN5GtWnjSvkZsCY5hjuovbcHBAxqxZTVZ0GVx5T9MCyPk3zD4KVcRDn8/I?=
 =?us-ascii?Q?cJxQ0PRQFS+M5PyLGvugOX/WjqNpbUyU8hxWeO60a8Rz9+r5RwW80xyB/3aK?=
 =?us-ascii?Q?/wtBApqYIiu7iCem/28qHqrnrtiaDBup8evL/fqdVQG7zlNTKtf6Dsc9QIau?=
 =?us-ascii?Q?MyW84gh/xw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b798bd7d-135d-4d05-88a3-08dee8bcb947
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:19.5225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxKFl29yOl52myaiomHjNELAmaQUGV3fkNtZZTqyvILsTemnnel0ro5N60cjQb1o6GhPnzXeUh9Z+kCWJX0Ieg==
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
failure. Remove the now-redundant driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index ce1b73214f26..ab644e4f3a95 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2528,10 +2528,8 @@ static int tc_probe(struct i2c_client *client)
 						NULL, tc_irq_handler,
 						IRQF_ONESHOT,
 						"tc358767-irq", tc);
-		if (ret) {
-			dev_err(dev, "failed to register dp interrupt\n");
+		if (ret)
 			return ret;
-		}
 
 		tc->have_irq = true;
 	}
-- 
2.34.1

