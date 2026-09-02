Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EC9C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 949D710F407;
	Thu,  3 Sep 2026 07:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="ZjUxId66";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E5F10F1CB
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhvjDDpsXYpTzoA41mmUfilY3mqw/bg+AtQiwGGdPIYrGk/aBvKpSxu1vFQfz3PM0DTnFom2ydnZKPU2l1sQIQz8Yz/cMhYN8NFGMGSlchYfffvnfP3qU8CF9oAU36u5XGh5BphExZzTAa9jDOs31ksnDtKcQb5+7KbmF6Hzp+mA59jaX+L848v4Socvk0rnM4Sa2ymdO7D+iwEvHY5yzs1k0qxs47J0cw7mRSSD7wF8O6GF9MClBrZDMA7pLLy3u9n1JSNQXWGF+cCxQ9ge0pwJwAzD2krBMYEiKlgEUPAbFfm41kO9U3y45tPIsJs+BsvtaxOo7vYZpx6+qY8WEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLRU7fz/a4AmTksGXjPumynJ36B37oe4U/DOZBzei24=;
 b=Gm0MhMv8Zx+hEWMikZjD9vzOoAIUzuCGzHdnVHDPhzlxYpby4bjwRI5NVlshMD8z8XppSqSc+Wr3z49RuEnPiiLOh0pNiMdWoRxOJkoWwX0jRjcpA9lY4uFzMlZ4jKTFo780PHJ1h0Yuu0YeHJnYZdh7mkIdI53m76dVH+Sor/G8etoVMd34q6KH8vatqBYKv1/n6S5iIumjkjf97bRQZcORlU+hqG2l7KFxVMHohV0mpXR64QE5YRllpNBckmOPmCKTa43/7unTN6FLB9VbYhsnAXREPtzc6FK/rEIZSF/iCKaC7axGDRbd3lo1cJ+l+1R+Sjkt2EInFznb5mvikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLRU7fz/a4AmTksGXjPumynJ36B37oe4U/DOZBzei24=;
 b=ZjUxId66AgV8rDnyPhsPlNW81ee8W2SK5JksQo1dbaUd/qAuHPBktwgqUM+LwG4BCrP9KVviAQdmdtjuGj28GgWoG8P2EY2ABdS0J9oSEUVLPI2a4HD5nnXh3heiSkbG6haHY2DEOkPuy8DxO5SE5lVSHz6r937Fxu6cUVicInWgNKGqmlgTG+eSkNyKK99ONmjHuA5NCUFAUt8UweZRaBSGr64CyEcD5uzZpOjYgorLzzbnr8D7he0nAHe0taPAXp0ngxPtoqREeR6x4w5a+WoS72h1qfVaTd0G9uHmsRxdYCyov8g6BTitUJOpuWH+xYpV9qI2TTeYvVn8xs8mpw==
