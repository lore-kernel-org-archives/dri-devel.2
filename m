Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4E1FCD0CD
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAEB910E6ED;
	Wed, 18 Mar 2026 08:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lI/SPnyR";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5150810E6D5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr04fXGWhrbCHtol4DZBIcvHbGWFp6cJqXgwH7TIGjBG65gOUqLGFqx8jGmP9ssNQVx4TROBT7ejGqrivayK5N8tFKQJUqs59TGRzgip0z3GmrifwrAmPwnObqWvbfw+O498BwusbRjnEowOoaRKFns2YxRo0TCJnzGXZKZdlHtgL/7mae/IgVYVVLXUw1FeRlmNr6uUAusjryEaYxGnTIXKSGu5BmyeqcCcOq5y659EaJXb10FJaAFQI4jHADG2QeZUn7Ncnvr4xjq1MinmaLajy8df0i+tEOxw0YL4d8Q/mw6YQ7ecfT9TKOah+Zz3Px9YW1KzluVKlzREn2UcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTfJLn6BbT6xVusjuQEIMCUBwWsazDd8sCdIg9cqew4=;
 b=pmiQLnh9DuVk2d7g0D+9Au2v4WnS3u51vQirQdrSrzsY88DqcErzbliHLsqZ9fzFIOEkrOI/XACbYL0JCoDjK9JGrx378psHJZ3MPBFo9jpfQZO9nSPDIwvRdYAtdWyrow/Uf8w9F1h5v4u3eo1UeAtzuEnOX7vvjj666Kta8UGThkyzWDqTG34IONV+4UUWjjkFcwFoMdhlaFmjlEDkVM1TRno4nttRCq4lV4u77Au+FNBtUkD2b7+vA3hGBfGHM45aEHLg9cDrB7NTZUNrpBlJB6Qd69jYD1HlSRofP62d4XuHVRRj0LKumBvafr1PJkDZtNybT7d/6Hczf2O3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTfJLn6BbT6xVusjuQEIMCUBwWsazDd8sCdIg9cqew4=;
 b=lI/SPnyRP3yg3Zy7Eo3r3qGSgqMnpwXxaCM6zanjgS9sUy4czNaRF2kLP8txCnxaRUdXdvfE63XjoKGVr7ti8vPeJVRf08Y3nBU5dtg5b7528HhtB1KnzM4+dGpqgwL0bLwPWSAIKAgon7PdsvnPcsMFUBQcFid3bwVtqipu9/4DzLuYNZLMcA+4wDLoVYqscRp37OjsLLM4e2ckdJevT3puGLgiujIvHDRLa1ROmaHQbVWBqqQbwDl8sVQ5KWRSsp92yUSV4ZlrMMPLPydoKe1ntvxXREx2bo1f0InBXNK9WRvrbbRG4ktKDk+/BYxJ5q/MnzeH3nX5/UshgJ14KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:06:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 08:06:24 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 18 Mar 2026 17:06:02 +0900
