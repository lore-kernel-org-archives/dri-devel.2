Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5E3FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB01110E359;
	Tue, 28 Apr 2026 12:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="D47eNbaz";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5745110E359
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXltW8nxglz/8pGGVKEqAzINM+QrWLdazdSPaQGX23E5mt9P/swQdpUqdM21yS3C7l/wWDcklkm8xoW0RUO2lf3kjakBR+DB7m6otHg16DpRkT+2A07bRMNGtKIYhePYbJZ2Ht1zqlNAH+ce/vzOSkLhbi+VpX6eGBRzlIKaw27vDBjMm8abphtN+UXiM8BxCl0P04yd2lLR6r8UxsLRWjLOo8MgICXPwPhYyrchUZ5i/cUdOO9PyGuZoqXs+8CiwlnFm8gStWYyW3Tc1D9WkdePU4RSjyTawEIH0ER3+aA5fSEVydDDjdTwMnXgUUC3LXqdGVpsKrrJNTS9h0qRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhOWJwII4ORqpVG15FHj9jAMQxJTGemYDQms9hqgNGU=;
 b=ZXsC194ZKvn9AgD7+AxxiEwR8OgY1ikQmrVIr7GZlpmPtbcT0b2LptqbHhQNTMMVL5V9jkVJUX6aGgw7+TdFp4h5FebBulZEvCQbU7+I+ef+HGtoUCVQ6vwQqNWUNOOz/x2i4eV6flcO+IAxotzlUgd3ysTxXSkMZYOs+SuBvKB7va0a+WHYYlRlnYfUePxEamUvPZ+aX7HNZhD2Wzp+3WO8siiG/qowaDyfqGQqeSjr/t61bcqB6d7pBy47WdlygQNxdXLBwIgY3VA1iRkCWabup11kM+9zKyEiib72JuEfJvJm8yVJr1+WEzFDHbFXG5wTxmfnfY062payrlSjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhOWJwII4ORqpVG15FHj9jAMQxJTGemYDQms9hqgNGU=;
 b=D47eNbaz1tq8WiYe6AF2UCcsBsURGYLI/Nq+olFfdv1rErqG6SGLY1hYoJH3iMBG+XCX6Qda1kxSBSKtgPJ0ykUZxPrmdDRqaDT754LbSfl/npIKJrjNyIgTo/sY8JsVtcHKiWswY+cZ+tZq8DFVOj8VWR5DXWEi9y69md4xTeJuPCMCcQi7gCHpjl2e0fjyg7aedCOxKSHaXchY/kha3V1KzJIVtFB/O8LpiJ6fCI1FBelfBAbad1tQI4KylbuoIfmo0N2kd9BcRE8XEfdjAFebAoO+/f48UDU9T3ApDi+wsxdMhtzwpDDk+403uFSMGgTiVYdIqZisFKd/JbEWRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 12:20:37 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 12:20:37 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 28 Apr 2026 21:20:21 +0900
