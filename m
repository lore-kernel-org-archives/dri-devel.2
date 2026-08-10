Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E53C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF2810E885;
	Mon, 10 Aug 2026 13:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oED6F4rT";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605CF10E885
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efhw8R3Pw6DMhU1xVSh+7RHfzq5AClX409OIpPKKk6xJAtuAC7owYsVSM1qDGIJ2eZWXj1am+ZT6B9WDxPZcb7i4WrMLXBmtbUzyG3/uzJdDPJFXLHWQBQeQGvlrJa3Csz2j4+oYHyZcvc6w4caUylQBzQr8FET8AG6ZXrwxBMA4Ot7WyqRGT2E5ihFnwEuFZbjSJyFhYsj+4W39egfn3cPvq3+G91PBvdxCCBZlbduWiQOM0uKK7brfBQ9b91w7oOJ0Th070XwlY+yErejVF68fwLYczvelnTHTr05V7zb4kAuqyI52143q15iZsrNyXXjEQ3/BmRa7KO5NoxpgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM9kPxv+WNug2LPP1+XIOrneIPyMVyoHvHhoc6A+61g=;
 b=shSsSf6HoZ3kjMIDzdVq7bsbET64zWGJhRwiQgKs1FEn0RUYzxjKBBQMjOX1aFE9u6e3TzcQs/1cEMuItRQ1QQcp0sjBY1GCqb4ShFknB2QLMPHH3u9iifE/FJF8N1DcUSc4kcEv0YfSlLyjirJ0neoL562VQGo3FnU7PBTks8b3AS0yrGQCmIsH490wytnKvyWl2WaUKoVWWPIjNtGyqWy/vSGnGzsvH04g93Qn7TwB58+EYgySheGje+DKz3D6hH8qL3SUaYX7L8RaBdvFB2k79kILDdeXyMgBmEA0wvGV8K8hciCN2O9/26KYeKh6tX4fG94eBiyqvXkU3+HN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM9kPxv+WNug2LPP1+XIOrneIPyMVyoHvHhoc6A+61g=;
 b=oED6F4rT1x3++fV1W8kYNJ5bFtZd4iWpuLlkfMCdHKhYq0hrFg1Wi4jnHNnvyV3gUoJRIOdKUKxUcPdfuo5TuD9cMydgu1mByYpwqwtQzUdgJN7Zdf04qDnh9HgkL9TfW4O+7KHTNkERtlqxleXTWte7AAY0gr+mAVRiBQLfLSo74vqrqzfRo08/gbrwNzgvQKH2wwfkKWCKGzLmUYDysn2iDHTVPhZWlotkA4ey2jOIbARd+SeoBwDSYyEjXVh5vpV8IeyOYnrWg33pS2W6uQYZBfgBPn4ZIC7g1ObmgT/AdWL5kW05aAT7cRsQ3djKw/aL/+mN2h4f6tReWuZnlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:57:50 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:57:50 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:25 +0900
