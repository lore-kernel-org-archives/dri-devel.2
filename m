Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A78C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369DA10E282;
	Wed, 29 Jul 2026 06:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OvFguOlZ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B89410E653
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejtYs1Gha46UcMST8Mwt6xSRLOsV9Z25e7a+v/FGPsc7d+pawEtNdfzMUx3RZoBxBahuIlEr79IyTbtCYljv0WnnTqmimsQfRy+PAXpX3BZbxILKjetpNFCqWa1JqZ4O2HI5WavXcwMLK9aOLXSyGOncU2oAEyYl/9Q/jwLO2/asdO83lp8J0+E8yuVxvibkYuHt86u99Zy4L303dLg6IobBiL9AjnjwHVXMH4IFx3SdyGDxUyvYfgfDGdGaJG8alMCv4yF95odyWYR8gdI5x6n1UqGu/qggfmSL5MD7cok8D+0Xm/fBLfOzvJ/l/nZHDy5etwEgNb9eyYgUPUzRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u7dvAPBl2WuKO3iwzYyxwsdySo7yOHzfxH3cCQuXO4=;
 b=SP8w80IPwA08QVdGUUk32IB9Urp9AN+z70dRPFUAjIWEXHeh31rM7m4GU0z6gCiDVWmZL7qrStCMBeaTJxcbKAgwnuAuZ9hCMn2nnBACXKE7kUjM8nG6Hk7zWnSb9TpwUCED4uhtZXsZMouMnnDia8OOJVFd1QvdL99YGeb+rcdnzYjIKDWALK2taDrPFetI/GluSr+CaSQTUOOgrf3ZHnpTNY521ga7fCopQrQnaRdxneUMJV9pMJcNiUUTpoMtVIPiBqTD12ySgKemIG7ketvqZPqaf0OW0lJWSv6kerGnk5c3T/5U5UJzGs/P7wSzGzTpjLgqIutWfGldB41MRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u7dvAPBl2WuKO3iwzYyxwsdySo7yOHzfxH3cCQuXO4=;
 b=OvFguOlZCWR00rszgsUm7nfGVBp6rNyTyctWgADsv/PLM5OZUetjuHHk5Gx+bK0JpwnInvep4NipDips5HdPXQh3H6TRW2jPaJHzAI+AiPTZADDHtLgdO7q7+X4/9yQQXMqsG6831pxSqXIjijXnG1utbptk3ALpeg4Y6tRKjVyMQs7FkTTdcSkfHltI2w3waAuE1bO/P7bk0RlyxnR7BbbFDpUhQfRZUMiDdGHajz8Q66lPOG3bCjDTcw+dK+yflxXlabghWchd8H5SMBi83OxRIgjcEZZVq7x4INWoHnq4CDB00/7ZDUi7e2oXQ5JEZ5ytKp5LryJ9xTWVZm3ieQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:54:26 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:54:26 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 29 Jul 2026 15:54:12 +0900
