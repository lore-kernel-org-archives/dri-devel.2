Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69606CD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 10:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7AB410E173;
	Fri,  1 May 2026 10:49:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Km0z94Js";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E8B710E173
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 10:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOR9HH7NhR3XYCCEwb8VOKJCpB18XCQDvFlXLEinfT1MVvKk0EYLVJzIWQq9RFFhGYSu7HYWQ90jNdL6owmvaaQlGVbJsAiFGBZfgEt1BmrTKiFACotIGVVPnDty0kyDGHBUQymRIQi5xsDWR994G1UagxEDUz4x7X0vEDdGxZ8NCx0hp3gi5XgyeSAWUOwhWJY9z1T8LrwMjkJyjJvoIJHTQel0iYeitcr9rplwKnXMklgFGnP7u3EB+0VFf8lqWmuXwqLRNCsq4YpUbg/HAn6WtM/FW7SgUUdJGMSXgyEbN9nhKHR8c1lirvf4EmxjQ3WLP6KVZ6S7COZfBHgKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gS86HNPIQF0TXKVywWGCmzCS0Lzs2Lc+FXdLAnnmE0=;
 b=NtcT4A3VPQAvfDoJSmXun/2kalM0XB9sHuAfAHko9SwnhWumec2ySIA/G3vkWBkIu0GqrZxeqLj8DV/yE51d03eABtXSIrSLDNpiO3cdwvNSVdyku3rHil7gbJ8dCW25KPQzo0PfTT1r0BnoxFFH3tuGrweGWXtTlL0URJadN6TFot/U2KtXmMMwsRJ1+P2hETYbeyzy8/mSmdnQ1jdl9nfIurfTePwqSjVCeDGGtGKWcTKmWwSWYimQRX8DUlVj5j4so5wUF65hIYtK9hYSk9eZXR5y9bWIcpfTRhrXFcjX4RUBtdUM3etV4cOIiXlCT9qEU99Ha4JxjjlLD9t76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gS86HNPIQF0TXKVywWGCmzCS0Lzs2Lc+FXdLAnnmE0=;
 b=Km0z94JsQcGVoBmJAUd1JFFUzugvYLWo0J0Uww/7hHgS1FZ80BUV33EF4LS+dHnQ+DwJ2fgJkdHoLJHkKW4VjDcflV9+tngAiEwvEU+PKy2Wpyuc6vRRaGkJ+7oALlsxwlC45hrwyP3Xe/CIIseoKJ9+ymC3CWwtw1pR+1X8povWzGwxMjy0Mbr26/+NjBa0E7etXWq53Lwbldh/VKtV04zvFPtVKxeaGXyveXhp9GxO5c+NU0ZPyMHEnpGSqXsL/b+YBlYuxWYxhvgGZZfCKh8WTkre7GXA+M6pX41oVaJZbDoARSqhGYSdLrhzXClo4gCArHrNawvd++5ubL6AyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 10:49:46 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 10:49:46 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 01 May 2026 19:49:37 +0900
Subject: [PATCH v2] rust: drm: fix unsound initialization in drm::Device::new
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-fix-drm-1-v2-1-5c4f681837bc@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ6CMBBFr0JmbU1baIuuvIdhAXSUMYFqC42Gc
 HcLmrhxM8mbefl/ZgjoCQMcsxk8RgrkhgRyl0Hb1cMVGdnEILnUvJAlu9CTWd8zwQp1aHSujEW
 ZQ/LvHtNxyzpXHw5Tc8N2XAO+hsfHlErGn9ZRGJ1/bR9EsW7/lUWRhlGKKyNMybU+DZEs1fvW9
 VAty/IG181alcoAAAA=
