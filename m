Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B01FF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF15210F407;
	Thu, 30 Apr 2026 18:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="js/lhCa/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61DD10F3DB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 18:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fvngzw4JiXX3KB8dqBTDqvZRt2OJGkRgBBlUb/GfZp71lnHNjaf4b5rECA2YyUZPnk1rnTqSZylxq78sDIHIQr4GXq8Arm1GTtLklUpYZu3BcVI7o9di6tMpEw2XLDtpXDlC1bsRBsknxIWYzb85MkhOUwMZIlFdz07Gmd+OrfbM9YnIt0xzeyq30f/Vyl4gCuCsweh6ofurpGiVefBKC2Ls+LWV+PrdcEPjuEY77p3ai+V5B64i83k98AXBSt4yxLJGQzSogk8DRhJhHOmANqOu+bmbZb5htVWnoPS6+Snm46AW9VtZ+AOJSnJ1Np6PUQiGoT/HSsZ78u8ZZKrPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYu2nmwpmNZsI5X8MoooH3uoTuTf34eMt1KDPShWHNY=;
 b=PEMdZ1A3twhbHkqhnYEHOBu4kPupKzAVAJRVgtdzluhcUX23z+f46MQndORFnKhuX75PUnhHfnP/5JC0Hxt6ajVw5C0pkQmHEKV1EkRykOU34nA0Fh9yGC2Y1X/TK55kTuc9UDCM7iKZPH1FvS/M+BZkRPUpLS44Ormemy8GwxLUYWQ9b7BXXsaQrGGpvuUY8gOhFYCsf/63GUNYG7oj0boKtYokNtinZwW6N4OjwnQFK/U9BZVpGhrOF24uzzdlApnr9JIZEUoMgCsf0bfJRJCa1vm40LxqAyEYDXdJH4kfWcjKqCmuF+VCEKD02yghxXAvIXIFc4CmElVC3hdVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYu2nmwpmNZsI5X8MoooH3uoTuTf34eMt1KDPShWHNY=;
 b=js/lhCa/FHeDzSoz09RjqA4lkSNeksk4ZKOLjN1/KCDhHsVilRcSe9IXRDRFtinHVTN8fK0UM9Q4NS+ml1ftaRXmbXxlhfHbH5WDfaLSYEjEpIKTb1fjelX9+XYg/w3hv7kqTZ8c+87YaftrmRKLJC2zgWTq2TApYIX6cpWFr+E=
Received: from PH7PR13CA0014.namprd13.prod.outlook.com (2603:10b6:510:174::28)
 by DS7PR10MB7180.namprd10.prod.outlook.com (2603:10b6:8:ed::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.19; Thu, 30 Apr 2026 18:33:38 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::4a) by PH7PR13CA0014.outlook.office365.com
 (2603:10b6:510:174::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.7 via Frontend Transport; Thu,
 30 Apr 2026 18:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 18:33:36 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:33:26 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:33:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 13:33:25 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.233.157] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UIXOaM1942851;
 Thu, 30 Apr 2026 13:33:24 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, "Bjorn
 Andersson" <bjorn.andersson@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <s-jain1@ti.com>, <s-wang12@ti.com>, 
 <r-donadkar@ti.com>, <r-sharma3@ti.com>, <devarsht@ti.com>, <afd@ti.com>
Subject: [PATCH 0/6] Add DRM driver for Solomon SSD16xx e-paper display
 controllers
Date: Fri, 1 May 2026 00:03:05 +0530
Message-ID: <20260430183311.2978142-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DS7PR10MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: c715f9e8-3d06-440a-e99e-08dea6e6fe2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qrnfyNeU21ZSzK+KCQ1zcrph8YuRrNxUdK58eklCmfAb5ijalXnMohDNeb+lQ1tuKIukB8Jo9VGoG0P0ERXRTtJavfTKwbf09n2vu/DUAqU3mXL4etyDpbAgC+U0TgFutFzrGXyms49lqNfEmcnonETaA5lLLUOxJ18KhUyXDbPii0qN1Ej0rTC2ikeOahHDGf0FNP84MBCo+MElzwWf7lLdDAYZoe7cm9Pu+xq4OMbl8bi1ewVANl8Hrlq4ULAJ3Ik9riF1+DzdBl4GPp6tHXTMlRSVLYnB/o057WMnX7fj4zlep9mCE2BWlg6fahgz+p/oIeT54mapyuVeOilsRn1NjfOjzGrF9BxyZnYpG6e+WZ79OQGlXzxlZm9rjo/56W60+yhxav4kZ7UhgRcVlhhMx7APyJsFTbTJvLbrNHS0QQtm9Ms+kjhsFuNl1+ohBxdqzDlAzYF+NIFIq8Dz4+sbOi/PIeoil5UTTlPhfj14pQfsvn131dfvLS5Dm2qunotla5uLB0ZHWeqbbHHGTNOOFAy8FIWtphFX5KX9u2HuyC5zUoGT2brigCJtJSIpBX7zXItCan4oCbzs+OQBcq6XUynYF9LECg8Qx9c9ZQSy14fw59IlIS6RTxGu36+gHQF99VhXnxWx2ZREKAQc4V40epNbrEQZ1h78UB8dakEl4yH2PIvfZuKFMVexhmsTTVTjTsqucNHIMEvuHiMe8Td8kLH4q3E0iawCBYCZ9B7m+BTkl86NWrgqoTfbzJ+PIQBK/clmUNjnNhgXRP0Cbow3OhDsTnqZOwzwRMGWD4U=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hGz9DSRtibof2nFLTi5R/wqyt9IrRQ+VhadZUv2R4x6hAIsq0GbYzMiJHvWmBw51gKqDFroo/+yXgeyRSv5rNb8NYK/0NTizJaxz/9zqwMZWUuhPfn1tBsc+SVCXeZlTzzZ9LVsRh98N9K0Ov6RwAQo0C/c6mgHUpLi3JJMbhrkdZIszSOlb4hEfy47OL4o78g16qX5IQW3HMFtTAO10PH9gPafZOxlNOnXLm4V4/HdM+j3o+awGUv+XuDQT54TLxYs1V1o+Aio4L8YOEDf7lXJcssmWmqMskgoouunFY3y64NDppvBzSnPTzl/0ODPtSpT67SKJQorjbc1UZusm7D8ekkl0ky4gdhcTds5e3Z+9lzN0FjvepmrzOk/MorMphBxmmhcwdUn/fFI+7S6zBS55gqYIvAxkuX6Cf9+4OiN3riyToL5m19J03Bf3tmjz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 18:33:36.9301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c715f9e8-3d06-440a-e99e-08dea6e6fe2b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7180
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

