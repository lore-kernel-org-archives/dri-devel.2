Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163F7C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B67210EB09;
	Tue, 22 Sep 2026 20:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="muphYFJq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="muphYFJq";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013049.outbound.protection.outlook.com
 [52.101.83.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3651A10EB09
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:03 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fJRi4T/ORM/uU6oOk/AFHkxrbw4Z55K1SgrKMa/xs+P8Z7ePQIYpAPpWhV8QGDkvXNlKQ7kSJ7Bc7XvSZajWy0V96eoKlZl1621rdQvx3YfT+VHNRRMkXuncT0x3MwshD4JVkN0f+6kNz32yABAyHZlTXO6VLdQV+/oX5isFs2rpcUfNcHuVY/47ZfYLt4xUYqih8WVVHtYGzI6vA2Re3mOwx6xvJ0PHdUqeMe+U2HCr8lIacfMmxYsvNMLjNAaNLb1ifFckp4IXTbtbBLxnMXdGqzB5Xab4v7x8OBZdAeHk2yDd6gb1LKTjq4aghFgjIgmRbRJdpU4l7YMydfXAJg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oree9r/U3c4rnsEUaSCo/nIcAgylEsSjXgOhfahbCvs=;
 b=YaSSfgJ9dmtX2Bm0bXFNjJJEumu8iFq0S1MxFhlvbRa/yTRE0iSwIanKAHrSIN4GpmhpDHsGm0jKjuE3iz+EHK4hUCb016rWBz5qdTVNAmx2VWdVyYsmMnSLxxKbsFEaHkrJOERdaCQCPaqmT8YMmUaCAd8sWV8OUxM7hQjT79grRMWYMFgYibnMNNKNcTSx8JnWa4GHZLCfBUDUltF7iebJdC0Ji0I1WJ2atyMf7zONTbWjtMXs09g0C8QOMw62ljBo9Dk8xalS6UAXfFBUFWP+Yj1SErjOQLqwCTrSA/Xu3eVUgkNrIFHzZfaCetlJh6d/Nhj/oJSF4sZGOLAC6Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oree9r/U3c4rnsEUaSCo/nIcAgylEsSjXgOhfahbCvs=;
 b=muphYFJqhOZhEFTnci6G0Wb6qCTJtbH5lgwwct69atPxbDZpDLhuNncJvX8JlXPXH8ncWZaJwPEk/7QkhevL2ZN500cMGogOaE6HfCKpUlljKsSEx3uO4wtvaXLEF3U9CkXzsSfOg9cA8LmpkbwRHJQnKkdezyeSDKdBaVHqrmI=
Received: from AS9P194CA0022.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::28)
 by PA6PR08MB10739.eurprd08.prod.outlook.com (2603:10a6:102:3d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:46:39 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:20b:46d:cafe::98) by AS9P194CA0022.outlook.office365.com
 (2603:10a6:20b:46d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:46:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkH8tFMOyaniOpk02z20VboR2knkvmuvSKDAN1cUTDZYnmV+SOai1isf3y68cUYRse+vKNHF3k8078Ou9vW5RrHeR6WmrAtL65/eUhXcxtoDmDoxsbrPVAFr+hxtLYFZMlYn4RiQhpaNcatPAHRueZaJkfYvWDEhprOX8/ZRciuTvnodTSwvL3ciXszwA/ZjTPKNgUPFxzjy7ZGixNSF7K2sTSzkWY59XJpqFJVRMYTWqGpz0fmbUJNx44beD/AvgLlZOFby3JeOl7+yPjBUa07+RK5ARTlujQtLoZFDTNTsUmFKoL4ymgTY2wgBC+iqz7aVQIJdJNDNSEVQdMj1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oree9r/U3c4rnsEUaSCo/nIcAgylEsSjXgOhfahbCvs=;
 b=cycbKIzGeadllK5No66G2onu0cKzQyQokxi+/0V4UieMbK/FzM1xxUUZz1z2FA6ckZhMga7Q5/O72hS04150Fng1JbTodm6DX2SvDApc/oK3mHIih3XUnvEu8CuOZeexGAU5SaHT/kQUqBDTYMmf0sbctm+M+dDd65Pn3Blscm0DsuNRzpQCR8VVwdO0wSMWZQYXfxX6iO+DgL38RNAEkGFfh0yzD8eBRa5HE45A3alvmZHN+LFdraabmbjaVToF4yCoirdqMuKLacOd62TQYVWnWjfkg0c9ubpMby8cb4TfEyKcrGigXuUAChligy178e2pmFdNJv6+gIllIt8o6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oree9r/U3c4rnsEUaSCo/nIcAgylEsSjXgOhfahbCvs=;
 b=muphYFJqhOZhEFTnci6G0Wb6qCTJtbH5lgwwct69atPxbDZpDLhuNncJvX8JlXPXH8ncWZaJwPEk/7QkhevL2ZN500cMGogOaE6HfCKpUlljKsSEx3uO4wtvaXLEF3U9CkXzsSfOg9cA8LmpkbwRHJQnKkdezyeSDKdBaVHqrmI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:06 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:06 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 02/27] drm/panthor: Move register access helpers out of
 panthor_device.h
