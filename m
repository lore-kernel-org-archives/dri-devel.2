Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B892C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1394D10E7C2;
	Mon, 17 Aug 2026 12:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ks7mGRYv";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011014.outbound.protection.outlook.com
 [40.93.194.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C300310E7C2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCmEK4MWJH8a7JPbGq8x25DZhevpXNlynPdc206F2UGHkrnjagt7I5Gp3AP5SCUqIz3oZCVpuo9CSSZMD7NE78WMuu7v3Gm23MMy0manV45ROUxeiROwOkdCqsRiyeBi4h/HdvYCwoNVgJq/h8b9jnTt5hRy5j+aOdZsSb2CfzAWzMMte7B4F3vDDWZnV5MNAv0rlTdKqPyagKr+bKNcHpRtUC/4MMKpC4+5IbZ1OvkREN+zsZsOqE8Kqfrur6h9bgdPm5zhQDPyoLr/Mj6Qm52kXTSFNF3ZBIO8FQMdFlhsyubJD7/ZyL435fwpCBLrqR56Ui8XVK1KoGgV4bVvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzo4kPKqaJ73zkodzxKW8/KYHl95STGO1/blrVcrVrU=;
 b=nObFTN71vsaCrhT1iZ1Mnfx245ogn5C5d3xaYD6YTU0qUJzC1ZTp58sOqYfnRC1L9Z/6Uav+02cYYgq64Vgzw8S6Dh3CVg/NvbcbTTTwROqwAgQ9GNzaIMvFP4W13faj5b0VOaC6XJ/Nn62Z7bR3wSL1Btxi9qfGWpeiXQ6zUnKeI4l89oMFhIrHQ9+Rg0EW9G6LC8goLbMua1NyAAwQdiqs/+PvjHkA3hjfkwsSMINTqUbdjMz0taFvD89L1BAMqw5A/Bb6hK05dbMqecR1J9FDpvbh60oWYr7tEKCd45LFXIu05Uw8ptAjwRM5e9f24FHadC46dFE+FMzoUbhB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzo4kPKqaJ73zkodzxKW8/KYHl95STGO1/blrVcrVrU=;
 b=ks7mGRYvYz9iAtC0kQKbBMg/Y1iqbUNOThQawE4sXPWtMiknF2oOxIfAScKrmsa7TBNyoHq/O+WEogD4iWNuQVcVgtfalcuvNO7heqw72IKfARy/APuEhUHNwMDSzwBKRbeQpOfHcUduh2FO0UomwCxljkdtHU0rC8hkwtnYcVFs6b+j7koEyHAD+UUrETNjkYlEjl3xvcd2UugITIteaL5kUzwwHY88UEk5YPLtLgRKAvL8BKofPcKhxi5CLc+VRCH06fKRgRBnnaFT23QHbrZZtLfd1nHVWb0zs6Ip982Q068Kqp8Mgwyx2IzoyB+FTUimxEIfY4UVIsRyNfDqIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 17 Aug
 2026 12:59:24 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:59:24 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 21:56:40 +0900
Subject: [PATCH 5/6] gpu: nova-core: add NVKV typed decoding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-nvkv-v1-5-b84db5e84b67@nvidia.com>
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
In-Reply-To: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0168.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 20dfecff-5ab1-4a67-b550-08defc5f5cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|10070799003|18002099003|921020|22082099003|56012099006|10067099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: +p/qsUk8VfshCiLM+Vo61JjlZKZkQ2RMIr9Pc9t3pKJL7aO0FEyrbldn0Qfp8Vt/+jhompaiMgXXnR4FbgAvZ5FtF1YpbwXphVext4rUYFPQoWqYxX28nx86SerQHto0Wjr49yJfP989/lrzCkRgu1tqMWd9sAGuZpnMW9mW4LUIFP4h+UretTLT+qy5/fIaHqXkgJAb7+g6WC6n0o/NKiwkvor1KfWPI8vPRKnoiEu/nA3ZYram2nrzGrUIOJxGh/1Mh0EX1kIwqjW96QKOg4WY/EMNbAotOdpOQKhR9rZk6r0bdM1cXIQjR1f97RgbX2nV/2JlIRyUeQo2P4c6kJv1FAeahj59oiDYj0xjLLRx3agISGCOdmHAfK83ssbdFIFnq3tbCcG5ywE0dwfwev9viFZ6qV7OQziff9L2yDDlH7JToxLC9J7R8DSGInX5yL0CH9slokx541ZgvWprksr/N1T4NVPIFBgD2EEBsttjE9U3cD8Rla/hJSDApGVDmM9VidLgUmfHFsWU11ol6HTUnGCs/imNM0Uzip4hdWGfEidHaKRQ/1gjFg2RSLZ6zOBWXZCexNHbvalUTJMUbQB/qyCFpIBgFiYqDGiYnBuHJt2tRnuNwIpg81DVqEjoPcconTLcmi7KkqTUdIYiZURrPN49USzKrz2bRxNqj0WNTA4Q+yBxCPFIbvb+6RCAnsoL0WlCAnjs2TiS8f1MfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(10070799003)(18002099003)(921020)(22082099003)(56012099006)(10067099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHAvT3V0aUkrZG9GdFN2eG5WUkZkOUFFM0xud0tjOWJlNVp1NEgxNjlnVDRW?=
 =?utf-8?B?ZFJabTFaM0ZxY3V0WGFkc1BuTE04ZDcrekN2dVdoMkpOcENrOGs5aTA4NU1n?=
 =?utf-8?B?VFJWMW8xRTdLVmdUQUUwY0phKzk0Q1pZRHFKU3FhSUhRdjQzNnZpUDFnWFFh?=
 =?utf-8?B?RkFyRVFqaG1zY3lVbXk4WjJlSFJEOHZyYy9wSnV6SENyT0VCaHcwUzVoWWRl?=
 =?utf-8?B?eFNKRE1mRUZmNFdyTEFXdTVwWmc2cTgrK2ZaK0ZERGxMRXB3aUI1Q29FbTR0?=
 =?utf-8?B?bFpYQjlUblU5UUZMTXJ2Q0RpM0JlT0YyUEdtWEwwVzNraG5qbmpFbEhkMHAx?=
 =?utf-8?B?WnAxTXZnd0dPWmNiY3BrMVE0aHBFSVljL0l6S21kdlBSSGozRXl0UVo1YkNV?=
 =?utf-8?B?OEZocC9WdURJS0ZXU2x4Q2pvcWs1MlhUM2d4UHBNMUZLa3NrMFQrZVRBZ2Mx?=
 =?utf-8?B?bVJXT3hySnVXSVlZaTdlZW41Tk1QVkpSdXNya3JyZWdscGsrUGdZQVhLVnBt?=
 =?utf-8?B?WlJ3RVM2bmRQZFZENEx1YVpjTzBkNDR5bitncHpZNHlRZzZUaVdTN0FIL01q?=
 =?utf-8?B?YWExUVlJZTZWVGkzZkhIUHRhVnl6VldXMVg0eS9MVWFQNmFmN3AwMVhSc2JC?=
 =?utf-8?B?NVBnems5aFBoRzFrRzVobDA5QlBXZWNjMllTZkJQU1V5WDMzaW1RckxTMmY1?=
 =?utf-8?B?dGNLc1BkeS95MVpzbGRSQXJQMk5kSERSYk1YKzFmVitSdUdadlM1TWhWUXlp?=
 =?utf-8?B?V3J0MGk5NDUrNTd0M29mNWU5S01vSlN1MlorYXRBcFBBK21MYmFqU01nbEpL?=
 =?utf-8?B?cUdBUVpJaDFKa3JMVEQzRENsWE5ONmp0SnNGSFpnY0lYTGwzdjhwdVNpUlZY?=
 =?utf-8?B?MHkvUnN5T0c2b3Y0bTY5L0c1R3pINExMNjFTalVaUWl1YkNqZ2xZbSt1cXVD?=
 =?utf-8?B?TnMrOStKdjFEa0lIdDNEZ1BmakNFWmpTTU1adTJNZnhlR2JWRW5OZ2EwZ1B2?=
 =?utf-8?B?Z2h3OFEzMC9Yc1lldExsMkpXRTZKSXpQL2ZkemdZWjB1ampiWTNUWWlJZkt3?=
 =?utf-8?B?MHFOTVh2ZVppcTkvcnRybzR4NEZzTHNoQlE0TXpHSkhGMTFXQWZNZUZtTllV?=
 =?utf-8?B?VTMzQUszVmE4eVhOSGJGaVVkOHJsZTF0NTRGWmZCS0d0R2lTYy9RZ242RWdS?=
 =?utf-8?B?SldTM1I5eWJPUVlTclRKcGhZZmpiZ1VFWUFiZWxyYisya1VjWXd6dkliaW8r?=
 =?utf-8?B?aDJxRWdzV0hMU0swSUJ4ZUhLalRSV3NLcnJ1VWRtbHo4cVdhUmV5dWJIMkpi?=
 =?utf-8?B?UWpxaUtya0syd1YzdjFxSlhtN0c1b1YzS0hsYUtxMkNPa1Y4OGxQWlBON3hF?=
 =?utf-8?B?Um56NnVUTm5waTFNUGZvN3dyemtUSDJOeG1aUXdiZ3g4dVBab3EwUUxUVnBS?=
 =?utf-8?B?MDVPWDFBUnNIakxocnphQklVOXdYVGFFTzV0UWx5L1lHcFJmMjlaamYwUE9j?=
 =?utf-8?B?UUo3dVZxUjl6RGhqSVF0b3RKa2FWTk52am5hMUxUUGJydTNNUDhySWx0ekI1?=
 =?utf-8?B?dU1sOXdYRS8vMmljeUc2WEJaT2picTE4MHhzVjR0TWozenpOSFgrcEdvUzAw?=
 =?utf-8?B?U1YyOHRzUUZSVndnTVNSQUpzSDQvbDF6b1JPc1NFQm56UFlSTC9JbE9hQktt?=
 =?utf-8?B?K0RvU1Y0S1dydkFIRzUyQStBRjgzL0F0SFZVUDZ5VUFTZU94NFhUaDlUWjZl?=
 =?utf-8?B?UmU0Tmx0MFBkMTErb1drdk5oajkvV3JXRERFWG1aS1BKWHV4dXlTR2Z0eFhJ?=
 =?utf-8?B?K3ZpYmh5c3VMWGx0N3RJOWpDckN5NTVia3c5aXBGeFpadVpPamRyWlZzaUwr?=
 =?utf-8?B?M1p4Mjk5RzNmUkdJNHN5dHBWRE15UUltb3pGT0NwQk1lYXNQZHh5QldOcXF6?=
 =?utf-8?B?TVdjek9Ib2RQQVI0R2s3c0dTNWRXVWtnVWVianBTeFpuQWtZU3h0VFhTVU84?=
 =?utf-8?B?TkhDVHhPNlZCUnRMQ3l2KzlYVHV0ZFdFVXBLZTBVUG10bVJhaHpkNElmaVFq?=
 =?utf-8?B?ME1lSTNzRjBBMmtTUlZyZ1orS05mcFhQTXNOck1UQ1BTaEtlV0pvcVVqYVFF?=
 =?utf-8?B?ZDl4dFFaM0RHMzkxVmVud2xPZTRMbm0yZ29pM1JNSUNZVHB5MnE2UmErM2t5?=
 =?utf-8?B?R3l5NWpiS2xtRnFIWTBiY3JFZHJ2NU54dGswQWZ0cDV6ak1YTHk4V0NOT2xi?=
 =?utf-8?B?NS96YzdZVHdYaVlEVHlYSGNZY2Y3SE5rSDdPVC9Xb0NyLzVjVFRqc2d1Yy93?=
 =?utf-8?B?a1Z6YjBZemsxVFYzbVdZcnFjZnlTUVBqNyt4Vmg0SzlGRTRxeGpHNXJsVjY0?=
 =?utf-8?Q?Qr/ZATv5XFD8zC7tCgMKUtGQ9fLQn085OzJ3tZHmU5MYW?=
X-MS-Exchange-AntiSpam-MessageData-1: 2YgEKMDAkEb/dA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dfecff-5ab1-4a67-b550-08defc5f5cb3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:59:24.1474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imtEZldSga7aUr36CsmDTYQMKKFT/8y3iLNmD4wtOm7wqvzklgUqleoI8zuGKbiVOo8nw0lc4W2f7f1Z2Vhq8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
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

Similar to the typed encoding layer, add some decoding type machinery.
Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
by composing visit calls to each member. Add some common `Schema` kinds,
such as `Array` which collects an array value into a fixed maximum size
array, and `Required` which fails a decode if the value is not sent.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |  60 ++++-
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 393 +++++++++++++++++++++++++++++++
 2 files changed, 452 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index bf6500d54b21..a0068847bb80 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -9,7 +9,7 @@
 //! function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0, b"some gpu")
 //! naturally maps to storing a &str with the GPU name.
 
-#![expect(unused_imports)]
+#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
 #![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
 
 use core::marker::PhantomData;
@@ -78,6 +78,64 @@ fn default() -> Self {
     }
 }
 
+/// A fixed capacity vector that holds at most `N` elements.
+#[derive(Debug, Copy, Clone, PartialEq, Eq, Zeroable)]
+pub(crate) struct ArrayVec<T, const N: usize> {
+    data: [T; N],
+    len: usize,
+}
+
+impl<T, const N: usize> ArrayVec<T, N> {
+    /// Replaces the contents with a copy of `slice`.
+    ///
+    /// Fails with `EMSGSIZE` if `slice` is longer than the capacity.
+    pub(crate) fn set_from_slice(&mut self, slice: &[T]) -> Result
+    where
+        T: Copy,
+    {
+        let Some(dst) = self.data.get_mut(..slice.len()) else {
+            return Err(EMSGSIZE);
+        };
+
+        dst.copy_from_slice(slice);
+        self.len = slice.len();
+
+        Ok(())
+    }
+
+    /// Returns the initialized elements as a slice.
+    #[inline]
+    pub(crate) fn as_slice(&self) -> &[T] {
+        // PANIC: `len` is bounded by `N`.
+        &self.data[..self.len]
+    }
+}
+
+impl<T: Default + Copy, const N: usize> Default for ArrayVec<T, N> {
+    fn default() -> Self {
+        Self {
+            data: [T::default(); N],
+            len: 0,
+        }
+    }
+}
+
+impl<T, const N: usize> Deref for ArrayVec<T, N> {
+    type Target = [T];
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.as_slice()
+    }
+}
+
+/// A schema field for an array value under the NVKV key `KEY_ID`.
+#[derive(Default)]
+#[repr(transparent)]
+pub(crate) struct Array<T: Default + Copy, const N: usize, const KEY_ID: KeyId>(
+    pub(crate) ArrayVec<T, N>,
+);
+
 bitfield! {
     /// The op word that starts each NVKV operation.
     struct Op(u64) {
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
index ee8b6ab5a3a4..9112dcf1aaca 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -3,16 +3,311 @@
 
 #![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
 
+use core::marker::PhantomData;
+
 use kernel::prelude::*;
 
 use crate::gsp::nvkv::{
+    Array,
+    ArrayVec,
     Index,
+    Key,
     KeyId,
     Op,
     Opcode, //
 };
 use crate::num;
 
+/// Defines a schema struct together with its [`Schema`] implementation that decodes into `$target`.
+///
+/// Each member of the struct should implement `Schema`. For every (key, index, value) triple
+/// decoded from the NVKV stream, the generated parent `Schema` implementation will call each member
+/// in declaration order with that triple. If a member consumes that triple, it will stop there.
+/// Otherwise it will keep going until all members are tried.
+///
+/// The schema struct holds the state required by the schema implementation to do the decode. It's
+/// recommended to use one of the existing Schema kinds (`Required`, `Accumulated`, `Key`, `Array`,
+/// `Indexed`) for each member.
+///
+/// # Examples
+///
+/// ```
+/// nvkv_decode! {
+///     #[derive(Default)]
+///     struct RequestSchema => Request {
+///         id: Required<u32, 0x0001>,
+///         name: Array<u8, 64, 0x0002>,
+///     }
+/// }
+/// ```
+macro_rules! nvkv_decode {
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident => $target:ident {
+            $(
+                $(#[$field_attr:meta])*
+                $field_vis:vis $field:ident : $ty:ty
+            ),* $(,)?
+        }
+    ) => {
+        $(#[$attr])*
+        $vis struct $name {
+            $(
+                $(#[$field_attr])*
+                $field_vis $field: $ty,
+            )*
+        }
+
+        impl $crate::gsp::nvkv::Schema for $name {
+            type Target = $target;
+
+            fn visit(
+                &mut self,
+                key: $crate::gsp::nvkv::KeyId,
+                index: $crate::gsp::nvkv::Index,
+                value: $crate::gsp::nvkv::DecoderValue<'_>,
+            ) -> ::kernel::error::Result<bool> {
+                Ok(false
+                    $( || $crate::gsp::nvkv::Schema::visit(&mut self.$field, key, index, value)? )*)
+            }
+
+            #[inline(always)]
+            fn finish(self) -> impl ::kernel::prelude::Init<Self::Target, ::kernel::error::Error> {
+                ::kernel::try_init!(Self::Target {
+                    $( $field <- $crate::gsp::nvkv::Schema::finish(self.$field), )*
+                }? ::kernel::error::Error)
+            }
+        }
+    };
+}
+pub(crate) use nvkv_decode;
+
+impl<T: for<'a> TryFrom<DecoderValue<'a>, Error = Error> + Default, const KEY_ID: KeyId> Schema
+    for Key<T, KEY_ID>
+{
+    type Target = T;
+
+    #[inline(always)]
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        if key != KEY_ID {
+            Ok(false)
+        } else if index != Index::new::<0>() {
+            // Single values being set must be at index 0.
+            Err(EINVAL)
+        } else {
+            // Overwrite and take the latest value here.
+            self.0 = value.try_into()?;
+            Ok(true)
+        }
+    }
+
+    #[inline(always)]
+    fn finish(self) -> impl Init<Self::Target, Error> {
+        Ok(self.0)
+    }
+}
+
+impl<T: for<'a> TryFrom<DecoderValue<'a>, Error = Error>, const KEY_ID: KeyId> Schema
+    for Key<Option<T>, KEY_ID>
+{
+    type Target = Option<T>;
+
+    #[inline(always)]
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        if key != KEY_ID {
+            Ok(false)
+        } else if index != Index::new::<0>() {
+            // Single values being set must be at index 0.
+            Err(EINVAL)
+        } else {
+            // Overwrite and take the latest value here.
+            self.0 = Some(value.try_into()?);
+            Ok(true)
+        }
+    }
+
+    #[inline(always)]
+    fn finish(self) -> impl Init<Self::Target, Error> {
+        Ok(self.0)
+    }
+}
+
+impl<T: Default + Copy, const N: usize, const KEY_ID: KeyId> Schema for Array<T, N, KEY_ID>
+where
+    for<'a> &'a [T]: TryFrom<DecoderValue<'a>, Error = Error>,
+{
+    type Target = ArrayVec<T, N>;
+
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        if key != KEY_ID {
+            return Ok(false);
+        }
+        // Require to be at index 0
+        if index != Index::new::<0>() {
+            return Err(EINVAL);
+        }
+        // Reject oversized and take the latest value.
+        self.0.set_from_slice(value.try_into()?)?;
+        Ok(true)
+    }
+
+    #[inline(always)]
+    fn finish(self) -> impl Init<Self::Target, Error> {
+        Ok(self.0)
+    }
+}
+
+/// A schema field for a key that must be present.
+///
+/// `finish` fails with `EINVAL` if no value arrived for the key.
+#[repr(transparent)]
+pub(crate) struct Required<T, const KEY_ID: KeyId>(Key<Option<T>, KEY_ID>);
+
+impl<T: for<'a> TryFrom<DecoderValue<'a>, Error = Error>, const KEY_ID: KeyId> Schema
+    for Required<T, KEY_ID>
+{
+    type Target = T;
+
+    #[inline(always)]
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        self.0.visit(key, index, value)
+    }
+
+    #[inline(always)]
+    fn finish(self) -> impl Init<Self::Target, Error> {
+        (self.0).0.ok_or(EINVAL)
+    }
+}
+
+impl<T, const KEY_ID: KeyId> Default for Required<T, KEY_ID> {
+    fn default() -> Self {
+        Self(None.into())
+    }
+}
+
+/// Expects objects specified sequentially with index starting from zero.
+pub(crate) struct Accumulated<S: Schema> {
+    current_index: Index,
+    current: S,
+    current_started: bool,
+    next: S,
+    accumulated: KVVec<S::Target>,
+}
+
+impl<S: Schema + Default> Accumulated<S> {
+    /// Creates an empty accumulator.
+    pub(crate) fn new() -> Self {
+        Self {
+            current_index: Index::new::<0>(),
+            current: S::default(),
+            current_started: false,
+            next: S::default(),
+            accumulated: KVVec::new(),
+        }
+    }
+
+    fn into_vec(mut self) -> Result<KVVec<S::Target>> {
+        if self.current_started {
+            let done = core::mem::take(&mut self.current);
+            self.accumulated.push_init(done.finish(), GFP_KERNEL)?;
+        }
+        Ok(self.accumulated)
+    }
+}
+
+impl<S: Schema + Default> Schema for Accumulated<S> {
+    type Target = KVVec<S::Target>;
+
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        if index != self.current_index {
+            if !self.next.visit(key, Index::new::<0>(), value)? {
+                // Unrelated key to us.
+                return Ok(false);
+            }
+
+            // Require that objects at index k have all their keys sent before the k + 1 th object
+            // can be completed. Require that objects are sent contiguously in order from index 0.
+            if !self.current_started || index != self.current_index + 1 {
+                return Err(EINVAL);
+            }
+
+            // The current value must be finished. Finish it and start working on `next`.
+            let done = core::mem::replace(&mut self.current, core::mem::take(&mut self.next));
+            self.accumulated.push_init(done.finish(), GFP_KERNEL)?;
+            self.current_started = true;
+            self.current_index = index;
+            Ok(true)
+        } else {
+            let consumed = self.current.visit(key, Index::new::<0>(), value)?;
+            self.current_started |= consumed;
+            Ok(consumed)
+        }
+    }
+
+    #[inline(always)]
+    fn finish(self) -> impl Init<Self::Target, Error> {
+        self.into_vec()
+    }
+}
+
+impl<S: Schema + Default> Default for Accumulated<S> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+/// A schema field that scatters indexed values into an array of `N` slots.
+#[repr(transparent)]
+pub(crate) struct Indexed<T, const N: usize, const KEY_ID: KeyId, As = T>([T; N], PhantomData<As>);
+
+/// Copies `elems`, converted to `T`, into `slots` at `start`.
+///
+/// Fails with `EINVAL` if the window does not fit in `slots`.
+fn scatter_window<T: From<As>, As: Copy>(slots: &mut [T], start: usize, elems: &[As]) -> Result {
+    let end = start.checked_add(elems.len()).ok_or(EINVAL)?;
+    // Reject indices outside of the declared array size.
+    let dst = slots.get_mut(start..end).ok_or(EINVAL)?;
+    for (d, &e) in dst.iter_mut().zip(elems) {
+        *d = T::from(e);
+    }
+    Ok(())
+}
+
+impl<T, const N: usize, const KEY_ID: KeyId, As> Schema for Indexed<T, N, KEY_ID, As>
+where
+    T: From<As>,
+    As: Copy + for<'a> TryFrom<DecoderValue<'a>, Error = Error>,
+    for<'a> &'a [As]: TryFrom<DecoderValue<'a>, Error = Error>,
+{
+    type Target = [T; N];
+
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        if key != KEY_ID {
+            return Ok(false);
+        }
+        let start = index.cast::<usize>().get();
+        // Accept both scalar vs scattered array setting for flexibility.
+        match <&[As]>::try_from(value) {
+            Ok(elems) => scatter_window(&mut self.0, start, elems)?,
+            Err(_) => scatter_window(&mut self.0, start, &[As::try_from(value)?])?,
+        }
+        Ok(true)
+    }
+
+    #[inline(always)]
+    fn finish(self) -> impl Init<Self::Target, Error> {
+        Ok(self.0)
+    }
+}
+
+impl<T: Default + Copy, const N: usize, const KEY_ID: KeyId, As> Default
+    for Indexed<T, N, KEY_ID, As>
+{
+    fn default() -> Self {
+        Self([T::default(); N], PhantomData)
+    }
+}
+
 /// A decoded NVKV value.
 #[derive(Copy, Clone)]
 pub(crate) enum DecoderValue<'a> {
