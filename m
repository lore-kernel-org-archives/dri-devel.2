Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D145CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6512910F900;
	Wed,  3 Jun 2026 06:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KQKAVcu/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D5F10F900;
 Wed,  3 Jun 2026 06:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2EDwxCLeQ7nrLoNgwHphJmX+YwMnwP3zhDcj5VYgGYJ3ico2mWJLle9f89xqPHQZlvLL9lFEdsAjq5ZgzEf7pFRnbgtyzRLC9/eb+FY7Uyw9EVrEsHTwL2Q9vzGsZsC+0orfTmnYxAdRviB7ZUwZTIzAJ+/8YWzjtT8IbEDFF85SYCUBwXMVb85YIzBg5t5vSSKLf8r9pOn+hYQizTIT3Jmp0s6zk9FrO2WWlVSQ6SrgunC3AZqak9pjMSxVbYMUWSN8LFG1AbcgOtJM+TaKczvi+n+gfzYeOYjYD1xK1dHmfM2qXJhyt6jw4G3aTdq5u/ckPTZZIFpdm3Dx36Paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuTP5dIkZ8ck7JicKDa87UGLfiTGL5ouM1Q6rPO/cbU=;
 b=cw5b/QQB+JcwjyJcQ1t2Xssf98/nQuzuOXCRHRIgt/OueGrF0EmkYhJ+OnTOYwCYcJnDyBwp5my80BP659SYRSD1QQ16mFvlh1m12OQEKquvH95Y8CHLFo9tQhk5oMrDidemAkV9M6v+I5mwsMgbw/Fiw/atElmzfLJyMgPtgSb2Hf46ecriz1wOqC+AlhlnE+an6k/5aKhZpPb3g4PnHRzvcLX6s5aXendLt9F7kaIGVQjeSzpqiMlWFl/usG0kr02BME7yLSTzsaSycLrShC4+dJx8bCjj+Z0RkC9W+A6t5tYQSWOuYMg6Llt9dpOOX27t4dx4ST9dy/A4HQOPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuTP5dIkZ8ck7JicKDa87UGLfiTGL5ouM1Q6rPO/cbU=;
 b=KQKAVcu/lcs8Aodv/RHOtTlrhVJtbZyrvaiN29G8wcCL2UFVXdCjbmXXnB9ziPua6AFaW/WVtwCskjADKn/Einn9DBi8s/5eC7jJo1ZWj6qtnNhKQr8ypsRpBNCIswANXmLAhyq5LwrFufqupW7nVqWWesE3CM4BFcEfaKvdwC0=
