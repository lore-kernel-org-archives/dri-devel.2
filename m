Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAFDCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4461A10E5A7;
	Mon, 22 Jun 2026 09:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EFwpyY5H";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3AFC10E5A7;
 Mon, 22 Jun 2026 09:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3SVgv+Ipw1pEYXlXlgiFLtElCiwunUCdwAd/EQWvNwrHeBj1ctZ7BjtQE2DVexkycIeOAtYXaXnUtnyV+193yaNlZwQYVs+Nh8iTEWDDCN17HTsUWg/6M73HgzEpzCS9bESl5/HOkQ/tO6k3cq9l7MdJK0fgXw8826WD6JsPrlawuJYP2V8tzU+OWem4iYF5bALiLDaQLS/7Yu7kRfHM/kuH76u2T+CFw7l961IcnM+Y9Cw5uO5Ri9gwt7Emj6/J5RFH3pFY+PdfhczPrLRWY4cS5D2yphh2+dBf105qFDABoi+z85UqHYzS0eXlIcT/6RdZys5kRGkk5jUyIswuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAmu+hJ+hVOCAbCCiBbqhfBWcqhqApEgYgjQ3VEjCU0=;
 b=JXQGZRbutiA6RZFrXIwpthZyTTBfW3HwBnO0iF5pBm93QQjgmgn16640kmjGFbXbg3avXSIwRxqDbN+rVMlKfQSJNyoEP1s+o5G3kUlr7wqFqcwRidHkgpDM6Lg3sY3S0VvAcbekOmerYs7xL4tAwR8PzdMFMEGfYE5DxK3yTD/qmc/4vvkqnD+161V59vuA+QKxCJ8JCcEivtJQxLIrH1dLAzA4orrCGrX/DKEfmIl5nM/muEHo0NgUF3CVqTDcYiTRys7wgiX7WuhAaqKCmFb0xesRG4m0Tj3rIY5Vfnh7sQxLZK6N3CucS9jXekui9fr8C7CJ3OSLchQIKg75MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAmu+hJ+hVOCAbCCiBbqhfBWcqhqApEgYgjQ3VEjCU0=;
 b=EFwpyY5HP5lWcBUIzEUf7JlM+5651UQux2Q8jHzplqbD1+0zw2B5/L/sXCg78YLHFkbcr8H/RRgQ8Frg+QW0mcLrzMqDsMqmAtJ30rNznLYEXZ/o7InvoYlG1tZIEPlhDalY3lvVlnpgO9uT/qCt5GqzHw1Pb1+7BI0EFH3Dn1I=
Received: from CH2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610::25) by
 SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 09:30:16 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::91) by CH2PR05CA0012.outlook.office365.com
 (2603:10b6:610::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Mon,
 22 Jun 2026 09:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 09:30:16 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 22 Jun 2026 04:30:14 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] drm/amdgpu: remove left-over variable
Date: Mon, 22 Jun 2026 11:28:58 +0200
Message-ID: <20260622092859.3600-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622092859.3600-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260622092859.3600-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 3892cf20-f2c2-4772-fe7e-08ded040de69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: G7szXsi08gTs3ZoXpsgf6cN/84DH9rcz9O/w0Sz1p3jFegl5Dq4hr2KrnjuU/NsAhLhLvDI8D0wkXpGHYP5XfxwzBW37OtNkCaJ5/WwZjDxgmR5UvLOi8MbAuqaNHZzvG2Y1qwyNuxgNisDK30zPu+GY3ZSCUxXh1q7rrjybyir+8nAW5IdtYVh9Vl2C5iQ9/esf/l5rkvroP3xcuI2kJ6JYVSzWTdTDjZNCI1Feoz0fCmeXO9bKhVtwNEbO+cD2CwF6ny1l7TsTCev++RcfWKEbJk0U2FGt3rzsPNYIbGfNZKuR6mKhhRPNcwMUb5upGif1weMU8UeE9febUU4RFbPAux8gETW5uZYPse3s4Q7S7i0AlRHs9wkXVHA045Cfl41T+B/av4gZxo61elM/tLdlsiO+3XwxKm2difDK2oECqv7zsQrwLAcE1VxFbCpPI773E6fcsmEWR+zy6DlBwSqleVAATBp4QStSqZa4zVGDk4lHrqkxUAHoyjr31HaN2YxEWgSdhCFnaFV54pQ86laMr+nmR8DLvn+9jGTD3JukG8hfwM1BnQrugusHTBm9salS3bE4x+fJmho9uHTrqr3gSiOHi1KbnxfJbcsFQNuUB1UzlRsBRKe1X82owvC+6YpNBjB5LLCGL42QEPFqzgBWDqduVmvR+PZABBjPBJfkoWag8B9T6gGaEszgik3qGCEa5rEGwCtUqt3WHTyewg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /4nqfRapy8bz5codcpE6ETY7Uxi8/GPTs5qL7I4XwLdQqUYv3C430VU+DIcuXIgJ3q6OK2tv3IyYOnYveFZ36hcoReNaGOaLnc1MMxJqXMtYJtHCjaEQEDtwV8W59/IqYSMBgAJSQA6onKHh4QNwkVLE++ARTfI8FiXQFA0u0IT0zvgT9cSmnhB9cBIptoMGZkDmjQQEpgDctLmtSbeHtEeHJOGAGuddak2GGEJtavy5Hbf/jMJKkqI6nyeyd5GEyUHPtNxA4fK0Y1zeed7AkoYEfM3JWB47Q7k/IeCNxz0XnB8QhbgEUt45aEBiFrCB0gfZVLsRg+qgt7OA+wcyUHPMlZ+3v/4yBCJmd5gfHbYp6+WZOLyLjy7xXzr0nNr26PWxC8DIxmG7tsWrGUN3P704aqT5wEhy5yaqeGTUo7sdiomiTa7O1fC6cdTjeBZO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:30:16.0767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3892cf20-f2c2-4772-fe7e-08ded040de69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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

887db1e49a73 ("drm/amdgpu: Merge debug module parameters") removed amdgpu_vm_debug
handling but this variable was forgotten.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e2d4be3c111d..3b78503ec78e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -182,7 +182,6 @@ extern int amdgpu_vm_size;
 extern int amdgpu_vm_block_size;
 extern int amdgpu_vm_fragment_size;
 extern int amdgpu_vm_fault_stop;
-extern int amdgpu_vm_debug;
 extern int amdgpu_vm_update_mode;
 extern int amdgpu_exp_hw_support;
 extern int amdgpu_dc;
-- 
2.43.0

