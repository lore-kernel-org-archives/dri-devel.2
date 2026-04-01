Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B24107637F
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AD910EA33;
	Wed,  1 Apr 2026 14:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fOP/oOu9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0907210EA33
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 14:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvRbkcCDVPFnaxUZApinNylvwtjFqjXisvjZlT9mNnZm9gmA97qQsjc6r9RF+qYFbJKmHU/3FuVypfJIwawnm+i3uiKQWYSyvj5+Rxw/ERpf5p4LZF2ReJfBWvEHlC9Fs01OA6x4rTKQcIvgtoggc395O0tTbi5ktqpjHFVwk1RU9EJCx+RFRvB4kbBumw0pt+LgAPhJRJmekAnMKpMKPuRta91iOVhmZT+uOCyEOgb1u6dgR8FYrdTAsgwdBR/8/cLv7V7niVbdA9jOn6bkpjbgLFuqxtH3a86hb4oUW5CXljXLZqNSE8wVlxSunh3jXyCSl45cQjORJz65dYK6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjfB3y/Ru5XELhK3MQHlxkRUcIg3hSC40b6tlkaiqO4=;
 b=UXfqaYjjxffX5ibZpDOVEM2GhIwqeM2kYJI8/kyjsm4FSjrXNuP2WmOJn19Kll09nwYRi1laDYpyGQiRfEiKRdGECYFJLD8DaVIKKel66ZXbtp7fA9STOjyXa+pOTrE2cCt/WuJFbXpIDfn8ikyw72k9NHwPj9sfpNuPS2XbUlGnN0CTKzz96k04AkMcI+2Ej6BxCxQl1K/zCYKthloECUWWbVfsTUgY+uD/Cp5ys6dcr/+c9u4IAHOqlSgVYT5NzvKZc8IIvm+oFHnlXsr846HjxFHhoHRqEgMl0PT/clredRk28AdPEoYRvbH9xazBB1KelQGrPG6mB8QPj2LNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjfB3y/Ru5XELhK3MQHlxkRUcIg3hSC40b6tlkaiqO4=;
 b=fOP/oOu9u7NGubdxgPd7pudq2cfxKbvAvIrVWn1E1/XpN2imBSgnFC872AVUy5KpYAMKlmsSUUbrJILVgdxjMY5gL8mpztMD/zQ4Ak8I1bjHnFeF6heAE9jd+OcyRKWrNkJXnylwlrthexzxgbNpzFbSPuBs2RxGWZEsYVsp/8F8Txbfhspdigocw646v0m0qC3LJDlVI5CZqPr0GkBDF/akgAEZwXHtty3i2GYMCCkE2plPEliCt2Ja451dk5TOqi0v8dOOJvSgn1IdSwDqfHKIfoVMFeH/5Il1YfRmw3DCKZMj/5SYt7QR+g7+5J1usZkWqgiSyUomXNmujcQk/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS1PR12MB999188.namprd12.prod.outlook.com (2603:10b6:8:495::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 14:30:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 14:30:06 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 01 Apr 2026 23:29:51 +0900
Subject: [PATCH v4 2/2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-cmdq-ub-fix-v4-2-a9a9cf982485@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0063.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS1PR12MB999188:EE_
X-MS-Office365-Filtering-Correlation-Id: d875a02b-fbf2-415d-ac3b-08de8ffb2b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: uu9v4Z2qX8h26ZWXg1XbMw+Nmy4OWw+/p/HwZR51bEbkhhF2w1N/jK3gPLO6V2FGSJK9zXRwHlDzHE6lbR2PYJMHynGZNYjh1vojHXEStqHO1GFcbWcVRTnCV5EkKoj9dtm6WQx+c4UgTkPcun/wcsZw8QHQw0z19rKkFFw72HoJqAqS36NvYXFjP/2S5oCUWwl5vPziOlFrje9DmY3YXc9zl0stpCmVxjyoUcnjsnjU8Jy59BLru65fr+TiFn8xV2kJyLq1qtjfVngCtXhaVZb5+oJ3pN1fK6jF3IL1vYB06pkNJB0lIRjCveR3QKuaaw9oDNPZb9gjJGj4a2lvStXirIiXnpd3ujtiwfrTcFMYigamGnnsWnMM5N1aJxVs1XiNZrL4RJEmmK/qAoyPG2VQV6GpQR2dButuseN0QDu6s7EATHAxGM/3sOOuZRFEOUxbWKsJFR9+mIhEmJzso7pZpvLdy6cHozP9R5+n/2ltX1BpGbgrHbk2QZuTGhLhfQ02wv/PbcmjYZCl7JmqzAs37kopmMkwCMy7wJeouxJAR+Z03zjQIGszco3kVscNvQde9Qi9F6nLr1tmqEWOHeDDPlcVMnsjJ2O69DkeRaKi9lMOskximX1tSVA1c+zC/VKNsbl7P3KgVXmAZxbX9Dq+fWOxFd+kuOyyw3xz3VIo63jGOznv7/Ew63W/6dzN0KysVEIn2UC2ygfS2+XZF6LUvQQsOY17Z9Bu+zty/WU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxoemd1S3ZTZkN5MnNXRFk2Uk0xL3BkeDJYRk1Qdk8wa0h4ZTlGUE9lYmN5?=
 =?utf-8?B?akRrSlp4MDlnVXVpdHlaQVZlMXhOWCtxTTJMeU5PSWJRQy8vbU94cGlRbDQ3?=
 =?utf-8?B?TEVWUWVNNmpNMmpod0x6eXJqbnVEeVF0Zk5UOXg1UXhaL2lGdFAzdERzUnRR?=
 =?utf-8?B?OXZSWVRDNkwrZXg5ditacnFtZHB2Sm56WTRzeUpMbGJ0dzhNTWpQRTk4T2o3?=
 =?utf-8?B?M3lOYXFvczRSU3RQMTQwMFFSZ2pkVVRpSlBYNWNpbE9RMkt6bDk1VUdhTkFn?=
 =?utf-8?B?dDRjK0xFZERhbWNKSzNOZVpWU3Nib040bW9TWlFSem1nWGM0bDRNNFQ4L2Nz?=
 =?utf-8?B?NUNFYjFoRjhPQ2pJRE1NODFsYjJSMGR0OU9vUEZCSGxNZUNZaDVXb0VxZ09a?=
 =?utf-8?B?WjliWHdHc29jb1E3TnFkeHUzWFBtRHAyZHdBZkdBdDg0NDZ5aGZwdW9hWW5w?=
 =?utf-8?B?K212ZHl5aGFsRGxZbXoyUWpnODU3UEc2NHB3cjRpZ2U1clVYZUI0Z3NrZWVS?=
 =?utf-8?B?UmNUcm40NTFQS0cxUmd0eDRxTGhpWTJLZCtNUEptZ2NJNTUzTzB6V1YwWnpi?=
 =?utf-8?B?UExsb1RycGhpRGxNenlXdTdNcFdISXAxeWhtYmxFSWhxbW11dlFoNWc2cTV4?=
 =?utf-8?B?bUNYNldSV0VWTnNWcUI0NE84UFBnUkpRN0J0TDRqVEhqeVlUQStlVTJlTFB0?=
 =?utf-8?B?NTBzd0h6WWN0ZU42UVJqZTh1elJlYyt3aGdLSkNlV0FIYzY5dDdZcWZuUDU2?=
 =?utf-8?B?Uldza3g2UGFLVkt3dEFZaGdGUExHN1ZFKzd4bUNTWlduR200T0g0UDgwQWVG?=
 =?utf-8?B?ckRiT2pjSjgzUTJpR3A3aWtxaVk5UzBWeW4relJoZS9aUGNGelFKbW5ZS1E0?=
 =?utf-8?B?SFpjVEpiZDVSa1BRakluZTlpc1JSUEY4WHJ3QmlrQkN6TUdxeDZrbGltVGRN?=
 =?utf-8?B?OUI1dTlYNmc4WUg5b3RvVnpYbVRHMjdLbFNBc2ZHTkJyZ3Vha0xlY3hZclVD?=
 =?utf-8?B?OGNCRzRvSUIrMFd2V0FGaW5yWG1jUmVPZktaZ1R4SktFMWN5SFNSQS9OeUlx?=
 =?utf-8?B?L3lpN3VNeHl3WVpxNTVzMklPYnhSNjdiNzNYYkphdHJwU0o4cmJiTGFiRU41?=
 =?utf-8?B?YlJGeVZFUFJXR1UxYkRwNHFBWlFQQ09KYy8yRG5tS2tTOEczOGFiSWcrQ1Jj?=
 =?utf-8?B?VW8xcEFaeFNmc3dTQWF6RFgrVnNOTGtLMEhhS24yc0k2ZWxSdEl3NjlKeDZs?=
 =?utf-8?B?RXhhMk96TFhxb1YrVFBGajhvenA1ZHc3QitaampKcVBLaTZjRVB3WHRGaWlx?=
 =?utf-8?B?MHlxUTdtTjArWGVVa1BmQnVMN0t1eWdhY3ArN25hMitGQm1PaENGaFJOQ3B1?=
 =?utf-8?B?QUR5VDRFdFg0SlEzRHRIZDh4MzFyWW1aV2I5QUI0SEU2RlRRT29zeit3UzdF?=
 =?utf-8?B?M05lbGRRL1RSRDFpeXRvc0hOOWFWczZMK3lUNkZnb2p6VUpBR1V3c29IYVNy?=
 =?utf-8?B?OEM1cFUrNk50RWkrQ08wbWtPVWkyWnFoQVQrN3pnbGFSUEgwN2VwVFU2VUhF?=
 =?utf-8?B?OW5WRFZsclRBaElENjJRZEhjUjNsN3h6eTRWNzFPUzNiaWdldEFtL3RzYk1h?=
 =?utf-8?B?WEJubDlLRElPOTZJY0pTa1VmUzh3R250bHpmVXBMUjNaRE5vRkNWWVNIMWdu?=
 =?utf-8?B?R2JrNzd2UlFwWEVoYmNBSVVEVnMxTXpJOTY2MktzUXJHTWduYnYrRENXMWdK?=
 =?utf-8?B?RS9Zd0J2aDNaNGs5RFdhYzc4SU0rcUVxSWxMcmo4a1crUitBTURXRXVlZXJV?=
 =?utf-8?B?SWVlV2RQdWp1Y253UUJCdGJHOVNjSlVRVnpMRmtpd3VkOXV6SG5uWnJzYVpk?=
 =?utf-8?B?c1BPOC9CVlg3QnNDU0RaQjZDdE5qYXE1bnZTMitWZHFiT1JKbk5nVXh3L2Ra?=
 =?utf-8?B?OGZFbzNkNjhwUE1NRHNkMmh3NS80ZnpvUHRONDUzR3VEV3g0SUxudnhHNmZw?=
 =?utf-8?B?RnhRTUlGemEwY3FqeWhFdU45bDlSbmNzMXVzd1BJbUNCcTgyQi9yUkFqY2JN?=
 =?utf-8?B?Yk96eWNXOE44d3VVcFNscFlOdDNCRyttOFA5SmtyTklmcDdRSXpwNEZDb2h1?=
 =?utf-8?B?bVo5enlDdHhYWGk5RE9xWnVxYWl6R0haSUQvUzkrUENrNHhyOFBDWDYxR01X?=
 =?utf-8?B?Q3A2b1lxOGlDSTlFS1g1ZUd5YTVJaXpKZnhIVkNreC9wY0trK1FpY2hRYXBW?=
 =?utf-8?B?WHdyKzFobUp0YWhxMjIzODlJbDFmTWNWMXY1R0lZcmlwMnJaWGVvVG9sYzBq?=
 =?utf-8?B?WFp1SmRVeUptRXAxak53RG5sRVN4SXFwdzQ0M291UmZqUFI0c1RLb3k1dm9l?=
 =?utf-8?Q?z299LRDfCWsMCyqknTjJXBaCdFK/s80stmK2K6NWkWLzY?=
X-MS-Exchange-AntiSpam-MessageData-1: /N41OxC6dPCsOA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d875a02b-fbf2-415d-ac3b-08de8ffb2b86
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:30:06.4528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5ykD1NKhilM0u79fJCUhOqMyn5oNKoArpylhmW31ddW/xOFnagfLbiq4bTmBMhZdUqeM4LaKRlnX7QFIdbRZQ==
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

`driver_read_area` and `driver_write_area` are internal methods that
return slices containing the area of the command queue buffer that the
driver has exclusive read or write access, respectively.

While their returned value is correct and safe to use, internally they
temporarily create a reference to the whole command-buffer slice,
including GSP-owned regions. These regions can change without notice,
and thus creating a slice to them, even if never accessed, is undefined
behavior.

Fix this by rewriting these methods to use pointer projections in order
to create slices to valid regions only. It should eventually be replaced
by `IoView` and `IoSlice` once they land.

Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings and handling")
Reported-by: Danilo Krummrich <dakr@kernel.org>
Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 114 ++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 72e9b79619eb..485d0c0f2a4b 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -17,6 +17,7 @@
     },
     new_mutex,
     prelude::*,
+    ptr,
     sync::{
         aref::ARef,
         Mutex, //
@@ -255,38 +256,52 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mut [[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.cpu_write_ptr() as usize;
-        let rx = self.gsp_read_ptr() as usize;
+        let tx = num::u32_as_usize(self.cpu_write_ptr());
+        let rx = num::u32_as_usize(self.gsp_read_ptr());
+
+        // Command queue data.
+        let data = ptr::project!(mut self.0.as_mut_ptr(), .cpuq.msgq.data);
+
+        let (tail_slice, wrap_slice) = if rx == 0 {
+            // The write area is non-wrapping, and stops at the second-to-last entry of the command
+            // queue (to leave the last one empty).
+            (
+                ptr::project!(mut data, [tx..num::u32_as_usize(MSGQ_NUM_PAGES) - 1]),
+                ptr::project!(mut data, [..0]),
+            )
+        } else {
+            // Leave an empty slot before `rx`.
+            let end = rx - 1;
+
+            if rx <= tx {
+                // The write area wraps and continues until `end`.
+                (
+                    ptr::project!(mut data, [tx..]),
+                    ptr::project!(mut data, [..end]),
+                )
+            } else {
+                // The write area doesn't wrap and stops at `end`.
+                (
+                    ptr::project!(mut data, [tx..end]),
+                    ptr::project!(mut data, [..0]),
+                )
+            }
+        };
 
         // SAFETY:
-        // - We will only access the driver-owned part of the shared memory.
-        // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = unsafe { &mut *self.0.as_mut() };
-        // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ_NUM_PAGES`.
-        let (before_tx, after_tx) = gsp_mem.cpuq.msgq.data.split_at_mut(tx);
-
-        // The area starting at `tx` and ending at `rx - 2` modulo MSGQ_NUM_PAGES, inclusive,
-        // belongs to the driver for writing.
-
-        if rx == 0 {
-            // Since `rx` is zero, leave an empty slot at end of the buffer.
-            let last = after_tx.len() - 1;
-            (&mut after_tx[..last], &mut [])
-        } else if rx <= tx {
-            // The area is discontiguous and we leave an empty slot before `rx`.
-            // PANIC:
-            // - The index `rx - 1` is non-negative because `rx != 0` in this branch.
-            // - The index does not exceed `before_tx.len()` (which equals `tx`) because
-            //   `rx <= tx` in this branch.
-            (after_tx, &mut before_tx[..(rx - 1)])
-        } else {
-            // The area is contiguous and we leave an empty slot before `rx`.
-            // PANIC:
-            // - The index `rx - tx - 1` is non-negative because `rx > tx` in this branch.
-            // - The index does not exceed `after_tx.len()` (which is `MSGQ_NUM_PAGES - tx`)
-            //   because `rx < MSGQ_NUM_PAGES` by the `gsp_read_ptr` invariant.
-            (&mut after_tx[..(rx - tx - 1)], &mut [])
-        }
+        // - Since `data` was created from a valid pointer, both `tail_slice` and `wrap_slice` are
+        //   pointers to valid arrays.
+        // - The area starting at `tx` and ending at `rx - 2` modulo `MSGQ_NUM_PAGES`,
+        //   inclusive, belongs to the driver for writing and is not accessed concurrently by
+        //   the GSP.
+        // - The caller holds a reference to `self` for as long as the returned slices are live,
+        //   meaning the CPU write pointer cannot be advanced and thus that the returned area
+        //   remains exclusive to the CPU for the duration of the slices.
+        // - `tail_slice` and `wrap_slice` point to non-overlapping sub-ranges of `data` in all
+        //   branches (in the `rx <= tx` case, `wrap_slice` ends at `rx - 1` which is strictly less
+        //   than `tx` where `tail_slice` starts; in the other cases `wrap_slice` is empty), so
+        //   creating two `&mut` references from them does not violate aliasing rules.
+        (unsafe { &mut *tail_slice }, unsafe { &mut *wrap_slice })
     }
 
     /// Returns the size of the region of the CPU message queue that the driver is currently allowed
@@ -308,27 +323,28 @@ fn driver_write_area_size(&self) -> usize {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_read_area(&self) -> (&[[u8; GSP_PAGE_SIZE]], &[[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.gsp_write_ptr() as usize;
-        let rx = self.cpu_read_ptr() as usize;
+        let tx = num::u32_as_usize(self.gsp_write_ptr());
+        let rx = num::u32_as_usize(self.cpu_read_ptr());
+
+        // Message queue data.
+        let data = ptr::project!(self.0.as_ptr(), .gspq.msgq.data);
+
+        let (tail_slice, wrap_slice) = if rx <= tx {
+            (ptr::project!(data, [rx..tx]), ptr::project!(data, [..0]))
+        } else {
+            (ptr::project!(data, [rx..]), ptr::project!(data, [..tx]))
+        };
 
         // SAFETY:
-        // - We will only access the driver-owned part of the shared memory.
-        // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = unsafe { &*self.0.as_ptr() };
-        let data = &gsp_mem.gspq.msgq.data;
-
-        // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_NUM_PAGES, inclusive,
-        // belongs to the driver for reading.
-        // PANIC:
-        // - per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`
-        // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
-        if rx <= tx {
-            // The area is contiguous.
-            (&data[rx..tx], &[])
-        } else {
-            // The area is discontiguous.
-            (&data[rx..], &data[..tx])
-        }
+        // - Since `data` was created from a valid pointer, both `tail_slice` and `wrap_slice` are
+        //   pointers to valid arrays.
+        // - The area starting at `rx` and ending at `tx - 1` modulo `MSGQ_NUM_PAGES`,
+        //   inclusive, belongs to the driver for reading and is not accessed concurrently by
+        //   the GSP.
+        // - The caller holds a reference to `self` for as long as the returned slices are live,
+        //   meaning the CPU read pointer cannot be advanced and thus that the returned area
+        //   remains exclusive to the CPU for the duration of the slices.
+        (unsafe { &*tail_slice }, unsafe { &*wrap_slice })
     }
 
     /// Allocates a region on the command queue that is large enough to send a command of `size`

-- 
2.53.0