Subject: [PATCH v3 1/4] rust: bitmap: use function-level cfg on kunit test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-chid-v3-1-20cc08032bbc@nvidia.com>
References: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
In-Reply-To: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0092.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: fe20ba78-b90c-4b22-d299-08deed3e3af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|10070799003|376014|23010399003|366016|56012099006|11063799006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: BcvV1sXZrVK41sRt6S526HqMtffEk/oGS8K0yeUc6d99yz2RZ8RkR+OZaqLoigQWKYYfx1AWoF0Mc6Zm9eTZYQYnhtKAo176MZYWX9yBLYROz/Glk33BjrUsvjnA7baCUt9TMc3DYK8iKHQZCw99W6eDHKMIzJgZb6cRCAqEWP8jui8rFGXL5H+NZy7+heJf5q4VLnJzqQ3oDgcB9LmjOKRDlnlUzqV6z5xxCUTD9aI04Kx1J2ugyXGkTrFtgvTokNIzEmPUuzzHRt4xB31YnbwvfTc6P53fsJKVJyX8pwBGjLX6p2c1X3b61Ey6YQCppljE5dofemfCHZxVM7LezLp9zf524UGIhtxXqo4cKPBOEFBp3IZ3PHLSA62slXBk4TMZsD36qgqHqffH+xuGKlGzWWL+3tWOB185ZOun6BVeCakjFdrkH9HkednfSa4dKSP3N/vMRGj9crA1u5ASi6dU0IAkFPIbcXWCtiThHgeJXmYGWYKOrKY/wMr2iwhmrrEdkEBUjtcQ6SdImCK1lCqxAHtYA1T2DJ6gfXeWeX/ifov1/I+jdMeWhMMNZSdJmktgiqNW7uQRZ76+bNaACGjjyiQHUsxcVRn7ZkV+jr4WRvJAoupYl13HoQn4FPVuOJRtl4pXeHwPISyIj921UggnKUAnOVMBr7rTuJ4f2y93g2CibtRCcwozw8iSI+DMpWmOZ9oQtttDSUBN8a5dKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDNSd3c1b3ZuRVk2RENFS3FiY3J4RXRWdkRnVks2Ty9LTjRISVRnQ2dhbS8x?=
 =?utf-8?B?d1NSTndkV0kvK3ZBMS9DVlFXVnJ2aDIyb3FkdDVGbzg5Tkc3N1BDWjlUZ2Fx?=
 =?utf-8?B?QWhyRVpDVldGaHdMeXRFSWQ3bURPYUN1dnJ3amkvMWJhZDhuMythaUk1RW4y?=
 =?utf-8?B?YmY5UEZmeXZwRDlqU1BxdFliRnYzRzh6YkdOM2tpM21qOThGdWc0SnNqazdX?=
 =?utf-8?B?N3l5NTk5UHdWVTFmNGhTemhZQkpSTDh2RnpGMlBHMERzNDlMZzdYcmRHOW1T?=
 =?utf-8?B?aGZYRDd1NXlaQjYvY3MybmNZMEo1NHpPdHlaMHAwOXNHZEYzK2NkREE2bHV6?=
 =?utf-8?B?MlE3YytHUnI2NUhMcVRzSUluRDk4WTlXdzFvc2I3N2N0N2pOZHJpeUdLSnlH?=
 =?utf-8?B?aUVUMW5PRm9JU2IvRFdKRjdmVzhUMWVRb3JxK3lIakZCalNFa2RUVHduRGVO?=
 =?utf-8?B?ZWtGTFRVS1kvZFpCWURCUkpBSTNQNTRhZ0RIcGx1TnNhd0k3Yk91Z3NNbnV4?=
 =?utf-8?B?amZTcU4yTHl0OGFhQ0V6UGg2Wkt4aUUvTVAvNFZtYjN4S0RHWlhQMm53b244?=
 =?utf-8?B?ZFRxVWNLRkRBL2UyRFZDTzQwamtKRE1MdWwzNFB1MVViZkJVYXowbFh5eVFJ?=
 =?utf-8?B?SHFIQ1d2K0ZSazBhTnQvcGR5cW1FQ2lOWEhvSGRwS0VFQms0bjJuS3N4WkEv?=
 =?utf-8?B?L1hiSkxSZk1ZQTFJUElSckRyU0xZeUFKOGE0YlB3eDFvRGgydlpXM3dmWHFo?=
 =?utf-8?B?cHF2S3gzOXZxbk8zUCtMcmIrUnUwb3VGTGx4Sm9wZlB5STRrVHRoc2tJdkEy?=
 =?utf-8?B?a1gzWDc5aTZZOC85UHlVTGJoTEpFNFk0Z1REbmh2bnVlbzhDeFh4YUM5ZHAr?=
 =?utf-8?B?WWJ2T3hVYTlWT09kNkRFbzZpWWV2ejA1YmdHUHRucEl1MnNjeEozTzBwRGlW?=
 =?utf-8?B?cFREQVByODNVNGxSWmtpR1BUdkgrNGFVWC9EcysvVHNzZEhLdC93UUhRbUhC?=
 =?utf-8?B?OXBvOUwwNmIzTkRGVnhmSjJKNjJDTC92Ti81aTRScXN1MWhCUW8xMFo4M0pL?=
 =?utf-8?B?SVQ1MTBzZm5aYm9lcGErNXJFWml6SjdCdkR5VW9xakl3YlFZQWhuOGllYXJI?=
 =?utf-8?B?ajVEM1VZbWI4eVJzRzlMK2t5WmkrNzZoMmNrZ1RIYTJ2ZFdTRHM0SzI0Q25m?=
 =?utf-8?B?dXh0MGIxMFVlLzF2WEpSeE02NHRwMGN0VlVzUFdPRU04b0JETmpWTmxJelJS?=
 =?utf-8?B?d3NSVW5sM0FoSDJ1QWQzN016U2VBZ2FOYmUzZzZMS0s2dEpabUlZSGI1VWxO?=
 =?utf-8?B?dlB0NGNRdHJwLzgzS1Uwc2xmdDRobGlXVWFySDdGVXBhMGM1Y3JyMndwYVo0?=
 =?utf-8?B?Z21vNnRFY1pGZHZnVGdOL05MNGdtUm16Z1diZlJCQWpkaHg4NDYxYjhZY2p3?=
 =?utf-8?B?RmtscGtPK2F6Q1c1djdqN0NMOW1FWUFhaXlPYVFhZ3QwUVZDT0d3dXZnVGMr?=
 =?utf-8?B?bWpUNnk5cWYveDBmcExmeVRuL3hDRlZ1bFpjcy9GOGpFaDBDZWdIMGZPSGx4?=
 =?utf-8?B?bVBWOXBjS2h1Um9TYUlUQkNHMEgzTlFYZTB2Z0w3KzlBZmxJMDd4V09ibklJ?=
 =?utf-8?B?YkJKZVo0ZzBVUXlZeXkxUGl3blhtWWZ0d0ZZOTBiNFlsVXVHWlcrUCtwSkVI?=
 =?utf-8?B?M2luK1ZxTG5SV0V2S1VkRGcvMWVkYmpoZ0l3ejAzU05kQ0ZncVRhQTNRaFlt?=
 =?utf-8?B?RndmREpzZXQ4a252WHJSM3VzdzJ3VUdDQ3ZDdTdRNS9INzBqKzN4QVY0a1h5?=
 =?utf-8?B?SGhVeWZjaUZSWkYyTHl2cUo1MDcvclcvK25LTklJbEY5N3ljMkJCMzRmRStL?=
 =?utf-8?B?bnZ1Q0U1QmdOcUJhRTZTaUU5bUNJRVFXN2QzZCtlRjl1Z2I4bXNjdEdmcm4v?=
 =?utf-8?B?SC9vc1RkaEZYWC95L3BXQTA5RnAwL1E3STVybm1GbndVVm42d2dhR1BuR25B?=
 =?utf-8?B?cnFLNVlERmxTL0Njb1VscFNPbVpCODhQRFQzTUtwQis2NmdXS0dWL3g5UXBz?=
 =?utf-8?B?enhhVm5NRy91bk82cUtyZnJqZEorMjhsd3FjM3c4Q0NQQzI5UWFLZEd1Mndh?=
 =?utf-8?B?YWpJOVlYN09mUnllWFpaQkt4YlFuZDc0eW82QU0zRHpUdDI3OXZNakt2b200?=
 =?utf-8?B?aExFa0dvekptZmZCUHY3MDgvbDAvNkYrY0RJYkVIQkswY0VFRlFkS3VReHZH?=
 =?utf-8?B?VjdhVWhyWmRaTXVMRVFWMDlRZVNRdDBTcFBaSGpzbk9sQXpvYUdFNHJiRFBx?=
 =?utf-8?B?eTdibW1OOEFSRHp0NjkxZWRPRU8weDAxczRqZ3RGdGhMeUp1L2NLYlNvTWRl?=
 =?utf-8?Q?Eev4vUY1ACTswEtFMF06nZJwnuucmFRrUTnbiMieuoEK1?=
