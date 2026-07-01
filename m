Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1EBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2DB10E301;
	Wed,  1 Jul 2026 06:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="T/xuzEI7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D730910E301
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCHjgjel7RGbrDksobA6zLFl1BpZFgymEn5H43619KOTr2pGSta3GLzDGKVEWo7+3+3W52m0NyLfiu8eH7pqm+Qr33rLt0SphCiXrBX0xcOin13yStLQZMzQHdDd2/KYsKq/qWVVkeVakhcDocpfT2RcnO6kT/K0WB/UInUHgJKeM9fEfLJA31TWsyLXmbFFmHN8//ahcu/i9UVcGWclkkRkJ1DebqPaPH/WwvJUUGhHStmzql/B+x/zik6mheHwGC85sxZPD9/Xk/uhOlZGcWtIiKvslHXEQP1kSlvndFov25tH2/xC9pbDSKEVNol7OrEKJDLU9JTypSIcIfDluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+4bSm0yW2ucxesDEqZRzEOCXUDo1NzkZG6WYFXPqOw=;
 b=L/EppB9iQMFNY/cLaj4LH1z7zfy/KoVQpdgD9QxDMsL5u1cCbLtORYHXwwL8nMPupqj8N9Sp1vI0TZS31i//1gkuRcHKN7xaWnUtfHGrTQQ8RB7XS3BuNFpLDZ6JANUxfHQzccZrZq3ScdUO/o2vGI83xPoVLRsXg2uBaFepu74cbdlfehythzC1z2a1JBPayuAgXwJA6IuCuZvnxXm796rdW62jpKQr7Ov8ZN77ld90yuYYlmU0Wau5xObgi3jsjl0u7ispWrd2H0sJV68KNGTOw+UtoRwWlmIVwO1mFkRpqpMVkh720OFy1ZqH297xrIMAY/DR4OayfPIuzL4beA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+4bSm0yW2ucxesDEqZRzEOCXUDo1NzkZG6WYFXPqOw=;
 b=T/xuzEI7QHEoo0uAniiGzvUjamTAve05Qo6w8kTZcL4Dzk7L1aB1UdM2mi27Aeti9I2pq+VxabhdboyJjyyoJT/FA2k89r/xabKN0paMBODTdlNioflYcMtW3DEFf9WCnvi4DS9XQU9AVH1VvX/wpmepK+pubXpJJy8ZLMISx6aaMzaVt341+SbJAqb6nZXGlNKXnR35r3vyL46AK/Nz+nxBSbywDVTFK33NbwjM5vwzKv6gOjIAjf422TJuGoEk79BkGevhIOdMswT9D4C9UQNT3WheupN1SQ4EzU5Uv/IWTjlTLJ/ln4Jcn7DY64cXTPozV9xRIXUQ/K4mIPnTpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 06:40:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 06:40:59 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 01 Jul 2026 15:40:51 +0900
Subject: [PATCH] gpu: nova: fix rust-analyzer generation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-nova-rust-analyzer-v1-1-5209f486f10d@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrm0yA4rGqxgXdaZAjRlMC0Ql3
 J1Blm/x/wzGKmxwLWZQnsSkTxn+UEDoKLWMErOhdGXtzs5j6idCHW1ASvT6/ljxEqM/1jGcKqo
 gh2/lRj7/6e2+28bHk8OwnWBZVneuxM12AAAA
