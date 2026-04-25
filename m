Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C652DFF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AFB10E49A;
	Sat, 25 Apr 2026 21:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="G6Nz0/Ni";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C553710E48C
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8iXAuWR1fqDlGgWAruj6g7KzJu8vcE+YKKbWrMzF1fAkfpxChIHQa7+TE4Fd4I7tsIXCQzV0sszZ/YkLOYSdn3eI3Jd8hmsgDUMmyNDJIO8fm8OulqzDclU7DJ9+gkuvg9BCzY5CIq4/cxnjQOe7NtfTfdDWKTW2nNMcpxYF0zXTS6l4uziRiOcM/qRoJE3XkmeDGJmjvYGtCpzMZ5m9/jxde0tJ6b6vdrJ7dcKezgmYjHg91zGytIIBZKSbf9nq6tAnhIRAI+pVjmbef8LIKw9dPXJra+e7Ebrb1srPzwTYo6rzWYQDhz67ffFNWsqlQK4X1JUT566PsKqBkjLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPWqWeNmZCRfm6CfqFDQxkbRqTfCo9IE5zDAweyMbiM=;
 b=mNCTD/J+ykkpRv7OrigMc8oEhgwG+a7t5og3H33nyrwfWzh1dZIJlwOpOlvxnE/SthJD6FA+jNvb0Lh/RcK8ML2J/dc7/O49JMPFWnP5p4dLrUF47A716fG4j1L4PZP71F39sOTZ6LdAoHgsMos2tWIyD+1SaCgNZDp/L3IMJFrDfkoYMC2WgU8XRayIMLybzUSHQINblEBZKQKMVTmvqztHVCh1XrPxGT8/OsfWKkMulX7eUAPyYIuYMrUfYLuDhxcvT5D1ue+VFMNIBNo6V8tqqHSD0taKQobr+LTtg/fp+68/jxrEmOCux7+DI+Sbvfd/o2Z9JgyqVKYMBjSdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPWqWeNmZCRfm6CfqFDQxkbRqTfCo9IE5zDAweyMbiM=;
 b=G6Nz0/NiXSR5Ni1P5udr2mFUWdlz229CBPsJZ0+A0S89zRr7KEWDQh3MvqpY07sOHfy/EvgLjb8gVIGdXhRfFjTTPzWVSDNBXGjdGjColQ/st1VlRWkojZiEt3Zy1jDXT+4sy0fXgeHv3l0mPwSGhivvYx2uG2kR37PD5/Hr0w4PQBbrkYh6EGM7qxBaMYtPsOHJhyfDyHYl+i/5MLYscf8UmBxJ5KUJ4NLOc0USMhEuCrCl0o6uKEAD77PvPGziEF71XOyoqxqbXtFkfgXc6YJP1BvoTRJ8jDPWRVlfAJv96QoWHpgpTV1aYPHdLLOV9ti8vICnDVA14oee0mchhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:49 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:49 +0000
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
Subject: [PATCH v12 19/22] gpu: nova-core: mm: Add BAR1 memory management
 self-tests
