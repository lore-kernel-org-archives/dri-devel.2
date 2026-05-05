Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E2CD3439
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC7A10E238;
	Tue,  5 May 2026 16:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zgszHUNi";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A10910E238
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 16:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMz7cLZbCcvs5H9LSJPE+DdByX47t4CUcP/HdfNY/nmV9b42YUtqvkJbmjIdJO0C/iwkcHx0OfxLC8GneVhehBCKCu44WUJu9ygmP4pF8TwaksKFNc4WAzyQF7PhR5irtkjPzNoPP2msofWDzKA04E6HaMFAzX26oGmzLk5DAaDi308PWkfnvgfcUYJZfktGnd2ByVyxBxvofxH+pC7JZ+NOUp8eJGIxjExraKxdOkiBGM0f5YIhjZsdaMd+7FUfRq5X3J/fIdLDncIwDgDHVwnAo+zYBJHnGebyIqWl8QoOF3rDEs4RxOajmvK3+JRm5sEZhTVPgtHb8R7IKKeICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmBC4nonmYiZEjXQnqtPzRri/wbbEGooZC9aCMw6ZLI=;
 b=hHwh3XMse9nJGLjW0o/r6nD2deYq4UVF38tlYg9Uall81fqvjc4OdC6HuUBRqDZU2CHb3tTgeCkVubwA8oYwwE42t1Bof7jhZgsgoJuHKyh/vsUfkjMrkY/VnpJ9uF15GkoqQ9FYtfAWPRUMndhIsdD3F+jZI9L/+cEWNAiaMD/h82SsxDAdv1jVbx8pc1WScR85QjRPG0di8MEJNiNz/tC8ecqHHqdhkiUzxbEIA96gQurfG4k0Z9K+k+zJweJ7QfP66a/z0DPjdR0+3eQAIodm286AT/CNel/Izcb3z1Pelt70hNESzLYPgIy/qUCTrekBzohMa4z+Lrl9FCgOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmBC4nonmYiZEjXQnqtPzRri/wbbEGooZC9aCMw6ZLI=;
 b=zgszHUNiTGRQY11uuiI8qlpvRU2SPrlYEYWGsvHjNesP1Qi/45KE8WbWZbUb+83DVq8hH9L5P0lCVVxbtm9c/PqlibD39yP2i7XyuRdoideP8B6Jw764R6XKHlVCLqRA+MHA84pp4hblPxvi298DgKxZDzxqYue0o9Fr1mHsdAw=
Received: from CH0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:610:74::15)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 16:10:38 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::e8) by CH0PR04CA0070.outlook.office365.com
 (2603:10b6:610:74::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 16:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 16:10:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 5 May
 2026 11:10:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 May
 2026 11:09:43 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 11:09:43 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1 0/6] SR-IOV Virtual Function support for AIE4 platform
