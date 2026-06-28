Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA29C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 06:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F49010E54E;
	Sun, 28 Jun 2026 06:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7KPaQAZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A64610E54E;
 Sun, 28 Jun 2026 06:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWo/RHKdF4HHq9MQrBqxqEVNsI21c/WJGo/CEdTzuGTlb8QQC3QwqN4TvO38Va1RSu1X4BoBXpguzfnFq8W9wAsj6WqupV1SHqz/WvrIDoqJ94t8rc8qJwbCIRbYVo401kcrrOlSIyS7Su4ewel57n3dptSydMdr3lRTnJXS2fVGQGfFjFQ5iop2tq41ibdEA2DqMiHv7fUwB/o1EN32HBgXTQLNI8JIUzsOnyMfnUgIdFbeg8zH2JoIG5lJhKyAf6BsLCsnIpy+rJHTPowdplBP3gzix9mLme67+kyM+0ayAdyTDoNB1/8a9rKWl0Kfn4e4oXomDR/+QAYB3X1RfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kYqXK+ti6dzjaz4KAbqr/v3WdgKSqhc/lNPnZP5m/o=;
 b=e24eX+YnEodiBiuXYn11IjH5Vfkk+4hxxGYNmCpxy2gJFyQe9SayjQtlEpeXLMndyBxbvlZIrMTaCn3rEWpMtoXciqdNsi9IPD/wfSDBQE+2TNebJeJ9eATe8rHaJbCqrW2Pnn2QYMaHGHqXqFadBfL3ZBgeCZozlxvJuIvjceMWhoOMiQbvLma4aHGZSzPz8pdvxSryC6loluD6E1LQ0l92UcmJlVLBxhzPsmgrkpK/PTEyfeJ767HAykDi850iaoHc7/CBnRWFWJ8QP/cblL7PU+OoDhSvggQrKcaDCSe0avvZAOMeEnYNRbbtNLUSAEa55ddCB8wsMRrtRt5W2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kYqXK+ti6dzjaz4KAbqr/v3WdgKSqhc/lNPnZP5m/o=;
 b=z7KPaQAZwEivMZtJ15L5EhVFDU3Lzedm/UkXLh3rAoWyKdfarbvUfhyf6hY2Dgx2J7QKTchhsnmfaRdhwvtG//lpd8qWorpdybSLQ1FFFTOzfN0IS3e7qJ/TxMk2prIlXVsFJvGcxWMvzVE5K97sL7SGb9OEGm5REOnx2rXJyyQ=
Received: from DS1PR04CA0016.namprd04.prod.outlook.com (2603:10b6:8:243::8) by
 MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 06:18:24 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:243:cafe::61) by DS1PR04CA0016.outlook.office365.com
 (2603:10b6:8:243::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 06:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 06:18:23 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 01:18:21 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v2 0/3] drm/gpusvm: fix IOVA/DMA unmap leaks in
 __drm_gpusvm_unmap_pages()
