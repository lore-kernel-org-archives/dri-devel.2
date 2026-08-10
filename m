Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E08C5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6274510E7F5;
	Mon, 10 Aug 2026 12:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5b7nBnie";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEEF810E7F3;
 Mon, 10 Aug 2026 12:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FchU4pVbBEBaWoHSffASz7lJwb/mtsM946q1Mq7xTlxvUHhIUKttrqU9gwEw0WKgv3XV0XMClgqSeOi4JoxcCYIIBM16U8SKaiUyY+2NiLcsXkO3TTjue1mI0Ss9akDgZ4MxyDc1HzzTDRc3lwsenQ5GV7L3yS9SRNdDS8ofywAxPZ0Ny8oNTrEjECmFXtKVgtNLorJfVuuRra8Remnhn3uW8YZ2WUe94BCyr69iNdSYr1hg6B6ud01U6tKqkQO0krFp5c8A8A5xLLnsAiS52X2owBpnrW0BRuj2KY5N+UoMqKcJS6WMwOVbQjU5VE1qesaOdfHzSXZ/92i4kPRNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qIcCekxQ5Fq5/83/E9VJQrKqt7nqFA17GW7oKbD7hE=;
 b=aEHv2TXMHMFozb2aYks/nK60tvaZTcV4RfgxXmarkDYLPKmTlL4y/aCybJGYCInG5PkH6yveI8/G/7OSwPKF3UQC78St7Ucu3A2aKPN7yqSUKSvSU4hsCBv1Fej5HRAJljmfM/4roLfdLI9FRYVJKyxKaxWvPawF+JV+YRLVIfC/SfNVwrWaDZPJYPqQ+CcSLyQ97oQkXq43Vqup2+RZJ9kehZmSQzIMkQ2+tPrBlcsvB8+aa6lykiyirkQUy2++cJz0k1bWJFCKM8UAFXuXwp72lTFAiyqogtSg3A0EWxaBq77Tdeyxyo0GpgCw4rEv2JgQGsy62UQYelIXjsCQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qIcCekxQ5Fq5/83/E9VJQrKqt7nqFA17GW7oKbD7hE=;
 b=5b7nBnieUbYaHqcKIbmRZxGTtKsSERm1sZn9NKoJFVG5XAKMh9GWNKO5BLQ6e4TDNpU6FzIKlC8Ag0RTQ14rPt6Pod8zLRZolZBg4MKBgW8SRryQOpG1ytnPe2B4lqAe0Kc2cyplWxogvlXo/nK24jK7hidTfFaXhzbmQx20oJA=
Received: from DS7P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::13) by
 SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:03:07 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:25b:cafe::5d) by DS7P221CA0002.outlook.office365.com
 (2603:10b6:8:25b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 12:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 12:03:07 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 07:03:05 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] drm/amdgpu: delay ttm buffer func enablement on xgmi
Date: Mon, 10 Aug 2026 14:02:15 +0200
Message-ID: <20260810120218.23000-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810120218.23000-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260810120218.23000-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb26f01-9287-4e00-e320-08def6d75725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Nbh+mWjxDgYdjGSVXKwDdIYmItkEjvszuMJVgpN8+f+1hUqgKQsRJoEggxcIzc4A3r0cCRPO1afH34h+oWXa+lQ5AqAM9ftK3edtggCEhmdpCxc7bbqBjcPHjhMC4Wg8vuSg3xacb8X56vSAtYe3RQHpsDW7j/u+9xVfqsjialX9x33rxFOdMh2W74BbG2tex3yBmvUMNDUgLjNyZK66I1F7FmMp4kTkfTCh0kwTro0/79aOCxCNmLv7b2yXG1RKbSP/lH6+uRnj3bTk1GKeqUdKBSHCF34gSJl8ggHl2WlrNezK+96rulHJJdBxNO7AznOgxDLS3wgdxwmyGLu2rPEbCTjOL39QrQMMgG6vZzimEzPK0UsWtqOvhM2K9zwfZEkR+phA0Koc6E/s5jB7JSMSsGZQdo1Yhyyw7+J3SJtYUbJm370euJJq1eW3Ikn2ZupHPPL0SJGWA8z+hjGKOBRs7SZKXH5vRejKMVNzPjYU037LPQNMTTGHIEQ2J3Gi5rUY8ei+dRTYDtj0wpMtcNHApg1YMLKmPNA+Kn6d/gtlZ2n8Neq8JQlv64zz41wyxjFLzLLkSdmjDwtl36GnvvT99xoO6yOscqzNT/Iib19nGWXnx5bbHlzDOx5grj3ZIJRJrvL5aHTao7+Xkl9LTG1ED2chP//ob6TUy8rgbHy01tvLiDG2YRPUq226on5UfRl+093b6jFylO4UYe89+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wsFuTFzuSHj1Hn2iIBI3UVn8UZwhgtMsjiD0Iwdh60xf2BExoJgmVDtAJ7GAb6kIpqGgrllsb3vkt/P2hJosmmJF1ly1DAACPuuYXeRznGIaTDjVZXn4P4KjKRwbl8CsiCLe2Aotrg5EN1i4EZlzE1Sl4wOmjaSqt82jDS4V97WL54uOFbqjPp+3OridWJZ5tvrP+bxSUUSq4ouu4bvzLfAaSD6MYPrV9C83un0vsB7f7qu9eWXSbUaYnWakl3XViO2sztycFzKgwV7421AgftmW3fFP1IeCY7Iq8wjL3iJmHRjZ4umxbL1RNQG0qP0d2tkP+UlGsM9zKyEy6AQ8G/S3eQg7+kfPqk2fFEJPQ0ZUPWlyaA83rpJjlOCzrtCmWie/oVtuf3YCiINc+0bqllFYMvR0jZmhvxRG4DwpZCd3CvTo/3b+DuGWtCt6A9bp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:03:07.2891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb26f01-9287-4e00-e320-08def6d75725
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
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

When amdgpu_init_minimal_xgmi is used, SDMA engines init
is delayed so amdgpu_ttm_enable_buffer_funcs must be
called later.

Without this, the check for num_buffer_funcs_scheds will
fail and using ttm buffer funcs later will fail.

Given that amdgpu_ttm_enable_buffer_funcs is a no-op if
amdgpu_in_reset() returns true, the call has to occur
after the reset lock is dropped.

Fixes: 3a5da695c8d1 ("drm/amdgpu: only use working sdma schedulers for ttm")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b7751dde2894..1ec3162cb175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2474,7 +2474,11 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	amdgpu_ttm_enable_buffer_funcs(adev);
+	/* If SDMA is not brought up during hwini, the ttm buffer funcs enablement
+	 * is delayed after reset-on-init completes.
+	 */
+	if (amdgpu_ip_member_of_hwini(adev, AMD_IP_BLOCK_TYPE_SDMA))
+		amdgpu_ttm_enable_buffer_funcs(adev);
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
@@ -5088,8 +5092,6 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
-				amdgpu_ttm_enable_buffer_funcs(tmp_adev);
-
 				r = amdgpu_device_ip_resume_phase3(tmp_adev);
 				if (r)
 					goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 2725230aa5e3..45e31b3daf06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1380,6 +1380,9 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
 
 	list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+		/* Enable ttm buffers funcs after the reset lock has been dropped. */
+		amdgpu_ttm_enable_buffer_funcs(tmp_adev);
+
 		r = amdgpu_ras_init_badpage_info(tmp_adev);
 		if (r && r != -EHWPOISON)
 			dev_err(tmp_adev->dev,
-- 
2.43.0

