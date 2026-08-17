Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A371AC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0415C10E691;
	Mon, 17 Aug 2026 07:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="csHD6pP5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C5F10E691
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESIr6s5SrDdeYqkbvnyx6Msw18CWyR4fKKjEaG8H94DFi2zKVI544n4+VFYxEgrNiLwlllSFC0SUWuJzDrV63LjpDF3qqoOSeRrcRDEhyp7iSYphb3BYrzzE7219DAqBNAGH80GIFWDn0+Fi1tyHxMh18lZcv4JZlFR40TWhb8GX0qjIHhCkZDpkiyZgStouU/ZYrkMue5p0R4VPmzGLSnyCMhYEqBsMTKudEZIOVsns2MfQSiZS3mIJQu9KXDVC8zb8Fz6np713oUqyMjyZ48bs5/OUHR1+VmteqxuKt6iMqAVHQbh+23nQNjWsYo9iiL6Ieyg0O8uDvRe87Dfwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf4inSY+RB0lfRXpJU2uJKpcdM/pReKphGzIA5sDc8k=;
 b=XsuQC7untDLQ5HuVYDxpBGOlVaLNKZ8d9P6FA29q/smjsm1+9taQtRWW29bJW+WWpNhE039UUeGR9yn2ItAUYtn6b2ogrEm/VrlZSYa6+7xkgblNkkudxliQPBgX5L4b5/gtUvwlDF8P+ChBlAGqjm9ermQar2UFmYbut84+UBO0mf7vEvTnU4XOEBu7e84EOl0q1WrnES8lVHnHw/LHstvjYEMcTHP3QFNveutJ+03DT04dhU3imPkrsdeSwu2slrSdh1qUdqU0mNSHvMRnKZPZgz45FS3vTS6DGTPcraA4buQEtD/muI3D85lelmV+ypbXsKqhsXjt5lcWfnUlwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf4inSY+RB0lfRXpJU2uJKpcdM/pReKphGzIA5sDc8k=;
 b=csHD6pP5r3jM/2BCB++8vKrpGFyL+xKkgrPUQ4TgMPE2VBu8Ejw9f7o+4/awsBuo0bpSNTS6sIymYAyZQm8uOhRE+aY/I+qKnScT6tBDdRNKMz4EPdCtqIrWb8qjdidxiP/EtdmOL71JWbk2oQt1t3ZcNQbKY4i4YGi/3/AF5Gp8YO1qxqEwmbMwwoRX3Vmq44faRnnrB5m6p70J7oAUCoZjqy1XGevPicA9tr0GVcp0JElMYD7KUPi7LVudis71r/beo5o9ABwtaNgNmwYI6YnEC1zldoJzWLvjFTQI6dkkjOQ4if4uGfwBKZUBe8usl66Ov04PX13D9/m+SY3aZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:04:51 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:04:51 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 16:04:21 +0900