X-Change-ID: 20260428-fix-drm-1-459b6357de23
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::7) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa36a43-a80e-4f2c-0496-08dea76f5c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0M4lFJphDzhvC8MqA+wpMRIPBQagOMk8+DcfnnjC68r11x9Sp2l3Cn9eoCk5GVnStCxXsECWdtE3mAnVUKIMlNSgtS8CGJsygYtotm/QSyxiDUPO+iFqN6BYhvwJrFWreJ48erVj9W/tXsRxBW04w1lG8Zd1i4bAb09Yqs4cN6m5pBLh4o7EgTcaE8wL+j/XDKTYtBu6CNYAnDzQueuTzgVW7jRfdNmtUAo2kErXSAA2KlkBbf64YcMxSjV4RWZzYM4ZPUyyh9QL5SxTtydip5ot0S7lfnyZ2YQA2SXsXdXEOS6YQG+0ArbfiIIUaXeiAV3GMb3TwEWyT/p8x+5c2e2+vun8x9aM65wsTVkbRAx7feS3Q3sdJg2fmd/1oSzueBM0YeqlYxC4URcSzXJLqvxAWvbA6ueuMpec+pqNA8ZuJoM/BJtCx9MP9cuH5eaPQ4nUFw2QAAe8QCfZJ4B4TPBYhQR5VjU7oJrInmK9ybSBF6M4q96puIb7Kk5Q8F+GKVbyza4clHvrL7PbC43O9O9ISYWcWMbbW8Y0KSHopfJQP7oIDXhVWYYME2HDZomjzAH15MmWBrJjhIYDpeKLo7fF4AsI3hWE4gAgt5YOU8hFlXxCzYfb1fQGctNEX1ylb9Tcp9k7np5aMBrAYE5SsWdC5ea/OpK9OUHei3pSwkCdMXIbsKw5bpQhE7SZ/niyEDbjNA8gUkVCP0jXk+tUVBrHcag11hS358lqT/1gWqv2DGqllidKgaglxOO07DhK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTI5YW5CV1QyaEs1S21tMFJBOXZIVzdXNk4rU2prUy9TV2lvWVQva1dqL2Zo?=
 =?utf-8?B?K0hNYW9jbGNRZVp1dGZRUnIwRVN2UllYdmxUSWoxUFVTRmJwVDJFdUU1LzZZ?=
 =?utf-8?B?Q09XdThZZ1hBQ0VvRUIxWDloUkV0Z25DSzg3RFN0M2tBQnBJU1l3ang0QnA2?=
 =?utf-8?B?RkQ0clJUWGVWOHdUN0JMeWRMRWJqaXErWDR5dUlJNVRmL2dEUVU3YXAvcm9q?=
 =?utf-8?B?eExCb25OdytsK1kxMVM0SVlkMWVCK1VkNExqQWF3WHROR21FaXVCVE5YeXVj?=
 =?utf-8?B?S2cwMG5oeGlaazh4Smg3cWdveWlMcEkzaUFOZmE1VzdCYk5vaHNOTU9RTDFB?=
 =?utf-8?B?QW1ocXc4UDNWNjg0NG8vMW14STRIbGpqMm1vQ2s1UllzUVN3ZGFKbkVEMzNR?=
 =?utf-8?B?eXgxRjBoNFZUMXlpSi9DMFUvcEVQdlA2ZGtkMGdMczNJN0UzK2JmdHhzMzZ1?=
 =?utf-8?B?RHdLR1R4bGVtaEg0MDFob2NYbDdvSzBtNVVabENZTVA4N0dkVVR3R2NkSGw2?=
 =?utf-8?B?eWpBRTFFYlo1Qms2cm9xdVZyTGQ3c2k0ZUJFWVlZcjB0R1lnbFR6dk1WY2VH?=
 =?utf-8?B?TVJjcFRYRWZqQzU4RUQ2cUxxRUc5WUMzRGRKVFVUZ1NudmVyYS8ySWJpcXBW?=
 =?utf-8?B?KzVDRzkvQnFNUlg4QXJQbDlHbVMzbnhTVmdPcUFDSDZ0NWxaa3FyYndQSUUx?=
 =?utf-8?B?bU1ydDZHQXFSOE5Lc0lucWIyNis5Nkh0NXl1QWxZeWhsZFZrQWxJYkFHRnFt?=
 =?utf-8?B?cFJzZzJpQ1MrcURpSnh6Nm1LYStNbkZYWVFhMk5PMktkRUpHTWt3cmdodmhY?=
 =?utf-8?B?OTkrT281bFV2a3A3YVRYNllwWTlvMjNsQ3NQS01xRHd0Z1l1OXYzc1JVWis5?=
 =?utf-8?B?Z3dBWThWOENlYWNDOThCS0Z0bGxqWDhnVmVOcHJFRHB1V3N1bmFCZTNaT2Zz?=
 =?utf-8?B?M0kxajJVMTl0c3pORzNXUW13Mjk0TDJLZURlU3RXVURQREJxbm10YTdObGgr?=
 =?utf-8?B?b0kxMzZBaWZYRW4wajFEb3ljQ2ZIQ2dmckRsYkVlcmZWUDRRRmpvRDVqRDl3?=
 =?utf-8?B?Z0RpQmJ2UzhWMVFFQlE5aWl5RWNHM1pjQU90aUhOcUxoT0NCREVnZmdqZzcw?=
 =?utf-8?B?bkxPL2FJWGd6OGtCTlVGWEM0eG9zNUdJNDJiNE5yR1lyZlQ1amRBaDcyVEFC?=
 =?utf-8?B?WDk1SGFMbXNqWFdiWkVaczFLQ3VKaWw2QjIycllNVGg5M2N2STVXNm1KMnFJ?=
 =?utf-8?B?a0tTbHB6MG1GazlsOThURVRvL3hYMVJlQ0tEV00xMnBjWHUwTmZYMWpjWFBB?=
 =?utf-8?B?OU9KSG9wb0tmQkFKRkRIWU1nUmFQdk5LU0VJTEU2enZxd2d2emdPL2hMbktJ?=
 =?utf-8?B?VmViaGR1bU0rZVgrOEZNcDNEdElYZ0NkcXlGNDF4bVVtUTBYN3VrYVRwOHg5?=
 =?utf-8?B?cFVNQ2NOS1FKMytDYm1ldTQxMElTSDdUL2dqbm1NVUlGclV5Y0VOUkQxOTM3?=
 =?utf-8?B?UVYzcnVPd2tpbFlhYnQxY2l6bWlRbWhuZE5EN3lYNVR5OU1SL0RjTEN2cFJF?=
 =?utf-8?B?RndyZStNYVpZUjFJbEJneDkrU0dvczFML1NnTnV0eHliSWs2Z29EaEJaOWhU?=
 =?utf-8?B?ZXFCb3pJY3ZuOUxYVzBUclZyTTZyeUdLeS9XOW1SOUd4YlkzSERqbUJ4MHo4?=
 =?utf-8?B?WnVBeHkvcCtCd1VuS1dCSk44ZVVGa3FXRkllRk5oTDRtRFdyQk5GR1E4THp5?=
 =?utf-8?B?RTdycE83VW42NkRMMVZ2aDNrMU5CcGh0SG5pTmVXQlYzanZkcEFwSzQ4aTdW?=
 =?utf-8?B?enZYcFV1SUhneFl0UnErWExMY1JMaG1qalJlTDRnaHZYSkx5UURVeE40aTRY?=
 =?utf-8?B?a3IxTkRaNzNTQ3crbEJQR1V0aFNWeXNGL1FGcUN1c1lZNXR3ZVlvRUFFNFdQ?=
 =?utf-8?B?aXYxcFhIUWdNaEUzbUswOVJyVmg5eS9WaityMjdZZzZld1BhWDBOQnZaQ1cw?=
 =?utf-8?B?ZnhyN0xUSEVaSzlGNjFZenZ1T29ENVpxWG56Yit0RkllVlBnbnUzSEFWbmhF?=
 =?utf-8?B?TmE3ZlNFdWQwWm1BWFIrOWpHMk9ZQUc2Z04vYjJPcGdUYVM0K1BtMDVySkJs?=
 =?utf-8?B?eTl6MUNUb3krVyttbXp4ejB0bVZERzAvbkV4ZEVkMVNGUlZMRlFKY1dZbWp0?=
 =?utf-8?B?VmhxNUxTWkg5U21mZXRhZ2k1TTBwdnAyRHZNcGliZFl6WVYwdE1saHhmT2N3?=
 =?utf-8?B?V08xeCtGa3RLRDlVTXowMmtTeERsTy9oTTE0MlUzb0J3ZW5kVHUxUXN5ZXZT?=
 =?utf-8?B?dGdzVlVwcjYxT3VkeVpLTm1meVRCTFliK0Ftd21tMHlWekNQVGlDbWdQazky?=
 =?utf-8?Q?04R4PC5iKrWKQudmis6CQsT2YctIfMsegCq9L50Xyw4rt?=