Subject: [PATCH v2 03/12] rust: num: add Bounded::shr_exact
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-3-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0070.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 60be9f68-6f6a-47f9-4e1c-08def6e75dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: QqLb9p29w++zj8/wx/YGJiMG2Ljwr11yLrt6LDAZuipdaZ6rLUh2LspgOALa3b5Ia7xxOURugxIioKnftQtdFNIfDJ1DcnZMiYabnC/oGRifemE0dD0LHsi05fcmqbkCUGmIWf1L3XPemQxHWpv1xNlSdYxGff8JnczMaq3nkPZlFZ+950KAlGFDjH6Xvqi9A6PykdcxgICDO6q24buToxgwd83XU7loWA5JxAn1xiNYNDx5ZZ/p+hhV0D6rgaG6Nm5DCyggGkQ4zMLzwcRB45ivqiRarUZK0RgWL4dCVZsN1at6mBMNpzheGRQJr6wzPbPYGiZPAjLIODHv7DLI/sB9xeGLHFnqgQsuSdPkvRODq4KVu5141Rns9AKklVkqZ1aKtGHKYzAcfMQBWmF7LXiOSxneToV42NpSZc/D5+7GwBtUh8YE4Xfo/wiyzBNGIgcpQK6wgIEGDZeO3w1qMme9F557bx9GKr4SKH8WAmkwuR198A6GzRnZSXKXnHt+JZOpvTG9GeAlAAeLdvi6VjpqMzxrDNv5gu0sZeV2WdWruvH/Te5RIwybd0z6kUWkmL9GDfYW9d6HLB8sPxe3zoRPGvuk9N7xWVVt1IFYbVRFCYlny8l725RZabcfe6snmzbuEMnfhTIU5oBdCR1iEWtt2kC6mJaJGcTI0BhX1UnrE7jUpDaa8G+ZGN2fa0ZzlcxqKHSm57ILBCDcjSh5EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5qV3BxRnBuYnZrcFh4MUM2NzFWU0I1amJKdkZOaXN3Ni9sOExLcjJiSDNN?=
 =?utf-8?B?T29zK3liVFUrUXFWQjBSOEFTbDNON2RwZ1I1bG9GbVJTNmZjaFI3ZUFmbkZH?=
 =?utf-8?B?R3JkQ0xubEhyWVg4MFVKb3hhYmx2Y2Fyblp1RVhwMm1JOWZSdzB1YTRNK0V3?=
 =?utf-8?B?cnhtMWJZeG1CaWRLVE80MDVTOU1JN2xhM0JkbTJpNCtJQ3VOL3NVZnVUdUE1?=
 =?utf-8?B?MzBGcGxFTit0VnpJb3E3Tk1rVlM5MkFmRXNSWTlTYSt6ZnZRc2pHVUpyWWxL?=
 =?utf-8?B?dkoyR29JekRxbm1LcUV5RkRUVUFPK0c0cFBvamsrdzFKdlY1NDc0dGFlRVRj?=
 =?utf-8?B?Uko1R0NxNElFY3dLdHdlVTJHZ2RSZ2U1amc0WTdNTTdJL2UzaEFDcHVvOFRa?=
 =?utf-8?B?YUQvS2N6OFNvR29vdzlQVnhTRkFRcEJ5bXUzRjFmeksrcy84emliSHlWN0c1?=
 =?utf-8?B?MUxxYk0rME02VE1kZDNDOVY2RFNrOTN2MXJ5TDVnVDk1NzJ0WXoyc3pKOTRq?=
 =?utf-8?B?MmJsVEV0L1c0QWIxWVpqU0xhNEFhSTBjdHhmZnN6dUltT0ZuUDF0eHd2cmds?=
 =?utf-8?B?ZHNwVHFBUWhDa29XNGd5SVRPdUhTNmVBMDZWUmhUUWhVNkxjTnljdWRQVmRK?=
 =?utf-8?B?RHVHcmNsUS9PQ2oxdThOUlhUUUF6ZnIrMERNQS9vckFSelRGenZObXNvUktB?=
 =?utf-8?B?TTVPbi9mWHB4SUh1cXFBRnN2ME14aHR6RmU5YWZHZE9NSkdoN0s2ajdVQ0pO?=
 =?utf-8?B?V0xPTmo3MmM1RkRYNlJoak9YYnVzbkNkSDkyRWVud1QxbFMzOTlLYlhQZEth?=
 =?utf-8?B?cmU4SWppa051TmREU0VuNW9DandkV1VPRHErbVF0TjJnNGJJTGpvSDRTK0NU?=
 =?utf-8?B?OVFXQTF6U3RUUGxlVDBtMmVGQWpXRU9KUmp1TVJOaXNLZDRTSXRuUC90Vmtw?=
 =?utf-8?B?RUhqaWYyc0NFUFhMVHpOQUFvcXN2VUFJVXd3RXhWb3d5YSsxN1RIZkpCdCth?=
 =?utf-8?B?Y1QxaXA5RUZsaStLWjJ4L0thSXE5ckN2V3BvOTNVUlhjVDQ4WjU4cUlnaVEy?=
 =?utf-8?B?bGlSQ2lEYTAzZGNBQURwWGxWZUJQRDJJUllmZWRldFRlNFVOMGVnMUxBV0Zo?=
 =?utf-8?B?clBuVzl4d2RscDhIdXdRU2hYMW1pRmJZQStqMUZNcHRQKzF2bWtnMGJ6ZlVa?=
 =?utf-8?B?NGVUV0VpRGdtSTR5cmNGMmxJRVlKUmhKU0xxV1pPaHRHSVRTMkRSLzRCbFJj?=
 =?utf-8?B?RWQ2QWZQZm1DMWplOEpmZWkvUDBsU0JqNWlPQXltam5NeHd3ckc1ckE2TjI0?=
 =?utf-8?B?RWZIS1ZXTVF5Y3RFaDEveHNOaENCS0ZwM1RPcjg5a3c0ZjlLTGlkTE1lc0pk?=
 =?utf-8?B?V29oaFpxcUFMKzN4anRkQWIxVXVlRm8rM3JEK2o4blV2aGhPU2cweW1ZNTNw?=
 =?utf-8?B?VEFIUm5EQjJVazVxa1ZCaFlIbE52Mi94a2wrdks5M3lGdzZncWVXQzlVMmVo?=
 =?utf-8?B?ZUhYM0V3RE9hSTlGcFVyakJGMERYMC84eTFTTGxCTUhJRUJsaGNkb0VCVFRu?=
 =?utf-8?B?a0s4VzliTk5XazBNUUdmcmFzaTFVTFJ4a2tnQVIzMCtwYi8rZ1lqU0E1Z0ZF?=
 =?utf-8?B?TUNBNm84R0tWNVVuTGI5dUFzMGViME0xRUlObGo4bUdxeXVFdHI1R2lEc08v?=
 =?utf-8?B?SVhxL2ZuRkVHT0I3bEVUblN1MkZZSzk0ckExdWNSRVQwcmcxLzZtK1MwTThJ?=
 =?utf-8?B?SHN0YXRqQmtXZDE2NnBYQVhZK0JxdGNSREFGRHdHMHJRNVZkWk1JZzFUSTFY?=
 =?utf-8?B?bUFBZU1xblZpSm0vME90Rlp6Umo0d1B1YnZQYUpvTWV3WFNIVXkxOHBwdEpo?=
 =?utf-8?B?NWFBemRHM2xNWjcwc2xUdVJqSGhEMVRraWlDVlFiL2x3a0JkVHRvdzhWeHN0?=
 =?utf-8?B?Q1IxRldaT280STBKZUcxU3FyVnJEMzUrbWUwYkRPTFl4VWp1MXVmaE1PTFlM?=
 =?utf-8?B?WTNpaHRwbDZ2ZFFnbnQ5YjllaUhmbHduZ1NoMlM2bkJlK2IySFUyWVkvb2RM?=
 =?utf-8?B?L3dNS3VrN3RMNXN4WlVhZ0dRUjFxSWtBSFhCYSs2UVVLd1o0SWpZZ2M3Smtj?=
 =?utf-8?B?STJpZC9ISmJ6N01tL0phWUUrWERVelFKdGRHTGNDR3ViNWdFMU5qVHV5TDNx?=
 =?utf-8?B?Q2REcUV6T3RkWWI3cXp0Z2xQWkJQYTJneU1FL3ZpWjk5a2o3WmRKMFZDN2Ns?=
 =?utf-8?B?K1l5V3dCeXN1ZDlZVjJxQXBOVXNpMWExS2hhcHVmRE11YVZVNDJSTVhxTkgw?=
 =?utf-8?B?T0l2V1hLQk02U05EUmtwcWpPQ01xVTNDVFBONHJwUnY3REpRZ2xsN3JOSVkx?=
 =?utf-8?Q?d0BA21a296l9n6OPO6AOo9m+/C5VoCOy/CAk9ISbyK8Mk?=
