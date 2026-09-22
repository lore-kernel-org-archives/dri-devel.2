Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0B0C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F2110EE61;
	Tue, 22 Sep 2026 20:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ne+Bj2dW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ne+Bj2dW";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE75910EE5D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:54 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fTGY/fl2mP7a8jGqkfNL8es8D6KikfJA1l88iVSOPQgWCMPLXaurJ3irOvC3SvC1XpeoQCmg1GtLeZSrH+O6Omfga3+q4KtXE8ZV98cy2AMzf+1b17asrVsrkbnSjRb+DxCeE7iOstqKO/SG0b4xh55llOvWU9bikrXdPWOEUiHgX+ZGwNpmf5jMBW3VXKD4oFmlTeQS10V16XLbkTYOxgfuOSqwhQ//vTcLv2LsOUS17sJJiDV2RHvNasiu94ruHk6lfwVUERgFVGGqJrjPmnGHHboAzMOOKj+XvIUWseJJGvGSpA90eqlxCgjYtpfDwg19ZkqNq0qkMEC//UZJrg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRkYwoeXnXN3LykwIKPUpF8ENKoP7R/3YQrwGvhorL0=;
 b=dHt0hSJfQL9zo41zTkyCmA4rtDI1F6SBz4K6Ydq0mlS4185iz+alxOg/Is1KdND7U1WMXPrJB5K4zR5ko/26yJHc15Jj3Qv6JVmgdE3T8RCA/MZYpINDw1mHXObEWkC5Mf2axtE7TtRTLsgoLraKdTsjRA9OZAId/l5ezF5rxJMY4GLT+whMB2Ca2iv15NnbutKOVHxoMZ+hRlr5AugNh6wIAdo14fMxjQpnJxbqgDuyaY/4FqAxWYhuMqUsyoeK1yIQ6e72CjPYxaLRLmHebv4sef676Qu0xktMA66mweHQOCy4wEtO7hZD+5UVZsTB/ZWPaPztvOMCBacAmSLmKQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRkYwoeXnXN3LykwIKPUpF8ENKoP7R/3YQrwGvhorL0=;
 b=ne+Bj2dWUOicvdnNXDnBtPK3K1TrkEpFdXV8VtevS8InExFAQygOlSycNl2ePrPix4ACNJdq8nkFoz7h3+YkWndTSN5NG81jRsLhqt0aJsArONQPyjfxnsId07lcp4ctd+B4P6Pq/mT6UPp1J/vE/39kfBEkUDQCFtrJQJoGsHc=
