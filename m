Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46096C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B32510EEC7;
	Thu, 27 Aug 2026 07:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZB36Y0ui";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95CA810EECF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWlGSiQlYKU4clDnwqwcro3XzISOnjjcese4ek/5b8V/aTKbiBKlZBjV7BPZ9HG0rBJ5RasJx2bH22ncjBcrsSwKtjELi6m8/nPAXzOwPtT9FHD50Ie2gw0RrdRmPyN4cCoaELImFwB2lN26bhuPQJSxEPto7r+TB1QLaebhz4WGjEDCrJhSUW1WusDIs7uvVtfiqI4eTzQ372xfvLrtdtlszvm5480GAGS+4DpcUKgChiiuxnWLPIkkF6is4rY+bhJKDShizxhZoto7tM6LizxtzknumYFE6m4yxT1A1mWBx8FUwL1FgnqJvZyXSmqNmNqJbiOXL4Qq6H30fup8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRJPJfeggJ+kULFkNGAzALNdZQf31kbGmiGeHk3gAXs=;
 b=rllNBFnux32P1utWCfXBQnp+y7GnL/SrQRI7jSTK7puY4Bufs40ULrFtVwDmgayabUS50OKEtpYG+uCo5GlqghGh2VYWJ+E6DE+iNSKtPXt+o9BlXX9TaLoHqmXGQcSK7rBR1azEqfCaN/CYY+iO87f0eu6mNSutnVQNSWlX9I77p/vBA9SGkRgjaCbi6jphztwY1BCm3yx0QbJ2sr/HaN4WbBGM104gMY1YfYiG9Lcu3+tCE6wc0Z1yNJcal0R1LO52bbV1cnb2C81BffdxnqWVGwnEs+n+W2yzSO0H5jr6U9GyORySQrbmqA4S6VFiPh3fXCMkDGZIC1h4/WFmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRJPJfeggJ+kULFkNGAzALNdZQf31kbGmiGeHk3gAXs=;
 b=ZB36Y0uiQtOIk6gQnq0RMBguy/pdfiPE93zJtlghCvpUAik1nFMYqXDVv6g/WLOr/pTTZWRrGURkEM2IN1wqSAA3mPq6XfRvKyOOker06mZ/5WhmX94bNAfo4y4zxjJ0GGCOAWoZgI6ZsXmyWaitsayCQnDFugfGiGGs3Hptj8XqOr0rMcnh/Dnm0t8YhANpG7cb4fwF8sF6frB58wBB1xSKaZscIso9cSdS4M+tVFejWW0ggeWeBKcClvZklLtRO9fg1ZfG9fWWtR7MkTg34YWZ3X1YvnJCcEmlzDMRrppv/Q6uFZK4rxBxp31rnvFl16mqsWldmUFV4ZkraCDsWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:41 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:41 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:34 +0900
