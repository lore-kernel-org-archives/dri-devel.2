Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC79606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rTYOrhxO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C03BB10F95F;
	Wed, 28 Oct 2026 02:22:24 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6628F10F952
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIayGnjQY7IIZxzS9sp9CsgXcqb9Ubtm4wXcHHUzyTucGl5zPnGl1iFF9xqkTSh1lUviv/AZ2vjaUU2lSUb+Dhu/63sR93uFMG0j1rCcOMooC/V9Pg0DiWr/Tbaik/Y8tmTCzO7DLK5VSchN5Ncpfm9SPdCyYbJMG5QRiBM1xCOH3vhonlaUr7PsTWgkr7la/S4tQahS5dRsC8JGiK9t9l8S0KELYL3SxKJyFmc7gq/MhbmIW1PPm2JfWNcixMycgHLlHZYmKwCef1PcoMlFK9yFn7XkgqBNBO5UqKMvjTaKbL3hJRTUbur3EjvLlwP50eyQIydbF92OoPN8huiDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QbxAjhG2KdEaYIIFxdcLSvZ9QNujO8196zF1hdYGrI=;
 b=FLf7j1v0sG/r0qm6niaoLTxRINR5CjAHM/F4WsafVcvgbe7VFDeuK9pg4yciN79YI60aUwlwy5dCnV+Myx2el4BgcRrahmzV5X4WZONnS9vTty5YiVgppfclGd1VlrFOATN3o6TogW8cfpqRrao7xje912e9Sz80i9ucGgMT72eJSfrgqSefc7u6RfxH/q1Dj2+WtUw5fMaIU9e1Gk3/vbm3W4ehaxCVDk4cmOouI+DdyyZpG+XEY4t2IWWKohfBU41E3k9ROAW5nVdN5e5wexK9FFvHyocJKHNKSEMyIcNPgJ7Yj9q7GUad0243c9Lils8LUo+QmE6QqOoRgLPu0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QbxAjhG2KdEaYIIFxdcLSvZ9QNujO8196zF1hdYGrI=;
 b=rTYOrhxO4JYWg39xUDCJWmo/+++APPnF902lYI8e6ZkPy/q1hiZa1gflScr4miBHvJLZXj0puvD1/fJ+qzYSmlBxBtbGNLNe4wDMs2HGu3/ZfgMD7quvX3TBRkpiti7XxkM5AGSqWxYSRFeOZDoZFDCN13qtsWrHj3pKoK5ovDoqCSVD5PjQcebvk1lATMcKDIcMBTuJoxHzZGejOJxJjZTB0ojwQBLjQQcQSt7/zxCqtwmQBjmsebzaW2oAlt6/jaYAeLQ01ma9wskRR6ZrmSRuudzi4tpRuiISKCb8Lp2CaxhXJ+pn9CaC11b5JAxijojCLhNhmxZv9GQuJfI1Sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.16; Wed, 28 Oct 2026 02:21:55 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0546.016; Wed, 28 Oct 2026
 02:21:54 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 28 Oct 2026 11:21:06 +0900
