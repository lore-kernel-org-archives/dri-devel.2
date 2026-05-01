Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22627CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 20:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC9D10E214;
	Fri,  1 May 2026 20:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="O1zYkToO";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD2F10E214
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 20:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN4v61Ahcl7jRtOgYpMuITqGpj5JHzzi06X0PfxoEb/K9XexJQzysq6Q/T5t19Chlp+jFZ06LlA5PebfNMwBmGyfpmZYLS3ACO2vbKl3AgzbYoA+nMsEFl1FcGRbD8dEYvNTzHgmanuOLB//Kog+Dp8yt6YnIcGbjeWSGfjQjFbEpxhxu59NWY8TVcwZfiz8Ch79b9Fnjwx7/xYiRi9FGEZBie+PumltLi3pQJ0jeBDMMHb1ajGsMHXZzS/SQL1nV4VryfVcQARiNAXBCrXKPcAT48qQ6SF1wzDohpdANSEZVHcolnq7EaQWOOWQrw+6rXXs3cqvrkPD8if9ATwtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4SeWrM7mt8EkPREZNUOyCtHOEygrvsCICbq8TN3YIY=;
 b=xoJb5j3pFL7Pmi8uUBTZBTzWtfR7Mva2xt5LF5OokRrX7oJg4iP6XYJwmtmeOOE0ma6Y5KaPjYHnGuKFWCXrJ62D1wSRAzBPs4e1Yt71x/i6mfE4wr3NFzn26FTZnWALjMhy8PEu2065notxpggoLeM3MT4RNEjcCxWqwFyieyz82u0ScC5r0b691Mp96jyRQzbQP2qrZAbiq8CxM3d/YTHcCtq9owPDFjpNySRsjOSQXyKjXxT4YH9mwtpjHHaU8iXZ8IJBLfP/HUjlCIyltjTB8h+3tIZwWufBrm4qlUKFtb8NfDi79wocN+HjMaxwono6N3EEDtOhtJIYwYIEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4SeWrM7mt8EkPREZNUOyCtHOEygrvsCICbq8TN3YIY=;
 b=O1zYkToOa3jTDhfQ4btsEYn3V1X24vnyqpyTCkrLCMBnJv/JViUizbEl6z4ABmYVTWbwwS5+bcvQ2CVOpa4ppJ5s9kr7p1+l+noI0y3yz4mOq3uz8U8JppEoCdZWov8ydqAM8j6WiRw2aI+BvGq/DlwKe6Y/pSFqmJ8nOxDwYDxjq2X+uMPbEqO4stiLz/d5dLJUxvFwLKC0JSvdpeDDq+4f0vZfsUPrvt1JPx/80psgdQKpC0e56OqzvNn/1cYYqoZ+AhkSWyCFodHIRBlanoilQ19IdXshm1vgjWM/FdgpyRyv9ns90QilLtTjnQfQhiAUi+1F137SU0I8Bswu6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 20:58:38 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 20:58:38 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 3/7] gpu: nova-core: add interrupt controller register
 definitions