Subject: [PATCH v8 06/12] rust: sizes: add sub-1K size constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-6-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0141.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::6) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: f03dccab-f76b-4bf2-da3a-08df040d190f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: LpBPokn8HWG4eCx/ZNWTQ6jOxsty8vskbcUpJqCG4rIK//p9GK5JcesVitpp9bCzLYD5ZPe6QHs/vMFTjzW2ljrGJSeuzEhczprGswlxzztUPTpdCpHQPPaI8fxwWjDwjPZEgwLL3bX2DRjsk33cHQZxUoWctwBQ8Ypfjs1TzZD2l3Av2WTnRB+92a6hgWv3yg8A9b9XKmoUa6IwKFcxOsOmjPeXpEAn9Ak8zsUR8e5ixKIO9fMDd/+ZOJzEQDjZDXme733qgUCM3gTm0hh/5KPO9nj+tLb7nkUyoOalsyXr2M0i1LsASm0xP6BUdE+pfEQFvHmLCJhRjGSOJm7Q9JUYcEe/X7N1MtbqiEP0vN5x9U4j2+NzQRG031zzDTamh3GCPgt340/WWuuvEOtIkFujwZ9jtGcdQzq5Yj0D1ONsa8HxjmLuOodrONGh1BlFYmUOB4M/AdC+a6nwSvbRog6yYa812KXfhRvcAEFU/4gQsJWtd13Y0TWl48yNltY6YqsmlTojFDI7Q1FsjR2bHBv5sk74BA/s3jcWsBfMrrJrsB9oDooAugqBku/SELlytpSsvGkpgtieBwUmJJ4GpPUQl+SN4753+bS0TzqWjIxG9yl4CgUcwYRGoj+uAW109e9xyvMWas1HkKhys8hbvFJvLUo3CKOg+DCkm/cuouT0zg3n+Crcxp3nBlK0tz9k4VEuszXMexdOdm0wT3UzYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktNL0lrNk5iUU1kYjBqdHAwdDg2U1hoOHJsY002Q29DblhkZmhTeExzSUdL?=
 =?utf-8?B?SllkRTE2SHFJd2FzVEkvekU1b0RJTE1DVm9xSURvK0huS0g5Lzcvc0N2OHhT?=
 =?utf-8?B?Q2Q1UjFrOTVWQmFabEdlbmlEc1lTZFo2RlA0VE8yOENPSWJGMHdDZ1NBZll4?=
 =?utf-8?B?RW1BcXRsQWdMb1h3SW9jSERreVFiNW9TMU1pWHgxenBRM2ZvVzJLSVF5TVFO?=
 =?utf-8?B?VVdvSDFSSHd4ajBkV25HTUFENlBnODRvNm91ZzNBU0ZmZEhPYXRNeXF4WWhu?=
 =?utf-8?B?QytjTHBCQzZHUTU2eHdWaE5Fdmg2YmxsS0taL2dyVzZCZGJTMEtTUWJzMVlK?=
 =?utf-8?B?dWQ2TE5RaWhsQ0ovRjRDeHFYbHZRd1NLOHc5YUpqbm1UUDBKVFd1U0NzaEVt?=
 =?utf-8?B?c3lXYVQ0azlHOFRCSDM2RDJmczhYUWV5dEg3Mk80TmRnaHprcmVGdE5sRnFT?=
 =?utf-8?B?Nm5sbGg3V0VMb1pnNUFMczR5MnY2bjZ1Q1J0UnBnZFNrMHBRKzZZSEdQZ0Rl?=
 =?utf-8?B?dlBXeU13d2JydzVjc3lMYlRFMnYvb1YvVmhPLzNaTGF4ZlFkd0p2K0xZeWNF?=
 =?utf-8?B?WEtiYllZMUE1MlJSbzEzQ3pUck1ha2Q0TmJSQkVVTXZwWmtybkhQMkZmYjkv?=
 =?utf-8?B?Mjlaa24zSzFublRpam9RTURkVENzL1NNVG1JMnI2Vko3TnpsOXg3b05YV1Vj?=
 =?utf-8?B?MHYyem41UnhHV20zRU9kZWhBdzFYZWMwdDRLSXpId3dPUjV3Q2hUMFlLNzBj?=
 =?utf-8?B?eXBwQ3NuZVVGK0NQdDhFQWgvNGIvbit5RGtzMWtvRVk5Zm1qeWwzRjRVSVhw?=
 =?utf-8?B?UDErWmZ5ZWNsMnREckhUU3RWelQ4ejhlVkdTOUtldzZFZG9yNkVsaU42YWZH?=
 =?utf-8?B?dTUxYXZpVEZRL1U3MFowdjhFdzREaEJxc2dTSWVWUWRTTGcwQkduNS90L0NX?=
 =?utf-8?B?cHZubUxDaWlMZU5mR01KamJJMjZBdW4zYjVucjROWnVKL2h3bnBNV0Vsdlo1?=
 =?utf-8?B?ekRiYWlvMXBEUW5kdmVhd0VzOFNZbHNUSXNSZXlFTVhqSkRoQncyRWM2Qjhs?=
 =?utf-8?B?aW5UNGM4UThxTmJJZGY4eG1NQmNIOXB5emVjaVprS2U2OGo1TXhITnlFa2VP?=
 =?utf-8?B?ZllHdUpQYWt3dGtzUGhQVjBMK1pWbUx2NkIvK3Fsb0JzeVFwazVlQU1YMTZW?=
 =?utf-8?B?UnZNK0RCUm42cmpaYTNpSmliU2IwMy9wNHhOVE1zZGlCVExsdWFXeC9VRHVS?=
 =?utf-8?B?SjRyT3VXL0EvcWl6ajd2a01sODZkRVdwcCsxZ0xVeEt5Z1dIeW1LdCtrYXRL?=
 =?utf-8?B?eko2ZWE4QjJiSXF2TnpkQWhTYWdoRzR4TDBHb292WTVqcUtSc01CTDFmaTF1?=
 =?utf-8?B?UC83aGZnUU9HWGsvcFZURGhwcEd2OG4vQWdWOUcyOXZDWmZmN3RqZkl1SVN2?=
 =?utf-8?B?LzZhOU9BSzI3d05jMHBEeXpESEVObnEyM01GL0ZhcUpuQlMyY1p1ck0vMVpZ?=
 =?utf-8?B?dHJycjdYcUo4aVBzNkNuVEhLSmE4RjViM3hKaWtMVFFQK3MveHZ6UXRadWR2?=
 =?utf-8?B?RDE5ODQ2YUV0dHVDZnZXUGc3NEUxYUVXbGRacEwxdFJQYnN2Tkh1U3Z4OWQv?=
 =?utf-8?B?S0RoWDVXS0IreGgrSm0zZUlMT1VtN3d4TG1ieHVOSEhtNi9qWTFKQVZGdUcz?=
 =?utf-8?B?SU9HK2ZyZWg0cVRzOUUwVXlsSW1sais3TEU5YTdLL1dhV3dsTHBOc05jN2lj?=
 =?utf-8?B?ZXhlcTFZM2tjMktGK0Q2MjFEazdtTy9IejllLzA4LzdkbUZGVjZaTVpEejVO?=
 =?utf-8?B?TzVwdjVSSnNkcGEvODk4ZUY4cSs3azBhanhISnpoZGNSV1dqNWtkaVRWQ3JB?=
 =?utf-8?B?RlY4TG4vTnJIYUVCMjdJek43dFpSL3J3VWc4NVNNSXg5OHA5aFc3SVZpSUtq?=
 =?utf-8?B?WThNb011NVBGcE1GTFgvSHFXbHdjVmRFcnBNbWpITDdPMU96aE5ROFpvT29N?=
 =?utf-8?B?SzBlaS9tTDNPLzNlRHNUK1p6ek5RSGYyMDZYcnlPVzZYaHJOb2p4UWF2STM1?=
 =?utf-8?B?VlJuZG1Uc2s2OUtuYnFyUHB5dzhkYnZ4VnVVWVpvdCtQS2dtenFqejE4bzBQ?=
 =?utf-8?B?ay8xamRsRHVJZmpjMzV5SEE0OGZ0dDRuTE9UWWl6UzdSTkIrNDc1ZzQ5SGlk?=
 =?utf-8?B?S2NSYUxCNllHN21paDM0dHJyazl2b0QxWDBEclhZUGw1VS91dzVQSnU4VFN0?=
 =?utf-8?B?SGQ0REVrUFJuZW0zUkp3VHhMN0hBUUozNkN6MHRwVGlsYWhMTUJERmNWeHFZ?=
 =?utf-8?B?VkR0Y2U3WE1VaTRFZHhoOFhUeDVKdUJlU29GeEVlSE5EcVM5YzhHZ3ZWT2Vw?=
 =?utf-8?Q?GfPCvUWC32VoJRdM49CJbdKF3OVroKpbjh4SBG11uZH6R?=