Subject: [PATCH] rust: drm: fix unsound initialization in drm::Device::new
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-fix-drm-1-v1-1-755057178066@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyML3bTMCt2UolxdQ10TU8skM2NT85RUI2MloPqColSgJNis6FgIv7g
 0KSs1uQRkAFRFUWphKdCSEqiy2loAvgktqoIAAAA=
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
X-ClientProxiedBy: TYWPR01CA0007.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: be2cb56d-64e4-4d5e-124a-08dea5208de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: euzS+ikD08CIdBwM0advOE0XH2apOxjZe7up/A8Rj0HWT5L741PRh5ys1WiK2I1eaFeJLx1Rrww6XYHlRQnKmYOwF4Bl52g56/Y6mlHyFwGTwk8aoyZWu1cn/5UQS1gpQyLq0Ixv4F+qpBqYntuRM68ii2Tj5ssVBOD6JsgUef0UQ7ajrDLQ7zrA4l8J5wvAv/RmOuGCTXKBVkP4HAy3YPubQ7MFs4ZhtKG87KsMZjpVQLdMrsACDmwmiAPivX+idIRYQ1dNzi1bWyVbyTlz85HhgXVLeyuzLXDA1khIXctIa5SPrThl54RhGqYklOS/R4PHxYOL7uloDS9B7jbODOc0y/9oYVrxM0kE3A1peC+IZSJt8Guzqcrq5TlaMVC78gnU4nQbMyPn2PsncR3t1hnhcSoHSE04o4fZiU6tMzG9jgMMNAw9OO6u4sARQW5hJpGW4dqnVcEFHlIJTkQ/Zk9zogMWqZAjQ7dJX3HPFYpxRzr/L4i77Pqb2F6dMmjNE6Lic2i4fkyyegGyhw7mSzAzfh4KewTHotz1oyJGRhdOwyp1xvKPE5XHLrrvrBkwAIXnfRaNUWAVJKgnxioVhxrullw0zc2Q5fXIHp0qlwHam6ha6E1fnkAsXyevFRdQB/fvf+K0PImgRvHTBB10EVBt8/YS2SRyXKMoN42AtsqHPR9uqbHAzcbxikKnNRuFBEf1Y8MlGiLJtNZuwRa5NaOivXmad5Mcc+pwk/MNvfLGQGO+c8o4eXbOXgdIiW7pbkwfdHwggCAQE+MRRGaOxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhSL3J5eXY0MTZqNXg1eloreWM1UGNhNFR4TzRyY0x4UHZ4WnRETG5jaytK?=
 =?utf-8?B?UVpUZlhhSnFUcFBhZ21DTlZjcVR6U3RhSFd5bU8yMTBFR3Z3T2x5SUpCcGdT?=
 =?utf-8?B?ZVBtRHNqNHM0SkQxQjJScloySUJBN25IdzB5ci9vbTRPVXNmM0J3RjNHS1Ay?=
 =?utf-8?B?UE56YktUMjJxQjhWOHhnQ3ZpdXU0NlQzLzlJOWZUeGhiQzRYWXhtNUJBYkRm?=
 =?utf-8?B?VG9mNkV6Ti9jM2E3ZVhrQ212bXRtTjhJSmNCRFJwZkx2WGZZaDhVb0Nna3dD?=
 =?utf-8?B?S3hZMTdiZm5TOWlJTnR3R2xyWVNVM2ZnL1hDV3pnVFdrZmVzcmVHenN2aFFy?=
 =?utf-8?B?TW1iZ3ZRL1FBZWtWUkhhVEo1Tkt5NUx4RXoxYTh1aE5EU2N5QXdtc2lVbkJR?=
 =?utf-8?B?TkYvalRXY0c4aXcvQlpzQ3ZHQWhFdmxkTmljalZ0NzQwSUxiR1RlNkRWSGpG?=
 =?utf-8?B?N1U2RklEMmJLMXc3Z0cwYTZSZ1RVRWgxdWsyOU9YK1hKbkNVZDYxM3ZTMW9y?=
 =?utf-8?B?UWZHTjFpUVg0RXgzaXBjQUQyWU8wdUFnQUpqaXJLaEI5ME85QkY3Vk40OTJ5?=
 =?utf-8?B?dXMzeHBTV1lrbmJhb3NvK2U0RWJLeFE5NWpEUytmMlhldVRHTjdsb050WEo1?=
 =?utf-8?B?WXA4UmdtS25LT1YxcHNaWHlqT1Fsd2Fwd2NRdHV5dFZyVW9hY0NLWDlwOWds?=
 =?utf-8?B?TG5wNndzWEcrVjR3SUUwcnJsNFJLcS8yRDlUdXpCR0cybU5PdUJpUFpOTDZH?=
 =?utf-8?B?dGJiQlFlRHgveS91eGlLQnpUQ3VndWFzOFhid3dORThOQW5EaWkvOThKY0Jk?=
 =?utf-8?B?UWpxZFZxajV3MnNHKzIyd293Z2lxRk40WUxrN0NFN3RzVFBSalhScjRQZ3Nq?=
 =?utf-8?B?aEsrVVYzL01wR3ZHQkJSbkduNU1nTytYV0wxU3NlSCtxcVNTOGdQbzFGZk5B?=
 =?utf-8?B?M0wrL0VER3JJcm1DcHlnTTBFUmFManFzcDNiQ1BjVCtCTE90TllnNVQycmlG?=
 =?utf-8?B?N2NmRnpRVnQyQnpqOElQcFllcUQvajdyUG5aMWs1TFFXY25XMllLVlJlZkVR?=
 =?utf-8?B?K0tIM2VLZk02NHVxNDR1M3FESE05YTVjcWdKckJ2bXExbE1BQU0xWUNyUk16?=
 =?utf-8?B?WTFGOXMrcHdEOTllaWIySGZ0eUJXeGxrSHl0R2ErQW9NZVFmSmZOZnlvQyt1?=
 =?utf-8?B?d1VMU0puM2FrV1pST21LNGdCbU11eHNWRTZzdmZ6MityNFR3U0dXdG1tN2xs?=
 =?utf-8?B?TXF0VHlOMmZQT1VDVnlSbHhJejlEdm1yQ0Q1dFd6bkRTV3pmSkFNR0lxVVdQ?=
 =?utf-8?B?SHBmajdCbGJMTWNDZ3A2RGFrTEV2OEdkWDN0dC83eVRLTmNZaVJPQzhPOEp0?=
 =?utf-8?B?ZUhZbjZXSmE1VHh3MnhMRWIzR1ZBYktoMHk3eXpOUzVxRGpmU1JINHc1Y0RK?=
 =?utf-8?B?cXovNDNXTXdWcEVFdVVzQUgreUg3L3lnWC9tZjZia0pZd095R09NQUVmQnBr?=
 =?utf-8?B?SGhkMEpGQ0w5NEV2YXFjemk1Q1RibHM4TmhpNXMyVm5ncGk3ck1jOENOellL?=
 =?utf-8?B?QkZWajF0MFc2NzdURklvMDdIMW1oMytCbHZma3RhMm1TWVlPQ0JYNnVERFZW?=
 =?utf-8?B?R0Z2UE9FU2JISjlJS1AvSm13MEh1TFlGWlR4ZkJzeVpSWTFYRHY0M0cyR2Jv?=
 =?utf-8?B?ZjhFZUJRTDFkakxSamlqZ0dpdXRFc213Z3dCNzJLR1R6RTY5RUtlY3hLWVlN?=
 =?utf-8?B?WEZhM2lMUE11Ky9pUFhkRjVGV3R2RC9zc1d4TWFXQVZVOGE5Q1YwNEV4WFZY?=
 =?utf-8?B?b3cySEFxNVZsQTVZc1ltY3ByS25HVUdhdElOWDcwVTVnYXhTWW42cDdPV0xU?=
 =?utf-8?B?QmhHOXRvM0RtRWZ4MnpFcUJFUm43RmlTcUhmZzFwU1pvMG14emRhTEZzci9z?=
 =?utf-8?B?WG9VVjFCR3gvdEg3dGd4c3k4YS9JeEF4clI2d05idGh0cnJ3d0pPT0htWHNh?=
 =?utf-8?B?NUtNc0FwSkpWVnV5K2pEckswVFc3VnlHZTJ1TSszVldORFpJZXZFd2FkLzY4?=
 =?utf-8?B?STdMbVFxUVgwSmd5cUZlOGRySTJqYVFUTzAvd21NL205UmFiQThybGhENUxC?=
 =?utf-8?B?NTZHUElRaFFNeTgrM2hzRHB4TGZXSzhlOTY5dTF6MHlrS1l6SHNmcmpzd2I4?=
 =?utf-8?B?ejV3VXlnU1BhS3RrVFI4MGJjWW96TFRveDlhQmRKbVl4R2h3TmFXOW9YK3RN?=
 =?utf-8?B?Ui8vOEpxVkc5U096ejFzcG1xUXFITjZpQnNKcHhmTlp4VTZXM2FRbHFiN2dL?=
 =?utf-8?B?Qmw0YUVkRHAxcjJQZE1BdldFRU9TTkRDUU1lZnRFUWh1OGkxOWFIaWZUeDk4?=
 =?utf-8?Q?Pe2iFudOoPISPbhkFgk6xRNfbH095xWmmoVY4vzx7gWD4?=