Date: Tue, 22 Sep 2026 21:44:56 +0100
Message-ID: <20260922204535.2850094-3-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0201.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::18) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|CPH1EPF00000520:EE_|PA6PR08MB10739:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb6ea97-065f-4e4c-54cb-08df18ea9957
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: kZngVoAazp3m2Ua7GA12oiMllRL98qTtwvI4C08fr0sUjNGv+L99uN3B1LIBpzX9Hl8LRZVzfsHbdgghPBBJ78QPY/3NoH5EHoC2HIBy6D7uzxp+f9XA4ovbU1PDydjxZo8MUSQtz4JuHI0s2dv38NB2aQwQJb6OHqdTT4n/SqWCnqla750e1N3yQDnH7dfXGTC/eTrLoqL2frT/sVwe/AyxwEZV4H7bwn/NEPM828e2FeF/YE+gLj4AShgU56nQ6z3MQoBu9xbX8438Bgsvz18SyjYCjEdjMx3AeUufmFPUV/oO+IrNwYnPT8We/DOjwxvSeD9mxJ8N7/EcUlpw++cjGU2Lqs2TQOYKiqgLiweViOBXuAnh5wxSs+1JjeF8wjxc6Pc5EmkQnLcIwnunAoJNPnLRMXyz/oo8SKbve0y80wcrRfRB701AlfHbtUS+Vuxlzq4ri3ZjnXvps/40pNbW24OEcoV2OPcrOXWe6iIzutMWIWSyT+NQSMIdRjSo+GbPB0PdhMOOIFdZs6K7pBWWSu4HQRBwSbOFrO7oGf+hbeyZiyKgPFVKC3ykRfdZj40o6ipspxPzSv6mG7vx46t4Td6VMwEGScWk43yVRGQcDTtskLYflhz21XIsNbMWAY1/YpSxNyRUELwH1UiNRg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 5ZyYXFFiRjoV+0heVnfgUxwLAiUUhl652OsrOVeEh0p8CqDz9s8tLHIIDCy3suvxWFlXz9wocn+khh9FtLJ4t/8jIdxbcprjO/5fZG7Lg26i2z1gABodZWgujT5l1qkxy0brdo8UKRpCBuPDQUp0ubTcio8jFW6R4WeGmen73Jfp8RKkMwCFaD8quInF67eJoS/sYLT8y9SBAKqtNN0EK4ZhNCHSUj8zz5Dhp3Xy3N+M3pgS/U1OweBHVucHfmgzOXtQGLlPJTNidPiFgnOnz7LjXNAsPD7SOdl2IbeeGwv7bvoYq9c5+W2dSImCrOZVHVPIbEw5jE48BkrUTIbTyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 43cd8b07-47b7-4859-7f2d-08df18ea85f6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|14060799003|82310400026|36860700016|1800799024|35042699022|376014|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 74x8W779E0rRQ7hdsNM4FS0U+Rn2r7lU0YlY9TIavDT2b1/dEAVO64693/dOf4NerbdfhZ/sQmrkIeio1e8CDF5O9o4YMADIJzgy7lI6NcOxmzS2+z6RHCjh7lZCIMFuqZC99f7Y8nzASmLfVVLFoOocGIdofQdnAHQHWrgKxhsFDAAgertEqjlcKbhLkJdHuyAWQRlYoVbxrzcjxoc1SRZ1nqR8l1IeLLIEvzQNNdaHdcBPjZrZ12VI91kMOIkz9KF5ZczYfLqfzbxR3ZL5WGkBgXn5/ty9m8m60x6NC1JikIqyxFuAtU4z+wbOLnB4//ANOw9xUvxaxfvFDCj8Z63G2025M7MkCJtPirjxMvAcvTdFUqxlJ4FUGp93E5ExP+PtUYGYwo6oRBJRef3YrDDf/behWdKvpnSX5bq+kNs2YEpLazyHHR/nhQkWe4fl0tbUNiyOjSE64K51RbIrtaXEQ8MjxSFUSxeuIhK9RXcxDsI40dAlI65gqdXbU2qidLDR6BEr7+2Q1CjclrI21ZYosuk+0qvCY+QwkdIsPXJf5z9BlaBlL5IKdm4gIB4e7qhy6QbT3HSTmcyzzAyqJayaMwWJAZcUsWmlsLvsRZKkaSHHocCDqRmcRSV/Kfic72QwcZIfi6aDcHA09OILC0zEnEl6aGCBirWe6stBZZNkQmMX0OCccg0f+Pi0M+gy
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(14060799003)(82310400026)(36860700016)(1800799024)(35042699022)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b9rMmLDsdhsD2cHRrpFjyNa4RMBcuGI05a42dN2BwbepZTfShoH5qgO4Xzxhv4sDNbgvnb+CxtqeeIwyazBP6xsPt4+D5kHjavdmHlY4ZfJCSovZVunCINQYQvsyIJeP6wjwJWTZSZi1RwastamBKg00Ap/leMIOGRurVce9l7Tq8Asq0EsajR6VnFUzbyVITSbFqF+IU2ood89GnSG2QGJQkB9R4EQ0d+rLCXMSDwR1PMcrA7KXpfSW36Xo/01xx+DteEduLt+waoP1zWpAqDlyWSrDar5N5CRs+trZfPa49kcXD47DB9QtgndluHfIomc2pwY7idnkAVAYUNUBiPLQlAMZGnL0AyrsGLk6IW7CMxnmaSQSQHeCClFPzAB+MjmtuebpV0A+BJsGVoALnY9szYw157gWqGPw7M285ZgAbSNTf3VVR48Icm6lkrUd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:46:38.2340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb6ea97-065f-4e4c-54cb-08df18ea9957
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10739
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

