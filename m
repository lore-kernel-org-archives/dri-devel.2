Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78A5FCD0AD
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F5110E00C;
	Wed, 18 Mar 2026 05:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="kjP7QnvV";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BAF10E00C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 05:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1ZPImORch+VpsNP3Hk/YJ+sSgdYTFwmLm8AGlNGSKIHfyKQdysQXreapeDCWrOOsDEnj5xRHu1eU9SH8Gbat1iUdWwb+/ZkSSC4zLamQs36xobiWDAo/5jRbYdq5wtA5AtWsX6lFKwUtQKOhsDtrbqnWN0fYtbXu/Ed5xPqJOImlCQiDm20mo5xi8BIAtlH0NRAOvVTiZ8Hzc0yB69Hq/zvvSBmu/60aU+JSAZEmdV9xuSp4vAXiG4a7YDHnqPGxijZR0BuYHH6x22Dem3VqktjTRrbOeSXm9Xsf14lr6fGmGSwkrGtHD3DKYSkwllyaHT8bxdOLHk4BZVqZNzemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0+NrJPgWNxxnSykH//d7ef5BU9CYfq8/k2nCQhLQyo=;
 b=cKnH1JLyPfZAAMwILB7J/tM8Yib4dwgUDpRA0Rj7MZQQZhtwGinAQjhjij6eJpahgBJkiJy27filhGxXhcSuGAbh5USjIbWIdehsMlylu2675YYXqd8V+vx/K2TKINHJIxv0cCNrCrhB9SVqs+tQhj5Ir/oG/E0AO4wRzLegRUvDYQOBbme1N4zKtH1ztzhi0mIFwr4UJIOYIo/qHNosyK5B47DE5I1AyNTpZ3pEgcdAVT5Qepx345qmy9lMGCz9oQBTnsWvkHcGgBi0iy4pie4hvgaXjwarYy24SQ6dvfkOkLcTGTK9oA2vkzpJetunhnhvevAStcBb6JWoWdJ9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0+NrJPgWNxxnSykH//d7ef5BU9CYfq8/k2nCQhLQyo=;
 b=kjP7QnvVeD5Xs0xeIkf1LFCIq00DYswmvABYHvzngCzYp2kVhsP8WZsZqgL3ARva1Nendd/4BcEyq+u/Pbztj1+kvKpktp3VH7lfI0mkgfygG7ItYWpDb9WqUPvquuWA/TuHIJvJCAvdfPsUDY2ADgVXb6x66hUsMi4B3VJc72JRVOaU4l5s0ea6V+/99Rmm9JRL0Tgs3F7c7AR8/nv/VVPYqzgPAnqKR0e48KMUdSYu/O/lSuOiOUiUwiKX2N6J7rRsO4IiWqiwgXFAcMzx2K0FYlFOZ2PQg7jHKxNAg++wVeng4OAUCxhCwWmXSbRuei3wduQpyG8eDWUEBu3h2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS4PR04MB9291.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 05:25:04 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 05:25:04 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Wed, 18 Mar 2026 13:26:05 +0800
Subject: [PATCH v3] drm/bridge: Fix refcount shown via debugfs for
 encoder_bridges_show()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v3-1-147fea581279@nxp.com>
