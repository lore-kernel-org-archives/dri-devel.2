Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38093C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD0E10F092;
	Thu, 27 Aug 2026 14:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFZYLk1k";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFFB210F090
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSYjRNxQdmzCX2iDkm5NaqM7kSTtMrlbv26TDwAI13JZh+cEUISL016QdIl3zGmxeuH2uD5n00PuGXUXlmOnUkPBECS4uDW18l/Avjk5WnJzatdrtx3dMI8QCb9RcReAN7qc4YjnidXMBz3ykUCVV16EhObZ0jOO2XtuVLJ/56mZUIZcQmBQhq9TEreSeGbyOKkklGeujhIPPgjndxM8jwhp7WdAcB+VKQVmvzQVcgvXX4FyYChm6WoNMfpeKsH0ysLBXeECGyLjWy2PbRE1CgqFboM0MWRLIcaQ+iTx5U7kcUcbsnXp5XyIXiH/SG1ZZGNuEzAEndU/JswupRzEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC8ueQBrSt24otLk3wNlkGNbN7djMZYKMzV7Ln5zC6k=;
 b=uaMGJtWkq9cpyhQTmihnGqaKOTuTU50k0Qb8Wyy4Bb4E+ZEEWSnpl5S2xSyQz4Tp5tGwgV2vI10Uh0qtIIkl77x7nHHbiJ9E6KRgVlzwuHt1X2CGQmdvD/n1qoyrzPTC8yGNraPMDGRtJ2JGfKi0UQTW9NDa7dwdwESLjB5tQzrAW4EcQ78h19HV/8nR/izs1tKQ6ONGEzZ5eHibFub7PPKuqGVCotzM0lq1WKqVQ0UvSIaMjpt4u0iqSvfUzLc4eDf680vka41s/sPl/GAl/6uBfFJ8GA5sSHcIrg/uorFFjPSOTZSwgSbop8Gtrs9Urb/b+KGBsPUmARHmk4KipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC8ueQBrSt24otLk3wNlkGNbN7djMZYKMzV7Ln5zC6k=;
 b=fFZYLk1kzT/NJ6y301uao0+PJTs3gSPN+XbeMHX7WVtlDYZ+vsuEFbhYrazaITI1VvShDk2c+YBn8DENYJmQBxxSBShnfZOA3PCgezk3CKcyUKugHJseAJyPp+oMwQaFeLh75amhhH/8iCnMsBDOGjujjV7t2lqG6L6siLGzKJr6YWQXK0ji37tmxlR/6UfTXT/ufM36+EG6ghjrQ0j+K7hTdUlKPU0WhLeBU5Ff2if7xlEyMH0XHz+5OYGixn2q+e63Ff8990DVOk9bBZF2CJjlcFD6WTViggTCB7zyMz4TDLjd4bv7/XkVrlinhJLOcOTMI08qSMI+hj6cHymP1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LVUPR12MB999161.namprd12.prod.outlook.com (2603:10b6:408:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:22:55 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:22:55 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 23:12:51 +0900
Subject: [PATCH v2 2/8] rust: alloc: add Vec::push_init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-b4-nvkv-v2-2-0de9d5c8658c@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::6) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LVUPR12MB999161:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac8f861-706a-41a2-5d2e-08df0446afaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: 5NnFYxNo1vwS4xPyMQiRo7wOw+BgQpOERii0RoPjP3pOtt1x5o2IQ3exgItyjGxuSfnhf4bd6VEsFXMbVU6owUzn4Ev/OdcFYuCUzJABRBjev2kBmCZFwtMmulqR/XvPNI2xgXyoCNQU+7tsAhXPAf3w7i/PFBRcRDoLJhTZjHofCp99Ae8atDr9C2op/yRLWxIWyh5urzqFKn5Gh9K7HwXgMgjRInv3d2LOM7iQKke2mUgw4IJ3n4gY8eV/ubYoTrKBqdHCq04Z/8h0OO8HrZqHXENY69kKSzG+osUnmKybdrpmY/OPA8VxKBEOwtPPrWXcs1LtWuInedo+Zwxl0j6ChroFqiCJKPEJBNeZcErrPgPgHjIiRSb+vvM4YFJCwAVpSigUEhshHV+1rukojmY4onvX64KTwA8RseNQh53HerfBw7EAoFoLEEPAaAd8bxliqxe/3iwF7sOcoUSv83LdDue7VQCUR4op+pvdccTQgkKK/9r1eq1H8FBh1DWKDhUaiEM0l5aY7oIWZ8snynfWuBTYvQM1y9nWuJWHE9gp8eAi7lAuQf4uN4mwDJH9rWit8d8V1BY6ys+/HXq4hx5NWF4S3J8JNeYrsiwxQy5ZMRamT62k1nJjX6TpvBxBkcPSnPCt7N5PClgo1r3Q4fLnhtRVOeI8Y7dsurqLx0nNRGLmc+GdtpLykGE+D6O2KtatNKuJDk74/YUqau6tjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtLVkFZNDNzcHlPRndNd01CNDJvODl2ZmNDRlpNbUdjeVBIckl3eEhBUEVL?=
 =?utf-8?B?TU9FNkYxOXdSWTFNbWNpOGtScFZKQmNOckN1bnlTN254MFh1UHQzSVREY2Uv?=
 =?utf-8?B?b251ZjdIWWtJMmlhK1Jycm9IVUw5aDlCU2NLK2lHV2FaT0R1UHZvMWs4b2VX?=
 =?utf-8?B?SmZWTTJUQk81ajYyZ0g3WDZBdmhMcXhXT2t2bGJaVmRiK1RraDJPdW44aHpn?=
 =?utf-8?B?R09zRHlLQlBFdDZxVXFrdGdoOU9xZ3lmQ2ZwYU1CQVV4ZStPZGsrYTRFQTdK?=
 =?utf-8?B?akk2b3ZtS2plbDZicktOd3d0b0ZKVlRGRjcxdEN4VFFLRlFEcmJwaXNIN2V3?=
 =?utf-8?B?alVkZDM4Z2t4TUFZY01pcVlTMEdFbVJEZlREenVXcGZ1RWlWUk5zNC9pbnNw?=
 =?utf-8?B?dUk1Vnc1UGZUR0E4bXFvMDhtc0x6RWlWQ01zYWk5c29ndnpHUFpyYjlJSlM4?=
 =?utf-8?B?M00rcWJ4WjhHcW1hTVR0OFM3K0UwNno4ZWIrY3ZvYS9leTVBdXZMMzRJME9u?=
 =?utf-8?B?YnpOVHhFam1kVzV0UTg1V1Aya0xid3BwcGllQ0xOMEtuUVB5cWpiVWs1VmYv?=
 =?utf-8?B?eU9vY05aeTdIUVVIUTV0RVQrZlpxOTBBVG9jdENyQXVUeUg3S1lta0tGRVdL?=
 =?utf-8?B?dklRenFBRDB3MDZUeXQyY295M1EvRHdlWlQrZi94NzMySWlkSkppVTI4cC9z?=
 =?utf-8?B?NmlueHl2cXBDamVUMGliMTRiT0ZBQXg4QzYyR3hGZmZuTkxrSlY5ai9tUXMv?=
 =?utf-8?B?dG9JVjBuOWJ0YzFMOXlPWkU0SFFrMlJZL3ZVK2hnbUtPajBKbDRuU29sRHBO?=
 =?utf-8?B?eHFaeUJSbGpGbFd1MVAwdE9VMnVPTUErZU50MlNJU1AwU3BZM0gzOVpOS2J3?=
 =?utf-8?B?MlNidzl0cUo5MzdSWnZqSHJLaE1oMDN6M2VQSVFMZTFTZWtYOHkrWVFrRzht?=
 =?utf-8?B?Vjk5eDJzakwzbktlSkU4Rit3VWszNWo4Y3Q1UWRqUzVUVVlRcW11emVRditW?=
 =?utf-8?B?SVR3M3NlMlQwSEhNR2pkNENPUGZLQ0JMZXFQeHFvL21QQzcySStOZU9hNXRC?=
 =?utf-8?B?UWV3cFp0WXViS1ZBcm1oMVNhWEpKTkE3TVFDZGNhUzBzUU1LVmdkazl4SUVF?=
 =?utf-8?B?UndFQlFqc3V2clhkT09QdjZFVEg5M1VucEdsU1JaTzFvR2hiZWZmZFpJZ3ZH?=
 =?utf-8?B?T1kwRFlNTjd0aThqVUlDTExuNmJacTZMNS9SYjdaZk9oelpwdVhGTHp1SUpH?=
 =?utf-8?B?a3dYaUxVRU9pdStYT20zSlNtUDhzNHFXS0dqb0JmQWRSc0dHR1YvTCtlMFE4?=
 =?utf-8?B?Wk9PcDdGZlBBVzZBWWs5aVFDcmFlelNTbUtZdEdxZ29vSHhoWjExUVdUUm1K?=
 =?utf-8?B?OXBudVl6SFE5eWYvc0NDZ1JzUWM4RWkreXNyaXZjYXgvb1JBd1Y3ZTRuSGhJ?=
 =?utf-8?B?djFWU05NV1QyR3FXbEVVdVh6QlpoOTVpU0NSOG5BcTR5c2g1d2NvL05zQ21K?=
 =?utf-8?B?d3VoOE9BNFVTZnJUc0MwUnIwcGVCVkx6bkNzcTB3TVVwcTQ4dkhaaXBrK05z?=
 =?utf-8?B?YURVeW5WN2pka3ZtWDBzL01rM3pXakFHeW9RQVZmbUkzaGZsN3NmNW9iOXBr?=
 =?utf-8?B?TnVzeFpjY1A3ZnFFMkdCajQrekVXNlpOaEMrdG9TSDdnTlhGclBKbFIxQ2Jy?=
 =?utf-8?B?VDhiZjJ4UWtpeWNvZGxheFh3OUV6ell0V01WOHJnTjJLMG9NL2FHaFF0VHhX?=
 =?utf-8?B?VkxGMkhSUU9hL2pDcG1lQ2lzOHBteFZ1aENHOExxV2VaSUMwSXVpeWFDTzVy?=
 =?utf-8?B?YUxYd0VZQVYzT3lyQzJkMHdJZ29wZk5VN2U1bFZuU1hQUmgva0ZwbEZTUGNI?=
 =?utf-8?B?YWVsc1dablJOa3JSank3QlRRV1RxMU9nN3VFa0R2aWIrb1lUOEZuODB2bXVm?=
 =?utf-8?B?TWZHL2p3RThZSWxzaUdZZ2xnQnB6S2Y5STJmZCtURkl4UGRsbW5yaFBHNm9a?=
 =?utf-8?B?VDZjbFgzbzdDNzNKTktpSVUyUXZHZHZLVkNXeDluNElSc0hSWEoxblZPUFBu?=
 =?utf-8?B?SkNkZ2FpelYzSmlFeWRkeXBtNmJiV01OOEQyZHRObG1qY0c0SldnRC9RbThr?=
 =?utf-8?B?bjhBei9qaUVQN04ySmRtNTFMd1BObXFGamEycDF6RUt0TDhhTGVFNDhvcXJV?=
 =?utf-8?B?MUlkSEVYSitBMTdXWXRXc3FQTEJBdE1nODRzVTg5SXdjZUtOU1lsOWFQa29O?=
 =?utf-8?B?RCtYMHNONm1xZHhMcnRBZkhUckRqeHlPY2Ezb2MxN0twamVhOXFuaTRmR1Vx?=
 =?utf-8?B?VjVRU3NzVEJGZDNRMGlRaU4yRlFqam9yNHc2K1lEL3pMeCtFZGpFQml0SXRx?=
 =?utf-8?Q?yynqHFKr2Es0PHmlP0q+PPCfw8CuGFiYm5SPSbYeJoxUL?=
