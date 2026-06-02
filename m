Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75395CD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6EB113A5B;
	Tue,  2 Jun 2026 14:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="j1siBBjF";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B295113A55
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehqcGu9ZFVkPh7NRJJ4Dpp+vFWpnwNzwDQboS4zZ0vUL1imDNTmb5ezVoEjFpAAeiX0TqemCqh+UWjmLCkRtarl3W76hjTN2U6oNgQw2OXX42E2dlewNR8WuhVJ0KPGPBjb7cIPzxG/QyE/gxePd0ZtJjTBYbw5v6da5AXfdyoufcEeisnhY+WowBk+NR/BXB5h9HkQjV1p3qvRr9fwdUPjCnWY6+VbSL+4M9RSf9knrU85sposfLcMTYIdSycMig81jIkYlalTuxGbU9kKPLVpO6fhW6l6/ld4Bq0sbyjsCHMCbkGDHASA+GJ6w6uoRqzCZdQOg6BCeT2r/91xtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzPUAs5MBpx8tth380XTpOt4FWUkDAjeEAs2cl0quBM=;
 b=f814kXzyGJstceaRsj8CV5v3zWpGIp8NFcWsaBwqLHP45Lt5Exrc1OAlcGcef8+YJOSZvxK2eXSn3Na+kqu2EJv3ni4m0+7ISUQAMS/KBDYi9bQhMtni/mdTL7mu+RfXkYe7Oedmxh5NwfiPe1NZIELKx7vysij0mSnY+EHJq/TY6pSmakGfg0ku00LH9rJtQTeuHIEIEPAWV/Ob/5xHwqDbAWDRL4KtQBA07Ck9gFM2yGSXAqGTqMjffFIwXGPJE5TD4VpU4OOn3DaNdvmzI9DeDQotrJFdm/OZ070SSvewA9rUAzNGa3l5zaFNymSqShnCapOMJp+8SSn2WzTf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzPUAs5MBpx8tth380XTpOt4FWUkDAjeEAs2cl0quBM=;
 b=j1siBBjFmB4vNOozGOu7DTeaMT8c7sy8wqps33qGVzuRDYFBNU6ViJLcaZvKQ+lqzEOtTpNpnrXIvSZRwoaLa8d1o1Fz06rLfh4d2zzYPcU3qKE7aycES95y8JYMnxth6cq1EVt/MM970sNw1qe3N7i4wW9mQytdFew3Dn8TO0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3626.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:18:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 14:18:02 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 02 Jun 2026 15:17:52 +0100
Subject: [PATCH v2 1/6] rust: ptr: rename `ProjectIndex::index` to
 `build_index`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-projection-syntax-rework-v2-1-6989470f5440@garyguo.net>
