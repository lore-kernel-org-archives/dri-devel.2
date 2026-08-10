Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6FEC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B2ED10E71D;
	Mon, 10 Aug 2026 08:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SyWWTSIA";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E79C10E71D
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/iIoEk9J07HzrjQfhSG9sHD88LhjssC91DRuVWeL6cTAQlq8xMgMfGJ0ASwfBpqKGGfE31k+jdX3RL90bCWsuw0ZLWM5tcd3l2QEvpG1qBax9fEBOzMreXx8g2hmuyLsEveDa6DuAHXjkjQQenTSeOGmXk0XqhG3md/6HH4i6Km708pLRXyQtei5R857GQj+2JwNqFhJxQYJMV285nuCbMeKO3a5PTxSK6SYr1fHKEtUceCtZygqc3zwoOlRG7/WTloyedDrkPO4bDcrZXFopsuOPBSi9p7OvLNzijwuJZPV5pG882O9dWg4uvjzx9abYy34aZ6nQUOXEsnts+MmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj2204dTDoA/COASlUYF+k68w7X/AUy2/BhrHJC5RL4=;
 b=R9LvQQmJifd0IXRevPQlKn3ODxBoeHu+gcnlEDmhKrgKoRyRIKnsvyzz6/zY0YKENtL8NVqGusCAGGyw3mlZSLCgVNB2YT95k14tTLPhRVhf1C83ObAVTzuAecNZgzwj50R/E3MTJx4dHmOo/a83HlPADclIpdp+gumiZnVjsIkS6CDSmny1c9ziskmrGeNcK12iWd2aazgFHCsNcv1rdkWzWrqLEPAtY+KGTOVD5UAAVJ2+vXGNNkxy/QUGia9c43E4OljTCAXnYfWEdzZbPF1j2pqAXRFRqUvQtQpPJG8aPPEjYeNZc+Wzt4yF9hF1OjcZQJXhFB+Xa4oQtiWWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj2204dTDoA/COASlUYF+k68w7X/AUy2/BhrHJC5RL4=;
 b=SyWWTSIAWa5eI5l/L8s9mdNZMJP4ahkNmrLGE70SqB+mu8LMegdypP8NtvLy/oOJUrhSpJQ1E4h/E0nOOTBc2Et2nKUcWs9PEBHEkXUS3zg7lRyaxWMSQIkfB6j6XL0SNwQi413neRsG7ybaEaq5N6thiAk+rcPAoYect381Yy57z5ngLWksjOHEZMJgeUbEW+uj/mAz/F3csft8jZvu7C/3qgvFrTP1m/7cPe5qZnqzk1tPCLjXAN9o7MCGeV/KJlJx/zyaGeJOKYJiDQy7Vvtv2hAj1iA9yLQzYxqb0sODVgfOPNIrdfWGka2b7HGSo9zUXD4A3njsWZbZfShUlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:35:42 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:35:42 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 17:34:10 +0900
Subject: [PATCH v4 2/5] rust: bitmap: restrict bitmap length to at most
 i32::MAX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-chid-v4-2-c9f206fdcb97@nvidia.com>
