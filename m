Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA54BCA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EDC510F2DA;
	Wed, 30 Sep 2026 10:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XucK8EYY";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5612D10F2DA
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4rENzfIFMNhl5HthgG+HwmDuA6WeyNcVvCjbFD+RBQk8Km0NO+pQbb+PKT9WukHBtLpjDXwQkL6+UB3MdO24vv5CKCWeyEHeWHaqn3uEq0oSgx6rjZCt4upD8Y7MsAT2nLa1laFla341aPiAZlw4EpGJAUG4WAeFlQVsRns1bYbHc8NqlC6PIK5wl4igTDgXkNVmFjWVmjnsVApSTt4RqaRhC0vFT7P2DRgLDvi/yht4qDSUIxZXBXX7QxRodIznkTa8krzdGt7RoacsuMxB1qhHw0mygmPCQELKXHh3/gtKHKuN46HUh1EXPF+9LxCqpDPhpX/+AUioPvLwSp1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKDLXJgKJFLI2gSwUZrNIsBCu1n1ip1RHHc+UiqZ5ME=;
 b=IA2nMjQU9nlo6SRwA9EPKjgXPuxp1duthtPLrMUR313hEO2095/LlGSPp/EDqqPNder1JR9Wl2JM86zuj3tF9CZystLk2kKEg4W+gCMFs5Hp/chh1hhFycUgd64jHFu2ZN2wDvVkXKRitxqibtf7nAxjm7b0GubJOFL5Yj+vNEvJtCiRVwRNO3KQyEK7SjyTAHZ40hecHi+y06C7FdVDzdYnplvb+YvSFfBVB8ZvxmdBsbUU2+dAeIoQlRnj+5ejzO34b5DfgEdWmSJLZcImZ3HhPQjuNC+Z5sdd5jOgd+jd4/yuFovSZUXpdDGX4bx9puzPMBqycv6mMJcDingQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKDLXJgKJFLI2gSwUZrNIsBCu1n1ip1RHHc+UiqZ5ME=;
 b=XucK8EYY9x9IXX7Uu1y/J5dNrXVsLAGFvaDEkVL4UKuKznyrDdBukDXn+lbDnn2ldWny0j0xw9JEFPqrYJ2FXx3P95cUlWiT0KItzsf2AvzWICo9TpRT1NvUfiptAcjdLiSgg6ZRBM2pkgNX+drohSuFCiii2wMWHXAPCWECvIHvP7pyKMO7sui9rHMW5O78QNWq6Rc0sZYaO8k8O10yw8hi+yVh2Waqwk5OnOQLs3GnvZpxmtJB3UQYmOR1waaNMEdxBpbToTnTVFqY546L9LMQqUY4+faAP1AiWPtgXyAn2E2HqgDHddjb98cwU4mTTsyGbZMYwJQG6+hsXl1LuQ==