Date: Sat, 25 Apr 2026 17:14:51 -0400
Message-Id: <20260425211454.174696-20-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0350.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::25) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc286f3-2618-4a9a-4196-08dea30fd316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003|11006099003;
X-Microsoft-Antispam-Message-Info: VL5JVU7Jrjix3n13QuBXa0iAKTUSSOek+QQLrd9Djgoo5IeG8GRf3iAQP0aAw3r/IdhswtfoyvMQabcgUEDug7iZmFrdbmGUp9bUOzB4SFd6DGcax52IaFOjs0/NjsS5AII+rnJLjg9YxWks3/2l54R9WUuJoqTE2rqWXORp1Id4xm+xRV92ynMSe7UhQ6sDMHgxdnAcrKMQwxBqdAenADQ+NlE+BUtGLhcS8GIL4PV9EcBqUhUx2gDyPiUCjsorsUHw1VfgRKoRw0r+Ug82sBv+WoNWJtRFyiDbUUUKanbCefb0hqmuR02vdI8drV9CWuxt8a0Jd1PesGdaYk28H/3LK8ydZmB1pTidDjFXNkDVo7p3eYp1OujmiKg5pAoocOPxTWTH1IDheiUtTxzLjOMahcMWl0r5biZhd+9htNLFWddAebiIhZJ5I2zVC3u7RI6ar7aA862Z+wNpy2aWIU57n/NC3W4+DPRR8wCyc35p8x4pqOU0vtAhXNlMhJduHurP0D5bFJmVOFpKh8eQo6Kh81jLtZ8/qF+H8S49fS/Xhsbz1A6A/4oGg8qBPB62nptF/YdeOCKww/k0E6C0YpMT54V41JxC/Ek4E7zR0GJkaYYOtAMBhpqtLc+YAU4MCYf8XvbhD6hS7w4CsQpptJgqa82khZgTEamC4l8deQ6xscI/SHRmaftxRwr5r5RlRDikBhKcpztkbFLVwCNAreW48/isSY/196td5vDUrwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003)(11006099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5hTzhtaXk4NzJhSXlNUWdYVVBsZGZNMEdFcEFwSjZlMG40Qm02MGREQ1pj?=
 =?utf-8?B?WWZtbm9OZG85RTZraHlWeDVkdGZyUENibTN6TDhJcC9YSDdRQmZaZHlXV0Vj?=
 =?utf-8?B?RnF3NGdYSGZUUHRCTm9jZmNKaW1sVG8yaXdvRVJjZlhKSTAzb0xKaUdOOTNV?=
 =?utf-8?B?bUNLTUgwOWROZ1B3Mm5Ra3IxbTRxSldPY0pCQkk4b2xsUUpnV0NhQkhzckFN?=
 =?utf-8?B?Q2pBSnl6VDZ4ZS9kL0VuZ0U1Um1UV3ZDSjg5WHlUSTBhOWFBeUxrZ1FpNmVo?=
 =?utf-8?B?WlJTdC9vSFVvUWJPbGVKMGFhU05XWnhUbGVoS0JNNi8xVTF5VUVPcTQ2SHFT?=
 =?utf-8?B?aFQrVkhDRWtNVXIvdlZybitLUGZERDFEK0ViSU9vcHhzb3hnaUM1Rmk2MEJ3?=
 =?utf-8?B?dXAyTFk2MitWTDdyOTFKN09wdktEdWxZTFBWT3JqVFVRN3JtbURLZS9wZUhP?=
 =?utf-8?B?L2RCQlcwaGRWcjlsSFQxTE5haERucjNXT1JCNnZoT1B2YStzSzFTTW1pOW52?=
 =?utf-8?B?NkZZOVZBUU5EVk1QSGs3MHNIVlNWYko1TDBSOHdqanhodXBMQURHRmc2c1JC?=
 =?utf-8?B?dmNuSTQ3TlV6a2pvejdFZ1FDVGFWNW1QdWEvN1NZQVFkUHV1NnZQMnZBZmJH?=
 =?utf-8?B?TTdSRzFUcVN4RDc2UjlRR2x4SDE2ZG9pRlR1bEI1YVRkeG0vcUNxLytuRXdp?=
 =?utf-8?B?bzdvN0xiUU1Nc1hrdXFPb2sxeFQzc295bkNrWFZKOXJhRUoyenYwVTNZNGhL?=
 =?utf-8?B?dlFMQ3Z2UUZicHRmWllMNzdQK2xENjdRY1ZYck9peEdMNlJCeFJGTGVud3hv?=
 =?utf-8?B?cFpJRzhONXhONDdZTmNtWHFFQ2VVOTJqVUkwRTVLZUcxYVB1ZWtjak1sMi9O?=
 =?utf-8?B?VkZiTkZ1djBva3dLNzI1cjFlRkVxaERMaFF5QVg4enFWdis2N3h4a01Bc1l3?=
 =?utf-8?B?a0gxcmJLUGpSY3JsU1J6R1lUQ1VYZ1dFQWJ4MVc1ZGxmVjNBZFA1aWVhSE1u?=
 =?utf-8?B?Y2RHUkQva2xtZ0pmUFo1NGRjamdhMEYxSWRyT3VEamNFcVdxSGhPK2RDOHU4?=
 =?utf-8?B?RlQ2cjZTUHF3UW13RWw3R2o3c0RyZTZmTEdMU3RCNHFlRDR0M1FTdXdIL3VV?=
 =?utf-8?B?Yjk0b1FSWkM1MmRLRm9kdStNS2F4MGwyUW9NNXBySXQyN2ZUcUMxUkU2aEh1?=
 =?utf-8?B?NkNwMXVJRmdLaEJDYWdEY0RKZ2poN2pRaXdBaW9vSElLMFU4dDNUVDkrYXlD?=
 =?utf-8?B?c0tyR1NaSkc1TU5mRWJ5NUxOZXZCRGFJY3FnYkZWYk93bWVSa29VODdpN2RK?=
 =?utf-8?B?Vy9kb0xsRkpSTndwbFh1UDJXa1RwWktpQzBBSjB0clVkSW96bDdkajZvaXdM?=
 =?utf-8?B?WThtaGtPeDhvME12R3BxQkNXbVN1eUVzSFV4N25YVWlib1dOdytXdDNKSFZ3?=
 =?utf-8?B?dms4NUQxMHNhZFNXNjZCM2xHNlE5N2lLVGFTc2l6OWVuZ010bHZwbkdRcTQ0?=
 =?utf-8?B?cm5EYXRFREUwM05VU1hIejRRb0Fya20vYTZSamVORE9WeWwwRllvT3c3eHUy?=
 =?utf-8?B?MEJyN2tPQk8yUGVsa2UzdWE1TW4yT2diNzRIMitJTkJKbWI2S3Zvb2ZlVmJO?=
 =?utf-8?B?RHNqb25xKzRCakRTWXVNZkFiUVVieVNSb2dpSDVjSWNueGNsKzgzb3o3ZUZG?=
 =?utf-8?B?ejllYmlvRDJkSUZiOWxWcnhJUHpabko5UU9xR2NPMDlMK2J2dkxJbmhvUVQ5?=
 =?utf-8?B?Vmg2ejA3R0FVVml3eE5jR0NiaW5RTk0xOVF6NUpjTzEzd1lFUWZBb0M3YmZR?=
 =?utf-8?B?RUVVNDFDVDIySjQrVUt4b2FjN0ZXajh6STd2VVN4MVV2c0p3ajkxYWRkQWxh?=
 =?utf-8?B?Szl5ZFN1UVM5OUFQS0hSWW91eExqd2NycnJvdXFPa2ttbjM3Njdxa2d0WDVN?=
 =?utf-8?B?enJ5MnJaWlN0UDJRc1ZNeXFENlJSN2NhSlJyTjJRRy9SRGxWUDc3ZlpiVWpV?=
 =?utf-8?B?a1pNQy9NQXg3a0FDYm1VOFg3S1o1cEROY09XOHB3ck55aGVQWmxES28wY3da?=
 =?utf-8?B?MUdVV09acWZXeDM1TFFscnJjNzNDZHhNdkJXTzBaSlVGSEZXak5xaFUwbmRu?=
 =?utf-8?B?ZUc4VDNway8yVHQzMCtUTld4WllJeThIZU5tSDIyZk1OeUtnekgrWkVwbXhP?=
 =?utf-8?B?emdMaERiN3lVMVh1aWNMbVRMWHNhOXJIUlc4OXRid01Nc1VNVW9pSFRwWGNV?=
 =?utf-8?B?cDlKVk1OUGRRMTFnRWVEZWVkUnJKeG1UQVFwWmJQeWF4ei8yTHgvcXRXOXRo?=
 =?utf-8?B?dytwOEFZQ3RaNi9OMXBVOVNxWWovVmlWT1lVYWh5bnp1RlNsTjdGUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc286f3-2618-4a9a-4196-08dea30fd316
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:49.5907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czUCyOvtI77BxQVaVnhkUvNaCgoEDYEEd2VDue6Mh0RNuw2k0uBEsUTMUlZMFun2g69ldmfNyzBG0QBIManmsA==
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

Add self-tests for BAR1 access during driver probe when
CONFIG_NOVA_MM_SELFTESTS is enabled (default disabled). This results in
testing the Vmm, GPU buddy allocator and BAR1 region all of which should
function correctly for the tests to pass.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/Kconfig         |  10 ++
 drivers/gpu/nova-core/driver.rs       |   2 +
 drivers/gpu/nova-core/gpu.rs          |  31 ++++
 drivers/gpu/nova-core/mm/bar_user.rs  | 244 ++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable.rs |  35 +++-
 5 files changed, 321 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index 6513007bf66f..35de55aabcfc 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -15,3 +15,13 @@ config NOVA_CORE
 	  This driver is work in progress and may not be functional.
 
 	  If M is selected, the module will be called nova_core.
+
+config NOVA_MM_SELFTESTS
+	bool "Memory management self-tests"
+	depends on NOVA_CORE
+	help
+	  Enable self-tests for the memory management subsystem. When enabled,
+	  tests are run during GPU probe to verify PRAMIN aperture access,
+	  page table walking, and BAR1 virtual memory mapping functionality.
+
+	  This is a testing option and is default-disabled.
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index e78a682a7f2a..6f95f8672158 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -97,6 +97,8 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
 
             Ok(try_pin_init!(Self {
                 gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_ref())?),
+                // Run optional GPU selftests.
+                _: { gpu.run_selftests(pdev)? },
                 _reg <- auxiliary::Registration::new(
                     pdev.as_ref(),
                     c"nova-drm",
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 73a48dba391d..e94f5374eb67 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -346,4 +346,35 @@ pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
             .inspect(|bar| self.sysmem_flush.unregister(bar))
             .is_err());
     }
+
+    /// Run selftests on the constructed [`Gpu`].
+    pub(crate) fn run_selftests(
+        mut self: Pin<&mut Self>,
+        pdev: &pci::Device<device::Bound>,
+    ) -> Result {
+        self.as_mut().run_mm_selftests(pdev)?;
+        Ok(())
+    }
+
+    #[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+    fn run_mm_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bound>) -> Result {
+        // BAR1 self-tests.
+        let bar1 = Arc::pin_init(pdev.iomap_region(1, c"nova-core/bar1"), GFP_KERNEL)?;
+        let bar1_access = bar1.access(pdev.as_ref())?;
+
+        crate::mm::bar_user::run_self_test(
+            pdev.as_ref(),
+            &self.mm,
+            bar1_access,
+            self.gsp_static_info.bar1_pde_base,
+            self.spec.chipset,
+        )?;
+
+        Ok(())
+    }
+
+    #[cfg(not(CONFIG_NOVA_MM_SELFTESTS))]
+    fn run_mm_selftests(self: Pin<&mut Self>, _pdev: &pci::Device<device::Bound>) -> Result {
+        Ok(())
+    }
 }
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index ab56ecd66fb9..8d996e7eaebe 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -154,3 +154,247 @@ fn drop(&mut self) {
         }
     }
 }