References: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
In-Reply-To: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b686e30-22f5-47ad-5709-08def6ba5d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|10070799003|366016|18002099003|22082099003|6133799003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: alv++W0nkR+hMAtyUvhGhPpaxLxoa0JlsIlc6abmUK4S43cWlRAxV/K3UiYqqnYsEAP6DCFY14hw9BuBAxc1rYag4FlKWJ7vDMxK7umychUGnKbP8D5C7NYiVfD1e799BReXqmNFD4mcqgIa+vXv3US1eFycX0v9fCtC978OVK0T/tmexwmigrTs+RuYhmmfQ0UlitSP7zC4TVsNLaTx4yYFX6I+9voLtPW24rT4qxgap+eTzMs7b7oVMaTCTTqR+iMF+aC0L2mBHG9DAQwNvqIbvaNo8G0PRTJkU5EIXxri/MsIUf7puG8ylXFYTbWH47cfXuHUk08bStFePnqPrjitzIm4l2SvyxqhrfIkAOQu5yVfmmBFB4/7jBcnnHr2E8NvSg4U26Oh8UBeGRcj5hIXMXqzJPjQBSFKpxySk41afGbak9dixulO8srKy7PzGLZE4bUkRhJWXVKQAlnmh0CbjVWY8qGYICnDiiq+uuVvmHHXbjaVj/O9vPmdXr7Oj/V9iPF2/Nn2qzLAbKRqRXu9Mr030iWGF68NvDjLxLhdEzkQfF3MvS82RpMyZPhLzr8yNZvH/4aACljRkuVPSwmo3eW5oYnPBzufb6CMiUkgBe2zunMhV3u+aRBbc4jrlDsDIXB74FNdsSY1pNx/4c7QcQLVGMreE+Uq9cs2PXgzl/xF9E4hrKAGc/oJqGhiChTPNq/S0xPyD8jW/zqKzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2VNZXhXdWJNQ2dKWlZzL3M0aG5KTmtCQnRqc2trb2diYllNNHVRdFpWa3Nx?=
 =?utf-8?B?aUowSnF1YWR4bWNBTkpyN0I1Q1MzMG4zVHlydThsT1lXbGNNNlJnYUNzemdt?=
 =?utf-8?B?Ujd5OXVOLzZmeStDRHdWMVZ2OTlRM0JPdlc4QnJta0hYSlVKaloxZUU3UTVE?=
 =?utf-8?B?UkhZTUpQV3dTTGE0MjJIMmhlMkZEV3RKYnhxa1dUQmtPSERVK0YzQXptcFJV?=
 =?utf-8?B?NGQ1VTlkNmNiV3llNWV4aVFqcWV0QVBxWnduN0FWbGdLSDJCSkNBUTJDRDRW?=
 =?utf-8?B?ck8rc3F1TVFRWFF1WlJETisxVWNQRG81SkJET3hFOEFNcVJDcXBVeW9BSDFv?=
 =?utf-8?B?Z09BdW85SEFadEhMMWo2MFpuQUFtRll3alA5R2I1eHJna1hzeFRtU2ZtUXFL?=
 =?utf-8?B?MFg5SkV6YzZJUWhTL3RDVUlDRVVVS1pWRnBialRUZXBkSjZmSXBBaW1MY3RG?=
 =?utf-8?B?TXcwTTJJcnIxSUIyQ0ZxSU0yeWFtdWxZWXVFQnlocjJoL2ZVREFuZENwTUxh?=
 =?utf-8?B?UUQyMTNOaUZLRWlCS3B2cFhUT2QrV2pnSzNCTmdyTjBIWnRDM2FYRW50cnNx?=
 =?utf-8?B?NmpreDBvdWk2TFM1QUE1end2YjJIdGZzYXpJZXZhMHkyTmJqR25WYUFBOXk4?=
 =?utf-8?B?ME5MYjlIZEhBaHlyYWRpWFlQT0pnYThxSC9XejhDcHh2N2Flc0VZZE5jOHdw?=
 =?utf-8?B?WmdPN3VXSWp3SDc4ajRKWUVSa0tCNU1EOUViUzcxK0t1WmI4T3Y0akNpdjI5?=
 =?utf-8?B?REovbU5EVjdENXFmTXN5MGN6R0tlTHBQK3pvcTJJRVJ1a1E5OGZZRlhZRHB6?=
 =?utf-8?B?cllVKytIWEc5ZkVmejAycFJFTlZiTGpLaGR5Ylp6ZXN4ZXBIU2hqNEFkRVBS?=
 =?utf-8?B?QnF4UkZsekdncmZ3OEFYMlpMVVk2SHZNbXVTeHZmdUhxc3lOSzByMnF4Yitv?=
 =?utf-8?B?d051N2trcTZGUTV1V2xNdTNGbXU0WXVETmIvVUR1bG9JQ2podkNQaFRqaTg5?=
 =?utf-8?B?QnQwdjZwWS9adzdadTA1WG03ZjVqWEpvVEExOWo2WXhuYkJGUHl1cytWQWhB?=
 =?utf-8?B?UlpLZGRWRXhrWlQ4cUlkWlFta1dqU1o0eHVTcnpqUzdtNVVwcVN1ZUJVemRV?=
 =?utf-8?B?NFZWZlFDS1hRdkkyUVpUVlJ5RDQ4bmloVFBjc1Z3dTJqOHI2UDkzQUVzOU41?=
 =?utf-8?B?dGhwUStTOFhYT2tXeitGZTNEdXFBT0FqVWpkZWlWRGIybFVrUk41K2pQQ1h5?=
 =?utf-8?B?b2xrSUcxNVRaRVF5cmc2cjdmZ3IwQlduQ0V4UVZ6Tzl3VWNPclFtUUJRQTZQ?=
 =?utf-8?B?UllMemllSXVZUTU5emZSaDk5bFNNaHlzMVRrM0hGNGIrc0ZwUkg2Y3RSYnY3?=
 =?utf-8?B?OXgzTG5Hb3NLeGdpNE53VFRuRHFBZXpsd1R1aG9QWnVveEZRbEtJb1NPZXNh?=
 =?utf-8?B?VmMwOVhYVWhCN3pmVXo5UWFaQTNPZ0pSbzNhZ0pKdCtuUDlLL3dSQm1zV1Zu?=
 =?utf-8?B?RFFQM1BlZFBaQ0dyczM2Um1IYzZlVlFZNC8xK1ZxUUdIdUY2SkxuNENJZmQr?=
 =?utf-8?B?aHUyOHoraXFySTlOSUF2Y29vU0FsMjhaaU1xUjYxUkJNWUY3QnFoWG16UlpH?=
 =?utf-8?B?Nmg4YVkzMmZpa1JVam10b0F4NGVtazlubkcycmRKY082ZGltbWlmWkR4aTJC?=
 =?utf-8?B?Wm41VDZZcHkyNDAzYlU3dnZKcERBbkRiRTVja015WjJWZSsweEcycHlJMmpy?=
 =?utf-8?B?S0I2OUJUdmxPTEE3Zy9ZL2NqZEhXc3hlUVBZK0ErclpjWXV4VU92OHhzaFZJ?=
 =?utf-8?B?dWtRQ1o5eUpGMi9OODdjOTR4NldOaldRaHNvOFpSaWZURllwUjJUbVZ3cytU?=
 =?utf-8?B?ckZMdVpuZnNvWVZJRHZ6dHQ1cjlJWmsxd1RDY1FyL1dmdTQ2VGErS0RJV3RO?=
 =?utf-8?B?VTYyaHJ1azNvWVZDTHFGZ1I2ZjNZOWxTUDBIa3FHZmpjb1RaZU94Y0Vya05L?=
 =?utf-8?B?L0ZDV1E4SVp3eUhpOThVWXc3QWljMnZzR3FZQWlEckE2MTZuckdSWWxrbGVE?=
 =?utf-8?B?Tk1hdTltQTFwSm4weUowdVBUSHU3cTRuaW9qMlZRZkVTYlo3RWV6TU9xTjUy?=
 =?utf-8?B?RnZxWi96MXJlUWFPZjNYbUdXRUp6UUdYeHFvRmZjRDFHVjhNS3hUV2Q3SG5B?=
 =?utf-8?B?c2ZUamxENnlRL0YxWWlvU3BJbmlKbXJ1czBMQnV1T0pFVVVtSlBKTmhscXVJ?=
 =?utf-8?B?SEE1azJVM1MxNzAwUjZ6VWtSZlpUUVlremw4d0NjWlpNa2krWlFlbmUrY3JP?=
 =?utf-8?B?dXNkUU1qeVRFOFdtc2VzWWIzcUNWSjZSS1pFc1d0THhIYnVIcDJqUSt2TnRP?=
 =?utf-8?Q?pszRx//cEWaL4um4PDp2e0N/FtfxmIs54zXlTtZdKdbix?=
