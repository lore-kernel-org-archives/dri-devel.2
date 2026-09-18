Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9621C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 05:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0396410F17F;
	Fri, 18 Sep 2026 05:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kU3lKSuk";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC0110E808
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 05:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IU4awKQ3B+zDsx2Gdnz7La06QLkqxvgcHSobiicIqS3oyA6OM4lARmUDc7H4D5Mdy84bSwLketh4yPYz/4CZgy71CsswPgevnELFUw30ed5W1M5wrYCbnsPtRbrePhuw7+iNPMeWV9wMw8PBCCpDG8UKX1ObTXVGsvd1mVswzWCsOaX94KZfYs7ANtvkB9AQhjZvPcM/andSz+6ip0PoEpBWBicHhk8VgDX0VSbZC3ZI1ZPLUfo/O888yuVevvyUeaW7oO6EXcNWG4xg7Df7HucmGZJfgTbfOTPMSZBGEpgZjnsbKJT4c6/JE6Z2DXyASHJ7CeFm5kvY2gIsCXjO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdkZrA3wbN710BLhTOaOVBFMs16aeywP5bUKbCBpAT8=;
 b=C3v4+137UJRaNxn8EohRgxc9z9OT/NbV6ayQzAp6U9HehZXRFw7mSPTXVOfRt0LsbXgwZ09WBeXik36AeR4ZblbX40NOEuUTsMQ98v1nd0rfNMDaPQxqXwco+7a68GzEezzB5hkz4OaBIHfeHPalrwykiq8JRa8sPtMVuedyvjryKNT2MqJ4tPT9e30NWl9r+QdNNTrkbCmspN+GptTHs/7etvBSeg6Fe47EFE0Ld+Vv/0h/deCv8RFtmOuvhkfA2DszxDiLM+WnUsKt9ggpLlc+SxBhHNobrWWRVscEFIl4N1AFzqLm5sJjAHeoUQnCSpLMjoNQaWsqRMdzmysGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdkZrA3wbN710BLhTOaOVBFMs16aeywP5bUKbCBpAT8=;
 b=kU3lKSukl9mor3LXgL9aqzeSugoG3/whkw9KHfxFl8BzQP0xGjISlOQz712epRfk5jiOaV7DZIgFBqeTKB94kUb3eU8HZCaURmrzcvHed6rZhVim5KImnEFCYeFfwuimOCpRp1m9iSo/ss1BMRINeP3MdX9xf4IY3WvZo38TwsE=
Received: from CH2PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:4e::33)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 05:59:32 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::6f) by CH2PR02CA0023.outlook.office365.com
 (2603:10b6:610:4e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Fri,
 18 Sep 2026 05:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 05:59:32 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 00:59:30 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 2/4] drm/virtgpu api: add blob userptr resource
Date: Fri, 18 Sep 2026 13:59:15 +0800
Message-ID: <20260918055917.2133574-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918055917.2133574-1-honghuan@amd.com>
References: <20260918055917.2133574-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5d5366-23e3-4379-0af6-08df154a02bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: N68QX7qjKxtdlMWfpaw0eDGVSbw9jGLO+1xi9ZXf8q5LQo38awIiwLhKQYilrdc6nfw/3DhDLk3rYEag4Yq1IYew0Lb9SZXaj6EVU4oM4Z1pE0beq3Vp3VYY4TzcKr5Th8bZW7j8D5s81d4ZJiCrO9S38QpHPIoJFV/lD4pPgTxWTUF5NaOQgj23jnDz8Rfs6sz/py9d/ZXmWVRMXwmmGHKcFt8vYToBKlQnGrnAfiijc3HiLN/DUT1m6dUrb2Fib1Xy+IMQ/AnPlqLNXRNrtDAYtyV3CFyo8zil367pReVm432l0estAFnIAUlwQYVpfWgTdoOLBgDFSZEwPwz4D71DWXfAjLACgPqNuf/VURb++X05MRz1eQE7ynsDU1ZDfuM//RE84t8qBGFY8tvF6FQvAoiPQUF7WHNJDFig8hyq8lUFGMHOJpy1HxqPahVh094nCV/PQ9jeuxNtMhSsIwFpeJAw3c3bfjlzWcpSyYQvzKnT5opxOHoxA5A1Chd1pnWG7w8dNMmL5C8A6mlZDj3xPNPyBqbnrY4p3pI4TOoOyXuSq6th8Jat9fKLu+dsy0YGGEbwLjosH0j4FAhj1UhTHjZpiZy4iOyShqVaRRYXJV1heVNw1xYULqe6oTVAgOyawfMEVA11bS4OybLUmMfUyKi8MsTEXQr6ZwvKIZ/VzBhsRsSjmRzzTrBsnepfgE3NMPSi963GtfGESjaiHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GW4hEDrfR5lVg5Fgh1IedIChXoKzHOWxai5s7XtPJ0lb3LbIN3h4MVNmsA6ApXGj5qMUBVCDlxHn2TDEzCCbWc5FFE+qR9+b4RGV1P0+5Q9EcJB5rBZ7PvONiyTZQrRvyrhOILd8oWrjgG8voL6w786vw/+Q11lx4cbIot/ss9rD7XZPg8kvnZBV8PNTHYgEienmy1YOkAp2c675SoPCrhgG7ChczNbgjGpFyFx73d9eKyB3p42vN6V71BeLc7jRTWODv5J0NVyI/BnBncw683MW0uDZb9L14QEgW29PAh4YRiUFoQOX0XP5NWxo95Y5TYoKSEKqMFqAc1zREASvzOVBTY8HAmuFJSx/ZTfgQ00Ivgej8RoY2xhuIDBYibbtcJ7ktN+0olP+uK9zKlOlfA2tb4Xgd+JOirphJySmemJCmRO5tQawQ/hjq95K14Tw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 05:59:32.7067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5d5366-23e3-4379-0af6-08df154a02bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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

Add DRM ioctl hints and a userptr address field so userspace can
request a blob backed by an existing process mapping.

UAPI changes:
- Add guest-only DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR and
  DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR_RDONLY to blob_hints
- Add a userptr field to drm_virtgpu_resource_create_blob

These hints select guest pin behavior in the ioctl. They are not
part of the virtio CREATE_BLOB wire ABI.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/virtgpu_drm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 95587e12ae..aa8abef8f9 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -203,8 +203,17 @@ struct drm_virtgpu_resource_create_blob {
 	__u64 blob_id;
 
 #define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
+/* Guest-only: pin an existing process mapping as blob backing. */
+#define DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR              0x0002
+#define DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR_RDONLY       0x0004
 	__u32 blob_hints;
 	__u32 pad2;
+
+	/*
+	 * userptr: guest userspace memory address for
+	 * DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR. Must be 0 if that hint is not set.
+	 */
+	__u64 userptr;
 };
 
 #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
-- 
2.34.1

