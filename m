Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE27EC01CE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A413710E3FD;
	Mon, 23 Mar 2026 11:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="f1Vz97oR";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A027E10E3FA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYVnXqLt56Yd142YdVlxRDO8jDCPip0C0/0uvi9cpERZLWDxXmFDaQS7JiJX45q+6i0bR25IxkU8Uo3MfJWaYLP/jbyYwZx+GmfrwhyG6R1rwnYPcgsjBGgijuPXfFHhvn+BMcWIIm8k2mSK2TVprwmvid/T8w31eiWtHwEBRzziRjzOM3JgWckhCt7stl8y3GQ/MRSNWWgfynnosEhM1dODqYMtwoPwaATwKkV0sP0i3KuFi7ZZf/YNwjNG5iFcLTv9SnIkcQJKPLXTKl+CKVxa28ZGUpe+dWmaMd16sASqTdun2wDBhjohm0FAplXDRrGCJkFzmNWUpXnk3+NXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njKVJzFsnGP+sjNyJ2knpbzHaLUkKatE3tX4O5dIiDU=;
 b=Ej+kNi009bvdw5+2632oQePUyO3IWmvm4UWafw5Yvh2ECjUgMMm3NvbhWADYfdYq8RCecZRIsA2jXnIOzIjallDZNQLwcUz9bjmDq2lOR6BOYCe+keKjob1ctIfNRLM2S2ShhXyDjewjbKgRVdiwS0oZlnQ3QnHUjr98gP2GXfFyIBhr1rGpfo8mQZgsF7KALReRCBpn+goG8dmCJ9sUG6imBc2J53EKbfb+uiKhFKsm4DvtGwxD1LYubZesOY8ggTuIpQ/HjNq/N/tbQfE2Vb6tHCxH1PZ5HEh1pjZ67Gt3rrBJVsqmf9FeFv5h0ds/RDl2GIt1OncpenkwjwvK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njKVJzFsnGP+sjNyJ2knpbzHaLUkKatE3tX4O5dIiDU=;
 b=f1Vz97oRk25yjeMFbBG4/hKNyJrohq3ILzAAY/BFFbeLNS2TV/wpGY4Ahv4V7dOAUVLlZ99kVJJiSDLvjpzYlf2tGFwRoVtD1RH128df6anhW4El9pDgc6AW/Rk+1YPOBTUx8FiI4E81iLFwXhuaF6jPVk5hqzFhvShNf0F1vy5XV89TCD+FX7t+ngJqK7Cz67HqyOu25sINfc2yp95nz5k/FSoManQLwjqLtvjkJcFew5Yo6A1NOauZfWLzTcPVUVkXwZVcHpya92AFfCf2HJxFD/HaUIA5QhF87QjWqwHeJ3iu28dCCStegvzCiNlRFjwRAf9PB4yuUz3UKxkWdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:08:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:08:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 23 Mar 2026 20:07:39 +0900
