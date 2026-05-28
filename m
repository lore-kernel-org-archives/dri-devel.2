Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2227CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357C810F320;
	Thu, 28 May 2026 15:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SdMdpXP4";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SdMdpXP4";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E344C10F320
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=M7a0oHMLoeAebcK1elc6+eL2Ci8nDMA5W/hSIQkUvaGUxL9E+TT1CiaV0r6qeE8xgdHBcRHrEIW42CBjNXaBUGom8YsqOfSAJtgfL5UwI7lJHfmtTCT/QKFvwaA9xC4qLaDjXzO1B3oA75V74cvF9+w86MLyJTgEkTz6OnM0Y+iojEXLxI2vbAztQEKiVUySChMFPPXdaKYZrB8E1No3BdmFudlOJTam1jA2Ptsor8xDMYiwzggBAbLhI8hZVaSVeE9oK0RliTqTkmq5f359IjlJDkAHaN+aHIwYn3TogoXXs2BRg8jzTRQG+tE4rdSgmtF6j2QvFLj7L4xUwnbwDA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlsiOMDyWO3C6YjKkbHsPXa4SWDGHhYpRvhQJGfbM48=;
 b=l/kRp1fQMXon52ZR/pKup8UmWsznjk1fkngS20o+iQ6V+aTWfnGzyLqosPzhRQOr+AG+i/Dq39qGBzJutVMCgF+Rdk3AhFK7/g9cznnbjS7F/Sp+8j7VI9lH3RAXyTIIvkpOUUhGUgoNl9g2QeTYbrOXjJVMEHeYez4Bor/+PQrIWxBzC/A3K8PZ0yDL3cO2vUclzar29cpbkuMDXNSpjGtVloSc3pbofC9C1gdQVzgyLlGhYB+OjWL8QjsuT7USCUJLYWxnY1/Znk4y+a4L64WkHijZzA+R1k0luogSxol8mN4v4XGdQdOI8vlOZ7UJaOvxWCYepbNTG9Uo6FGzWA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlsiOMDyWO3C6YjKkbHsPXa4SWDGHhYpRvhQJGfbM48=;
 b=SdMdpXP4wVMtRlZjP0LVHevFuGv4FyQ/dFSyc/7Be/D9OyEOfddIInjCFI0u8hyVDRk6BwOnKZyn0zL1NFfUK+SJOIf7if9yJ82X3UO2EtJsuPxQTh1AY6m/1VGsS3VUR9fOD/H1tJMfIlBPZcmKa/ub9X3GtgpDExZVXzfrmSs=
Received: from DUZPR01CA0269.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::18) by PA4PR08MB7548.eurprd08.prod.outlook.com
 (2603:10a6:102:26e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 15:07:12 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::24) by DUZPR01CA0269.outlook.office365.com
 (2603:10a6:10:4b9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 15:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Thu, 28 May 2026 15:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkQBaFMwkn1d8eFukX/evGueUWGUjo7XpmZuDQ2fyVEMa+nG5cAW9d48QlEUWHKBB8OJKCRPR1YDvi7nPgEyeU0wXwlZavH1DZbdvlwkXZWRS0jseReph+kRFRqV6l8ZHbaIt0OX1PxlzMFJTEML1GdQkEnZ7NQBLmNK1L+FMYhtWgk4HL7XGsx3NRFdphBVGAdWLjuANwwj2b9YSYGP0bsS4mrmmobTRDNkRIJbGsG727dZwbLwnqLFxW5Q7aP1vAVgZygc4aaEG+SX7V+2kazX2/f86mQO3VRN9gUErmuQ0vOWOEFlYjvG1TQ2s7jyfaHh2xK9/CPBdc2EXCQoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlsiOMDyWO3C6YjKkbHsPXa4SWDGHhYpRvhQJGfbM48=;
 b=uuABC4N9oEEDP7B9WuN6oAqvrm5V7pKlsxTuKQ4NAD120cAJwoL7bWYiya5ob7sjj9y/rrRaiob69lTN1eA8PhsEaSRe6kBea/DrkbHCn98bNF4ffazObA4jSCTs/aaytP1MbOgVIKTQzHhxbASY7xSS5BSjINnxgSWSSTo8huMzpkEW3S9ez4hRWfWh+42+C7ZKe6KiZbZTA3RJSOZCVNiP95andDZiWnDHGx4FXcZ5ejMzJ9r751COncRrsfOfNhqBudJbjpdzL6+PrgblwF6LlNkAiYeSwmZST/VRpGIjdzPAHy+Fe5WHPkeJsvZTDR97sOPPw6WWSvKDF3nbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlsiOMDyWO3C6YjKkbHsPXa4SWDGHhYpRvhQJGfbM48=;
 b=SdMdpXP4wVMtRlZjP0LVHevFuGv4FyQ/dFSyc/7Be/D9OyEOfddIInjCFI0u8hyVDRk6BwOnKZyn0zL1NFfUK+SJOIf7if9yJ82X3UO2EtJsuPxQTh1AY6m/1VGsS3VUR9fOD/H1tJMfIlBPZcmKa/ub9X3GtgpDExZVXzfrmSs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:08 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:08 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/18] drm/panthor: Add AM message helpers
