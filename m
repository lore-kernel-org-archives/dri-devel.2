Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31852CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8875210E81B;
	Tue, 13 Oct 2026 12:55:36 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B8010E81B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:55:22 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jATh2AsqODa07ruRERrZS0+GFjtKTY0PuR2ogIqc2OrPFNflO2B9xKlo7sCxo/AxPXPoATW4PTafOfM94Cxuxh4RS8nNk2WtLMNgQwruZQLK/Zwx3is/gd6uGB4D28pF7U6Qf2EebcS3mJCavis92a2Ko2cuFYWpDVELD1ci/B30RCak3eiEpqIuRCrFk0VMa7FwHQ5Vp1gilrSPoguZSLZHOZ9w9flOadrMAL33K7as9wd9kiqPR3AHEKi5Ed/Zidkr7LoT5QGVN1nXUh11NEc7ltypmdfDLFJ+RoC7zKxeOpGRaAfbRHA7pQrvH0pQeJUteWIePnbaD27WZRI6Gw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj2uFjA8H5tv1QIzEswvkGt177etJ7BujzmuQqakc6Q=;
 b=LU9+kU7zDnICVB4ljHURl2ziwiYF5c3+hQDtMJ49B4CTriD5AJ1zahJB2l8764A8a+nQkrf8T8SoP8J54gn8qffGtjS9u+NXF2Z/gcKu8rIQ+gbZH77PUAJehdqjD0NKN+I0+1Dq96MvJvWwKmz2nBsEQjGeOed+BLr+rvlLNU+UekrLjb3EF91Vg3epef5ApxAYmZIYAo320mGBWHGvWr8e9arTyVDkC8p5XKQAAqhWbZZfc05JfBxdUptZ++P6BBfWQVvu39bupdXybvDOzRp4tPP+JNYJGOieft4/EPONRPpU9KC5Zf11nducdiEGRaA2ClswKi1QdpLALfmnCg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj2uFjA8H5tv1QIzEswvkGt177etJ7BujzmuQqakc6Q=;
 b=ZiyiFFvFTULLiFcDlx+iMqqHCeIWYqv3ZsJ+qrBNJDPOLv07qZgBeJp491XE179geWcTMQDQ8VpZyDaSGfOCznQHZBFsnVPj1FnZaRHY585e2y1WFwz6ot6E0RSDfl+56WploBt4uY5Z433lsJvQ4CzpB8Izoge0kowQtQefvaw=
Received: from AM0P309CA0022.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::9)
 by AS8PR08MB8135.eurprd08.prod.outlook.com (2603:10a6:20b:560::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Tue, 13 Oct
 2026 12:55:11 +0000
Received: from AMS0EPF0000056B.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f:cafe::7a) by AM0P309CA0022.outlook.office365.com
 (2603:10a6:20b:28f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.2 via Frontend Transport; Tue, 13
 Oct 2026 12:55:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000056B.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 12:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWotqWmd3tZx9ibGkpyO9drme4RWsPri0CvZK2D4FF2w1je46SS1ShPsoxWUEpqIbmWvobQeIhzu35vV7rgn0+AYdXOCdTi5SRG3o5yTETYB0wmgo6VP6zWx0HhsGC8RW/wupBTBxXNENxWRs3qdmqUes+ntpcPCi2wfEhINNsm9vjLtWVDJjNvYWOHJslvcoIuG611BK/wNLL4/wfOyG1N4/dJFxfdfMMqgvU67rY37OEuS7m+2KnB50QthiUYNpvrxi5z42VZ3ExB27zld+AI8n4YSUzzw9rm+k6mFLhJGB72ORvG3ktVypMYJ06wr9RhVCT0bleCMswu0uJK5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj2uFjA8H5tv1QIzEswvkGt177etJ7BujzmuQqakc6Q=;
 b=P/TwLy6kfMYJue7CDUbdHB6yTkOtuN8idx21bbQYZeLczwS/FOIXMbY3N/z70KNm02tlAPiVULrMBAN5yki6MxPVXGpAXv9+o4wDn82HaQIKmvmRxoARxpCo6dtFQvnO5NyzlcNQR8iVegZfseM+olawBozhWfmW8AiATvfvyiRAkx7eWrtu1jF4j1RF4Z10cgmrGcvoOEOyC23gyCRgShEZb7s8brTV4c/thIy7XrOqi0YSy3nZANG777N1lrLlM2vZQjfQa5ZtEDr5AVoCs0Bp6oy0Bf9dOR6gR7tq0gKtIqpYKJ+YwCAjNizzqdDD4I7at1Smy75ZpjVH0KlfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj2uFjA8H5tv1QIzEswvkGt177etJ7BujzmuQqakc6Q=;
 b=ZiyiFFvFTULLiFcDlx+iMqqHCeIWYqv3ZsJ+qrBNJDPOLv07qZgBeJp491XE179geWcTMQDQ8VpZyDaSGfOCznQHZBFsnVPj1FnZaRHY585e2y1WFwz6ot6E0RSDfl+56WploBt4uY5Z433lsJvQ4CzpB8Izoge0kowQtQefvaw=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by DB9PR08MB6667.eurprd08.prod.outlook.com (2603:10a6:10:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 12:54:38 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%7]) with mapi id 15.21.0522.002; Tue, 13 Oct 2026
 12:54:38 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com, liviu.dudau@arm.com, steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com,
 Akash Goel <akash.goel@arm.com>