X-B4-Tracking: v=1; b=H4sIAGw3umkC/6XOMQ7CMAwF0KtUmTFKYgqBiXsghiZxwUOTKilVE
 erdSbvADOP/lv7zS2RKTFmcqpdINHLmGErATSXcvQk3AvYlCy31XqLS4FMHHWcHgaYBlhokgqy
 h5QkouOgpgU3sb5QhUeviIwxgWkOEbW0Qj6Js9+XC0+periXfOQ8xPdc3RrW0/4qjAgX2aBv0Z
 rc7oD6Hqd+62InFG/W3YX41dDGcPcjaFqRB9THmeX4Dl91iCFwBAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MA5P287CA0096.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::11) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS4PR04MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: 20875726-0e55-47b8-662e-08de84aeb598
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ipj1VC8FyDnt8ZnQYVqEzgvWpKCU4xHLsKGUPN6B9T4+feqZYUW1tdH0NnKOfZdyKGUvcD1DV3OwkDQa4g1XD8CaNgUdzDLDQ08WRrJ5FcFY8HMoODSkhgmC6VuP6OzRIItAtltkrZSexJSj3a+GwRglx5kHPtZgjxF7yXK9t5XcxAx55XZWsi/26C3BJtJV9CJXnoqkkhBgrK3tAzoVyo+MZtO8Ff+/ZZGqipAIRY/XEKPisk9C8mJwt3sMjpSpmXqI/aSRTpHx5JWwyPgatOTA9BuygyBk8DOjObI6pZ3/p/Z0UOmWlmLWz14pSqZ1rkGus0uS3FwHkn5nOr6cZYnbwB9YIz3TwK5ffEomytCqdVoHy+1J0CVfG1eIlwz45BvWo7rbKFwc/A5YBq+23HyU9or5cMVd5aPB644JRfemRDun2wsSo8xq76IUXGc81D6R4rQX0akW8CIof4iT5FtvzNzMsjY+RA0OhToN4uWhioPPXzhNf6qAekOHBn+6bv3nppluMV1Rl8SQ4TG0vTohC+fdgZvYSI3NfleJXcSdmv61NGoEvvPgyZtAYrQgPEjm49WiXoI/qVovMxf8yLDx58PKdAeamC6YvbJ9+6TDYh1CvEIK4UeLoW95cw1WSW7C54oQYEZZTTKjfabnOObIyJu9nuK6yrhx/mDhNU7g6tV0gsnt4C9AgUzn48E/uJ0NeSGR3WZkUu/1yg2Oq7DNV7FEa9nZOxJdiRRtXhu9AvoxhCcBIagwyQRY5g30/lCjsNySrscktkyyp28nCJgeIMM4LQtFb/5Hs0OKBrOPHGKEfCUU5BOBEcP0kbhC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01QQ1Q2T2hhOUVlUytHakNJSTNGY1I5U05CVFFiVGNjM3ZjYjZRVFUrUnAy?=
 =?utf-8?B?K1lkZkVpaUtML0pRQTB0b3J4eUVVQ2xTc0Q4eGwzMjRPMXI3cmlHZ0FxNkh5?=
 =?utf-8?B?RFJRNnlWTW1VYThjWVZxVlN4WlI0d1FBdEVCaW5ySzNEbEtuNSs3TUVpL05T?=
 =?utf-8?B?QVc1OUlLK2h2S3RGR1dxOU1TamFpK3h5MHFzOW5BT1BwQWloYXNOZnk4dkJ5?=
 =?utf-8?B?d2VlTFpJR2lVcitudHVPUS9ZZmpabFRRMUN2SGt5Z05xb0dYYVA2QWRTRENU?=
 =?utf-8?B?bXlPdTlkMFY2NEN0elhLVkdlVS8zRXo0NnluRElheFV5ZS9qd3dIeGdGMHdo?=
 =?utf-8?B?ZXFZN1Z3bk0vWXVUVXdXaGdZMTgrb0F3bTVjb1h2TnRDeXFjT2NrQUxNcHhI?=
 =?utf-8?B?SExnWE1ZNjlrVExOZjZJYkppMExWTDNyTU5LMWhjcmkvblRRMEh6c2x1STFV?=
 =?utf-8?B?NUlEckRWajRIMVRwTER0ZlBuNW9kQmZFdStVMlUwaThCQXpTbXFZUGpublR2?=
 =?utf-8?B?bndJdlZSVnZ5amJxZlp2bGtFUzZSNU42enZjVVg2UFUzVVQ5aDV5VnJZU3Aw?=
 =?utf-8?B?UWxrSHNHbWdWb0tJZVNmSHdsWU5iaklnODZWMk1LUmNpUmlHWmc4Rmd2bVNx?=
 =?utf-8?B?SGJiRHBXaWtyUGw1R1ZoSFdMNEM3WEY3V2VBdTl5MGFOU3laTldjeFRxQWpY?=
 =?utf-8?B?TTltLytwR0FHVGowLy91aEgwb1pJeFFpd1JHaGRldTBCV2E3amZkZ3VFYVBM?=
 =?utf-8?B?VzBCUmg1THdtd200aWd4MGxlaDNPeFRXNEdNOHpJdFB4dCtTemZSZUY5WEpN?=
 =?utf-8?B?bEpad3FqZWJmL0U4OUkreTBxL0NxSlZLN0JoYjVTb3VwTmp2L3o5Z2FtVE1B?=
 =?utf-8?B?RzY1M0JLWFVhK1Y0dEVaREJHVTh3OVJkV0dKdzFvRGQ2UWltcXNQK2tVRmNJ?=
 =?utf-8?B?bEN3M2xaUnNpUkNLZUFjT0ZRV2tNZW5abE5vSzVidytVRU9ocHBUdzRpZy9s?=
 =?utf-8?B?RDJBaVU0OGw4VDVwNW5DL1hva0ZOU2VLSmlmU0NRVGdhVmR5eklyZmhiek5z?=
 =?utf-8?B?U0RoZmFFYmluWUowS3RUemZMV0UrRlFvdDBtWS9jN214SkdadlNrdmxBakVC?=
 =?utf-8?B?bDBpTDUxbk9hc0ZMSmJiQ3FnRkxCVnNueWFGOGxpMHg0VDNMd2RMZFdDT3VR?=
 =?utf-8?B?cnR5T2pseTdEMjlLUEhDZnkwSjFnd3NVdVhVUUliR2JHYjRyK2lWVWtRS2hE?=
 =?utf-8?B?bDBjc0YvWFZNb2J2VDgwa0ZaMlJhZ2diMnpVWkx5aHluSEJTNjBseklKTktP?=
 =?utf-8?B?UU5KWGJjZ0E3bisxN001Y1A4QmpvbnA2QXpsV2dNWEtRSFNheE5qMldJeWRl?=
 =?utf-8?B?ZHVxVFRQVEZod2ZEVnh6Z0NOQ2JkOGlwS25DeGRYbDBqVldYOTg2M1YvaHVE?=
 =?utf-8?B?WnpYMUYweE0xS1U5M3VlZjgxeU9iNS9rM3RlSVMxcTVIY2JEbGJ6NVF6Y21Y?=
 =?utf-8?B?TXN3dVlOR1Y2amlSa2daM3lRZ3R1dTU2RVd2d0NNMTNzOTZKOHpObEVobjB5?=
 =?utf-8?B?dVZjdURkWWY5Z2VQc3JPclBMbUdid3VEVy83azJ1UkRiZFoxQzYwY01rdmF6?=
 =?utf-8?B?WkZGRjNqT2tMVW9hQTBjbGpWNGo0Y2pEOFd6RHI5SmowR2RMTnh0bmF2aTRi?=
 =?utf-8?B?VTFCV0pqTlFoS3JOTjlFVlNGVnppZ1liRE9nMXFwa1FMSENPV0ZSY0hrV0Iw?=
 =?utf-8?B?bStzc2YzT3pUTVpxdHB3VW44L3pSK1NKZStIMDFCditmcVhuN3pXTk9NOXBk?=
 =?utf-8?B?dkM5QTN4a043c25lY0dsMUxacTBZL3ZyNmwrVDVRalVaMmF2ZWdkQ2puWUF4?=
 =?utf-8?B?V1h2ZXAyMXVhd1pEWEtFNk5VSW0yT21pS3VSMy9GZm04aTBkQWFsL1RkSFZI?=
 =?utf-8?B?dHQ1VW5RbU9QTU40QTZwbFJKYzJ5aHlvYkZSSHFWUWhtNzdNM2ZqZWpLTkQw?=
 =?utf-8?B?YlR2VktEbkdLSHlXOUwweDltU3FwK2hZZmZCbENyV0MxYTJ2Z2ZTMEl0SWth?=
 =?utf-8?B?Q1l5RzRHZHNHZWJheHdGeXFiSENaV1B4NVdBZEFXV1hCUjhVQ0poeG92MDJB?=
 =?utf-8?B?ckM2RTJoTjBuRUtEZ21nRGw1TEZqNFYyYlhxRjJvUGpKS09zdEVob3JoT0hU?=
 =?utf-8?B?MjJvZENjUWdEL1RvTjJORW9FL2x1Y1hXOUIvS2o5NVh0NkJqT0FERzZ3MVcw?=
 =?utf-8?B?ZGJVUkxQc3piSXJVY00rbXdRUFdNM016MmUyWXhVS2JNaGg0UnpFeUhLSWdu?=
 =?utf-8?B?TnBveWxNY0JJdHNmUTFnbk5iZEREeldCK3NJQXZwRW4rQWVSdkJRdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20875726-0e55-47b8-662e-08de84aeb598
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 05:25:04.0248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIR7DWimJA+qUMtTpt6QpCy5dkjnEvWvq5jxIgeO220UeB9Q2oCBabbjxgsqGFcGeIBniIu0ie9LC9YGhjCD1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9291
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