References: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
In-Reply-To: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780409881; l=2897;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=g9OtVD15PZdi1rykkPPp2c6JTPHue348sNKr+bbfSiY=;
 b=Sa9uZs1AhC6pjwEtfrdWVEzvHowTaLkiMfCateb8ZlWvssfdUv4ZE7b17TZmN3NQdUCt2PaTu
 9Pwd9fp7CoMDierKsVMhmoEmr7cXX23rbEs8NIOb7msptYFFxEK1sXH
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b80ff5-bcaa-425d-b68b-08dec0b1c173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|22082099003|18002099003|921020|6133799003|5023799004|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: cfG95mv2t7CRmeHQoty4b/y7ktZfJk8RSA55oo/CExHnEq+bJRiR5rNhFAFMybWKeHZ3mtbQUFKO0LwMVTW2A0IWVK4Q/hqtU2Cu114bmMqeiftxkUtsSCOEMmYbTc0OAn3cI1Lhj3nM17ee/oCJTHf8X09SrhcLELXecLc7imy4sEYsrWxfO0srru/IsS6PgAzIudBU9zS+yp6WrwijZ5KtOqVJQTN0B957qjqZdlJVnC5fQySOE7dJEiNb52zjiTtR3EPYKouhcB0+FKvT5mWkyJwxK5vonHzBVIpUZ/vFifyhHpzFLGZVP324k3+zxcWK60Z1Cc6dNxCs+m5lbMEf+51VnwWN3QlvHUb2OuYiJNz9OnuBvz5ROphD01T9wBVbuiP6VWjFq9ZGfEJMuxppyPFfUPBe1sTQpo22quMRN4aqo5M+XfcfO6z1MIzIOoPD8m6T3slrZfKY4F+8j2sdNb6it8mvc2b/vOh5J53WKdkqAy4OGgF0fiezMuXiICgcrLJM2yE7ArZErgP7bgRnRbYNz5X/mz1hpWfHzikDl2zFYOmnRfzsDPK8/ye75PZ0g/09Jf7xcEAr+z8tI2o5CcG5nZJaiK4Da9AT6lPx0lelpv4psaQZwvJQ64OfEv4BjUS3LAEkqFlU9cMqM1OwuIXIc9LTL1ARlSOOfGWJsW5xV0Nea9/EXXN45OVCfdgjGYy6o+4T0sMMvw8XOuuE8I4Wm8FFpaNhOO904gw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(921020)(6133799003)(5023799004)(56012099006)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZmRkxBQldrU2oxbjRDd01QNktNU0RQUHBHQWJTUkNzcm1FcjJHcG1oSzVm?=
 =?utf-8?B?QS9QaGd0c3k1U3JySSsrSExnRERKbnZCWGtqWFZqWEZhTEtoNkNFcHNNalJZ?=
 =?utf-8?B?ZytzN2RTazhscEM5YjRid2NCdFVpUVEzTzlMZGxGQW8rV2dMWmdodVNQMzlh?=
 =?utf-8?B?L3pEVk9vZ3BaU0ZzWEZhNmlDSmVSeHFEeFREMTVwZ0s3SGh0NHlKZW1xRFdF?=
 =?utf-8?B?L25wUkVuMDBZaE9tYng4VTg2NzUzYnBDMDVMa0ZOOWcvSTYxS0tOOUs1dEIv?=
 =?utf-8?B?bkxBcDF5NVRMeXI0dkEyL1RaM0pHN0Vra0plYnFJVEIvamxkV2pha0VRY2pH?=
 =?utf-8?B?SkNsbWFSbGdwYlFQZ01jbW5Ib0JDMm5oMzRmMWE0VW96UTZ2Sk51YmhlV1Nk?=
 =?utf-8?B?MXFJSlJrZWFRRkc0K3V2Znh5czFjb3RjVnBHTXRiV3hPNllzOWsweTYzWGlq?=
 =?utf-8?B?WG8wY2xXT1R6NzcrZldUNDJXQnZaOTk5Q3htMlJRN2tSTFdqTjVSTkV2blRC?=
 =?utf-8?B?MUFWeE5BdEF3TU0xTG9XSTNwb3RvZlFRNlZiNzYxb1J3Zkp4TjJ0clVEbmJS?=
 =?utf-8?B?bWFEYkpJTlRuUWZnTGdKenV2bUpaY0VHMm1PWVBueGgvVElXVitkRU9JbDk5?=
 =?utf-8?B?TUQ5SkFReHBSMldvSXl5TXY2Sy85SFhObHVBVy9lUmNXbG9OM25Bcm5FcGJJ?=
 =?utf-8?B?Y1BIYjQ2dkt5NFJ1YjYxempWcTA0K1JnUDNjc0pvSWhuYzFDMDh5R1dwME9m?=
 =?utf-8?B?b2NhNGx1czE0Z2NUTit0NkJBZnBTUkNabFVXeG1kdkUwd3dUQXVhNHRtTWkz?=
 =?utf-8?B?Z3V2L0JDaFUwMlM2ZlN1Q3Y4S2hTOGhwM2lYTlIvNnZOWHBmMXJQZEVNampk?=
 =?utf-8?B?eHViTUVsR3h2Rk1uNVF2OU1xZW0vUFVNMzRtZDB2NVcyeWFLamdzTnpjbHNB?=
 =?utf-8?B?ekd5dFc3VmJOMHhreGhVQnpnemtwRWRBakY5Z0lzUGdpQ2k5dktVL3FLZWNX?=
 =?utf-8?B?Z3pFQWRwYkl5czIxOHozdFpUV0VDQUJtK0cyL3duY2JEbjRmYk5mRUR5Y0dN?=
 =?utf-8?B?cnRnL0JRZ1FVVUVDeU9PZFc5a3dEUHRNWlJITDQraG5hNEI0MlkvbW1NMjNS?=
 =?utf-8?B?NzJwODN5NWFFRVZUUHVwSlNzUWduUFRLM0hqQzVibFhpNkRWendtTVVjbUNu?=
 =?utf-8?B?RENCSHo3UHZKUXJ2eXdwb1c1L3IyNFdibVlPbXlySFZFeXhDbkplWDhXV0hk?=
 =?utf-8?B?dWMxdUQ2T0tGYU1QS3EzNVdWejlOdzZQQUQ5WS9Gdm9OeXg1WklYL2JxMXZm?=
 =?utf-8?B?elBaaTkzelJzdWhGMWZEUC9iNFVla0p3TTNhMmNQRWt2ODZtRnI1bHdYWHF4?=
 =?utf-8?B?d2VqS3lCK3BpdG8zN1dFcm4rWTZ6c083VFc5TGppekZBQWV6NTRFc3NLMUlv?=
 =?utf-8?B?M2dNUWoySlhvSjBNSllGSWxzSFlTUDNwMDdNUGluZTJzYVp1RjVNVnc2Vnor?=
 =?utf-8?B?d2JRbVlOTU8wL0E5UjQwR2FJVldZeGFid3JiM08zNlJ2SjZMYXZ6TUdzWUFi?=
 =?utf-8?B?czZCRG9CSU5lSXFUYThTQnJyYVRsQXVTNFphVXlMSkNhZ0pCMmUyVUc3ZlBz?=
 =?utf-8?B?QnkxbkgyN29FMVRmZlFvdEFWK1c5bWhMd3piTHhoQmF5VFJLSDhOQTBQSkJD?=
 =?utf-8?B?RWE3a3B1c3VDUEwvSzd3V2U3VXh5MUIrOTJ1ejRsNWkwYWhqZ3U2VGJkMU5t?=
 =?utf-8?B?MHZ0Q21hSEpqdjQ1QXhrVzZ4VlFlNTJYb29aaEJJVDVsdE53NGF2RzFTSWx6?=
 =?utf-8?B?KytVS3B5OVJ0Sm5PeWtQaERWMFp3OTFhSVBhRDJFc2w2bnIrZ01kRDZmMmlY?=
 =?utf-8?B?VVU2YUdKc01DVys2d0M3dXNESGc2bjhTYU5BTlAxMmJZZ1BSVVFOckRaTFcx?=
 =?utf-8?B?VVY4Mmd2eGRTbC9ER3V3dmFZa0pKd21YTFRqZDlMN2UxSE9hbC9lVTJHTzJo?=
 =?utf-8?B?OTJ6OUVVZWpKWktGeG9seWpOMmpnMWFISnJTMVorT1E3ME5vTVVFWTA2L3pZ?=
 =?utf-8?B?bFphajZjVlhKb0xLYmhjajVoaHdsWEFVUndqeHVCWXNWaHVEeWVtNk9CS01s?=
 =?utf-8?B?WTRuTWJHZ2NTd21vU0dLdW9DL0N4UnQ4VkNyYW5QbFRsZjNJbjF0dFNZV3VD?=
 =?utf-8?B?MWpUaEZ1VlFWQ0VIYS9DMC9GUEhNTHphbWJjYUF5bmNmRnhIWGpUQVFqN0FK?=
 =?utf-8?B?NUxSajl4blh2NFBpM0Eyckt0L2lScUs2SkRMOXRBUFpMVUlPT1l0bXNRSHM0?=
 =?utf-8?B?cWRHemtJb1Y2bktFMHlNdHc5cjZ2bjVXRGp5TElVYVdFMGJxNUh1UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b80ff5-bcaa-425d-b68b-08dec0b1c173
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:18:02.1082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pt/sqalNRCvgwEvfuMKlm/dnNoy8YiXl1xwWDIC+wcDnNDaVmcwTx8Ysm7VTdYi5+7nJm30gT55yVWDNl/w52g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3626
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