Received: from MN0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::30)
 by SA1PR22MB5351.namprd22.prod.outlook.com (2603:10b6:806:3cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:01:23 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:52b::4) by MN0P223CA0003.outlook.office365.com
 (2603:10b6:208:52b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 13:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:01:19 +0000
Received: from zeus.fihel.lab.ge-healthcare.net
 (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 62D81E4DB;
 Wed,  2 Sep 2026 16:01:15 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ian Ray <ian.ray@gehealthcare.com>
Subject: [PATCH v1 0/3] drm/bridge: dw-hdmi: allow ignoring rxsense for hotplug
Date: Wed,  2 Sep 2026 16:01:13 +0300
Message-ID: <20260902130113.2720-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA1PR22MB5351:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 20d06112-139d-459d-dfba-08df08f24852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|56012099006|11063799006|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: mTNhjbwmMBASPzSEwhD3+6IlwV+BKDxtqmkGjmPUrKrbWp8EhBAyzmhlJAqKw8m6IG4dfewogbONDqlx9mwp2vedGRL0HJZNYXhPRcv/q84VPb0MJJmiHn8955HID5Uo9MVIuosoNBNViHCTh2S+OEBV760he6C+vvl3m5G5nEn2B9NUWEHIYiEVAc7i93JtCOOLJoWVZCDlvZgJIjc477AzJMLi4S0XrArzQK0JR94JBRs178MK70KJLy23QJp909l5TjlGYg7M80G7FIA3BLyXrtnmtp6ehSC4Nuj/hfuuVsrp/YJ828hHPAv//OGto9nLF0CdkAxG8ddje6j4e69+AK0Oe89tS6r6E5/x/jvqI+pAXxTyc7RpRs+2cfgEvj9FmUQRZb02YxnBGfLQMyTREYkKz5u3b40TRo4wIv6bRys5AQsMLRhcToZBp8dM1lzhicrv6+BOG/T7v35AkLr8+ufuGpNC/U7R2BtFb0ZkiVXRgvmBE2HdmqfcsrLfarNuUBBjY5q/Jt9TXE/gtP+91XJo79rNZMECT8HKJ0oh1ec9oJAlRUM96w8rTdHHMUbqLI8/GylKtvPeXKniXeHBeNiV+lK+Z31GlheTSaxkecNK1PeA5YcMCeszJBn0uSwhBavg/XKfTotJ/NPq0axJ4W2mEIB9gIt0MXZrxsadI2W4hU3fpk+H4XG0rzpcY+dNwxnD0ixsI54qapAwkw==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X6P1ZwduWhoRkqGj24KLrC9K+cyemgEb0m1DTJOv+Qi1fdO3SkyXUb4lD8WLjdGTmrRWWc6QaUH8rfLT/Eb+d0JxpqvEZoxqJVO/RadzMwRulKgZOHh5hlYyIsUfrAo1OKydMRxoKvBuIZtuWKb8uUN4fa1nta7tC42sb2uraEYL37CpHmqE5q9NAJJzjKIoXTq6kjeX7vYeRxo4IZWkDZTjqVAa6hk1whjhE+d4RymcGIY3a2Gam1s9y94XasYdZQkzHxjH35eENOTe+P2cWoFei0h/d4zoydxnImh+8sWEHvkv5IGYhA2OgkrmtEMu7GMkSMKpda13ogfoc+0lU5mCSGTMhu97mCCwGJcajb6dq8dm4XywEtL1ZdRGx0n2u+VeRQ5dDC91rYhaWqeWyzuPi9WZjzPzOufFBEQoCL1znbjrMzw72sko8RVoGD66
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:01:19.6541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d06112-139d-459d-dfba-08df08f24852
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB5351
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Commit da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event
on link change") made hotplug detection also consider rxsense: a
disconnect is now reported only when both HPD and rxsense are low.

This is a problem for boards that route the HDMI output through a
downstream device which keeps the TMDS lines permanently loaded. On the
GE B450/B650/B850 (bx50v3) boards an STDP2600 HDMI-to-DP converter is
used, so rxsense is always asserted and a disconnect is never reported,
even though the HPD signal works correctly. The connector is stuck in
the "connected" state.

This series adds an optional 'ignore-rxsense' device tree property that
restores HPD-only detection for such boards, and enables it on the
bx50v3 boards. The change is backward compatible: without the property
the existing behaviour is unchanged, so old device trees are unaffected.

  Patch 1 adds the device tree binding.
  Patch 2 adds the driver support in the common dw-hdmi layer.
  Patch 3 enables the property on the imx6q bx50v3 boards.

  `make dt_binding_check' is clean for the schema.
  `make CHECK_DTBS=y' is clean for the device trees.

Note: The series touches two subsystems. Patches 1-2 target drm-misc;
patch 3 (ARM dts). Sent together for context, but driver support must
land first.

Ian Ray (3):
  dt-bindings: display: synopsys,dw-hdmi: add ignore-rxsense
  drm/bridge: dw-hdmi: optionally ignore rxsense when detecting hotplug
  ARM: dts: imx: bx50v3: ignore HDMI rxsense

 .../bindings/display/bridge/synopsys,dw-hdmi.yaml         | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi               | 5 +++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                 | 6 ++++++
 3 files changed, 19 insertions(+)

-- 
2.47.3

