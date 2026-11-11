Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3D606A331
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KPFTkLF4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9750910FC8E;
	Wed, 11 Nov 2026 16:43:53 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C42C10FC8E;
 Wed, 11 Nov 2026 16:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8ceqpT4i9jtJR8rl5GY6CFMygIZXf8FYTwGkWwYSJBHvYOTtNquwD9YT2BWcsMoUOY6xVLt/6vkBSbQoBxhckp6PpHzzar2xDjy3kSuzY1kMhCZ2m91yyraKqHKeiMeaGUkmH0VdoVevhWwLOkjWbUp0Hn2KnxHVAVGuRzLBYo4Dc/gi+7KVqm3kjphyBKdB98Z3O2RqxqGR5Q9BHue7sInVDAJeCWfusfFxw6jVg/bmzGZ/CvYLBxsJQsU4Idx9IaH+QV8ZdlHWdd/cGnL1ascuqVmsy9Fep9MEcf6Ptv9kqCCybUo9TmFwEXNHa4TSRi/eOZMCwQrmLfsNMJpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc0Rcnhbg84Wt5UdzGwaC9zodWw6/8J7VDspHKFreUs=;
 b=oFJAQmjcrr4oMKPjJnpcatnynxyDvrGmu+8ZcZze4XSc1PWcQ7aYbyiC673n74Hn7c2qY8VWOGLrHjir1vyqTfhs5oSOS+PFS6ekoQszUfx80SMSiEqnq96XNqXzHKxT8aBPaWGywqWPrmTN4KASw3NyfN85piykI6RVeG1MiNsWNa/caZyjJ5lsU5G58hw8DalvIeOYbDsFl9XPmcAM3zwwHMcu/hzpsmFJz+AICwM1JgsIx2xSqo1MK7+vdBpbVWeSNx8OsY4Tq9K2RVXgYvtLU70LZuHCuHHJ3F5GIDbQAv9LcCG8d+ot31sp5PvUCdAaBE6Vqnix/HIAixPjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc0Rcnhbg84Wt5UdzGwaC9zodWw6/8J7VDspHKFreUs=;
 b=KPFTkLF4PyD+Mgy8tpNkFNbZ1NNBg47TMllTzbPzrD+ZYRQTtUV0i+7ZPAVwoqxCzIa+bf6mhnkGB7KFTeog89HjaOUCqKCatF+aDbe2fzAa5dIC/GSyIrGcHMglkzkAXqJBVH9zG4d29iLw4FO9b2gfq803z6oN47gRsoMu32M=
