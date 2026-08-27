Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AF2C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F6F10E3B7;
	Thu, 27 Aug 2026 08:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gMWVGUPg";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011033.outbound.protection.outlook.com
 [40.93.194.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F45210E3B7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6WE9wKE3w9QrVcLmbAW3U8pKUBPXIiicelN0gze8wTYcTyQMvaMcOvPAn1QaLvSho0wim1cS1WjKpfkKJvIqUDoUzgEkFrBLbjGVqwWsNGgqsUJeyVIcIIcY1vZUydmpJ/UEFdJJ2e10ol6UKb8eAi7j/4pncjtW2wd/5TVmh2l0I3LHQrOChDTP9d1OaogF162CQwECQlefNLWa283WzoMwZbEcs4yPq5u3EQW1PqhN1ktUmGt7JNN952Vqc9EVizBNF0y20iGjFJSLm7VttTC+j5DQ555LE7P/HHPDOcqyxP6RyCYQh/HKE5dOEgaeWlfwotU+9wpUAXTaeiFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vdsr036s5t8hgvDktTxc5HnFctzmi0tcT/PZHzUKwE=;
 b=WrN1Ok10Fi3GzS27C6FSTvV5/F7BoqSuvpqjYkPAUQcPvpkTIxmQGaLb5Cex+8+/lCnWLr6B+B4SOJ4zxiMxEWQLTEglW0ywLXZUKKyQ+yZFCfKzJ0K1wGZxzNb/5ybd3fBCm8Af///XleLfIP28JjuKqHHAeNA7m0qwEYWleEdnYXMFZjJ8M2AUhgNWKuuxGr3/T4C00pGgbtwrrCFy1tGOz/R/qW8kBQL0wtbXw/tuZh9oZk9i2WOH9/dBGRZX4rooMdvzS6xRhpZedfHa4Opq8DQd75ZsFFjCyT0223fV+GA0i0pOFhJ/k8Fh1xtfnBm6dg8aO9BtfXhXgmZr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vdsr036s5t8hgvDktTxc5HnFctzmi0tcT/PZHzUKwE=;
 b=gMWVGUPgHtaCweNd3UqH7mtSk3lKCX5o4aaf5s6k/hYIkRauo+yYmL2wQ+KOmTFPJtfos4y47sCucF5MOnMZGX2KMD9lnKiiS5AkLZL8wWNFNwkctwJxfdUEJ3T76oGQidk+QJiAb68xUzA0T3AFfWGC1iQdlAfAzCtsBVWNaBaxMOVqBphU6JV8EcU9zPXzaIy64RZE2LEdyk68DIYWRSrJD1AHsLInjndxP3lkDkAkgUixPIK8py2IKGXdX/LeDwWz9O6WK2HQfitmCCuR+5LrpI38vH1IjDh9X00/fWj3oBFQmDpEqkaU6sxHFqNkf9eCbHGtHk8xh3MDeEAryg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 08:52:06 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:06 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v3 00/10] gpu: nova-core: add PRAMIN window support
Date: Thu, 27 Aug 2026 17:51:41 +0900
Message-Id: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12QSW4DIRBFr9JiHSKmpoeV7xFFEQWFTZQeAhjFs
 nz30G1FsrP8ot7jV11JwhgwkbG5koglpLDMNciXhtiTmY9Ig6uZCCY065miazRTmGlav0KmQ8t
 QcAYapScVWSP68LPr3t7vOZ3hE23eHNvEKaS8xMv+X+Hb3J+6fVYXThn1XmKvTNc6Yw9zCS6YV
 7tMZHMX8UBz9o8WldatYQyk7SQbnujbvVrE73NdON/7EjAJaX2fQh4b1ForL0BKBwPonnMEZdF
 yNnimLQhQXrW9I4+HGpu9TSc4zZcV3UfEY90XI+WdRgPSAGI3Flkr3H4BzxSnSHsBAAA=
