Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB0606A325
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W3UAZtfU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA8C112942;
	Fri, 30 Oct 2026 17:13:44 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D818112940
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apTQSVOlkXFDQmQBtqX7uv55DW73i1pm+DRv6QcDpjtzSFAzv3hNeBNAm9SUy7lNulu2ykyt34vR0Rzl+5wsAJb5z2ACWbgEyrs8jPb3ryo46Zzu40UOK0l0JS/9D+cD8e+fC+JfFDZqDRQqNHVFUDGXcixpXTVL2fto11wmzCPutO3/+H6lmDkWheFyQ3W2Q6jjeZy3hT/2ohS4f+TA2aACEhIqOHfU/smB3JJb5SEx4bnBCd948zz4ZKRNQCXG8+TSl026fP1tFlkHpdKAcT0yLZ0E12vk7XOVlvzdb51ALhv4ezQbhhtEq8k8kHA4anBct/lTCnoaDvvEJVberg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmKETW54F/8Nm+2y59K4seadmz7NGjll7gw6nPcM694=;
 b=t6nXKbhdnA2ORiC4z6/xE99UzBOm1elu+GsA4tpR1xXOzQopLI8ACm/2mBYvzzeNcm23kdoDecBPWp2u+mMF7hN56AWSxCi2HtLhSACWEKSV03aa0W+brX5hffIwAu6x4lnpWsExalZueIBxJc/jz9lfbac/3y4OHfL/6J6hlbZ2dfMlINoIJU8QmAWtLCbiPGZMrzObDIVARUkmEOaKf8BOta2SjpGLvKKTQs/zJHgYWjhoi9mIqB1RNe5Lud/cagEOLzuIN1qw51Sv+/Jjhovazhl3bwcJVCui9umhqzBy3DPbhbsibL4b8wKIwVyv8sOa/LjVMkKS/u5qDSI+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmKETW54F/8Nm+2y59K4seadmz7NGjll7gw6nPcM694=;
 b=W3UAZtfUYw7rlIyQyg9ogq1bx6O6iECk2voWQ08BYFxAeV9mYaLA5vCcXt76ZRuoqVB9B7E1nJEcB0XG9ZRRX7FwetAngL3F4iQwzrzk5bgYZl4VIXpT2TLBQJoBtyy6NT4/5FiJbPffmHTZDQXSM7Z9GxtEK3p6swsEHcIjwvq4mAEswwhsezIi4oeX4KWhpd260u4Rt4jS4G5eXokkFgOHPFzDo3M/RjvnziGyu8EXz/ppxJvK9rjoAA5K3jgZeNJk6ddq4dH+2MuFcCmKGp71ct0ysZZcwgMZ4vb77wFUCuR22501OD849m0RfKIvs+hPHBYCMH6PBpCKd4EHwA==
Received: from DS1PR04CA0012.namprd04.prod.outlook.com (2603:10b6:8:44f::7) by
 PH8PR12MB999320.namprd12.prod.outlook.com (2603:10b6:510:42f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 17:13:27 +0000
Received: from CY5PEPF00000E7A.namprd02.prod.outlook.com
 (2603:10b6:8:44f:cafe::34) by DS1PR04CA0012.outlook.office365.com
 (2603:10b6:8:44f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 17:13:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY5PEPF00000E7A.mail.protection.outlook.com (10.167.247.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:13:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:13:02 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:12:59 -0700
From: Simon Song <xinmengs@nvidia.com>
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
Subject: [PATCH v5 4/9] rust: pci: add num_vf(), to return number of VFs
Date: Fri, 30 Oct 2026 10:12:22 -0700
Message-ID: <20261030171230.196717-5-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261030171230.196717-1-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E7A:EE_|PH8PR12MB999320:EE_
X-MS-Office365-Filtering-Correlation-Id: 57674366-b062-437f-ede3-08df36a91ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|7416014|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 52muTwgm1l80+KUZ5mp2EghoRoUJx1773Vim77zZ4cPiE5C5rN24rE4a/WavLBlLvofeuYTrpQiNMoMgpw9KgalYv8Rfex83ot+0XvxjbiCPR3F0/LPMz9H9xqspIjlhs6eXFNqPSI+gZea8peyr14kvJfumpP8i7jGe0NP7kc5AOGpzcyVpE9hJOadfkbcRa5ipZSMZwYof5vxRdtfSE/3gHsotQ1Bcv6c83VVIoPlq+B3Xb0/wmXkokwr6iTvIQaE1woejZeJppFENqSQik1bJ/B38EMonEBQFK8QouxqfUxBZUldNqg/Y/cx9RVQXqLrvBJp/SwmBzpbncrUJJVBlKhQnD9hsc31g55wDhF+hK+ESkM3XABIfTQiBZxovwLdFbZcnS4Eu1aCqRIy3QrInYcEEqYdi7KvLvbpqWCywsx2aSauyk+qeO6+NXGYaGxym5yHoZXPOzrJ/a8TYFM29NhQckS8dvFYtkgvsFiv2qR2Zs6nzp53CaoUC9mA8BuoN6/g03iMQC8wlF4ZU6rAdZGYM/MCs77f2FJZqMgiM/yduGswoxz8S42VcxHo6zn3P+E9BVKyZcDQUpJ5/xo4KQkAM1obqNZlMo6pB1JOQsxWxnABbBrasZt4zvxltonenX2tQeOXroPX0eDcNHYI5Y1zaJr7jm8ePTc/nGl1NOfwJXBr8H/b69N+pxzZRjgZsXcZh6MJOqNLHUVYcBA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /NzmnC/0t80HJs5hR72KWEGTGLH6oWPfNWT/v/MR/sZJq5FBHDnvXQd4yx9VGqpcMR7d3FTKu+bGjoA5LQ0PgJ7XP/z3fZCp3KhpHn+wEPT0CBXBRaCdHFFEtZAhMyXJdlBnMZVItjNB1v+Ck6vgIpFN7uMxyZos5OiQUFxl0oBhNzM3Ks21L832s+esmcol4T6WvBIZ32waVhVmW7Yh7AEfwObrrVJUzigIzNBKoc6IBg3fW29jOSFq8ezt0Cpe+w1uBevxbr6iG6XGvBBoQ+dW+jSfodX/EqsqQ05hBQx/JToBCwZBfzua7JuytsXMjrlQR70u9W27FSf4sHVTUSweI7dXs49TOz66rcc0BZAECvwI1/kAJyYvchI+qkGcRjiRwCbdnb4/AJ64ZOWR6j27vxIUmR2ul7BAS+zLuRYpRoDm5COuhemLqV7M7EuH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:13:26.7501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57674366-b062-437f-ede3-08df36a91ca9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E7A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999320
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

From: Peter Colberg <peter@colberg.org>

Add a method to return the number of Virtual Functions (VF) enabled for
a Physical Function (PF).

Expose the query in the PCI core callback context and return u16,
matching the type of the VF count stored by the PCI core.

Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci/iov.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 6f8f95ed618..1ff0ce94f16 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -11,6 +11,17 @@
     prelude::*, //
 };
 
+impl Device<device::Core<'_>> {
+    /// Returns the number of Virtual Functions (VF) enabled for a Physical Function (PF).
+    #[inline]
+    pub fn num_vf(&self) -> u16 {
+        // SAFETY: `self.as_raw()` is valid and this call runs in the PCI core callback context.
+        unsafe { bindings::pci_num_vf(self.as_raw()) }
+            .try_into()
+            .expect("pdev->sriov->num_VFs is u16")
+    }
+}
+
 impl Device<device::CoreInternal<'_>> {
     /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
     /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
-- 
2.43.7

