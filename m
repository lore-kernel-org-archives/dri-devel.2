Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41F606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=reM2ZjY4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CD010F244;
	Mon, 16 Nov 2026 16:11:38 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0672810F2CE;
 Mon, 16 Nov 2026 16:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ouh2VAuudoW3tP/SR7BJi9pKMkud5aubfYAzbo0+8ZiO4z26YfUf0Kwr4HyTXdJSmV3iSmagCpanDD5iTQInhV+V0PDotzQt0l8siItlaCUl9XGOToo1E1iHXnnsHoaT3lLz/h+9RTCnELIGjOqX0ReU8KpsK8g9/40M+Fm8335AREE8eI+sQu9KpuY/gTtSbx+9geB7Jf0Z8ciAru4u7ag3gu1OzqlG1vZ8PeYF0QYBv5Ql8nnjer4vmOX7UbMkkB3xzUL9Wl9LtfbsuJnrFGJSu4hUj6MEun1umUtRo0jkxe3ELicjrZt7+Nv9jZAwH5QQvyNWyM1ABZ1UI4bPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHpl87zmF1/4nKJH4W4E7I3trP5FZmdyQm1H9rGiW2k=;
 b=NScXw6tyx51GYPND4TB9FCDL/YcEggeqPLSfk2JzkctG9wrod91nZ7QNvVag0ij9rWlXqj+mCoDlLn6SQnGSw+oAxtjcysO2mn9DtGKPE7DrBPs7Xjan7Vp0gRDCI2fBXTfFlv2FyLc14Im/ZIblqsi2Ql0irYyhbmQxJzx0KD3sBpqxhD5/mA3ZdCnuBrtwqAJX/Lq7PZxD5ZBsvtIhfEUv07DvRv6wXssBYIrBwyW7mqMtinjFLwJQ/je2++B4JTuWKXNCAlZPAe2pq+KdBO16Rj+zWS9c1/ArArISTxArKQbi/wexPwf6KtP+e67RXye5QLRoNsbvFDDOdXOtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHpl87zmF1/4nKJH4W4E7I3trP5FZmdyQm1H9rGiW2k=;
 b=reM2ZjY4SI77nPIjOS+mkgBeEp6agKH2FKag47LhN+0397skXHwz6kgkyk1OYM4zNImSIVvbj2698lwQAXu2hjR1ezwJJ0s+AxdgP+8n4T2W+fhpwkEut3ZW0ADFi0naTM28nH2h9IqxV6JqN96TWAe0/oC49i0m3EOKNYUwrx4=
Received: from BN0PR04CA0196.namprd04.prod.outlook.com (2603:10b6:408:e9::21)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:11:16 +0000
Received: from LV8PEPF00000059.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::17) by BN0PR04CA0196.outlook.office365.com
 (2603:10b6:408:e9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 16:11:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000059.mail.protection.outlook.com (10.167.245.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:11:15 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:11:13 -0600
From: William Palacek <William.Palacek@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Sanjay Yadav
 <sanjay.kumar.yadav@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH v3 0/2] gpu/buddy: find range-biased blocks in the free trees
Date: Mon, 16 Nov 2026 11:11:00 -0500
Message-ID: <cover.1794845083.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000059:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f08652c-bc4b-4e16-4a56-08df43fc3daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: dSJH5cNoL8YBSALz7YLbBgYJkhNI/947Ysg8zACe5Qa4vSHPMc0glntBhHjnsAbLIg3GpbmP2+yp+wKbVp1hEFyQAq+3PF7I9fAWWu4gLNX9UxSmBEy57y8Q4nUNjkqHQAdfgjveS/YsawutkurucFs5iI0bavUre+mtb8lgE1sYJJMiYn6+4Ne4BxmmyWt/R5yPZYtm0kZ2CAjjmjb8DJdqRCepxUT1efURkujFINFMXvNStvhDtcVeOryouCTkzjGwB92t41J48gduBIc+x0yKwSA1pt9JREbJWUFuWijM3DVnTVCNYdPPjsE6GxaPq6giTlxmedVQa0WMsu3SjG0eSPBqGhEYAD5DL3UA09feQRAg8KlNGErjg/CRQpwfGwKFACcM5n0qFgRG/OmjkDdh04jhdARgTIzpNS27+GXlcjZb/EtAKELRzzeEdd/DvB4zKUhS6rrdGzGa8Isqd46wzsPWzEE9kRVSBxvU9XxlLZwf4LoJuago0AeUK+qc0uavJHLSYGyu1CvshS+9QMv52nAAilL4A6/VR38yZmiwaPqyYAsCpKzLhaye6KQOoh3Me0Q3PJpmKYI9c3AS7UZ2nKvGBvksobWoKmkh0jC3oAFBZkaeyaUpQjpYwDBbP2eQQIH94frYHeCpssMcgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +xKzFCUTprhW0QlJ4Z80lLKyE0eiapPQKQcoRtGR/J9HbivvkgodRReVuYr5p1H5tNDLKutlF3dW71sc1Ceajea8cboeNOD0jI/8+mmDSCV/Hu4O2krnZv3NJeEfjyJ3HJVL1gdvZS3k3C7zfY5loXB9BO973WjM23tZcxhiF3qr6dhJDbBbvM4GwBjck5E+/i1h+cxEH8v2sq3PpObiZKV/xBEbPUonpyJEWbxIAV7JbAQZWLCy98t0ydz5SxJ8LGSJvZMIalKYygFOXPb3h3M4zWj7By8dPdjs9JV4LkLbZpfeoght5y9C2Xgrkf4dvEu7rmr9aT+1ZL8CChQ0ElJZNgH10y4CGOoMtTIDTuptljUBn1Er8z/VaAMgLAmIHUzbwOjQ4WNX/YJa2GXImLrETo7jO8rZ1E98qCwT0N9Pg53DsMP0dp0q1vAKkBRa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:11:15.4855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f08652c-bc4b-4e16-4a56-08df43fc3daa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000059.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A range-restricted allocation walks every split block in the range, so
its cost grows linearly with the number of live allocations there.
amdgpu restricts every VRAM allocation to its memory partition under
NPS2/NPS4, so on MI300X in CPX/NPS4 KFD allocation latency grows with
every live BO, under a VRAM manager lock shared by the compute
partitions.

Patch 1 replaces the walk with an O(log n) lookup in the offset-sorted
free trees, based on Arun's class-aware version of v1; placement is
unchanged. Patch 2 adds a KUnit test for the NPS4 pattern (range-biased,
cleared, top-down, 64 KiB) that also checks placement: 1103 ms before,
2 ms after.

v2: https://patchwork.freedesktop.org/series/178108/
v1: https://patchwork.freedesktop.org/series/176957/

William Palacek (2):
  gpu/buddy: find range-biased blocks in the free trees
  gpu/tests/buddy: add range-biased allocation performance test

 drivers/gpu/buddy.c                | 214 +++++++++++++++++++----------
 drivers/gpu/tests/gpu_buddy_test.c |  27 ++++
 include/linux/gpu_buddy.h          |   1 +
 3 files changed, 172 insertions(+), 70 deletions(-)

-- 
2.43.0

