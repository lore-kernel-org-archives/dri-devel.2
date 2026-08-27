Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A05FC61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0209B10F08E;
	Thu, 27 Aug 2026 14:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="et905asx";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A93810F08E
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJm2NVh1rrenkqXFdYpmgsnvoZ0c/VXdu5VoHQYeX+BtOHGPpalYs6RSx+kZSq5k38mU243TJDUSaK3VccU8FPfk/h5ZCpLWQvChFK6SZSQ6ZZ0DyO2ia9lC+k+VBXfsunaILyYmiLx2NY4vkxev855xPoPBLch22kgqDadinrxFkluQnE1unWdoPi2lOu3odmYMTUR/K6GguYCrK4F2vWMzsaQL/MhfM3c+Ux0EXqfuIE0eerlZC64q3IzspTJ0+XRnagpJQ4u84C+BlGe8Po8FtnfwK1NDopxtrZBG0z1iY3mBS+nhH0Bxb6MGuwMQrHt/IdDCHbiDc8YElouVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YyZsoV/mhRF+IKvx6hVeJJ7wG2dYU0bTgI8klUQ/EM=;
 b=IQA2ZejzMLF6LHkvxUeJatzv4gwnkFzXcuB+T1BJLYsRdC31ASKGer5fvtRCDZ3AaWPfZi5hDLH/RHKQIMhw2TUdwWLwD6b3cnu6eFf6x9CuGl81HZ072eY8GeHC/IgD1JuGCBzV3ppekERKAde9vz6uIsGfDI/aEULoMPKlFgGggpO6VQN3OKcQCYXkN5IFvWgv/WnI2l9/We+hqMZu2Xe4op00r7P7frtNAzxa+8ScIhmDfyEugYnfwYqNagB9y8Sw6fGApQQ3mjSeW1B/Tw5ZZ17japli0KODck6Tvx7eyUFqBHXxPhPdxgjD9zL7BmS+aH/OaxzM88oer0BXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YyZsoV/mhRF+IKvx6hVeJJ7wG2dYU0bTgI8klUQ/EM=;
 b=et905asxkoXP650AoiJccsmABs50qjVmBdDZX9iZJpQYUOII0gYHjgrOB3bOrYbp/0+a6ZrNRE4BT9E1LmT+KUXt8/6kYO09vnkEzTLXrQsedquRyY4/2748EUPznnIy646sqPP1cp0pVcdFxVthk8NAc+C4A4WjdPKhFUKGLqrIPGjk7uyiQ7T75SkTd1S7A0nYAtzZi1xhndUhX9pNTPPQRq8fyrGWll84igNgBfjiqGJp2nSlS50HMcLFUPdSxMK8zZxqn2SubkA1ybmYsAnsDiieooMiLhJG0gs4h49v1ArKDmyINu8T97lH+WEIwBF6wbF8t7Rk6uOYIj0HaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LVUPR12MB999161.namprd12.prod.outlook.com (2603:10b6:408:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:22:51 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:22:51 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 23:12:50 +0900
Subject: [PATCH v2 1/8] rust: alloc: add Vec::try_push_init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-b4-nvkv-v2-1-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LVUPR12MB999161:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ad357f-1be3-4df9-d714-08df0446ad8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: B7K8UBmxVRVKr1dFQYcrsU2HxZxjFe/wZJIes2iwUcjUPCeWe/o4/gmd2va73FN4qT2zLi6IS4pjLowH+Vm7BFxFOE+tjwooGkrAtt4MwabGA6Rsj979Ojmg42Nz09rO4XWxlHYVLQ72R3U9J3WOwJ9TsyeG15L2Yw2Q7YtBgYMU8bK52tJB0JpCi9DxmoXOCMf/hwd1w3wCefBRF/vAkLwUzi/I4gb+eM+tRKsMQHDRz88va2UzBMLd6u4Xb/16tEuD44i25wcBfF1zZSzfjy3yVFNJOtaGFaIEToPf4yC9ccXzIvDGMHMejzSsPz/b92pNUgxfMaAL+/z9QBQrRstjbId+c7HCzaQPnm9+laQSRljwDMDJ1g4y1/pEDw6yEIx7Wa+ppZvaC52EHoYZcQCQ/kowBdyGWBT/RxXrfXFbroOEC+FlBAMS6PJXZKdDYaARR46EFJZjxOywoTLNkkyeXwXiIF1bDJVw+liAfvT6o7NoodfrViT12TsMOQpxPiedJUTawSDDEu72kfIm2B2G80NGcuPg+AOAAQOGEyD66EC9R71fFwBCchs8cHjwqXwC/7buxU+zGvbCemVFVurvSyKcDQzqgw862RkPo/prCGVzglNT47W6FWapL2i+OSF4roqBxfqS8Rqaxxgf3Q+N+cUVYaXbk2puxtGRJA+evcoEeBUUlzjUfbzvZmb/eUCx+ZtFTrR/kuRbIqKQAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVQ5dmdla2Zjd3VrOHhBaEc0amwrd1dQVzJjRjFwWkoyL1JRS0xpUis3d1Nt?=
 =?utf-8?B?Yjd0Z1YwVzQ0U0FKek45djltSVpYcDcvTjVrUFRUbDJVcHVTQStNMGRqRStC?=
 =?utf-8?B?bTltcFJEQXhNdUorWmVjUTZZTnlJbVV4NXhzemFBWkVYejJNL0pqZUc2STlK?=
 =?utf-8?B?N3FZaDl1NkRuRmNqY3hxbGdORVJ0MXRKSC82YXd1OWY5UGhveFVpSGZRYW4r?=
 =?utf-8?B?WFBIMDcxT3ljSkpGdUlaVWlvYm1pY1VFNFZzRG5EdHRCMTRoN3NyYTJtdS9i?=
 =?utf-8?B?WWUzSGM2THhRQS81Z2pVNzJ4VmhlRWI0RlBqb0pTb2xlandxakN3SnBqRWpM?=
 =?utf-8?B?aFF6alRZek16eXF1SHl2Z3JOc2xUbCtSTGkyOEl2NmZJYmJZWHU0eXU5MGdG?=
 =?utf-8?B?Y0VFQ09MNHRvL0tXNi9pd0FjTUt4MCtqSUR1SitneWtHUjdMTnl3dXBRcUJ2?=
 =?utf-8?B?N1lFdFdqVmVyeE9pc0wveEdSSTk1ZERpMGdPOGJORVNxYnZtVTBFRnc3b0xB?=
 =?utf-8?B?dW1NSlVJN3BaamJVdytQYjUvNW9mN00zWjNRYkZpdEF1VDFSQllqYnE4bWxL?=
 =?utf-8?B?MGxEb3Z5Nllhb0NQYWEzdG1pS0NKRkdUWGVSSUNMSEFBcUZPTVRxdGRpUFRS?=
 =?utf-8?B?d2FsQjVVSEtIT1lKS0xxSHpKTmVmc1lPTEloU0FBK0F0dmtUWkVqTE5RK0lJ?=
 =?utf-8?B?Mk93V1kyaTE0WTgrTllraGx6czRpd25FbmFyanFwb0t5WGNndkpUQWpvTVJJ?=
 =?utf-8?B?OTZvRW9pY1BhMmR2NDlCQUlYWXc2ZnRNdjlGWGdaMnJ0ZU1tNE5rcERIcEVi?=
 =?utf-8?B?d29hWWJheUhaU0h0U1hZNXJKSXFobUJWK1ZuQXBvMFl4UDJMdDBET1JrNWVy?=
 =?utf-8?B?aGVrWkxNd3NHdEdGNGxrSkxCalJIalg0NTk0ZWdaZHJoamFHWVRTZmRsS0tE?=
 =?utf-8?B?bXJJUXAzZXFKKzllL242NDVkTVVVNDF0Mkc0dng1c0ZkcTNKU0VGOFFBbVp4?=
 =?utf-8?B?MTV6NEswYkJRUENGbm1iVmo1bVBkbHpXbnRDU3dsY095NlNiL1FzOFk4RC8y?=
 =?utf-8?B?Y2xUa1ZqeHozMDRhY1FaUHFrd2Z1S0lETkF3NHozY2hsbnhtYnZIUndhZUdp?=
 =?utf-8?B?MHFOb1J6UHRlQk55Vy9XZk0wa0JmSDhiV1Y0aUVyb2dhRjJtVzY4azVwNzY3?=
 =?utf-8?B?VU8yWU5ESUg3d2FzVzFuUUNnM0VQek5IYVBWWjlDNjhVcmZhOUlnaDMvQy9m?=
 =?utf-8?B?U3FnUVl4VkdMbVVMV3A0SVZzY3R6Z2lLZmlpMFI5MGU5NFAzMlptelEvdzYw?=
 =?utf-8?B?eDdzd3BHWUl1bnJxb2FVQVFZSEVxcUFZQmhnN1dhUXhPNW9qTkNueUJBR012?=
 =?utf-8?B?U3huUmRzU1JUaW4xdUlKL0lSUi9NaDZnOEYzUjZraHJ4UnFUMDVkMk5xYnRC?=
 =?utf-8?B?eXFGMmFGTWhlejFMWjhlMGpRTzcwL015aDA2bEdHLzNndnFpRUNuR0k4Y2Uy?=
 =?utf-8?B?SE4ySUtFeWVyb2daZThIKzhvU01NYkVYNzVWaHl2dWIvdFY4UWRsMWNWUkps?=
 =?utf-8?B?VDcwM1VPQ2V2L3lFSExuVWlSN2Fic2Z5QVJXb2FhdXhRUVFXVFFlQlJkK3RP?=
 =?utf-8?B?MWhQNzNuaHJYbEdCNUc4WEUvK0s4MnliS2tnSmhNSlAxeWZjOFg3cXgzOFpt?=
 =?utf-8?B?ejNnYnh3ejhQcE9kRXJTbWJzK1BBWGdQbSs0SGNsQkVTeXQ2U0hvU25BaEZs?=
 =?utf-8?B?aktTMDVqWVZoTTZmT2paUFhGKzlEaHpyUUZCWStSbHVjcE8vU0FBNnJqQzRO?=
 =?utf-8?B?WUg3NzVwSWR1ZFRpcVpNV2dNT0h2cUxBS0JxcFFXVUhLdU53ZzJVT0J0SW5X?=
 =?utf-8?B?ZDYwcmdBNFNrei9oNDd2NDFnVnBoa21ILytsV3NtVXRXVU5LWU1iSzZiUjN4?=
 =?utf-8?B?YnZ0YTRqS2RxQkpJcHFTOENhTlpLRy9ZU1hzTFlEWHd2ZTB5Zyt2eHFGNWRQ?=
 =?utf-8?B?ZE5ibUhFanVEZTNOZ3ZiUFRQL0k1OVljeWJGMExycjZ1U0ozTjhSZkV3VW0x?=
 =?utf-8?B?UGF4V1BNclVhZG1GWmhmbmU5Y2R2Z3drMzdJcmhjT1R2YlNZd2syRllRYkhX?=
 =?utf-8?B?YTU3R3hzZmJSR2V4QURjNzEwazZZNjQ1U0JwOU01OVBOZUVJd09RQUVWNUpn?=
 =?utf-8?B?Q0gxaHkwU1ZaeEIxanAyUEh6U0NyZHBLNFFOZEpTWjZET1BtcEZUVDZpVTdt?=
 =?utf-8?B?SXdVTTZrTnVFVmYvMzhjZmYvejZIeVMzYUZvT0FYdjc5VkNtaDhiQUFrSmk5?=
 =?utf-8?B?cHNOZHZFSXl6RzZRSEZLYU5qY2lvS3FESDBGS3hjRWVWYk5BdEpDUGZzTmgr?=
 =?utf-8?Q?a4YsNrs47+/BZMkKgLnPN9qQqnBfUS7pdVGeNhfhVUU4m?=
X-MS-Exchange-AntiSpam-MessageData-1: VajJF1I7lGsPoA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ad357f-1be3-4df9-d714-08df0446ad8c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:22:51.7285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwtU8q8qwht87x0wwkQNf19V87sXbXke6Extwt/TIWLZp8xYkOsYhdkzMhjnYotZirage8Z/8aUBdPgn8g22MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999161
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

Add `Vec::try_push_init` for fallible initializers (`impl Init<T, E>`)
and a new sum error type `PushInitError<I, E>` that it returns. If
allocation fails, it hands back the original initializer. A From impl
for `Error` lets callers decay the `PushInitError<I, E>` to a regular
Error if they want.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/alloc/kvec.rs        | 56 ++++++++++++++++++++++++++++++++++++++--
 rust/kernel/alloc/kvec/errors.rs | 30 +++++++++++++++++++++
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index c7546b9da4fa..fe86530624c1 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -52,10 +52,18 @@
     }, //
 };
 