X-MS-Exchange-AntiSpam-MessageData-1: 4c77qHEvMRRQzA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa36a43-a80e-4f2c-0496-08dea76f5c23
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 10:49:46.3536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sVnKdWTpvHs8xiBAuqML0vo1m+fTYK9B9d7O1Tm605pmNLT9wS0VXwk6BjsJLnB1bLfINhwasYZzAILrIXCgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

If pinned initialization of drm::Device::Data fails, it calls
drm::Device::release via drm_dev_put. This materializes a reference to
&drm::Device, but it's not fully constructed yet, because initializing
`data` failed. It should not be dropped either. Instead, if pinned
initialization fails, make sure drm::Device::release isn't called.

Fixes: 2e9fdbe5ec7a ("rust: drm: device: drop_in_place() the drm::Device in release()")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v2:
- stack allocate `alloc_vtable`
- use const { &vtable } trick to help prevent future issues
- Link to v1: https://patch.msgid.link/20260428-fix-drm-1-v1-1-755057178066@nvidia.com
---
 rust/kernel/drm/device.rs | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index adbafe8db54d..403fc35353c7 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -119,13 +119,20 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
         // compatible `Layout`.
         let layout = Kmalloc::aligned_layout(Layout::new::<Self>());
 
+        // Use a temporary vtable without a `release` callback until `data` is initialized, so
+        // init failure can release the DRM device without dropping uninitialized fields.
+        let alloc_vtable = bindings::drm_driver {
+            release: None,
+            ..Self::VTABLE
+        };
+
         // SAFETY:
