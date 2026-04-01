Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765161076382
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FE810E5F6;
	Wed,  1 Apr 2026 14:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IYgTz4DG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C350A10E5F6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 14:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHnJKmmYVf8F2lgtNCAL4Uti2d5TmNUSLJ7TlLB8/z21jIfNKik2LgcDfyGiioorciFWHJtP/HLfChwVR60p9s0EFqupm95DJQujhzl3OALkkLmVDcNLD6y4FRnWK13DjKkcCUrcFNiiR1ObrUlbCti/xlwh+fgB12OL7WardA1sPfZzg2lYJnaN+GbW+rMaxVrMHt8X96j5UG4Sq75pcpO52ZTxHRI3Yh2x7Q96aROWPUFD+1s8XSunFwlXS0UW6ToxQsQtV+LnO8cdeOTWS+hgUn0yHnhfjGFU+8wByX/r/I4OEyDJbXtL80zQKebC4nt2Z9JaKTt2zzSL5gffuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JCHy4pystE32tJ78s97oMmIQ5CUqgpNhSi/BgnX77Y=;
 b=tJvvYxuxDEG9a/kzE0IBW6YboMLPkHzhv/2LXJIRLp036rjKQSr7hny1Bg/4XbDz3shhLNacAZVJuTJSKkuKMihPnHEPyCIrG5Lg+wW58l4HSLWUxLySHTUuMe4aFy/CAYvEucP2hq3gon7r8JCvQuNYMGrNtlnv3S3kwaFGVJX4ClHW1TzHPo8/6Dlp5OHEQ4UxXF1Xb+TRkVGulc7V6tJGYoMhvokkgnTauvb8PGEeew+IsmyTnBlhHI+hu0vVuul/oggIKajCyozjHESTyeDyp2NDjhHAvqC+rdFF+JXinsZlvrB6TznM8zdaV0ORDvz2k46FsbrQ+C0QcKkoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JCHy4pystE32tJ78s97oMmIQ5CUqgpNhSi/BgnX77Y=;
 b=IYgTz4DGSQsxeEJQL+5UAIwcUwe3j2Mvbs3x8LYCGmcTX/w7Ugl5jZ4h+iU5EqPNTaiJayehNXpuBdJlzCcnxGfuHK4HAtT1gWaS6LdZlUlYDkeYTAW01MzdfOlmIMwAr5tYSO7Ayw2aaNOmdCZsiwHvkMFHyeYhgzoPgz7SD8fNDwghdG2XBtIjaqyCDVU0qJYBwrRvQ+ugDPm2+ajaYCuttLb622zieSJdtP+/8mnNYnpT73bGM+os9vfe8cLS9aJQezJDGwSdYJlXOAAvZfbCLkoVqaCjAsyosWD+2HZjmcnCS+FfKjMEo2bFJqNKkwKbRiJaV+45zAR54ie7fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS1PR12MB999188.namprd12.prod.outlook.com (2603:10b6:8:495::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 14:30:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 14:30:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 01 Apr 2026 23:29:50 +0900
Subject: [PATCH v4 1/2] gpu: nova-core: gsp: inline methods providing queue
 range invariants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-cmdq-ub-fix-v4-1-a9a9cf982485@nvidia.com>
References: <20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com>
In-Reply-To: <20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TY4P286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS1PR12MB999188:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7ffaf8-4d40-4f18-9a06-08de8ffb2962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: YbYxmlNfODABterfFavHuATjXG2ezF9y3TpxktfzIgwd1u7pXYfiTXo+zzckK4fKrFju7ZFAgHyLzVlZmzs07VkOzzQI56ye7wirqBDYZQP8Fg97pYFC720ygjGdkq32oRTo66OlqUTPEjwAbLJm7bN0Ztqrm8Q/KLrdxTt6vhpl2smYaI/EZcGs6TmIsVjK2T06rl811YeXOsYA84RMUv7YaSh+vMaTkkdqBIk/5nd3ybL5tv4dqUzSooogtfcyolJDIQnRIyHi3hxoWthh4pHH2nO8aMwINGd8JDPlKfgygUd4gmwWufWy7qxMwGVzCpkAq3Uz6ezqAfcFgQO/YUE7N+GQaDLyoVy73PCnO+VmPcSmcCByduLbe4dTXptupVmjDbVbbDoeCyNM+Nfx19CuXgwCvICJZH0czKs12HBDDhlgc+D5uq9HUwbzzqVshFAhnT4Q9ORFvxCBvwrZmWjyLjQqPeLCKw80W1DlDzMueIF/fHl+MncWp5pML0kO9z6p9+BTCqCtHhDG+Oq6cmPaaSdh+/XavM6h17GafhASOgu+6CACVvQ8g3fSoJFX65Csa6zX/y0Y7I3PL3eHXn4A9HVG9oVgG1+ZnJjLuuFk1KHHernId7EvCEknzo6J54M7aeBKXMl1KLPc65EE0X/zXnufNbhmFv/H2+TyJP6YPvdCbISUVhgxrraTHZXgJu/Ot4jGofiMVXgTKT9y+m6VGhCVdc0vAJs05ORVNI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXM4N3NIRHFycEJxSGdPSWxFQlVETEs3N2ZDNFJtem55L1lhUHQ5elVzbFZL?=
 =?utf-8?B?Rk1nV2JURnBsNmRnOGFPamZmTWdEQnJmYTdLaE9iSGtGOHNwVzMzcnArclYv?=
 =?utf-8?B?bHpOcE1UNStwRGZ6aTBSWjdVbzJCSGhOMmFzcWtsajBmTHhlVjJteUQ0R2lX?=
 =?utf-8?B?bi8vV3h0cXVPb1g1OVRnKzcxZk9UVnNLTzF2bzBSOE0xcWFMd1VwT1gwN0lT?=
 =?utf-8?B?WTczbmxrSW4ySW5UV1habzJwczRTc1BGbzQvMVlSVFd2NG9GTXhWNnZ3RFFU?=
 =?utf-8?B?aHk3NHdLTWlrK3U4MzdrSFhpdVpUdFN3b2JIdk45ZVZmYXVSMDdRWXFyWEVo?=
 =?utf-8?B?Z2xZZVZmMFNZOWRkWUJ5Nzd0Z0dmNi9QMmZzSmdyTnV0NVZGOTJyK3FjY2p2?=
 =?utf-8?B?cHBmQnYrbHRjbkxRbnBEM3VoUk9lb0ZyOTFXdTBLRlJBdERMOGtWQ2xyVTdx?=
 =?utf-8?B?bERvbTdJeXlSOWVxTFhiNnpPZzNKekpxZnVyM05UQXl5SVliSjF6d0ZZMGRJ?=
 =?utf-8?B?WHJDdkRuMllnUi9DYVhFTHA2clZHZ21VT3krM1RQdFo3UWwySm5YYXJhNnF6?=
 =?utf-8?B?UzNVUWFCNjM5c2FkNlZoS0xvckVHQ3lnTHJhTTh6SFJWY1RkRkJ1aHlaVHNH?=
 =?utf-8?B?L3JxeGdKb2Qzd1VBdHd5NDcrVHNFYVUzZlFGN050bklrZkZKRitOSjJBY2J3?=
 =?utf-8?B?YkhId21ENTQ5YXliSnRQZDhJRm0vaTRvRXFRYUlIUng5dDgvWXcrZm9hRDN6?=
 =?utf-8?B?YTdyaGpxWXVTMHFlY3JMNmI5ZWVpMVBJQWl0RHJmcytmUmpUY3k4VTJUMlcw?=
 =?utf-8?B?TThxNHF5K0pxL1JLNUp0SFMxT25mQzlWQVloVER4Z2V2KzZPMGIzMkpMUFZy?=
 =?utf-8?B?NlpaL3RtUFdaOEtLVnFDKytsckc0MWV3YlFXVWIzVGpnYkIvUWJ4L0tRUHhH?=
 =?utf-8?B?a3k3YXcwOEgvNUdyMlowY0UyOTQ0WnhvV3B3QnVvVEd0ZkFMM2F2VU84OUJz?=
 =?utf-8?B?WnJxQXpNN2ZDdW9BbUhnT25SbzVPeDR5V0M0dTFlbS8vS2VzWDlEd2RZcmti?=
 =?utf-8?B?Vk0xcm5GenBBQ2ZLZzd1S1FPcExOdTEzamduNk5lUEg0WERvTzVZLzl5TENI?=
 =?utf-8?B?dEN1ZFFVcW0zZ3hnQWFQYW1OQTVIQXk5UDU1RkR5TGxwOE1lSyt3NE9mU1Np?=
 =?utf-8?B?VEM2WHNPS01RdjBaUUJHbHNmK2YwaWlISE9LVjlvYXNXcFhXL1ZJOEVMSzVs?=
 =?utf-8?B?cHQ3V1VFckdrK1lERzdiUFRoUU16U0xRRzVDNUhyMEd4RDNwT3U0M01jb01H?=
 =?utf-8?B?WjYwdXdNR05Yd2hFWVVvSGtNTFMzWUk4VFp5enlZb0E5SEFSUVQ5b253Mmxo?=
 =?utf-8?B?dENsNUJqWnQvc1Rzb2ZrbDBMQWxlZXhObU5kaHFpcytENDl2bFBsRGJPYXVj?=
 =?utf-8?B?SnoxaElLVXB3bDhIeDVBKytjZjdiVmZ4TkdkeDI4Wng0VkdDdlB3SmtIOFd2?=
 =?utf-8?B?N2psLzRhTUFLV0h0Q1dmbUpoVElxRU1sZHM0bUZNM0Nub2hZMWxpUThidkV3?=
 =?utf-8?B?LzUyN3VjcytIN1VJMGcxckE3dUtJZCtrL3Q2cFVwUkdIUjJTd1c1TitWMDcz?=
 =?utf-8?B?bDloWjk2R0VlM0MyN29tN1VaUFM0MGhmdEd5TXh6cEF3VzNHYlFYbGhEaGZl?=
 =?utf-8?B?dkZoRG14SVowYmJCOGZuSnI5bHJQZHVKZlhmQmlQSUFmaVZCWDZrb25TZDkv?=
 =?utf-8?B?SVVVNVpBZ2F3VEsvaXFxWEU0TDVGMk53WEVGQ1ZrQ2hQZzVxWGVSQ0VxYTVJ?=
 =?utf-8?B?S09sckdpdjhIMGZZdk9VK0lHaE1qdjhaNndBOU5JT3Jpd25qamlXMFRwSCtV?=
 =?utf-8?B?MURYVFRYVnNkaFNpY1lxVWY3KzczREtXajlNUFNyR3BsVmp0Q2FoRlh6enh1?=
 =?utf-8?B?ZXBOblpCQlNLQW9jOXNBS2VITnhvQ1pFTGM1ZUFEQVQrRCtDVlYvajRPanMr?=
 =?utf-8?B?WkthQjFva2lnVE1KOWpHRm93VStidzdFNHhCL2k0WG56MUhveWsyVmxTN3ZL?=
 =?utf-8?B?N2ZCOGtJMlhmUTlGUWI4QkQ4YkNBamc0N2RpNGV5ZDVDOTJxKzJCRjJ6RFhS?=
 =?utf-8?B?Y2tIR0hCY3k0Zi95OC9aZDVXSjRtZWoyRlNJQWQ3ZTkwd2MyU1RXWEdTM2RD?=
 =?utf-8?B?Y3lSWFV3anEvRFh6QklMYjRMMmtpaEZDQmJoK3RJMnZoRE8raEtyM3ZRak5p?=
 =?utf-8?B?ZmZ2QTZMamtGNGtRdS9HQzYybnYvV0pTNVB2Qi9ZR3EzcGJnNDRuZzNMMk5N?=
 =?utf-8?B?ZzVwN01MV1ZLWFRpWDJXdjY1cDRvZkRXa0lqSFBYYngrRlVMYmQ1cktobmwr?=
 =?utf-8?Q?2ixblwl/ipkNYijLUepM+/Pt3wQITHTBeGJTbB3cqrXoT?=
X-MS-Exchange-AntiSpam-MessageData-1: o6YsJ24Saz24Ow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7ffaf8-4d40-4f18-9a06-08de8ffb2962
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:30:02.8312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87PwDmV6blw+RGqWavcM/OXCbnaO1XUCtGr7NUQvJ7eI9iw75l8lJzQYK/SqeIZrmp3V6LoQSms5rdp4zOTasA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999188
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

These methods hold a range invariant for the read/write pointers
(namely, that the pointers are always in the `0..MSGQ_NUM_PAGES` range).

The calling code depends on these invariants to build properly, so make
them `#[inline(always)]` to ensure that they are propagated where they
need to be.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 4 ++++
 drivers/gpu/nova-core/gsp/fw.rs   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 2224896ccc89..72e9b79619eb 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -384,6 +384,7 @@ fn allocate_command(&mut self, size: usize, timeout: Delta) -> Result<GspCommand
     // # Invariants
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
+    #[inline(always)]
     fn gsp_write_ptr(&self) -> u32 {
         super::fw::gsp_mem::gsp_write_ptr(&self.0)
     }
@@ -393,6 +394,7 @@ fn gsp_write_ptr(&self) -> u32 {
     // # Invariants
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
+    #[inline(always)]
     fn gsp_read_ptr(&self) -> u32 {
         super::fw::gsp_mem::gsp_read_ptr(&self.0)
     }
@@ -402,6 +404,7 @@ fn gsp_read_ptr(&self) -> u32 {
     // # Invariants
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
+    #[inline(always)]
     fn cpu_read_ptr(&self) -> u32 {
         super::fw::gsp_mem::cpu_read_ptr(&self.0)
     }
@@ -416,6 +419,7 @@ fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
     // # Invariants
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
+    #[inline(always)]
     fn cpu_write_ptr(&self) -> u32 {
         super::fw::gsp_mem::cpu_write_ptr(&self.0)
     }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 0c8a74f0e8ac..e2c0e9bf310e 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -58,14 +58,17 @@ pub(super) mod gsp_mem {
         MSGQ_NUM_PAGES, //
     };
 
+    #[inline(always)]
     pub(in crate::gsp) fn gsp_write_ptr(qs: &Coherent<GspMem>) -> u32 {
         dma_read!(qs, .gspq.tx.0.writePtr) % MSGQ_NUM_PAGES
     }
 
+    #[inline(always)]
     pub(in crate::gsp) fn gsp_read_ptr(qs: &Coherent<GspMem>) -> u32 {
         dma_read!(qs, .gspq.rx.0.readPtr) % MSGQ_NUM_PAGES
     }
 
+    #[inline(always)]
     pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
         dma_read!(qs, .cpuq.rx.0.readPtr) % MSGQ_NUM_PAGES
     }
@@ -79,6 +82,7 @@ pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, count: u32) {
         dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
     }
 
+    #[inline(always)]
     pub(in crate::gsp) fn cpu_write_ptr(qs: &Coherent<GspMem>) -> u32 {
         dma_read!(qs, .cpuq.tx.0.writePtr) % MSGQ_NUM_PAGES
     }

-- 
2.53.0