X-MS-Exchange-AntiSpam-MessageData-1: /y70/tyH1XjxNg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac8f861-706a-41a2-5d2e-08df0446afaa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:22:55.2376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SRL+I9zc2/fo64Zr/g7ZpVc/wpOsuyASW8zxZ6JggS4Do/EZKYjC+NeU1ky2Gc6GeVNv2snbBOyxxwZN0DTng==
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

Add `Vec::push_init` which is the init-infallible version of
`try_push_init`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/alloc/kvec.rs | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index fe86530624c1..bb4da220293b 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -369,7 +369,24 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
 
     /// Appends an element to the back of the [`Vec`] instance by initializing it in place.
     ///
-    /// Unlike [`Vec::push`], the initializer may be fallible. If the allocation fails, the
+    /// # Examples
+    ///
+    /// ```
+    /// use pin_init::init_zeroed;
+    ///
+    /// let mut v = KVec::<[u8; 200]>::new();
+    /// v.push_init(init_zeroed(), GFP_KERNEL)?;
+    /// assert_eq!(v[0], [0; 200]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn push_init(&mut self, init: impl Init<T>, flags: Flags) -> Result<(), AllocError> {
+        self.try_push_init(init, flags)
+            .map_err(|PushInitError::AllocError(_)| AllocError)
+    }
+
+    /// Appends an element to the back of the [`Vec`] instance by initializing it in place.
+    ///
+    /// Unlike [`Vec::push_init`], the initializer may be fallible. If the allocation fails, the
     /// original initializer `init` is handed back in [`PushInitError::AllocError`]. If the
     /// initializer itself fails, its error is returned in [`PushInitError::InitError`].
     ///

-- 
2.55.0

