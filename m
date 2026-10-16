Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD435CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E2E11255D;
	Fri, 16 Oct 2026 01:54:52 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B376610EBAE
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ev+roCHWj12kNO4xM62t01ygjNyY/+OyDtwIQVk1X8qwZi48WaMECZ+kkgSHuat4MHBxZWwYUUq69dH9r8wHbh5TqKvUZ+yiSIc3YvkHkGqy3HmyU2EKP13AxSB0zd5Nnp+rta5PTtqHSvgodXWLvjDhMCWp3Xa6gcBN+vwHwZjZZhzxWAYm1ci1Vob/7+vILS9I8oHEjyN9fm6b0EhFHEJ8HFiK9LvopP2IAS3/HBBMS6kb928Ma3cyXPH5R/5pgUo1wHcUJ+72wyhe+vPqjT+TpO/T89myAN7+sJcwpQgEmuDWt43QdP/PsK8IdHhe4MKfU7yHgWZh82lSNuNoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UctnmKN9SztN06AHJNUNiPzrY+w5TmhFNh9xATttYWI=;
 b=r7NLdKLhs+ruHHzrI5VxaiK96VFspsJ0RTq3QrUNCgwEUnJvm+3pW0uk3Px/7gjK+tzl6A1nhuJfoVic6qFRp5gQBUXlVifKQ23Bd8+FfcH4YkY8MTSAYs2QytggkMQFhtIxPbtUHRlVNWtr9JpCSK9YsBhbnjq/kdtfjULTeNtXa7Mqc9vP/RL7PojWWZqUDpeWJ0Dluie5vxt2tTNHucLl8DFt9EquOjEP9Tv++4SLzr3Apb8suXBXNTIsgrI8fAR87Il88SMMUTKSp1Lu0aNIAMN9qnzM3EKJv/Ya3Ar5JN49EZBepSav1tfbYxrqcZRoTDkCGG0Rge1LPV+y9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UctnmKN9SztN06AHJNUNiPzrY+w5TmhFNh9xATttYWI=;
 b=Wj7dCx5TxlTkcwC29WZJScgMY+wJk3ez9BVnnbgn+AhjLuMec+zIF+7xNl9+uYSOTweEzHcghUFhtYm3wJlbTkDcehkPkeq2f0o632cYRMCu3TuHNvgjz2WdcIrJxPQ4yE07HztHAYAzdKZv2TXOX404uWx8Za+5+pXpEJXzQXuzZnulSWb2LsXrscF/NfB5ckmMPuBk31W6ihEALL74NL/I8x4/aojw9s3P3BNvNQtRYAiNsKhW/HAZN1YzzwKpiV/MKra2zxS0/3xVwzgdub0uKgX4pC+g9X4G8Lp9lGBh1cwOmseL2UEMrKLxaJOQX9rPUA3w0UiI9cpNWXsHFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 01:54:07 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 01:54:07 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v4 0/7] gpu: nova-core: add NVKV codec
Date: Fri, 16 Oct 2026 10:53:36 +0900
Message-Id: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XPTQ7CIBAF4KsY1mJgCoiuvIdxUWCqaGwVWqIxv
 bvUv2pcPvK+eeFGIgaPkSwnNxIw+eibOgcxnRC7K+stUu9yJsBAMc2BGkHrdEiUF7yspAWluCW
 5fQpY+cvj0nrzzLEze7TtwF+NgOcuT7Rjbedj24TrYz/x4fU9Nf9MJU4ZNVo4I1ELo+arOnnny
 5ltjmQ4kuALwheEDJnDhZNWK6ntHyxGuAA9wiLDignJRP4hWPiBfd/fAZIlnms4AQAA
