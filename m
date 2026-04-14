Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C99CF531EF
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 06:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F9910E200;
	Tue, 14 Apr 2026 06:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="43xOOq6W";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD5710E0B0;
 Tue, 14 Apr 2026 06:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiZgfB9hZhOQwyK8UeW7l039wZ8nklp/iqv38hcQw/VO4An0R/AHDSEporXgLenx6F/YWUyn29HRiIxjeXLyco+MI3RcIRzQ2gPM2Nplijz4a7PJUYw3RL6FXwBbtxyXgn0NbFfIxyGZWLGNvLNXw7IR4E0aLhuwMv9B6QrkDflP2L+Yvy1q+fI+ylDB28rvyFHblxI2Thsky2aS5Wdu23lj070+atOVaMs1dqk4Snd/7FLINnBfuVGfiV6HUUvw0Mpt4rUoITttBf54kPVIL5LTv97P6FdKh8wTU1JEt0QaAOBrzB4QN8oSrCnak1p4dUVrrJ8LxheoeX4PxvIO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtMAVh2hqq04lMjTN/HCPRsVG19QQvnNYwFIfBdoJ+o=;
 b=buZVq0otEvNiF3rnq5PBVnMsDylwKmrxFxfwrIHWL7bo+4HJXoJCUekpjIXr4JhevkW2DJQ+GPS3AdF+4ICQBiX9iX9+wbwYPr52yaveutz5UVdHC+75YyLfRpWZakBH2RINZxM5PcOz9St8GOX4HLAWNh/laBX6x5pAY/v9WXdku4wX1WEIl8VYRi4n8dF9gGNCanxCy0+sy/MpzW+wnbHb+NUFGYq6OqIFCPkJBxY6RS/xR+Vy3G31K2YEj1KRQwqxqkP5fQG1HgQaTgUpnsFYWpYEf4eFgocxl5iRi9FdOvJfsWC2k8mfOapIQKhSGqtRQlAVpA1TZvxLKFgZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtMAVh2hqq04lMjTN/HCPRsVG19QQvnNYwFIfBdoJ+o=;
 b=43xOOq6WJAHdLJEoTlAcC1wDGjb4p3MPErfxWzxdXxu7j3yF6U7iwPEGn175yzFtaU42VRWpSxxacTKc9Av9r3HGOuDgT4tnoTEEztrdFlmh4hZ3gyA2CUZe2tOjyFX4OSwaODD9j7J6yaGP3cBfU6crtbXyb1RuU+hBQmYNq50=
Received: from BN9PR03CA0406.namprd03.prod.outlook.com (2603:10b6:408:111::21)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 06:02:46 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::9a) by BN9PR03CA0406.outlook.office365.com
 (2603:10b6:408:111::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Tue,
 14 Apr 2026 06:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 06:02:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 01:02:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 01:02:44 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 01:02:43 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
 <michal.simek@amd.com>, <git@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "open list:RADEON and
 AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/jpeg: Fix sprintf buffer overflow warning in
 jpeg_v2_5
Date: Tue, 14 Apr 2026 08:02:31 +0200
Message-ID: <1be91839e8b3e41003147a8cdc99e6efd1a87442.1776146550.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=5DhDbjcKaaYATJQJ+CKjPPTHlG32mivH4RjudMGCpQc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTevVGldlPxv9a0hksnZ10otl41T3dilICf9NX8GGu32
 /Jzmrae7yhlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJbPVnZDgzV1UvJbTE4rDz
 5BV95i6nja0sfl99Z++8VXzuOc1rt+oY/vu+EebuvalxZ4rgdw1G72DPzLlr7GJcz7G+7LS57rH
 1HjcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 543bee89-41ab-4131-a682-08de99eb734d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: wLhZyz1YwohMekNwqdOY2tuhazRCI9Ykn5rmG14Qh+jwyEpV4qdCElcJjhotVHyjMcKwuGDTIGMAvGJ3OuYoqyUcPSca0rZENZDtpI4O0Z8LiPWDnS5n2jV779Gjw64g6KitVyoeus1umTWzgByq8rqJaqikuHKqtGPsOlYSEecWJ3MqdAWPOuHN51sgJbv/eGjJLmal4fx1LOc+VeNX8c+Y8D3eoHYDrDgNPgMw3QEVJGpmaNOPT6MqUwXtE+7gVb65oZgZIrazEyDc2/Jmlm9tNahaJx5kQoD0mzsjVK5HU2qoDaVSv9oFWYse4BtAVJedHAQFDBpX4wDdpPm5CZbVB0mDH2iyiFxlvfpZSpnvGBBN7Jh6yOJX/TivonIo52skHf8NzzqkQwWqG1HhEl6gsWD775EbVIhvbUBRSSh2QKb9tbZjvtLhVj5hfO57usrEgn9oc65baa4C8vvFOCWlt/4CihtIzDtoVB7oh+p0ua1xOPS1iWDsFL0ERWE5iqG5VKu7so9qNkMkdZLhKN9c+jqeaBek7VNIzdZc20AkiJE7XL4W5Xw2Mr20UL024OpltXHbN0mcg43R2KULz+eePBJy9lbS/V1vwAo3Ab+E4zOSwjMleRyJNR2mJAS4doRyfrBeuIATr/hbs8zlWeWWb3iHahl1jkIt9LQCTAubylQzbNjgoK8Gw6Hre3ve+eVgDrpuuz4C033Iv1aqh3WCYMiPBsI1EC2uolJOm+j3n2ay+d9Zwv0uJI6E4GDR6AwxAmmNcH7eMOuMBJHR6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uP6hv6b9GcsyxuamCUimVgy61ts9beRaNjuO26YRU1IarV8OG9vYJLtnop+HmKxpnL/wnEeD01jAA3plYOJEh7BZ64hZYhxXBBSq3Fc5b9Xam2fpp9Li1LRLJ1Nt3BPyUZrfWPNEtCF/WuL59qyYRy5nlLjcuzuznZqqXdRs7OoTZIVJ1GEZCsAzMMqldWhI8AGZV/A86sZpGSVNs6bTxIi2RJP9R6KNCIe7b4nfUkj+Kp17D8OZ1SuRzFKlG+IKpj3NZMzkA9yXFAX3qqp4w4rwvkXb+asrMQj8BOgjIl+8uE36oZE3mh5HS8V9/vZbBjDKbAwkQMjli/lp7yFxShFgWiCl5nOBi3oqCVSlcz8c4KQmRlv6Dn8ZcmJn4YAODQReDoTbrQ7uJA1ZLmFIdACKCiUvGyI9SiEnQ8+zKK53yNhtuCM5pVLw9l0Gqkfr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 06:02:46.3632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 543bee89-41ab-4131-a682-08de99eb734d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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

Replace sprintf() with snprintf() to fix the -Werror=format-overflow
warning when building with allmodconfig:

  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:47: error: '%d' directive
  writing between 1 and 11 bytes into a region of size 7
  [-Werror=format-overflow=]
    152 |                 sprintf(ring->name, "jpeg_dec_%d", i);

The ring->name buffer is 16 bytes. Using snprintf() with sizeof()
ensures the buffer cannot overflow regardless of the integer value.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 20983f126b49..fe2b049afac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -149,7 +149,7 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		else
 			ring->vm_hub = AMDGPU_MMHUB0(0);
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
-		sprintf(ring->name, "jpeg_dec_%d", i);
+		snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq,
 				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
 		if (r)
-- 
2.43.0

base-commit: def01be0116ec66f7903e49ededad78e49717109
branch: master