Date: Tue, 5 May 2026 09:09:30 -0700
Message-ID: <20260505160936.3917732-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c659f0-60ac-4eae-2bab-08deaac0d856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IlHuzxc1CIZW9B9R2irwUL5xsqZExiyNWw3niiuDu0r1ZRIAYDYJwT/k/u/UH9edvLyJ8+/VyHHOERSw8YuXdvH57s1UXqngFKnqvLH1NTVIkLCGuLy653Xp/75kg6tBD62hs+JoRVatiNI9v7BRS8KxzD0k6NyX3hjFS+vBgD13dWDsh69H4weKbbbTwUkzy9tia8s5jg0nqzMRBJeWdBmpblDqYB02kza2Y9VF+hQM71sU4+gBmtfeLi/JOJCr9pwKwDQVYVr4Jxh3HajU4eWsmCw1othHefC6w/tdVTYX1bJpx4aVQObOWf4c3K0Hj97+NPHEy44UaDZ2iMNpOJsllqU39rjn5C/xzX01M1xS3OD7cvuam6mizaM6DQu/xvetJsnFjfT0jBzvNj0zZymBKyNfcfmtzzLIWuDEo66Lz29qILCsim/rVnvBWDST8pySWYUQ3WxDyo+xnIEYH+XepZ9YaBAOdvsXU5gkuJDuu1OQ8QGNM71Kr+UAV00HgbZ7qRxbHoyH7RBzD+yhyYTHY0oN00dAgJSBrxAVOJi8348YJxvk23SqU+nSZTJVcRHgEawteJ3n9miC4qWlg+M/3VoEPIAXyS0+5WqBmi5uxO2wWPOTwM5BH4SOZ0EAFxcGhyT70C+/qezp68dyQYpNUXxHkHhv0H4jztKv3TSV/lAFuGL0UM5VJ+DBK/b//8RxpUKTZtb0fsXw9n4kcLLxIGWWD8/Yc+xUhR3pFlk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TZXB6wh8R9nt6El2jZDXFAj0j9SjvqleXJr02H9Fv9+dW8Nq0YIfcqElpnoTxwlMFDlVQ9N5uctStf6qo19jcq+zAR8LzvTONqheH86TOy4ihzqgMLrldf131LdyLzxNb/VI5DWqPpPpxIrYAmbICPnsQwmKwXKRjTkY5qkNZe3YLI7mel8+PYkN4XtYUhRJ+V1/8kArpiaK+cV6/6Q5UtUzzRNAdNOhw6R21VenvlAsqm/Z0dxldZrvl5dhmwHXJBOSf4MWFU4cCKDVArJx6WSTIAlXIcz2eRcMIIYY0cQwUy8vbXt4NKiJv5MZfrYmAbWUmc6Nee15VQia4XysqBpNQkyzErs/ZtaFo6K/mxCvu3Wps63hMpnUNuxtQ3ABxpzmhsnhJ6y76amtnRUE7HiewZqxGd46I+z67dENCiIADTqefrzu22B9z0At9eY0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:10:37.2636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c659f0-60ac-4eae-2bab-08deaac0d856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213
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

This series extends amdxdna with initial support for AIE4 Virtual Functions
and the user-visible execution path.

Move message buffer allocation and device metadata collection to aie.c,
allowing both AIE2 and AIE4 devices to reuse common code.

Testing:
  PF + VF: Probe AIE4 PF, enable SR-IOV, bind VF devices, and run
  end-to-end workloads from a userspace application.

  Regression: Validate existing AIE2 regression tests.

David Zhang (5):
  accel/amdxdna: Add initial support for AIE4 VF
  accel/amdxdna: Init AIE4 device partition
  accel/amdxdna: Add AIE4 VF hardware context create and destroy
  accel/amdxdna: Add command doorbell and wait support
  accel/amdxdna: Add AIE4 metadata query support

Nishad Saraf (1):
  accel/amdxdna: Add AIE4 work buffer initialization

 drivers/accel/amdxdna/Makefile          |   1 +
 drivers/accel/amdxdna/aie.c             |  79 ++++++
 drivers/accel/amdxdna/aie.h             |  31 +++
 drivers/accel/amdxdna/aie2_ctx.c        |   4 +-
 drivers/accel/amdxdna/aie2_error.c      |   7 +-
 drivers/accel/amdxdna/aie2_message.c    |  51 +---
 drivers/accel/amdxdna/aie2_pci.c        |  54 +---
 drivers/accel/amdxdna/aie2_pci.h        |  28 --
 drivers/accel/amdxdna/aie4_ctx.c        | 333 ++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_host_queue.h |  24 ++
 drivers/accel/amdxdna/aie4_message.c    |  55 ++++
 drivers/accel/amdxdna/aie4_msg_priv.h   |  98 +++++++
 drivers/accel/amdxdna/aie4_pci.c        | 310 +++++++++++++++++-----
 drivers/accel/amdxdna/aie4_pci.h        |  37 ++-
 drivers/accel/amdxdna/amdxdna_ctx.c     |  40 +++
 drivers/accel/amdxdna/amdxdna_ctx.h     |   7 +-
 drivers/accel/amdxdna/amdxdna_gem.c     |   5 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  25 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   4 +
 drivers/accel/amdxdna/npu3_regs.c       |  25 +-
 include/uapi/drm/amdxdna_accel.h        |  24 +-
 21 files changed, 1042 insertions(+), 200 deletions(-)
 create mode 100644 drivers/accel/amdxdna/aie4_ctx.c
 create mode 100644 drivers/accel/amdxdna/aie4_host_queue.h

-- 
2.34.1

