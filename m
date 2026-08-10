Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3941C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B71910E884;
	Mon, 10 Aug 2026 13:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0Xgaypr";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A324910E884
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejZLXaZrc1PToTp42XJ+wZ0W2Ex/jc2lqm7+xX1B8ahofYq6nl2vanmuaK0yA68pqUbsjLQCdqnWPXKOz9hK7icAtxLtaq5+AGJutofR1Z6aRQRrcOFiNBMS3z55reXXy91HZ/dt29d0tv6D9QrPkeji5s1Dn844Bx7hXwc8E72x0eRj23YrXG2Utezy9qbF10sm/KOuxFXwE5ZXZIfIna3vEXzdFISfoJ784wYbdS5oM5/PM9TwkHH2WWJNYwphLhXi9npQoPV79KLB07j4niTgwZTmNbk767ziKorsjUIxttoehSLTTfRSvnw2rfEJG5QdfmqNfgLrIBJ7swap8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHrjkytmNGfxLFA2QKe/0x1XLL5ts8Zfg+RE/B3uD/s=;
 b=RNNCNARCkPO9rOivkIBm3iDawssUW0Zs2hnI4dN9ioY/EttY2MCk0taAsB7dSdgs04gK4XctB9zBPm/wxgo8xqgxKubWNmB8ANp0uqKh5uHSNmzqJT+eKgyyXA96qsCjTnli45bMGIaH6lClbE3Dv/PW85vrdcFt5eiB++4+SDisEmWWXu8RGjPiFEpDqenhDHe4Gpc9fSVxSN7w5c03sp4WsZRmRF+6Xvdjf+2zWFh79QhbW4nJ+78G6xoJiQ6zgyOSsq/usiIqgoicjs+lsooC2WqiZzOQo34vbynNyq04iZy4y0EBmRPz8vw27mzDAjclkm5iYnfAs+AYJ0A0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHrjkytmNGfxLFA2QKe/0x1XLL5ts8Zfg+RE/B3uD/s=;
 b=X0Xgayprr+/Km1+7JpmG0yMFrltJdINvRy83T9bncEzFDENfn9EJyIIhiwvDBAW107EhzHWQ1cOhPfaEySzZdUrCXE3ushsmX0R4x9oOczGy/0OuScO2BiRU0EIr3bv5r9cmPp2IpS82Rhyj0XQAKR1ct1oBfqcQKMtQ3HhJtwvtNZsfdPLhN+VMo+J1NknyAX6zSLj/FUObj/4czjBsVhA1YQHrcypRFlRIoLpoxHZTWXBrHa+s7hCva2qxTH4XukGLmEHN40w8gyomWNNRmar4chLrBle+Y3vbWnpJztFViC11GKQXkLVZYiwbq+wIHkupG9FbYtj+rAD2/cWkFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:57:47 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:57:46 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:24 +0900
