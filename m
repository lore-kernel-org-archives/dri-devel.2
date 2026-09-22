Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A13C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF3C10EB7D;
	Tue, 22 Sep 2026 20:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="VSMp3ffU";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VSMp3ffU";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4099610EB7D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:16 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=F9Pmw8a0Bm+nCgRVRNjysyZ+uZzfkZj8dCoVVyM7Pr4Y6LzwAJLaBFJMJg1c+TzvnqOSyIXNIOSCC18d6cDSK4svw/mX3wi/9dr5b3gDDV4N+Vmi5lq/12lQU2nN8X1Y+H06LhPakbj1tm4wTetlgA8kzQATJcnTrQjhVCZa8erxlSXgvTTtG38zVAei9KjD/0Opy/WMhUFi/gpGp1NRoDjzkwXArfWY9fwzoDWnwszrvnrXHPLxEvvBf4chKH+bvegjj4srkZEoikpL5PqDKkFUcR+hUyLDKvkG5EyPXVtkQ5w0BJ+OCU6X1ZqEPbcHoo7c+ujhvtVX/l58/MYpAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CdvBFTSvSbbxQmACGfQljI4weUvRAN138KYCAn5C4I=;
 b=EdC1gEOGuB8n3xQA29M4zx9vgXbR5xHqRUCDzDpPemDp4g/0nVQcJS6eX2GXiGE09I/7nP7DVpJpKO0rQJ2TS06bBgVJs+HhZ0rZo1gQgilWQzmF8foPnSqTwAtRjiz/agNvREGxYGx4y7OptfhpH/hWi72osEBAZq9+Mq4MEqKfRxRBJJSwe9V3Z5xiaCF+hjvswjys9ZuRfJSTwsI+7pl5CaP964UH3cwa07pkubafXF0BN8twX2qE2jfACEtKiRgYpkoPwjStxSEuxQJD3D2GKlHOvVk0B1WHbziyocXThKMCjtNdwJMrmJpKARtazSj57KgPJZvWTxrX9f6DSQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CdvBFTSvSbbxQmACGfQljI4weUvRAN138KYCAn5C4I=;
 b=VSMp3ffUGeHDDIdZJ06AXLdGC8rwzwfmdEoEpfNYJWK16mrlURR1MbjYy42aFwgho4+mrV0GOgRvddnQNMz8brJbu/eTiDRfxRyFEIZnUTrGYnytLKwMlix/VcqygAaaqYntPS96YfnbR/KHA3+hRODxoM8e/YQMfvwKy62DMAA=