X-MS-Exchange-AntiSpam-MessageData-1: ttkIXEgrYsPSew==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2cb56d-64e4-4d5e-124a-08dea5208de4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 12:20:37.4013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkARrkGt9BLc6/yuYpLwkviieseHnwJ8cu5PW6urQiqLgWz4JVlG9GpsqCY3hoZ0k/Hxen5Btf0remtScMHWvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
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
 rust/kernel/drm/device.rs | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index adbafe8db54d..78ea0eb12535 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -111,6 +111,13 @@ impl<T: drm::Driver> Device<T> {
         fops: &Self::GEM_FOPS,
     };
 
+    // Use a vtable without a `release` callback until `data` is initialized, so init failure
+    // can release the DRM device without dropping uninitialized fields.
+    const ALLOC_VTABLE: bindings::drm_driver = bindings::drm_driver {
+        release: None,
+        ..Self::VTABLE
+    };
+
     const GEM_FOPS: bindings::file_operations = drm::gem::create_fops();
 
     /// Create a new `drm::Device` for a `drm::Driver`.
@@ -120,12 +127,12 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
         let layout = Kmalloc::aligned_layout(Layout::new::<Self>());
 
         // SAFETY:
-        // - `VTABLE`, as a `const` is pinned to the read-only section of the compilation,
+        // - `ALLOC_VTABLE`, as a `const` is pinned to the read-only section of the compilation,
         // - `dev` is valid by its type invarants,
         let raw_drm: *mut Self = unsafe {
             bindings::__drm_dev_alloc(
                 dev.as_raw(),
-                &Self::VTABLE,
+                &Self::ALLOC_VTABLE,
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
+        unsafe { (*drm_dev).driver = &Self::VTABLE };
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

