Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9CFFCD0A8
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B7110E054;
	Wed, 18 Mar 2026 05:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="d7IutIu8";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013051.outbound.protection.outlook.com
 [40.107.162.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05FB10E054
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 05:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Buyr0yqBFzQcrIGNVOMUzGg8EI8QPIoh7VTXC+x154AyOtM8OvTaUSoDkFgBCYMx0Qj8MK6evLEvU/sw6qCZMg0A5NaRS6WMvtXvP39apM8DAKXbONUYMHvVZpubi1vuBUpUeqTCD2zJogU5OV++wiqditMOWGF3I5dh840QSXIS4tt84ibluGe04U6sklJ2GD7mEajG2jhxD60uCkz7O5/bv9yZu+CMhWs4W4AAUGTsVoJJyBDDwzzrTwIWxxKPxm/MP88a84WSCfm4KFhRhfw5od7aAqOCp9Es9QcN6AYqByd0QXwvft58V+vSywV+GWnWKqeOBlhGITQI5MVZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlnvnqDBidKE8F1DnJ222YrfiSc26pdsqUqR6TDEEfc=;
 b=tFljPgzA1djFlz6H/K/1HYVw2L6tvfu0IrwFQ/TxYuWKnJSG+GmgMz4YkH5vWV3YPi7wcgssg+s1BHgRnEbRJbnM+7ZUHTlQnqGG5yGrNRYeeGBASniT4dWqnntuLb+4xp692+b/7Pa6b5848KDJroUH7a+H2+oHYRdkJOfHCi4/1bCvhzhXv3rbrIiLSouoZVcRyztzeQpUpFlvghX9WSMSy+hVHfv35uPxiTQnE+YWoHLMEfhknobiij0ei1Fie777iX7Sqg9+CbYX8whafzx5BPBNXK8dqYkxgqS36BwwVysFD5+CDbHJmNG0izqpFGlEcnGKI++OPOicKAmihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlnvnqDBidKE8F1DnJ222YrfiSc26pdsqUqR6TDEEfc=;
 b=d7IutIu8mxF5tuRHaQskiZNEffFsdrq9qbPe0RwhVTiUh2ImeqTY6GebkELqESM87R6d/w4Y7Q2XUS1xbYNY2wst8vUVeKeTWCLtdfsX9skBnLv0biCenj4pDFHV4oKkPvef6e1OJU10ZhJIE05FO8/wnKBnkzF35GWhCjIM9dXMUkxuCQYs5oXpym1v4jbpwLRRtTkFLNK7oH0IiCX55H90Bp82eO98eNPBtl5ljbnh7zG2YSKOFPpUA6G2+jJSQylRfOY4DMiLjkZfNt2o9VxihS/NTH8ajWRCS48WY5XmacFEk2InqQLYVZdNeyM3Z36WyUmdQTLxI+8NPWiGnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VE1PR04MB7309.eurprd04.prod.outlook.com (2603:10a6:800:1a8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 05:10:28 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 05:10:28 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Wed, 18 Mar 2026 13:11:24 +0800
Subject: [PATCH v2] drm/bridge: Fix refcount shown via debugfs for
 encoder_bridges_show()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v2-1-cb705bd84a31@nxp.com>
X-B4-Tracking: v=1; b=H4sIAPszumkC/6WOTQ6DIBSEr2JY9zX8aEu76j0aFwoPfQvBgDU0x
 rsXvUKX3zfJzGwsYSRM7FltLOJKiYIvIC8VM2PnBwSyhZnk8saVkGDjBBMlAx7zAocGroA34Cg
 DehMsRugj2QETRHQmfPwC2mlE5Rqt1IOV7rkklM/dd1t4pLSE+D1vrOKw/y6uAgT0j75TVtf1X
 cmXz/PVhIm1+77/AGRtqnj4AAAA
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
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VE1PR04MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 31795a40-8646-4885-5045-08de84acabce
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: yOgVy9EdQN0Is1VlcCVs0gwKOkHXcrizpgoXMuLZu3hvKXf14+CagQhyVo9SqBwJRTqF46qmBkmJstXsSYRv9k7Jf9cibKCb1Rv9/acSFhsBqOj9fgvepRYu3stfG1r/EPvg90JmIkI6/FAxv+98JeNfGDW5FnQgdxEnpNkq7cX3JaBznMNtQz17ONFGs1WndQZOWOW5pAOcl9kC1FXqtI2VHWdYpJQVzgQEnKOIlQfzTjYnk/+JO2BY67uK6P1yhvO+agNcqpFDkv3k4XMBUkUUdWE2ryJahBsVO91YNyt7Mwbx5l8B5Il8fZJTi3/ASfF9bpVZBBZZ73JOi86SRYjmprwq8/xe/a9FeuRB/y2FMB5sa45W2YKr4tkLWldOXZ3hVvJAIEHFoBpgKHTouvZgP7sqyVkizytQB0JSyh9+7Y8HjN/G2hNsVdAF9uxRzvrL17XLid6wGmJnzxGAKsQ9Htynhg3MV+o1YzetnRCbFM9wugrTIVUCmU387TmMOZn+TOHNHUmWixOveK33SvXDE3kIGbhGvObHvBqREcorDEYjZ+5qZJHCYchFVOyntMR7aGapgPMYXRMNCzsDdtETeLeijRtuP2OHZnLfccv0n6vhTF2KDq9PkqpZ3m3kTB8Fw/Lc+f8jYi/JndZfmFhGGdeXQmPErX21iFBLqO4vVnLasmb/pxX8O//lFTTFA5bzSSZWXNkDQVPO0xaXJ4pxIVlwLD0hthmbl3om+gqyQr6hI3Ektn9c69jOnbmyjlSTCMPwYEWOhU6JKaJ3QJAnKeME8d6mAAoG4ln8QEs2QuluRovgHAUN95DrnOKg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDhPMDg0a29GdU1zRWkyQWQwNisrM0JrKzNvVkdKNmFxN2dGbTd3UVhBQitN?=
 =?utf-8?B?bWZpQU1RcGhFSkJ5Z1U5aUwwb1lyb1JFQjJaR2xtbk50YTZUcXp4SzdlZUR6?=
 =?utf-8?B?Q1NTS0NaVmh2YThKS2svRi9rSzZWb2QvREpPYkRJaktOZVNKbDBFVk5EQ1lC?=
 =?utf-8?B?bVFNZEdxbXpsdHBuQ2IrQ3BibzZQSk9nSkp4d0hwRHFJcGUyVURrcTVkOUVE?=
 =?utf-8?B?VUxUcGdPdTJoZVVwRkZ0YmpsWFpZSlNhZWhLTjNqaVQvaVl4Vy9wMGFIMENW?=
 =?utf-8?B?eGlNZm9Vd0x6ZGYyT0crYzNvcWhVYytxNHpsUTV0MWVaNlJsRDQ1WFhpeU95?=
 =?utf-8?B?YXlEdTZnaDlnQW5XUGNxYzdJQ04vczhjd1F1YW55SzRteGtGdFUxNWh4aVlD?=
 =?utf-8?B?UjhvZG53eVVhSDZ2dTA4UEcvVlhTRTIzb2pYeHIyd09vNis2Skx2N0crT1N2?=
 =?utf-8?B?UHJJa0tPRkNMZHN5WTFXZm16T1R6RTJTZnpJaXZRbjZwS0N6aENRSE1nQ1NM?=
 =?utf-8?B?MU9aQWo3Q1Z0YjE0NHJlQjkyN285RGpNcjZKQnp6aUxPSDR6M2FqM1hwVlpm?=
 =?utf-8?B?aVJYejR2b1pMV0FUQ0lMQU9WQmpkNzUycDJzZWV2WDUxeTJiTTNacXNWRTRK?=
 =?utf-8?B?bENBbVZReEY4d2hERy9CMzFkSFBoRmt6dm4wV0kvZTAzR214NC9TdGF3S1dN?=
 =?utf-8?B?QjhkaGtVbkJCdG1BT2szei9RbThHSHU3UEJ4THBUaCtQK3V3NVMxZXBFMzM2?=
 =?utf-8?B?Zm5XeURXQ2JkUG01NE9GcTQ1Nk9EbTBvYU5Ud2huOTNFVXJBdU9lTS85SEcw?=
 =?utf-8?B?SHgvRVZhK0wrSzg5L2JBMmNYTlFZbkx4UkpFVEN6cmZ0TzVTZnRWaUFHMlUv?=
 =?utf-8?B?bjJ1bjJURTBTUitES0JHb1Fjc2ttNURwRllLTnVTVmtINmZCZE5BaVJ2Nkpv?=
 =?utf-8?B?NHUwdndNa3ZiWTBrMXQ3RmZ0Rkl6ODdGT1FTZHhzTFR5NU1ZOThsQitSMUVa?=
 =?utf-8?B?d3NIK0NSQ1JIL1VaMUJ3YzZRZ1hPNjJJL2l0UWwzcEtXOEwrWmFuampabHBM?=
 =?utf-8?B?Z1NwbEFEd1pUSE9oUW1QTzFlK3RHKzVSV2pRZG54TmFsMnkzc2F0UFVWL0Yz?=
 =?utf-8?B?K0RMWGR6WjRZTjZJMGRnZkVtWG5vMTNQT0ZXWFR2Y3pHRFF0MDg4TUx0OEdT?=
 =?utf-8?B?d0F1UmozUEJuRlBleURraUhWcm1EWGxqN0JKLzM3MXMwYWRObHl4SGZxR0th?=
 =?utf-8?B?aFZBZEo1VFRyVkt0dUJuYjhqTVI0ZmtyaWVoNDg2dzNWM1BpOXBvYVNwMSs1?=
 =?utf-8?B?YmplTVJ2YWJXWVB4TFpMKzIzbGIvSzJTTU9FeEc1TkIrcGV6czMxTWMvUE01?=
 =?utf-8?B?MmxjSVJraXdzS29JbE56bjE5akhnNS9KenUwaXBVT1ZCQVVoRDNIMVBQNUU5?=
 =?utf-8?B?MURKS2lEelR6dUJPUGV2UnBOQ1BmZW41VklZNGkxN0pMVUJDNThUODRRUjJu?=
 =?utf-8?B?eWtxSGNlNjA5YXhvUEZrZXlpR28vNEhjd1FTWXFuOTJzSGdPU1lEODk3eTRF?=
 =?utf-8?B?ajE2TmQ0Vjl6R2d2MWJiOGg4NjlaYW83ZjdzQVV6cURWQldoK2ptQm41Y2M1?=
 =?utf-8?B?VzBKM1h4eEpveTFNY3p1ZXp2WkJDQU13WWQrSmd3MlkwZjVuTWE4L1JJa3l0?=
 =?utf-8?B?YndsbHVzRno3dTRrRzlZeWxlTERhallaQkZsSlA3OHJXRjFITTB3T0sraDFk?=
 =?utf-8?B?ZFM3aVJ6NFB6ZFl4ZUc1bGl6TmRUTWY5c1cvNUJ2TUpzWHFkVFh6TVpRb0I0?=
 =?utf-8?B?OW5CdWx3T1FJdk01RytNVWc1d1FhQ2l6WWNPRmVSYnh5bk12NEp2L09RcmFU?=
 =?utf-8?B?aWNHVVJUYUZLTzNKQjNLTkEwb0ZuZXFMVDg0QzNxVHFKbEM2WElJUFgzZGg2?=
 =?utf-8?B?VHNzZ0pLRHhPdDFrYkRGcGFuZDBnNDZKYjF2MnQ4cVM3T0I2NS9aSzc0dE16?=
 =?utf-8?B?YXpIdGpwL3NlNGNHaHQrS1BuZHU3THJwWHpqcVFtQUZTNDZuYTdrVDlFb1o2?=
 =?utf-8?B?dUc4R0VPK09tT2tNMloyZUZrK1JrWkRLOEZIWmlMU2JWYnVSOEM2RldqYWN5?=
 =?utf-8?B?K24wQjlXN3ZpVWcxRytIWjRCQkhJbFlXMGNsL2R4Z01YaHJITFVhVXcycDcw?=
 =?utf-8?B?ckpMSURHd2RHcWpiU042a0dCNGJwOUprZlhDT3pnYndIUDdOeE93RVBaeEVQ?=
 =?utf-8?B?bERlVjNRTkdrWE03WFJVK09GTXFvN1RFdzZFMTJkenhJS2lkMnN3aGFtTXZH?=
 =?utf-8?B?eDNBcWJWRUJQbWNETVJzZlgrU0F4c3lKZWNKMnNIY2R6bXpYYkZ6UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31795a40-8646-4885-5045-08de84acabce
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 05:10:28.6234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bP3122OQOaAAUTdD6FPFSQzthKKPCw9vey8NXC6eued5VEDAQxuxefmDeJU6VTQ1ZspZUAfbLvxq7AHGsXz52A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7309
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
Changes in v2:
- Improved code to manipulate cached refcount.  (Luca)
- Dropped boilerplate code.  (Luca)
- Link to v1: https://lore.kernel.org/r/20260312-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v1-1-b9ba3d844732@nxp.com
---
 drivers/gpu/drm/drm_bridge.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index f8b0333a0a3b..dc478a9190f5 100644
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
+		--refcount;
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