Subject: [PATCH v3 04/10] gpu: nova-core: convert GC6 registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-nova-register-v3-4-ae2486ecef1b@nvidia.com>
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
In-Reply-To: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: dbdf4722-8e32-47db-3e59-08de88cc7397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6oIeIofdLTR8cLX8tF8qoXu4zsY8VXV518nOWyqDUm3ByCQ5rlV36vU7OivOHv7X8zbiXtD1+t6qnhdtJjEIr/U/gPQVQ92xKJOy2eDouKcEQAhxYL3o3x8a0ntx9Vx7nxHSPOV2J+AnL3szmta1kb0ZFF3BSa3tQhXCAf1+0Fpk7aDEZZTE47VyLLKb+xbQeRYofSpu7Fw+/zUnyLhNsuDBhVG5jx+kFdrXPsTPGQOB/C4nwRCUiLuGFiZnLr/9sM3XYbOpojP989VHPNt9gw3A2wzdOex7RQlHDiUMZ5Zh5rFnR45+0a6vMGpuFdyrGvMufvUhqz8BOyYZyPG1oQH5RE6s9KgcaExZ2Fny1EnHyw4GYeq+Dj0YzyIgeCGfDMCd+dAhvC6cciJMO4jDZrmjPmmmBnaoz8B5f2bOezCv3wwYn6SQfGFZgfvHZt7HcvOC/ZWX2etrfhXe9x/FKxYLEekBIhkkwOkqu8bCh3hxHGOgRZli9yQan8TUoJly+tJ9zz3VeT0iGINsaDoJXn5d4SKRL+8PeDsx4ua8LUD4vJVTN8hP/lb88zd+5blyoJXjoZMc6Svmr1mV7Ybp/JW9bNrsXMHuQ4emh90xdHHBbx6c0OADpY9UuzxFny/vSc4e2T4QEPh6PU6cIXhEiIGoTZoXUTeHS4N1ISkzbsNSAwiwYQCSUGDq6AHOQnJbRTW6jYwsLyGAu930PpkKOdrQhTYrCkQlhDpJBTVrR4xPDK3Sjti7jmHuOI7Rt1vvyn99ofShjBJ9IgSElnGQsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBYNE9McFhUSm9tbE9NREcxOWVHdjNKcnVoS2NGanFUTkNqdjY4T2VySFBJ?=
 =?utf-8?B?MjhNZDJhci85b01vR1JodmRVaFljVXZOYitQa3p4TXdtWWVsTVhBTDQzdzZD?=
 =?utf-8?B?a2FlSjlWYTNyK08yNWVLb0Y5SHFmeTFaYlFvZ0tPOVFGdVVqR2ZBakVocTdx?=
 =?utf-8?B?VEdWTENVMnN3elFPMnFyVXJ2eFlBUXRrWU81aFJOc1VIZzlIMVNEcGVPQTNi?=
 =?utf-8?B?TFBmRUNmL0ZPWlFkaTNjbVFoUjNiNGlVeGwrSXVYVE9aSmlIbDczRkU1blNH?=
 =?utf-8?B?YXpRT0IwVWdBblMwVWNCOThCYTNCYXFLZllCeXFuTUtGRmRhY1VaYVJQa0hs?=
 =?utf-8?B?Q1l4QjdpcWhIajlGTnVORk5BT1pMWkpMV2pJL2ZoN3hZWTZmdHplRGFkNUMv?=
 =?utf-8?B?TlE2NGlIV05PWE5uODhJV1VsVExVYjY2cHhkRmtVQjRnRHd1ekVLc1ZMZ3lU?=
 =?utf-8?B?VlBiRjMyWkx6S09taTYrdTljSC80NnFjenp5MTVkRktnb01zakl6YXQxZTNz?=
 =?utf-8?B?a3ZESnNqM3ZLMm5BNWtXd3BDcXA1UmlmbnhrcU5sanVseWJ6dnFuMnRVcTVh?=
 =?utf-8?B?VTVweXRLWENIbkI3NzMwejNYQktUMmtuM3BuTzlJMzZjYkJvV0crZnBCemJp?=
 =?utf-8?B?VG9DbC84Qmg2UmlMWXlRdmxldk1RQ2JhcnNvVHZRUWdKZ2NiRFpTdWtDZWJs?=
 =?utf-8?B?WmVhUTA0MnZJYUdVVkdWTnZpSDBWNHQzL2NFR2dWQk1OTnFwa1d6UWtrYWNB?=
 =?utf-8?B?cmYxbVlKYTBvOTRaMnpWWjAyaTIwMEVZWFNwRVVad1hkV2ErWjFUWlJ6T1lS?=
 =?utf-8?B?UHhWbGo1TEdjb0U4WmxGS3ZDc0xNVnlSMzJGMldyRTU3bTRtVjhzVFQvOTdT?=
 =?utf-8?B?WERHME1neGsrV2o2Y0I1SGwrQlVUNnpnRzRyeXI5NDRrQ2V4aDl4SlhNWHow?=
 =?utf-8?B?WUJtWEU0anJlVE9ZRFNkWUFWdVNMNW94ZlhVYXQvTXNYK1R5RkJuUk1uZkNi?=
 =?utf-8?B?K3dQTWtPVXVvcDkzVTJSbWVaY1Bzc0psSHBJeE9xVnRWQk03MnArZktqZ2Q4?=
 =?utf-8?B?cm1XdzVib1hNRGZydER5S3FlVlZaWE9IWGhObnhFckxRemhWRW9Yd01HdFhx?=
 =?utf-8?B?YkJFTmlhQXkzbk5nTzVreE9ZY1A0MTVTMFdMM3FqNHdBamRuQmszMVlTSisx?=
 =?utf-8?B?V2paSFhvOHhMQ0RzUnI0QkZ0a2QyY1htMWNIcXFtVkUxK3N3S2RiUmo5OFBv?=
 =?utf-8?B?cEhBNlM4TFNzYmFYUllGZ1JOVEd6RzdjQ0dFUXNaRTNyeW1sdWZaSzF6K0xk?=
 =?utf-8?B?QjJuTDB4UVF6blpvbEp6WU9xTzFWbUNjTmNxZC85bXNRaE9BUzFPVWU5Skpv?=
 =?utf-8?B?c3YrZC82Mlp0d2tlSzNiL2JBRUNUNHlEeG1lNmxiZnhtVngrbnJndVVRZWND?=
 =?utf-8?B?WVRNMVJsZ1NVRTZEZXA0bkd1WFFUd3lBYTR4N29POFAwSFlEem5xWXY4cDNY?=
 =?utf-8?B?ZmQ2akcydTNBVTdXaGU3Q2dnM3FkbkFteWwraVEraUx1VXRYY3B5TFc1NmJL?=
 =?utf-8?B?eDk5UXB0dTdPOXlUVlBDa00zTlplTDVzcitVSVRId0UvRkFjQ3VhZmNudW43?=
 =?utf-8?B?OWx2TEJST29zcVU0UmNqSXQwYldOTUtpS3M4QW96MWlVN0ZobVc2TGM3a2FB?=
 =?utf-8?B?VDM3b2o2Zm5QV0J3QTJ6SlozOE1MN1NqSVVjSkNLaTZIN3NXdHV2Z2JuRjE0?=
 =?utf-8?B?YjdQUUhPQkc4eVp6NmR4b2tPa2NUT2NhMklENlA4STNWcUZEMHhZRm1aeDNP?=
 =?utf-8?B?ZlpRaGRXTENVRzFvNTl0cHYzRzR4VExYQzNkYlBzYzhOWm8yNjZTSmFXWUFG?=
 =?utf-8?B?amtwUnBpMUplRldLMGY0WENtZHBKYWZDL01iM2YxeGlpY3VXNHlxcmJiMVcr?=
 =?utf-8?B?bVBsM2VKQlVJaXJFSGd2UVVSOUU1TWhsQzhKTE80eUQxVFhIWTVqb0RjdmE3?=
 =?utf-8?B?NlZEdUhWdksvWVRCRTFQRTh3QnRHaVFUY1g1T3k4NjAwM2NwcVZXclpDZ2x5?=
 =?utf-8?B?OS93LzVlRy9HQ2ZlL3dqc0hBWU5ZOEo0bXhYTnVhY2pUVVEyUUwwODhnMU5N?=
 =?utf-8?B?WUxubkdCdFZZMDRQYm9HZW51RHJNWVh0RVduTGZYUXppTkkrN0xMTzhta3Rv?=
 =?utf-8?B?YlpWSTZzc29lTnBINkRUbGs2SnBucFdUdWZEMmcrOHBEMy9MSG1wMldoSkwz?=
 =?utf-8?B?bi9ialZiM3gyU2F0aGRPRUcrWDE5YzhNMFVqOFhNUDFQNXBZSDdPYlRZM3RQ?=
 =?utf-8?B?aUZvY2FIV2NHcVJoZ012REc3SjV0cVhqMHI1RFo3K0h1UXI0MDN0eDVYdUJj?=
 =?utf-8?Q?kSnt87lkzchKXSgik9PLtmVfmqxxmK0XLoO6Db6UCRtns?=