Subject: [PATCH 4/8] gpu: nova-core: convert GC6 registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-b4-nova-register-v1-4-22a358aa4c63@nvidia.com>
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
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
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0297.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: f32a290a-52ab-4887-253e-08de84c53f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AX/4fuCePCh/aibmkbvayu8kPhmf6Q7b8W+vbb2OpemUl6u17gUsCrECcyBeuqmk0FaZSJ+8nogQ/bKbVNLTgCFvYSemyJqz+CAtvDRUZEMYxLlCaOCASNfKac+4tDa9qg11FseYtZWPjnZY5vKT2rQ1lZRNIyNJdnPu4S99sFfrNg1EBwU6xzgM42g2jibty+z0zc2DRg0q4SqD49anOV1M0cbLX3y72I1HxRrpSFO5h5Sq7usm9OXq7a+fDDm0DQX1SOpseXWdMSzMjqrHHibazRlgYve5Zctacn+cSg7iGdjS53OZXd2z6Uc+i4HyJFnD0S8HjASSfz27wj9Bwv1Bl23w852WxcNx2/vYrmh8UonK1pmCM1B5RZN90XJ5EkUc9zP6T5djNnZNNqLbWU6DiZxSzYCgrrdq8RfLSD27Ne2PMzi0sCDN33zzWXbxwFtYNIyGiAMhlWkVMi+WWv+241rClW3BO3UfrHYDbunMPY/vuHNNBy/dM0uYCH3hhUA+BvMtBxfB9qdR6ZhKzSbD52X2ABFdskXOUSm4NaG9sy4hzr0sfVBjxFHRQ/ql3qWhg3pr92ab47b8voRwp/gNjr5URMLiUAbZZHXQpiW0GhK0e79N6hM2VIfh2Rv8rI6eZEnMjysnhPp48PVsZuwxF3/k+by0+aLog0zvHOyCls19PtNMSc/Ft88wkKBvpSF+u1P34FNTCb8jfrkpZg4zhXA378DbrRI1IKWSe5nHJLVPc2+7OcyCOVKpNdsmQxtnEQc9bcRGjTEz5zqYFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTJQc3VpU3lxVjM2bEh0SEI5Z1hwQzNuS0R5K1Q0bEhjMzJocUxKQUdlSDQw?=
 =?utf-8?B?N1RuOXA4aEFLSG40MzVvWE12Y1JpM0FKc0Y0UUxBNXpGZWkzaHNBL2U3RkpW?=
 =?utf-8?B?a25XL1JlNHpQTDZmdTQ1UFFHcVdDVHBjd1pKditlR3Bod3V5TjY0YjNlZEx3?=
 =?utf-8?B?ejV1cEx5MlZrcGRzek1aQXNacjhtMHNYYWs1YTl1L2dPbC9zcFJPQytvblVq?=
 =?utf-8?B?NHBnOGRmVTlDaXF1M0lDMTJWeFpaT25ka293OWIxazlGZ05nay9hcVFMZncw?=
 =?utf-8?B?em5IaGlWSEdBeG5nY3ZDeEhZZ2w4Q3lKM0JYVFIzVm9JYkhUSFZ5Q3VHSVNt?=
 =?utf-8?B?ODg5WGxBcmI1WkNFd1R0RDFQb0VWNTlTNDk5ZDc2WTdQZVI0QzBrcy9LOGg2?=
 =?utf-8?B?VGwrWGo3TTdGUDBPcXdDWWhYVkFlaDZpemlXSGgzTEdlREVEZGV1WEw3SzJx?=
 =?utf-8?B?VWs4WHNyVWdQei9mbWZFcWVna1QvRGxYZjRZZ2ZkTXduSjN1VmFjS1orUTlt?=
 =?utf-8?B?azJaZS82MWMvZEI3Y1VtM3dDL0U4aHJ0b21ldVVwZWtsWm9CdTE5UU9IdktW?=
 =?utf-8?B?OFk2ZVp1ZXhRQzJrMk1jb0treCs1MTBpS2hmMVJpdGYrbERjYkRZeUJMd1NW?=
 =?utf-8?B?SHNLREZ1ZDFIdzRka21qUk9wSUpSTi9vd3owOUZTUlc4OS9oRGJzMnBudWJ3?=
 =?utf-8?B?SlZsVzlxc3Y5Q0lWbFNWWXJBNzBueW5KV2VCQ1FyM2w2Y0t1MEY3cERDVy9D?=
 =?utf-8?B?TW54SWQveUU2MWJ2SGlUanBvQ0tDelAwVEorS3RLdUR6UmlaNkQ3NVg1aVFl?=
 =?utf-8?B?L21yM1V0OFUxa2pEY3hmS1JYYXdoUVF4RjU3QnE0TEVDd2NXaWVrWnorNG5r?=
 =?utf-8?B?MFNQSFJjalluT2x0em8wQVJwdTZGKy81d09IVlMwd1BKYTNxNys3UmxUTkYv?=
 =?utf-8?B?eURQSXZJRjNIa1pOZFRheWt5WHhucDdOR1gxcFI3MEJ2bVNpeTdKK1dscFJu?=
 =?utf-8?B?SGxBM2FNaWpIQ2E5KzFyNjBNY25QT2ZxTDg5RzR6S3FzT3lvK1p6WU94WnYx?=
 =?utf-8?B?WllHaUF2OUNNZjZlbHBlYnFnNHNFUmdFMXhyM3cvTWNmQS85WWhOc3NobVdN?=
 =?utf-8?B?eEEwbXUyWjJSYVVkSmptL21TUE9ZVU9mUXVkVkNJZUU0dzNZRXRMeU9VTkJ0?=
 =?utf-8?B?SUlqc1JsV01rQXlPSHFvd0d0c0czd3JHUVAvN3J6b3Q1bCszSk43NXRhVnRx?=
 =?utf-8?B?ZStRRnRLSHJ4M0ZpVnltbjNVV2drMTlUTW1jZ2ZqbHVoNi9GeUVRSVlaYnJw?=
 =?utf-8?B?V3BKZko0eGd0VVU0MTBhSmkzbDE4bjZBd0RWRTJyaHpvSVF2R0dMY0puTktr?=
 =?utf-8?B?RnJRQklEVUVtTzhWVjJGUWt2Ym12SC9sU3RVcWEzemQ1R3dhNzVqeFdubUdL?=
 =?utf-8?B?L0ZBenRqL3htOGl4Z3RwZkEyK3Y4KzB2RlgvQnB5TDlLZTBnaG5LODFJYUJt?=
 =?utf-8?B?VlZYeC9yMlY3Rm9JSW8xWlp4NW16OS9jQnVMM1hEaU5EYUVzc0tkaWtIM1h5?=
 =?utf-8?B?dUwrTlJid2ZEUFRvRFVVWnY2Z1ZubXBIV3U3TlI3YzdqaktZaVplNmwzcE00?=
 =?utf-8?B?cmxnMmZzdUd5RUpTdjNpNUVnRFVtUWRrNnN1eU5HSmpXRE1ha1BSQzJNaGRO?=
 =?utf-8?B?V0F1TEpJQUpaQ2NyQ2J5Um9nRm9sRlRyRVh2MlR4TTh3QU42ZXBpTGZER2Q0?=
 =?utf-8?B?VnNqOW9WZ3NkM2UwQ0ZualU1eVBUa01aSHlqZ3VuV04rK3RMbVR4R2svWll2?=
 =?utf-8?B?Lzg3SGVCV05RZ2FuN3Z1cURVQW4wNExwV1RiZVBOeU1OVWk2RzBBOXEyU1Vv?=
 =?utf-8?B?ZUN6cTlsWk1KZ3c2S3ZQL0o4MU54RmRabEJWOXI2MUFqMVNlVGZ6UWg2Qjhn?=
 =?utf-8?B?eTFnNExYWlpuY1F4OXpwYXRUVHZhM25jaE5Ra09IYTFFaDEyeGpSY0JicU5z?=
 =?utf-8?B?OXA2c252ZU9RVFFnK2dUaDYvN3JnUk56NndDdzNReXZXVU1PNUhVSFM5dG1q?=
 =?utf-8?B?Ny9sUWNmbldieTkvNGF3SEtXTVhPcS9hekV4T2JISGxpVmx2REVOeFl1YUJH?=
 =?utf-8?B?a0VDemRXalh0U080bVFZSmdVN0NwZjNlZE8yLzY5OEc0QldMaCtRSnpWSFlo?=
 =?utf-8?B?VnRZOGxaWG5UcmlOU0JNNWxiOTBZemYzbk9FV1p0YnpVMjJTS1NPZVdXd3Bl?=
 =?utf-8?B?Wm04TWs5d3BJSURKZXVKLzE2NTRnNzNKc3ZnMHJFS2tzUzJqRkozMFBocDdY?=
 =?utf-8?B?RFpkWVZBTmxLUzE0b2R4eGthbytRUXhQTVFubGp6RDVHeHppTlpFVnhJL2hC?=
 =?utf-8?Q?+hrW11H+u5IroBuC611zL+tO/mbxf4g6HdJjDTi0KLADJ?=