Received: from AS4P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::11)
 by MI9PR08MB352182.eurprd08.prod.outlook.com (2603:10a6:290:b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:47:11 +0000
Received: from CPH1EPF0000051A.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::51) by AS4P191CA0016.outlook.office365.com
 (2603:10a6:20b:5d9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF0000051A.mail.protection.outlook.com (10.167.241.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc/yMMILCKJ8te/x4pRLzU/2+IifvdeZ7tdmSciD0aAgtjRRa2HfYm1NN2Z7KkOFiBNcqudIpLp0ZwJmpo7CR9F7grI+dD0ne17wcmF8NiYtyhsC4O1C4xI+f7axLJZJosp9e4aU7NxFxatIb66T8H2iMszgsttpf4elbZ76Vs7Iie40zFx+fEP2uUgSytoVxnMVUyiCUee4u+ICignhnR52J+avNQ+Osy6fho1si1gv7oEcRC4wKu0XMGjN7dhX7HmyqIABnGjGRU9472rvHlf2thO8VW9Aluz2KN3P00WNRINPmzFfPQyFLn8Te8Og/IlUA3HmRgpBy6FvhFIuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CdvBFTSvSbbxQmACGfQljI4weUvRAN138KYCAn5C4I=;
 b=XLhC/fWj6SdwjUkaVgY9iFJnUqYNBCbZSjlh7F5fnjk6RsIiLF5dg+uGmyWOvJ/2XMg394Z/jYjucT2uPASoJbCMkfsdypMIXK12hjyLFAi+nWwO3DiNNQgEhbSHorFRGUiMGeKQewZZkNhAeSju9kkZeWCjPvuds6KIe3TdWm8hmRJ35yBILKhfRSiethphyXnkmDesu91g18AVrpP9BkpUHZxvaLqUqelWxd72g1sXe+EAq87tvHp+kLOyB7drbBbK2mK+MNGeRRDPttGjHaOVP9I2GfgG06PlyDq/FcCDIYagP/MdwL3g3oBWgugXOtzoHJsUEHowT2k+C2ZLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CdvBFTSvSbbxQmACGfQljI4weUvRAN138KYCAn5C4I=;
 b=VSMp3ffUGeHDDIdZJ06AXLdGC8rwzwfmdEoEpfNYJWK16mrlURR1MbjYy42aFwgho4+mrV0GOgRvddnQNMz8brJbu/eTiDRfxRyFEIZnUTrGYnytLKwMlix/VcqygAaaqYntPS96YfnbR/KHA3+hRODxoM8e/YQMfvwKy62DMAA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:38 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:38 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 09/27] drm/panthor: Skip devfreq when no OPP table is
 present
Date: Tue, 22 Sep 2026 21:45:03 +0100
Message-ID: <20260922204535.2850094-10-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::9) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|CPH1EPF0000051A:EE_|MI9PR08MB352182:EE_
X-MS-Office365-Filtering-Correlation-Id: c39e8bae-99b0-431c-b9ce-08df18eaacb4
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 38uD8iq+++3v97gVGbjIipjFQnDIZBILoukURHr0x77k3MIKpOiuJuU0N0UNkI/sJZPBI1NGgMypT+hnNzXtpcQF53jl8MQmZxGa0b6fl3uGtUHBpVL6AiSyBsS+CTGJf4qECwFravKXvZ3Ty8hJYZj0si51Zob4shi4/kSa5vcqUqE19hYRyCSrxXI4brrqj49wUs5muxKrh372tWBMpbUWpoOlTWneB4yklxpz7BJ2yXxPY3hdOpg4IAPbitEbrjBNQ66dYmu8mQbkdLBZ9k+cYgpE5XCt1ytLP3j8EUJ10Yf9gLacN1LDTbloR72TEKA0o3xp5mxZU9ylPxsn6Pbscu8I8AdZzR6+IKmMCe9r84v8Ic9YmLSL18Ze8d4Rk7WYg3p8ZOEu8ThcRVszlSpNbOVr5IpvWYyDJ0KlwUqqFcBHYglqnkj0UVCZeN9FkJ0WsczfdHp6vSN8D6aJy5wFq1MGQ5x+vAuj8MCFZ4ZJ36Bi2SVfU7wrXVnBBg2lpznBlS8YsGiHHfTpZll3qaE2gW03OwAVR7oThuQonDvh2BNuhXjtkCK4KuJK7xwCYNbKH5drtasyFsIUCh1DNRQe4LexwHZareNsUM9wAfFdgNhpAHonbtw7CBqbWpWPevfRLcycktz9IljG51ujzQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Lq4lagxEW8lSrL5syFaOYIby4+8L+frirRmo+pLS2KgPtvFL8S9xvy2eaqC3o/6WkV3d1aFOLgDVjvZmbNAhMz4I1pDVjLz/fRn+zBuRleZlHc0aMWzZcnjj/opAAtERoynzSI8bkXW7HLV/vdfusjrwqh7Q0Axdxz7rG0wIAVDBA1UQmPwGyIeADUI1lkqtCDy2PwHFB54UOR5Cq9LzoI4WApo0PrJY2ptzrUANpwgNw3ObZCFJkpMrf46fUcpDsb/ivFOBRCHU3ZYa5VYvEa4yXBBgAuvrGYadVvma024akVunAfnrMDHP5VC4gwtHdnmJ+5bb5jUPCLCTFSRVVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF0000051A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b88299f6-fe1c-44f9-4378-08df18ea993c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|14060799003|35042699022|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Db95C4BSbPQH/tlq8UeNRa04BbeQ4XbQ7426ZxiCkNBaXPPXUIzPK/VK5PZ/0CaFr7NNPVKHzrBMo6Z0fe5GgWLoGcOr7lIGYBXsrGjJuTncWVo/hEbCESfgP8yMyNmIJvG7idQd/N2VsleC/bl0ONNkCiR1ea5rIkwUvPF3/i5FxcL0H2zMkak9XUzyS62KumjoGFp9Oa4mLHFvmuDBk0RneJatXs7jHmxI71Nx27L26CvfyMeSkV2/4yBmxpHBaUzaIKVLhk9Gjt/eetvn8pFq19tdxym1VNhSsoMXIqFf1mx7euvGaiGm0Fzm145MAvYoJD9B2NW1tRQFB5FSAa9XB3BEygtI5Y0MEPR6WK8u16rjTgKfB+iLlweVB9d/rsfxw8HUK45Xm+2Z4IYK5hW079Of0u7p2kjEksuHq4XEFBr9UfD8sqjfcvMIDfSHwwbDzXv0nyj6RaRl94Yr6UExcY+VAsDjIeqCXJYmAgMqdJtLgkU/6lyikOzwFPQ/5OhP9eVKcZbIb9BrAIyyEt7kmRkKselhL/ANuLs8sMB/oJhc5A4LAN5nN/1wTeCXv7MjpY5FEVoWjbE34oeuWrDTFn6xsZFn6h9XtqL5mmtXzisgOFgRs/FdSHQqxsCDPr+/d/p/ivwfe6ht0dVqCsJiJWjPEf+Uy/v35751xzcd851firbbQI7h9nYDsQyn
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(14060799003)(35042699022)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SZYN5/K57arVlx1zT3QzlBCEmH0XN5dtssGjYmvAFO3X++XfJCPIeUQbc4qeGUF7lv54Nad5eFz1SpkDWVfzYjJmC4KVVdEBU6hXFqKjDXrB19T09riTldiGfsOz5LU4c/ipUlQ/XmQeaXWfT29xSY1CeEoN4mtjHe32yIcQBLDbPIkSGBcj+fhT1mr8ydmohqUjeW5KqYhXm5AcOECebaTuEUIt/ErzGY5XmVvh3BGhu432SX+9VWlccu82Ixmy/2iI/cCeL+AsOF4CGfWnTCUnQh/tPls3UV6xKz/Izuk8KaVHIGvTEInLBt7wgvUroEDLvrT/eZo6jE2VTDj0TLzBm3Ub2qR4myWUXlkbSOPOuW4jE1KeGHvMzoQulrl1nFWemA3d/AZd0ribgZ3sziH+ce6j8oLNF+7++WeDlFw3i8ApshghpiulxLbpraew
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:10.7475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39e8bae-99b0-431c-b9ce-08df18eaacb4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB352182
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