X-MS-Exchange-AntiSpam-MessageData-1: ekcWt8yJ4leAiA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdf4722-8e32-47db-3e59-08de88cc7397
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:08:02.8300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bAfXyBDQLlS/WRbK84VeHJ0fSplWDVthwpm2YvwO6cM0koPm7OtboqupqVnfkFZ9ossbmAwmrMAyIh6wwJQhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

Convert all GC6 registers to use the kernel's register macro and update
the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon/gsp.rs   |  7 ++--
 drivers/gpu/nova-core/fb/hal/ga102.rs |  7 ++--
 drivers/gpu/nova-core/gfw.rs          | 11 ++++--
 drivers/gpu/nova-core/regs.rs         | 67 ++++++++++++++++++-----------------
 4 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index 67edef3636c1..e52f57abc223 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use kernel::{
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -47,7 +50,7 @@ pub(crate) fn clear_swgen0_intr(&self, bar: &Bar0) {
     /// Checks if GSP reload/resume has completed during the boot process.
     pub(crate) fn check_reload_completed(&self, bar: &Bar0, timeout: Delta) -> Result<bool> {
         read_poll_timeout(
-            || Ok(regs::NV_PGC6_BSI_SECURE_SCRATCH_14::read(bar)),
+            || Ok(bar.read(regs::NV_PGC6_BSI_SECURE_SCRATCH_14)),
             |val| val.boot_stage_3_handoff(),
             Delta::ZERO,
             timeout,
diff --git a/drivers/gpu/nova-core/fb/hal/ga102.rs b/drivers/gpu/nova-core/fb/hal/ga102.rs
index 734605905031..4b9f0f74d0e7 100644
--- a/drivers/gpu/nova-core/fb/hal/ga102.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga102.rs
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::prelude::*;
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
 
 use crate::{
     driver::Bar0,
@@ -9,7 +12,7 @@
 };
 
 fn vidmem_size_ga102(bar: &Bar0) -> u64 {
-    regs::NV_USABLE_FB_SIZE_IN_MB::read(bar).usable_fb_size()
+    bar.read(regs::NV_USABLE_FB_SIZE_IN_MB).usable_fb_size()
 }
 
 struct Ga102;
diff --git a/drivers/gpu/nova-core/gfw.rs b/drivers/gpu/nova-core/gfw.rs
index 9121f400046d..fb75dd10a172 100644
--- a/drivers/gpu/nova-core/gfw.rs
+++ b/drivers/gpu/nova-core/gfw.rs
@@ -19,7 +19,10 @@
 //! Note that the devinit sequence also needs to run during suspend/resume.
 
 use kernel::{
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -58,9 +61,11 @@ pub(crate) fn wait_gfw_boot_completion(bar: &Bar0) -> Result {
             Ok(
                 // Check that FWSEC has lowered its protection level before reading the GFW_BOOT
                 // status.
-                regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK::read(bar)
+                bar.read(regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK)
                     .read_protection_level0()
-                    && regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT::read(bar).completed(),
+                    && bar
+                        .read(regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT)
+                        .completed(),
             )
         },
         |&gfw_booted| gfw_booted,
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 4f5cd64c2fce..6f49467e78ec 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -198,29 +198,41 @@ pub(crate) fn higher_bound(self) -> u64 {
 // These scratch registers remain powered on even in a low-power state and have a designated group
 // number.
 
-// Boot Sequence Interface (BSI) register used to determine
-// if GSP reload/resume has completed during the boot process.
-register!(NV_PGC6_BSI_SECURE_SCRATCH_14 @ 0x001180f8 {
-    26:26   boot_stage_3_handoff as bool;
-});
-
-// Privilege level mask register. It dictates whether the host CPU has privilege to access the
-// `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
-register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128,
-          "Privilege level mask register" {
-    0:0     read_protection_level0 as bool, "Set after FWSEC lowers its protection level";
-});
-
-// OpenRM defines this as a register array, but doesn't specify its size and only uses its first
-// element. Be conservative until we know the actual size or need to use more registers.
-register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05 @ 0x00118234[1] {});
-
-register!(
-    NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT => NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[0],
-    "Scratch group 05 register 0 used as GFW boot progress indicator" {
-        7:0    progress as u8, "Progress of GFW boot (0xff means completed)";
+io::register! {
+    /// Boot Sequence Interface (BSI) register used to determine
+    /// if GSP reload/resume has completed during the boot process.
+    pub(crate) NV_PGC6_BSI_SECURE_SCRATCH_14(u32) @ 0x001180f8 {
+        26:26   boot_stage_3_handoff => bool;
     }
-);
+
+    /// Privilege level mask register. It dictates whether the host CPU has privilege to access the
+    /// `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK(u32) @ 0x00118128 {
+        /// Set after FWSEC lowers its protection level.
+        0:0     read_protection_level0 => bool;
+    }
+
+    /// OpenRM defines this as a register array, but doesn't specify its size and only uses its
+    /// first element. Be conservative until we know the actual size or need to use more registers.
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_05(u32)[1] @ 0x00118234 {}
+
+    /// Scratch group 05 register 0 used as GFW boot progress indicator.
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT(u32)
+        => NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[0] {
+        /// Progress of GFW boot (0xff means completed).
+        7:0    progress;
+    }
+
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_42(u32) @ 0x001183a4 {
+        31:0    value;
+    }
+
+    /// Scratch group 42 register used as framebuffer size.
+    pub(crate) NV_USABLE_FB_SIZE_IN_MB(u32) => NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 {
+        /// Usable framebuffer size, in megabytes.
+        31:0    value;
+    }
+}
 
 impl NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT {
     /// Returns `true` if GFW boot is completed.
@@ -229,17 +241,6 @@ pub(crate) fn completed(self) -> bool {
     }
 }
 
-register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
-    31:0    value as u32;
-});
-
-register!(
-    NV_USABLE_FB_SIZE_IN_MB => NV_PGC6_AON_SECURE_SCRATCH_GROUP_42,
-    "Scratch group 42 register used as framebuffer size" {
-        31:0    value as u32, "Usable framebuffer size, in megabytes";
-    }
-);
-
 impl NV_USABLE_FB_SIZE_IN_MB {
     /// Returns the usable framebuffer size, in bytes.
     pub(crate) fn usable_fb_size(self) -> u64 {

-- 
2.53.0