+
+/// Run MM subsystem self-tests during probe.
+///
+/// Tests page table infrastructure and `BAR1` MMIO access using the `BAR1`
+/// address space. Uses the `GpuMm`'s buddy allocator to allocate page tables
+/// and test pages as needed.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+pub(crate) fn run_self_test(
+    pdev: &device::Device<device::Bound>,
+    mm: &GpuMm,
+    bar1: &Bar1,
+    bar1_pdb: u64,
+    chipset: Chipset,
+) -> Result {
+    use kernel::gpu::buddy::{
+        GpuBuddyAllocFlags,
+        GpuBuddyAllocMode, //
+    };
+    use kernel::ptr::Alignment;
+    use kernel::sizes::{
+        SZ_16K,
+        SZ_32K,
+        SZ_4K,
+        SZ_64K, //
+    };
+
+    // Test patterns.
+    const PATTERN_PRAMIN: u32 = 0xDEAD_BEEF;
+    const PATTERN_BAR1: u32 = 0xCAFE_BABE;
+
+    let dev = pdev;
+    dev_info!(dev, "MM: Starting self-test...\n");
+
+    let pdb_addr = VramAddress::new(bar1_pdb);
+
+    // Check if initial page tables are in VRAM.
+    if crate::mm::pagetable::check_pdb_valid(pdev, mm.pramin(), pdb_addr, chipset).is_err() {
+        dev_info!(dev, "MM: Self-test SKIPPED - no valid VRAM page tables\n");
+        return Ok(());
+    }
+
+    // Set up a test page from the buddy allocator.
+    let test_page_blocks = KBox::pin_init(
+        mm.buddy().alloc_blocks(
+            GpuBuddyAllocMode::Simple,
+            SZ_4K.into_safe_cast(),
+            Alignment::new::<SZ_4K>(),
+            GpuBuddyAllocFlags::default(),
+        ),
+        GFP_KERNEL,
+    )?;
+    let test_vram_offset = test_page_blocks.iter().next().ok_or(ENOMEM)?.offset();
+    let test_vram = VramAddress::new(test_vram_offset);
+    let test_pfn = Pfn::from(test_vram);
+
+    // Create a VMM of size 64K to track virtual memory mappings.
+    let mut vmm = Vmm::new(pdb_addr, chipset.mmu_version(), SZ_64K.into_safe_cast())?;
+
+    // Create a test mapping.
+    let mapped = vmm.map_pages(pdev, mm, &[test_pfn], None, true)?;
+    let test_vfn = mapped.vfn_start;
+
+    // Pre-compute test addresses for the PRAMIN to BAR1 read test.
+    let vfn_offset: usize = test_vfn.raw().into_safe_cast();
+    let bar1_base_offset = vfn_offset.checked_mul(PAGE_SIZE).ok_or(EOVERFLOW)?;
+    let bar1_read_offset: usize = bar1_base_offset + 0x100;
+    let vram_read_addr: usize = test_vram.raw() + 0x100;
+
+    // Test 1: Write via PRAMIN, read via BAR1.
+    {
+        let mut window = mm.pramin().get_window(pdev)?;
+        window.try_write32(vram_read_addr, PATTERN_PRAMIN)?;
+    }
+
+    // Read back via BAR1 aperture.
+    let bar1_value = bar1.try_read32(bar1_read_offset)?;
+
+    let test1_passed = if bar1_value == PATTERN_PRAMIN {
+        true
+    } else {
+        dev_err!(
+            dev,
+            "MM: Test 1 FAILED - Expected {:#010x}, got {:#010x}\n",
+            PATTERN_PRAMIN,
+            bar1_value
+        );
+        false
+    };
+
+    // Cleanup - invalidate PTE.
+    vmm.unmap_pages(pdev, mm, mapped)?;
+
+    // Test 2: Two-phase prepare/execute API.
+    let prepared = vmm.prepare_map(pdev, mm, 1, None)?;
+    let mapped2 = vmm.execute_map(pdev, mm, prepared, &[test_pfn], true)?;
+    let readback = vmm.read_mapping(pdev, mm, mapped2.vfn_start)?;
+    let test2_passed = if readback == Some(test_pfn) {
+        true
+    } else {
+        dev_err!(dev, "MM: Test 2 FAILED - Two-phase map readback mismatch\n");
+        false
+    };
+    vmm.unmap_pages(pdev, mm, mapped2)?;
+
+    // Test 3: Range-constrained allocation with a hole — exercises block.size()-driven
+    // BAR1 mapping. A 4K hole is punched at base+16K, then a single 32K allocation
+    // is requested within [base, base+36K). The buddy allocator must split around the
+    // hole, returning multiple blocks (expected: {16K, 4K, 8K, 4K} = 32K total).
+    // Each block is mapped into BAR1 and verified via PRAMIN read-back.
+    //
+    // Address layout (base = 0x10000):
+    //   [    16K    ] [HOLE 4K] [4K] [ 8K ] [4K]
+    //   0x10000       0x14000  0x15000 0x16000 0x18000 0x19000
+    let range_base: u64 = SZ_64K.into_safe_cast();
+    let sz_4k: u64 = SZ_4K.into_safe_cast();
+    let sz_16k: u64 = SZ_16K.into_safe_cast();
+    let sz_32k_4k: u64 = (SZ_32K + SZ_4K).into_safe_cast();
+
+    // Punch a 4K hole at base+16K so the subsequent 32K allocation must split.
+    let _hole = KBox::pin_init(
+        mm.buddy().alloc_blocks(
+            GpuBuddyAllocMode::Range(range_base + sz_16k..range_base + sz_16k + sz_4k),
+            SZ_4K.into_safe_cast(),
+            Alignment::new::<SZ_4K>(),
+            GpuBuddyAllocFlags::default(),
+        ),
+        GFP_KERNEL,
+    )?;
+
+    // Allocate 32K within [base, base+36K). The hole forces the allocator to return
+    // split blocks whose sizes are determined by buddy alignment.
+    let blocks = KBox::pin_init(
+        mm.buddy().alloc_blocks(
+            GpuBuddyAllocMode::Range(range_base..range_base + sz_32k_4k),
+            SZ_32K.into_safe_cast(),
+            Alignment::new::<SZ_4K>(),
+            GpuBuddyAllocFlags::default(),
+        ),
+        GFP_KERNEL,
+    )?;
+
+    let mut test3_passed = true;
+    let mut total_size = 0usize;
+
+    for block in blocks.iter() {
+        total_size += IntoSafeCast::<usize>::into_safe_cast(block.size());
+
+        // Map all pages of this block.
+        let page_size: u64 = PAGE_SIZE.into_safe_cast();
+        let num_pages: usize = (block.size() / page_size).into_safe_cast();
+
+        let mut pfns = KVec::new();
+        for j in 0..num_pages {
+            let j_u64: u64 = j.into_safe_cast();
+            pfns.push(
+                Pfn::from(VramAddress::new(
+                    block.offset() + j_u64.checked_mul(page_size).ok_or(EOVERFLOW)?,
+                )),
+                GFP_KERNEL,
+            )?;
+        }
+
+        let mapped = vmm.map_pages(pdev, mm, &pfns, None, true)?;
+        let bar1_base_vfn: usize = mapped.vfn_start.raw().into_safe_cast();
+        let bar1_base = bar1_base_vfn.checked_mul(PAGE_SIZE).ok_or(EOVERFLOW)?;
+
+        for j in 0..num_pages {
+            let page_bar1_off = bar1_base + j * PAGE_SIZE;
+            let j_u64: u64 = j.into_safe_cast();
+            let page_phys = block.offset()
+                + j_u64
+                    .checked_mul(PAGE_SIZE.into_safe_cast())
+                    .ok_or(EOVERFLOW)?;
+
+            bar1.try_write32(PATTERN_BAR1, page_bar1_off)?;
+
+            let pramin_val = {
+                let mut window = mm.pramin().get_window(pdev)?;
+                window.try_read32(page_phys.into_safe_cast())?
+            };
+
+            if pramin_val != PATTERN_BAR1 {
+                dev_err!(
+                    dev,
+                    "MM: Test 3 FAILED block offset {:#x} page {} (val={:#x})\n",
+                    block.offset(),
+                    j,
+                    pramin_val
+                );
+                test3_passed = false;
+            }
+        }
+
+        vmm.unmap_pages(pdev, mm, mapped)?;
+    }
+
+    // Verify aggregate: all returned block sizes must sum to allocation size.
+    if total_size != SZ_32K {
+        dev_err!(
+            dev,
+            "MM: Test 3 FAILED - total size {} != expected {}\n",
+            total_size,
+            SZ_32K
+        );
+        test3_passed = false;
+    }
+
+    // Release Tests 1-3's Vmm before Test 4 constructs a fresh BarUser on
+    // the same PDB.
+    drop(vmm);
+
+    // Test 4: Exercise `BarUser::map()` end-to-end.
+    let mut bar_user = BarUser::new(pdb_addr, chipset, SZ_64K.into_safe_cast())?;
+    let test4_passed = {
+        let access = bar_user.map(pdev, mm, bar1, &[test_pfn], true)?;
+
+        // Write pattern via PRAMIN, read via BarUserAccess.
+        {
+            let mut window = mm.pramin().get_window(pdev)?;
+            window.try_write32(test_vram.raw(), PATTERN_BAR1)?;
+        }
+
+        let readback = access.try_read32(0)?;
+        if readback == PATTERN_BAR1 {
+            true
+        } else {
+            dev_err!(
+                dev,
+                "MM: Test 4 FAILED - Expected {:#010x}, got {:#010x}\n",
+                PATTERN_BAR1,
+                readback
+            );
+            false
+        }
+    };
+
+    if test1_passed && test2_passed && test3_passed && test4_passed {
+        dev_info!(dev, "MM: All self-tests PASSED\n");
+        Ok(())
+    } else {
+        dev_err!(dev, "MM: Self-tests FAILED\n");
+        Err(EIO)
+    }
+}
diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 4070070922a4..8fd179ce7476 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -22,7 +22,10 @@
     VirtualAddress,
     VramAddress, //
 };
