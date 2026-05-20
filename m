Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97DECD5BA6
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 02:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6AC10E068;
	Wed, 20 May 2026 02:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CQwcMVhT";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010045.outbound.protection.outlook.com
 [52.101.193.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A96910E068;
 Wed, 20 May 2026 02:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxrvK7uVkn2J2QeMoI1EGtQ6kz3R7L/J7OvqkqMQKwDCuIvmot1k1JBRltcVc06g3bqrYosZO9HqLfPdRWIpj2eSwQxVnvwa0ftg/FmLV/J5bzJz3l1u7ClSSYo74y/aj8MiFvC8LI7iwF1nMyiZ3arvUGlE6Gg6OH7NT4vXFYkX4zBple23lX2W6sLM/odGlZBt+M/we8exNmoQKPOGZBNDVzkGyJKtgD/sexZy0fXO+ulPlAlUxnvbQ3cpnXVh17V4+dZng1RIaxkoUIdlovp9bA586bwmu0OJGdj0eFPid8OP3cFWLnecJKOkgufUca03Ul7nAwnsuM/43d3IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F00cGz0c38GqX2ruu8wW+OtjTUnPQWj0TDTmlUMvhhM=;
 b=ckRb2AhoSAsnxjIMBIRD9f3pQMf4ZKMl+CMJJGz/r3W3muSykmCYa5WBxUtZ4o6O7o9ldbqLmrMxmzj7soEfEv8LnQ9bv253egKfwt5g4bznrp8U66O/aFd2Mc76PQ9FMj48aALAQ7Yyi+OJzyTHtCrcwi3L7tGoYJkuxbpIv+erR60DKBbmysle6ZHsUJUk0wPKok6T2GkmIEVC8BWkTZS2kmODijh2pfRkhyDnGjMfXk6IhjpRbg6h5tTViVYzpp5Qp8UtjEGyCEapL4rS5CqCAPo4psYm2yz8oyHWkVmE0uQVnvU2+iNj0Eg14Xcm826z+RLnorX23zQNttE0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F00cGz0c38GqX2ruu8wW+OtjTUnPQWj0TDTmlUMvhhM=;
 b=CQwcMVhT96lUPEYpGA8rf7rY6Gf90KzExsZJifER4Nx0TdDm9ww2KxFtKe6cucW3NcPObDAAR0N5cYkzXDr05SYPrpAacJ8sfQ+W8ZDcf2QVTY4WO63Mfasj5bzkFVN5Z5tnJJoFTIdOGPMq60HDfWCMtgDav1EUlQioof4Zpes=
Received: from CH0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::21)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:14:39 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::8c) by CH0P220CA0027.outlook.office365.com
 (2603:10b6:610:ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 02:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 02:14:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 21:14:37 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 21:14:35 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Ray
 Wu" <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH v2 0/3] drm: detect panel type from DisplayID 2.x
Date: Wed, 20 May 2026 10:13:50 +0800
Message-ID: <20260520021432.1301326-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: dd371062-5734-4d02-1be8-08deb6158b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|82310400026|1800799024|36860700016|376014|18002099003|56012099003|3023799007|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 24g0gcRCaehgLBBB7OkAdrNuFW/V2Dt8pNWWr456OEBC7aCh0bwxHs9OeFGJgQnk0FhvNDAwMr66HC/ncwsZRUkaC7DmxBvxThxQPao5Qpb/ht5Q1Wcj72A5/RFuXHUHlxrgxjof5T54REftWYUKvosN9FWbAkkEY04UDtCFxBOW31OSNxDO2c7Pj+qpWC16k+nJesI+yPvMyR6McLEml0pLLCt28tBrr8OsFGz1uefK38VGaqolnoUMVI+gWW6O+ZB6dIwDyHObEG3UkMM6xM1e258XMtnvIrVulnWgKT7l6qw4Adm9svh/09msQDNaFNvvS49DBQdLFR40Y8ak+tlfmHsAJO5K0oXh+HqO/ZJpjE4AXVu4QnmRWpO0DLG+wazXf1N8Y1m6Ku++iKQjIU/7hJNSbIFG+RU4Zg6+AXURhEuBIQzZ2OplALmedi2KQBl29FriKOhzAYXse0+m9Cs1BsTfmJD+3iut/MnxO/7TWUJAKGytZ03GcJc8jVSKRmMgaOJd7W4xXlzZMt91K3RcEe1SYrEutZ1vLJT0o0vioFJ+5mvs75uU01X/ehgcsLVRbIW3L05rmAmu4Qdjh0rRhr/0yLyCAksKEOVQz2+B+Ef4MvUoBO/IAZZY1qcrCH/BQq6mzM4riC2mDVYcfEtMdEUqw8jA9LgJCtMg7f82FDr6QjAM3AipDSBNomSF4dA9n2f92ofwXko739fuK6j0Fytd4b/1kYX0jiU0dOs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(3023799007)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nxbqISzNq5v8NcPxZVAGjLoKOP94bXKjWEYvoO4xejrKRomOrV04ZoeC0nMaGPxn38BQzL5/aj394bCNA3wPjG52osM8j0jiBRxN+Bi+Hxsg5+ODfLC2ngi0MUbHMD4IdASdgK+zIXIV9rGsPDdg9Dl51z1JQovUm6zLyXYjukUEqBBxkiZHKz5u14vs+4Dt6WQa7VFvR534OYJ3XCJgRsRWsGz5DJdL35uJClRzakfgB6P84gN8T/8oLbO6J+bluPQVo8ffr1xlg3WC1COo4yCPRncXZlSCmE53/gBJ1OG7JB3v0AjhtbD93uHGPY8r8OV4dNUgqwD+ACKVmw5o33c6XojA8J1xgqfqBr5o2YAbI49cMmHrZha60qRQFDie+hGMW0e3SXszt6L5dTEsL9uO+gtp9WkVroN8A/frs/c8Y/P4fvIZM+8hK2+l5/vZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:14:37.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd371062-5734-4d02-1be8-08deb6158b46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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

This series adds parsing of the Display Device Technology field from
the DisplayID v2.x Display Parameters Data Block (tag 0x21), enabling
panel type detection (LCD/OLED) through a standards-based source.

Previously, amdgpu_dm determined panel type only from AMD VSDB, DPCD
sink extended caps, and a Samsung luminance heuristic. A TODO comment
in dm_set_panel_type() acknowledged the need to also use DisplayID as
a source. This series resolves that by parsing the Display Parameters
block in DRM core and wiring it into amdgpu_dm's detection priority
chain as: VSDB > DPCD > DisplayID > Samsung heuristic.

Patch 1 extracts the section header processing into a helper and
removes the break so the iterator can walk through all data blocks.
The helper is invoked only once via a header_processed flag because
displayid_version() and displayid_primary_use() always return values
captured from the base section — they are fixed regardless of which
extension section the iterator is currently in, so processing the
header more than once would be redundant.

Chenyu Chen (3):
  drm/edid: extract section header processing into helper
  drm/edid: parse panel type from DisplayID 2.x Display Parameters
  drm/amd/display: use DisplayID panel type in dm_set_panel_type

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +--
 drivers/gpu/drm/drm_displayid_internal.h      | 25 ++++++
 drivers/gpu/drm/drm_edid.c                    | 79 +++++++++++++++----
 include/drm/drm_connector.h                   |  6 ++
 include/uapi/drm/drm_mode.h                   |  1 +
 5 files changed, 103 insertions(+), 20 deletions(-)

-- 
2.43.0

