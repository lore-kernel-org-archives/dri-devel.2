Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67011CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F1C10F32C;
	Thu, 28 May 2026 15:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QnTyXfgF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QnTyXfgF";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFC610F329
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:06 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GtqWwRt/qxTv3raWH/XbiKP+A9gFpZrNKQaSDGE1DWn3Or+pjbQCwdeXMmg28/qx7PakEHEJot8Tq+sfvZ+wpNwa3hEF1ap5qf22+/j8ushzzl0/sdnEyKX67DbfvRWbspDY5asEgojxgcZzUyeT+UR2SJMAyU9UwDn47+3CsPEseFI7L8wMU9XQCbMBNdcZZB2KSo4A8sC7CHW6AShm/fN0n1M19Eyy3weY40AnAssTjM0tHSvFw6jrCvvtSBHNDKyjTCnXa2moAuF3E3T530WIQ7DsO5rSGYUpmHe2YvJfjL2rqaG1oUgRYnoYv4pLy0eXDMbnPIKzIytyLbkNnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgs0Ixq4GIOAXKi2TG690PcnymTESPlK/cFaoN15goI=;
 b=eRv6tF5iUHFMZJv5LCCTy16WnMpJ6t0nOEuiswVkrNnva+R28RSW5PN71rqxXSR8joA7KK9XLP/MXaLu1oZVgjaMIKWaZQ81efdk4RmCcZ4wauZfItDXegj6B9Ekl7hgV1KYsUdhRCNLfZZRonf7o/8co3L/8zjSRBS0EfcERVdk0ea7KrimYoX4c5SO9jFW/gTQw8Sqt3lSW9cDM+sZsfXxtDx1tlHCGDo1OdAac9poqtz2TWQqmAIzoZ702SzPaaw8GggRqK9ZJHGZiskF036AdiN2Q8PpoZpCj7lflGqKCH8szr7rkAzcTC8vqOA1doK3sst+nF1ABKs9GscMzg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgs0Ixq4GIOAXKi2TG690PcnymTESPlK/cFaoN15goI=;
 b=QnTyXfgFwVXngc2ZWpPBWBbxy7Yr6TfYyruf8YS3zcBKbcWdQ2c8rNLmemBw5ae7bcB4PaqddtI/mAzEboBKvnXdgla/81SOxjtDclg+tvG/4cMUEVQeLqgTBm6DgKITNSQzkZqoQkVi80FJwy4VDyQSlbrs3Ah77GCaY6Xj5/g=
Received: from PA7P264CA0208.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::10)
 by DU5PR08MB10398.eurprd08.prod.outlook.com (2603:10a6:10:51f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 15:07:02 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:102:36d:cafe::2d) by PA7P264CA0208.outlook.office365.com
 (2603:10a6:102:36d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.0 via
 Frontend Transport; Thu, 28 May 2026 15:07:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePU80Bbkns/jPQ3SCHUF4Z6fElWmf+64pskAoTGLFVj2N7c3uv0JbJPWtcpbaaY48yzAmYI7swnXgKLB79HF3nbWFSMlsZ8VEYmFECb1VtuVjTU0ss0in/W0zPVWnXUyVxpiNsNrplDPH31mA2Scxxfdb5XrrxEJ+kuZToRytDzuifcmLbrqA9uGwZkgn0INiVyhEe2niUtDzA9JPc7WB2bS132DevEVMwAf1SPBdrF5OOxa23hJnrAnF4/NifmGdVgoKYIuf61MQMfQ9s4aV/ACFvOBgBPALlfq70eICbO6WAdxK1jcT31AYvx+2IRIBUZtQVFC1U6BfLu3u987sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgs0Ixq4GIOAXKi2TG690PcnymTESPlK/cFaoN15goI=;
 b=Nms/FawEWMS3YR60qkkUB6m7+aeueNoawncLMyuIDY3C78e1TE8BU+HoA+0Axehb+MuOgfDaeqHLGNBKQxfT6lFrbJyFmSb2pEjpByzeHjyrpcYY5gTJId5PUy+DKBXhyGhqPpCkHSYTESB48arpVM2vy0W0fhNBqf7/4WxD9IUOj4fGJ9+JRmFIGDvmJ8nN/LvPUB3920KdqKZwdwCyhlyHgr26cpHySNJ8zzi6vur4B7KNcAK4jZW1zZJTf922kcaSb+WgcsitU2rR1yNtY3d6GnOVf2CMlcdsz8wTYS14oOVB1uAtLFJW0H7jS5Ux3NGJ9uK/hobohJlnYUEvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgs0Ixq4GIOAXKi2TG690PcnymTESPlK/cFaoN15goI=;
 b=QnTyXfgFwVXngc2ZWpPBWBbxy7Yr6TfYyruf8YS3zcBKbcWdQ2c8rNLmemBw5ae7bcB4PaqddtI/mAzEboBKvnXdgla/81SOxjtDclg+tvG/4cMUEVQeLqgTBm6DgKITNSQzkZqoQkVi80FJwy4VDyQSlbrs3Ah77GCaY6Xj5/g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:05:57 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:05:57 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/18] drm/panthor: Parse and store GPU_ID fields