Received: from PAZP264CA0229.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:238::11)
 by DU2PR08MB10186.eurprd08.prod.outlook.com (2603:10a6:10:46c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:47:47 +0000
Received: from MI3PEPF00008490.eurprd03.prod.outlook.com
 (2603:10a6:102:238:cafe::97) by PAZP264CA0229.outlook.office365.com
 (2603:10a6:102:238::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008490.mail.protection.outlook.com (10.167.240.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdyAddeOJJlYqBw5ZKXJAv5F1h6LX0xLdn6Dt5NB7lWCWxz+z82okr+3n223cV4ONkehrNmTTTD5t4Kup8A/DyRH80dOU0zXWafKalhn3zI3J5fYqtpimtlLjyMfQocP7xVPlSNE89JBMx+8A12tQ/N4srseYZOSda5lsAPSowljHdaythE/+HGuvzVJoy+FDyp3irPorNSbkJobr4JODGWM3TdedHCyB4UnpuiBXEuapQtDNTGZ6aWutVfC5tJh+cklTGyznFdHsFOvuFO7iCMMkMPxZgvBTpZ6H8x9wFyUE067DAKCKEBBEb6ow+gEv+SypbgJ5h+34jE6RvrUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRkYwoeXnXN3LykwIKPUpF8ENKoP7R/3YQrwGvhorL0=;
 b=PLryKTNo7J/OcVXc4WiK2WoRhJQyZpWX5nw5ncSu3+64f+15NhkPP1ekk4OSanqeniBF0fW+YA4nzj3CRhBImOac/7JtyAW4m82UyI5Dra0GGWLhAaqLP+1+JdKlHgXlbP0d7EnS3uCK1b3LOClhyahNvN2o1eSNo1jo/qpcUJbCI0iARmxLqWbbND3b2yIA9vdAr83LpR/CXFt62xZGspyKTPPoJeBylF0a1jFp4Gyqos/t7CzTipZRG7dtQz16rgHXmFxNK7G/rlPWjdqoRAvQCYhiL1k79IIfuT9OjTir7O+ZI2o28K9wN7yRWfo7Ulni8NSkc3i35QTJ0eAImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRkYwoeXnXN3LykwIKPUpF8ENKoP7R/3YQrwGvhorL0=;
 b=ne+Bj2dWUOicvdnNXDnBtPK3K1TrkEpFdXV8VtevS8InExFAQygOlSycNl2ePrPix4ACNJdq8nkFoz7h3+YkWndTSN5NG81jRsLhqt0aJsArONQPyjfxnsId07lcp4ctd+B4P6Pq/mT6UPp1J/vE/39kfBEkUDQCFtrJQJoGsHc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:13 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:13 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 19/27] drm/panthor: Add AW assignment tracking
Date: Tue, 22 Sep 2026 21:45:13 +0100
Message-ID: <20260922204535.2850094-20-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0234.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::11) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|MI3PEPF00008490:EE_|DU2PR08MB10186:EE_
X-MS-Office365-Filtering-Correlation-Id: ab43eda8-626e-4e82-4b25-08df18eac1d8
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: +iJCVRFVMs1XRnXPJjYy0ugoqGfEtMm58Huw4oJeB25IRhWB2pkgGaW84NeWUNS3dqwUOwo9uTLpq/L94j7FfUPnpaA66SP9j5di22YGeFk6ucIS0/RIT3iXmA1Fabn82hYxI/U6qKDTd+7j6rK8mrjggj1OFOrBF06wMnenpYlabinSUXokeTvCw3mXYf2OyaWomiDePy0ByY++RTFyPD4LGrDLS5r1mRkYMlsSCjvt1Lh69dYFYA5ifrYYUa+sdoymggp5DjzLEtSEmiAY+562AUg4No2I89N9WvAJ5QhQn8RScckSYwGxoqFxmB0Xxb8hPCWLnNjz3DIAH/zNKCrVQPw6ZzaKUJa9cUTx4uwP+xxvsTeMS+B86Xb012NUGyPvSNy2Jgo2tHjnN5ycdX3Te34FLlIq8zV5K/LIJ4lnVs718APaFRH/7WItfxnqbzLSspv93Bz3zaFZZ8RZ+71VFZUFMsXs4ffzQlptDsmYxL1HcpXFsp/S5u9An8rztvpgC5l/gHDdPLU9rk3WPt1bMzDSLQT2yN6wRCS88tQA2rGN/HglE7ICOQK1omxiErXebV4p2k6r8p99/F7wN5Ep42tNmRx3Y9NToWu+ahuAxLUBYOUcCnRrFCTOfDhdQwzsNeJx7f8GtqFj1ECKRfj8dd9kM4bBcboj6cv/uK0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 5idUmrvpMtjO0C5O8Um4A/KxcWsAvZdOb7YmCXGMXH9dYShEyRSDG3AWXxZs1zCfBxNs0R8wHF8fsvxy4XckUCkI8MMa8aAJS64Y0KpSpzezRSLGk9qBPpcfcq4O3P1ZpNLHo1oyO2oTvbINP1aYVTwCOZd+ka3lgZEqZIBrwkhQYRkYLlrF2y6HxGgGyq93S1MOQSCOe8PTszn7k4EAu9O6D998B8ZcZa1W6ZuBQTaBmsyAY4j3fKbKWr7SR0iJR1F/s05nQQT2Li5e8BroyV6mUs6BS73AsB7bi97HVMUYQzz7I3i2ZG/VOj7QYz/mel1SqBUFbEf0SsWy6HsfSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008490.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa0806da-0a5a-4801-1742-08df18eaad8e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|23010399003|82310400026|36860700016|376014|1800799024|35042699022|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: M2ckxiuvhgFDLRsj80bSTWRvKgYSc+RBZ2OTdXpZx8nYOC/1KR0/KSUHGpc8Uk20uF0pYpW12a2JyxjFvfdwyRRIMblkW9d18c04fllXschWhUJiEj1EyGAm68IDhtHs/Vi8Yjme5BsPtAg7aYo1AtxBWZ7afFgNhpSj0IYULcQhHVApLaTwcjE68FtvS7deoo/aOK/xBvGekqdF8cZLG5tVuxXiNgkjqthE0k/MIqXg3gjnvHHoJdNLzuoc3dM7v0gPyp9t7vEf3UOGedbr8FKCF8C8xRgdXWaPqlZ2L393dkKc/pMixM2SX7ggAeaP5ehyQkK2EAqa4+lNlnXd67uTty7U2nkpr//RfZ+RuxnI3HPjiA1YxlhMB78dd6bRS30ggNK7zDnkXkyTKmrGx2YtHNFv7QQXVlwHbgaI5Zg4aD/d3Nhm/idQsQ4cOwlkGwl6SlJVnRsu/wjtIfQ4jZ4ckc85N75cYPVQunGGecdSyKBSm37pSKkg7DXjwPf58GeKxrPazFjt/PTQutjUb4M9A5idI1xD2YWoZTwbTiZzYoXKljrlvRkDpkIWxWIkDjGS4ySjSILa1tKqq+zlN9kbYnfmUtxolLduO4Nae2jsGS4jPxeNMI4NxZhDFaoCl9ihzLUGdQVLcOWlsr/MkYouMnlN3am+UrQiGiVdk4zl6aR6NbgtPdwVJxNRyjRkp6ZpRI6IunLeoAJuYWYIIw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(35042699022)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QtvD9JCD9kpBK1R9wkixCfEoGyX66Wv+p46TDeEIFIPit/0eglfOzdODWiuAdEIwlEMzUtbNJf8UAoRSw4WXGkHeF2Y3d2lVnc5TcEhgXjbliN6JDNAAt+S0xVSOoeidElBWAILykYVYN4PJS022pU//bOXnsUzNYBGUFaCUw+DTRyTPuCsY4zldatGqXmDdNG8sw0OesOfST60BcGnQH0378euHpk38DemUth9qs9oiqYZHQXLMExk69aRfUqgdddhVLaNPHhjgDaxV7JW1wn7V47GM9+nPKzQvsH6dLMYRjLyJ4WUwIZ0a4raDS0P6mhvfmB3ytMpSBx1lCZ6smBgJ/mpgIzMskqCwY836oQTqQjQ1U6xful2FQpEDwS2+91jti3pKwa4dpNPzmGUsOtuLhWa3hQDB99bFJGvJlYJ+WnNpqJ9vzq9/s4Dl3UOG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:46.1594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab43eda8-626e-4e82-4b25-08df18eac1d8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008490.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10186
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

Track the scheduler assignment for each access window using the default
access-window masks parsed from device properties.

Use the mapping to route request, idle, stopped, grant, stop, and close
events through the scheduler associated with the access window, and keep
schedulers disabled while they have no assigned access windows.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 .../panthor/arbitration/panthor_arbitration.h |  15 ++
 .../arbitration/panthor_arbitration_drv.c     | 201 ++++++++++++++++--
 .../arbitration/panthor_arbitration_sched.c   |   2 +
 .../arbitration/panthor_arbitration_sched.h   |   3 +
 4 files changed, 209 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 149221333eb1e..e1d569158ac6c 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -7,6 +7,7 @@
 #include <linux/ioport.h>
 #include <linux/fwnode.h>
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 struct device;
 struct panthor_arbitration_sched;
@@ -26,6 +27,11 @@ struct panthor_arbitration_resource {
 	u32 id;
 };
 
+struct panthor_arbitration_dt_info {
+	/** @default_aw_masks: Default per-partition AW assignments */
+	u32 default_aw_masks[AM_ARB_MAX_PC_COUNT];
+};
+
 /**
  * struct panthor_arbitration - Arbitration device
  */
@@ -44,6 +50,15 @@ struct panthor_arbitration {
 
 	/** @sched: Pointer to scheduler data. 1 sched per partition */
 	struct panthor_arbitration_sched *sched[AM_ARB_MAX_PC_COUNT];
+
+	/** @dt_info: Properties parsed from the device tree */
+	struct panthor_arbitration_dt_info dt_info;
+
+	/** @assignment_lock: Protects AW and slice assignment */
+	struct mutex assignment_lock;
+
+	/** @aw_sched_map: Tracks assignment of AW to sched instance */
+	s8 aw_sched_map[AM_ARB_MAX_AW_COUNT];
 };
 
 int panthor_arbitration_parse_resource(struct device *dev,
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index 723cf605e16a3..f44cd45ea342e 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2026 ARM Limited. All rights reserved. */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/types.h>
 #include <linux/of_address.h>
 #include <linux/of.h>
@@ -17,8 +19,27 @@
 
 #define PANTHOR_PM_AUTOSUSPEND_DELAY_MS 100
 
+#define DT_ASSIGNED_AW				"arm,access-window-mask"
 #define DT_ID					"arm,id"
 
+static int to_assigned_sched_idx(struct panthor_arbitration *adev, u8 aw_id)
+{
+	int idx = -1;
+
+	if (aw_id >= AM_ARB_MAX_AW_COUNT) {
+		dev_err(adev->dev, "Invalid AW ID (%u)", aw_id);
+		return -EINVAL;
+	}
+
+	idx = READ_ONCE(adev->aw_sched_map[aw_id]);
+	if (idx < 0 || idx >= AM_ARB_MAX_PC_COUNT || !adev->sched[idx]) {
+		dev_warn(adev->dev, "AW%u not assigned to any sched", aw_id);
+		return -ENOENT;
+	}
+
+	return idx;
+};
+
 int panthor_arbitration_parse_resource(struct device *dev,
 				       const struct fwnode_handle *child,
 				       struct panthor_arbitration_resource *res)
@@ -95,42 +116,186 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static u32 arbitration_get_sched_aw_mask(struct panthor_arbitration *adev,
+					 u8 sched_id)
+{
+	u32 aw_mask = 0;
+
+	lockdep_assert_held(&adev->assignment_lock);
+
+	for (int i = 0; i < AM_ARB_MAX_AW_COUNT; i++) {
+		if (adev->aw_sched_map[i] == sched_id)
+			aw_mask |= BIT(i);
+	}
+
+	return aw_mask;
+}
+
+static int arbitration_dt_parse_assigned_aw(struct panthor_arbitration *adev)
+{
+	struct panthor_arbitration_dt_info *dt_info = &adev->dt_info;
+	struct device *dev = adev->dev;
+	u32 seen_mask = 0;
+	u8 seen_partitions = 0;
+	int ret;
+
+	device_for_each_named_child_node_scoped(dev, child, "partition") {
+		struct panthor_arbitration_resource res;
+
+		if (panthor_arbitration_parse_resource(dev, child, &res))
+			continue;
+
+		if (res.id >= AM_ARB_MAX_PC_COUNT) {
+			dev_warn(dev,
+				 "partition@%llx: id (%u) >= %u not supported",
+				 res.res.start, res.id, AM_ARB_MAX_PC_COUNT);
+			continue;
+		}
+
+		if (BIT(res.id) & seen_partitions) {
+			dev_warn(dev, "partition@%llx: id (%u) already present",
+				 res.res.start, res.id);
+			continue;
+		}
+
+		seen_partitions |= BIT(res.id);
+
+		if (!fwnode_property_present(child, DT_ASSIGNED_AW))
+			continue;
+
+		ret = fwnode_property_read_u32(child, DT_ASSIGNED_AW,
+					       &dt_info->default_aw_masks[res.id]);
+		if (ret)
+			continue;
+	}
+
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		u32 aw_mask = dt_info->default_aw_masks[i];
+
+		if (aw_mask & ~GENMASK(AM_ARB_MAX_AW_COUNT - 1, 0))
+			return dev_err_probe(dev, -EINVAL, "%s[%d] entry exceeds max AW count",
+					     DT_ASSIGNED_AW, i);
+
+		if (aw_mask & seen_mask)
+			return dev_err_probe(dev, -EINVAL, "%s entries overlap",
+					     DT_ASSIGNED_AW);
+
+		seen_mask |= aw_mask;
+	}
+
+	return 0;
+}
+
+static int arbitration_dt_parse_properties(struct panthor_arbitration *adev)
+{
+	return arbitration_dt_parse_assigned_aw(adev);
+}
+
+static int arbitration_sched_try_start(struct panthor_arbitration *adev, u8 sched_id)
+{
+	struct panthor_arbitration_sched *sched;
+	u32 aw_mask;
+
+	if (!adev->sched[sched_id])
+		return -EINVAL;
+
+	sched = adev->sched[sched_id];
+
+	scoped_guard(mutex, &adev->assignment_lock)
+		aw_mask = arbitration_get_sched_aw_mask(adev, sched_id);
+
+	if (aw_mask)
+		panthor_arbitration_sched_disable_clear(sched, ARB_SCHED_DISABLE_RESOURCE);
+	else
+		panthor_arbitration_sched_disable_set(sched, ARB_SCHED_DISABLE_RESOURCE);
+
+	return panthor_arbitration_sched_start(sched);
+}
+
+static int arbitration_resource_init(struct panthor_arbitration *adev)
+{
+	struct panthor_arbitration_dt_info *dt_info = &adev->dt_info;
+
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		unsigned long pc_aw_mask = dt_info->default_aw_masks[i];
+		u8 aw_id;
+		int ret;
+
+		if (!adev->pc[i] || !adev->sched[i])
+			continue;
+
+		scoped_guard(mutex, &adev->assignment_lock) {
+			for_each_set_bit(aw_id, &pc_aw_mask, AM_ARB_MAX_AW_COUNT)
+				WRITE_ONCE(adev->aw_sched_map[aw_id], i);
+		}
+
+		ret = arbitration_sched_try_start(adev, i);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /* AW to Arbiter events */
 int panthor_arbitration_on_request(struct panthor_arbitration *adev, u8 aw_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_arbitration_sched_on_request(adev->sched[0], aw_id);
+	int idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	return panthor_arbitration_sched_on_request(adev->sched[idx], aw_id);
 }
 
 int panthor_arbitration_on_idle(struct panthor_arbitration *adev, u8 aw_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_arbitration_sched_on_idle(adev->sched[0], aw_id);
+	int idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	return panthor_arbitration_sched_on_idle(adev->sched[idx], aw_id);
 }
 
 int panthor_arbitration_on_stopped(struct panthor_arbitration *adev, u8 aw_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_arbitration_sched_on_stopped(adev->sched[0], aw_id);
+	int idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	return panthor_arbitration_sched_on_stopped(adev->sched[idx], aw_id);
 }
 
 /* Arbiter to AW events */
 int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 aw_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_partition_control_open_window(adev->pc[0], aw_id);
+	int idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	return panthor_partition_control_open_window(adev->pc[idx], aw_id);
 }
 
 int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 aw_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_partition_control_yield_now(adev->pc[0]);
+	int idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	return panthor_partition_control_yield_now(adev->pc[idx]);
 }
 
 int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id)
 {
-	/* TODO: AW to PC assignment */
-	return panthor_partition_control_close_window(adev->pc[0]);
+	int idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	return panthor_partition_control_close_window(adev->pc[idx]);
 }
 
 static int panthor_arbitration_probe(struct platform_device *pdev)
