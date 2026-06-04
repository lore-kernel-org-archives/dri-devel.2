Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0C4CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C911121A3;
	Thu,  4 Jun 2026 23:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xjygZ/C3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D6B510FB50;
 Thu,  4 Jun 2026 23:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPd0RO3jTzdXkxc6v4oByd5ON02N1ZLVxnhP7EzKN7yES9UMJg4ynQIJ1qX0MIcH6ZY/vwKVXbRn2thHmd+Yr2nIEJ6/DJT5F5GaPYQjhxUhZ6NUYMytfsauIW/nWmupAQ0+CiHW06k9NEShAf4gbxSN46RXUemrYYub/R/PCD58KnDDz/UTdrvZPAFTNQcaslC1gwlmD63NX/HJsIdeQzckVTYwczG74gwcZR7q3pxikRoVRPvoIpBo0Ml9BuUKjOmZ0GYJLXH6fg6UF3XyMuBSkrWBag0y5OacJU1GixQY4JQ1vqK+BMM8llIDXrSMTq3PgcRi0E0yJ0JNxz2hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0csn6TWMxnam37qbJzx8EZVavePKHSls4afDGPwLZc=;
 b=PlYNK1gw9xOJKSI9pQNbcqtdrIS9k4/yZp/s0MqpTg/NKUS6MpQXB2mKGgw7IBlvsaAsC52opvdi3gH3nqqwEJZRTklbnRh7m7F4UeRg828vOh1feuKWxs2pCq41bfCCK05H0Tp6yDtXSeUtJ2m15SSldY/4YviPQh+eLyraYXEvkVJp8RtT6iDa2ORMwdVZy0gJtd7Js0vzDJ/B+jzNoPrPe+Wd4StgMvVlFoxbIhzPhnnepwBMLyVTdaW29vqTL4rx24PtBSl7dfYKAnz5ooFXRQP7J5hCyv9Iz0AgOKyS65OUfa8q9IqT6RwxVigAWxEU8TRZIK4aOzwsBL3KIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0csn6TWMxnam37qbJzx8EZVavePKHSls4afDGPwLZc=;
 b=xjygZ/C3ontPgHyL8ErjMlDgikOtSgbWfpS4+u0Kv189yPjxNnge4riOwb1QOfoe7kbbSZuZaWsCa/rYbdzq5b0OMPoXL6J77CSmg7V7dZHFNsBjaaW5tiws/8NXHmLkqZhOd1f585qXonTIcs43oWi7i7YCBRYYEN8BuxxW86k=
Received: from CH0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:610:e4::7)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 23:10:02 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::3c) by CH0PR03CA0182.outlook.office365.com
 (2603:10b6:610:e4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 23:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 23:10:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 18:10:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 4 Jun 2026 18:10:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.1
Date: Thu, 4 Jun 2026 19:09:55 -0400
Message-ID: <20260604230955.19629-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3253d0-09dd-4754-127b-08dec28e6848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|13003099007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tBGKPsTfo4t5TNWnAULJW3RHu1SNsOaM+G0J8vFrcq1hGMrN+gPlDb6nEDyGYIAE0f/myc89TugUhFCrlRFh1ec6OutZWKXsusFrROfE7Q+qqhfO4TUgwTsxAXT3yvKok0tOgq3tLaC8Hg4ZCtXReA70c9U3GMMoMZPzCMSQmneB5KTeFCWZlRlDlHa5lytHNg3fucqdJJRRzs00Kpqf2MUh3TXLYPobG7qdhs9L91tiBKn0AOYorK9tQMk5A9clVC5E3ZRZ82gzUgAvTkJw/DO48TgzEwvfYQG1nZ4CbqeiFjsb/cW95N6MQD8Ch4qpmh3KCsS/XMYkO18QgngSkr9x9rj6xjXLN/e8u/0QWmgMcoTaA0zG+wcJHvc7q56uXb9VYONEmR1kDhRJMOctd1GAkXfmnrpSkKSzAev0ohFjJtQNzFybexUWtEa1Y1TW65GCM70NsxX52l5WoM4FBRUY+RYan+assPQOBom/P7V0b//FunzGTTN3ipGREbkkd5efT2i37q6PGZ1/tFnrZEm9GZ9xL/Qv9o2vH9oaaGiny/Voo9aLLhGtdXmijjVHryg2gduTVxbK0ezXr/XajBw3ct6VVQJgJxz9ZWQFSmlSaEALQ9yrTHczg4k9G8g/6Rmt5D6LFRgV8wQg5Y3I9tG2h/rl3kdnH3Mgic3nqQEiCMbzo8j+hzKsmDZJoZiW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KMTBCpE05daeLuGRKNDVMb9USTvD7assClUUgF+CIW1WzQihwB7IMiyCPRuuWg7YWkEBRvrMR0/DNEP/rmiX1zAtMi+mDOxo26AwFLeRLV8wYBb2gB/0X4YjjHFpNG4A98ERFCi+/aamtKnjkQoBtlg9zOaXP+C7cgRPZY+ht+i8eKrEPGMdkaSEyre5iWzHuX7W7B1leznORKVnhc/tkLGFenwqOf9NMo1WrWy2Ioq2A+WZsuykC3Xnj6BveKcohj+RGn4d/2OvBDDMv9LWoDDvYW6E1VMatFhkftkpwgyaHo3dSpmOqzCvw2PurgMBYy6W5eLpQSyLdZ7IZfhMCOhjfbbVtrNojrl0Y/yq2wwQrq00QR7nrl51plNtmdPvD2h3qz/zSDmfO67PW4lpD4gQvwduulebJ5AhG1ZfvWfrjQ81/a8jzeqLogGxy20t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 23:10:02.3470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3253d0-09dd-4754-127b-08dec28e6848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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

Hi Dave, Simona,

Pull in the MCCS regression fix and a few other fixes while I'm at it.

The following changes since commit 03b70e0d8aa26bab89a0f1394c1c80a871925e42:

  drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in set_soft_freq_limited_range (2026-06-03 14:57:46 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.1-2026-06-04

for you to fetch changes up to 2eeb342aff66477e0db9833a6393e581a6dac4f3:

  drm/amd/display: Consult MCCS FreeSync cap only if requested & supported (2026-06-04 16:00:11 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.1-2026-06-04:

amdgpu:
- UserQ fix
- Userptr fix
- MCCS freesync fix

amdkfd:
- Fix an event information leak
- Events bounds check fix
- Trap cleanup fix

----------------------------------------------------------------
Christian König (1):
      drm/amdgpu: restart the CS if some parts of the VM are still invalidated

David Rosca (1):
      drm/amdgpu/userq: Fix reading timeline points in wait ioctl

Michel Dänzer (1):
      drm/amd/display: Consult MCCS FreeSync cap only if requested & supported

Sunday Clement (1):
      drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EVENTS

Yongqiang Sun (2):
      drm/amdkfd: fix SMI event cross-process information leak
      drm/amdkfd: Unwind debug trap enable on copy_to_user failure

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  9 +++++----
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c            |  6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c           |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c       |  8 +++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++--------
 6 files changed, 27 insertions(+), 16 deletions(-)
