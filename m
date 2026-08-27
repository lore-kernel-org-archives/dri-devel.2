Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5239DC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837F910E3D3;
	Thu, 27 Aug 2026 08:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8L1LG5O";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB0510E3BB
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZ8XHp8WRoFGrdoC2OhEs4wt/uWkc1Kk7B10LxY1al0mEkPKhZGSmi5ByngAgVpdIOu+IRkTvCwx8YDZMspssikOCf4sNAROOPKilil9G28hUkWqvMfWqOkUzqo6FeYK4QK1/PAxL6byaCdGvW5e/gklpWuRX21s0UjWFFVTZdaYe2kDt59K27X5+bGYO4xLGDXu7H/B5PpbbYfGd1hFXEOA/EW6icRnK+FtpljXpVzh75e41fnGr7KCgjVsPkcDOBeC5qM4BgTc/lvdOmK0ha6xj+9fmnRr4CHPxwsrG456VCzWoM+m7F+mPU06qipL2pGjafKctRJLiL353fXpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGOBl5a/xNWCXmOTaWTF7DxH9KJC5yYDPccNRx+MRTQ=;
 b=evUZRPEylUqOG50CNf6YahpFFqJIkVSfCNQQ8Izx1xWI00XDRkD1aHujqiJUIGwFOc+voMJpxlbr47xz0fPPT8KZhjuurn5Est+o0uZACcZY0mwHIN8w6Pf/YjSV+28L7IU88+FfiQWr5CqBrIN3uCpdaLOGpxMdSZME/sN+U+32sXONjn5zD5rWOnmdVpKinR8hPQgsXnXq0DWFrU7yShZaGKCppNwbiU4pB8qV2BDwrVs3bxvKsKtiEQLbsdgn/6d+rYXckMI+7eAxJn6kmCZM65c/5H4jsDsvRDhZF7FduWxytwPALRRh+IvwrnP935OkKs4bb/BzvP0TrpYV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGOBl5a/xNWCXmOTaWTF7DxH9KJC5yYDPccNRx+MRTQ=;
 b=H8L1LG5OgDoTDuRpBL3HdcnJ785O1BIVLMz6EtSMUM8wbS0ivQSCWFye0iNLBmqaCD11mJvVcAvcNikBz27DZeW7HwKKXHChAF4GPtWeiphwrAkhVpJ0k+XIHTn9b/xq3db+TJahzL31gu0HMeUzLWxpI8KU8qnoksILZOUukxDBasgy+wbAmwC1PvXlsJ+fwLn6R+qN2s+OS53bIF3VLvBnk5fURJcPgUPklTYZFv6hwQV8igu5aF4VqHdMGi0R5p14AGOHPaNoUS8rZG02xNI3SfD01dlw5QI6tWvWgVfDrIFgRGpK9VqAhEENwUwLm+eLJonyPDiiaR+njd9v4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 08:52:15 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:14 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 17:51:43 +0900
