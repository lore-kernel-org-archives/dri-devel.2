Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0310103A9A0
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05EBE10E6C0;
	Wed, 25 Mar 2026 02:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aMzHJap5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8662510E6BD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U39WI2fh43Thqd33KPxm2sRJC2f38wfLIbpdT9f202gkgPqLRGN2HNURi5O7QFuPhwIjeQpzLDbo+8hdpHMhr9iZ45bbqvDTTDQI6iazzFwYna+YNAfM2AHe90okAfVdCB6oh5kTEIGLmN5aVVH/Va5sW5TH5rWCyOLax63atJRNb/SwXbEtWFtHcU8mBcDJV8ibAc+ObH3ydKpzKZcfnXuXwuNk1NGbS9isGKAglzQ3kBi/hH26gorGU1gBe54Z/6lm7jOSfluebT++E2tJrtlPKjfEAZ/mJIIdyXK+FHDnwpNS+px6YAhQv7lnHBi3/DN0fu+YLi66egI3EMBOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DtCy3JjxfDTz44vuIpnRs4XDZc1gwoMIAnOSORjFnE=;
 b=jbwk6kKJm7cpvLQBop+oroxTzceY0c75cqtvAn/eUzk9rMd4ZQtvRobvKjS0LABY6oX/ZlI6V2ZorKev0w5aP8UDycIQ31SaSmKkyc9ju9/MILrCKMW4nkuhYJO7kY5mRF9ozKfznonGxZm6k35w++IAlSt3dJEpp6qnP3gy8byaVlJy5yl2VQiMn/lE/KHeSQ9ZPsBLoNAHEc/fgy5qIcMs2qEEAvNu2zA92qbMNitOIsYCdn708Z1ai4ACgCBq/+lJsnIWrA2/+3/HVMZpqy66Bh3dJJLRzf1vy5WbrwjRGTzrxs2fMfRG9apSZc0oakbiQuJll3QvBJs5iDFH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DtCy3JjxfDTz44vuIpnRs4XDZc1gwoMIAnOSORjFnE=;
 b=aMzHJap5+hBbrWV0J+Rk50vk2JcPfYsus1QVkJekBAopjO+58Ejd6Eq5xJTfciNuBmRdyoL3r3VCaxCKun5kigp9BojviU7WQJn2Kud4PePM+xdW+gg2vtEvdKiByg07TCT9aRNYZCPIsp49X2z66ZK+CYgJuH5JYoFDFk0Aj06Uo75LY3ZC/IC4uvzL+BbLDONo6AjooOZVVKEQFDfN+sFKK5zOzLdo63yiTMV9oWSO++t70kJ7mQ0IW4siWdhQs8K0N1eJ8bEGYtxveCeYAOW1DbAIs05Gk0/+yDWLBay1PVdIAiE0dldX5iv4sd3DpUN29OF4LabAi2m3PDog2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:47:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 02:47:09 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 25 Mar 2026 11:46:22 +0900
