Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E72606A69E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nKlrSsT2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8CEE10F602;
	Tue, 24 Nov 2026 14:03:41 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C69F10F606
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFsJj3aAqmjuG2FYbpaCIM6x2tBa+TMnv+Y1H9kbnp0Yu0ySuk0tFlz+uLeRrDQTyiHRqARHoVjA8TFjfDa3yxRKtwvTp6ppqCiO65kr6qTXlrKZB0jOpKBMN9FdSuVN3GRYp35QQu70F2PPlNsxjOlMZOpN3eunLxsUdrGDmJVhAC52oVCHB5talN14iIfj+OCABZAFp1McN5U8rK2AvIQcfkPqC8zh1LOyOVu/kf/dsSTH+pDEHrrvByE3WFQE1keDQwO32qRZYzXSlhiNc6ot08aGQRX1v9A2yqTy774PJ5BkbO3iDyS4T0R1b38ej9kkgQ/JgExfFvcnqtHAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COClzCkiWB8pLbU9DmkfViUfjNA5sc4rtmig50y6Lgk=;
 b=ljyaHcQCV3p69DsK5K8TvKZ4P6cEAEqMtXbauuD56prnUZ3guP7bECXxClvRvB1Y2uKzb58JF8YLX37/VoR2AKtnTfHKZI900ID1hl5PcOlVZDi+NiIlOH9ohVk2/0fULBYj5jCe4gIpICdjgf6Wz08VXEcl6omoWvdyO+8MWi5Ghqh7YjserlXj6aVpdj4MekJdtXaVQeymrvEB3nHchV9iZY6YWWT1Q4xCYlj1MEAUATk+bIoaSTNSdh+waXo97mJhz/SBPx9SHKTKv0TgQnjFQAKxPyuKZyqBq5AJ3VhIZDDLunMm2UQk8JpoYnlMK5q8nQauPbD9ahKHXppIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COClzCkiWB8pLbU9DmkfViUfjNA5sc4rtmig50y6Lgk=;
 b=nKlrSsT2jBI4vIGVCEmk4iTbKjIob3PdAT3AV9lMFB6MvQQ6B8no5D7yaxpRz4yF8iSB49lCAAVDUlJ0TqQQ193UssV1UpT/8hVCxJTE5yMN6BXc8TR8F2I3sd5k3VrGXNBy1DQ8F69ZZ1bgs4qtwI7ulPiql+kD4OrK3TJBinzD/VgaUsOSUyzNQk19mHp7tlHgWFumy7qImv7JcTn3+iVc3JY4nSgN1m2g1w2GvbBd+TJpBluaESn3BS0MdoJZ5tV4NixnSZQYszdVHcjlClmuczn+y4uxoldeItFmR1F44QA6aOBG+vfTkLW2xrUSJ6UpesSlkKW34Hrpgiw2wA==