X-Change-ID: 20260804-pramin-split-950e210b6e3f
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
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0033.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: b42b3e46-8ea4-410f-4c4b-08df04187909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|921020|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: oC2zbDpVhS7EEAiJ7SrcQvY05iTgLzOLJyBzMsn+eV2UaSfkKXJuprjVSPewroUhUCs2wjK5Sx2Z8TYSrel08yx6WqjBeiVSEc+isl2xwDnd1K6jxClR+3pFojXR5Ptd3+E4qucj7OgH97kYF89e63YDKESkhr9VN5J3WIWgvNN7OpHxz61aPf0qkrelHG+WOb8HHFDvEszXj0b3wCS0DYiKkYcIvgDkxThscdFU6g09B0sBu+yOJQn/7hG0bFvK4BIrLr0gZEzHeeNuZyskN8dNJHLpJ4Ec6qcM0UqDDZXnPIrDAda5nzGG8jbXk4BT4BT+TFJ26jI9y764zEV8sjb6ta3nOWgmZJRkd0UxNFMQjaENKEk+zoIHLoUMeVSOqJXlL9wWE35XJJ8etUnttjrG0wtyYrieTXJfOZXobXAsNlx/3EjOWDWAJoR8Hwt/VwgpVIrxkFJAhqM7EEfSsIiaekTQ4egpWzr/OPi03MeN/MFpVA4C5l1GpxtOw1xx9jc4O59qu83EV/PFZV7NieD0t62y6usn8Pb3KHmL3utrIolZ6mjZVNsHYXZs2PSPAmyIl4HLZ34eqWh9mlotZPizyr8CsbkmIRXN38YkwJRblOs7/fwBAxixLspx5tkUnh1VgIUxELqQeVPtBcE1JoUO5m5DTxMxP3PzLDQ81lTlW06KHb2RhlRlk0gBd01gCY2XN5wABS+O/MHuP3k3Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nkc3SUFDdnBmbUNSdUhuTkFlQThBd0NVYUp1MUlIUmFodENqRG0rbEJrRHV5?=
 =?utf-8?B?TlF6NEpIOEpiMGFka2NUeGZiWFhvaXhZbkQ0b3NwVWRuTFJPemF3VlBJRExl?=
 =?utf-8?B?T1FsYmVPMGx3Q1YvQXlUNzM2b2J2bmRDMjcyN2t6bVl4Sk9KbUdSTkk2TUkv?=
 =?utf-8?B?ZWh0S0x4Z2d5QVRlNkFrMW9keGh3SWtzQnBibno0bklLTHVHUWJsWnlZMmha?=
 =?utf-8?B?SFFqOENvOXJ2UlF4N0krTGtzQWFORXdGUjM0UGt1Ylp4OTFQUG5LYUNkQTRo?=
 =?utf-8?B?T1NHUEN5Z0I5MFZPMnhzYll0SkZFcXYyV25UczFGeUNOanJDSy9kUDZXNWhV?=
 =?utf-8?B?Q1JmSVJKYUpCRFZKNGdRZVZsQU9XdnBtTEhjeU1pLzdqRW9GbHlxTWt6cUxX?=
 =?utf-8?B?cUR1UXhQRU5RQktnd2oxU2xBcENzbTlNQS91K3gyZ2p3aXEvSkc2Smx2aWx0?=
 =?utf-8?B?QzNqYXIreWtXZEc5ZXM1QTY2b2JmUTFoMVdieGJHV0k3U0hVUWJFMlRya1FM?=
 =?utf-8?B?SkRQditqb3hjeXlHTStKSVBITTRDWHUwalMxUUNYMGdHbldDOG1yaGl2Mi9u?=
 =?utf-8?B?WGttdGhKNEdnNWp5ZjF1NWtwNEJ0ZDRnT3UvS09ka212K1pkTTJ6ZXJxYi9N?=
 =?utf-8?B?NTZLOUVKRmoxQzllZjY5dlg4YXFXekd6MmRzNXNWOStJam1CQlorMzkwNWxa?=
 =?utf-8?B?M1ZhU2l2THBndURDZ1JpKzRCQlZhY2tKSEJkQnZRbG5qc1ZDd0VVZ0lqVnRa?=
 =?utf-8?B?YjhxQkt4QnlGSEhaQ2tnUDIrbVhKMVFzdG5qc3lhaEg1TDJwUGhRUHJsMEh4?=
 =?utf-8?B?dDVhMG0xRUgvQ3pxNHM5OGxVNWVpUVFIUVRKMkFyeWZLYTBwQkpYQU1iQlNO?=
 =?utf-8?B?OXEramdzSWpuTWJaN2NyOVZEbm9PK1NPVks0ZnppMjd0VEFqN3JYV0tPWmJY?=
 =?utf-8?B?ZWM2QXA1aVoxSWZWUU5tcFJ5b25lYkVOdlZzcm1RZW1NOVJkUHNoZytwT2N4?=
 =?utf-8?B?NENHSWU0ejZrUHoweTR1b05Rc3lYTEg1M25DUEtiY3prQ0d3U2ZqVm9HSXQz?=
 =?utf-8?B?eTQ4ajFPZm8xQy9TajI0MFNmVUsyQm81SHhIRWkzM0x2QWdXbWRnUldOMnZa?=
 =?utf-8?B?R0JJZlc0MXdGb0c5VVdwYXpDQ29rd01UaTNMTUFzRTBOaGpKcFBiZmxXaVJo?=
 =?utf-8?B?T3A2Q2FrbTJ5VHVKa1JncllacjBBYUZGSlgxSVhpOFViS1JLZUlBQmhqNTFG?=
 =?utf-8?B?UVhzem1wc3IyVHozUFoycjlsWmJ4bHo1SE5OTUNab1VYS0kxTVJrN0p5Mk1L?=
 =?utf-8?B?YlRYZkdwYTBsWHNzZEkrOXZkdDFib1YwZm9qc29UTGNhU205TG5qSUxFK3hi?=
 =?utf-8?B?bTNyaWFzY2l5ZzVhZkxrZ3RHakpqcHg5dTFCdTkwc0MyNFJ0Nkd3cks1OWRq?=
 =?utf-8?B?R3hWdGRxY3VJWnQ2bUVPYmJxYTR4MTU4RFlUcndmdXc1SmVvWFk1L2tWQ0tx?=
 =?utf-8?B?SUE4dFZqOUkvYWFQdVhETUsvemorbkRyLzQvRmlJWE9LbTg5eDhIZ2E4NmFW?=
 =?utf-8?B?OElUdU1SUjZMSkwybmZ6ZTRUem5POUtjL0FFeDZEMjdKTzBENzY5cVErVnM1?=
 =?utf-8?B?bzNhVnc3TlNYa2NFTWtKQ3drenVCRDZKY2J0bHFZVGtUSnRIUWVRVEdGREha?=
 =?utf-8?B?UlN6dDQ5Zmt6WUFlN3hEbTFVSlNiVEJRNUxscUxGMEU4N0F2aGpxYW9sclda?=
 =?utf-8?B?WlpXU1o3dEtSTDgrbHpMY3hJTGkvOWZDN1pxK0JrcUExYkgvbmlNREtCQWFn?=
 =?utf-8?B?UktpYncvLzF0d1pqOVJtV2tNZmt5V29FNnlHb2FrcTVIbjVzVHg2ZHpYYVR6?=
 =?utf-8?B?T3BJVVcrUWpsSTA5LzVIWDJldE1NbVh5RU1Oa1hwbmxVWUdKSzR4QStLVDF4?=
 =?utf-8?B?YW5lYTFNQ0Q2NlNRTVltMGc2SVg1TkRxREo4b0tsNldkVlJBb1VzVkdBRDdp?=
 =?utf-8?B?RkNjWDc2bitVOXFYcWdQaUoyQmVLdzZIcGIwNjdZZWh4OVlDamE1TzJEd1Rw?=
 =?utf-8?B?NHpydDVzQmNnaEVpSk8zSXE1TXJmaU00eldrUGY5M2ZjTk5wZW56L2ptbDJi?=
 =?utf-8?B?Qk1lMWV1KzVVbjB1Vzg3bjI1RjJBTms0dFVQWnc3UWNXUTJUVHpFR3dmSXNJ?=
 =?utf-8?B?VFhabHRtMG1KVXYyS3dFeUJkNlBOMVEvckZ5QUFMaEl1L2VoNzFlYlRQZXJR?=
 =?utf-8?B?TU1tVWUvNHQzM3J6alA2bElrZkpEOW51Rmx3UTNlaXlLQXg2d0IrL0k3TTBr?=
 =?utf-8?B?OWdPMDJHRFlRWFJMbVlwc251TzhKY0gzNjFSa2hzZjV4WVpKR0sveGdGTmpC?=
 =?utf-8?Q?k0rlfqwsXNCzyGjO+QhPIwygXLTggce9cI9pr9z1UT5XY?=