X-Change-ID: 20260701-nova-rust-analyzer-8dd146dc53a3
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS3PR01CA0016.jpnprd01.prod.outlook.com
 (2603:1096:604:dc::21) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 2394fda3-a532-44e2-3168-08ded73bb64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|921020|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Q71GqQbPFuVliuGQcOvs/ddSnv9DZUDzMEeLZssILU6YBEjqLtX5oGheJgZn4JNHBcY2AD+HAyGGQs9Q1aLVJXH9pnnADhJ/s/mji2tv4nJLssUzwwnLLgIfP/EYhCoqEVBL8bAtp0SHECvSMlyP6QradpyBr2O5D5ePLLjNVSNMdPWVGrrhY+7S66KA1xGM/7sCUgaSdauIvXt1z+L/zl5sTdz3q580DLrBpeQTI9pKZUmNLJRRmMDk/QJvYMst0wGm54HZQct/zK8xzYZmje7ekHPlyD2XRVcinADpEu5ENUXRbJ1qkhm1+hrZgHfBtqkdYuWQrvnReyQtKRehkZIavuiOg4VoWCtUfbw0NCUD+nj5WlCA87WGzFyyb98QCGCjcc0fusTKMF+4NgNkpovlpLz4YiKFK393Es6nVUlamCzPok34t8WRCbXKhYTaDjFOXEK5Aqr88v1oVFMra5AwbAm2dV8wRzGD2HtMfZM6jSf2KLlyJyaq5+stOEKoe0BpK2bdVWg2jSJS5VNvfw9AM777EkC3g7SMlNfTgFp7XTHD/gM7OiUggJ50XL/D7KjdoyxWm2B3mLJbE0DoxCkwKb/owqOnN45n1C9qxTedERtidJTUMD1vH1FP18pdWbx1fmYhULJrprpSLU4YVN98S+HaVLtvVrHVj5PRNvjiV/5bw4cYZvQ5yy+X6GTFz9Ys0Uz4wRHg2ELEUq4oSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(921020)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9yMFBrU3cxY1ZoRVRmSWdZMGpjU1p4elRCUmNVM1lDOGJKNTBXUVlTNXMz?=
 =?utf-8?B?N2Q2UHRmRDJwSWR5WHB2NjZOVlk2bllMWjlSa2MxVjBOTFprNnVPVTNYUDBx?=
 =?utf-8?B?MWdqWlZURDFQSlNoZ3NrVWxLdENLRW5lQVZHWjIyeWs5cDg4Y01icWdUeVRh?=
 =?utf-8?B?YjBIdXRHNGgxSVhBOVl2ZDNRdHpqemMyR1ViMFhvMHFyeVowcTZDV1ltYkJW?=
 =?utf-8?B?dFhSSHRramY3ZHdISWphaUxtalRIUS9QcjFqa25Qd29VWVdNTnRwbk5NUjJH?=
 =?utf-8?B?MzNTejVHanpucUhZalpsL3JZRWZlTm5ZOTc4MHI4QjBkemd0OFR2SWtGMzcw?=
 =?utf-8?B?TURpczBOL1VIM1A4RDd0YUV1azlTQy9zNElHaHk1cFhTanJxQ1VxcE1XN21I?=
 =?utf-8?B?djlqR3IzZkpHOWY4NnNuQUNXY2g5UE1zU2FtU2JxN2hEeTBrWmQrTFByalBi?=
 =?utf-8?B?VE05YTBKZFV5Y3JSYUdzaEViU0FieDZKNTVUU2s2eG1lalNuOWRTN2tUMlVm?=
 =?utf-8?B?and2cEg1Ujhmb3dHblBOUC9VcGMwQXVTWWpSVy9pekV2SDB1RzJkU3RBanRK?=
 =?utf-8?B?RnJKeDFiNDZNZXptc1BJS04wWGszQ0wwV290cjBDckJqWGJWUWJXTDFROTcz?=
 =?utf-8?B?bDh0NWF2Wk1CSFdudzVXRHo4QXhsekdrS2FTU0NDejBtOUxkK0FZOVNHR0VM?=
 =?utf-8?B?dXlFYmhNTEVMVnhQT0dHZXB1VkNZbHlkbExUUDNlMU1KZWh2cG1uRDVFenMx?=
 =?utf-8?B?L2JvaHhKSm5PODRxZUlkQU52aEdzT21EQjNZUXI4NmhsT1FCZ3dKZk9DcmQ4?=
 =?utf-8?B?ODMxT2Z1ZnljY21RNU0wcVJxVnFPbzBFSkpkUm45eTdWblBQTDB4K09LcW5j?=
 =?utf-8?B?dTQ4dWhYZE5ZYjMrbjRFM1dUaUFtU1BTOXNHK1RxdVJPRkQ0VExjWk9WbFVm?=
 =?utf-8?B?aklvRXd1RnpVQVQyUW5XNFFBWkN1VzErMTl4aDhpNnVHQWtBckx5QUhsK2lr?=
 =?utf-8?B?SFlEMEZWVFFvN2Y4RENnRGtKc3crMDhCek5iRWdkK3FSM0Q1eXB2MVNhanpI?=
 =?utf-8?B?Y2hhdU9MTG1QcldSZGhKMmozclhQczhjU1dnUG12T280S2VWTFZVTldXbzNK?=
 =?utf-8?B?cFdkbGFNbXpzbE1OaFppdGxKMXZMVktKUlJPbUVKem1GQkpQSllLZThXSUNK?=
 =?utf-8?B?eHVqdXJPcFBveEl0VFBBTDFUdGJmL3hNSWJJSnVFRlZFWm9lMnRVTlN3YVZD?=
 =?utf-8?B?ZGZQS05uUVVhcFBhSEd3aXpBVWRWRCtjUWpaZVNUSHdXR2NIaldyNkVleUJi?=
 =?utf-8?B?dzZTdzlwMEU1MXVnakRZMFk5bHNRakxtd3Boekl4bDJUc2NtVTRDdFNwY1BY?=
 =?utf-8?B?bnZpWFpSd0FvZ3hOSDZYcUIyMFpGd3NoTmhnbHd3NCthWVhhUWFSUXdSR3la?=
 =?utf-8?B?a0NoOWZKZXNXTXV4bC9vYkdsOVVNeDRvU1JDYy9USDFDb1hKVE1MbjdhVjhY?=
 =?utf-8?B?V3RvSlFFbWs5cGxXZjZuSFpVeWJSN2FEV0psQzVWYW1rMU8wbmZmTDJjbUpQ?=
 =?utf-8?B?R3JEbXc0cGxUSERqaGo5NGN1eW5icTBBQnlodkQvNnlJNFdVZWpISDJDVUg1?=
 =?utf-8?B?MnkvajI1MmFCR2tqcHIvRWpycjZzSUJaL1FsQlNJU3Q4eVNxZVFxNU50RFhD?=
 =?utf-8?B?emp4SXRQK0FWdHZSdUNHZDlLS2xSaFh0RlpPS1ZQQVV2NTFQK1hjSStQN3c5?=
 =?utf-8?B?cXVydzNCclRXcklvVG1MNk9LTzlHL0h1Z2c3dnVjR0UzTHMvTE5tNTA2Vmph?=
 =?utf-8?B?SkI1eVFHR25iaEM2U214ai9rc2h6K05pK0Z5VFVMemlOUGs0Mjd1UElyamZ3?=
 =?utf-8?B?bUxobmJNT256YUUwb3A1ZnVkYlBSeWlISFk5QVNFbmxWS1JHQ1BQY0t5c1Fl?=
 =?utf-8?B?TzBuZ3gzNDJtSGdma2V0a1NkbzNMZTRXemtaaTd0RjNScVIvbmdPamlLQWpR?=
 =?utf-8?B?c1dKWFJrNXlFM2c5SGkrdmVsNjVxbGM1K2NSNk9wS0QzQ2ZKUFZpK0RmM1NN?=
 =?utf-8?B?aTc3VFUwWnRGc0M4NmJpTkRhT0hqSkF2TmswYS9VWTBSZXNTbXV3K0ZKZDZP?=
 =?utf-8?B?S04xZFN6eGNIdGY5VXpLL0VxK25YdnlJU3dNMlhkQjJEenJQQk5YTTZFWG1R?=
 =?utf-8?B?bEUvY1Q2YjFLU2xneU5zNlpia21selVJZkdwcjZLYzRqaitoVWJ5QlhTWDNw?=
 =?utf-8?B?WGEwKzN1RnBpc3JSWm1WMU9RR3JIcFpiaEwrdk5jWDFrVEdXTDVWZlFhTGp6?=
 =?utf-8?B?Vm1kczNiQlN4Y2VnVVZBRUwvQ1l2WU0yQlhaVmNTM1ZsN3VDSWtKSWUxOEVO?=
 =?utf-8?Q?P9FY1+Bnt0CcX1Xhz+TUdtFSYNQerf1kXANorGv+NWi4D?=