Subject: [PATCH v5 7/7] gpu: nova-core: add NVKV GSP_INIT schemas
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-b4-nvkv-v5-7-ef78909b513e@nvidia.com>
References: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
In-Reply-To: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
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
X-ClientProxiedBy: TYWP286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2226d7-de0f-441a-5c0d-08df349a3c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|7416014|10070799003|261022105027099003|13003099007|921020|261026140227099003|11063799006|56012099006|261026121527099003|261009223027099003|10067099003|261021121427099003|261021123027099003|3023799007|18002099003|22082099003|261022075727099003|6133799003;
X-Microsoft-Antispam-Message-Info: c16lJ7hluMM/9t83nx0TuU1LTMKvGOMMXekpdC5CqZRVhZNHcGI0DYr0ZCePXwz8mTaGvA0nJMba9/QTDzwTK7wuOnHIETzbOCrJz7lJM22zsBmorZMZ+DSWxYxLbBA1gEEyk4M6MWfWywEXY+gIvF5c0PX4NfifyBuU0kXFERTP2DAnqRJd44gjSJ4MkkY18XJcSaTOJVnB0+EXurohudM2440XwOxLbwDxeYaq5OIAahUFHFOqWfpVXEeq8bkkrtnAnZ1OKOAFtaRB+U4WBsfcqLSRKfJEg4vw5mtI1BWl44dIkjXdNPpj/C1x2cYuauv9k7yqoivIYfJhxZN4s1ElMJuo301sWLAtP3F/40OGVe/HTtVTQH5qNYRZM0aatYlI4JcXep9kmA6Q3D1/QYMb8Frs9SaCDTvnsSlqRmC5dO5r3smpS06Wh/WgcVQBAvDd8mVRxRWrrglHr+ngGkiWpJaKYrG0cr68rBm/D8Y+w2Ae7/qSc4GY2xWeItQ/qbYhRmNkWYF6QHeuwjQ1IpPRqbbPVdwlroasTOR1uWePeqkXyRwJMsdbTiQ0QkR3PfELIsu7ek70KVCyKH2pr0LyQdXIgRdO7S6neZRS3f/oJgUkfLEWdZlL5fJKYW9DHCm+5wRdSDFV8stJUuazol5D3yyaSPKUX5E+Orz/FsDePmqq/jgYrTijyq44Uq2LW0QQr9GzYq82ENishjFRhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(7416014)(10070799003)(261022105027099003)(13003099007)(921020)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261009223027099003)(10067099003)(261021121427099003)(261021123027099003)(3023799007)(18002099003)(22082099003)(261022075727099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnY2dndzUkt4aVBFMFBSZEdDWmlsUGx6dGFoVisyQXV1ZTF0dVhvcHo5QlAz?=
 =?utf-8?B?WTdlOElCdmpKazZ1NllqWGZWT0Z2eEp6R0YwR0RRL1ZVM1JRRVY4VS9KRS9Y?=
 =?utf-8?B?a2gxQnBTTUVnWGlucFpBMTljUnlpWkpyQVBveXRhcGJBSEhHSUlHT3FDUGVL?=
 =?utf-8?B?M1pzNEhQSVltZlQzSmFxV3kyZGVqNWNLQ2t6VzA0ZGY5S2RFUkZWS1R5QmFz?=
 =?utf-8?B?R1lPRmZaRWNWckN6dGViUkFaUFQ0cnNQOERMdlBjb3ZYZFA0bVV2NDhqZTFw?=
 =?utf-8?B?eTNuS1VZZVVva1d0N0Q5Rlh1UkVJL1RkOHZJTkxXcmJmQlE2ZXJxb1BZZ3pD?=
 =?utf-8?B?UkRXZlBFOVkyOW1kTDRpamttRStOLzFGWlhzU1JKdW9CU3Bma1hmQTB4SGRq?=
 =?utf-8?B?cHpzSTNkMEtza3diL2Raa3ppK0l1RHQ5R1BJdVhNbk1RTlNhenhUUHRKYUZw?=
 =?utf-8?B?d1lEUWoyckd5aGdIMWlEbVlBOEhUWlVVT1pxaDBhT29sNXRNWUl5eWtoVjNr?=
 =?utf-8?B?NDdVTDI1cmYyalByUVNueDVsUVRqeTBaYlFzN0QvS051cVZLcVM4NENNbkxG?=
 =?utf-8?B?SU9pOVJtdmYzbWJOYmppZHdWRnI4eXlSam5WYmlhTVR5Ymp5dVlVVnRlU1RF?=
 =?utf-8?B?dFNxMzlhR0ZIWkVDRzVmT216aW1GMm80amRzMVJORzA3eVUrNEtUeFdwbWE3?=
 =?utf-8?B?bzBCcmFhck9wOSt6RkVtdVZKd2N2d094OENaaFFydGNXQUp4UlR1ZzZlbGhR?=
 =?utf-8?B?blY1Y25hTitDdm1zT3BFeWVFUEJTV1BYdGVWT2dUcVJ1WUpqTDF2OUpkWXVj?=
 =?utf-8?B?ZW9mcDFCVDhOYmNpTTlhakZiK0FVYWFxbmE3anRocGhDUWREMllSTGlrZVA3?=
 =?utf-8?B?Y2pXc254RTF3VGYzUVlvWDZ3d3FUMGo5N3pQbnZ4UTdvZG9ESTJ4L0lWL29X?=
 =?utf-8?B?b2VqbTNFeUwvVEZCYis3L1g4Z1BhdytkQjZhQUFaZEhQZXVoWDNCZXJNc0NO?=
 =?utf-8?B?MEY1Qm9CNFpCME54ZUhWNkxiSHp2anVlb2o1bmVVZVhmNks4bWVTVXgzVlM1?=
 =?utf-8?B?dW02MDc4alljTGc5T2xJV3MwenNncjJjSDRraFU2TE1HaEV1YzMxZ0JkeENm?=
 =?utf-8?B?dmZhWXJ6a0pvZ3Z4S3FiU3NlUndtMGM1TEtmM1VMa0xuZWJ6S2xlMVRaOHl3?=
 =?utf-8?B?WkJaQ0xocGs4Z0NZaHZBOU1wMHhTR0xIa1FjcngvdDdwcFU2bnFQTmJXK3pW?=
 =?utf-8?B?NXpsRmRQbXpnL1NoMUw1SkJteEdxRnZvRWZSZDVpR3BZS05QK3hhN3Y0N2VX?=
 =?utf-8?B?U1dZend4V3I3R04rRjlFMnJkYWR0bklzdldSUk80UTRudkhlR2VNeFZMT3Iv?=
 =?utf-8?B?aUY5Zlh0N3pPcFVNK2pMN0NGMkhFLzVyV1pweEhwUHRteUtvK0xlcVVZMGxp?=
 =?utf-8?B?VGRORnVkUkVjQXhpUGhuV3J4UTBuVVNRREFBTnZVMnVsZVZoK2dGS1pZRGd3?=
 =?utf-8?B?M2EvTmNaRXl4QzN2MFgxaHo1TENwS3VjOHl0M3hPcUNQZU9YNUgxcTBXTVlW?=
 =?utf-8?B?VmhBTll1YTBXemRjM2NLakhDeWNNbnRXWFpnOHN6aUVzTEkxeHFrSDV5eDRv?=
 =?utf-8?B?WHhsYnVMdm1LKzAwWlhyeXB1UWVrNVZyRmdFWEgyM0JUMU9xZVJldWlOTzQ1?=
 =?utf-8?B?NkNjaWxhRm9pdEVPd1U3UmdvN1BOaVJ0d1prSEx1YWxWYUc1YXZIeU1JeW1Z?=
 =?utf-8?B?TnRTYVF6MkZ5VW0vMzAyM1o4aHBmM3Nza0svOXRMYXBDZWF5RTUveUlxMURm?=
 =?utf-8?B?UG4zMEQ2Zk5CamhORlF1eEdEdUNUUHlvS3B2SG5XeE55YTN6bkxtU010Y1Vp?=
 =?utf-8?B?QWdyK2tUNFAzNnFweWloSWFQT0NsZEU0bE4rbXplbTdLVVd6RFR6QWdTcFlJ?=
 =?utf-8?B?ejZDUWl0dDl6YjhBalF5M0NMY1kyZlBCd3BHQzhidlFTR0oydXJVc1RWcHZj?=
 =?utf-8?B?MEJKRXVrVjBqTDFrZm5YQkhHTllMOHN1endOdm9hSVc2NDAzSVR2OVllY0Qv?=
 =?utf-8?B?aWl3ZzFQNWVNMWdTZys1bVJiaFlpNnk4YmMzNGZ2MXNSYTUzTGRNUUwyWjFR?=
 =?utf-8?B?NEJXWGEwdU1STWtZMGs2SVdHcHNGTnRqN0RlQy9Bd2FTeUJnTzB0WFMzazRU?=
 =?utf-8?B?THRWdlJRZGQzTGt6Vldwck41OWtvV3B3cjE0cmhrZTBpM1Vxem9BYVZRV1VE?=
 =?utf-8?B?Q0VBSU9PUlV2UDNtaUIzN3BUMHZUNUYrMlM1RlpRd0pxM3pwZnZNSmxJaEda?=
 =?utf-8?B?d0FUa0F3UWoxKy9Od2JNUytPZldUa0FKdndocjVsOWJLTzZFS1hXUXA2M3pJ?=
 =?utf-8?Q?AAg6mXvhM0kyteTf2p2XaBxD1Id0MAIqz1l/VFYrI2+K1?=
X-MS-Exchange-AntiSpam-MessageData-1: eb3539jFW8rATA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2226d7-de0f-441a-5c0d-08df349a3c0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:21:54.8232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvL7GB8voOIo18nw28Tl4+ur4yhFrD7TWKHnbehr6HXIIIzbMqGNzr1adFU3NhgYeg1YgGwANJuh9oZmh5APkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the first user of NVKV encode/decode which is the request and
response for GSP init. Later patches will support GMCAPI in `Cmdq` and
use these messages.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/commands.rs | 157 ++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/nvkv.rs        |   2 -
 drivers/gpu/nova-core/gsp/nvkv/decode.rs |   1 -
 drivers/gpu/nova-core/gsp/nvkv/encode.rs |   2 +-
 4 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 567c56fbbfe3..88111aec3ddb 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -4,6 +4,8 @@
 use core::ops::Range;
 
 use kernel::{
+    alloc::ArrayVec,
+    bitfield,
     device,
     pci,
     prelude::*,
@@ -15,7 +17,19 @@
 
 use crate::{
     gpu::Chipset,
-    gsp::GSP_PAGE_SIZE,
+    gsp::{
+        nvkv::{
+            nvkv_decode,
+            nvkv_encode,
+            Accumulated,
+            Encodable,
+            Encoder,
+            Key,
+            Required,
+            TruncatingArray, //
+        },
+        GSP_PAGE_SIZE, //
+    },
     num::IntoSafeCast, //
 };
 
@@ -245,3 +259,144 @@ unsafe impl AsBytes for UnloadingGuestDriver {}
 // SAFETY: This struct only contains integer types for which all bit patterns
 // are valid.
 unsafe impl FromBytes for UnloadingGuestDriver {}
+
+/// The host CPU architecture.
+#[derive(Clone, Copy)]
+enum HostArch {
+    None = 0,
+    X86_64 = 1,
+    Ppc64le = 2,
+    Arm = 3,
+    Aarch64 = 4,
+    Riscv64 = 5,
+}
+
+// TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros once
+// they land.
+impl TryFrom<u32> for HostArch {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            0 => Ok(Self::None),
+            1 => Ok(Self::X86_64),
+            2 => Ok(Self::Ppc64le),
+            3 => Ok(Self::Arm),
+            4 => Ok(Self::Aarch64),
+            5 => Ok(Self::Riscv64),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<HostArch> for u32 {
+    fn from(value: HostArch) -> Self {
+        value as u32
+    }
+}
+
+nvkv_encode! {
+    /// A GSP registry entry.
+    struct RegKey {
+        key_name: Key<&'static [u8], 0x3070>,
+        key_value: Key<u32, 0x3071>,
+    }
+}
+
+impl Encodable for KVVec<RegKey> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        for regkey in self {
+            regkey.encode(encoder)?;
+        }
+        Ok(())
+    }
+}
+
+nvkv_encode! {
+    /// SR-IOV virtual function information.
+    struct VfInfo {
+        total_vfs: Key<u32, 0x0080>,
+        first_vf_offset: Key<u32, 0x0081>,
+        flags: Key<u64, 0x1003>,
+        first_bar0_address: Key<u64, 0x1050>,
+        first_bar1_address: Key<u64, 0x1051>,
+        first_bar2_address: Key<u64, 0x1052>,
+    }
+}
+
+nvkv_encode! {
+    /// Payload of the `GSP_INIT` command.
+    // TODO: expect() doesn't work here before rustc 1.97.0
+    // https://github.com/rust-lang/rust/pull/154377
+    #[allow(dead_code)]
+    struct GspInitRequest {
+        pci_device_id: Key<u32, 0x0001>,
+        pci_sub_device_id: Key<u32, 0x0002>,
+        pci_revision_id: Key<u32, 0x0003>,
+        pci_config_mirror_base: Key<u32, 0x0010>,
+        pci_config_mirror_size: Key<u32, 0x0011>,
+        host_arch: Key<HostArch, 0x0070, u32>,
+        bus_device_func: Key<u64, 0x1020>,
+        regkeys: KVVec<RegKey>,
+        vf_info: Option<VfInfo>,
+    }
+}
+
+// Decode:
+
+// Should decode with UnknownKeyPolicy::Ignore.
+nvkv_decode! {
+    /// Schema for the `GSP_INIT` response.
+    // TODO: expect() doesn't work here before rustc 1.97.0
+    // https://github.com/rust-lang/rust/pull/154377
+    #[allow(dead_code)]
+    struct GspInitResponseSchema => GspInitResponse {
+        gpu_name: TruncatingArray<u8, { GspInitResponse::MAX_GPU_NAME_LEN }, 0x2000>,
+        fb_regions: Accumulated<FbRegionSchema>,
+        bar1_pde_base: Required<Key<u64, 0x1020>>,
+        vmmu_segment_size: Key<u64, 0x1050>,
+    }
+}
+
+/// Payload of the `GSP_INIT` response.
+// TODO: expect() doesn't work here before rustc 1.97.0
+// https://github.com/rust-lang/rust/pull/154377
+#[allow(dead_code)]
+struct GspInitResponse {
+    gpu_name: ArrayVec<u8, { Self::MAX_GPU_NAME_LEN }>,
+    fb_regions: KVVec<FbRegion>,
+    bar1_pde_base: u64,
+    vmmu_segment_size: u64,
+}
+
+impl GspInitResponse {
+    const MAX_GPU_NAME_LEN: usize = 64;
+}
+
+nvkv_decode! {
+    /// Schema for one FB region of the `GSP_INIT` response.
+    struct FbRegionSchema => FbRegion {
+        base: Required<Key<u64, 0x1011>>,
+        limit: Required<Key<u64, 0x1012>>,
+        flags: Required<Key<FbRegionFlags, 0x0012, u32>>,
+        tag: Required<Key<u32, 0x0013>>,
+    }
+}
+
+bitfield! {
+    /// FB region attribute flags.
+    #[derive(Default)]
+    struct FbRegionFlags(u32) {
+        0:0 support_compressed => bool;
+        1:1 support_iso => bool;
+        2:2 protected => bool;
+    }
+}
+
+/// One FB memory region.
+struct FbRegion {
+    base: u64,
+    limit: u64,
+    flags: FbRegionFlags,
+    tag: u32,
+}
diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 143746daf782..f81a9e60d89c 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -9,8 +9,6 @@
 //! speaking, the function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0,
 //! b"some gpu") naturally maps to storing a &str with the GPU name.
 
-#![cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_imports))]
-
 use core::{
     marker::PhantomData,
     ops::{
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
index 534056b97708..84c0c998b2c9 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -57,7 +57,6 @@
 ///     }
 /// }
 /// ```
-#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_macros))]
 macro_rules! nvkv_decode {
     // A schema which doesn't borrow from the stream. The macro uses a generic lifetime for the
     // [`Visit`] implementation but not for the struct itself. This allows omitting the unused
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
index a9d0420d0936..c6891c0441ff 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -38,7 +38,6 @@ pub(crate) trait Encodable {
 ///     }
 /// }
 /// ```
-#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_macros))]
 macro_rules! nvkv_encode {
     (
         $(#[$attr:meta])*
@@ -65,6 +64,7 @@ fn encode(&self, encoder: &mut $crate::gsp::nvkv::Encoder) -> ::kernel::error::R
         }
     };
 }
+pub(crate) use nvkv_encode;
 
 impl<const KEY_ID: KeyId> Encodable for IndexedKey<u32, KEY_ID> {
     fn encode(&self, encoder: &mut Encoder) -> Result {

-- 
2.56.0