X-MS-Exchange-AntiSpam-MessageData-1: E95V4EFc5QYDZw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32a290a-52ab-4887-253e-08de84c53f98
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:06:24.5045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6ewSx95mxkTaQrsNcx6HAaNBWAktCIlQisevr1L0TCKfLr7H6OW/dVG/2kDhIb2Ep8SWAi5NfxFIbDuCRFy1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon/gsp.rs   |  7 ++--
 drivers/gpu/nova-core/fb/hal/ga102.rs |  7 ++--
 drivers/gpu/nova-core/gfw.rs          | 11 ++++--
 drivers/gpu/nova-core/regs.rs         | 64 ++++++++++++++++++-----------------
 4 files changed, 51 insertions(+), 38 deletions(-)

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
index 6e35240fb326..4439464aae4d 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -221,29 +221,30 @@ pub(crate) fn higher_bound(self) -> u64 {
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
+nv_reg! {
+    /// Boot Sequence Interface (BSI) register used to determine
+    /// if GSP reload/resume has completed during the boot process.
+    NV_PGC6_BSI_SECURE_SCRATCH_14 @ 0x001180f8 {
+        26:26   boot_stage_3_handoff => bool;
     }
-);
+
+    /// Privilege level mask register. It dictates whether the host CPU has privilege to access the
+    /// `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
+    NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128 {
+        /// Set after FWSEC lowers its protection level.
+        0:0     read_protection_level0 => bool;
+    }
+
+    /// OpenRM defines this as a register array, but doesn't specify its size and only uses its
+    /// first element. Be conservative until we know the actual size or need to use more registers.
+    NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[1] @ 0x00118234 {}
+
+    /// Scratch group 05 register 0 used as GFW boot progress indicator.
+    NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT => NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[0] {
+        /// Progress of GFW boot (0xff means completed).
+        7:0    progress;
+    }
+}
 
 impl NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT {
     /// Returns `true` if GFW boot is completed.
@@ -252,16 +253,17 @@ pub(crate) fn completed(self) -> bool {
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
+nv_reg! {
+    NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
+        31:0    value;
     }
-);
+
+    /// Scratch group 42 register used as framebuffer size.
+    NV_USABLE_FB_SIZE_IN_MB => NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 {
+        /// Usable framebuffer size, in megabytes.
+        31:0    value;
+    }
+}
 
 impl NV_USABLE_FB_SIZE_IN_MB {
     /// Returns the usable framebuffer size, in bytes.

-- 
2.53.0

