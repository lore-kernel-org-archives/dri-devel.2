Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA07FF885A
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2AF110E499;
	Sat, 25 Apr 2026 21:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="d6TpDRY1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5742110E495
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNOnplJ0f682V4N8qzui6ga79Qrc1RtQnsPoVqetgldx7ZOw6t9jSKbhZdEoueMtGBLOAaOXjwjxNt94++ON2pmcVO7oxrFOpLZyuB5NaFp0DQH8I4Ao/IIWYGoGB4rtGv7EYbYI7mLY/GycpdNqKwNkhjEX3gIBln56yu4OHQhS1aLVlbw9r9JLofZoEfJywnc2U9rS94wYNQ07itneFRjmPpnhojULbILJoj3dw+PjnE15SGxjBnLwgByT7VQEBJBic9B5CnVQvJpaefe/kjQcnzQp91S5mtCDHXo7i+kXTs7wHew1FG/V/yLUDomD6Lu+H5v0g1xO9e7O2HPa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVoeng5+2YS01/dIGeGYbLgbJ1Z2cXZHWX3zgUqvlBQ=;
 b=bPVOFDD6Ru1ZWbDTVsswB1XFGtZhjy8CHvqAToxMe4vRHov4xmi+crqESED8eQoIzPPV+kHJr/rVP7PbfweqROnCswGggsdXkiiXLTVm4LaeC20iJdqH42pwO/F7LyUQaFIHF/yiPsoI5j+faBpxf48aCYrh54JlPN2r0ja25B68Ww7CxQ7Gn93GG4MTuUhPvTuUFCJEBBpcMvhhNXsO6XhiY3MPSMIHovMnJNEc89Z8YDwpmTiy4qDgByOpVYxaVV9zRiiAWHxL5DZcQacm2sMcS5giKN5bMkaVfHl5Lvu6k/83JE6b3TOj5FSrpk33CiD5FSYxG7qP/5aZstF9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVoeng5+2YS01/dIGeGYbLgbJ1Z2cXZHWX3zgUqvlBQ=;
 b=d6TpDRY1B+9zsaaM7R/5bkHKknnLi1vqtNT2fFQDD80eKBrIjqOAXbMajq4DnrHsXie1k1H4+RRVecEtov5GbJ6OtgxKPtYzsYrS+/E4cpHjiz0V1NVQy+ijI77IczE4PjHdJGzkb+iLM5O3tMEdDxMVVilsocKBDQVQMUPMn55ZTsSQzMMth/dfb1H/N5KgCnM3+bkF5WJUOryJsDthDOobE6OtwMm+++3JMcKl1+idow7MxR+7eMC3R1T/Y8YqtqKCmY1bv8X29CUpoddGN0poGhkz1MSpflqm13Fba+PKjywRGXZTTgcfnoXUi1ESJyPLZwCjYQvi4yJYbdFfAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:45 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:45 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v12 17/22] gpu: nova-core: Add BAR1 aperture type and size
 constant
