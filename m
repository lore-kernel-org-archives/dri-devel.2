Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272FBC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD05F10EF39;
	Thu, 17 Sep 2026 14:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L6IDDSOl";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED7210EF19;
 Thu, 17 Sep 2026 14:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5awjF6EcaXGp7N8EA7x33fGWX7SMGO0hIDdCjc0DFwMFec9zMzzO1kKOG7xt0kGlju00cuz3tM9Jjs3kEDa+sfbnH8E7voUHhThhacUK2o5L85MQ0XlBoaqz9eEptnF8dC2y+g22gnp9nJ+nI1FAtQenFVKfJLD/r4De9DYWwVEDpSpn1+3IiDb1Oy9I4ylihhMuxp1aYxhdl4Kmt2afC8T53AsmCd36WTP6o4S2uMqv0zeIHx/CmUrc/R3DyyTP6XUEAn3/fYYHS3V8mkGKxR8ytMii8i1mhSciQd60lXqd+DynY9gdwWSeCOU3pJ94piLOJ2vKKBpYkLmSHpHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2++VU5n6gdyF34uFGh9HCkvo7gaPTV/G00Jt5KjJTM=;
 b=WHwaSixGgpTlE/T8Kh0T50csRu5MjhVtnpoa/ILDOW1U6XWRLGrt0T5GR6t6/9ADRIgnpYDmT5du10RL28Rt/CkLWoVvbjK+Mnh38xz86sxccWiuFROVnlQjCVfj3CsCUdv1Tc2ulEuVAPRmEtMhr2t0zJiWIerFPWsSsG5nJXCgdRAQvV7/yJ/0/bwhW5PD7QlymeHB+rPKwVMuoGV71DCUm90/Ztzt/Q3C9PM9Paf6hzrtE4Txo8wbUkfJZPc6TLzCWK3rkIleETs3ekoDaFxYX44t2eDqDndy1QWKuk+bppAUXAUQYuFlqwwhbi1pDjXDnoymGJf2NJvqeOWYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2++VU5n6gdyF34uFGh9HCkvo7gaPTV/G00Jt5KjJTM=;
 b=L6IDDSOlwKpxoJxet2DQC0dC9gpWUtvQQfqsZEORQvA8kRk/7a/xlkvrTTITvcQiYwMEnIeAB1JqCVo5XTsB9R6nTc0IRBY1HO4byZhMURirisANfm2S1L4/2bULGmQdGwlG8SfBHez2COxAU06T2JqAuU2WDxQwzRef4DsSYYk=
Received: from MW4PR04CA0384.namprd04.prod.outlook.com (2603:10b6:303:81::29)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 14:36:18 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::53) by MW4PR04CA0384.outlook.office365.com
 (2603:10b6:303:81::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 14:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 14:36:17 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 09:36:16 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] drm/edid: Honor overrides when DDC is unresponsive
Date: Thu, 17 Sep 2026 08:59:47 -0500
Message-ID: <20260917135949.2552704-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 30084067-ad67-4862-b0ca-08df14c908cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|3023799007|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: D2jYWJpc+vNCMtJLQo+vu0imjiiXFa3sxZTT3XDXjcMzE8mYvEuXwqv4v75FQ14MBpvnqP0zBuII/6q3528Qq05CUGVRpmT/qoBXZRLyuiviu6I1dj5bQsh5R196+a7BtQDW7GockWs+oJKpSz609u77NLQ40hFe36YQWRHFJCJ+wcmO/IGiNyLe/9zAtY9YqWupvzL7oeOYNaihvjhGBfwmHJs5YDNyzEXoF7CurW0vIX1H2WlDIUtGnvf/uRlGxj75WuhUdzLJTQwAW9SINl2pcNvWeD5MFfa7BlF8kp7S2GLsaWDOhos71gJWsZIniQCgAirhMl6H/T+nSp4qzmqP1K/yy44LMgnycoTNyoOFNePthXI6yeVt/ouOx8aLY+XgG4zCnxQqeAH6duxCFl0/lgHEVN7yfkGFZm2YKtu0Nlrx+vbeRQqqSBxU7imwIN7BMbOLoQz/flN9kjjfBgjFQkaJTA7K9HQgqBtuU4Jf9mYRiFjVTn8EcE8Qe8utqn52xA9IOQ169IWU/povt5hEN83AFwghYR3l5DtpqyRvSbsBYqZ9B40JbHIF9Wuc3KYCanmjq6UEugwpKjwyuQpsYdkOWV7lxPYTuZXCoRd4D4HRSedtrUOo5LIiwBHKryaimUmV4P4ajwyKV8X1+T9pye0/iC5Wq1oq+ayeFT9G679OFyW9aQeGSTr/btnlzZa7LRz14XfcqVn7IKyFAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8eGZCizR2UZMT1bUj9FJxB91GEkGzJ/NA4bDxjNQQiDcwxjGhz+4x9x3kiAYNXLWPAfuZGhakUfsku6055f7BKD6ZpbjBelFdLq+hbTFPl1z6S1qSuI4M6qtDAX6QMONZg7LhrkV8XSrIHS9oUgYsESE5lVDb0s8EMtj/Xh6JjspqV+5zrgVSHx6vNIjmjq2tXGo9M0DoAQx7XCgifV5zL97QaVrQNw93guJBYYRDrpZYL/LXIDozvgcqvthcQ7IBf1GTgnLlmBhLn4VSFb0ZeGy+EFTEgjUMDw7/eiTMnH2nKw4Q8TL0nJ1S4oyF09LwhK3rjauSpcLcgx2oOay026vEz/6T+DvhmF+STorNWg/UX7cwkvD7tA9TscRbRZu5qtkAk4DXanUSGXxpELrjB15M1bHo1YgMZQpYnTKXj5Jh/M6GJFIM2j1VtlxKN0e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:36:17.7239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30084067-ad67-4862-b0ca-08df14c908cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

DRM's EDID read helpers probe DDC before consulting debugfs or firmware
overrides. This preserves connector-detection semantics for drivers that
use a successful EDID read as evidence that a sink is connected, but it
prevents drivers with independent presence detection from using an
override when DDC is unresponsive.

This affects AMD Display Core, which establishes physical presence from
HPD before attempting to read the EDID. When a connected sink stops
responding over DDC, the configured override is ignored and AMDGPU falls
back to a 640x480 mode.

Add an override-only EDID reader that does not access hardware, then use
it in AMD Display Core before trying ACPI, VBIOS, or DDC sources. The new
helper preserves DRM_FORCE_OFF handling and the existing preference for
debugfs overrides over firmware EDIDs.

The first patch introduces the helper. The second fixes the AMDGPU
regression.

Mario Limonciello (2):
  drm/edid: Add an override-only EDID reader
  drm/amd/display: Honor EDID overrides for connected sinks

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 14 +++++++-----
 drivers/gpu/drm/drm_edid.c                    | 22 +++++++++++++++++++
 include/drm/drm_edid.h                        |  1 +
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.43.0