Subject: [PATCH v2 1/2] drm/panthor: Fix handling of NO_MMAP BOs
Date: Tue, 13 Oct 2026 13:54:32 +0100
Message-Id: <20261013125433.26432-1-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0004.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::9) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|DB9PR08MB6667:EE_|AMS0EPF0000056B:EE_|AS8PR08MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 665d358e-4ac9-4372-def8-08df29293756
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|18002099003|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info-Original: Q5xljTYYwWRp4scnvhZh9hfz2qrQuK6e02SirIjarAa8aL55ucU1SrKyU7dkzyXMWklDm2wyhpvI9Gei7PJfjNbvIswn4COzQ3hoBYDOC9i+50K7HzQ15a2WmhdKcIzRY3+kjkp9WccewDPShCbpR14PO5XU3K5oYjWsuz3BqirA+G9HCD9n2VsaJslKK3nnJiQIZkxZX7fXrWuFVtku2U84VqKK47A4WFSKiHLx469y53UtL3elRI9ja+CoBwAT2KYCnGevwGTyK9ej6EgH5qoMpuuuUa5FuFrK/DaJ4kSq4ZjqzQpfAFDduGJ1EvX1F7meWuK+o5KmrBTXeVeLy4docAqAjOOvY1JdYXdXvhXmplBbRbh5FbHxk2BWwOLgBTbEH1XWr7XVuTy+Pp+OmYwNpS6lmYSHt8gNtcOhejk2ZVt5VcETKvw55wbYwoiN2y2f1wayll7qN5CyyK7HdhAjCc2726bI/MjFu5ZQLLAMPCVLK/ma7ucA3fThiJFa6DRQyDdg7mSxxWvm/vvG3Zv2aPedVLsfld2r5a0mCWnRazTe6Jls85rmbah9alwGpIOX9vw8zGkgj9nqU3UuV+EWvdnUDPqV62uTMz27dapAd6Yr/mz6mI7vek2ibwM7JRhbcQAcKNWLOSjiQPFGxf8IWbXasmGCCt/vCo/qF2w=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(11063799006)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: OBLKaeQMxnRJwKz3sagvMlrAI9YwSSdw1Zhe7oJtTdOz7TdssoIUMsL4RU6Zilkbrl5xgOyAN8mN0KeHOZZwtfuuxlEG9yTKBgcAZuqW5yaUKSkSavtYf63BiVz/QUzceO0F+oDAMPrC35rp6wqKHBqiRqBHmJAMd59O7WR+HL5i3szOEA2J1zD5Sla/Yz39uEGHOkb86lHSOMOaz7eX2FcPbWfpFJ79FMTF340CklGTE57BYqrxi2gbVrRLftoAVYAFtNaxaUQaMlYM2n2/siVNsafTmKDZYF6NREpF3Toe9X2FIbq9seBPWP4JNXE59nEQ2xBTXlOuYXgXrhWU7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6667
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000056B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 53b65ba0-20cc-48c3-6535-08df292923d5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|1800799024|14060799003|23010399003|36860700016|82310400026|261009223027099003|56012099006|5023799004|11063799006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: NqF4kyW1u56MVnUG+suHe9rp0f0S3Luv2zj48U5nXE8w2cXZe9sXf2Am194t2MXFCv8D2Gm08tI/L+cj7GY3K8ozhcNUpRFmFIHOMyi2cYrrpReyFIwXpe+3JGGgyhGrtJCG4IkiVZutWE943/6Lgv118I3o1nVARLTB5MgVL1Goou9YW6JuhrWkpJlZu+tnMkxtJjnxsqNNK59JiScCKQS1NGje0p/KJh/eEMjHUN/TMrJehvhOni766iWJMEGsQVSo9jvSYOqYbWkFbeHixekIGuX/gBCO9SG5b45vHMmr7N0PSVY13kn7uVQLhUaC7GrDakQkqV3QPcbE2iWr3SAKvvMWY7Np5buNJgIUDf8ptJqv58v+PLC1KBUXU/qQmLQ8Q//LFew9cjxxtPUU3xVUx9MqF9vl2ornEDsOQvOlVrlEFthNhSId4jHNXI025OsdWPDo5R5lwJg4pZGbcbqdJIg3gtwFrxQk5VnX2VeA4qMZtFzuiq9qm8pp/pSnQOFhSY+9EinhUqMknwA8dzjQGel2h8wpxuhmQO0T362sF85EV62skVy4BSU++fFLeePZhmWze1N1GcyAIg9aT7zXbjykD26bs0lOYVs+9xNV1uDiF1Gpk2eBA2gZPTF2DMOm1ViTpe7O6pWuZhykaQlkO1NEVv3NnmUuoJY2OPNXemQ6yL9nYEqBr0Xuy7huRive4RJYGyzA0j35QZ0PJg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(1800799024)(14060799003)(23010399003)(36860700016)(82310400026)(261009223027099003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yBkBWfXrQz5kaZnT26AX0EgkhCJ3eml32QvC4CIWXvPT32CowRRmwAEbad+AU0LfKPwyOvmZbInHNS8oBoNbZT0VkrpjTRRApfxeqhkovB2LeI0xbpD1xY9suA3LP327IBRva27NsD05W1C21G2cEcoJG3XrO51uCNvPj6l8LvQXHdbtDXBpDdNtkGUY0biJ7D7qTMWtw1Q2H7QusIdYofKhks5VoeFQbv8ZXWUpQkcENPvYKEZ0Zs/Y4d4qwUUHmNHOlXblAH6sPvS0EmUalwgoxRs5OnGLr9/8jA9R5kQW5dWeW4LnB5NQppNmusPAdIRxD34zu7COWZkIPkO3IcEXNT/w0s1+b9lvd+t8JneRcsdIfsiwSfJ3yagfUPLlUSjpqZwj/6JmK3lpYdPQTl9rI2fU3nJDEFCYpwZJMza5+dklkNa6g0sKmCsEJ18e
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:55:10.7827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 665d358e-4ac9-4372-def8-08df29293756
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000056B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8135
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

