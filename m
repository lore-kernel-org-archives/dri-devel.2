Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CEACD6E49
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F2810F32D;
	Thu, 28 May 2026 15:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="AEevoAM9";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AEevoAM9";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA00810F320
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:16 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=c4aBD2ePJ0oP5ih1LtEbIUkfkcBn95+ObTG2J+QjgsPT2HUpMIlVeCvPKMWGQ2IKqZxF2a7Jt9IzZPbWkoRAe1JJwXWr3scwqQhaZKiEpXTcMIo/SGxXn8jHefmDq6cep2rLzD4/4umExWM1mso3vRmfikeV4GbLC/noSvgi/zV/NBG3aUDMO5eN/JTVB0LH3GNgYdlSA85IhX6L+DyvzLsp7vsYAQJi+4Nd6p5YuP/HFyrxm1OpCltRams2FNag1mDPuOH9hdApMtw00tCfM/4rYOzYEivTYsXbR7to+VUQMR7y1mgyGvX4cdmyJzqJmjBLKAMCuNYddqagA0/+3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9l4J+Wa9HlncrFg48/Cw/gSHh7yTxKzXMxQ175aARw=;
 b=HRa4UGsD5S16Iy/9lJKQCj9hAkZFRkWt5TtuLlfoCNswalVQyZCLMaYxtXI9WbmlLh8vfrdTkI7+BdLAhuy4+4BlC1dabUWbozPGlklmU3qq3cG8LCdr3dos0rk4bCGJL07nkqo6T/+MSEwRD36tnOuLuaJN9q7PDUccBTalEtLuZlYKLEFpOy7yKlYoeBnXlhYnXeq9anFX5fjyBJyS1g+gdEyGnvBrnrLt1NNm/Lty72WP/SpxIh1Z+kRpWk9L7s86XQu7ak2UgaACXkTA2EvjF8WPh8q+5KQ+pY3A76TXL1VUJtE9D6QmsKSMTw/ktaSWc8FxAS9UXpWUmYJ8ig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9l4J+Wa9HlncrFg48/Cw/gSHh7yTxKzXMxQ175aARw=;
 b=AEevoAM9LZr6cRvN8T/pqRYoe492/TsCToKap0YedJSqMIz143e52UBkfB9fjTIGUPU+zS4KviNTSx8/CtdiLnZGOdLbWJeC0HbTKWS9osGcADDrsGxsCvjY1ZtnxBkkW+yWYPbuNbTtFaNUjOLvMgjWzNdcNCeFG3ugIkK3Yug=
Received: from DU7P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::28)
 by GV2PR08MB8413.eurprd08.prod.outlook.com (2603:10a6:150:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 15:07:06 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::8a) by DU7P190CA0011.outlook.office365.com
 (2603:10a6:10:550::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:07:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCz7SApuYspcihmLXMfVEJ2W6nzb58guQV8h2aq9Uh/w+GuVQBeeixghQW1nafXWloD6bK2wecORU3Q+kiz8Vj0Wm1vBolDI6dJMHaOnXBszEa2zG06zGsh57G0pzlKeoDn95bWD3G58/j6Mgn0HPhHvQHHo0+iAk0n3uh0p83pQN9KlXlzJ1IKB0+Gvt/m1+z4QdHTQ2qy14LPeI+fqIG54eIxfOZn8OuchPj2v7B8vP20pkyTqcy/rfQ7xRg6GR+hh1mOzy2v7YlpmRblO06FBzTlankRODQBUXnNwuqB3NF093IbgJmxTkfqybZpo4HeWV/KhSRSknM/NWGGSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9l4J+Wa9HlncrFg48/Cw/gSHh7yTxKzXMxQ175aARw=;
 b=WlacGpJBhAMAePhdjXIQM1F2BxdXe++7pCD+on8MezOvAahbq6nj8ldlvFVz7f2q2IdEEI7p+R7Prxh6ThkVOaKipWYFYMLnmCQStdkO22I9BQonv3Bw7S+IJQ1deGDbOzV8JIWW5/+rcTsHHtG9P5CLQGH2dToAiaw+ffd8rKgIzNn0rKsHbj7lHHc+vC6EVrnxN2Os/mDYSvC8DVzdctdv41m3kGcHUGyoSl1c/pGcwztCOnqFlaMcolYSXGBRIE0r9OpPFPFfSoAf8RDyk7BizkUmdMy4jPLT6njGIq5V1XlQR8rS8oX15+YQWCbi/8OKyysziq7UzhV3QHo2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9l4J+Wa9HlncrFg48/Cw/gSHh7yTxKzXMxQ175aARw=;
 b=AEevoAM9LZr6cRvN8T/pqRYoe492/TsCToKap0YedJSqMIz143e52UBkfB9fjTIGUPU+zS4KviNTSx8/CtdiLnZGOdLbWJeC0HbTKWS9osGcADDrsGxsCvjY1ZtnxBkkW+yWYPbuNbTtFaNUjOLvMgjWzNdcNCeFG3ugIkK3Yug=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:03 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:03 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/18] drm/panthor: Add Mali v15 hardware support
