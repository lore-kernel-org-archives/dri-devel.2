Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58239606A6B3
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CnfN0C8g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B562610F605;
	Tue, 24 Nov 2026 14:03:55 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87CE10F605
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHFwVnNG9BsgWUPSgExPjaGpU52dJBoyUpIAn0Uz46a9Ktj2nucgY6S90IkzewBUriVsr6HFF7NHdzhMarR7Ho2nW6Y3ymCkh0xDNWm5IOMA5qR9vXGlzjckNpQruxS1Cd937zDdPT6H5SFfEOJWtzc7/MlKCeADwaLU8FIaFgQEUUeLv+pbIxkcMt6ofZCNZNVNDxHRL9ahWc3MUTakhQeukBAxaBz9POca3HO3KZBNws+p3ZMq+L4t8A54nV25+xY1s5VrppiMwZ6JRaIpClbadi5h5oUdtU8VEQ4pTZAqCwZzBtg82vQyhxELN/olEIjHluL5NjkumWh84ncz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe2sbdRIty4vY8cy/krjXwZBiUKMZQA/Q12cwJVQcz4=;
 b=iDkTeXwPE2Ayva2atWPlQ+JUOpuJ5qIMPRoLiE7TzB2tLCIGCD8cJxY5S0ELMulvWXz8+CzpX+GN8aOkWpaWQ2Y1Dop7Ob9sMZ1EWa+HSP8eIJhyXcTuWGJVm5h0xZqz9Q4LqVY/74Mvs09CSgo5Epnsnvg0c/EDNJAAo9e6ej3U2ZCMroTYW7DFDiLWwjeceDyhMq2bSxwgfNnbfm/Lr9eJCu6pZnGU+IuhALJWyFMzwNxtw/FIgCc8rGtvVolU7718D8Pyr7EOAI8opEnAb7qox30xsJjSnvXXIrgUXfBsUfx/UQ5XE/bQ8SYuPkNM1ho6OelT99FRWqbPKHpxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe2sbdRIty4vY8cy/krjXwZBiUKMZQA/Q12cwJVQcz4=;
 b=CnfN0C8gGp16xAXHXAJTlr4xfcHun5hECufgd3vr/MpW08NjSz9JpuDrQXErXFUhqsfLmiD3aIXSyZ6bf5xHaK5ynwcnfjzQ0D3x+jqpXOTlMLPfBQkHJHRkcDM+UmBj98dKVMa7HRuX4Uw6/pvqunzVlWND7fuvNloqhktuB2x36kDfH7cwBoavhMuYjvv15alh2AzGsgQRQiRJWZIb1wfgDlEXB7cc0RWwON4DktyFpEQSg5kTlYqyx4oBtVHrvgJCO8wHpajf1jLojz7+QSRKLOy9PADBpp442tarpVYrEk4gh1Lc0uEfIHyTYYnIUzKo/sfHXvU2uVGSwkZCuA==