The BOs created with DRM_PANTHOR_BO_NO_MMAP flag are not supposed to be
mmappable by the Userspace. But after the rework to support shrinker,
it became possible to mmap NO_MMAP BOs. Userspace could second guess
the file offset range, allocated unconditionally at the BO creation
time, and create a CPU mapping. There may not be any adverse effect of
such a CPU mapping though.
This commit adds a check in the mmap callback of Panthor driver to
fail the mmap() attempts on BOs created with NO_MMAP flag. The check
covers private BOs as well as the prime exported BOs that are mmapped
using prime fd.

v2:
 - Fix breakage of mmap() on exported BOs that didn't have
   BO_MMAP_OFFSET ioctl invoked for them.

Fixes: 68cbf96b1e9b ("drm/panthor: Part ways with drm_gem_shmem_object")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index c07a44057e42..22b57ab6f929 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -744,6 +744,9 @@ static int panthor_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *v
 	struct panthor_gem_object *bo = to_panthor_bo(obj);
 	int ret;
 
+	if (bo->flags & DRM_PANTHOR_BO_NO_MMAP)
+		return -EINVAL;
+
 	if (drm_gem_is_imported(obj)) {
 		/* Reset both vm_ops and vm_private_data, so we don't end up with
 		 * vm_ops pointing to our implementation if the dma-buf backend
-- 
2.25.1