Subject: [PATCH v3 02/10] gpu: nova-core: mm: Implement Alignable and Debug
 for VramAddress
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-pramin-split-v3-2-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0164.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: b8edc9ec-8ae4-4969-1235-08df04187d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|921020|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: bN0VPluATqLzskMX7BpqTKlVDSwGGu28wZrXkMXgxqThQgC2cwrwmNr4Dp9MNUqEMe4hn2lJmczFpM1FslcRvdJfG+EUyeekB6x38Ffabc/LydqzGHEHOMNY8xpNL/GNrrTkCR/Le8pibpS9LaOMPQ6C19l0vmoybxx56WcC9LRtNqtF/K9+UENmzIHXeGW7ArQMch+cepbRseJtNnWKSAuMo5gtLfVmLoC6cE2BddQgoICmM05qhprJFv1NGgubV95L+p8cehEPnmhyZGeRo9tE+9rvE7RSH+Q62QuyTabgLHJ9KywQyyn2Q7yI5mOsLSQslaS4SAbHjZlYugqkGKs63u4YedZ0ABMZeEqZgDS0JXtteyh7rmAW/oLQzGTV2jrJPcaEui2Q+kwkc4Biqlo4aPVC8ZKEWsbt8j1lleuyk7KyaWeUq4+LUcpTjOyBcdIdR8NvZrxL/uU+DYfktbyqjbLeNWEDQ9MFPopqoZNCKbcP95vZsVxfE3nboYV2fuCWCTKqI5zfNxEXaFI2/ytrzoNmYzIQArBJ/BOT+qW3frMDnwoawegp1KvbEoa/aESn+psEYOLK9T01a+ezr3frUsGhjOHsctTIjt2B364xpq1LEw+BPooyeDes50CT6Xj1f9PvcNs2hNdJ7Zc9c8waUg68toRHsUpFtwSQk1VPGDQqk6YSgmr3LcOZgd68zi5Fv9fCOrYoqsMzqliwqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWh6WHdRZEhoRU8zOEdSaW5pU1cvVDlFcW5JNWJIVUVETWpSbUdCdEJrRVUv?=
 =?utf-8?B?VzFlcEdTa29LM3VET1hrK0xrb2xQWWE4QXYwd0lxcktDUVpabVNUeG1WQXpB?=
 =?utf-8?B?UWJDcFd4TzhDQ2E0RHRScWQ1cGJheGMvajRSVkMvc255RW9vNGpnODZlVnhk?=
 =?utf-8?B?ekV4bnQwRTFmWVZmWHdockRoWDMyY2VaSFliVEw3UEtsK25jb0sxbHNGdER1?=
 =?utf-8?B?Q3NBdjRSSU5UczBCWG5neHUrd2FScFJpYlF0SUN1TEpsSTVXMFl2UWNINUM1?=
 =?utf-8?B?a1M4d1NjNmNQVHRPdVhQb0ZPY3NRbjdkR08xZlM4clZCYW96eEh4MGxGb0tC?=
 =?utf-8?B?cFlhbDU4dTlYTWp1MHpuU2tKNXlLcXhYZmE1dWpGQUt3Y0hWSUYxM3B4azAw?=
 =?utf-8?B?cFV4TDFpQ0t3VGxnV1lvd0ZicHc0SkZESkJPbmVLK25XSHIxWXdoVE9HY2Zz?=
 =?utf-8?B?ZnR2L285Y2Vsd0lVL3ZGSHNFRlg3ejJvWWxYMllKcmNmVVZnVmxRR1FuekZW?=
 =?utf-8?B?S3dObS9sSDVmeGxCb2I0b0cycUR5QzE0Q0I0L1E0dS9IeGxVb0tXZ2pudWNB?=
 =?utf-8?B?aG03TWZNbkNFLzZhNS83M3dkY3MvZkl6clhaaFNYakhoQm11d1RoYUp2OTY2?=
 =?utf-8?B?NytpUzU4TmRZUWoyaEdVczV2c01FK3E1Ylk1c0FadXV2S3BDdUx2NzQ1dGJz?=
 =?utf-8?B?S0tuSGN2WnZlMUtqb1lnbTBVY2FZaW5wTm9mSkQwWDc3Z2Y3QXcwQ21BaVFq?=
 =?utf-8?B?Z3Z6Z0dLNENubmFyNUgwcUltVm9nekJUa3pJTEFaWFQzSVVhbGN5aU0xenBH?=
 =?utf-8?B?bVY5Ly9EUk9ydWNYbUpGbENVWUUyVGtxb21Vd3BGaFptTXJXellMYytNcGJ3?=
 =?utf-8?B?R0JJc3Z0V1ArYWZMR09CZHNmTVpkNUpqSjN1L2NXR2E1MHozMmlYM0FydHdE?=
 =?utf-8?B?a2dKcWdMVnJFTC9FdTRQSjdldUs4Ui85WDJkRDNjQjE3RUdxK290M3p6MGl5?=
 =?utf-8?B?WG1Vdm9MWGsvOEhuL1J4U3ZjUWFlcTg4WXNSeFJTblBrRGRMeE9PaU5kSVJP?=
 =?utf-8?B?YW50Rk9QSzYwSFpWbEVlcTlGQjgrQjBJRzd6b0J1bjRPcTNOQjY5K3UwQTFZ?=
 =?utf-8?B?NFFJTFdzYW5RSkV3Q1dBWjhabGs5akZydG1ZTWF6VEU5V05XalJvOE9vcUkx?=
 =?utf-8?B?U3owSjMvNFFWQjZUb2F5QjVWOUdyZkhuSnE1ZTFkNkl0Ynp5ajU0R0dMVGZy?=
 =?utf-8?B?MGRMWDBUT3Z4TjlpN0E2M2E0a0NKa1luWCt3Zmw5dmN0RmF2ZU9VTVU2cG1Z?=
 =?utf-8?B?amJnNFJ4VUl5V0V5R1h5QlpXSmRyT3krbzRpcDduYUo1Y2o0NVJFNVZqVXBj?=
 =?utf-8?B?dlUyVU9uNW95OGZ4czdYZUJnbFp4RlpVZEFDWitPSzZFbFJCR090TmsxQWZN?=
 =?utf-8?B?dE9UQTY0MjNqOEVnektoT2daUTJwdHNxbmpYOFpDNCtrTnZzaDY0b3FuSm9y?=
 =?utf-8?B?djAvUWRrVWZvc0VmcnZKN2N6V3BZNDVUMlJWQmMydncwOW9WWVJQbEJrQ0tC?=
 =?utf-8?B?SWwxNFFqRWF4WlRoU3dNbzdLU3NxUzZjaHhWbFVGa2xzVHpUNzBxY3B4OWFu?=
 =?utf-8?B?cDltNGZaWHBtaGJsS0ttV0VxZ3VFYWowRDl0cnMrZnZnVytnY3NXZS9BUzky?=
 =?utf-8?B?TFAxWGR2cmd6U0VYcVNqK3d2c1ZwbW94Yk5DanFhdmxPRFNjbUZ6Tnd2Zkhp?=
 =?utf-8?B?a0thRXFGL3NWdnJSMGZCcVROMmtyZTB6R3JxdkVGcjFiUUlGblA3ek1XcU5Y?=
 =?utf-8?B?R0NndzJnY3hSRnVUQkRiWHJTRitsWWlFMktLbzNjVVZhSGJJYm9YdDF3ZXI4?=
 =?utf-8?B?UXZsL1ZOcHI5RXAvRlpYVzlta2JzYkpYZ09jWXRjSUc0MGpsNDk1ZExoQjlo?=
 =?utf-8?B?S2hBTE9NQVJRZkFoL2l6NnFXYzJ5TWVzZTdCbEpQaVRrbkR5Z1VQTXIvTkdN?=
 =?utf-8?B?WDFoSG5IbEp6OGFINk9LdEh5ZGhHbDhuQm5HL0QyejZzeUNFN0ZueDVJbjhY?=
 =?utf-8?B?czQxUkxicjlFQjBMRzhZOW5iK0NnTHgyQjlKazY5WHMwV2F1RDBoeVl3Z0gv?=
 =?utf-8?B?YTNYWDFLb0RJOUlaZFhFVHFvUWlGTW1GOWFGVW1yK0UwY2VWeDMzcDVwOElv?=
 =?utf-8?B?eU5zRzYvQWdKdDRBOGlkVXRIL25WVmcrZGNsekoyWk5IOTl2VU5GVFlOakUx?=
 =?utf-8?B?REFkbGx2ekQ5cExsdjI0aHNibnd3blA1L05WMmVhZDVWQkgrOUlHUnhycjdX?=
 =?utf-8?B?S3pxNHZ4S2VPNUxHOTZiZnpvQmlVZ3RORTJWMEZRZ3d6cno3Y1p5dFEySkJC?=
 =?utf-8?Q?f1BT03Esxa6TQcf+I0Jzl4DPuUkfvN4sbKOJ2T38y6CbJ?=