On Mali v15 AM systems, frequency scaling is handled outside panthor by
the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.

Make panthor_devfreq_init() return early when dev_pm_opp_get_opp_table()
returns -ENODEV, and guard the devfreq helper paths against a missing
devfreq instance. Also make it so that frequency can be queried even if
the devfreq instance is missing.

This keeps devfreq enabled for existing platforms while allowing v15 AM
systems to probe without a local devfreq setup.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Only skip panthor_devfreq init when OPP lookup returns -ENODEV instead
  of direct DT-property check.
- Support frequency query without devfreq.

 drivers/gpu/drm/panthor/panthor_devfreq.c | 31 ++++++++++++++++++-----
 drivers/gpu/drm/panthor/panthor_hw.h      |  6 +++++
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 2249b41ca4afe..18c1a7e56ca08 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -12,6 +12,7 @@
 
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
+#include "panthor_hw.h"
 
 /**
  * struct panthor_devfreq - Device frequency management
@@ -164,6 +165,19 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	 */
 	table = dev_pm_opp_get_opp_table(dev);
 	if (IS_ERR_OR_NULL(table)) {
+		/*
+		 * On v15 GPUs, frequency scaling is handled outside of panthor
+		 * by the AM_GOVERNOR block, so the GPU DT node may not provide
+		 * an OPP table. In such cases, do not initialize devfreq for
+		 * panthor.
+		 */
+		if (panthor_hw_is_gen5_am(ptdev->base.dev) &&
+		    PTR_ERR(table) == -ENODEV) {
+			drmm_kfree(&ptdev->base, pdevfreq);
+			ptdev->devfreq = NULL;
+			return 0;
+		}
+
 		ret = devm_pm_opp_set_regulators(dev, reg_names);
 		if (ret && ret != -ENODEV) {
 			if (ret != -EPROBE_DEFER)
@@ -267,7 +281,7 @@ void panthor_devfreq_resume(struct panthor_device *ptdev)
 {
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	panthor_devfreq_reset(pdevfreq);
@@ -279,7 +293,7 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev)
 {
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	drm_WARN_ON(&ptdev->base, devfreq_suspend_device(pdevfreq->devfreq));
@@ -290,7 +304,7 @@ void panthor_devfreq_record_busy(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 	unsigned long irqflags;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
@@ -306,7 +320,7 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 	unsigned long irqflags;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
@@ -319,14 +333,17 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
 
 unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
 {
+	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 	unsigned long freq = 0;
 	int ret;
 
-	if (!pdevfreq->devfreq)
-		return 0;
+	if (!pdevfreq || !pdevfreq->devfreq)
+		get_cur_freq = panthor_devfreq_get_cur_freq;
+	else
+		get_cur_freq = pdevfreq->devfreq->profile->get_cur_freq;
 
-	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
+	ret = get_cur_freq(ptdev->base.dev, &freq);
 	if (ret)
 		return 0;
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 48232254fef97..e5bcb908068cb 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -101,4 +101,10 @@ static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
 	return ptdev->gpu_info.l2_features;
 }
 
+static inline bool panthor_hw_is_gen5_am(struct device *dev)
+{
+	return device_property_match_string(dev, "compatible",
+					    "arm,mali-gen5-am") >= 0;
+}
+
 #endif /* __PANTHOR_HW_H__ */
-- 
2.43.0