Received: from CH0PR03CA0078.namprd03.prod.outlook.com (2603:10b6:610:cc::23)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:03:28 +0000
Received: from CH2PEPF000166C0.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::81) by CH0PR03CA0078.outlook.office365.com
 (2603:10b6:610:cc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:03:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000166C0.mail.protection.outlook.com (10.167.252.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:03:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:03:00 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:02:47 -0800
From: Alok Kumar <alkumar@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
 <apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v5 13/35] gpu: nova-core: mm: add VramRegion
Date: Tue, 24 Nov 2026 19:29:09 +0530
Message-ID: <20261124135937.18583-14-alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124135937.18583-1-alkumar@nvidia.com>
References: <20261124135937.18583-1-alkumar@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C0:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: b5735a87-4967-49a2-9758-08df4a33b72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261021135927099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 8UEvmsvRYnH+nMuczAWXW1hxy6ZlhUKBM4SdubP/0eqdkPgeuOoQKEqmCf2uBVjS58Grho/nQfiTQ1YdcgC5m+Rap8MBtyfm9SUGxzhBV2/PlJJwZV8ogCaKVqwRcBYpXDi2D2B9ZzoBie/rcA6+isIlt05PzPTV7uHy+yvTUEelGTD4iZLELJmbUP6PShRGzXjaCePxI6p1kPfr1Efn+Gc/DYrr+ONJEZyl4THYiyA6bh+LjPouzMAOdhRI40Ev2UM89bAr5oF1gFnZ5JV9/SQfxx0NbMqI8nAMBrDg0oD2BYbyISuSoBotPpLBlOpUDleNoGeCwehd5pcJoqjPJmtoCm5K/F+37Y5MH/xvQqYHZBM4h54rVIRHTV+TbGEy8uYDN1yJ/PQrdMLtYd+tAGRrNA4wrRIa8vjvRxV/qFpCz6Ffaw/n8aR86bTAYoSaPdo8be5xRIwp+9oOO4isaBDSWFiva5xJATcBTLbR8E7xutzaZDnYnktzfJqIJxUUPMbVkY6J1hz/YzGGw2iDsUnqjWHzKEzgAMK1YHnY8T+YTJZ+8hXLmr/DdrwFuqLYVxPCsDrzm7VasVMfpqdkIXwdW81rcqXQ7FP6CcNxkJ9n1XsJEt9ZN74xVs3bvDjT74Es6efRdoqEnMwh/g61Hitx7UDmOgofPL0SF4/6Dxx7y4NdZFIVQqzifdu/e8hbQBwlo99aXxIoOaVpymOtBg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021135927099003)(10067099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BSYXR0gNEiHyXlXm8oTbKnhKPfAHQo2fzs/Ri4WmQtQNbl9OpILm9DNXANmQKOThu19UFh0MpVdoWmTy8JogPu+KrgGmUQWxow4VOnlGP7tXHe3/9e5LciPwGWmcEQ/BemjQWa93M6c6IqrpFjSSZUlwnu6DGK+iXmlEodFSiIoz/PpA1l1wHYa6XPrYG2r1w9ey+8HVmkJQg+P8dkCZPPfTKML5d2nBg64ZdEafHNkN1y48QOXTM6Q6c6uouJ1pHxGpdTvJBGXuxxqex9gbzBjF/R2lDu30HAg9rO4Rq8rHRC7Pi+oBEXtcKXkDsObEBb6BCW9H4GCFIuJl3e3oOmmSU7dtXfW15g4Mk1KmiSnsJni6c4DVQpe37LtLf5Ac2Br/MKWVRnmvQGrTxkxZVkieOXc+45oXBZEvpd95liK3R4ZYC0UF8FhSlYVLRxXD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:03:28.5853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5735a87-4967-49a2-9758-08df4a33b72d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
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

From: Zhi Wang <zhiw@nvidia.com>

BAR mappings do not necessarily cover an entire VRAM block. A region
layer lets a mapping select a byte range while keeping the underlying
allocation alive.

For vGPU, communication buffers occupy only part of the management heap
and need a BAR mapping of that range.

Add VramRegion to describe ranges within a shared VramBlock and support
bounds-checked subregions.

Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm/vram.rs | 56 ++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/vram.rs b/drivers/gpu/nova-core/mm/vram.rs
index 6839960eeb2c..6054eed9aeb0 100644
--- a/drivers/gpu/nova-core/mm/vram.rs
+++ b/drivers/gpu/nova-core/mm/vram.rs
@@ -22,6 +22,21 @@
     PAGE_SIZE, //
 };
 
+/// Rebases the nonempty range `rel`, relative to the start of `base`, onto `base`.
+///
+/// Returns `EINVAL` if `rel` is empty or does not fit within `base`.
+fn rebase(base: &Range<u64>, rel: Range<u64>) -> Result<Range<u64>> {
+    let start = base.start.checked_add(rel.start).ok_or(EINVAL)?;
+    let end = base.start.checked_add(rel.end).ok_or(EINVAL)?;
+
+    // Check that the rebased range on not empty and fits within `base`.
+    if start >= end || end > base.end {
+        return Err(EINVAL);
+    }
+
+    Ok(start..end)
+}
+
 /// A physically contiguous VRAM allocation.
 ///
 /// # Invariants
@@ -37,6 +52,47 @@ impl VramBlock {
     pub(crate) const fn range(&self) -> &Range<u64> {
         &self.range
     }
+
+    /// Creates a byte range relative to this allocation, retaining its backing storage.
+    pub(crate) fn region(self: &Arc<Self>, range: Range<u64>) -> Result<VramRegion> {
+        Ok(VramRegion {
+            backing: self.clone(),
+            // INVARIANT: `rebase` returns a nonempty range.
+            range: rebase(&self.range, range)?,
+        })
+    }
+}
+
+/// A byte range that keeps its VRAM allocation alive.
+///
+/// # Invariants
+///
+/// `range.start < range.end`, and `range` lies within the range of `backing`.
+#[derive(Clone)]
+pub(crate) struct VramRegion {
+    backing: Arc<VramBlock>,
+    range: Range<u64>,
+}
+
+impl VramRegion {
+    /// Returns the range covered by this region.
+    pub(crate) const fn range(&self) -> &Range<u64> {
+        &self.range
+    }
+
+    /// Returns the length of this region in bytes.
+    pub(crate) const fn len(&self) -> u64 {
+        self.range.end.saturating_sub(self.range.start)
+    }
+
+    /// Creates a nonempty subregion relative to this view's start.
+    pub(crate) fn subregion(&self, range: Range<u64>) -> Result<Self> {
+        Ok(Self {
+            backing: self.backing.clone(),
+            // INVARIANT: `rebase` returns a nonempty range.
+            range: rebase(&self.range, range)?,
+        })
+    }
 }
 
 impl GpuMm<'_> {
-- 
2.53.0