Date: Thu, 28 May 2026 16:05:31 +0100
Message-ID: <20260528150546.3168527-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0073.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::20) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|AM4PEPF00025F9B:EE_|DU5PR08MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: ea544cd4-6a0c-41e3-f2f1-08debccac539
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: LfrFZUMJdQn8gCc+veQau1ABSDieiLqjhOshlRbJSIvcA65dr6R7N4f71aHgaOtD8kRa4kqjtYXTrYAO2cycJe16xgTxx43pt4m1+mM1jFztKlHFo6YGsQOrH7SdJHPVYK3dt1/FsF0y8Mq/h8sPfd7zNfJ5wkqz3XJwzN4zEqY+4foH8jURykUuqh4vDUG6q1J3JrWZzr7VZ0NiXSd3ZdZvAl/h0A0ojj4L1GETR71SFLW2r1KRILzrYkjxlYI4QZX3BXc73lya5PvTo5Hxq9C00Kzso+ccgtJLwcltDvQvz9UaGGBSopSmrE4eS3mDFKUdVoGIDgOea5J53FY4hijk89wRdR02oW2z7gasfmjC0KTrYjIv32k1t5Km1bHebi9LqqNMkaEK4dQpOqzgboocvj+cHnLfes93Cz1EK/leEs4v/TAd10NXYAhjy9mIkJbqXIr5JZoJ43eb3fXWZ4S8b7jViEnBWSimBgRHJCWs29TXcktDNxthgJx8JUWTzLcgVjV0uMhM/Xu6uZArZ02xLssolldp6JAbU9Uyr2s3f/mPD/w/FjqP1FJMW8ytni/kFs4aslNkY3Nr5C7t3qxWbDM2qtOXSyzShBHCfuyKidAvx2RdWMGvC/EHHPyq0085q7hYhmbUGzIBut4+k2egaAkVh9d/MIDn0fqudurRXnDwN8Jr5ThUx3sAUm42
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: iL1Pr1xtKkUEL9YVG2gH6U8UXYWqdnakFSVaH9HywNiOIl82f6s9HoAZao5+6ePIeLPxDG4rEBK/XF25TdcH0Odo97O0rj0Z4Bf+fWSsqMfOnJ14D3sLrxIhyhSNgZd6nu1I+gn6lTMWVVYFedYGLdL2vN29e8kKn+3yvM9OX6JgIviBPVxhIUqSv49Hmi+gvpSwzwK8GxORQS+xr+rJFsHybtisI9Z8OeKbV9kUjgI9xowEjzprR0TX0ZHR5+bXWCxkZ10wT/jb71MrSbV/JYJk+xFfiCEuPmQWg5yj+zEjoe7jj4k8685CO0dxv2puelviSdp5jjUnTw6BQnxHog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 19d8cb76-c721-4047-d692-08debcca9f58
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|14060799003|376014|35042699022|1800799024|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YdnZLTH+mWgdjmAGgfK1GsZB6eIu5coxj55K/R33LERdRT82V9WGmdy3J+h8trgw3VIyDMH6A8HX1BBYcC48cy0F481zfq4hZl/XKLSZ2BdYlH/R69SDocV8RvAfXLbcFkaz9IzvR7aJNL+L8IdTm30VUzpwUpc1lyAIyLSiQKe0SlN4A6SUwtrocfuUjAJ9GBy+d3yZ0mqcEkC3xjWxVPwLZlLKAf24UjsB4m7f2hzdbOslGlbYw4KifR+DkNGNZNFTNgjVI2VibEYumKOUPIgBOuMaV3r2yYh88ReV4plWdzhIqgZKww1L3rDPaH3h3ObwQQ0WyljTdk8oW7OMyx9p6RBp3qi6p82j0i8g9ZRZLKsCO1ltmYYn/oCxZyStRBxiw3rcP0N8Qj1A9YhH9TfLMcRpUk+KAqAFDJNmTHOdca6MuS7UlydjdcpWV2/fIwgg0LjFYlPrzMBg/2eMjlvN7jYhZVVHyc2j/uc3ErceslCqiW/5Ilr+ZHRucYmeGkJmiiXFR1cyKbCXOGP1AFiVkOndu9LNr9QaBUgtgkpCHKn8Pkn/9Sds/O185DK9zFaNt6BBw2u3OZ4OrAYtDmu1ZLCG0SNWKKZqiH1VG8j+Se4vurwDr5hwC1CUVbPRVELvljkTC3jnJhgGG8g69cmmcShNYagVQxc/FHjgThNxuxynk6tLU6PIPtbca5tW42G8RTxcsW9qHyYuHqx1orW4E5O6viGrkGg5F6SIKkg=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(14060799003)(376014)(35042699022)(1800799024)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xJRTNGunWSG/oPbVm8VVKNqPmkpvkrKxivNwo0E1/RBaoY5lxNg5B+/g8bn7FM8Ab4ydBJYREpam91MCfhkfuDCeiUU+bbSJoUo3lMQzaNoDDaRy6m+nENsVM+ZqQff3ysq5Y5phkt2XmTqX4fv8GR70WiDRcw3VHIXe5up1cH76/J84FSotrKhGsbNEco9UuHGuzeGgFk3PT6SkRDyrxLIB4+kBSvQQu9qxr15X9wHTrDJjxMUb52WankjDBykib3AqHkrNWk9twDm5QHcP8d36Tz9G3p+UL3wka+zoC6al30flmSCpKC+VSmXEy3VVl1ZBsYn5v9yyri9FUmsX6gkd9EmSabiGs3ATceYi8z8gSO6p7EgEqAUZEDbnyiojnqsbzYRSByqrnY0xuFLpgTARyU+YtBSGJU/MVy1p7O1TUMlTZXPJHe4hRUcPHpzd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:01.0542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea544cd4-6a0c-41e3-f2f1-08debccac539
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10398
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

