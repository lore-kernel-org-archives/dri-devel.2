Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72843107BCCD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE27F10EC64;
	Fri, 13 Mar 2026 16:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="elMOKlGD";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B020010EC64;
 Fri, 13 Mar 2026 16:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxYhgYP0xdfmqsHqrs0m+R+NuGNz8S3yz6B3fsIvDu5ornAFSFv6MlkxDb6XCmArro9yTXZjxa7NcoG4RXOlDFrK0FjOMjtXXGNTVyC7c5og5kLtIblZmtgnbCGYf4FkocRLe5XsKA7tPvuHmlODOeeDm/dttIlWYkc5lz+xIX5DgpuwEbWaZYHeekm58YKNsYhosCGitm59MklAiJ3uoF3Zno2EoJ6uWSKLg8UaiS9EXkyjdiLyTn/pRvoLz1LTkapVfjQRrqLUVopLIuKD+5ynggSkadctM2cGLVd0UbB9WQ8IZSXC9IfYgRdhlMsPCxxqXTo34G5Q94H3bQjvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koww9rh/+UdpFYobu1XacYH7GVIdk+rkej1Z+tTPPx8=;
 b=zLgqmo65vm8WlufTWBZWjnTH+9vNgadYT4aa1YntEWaFMTZ4ilU5BPIvgpw4LStYQgXPJmx6WgljQgEXWYqq+SaK7OaT+s2smaQVfT9ThNy1AQgznLslqfIuITSyljgkLTnqh3KmVII7jKy0RPdeyedbhdoioVLHjlNwOBRpdYrFj5ewqj89iLieol1T+yHFe93WnxWPu+PvKkS0rqveZ5t3ekKMSs2n6leihsYVXXcj+M8FhN4UEATYy2O7laGxy6Zve/5La57cdyYbjSv/fI+vb0xbTj1RYYBkA91k5Uc9b6/e0/v4HuyKFZ9FfgSq9uRzPS1of3sy9rqhzU/nhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koww9rh/+UdpFYobu1XacYH7GVIdk+rkej1Z+tTPPx8=;
 b=elMOKlGDD+JjeZoGv52DCt5nWVOBF7QHf77lVeHQgkAQPyVukzihKfWe/c571gOrePnV5edSQdkLzDEu0Mcfdpc6V6g1ovXwlhXPnibMVuzOacQgDoQslk2NQu+Lq9q3Iwk1JwvEIXQB8jPtDUAG9WI5cE0Tmsxma/lLRF7Uo0oz40PQt1FOjQDRj+rNs5uBjjI0VDLbZVD6rf8BSwJNfNVzGG6OhJXaVg3fp7331ffU3wv+EtR+/tmqvAXklIsAPug7Vud0oPZyEjf2IBtiwYHZPN9fGYoZkO9+xEzJ+7yQBO8fl7YIv4L9dgsuP7yhNclj14Ysq/ujZ8q+VN/isQ==
