Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3C606A88D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bQWOYXdC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FEAA10E6A3;
	Wed, 11 Nov 2026 22:34:39 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7510310E6A3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 22:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejQVbMy3eIwBqc+1D+03O8d4OrQwZwg1KBE0lUJmbN46GD296xzYXD8B/PWjVHEkYOxSySlBZBIL4IN/An0cIFSpe1QArDc5gP8CQvLzA1tiPMBsNMvRnvHGi2aJMPIXg05584Nmb8pLhdq/LGSeSy6sHPaVysuGSMaCsPs69ZnG7I0ow+McFnOsntMhvkUkjP/JxUdISDPqsL9TfJ9YmoMfQaYOB0IAXcrfdSbR/k+405vrn+7RaN+V1SWOZ1OaOK9e+lETaYouFV4T8oqhRasoX6yBQEU9WIVj5WQmcQt8aqna1KEqBxZ+dSiwELAQqf8AKa/k7b13ccUvwPstnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFq0ubk5XyJSWBuSaYkKK/YoYeu+hIk3ipie7HQDv+k=;
 b=o5zjnUcWWpRArHuMadnV7FKs4YWt7DLyhA/7TU/XO/GiuOHDAsWE9VcRu1hLTts083P80zYSZbmk44U692tIzBcLXYJx60CXStEPdEJaYbbpoL8dVJ7BGVuWKbNQKsRh2L6Ht3afWxphpJkI48xEn79MIW12pyD89vJnBUFajIMXZNBkpx1EQ/Z+/Z3OfjfuWZ+8FMbNqEATDM2OqHZ7l1ODSOHXbHoELWjVA15UJhyRe93uStHyL5E2mdFiEr8AxuN5RMsZ7ZSMPg+Czoq5RCEPPV10C5n3rAKnG5Sm/itwFWwUpIT767E0R5ZOWTFeMJyI6+SKsjQz0jFFTvxK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFq0ubk5XyJSWBuSaYkKK/YoYeu+hIk3ipie7HQDv+k=;
 b=bQWOYXdCUc6BP2C6aeGTKTrAWvPOjokhpjpHRiVd3ef8BK/HBI/mibuBxFYQYFt2TQcGpf+eKY9ri6NmapK8hUbbAYarmexHOePKIvhfn0vWq321hyDrqQELg/BSqOFMjje5QBQ5AM1WEWO2+1S4JIHhG3XVesWNVzpJuCN54hhKAm/7gcYwoOw5O78stIRbOTbSb7MKaoMXzwsgGrQw+Gi33tkKEaWseE2WJ8aIYaltRKjrcfIHJApqWmKydcUGT+Ot95icAkQFWP5o3Z65xG+7L7W30fx9fwF8LgtO3xYTwrcdZb8Cgf0GxQAN3+xM+kW/xS7mvKKT1d7QveC/sw==
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 22:34:26 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::14) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.7 via Frontend Transport; Wed, 11
 Nov 2026 22:34:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:34:07 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:34:04 -0800
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
Subject: [PATCH v6 04/11] rust: pci: add num_vf(), to return number of VFs
Date: Wed, 11 Nov 2026 14:33:29 -0800
Message-ID: <20261111223337.508989-5-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c714c5-75bc-40c5-881c-08df4043f15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6SE+XXXcGYNK+tq5mtrey7hfJ5jXOX1azi1oH0OTfNh+WsjH1kNcFXxfSNtmhgn6L/0Yw82/NI+deRrM3IllnHzfGqzVbRHOw5rpBAbL1dAxa0xGk1iUNnO2SWkLUTcM+Na7ADvBWo4iMxWLNjHOVeADc+Hf1s9Yd7Qr9tnOtTRu/zJVx0EaA2DN6SskyXep7O5FEntoxUKa4s2+FYCc+aHClfd8BYufZW/6GJryQl05LGl9mIE++M+TH67VzCKMcgNSLxYT/e80gsjV5Yzq3LgqmTMNpr7iiw1xfpnFgewqAJM0/XdC21wbpEbdYwT4Uhqeb7yyl8JHZg4MfmW6xpVUTFfHYSM+D4bjuRZJn/o7QrJhJ+x5elOTswhy6b1BzhThwDahw1iYo/dDnW58AsT3ZzxLqUestj4QR2hw9KwyD43e3HbDmH3xF7DYvlRHJry+TRlgot1m8JnolWN0Y35z6C+cIs9qgWMvrv83brALWHOJOJ7uSNM4kjxp6KMm+4t4CxBdMpKXu1txUGz3sKgvhvVzX/1MH/JPPxslRoV5C8B74npXTQumAazz9P4cMcJCzfRgaePovL6gnbMIUg2Il6YWV2oreb4ex79KK9jgts7C77UlZI1xVYSU2Ka12UrmDqLymBvWSm9TBKbA0cjQIkecPwRXksyAIbzk8Ec/hUCiIeEEeZGtNKIFlZzNuIx6KuUUnaIZ5jiHhgiKnQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w8EaUxTaawpAXhimIHh2FoBlZA4um5lKz9Hd/UrIGpZ1e8gHgf0GAqXbjNvSqr+EoIDCMc134mu5wm736AGBXgXNPSb/IJyM7R0immeqZDgtmRde6gPq7CJgllZELW8jggcCl+wpkAraaFQG2VkBMI1GLD3b+65L/2dRXSRUVE3GREuHQkmPLWfZl+lZvlE0fVRmkScAmqm45QhzRdYP2lG2WWmUVzkwWXF36mktApoIVdh5Msm6xqbqXywJXrxdH6hygoDMT0bk4NTPoZZOEB77dfwT4e5XJ4j2zDai1f/feBaqw0f/UhLZUm/qZ9TGvgf44QadHUV1WD4URD/gZfFs5yqrQQqTCVJ3YqCNo/FAHRigL8C4kKV1FGr1vfBmslyVs2wRVo7ViKrAow54W5Kz0PBWyzG5y55adNO2QhqpD5CYnei0XoPaHM0LBatI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:26.5922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c714c5-75bc-40c5-881c-08df4043f15b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067
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
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/helpers/pci.c     |  5 +++++
 rust/kernel/pci/iov.rs | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index a87b5a77efef..57c28ddeeb9b 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -52,6 +52,11 @@ __rust_helper void rust_helper_pci_disable_sriov(struct pci_dev *pdev)
 	pci_disable_sriov(pdev);
 }
 
+__rust_helper int rust_helper_pci_num_vf(struct pci_dev *pdev)
+{
+	return pci_num_vf(pdev);
+}
+
 __rust_helper unsigned int
 rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
 {
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 18e42b2d3965..78e279169be1 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -11,6 +11,19 @@
     prelude::*, //
 };
 
+impl Device<device::Core<'_>> {
+    /// Returns the number of Virtual Functions (VF) enabled for a Physical Function (PF).
+    ///
+    /// Returns zero when `CONFIG_PCI_IOV` is disabled.
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