The corresponding `SliceIndex` trait in Rust uses `index` to mean the
panicking variant, which is also being added to `ProjectIndex`. Hence
rename our custom `build_error!` index variant to `build_index`.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Link: https://lore.kernel.org/rust-for-linux/DI5LLN2V3XCS.34H4CG99N4MPA@nvidia.com
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/ptr/projection.rs | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/ptr/projection.rs b/rust/kernel/ptr/projection.rs
index 140ea8e21617..fbe172e493c2 100644
--- a/rust/kernel/ptr/projection.rs
+++ b/rust/kernel/ptr/projection.rs
@@ -26,14 +26,14 @@ fn from(_: OutOfBound) -> Self {
 ///
 /// # Safety
 ///
-/// The implementation of `index` and `get` (if [`Some`] is returned) must ensure that, if provided
-/// input pointer `slice` and returned pointer `output`, then:
+/// For given input pointer `slice` and return value `output`, the implementation of `build_index`
+/// and `get` (if [`Some`] is returned) must ensure that:
 /// - `output` has the same provenance as `slice`;
 /// - `output.byte_offset_from(slice)` is between 0 to
 ///   `KnownSize::size(slice) - KnownSize::size(output)`.
 ///
-/// This means that if the input pointer is valid, then pointer returned by `get` or `index` is
-/// also valid.
+/// This means that if the input pointer is valid, then pointer returned by `get` or `build_index`
+/// is also valid.
 #[diagnostic::on_unimplemented(message = "`{Self}` cannot be used to index `{T}`")]
 #[doc(hidden)]
 pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
@@ -44,7 +44,7 @@ pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
 
     /// Returns an index-projected pointer; fail the build if it cannot be proved to be in bounds.
     #[inline(always)]
-    fn index(self, slice: *mut T) -> *mut Self::Output {
+    fn build_index(self, slice: *mut T) -> *mut Self::Output {
         Self::get(self, slice).unwrap_or_else(|| build_error!())
     }
 }
@@ -64,8 +64,8 @@ fn index(self, slice: *mut T) -> *mut Self::Output {
     }
 
     #[inline(always)]
-    fn index(self, slice: *mut [T; N]) -> *mut Self::Output {
-        <I as ProjectIndex<[T]>>::index(self, slice)
+    fn build_index(self, slice: *mut [T; N]) -> *mut Self::Output {
+        <I as ProjectIndex<[T]>>::build_index(self, slice)
     }
 }
 
@@ -287,7 +287,7 @@ macro_rules! project_pointer {
     };
     // Build-time checked index projection.
     (@gen $ptr:ident, [$index:expr] $($rest:tt)*) => {
-        let $ptr = $crate::ptr::projection::ProjectIndex::index($index, $ptr);
+        let $ptr = $crate::ptr::projection::ProjectIndex::build_index($index, $ptr);
         $crate::ptr::project!(@gen $ptr, $($rest)*)
     };
     (mut $ptr:expr, $($proj:tt)*) => {{

-- 
2.54.0