A typical bridge refcount value is 3 after a bridge chain is formed:
- devm_drm_bridge_alloc() initializes the refcount value to be 1.
- drm_bridge_add() gets an additional reference hence 2.
- drm_bridge_attach() gets the third reference hence 3.

This typical refcount value aligns with allbridges_show()'s behaviour.
However, since encoder_bridges_show() uses
drm_for_each_bridge_in_chain_scoped() to automatically get/put the
bridge reference while iterating, a bogus reference is accidentally
got when showing the wrong typical refcount value as 4 to users via
debugfs.  Fix this by caching the refcount value returned from
kref_read() while iterating and explicitly decreasing the cached
refcount value by 1 before showing it to users.

Fixes: bd57048e4576 ("drm/bridge: use drm_for_each_bridge_in_chain_scoped()")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Changes in v3:
- Changed '--refcount' to 'refcount--'.  No functional impact.
- Link to v2: https://lore.kernel.org/r/20260318-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v2-1-cb705bd84a31@nxp.com

Changes in v2:
- Improved code to manipulate cached refcount.  (Luca)
- Dropped boilerplate code.  (Luca)
- Link to v1: https://lore.kernel.org/r/20260312-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v1-1-b9ba3d844732@nxp.com
---
 drivers/gpu/drm/drm_bridge.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index f8b0333a0a3b..96e1bd86a585 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1570,11 +1570,17 @@ EXPORT_SYMBOL(devm_drm_put_bridge);
 static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
 					   struct drm_bridge *bridge,
 					   unsigned int idx,