X-MS-Exchange-AntiSpam-MessageData-1: BtwkbJ7DOIUNOw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03dccab-f76b-4bf2-da3a-08df040d190f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:41.2608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryUpYOs85cK7cTPHFhaTRi0zNfiGMC3nFlQgZXe+9TFQwFzQdYNQ1H1yWneM6hCkVN47hGYBCqnw4Gwf3wjelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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

Add some more size constants, mirroring include/linux/sizes.h. This is
useful for making `Alignment` implement `SizeConstants` in a following
patch, because these are more common alignment values.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/sizes.rs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
index 521b2b38bfe7..7d03361eae3d 100644
--- a/rust/kernel/sizes.rs
+++ b/rust/kernel/sizes.rs
@@ -35,6 +35,26 @@
 macro_rules! define_sizes {
     ($($type:ty),* $(,)?) => {
         define_sizes!(@internal [$($type),*]
+            /// `0x0000_0001`.
+            SZ_1,
+            /// `0x0000_0002`.
+            SZ_2,
+            /// `0x0000_0004`.
+            SZ_4,
+            /// `0x0000_0008`.
+            SZ_8,
+            /// `0x0000_0010`.
+            SZ_16,
+            /// `0x0000_0020`.
+            SZ_32,
+            /// `0x0000_0040`.
+            SZ_64,
+            /// `0x0000_0080`.
+            SZ_128,
+            /// `0x0000_0100`.
+            SZ_256,
+            /// `0x0000_0200`.
+            SZ_512,
             /// `0x0000_0400`.
             SZ_1K,
             /// `0x0000_0800`.

-- 
2.55.0

