Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0AFCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8254E10F332;
	Thu, 28 May 2026 15:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="A0uuasu6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="A0uuasu6";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013013.outbound.protection.outlook.com
 [52.101.83.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1AAC10F32C
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:13 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IcA6AnK0tlhyb+A5+DugWT4HZhuWU4FOVYOciGZwmFxvTDT6aE5/wLj26RJcllOlAlg2BHlcVmos/od7iAOYp/eD9kosfRDl4iOs6GX3eLkUxK5m0w4M+yyJHTpPI34t2NBJnHp4Oj7IEq2S/bDVp1cnVsOuvVzXJSse42ZWEFG6p844kuXWiLHSnc/8JdJ+cmKQN11o+OFI+l6EMPV6oJ2J3Om7QZ2qGhbufvE+KzaA4Yq8Ursk56j90831PFy5R/4pv04pQjpMK7nqOhZciuqHUfWtPxRMvyfnV1bz/uz+tGSqUls6SMBwi1VU0SZR7gVZqeORmz+wrjYDp0nkqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajFSQ6s+SFFXMbMKlZr9T+8HkC//oBq+W61GyD4LJt8=;
 b=kxCWuJDi0ykXRiAhS21BBp1WAhwln9BtTnyFl+Jn1zPed3ZrqY4ieU+g79qpE5uPR42rB0HIsN0/0Jp68/8b8t3bRwbdPokYj2ualIsxaLmfug3lgNQXNy9Vhn+zCqcEwZ/typDz2H83c3ObLBdj9iQNQ/JdUCUZGjdUExpLFXgnMFisyp7wlAgaxO8BwPadaqFJFYnpPeZdyzfStd/CUyicdP2ItEKKC5x4aov7mKtB6yTNySyhW1oHs5jI2ptoUSEWtp2dlLK5w6bOLHyzZX8i+wSyCDHR+5Gt9dLzGqLSYmgE2JKZ1FH6PnvBZe6Hg7fgny7/64sMVE/bAUJ8kQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajFSQ6s+SFFXMbMKlZr9T+8HkC//oBq+W61GyD4LJt8=;
 b=A0uuasu6ODRBe//M1kShNi7TOXoaNFC+g2QUTBWyEBrl1f2YKrJ00qLc6wsZugKUCpA36FQGF6kjJ4rDGBkFUyQlA2QGIjDEhucNALOAl4FMpKZP8ms3AWK1YZiAoMCIgaGhtMGVBgBN4f//SsBGFHPP08OHPSie7t3qRpwK7Y0=
Received: from DB3PR06CA0031.eurprd06.prod.outlook.com (2603:10a6:8:1::44) by
 PAWPR08MB9639.eurprd08.prod.outlook.com (2603:10a6:102:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 15:07:04 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::6b) by DB3PR06CA0031.outlook.office365.com
 (2603:10a6:8:1::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 15:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:07:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9/+i8nrhbXwB7ydI226xE4Pubq6CVZfy7GuxSzKaTFt0a1XFV3k5jiENMWL/e72jB5aYmqNaEs3tlthHe1SE6aS7s8+A182pNORHJPBalUlReVLzajbfOTm//3Wzn05Z89JC+wNevH4COG1CauvoMzW7CP8hB/lB7TuSoWaS4QYFMLhVD1gRm98f3kCb+PWE10gVY1sflBbQx5ry4sQ9bvHI7MWnBR7Pk1Dv4v+NH4L+xsbPsNz9DbfVUluds+2bnnADGc5nnJ/2XdKyQ4Uz+PP+quNNxTpziCEDyBU89EErD6Ks5O46Hykm+O1m6Dw4bRBvrGrWc9X4QUFLx4VcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajFSQ6s+SFFXMbMKlZr9T+8HkC//oBq+W61GyD4LJt8=;
 b=vD47e8VuaIItYL1sGW05xadmFJ/kpyxmeC7NRuRXwmipRYlnGSDJ+oXEMfPy0t5Tf/xLZTLK7aq34m41GDsuTUqY52TfqLkP1JZGI7JgiYE69uaUVVlNdoO/d+GYTWdZom46qU+bXOGYHwbUVZ9GAU+6i07yrEHsmeALHZGMVWRG1vLz741BCRzV7I9qBVFzNxoxTeMuPgtc+9IWwKFr0YsfGEqVQ3lShyifBlvo4dQ4K6Pql1fgOPVwmDodqxv48HUnZbIs+MoETfAFQo/XuE0A1Bxs5v60DscAv14luUb9Zs1Yxw6AnBrmVIROnGOFES9tPM7+KPnkCBaBwfes/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajFSQ6s+SFFXMbMKlZr9T+8HkC//oBq+W61GyD4LJt8=;
 b=A0uuasu6ODRBe//M1kShNi7TOXoaNFC+g2QUTBWyEBrl1f2YKrJ00qLc6wsZugKUCpA36FQGF6kjJ4rDGBkFUyQlA2QGIjDEhucNALOAl4FMpKZP8ms3AWK1YZiAoMCIgaGhtMGVBgBN4f//SsBGFHPP08OHPSie7t3qRpwK7Y0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:05:59 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:05:59 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/18] drm/panthor: Add 64-bit GPU_ID decoding for v15 GPUs
Date: Thu, 28 May 2026 16:05:32 +0100
Message-ID: <20260528150546.3168527-5-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0297.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::7) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|DB5PEPF00014B8B:EE_|PAWPR08MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: df3e3379-af72-40a1-7b9b-08debccac719
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: YdV/PnOsDUABulvXOKSclt7RibqRdyI89e+/pbKgobjgdd+tVJFglVcwaIs1FSHlnNWEynj2ncz6HmjzD+w09Lm9BoVOlnbvKHYsHq9qWISYGHEJPr7DKV880XAZe1Mpi0g+aY91vxfYQvHjhwxVpZAgU5T65g9ciuVpMZuSJWA1fdiaZQ+fyFQEc6a/+Kpt5wJdAqZYXXomF6CXUJ/gg4CRcJxbuCuB5Jfx8csgewEMeJefcIT93MGiZGBbKYctMWzl9PrCRtbhnU8ep1wObLSvTizN7y1B/KMgvy2sIcFv+yih+aXN0Z6TcMei48FW+2uFd3qFXgFSPuhzrZaLgoYmruxVQKvtxvQn23HFvXh9CPkdJeM/8uObEVH4GGb48kleKoqmqNm01hHEjmb3rReGEJHwWZBBqsnxsXB2sOFkSm/U5ZNpriWauDzMqq4jO8JR7yfJGNC6DZBN2SPnkBUzy/d32PbC4tFQtAuesm00ieHiPdlGqWju3y4CUGg5Dn6Vl1hWrnTAKiwckJht2WcJbYIMFSrThWGs3OEk3oqpcgKOReUSb2sUh0/M3eEK9GD/GLIJ63xbCdMyOM5gblAQI5cDX6hLy+lJGJXR2aLINHadNQPDRSXFZkQfPWj8ytv1ykenUQgpsQ9pu1gj1/jI/Rs74pb0Oav0k34s/HWUa74yY+YQIJ0hsZRQ5wOF
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Hm7/tnrm+Z/xcsclOb5JXn+tLVu1oBjs7Kq8fU/PLBOwnYzSOHXEMxKucC0GvAVNU4kEjCbunq8SfNQQj+tdiel4UKVD2+KuGHCCFkpXcxEJ97UMee3pzNInFVzzUYYtdG92iid7s/wXutQKdZbWoubfkhT4ZQZVzZdb8MmH5Za1ttu+1ZQ//nHSGaS+2gSE4t8xxRv3PY6qTbrmzbQx2ueFOF97CDsrCP5KReyofJRr6xaAkiEhMEQ1HbRLNPkFi/CEUibSQ9iJJx9XHJQXPQ8A98PrWWyvP56tX8XKF4Nv92T1BmR+5owDd4oEoBsq5iO80othUXuFTU/Nxh1ciQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bdda2afb-68ef-4f58-470f-08debccaa027
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|1800799024|36860700016|82310400026|35042699022|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gU3DrCota1jdiY/pOC34NMIjsGAbjMI51l1Nx1SMeTGPkkBvwu2tqrIfvMIzMkQiFwZEyVNEW42D1E4tzuk72WFOd2tOgvdB/A2NCVJ1mBVF0by/qmIf2VjE6WmaC8BQTNcwPedSa4FOdRRwf8NLfz1mqKK0bX+DTScAWZbDMxzsq5OGo7eibuw+h1U/WhiI8S6vBljLSyjdT3vphGoKuYnBEK/vSbHOuzY03qWQlbi4t7Zco4bC3CZuCE1XSY1OinIgln/3k3hIx8MhHC1i5dCcsTi8eXVhqKy0k6zfirQosXZUdtFN2xjvFPvBdSCe3YcRSSrJhjkKoWwvJHuLCELxF0yQwtM0rGA29oalT9lytFMTaQYztgfQ2dRal+jKRyOoZmE5LKa+IzNjF8UzFE8/r7ih7DURFaFUfczG9jqzS/PzYlCVRx3n3JHjDyCDQv7uzR/GNUc9rL6k4Oi2EcmUIrPYwbn19152qVn6+i6Z0tzltk4+oBiO4hjTsnFxWpWbgMPPVcYDOsh9zgxSbL4l7M6WIiV69Evqoz4MNNQkxjtSNVCwrT7fnSgH2YqKDaWqywbP7j5Ob8doHNPtyQ3m38A7X5VjhF84XVI4PjlPSh5FDQcKJHp90plWrndFM9bl82VWHNj35Qr2LrIatevkSzGC5Z/D/fCE6kLe3B0jNwYyarNm3cM7SerIgOOJWl09tUD457ACDvMPMPFlOL5KJs5X751ch+uata5Ouug=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(1800799024)(36860700016)(82310400026)(35042699022)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gmHgKcYVMUcxjFEgAQTyqUX38Gs4iNOBqRUJMMaLY8voS2L3e7508QDhQ9xOGjiqn1DiXu3VfULUuB0Gowg94aSThaeaZu+msLlrVpWd0GExFimv+aRdRrR8+UrkSfMwfCwktEywfPLEnDxIiFjNY5XcsPMV41eOhe8/FIj6zlTSCIB796TBWWLBW26O8dbmshzlCFuQQFyJWWsvanzKTlkpHCyXBT+tseddX/BuLhPvGJSCJ9mpsrH/B+JIvD5Lw94vtGb8YlwAHDtoiG/Uw4xw+nVNzrN0NQ/5ikzP0lRk4stJ0YHNDb7i9qpgunPrRUgx9luG1f1pdN634Zaun03gcjW/TQkvWcBEpVuHxh6ZqoWKH/aAGNKDSuXMIXhfNH0rTCrlErnhL6PcfFfLq5yfByl5s1WcjiZm6aT9fjyNctlsDOyD0uAILzQK3PnT
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:04.1899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df3e3379-af72-40a1-7b9b-08debccac719
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9639
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

Mali v15 exposes a 64-bit GPU_ID register with a different field layout
from earlier GPUs.

Add the register definitions and decoding helpers for the new format,
read GPU_WIDE_ID when the compatibility value indicates a v15 GPU, and
populate both the cached GPU_ID fields and the uAPI gpu_id_hi field.

This allows userspace and the driver to identify v15 GPUs correctly.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 .../drm/panthor/panthor_gpu_discover_regs.h   | 17 +++++++++
 drivers/gpu/drm/panthor/panthor_hw.c          | 38 ++++++++++++++-----
 include/uapi/drm/panthor_drm.h                | 10 +++++
 3 files changed, 56 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h

diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
new file mode 100644
index 000000000000..54bb104902ee
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_GPU_DISCOVER_REGS_H__
+#define __PANTHOR_GPU_DISCOVER_REGS_H__
+
+#define GPU_WIDE_ID					0x0
+#define   GPU_WIDE_COMPAT				0xF
+#define   GPU_WIDE_ARCH_MAJOR(x)			(((x) & GENMASK(63, 56)) >> 56)
+#define   GPU_WIDE_ARCH_MINOR(x)			(((x) & GENMASK(55, 48)) >> 48)
+#define   GPU_WIDE_ARCH_REV(x)				(((x) & GENMASK(47, 40)) >> 40)
+#define   GPU_WIDE_PROD_MAJOR(x)			(((x) & GENMASK(39, 32)) >> 32)
+#define   GPU_WIDE_VER_MAJOR(x)				(((x) & GENMASK(23, 16)) >> 16)
+#define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK(15, 8)) >> 8)
+#define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK(7, 0))
+
+#endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 3570e2889584..833d10cbb2d6 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -9,6 +9,7 @@
 #include "panthor_device.h"
 #include "panthor_device_io.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_discover_regs.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_pwr.h"
@@ -297,18 +298,37 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
 static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
 {
 	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
-	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
+	u32 gpu_id32 = gpu_read(ptdev->iomem, GPU_ID);
 
-	if (!ptdev->gpu_info.gpu_id)
+	if (!gpu_id32)
 		return -ENXIO;
 
-	gpu_id->arch.major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->arch.minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
-	gpu_id->arch.rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
-	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver.major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver.minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver.status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+	ptdev->gpu_info.gpu_id = gpu_id32;
+
+	gpu_id->arch.major = GPU_ARCH_MAJOR(gpu_id32);
+	gpu_id->arch.minor = GPU_ARCH_MINOR(gpu_id32);
+	gpu_id->arch.rev = GPU_ARCH_REV(gpu_id32);
+	gpu_id->prod_major = GPU_PROD_MAJOR(gpu_id32);
+	gpu_id->ver.major = GPU_VER_MAJOR(gpu_id32);
+	gpu_id->ver.minor = GPU_VER_MINOR(gpu_id32);
+	gpu_id->ver.status = GPU_VER_STATUS(gpu_id32);
+
+	if (GPU_ARCH_MAJOR(gpu_id32) == GPU_WIDE_COMPAT) {
+		u64 gpu_id64 = gpu_read64(ptdev->iomem, GPU_WIDE_ID);
+		if (!gpu_id64)
+			return -ENXIO;
+
+		ptdev->gpu_info.gpu_wide_id = gpu_id64;
+		ptdev->gpu_info.gpu_id = 0;
+
+		gpu_id->arch.major = GPU_WIDE_ARCH_MAJOR(gpu_id64);
+		gpu_id->arch.minor = GPU_WIDE_ARCH_MINOR(gpu_id64);
+		gpu_id->arch.rev = GPU_WIDE_ARCH_REV(gpu_id64);
+		gpu_id->prod_major = GPU_WIDE_PROD_MAJOR(gpu_id64);
+		gpu_id->ver.major = GPU_WIDE_VER_MAJOR(gpu_id64);
+		gpu_id->ver.minor = GPU_WIDE_VER_MINOR(gpu_id64);
+		gpu_id->ver.status = GPU_WIDE_VER_STATUS(gpu_id64);
+	}
 
 	return 0;
 }
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 0e455d91e77d..04fc9f133152 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -373,6 +373,16 @@ struct drm_panthor_gpu_info {
 
 	/** @gpu_features: Bitmask describing supported GPU-wide features */
 	__u64 gpu_features;
+
+	/** @gpu_wide_id: 64-bit GPU_ID for v15 onwards. */
+	__u64 gpu_wide_id;
+#define DRM_PANTHOR_WIDE_ARCH_MAJOR(x)		(((x) >> 56) & 0xff)
+#define DRM_PANTHOR_WIDE_ARCH_MINOR(x)		(((x) >> 48) & 0xff)
+#define DRM_PANTHOR_WIDE_ARCH_REV(x)		(((x) >> 40) & 0xff)
+#define DRM_PANTHOR_WIDE_PRODUCT_MAJOR(x)	(((x) >> 32) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
 };
 
 /**
-- 
2.43.0