Date: Sun, 28 Jun 2026 14:17:54 +0800
Message-ID: <20260628061757.4093701-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: b70f5b99-8bdc-43bd-f1d7-08ded4dd0f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 25Yg7CuMN0odWlxVZA5CbWUDA762dtco/p6OTxBepM9u7ymAY1EwI8Z7yRLdY7zNsZ+3vCFs5NUpOXO3wMaDutjlnCrPJqRIr5Yfyo7VxOLcVG2guLl3r44EotKNctV0rIIpuVPKKGUtEbSc8PwIUojB9VOJGqbP5ERrZYgGr5rzHMi602tkpWMzhD0r5XqsIrgRgY7Enw3D7sYVGZodk7yZQaS/QxVUJaHYmG49jQ4Zd2HZ+rrsPnl4zzkXqNOT31mtMNJDOKAo66CCvjQUdAwr0iAei03IZepT7oiZ5Zc87k9Lhwes89yA0I8uduXHQwVLGi2cbPK73spnajGckonYnuNAgGnpZEh04MyRJnXmVZM5Yw9PNVure/+5H3krOtJ28kziGNj0ozqWosQ7vjaLKyfIrTekGkth/UJZ9calJqQVnIxixCR6fIGCOjy0q/1W7uC4bnSewIVUJQe2Ws9ythwksA+IuD7VafYMVZthtFf0VmrcmIl0Ag1ssPPqBDWF6j9m7SD2VOEBDcEHBQ25+3Zzl/TQ8OMr9xPiULjVfVSShzz4cE7D/tGgqaTv/LRRfMEOfsLC2fF4QFMvWSUellZ4qhJxT+PcBO+L3ShOPo5E4mwXYJh93SQUG6pF00m35VxxB0BYEapjrucfEAtKjwbmSNGxoTKWVAVPa8HoZu3HIV8C7YnIlPKcdkIDkEOfEO4+6rvGNo3pTrJ/hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 07770ZwWn7JEeaMFQL2+AqAXB8km17MPYW4mX5YRC8HZfqzT+3SggtUOKck2ZdPQa9DDL8rJVcCvwWXBM2O2+bSZm6PB3vnSEfky5DK2zPSlypm73vFjMvrGpGAoYPwvZsA6Ulxn4ZtjCkIzFzCMep/Jyxm3bXwUvLgz+rpBZDyoBlx5w2LxyWfLj3n4SHcOmSIBfcuQ+qmkLUMgYhAhxDuQLCnuSrk1K2zE+D0RyJNdK3YFYQZYiz/YivB4aIaJzuJ6dNZZ44DTYjpmJeSyn1PPGGwSm4NObobqmLjSsQfKyNb5+nH1V4tF9zbnZfxl995gnNFWWyotvSEubwImheKiZQxJ3yX5KmpK8N/5usLbIMm84wrMmCOZymF3D9wcSCbKLiAi9Illc56WF30OAeNw8xrDotdhS8lc6cN6MK0Wb/enrdLwuxgAiberG7va
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 06:18:23.8340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b70f5b99-8bdc-43bd-f1d7-08ded4dd0f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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

From: Honglei Huang <honghuan@amd.com>

Three small fixes for the IOVA/DMA unmap path in
__drm_gpusvm_unmap_pages() and the get_pages() error path, all spotted by
AI review:

  - Free the whole IOVA reservation on unmap. In a mixed range only the
    system pages are linked, so freeing just the linked part leaks the
    IOVA reserved for the device pages. Unlink the linked portion and
    free the whole reservation. On the get_pages() error path
    state_offset is 0, so skip the unlink, also avoiding the
    uninitialised dma_addr[0].dir read, allocate dma_addr with the
    zeroing kvzalloc_objs().
  - Do not route system pages to device_unmap() on the IOVA path. Branch
    off addr->proto so only real device pages reach device_unmap().
  - Publish dpagemap early to avoid leaking device mappings on the
    get_pages() error path. It was only stored on success, so a mid-way
    failure left svm_pages->dpagemap NULL and skipped device_unmap().
    Assign it when the first device page is mapped.

All three issues are preexisting and independent of the gpusvm MM/device
state split series; they were surfaced by the AI review of that series,
so this series addresses them separately.

V2:
  - patch 1: extend the uninitialized dma_addr[0].dir fix into freeing
    the whole IOVA reservation, fixing the IOVA leak for mixed ranges
    (the earlier version only guarded the direction argument).
  - add patch 3: publish dpagemap early to fix the device-mapping leak on
    the get_pages() error path.

Honglei Huang (3):
  drm/gpusvm: free the whole IOVA reservation on unmap
  drm/gpusvm: do not route system pages to device_unmap() on IOVA unmap
  drm/gpusvm: publish dpagemap early to avoid device mapping leak on
    error

 drivers/gpu/drm/drm_gpusvm.c | 53 +++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 16 deletions(-)

-- 
2.34.1

