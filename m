Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE74CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 11:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB24E10E244;
	Tue, 26 May 2026 11:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5JC0cr7n";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6357410E244
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH9Bz+uA595Qz5H7jO6hqc9odfa5tjWuct0/kSoi5YjvV6rQ7dX7Gx1+tn8/qzT4RJM5GlmXx+XCh/ZTxPHyNAe7ACzWYwHSIdTIYbxxxl3GGlxfFh3yxrOVw8Vt2eDHc9AWvkQudu8dILxSK+icB2/gdb7dE5cIYx80KrcLjis57SAuMC9MjSIK9/Aze0xDsqHg8pzO/fo3rIs+RZYZxwhXa2xC7u1OIKrPYu4MPVUU+miF5aEf+RM/0ZXbojgavdUSDhx6mhwApYtjFzj9hyjOFTnQNGtB0RuExRoHAkmbDAdtSHltV65UHY/LaLCK1y8ODYWPYjcahmJXgpIP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1CWIZ0zkWf3sFhGIgbqhLQceLgewneqANZycTMMRvc=;
 b=C0Tbpf2RGmrsQh2jVrE1/dj2h8xOElrchhdrEYEBCbXZsytsRrkENoeA0JF67IXveR6wkAbfkah0L9q8zhv1fBpaHuu5qfMEDO4ILG6VXnLbYARQW9bz5SAWbgT+nj85fdnXse5BwYwYz0uJXxPJZDwtVQQptKnwd9nhHHBBdeqAyrpJ44+LBPQGMWC3hj3ZVDc18a3qs9fw4ddPLb7OxxwmeDkkLb7edDlMvtFnC81h/eOZf9/sAtxINxFHUybii6qcM+geRrMD/aiGhEj77Orix0HSqYL9x3BRfsDd8eX4gD7ZMmifoYpjRJHozIFqvOzvMr4ig2ldQ+KsCcoELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1CWIZ0zkWf3sFhGIgbqhLQceLgewneqANZycTMMRvc=;
 b=5JC0cr7nWIZ9OoiEXPmx2R1UFfgjGE5+NFKCnFxB7V0i7oPnTtSUyFl5PBMczD4gcAmC4vrJ10btaO1vctbspVpLTXGXsSiXS8UnI1/5/oOSkmP8lNBAYIB7O9vGmZP+w0wRYTYW80JLBWMJ0ZNhDK756a6LOAaWi8BmmfHM+VQ=
