Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A160FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513FF10F355;
	Thu, 30 Apr 2026 14:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Us498uu8";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FB810F355
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 14:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kW3YcqUEbrGYR0hRsY6iCSoef2OJSY0YF8wTb5+PBweo6hpddO8hvj7cZAH9MlTB/v56gT5iVIRm7L/iskimilwS/WRGz2hu29zffJX0wusyqBtzFAK6On2RICk3PoLgyPk15ueaNqtvKxMoJ7K2bVbPDEQ/GZmSOGcoEb+erye44SageIEYym1OTQ2JFMWjaDf+Tx1Xzz1uAaj5ZutdPThbDvaj7UNFiafYIZvv5PXZnVN1WM/0V7ail1TKNacKt+vRCazDzvDf1iivc+lRAOK5uGipSDXZJ1eJkdoSXmds0hBIB5MFhoLYYN+NVn0eRRVn/Ke6T1h3CrI7UEu1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAd15UwN4mTEG4527fWjauX54mzLTXh7nzgQbcYLTQU=;
 b=G+VyUnyXgIrczW/wJRc97WQAt5d6knvb9BvOpLFZ43ccEJIQVlIQQQhmlrj4GNiAXaVPZ/f9lVUR98C/y2EBJFnlkVKesMSIaGZXq3YT/SNI4iS0d17h2NENNjXRmQeUjplb2HlWuzs1v+Q3jQPUAQQL69SXfI89Do8r1XWbZmReN0dyY5Z7UPWnKEtHe+s+7ni6WcQLamCsUxSIWtz9yQwrbTxUk1UAv7far6XWrdmpgTT1lXQc9QUVTiSWdEn9whdEKUy+BadeT64Sxz5iXxCe2ECarBntTM9YNQHaH0uVPY7nISGNJIGBNNatdkFgOa8PZgunOgHebyDPEqIL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAd15UwN4mTEG4527fWjauX54mzLTXh7nzgQbcYLTQU=;
 b=Us498uu8JqrJxY9Iv0V8JU+5nXsKpfAYoETID2RdBNrE8CKRGKgJOOkAmkI2Q+MvkI6+kbYnxyf4BZWB2ILgkkaCZi5vERke1SpqNxPefcsmrTt5HABUyJY5fxVjOC73sNy2tVou34ZH9moZT6Ebpz6icd3mEXjo18oS551KDB8dt63xDxDTSqHWhTfVzs4I8Fc9eaP6dW0z5j3GMH1MrVWRcJwPWUB+CTlkNViLXNddjiMziJMrXNbimEs9V7z6af3sY/SPH7PR/0B4x1Ij5H7zWyzeqILRtAC75MK+mUWUECOHlml+aD4EfjIkWccick6MLvVebqy2gKoMWPINzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 14:55:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Thu, 30 Apr 2026
 14:55:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 30 Apr 2026 23:55:09 +0900