Received: from PH0PR07CA0038.namprd07.prod.outlook.com (2603:10b6:510:e::13)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 14:03:42 +0000
Received: from CY6PEPF0000004E.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::27) by PH0PR07CA0038.outlook.office365.com
 (2603:10b6:510:e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:03:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF0000004E.mail.protection.outlook.com (10.167.247.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:03:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:03:13 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:03:00 -0800
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
Subject: [PATCH v5 14/35] gpu: nova-core: mm: add BarMapping
Date: Tue, 24 Nov 2026 19:29:10 +0530
Message-ID: <20261124135937.18583-15-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004E:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 693f92a1-fc02-447d-eb37-08df4a33be70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|7416014|23010399003|82310400026|10067099003|56012099006|11063799006|261022075727099003|261028144727099003|261021135927099003|261022105027099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: zbDSVfRp2Jo04V6G/PIs4aylTg0/tKRpLaOquVDCfZolVDPhV/ydwe6SPrRlI9s7rMdCKAv/F/+Mi22tPJ3rRwzxVfF9XTOqdrsq58iXOxRcFY6UVQwRUAqtaSYAGXahlo4cFpMyzIsqA4dA2F+MUETkgS1aeLEJqqxgqHHnx1dcZOAP9Hban0DEeFaJ3ijKQdZqTYS8ljW8HES2++0j0dPhv7NLTZ2bBc4b80CB2pqJo7fgbqOO4N6bn5/F0G95l2u8sCaWFcwnqcAlligDC22LEjKD0Z25Mo0qRjTNIM5sV1L5mcsAlp7IHUQxbiG0U7oxU+PENK10pidDBiM01rqdR/ZoEOKOcKq+V1GKiuPgbCvi5kdTJenNcyz/eR3i5vYbIsPkMjtPuCvCrKvouh9j+tbdBUyVtEPTXS3HPz0oJ9QdDbTdOBgy4SoPQwDSqKOPHD8KE3iyzZ336bhVxFe24yNb3kZ24GjZ9StuHJLkH5lBswduNDCVKeE1g7/6FPn0zo5Xg26cizXrDUvDU+AIjnM2wQOz0ndlNvcEsDcGS7yKWq/rsKrQIC0tw298f7MmyVRv1cn41mQx0+FLBPtQdbmJLfjl9WkBv6RJQWr2o3CrF4jStS1etyyXnjpDClvBsNcawxEEktdt9+2dLN3Vh+dFjK1cmVuOb7cnLIZxNeEAscZTeCe145jRlJPGAlk3s6c2n8ZsgGNbT2aW4w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261022075727099003)(261028144727099003)(261021135927099003)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9b9FKexaKp/y0k5UZ0v0bTPn8loDGl9parOVL9dF8y1Higfyi+zulV0B4GSA/uuGpMnCYZZ7JuYMxFlPfsgt0xa+LzUKzKJUW2dmM1Ka3XIXf1/FsbTf5OXzmVlzEvH1JnxiidVkcF6hYj3613C853n6lKglTJCZqgSYnojutUsMV0GpeS1kSrJ7JZRe5paGNOAAaGouyV7xcQXtUTx1rWHVQeazWJBDFk6AqwgaaHG8elarjvwyKpUoEzlQY4vJHwSaf10D2h1JLKr5R4E3n+nt05jh9XCJKa4d45OKOIN880eawLNcH4MpMPL609YPzxXA3oNSyDLZRmvxMWs/qB+pDFvV0hIGiLxZxQ7Q2AOmDcpMMwPekU1e8/7vg5asxXGD/i3CmoHXcAbrY0tYxouMsCNJ0ftUX7NvjOPkp0qXsE2Oqex87cRoI1Bz9Q/D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:03:40.8095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693f92a1-fc02-447d-eb37-08df4a33be70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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

vGPU communication buffers need CPU access to regions within their
VramBlocks. Add BarMapping to map these regions through BAR1.

Retain the backing region and borrow BarUser and the MM mutex for the
mapping's lifetime, and unmap on drop using the retained MM dependency.

Provide an explicit unmap operation so owners can observe errors before
releasing resources. Keep the mapping and backing region on failure,
remember the first error and reject subsequent accesses. Owners must
retain failed mappings until device teardown; drop does not retry an
unmap that already failed.

Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm/bar_user.rs | 100 +++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index ff1d0e443281..243f8739dfe6 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -10,6 +10,7 @@
         Mmio, //
     },
     new_mutex,
+    num::casts::FromSafeCast,
     prelude::*,
     sync::Mutex, //
 };
@@ -22,6 +23,7 @@
             MappedRange,
             Vmm, //
         },
+        vram::VramRegion,
         GpuMm,
         Pfn,
         Vfn,
@@ -171,6 +173,104 @@ fn drop(&mut self) {
     }
 }
 