Subject: [PATCH v7 07/10] rust: id_pool: add contiguous ID reservation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-chid-v7-7-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P301CA0015.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 144a2a7b-103d-41b3-7f1c-08defc2dd4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: btiJUgQPViZVjpAmwtXPkbyJldBKr8JZrirI7WjDqxqvxY1pgQET1vJ3x/NDQJ6hbtmdS5yNxsbV7pHRh31bC8V81oM1N4GAK3XKDBsX5ZxUb7oxk9t4GpOoJCQAJLwrQUMQc65Gp7Ug6M2N1WwSTrLLeXUNGRuzhl9/UuoKMBs3IKyPvw1nNJqsHlKhrv56GDZDkWScJruzwrRyfWN1Kp++oOR57elflOBubM2i6EAVIW0A7kOPwx1v7bQGCTruoTZpaj3BShKw0gC1hUQuhPUtvmcBp5vxULYf1+lvCgIYFH1yfOHKVLrF3AFkoAap6ydnnQC2HKxe/kfQw0/QhOzZfbrKo+LMRu6NgCbGFZb+yLwzNXgfWE65mlV5qhuYm2tfz89q/DNmWKalG9JGKPAyx5BJjf7SXupYsE0a6OpjJkZ8wNA7QGGoXInqfwVyBomUNCsjHKpSCxcbSP8LhgIBMsZniFO9SI2F5O2aRbn6E8W0fttn0noXpjhd5MW437UmvXOV2fGjZTrH+DnaeRa9bNKROeW+D7+UpgM45A2+sx5saH7CSsOxJ9AxWsK54l7UEwWf/pyuCUE6CoiCDcH1+VF9NnLQ4gZZYr0Z/rr9G5LX3qcKcnoBMLqMkkJgb6KA1o5jkezYhtaM+GuFk2grwL/0ci1yc7b85ruH77Q/9NtwDTTBv+gd/FtUTrySc6rGPCnoq4SHFBt/26Ngfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkFMUVNKMVY0UkRwUUlnaExiZjhhNDczL3NCRVRDT3FtL3lCT01YdUFxeEJL?=
 =?utf-8?B?Vmh5UDR2VEIvUG5SMVZ2OWFnWVJ0ZFc0SGxiVi8ram9WU0ZpWEtFWFo3aWdK?=
 =?utf-8?B?UE1KWmIzMzFyM21EZjNQMk1rMjNxb1hadExLQkpqS01OMjNHMXk0eUNLT3hP?=
 =?utf-8?B?OGZZQ2FpUTJsdEg5TnNIVUZITWlSMUJFWWdCVG9XaFV3aUZzV3J0eGtWUjVP?=
 =?utf-8?B?RkNMNkM2VXlnSkQvdHBMSkZXZ0w4emhhTWhOVEFSUk5PMGRDUlZjLzRyU0ty?=
 =?utf-8?B?NWtWNjV2OVhNVStTSjlBYjUvaEgxbmR1U1lJcXp4bkM5V3pRTWhSZWpTeUUy?=
 =?utf-8?B?VTlrczRhdW1PdUdxK1hWYnh4M1VldVc4QXNBbm0wdjJ5VmxoWXRLSDUwQjNH?=
 =?utf-8?B?ZXR0WDlweVZ3ZlF5aXlEelIva21jRHhGc1JVYndmQWpaajJiSWJQeEt1SzhT?=
 =?utf-8?B?S05vTElCOVk3RTV2bzZEWmNSUnd4Z1QxZWx3UHAvMkVxNHZoYUliTDYzRXhW?=
 =?utf-8?B?SmordENwTkJ5MlJINk5vZHBLRnhEbENTRDN0Y1Z5RmlIclhESlhJeGpTQzk3?=
 =?utf-8?B?Z0V4MGMyWStCeXpqWnRUK2tJMzNKQzRSTmFwVWxVTkdiZVR3Q3BFNjZHdHBz?=
 =?utf-8?B?RU1LT29HVjhvZ2tBY0UwMVlGRDg3N3J5WEFKall5VU9LWjYzT3YxNW1WV0Jm?=
 =?utf-8?B?Nzk1VExMRk1nc3hxT2hIMmV2QjlJUlJ2Q3NlOE51YWtGdUhOamJ1ZEpoNmM5?=
 =?utf-8?B?NURGaUhLMFpJdHZjRS91eHdVRE41TmUyaGhWamxLV3FCME1lc0s2RCsvQWx1?=
 =?utf-8?B?dG96WVhCemdsVGtpN2VkRXpFaDBNNG5oZnBLQzdPMlcwa1pOVENtaVFUcWR2?=
 =?utf-8?B?NkplVFNtMi9oRDFneXZwRGJXUTRseERpb1czTjNvalBCUGxRMnZMc1FjOGZ1?=
 =?utf-8?B?aUIwQ1FRdVJvTjlmaWpRK0Mzc0hpQW03SktBNTZ1cklTdGdyd1BVc1Fobyto?=
 =?utf-8?B?bVJld0YvQXhkeGw1UERiR1ExUzhxa1ZrTm5Od3JycWRWbEF4QVBURWUxTkZz?=
 =?utf-8?B?UXMwdm13MUJ5Vjk0VnJwMHN4czkvc0JHV2VQWmNxdFFVUEdSMDJzeWVHcWZ4?=
 =?utf-8?B?SW5DWWNGUVo4UktDN3lBRUtEUFRLR1F4Q3E0RWxOTlZVemJMN2pJS3d5N0Jo?=
 =?utf-8?B?NVozbHhWVVQ3R1h5dENZZkJERlMxMGswUEFUbDh4NFhDNWlpeHc4SUlzN0tP?=
 =?utf-8?B?VnFVKzl1TUk5cm5XbE5UUlQvQ2c4WDNLNXFhbjBsejlPNWNZaG5NSTRyNExE?=
 =?utf-8?B?RzFCNnlhV0kxdzREQkFKeVVoVjU2NVRwNEEvU2w2cWU3MGwzOTBiS0dSbDhk?=
 =?utf-8?B?YUEzTHVBZStVY2ZyV1l2TWhXaHVKQ1ZMRFZ1OTlRSHA3aWlQZ3VRTTMwVVNF?=
 =?utf-8?B?emRaQjVudGk2UU01VUlKMHdFemhMM0x5UVZOcGMzbjNvblNCNW14Y2JyaXBp?=
 =?utf-8?B?dVpCNndnL05PMldxVENqZXRhZWtZYkI2VXd2aWtSYUhNbWdzY2pNR1B0d0pq?=
 =?utf-8?B?ZHk1ZUNZdndHRlcvejNxd3VMelU5VjRPT1ZDQVdKdGExWDdPQmh4MkJNeGdD?=
 =?utf-8?B?NzE1Qnd1by8vVHlQRCtPUjI4UGp0bFp4YjlrK2lYTjNTOUUzQVJ3eWgvYlZU?=
 =?utf-8?B?Z1RaVEhBNnBYdXJlcXJabVFqUkFURWl5L2VKTXhzaXpRa25HRWRFT0Q5akFn?=
 =?utf-8?B?Q3dEdDVPdlc1YmovUmlDeXA2S2h0UTdGSll5d0VSL1lFeEgxRUxPd0lpem1k?=
 =?utf-8?B?VjZKOHJnY0JPQ1kzdlg5Rll0dVRsMzN1ckk1VTVhWjVqOUtiTG1TM0pyTzF1?=
 =?utf-8?B?RjJuYWdKT0M4akJ2ZGsrdm1ORnNYNC9lUVZWK3lQMTN3SzVKbmoza0tLcEJo?=
 =?utf-8?B?TGR0U2RGRVA4Wjh1Y3ZpTFIxbnErMUpZVmtnTFNkblR1ZDhIbm9BT0JDWXQz?=
 =?utf-8?B?cnNRZTdITHZacXZTSnNRL2JnNUFsaWh4RElyOWxjL0h3dS9RNzI1L0EzN0Vs?=
 =?utf-8?B?MVVKVzVZdUZ2dDVjeGdyZENvSDhnYTNBOERMZURRcjF0cGR2MmJOU3o4M0dE?=
 =?utf-8?B?YzNUSUk2N09yc3JCRXdyZkdDV2Y3L1FEK0krQlYrWEM1MDF5Rjl1SUh4KzBO?=
 =?utf-8?B?K3BXdmRjazMwYTVCRnBNUnBzWisyOHFDYzduZ0xNRXJTRUdCdXczSkhmeTg2?=
 =?utf-8?B?YndCOWtZZDZ2RVRlZkJHM05vM3l2alhkMUg0YThHVzZYdzJyZEU1enZiN0wy?=
 =?utf-8?B?TkZyMXY4UmNtdk1EMG0vdWFNeGcybStFSjhrZGlqK0Z4VGFjVDQwY2dDZnBU?=
 =?utf-8?Q?KiwX+QxE7CNWgscjDCbYlSKcACwMisy+dl/GSClYe755w?=