Subject: [PATCH 6/7] gpu: drm: nova: build after nova-core metadata
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-nova-exports-v1-6-7ca31664e983@nvidia.com>
References: <20260430-nova-exports-v1-0-7ca31664e983@nvidia.com>
In-Reply-To: <20260430-nova-exports-v1-0-7ca31664e983@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY1PR01CA0196.jpnprd01.prod.outlook.com (2603:1096:403::26)
 To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abf0ead-68e9-4a50-6932-08dea6c890eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: R4kAzT7qpctqqXFrKCczAC60jUrQKL/6KH5APDBkD4w10i7ovuDOnvdz3o5Ksm8JisgEwTay56IBioqDIPt0wjH0WImJ3oOS/FcPD8RtCog2EHaxaGCKvYWYB/4IaTt7Z+iv5K5Bo03aODJxIAig8dMk8yrSfqeytua3Qo/fZ73oiw66sUuOrH3qSglS0vStOTzZ/D5BHkx9O0WGFJO/4Q+oxt4d8Bt2YiGytSVai7jPYgCn69E/lgtvU6zRDfHO3gGJI91H5E/RiB04Ucnt1KzdGbnVFKeFv2DPfn1rCJT0z4iRwJLnqlBargmt2q1eoDClmwCDP+tHHFaJHmQwD5UEbWWkhZY4BxV4FZl8sHnCEVqFefo+1kSNDYNOFzR3js9ZfZe1kY+jucmj6vmG0PChFReObv00FaQxAx0KsCgyvuAvXUtxcRXrstwAyhotU3uOrmqkHS1+V2zbbe8CxOoimaRiOJJtQXvjoNhgBIFDvj1qsA+qLTCQoTail8zDfWFzxnJ/IW/RJ6Az71QKBS+shZey+ZUUt0AYpDRPj/g8Cmv4GwvTveQj91vivuale38c4yidLLzZx0tj60r6I+IdGZWKmitrPmRzJf9SDwgFwo2IwSS9e4IbhvhvLtnuaLp0oKrjRvZq41AJEP6MmfKzAhQoSBVHPnz9kHqssJGoxNyPyIlLQvX0tEqQ7e10+IXXhGhgg92Fu3fK2AF9cy6WMedgBX+jo0kDNhMxu5FhPClpaA7Z8BRJ4hBFvQUTFxyp1MDOWnuqdZNEaEzFtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkhOZlhPZUVKN2RoTkhsVzExemdFN3NkcGgyaEVkQXp6UWd3RUtuY1B6aFZp?=
 =?utf-8?B?Nm8veHY4VW85WkVzUzdJWGtRTGVjTGRCSTBqZnAvN3l5UUY0WDFxRFRhbHR6?=
 =?utf-8?B?TjZpQ2VWYytXWGJTS3pDbDZ5cEFzYTFMUmxhZkNETkpOaDhHb0wxTXp2QTdh?=
 =?utf-8?B?allBWkIvZUxVWDBVK2NiOWJGbk1RMkE0NmVPMDlZS1BVV3hZTllTbGZXd25l?=
 =?utf-8?B?cnRpaGlpcjN0WlZKdzhXQXZQL3I2THYwQXY4blNYaEhPblE1UHI0eW1QM1V5?=
 =?utf-8?B?WDJjZTlMalF5WE9DaUtIdVZnWGxXNlNYbUt2MW9GbXI3MnVoWlloMlR1ZXVY?=
 =?utf-8?B?SXd3Mk1sa1BRc1EySjJDa3ZEbThCNkhVK0dWRjZibmpxS0RWVCtUVE8yRmI5?=
 =?utf-8?B?dSswZTB1M0hEOVpyQ0I0dVJpQldlakQxODJRWDVlaXE3NHFIZWZiK05Hd25j?=
 =?utf-8?B?bGZsQU0zN2ZTOHpqNnNtY2pEYTltU1hoNFV1WTdObXIrR2U4a2VPcFl0R3Fy?=
 =?utf-8?B?OXEvdnNPZkhrOHh5VmZPRUViQUJZU28yYUxjWHgrQjFlTVdCTWpNYXQ2Ylll?=
 =?utf-8?B?UDhaS0poM0pQODR2bW1WdUZrZ3VXWEl6ZzJ1bWRwTUV0UEVDd3o2elRWOGpm?=
 =?utf-8?B?RHNUb1MwQmRlQmUrQjZZNkpvTzlhQ2w0UmJ5SUNxQVF3eEw1eEZYb1JZKy8v?=
 =?utf-8?B?bXVieDcwM1FyT3ExSC9ZRTF6U1FtaURzRnQ4TE44SytVTDFXbVhvckNnbnlu?=
 =?utf-8?B?YUczekdXcVd6THllMGR5cGlWSnZ6NUs5MFVBKzJkbWs4UkdJWjdXY25Sdkpv?=
 =?utf-8?B?TVFkY1Jmei9yeU1mR1gvSVlFUnpzeG5uWFgrc1hNVEpJRUQrRytPQ0dlZ051?=
 =?utf-8?B?VEZRa084QTF4LzA1aTZuS0NjemRkYTNzM3F1K2U4em01OXRrMEFWWUM2SVdm?=
 =?utf-8?B?cGxJamltcEtLcEJjVGJRT2NqWlh1bkVhanVsMk9EV2lzRlBtTEdYNUVQbWJ0?=
 =?utf-8?B?NHpiaTVmRmJuZktSbUtVc25sdjJ3TTlYbjNCbnBESHdGYU1WTEJRdlZ6QlJr?=
 =?utf-8?B?b0c0K210ekluME5ObnpFaEt5L0NzWGkrZWgweHZTdWc0WVNkczlnUVl3ejlT?=
 =?utf-8?B?d0VDYXNyV1F4SmFwWHQyZkVSQ1krTXptY0ZHdmZZZFZTQ2NRRlZrNHpDeFdF?=
 =?utf-8?B?SGRDVDFrL251dEZUbTVsUGlLbVlPMGVHaGRYaWpaMWpFU1k0L25NbkVQRWNh?=
 =?utf-8?B?bncxcVh6cWxjYW1LR09nS2ovQVlmT0gvSThOWFBuTnhYSjh0SlhmTEhYdXRG?=
 =?utf-8?B?dDhIUmtuRG9GVEdibXRGOHhpT0NNc3Q2eTJvUXBCNVFNTXhFQTRJNm02Z1dJ?=
 =?utf-8?B?UTI3M3ZTdWpvdk5GR1p6bnd2L3lUWE5qZDdjNW56TVdrTXczbmZuSXl6cEU5?=
 =?utf-8?B?SWVrMEhFME43T0Y4SGRjVll0R2NXU0l6eUs4RFFML2N3Q2RZREVHUXlEWENI?=
 =?utf-8?B?cHFBcms4b0MxYVRrYldsTkt0NjlvUEd0Z1huZzEvVWMxRE5xQ01JaVd0ZUha?=
 =?utf-8?B?OWFlOTFXSE5qcUROUkM2V1NwRTNNV3A3Skgyb3FiSFFtbHFRQ0NtVDFGUUtB?=
 =?utf-8?B?OTdLK2YrREtlRTIzVzlpT3UrUmFxb3ljbysxc0oxWGpBcG9jYlpKS250UFZq?=
 =?utf-8?B?b1gyc2g4a3VkL0RKV0gxZ0QwamZoNEVPMUJzTzQ2a1Q5bXFOckxwOURCQ2lD?=
 =?utf-8?B?SHQ0ZmVMKzdBRElra0t3NXhFbjlIL3N6MUdTK202RzlFRHRyd3Fqam1CVk5s?=
 =?utf-8?B?dEtFYzE3SXZtSHhoUnhQaDVXb0RhOWUvQ3NKTWNWZWJRM2Rwc21tbTU5OU9v?=
 =?utf-8?B?Nmw5cmo3eE82SXJaWkhZS3lIR3ZRWmpXcmlmR1llVmk4WGVrckg4Yk1PUFVM?=
 =?utf-8?B?c0gxRFd0aktyUUN4K3VqMGtzcnFYWFBIaXJqblYvak10WVZMa1orSG5oN0JI?=
 =?utf-8?B?ek50MWIzM1ppeTdnN2hLZXBhV2p3YVc1ZzlCendzY0dmdlRnbWdKWlhyeFZp?=
 =?utf-8?B?VWppTmJLYjB2U0pQdHZ5UW0yNmQrSUhiTGtISzE3WWpvUVQyS1Z4SG1DZHZP?=
 =?utf-8?B?OU1MRFM0ajRmZmdDUnlibXg0YU8wbTkxUUxjSWRZU0txVEpuSldveFN4czlq?=
 =?utf-8?B?cDBmOUhLZk9kSW02N0gwWjBKZVdCK1lBRjNZYVFZa2w2TzFnMld0clg4NEI4?=
 =?utf-8?B?QkNFcUxoZXYvVUtnNTRmODZHT1ozSUtCQWVEZWVwZVhtUjJyQlZKNUtIV3li?=
 =?utf-8?B?NCtMaU5Xa3AxWnRpOWpVS1dSaXFVV2lkb1phcjBGbCtleGdhTmYxbUhoMnkz?=
 =?utf-8?Q?cBTccGmr8ghiUux0MSG97DXRE+ZVYR3JyagjZ4xF5eDyR?=