Date: Thu, 28 May 2026 16:05:39 +0100
Message-ID: <20260528150546.3168527-12-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0500.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::19) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|DB1PEPF000509E7:EE_|PA4PR08MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 751d8226-c0d2-4424-da12-08debccacb8a
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|3023799007|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info-Original: UQSvzjw+H3LjGMS08SGHyfAIHucdIksYbnYUPHDSGvlm+T21ZDT5Xi7pRERjeJ3nIQemYqa5+P6/0u7csx5oAe7kINfeKmAOvmpovqq78a7mw6QmtieRbcnYCmsCGMnUYDMGRAZbzwL4Xfn326vPAyFssgj0Q0cY1e+fY7Sn+JOB8AGlZaAg64BdCXWLdQjJwa3nfsW5qJUlBecyVDI1buCdYP7CZ4skNSU8HiLO0wSZrwpVuUVMqe8zDKw/1lO4KHOmcyz+UA4QpiPKDMDEc1fSVYxewzZL55IWRI6veUnHxygiNtz0biw58Eh9RLBBDbam6eHMiNhPfHM8RK6ksOSKDuIPQdsaIKVkJefwXrGSqkznH/kFaqhsYnhFou9jnHV4YsEc4n8xByZ707xe2eCOnFBSOPwvJhAT7PWU9Z650Yy7ub1kKSgLmE5Y0rpoLdXFbdwUAkgqyhAUvDCOrRhzXZDFiaB4ZkBHmT+UsKoihBL8bpynJFuotiZlFk10W1ttdY5HOAWMFw33dRXSRmrAXY2BHgwbJ3fKsxxhXX/+CGgD/ZELmnkgHtxeU0rdGwb90KFKwPUwX7Xn65F/4C+w/9hFa9W4upw170567QKBRGpJBluvnbSUcwZsvYp61RmoZ4eTu78S4+CFhVOt2FmbqeVpQD4BW2DbwylNikw9vBua+2rooaiIz6aNBWrt
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ZB0wv1BGVEp73SWXtfA5uHIZP0cd6whNbZuVyJlEMEK12t91dOlJ3vW0VmQrvPJAMwbpg9BuPr9zEmI0iorbYw5MC0A+iWdATo3AWKGNYHYdIm0GC0ntbLo4P8O2CM1dmBTODZO7c/1Grfkgz5a5u5omPx3D1CrruNjA5YCzEvB/9iVcp6B6Du7B/wJt7+iBFd1kgdspLzQ1cg5uZ4a8wzqC0VGsupacXYqGAJx0b1DVka6HMAkBA83JXAYxTEv9ei2IJWtK8inEjrVshEOpbspeGnwbgRZvPt+T7IS+MbZPN+4ApDbeesoR7frKXvy0E59q7NHreuOQKla2h0bErw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a792d752-005b-4ad1-4400-08debccaa5d0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|36860700016|376014|82310400026|35042699022|18002099003|22082099003|56012099006|3023799007|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: tuhy1xQg8KBZKBoZs1KQfyhKziqBu3biZW4Ynv9Xa+OivMAE9K7J5pkJb8WnW1xCxJw7+lQan6pyCixt0RDQ9bBDbxj40G7sFpv4H6Tfnz3Ty4Mcz31M/G2BoFFampXxhloli0tEYMXPp0TvMQ5RnaagUSCN8qEr3qLl9HUf4sexiKhhO3To3i+ZLgG5n+DG6fcZ6StP411y7P+Z6TpPIUWf9bridyIvLQBQjUrqQXT9pSeRdU4UGBLLY26TaD/DV+l9ziLSWUqTRxL6m17F/lTxl+AHR1vzMdMP0IKAQDBi8t7xuESMZAS0YB4jWiNg9JYWY4zfS+GX5ZmoDqkTzJ2teXOc2Oc2rT6lgz5bvwC3QEYrXFXUMsHsDkk8I0U28navc1NICVblFiKhPeSN3nKhGg/4GVkky/5KpW74p+fA3i5AXe1lrgxa/l0anfMk998A3AArcKwnPFG09tsVwfb1RH3V5tbDMUAxs0C1Jm3wd9xXIEYoElHu9nAJqpcBiTFbcjVTeeeeHLIJEfurex0ZtyAhiVbZE409q9HOQQe27k7jRWpCzEjnJWf/SyIwXcSRzXYSX70ht0MPszulmmvbxklG4TLJkTHguF4Ijon7siVcwTSWVN4ruRu59Y3Avtm1jCK9icTj1j4a9bPquWTzjGyMQT8pD+NMboZ5EfUufpz2cjRYy9kZ1uaJmZ3AdVLavNvix2DZb0wMoyR0WfEtAQ9Eyv3jG1OdGoRgZ+I=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(36860700016)(376014)(82310400026)(35042699022)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vUS2zb8fUTakEPOe10TMK3vUPWg3Iq6KiN2OO5qfa2roTIvzWxOHrmaWioffrg20LFJo5noH4oOlGGZtK07DKzYz14gsySXfl4C4xOpbS3V7CKoc5QDtvZn9GYNmNOPg3QHin2vcDvprTs8Uoe1snAwWo+N22GTlFEmX/c3grvR31x0Tb2m5E/K81tLs7naNutcyYbZqy2jmvy2z7ZXCXktPzr6DeGvd40cNmxZpP0snrlLzzjNSEgUYMXY9IllBGvxfbVgwjrL14+LJEaLqnAN01JOxbCDr/fHWBucsUdFQVctZRTdIr8fn9kkMZ9LlHC395sEWrdZKxixSeR610uM3eJi5cw+JOd/bFKtAliNMslMHkxs/w3BWWNk0pEwSmkN5N9nEJmolosVEtXLQk2aBm5sY1ghiTwI6/0/gZpWjGakCfAvwNkOvX4Z93swX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:11.6387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751d8226-c0d2-4424-da12-08debccacb8a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7548
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