@@ -148,8 +313,16 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 
 	adev->dev = dev;
 
+	mutex_init(&adev->assignment_lock);
+	for (int i = 0; i < AM_ARB_MAX_AW_COUNT; i++)
+		adev->aw_sched_map[i] = -1;
+
 	dev_set_drvdata(dev, adev);
 
+	ret = arbitration_dt_parse_properties(adev);
+	if (ret)
+		return ret;
+
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
@@ -170,6 +343,10 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_term_sched;
 
+	ret = arbitration_resource_init(adev);
+	if (ret)
+		goto err_term_sched;
+
 	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret)
 		goto err_depopulate;
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
index 41f06af92ce0c..9e26b8f92b69a 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
@@ -585,6 +585,8 @@ static int arbitration_sched_init(struct panthor_arbitration *adev, int i)
 	INIT_KFIFO(sched->queue);
 	sched->active_aw_id = -1;
 	sched->phase = ARB_SCHED_PHASE_IDLE;
+	/* Scheduler is disabled until its resources are configured */
+	sched->disabled = BIT(ARB_SCHED_DISABLE_RESOURCE);
 
 	hrtimer_setup(&sched->grant_timer.timer,
 		      panthor_arbitration_sched_on_grant_timeout,
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
index f1f50316a2fff..803a405964a4e 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
@@ -15,6 +15,9 @@ enum panthor_arb_sched_disable_reason {
 
 	/** @ARB_SCHED_DISABLE_TERM: scheduler disabled for termination */
 	ARB_SCHED_DISABLE_TERM,
+
+	/** @ARB_SCHED_DISABLE_RESOURCE: No resource assigned. scheduler disabled. */
+	ARB_SCHED_DISABLE_RESOURCE,
 };
 
 int panthor_arbitration_sched_init(struct panthor_arbitration *adev);
-- 
2.43.0