Subject: [PATCH v2 02/12] rust: num: reject Bounded::shr overshifts at
 build time
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-2-65a00b3c7309@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0143.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ff5ed4-7249-457f-2b85-08def6e75b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: TcKqYW8C/OwAX8YBflaN7IH2YiASJ8RKRKmcn72UtrySjpgKfWj3B/TB+wzGUZp5iMDLOJ2baI0uSms7seurXFtx7YWeiFHhENAxuZ+XnlVm38X6oJysZ+MZ38UNZ+r/ZIQxOejJMUJ6Gfups6y+ucgMFxkMzOb4dr0ngv3Qd4r1dkAitwEFhaBp1ALjViBJzs5BWSRdSuzjZo05kw6m5E0NsCzbVdA7mtIn4G/FbvVSFIfWRVfzetn5ggLNXNIVtfnVBIyWijKmbBAtUMgrHrIQ+hzZuwT/+nTFUAz1VCEy5NR00aglVeLw8BIn9l3OeRipGF11+ppN2siVUHCPygY7wtrqSpyq6Vo4vAnWEwBdgfB5t1DCo9008xY00tBQezEEiL5d0aDNbLZr6YGJ/lhcUyinj4CrA6y6NmmsJk8PKyh2PiJqjx/7UoWcBrqM8xsWvW03e5S5g7FKaP4ZZU8BW4InAnIjOtIyGKA0utQlbF+0E5VDqL4m89Gmv2TP9F5xZPYAel+Sv//qPs8KNaYUenmfCxLpDGeXJpDyvjImBj+7vUY3NtnDHLQXmVPn8CA+Y7C8Q2I+5xJU5s4W0JttQQp/aEaFPgnN/mF9rc/5r3+O8jTNyk6d2T0YoGc6eEzf1Twj8RiMvda6jCILQEvAN9n9WPQPjoxyJK1II+S9xLkYguK2qpizH68Pux2Et+eh0RN0IliTK9Qwx6VtZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXhXTVRiRUFPSHVlMGVYZmg5TFp3S0ltUlJUSy9Oeks1ZURVeGpsNXRQZUtJ?=
 =?utf-8?B?ZzRtTHBJREJmRFMxVUF3bm5hVGhsbWpNTTRWNUNKRFNLdXpHV3BCRk1CSmcx?=
 =?utf-8?B?Z2lNamZUcU9rUzMwVE9UOW5QMFl5bmt3NzVveHE4QVh6OFVQYzJnZDdhSTNr?=
 =?utf-8?B?TUdmU2Z1aFhDeTJHMVZ5TEtFWlFOTWpkWUxzeXdBVWNmMkhHNlgzcVdHYlJ5?=
 =?utf-8?B?U3NDOFNPVFdMdldvM0NQamUwR0pmLzd3c0RGU2ttcjhIdWtwWGU5emU5SUVN?=
 =?utf-8?B?QWJvQ0YvWHlCZUNvUTR2N0JPYjdvRGhSUVJaTWRTTUh4cEtrNUhBVGxvZXlq?=
 =?utf-8?B?a2NaQldnUWtTVndOcFBJOXNNcmd4RStVWUxNQ3ZrRERhRytsajFlT2hFZGQy?=
 =?utf-8?B?b09GTEJBZVVHa0ZxVm5RdHZNYXN5RUdIZzB0dU5hUUJKa1Q4aWpvS0tDWHI2?=
 =?utf-8?B?RllIWHlqeHpQYVRCRDdOTHNFanVTaFJ0aXJ3b0tJOEhSNnB0dTVnMG9zekVn?=
 =?utf-8?B?eXQrQzl3L2tQL2JzNWR1amlxSTcvUng1WDVVY1Z0MWFJcU9zWlFZSmpLQ3Y4?=
 =?utf-8?B?VFg5RGdQdVQ4cHdnZWloK2hzRW04NUxNODJPc0g2UkN6RVdMM3NFTzlhb0Zk?=
 =?utf-8?B?WDJXdFdqaXlxZmZteXlBaTZuOWFpK1pFT3plUDUra2NOQkQ0RTZwRGpqaEt1?=
 =?utf-8?B?UWFxT2VzemFMUEgvVGhPWWFsR2VlYzEzemtmSmFiVFZxSXBNakpuSmwwcFBn?=
 =?utf-8?B?Q2RCdDM1aVIvSFVtaVdhd25TV1AvYUFPN3cvU29oWWEzSFZ1TDZaaUNzUERz?=
 =?utf-8?B?d3VlTkxPRE5VWHMyZ1RWcWM0amkwbXlOMElVL2l0RVBhSkpoK1NlZ3FvSEN3?=
 =?utf-8?B?emUwTnQ4cE1qZWMrNnFjQ01QbFRUd01JY242ZHUvOFZ0UVFPNmluU09va3hl?=
 =?utf-8?B?VFh5R1lUNVFOMnZ5N0NsZlFKOUllVkVhRTJXai8rYlJnb3M4OC95dHVNOFUw?=
 =?utf-8?B?S2NkM0ZKWGZ4RE1wKzRPcGV5T2hPK2U2MVdibDdFaldBU3VFSEIvVktZRHgx?=
 =?utf-8?B?bXNUR0srVTc4bmpxZ05pd2F4VzFiR2x5MEJwRjdWOWs4by91bFNZL0lnYmo2?=
 =?utf-8?B?amlmTit2Q2l4YlRYOXgzdS8vUGtrcXo5MEs0T0ZGUDdHVWh4aG5tcFZ0MFVs?=
 =?utf-8?B?UFZWZ0luZUdNTk8rbFA2QjgzQVhZNFVWYW9lTCt3dG1EdGxEV3poRmhncU03?=
 =?utf-8?B?RXMwR3hKWDBrZUVYbmVHdVU5SVU5cGNLbUZiN3NrOElsdzd6akpyanRGc2VY?=
 =?utf-8?B?WnJ0V21PQWhPYnN5VVVmWlpkbUM4VEpHZVlYV3RVMDIyKzVjaGZtQlJqSkRz?=
 =?utf-8?B?VkNTcG1RZWV0b0R4TWczUmhDVVZjS1oxUSsrZGszTWxhTkgwOXpYMzNvdGFz?=
 =?utf-8?B?UE9XUnZqVVJ6SkpxM1c0bXpKNkZvVm5SOFBxNStBZUNwMFFHL3lpZFprd3c0?=
 =?utf-8?B?NU0wTEhpYVZyOU1BZ3ltNmkvand4akpNZ0dwV3ZlNUZrZ09QU3A4b1RPRUhn?=
 =?utf-8?B?VS9kTGNoUkpZbkZCN3lTalhlbXZNMStUcEs0cEgwdmJ2MjhaUzNZYnBaWmRV?=
 =?utf-8?B?ZHU1NDNOa0I3cXF2UjFJWjdVV0U0UXlYMWFFa2toM0xJSmxXdzlXQ1hwK2xG?=
 =?utf-8?B?TGxKTFdwT2JDNUNocXhsMzlaQ0xIU1Jrd09tZTRSZHdDYkVmeTQ3TEVDWStN?=
 =?utf-8?B?dGcwUVoyVmlxSmljK3h2a2tvMnNaYkNMUEVYMUhsVy8yZmUwQ2xjaHZBN2dS?=
 =?utf-8?B?aW9pTzdDcUJta29aRmhKUVY1Qk5qRlZlUnNhUzJiVndCdDNyVzEwS1ZmdXVs?=
 =?utf-8?B?YW52MGZwUmFIRFIxSEtpUmdTS2ZDNFZmbDh3alV5cm5uMmszbmpVajhKWm5M?=
 =?utf-8?B?SHBPc3JmVmNyOG5kV3dZcHd5OHJ3eVgwWERWb3h4V01NbjJyRG93MGFMSTAz?=
 =?utf-8?B?QVpjY1ZtdnIzQXFBSU0vemw4ZkU4eHJZSDJYYkwyRjVGeTFBU0piRSs2Ukd3?=
 =?utf-8?B?a3BQdWhYTTFpQnJXaUxxY1dSRmtVaGwwTDIvdU85UGtvd05VcnBISHgydzN1?=
 =?utf-8?B?RGNmNHNlMW1tMmR3TWtMTkNFMkk2Z2pOUnlnOG1Temx3alM3RVM0dmRaWGha?=
 =?utf-8?B?Rjd3T3BTUEpWenUyOGdPYkpubGpNazZkb3BzeW4xMElTT1g1OGU5SUdjbjc4?=
 =?utf-8?B?MnZJaTlSSDJsdFpDbTBIaDBzczFiMEtUdlBlbU96WlFtaXJPejRhdVZ4R0NK?=
 =?utf-8?B?WDFRMit6VjZQUjhsQ1lCdnJZUG9WOFRpVkNPZFdkS2UwcTdrQ1pTaWFkQ2Iz?=
 =?utf-8?Q?mizMYEajX0VGe/PS9AvDOfFi9mB49lMCXwBOvYrwAmmv8?=
X-MS-Exchange-AntiSpam-MessageData-1: eCN0J4ohn7aSTA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ff5ed4-7249-457f-2b85-08def6e75b90
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:57:46.9209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLUzl9uONPhDp0Ojf6hqXoKzFwpHNraQWVPiIZmvC1rHDeoC0zJ1UmxIfbTBdSpmgfQ0/FAdbHhHVdV4xRptJA==
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

Make `shr` reject shifts of at least the type's bit width at build
time, instead of panicking or masking the shift amount at runtime.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/num/bounded.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index 9ad7df1a243d..90483d2c5374 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -485,6 +485,7 @@ pub fn cast<U>(self) -> Bounded<U, N>
     /// assert_eq!(v_shifted.get(), 0xff);
     /// ```
     pub fn shr<const SHIFT: u32, const RES: u32>(self) -> Bounded<T, RES> {
+        const_assert!(SHIFT < T::BITS);
         const_assert!(RES + SHIFT >= N);
 
         // SAFETY: We shift the value right by `SHIFT`, reducing the number of bits needed to

-- 
2.55.0

