Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7C606A9B6
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GWZ26DBf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB16510EB33;
	Tue, 10 Nov 2026 14:28:12 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68E210EC53
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW+d2ybiDKsttpPHCh77feAJkKcMvA4xeD/GPs+zN5Y3RPbaBHscBkzFMlUkRDVkQKogKTArUP41MUxxny1o/lgst55kmV6aCEEPQXIVWjT26C5rBQys2Y3u/BqFBaROSLCTPdQd2ZxwyfY4zN/CFYludFzWBQxUyHAZt9aHj4nLDaenZQhrpVZ7SEaMHELSUtze/74jQg5NMjgwtgaZukkQeE1aE9rhZ5isSEK/vfnbIwkarX9CvJJR0hAptlgmpYHAc/HpjdyEeRazrtaUbKEGx9I1yv/r6xMtN7CbxHerbjlsPxvp00ayuIJevZAvMZmhFz5rG0/mXxUwq54sKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp5l9fgTl2d8kMs9ST9wroapwaoIKb0B7eolEACVYg8=;
 b=ZXcSkhvOqN6bGwqQd9AMvTLDQBkoT3zaFdq8hSc6iMVclVNklguCUAyCySZ59c/Wi2CwDBfGGf/iB+7rsh6xC7QkAakG5HU9hyP6RIS+4a9Rh8KDQqThZBSb/8Wvya8ujASNERg/gT+Yq+HyH3hKKjm7uzclpwgm0yBMAAvAVnGN33vNldRooJHI1emFGWcMF6yovFlydpD+3xLCJ6CiOkKci0lWg3ZP6DYHNbzepnZ1qn4abFPYHSNZLK8ot7vh/HlPHZZxu0ShmiGj8oJUp+zwuVjluljv5nIUUOhtAbJThEOs/Sq/PvV42lLEPpeEkVwuKcRx3us4JfvMG5IB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp5l9fgTl2d8kMs9ST9wroapwaoIKb0B7eolEACVYg8=;
 b=GWZ26DBfE2yaTrKxFv6HsISVIvd+Bvpe93BxJPEqgkuFxMzEs0+3OP6m4Y4XGmSbi6mhfG/IBTHZRrr4MspOO8zaz6e6r/xFy884v4uaELWZ+FlIxnU7RF+8GRde7rvl1JSvd1MD8s0OBFl8/odiazr/XmiIt0VIV/F4Mg/QHjcoSolQB5Za+Y3OV9vlgWDL0WnOd7GK0eYPdobdAsMdCkb8aKDL0At4MQd7LqnRIVZiRU4dIgH/S9z+T0OOZhFZ/ItitqT6bZvMOlXWFt7udhmrvxOazCHCTWoE+Fptcie0p7FTLVan+aQEWiwfPd48kwm0aAIN6B2A7pLpVMAoPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by VI2PR04MB11196.eurprd04.prod.outlook.com
 (2603:10a6:800:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:27:58 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:27:57 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>,
 Marek Vasut <marex@denx.de>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v11 0/7] Add support for i.MX94 DCIF