X-Change-ID: 20260812-b4-nvkv-131af5c2661c
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
X-ClientProxiedBy: TYCP286CA0332.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999230:EE_
X-MS-Office365-Filtering-Correlation-Id: f8820ee6-f54f-42a3-501e-08df2b285cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|10070799003|366016|376014|18002099003|10067099003|3023799007|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +cet2tDfSlL+RnY6/0hXy0bgQkKDKwLLbrz3RxqTPDYR5QU4kb7+TwwoAVR25qi3KvnknjtyuwBdEB5qmp4aImOYMvDIBMdVn9rhVrjEWXg9JvK1/qqRsBY9byoTvSgYH9dtgcwxQUMHSroG2MBXMwe3lg0XLh3N5ueyrSVDDWJvYczft5aAadut164QXakA8ngqyJjHr4ia5e/z1bPiTTdDqlm25OKY4sAgEGK+xayHZ2X49Fa5VjDCRAG5gkkKz7zsqfr9vCbfSuGeHIJkYmKSCw4LgL1dfEWZ9t2Nk4E3gR7+TO9+JIhm40Cj6/DA1sLn1xDIFpEY8clWlC+2Zlch/WECg/j/HFpR07byF8uRK30iqUyvH3G51ViG6rdT2HAmFnlht1sM4Pm+3y5bhkkC0xG4/Wm0BYXYZ0bW2p0/njIDgWyBnuNO2izFCNO7+yx0xGMz2ACeWH4EtZtXS4zBhvCEpipQizf345MYaO4rvcGukEGS0K4U7rnXJdZzbBKE67KbgWMmq1pem+PLmZGnDZctKnPmOyXRb0NA6e1/kUsm82Sj7eya2wOh11n3UevUrLJwOFAJMkIiEJTNZsMehEjaDIU/6QG/fcT6uigZIVP5hQD3QJDrz2/OTBbD6Z3T1w1h/fSMqQWacVeByWv6R+Bs3U1FlVi2tmiXnSNaX4cjSFWqYzcxgd8G9W32DHnVdJippQSXcGC78PmHkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(10070799003)(366016)(376014)(18002099003)(10067099003)(3023799007)(921020)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFhLT0J4K0plazVkbWw4Q21rWmdYNEo0VHU2cDdWNkdUb3loVE44U1NrRkp6?=
 =?utf-8?B?L1hYeTdQOTJoL2JwZGZIWmpDeW5ldGd4RWIyUVhYdHJsZXVTSHBnY3hkQTRh?=
 =?utf-8?B?dWxkanhTcWpHaXpxSFA4U1RkQnhBcThEOEYrWnR0V1JhdWRGWVQxVnFFanBx?=
 =?utf-8?B?N1RUTUI4T0pHM2p4MlBjR3JRWHhvU2czQzRqQWs2V0szTzNSck9rdTJQSDJm?=
 =?utf-8?B?ZlNmZVpWdEZ5WThQRENiSm9PY0xtc0xBWGNvTzA3RTI2endGOFpPRmlqZy9q?=
 =?utf-8?B?OW43N1FxcWc0VUI5ajBFVHBRakhlSVF4a0NyR3FLNW1RMTRZWWhHZnUxaWRy?=
 =?utf-8?B?WUlQSWxKMldSaDNDZlpuVUR3T2dodjZjUlN5Uk1jK01LQjljV002aEd4Nmow?=
 =?utf-8?B?cUVYVkI5V3o5RE9ibkkzVDJLZVozUDkrSzdTTUJpQUJ3NzUxR0x0VjZ5dTA4?=
 =?utf-8?B?VEord09rS2dOWERaTFVKR1JQTy9uRGdVVVJ5aE9BWjE5QzFOLzVVYVcxUDZL?=
 =?utf-8?B?WEZiMERpSE4wUjg5K0IwRXIyRlh4dU9LYW1ETVYvRUZVN3hFSndKZVZ2d2Ft?=
 =?utf-8?B?V1FpQjBSZEhwbFJSWm12N1ErSzhxUVhta0podTJvQzFpZnRYNXNDUnZMMjFM?=
 =?utf-8?B?TExKYnB3Mk9QdDlPVnBLdTRZWDVWc1I2ZERKM0ZyblovUVNxaTB1ZitwSkxx?=
 =?utf-8?B?a1RNdk9VNWdZMFAxOFA5cHFpYnhnOTdzM1o3TkRQaVNJWjR0eVIzM1ZGUjM3?=
 =?utf-8?B?M2llRldDYXdRRnlaYTM1MVFqdFVzcHhjb3lVYTV2MXRTNStVWVVtaGx5WHVB?=
 =?utf-8?B?SUxhS2dBNkowWkRReThWRkcxNEU4NzZuMUlVLzBjeFQxVERGck5wbXZaVU54?=
 =?utf-8?B?VWl4aEZkeUtaUlJueGkzeUkwT29NcVh4SStZRXVqMys5SVdxQ1FVdHZjaG1m?=
 =?utf-8?B?QWFtV3E0UnN3Y3VFL295eGZzVXBzbUh6Zjc3ajY2TFBvNXhiS3JzQWZQSGNE?=
 =?utf-8?B?RHl0TzdacXpGcVRvNnlGYUZZTklpZHpZcUZ2WjQ4amZEUEx3UEl3eWFjMGZq?=
 =?utf-8?B?K1RYWk9KY0pqWitjd0FFaGprdHpQbXFyU09TMkhQV0ZWS3pSZFd5c0NIdTNV?=
 =?utf-8?B?MUgxbmVkSW1KR2QzaVhZY1oxWDB5RGVReGhxdzREd0RDbzJBTmpqa1RJNHJO?=
 =?utf-8?B?dmVVZmVtZHlIRjNFak1tMjlyTjhCa0ZWRkgzejdWTVRta3ZBSzJFSktmcnM5?=
 =?utf-8?B?SXhrb3RjZmpJTGdQZkYyOG1ROVBOb0hMRTZrdXVqSE41aDNXTDZUTFpFOGFz?=
 =?utf-8?B?RkdBREpydUs5V0pYQ2hZZkkyaDdJNU9RVkczZmkvOW5lME94UHltM3l6VnpG?=
 =?utf-8?B?QmV1T3VMc1NGNzJ0VFRiY1kyM0g5REJ5MG1neCtiZGNMalBiWWNrSnpVVjFh?=
 =?utf-8?B?U0g4QXBicmt3REl5VlNaekU1UlVTeVIxMzVSUTY3ZnIxSUZzSno2U3BBVUJD?=
 =?utf-8?B?dUIzVXNUdG5TMGZuZzJ4bmJ0SFlUcmE5dGQxMzZ2dGhLa0VYNnBYeldua1lV?=
 =?utf-8?B?amFzaE5CQnVTYTZxM1pyR2NuaUNYRXlEd1FWem1LSzg4N0trbDhJYzJXdHp4?=
 =?utf-8?B?a0RnQXp6TVZheTh6aUJuY0ovL1ZrODd3OFVudGk2dVdzNU0vaWJaTkVMMTA2?=
 =?utf-8?B?S21qTzB3TkNkWFpaS0VlckpCeWRGZ0wvRXlzWER4VTNKYU15eWZrWlpySlRa?=
 =?utf-8?B?RW91M3Y2MEZ4TkpNN1p1Qlh3TW8zYUdpa3pra0lrMGloRGhxRjVnMnJUTUZy?=
 =?utf-8?B?RkRlOFVUUVVHSHZYeXJ3d29WN2xQb0NhUEVoZlUveW5SOTV4WHhKbkZTK3dY?=
 =?utf-8?B?MFNlNENHR2dUclRKbEYzSHg2MkdUR3dXZnFpUXB5ek9XdDNoMitaczRRVk4z?=
 =?utf-8?B?Y0x2NEtRcW5RWDk4T0p3TitEd2E4V1FzMkRyd2N6OEptUy92SzVPM2lUZ09L?=
 =?utf-8?B?dkZFS1p1eXlRU1IvckdneHg2aCtIdzJ0SmpBN0dKeWdWVUh6dldyWFZrMFpY?=
 =?utf-8?B?RklISlliM2d4TXJTZUp3TVhiOU4zdUF5clFaaG1Nd0gyNTdGNGFuWmxNSEZB?=
 =?utf-8?B?ZTlxandpbG8yRXpFSXArNUxWNDhkQmtKTkM3RU9sMGZKbjRlS3BXTG9STG5L?=
 =?utf-8?B?VmxmL3o2QTFHaHBiN3kva1NHa3JmbEdOZGVBTU5UYmJ3d25NT2JCL1M4OU9j?=
 =?utf-8?B?TVdsV1RJSlpaeHJmbHQxd1M5U1h2Q3hSQWIxd3Jwa3ljZFlGdlJLWHEwYzBx?=
 =?utf-8?B?eVBsNDZ3d2NxVjBvZnlDa2NkMHozSE0xcXFLV09xZFJSSjB1TkN2cjM0NnZl?=
 =?utf-8?Q?+buL4DwTqZKpOhf1HbSYdfruqGOmRvAtTsx63hQNHlICx?=