Received: from CY5PR19CA0125.namprd19.prod.outlook.com (2603:10b6:930:64::24)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:58:47 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::5f) by CY5PR19CA0125.outlook.office365.com
 (2603:10b6:930:64::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 10:58:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:58:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:58:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:58:23 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:58:13 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
 <zhiw@nvidia.com>, Boqun Feng <boqun@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>, Jason Gunthorpe
 <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <dri-devel@lists.freedesktop.org>, Peter Colberg <peter@colberg.org>, "Simon
 Song" <xinmengs@nvidia.com>
Subject: [PATCH 2/7] rust: pci: expose the VF index within its PF
Date: Wed, 30 Sep 2026 13:57:44 +0300
Message-ID: <5828df56a42b784ce9da005b338e8580ea63294c.1790764573.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790764573.git.zhiw@nvidia.com>
References: <cover.1790764573.git.zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f5eb38-d70b-464d-47dc-08df1ee1cd4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|7416014|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AsPToAnWPGUhxBJ5/cPaIEydbYRXJ/Z+0/PVm8cUMmqRdAYhQdf+5BFJgTTcwG1vLWwZLeaHmYSn5ylxGAN/v6JNBGYvzoSfTvR5R6P7A0bWaZZMQoUMIeFu1a07H9gTy+/QO7iv0vsVwC4ULygEP2CdetEAVv/RDubR28omq8H8FuZO6l/zZzIUpATUNtanpjikcGP4r+UF9ANk//W+CzSPCaFHSsPqZjtuYWKjuLexrgaG5ZwoJDLDCn7BkovhVnA0ojUGoXpAOoP7fdi8o/wu5PqJbX2MeFdiIYKvZpTajv8i9lhqZlyIXFFJW5WQA5qpTM/Nv2knsyPU+Z5YR7dnF6ICMwe/bkK8RFfJOIBBmFuFarxcDLWZ/VhRTpo64Bcw6LJYJzxtOK2Xtpoqy3VInaYuDjs74kawjm3x6dwVA8QRH40Km3n9YfNMOfqNORg9Ei6lWzBDqRsKt/QUgMzQ5gFF5GkFqZhop++bSgQV8yWJ/Gsdba6+woq4E1ZCoyhV/wCKTVHIp2Xaj/DVf+GMQNYOHgA9BKRohtisPL0M/33dqRTuXm3HUPqGxqxD4IJSBnARuhyFZM1vq27SHQH3YrTVPOx6Lm6povVMFwjDF7xJacSHBFIqgyxDQgp4SVWmw+k3QO8Qp8OSe43DZJalzijIthu6h6WJa/FGy3/UJ4Ucq0NEsVtAO6TIYUkdU8j+wz0Z8RSRhiBFShm/Ew==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(7416014)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xDTJ/ATMuUzOJoaGBxlhp0E7CZpPuqoVTnWgOEJe4scibdNRQ5oNmnqF7hMybOdKUHHDyYeBWJ9EmWd/jqEGa/vH3w4Wp1PwkWAv0RbA7EkJZjC8XSAihI7xA3Unnu0xD9Ra4SJiyFPB9zExBJKHrAd3VF8LaaHmwKYNdoMzvoDN0RU205HMNE5fD4ErZc0fBBQTZLVPIj4Xl5MV9CF5hln260QT+nQWYNz3GcWQLJ6p503Ew7JTNQ93JLNR+Hu8/evvjhqN/783mCqoc/lxUzkgnfD6FjnWQGTQHqk2WhN2eOTTQtt+GCfBuEvt8feCCmQQO6jUpHbQXAvg50D8nECplShgBMnbpLI6MC6lwcRQNPMl2pwgfdExHLEpy5jc0CeJ1SsBWHFjPL8Qs3arCgfq+kSNKUFoLmTCRvNjz+5+HiPYiAHR/3bOxMYZr1tD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:58:46.9473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f5eb38-d70b-464d-47dc-08df1ee1cd4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004
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

From: Danilo Krummrich <dakr@kernel.org>

Nova identifies a vGPU instance by the VF's index within its PF. Expose
pci_iov_vf_id() through Device::vf_id() so a Rust VF driver can obtain
that index, with an error for devices that are not VFs.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci/iov.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 9d9bd3ac7025..fac134d1ebab 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -40,6 +40,14 @@ pub fn is_virtfn(&self) -> bool {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         unsafe { (*self.as_raw()).is_virtfn() != 0 }
     }
+
+    /// Return the zero-based VF index within its PF, or an error for a non-VF device.
+    pub fn vf_id(&self) -> Result<u32> {
+        // SAFETY: `self.as_raw()` points to a live PCI device; the helper checks VF membership.
+        let id = unsafe { bindings::pci_iov_vf_id(self.as_raw()) };
+        to_result(id)?;
+        Ok(id as u32)
+    }
 }
 
 impl Device<device::Core<'_>> {
-- 
2.53.0