-					   bool lingering)
+					   bool lingering,
+					   bool scoped)
 {
+	unsigned int refcount = kref_read(&bridge->refcount);
+
+	if (scoped)
+		refcount--;
+
 	drm_printf(p, "bridge[%u]: %ps\n", idx, bridge->funcs);
 
-	drm_printf(p, "\trefcount: %u%s\n", kref_read(&bridge->refcount),
+	drm_printf(p, "\trefcount: %u%s\n", refcount,
 		   lingering ? " [lingering]" : "");
 
 	drm_printf(p, "\ttype: [%d] %s\n",
@@ -1608,10 +1614,10 @@ static int allbridges_show(struct seq_file *m, void *data)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list)
-		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, false);
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, false, false);
 
 	list_for_each_entry(bridge, &bridge_lingering_list, list)
-		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, true);
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, true, false);
 
 	mutex_unlock(&bridge_lock);
 
@@ -1626,7 +1632,7 @@ static int encoder_bridges_show(struct seq_file *m, void *data)
 	unsigned int idx = 0;
 
 	drm_for_each_bridge_in_chain_scoped(encoder, bridge)
-		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, false);
+		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, false, true);
 
 	return 0;
 }

---
base-commit: d2e20c8951e4bb5f4a828aed39813599980353b6
change-id: 20260312-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-8f8ee3f58339

Best regards,
-- 
Liu Ying <victor.liu@nxp.com>