-use pin_init::Zeroable;
+use pin_init::{
+    Init,
+    Zeroable, //
+};
 
 mod errors;
-pub use self::errors::{InsertError, PushError, RemoveError};
+pub use self::errors::{
+    InsertError,
+    PushError,
+    PushInitError,
+    RemoveError, //
+};
 
 /// Create a [`KVec`] containing the arguments.
 ///
@@ -359,6 +367,49 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         Ok(())
     }
 
+    /// Appends an element to the back of the [`Vec`] instance by initializing it in place.
+    ///
+    /// Unlike [`Vec::push`], the initializer may be fallible. If the allocation fails, the
+    /// original initializer `init` is handed back in [`PushInitError::AllocError`]. If the
+    /// initializer itself fails, its error is returned in [`PushInitError::InitError`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// struct Element {
+    ///     buf: KVec<u8>,
+    /// }
+    ///
+    /// impl Element {
+    ///     fn new() -> impl Init<Self, Error> {
+    ///         try_init!(Element {
+    ///             buf: KVec::with_capacity(16, GFP_KERNEL)?,
+    ///         }? Error)
+    ///     }
+    /// }
+    ///
+    /// let mut v: KVec<Element> = KVec::new();
+    /// v.try_push_init(Element::new(), GFP_KERNEL)?;
+    /// assert!(v[0].buf.is_empty());
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn try_push_init<I, E>(&mut self, init: I, flags: Flags) -> Result<(), PushInitError<I, E>>
+    where
+        I: Init<T, E>,
+    {
+        if self.reserve(1, flags).is_err() {
+            return Err(PushInitError::AllocError(init));
+        }
+        // SAFETY: The call to `reserve` was successful, so there is at least one spare slot.
+        unsafe { init.__init(self.spare_capacity_mut().as_mut_ptr().cast::<T>()) }
+            .map_err(PushInitError::InitError)?;
+        // SAFETY: The call to `__init` returned `Ok`, so the first spare slot now holds an
+        // initialized `T`. The new length does not exceed the capacity because `reserve` ensured
+        // the capacity is greater than the length by at least one.
+        unsafe { self.inc_len(1) };
+        Ok(())
+    }
+
     /// Appends an element to the back of the [`Vec`] instance without reallocating.
     ///
     /// Fails if the vector does not have capacity for the new element.