X-MS-Exchange-AntiSpam-MessageData-1: a9oGfWv5VknD9A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8820ee6-f54f-42a3-501e-08df2b285cf1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 01:54:06.9243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u34TXYDPfMaiWAbJmR/DLQsNH32rkGq+73pGamBVbh9FbV6JAGuLnCF01w0QANgyHR3tTumGgWgnE9FXhBJ0FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999230
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

This series adds support for the NVKV wire format for communicating
with GSP.

Essentially, the format encodes a sequence of calls to some function
f(key, index, value), where value is a [u8], u32, u64, [u32], or a
[u64]. The key is a u16 and the index is a 12 bit integer. The
interpretation of these function calls is per GMCAPI (RPC interface
used in firmwares later than r570). Generally speaking, the function
calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0,
b"some gpu") naturally maps to storing a &str with the GPU name.

This series adds a general encoder and decoder that works with the
base formats used ([u8], u32, u64, [u32], or a [u64]) for encode and a
general `Schema` trait for decode. This could be used directly, but
since most messages are struct-like, it's more ergonomic to use some
typed helpers for this declarative use case. So this series adds two
simple macros for encode and decode of structs, plus some general
types and implementations that help with using these.

Future patches will wire this up through the command queue.

This is based on drm-rust-next.

---
Changes in v4:
- Rebase onto drm-rust-next.
- Fold Vec::push_init into the Vec::try_push_init patch (Alex)
- Rename PushInitError to TryPushInitError and replace FullError with
  kvec::PushError (Alex)