Date: Thu, 28 May 2026 16:05:35 +0100
Message-ID: <20260528150546.3168527-8-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0178.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::10) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|DU6PEPF00009526:EE_|GV2PR08MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: b7efe91f-7a3d-4a39-9066-08debccac872
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: MpPu25yc+09cn3hao2RWrhBhmDrTIFDHz10YbX7ycRpqh1rMht4z4voo1SiBj0WJb9Gp/8ZFcYuX1K4D7yUK0pRmjU+gkkhFjywS2CwTsf5yKCzdq19VnvfcRh2e4KOrCLlsxDBx73mzZShd0y2Q1vx0ZiVW9mqqw11YU7WsFkvq2a7aw1DvsN/xhjjp58abervGmDtLCG9fY0ge+SGBN5gYmnqhGzULLYtDARf/XPK9lFnVlwJk/Zskbu/u2Tvxcj9C5QDzuKTpEJK69Xiw9RTG0MYoOMhfcRX380W4QoP9xaCdruULhx6HoAJ5Ui4IoM6E/S/Mz/4yV8P8xgfwHvEXs7yFksdDEKq1cv0wmztKjlgeVr8F8WNCjpsiziUgTYx7o4tKuMjC/uk7lilePChODWgRf9mIAcWi4UEdAsnYxSVHghonlDu5OUtZklsQSYED2NpYIVX+KbdYXvcw0oIr5Zq/tIl+HM/Sab25OuPUh95ofOCZxgJ/632d/3fMjI3jIaSROQz5xekJyvj+YervzytTL88tOCv25gwjsxI9SJmwy0+X+UC5fnsOFvnitr1a8qJ4aQB+pCxPsCbRuK82diAZ2eANT1maHYRLgObPSHFZpcCR2eY/cGKl7JMFitO00BBQxSozwUNPcc1/zdbcCPgCJ0Pq1ZZiyQtSKi1pOrlvkThZgKH+LQEs8rrI
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: rDv5WKIbtcD0HYY2bG11bPG+2P5l5g6tKygR0TeHFssyMhO8dLVR3+U7hs5d00c8071vsof99Dhb4EG3gGBwYfG5PIC8feSzIfyHR93I8Ys1DiUoweW6TL4xIvPmHCVC2izYUTL3HhwLraTgAJeQreuZTjhgvBYGEyx7EAiXacOHWNbe43U/P9GJrCyWRJ05HrgcwNrC2zQfcttLZzcUX2mkbvDEsJO8PdpvXPzcCm9m5pvgYtkpbkhn6ag1GOV4sOpED0C6s0YxoMexvcyUXl0UTI7QlMhXWHM1YM2oQlFq1B8b6Q0Wf7FqO4k8vNXVt3fM+cacTNb4BAgsUwrIBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bb465505-aa9c-434b-b90a-08debccaa286
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|14060799003|35042699022|11063799006|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AGEDiTk7C/wsf5So3OilGdMkPs+GtBQGyWtyq17HxqRPBtp9W1AEUHsIkb4PE0DmGgLoR0D5cqf319+SwhY8LyhTrNCr1sQG3/D551Sw4IHsnDeSfI9co0haSWv8u9cGaOKZ7ruj9HzbOhAWiW28ghH1DL5QuujriN4dpySa7681F7pWhn14kMic7T0c4jC/yd2mveXZmTiu+axVW0ncvG/RJCiHxm7nb95U1HED4NeW9bw8sOtpOlvxjCKI1X4oacMqDbfRy7LDF3mrcfFh264/bzeHcHDV96sRkw5d2lR1CCip+iWh9OUkQmWs2ctshlR7zw6tMbOZZEfbYQSuA4zGyLb4RzVtFfFTVNMXLxrVh49iAuPBMtMruCYpODKj4luOeUgSIrDRA2GrkLVocir2HgvnOlnJM63v1Y4KQe9JeQRDcYYABTnDu/rxxxbF+QpfxBTlxdiRgLT+0bFqMZHwV2KX96fw+4siVdsAdUbk79vjK5DnFFaBzQHyLkjd2r7hCeYFtd4cfrTLUfCOQww9CZTk3veMOhnOlYyXHBUXzBEZI78aSgkJmApxvYwxM8FyM1qPmCgatzv1Y94qZJcKMBZZ/4fTYIryaW8VX4DewCowoV0VrzPpbH5ynP3QpJqbavASWxnzl4qRwxTLYAjMEyKfud2AyQW5o7LHCLZ2kNdy31O32pezLHuhc1pfjjI5KavI/d4LW0Z8DWeAPPsrZ27eKa4B/yd9b90bs1c=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(14060799003)(35042699022)(11063799006)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OHobKJTytizB0CpXmxqkTJoD0InFeuHZpgDvqhi2GosMKrQ8XOKPiqBz7oDoZzTT+LYlXCNBEbharSsDxPl1oRSQQU6iHkvsiFYvsS073sKjjeRdE2Yxj0IbUH9In60tRLcCIUJ9xS2NstmB2m7S9EVpJRqnzLsz+aQftHsreJQjc953Rv1mIngGBJrKLVdIod/IZSuwf6HHZSTC91G/LH0vjXMez8z9aUdmt8pT6N8m70McawL4hLOZBxlwwn7W3YaK2i27ITPdpmbFBwMRh/uv+yNth5PeoNORFQs/m1K+pw5mvdX0OqhKN51riHTrTPM4XtzFirITvKlBgTP2sskbvUtHu74zBQzPljG2eBEppnyWemJUo9XqEAToUbINGOkdKm2zCQPy+kIYeM8Bf3/Jv4fAU2rDVki4EIo1MKFRHjTQ3MIA+UGaZ75uhEPB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:06.4409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7efe91f-7a3d-4a39-9066-08debccac872
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8413
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