X-MS-Exchange-AntiSpam-MessageData-1: eUu1+ry8Lqi2eA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42b3e46-8ea4-410f-4c4b-08df04187909
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:06.7721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85bg9oFCrnFiEy0zdxlx9lML9FNkOHAbPqil1Rpifm4zjWK2vD1KGWxxDofA9PPznzlS6cQZH13njoP9m9LjLA==
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

This series adds support for the PRAMIN window, plus some documentation.
Some of these patches were originally written by Joel Fernandes [1]. I
have updated them with changelog notes in each patch. For example, I
updated them for the newer IO machinery from Gary Guo.

This series adds a Pramin structure which deals with updating the PRAMIN
window and handing out typed MMIO views. The PRAMIN window is a method
that lets arbitrary VRAM be written over BAR0 by configuring a 1 MiB
window through GPU registers. That 1 MiB window can point anywhere in
VRAM. This is useful for bootstrapping e.g. GPU side page tables.

The Pramin structure hands out typed MMIO views to do writes through
rather than letting callers write directly through it. A follow up
series will add support for GPU side page table entry writing through
this mechanism. This abstraction is important for later since we will
eventually want to write the PTEs via BAR2 not PRAMIN - using a view
that we grab from the Pramin structure can abstract this out.

This is based on next-20260817 (e6664f2b33db), with Gary's register IO
projection  v3 series [2] applied on top.