-use kernel::prelude::*;
+use kernel::{
+    device,
+    prelude::*, //
+};
 
 /// Extracts the page table index at a given level from a virtual address.
 pub(super) trait VaLevelIndex {
@@ -383,3 +386,33 @@ fn from(val: AperturePde) -> Self {
         Bounded::from_expr(val as u64 & 0x3)
     }
 }
+
+/// Check if the PDB has valid, VRAM-backed page tables.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+fn check_pdb_inner<M: MmuConfig>(
+    dev: &device::Device<device::Bound>,
+    pramin: &pramin::Pramin,
+    pdb_addr: VramAddress,
+) -> Result {
+    let mut window = pramin.get_window(dev)?;
+    let raw = window.try_read64(pdb_addr.raw())?;
+
+    if !M::Pde::new(raw).is_valid_vram() {
+        return Err(ENOENT);
+    }
+    Ok(())
+}
+
+/// Check if the PDB has valid, VRAM-backed page tables, dispatching by MMU version.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+pub(super) fn check_pdb_valid(
+    dev: &device::Device<device::Bound>,
+    pramin: &pramin::Pramin,
+    pdb_addr: VramAddress,
+    chipset: crate::gpu::Chipset,
+) -> Result {
+    match MmuVersion::from(chipset.arch()) {
+        MmuVersion::V2 => check_pdb_inner::<MmuV2>(dev, pramin, pdb_addr),
+        MmuVersion::V3 => check_pdb_inner::<MmuV3>(dev, pramin, pdb_addr),
+    }
+}
-- 
2.34.1