Subject: [PATCH v4 09/10] gpu: nova-core: remove `io::` qualifier to
 register macro invocations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-b4-nova-register-v4-9-bdf172f0f6ca@nvidia.com>
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
In-Reply-To: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0f39a9-4e54-4b76-b150-08de8a18cf47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: L24wlCiZDfIALyjHgNk5iv8E9412gT4/43BPl/9PeHBOTAqSKPto8J2qipp3+unQzyFmlrTPxvdFei9ZRZmceVb4mt30vFu2QrvbmCsWdd7JYQYJXphrMCf8GFuL+JBqnc327F936viJSp2uY4o1GGeD0Hybn6vSWdjvX+bM9CxSsRkO7bZw07SdbFckXRztJfl5PBcpi+s0SpBitZGPNRJsLMtlODyZqe6xuAcensq/adsmQxRFIqgvJ8BppmfLWsOndEIBoJXGe162PeeN4FdRGidYcaG3fAxzuP5QVuWgAoQMDuDau4a6XCfOol9DmUV5U5ZXk5aCa5YPpyZ6y5CfTQclQaJLMDj2NmvuX1lcpI/8qS1vKLoSa7vHhp9YH0KF7vUHNNbZOMuLRCaJYEYaEVl8HLfxFoF5TL/KsKNiDabSsP0Pcue2B3135cADIFcimAi8WeWYptorixcBeclNwsVZcCCrYQE6MkrMkCyPUCzNUiVlN0udFq93UgsjWZtRpLrTP+VS9mX2PY9hZGlnqNrnm9ujCb0O53d0mpeY95nusnallBvgTBKJdLKAplKZR/M7kZJEsBYISf+IpMtXpui9Z9/7nCnEP9SuSunXDxFq/7S4J8xJgeUUCg7ZIsR69AQ95tEDWGVJshNmWUku37o1KCyM3deZzSCrjJnREYAn4q3kJjxHUkE9PKcb7gf1Z7h2jHHr5zFGTdiRSWNMaUej5V1QPNT3hMkGyQFazHNajsoctaTxi5T3QHbbgRtBb3CVG4w7g13kg7qalQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wnl0cTlYVThIR0xhYkhwSXl0SFJILzBIZHQ2SitWS251ektNNDJYUUwzbHhM?=
 =?utf-8?B?RkJBSmlsVGIvbnRzSUdpR1kxTFcwWTdzb1NJYmhSQUtYV29IbHVmai81Zmd1?=
 =?utf-8?B?aVJOVGZHcUphaUUxMlFkMTV4UjhDZytYLzY4WENja09xSnY2ZDVTaDdKalBP?=
 =?utf-8?B?Szlqbkg2TWN1TjlDakQyNWNTdUhNL1plR0hUaUhUQmlPaVJocHA5aUtrQXJr?=
 =?utf-8?B?V3ljV2s3MzlCdDJLb3NJcUZNVkNYN2pNK0hOaE1YbjRMRVR5U1RiMnpacFdv?=
 =?utf-8?B?cGdCTlJpYmRFZkZPWUJhQkpaRyt1bXFsck9NWDc2a05mOVFRMWJCU2pxU2dX?=
 =?utf-8?B?T1daZE1rV1dadVI0bW1mUVhtem5mdm9ldmViZjJKZUlyVmdFWVA1enFVRDdV?=
 =?utf-8?B?anZiVmEybk5UbTM4eTVwTW1pQ0xQeHJrZ1Iyc055TW9haENwTGZYQlRHSnpo?=
 =?utf-8?B?aVhXSDAwUjE2b0tybXorZWxDTEovTzZPYjdsRWNYMW5JcGl3RkI2Zy9WNUYx?=
 =?utf-8?B?a20zNVF6VUI5SUo1bmh6UkpRUlBQZmtFV3RldVdVb2QrQi90NHd5eCtmdXNa?=
 =?utf-8?B?alNDZ0htaGFmVm1mbUlDbTZsNWJKdFRTM1V4aTd6MmxENzdnUWV2ZmN0WGlW?=
 =?utf-8?B?ZWJPNTRYMk9uZEt2VmkveHZ6MG5kaUxQVjhEN01WOHgyaTNGNWo3WThqRTNR?=
 =?utf-8?B?OCthL3hBYXdvU01BRFJrMTBDRUhWRmwzRmQ0NUpBWUczaVRkeDdyMEZtTzFx?=
 =?utf-8?B?czd5S3hBcHFpcjhyREFkck5TcFBHZzFUdURBRHZvNlRiQmJPbVRGTDlYRkFP?=
 =?utf-8?B?bEdkQ1BSSWtsbXdqMTVjK3ZLcitwSzBqQmMxeGtTeFlyaXF2Ti9VRXlmZVZv?=
 =?utf-8?B?RFFUMHd0cmpINDNqemhxbWhPNUZtd3FhY3BLbFptVUxHeGRRS1JOeUtyalpw?=
 =?utf-8?B?TDBpNWw1czBMeUd0aVFNV3FrNEZFZHpkQUpFUzRzZDM5d092SXBxOERGMFBK?=
 =?utf-8?B?a1dzMjh3SnRrU2tiSk1MZVNucFR5b2c4S0xsSUpHcjJnamtIb1ZPbDg4VURX?=
 =?utf-8?B?Q0k1NmVrL3Jac1JvUFZkRUlISmlVd1REYU9aRzdLWC9Ld3BCMjdFZTJHeWt4?=
 =?utf-8?B?NDFVejVyM3c4U1ZSZEtFSkpWSUllWEtuZ3pxeTNmbkdBeS9VTXhjZDVEMnI1?=
 =?utf-8?B?dDZzM1d6TlQ0dzRvVnA2RG16OFVVblJqTlJuelhjdVd1cFBBM08zZ01RTnND?=
 =?utf-8?B?ZjcwMFRkdUdaaFRPeGorL0pmTnF5T0pubmIxUkw4djRXWGhZcmVrbWR0U3lV?=
 =?utf-8?B?QVNiZ2FXcU9TTTdaSFBpZkVDRUI0dDN1MExGWGU5ZzltU1YvMk1YMDZ2N2NV?=
 =?utf-8?B?Ni9XNkhjaGtxRW1ST1U1SENwbGwvWFgyQTVDUTlEbjZsMHNoWkxUSkN1OFd4?=
 =?utf-8?B?RHMvbFVrRnUzY29yWlZFalpKdGhIdlN2MDRTZzZIaHZqUlo0Y0xNUjNQVkpP?=
 =?utf-8?B?Mm44ZDFWaGtQOWFVUzZMMEpGMCtMZW9KQjIxT08wYzBaVW1tZVFwSVd4YW44?=
 =?utf-8?B?YUNxeDlqNnJ3c3FwSituVlFNbGVKWTloR0pMSHJ0allUdUFhdnQwWlhmTUVw?=
 =?utf-8?B?SXhnSnZNblZpU0ZzUkhYNHkxYktPdzd3ZFJPajVZWmRYM3FPY0dWbXNpeldJ?=
 =?utf-8?B?WGp3ZXZBWGlTTFg3eDNEMEhBQVpQMFdNU0RQVWhxUTE0YnliWmFrVTVwOGZp?=
 =?utf-8?B?b2tvb253MTNGWnBmNGphck1IbUF1ekRDb09oNnQ1cVhwN2xoYllzdTBTenBu?=
 =?utf-8?B?cGdIY2N0N1NtWjJJSTZmc2FwM3YrRWtwVFJ6VnB4c2psMjcxQjhBaTA5R3ZV?=
 =?utf-8?B?UTRIUmN1REppb1FWSzRzdEsrTzRFcmliWXRRTTJsWmNRalBtSVdjZStmN2ox?=
 =?utf-8?B?TmQ2azRHZFJVMW5xbkY0d0liWE9CaTIyUktCK1VsdURySFRqWitTRzI4WHJ1?=
 =?utf-8?B?and3Y2NpRytYU3BlYlh3RUFvL2xsSEVQN1RkTDhJcmY2cCttTG9MbDhacXpJ?=
 =?utf-8?B?ajRicXlqakl2cDRtTXpaeEg3NzlvNkpuVXBkSXZYT0J0WCs2V0pnU3JsNUow?=
 =?utf-8?B?VU1xS1JndUpoTmdydWxzYmRhWGh3dElrY0RZcmg2d3MwMjVzVEp3TVpPWHRv?=
 =?utf-8?B?QUd6bnJXVG9WMEhZR0c3WWQ1QjJjZWgxME1yelBaMnN4bGFwOUxFSkxrWlk1?=
 =?utf-8?B?RlN5MUlyRm1pUlBKZGZXSHlpNmR2aU5TaTdkQlE4cWFnTlZhWTV2ai83alNn?=
 =?utf-8?B?SHVIYjRzZUxBeDl6UXFmMjhzRVZiSVI3citoUmlUNzlVaUlCZTJGWGtEN1V2?=
 =?utf-8?Q?8G/P7OBRHQi3GkQKUCZof+AoHvHGzESWmK4OkAwCZy1sK?=