[1]: https://lore.kernel.org/all/20260518180342.2387845-1-joelagnelf@nvidia.com/
[2]: https://patch.msgid.link/20260819-typed_register-v3-0-3699a75fadf1@garyguo.net

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v3:
- Dropped first three Bounded patches which are merged now
- Rebase on v3 of IO reg projections
- Carry Gary's Io::cast patch which was dropped in the v3 since we use
  it.
- Link to v2: https://patch.msgid.link/20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com

Changes in v2:
- Rebase onto Gary's IO register projection series
- Drop Region::try_subregion patch in favour of Gary's reg projection
- Convert Pramin code to use Gary's reg projection
- Fix const {assert!} -> const_assert! (Gary)
- Add #[inline] to shr_exact (Sashiko, Alex)
- Link to v1: https://patch.msgid.link/20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com

---
Eliot Courtney (3):
      gpu: nova-core: mm: Implement Alignable and Debug for VramAddress
      gpu: nova-core: mm: Add the memory management HAL
      gpu: nova-core: Add self-test assertion macros and config option

Gary Guo (1):
      rust: io: add static `cast()` method for views

Joel Fernandes (6):
      gpu: nova-core: mm: Add VramAddress type
      gpu: nova-core: mm: Add PRAMIN window registers
      gpu: nova-core: mm: Add support to use PRAMIN windows to write to VRAM
      docs: gpu: nova-core: Document the PRAMIN aperture mechanism
      gpu: nova-core: mm: Add GpuMm centralized memory manager
      gpu: nova-core: mm: Add PRAMIN aperture self-tests

 Documentation/gpu/nova/core/pramin.rst   | 128 +++++++++++++
 Documentation/gpu/nova/index.rst         |   1 +
 drivers/gpu/nova-core/Kconfig            |   9 +
 drivers/gpu/nova-core/driver.rs          |   3 +
 drivers/gpu/nova-core/gpu.rs             |  30 ++-
 drivers/gpu/nova-core/gsp/commands.rs    |   4 +
 drivers/gpu/nova-core/gsp/fw/commands.rs |   5 +
 drivers/gpu/nova-core/mm.rs              | 163 ++++++++++++++++
 drivers/gpu/nova-core/mm/hal.rs          |  56 ++++++
 drivers/gpu/nova-core/mm/hal/gb100.rs    |  35 ++++
 drivers/gpu/nova-core/mm/hal/gh100.rs    |  35 ++++
 drivers/gpu/nova-core/mm/hal/tu102.rs    |  37 ++++
 drivers/gpu/nova-core/mm/pramin.rs       | 312 +++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/regs.rs         |  70 +++++++
 drivers/gpu/nova-core/nova_core.rs       |   3 +
 drivers/gpu/nova-core/selftest.rs        |  64 +++++++
 rust/kernel/io.rs                        |  39 ++++
 17 files changed, 993 insertions(+), 1 deletion(-)
---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260804-pramin-split-950e210b6e3f
prerequisite-change-id: 20260721-typed_register-176eab3abee7:v3
prerequisite-patch-id: 9d08451e181409e33cda3549dd2f6a18ad742a38
prerequisite-patch-id: 35e98efa10cce8cdd6c9df954c34d778a8b57e97
prerequisite-patch-id: 9dc002f047fb0c688c0ccce751535161fde8c216
prerequisite-patch-id: 551843cf854964cd9ef49378aa99000c8af73710
prerequisite-patch-id: 798405871b568af61cb6b9f0bf035c03b50eafe7
prerequisite-patch-id: fd9f266b3d8c80cc7ef4a3d59e302c25af9bb145
prerequisite-patch-id: 131291b0a4dc1ee7e43dd038f6f99fc5dc0eb99b
prerequisite-patch-id: 7c66eb2438e79edc6566b9e977ee33137d3e7fa1
prerequisite-patch-id: 8224018b7cfec0b00cce46b238abd9f68240e187
prerequisite-patch-id: cc910d5993c190268077d2dd56d787abd984465d
prerequisite-patch-id: 9590fa1a5c856c952eec73b630949a50e90ab4e8
prerequisite-patch-id: 511ce76481fe20bb1c498f020a5151bb008525f1
prerequisite-patch-id: 127be60ba6331574f6784cc8a5013d4f91b47df4
prerequisite-patch-id: d2faa8292625cbdc43f262f3773a1c5cc1f90935
prerequisite-patch-id: c447b4c47960e45497bd75bea84e6f1aea30eb74
prerequisite-patch-id: 5051a948fa965dd94348da1ec2f93bee8ff86106

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

