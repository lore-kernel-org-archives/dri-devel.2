Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A21CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1935010EC65;
	Tue, 23 Jun 2026 18:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1vFdI+Hd";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE94810EC67;
 Tue, 23 Jun 2026 18:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCB/eKbbjwhu76PB+kd2CJxsuare7XlAs6CdoYHfnKnicgTPDDwtrK0v+y0GLWT60YLFQF3QXy4+CyKaFNd88HSitytYivK3fl1zX1YVl9MMUX7ZzRT1yN2BmK8Sw9JUywec0Z3QZ5FRwV3r1WooTDU/1+8AJz9TGUR1Y461GNPFJvWv12qRUlj8OVu9Cs7LAnptirZcanKH+Caiht5nIIz29ipoGPf/PihsS20GxgkOUPE8c2OqmPOwIfh4eO5HyHmOa1gD3/vPfZbxl0a76Defe9xWOUIYnzWgyhcMVbPirYT5WLsNaxy+ZKWqy4TZVE6jcGLbPdEbYY4bUfKe6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgueUKHwPGkw94eyrlButMT07BG7Yhr+x2+Z2YPrYsA=;
 b=ji+pbBk0/XusYcbJLb2EwKVCT+SFt7hOlwbLUz7YIe7P2uRv6fJ4Yc0pcjrDAQDEIwlxy05jZoGB6Tj3rUqPWvn3jlnwI1RkFkKkM/xuxXEOhdB6rTPk6sbNWdpmyMGbEo8W16UXS1pbCuhNAVqyAV09f+0g6eYo4wBMLdNr2DaTipNN1iqshH7TSwDIIGI70F2wSLftzvv1GGM3jxsV/zVDtzz8jzxznziodQ4C4tZckcnD0SjG+9wJ9U/EEIK+d2hr9nBdpfxR4FKfej09+uXFKvTBH37g2MXohWCutLbSRjAA6ye7J/NAcE8vnErPxRrnWLx+zDBRkVwVZODh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgueUKHwPGkw94eyrlButMT07BG7Yhr+x2+Z2YPrYsA=;
 b=1vFdI+Hd3Uaq3Uvk6xGUfGCedDRpJh2pNcN05TAk5jHkTEfOJv5BcR4iqE5k58DQtWIgWCsLM8KL6wzZAM3xgnAEYr4CP1C0Wn3mierSaFgGfVqigmJtxSMvQXPv4JI2qu9n1H+hxDrbxysO4FGOGtuGkc+18QVYEUVf60pWxTs=
Received: from SJ0PR13CA0087.namprd13.prod.outlook.com (2603:10b6:a03:2c4::32)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 18:32:20 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::88) by SJ0PR13CA0087.outlook.office365.com
 (2603:10b6:a03:2c4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.9 via Frontend Transport; Tue, 23
 Jun 2026 18:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 18:32:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 13:31:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:31:56 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 13:31:56 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 0/2] Expose AMD's Gamma 2.4 and 2.6 TFs
Date: Tue, 23 Jun 2026 14:31:53 -0400
Message-ID: <20260623183155.212394-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0405df-a3ce-4c23-fc4a-08ded155c25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 74ndv/w2bze8PI18Dbh6+XGOogXcoZZ6SDt0ap4aJ5B55Pwe1kXsQ/AYB9q+42DQ/rv3M4CXFKloZwYyI5qEIR5Ai7dJkXD+tW3qJiFD9zAHSd2Oc1LQhO4cAJr7oM/gHJtsL8Ocg72QevE774e4ivtKFJLEAYdXGf6QIjO1cvRT9aNMjC+tLzwoWra12NqhiD38AflmKgJGZZH3iEeM/Y+PkyH0LaBfr1k65JUuDq/gl3hoVxQplJiAxKii4B0xpCMhgzdu3yF5AfscaAqll+KLjaWOSMZeM64+i/SSkSREW+ZlvgkWhSdvrbaH+OPQocDx2G+ueaPRj4GVWiD8RXzXBHuLt5C3xWpZY2826wjxRt4WiiRwG1M8r/mtsOy9fDGopuO6UELnLZnynwjY/KQcvodIrQohLKKPvIuXEXJ6W5w7aIn1ZPgYzYfIeo0FqutwMhPcX8xfB7rY8lLH9EiGEsp88eee4JhOm/LM6GhdBs7dbJgDX+OVuS9UmbuUWw8+SdJMsIok8CZnNS5G0dXmhg/SjMKh0MKDG/HK/r3Ddo5MM595t5T4N43J/FCqV3XEaT/YaaK1hgqQORoEw7HI2Rk+BdWkNzu2NjAnMzZBVQFJ6erFPr8sgx3pNz33Te4ZLvz3SDs7b1zymdfErRaUSUqkg4neSFg7UFQzwwJxoPahfQivXcxSYZtr336G5+oJfsAx27SErXgfE7/rNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dFTV7QPsr/dSeZYUixwG9KywbDvWS2+moRL5B37P32u27X+6tAAxz6VK1SSybEQ4f6YX+QAXjZajt1g7XrLypVvSHluNzZJiV6Ji79RuneWmAFsyxS4qIbO04ziynErLyX4utUOsCfoF/C3u1CVJ5s1g4KTR0ax4QI6XCa2LBfkZ53SMYmLzQzTR6/hMCfVnmYeCXu+rZhupG0+Uk9PjozNg1sp3s1SwsIXyoUbfBLeaYu0ze93ZbYk9Z84QeENz9QixRZS4SNWHTyPZP43aJ9KCwzgywniIxPU+PuwyYL65T9M04ax2gSayK02nmrPJnVBZZm31Lp4xXondKr1O1PxATlPg3n1SZI4zeYzdIs7mjEzKK1qsvzfEGPkLfDchwl3QI/8kG9aq5eLsBV6xK32/50F56Ii2oe4xz5rWC5HAjRJqWHqjZo+lJXoWYs04
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 18:32:19.5196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0405df-a3ce-4c23-fc4a-08ded155c25b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD
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

During the Hackfest there was some interest in possibly using the 2.4 and
2.6 gamma curves that AMD HW supports. Add the colorop definitions and
expose them for amdgpu.

Harry Wentland (2):
  drm/colorop: Define Gamma 2.4 and 2.6 and its Inverse
  drm/amd/display: Add support for 2.4 and 2.6 Gamma and its Inverse

 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  6 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 12 ++++--
 drivers/gpu/drm/drm_colorop.c                 |  4 ++
 include/drm/drm_colorop.h                     | 39 +++++++++++++++++++
 4 files changed, 58 insertions(+), 3 deletions(-)

--
2.54.0