-        // - `VTABLE`, as a `const` is pinned to the read-only section of the compilation,
+        // - `alloc_vtable` reference remains valid until no longer used,
         // - `dev` is valid by its type invarants,
         let raw_drm: *mut Self = unsafe {
             bindings::__drm_dev_alloc(
                 dev.as_raw(),
-                &Self::VTABLE,
+                &alloc_vtable,
                 layout.size(),
                 mem::offset_of!(Self, dev),
             )
@@ -133,6 +140,10 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
         .cast();
         let raw_drm = NonNull::new(from_err_ptr(raw_drm)?).ok_or(ENOMEM)?;
 
+        // SAFETY: `raw_drm` is a valid pointer to `Self`, given that `__drm_dev_alloc` was
+        // successful.
+        let drm_dev = unsafe { Self::into_drm_device(raw_drm) };
+
         // SAFETY: `raw_drm` is a valid pointer to `Self`.
         let raw_data = unsafe { ptr::addr_of_mut!((*raw_drm.as_ptr()).data) };
 
@@ -140,15 +151,14 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
         // - `raw_data` is a valid pointer to uninitialized memory.
         // - `raw_data` will not move until it is dropped.
         unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {
-            // SAFETY: `raw_drm` is a valid pointer to `Self`, given that `__drm_dev_alloc` was
-            // successful.
-            let drm_dev = unsafe { Self::into_drm_device(raw_drm) };
-
             // SAFETY: `__drm_dev_alloc()` was successful, hence `drm_dev` must be valid and the
             // refcount must be non-zero.
             unsafe { bindings::drm_dev_put(drm_dev) };
         })?;
 
+        // SAFETY: `drm_dev` is still private to this function.
+        unsafe { (*drm_dev).driver = const { &Self::VTABLE } };
+
         // SAFETY: The reference count is one, and now we take ownership of that reference as a
         // `drm::Device`.
         Ok(unsafe { ARef::from_raw(raw_drm) })

---
base-commit: d9a6809478f9815b6455a327aa001737ac7b2c09
change-id: 20260428-fix-drm-1-459b6357de23

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