Date: Tue, 10 Nov 2026 14:27:40 +0000
Message-ID: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260602-dcif-upstreaming-fb177f3c9351
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|VI2PR04MB11196:EE_
X-MS-Office365-Filtering-Correlation-Id: be8b0c40-6f38-455c-2529-08df3f36d0d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|921020|260925021911599003|260925021311599003|260925022911599003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261009221227099003|261102123227099003|261026140227099003|261022075727099003|261026121527099003|261022113327099003|261022105027099003|261028144727099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: KalJNJ3qK7F3sxULX+X/GLHCQh6ToDRMJGuUzooDSciGpYw8XhRXNdLrxlwf3BphrK/PFWKj1rfmX3brjn1CV/AUwpa36SdqtfpLEW51n4UhZj3/YRt1tYd1EW57i08xwDjahHC0l2+sm/22kYqcV7bBgGkFlgtuX++fmwdCcqyHD+jnFm6FRHj7xJJmDet9e4rEdADTrh4x9DMFVaIg5ZeYuKDy1Te2S2XqVp8+qJnVIVwCk9i0gmDpGnL7CQqg1tbkuwL1dXeb56ViT9FJWoVBypoVXR2MZ4KgvyGJTUo+MbVU756rAk14sK52+zlCEXnce8dAw3Ng6E06KdD731kRUgImkK1PWc4O9GzamndDKYm6Egq55OCf7s/JOP1m/EHzT+N+0QjvcNWCwk+RQDJfzTkjKfPuod4HRGg5374T9dp3ZOKthRo4syosNg4/F+Pd0u2ttBwPBiIrBiGE5VhttF9byIuXFPcdZ/S5lTAkz5eSEBQ98dM5K9kDIvfAZKVZEmYr4lOdP7psqim7lFFGP8u9b4hPLHg85nf9w7WUfQcJLzM2n31YOSPofQHVoCH8Sd7/FtuX/Y9iFQoQRqjbiNg+c9mRAga72u1/gVUJNudzZlkBTM2Hxm0/dsNAhFLSpJuu0VP6XBm8ZF8HUYKOSpkN+MxzCCLAcYcP6eE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(921020)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(261102123227099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022113327099003)(261022105027099003)(261028144727099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRHc0VucU9uelN6SkFGdkZJMHdSNVlvUEVDODFJOWg0RUhiYlFHTHRhenFt?=
 =?utf-8?B?TlEvTUU0WmdrbkdYWWJETnNBS3JTUXlCWkFRa1dUdEpMSmwwUXdVRHBVaE1u?=
 =?utf-8?B?eGVzWCtXaHQyYm5YKzdlMWx4UFhVR2pIRjJuVFdSOVBrNytROE1OdVVaWlNP?=
 =?utf-8?B?ZytnMjZ2VXVNSDZycWg3SWFiNzh1cXVNNFVvZ2h4bnBMcXpuMHNhRWxzdUNL?=
 =?utf-8?B?WUl4TzBvYm5udGZHeVZBUnF4OXBlQThja1dEelVXRlZxL0ZZZWRzL2VmaElx?=
 =?utf-8?B?TVVMWEhiWlFLL1A1bVJPR0J5NlpMVnhjcHh3TmVjZ21ILzJWMFJXUGdGS1U3?=
 =?utf-8?B?c2N5c0xQa1dPS2x0WnZId05lOUlnQmFnd2RWWExtNElEZHlWSDRLdW5HaGU5?=
 =?utf-8?B?cnZZRTV1aGw2OXFrcXBCMXNBcFlpYVlGb056eCtpb3VteXQzblMzbzVCTUVZ?=
 =?utf-8?B?eDJhYk0xSU9DWmpDSW85TzlqUW9xcTQrb24weUg1dnVWNVQyVHc1TnZUcHB2?=
 =?utf-8?B?aEZCVE5FaXpnZTcxNEFoSHpjZlVxREZkWEFRYlJqc2E3WVZ1WTJKQS8zb0wx?=
 =?utf-8?B?WkhkTVBNdkpnajA1eGV3YkhwQi81NWZpY1d6Y01DaDJDVFAvRUJWRHN0UTd0?=
 =?utf-8?B?d3NtWitidHF6Zm9Lc0JGTzg2OHZtZlJEMGxDYVBlblBVVk1OUWtoejZxeDF3?=
 =?utf-8?B?bmQ3Yk1RSGg2eFo0MG5CRndvY2VkOTdhWldoaFBXSU9EWFcvbnl3L2VpblBV?=
 =?utf-8?B?ZmxxMXNwWnkxOUxMcEp2QWV0SW1jZUY4eUtHWE9URUEyRXBwUFIvQ3F0dm4v?=
 =?utf-8?B?NkxjSE1BTUVLVjVybzhXZWdvU1hkdDFiRHFLaGthdzJoRW1qNDdSSjRvcUIz?=
 =?utf-8?B?aDI0eEdidWJTMngzWkdSZWNKUWRMcW96emFURXFQQ2R2NEZ6VzFzRllLZlFZ?=
 =?utf-8?B?T1lRWGFkTEFTSmZEOEFYRkYvNTJ3MnU3WjV2SkNzc3dkY1pOYnpPK1ZpRnpF?=
 =?utf-8?B?RXpwallLRW0xYnowT1FqVk4xclU2TjdPMnRXalcwN2tPRDRWczZ3a1VvQzlY?=
 =?utf-8?B?OWhrd3VNbzdmR3ZHdHR0bVIzUXpwMVdYWkxMSGl4SVZmNXpQTC9PUDlLVUNM?=
 =?utf-8?B?dzFWazJ5MnVEVUdyTlNNT2xCSmR4UXdxSlFjNkgzalIySlJqRWNUakVOUDQ5?=
 =?utf-8?B?NkJ5Z3ZmVzNOYXE4UklhMmwyTWFEUXdSMjJzN05UTXE0Z0Z2YkVaY3BHaHMr?=
 =?utf-8?B?TmNqUVRxU2VERW1GdmhkdG9hNGFRTzhxTFRpZ0thWHplY25LQlZqNEhuYXAw?=
 =?utf-8?B?c3psN3dnaHBySWJ2N2tNWnhBUE45R1B1dm1IQ3JDOGs0eVdhWS9ZUzhwRWpq?=
 =?utf-8?B?Y1kyd1JaTnV4R1JNcytjZkc3cDVIWWQzQTU0TDFNM1dwMWx0MTViaFJiZzRI?=
 =?utf-8?B?YjhpazZlSS9wUmU0ZlVDc3I3Y2RwSCtzZThQb2gyN2VvWlA2clh2T3NzR3JY?=
 =?utf-8?B?R2RJTlNydHViR2ZNdVY4SkIySC93Z3kyN29RdDk5RmNJaXowN2JiaFBnUEx4?=
 =?utf-8?B?bDJSSHFKVXpKRXlXbTJrZUFGbFgzVVhGSWpxSVVha3NieWtuVUQ2eDZ5dXcy?=
 =?utf-8?B?TmlQZmJYeFd4QU9DbzhaTzN0Z00rd1BEZlQ4dW5hSHFXSVJiYno3TmI2SVYw?=
 =?utf-8?B?bFliUGZIcnA3a2FNV2JuTnl3NjVOZnNYVElaNHdhenR1REVwYm83MVE1Y0FF?=
 =?utf-8?B?dzA3a09sYUhRMVNWTzlzb0g2a3JUR0hxY1hlaXg5VktsdnlsQm5FajhMUERF?=
 =?utf-8?B?QmE4YVJkYVg4eXFiN05QTWNpMlN1TGorbUs3c1NDeDlhQVhTampQa1pDTWsw?=
 =?utf-8?B?QkNJREVEcCtWYis0NTdmYXh1clliMHBuMk1zbXhsTFRtaHplMm8rY3VYTUdF?=
 =?utf-8?B?bFhxaG93ZFA5Ym9jcGJEVGFuUllJcTdkVFdUOHZWWGZhUmZOR3ZCQkZvZ0lK?=
 =?utf-8?B?dFVYS1Z2WEMrL2tvVmltRFg5MFVZaURFdHAvOW03eWM5NjN4LzYyM0VHUEt5?=
 =?utf-8?B?WTdnL2VoLzVQVE1uYXYzdVRQQTc3MzNZUHRCN0xVWHhIK2tvQ3czYnd1R0Ex?=
 =?utf-8?B?dFVYMys2TS9BZHY0cnlGbmpiVXUwMWVzWC9KcE9kS2F1NWMyWkUwNHQrWmtt?=
 =?utf-8?B?M2x0dGlPMVdXbG4vODEyQXFEWDRuVHVVemJFN1hYb2RUSmJtbE9kTktuMm5Y?=
 =?utf-8?B?L0ZaV2hKcU8ydnBFczFYb3dGSFgwUlhqd2Z2czM4UjhlNUxyNE9PdzZKOG55?=
 =?utf-8?B?dkdQNVIrbC9FNk1vYnNqUWpqQlBubmxRMU55TFkyVVE3RjMrTnFZQmJqVEg1?=
 =?utf-8?Q?1Cz5DooYQsuS7iJs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8b0c40-6f38-455c-2529-08df3f36d0d8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:27:57.6889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FR3yP49ZAj/04Z/Pt7Etot5kRDUpu9bCannyBfDBnOxje0qeHcpsvaG6tCFxmn5TLOQcBFNdQb29LgPqVbA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11196
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This patch-set adds support for the i.MX94 Display Control Interface.

Also, included in the patch-set are patches that the DCIF driver depends on
for functioning properly:
 * 1/7 - 2/7 : add support for i.MX94 to fsl-ldb driver;

Thanks,
Laurentiu

---
Changes in v11:
- Rebased to latest linux-next (next-20261109);
- Dropped "drm/bridge: fsl-ldb: Get the next non-panel bridge" since the
  driver already gets the next bridge after upstream commit 802372cf316a
  ("drm/bridge: fsl-ldb: don't create a panel_bridge") (Luca). The
  remaining cleanups suggested by Luca were sent as a separate patch,
  not needed by this series:
  https://lore.kernel.org/r/20261030163254.3175671-1-laurentiu.palcu@oss.nxp.com
- Dropped the standalone MAINTAINERS patch. The entry is now added
  together with the DCIF binding (3/7) and the driver (4/7) to make
  checkpatch happy;
- 1/7: No change;
- 2/7: Collected Luca's r-b tag;
- 3/7: Add the MAINTAINERS entry;
- 4/7: Program the plane registers (format, size, pitch, base address,
  layer enable) only from the plane update path, no longer from CRTC
  enable; arm the vblank event with drm_crtc_arm_vblank_event() in
  atomic_flush and drop the driver-private event caching, which fixes
  the vblank refcount and early-event issues; on probe, mask and ack the
  interrupts left enabled by the bootloader, and request the IRQ only
  after KMS init to avoid a NULL CRTC dereference; dropped the unneeded
  mod_devicetable.h and drm_fb_dma_helper.h includes; style fixes in
  the of_device_id table and platform_driver initializer (Uwe); follow
  the reference manual software reset sequence: wait for the DPI to go
  idle after clearing DISP_ON and hold the AXI fetches (AXI_RD_HOLD)
  until the pending reads are done before pulsing SW_RST; stop the
  controller at probe if the bootloader left it running; add device
  links to the display CSR and the LDB to enforce the suspend/resume
  ordering, which fixes a vblank timeout after system resume; include
  <linux/bitfield.h> in dcif-reg.h; in mode_valid, reject modes larger
  than the mode_config max_width/max_height and modes whose porches or
  sync widths overflow the 12-bit DPI timing fields;
- 5/7: Renamed the 'ldb' child node to the generic 'bridge' node name
  (Conor);
- 6/7: Renamed the ldb@4 node to bridge@4 accordingly;
- 7/7: No change;
- Link to v10: https://patch.msgid.link/20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com

Changes in v10:
- Rebased to latest linux-next (next-20261005);
- 1/9: No functional change;
- 2/9: Switch to using of_drm_get_bridge_by_endpoint() helper for
  fetching the next bridge;
- 3/9: No functional change;
- 4/9: No functional change;
- 5/9: Fixed a pixel-clock unit mismatch bug, ROI now derived from mode
  at program time, CRC reprogrammed on ROI/source change, bus-format
  validated with a whitelist, forced modeset on CRTC activation
  (dcif_atomic_check), vblank event flushed on disable to avoid hangs,
  dropped PREMULTI blend support since PREMULTI is not mandatory anymore
  and the display controller does not support it, probe error paths
  checked, shared dcif_set_csc()/dcif_plane_disable_layer() helpers
  introduced;
- 6/9: restructured to reuse the existing conditional schema pattern for
  the new nxp,imx94-lvds-csr compatible, instead of unconditional
  properties. Dropped Krzysztof r-b tag as it needs reviewed;
- 7/9: No functional change (context shift);
- 8/9: regulator nodes relocated/renamed (reg_1v8_ext/reg_3v3_ext ->
  reg_1p8v_ext/reg_3p3v_ext) to match existing naming convention;
- 9/9: No functional change (context shift);
- Link to v9: https://patch.msgid.link/20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com

Changes in v9:
- Rebased to latest linux-next (next-20260611);
- 2/9: Reworked to store the next bridge in fsl_ldb->bridge.next_bridge
  (taking a reference with drm_bridge_get()) instead of adding a new
  dedicated field. Removed the r-b tags for this patch since it needs a
  fresh review;
- 3/9: Fixed the i.MX94 LDB max_clk_khz limit (165 MHz -> 148.5 MHz) to
  match the actual hardware limit. Removed the r-b tags for this patch
  since it needs a fresh review;
- 4/9: Added a 'required:' properties list to the binding. Removed
  Krzysztof's r-b tag for this patch since it needs a fresh review;
- 5/9: Renamed the CRC source helpers (dcif_crc_source_*) and made them
  unconditionally available, dropping the CONFIG_DEBUG_FS stubs;
  improved CRC source parsing (auto ROI for the full-frame source,
  unsigned params, safer string handling); rebased onto the
  drm_atomic_state -> drm_atomic_commit rename in linux-next; reworked
  CRC/modeset gating with new has_crc and crtc_pm_enabled flags and
  proper PM error handling; switched event_lock to spinlock_irq; removed
  a redundant connector-attach call and fixed an error format string;
  added new pixel formats and full alpha/blend-mode support;
- 6/9: YAML quoting style fix only, no functional change;
- 7/9: Combined the former "arm64: dts: imx943: Add LVDS/DISPLAY CSR
  nodes" prerequisite and the "arm64: dts: imx943: Add display pipeline
  nodes" patch into a single new patch targeting the shared imx94.dtsi
  instead of imx943.dtsi, removing the dependency on Peng Fan's
  not-yet-merged patch;
- 8/9: Renamed the IT6263 bridge node to 'hdmi@4c' and fixed its
  reset-gpios polarity to GPIO_ACTIVE_LOW;
- Link to v8: https://lore.kernel.org/r/20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com

Changes in v8:
- Rebased to latest linux-next (next-20260303). Patch 2/9 had a minor
  conflict bacause of a patch introduced recently;
- 8/9: Fixed CHECK_DTBS errors reported by Rob's bot due to missing
  regulators. Removed the r-b tag for this patch because it needs a
  fresh review;
- Link to v7: https://lore.kernel.org/r/20260122-dcif-upstreaming-v7-0-19ea17eb046f@oss.nxp.com

Changes in v7:
- Rebased to latest linux-next;
- Addressed some new checkpatch warnings: kzalloc -> kzalloc_obj;
- Fixed a couple of static check warnings in probe();
- Added Luca's r-b tag for bridge refcounting;
- Link to v6: https://lore.kernel.org/r/20251103-dcif-upstreaming-v6-0-76fcecfda919@oss.nxp.com

Changes in v6:
- 2/9: Collected r-b tag from Francesco;
- 3/9: Removed ch_max_clk_khz variable as suggested by Luca and added
  his r-b tag;
- 4/9: Collected r-b tag;
- 5/9: Call drm_bridge_put() automatically in
  dcif_crtc_query_output_bus_format() by using a cleanup action (Luca);
- 6/9: Moved allOf: block after required: block (Krzysztof). Collected
  r-b tag;
- Link to v5: https://lore.kernel.org/r/20250911-dcif-upstreaming-v5-0-a1e8dab8ae40@oss.nxp.com

Changes in v5:
- 4/9: Removed "bindings for" from the title, changed the port
  definition and simplified the example;
- 6/9: Fixed the way 'ldb' child node is declared: declare the
  'ldb' child node out of if:then: block and set the property
  to false for compatibles other than nxp,imx94-lvds-csr;
- Link to v4: https://lore.kernel.org/r/20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com

Changes in v4:
- Addressed remaining DCIF driver comments from Frank;
- Limit the 'ldb' child node only to CSRs compatible with 'nxp,imx94-lvds-csr'
  in the binding file. Since LVDS CSRs are a minority, I chose to
  use the if:then: construct instead of if:not:then:;
- Remove the '#address-cells' and '#size-cells' from the ldb node, in
  imx94.dtsi, as they're not needed;
- Link to v3: https://lore.kernel.org/r/20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com

Changes in v3:
- Removed the BLK CTL patches and created a separate patch set [2] for them;
- Collected r-b tags for 1/9, 2/9, 3/9 and 9/9;
- Removed the DCIF QoS functionality until I find a better way to
  implement it through syscon. QoS functionality will be added in
  subsequent patches. Also, used devm_clk_bulk_get_all() and used
  dev_err_probe() as suggested;
- Addressed Frank's and Krzysztof's comments on the DCIF bindings;
- Addressed Frank's comments on dtsi and dts files;
- Added a new binding patch, 6/9, for adding 'ldb' optional property to
  nxp,imx95-blk-ctl.yaml;
- Link to v2: https://lore.kernel.org/r/20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com

Changes in v2:
- reworked the BLK_CTL patch and split in 2 to make it easier for
  review;
- split the dts and dtsi patch in 2 separate ones;
- addressed Frank's comments in DCIF driver;
- addressed Rob's comments for the bindings files;
- addressed a couple of checkpatch issues;
- Link to v1: https://lore.kernel.org/r/20250709122332.2874632-1-laurentiu.palcu@oss.nxp.com

---
Laurentiu Palcu (6):
      dt-bindings: display: fsl,ldb: Add i.MX94 LDB
      drm/bridge: fsl-ldb: Add support for i.MX94
      dt-bindings: display: imx: Add i.MX94 DCIF
      dt-bindings: clock: nxp,imx95-blk-ctl: Add LDB bridge child node
      arm64: dts: imx94: Add display pipeline nodes
      arm64: dts: imx943-evk: Add display support using IT6263

Sandor Yu (1):
      drm/imx: Add support for i.MX94 DCIF

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  24 +-
 .../bindings/display/bridge/fsl,ldb.yaml           |   2 +
 .../bindings/display/imx/nxp,imx94-dcif.yaml       |  90 +++
 MAINTAINERS                                        |   9 +
 arch/arm64/boot/dts/freescale/imx94.dtsi           |  82 +++
 arch/arm64/boot/dts/freescale/imx943-evk.dts       |  86 +++
 drivers/gpu/drm/bridge/fsl-ldb.c                   |  15 +-
 drivers/gpu/drm/imx/Kconfig                        |   1 +
 drivers/gpu/drm/imx/Makefile                       |   1 +
 drivers/gpu/drm/imx/dcif/Kconfig                   |  16 +
 drivers/gpu/drm/imx/dcif/Makefile                  |   5 +
 drivers/gpu/drm/imx/dcif/dcif-crc.c                | 221 +++++++
 drivers/gpu/drm/imx/dcif/dcif-crc.h                |  54 ++
 drivers/gpu/drm/imx/dcif/dcif-crtc.c               | 708 +++++++++++++++++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.c                | 248 ++++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.h                |  90 +++
 drivers/gpu/drm/imx/dcif/dcif-kms.c                | 168 +++++
 drivers/gpu/drm/imx/dcif/dcif-plane.c              | 300 +++++++++
 drivers/gpu/drm/imx/dcif/dcif-reg.h                | 268 ++++++++
 19 files changed, 2386 insertions(+), 2 deletions(-)
---
base-commit: 0941356091e37f268037391735464807e3819839
change-id: 20260602-dcif-upstreaming-fb177f3c9351

Best regards,
--  
Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