X-MS-Exchange-AntiSpam-MessageData-1: mJudOW7ccvN5vA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8edc9ec-8ae4-4969-1235-08df04187d53
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:13.9593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVEfea83R6mk3LYI8FZeEDPVonHfZPRhu4nd/pTRILKFQ+aykMHDQkGYpVhnrJlTBJUXsA+gPaOuHbwrBD+1hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

Later patches align VRAM addresses down to the PRAMIN window. Implement
`Alignable` trait for `VramAddress` and plus add a `ZERO` constant.

Also print the address in hex under `{:?}`, so it reads well in debug
output.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index dcd5e5e919bf..f9d80ffbe01d 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -10,7 +10,14 @@
     ops, //
 };
 
-use kernel::fmt;
+use kernel::{
+    fmt,
+    prelude::*,
+    ptr::{
+        Alignable,
+        Alignment, //
+    },
+};
 
 /// Physical VRAM address in GPU video memory.
 #[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
@@ -18,6 +25,9 @@
 pub(crate) struct VramAddress(u64);
 
 impl VramAddress {
+    /// The zero address.
+    pub(crate) const ZERO: Self = Self::from_raw(0);
+
     /// Creates an address from a raw value.
     pub(crate) const fn from_raw(addr: u64) -> Self {
         Self(addr)
@@ -37,12 +47,28 @@ pub(crate) const fn checked_add(self, rhs: u64) -> Option<Self> {
     }
 }
 
+impl Alignable for VramAddress {
+    fn align_down(self, alignment: Alignment) -> Self {
+        Self::from_raw(self.into_raw().align_down(alignment))
+    }
+
+    fn align_up(self, alignment: Alignment) -> Option<Self> {
+        self.into_raw().align_up(alignment).map(Self::from_raw)
+    }
+}
+
 impl LowerHex for VramAddress {
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         LowerHex::fmt(&self.into_raw(), f)
     }
 }
 
+impl fmt::Debug for VramAddress {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.write_fmt(fmt!("{:#x}", self))
+    }
+}
+
 impl ops::Add<u64> for VramAddress {
     type Output = Self;
 

-- 
2.55.0

