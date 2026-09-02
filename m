Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0B2C624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D3A810F3ED;
	Thu,  3 Sep 2026 07:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="kzVIIwmh";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB4B10F1CC
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py7zcEBIwrIX0kMN41ASrUHYO2UJrsbgGdBcbDydqoGW8n19Dmgo9JM94WUSQeOkoF+GbzZWwkekTyvdhV0VfQjtRh/ou4TRh8o+n8V86c1UBUvvCQ/l5InyO8Acr05VFwkSpwYlvWwUgOsm9AIzXuKAky/sOXQX5owExRDK16qfpRuyeab0V5tHqcHxZnn2q6tPggi94THQFNGW1tPADpbe5X/mOs7Of/YROj8XCEYY6sQbUX7U3v0pxnANMER5FwjlgQp+Zmx/tnUXmGUssoP4Qxb1JtH02+eMnahbN8Zf66YcMJRkT1kf90j0QtxFMnBaNqvhpHTuJu3wQ9szEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v0ZGbTEU8MTehrYpqFaIAFAhHuVbtcXKNj6VwasCBU=;
 b=kfH5QxssudhLXWOKbSipbqeGYnXv/K+eAVRwq1Sx2bLl0n9wdB0x0QUlDvAvxxEGCGpVCdZSipYyK1CFtQFCe8nvhLpB6Yin2MG4MZVyfWsEN4xivAJTZ4hW9o+Dfy4QIXtO3kwvsAdXk+dFZCB3XbWHyFZdHiC4kVXsBwd4pcHT/Xbo+xoATknULcKW7Pgj3/tO9bJtq3Hajc9tpu++Jt74zEo3Tluy5GkLTPFGxZtkaqCFZaVv1eDiqVFfHmHFNZ/zi5clQhzlkF/YfNiYKdQ7COLid0S3v+znRTiekxi74c8MgwSmbKOt/B6ruXtnwHp7K2b9CBwWzG/XAyjdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v0ZGbTEU8MTehrYpqFaIAFAhHuVbtcXKNj6VwasCBU=;
 b=kzVIIwmh654vbZt7oS8PPkwpxTtbb3/OgN3Ap4YssGxKUHpUoM44h88h02DH2Oqy8odQaaeFIKKq58XaGfQKr9KFM+u47rJ4JydOgVo+B5NwPlZpBGFXRknJd/NnMMPht3JuDUukMimtz6JEWKHx5gpZbDKvFTlU+xBW+4Kre8Zypp3O4bZL82faogrxqPDjSsp+Y81fuicgwf+6dxK6x1aeA3AVorcjZkr8aGfJrelPb+mypfbMgRqnGVqqRz02SdayP7kTAiAdZ94eLin5kQwzCmnNjZTCFsSNGEsK6EWwGgg9ECdoYkwf+8Pu6WioEfi9waafVt5qGUQcgACoqg==
Received: from MN0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::30)
 by LV3PR22MB4766.namprd22.prod.outlook.com (2603:10b6:408:1d8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:01:24 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::80) by MN0P223CA0003.outlook.office365.com
 (2603:10b6:208:52b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 13:01:24 +0000
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
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:01:24 +0000
Received: from zeus.fihel.lab.ge-healthcare.net
 (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id DE291E4DB;
 Wed,  2 Sep 2026 16:01:20 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Cc: Ian Ray <ian.ray@gehealthcare.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: display: synopsys,
 dw-hdmi: add ignore-rxsense
Date: Wed,  2 Sep 2026 16:01:13 +0300
Message-ID: <20260902130117.2731-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|LV3PR22MB4766:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c05828b1-486d-4648-fe08-08df08f24b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|921020|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 4MXCQncG3HQ/Xt+ON4jyA1OPvNb+0xpCy2yFrdo1MtAfILW7KWLQWi5iLMDkkvAu3Z2tgFvLjfQJA+uNNpbVO5QZuBN1Y2uxbImgcv7QHg4UaRVTe9d1L/kXjDePKMfhkT2MH+mynU4r/pRpomwbwrAhVS4vdBb+Dz9zQ5r0AL8WUebIG3iUjk2mOnsLTTHBS4MpQnEL0XsI3jYtiVsiJVFoF0LA/7QnivV4wOnKoQaEmQvJYR+31Ko6CHoySwCMdVqlJFz0349nyOCIdgwEsXFcZVtcZ/SYSHjytKDiT1mBzKXes7pCyOBazhHZIh9qHbwASA5HL3bWudtD5qi7J9Pj4tbtZW092use9BqgmqMHFy7DRxzvauceiYmuAmVzNeIftzw0xZcl8dzqw4Kx04FM46DwI3dkH6XNAV6kH19ctju9AfafW4nEMX8EFmEaD8cD0KIGAcZW6GZ0kJ3vWzz+f+jFz3s8fxi8QpW30YKZTgcqvUciY6ReSUhZHWL3QwVySRFzbDv2IJx0aqrN6qy/TTsNiH+x34O8lljQYDBRc82TZXlleLOzW3d7EnmLZt68NTxN1JheitZNTGUsv1wJtR9qMYGivhYa8/Gr0KcWjxbMXi7tc+oJt31fzopeqUO9TkCLf9QhZBpvaJ3gjSJnifSJZIptDjl8oOxBNXiTByrqddnvYP7lXVLTOFST8PnQiOC+2OgVYXL8DxMiYWJ28j0NFAghhkVqmMqQ4KSWOQOLsP3/m1l20v2LnqIG
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jrI9IIbWFfmqvhcJL+DtZ5SYfH0GECQ01hl5X0JX9IAK6U/r2b7vg2YMVj+Gr1jey4MAJYLz7GeXQqh7lqGCceINRuzV+69mPzFkLvFhMt3e/WLe5jNwl2HzF0Di4VHW3ApvQOfVo+oz6jU02jrHTZyn9WQV0afEuVkEey1IL3FYwUBvlhz2LuX1Kd/2zpTIMvnv3d1AB7iJEMJex1dK2CZ5vx1cQ8NOxclg4pDEo9vhv6GnwoWvwXhVrSabwNajQonlIkvLpEV6op+u1NeoKW0TuprPONd7BFS98ENoRsBwF+WZDQ3J64poVbwiENFHliUBz3bmDmDPpc/GLE1u9wO+97iCzfmm1URjz5+V7Sg+8wS63zcxk1/YJ3ZOXmfd2TzewomNEazcdfoNHH2SlxASSH10O5zhqrm2VhEh5XL9QAL0Wl9xcAdKPdirmCdr
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:01:24.6010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c05828b1-486d-4648-fe08-08df08f24b46
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB4766
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

Add a new property to ignore RXSENSE during hotplug events.

Fixes: da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event on link change")
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 .../bindings/display/bridge/synopsys,dw-hdmi.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
index 33481381cccc..0f6e4dabe11d 100644
--- a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
@@ -61,6 +61,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  ignore-rxsense:
+    type: boolean
+    description:
+      Determine the connector status from the HPD signal alone and ignore RX
+      sense. Set this on boards where a downstream device (for example an HDMI
+      to DP converter) keeps the TMDS lines permanently loaded, so that RX
+      sense is always asserted and can never signal a disconnect.
+
 additionalProperties: true
 
 ...
-- 
2.47.3