Date: Sat, 25 Apr 2026 17:14:49 -0400
Message-Id: <20260425211454.174696-18-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0193.namprd15.prod.outlook.com
 (2603:10b6:930:82::21) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9999db-8f10-4ff3-e4be-08dea30fd0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: a8DaCe1ErIOkf+6tStlftTTuHbh4Y8JJCYr+GwFU2pz2yIC0r40MI3+85cVtCWTrAKq2OCed14/4071WFVZ6BlMXGAY0KfXVPA+tpgZKgff5Yn8awee3KSVD8x+ZheY46x/XQwwzU2CevyBnXi6OeO+IJGcgxwR4c/mhjt0WaGP/Yts4LCIASoIC0YtkiEIkX6SwXeWuwLXTbzO7rDcOkqhicKbZwNDIrNHJJysU2Qku0OoJEw/W2+33W3gFdyuFvcBivv78UYx85+mcGvk2eAsan8xH4A51jJiJ9WL5vtI0K6qaoe56ZCqAOK+BrpInYmyXqPZZv2O15KZ5w49+KMJYVZyfwrrUahmS8VBDuZNyFb9q9UHR3gF3GbBB06ndAhtflc0xGrVjHoXY6XVYOlgtL4KOYpgno+JqSCxdeZwJpkz6AHter5Eo3jsQQVvNzjfpEZu+Ytuj7Akm1rMBvRcpfX60dp8/a8m59sgyOt2ObB9qCQRTc686iju/x57TVXi9vcc3LdE5ZiZIj8jdYvLxe7bkFfCTOlkDfo5yfMUkZZP/+xgiWBIeRxGhNlKFuMXcF7PH7+ZF/L6ElKPWOko0QbhifGoKzbfbp9vlro3yKpQ/SoYcNw0Enj6Up3yeZCwFi9Zslz8q7IVUdBe++ylRQQUMY6JbBoe5G4xzw1BuuIXxLeEj8Zg2f7GH3EOpDyJ50jkBgx06+A4NdGFgNL43/3sKkXojQfqf86DkFhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gMLs9aRVbSLVxvYP5ZcAc1HtVf6eamoI+o0HQ/mFRoqz2lYLTBdUaUO4abFE?=
 =?us-ascii?Q?GuIPRHPVB5h5PGVCKvM0Mo8f1B3WnQ7LJzZRe5097Ix0N4LCEvqYW58QVb2S?=
 =?us-ascii?Q?jbr6DwnZLiYpd28y2o2vLuIym/Qo+coO9F/cNWyLiVtOkwobnUSnwA57kSto?=
 =?us-ascii?Q?h26D7RxDIkstWNWed5EMYMeCaWiRvWEhqDQ2qMrmEOHdgjwm8LsFxY4g4M0J?=
 =?us-ascii?Q?UjJY8e6EuM3CHTC4fGKHabcoAFu08o74t3yQ6h4m8PWStj92km2TjnmjAKsW?=
 =?us-ascii?Q?O31re/dRDeMjj+glVkCr7Tb3U18FZcPwvPLENxJcxJvYD3gh6zhuNfV6Qa0l?=
 =?us-ascii?Q?HLj0MkXhZ1M2jFmBkwiqU5/zo4IdI2R8Mf/767E0dPJ/GVAJ+T95oBjCkRpp?=
 =?us-ascii?Q?k6f6PpgqfedqNgawnPOLzml0c5KDb6CQDBF0zQ5IkSiQFhlrbW0ixNL2p3BN?=
 =?us-ascii?Q?0Len/3b5pFLlJ0ZlJLwgH621aIdK0/V9pAsFc0JsnEM/XN2yslE5OGPtMvy+?=
 =?us-ascii?Q?9LtADoU5slid+e7oah7jevJWBI6YGoYImSfdtgBNJOhMxwmqsm0zjd5t7A7+?=
 =?us-ascii?Q?2Iu9UkaSdjSdABF+ykARAtBBL7Q3HJpFBU/YBhkqYfhj44EGe16kJgWK9wvf?=
 =?us-ascii?Q?3wO78Sb1gt+b6PJLfjFti5/kIi6pU58+ijlOsERlsXrxsjVOpBKaWsw/b6Rf?=
 =?us-ascii?Q?GdDDS2EfaLfnoJjpqAt2w6PeAYqB7hWqA0PMew3kI8k4mfbFqFYxQZVg11QP?=
 =?us-ascii?Q?ZMiG9mzrhSk9SAC5V7eshGS8qN0Ca2qHzof317WLEVni5q8pdL+cvCv5pFQJ?=
 =?us-ascii?Q?MGrL4x/zZTLaAppLTz71S7G6i9qqAXhuYXPKi/tIouttLG7lfGGye/OtriPy?=
 =?us-ascii?Q?9Xar+hqjhoXR4gj+zsaPhknCzdrer+nzFzhOz5op39h7o7bn1vsY48BzVm5U?=
 =?us-ascii?Q?btu/TMDWiop1En4SppNGO1FzETnqfsF5/qsmI8wS9dgukWua6l7zBjxSc0FH?=
 =?us-ascii?Q?LnP9rBKmawXSxAnvsze9bNh7t0dn3xdximG4GMUzCbWtXsrwXq5yGm6zmb8Q?=
 =?us-ascii?Q?pKcER9LwNCYUHuMVo8b+GX8EILMseAnfK1qlL4fYLxdmoBKXgNloLABjvQxy?=
 =?us-ascii?Q?daZPV7IMY5nFoQA1C5wpT5dZjXviuKGIkRWXqZREUo/HjjF6dqeWFzBU+toh?=
 =?us-ascii?Q?uCFGFXVOvBrw/9IREW0Mg2F4QYDUuz/WK9oFm+99UJE5vdJShFpHz73oVKaC?=
 =?us-ascii?Q?CL8k+ePKI9BAucOFUGk/MAJ2ddMwvmepY/QCnZSSFhqa7gmK+xJEiuAdDvzT?=
 =?us-ascii?Q?dRXZsJdE9wlbxnTXhiTex+4v3rnTdRRuCefwm4jLC3rahZXOlFNzDHTfdaOz?=
 =?us-ascii?Q?gJFI0SdtnGDvrXeYWfIkwMY1XVMX4KFVyWkayh69RJ5O742EmEkbwYeUdTcE?=
 =?us-ascii?Q?a+TqXD+rQ9PJydJrFLX1HyV1EXTxFMuQ2gnmawrWh85ux3qJLcQbpFysPWws?=
 =?us-ascii?Q?8Pizy6HFs1hSCw7q6bJAMC7wx7k6DNudicuX160V/ouZVgp4Nq+p4zOSyQSB?=
 =?us-ascii?Q?Qz6FhGSVqfmgNNwHS6NqGua9IdDER2MzxRhEVeF+M4V7XIfuYy/Bvui2eHBB?=
 =?us-ascii?Q?G9lF1i+cKF/nCXJh+xiA/qPQ607xO3vqzJo7oRTxSAcped9RFZPuGMoMfIEJ?=
 =?us-ascii?Q?sZCwabcqzfuhUqpNHSBxwqvWPTCjMYWvYOXu9v7fkCUWUnONucP9WGq8VtsT?=
 =?us-ascii?Q?RKobg3NLkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9999db-8f10-4ff3-e4be-08dea30fd0a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:45.5068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bjaSQ9z8hLZr1sBxerSojvK/oaEE/lZPnGN9SmYCGu01nySHkWaak2npxqmdZ29MbdIkjTZmXuOKM+pu96Rbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