@@ -1174,6 +1225,7 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
         )*
     }
 }
+pub(super) use impl_slice_eq;
 
 impl_slice_eq! {
     [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2>,
diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/errors.rs
index aaca6446516a..4e4be9a46d83 100644
--- a/rust/kernel/alloc/kvec/errors.rs
+++ b/rust/kernel/alloc/kvec/errors.rs
@@ -25,6 +25,36 @@ fn from(_: PushError<T>) -> Error {
     }
 }
 
+/// Error type for [`Vec::try_push_init`].
+pub enum PushInitError<I, E> {
+    /// The allocation failed. Hand the initializer back.
+    AllocError(I),
+    /// The initializer failed.
+    InitError(E),
+}
+
+impl<I, E> fmt::Debug for PushInitError<I, E> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match self {
+            PushInitError::AllocError(_) => write!(f, "Failed to allocate"),
+            PushInitError::InitError(_) => write!(f, "Initializer failed"),
+        }
+    }
+}
+
+impl<I, E> From<PushInitError<I, E>> for Error
+where
+    Error: From<E>,
+{
+    #[inline]
+    fn from(e: PushInitError<I, E>) -> Error {
+        match e {
+            PushInitError::AllocError(_) => ENOMEM,
+            PushInitError::InitError(e) => Error::from(e),
+        }
+    }
+}
+
 /// Error type for [`Vec::remove`].
 pub struct RemoveError;
 

-- 
2.55.0