Received: from PH1PEPF000132F5.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::3a)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:56:44 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH1PEPF000132F5.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:56:43 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:56:38 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [RFC 0/5] drm/gpusvm: split MM and device state across 
Date: Wed, 3 Jun 2026 14:56:15 +0800
Message-ID: <20260603065620.2555316-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cbdeb9-8d4b-48f7-06b2-08dec13d45a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|22122799003|1800799024|376014|13003099007|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Mp9LMPax6nWulnJ0uqvFKzIKhVODA2CNXuxoWzTwAh4O2B4XeJyWAfcQXMtScJpMIpB0AIhnA5oJ7fE42cpxdbWZb12XgewuF/AvAOH/9vwEaf5EMaejuYiR4VZwy4ff1iKlroXGeKu86noNYfKvlUjkaCkr6p375pc1wQqvcm5tl+jynrb3aq5uaaM1BSkX8VV8k4Rf8nEpPbpQlPwhknOmJlcpiKI/rbzjWel4vdYk3mTdgxEyA696CMMabG9SlNMiKFvR43lLZm2IRJXmJaMoVdV/YVH7iVbPXCvcwWfDj5vJ+Ng6iNtcv7kPOTx4sV9M+YuKiqhvtt/9ax6roDYC88jGcCfREQZyPrjuz2lF1LzaExZNqHpWpu+9NL71j3jEho5IG2QlIoTSnoHLFdKjRxfZ+YDDqTXJmvSLb3F+ViGeCUoE4LDplcdNpRlysd9IImVPcyZ4VNmIMFLqsQG4fGDSm3w3lc3JWBUINX406UA/NLNe3FjPESk0odrO9rdPZX8FOd9uiSXeZ5yroYbeBPGYvJWHiphn+aQzyh+C4mABGrskIonxGOtHM7U3GprAIDDRD5HL1R+lJ7H7IC2qAiwCu2sSVi8ofMMFPcvmcQaiDRqfBX2bZa7aNs8YygpoVENUCXZb5jLd7Ib8rULiuuF+IlUByAPdAMnXMt2mkh5cegkD+ACUGj2orUbUeKdhNZuuspftG5LZtCnxwCPwW/lZlRTf829LwCPoa0A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(22122799003)(1800799024)(376014)(13003099007)(6133799003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xjFtygdzRrH64GP4MG2+byYm4bDZIyE7C69gxESK09cY6iTcg8baJEpu2p1bMsBc96vVI8O983xTCSSU8VQt1kqfSIe4kUpECRzWxjYWVpec8h7kMJRnzEbevkz7pbgCN3UvdsHO0Lmh7hgrd/B6nCCPryhhBXG2J5BFj999B3GizcrWgNttVi0+XLeHVuzTanJxjj06mdtQGwbZwpT75Ix6PTSv+dLZO+4pDV4wp1/ZwGZXBARj4bdO94qNVJvpdeOfpBaV/jrdn9c3bsT3X2/a/nc6eecp2mKdpTppEJORxfZoV04pAOscgXOygW+nsQoxX+OpNwB2EitEOUT3AvhcLGUCAW9E9Hz70W9xsA4fiH7kMABNOaO4Z2ZASUva9PZegnu3n17bQjDrd67BbsXaNYcuQNsEKsVjvnpK/4EM6advUhphS1bkXGiqFaee
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:56:43.7906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cbdeb9-8d4b-48f7-06b2-08dec13d45a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
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

The intent of this series is to make drm_gpusvm more flexible and
give drivers more freedom over how they assemble the MM related and device
side operations.

This RFC implements the direction Matt suggested in [1]:

  - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
  - Embed either a struct device or a struct drm_device in struct
    drm_gpusvm_pages.
  - Drop struct drm_device from struct drm_gpusvm.
  - Have the driver's range structure embed one or more struct
    drm_gpusvm_pages in addition to struct drm_gpusvm_range.
  - Refactor a few range-based helpers (drm_gpusvm_range_pages_valid,
    drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages), or
    simply drop them entirely and update drivers to use the
    drm_gpusvm_pages helpers instead.

In essence the series does only two abstractions, plus the xe
adaptation that follows from them:

  - range vs pages: split drm_gpusvm_range (MM / VA range state) from
    drm_gpusvm_pages (device physical related), so the two
    sides can have independent lifetimes and ownership.
  - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
    the device side down onto drm_gpusvm_pages, which is where DMA 
    actually happens.
  - xe is updated to fit the modifications, no functional change intended.

If such changes are acceptable in terms of direction, I have a few questions:

 - Drivers now own drm_gpusvm_pages unmap / free and notifier_seq init. 
   OK to push this fully to drivers, or should some new mechanisms need to add 
   to ensure functions can be completed by the framework?
 - This series drops the three drm_gpusvm_range_* helpers and changes
   drm_gpusvm_get_pages() / drm_gpusvm_init() signatures.
   Do we need to keep thin wrappers for backward compatibility.
 - drm_gpusvm_get_pages() mixes HMM fault and device DMA map. Multi device under 
   one SVM calls would repeat the HMM fault. Does it need to modified to Split
   into MM level fault + per pages DMA map?

Patch overview:

  1/5 gpusvm: split MM state flags onto drm_gpusvm_range_flags.
  2/5 gpusvm: embed drm_device into drm_gpusvm_pages; DMA goes
      through it.
  3/5 xe: xe_svm_range owns its drm_gpusvm_pages and its lifecycle.
  4/5 gpusvm: drop pages from drm_gpusvm_range and the range-level
      wrappers.
  5/5 gpusvm: drop drm_device from drm_gpusvm.

tests:
AMDGPU:
  based on amdgpu adaptation patch in [2], but still SVM:DRM = 1:1,
  1:n is on going needs many modifications and testings.

  Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
  - KFD test: 95%+ passed.
  - ROCR test: all passed.
  - HIP catch test: gfx943 (MI300X): 96% passed.
                    gfx906 (MI60): 99% passed.
INTEL XE:
  TODO: We bought some Intel Arc A380, but it seems like this cards 
  don't support hardware fault / SVM, waiting for the new 
  cards B580/B570 to arrive.

links:
[1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
[2] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
Honglei Huang (5):
  drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
  drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
  drm/xe: have xe_svm_range embed one drm_gpusvm_pages
  drm/gpusvm: move struct drm_gpusvm_pages out of struct
    drm_gpusvm_range
  drm/gpusvm: let the drm_gpusvm core context purely MM level

 drivers/gpu/drm/drm_gpusvm.c    | 128 +++++++++-----------------------
 drivers/gpu/drm/xe/xe_pt.c      |   2 +-
 drivers/gpu/drm/xe/xe_svm.c     |  37 +++++----
 drivers/gpu/drm/xe/xe_svm.h     |  11 ++-
 drivers/gpu/drm/xe/xe_userptr.c |   1 +
 include/drm/drm_gpusvm.h        |  49 ++++++------
 6 files changed, 95 insertions(+), 133 deletions(-)

-- 
2.34.1