+/// A BAR mapping that retains its backing VRAM region.
+#[must_use]
+pub(crate) struct BarMapping<'map, 'gpu> {
+    /// Mapping of `region`.
+    access: BarUserAccess<'map, 'gpu>,
+    mm: &'map Mutex<GpuMm<'gpu>>,
+    /// The VRAM region that is mapped.
+    region: VramRegion,
+    unmap_error: Option<Error>,
+}
+
+#[expect(dead_code)]
+impl<'map, 'gpu> BarMapping<'map, 'gpu> {
+    /// Maps `region`, which must start and end on a page boundary.
+    pub(crate) fn new(
+        bar_user: &'map BarUser<'gpu>,
+        mm: &'map Mutex<GpuMm<'gpu>>,
+        region: VramRegion,
+        writable: bool,
+    ) -> Result<Self> {
+        const U64_PAGE_SIZE: u64 = cv!(PAGE_SIZE);
+
+        let range = region.range();
+        if !range.start.is_multiple_of(U64_PAGE_SIZE) || !range.end.is_multiple_of(U64_PAGE_SIZE) {
+            return Err(EINVAL);
+        }
+
+        let num_pages = usize::try_from(region.len() / U64_PAGE_SIZE).map_err(|_| EOVERFLOW)?;
+        let mut pfns = KVec::with_capacity(num_pages, GFP_KERNEL)?;
+        for page in 0..num_pages {
+            let address = u64::from_safe_cast(page)
+                .checked_mul(U64_PAGE_SIZE)
+                .and_then(|byte_offset| byte_offset.checked_add(range.start))
+                .ok_or(EOVERFLOW)?;
+            pfns.push(Pfn::from(VramAddress::from_raw(address)), GFP_KERNEL)?;
+        }
+
+        let access = bar_user.map(&mut mm.lock(), &pfns, writable)?;
+
+        Ok(Self {
+            access,
+            mm,
+            region,
+            unmap_error: None,
+        })
+    }
+
+    pub(crate) fn region(&self) -> &VramRegion {
+        &self.region
+    }
+
+    fn access(&self) -> Result<&BarUserAccess<'map, 'gpu>> {
+        if self.access.mapped.is_none() {
+            return Err(ENODEV);
+        }
+        if let Some(error) = self.unmap_error {
+            return Err(error);
+        }
+        Ok(&self.access)
+    }
+
+    /// Returns a typed MMIO view of a `T` located at the start of the mapped region.
+    ///
+    /// Returns an error if the mapping is not live anymore, if a `T` does not fit within the
+    /// region, or if the region is not properly aligned for `T`.
+    pub(crate) fn view<T>(&self) -> Result<Mmio<'_, T>> {
+        // The mapping covers exactly the region, so this also checks that the `T` fits within it.
+        self.access()?.view(0)
+    }
+
+    /// Unmap while retaining the mapping and its backing storage on failure.
+    ///
+    /// The first error is retained; later calls do not retry the operation.
+    pub(crate) fn unmap(&mut self) -> Result {
+        if let Some(error) = self.unmap_error {
+            return Err(error);
+        }
+        let result = self.access.unmap(&mut self.mm.lock());
+        if let Err(error) = result {
+            self.unmap_error = Some(error);
+        }
+        result
+    }
+}
+
+impl Drop for BarMapping<'_, '_> {
+    /// Drop unmaps the region and may sleep. Call [`Self::unmap`] to observe errors;
+    /// on failure the owner must retain this object until device teardown.
+    fn drop(&mut self) {
+        if self.unmap_error.is_some() {
+            return;
+        }
+        if let Err(error) = self.unmap() {
+            kernel::pr_err!("failed to unmap BAR1 region: {:?}\n", error);
+        }
+    }
+}
+
 /// Run MM subsystem self-tests during probe.
 ///
 /// Tests page table infrastructure and `BAR1` MMIO access using the `BAR1`
-- 
2.53.0