Add the panthor hardware description for Mali v15 GPUs and hook it into
device matching.

This includes the v15 register map and product identification needed to
populate the GPU information exposed by the driver and its uAPI.

Add compatibility string for v15 GPUs.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c         |  1 +
 drivers/gpu/drm/panthor/panthor_fw.c          |  1 +
 .../drm/panthor/panthor_gpu_discover_regs.h   | 25 ++++++
 drivers/gpu/drm/panthor/panthor_heap.c        |  3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 81 ++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_hw.h          | 13 +++
 include/uapi/drm/panthor_drm.h                | 10 ++-
 7 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index e8dc4096c1d2..21644a60c8e4 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1875,6 +1875,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
+	{ .compatible = "arm,mali-gen5-am" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index f6381f5f236f..e2a511b741f4 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1529,3 +1529,4 @@ MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch14.8/mali_csffw.bin");
+MODULE_FIRMWARE("arm/mali/arch15.8/mali_csffw.bin");
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
index 54bb104902ee..9c64676dc35a 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
@@ -14,4 +14,29 @@
 #define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK(15, 8)) >> 8)
 #define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK(7, 0))
 
+#define DISCOVER_REVIDR					0x8
+#define DISCOVER_GPU_FEATURES				0x20
+#define   GPU_FEATURES_VARIABLE_RATE_SHADING		BIT(0)
+#define   GPU_FEATURES_SIMD_STATE			BIT(1)
+#define   GPU_FEATURES_CROSS_STREAM_SYNC		BIT(3)
+#define   GPU_FEATURES_NX				BIT(4)
+#define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
+#define   GPU_FEATURES_LD_LEA_TENSOR_INSTRUCTIONS	BIT(6)
+#define DISCOVER_MCU_FEATURES				0x40
+#define DISCOVER_PRFCNT_FEATURES			0x50
+#define   PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(x)		(((x) & GENMASK(7, 0)) << 8)
+#define DISCOVER_DOORBELL_FEATURES			0x60
+#define DISCOVER_MEM_FEATURES				0x100
+#define DISCOVER_MMU_FEATURES				0x108
+#define   MMU_FEATURES_AS_COUNT(x)			(((x) & GENMASK(23, 16)) >> 16)
+#define DISCOVER_AMBA_FEATURES				0x120
+
+#define DISCOVER_L2_FEATURES				0x128
+#define DISCOVER_TILER_FEATURES				0x200
+#define DISCOVER_CORE_FEATURES				0x300
+#define DISCOVER_THREAD_FEATURES			0x320
+#define DISCOVER_THREAD_MAX_THREADS			0x330
+#define DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY		0x334
+#define DISCOVER_TEXTURE_FEATURES			0x360
+
 #endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1e9..afb7d68abc87 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -11,6 +11,7 @@
 #include "panthor_gem.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 
 /*
@@ -105,7 +106,7 @@ struct panthor_heap_pool {
 
 static int panthor_heap_ctx_stride(struct panthor_device *ptdev)
 {
-	u32 l2_features = ptdev->gpu_info.l2_features;
+	u64 l2_features = panthor_hw_get_l2_features(ptdev);
 	u32 gpu_cache_line_size = GPU_L2_FEATURES_LINE_SIZE(l2_features);
 
 	return ALIGN(HEAP_CONTEXT_SIZE, gpu_cache_line_size);
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index e677f1a8f488..52271fb9db52 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -65,6 +65,23 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 	},
 };
 
+static struct panthor_hw panthor_hw_arch_v15 = {
+	.ops = {
+		.soft_reset = panthor_pwr_reset_soft,
+		.l2_power_off = panthor_pwr_l2_power_off,
+		.l2_power_on = panthor_pwr_l2_power_on,
+	},
+	.map = {
+		.gpu_control_base = 0x3000,
+		.pwr_control_base = 0x3800,
+		.mcu_control_base = 0x3100,
+		.mmu_as = {
+			.base = 0x2800,
+			.stride = 0x80,
+		},
+	},
+};
+
 static struct panthor_hw_entry panthor_hw_match[] = {
 	{
 		.arch_min = 10,
@@ -76,6 +93,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
 		.arch_max = 14,
 		.hwdev = &panthor_hw_arch_v14,
 	},
+	{
+		.arch_min = 15,
+		.arch_max = 15,
+		.hwdev = &panthor_hw_arch_v15,
+	}
 };
 
 static int panthor_hw_set_power_tracing(struct device *dev, void *data)
@@ -187,6 +209,12 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 		return "Mali-G1-Premium";
 	case GPU_PROD_ID_MAKE(14, 3):
 		return "Mali-G1-Pro";
+	case GPU_PROD_ID_MAKE(15, 0):
+		return "Mali-G2-Ultra";
+	case GPU_PROD_ID_MAKE(15, 1):
+		return "Mali-G2-Premium";
+	case GPU_PROD_ID_MAKE(15, 3):
+		return "Mali-G2-Pro";
 	}
 
 	return "(Unknown Mali GPU)";
@@ -210,7 +238,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 	return 0;
 }
 
-static int panthor_gpu_info_init(struct panthor_device *ptdev)
+static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
@@ -251,12 +279,56 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
 		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
 	}
+}
+
+static void panthor_gpu_info_v15_init(struct panthor_device *ptdev)
+{
+	void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->map.pwr_control_base;
+	u64 texture_features;
+
+	ptdev->gpu_info.gpu_rev_wide = gpu_read64(ptdev->iomem, DISCOVER_REVIDR);
+	ptdev->gpu_info.l2_features_wide = gpu_read64(ptdev->iomem, DISCOVER_L2_FEATURES);
+
+	texture_features = gpu_read64(ptdev->iomem, DISCOVER_TEXTURE_FEATURES);
+	ptdev->gpu_info.texture_features[0] = lower_32_bits(texture_features);
+	ptdev->gpu_info.texture_features[1] = upper_32_bits(texture_features);
+
+	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, DISCOVER_THREAD_FEATURES);
+	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, DISCOVER_THREAD_MAX_THREADS);
+	ptdev->gpu_info.thread_num_active_granularity =
+		gpu_read(ptdev->iomem, DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY);
+
+	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, DISCOVER_GPU_FEATURES);
+
+	/* The following _HI registers do not contain any information (yet) */
+	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, DISCOVER_MEM_FEATURES);
+	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, DISCOVER_MMU_FEATURES);
+	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, DISCOVER_AMBA_FEATURES);
+	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, DISCOVER_TILER_FEATURES);
+	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, DISCOVER_CORE_FEATURES);
+
+	/* AS_PRESENT register removed on v15+ create virtual mask from MMU_FEATURES.AS_COUNT */
+	ptdev->gpu_info.as_present =
+		(1U << MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features)) - 1;
+
+	ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
+	ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
+	ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
+}
+
+static int panthor_gpu_info_init(struct panthor_device *ptdev)
+{
+	if (panthor_hw_has_gpu_discover(ptdev))
+		panthor_gpu_info_v15_init(ptdev);
+	else
+		panthor_gpu_info_v10_init(ptdev);
 
 	return overload_shader_present(ptdev);
 }
 
 static int panthor_hw_info_init(struct panthor_device *ptdev)
 {
+	u64 l2_features = ptdev->gpu_info.l2_features;
 	u32 major, minor, status;
 	int ret;
 
@@ -268,14 +340,17 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
 	minor = ptdev->gpu_id.ver.minor;
 	status = ptdev->gpu_id.ver.status;
 
+	if (panthor_hw_has_gpu_discover(ptdev))
+		l2_features = ptdev->gpu_info.l2_features_wide;
+
 	drm_info(&ptdev->base,
 		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
 		 get_gpu_model_name(ptdev), ptdev->gpu_id.prod_major,
 		 major, minor, status);
 
 	drm_info(&ptdev->base,
-		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
-		 ptdev->gpu_info.l2_features,
+		 "Features: L2:%#llx Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
+		 l2_features,
 		 ptdev->gpu_info.tiler_features,
 		 ptdev->gpu_info.mem_features,
 		 ptdev->gpu_info.mmu_features,
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 0ae11b78c77e..1b2678ea00db 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -83,4 +83,17 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
 	return ptdev->gpu_id.arch.major >= 14;
 }
 
+static inline bool panthor_hw_has_gpu_discover(struct panthor_device *ptdev)
+{
+	return ptdev->gpu_id.arch.major >= 15;
+}
+
+static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
+{
+	if (panthor_hw_has_gpu_discover(ptdev))
+		return ptdev->gpu_info.l2_features_wide;
+
+	return ptdev->gpu_info.l2_features;
+}
+
 #endif /* __PANTHOR_HW_H__ */
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 04fc9f133152..2ecc50eade27 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -368,8 +368,8 @@ struct drm_panthor_gpu_info {
 	/** @core_features: Used to discriminate core variants when they exist. */
 	__u32 core_features;
 
-	/** @pad: MBZ. */
-	__u32 pad;
+	/** @thread_num_active_granularity: Granularity of number of active threads */
+	__u32 thread_num_active_granularity;
 
 	/** @gpu_features: Bitmask describing supported GPU-wide features */
 	__u64 gpu_features;
@@ -383,6 +383,12 @@ struct drm_panthor_gpu_info {
 #define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
 #define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
 #define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
+
+	/** @gpu_rev_wide: 64-bit GPU revision for v15 onwards */
+	__u64 gpu_rev_wide;
+
+	/** @l2_features_wide: 64-bit L2_FEATURES for v15 onwards */
+	__u64 l2_features_wide;
 };
 
 /**
-- 
2.43.0