Received: from CH0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:610:77::28)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 11:10:53 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::3d) by CH0PR04CA0053.outlook.office365.com
 (2603:10b6:610:77::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 11:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 11:10:53 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 06:10:48 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Leon
 Romanovsky" <leon@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>,
 <iommu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <linux-media@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Ankit Soni <Ankit.Soni@amd.com>
Subject: [PATCH] iommufd: take dma_resv lock before dma_buf_unpin() in release
 path
Date: Tue, 26 May 2026 11:10:34 +0000
Message-ID: <20260526111034.4079-1-Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: cd42f7c2-285d-4b67-1f7b-08debb1773de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|36860700016|376014|1800799024|11063799006|6133799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9zaVwTxhzMJeILH8PVK1Swgflw4C47fpUlETzU8w6D12/1I8o6QQHZvnC9Fj915wB6KbTHrosG9MFve0TnWZsec/pnOLS7Xo1oypBV7X8B+trml9pgtZgmoIK7GL7JmkugPbUjmavFPT8YdJDuvItFTKBm5LzRmW/lDeJFFB6FMgP8CdqJWn+xvIjqHaiUHlWTn7qVCEUoVk9FBZs0zpydft35kC+Moq2Q199P6XA031LKWqf7dtFm8/Uj7a2NYHptpDHwl1XBjwKQMR3vMzSM10wR5Ot0q3aleKkYxx/94znSQ1y7Txbi0DmXCWnnzcTbY0crWp/3ewWX3Lxmiix4XxUP8waiU8+7pK8n9KAfz++bljLgEsMvyTzmEFtCsEmOLrW8pnN4khlXIfRHb3bvuF+bX6aLrdYeY7L49xqCmEYqUHVz58vg4y/Zcin2vm00yehNGThr8LHZKP8QwHzKx7fSGTDWZguRysOvcicAaoMCvB9CUHmARusQBc/NBkyBy0MW5qF2G9856ybMGpwe9PWXV0gTqsw3sxlJHikae3rYe6ceQ69rHjPzujBUQQP4Ooq6jAlJCddW2puy7Q4bKVrHXZFl4p78UfS2kVXTa2E+Ed1UYBgViJ8W7ew4VLoyy5rs4OK57GNJh/S6xmPuegV+ieRBuDp0NTcyOrE1h7zFWijYNiJVBRygTVnYNW+CpX5yL8WAjZGSdSTOsy/GDW51HQuqpeYfTQJuY4izc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(1800799024)(11063799006)(6133799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0iA4HrXmxGS0ykZnl5K6iTE53f/w3I3sn+xYvLG8xaSmQfakBE8Nh4hINpL7RnI7ubRWvNBdApTapf7oF+W1UCCDH04TH4uKClaGILL7+vNV4FCjy8dgIys7p3jcwzgPGzo6mloQOV57vfbIV5UgcEIwUES3fEbDZjnomtzg/hIl02dTgW9gzlnAMq9XuW+GoVenR1KCVw76pj8AsQxmabv1Kxn584x6iXvs5UlKrNHaDmvOPUYucgBvi18ZNVxZV3EjXQByLGmPlFk9SCgnZ59oicCm9/koJQm7daIAC2MlDj8R41gVJK/F4bMfvAZvapF8u527Al8Pp6ZkKd6gEu+wOY9AlQubIvJ3R0TxZ6LP7vejt1kRyhv05hXNqUzg+i0JaNpMmiEukcd8ZTuJ+BnIN8dHC3gdf7YvjXhlodZD7eGu5ghb95Q0Ns8oCauk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 11:10:53.5228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd42f7c2-285d-4b67-1f7b-08debb1773de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
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

dma_buf_unpin() requires the caller to hold the exporter's dma_resv
lock:

  void dma_buf_unpin(struct dma_buf_attachment *attach)
  {
          ...
          dma_resv_assert_held(dmabuf->resv);
          ...
  }

iopt_release_pages() calls dma_buf_unpin() without taking that lock,
so every iommufd_ioas_destroy()/iommufd_ioas_unmap() that releases
the last reference on a DMABUF-backed iopt_pages triggers a WARN.
This was hit while running tools/testing/selftests/iommu/iommufd:

  WARNING: drivers/dma-buf/dma-buf.c:1137 at dma_buf_unpin+0x62/0x70
  RIP: 0010:dma_buf_unpin+0x62/0x70
  Call Trace:
   <TASK>
   dma_buf_unpin+0x62/0x70
   iopt_release_pages+0xe4/0x190
   iopt_unmap_iova_range+0x1c7/0x290
   iopt_unmap_all+0x1a/0x30
   iommufd_ioas_destroy+0x1d/0x50
   iommufd_fops_release+0x93/0x150
   __fput+0xfc/0x2c0
   __x64_sys_close+0x3d/0x80
   do_syscall_64+0x65/0x180
   </TASK>

Take the dma_resv lock around dma_buf_unpin() in iopt_release_pages(),
matching the iopt_map_dmabuf() convention. dma_buf_detach() acquires the
reservation lock internally, so it must remain outside the locked region.

Fixes: 8c5f9645c389 ("iommufd: Add dma_buf_pin()")
Reported-by: Ankit Soni <Ankit.Soni@amd.com>
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/iommufd/pages.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9bdb2945afe1..7b64002e54b9 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1663,7 +1663,9 @@ void iopt_release_pages(struct kref *kref)
 	if (iopt_is_dmabuf(pages) && pages->dmabuf.attach) {
 		struct dma_buf *dmabuf = pages->dmabuf.attach->dmabuf;
 
+		dma_resv_lock(dmabuf->resv, NULL);
 		dma_buf_unpin(pages->dmabuf.attach);
+		dma_resv_unlock(dmabuf->resv);
 		dma_buf_detach(dmabuf, pages->dmabuf.attach);
 		dma_buf_put(dmabuf);
 		WARN_ON(!list_empty(&pages->dmabuf.tracker));
-- 
2.43.0