X-MS-Exchange-AntiSpam-MessageData-1: 9efPCixIR0vYiA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2394fda3-a532-44e2-3168-08ded73bb64a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:40:59.7706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGHbP/qx/GQltDDvyhYc2wTZ94xgLnOEhDFMaKynmJC018bTfFyK0c57mJNoOReq5jJ2xY4g+v04gVZM3GNHew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933
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

The rust-analyzer generator script recognizes a crate when its
corresponding `.o` appears in the Rust source file's immediate `Makefile`
or `Kbuild` file.

Commit ca524e273c43 ("gpu: build nova-core and nova-drm from
drivers/gpu/Makefile") moves the build rules for `nova-core` and
`nova-drm` into `drivers/gpu/Makefile`, which results in the generator
script ignoring these crates.

Fix this by naming the crates' module as a comment in their respective
`Makefile`; this is enough for the script to pick them up and restore
`rust-analyzer` functionality on them.

Fixes: ca524e273c43 ("gpu: build nova-core and nova-drm from drivers/gpu/Makefile")
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/drm/nova/Makefile  | 1 +
 drivers/gpu/nova-core/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nova/Makefile b/drivers/gpu/drm/nova/Makefile
index b9fad3956358..6355f7502c48 100644
--- a/drivers/gpu/drm/nova/Makefile
+++ b/drivers/gpu/drm/nova/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 # nova-drm is built from drivers/gpu/Makefile.
+# nova.o (rust-analyzer marker - DO NOT REMOVE).
diff --git a/drivers/gpu/nova-core/Makefile b/drivers/gpu/nova-core/Makefile
index 4c15729704a1..216329760a5b 100644
--- a/drivers/gpu/nova-core/Makefile
+++ b/drivers/gpu/nova-core/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 # nova-core is built from drivers/gpu/Makefile.
+# nova_core.o (rust-analyzer marker - DO NOT REMOVE).

---
base-commit: 431f10ba13a964c146ae05728e42e4074bf735ab
change-id: 20260701-nova-rust-analyzer-8dd146dc53a3

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