X-MS-Exchange-AntiSpam-MessageData-1: 5LnbF+D/MqSrqg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60be9f68-6f6a-47f9-4e1c-08def6e75dd8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:57:50.6706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N437PPddjsyOitadWFC7z+Bdx14nrcVYaufWFxj9HG8XbiyzvOnYbJazhyVH8VgAuk0TsWzs+FUoQgdoBAudgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

Add `shr_exact` in the vein of `try_shrink` which shifts a bounded right
only if it loses no set bits. This is useful for getting a shifted down
integer while simultaneously checking that it's aligned.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/num/bounded.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index 90483d2c5374..d192610a687d 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -493,6 +493,37 @@ pub fn shr<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES> {
         unsafe { Bounded::__new(self.0 >> SHIFT) }
     }
 
+    /// Right-shifts `self` by `SHIFT` if that loses no set bits, and returns the result as a
+    /// `Bounded<_, RES>`, where `RES >= N - SHIFT`.
+    ///
+    /// Returns [`None`] if any of the `SHIFT` least significant bits of `self` is set.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::Bounded;
+    ///
+    /// let v = Bounded::<u32, 16>::new::<0xff00>();
+    /// let v_shifted: Option<Bounded<u32, 8>> = v.shr_exact::<8, _>();
+    ///
+    /// assert_eq!(v_shifted.map(|v| v.get()), Some(0xff));
+    ///
+    /// // A set bit would be shifted out.
+    /// let v = Bounded::<u32, 16>::new::<0xff01>();
+    /// let v_shifted: Option<Bounded<u32, 8>> = v.shr_exact::<8, _>();
+    ///
+    /// assert!(v_shifted.is_none());
+    /// ```
+    #[inline]
+    pub fn shr_exact<const SHIFT: u32, const RES: u32>(self) -> Option<Bounded<T, RES>> {
+        let shifted = self.shr::<SHIFT, RES>();
+        if shifted.get() << SHIFT == self.0 {
+            Some(shifted)
+        } else {
+            None
+        }
+    }
+
     /// Left-shifts `self` by `SHIFT` and returns the result as a `Bounded<_, RES>`, where `RES >=
     /// N + SHIFT`.
     ///

-- 
2.55.0