X-MS-Exchange-AntiSpam-MessageData-1: kRvctoAqn/1IAQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0f39a9-4e54-4b76-b150-08de8a18cf47
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:47:09.6170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G11NGoJRGtCDygwoej0nd/KoSzqMfMmphzi08iNDlGhbITtASSUFoyPK+d+UeZTg4kNNZB2uXYLlBZLu8joH8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

The kernel's `register` macro would clash with nova-core's own version
if it was imported directly, so it was accessed through its `io` module
during the conversion phase.

Now that nova-core's `register` macro doesn't exist anymore, we can
import and use it directly without risk of name collision.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/regs.rs | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 87c2977ba6e4..2f171a4ff9ba 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -2,7 +2,7 @@
 
 use kernel::{
     io::{
-        self,
+        register,
         register::WithBase,
         Io, //
     },
@@ -35,7 +35,7 @@
 
 // PMC
 
-io::register! {
+register! {
     /// Basic revision information about the GPU.
     pub(crate) NV_PMC_BOOT_0(u32) @ 0x00000000 {
         /// Lower bits of the architecture.
@@ -106,7 +106,7 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PBUS
 
-io::register! {
+register! {
     pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
 
     /// Scratch register 0xe used as FRTS firmware error code.
@@ -117,7 +117,7 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PFB
 
-io::register! {
+register! {
     /// Low bits of the physical system memory address used by the GPU to perform sysmembar
     /// operations (see [`crate::fb::SysmemFlush`]).
     pub(crate) NV_PFB_NISO_FLUSH_SYSMEM_ADDR(u32) @ 0x00100c10 {
@@ -180,7 +180,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 
 // PGSP
 
-io::register! {
+register! {
     pub(crate) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
         31:0    address;
     }
@@ -195,7 +195,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 // These scratch registers remain powered on even in a low-power state and have a designated group
 // number.
 
-io::register! {
+register! {
     /// Boot Sequence Interface (BSI) register used to determine
     /// if GSP reload/resume has completed during the boot process.
     pub(crate) NV_PGC6_BSI_SECURE_SCRATCH_14(u32) @ 0x001180f8 {
@@ -247,7 +247,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
 // PDISP
 
-io::register! {
+register! {
     pub(crate) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
         /// VGA workspace base address divided by 0x10000.
         31:8    addr;
@@ -271,7 +271,7 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
-io::register! {
+register! {
     pub(crate) NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x00824100 {
         15:0    data => u16;
     }
@@ -287,7 +287,7 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 // PFALCON
 
-io::register! {
+register! {
     pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
         6:6     swgen0 => bool;
         4:4     halt => bool;
@@ -468,7 +468,7 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 
 /* PFALCON2 */
 
-io::register! {
+register! {
     pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
         7:0     algo ?=> FalconModSelAlgo;
     }
@@ -490,7 +490,7 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 
 // PRISCV
 
-io::register! {
+register! {
     /// RISC-V status register for debug (Turing and GA100 only).
     /// Reflects current RISC-V core status.
     pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
@@ -516,11 +516,11 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // only be used in HAL modules.
 
 pub(crate) mod gm107 {
-    use kernel::io;
+    use kernel::io::register;
 
     // FUSE
 
-    io::register! {
+    register! {
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00021c04 {
             0:0     display_disabled => bool;
         }
@@ -528,11 +528,11 @@ pub(crate) mod gm107 {
 }
 
 pub(crate) mod ga100 {
-    use kernel::io;
+    use kernel::io::register;
 
     // FUSE
 
-    io::register! {
+    register! {
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00820c04 {
             0:0     display_disabled => bool;
         }

-- 
2.53.0

