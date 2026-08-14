Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0622C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 12:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2076210E150;
	Fri, 14 Aug 2026 12:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PL/GEsjl";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q8ftVHDO";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9686910E150
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:04:08 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67EAe22S1288306;
 Fri, 14 Aug 2026 07:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=/RaH18i01KVIz
 yzuF1PS8A5EykjDj/8JvwlEhB74neg=; b=PL/GEsjlEsyh0lfe6f27PvolUA/pu
 w+bSga7YoSE1yEH81OQ6kUF8mQfqnfQ3YDLFNYBlen8TpZXpck7cVAkQ5+Rf/SJz
 nfi46FVwHUa082n1IT+7zAvUNTAmLXRjj1JD2nOUvesKPvDfmdAwJ6eZUmG9nnEH
 7+qKe6lhVCBq8LOS6aVDSSnusiW8qR/sy9rl+8sAJw6tdrMU2xo4wCfMvnr20Zc7
 l37vSxDnVDsGH3u/exVJg6HGvCfS6P4OzI0B4KEJOaRPorik2fwAHRrPTk7ciYj6
 GNQfq/pV4xqSNUOi4PZBvtRvMiRl9Md71sfbVVUf1HSMz4vmsJT9pMIaw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by m0380145.ppops.net (PPS) with ESMTPS id 4g1xey17sb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 07:03:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3JCehc8LQgQqtaw0iY6YeE5sFdlSkdZWR8pPZV/rQata97QC99Pnv7Db40JI0pzkC/gK+54UwDKQ01iaEiiCIRwsOa1xOS8OCUui5osE9kHGU/TqyJUqIv3ueDrVzdboq5quhoxHr9mo0ToUBSxkJjsqYP6PALjdzpNF2du1plzzJfaVUINwV0tm5WnmHGpqYhaOX0vNF7gCzvnCZmv2CTBpQM4e/kes9MqiA86vuIbtjcM94tXqgiEizw2Ni36eU+WNVe2crzcKjQN5nw2szCzUO5DaMnrRwuYWwIpUX8KsXF0+qFI7tl3E8uePZ/+4BaX2YCKYK9zams6xxv5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RaH18i01KVIzyzuF1PS8A5EykjDj/8JvwlEhB74neg=;
 b=HUozkOaixlQO4yNpuRGgI0+kxnHIhZI5WmqTKD4+qikcM6yKHRGvkUzqH+d2l5VFNbOgh8y2BuskU7DN67mUK+glCTfwsXF5rswfqBk6ijuV22FjQ8kWVHcmnyFAnjZf+5VTWgXLLa12Hz41fGRomTNwUmFHMcyDRRHmf/B0X/v8DOo6z+3SWKVbrhES8kXK9ZfmmzjivCEycERffNKrDyQgh9i5JgOreeAtn+X8kbNElWm7RmEa3bIb1eTccOPBlrsn67uZbzcHgD79Wm2M3fSOH+i18/gCI0a7lgp6hi2JGFWXHeg3weWWXb2awpAl9aGq4EtOaNO24SA8xaeLQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RaH18i01KVIzyzuF1PS8A5EykjDj/8JvwlEhB74neg=;
 b=q8ftVHDOBRnoJbZGa1YkaNmweEtibGNh82YoR1zvft4gRiGX6Aw0vcUuPm0G0BoOAv+pGMizjY4lpO9l+3oPSZJnvwa5n3dsGwj/0PBaxKMTIaQINUVimVsZ0vymivsnkVSo/K0K4lGZS/TvBkQgeGei9cG4bDvl36tHchmH/Ms=