Date: Fri,  1 May 2026 16:58:21 -0400
Message-Id: <20260501205825.73614-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501205825.73614-1-joelagnelf@nvidia.com>
References: <20260501205825.73614-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::26) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ceb4eee-34f5-450c-a98a-08dea7c46ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FlEAjhroqnFnGQjVfsZZvi6P6xw7e24vuoNu5aZFyCDic05mVz+XATPa6B3c5bi8AU4a5xlA+g8DZp3yeqUziNB1zYB051D1z/zk7yXMM86tXU0RG7yhHC7/Ct9hD9rOpMNwIYoVhLFR6ziE2nzgwhIYjAJxz4U2JDuNbuyTlMYW6n6eQMltxzX2HucyeW7YdOyfi4VgLMcowYQaEnu/dRAUnGkduskfvvEvZzgbVCmB7FJTzU+d9kOsfd9gUcsvqMY1mcx4TsqgWKgUlRMMBh5Zdgnxus5pkOkXBSxCfVraDrYJgLereOpd1rQjW+hX48miTb+F6e4XDfaNRO3QaqynFOBaIPSXpWKYwcazqgpAOOSMD6thqPOHL39sbhqfj3DbOKUYZbQPlsL/cRUrXIInIiQuppFc57PEK6/7ic/d4ryOYDSRW1CZzrh7kNRJCRd+dxkdjlxw4NKZKly+ybWFejXlbV3uh42GASk7DbM8D9Y9thoSxLrnuksMx5ga/tfFyZmF3/xWPmzVhZMh107mSoixAgkBpyWQlQeQjRKmUU1OfsI55CPOzh8jpvcTzxKX/AWclTI7mBLWoNZ5NZvSzYh69dJTSKL1au08H/f7VCAtcMJtyywLvPMD/Uiahu3EGlatYZeWrPjBp9Y0oJjbw333twvPajgMHxKA1YvmEf5mB1eM9IBwy7lUaQNP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TlfElmj6GuUMXsW6C+OCN2LkZNnkkxoYdS1UDS6vO6KHIVDGPyEed6VdAt8z?=
 =?us-ascii?Q?ToreAt5aBgKWCLKnLz2EuDzx3xB/UQUCo4BCiIIEIv0LWSma0yNeFn2iYSV2?=
 =?us-ascii?Q?SnQrR6d/D6S+yYZ9jiZa8BJfRP1flMYONvn4NHbMfVYXQl2j8rXGLw2h+TzL?=
 =?us-ascii?Q?kQ1N/qQU8bfly4JoU5bMsaE7XTYQ1Hv8u8PX9d6k43x+RfVE4HD+TylCWXs5?=
 =?us-ascii?Q?JDsU32APntOTZ7SPlfUNJLPlyQ3sQUSilUlELRiNASOCTFgMSwvG8nEJlG9r?=
 =?us-ascii?Q?1C/AVTwIRbZtrSWA+UB1TblXx4NiAR7XndsrIPmFMKrkKpk7I8UrunLOEayI?=
 =?us-ascii?Q?OzQEKyZS8sOABz/CWmY8IzsQ9fKHw5v6cDruKWlYSaNamYUmJAvEeqq17S2q?=
 =?us-ascii?Q?mTrBra4IjVHtU5PT97H5N3e65qJ/zGmoUExUt8ysrNxzdeIYqJk8+E7lplKy?=
 =?us-ascii?Q?L21lyeUKsOjQ2UBn6tEBC7gaPKyvRM1qV70OUr1MlaVo98ErH0M9xYWvxyja?=
 =?us-ascii?Q?N51g6m6oFvnjZLWF7TXR/CpPRVv1DXM+E5fJCPxH+HYtGAEoFRgSvSO0zZTC?=
 =?us-ascii?Q?DK9R26OD4Gmt64in/kuSgV0ey/txN4U96wOccwzuSKfG/KnbqTY8Fih9SWtu?=
 =?us-ascii?Q?KZNVzbkB6Ua+KVPbAvIjll+aHDgcefqPCjNbghI4rzErcI5epWFaMmckN/hX?=
 =?us-ascii?Q?MITQkQpN205CxHByUlreJKHVclfnVA3is/Tg522POlNtreMVJ8lP4F73GX8p?=
 =?us-ascii?Q?IK5y8c88KB0UCWobY40RlVMuFeZAELBUZRfDnZzRTb6ZEtcoRue6RdXOO3+g?=
 =?us-ascii?Q?Kle2lKXJRzuZRTiXHs6mrfUR9DfpFH1zEx9Fs2H+zjdKx6SWOHHjx2xxwjBa?=
 =?us-ascii?Q?g49hqgOoKUqc37twdF3CFIubqMPIFnO6Jzmt+X2I+kYBYjWbFgD9tPnYFp16?=
 =?us-ascii?Q?4MDRb9vs/OtmF6Q/Mz9u+ROgUbDByBFOMWxc40+Z9WsXuq4H8lPs0HLnAP8n?=
 =?us-ascii?Q?pvf9PvtvwxhDtEI6+kqs7C4qFqNrdRhE5v52zgcfo9hHj6bU9INr5r+nAlhQ?=
 =?us-ascii?Q?IIre+7vzdasM3QT+QH5nPplJaaqtcHUUtqXzZKSXG3wqalIrhS4hfepBNSfj?=
 =?us-ascii?Q?Mk37+qn+CTAcSKtOvNj+/YJCL+KXmGe3qB9BYBRA6B+mnnuv+Hq46aerNucL?=
 =?us-ascii?Q?L5H974+csbZeV10SkToA1SdEsegK2IVjJjb0Gvlvw0XVohx1Ctj/IRQOTbWk?=
 =?us-ascii?Q?PXeCXKvJ71eFyLQyypEnC5nuNrumMN0qFmJ+jIxxLjfCVlJT4jzugDCGXESC?=
 =?us-ascii?Q?1vstu6vt2e20kHYikgRltxTgToY6S6ou1BvxnFdU/9Q25dAwfQDGECH2Wj23?=
 =?us-ascii?Q?Esu+/mFDJrbvFNa2g/JpFPx5FCl1eKBhYccDuisaRqqfn/pRCYbC0UrjFdo9?=
 =?us-ascii?Q?SXlHi/mdlzy8WCsLS3KYHmppVn9GSMNCsQWCIBQ8rK83gtnZZyizbGI5an2S?=
 =?us-ascii?Q?cxGeJ66NijjD3ZRk+BdnrjuLRkg2jPxrij5YccAbTlPq1FTlqab/wDxfH0cr?=
 =?us-ascii?Q?f4hSdgrxXPH7DCvXU14Y0AHcHwOQY1wxueWAPEGy4asH9us/ToH60wAmKZlV?=
 =?us-ascii?Q?YmBoKDdHALa50BjRgYRNXzbgKtOjwP6f1NoGFG9meirkHxq28cJYxrF0vfkZ?=
 =?us-ascii?Q?R+Bp8P8Hb6O/EnM8lLW9aB7C9YX2XiSkxROACaJBflzamWJvit0acST4peP4?=
 =?us-ascii?Q?Q8oAlQkuRQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ceb4eee-34f5-450c-a98a-08dea7c46ace
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 20:58:38.1942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPrXrFYgLrtegZUTKNl9uiAvWT79Dw7k7RXGYQMalqSrwFIsbrwuHI5BmVSbNcHMmV9ExO0RSF/Mdrs8xZl+Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