X-MS-Exchange-AntiSpam-MessageData-1: VYCaQ0+gKPu7mg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b686e30-22f5-47ad-5709-08def6ba5d70
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:35:42.6294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaysC2AmeX3ew7SymiA4OlPDTiRBfPMRcJVL2YSeInMopdG/drH0puXkDzYK7bIC/YXhVPPA862wh2YHG9rGlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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

It is currently possible to construct a non-`BitmapVec` backed
`Bitmap` using `Bitmap::from_raw` that is larger than `i32::MAX`, and
it is not part of the unsafe requirements. Restricting all bitmaps
(even non-`BitmapVec` backed ones) to a maximum size of `i32::MAX`
simplifies a few things and matches `BitmapVec::MAX_LEN`.

Add that requirement to the unsafe requirements on `Bitmap::from_raw`
and `Bitmap::from_raw_mut`, and to the invariants on `Bitmap`.

This also fixes u32 casts truncating in `copy_and_extend`, which could
otherwise lead to OOB writes.

Fixes: 11eca92a2cae ("rust: add bitmap API.")
Link: https://lore.kernel.org/DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index a43bfe0ec3dc..0d481d761f2a 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -17,6 +17,7 @@
 /// # Invariants
 ///
 /// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
+/// Must not be longer than `i32::MAX` bits.
 #[cfg_attr(CONFIG_64BIT, repr(align(8)))]
 #[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
 pub struct Bitmap {
@@ -30,11 +31,13 @@ impl Bitmap {
     ///
     /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
     ///   that is large enough to hold `nbits` bits.
+    /// * `nbits` must not exceed `i32::MAX`.
     /// * the array must not be freed for the lifetime of this [`Bitmap`]
     /// * concurrent access only happens through atomic operations
     pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
         let data: *const [()] = core::ptr::slice_from_raw_parts(ptr.cast(), nbits);
         // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
         // SAFETY:
         // The caller guarantees that `data` (derived from `ptr` and `nbits`)
         // points to a valid, initialized, and appropriately sized memory region
@@ -55,11 +58,13 @@ pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
     ///
     /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
     ///   that is large enough to hold `nbits` bits.
+    /// * `nbits` must not exceed `i32::MAX`.
     /// * the array must not be freed for the lifetime of this [`Bitmap`]
     /// * no concurrent access may happen.
     pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &'a mut Bitmap {
         let data: *mut [()] = core::ptr::slice_from_raw_parts_mut(ptr.cast(), nbits);
         // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
         // SAFETY:
         // The caller guarantees that `data` (derived from `ptr` and `nbits`)
         // points to a valid, initialized, and appropriately sized memory region
@@ -415,7 +420,8 @@ pub fn clear_bit_atomic(&self, index: usize) {
     #[inline]
     pub fn copy_and_extend(&mut self, src: &Bitmap) {
         let len = core::cmp::min(src.len(), self.len());
-        // SAFETY: access to `self` and `src` is within bounds.
+        // SAFETY: access to `self` and `src` is within bounds. Both lengths fit in `u32`
+        // because a `Bitmap` is at most `i32::MAX` bits, so the casts are lossless.
         unsafe {
             bindings::bitmap_copy_and_extend(
                 self.as_mut_ptr(),

-- 
2.55.0