Prepare for Mali v15, where GPU_ID expands to 64 bits and its field
layout changes.

Introduce a small panthor_gpu_id structure and parse the GPU_ID fields
once during hardware initialization. Convert existing users to consume
the cached fields instead of extracting them repeatedly from the raw
register value.

This centralizes GPU_ID decoding and makes it easier to support both the
existing and v15 formats.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 33 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_fw.c     |  4 +--
 drivers/gpu/drm/panthor/panthor_gpu.c    |  2 +-
 drivers/gpu/drm/panthor/panthor_hw.c     | 26 +++++++++++++------
 drivers/gpu/drm/panthor/panthor_hw.h     |  3 +--
 5 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index c376e52e8564..8b2a9bb426fc 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -104,6 +104,36 @@ struct panthor_irq {
 	atomic_t state;
 };
 
+/**
+ * struct panthor_gpu_id - Parsed GPU_ID fields
+ */
+struct panthor_gpu_id {
+	struct {
+		/** @arch.major: Architecture major revision */
+		u8 major;
+
+		/** @arch.minor: Architecture minor revision */
+		u8 minor;
+
+		/** @arch.rev: Architecture patch revision */
+		u8 rev;
+	} arch;
+
+	/** @prod_major: Product identifier */
+	u8 prod_major;
+
+	struct {
+		/** @ver.major: Major release version number */
+		u8 major;
+
+		/** @ver.minor: Minor release version number */
+		u8 minor;
+
+		/** @ver.status: Status of GPU release */
+		u8 status;
+	} ver;
+};
+
 /**
  * enum panthor_device_profiling_mode - Profiling state
  */