Define the interrupt controller register layout in regs.rs.

The runtime leaf count is architecture-dependent. Leaf arrays have 16
entries covering Hopper/Blackwell maximum. Pre-Hopper chipsets
(Turing/Ampere/Ada) only use indices 0-7.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/regs.rs | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 6faeed73901d..51dff318acf1 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -284,6 +284,53 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
     }
 }
 
+// INTR_CTRL block.
+// Definition of the PF interrupt tree of the GPU interrupt controller. The PF
+// can also view VF interrupt trees, but that is not supported right now.
+
+register! {
+    /// Per-leaf pending interrupt bitmap. Bit N is set when vector
+    /// `(leaf * 32) + N` is pending. Reading returns the current pending bitmap;
+    /// writing acknowledges set bits (write-1-to-clear). 16 leaves cover the
+    /// Hopper/Blackwell+ maximum of 512 vectors; earlier architectures
+    /// (Turing/Ampere/Ada) only use indices 0..7.
+    pub(crate) NV_VF_INTR_LEAF(u32)[16] @ 0x00b81000 {}
+
+    /// Per-leaf interrupt enable set ("allow"). Writing a 1 to bit N enables
+    /// vector `(leaf * 32) + N` (write-1-to-set; writing 0 has no effect).
+    /// Used to unmask interrupts from a specific source.
+    pub(crate) NV_VF_INTR_LEAF_EN_SET(u32)[16] @ 0x00b81200 {}
+
+    /// Per-leaf interrupt enable clear ("block"). Writing a 1 to bit N disables
+    /// vector `(leaf * 32) + N` (write-1-to-clear; writing 0 has no effect).
+    /// Used to mask interrupts from a specific source.
+    pub(crate) NV_VF_INTR_LEAF_EN_CLEAR(u32)[16] @ 0x00b81400 {}
+
+    /// Top-level pending bitmap. Bit N is set if any enabled vector in subtree
+    /// N is pending. Each subtree covers two consecutive leaves
+    /// (subtree N = leaves 2N and 2N+1). The top bit clears automatically once
+    /// every pending vector in the subtree has been acknowledged via the
+    /// corresponding LEAF register.
+    pub(crate) NV_VF_INTR_TOP(u32) @ 0x00b81600 {}
+
+    /// Top-level enable set ("rearm"). Writing a 1 to bit N enables MSI
+    /// delivery for subtree N (write-1-to-set). The ISR writes the active
+    /// subtree mask here after servicing all pending leaves to resume MSI
+    /// generation.
+    pub(crate) NV_VF_INTR_TOP_EN_SET(u32) @ 0x00b81608 {}
+
+    /// Top-level enable clear ("unarm"). Writing a 1 to bit N disables MSI
+    /// delivery for subtree N (write-1-to-clear). The ISR writes the active
+    /// subtree mask here on entry to mask further MSI writes while servicing
+    /// the pending leaves.
+    pub(crate) NV_VF_INTR_TOP_EN_CLEAR(u32) @ 0x00b81610 {}
+
+    /// Synthetic interrupt trigger. Writing a vector number sets that vector's
+    /// LEAF bit as if the corresponding hardware source had asserted, allowing
+    /// software to inject interrupts. Used by the CPU doorbell self-test.
+    pub(crate) NV_VF_INTR_LEAF_TRIGGER(u32) @ 0x00b81640 {}
+}
+
 // PFALCON
 
 register! {
-- 
2.34.1