- Add #[inline] to small Vec and ArrayVec methods (Sashiko)
- Drop #[inline] and #[repr(transparent)] (Alex)
- Move IndexedKey to nvkv.rs and make it crate-visible (Alex)
- Make Required work on schemas and add Optional (Alex)
- Add stack asserts for decoded Key and Optional values (Alex)
- Drop the GSP_INIT tests, use literal key ids (Alex)
- Doc, test and type cleanups (Alex)
- Fix expect dead_code for CONFIG_KUNIT=m build
- Drop the clippy exception from the ArrayVec::new() stack assert
  It turns out this isn't just clippy, but also -Os.
- Implement ArrayVec::init_with with Init::chain (simpler)
- Allow a lifetime on nvkv_encode! structs, like on nvkv_decode! structs
- Add a stack assert for encoded Key values
- Support the As type of Key in decoding and use it for FbRegionFlags
- Add TruncatingArray and truncate a long GPU name as OpenRM does,
  instead of failing to decode
- Drop unneeded bounds on Array and Schema::init, make HostArch private
- Link to v3: https://patch.msgid.link/20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com

Changes in v3:
- Rebase + drop zerocopy prereqs which are in now.
- Define Opcode with bounded_enum! (Alex)
- Use #[inline] instead of #[inline(always)] (Alex)
- Add Co-developed-by for Danilo on the encoder patch (EncodedStream)
- Split Schema into Schema (init/finish) and Visit<'data> (visit) to let
  schemas borrow from the encoded stream
- Support schemas that borrow from the stream in nvkv_decode!, e.g.
  struct NameSchema<'d> => Name<'d>
- Construct schemas only in place with a required Schema::init() and
  drop the Default impls + stack size asserts (Alex)
- Doc improvements (Alex)
- Add a TODO for the O(#fields) visit dispatch in nvkv_decode! (Alex)
- Replace the Key<Option<T>> special case with TryFrom<DecoderValue>
  for Option<T>
- Make Key's field and IndexedKey::new private (Alex)
- Move the nvkv_*! re-exports to GSP_INIT patch (Alex)
- Add decoder tests (Alex)
- Add error path tests (Alex)
- Add IndexedKey tests (Alex)
- Add RegKey tests (Alex)
- Link to v2: https://patch.msgid.link/20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com

Changes in v2:
- Tweak Schema trait to avoid materializing copies on the stack
- Move ArrayVec to alloc module (+add potentially useful methods) (Danilo)
- Add Vec::try_push_init (Danilo)
- Add sum error type for try_push_init, PushInitError
- Use Danilo's EncodedStream abstraction
- Add some stack space asserts (Danilo) - needs to skip on clippy tho
- Using zerocopy e.g. ref_from_prefix_with_elems requires updated zerocopy to
  avoid linking error, so added those as prereqs.
- Link to v1: https://patch.msgid.link/20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com

---
Eliot Courtney (7):
      rust: alloc: add Vec::try_push_init and Vec::push_init
      rust: alloc: add ArrayVec
      gpu: nova-core: add NVKV encoder
      gpu: nova-core: add NVKV decoder
      gpu: nova-core: add NVKV typed encoding
      gpu: nova-core: add NVKV typed decoding
      gpu: nova-core: add NVKV GSP_INIT schemas

 drivers/gpu/nova-core/gsp.rs             |    1 +
 drivers/gpu/nova-core/gsp/fw/commands.rs |  157 +++-
 drivers/gpu/nova-core/gsp/nvkv.rs        |  189 +++++
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 1208 ++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs |  477 ++++++++++++
 rust/kernel/alloc.rs                     |    3 +
 rust/kernel/alloc/arrayvec.rs            |  338 +++++++++
 rust/kernel/alloc/kvec.rs                |   86 ++-
 rust/kernel/alloc/kvec/errors.rs         |   32 +-
 9 files changed, 2487 insertions(+), 4 deletions(-)
---
base-commit: 5a1b7121a6c4db6c0239d3ac3fd1c2bb33a40025
change-id: 20260812-b4-nvkv-131af5c2661c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