This series adds a DRM driver for the Solomon Systech SSD16xx family of
e-paper display controllers (SSD1673, SSD1680, SSD1681, SSD1683), starting
with support for the Gooddisplay GDEY042T81, a 4.2" 400×300 black-and-white
e-paper panel driven by the SSD1683 controller.

E-paper displays are bistable: they retain the last image indefinitely
without power, making them well-suited for applications where display
content changes infrequently — dashboards, e-labels, signage, e-readers
and e-badges and low-power IoT interfaces. The driver is designed
and architected keeping this bi-stable nature and low-power requirements
along with having adequate flexibility to support varying use-case
requirements for the e-paper display use-cases.

The driver integrates with the DRM atomic modesetting framework and
supports:

  - SPI communication in both 4-wire mode (separate D/C GPIO) and
    3-wire mode (9-bit SPI with embedded D/C# bit)
  - Full 4-way rotation via the Data Entry Mode register, with no GPU
    or memory-copy overhead
  - Three independently selectable refresh waveforms: partial (~300–500 ms),
    full (~1.5–2 s), and fast (~1.0–1.5 s)
  - 3-colour BWR pixel classification for panels with a red RAM plane
  - Broad pixel format coverage: XRGB8888, RGB888, RGB565, R8, NV12,
    NV16, YUYV, UYVY, R1 (native 1bpp)
  - Runtime PM with configurable autosuspend: the controller enters
    Mode 1 deep sleep (RAM retained) after an idle timeout, waking
    transparently on the next frame update
  - System suspend/resume: switches to Mode 2 deep sleep (maximum
    power savings) on system suspend and rebuilds the pipeline on resume
  - Runtime-configurable DRM connector properties for refresh mode,
    rotation, border waveform, clear-on-init/close/disable, colour mode,
    and init-refresh waveform, each with a corresponding module parameter
    for boot-time or sysfs configuration

Tested on AM62L3 EVM using Gooddisplay GDEY042T81 using following branch
and test suite:

Test suite:
https://github.com/devarsht/linux-next/tree/drm_ssd16xx_epaper/ssd16xx_tests
Test scripts:
https://github.com/devarsht/linux-next/blob/drm_ssd16xx_epaper/ssd16xx_tests/run_all_tests.sh (parent script)
https://github.com/devarsht/linux-next/blob/drm_ssd16xx_epaper/ssd16xx_tests/test*.sh (Individual test scripts)

Testi console logs and summary:
https://github.com/devarsht/linux-next/blob/drm_ssd16xx_epaper/ssd16xx_tests/logs.txt
https://github.com/devarsht/linux-next/blob/drm_ssd16xx_epaper/ssd16xx_tests/results/run_all_20260430_224250.summary

Individual test results:

Supported Pixel Formats tests:
https://github.com/devarsht/linux-next/blob/drm_ssd16xx_epaper/ssd16xx_tests/results/test_formats
Integration (Misc) tests:
https://github.com/devarsht/linux-next/blob/drm_ssd16xx_epaper/ssd16xx_tests/results/test_integration_20260430_223910.result
https://github.com/devarsht/linux-next/blob/drm_ssd16xx_epaper/ssd16xx_tests/results/test_integration_20260430_225207.result
Module params tests:
https://github.com/devarsht/linux-next/blob/drm_ssd16xx_epaper/ssd16xx_tests/results/test_module_params_20260430_224700.result
PM Automated tests:
https://github.com/devarsht/linux-next/blob/drm_ssd16xx_epaper/ssd16xx_tests/results/test_pm_20260430_225028.result
DRM properties tests:
https://github.com/devarsht/linux-next/blob/drm_ssd16xx_epaper/ssd16xx_tests/results/test_properties_20260430_224329.result

Devarsh Thakkar (6):
  dt-bindings: vendor-prefixes: Add Dalian Good Display Co., Ltd.
  dt-bindings/display: Add Solomon SSD16xx e-paper controller binding
  drm/tiny: Add DRM driver for Solomon SSD16xx e-paper display
    controllers
  drm/tiny: panel-ssd16xx: Add power management support
  MAINTAINERS: Add entry for Solomon SSD16xx DRM driver
  arm64: defconfig: Enable DRM_PANEL_SSD16XX

 .../bindings/display/solomon,ssd16xx.yaml     |   81 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    7 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/gpu/drm/tiny/Kconfig                  |   13 +
 drivers/gpu/drm/tiny/Makefile                 |    1 +
 drivers/gpu/drm/tiny/panel-ssd16xx.c          | 2731 +++++++++++++++++
 7 files changed, 2836 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
 create mode 100644 drivers/gpu/drm/tiny/panel-ssd16xx.c

-- 
2.39.1