Move register access helpers out of panthor_device.h to allow reuse by
other panthor drivers that will be added to enable v15 support.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Includes "panthor_device_io.h" directly in "panthor_device.h" instead
  of peppering multiple files with the header.

 drivers/gpu/drm/panthor/panthor_device.h    | 74 +-----------------
 drivers/gpu/drm/panthor/panthor_device_io.h | 83 +++++++++++++++++++++
 2 files changed, 85 insertions(+), 72 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd414..54031c5252473 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -6,7 +6,6 @@
 #ifndef __PANTHOR_DEVICE_H__
 #define __PANTHOR_DEVICE_H__

-#include <linux/atomic.h>
 #include <linux/io-pgtable.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
@@ -19,6 +18,8 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/panthor_drm.h>

+#include "panthor_device_io.h"
+
 struct panthor_csf;
 struct panthor_csf_ctx;
 struct panthor_device;
@@ -495,77 +496,6 @@ panthor_exception_is_fault(u32 exception_code)
 const char *panthor_exception_name(struct panthor_device *ptdev,
 				   u32 exception_code);

-static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
-{
-	writel(data, iomem + reg);
-}
-
-static inline u32 gpu_read(void __iomem *iomem, u32 reg)
-{
-	return readl(iomem + reg);
-}
-
-static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
-{
-	return readl_relaxed(iomem + reg);
-}
-
-static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
-{
-	gpu_write(iomem, reg, lower_32_bits(data));
-	gpu_write(iomem, reg + 4, upper_32_bits(data));
-}
-
-static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read_relaxed(iomem, reg) |
-		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
-{
-	u32 lo, hi1, hi2;
-	do {
-		hi1 = gpu_read(iomem, reg + 4);
-		lo = gpu_read(iomem, reg);
-		hi2 = gpu_read(iomem, reg + 4);
-	} while (hi1 != hi2);
-	return lo | ((u64)hi2 << 32);
-}
-
-#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				     timeout_us)				\
-	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				       timeout_us)				\
-	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
-					     timeout_us)			\
-	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
-				 timeout_us, false, iomem, reg)
-
-#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
-					timeout_us)				\
-	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
-			  false, iomem, reg)
-
 #define INT_RAWSTAT 0x0
 #define INT_CLEAR   0x4
 #define INT_MASK    0x8
diff --git a/drivers/gpu/drm/panthor/panthor_device_io.h b/drivers/gpu/drm/panthor/panthor_device_io.h
new file mode 100644
index 0000000000000..2287a0d9f86c2
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_device_io.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_DEVICE_IO_H__
+#define __PANTHOR_DEVICE_IO_H__
+
+#include <linux/atomic.h>
+#include <linux/io.h>
+
+
+static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
+{
+	writel(data, iomem + reg);
+}
+
+static inline u32 gpu_read(void __iomem *iomem, u32 reg)
+{
+	return readl(iomem + reg);
+}
+
+static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
+{
+	return readl_relaxed(iomem + reg);
+}
+
+static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
+{
+	gpu_write(iomem, reg, lower_32_bits(data));
+	gpu_write(iomem, reg + 4, upper_32_bits(data));
+}
+
+static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read_relaxed(iomem, reg) |
+		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
+{
+	u32 lo, hi1, hi2;
+	do {
+		hi1 = gpu_read(iomem, reg + 4);
+		lo = gpu_read(iomem, reg);
+		hi2 = gpu_read(iomem, reg + 4);
+	} while (hi1 != hi2);
+	return lo | ((u64)hi2 << 32);
+}
+
+#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				     timeout_us)				\
+	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				       timeout_us)				\
+	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
+					     timeout_us)			\
+	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
+				 timeout_us, false, iomem, reg)
+
+#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
+					timeout_us)				\
+	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
+			  false, iomem, reg)
+
+
+#endif /* __PANTHOR_DEVICE_IO_H__ */
--
2.43.0