Received: from MW4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:303:8f::9)
 by FT1PR12MB475569.namprd12.prod.outlook.com (2603:10b6:170:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 16:43:42 +0000
Received: from CO1PEPF00018868.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::6a) by MW4PR03CA0004.outlook.office365.com
 (2603:10b6:303:8f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 16:43:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018868.mail.protection.outlook.com (10.167.249.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 16:43:41 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 10:43:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v6 0/3] Fix amdgpu detection of pci=realloc
Date: Wed, 11 Nov 2026 10:43:19 -0600
Message-ID: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACeb9GoC/3XOTW7DIBAF4KtErEvFDD82XfUeVRYEhoRKiSNwr
 VSR715IF7Hldvmk972ZOyuUExX2truzTFMqabjUYF52zJ/c5Ug8hZoZCjQgwPIp+pFnOmYqrcs
 RFEavsdfoWFXXTDHdHosf+99cvg6f5Mc20xqnVMYhfz9OTtB6/69PwAXXzsgQguz6EN7dObz64
 cza9oQLjWKrseqA0qoAoLRway2X2my1rDqS1b2hYGzXr7Va6m6rVdWCOrCCpPXo11o/NcAfn+t
 2W9noyPZwiPKp53n+AXLvK9u2AQAA
X-Change-ID: 20261019-vfct-regression-2142fc52852a
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018868:EE_|FT1PR12MB475569:EE_
X-MS-Office365-Filtering-Correlation-Id: dc937b9e-46c5-47b7-4d6b-08df4012f160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022115727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: nhl2lAhdtPuD7jVvcFxQNbO1vDXc/N7/qjBcLq1bdcEzRF6avNjNVcUrgPWaimPoZDlUbV0B4pDe7v8ErF+HUc/oe7pIT/DnV+MaHKoMNOSR5df5X6pOg8nrMLCNgHH72LruUFeEw2IkvwMzJjqSM0EaYpXOh2Fjn9Vy5JNCD58CVmy87e5Lj48RdfpEnAV8h/WKpOtv3wyQNu85+2lY2VMWMpdem5In+4ZYK62lbyAVhSdAFvTtgXaFXjQLgTRxp6NahSAj/RRVlOZjciF9XKcJ0om1gIm41P/BJMAJXvI0kJAoSTAzaUXpPby8gSPjYRb3MfDaYcE6bTZEyi8iCYopa5S8YpM8EPPVRbDm3RlaNDh/T7KXintvi4yUX7oj9o2Wcf2xUFrfsRcyXRpvkOrJLRdzmjudNx+CHlZG8Tdq6Jr0j8B8efcep40ht6yZ+mE6UMl+A4mFZUxuTV/z35BeH05c4tc6vdfaozonnMQjGVUFrNXtmB0ltT1c6mHH117UZrq/5UJJv9RxEx0K5VGnOoW6Rxqj4ombTQFjmn2STrISeg+sOYCBlmv2kLk0+/xePmprg2gYEkQG5nRoZtypYNiW6lbVFqzlK35Yq6GlCWYkYftiUb5eZh3Q0jyqe5nP03gyD7QU8e4/p0PopsDAiILeFXJhSQv57DfU8lk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022115727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dOS1e8Qq8Z8nTl2LijZw9JDT6oW8E8ZZHXCSK0HWG+Hm9Atf2Y6TEBuKd7JNhvAOsANi9D1Q2+3spQKCqLUXRBS5y027Bvdsl2m9eNpqoOpyofdz3vdTce+17MIkNDrrIg5+kgnoet+/eM4MNs0BHm0+X/ySnmQM0GDiIdwNtyYG5DX1H3llQrUliXEzF6e2JosbdSjDOxypPiO0WO+s4CvXiCJt9n6fGKiUNMCst4m9ohj1D3+hr2QTQtXQKEag1qRxKsooQrgXA3JXCsxvVg7V04OcR5LmEi71JNFP7piahzxf6KZi2Bc4I1E3VSsHx0iv9sO8KtH8sMOb3MYfk+J6QZRD3bW4IIMfZAQTvhusbwpi/asbsL8OijugGfv9AOCdGZaaKdxvZuIBu+EWJPEhg+Dvg6dQxjlvLchAdFRjnnCfQhIzEZ6osqIzMNBm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:43:41.1731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc937b9e-46c5-47b7-4d6b-08df4012f160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018868.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB475569
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu needs to know the bus number the platform assigned a device to
be able to match firmware images against the right device.

This was previously adjusted to be a soft filter due to
commit 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with
soft filter") where if everything but the number matched to take a device.

This however fails when there are two identical devices.  Instead save the
initial bus number to the PCI device structure and then match that.

Link: https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.limonciello@amd.com/
Link: https://lore.kernel.org/amd-gfx/20261019194106.2796150-1-alexander.deucher@amd.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes in v6:
- Capture the firmware secondary bus number when reading bridge windows and
  ignore unconfigured values so rescans cannot replace it with runtime data
  (Sashiko).
- No change needed in the VFCT consumers; they continue to read the cached
  value from the upstream bridge.
- Link to v5: https://patch.msgid.link/20261110-vfct-regression-v5-0-f49fae981bf3@amd.com

Changes in v5:
- Record the firmware secondary bus number only on the bridge struct pci_dev,
  guard it with a validity bit, and keep it across rescans (Bjorn, Lijo).
- Drop pci_bus::number_initial and have amdgpu/radeon read the saved bridge
  number when matching VFCT entries.

Changes in v4:
- Retain secondary bus bus number for a bridge across rescans, and the child bus is initialized
  from it during allocation, before registration callbacks run. (Sashiko)
- Rename variable to clarify it's for bridges (Lijo)
- Link to v3: https://patch.msgid.link/20261026-vfct-regression-v3-0-fe9586ed6978@amd.com

Changes in v3:
- Preserve the firmware bus number across bridge renumbering, capturing the
  secondary bus number before pci_scan_bridge_extend() clears it.
- Adjust member name in all patches
- Add tags
- Link to v2: https://patch.msgid.link/20261020-vfct-regression-v2-0-d2394d11450a@amd.com

Changes in v2:
- pci_alloc_dev(NULL) remains safe.
- For buses behind a reassigned bridge, the PCI core now saves the firmware secondary bus
  number before clearing the bridge configuration and carries it into the newly allocated bus.
  Devices discovered there inherit that original number.
- Add changes for radeon too.
- Link to v1: https://patch.msgid.link/20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com

---
Mario Limonciello (3):
      PCI: Cache bridge firmware secondary bus number
      drm/amdgpu: Match VFCT using initial PCI bus number
      drm/radeon: Match VFCT using initial PCI bus number

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 ++++++++++-------------
 drivers/gpu/drm/radeon/radeon_bios.c     | 25 +++++++++++--------------
 drivers/pci/probe.c                      | 16 ++++++++++++++--
 include/linux/pci.h                      |  4 ++++
 4 files changed, 39 insertions(+), 29 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-vfct-regression-2142fc52852a

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