Add a shared helper layer for the AM_MESSAGE registers used by v15 GPUs
to coordinate between access windows to enable virtualisation of the
GPU.

The helper defines message IDs, register accessors, version negotiation,
and FIFO-backed sending. Outgoing messages are serialized with a
spinlock, written in the required register order, and queued for later
retry when the hardware outgoing slot is busy.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_am_msg.h | 157 +++++++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/panthor_am_msg.h

diff --git a/drivers/gpu/drm/panthor/panthor_am_msg.h b/drivers/gpu/drm/panthor/panthor_am_msg.h
new file mode 100644
index 000000000000..bc4dedcd03ba
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_am_msg.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_AM_H__
+#define __PANTHOR_AM_H__
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/kfifo.h>
+#include <linux/types.h>
+
+#include "panthor_device_io.h"
+
+/* Protocol versioning */
+#define AM_MSG_MIN_SUPPORTED_VERSION 0x1
+#define AM_MSG_CURRENT_VERSION 0x1
+
+#define AM_INCOMING_MESSAGE0			0x0
+#define AM_INCOMING_MESSAGE1			0x4
+#define AM_OUTGOING_MESSAGE_STATUS		0x8
+#define AM_OUTGOING_MESSAGE0			0xc
+#define AM_OUTGOING_MESSAGE1			0x10
+
+/* Arbiter to VM message IDs */
+#define ARB_VM_GPU_STOP 0x01
+#define ARB_VM_INIT 0x04
+
+/* VM to Arbiter message IDs */
+#define VM_ARB_INIT 0x05
+#define VM_ARB_GPU_REQUEST 0x08
+#define VM_ARB_GPU_STOPPED 0x09
+
+#define AM_MSG_ID_MASK				GENMASK(7, 0)
+#define AM_MSG_ACK_MASK				BIT(8)
+#define AM_MSG_VERSION_MASK			GENMASK(15, 9)
+
+#define AM_MSG_ID_GET(x)			FIELD_GET(AM_MSG_ID_MASK, x)
+#define AM_MSG_ACK_GET(x)			FIELD_GET(AM_MSG_ACK_MASK, x)
+#define AM_MSG_VERSION_GET(x)			FIELD_GET(AM_MSG_VERSION_MASK, x)
+
+#define AM_MSG_INIT_MAKE(_id, _ack, _version) \
+	((_id) | FIELD_PREP(AM_MSG_ACK_MASK, _ack) | FIELD_PREP(AM_MSG_VERSION_MASK, _version))
+
+#define ARB_VM_INIT_MAKE(_ack, _version)	AM_MSG_INIT_MAKE(ARB_VM_INIT, _ack, _version)
+#define VM_ARB_INIT_MAKE(_ack, _version)	AM_MSG_INIT_MAKE(VM_ARB_INIT, _ack, _version)
+
+#define AM_MSG_DEFAULT_FIFO_SIZE		4
+
+struct panthor_am_msg {
+	/** @iomem: CPU mapping of the AM_MESSAGE registers */
+	void __iomem *iomem;
+
+	/** @lock: Lock for send_fifo and outgoing message register */
+	spinlock_t lock;
+
+	/** @send_fifo: FIFO to queue of messages to send */
+	DECLARE_KFIFO(send_fifo, u64, AM_MSG_DEFAULT_FIFO_SIZE);
+
+	/** @version: Protocol version */
+	u8 version;
+};
+
+static inline void panthor_am_msg_init(struct panthor_am_msg *msg,
+				       void __iomem *iomem)
+{
+	spin_lock_init(&msg->lock);
+	INIT_KFIFO(msg->send_fifo);
+	msg->iomem = iomem;
+}
+
+static inline bool panthor_am_msg_pending(struct panthor_am_msg *msg)
+{
+	return !!gpu_read(msg->iomem, AM_OUTGOING_MESSAGE_STATUS);
+}
+
+static inline u64 panthor_am_msg_read(struct panthor_am_msg *msg)
+{
+	return gpu_read64(msg->iomem, AM_INCOMING_MESSAGE0);
+}
+
+static inline void panthor_am_msg_write(struct panthor_am_msg *msg, u64 message)
+{
+	lockdep_assert_held(&msg->lock);
+
+	/*
+	 * Registers must be written in this exact order to prevent interrupts
+	 * being raised before the complete message is written.
+	 */
+	gpu_write(msg->iomem, AM_OUTGOING_MESSAGE0, lower_32_bits(message));
+	gpu_write(msg->iomem, AM_OUTGOING_MESSAGE1, upper_32_bits(message));
+}
+
+static inline int panthor_am_msg_retry(struct panthor_am_msg *msg)
+{
+	u64 message;
+
+	guard(spinlock_irqsave)(&msg->lock);
+
+	if (kfifo_is_empty(&msg->send_fifo))
+		return 0;
+
+	if (panthor_am_msg_pending(msg))
+		return -EBUSY;
+
+	/* FIFO should never be empty at this point */
+	if (!kfifo_get(&msg->send_fifo, &message))
+		return -EINVAL;
+
+	panthor_am_msg_write(msg, message);
+
+	/* There are still messages in the FIFO, notify caller to retry again */
+	if (!kfifo_is_empty(&msg->send_fifo))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static inline int panthor_am_msg_send(struct panthor_am_msg *msg, u64 message)
+{
+	guard(spinlock_irqsave)(&msg->lock);
+
+	/*
+	 * If there already is a pending message in the FIFO or the outgoing
+	 * message is still not read by the receipient, add to the FIFO.
+	 */
+	if (!kfifo_is_empty(&msg->send_fifo) || panthor_am_msg_pending(msg)) {
+		if (!kfifo_put(&msg->send_fifo, message))
+			return -ENOMEM;
+
+		/*
+		 * return -EBUSY to indicate to the caller to schedule work to
+		 * retry sending messages in the FIFO.
+		 */
+		return -EBUSY;
+	}
+
+	/* We are free to write to AM_OUTGOING_MESSAGE */
+	panthor_am_msg_write(msg, message);
+
+	return 0;
+}
+
+static inline int panthor_am_msg_version_validate(struct panthor_am_msg *msg,
+						  u8 version)
+{
+	if (version < AM_MSG_MIN_SUPPORTED_VERSION) {
+		msg->version = AM_MSG_MIN_SUPPORTED_VERSION;
+		return -EOPNOTSUPP;
+	}
+
+	msg->version = min(version, AM_MSG_CURRENT_VERSION);
+
+	return 0;
+}
+
+#endif
-- 
2.43.0