X-MS-Exchange-AntiSpam-MessageData-1: FQYBJMGKfPN4vA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe20ba78-b90c-4b22-d299-08deed3e3af9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:54:26.7608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0MjNwOnYcAVzc7Pljpobrnqyc+2+A8v8aBDmqPRtOHzRFLxxL79QL3q9p32KLbVathfzBc3qDntoO+iLy4IdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
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

Since commit c652dc44192d ("rust: kunit: allow `cfg` on `test`s"),
we no longer need this workaround.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index b27e0ec80d64..a43bfe0ec3dc 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -572,24 +572,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocError> {
     }
 
     #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
     fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
-        // TODO: Kunit #[test]s do not support `cfg` yet,
-        // so we add it here in the body.
-        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
-        {
-            let mut b = BitmapVec::new(128, GFP_KERNEL)?;
-            b.set_bit(2048);
-            b.set_bit_atomic(2048);
-            b.clear_bit(2048);
-            b.clear_bit_atomic(2048);
-            assert_eq!(None, b.next_bit(2048));
-            assert_eq!(None, b.next_zero_bit(2048));
-            assert_eq!(None, b.last_bit());
-        }
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        b.set_bit(2048);
+        b.set_bit_atomic(2048);
+        b.clear_bit(2048);
+        b.clear_bit_atomic(2048);
+        assert_eq!(None, b.next_bit(2048));
+        assert_eq!(None, b.next_zero_bit(2048));
+        assert_eq!(None, b.last_bit());
         Ok(())
     }
 
-    // TODO: uncomment once kunit supports [should_panic] and `cfg`.
+    // TODO: uncomment once kunit supports `#[should_panic]`.
     // #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
     // #[test]
     // #[should_panic]

-- 
2.55.0