X-MS-Exchange-AntiSpam-MessageData-1: k4tlsEbBnltLWw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144a2a7b-103d-41b3-7f1c-08defc2dd4f4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:04:51.0580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xp5tPA0k+7treP5QRBk46o6RUV5n2yU/Lkzbh7pUGawBrh+lDrhIsECMFYlC/d8Pj1j7UdNPTjh87+BEP64jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

Add `IdPool::reserve_ids` which allocates a contiguous range with the
given offset, count, and alignment.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 9494fde701ee..382a5645767f 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -4,8 +4,14 @@
 
 //! Rust API for an ID pool backed by a [`BitmapVec`].
 
+use core::{
+    num::NonZero,
+    ops::Range, //
+};
+
 use crate::alloc::{AllocError, Flags};
 use crate::bitmap::BitmapVec;
+use crate::ptr::Alignment;
 
 /// Represents a dynamic ID pool backed by a [`BitmapVec`].
 ///
@@ -244,6 +250,32 @@ pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
     pub fn release_id(&mut self, id: usize) {
         self.map.clear_bit(id);
     }
+
+    /// Reserves a contiguous area of `count` IDs at or after `offset`.
+    ///
+    /// The start of the returned area is a multiple of `align`.
+    ///
+    /// Returns the reserved range upon success, or [`None`] if no such area could be found.
+    #[inline]
+    #[must_use]
+    pub fn reserve_ids(
+        &mut self,
+        offset: usize,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Option<Range<usize>> {
+        let start = self.map.next_zero_area(offset, count, align)?;
+        self.map.set(start, count);
+        Some(start..start + count.get())
+    }
+
+    /// Releases a contiguous area of IDs.
+    #[inline]
+    pub fn release_ids(&mut self, range: &Range<usize>) {
+        if let Some(nbits) = NonZero::new(range.len()) {
+            self.map.clear(range.start, nbits);
+        }
+    }
 }
 
 /// Represents an unused id in an [`IdPool`].

-- 
2.55.0