X-MS-Exchange-AntiSpam-MessageData-1: 70g9Oc1+7rJtdQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abf0ead-68e9-4a50-6932-08dea6c890eb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 14:55:48.9603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/ewFha9RXJ7tlPajArX+KbxHC7spFldYLS+FpFpPiXKxHUuwoLulNp1X0QCGtc1qVrwjyZkBAUWPGnj4Qn7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
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

Point rustc to `nova-core`'s `.rmeta` file so `nova-drm` can use
`nova_core`'s types and functions at compile time.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/drm/nova/Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/nova/Makefile b/drivers/gpu/drm/nova/Makefile
index 42019bff3173..f1d59c65120f 100644
--- a/drivers/gpu/drm/nova/Makefile
+++ b/drivers/gpu/drm/nova/Makefile
@@ -1,3 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0
 
+nova_core_rmeta := drivers/gpu/nova-core/libnova_core.rmeta
+
+rustflags-y += --extern nova_core=$(objtree)/$(nova_core_rmeta)
+
+# `nova-drm` imports `nova-core` at compile time, so request `nova-core`'s
+# explicit metadata target before compiling nova.o.
+$(obj)/nova.o: | $(objtree)/$(nova_core_rmeta)
+
+# Build `nova-core`'s metadata by invoking make.
+#
+# This is ugly but only temporary until the build system natively supports
+# cross-crate dependencies.
+$(objtree)/$(nova_core_rmeta): FORCE
+	$(Q)$(MAKE) $(build)=drivers/gpu/nova-core $(nova_core_rmeta)
+
 obj-$(CONFIG_DRM_NOVA) += nova.o

-- 
2.54.0