Add BAR1_SIZE constant and Bar1 type alias for the 256MB BAR1 aperture.
These are prerequisites for BAR1 memory access functionality.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs          | 2 ++
 drivers/gpu/nova-core/gsp/commands.rs    | 4 ++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 84b0e1703150..597343d5da54 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -47,6 +47,8 @@ pub(crate) struct NovaCore {
 const GPU_DMA_BITS: u32 = 47;
 
 pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
+#[expect(dead_code)]
+pub(crate) type Bar1 = pci::Bar;
 
 kernel::pci_device_table!(
     PCI_TABLE,
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index eeecf81a0ffd..9bf0d32c6a7f 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -193,6 +193,9 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 /// The reply from the GSP to the [`GetGspStaticInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    /// BAR1 Page Directory Entry base address.
+    #[expect(dead_code)]
+    pub(crate) bar1_pde_base: u64,
     /// Usable FB (VRAM) region for driver memory allocation.
     pub(crate) usable_fb_region: Range<u64>,
     /// End of VRAM.
@@ -212,6 +215,7 @@ fn read(
 
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            bar1_pde_base: msg.bar1_pde_base(),
             usable_fb_region: msg.first_usable_fb_region().ok_or(ENODEV)?,
             total_fb_end,
         })
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 8619f08a689d..a90ff9802304 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -127,6 +127,14 @@ impl GspStaticConfigInfo {
         self.0.gpuNameString
     }
 
+    /// Returns the BAR1 Page Directory Entry base address.
+    ///
+    /// This is the root page table address for BAR1 virtual memory,
+    /// set up by GSP-RM firmware.
+    pub(crate) fn bar1_pde_base(&self) -> u64 {
+        self.0.bar1PdeBase
+    }
+
     /// Returns an iterator over valid FB regions from GSP firmware data.
     fn fb_regions(
         &self,
-- 
2.34.1