@@ -255,4 +550,102 @@ fn finish(self) -> impl Init<Self::Target, Error> {
 
         Ok(())
     }
+
+    // Tests that decoding via the `nvkv_decode!` macro works correctly.
+    #[test]
+    fn decode_typed_struct() -> Result {
+        const SCALAR32_KEY: KeyId = 0x1234;
+        const SCALAR64_KEY: KeyId = 0x1235;
+        const ARRAY8_KEY: KeyId = 0x1236;
+        const ARRAY32_KEY: KeyId = 0x1237;
+        const ARRAY64_KEY: KeyId = 0x1238;
+        const OPT_PRESENT_KEY: KeyId = 0x1239;
+        const OPT_ABSENT_KEY: KeyId = 0x123a;
+        const X_KEY: KeyId = 0x0100;
+        const Y_KEY: KeyId = 0x0101;
+        const SLOT_KEY: KeyId = 0x0200;
+
+        const SCALAR32_VALUE: u32 = 0x89ab_cdef;
+        const SCALAR64_VALUE: u64 = 0x0123_4567_89ab_cdef;
+        const ARRAY8_VALUE: &[u8] = &[0x12, 0x34, 0x56];
+        const ARRAY32_VALUE: &[u32] = &[0x0123_4567, 0x89ab_cdef];
+        const ARRAY64_VALUE: &[u64] = &[0x0123_4567_89ab_cdef, 0xfedc_ba98_7654_3210];
+        const OPT_PRESENT_VALUE: u32 = 0x55;
+
+        nvkv_decode! {
+            #[derive(Default)]
+            struct PairSchema => Pair {
+                x: Required<u32, { X_KEY }>,
+                y: Required<u32, { Y_KEY }>,
+            }
+        }
+
+        struct Pair {
+            x: u32,
+            y: u32,
+        }
+
+        nvkv_decode! {
+            #[derive(Default)]
+            struct TestSchema => TestDecodeable {
+                scalar32: Required<u32, { SCALAR32_KEY }>,
+                scalar64: Required<u64, { SCALAR64_KEY }>,
+                array8: Array<u8, 64, { ARRAY8_KEY }>,
+                array32: Array<u32, 64, { ARRAY32_KEY }>,
+                array64: Array<u64, 64, { ARRAY64_KEY }>,
+                opt_present: Key<Option<u32>, { OPT_PRESENT_KEY }>,
+                opt_absent: Key<Option<u32>, { OPT_ABSENT_KEY }>,
+                pairs: Accumulated<PairSchema>,
+                slots: Indexed<u32, 4, { SLOT_KEY }>,
+            }
+        }
+
+        struct TestDecodeable {
+            scalar32: u32,
+            scalar64: u64,
+            array8: ArrayVec<u8, 64>,
+            array32: ArrayVec<u32, 64>,
+            array64: ArrayVec<u64, 64>,
+            opt_present: Option<u32>,
+            opt_absent: Option<u32>,
+            pairs: KVVec<Pair>,
+            slots: [u32; 4],
+        }
+
+        let index0 = Index::new::<0>();
+        let index1 = Index::new::<1>();
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(SCALAR32_KEY, index0, SCALAR32_VALUE)?;
+        encoder.encode_u64(SCALAR64_KEY, index0, SCALAR64_VALUE)?;
+        encoder.encode_array8(ARRAY8_KEY, index0, ARRAY8_VALUE)?;
+        encoder.encode_array32(ARRAY32_KEY, index0, ARRAY32_VALUE)?;
+        encoder.encode_array64(ARRAY64_KEY, index0, ARRAY64_VALUE)?;
+        encoder.encode_u32(OPT_PRESENT_KEY, index0, OPT_PRESENT_VALUE)?;
+        encoder.encode_u32(X_KEY, index0, 1)?;
+        encoder.encode_u32(Y_KEY, index0, 2)?;
+        encoder.encode_u32(SLOT_KEY, index1, 20)?;
+        encoder.encode_u32(X_KEY, index1, 3)?;
+        encoder.encode_u32(Y_KEY, index1, 4)?;
+        encoder.encode_u32(SLOT_KEY, index0, 10)?;
+        let serialized = encoder.finish();
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let decoded = KBox::try_init(decoder.decode(TestSchema::default())?, GFP_KERNEL)?;
+
+        assert_eq!(decoded.scalar32, SCALAR32_VALUE);
+        assert_eq!(decoded.scalar64, SCALAR64_VALUE);
+        assert_eq!(*decoded.array8, *ARRAY8_VALUE);
+        assert_eq!(*decoded.array32, *ARRAY32_VALUE);
+        assert_eq!(*decoded.array64, *ARRAY64_VALUE);
+        assert_eq!(decoded.opt_present, Some(OPT_PRESENT_VALUE));
+        assert_eq!(decoded.opt_absent, None);
+        assert_eq!(decoded.pairs.len(), 2);
+        assert_eq!(decoded.pairs[0].x, 1);
+        assert_eq!(decoded.pairs[0].y, 2);
+        assert_eq!(decoded.pairs[1].x, 3);
+        assert_eq!(decoded.pairs[1].y, 4);
+        assert_eq!(decoded.slots, [10, 20, 0, 0]);
+
+        Ok(())
+    }
 }

-- 
2.55.0