Received: from CH0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::7)
 by LV8PR12MB9641.namprd12.prod.outlook.com (2603:10b6:408:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 16:54:14 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:11c:cafe::7d) by CH0P221CA0003.outlook.office365.com
 (2603:10b6:610:11c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 16:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 16:54:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:53:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:53:56 -0700
Received: from inno-dell.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 09:53:47 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <aliceryhl@google.com>, <acourbot@nvidia.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <gary@garyguo.net>
CC: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <jhubbard@nvidia.com>,
 <gjuvekar@nvidia.com>, <joelagnelf@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>, Dirk Behme <dirk.behme@gmail.com>
Subject: [RFC v2 01/10] rust: pci: expose sriov_get_totalvfs() helper
Date: Fri, 13 Mar 2026 18:53:25 +0200
Message-ID: <20260313165336.935771-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313165336.935771-1-zhiw@nvidia.com>
References: <20260313165336.935771-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|LV8PR12MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: ee72e3e7-83d2-4d06-632b-08de81212855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6U6kLQtqoHUslM6uuyGm7xSWjkkA99PMQPgohtxbZSoSkd1Ne3K3nQqTvV6La/z/EtERjynKCXjBaMn+Lt+106CyeBSK1jE0nBBKWJO43kWQXZCxVnh9RTXnaZ1WGB/UdYx/U4cwdFkb7PmjLNLgcBzfquaOtavf1EucQ66jRCdhsNASj3ZW9juf7jeV8Zt+RGxW+f3Uu2kaaYf0TATMMv2xrDXfAzph1bHzwbeUK3AdSb2iJcXEIFGp98RC5iw82s+AXptUac2eGfXE9ASW5DHvto/dSJVXjFHhcGbao64h3xzjU+I72RzZ3Qp+VU8Z0F5nslCiX1M0XCW1i01DHRQp5f66OAwANgdzCTcQ7AVe9YR1qtZnkzvcnANsEVIuFyYb/lnqjOlPjSLkEoDSlbx644gut5cSR9/yP/rXoHfDScZqYCXYEA5165N8U9PI3hs9e0hmhD5ZIOJygcgLBxgvMagRLEnL3vilY0LoXiSHvzReuqMw3n9m4fkOOV3shsdaHxdxodkcDFMFTvOHlEJLPpRURMpcLpSgnddsMwbM4IVKTuj1/9pVinH0rTiY6VaISYQBwhNAiObkw6fR9nNHyOwjVMlyayB0kykj57CgOBT8TwswnPxAhTRkefw7XGN5sJ5NBKAPwhzAOqDvjAHmCHxJ36tOlQMfwlsuyi9gQLgO7v0aOZGiof9XPQWi4cc/5Zf5ZRZINgXLQvWiun2WRs1VIvkjB+Y7DdBvdYNx1QDr6HE4RbVTEfib7XOm5adrnvnVXh+h66PF0eFjBw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(7416014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4L5g15yzEENPMkSMd4arZRnMQl3dM+T+nzRVaGQeYShwF1Yluc+E0YoeLdgd+u9tz99yBTUT7EiNanZXF5JvV7jJQ1MyfNcBkLInaOoXh9XykdMfBQArde16jisf9pHpzG0u9OW6jRECMULd/zcMo1+AkYGNBq08ZUp9rzshgyqsKG+GI49muHE87hFRvSaumetFCps90hzcdqTSA88TFI6z4J6YiybOaqPQcrNiZkyCGtzTqIvBI3ShX4Gp48F1rgZmaK2sUiBqqjeLf7J1d3nvL5etRXNpbTfRL9XddFqnTBda+WkqZlKQ3usQSrg39tSqq1+vcMovJ7TMxksvH6SFVdFKYf9ootpRUMrE0w/TSbaBZOtyLgwGNQ0QwRT5TOEptYeqaybnMOwvhyhRwbdsAQyecK1pdseqyU6132Uy4avyun8M37ZyvDapElFB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:54:14.2103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee72e3e7-83d2-4d06-632b-08de81212855
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9641
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

Add a wrapper for the `pci_sriov_get_totalvfs()` helper, allowing drivers
to query the number of total SR-IOV virtual functions a PCI device
supports.

Cc: Dirk Behme <dirk.behme@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/helpers/pci.c |  7 +++++++
 rust/kernel/pci.rs | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index 5043c9909d44..a3072fbe2871 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -29,6 +29,13 @@ __rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
 	return PCI_EXT_CAP_NEXT(header);
 }
 
+#ifndef CONFIG_PCI_IOV
+__rust_helper int rust_helper_pci_sriov_get_totalvfs(struct pci_dev *dev)
+{
+	return pci_sriov_get_totalvfs(dev);
+}
+#endif
+
 #ifndef CONFIG_PCI_MSI
 __rust_helper int rust_helper_pci_alloc_irq_vectors(struct pci_dev *dev,
 						    unsigned int min_vecs,
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index fc9c8e2077b2..c787f62b7f53 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -450,6 +450,20 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Returns total number of VFs, or `Err(ENODEV)` if none available.
+    pub fn sriov_get_totalvfs(&self) -> Result<u16> {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_dev`.
+        let vfs = unsafe { bindings::pci_sriov_get_totalvfs(self.as_raw()) };
+
+        if vfs == 0 {
+            return Err(ENODEV);
+        }
+
+        // `pci_sriov_get_totalvfs` reads from the SR-IOV total_VFs field (u16
+        // in the PCI spec), so non-zero values always fit in u16.
+        Ok(vfs.try_into()?)
+    }
 }
 
 impl Device<device::Core> {
-- 
2.51.0