Received: from SJ0PR05CA0123.namprd05.prod.outlook.com (2603:10b6:a03:33d::8)
 by LV8PR10MB7944.namprd10.prod.outlook.com (2603:10b6:408:208::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 14 Aug
 2026 12:03:31 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8a) by SJ0PR05CA0123.outlook.office365.com
 (2603:10b6:a03:33d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 12:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 12:03:31 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 07:03:30 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 07:03:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 07:03:30 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67EC3ObZ1679011;
 Fri, 14 Aug 2026 07:03:25 -0500
From: Yashas D <y-d@ti.com>
To: Douglas Anderson <dianders@chromium.org>
CC: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
 <d-mittal@ti.com>, <b-padhi@ti.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Recover DP output after a cable replug
Date: Fri, 14 Aug 2026 17:33:02 +0530
Message-ID: <20260814120304.887993-1-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|LV8PR10MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 71889cbb-0cf5-4b2a-74f6-08def9fc0f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|5023799004|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: tYH8ELi280XVsRQFucz1859LPxVYNlMX9zTbUfHmj26lLAOIM0fFzBjLndSs2tFZKwu9vBonDhYRrutkqNTJkxGvheyOPUQwpW/sVBCDJOV8Rd6yroxFztDaQtB3Hdf2UH2IPuM5S8YVlDFpY82FDPWZw/S6wGj93ozzG1rZvDRXUhTLzF2d1GGnVZumLLu3vsait7yHQ1Ppe5uVXR9D2ghSnKQU0d1rz2tcRtQpmxbu+U2u+wEOfVnTnD/+2puLQOwicyc6taqA6RmdUScsBOl27Z8xkOG78eyk+9u13QOECkO3iqaQSmc4knQ50Aq65mepzcLP6bk1zrRtsuUNYQdtPaGgT4fsJ8YmP5v97EIxcseIpob8y7aQXKgLCaRBKFSKlOW3QVtfLIOE9emzfo8iOTc+YOUSofspvzwNoffSxVf5JBaZdCdFXBTSt9tpeE5Pf5i5wMWbR2qXfzqlTsgb5cxt1zJucKGe6JW3wO9X23mGyz8CL7uygLx2UUMHvZtRQ4+ShlppCJ2Z9+ZrcClB+8higpaDMPtWAgat3kksb9LuB1PfzTVd9/ImEs84WIxWarXSehqOBYOZD1iDpCxdiLYQCelGQYVf387D+fNkBmT7Uy5z0ZaNp5he1XBkFoRtG7ODego8wZgBm+c6smC1T8itISipaNfx5avbhgSuCJFp3m5HKyORenFsg6FU9erScqPcvLssuRqPBPIabQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(5023799004)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XvzyG0KclNwC7WCQIbgLGuOxzx0k11OMpiaq7sA92/oP14nocJr47RGgxALZIAEuYKIGKYFlSvvx7uwKD38uxXnQutzrtFKu2I3AI13YRYoUr9MvwwljHTdpHP+hN7u6TFhmkRcnFqjHIP4Xm63wf4gSp6vtLkqf7ZD3MpXZXVbENR7RMFQSy2FqoRsLi+WobrINIxF+fBCKHum8TnzLAvoSi9bT+EU+JN60EIGvqqKziLocFII0xaNZcCp1jVOwRX8mFaSTxzMOz10jqlA+LTU5OhzLDcPc7J9vQActyBhTLvFpxw6r2bK/2x9QBDYTQhPEQTmwVabUkX2zAwPnHRe6eZ4En3lrNgUkML6d+HG4jVxtEjag4mYunpNZArqQizAJcKBrHc5yfgDlPXKV0I92FRNSC+toIwdzAQVpchr5tYBOs6ZOKUKs/Lazwg/D
X-Exchange-RoutingPolicyChecked: C8SH+sAIWStjPrTFV7jZEzcBHNBrXrt8vctqBQo1bei1ii5wCImeYXgXzw12/ybT2Zt19h0cRx94XkxFAnPGm79xGV5PST9CmhHue3ywAjDjgOTYl/Ra6QBIgrvFwxWmH5+2gOoa8comDsb52HXSyW0P8xG5b0YD+zaw9EfcraQdWFNnq/Jp71O2p7Ii8yLglOXEQevU+U6vQoEDe7rq9VdbRLN8nb/6nCiAjqMuy55xW8ctcIFh9Nr9loQ8Knl+yxWABYKbd6RqujjY5dzIfpaszWACkh5l5fgYzg1IUuRrpKqqxMdxx/kYuGBVzr8ME21Mpje0ImnR2O0QXWlZSg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:03:31.2308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71889cbb-0cf5-4b2a-74f6-08def9fc0f18
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7944
X-Authority-Analysis: v=2.4 cv=F9ZnsKhN c=1 sm=1 tr=0 ts=6a7f041e cx=c_pps
 a=2Xzm8ETwQMStJzsoEhJbWA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=-UJQZbtFaib2lCWez6UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfXxaxpFUNbTxPg
 GJLkuT6jGQTJgs+jQt1dpVcA0G2HpktWJ3iojTICtAvY2EZzucXzGAp44zSf/eqq011FNYk84DG
 eGDduaMaX3wPZbj1GLqTSSFWwOLkLAY=
X-Proofpoint-ORIG-GUID: vOiq5ci9gioRbGnfAcrPHh0kyVD1u1eI
X-Proofpoint-GUID: vOiq5ci9gioRbGnfAcrPHh0kyVD1u1eI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfXyjfS737+0nnf
 a+XPfHgWQgyW8NY+wlJhKuEsWY2eKB4M6LI8aEH1zIY5ryaUeEGzLjpWuSayEs3nI4Hhj9XzjbP
 mcV6vSHJXG8byaoE9muHvDXEJ83AtR6wvA4Twjkdovn7ke70IN8VoZc35HA1I+nUctUXt2hihM3
 yKMfYLWIV5vwC1vnggzFRg7vfHyVd/aM5NCieQ2e0WZpkKsaxlwu5rP0vNBvDIMDeL4HWPJ0G0O
 i8HnUbwhQPtKgn1EBCSSl8AdL6LymRJD/lqR67GIFLCxMIw9myTJ5Pa/Cf/hv9nRCskuJDxgU3X
 UQGyQbiFwN6IMEqgbnTwDynDgKwpRjTtJ+1iXFnG9ScKL8HRldnnHOqjkwyi3h6Q35KAcm+KTyP
 x/6trywENlny31swIB+z87jwIj7fuj4i22Abr+ty515G/tuDUv8Q5t/Tu3LTpb1f1WYOCv25ME1
 4PRe5+UGTkS74hIFnfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140091
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

Applications that don't run a hotplug event loop (e.g. kmstest, or any
client that just holds a CRTC open without listening for uevents) never
see a display come back after a DP cable is unplugged and replugged.
The bridge's own link state goes down on removal, but nothing tells it
to retrain when the cable comes back unless something above it issues
a fresh atomic commit -- which these applications never do.

Patch 1 (improve HPD interrupt handling) fixes the interrupt handler
to clear all three IRQ status registers instead of just one, so the
IRQ pin is fully de-asserted and doesn't stay stuck; adds detection of
the bridge's separate replug event (a short unplug/replug that doesn't
always cross the debounce threshold used for insertion/removal); and
switches from polling every connector on the device to notifying only
the DP connector that actually had the event.

Patch 2 (retrain DP link directly on cable replug) adds a work handler
that retrains the DP link and re-enables the video stream directly
from the HPD interrupt path when the pipeline is still active, without
waiting for a new atomic commit. This is the piece that actually fixes
the recovery problem described above -- applications with no hotplug
handling get their display back without doing anything.

Yashas D (2):
  drm/bridge: ti-sn65dsi86: improve HPD interrupt handling
  drm/bridge: ti-sn65dsi86: retrain DP link directly on cable replug

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 227 ++++++++++++++++++++++----
 1 file changed, 193 insertions(+), 34 deletions(-)

-- 
2.34.1