@@ -160,6 +190,9 @@ struct panthor_device {
 	/** @csif_info: Command stream interface information. */
 	struct drm_panthor_csif_info csif_info;
 
+	/** @gpu_id: Parsed GPU_ID fields */
+	struct panthor_gpu_id gpu_id;
+
 	/** @hw: GPU-specific data. */
 	struct panthor_hw *hw;
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 52f176644aa6..784d0a25beb2 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -799,8 +799,8 @@ static int panthor_fw_load(struct panthor_device *ptdev)
 	int ret;
 
 	snprintf(fw_path, sizeof(fw_path), "arm/mali/arch%d.%d/%s",
-		 (u32)GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id),
-		 (u32)GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id),
+		 (u32)ptdev->gpu_id.arch.major,
+		 (u32)ptdev->gpu_id.arch.minor,
 		 CSF_FW_NAME);
 
 	ret = request_firmware(&fw, fw_path, ptdev->base.dev);
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index b63a33fe155e..bb5e64188a15 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -74,7 +74,7 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 	if (!data || !data->asn_hash_enable)
 		return;
 
-	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
+	if (ptdev->gpu_id.arch.major < 11) {
 		drm_err(&ptdev->base, "Custom ASN hash not supported by the device");
 		return;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 5cf54028f606..3570e2889584 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -120,9 +120,9 @@ void panthor_hw_power_status_unregister(void)
 
 static char *get_gpu_model_name(struct panthor_device *ptdev)
 {
-	const u32 gpu_id = ptdev->gpu_info.gpu_id;
-	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
-						GPU_PROD_MAJOR(gpu_id));
+	const struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
+	const u32 product_id = GPU_PROD_ID_MAKE(gpu_id->arch.major,
+						gpu_id->prod_major);
 	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
 					 GPU_FEATURES_RAY_INTERSECTION);
 	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
@@ -246,13 +246,13 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
-	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
-	status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+	major = ptdev->gpu_id.ver.major;
+	minor = ptdev->gpu_id.ver.minor;
+	status = ptdev->gpu_id.ver.status;
 
 	drm_info(&ptdev->base,
 		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
-		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
+		 get_gpu_model_name(ptdev), ptdev->gpu_id.prod_major,
 		 major, minor, status);
 
 	drm_info(&ptdev->base,
@@ -274,7 +274,7 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
 static int panthor_hw_bind_device(struct panthor_device *ptdev)
 {
 	struct panthor_hw *hdev = NULL;
-	const u32 arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
+	const u32 arch_major = ptdev->gpu_id.arch.major;
 	int i = 0;
 
 	for (i = 0; i < ARRAY_SIZE(panthor_hw_match); i++) {
@@ -296,10 +296,20 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
 
 static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
 {
+	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
 	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
+
 	if (!ptdev->gpu_info.gpu_id)
 		return -ENXIO;
 
+	gpu_id->arch.major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
+	gpu_id->arch.minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
+	gpu_id->arch.rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
+	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
+	gpu_id->ver.major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
+	gpu_id->ver.minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
+	gpu_id->ver.status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index f797663893b2..2a666d8cdb98 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -5,7 +5,6 @@
 #define __PANTHOR_HW_H__
 
 #include "panthor_device.h"
-#include "panthor_gpu_regs.h"
 
 /**
  * struct panthor_hw_ops - HW operations that are specific to a GPU
@@ -58,7 +57,7 @@ static inline void panthor_hw_l2_power_off(struct panthor_device *ptdev)
 
 static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
 {
-	return GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14;
+	return ptdev->gpu_id.arch.major >= 14;
 }
 
 #endif /* __PANTHOR_HW_H__ */
-- 
2.43.0

