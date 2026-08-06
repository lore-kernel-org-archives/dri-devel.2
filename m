Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E11DC55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7184E10E29F;
	Thu,  6 Aug 2026 07:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nRNEGTIv";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECEAF10E29F
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 07:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNDsam2Wk1mkFUJfKqb1MP5ha6bSIhRbqGV2JmqJwrMvji+uDsfnHTujqgrzUHQfS6CPycH/HbsuFuHd+4VSvH8xnCpKZzDqJ5gMG/mnYOUeLMSqOfwzXNTc+9I8BJqHW+cNGCy6y7XWrMxgmNSDmji2pEBpf4RscgnhYATblWN+5PMmUEaSxCxArLujV67j6C3MPqfWWb98KFpQ4eG94gdN7O1oHNkslgmLVdyDia/a3psOyc7NJ5bPh2rLARsD90aXBwiaucCfvdl6r/snyf0Ggqxjihg5Wi1hiPpjqh2tNLxbB3/q2UTZZxwuxLU/P5cXk251PRG26iN00Epq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JUHTzv2uggcNwjZssefcw3SBSjsr6E3PakgIUWpqes=;
 b=t6OPphD+XaytW54u4CCSyQUsv2Bg4W3JCTuNAd25rdI2OlLPlzn6abgEKQ5ytPOvZXBuJe9E41J/7stlqaxIBLCWje6/Xuq10F0pzU8qgcVjCMqPxIOtIpfkp8dOFzHSkrdOYmYBsifQqk8kKRDEcgCygYelky9EEpoAG9LxNtoD0pJZbDSSa0a/n0f++whe+aKMIoklh3p2lOa7xiqSo6ayWRVQXYJd9RAsVtHAs1Ll0Rau4IarQ6OH40S90MMyjYXybLD4f7w/HUCTMXSqEZwa/W7IySkjhTCqrCw3ZTFM5S2F/TrI7LWW82VCWHFW/iDJbH7N7VEasCtgqLwv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JUHTzv2uggcNwjZssefcw3SBSjsr6E3PakgIUWpqes=;
 b=nRNEGTIvsLyXzKjMkh1eJkFeKyHNc+ZXfRdhoSUrOOAQwfEEPT92MiJkjAZE9QtPPKh0HxDHAIpZXO2l4tAXgYVEBhsRQZpGX+3LjAzPOOl72tk9JUNq8mO1qmhugXbqjtGycaSB99AAUQ5X+qq/Fj2BS3u1dfnldxWTZJaIR1AZJIdOMkEp18qt7OUTlJecL+AEA2h8rOJS+DG7gn1Et1Lg/uyRbZM/xNz6AJkmU899r6wnN31TCtrZcZ5d57Xw426ehtvzdYM9LnBoLfJopoxfRrFZel8ETYSG96Lqr75GE2kaWMN4DQlztvHX+f7HZoCFHc4baIKTsOyP6AHsqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 07:36:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 07:36:27 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/2] rust: add functions and traits for lossless integer
 conversions
Date: Thu, 06 Aug 2026 16:35:52 +0900
Message-Id: <20260806-as_casts-v2-0-cb76a4d3a6ef@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MywrCMBBFf6VkbWQy9JG68j+kyJiHnYWtJCUoJ
 f9u2pWCy3O556wiusAuilO1iuASR56nAniohBlpujvJtrBAwEYpqCXFq6G4RNmS1hrJgOpRlPs
 zOM+vPXUZCo8clzm893JS2/onkpRUEghc39wsUu/PU2LLdDTzY4sWo4UOux8DZOuog9p7bKz+N
 oac8wfFtDOC0wAAAA==
X-Change-ID: 20251104-as_casts-6a8882ac0192
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: b610a7e1-bbfa-4ef6-f00a-08def38d6cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|366016|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: PtVBF4at6x1/9iUtQyTIjRW2RMV9R55RONKrQPsKqGuXO1wFYPJK2z0WRw0Zgaz6hyd0+eqCoTTbUbKf+Zq1TY6cEzf8MQDRqwCKLAUBmxmRkCooqRcBe6GAiTV51I5CpjC2Ireq1/w5jLCFBmb+eqHglj+8TYdoMG2PAsWXtgWtdFve/p0EIMtJEXgcaiZoYp0z020CE9mWnGudmuq5HoD3F7uoNbYVJ36GoPcvw3FZ8+GzsQlpqM/3M8omZixh4HxAwgR7RVDR9bn/5abJgysbgKCzJpHZgYcjhFTR3zT+lonRLLsmJDpqZAgKjPvKI/OpOYaLkOVkFfQ45ZGLlZTPGNFawh3qcUJ4CCIBEzH4mE+gHE4FWjIGfVoBnvxPovSDquZ8D+kbQOilZb2G0+AHinPY2KiFQhEjafX+ZRpofiCoJL4Ff/WBhkTEOm3/9SAlTsoptxFIaDVR53wdXanYpkjmruBK+I6mO26FFEb4CLewM2BEwOrw8m163buGyuqmkjfYDaoKApHGyzMEHk3zgQW0fQTYDliuqaD9Zyb4kGH3hhsWu9zzYs6SoYZ0Bq1QLnRJHG/5lB3C+L0nFmHqltiqDEgpjkHW1bxMgIfXZmkArYMQMUf1r3C3eU+698g2LVFIiBZ1/wSzyqthhnPcsQBTyZZEEZ0QmXEKstbbPe4TF+ISYEk7UiuQ2OJowYUAmzM0vRj3zie1ZbA3yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(366016)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEpnTURidlpRdVRtOHZuVnNLU2JlcW5rVjFGeUlGWnpocmZaZm9XdytWbmRJ?=
 =?utf-8?B?Q2krNGx3cFhrWmQvdHdIUVYzRklVZFRESGdaNUVrekVRUlUxVDVJeE5oMkMr?=
 =?utf-8?B?dlRNUm45V2t1UmNFZzg3ZnppWEVuQVpxdWVmNm1TN3NxUEJiWWV2Q3lMNEkx?=
 =?utf-8?B?bitNakJUbndIa1pDVHdGcVByeGNTQ1FCNW9paUwydmJoaHVFeU52TTZKZ1JL?=
 =?utf-8?B?Q1BSZTQwV1J1RzR4ZXVKSFFrNEFOOUMrQ3o4MmJ4RThkRU1MWFYxcmpnamtF?=
 =?utf-8?B?aVFvT3RFSXRsYzJUdmtqUFRQZDVqa1doNGpIZFFEK0JZVHA1dGs3TGVxeVlo?=
 =?utf-8?B?TDI3dGxPWEhBVWdpQWtrMkpjTm5Na1U1bFE4NWRsblZKZzU5dmU1cXN2MmZx?=
 =?utf-8?B?TnE1RXdSSU55NHpETEVIclo5KytXNjVqRkJzbzNGaGw4dmhxYTBQamlLRTVN?=
 =?utf-8?B?bEF0U3k3UnFkMmp6M3M4am5vUE9MMHVwZkZ4aWZueHdRVjI2dnJ3Nm5XUmR2?=
 =?utf-8?B?Zzd5ZHJxbktZKzRjN0JkVVpEcmU4RWwrZ1cyQjlRZzRxZDRFdnhzSEtGemFC?=
 =?utf-8?B?bHp3bUdKZUtNS21JYzZvUUJ6ZXVRdWVSUmltLzhPWVRrSkh6WG9oRGNleUhM?=
 =?utf-8?B?SHNNakFiVjROYzlRTHdraWFFVTZ3QlBCeC9xclVDdUFGUHN2K01LSmwvcDN5?=
 =?utf-8?B?ZVFkaWJBR3dWQjB3cHJHNzRSenM3RDBKaVEvdUhtaDRZNnBVR0poSkgrcUJQ?=
 =?utf-8?B?RVByemhQUXNyUGxxdFVDSDQrT0VtcXNwekJuZ0JrazhMOEh5empleDdaWmZa?=
 =?utf-8?B?QnRRRC94RXpjZW9mNVRTalNWYkFQbE9FNEE0WXNoenFPR3c2WXl3ZlI2NS9j?=
 =?utf-8?B?Q0pHTS9tUUtUemlYZ1dYVm9lSVN6TmNMaXpTR21rbDhjZTBPMkpBWUlEbGpo?=
 =?utf-8?B?MkpKZ3FzQXd1dEtMRDZtTTRwRDh3NTI4SEl6RkdFMWpHR2xweXozRlV5SGZG?=
 =?utf-8?B?YURGaWlBeVdqa3VlQkpkUitOcHE3c1BvYm01M3E0QkEya0JlVEFpRnM2T09m?=
 =?utf-8?B?VHdtNDM1UEZXK2VIVmhOQnRlUmJWRENtSHcyV0JIUmw3My9HZTEvNDhPdUtV?=
 =?utf-8?B?eTZNaUY5NnI3SkNZVHVHdU1sVTZpWEdNSVFHaHhUZitCcS9wMHl3VUhTTFhh?=
 =?utf-8?B?ZkhNMWw5dkVvbkU3Rm9UQ1RoejNXMHQvc1dEcExESjRPMzdwNG1tVklPdjYr?=
 =?utf-8?B?ZGUrbDFIbkNqTnVJaVhsbHFBZnIvQUg4TTdWZDJValFOZWtzT09yQlhlNWlr?=
 =?utf-8?B?MUV0WjZJQ3QwcXpLNGVpR3BnVmFrUU9TalhKd1dVci83b2cyUS90Y2R0eGdL?=
 =?utf-8?B?K3FQVEJobVpoOTNHT0ZVbUpHWkZjQVlzN010eTlqNnA5OTFxcllGcDQ0Qm82?=
 =?utf-8?B?VzhMcHpNME9uNW5obDhoZm0vcXVpZ3EyRG5NV3RoeUg5MXpkK0Q2QUJrNnVa?=
 =?utf-8?B?aTZhRVlLckw1cG5CK0FNZDlaWVVZUER6YmJ6N3I0cW1yMjRzSHpZTEgvQnhR?=
 =?utf-8?B?Vmx6VC9OZVk1RkNQU0dRRnRaZGluanJGaU16elVNVER2V2s5L2U5c1BzRURH?=
 =?utf-8?B?UkFERFN5MTcrQ0xMUDU3cWRGQXVmSDMxMGxzMkpHUm9Ocm1pRlB6MkdaNkF4?=
 =?utf-8?B?SmtnbzQzUFJJd2J3ZWpZQlBjKzRzRHZRU0JLR0NqZ3I1Nm5TQ3hMV1pQeXVL?=
 =?utf-8?B?V0tKYWJ2cGJyWlFjbXZWZjJhWGFBVjZHUTFxVFhWVm4wMkpiNGtzZitDc3ZM?=
 =?utf-8?B?VDRtSWNSdG5lZVRvS0FaUEVEMVFHdHczVlBwaGZrdFJzb0JsZFc5NE5aMUNL?=
 =?utf-8?B?T3ZmSHhaTEt6eDBrR20zRUhhLzdjMi9lNkJNSGFialZJeC9abkhnRTR0VHRo?=
 =?utf-8?B?TXQ5OU9WZTh4NjZBM1RySndEQ05pR2MybmxKa1MyV0s0Nm96Y0N0aXNCUjZU?=
 =?utf-8?B?SnhiR3Bvd1FYQjJiMTZyTUk5SG9qMDFTKzE0Q2wzVTN6aHhqdmhCOWEzZ05q?=
 =?utf-8?B?b2xBRU9qTWhmRG1kVmhGbkpyMkt0NHhWS2FQbzgwR29kVVdMWStUUHlKUkFF?=
 =?utf-8?B?eFhpdGpOVFZqVXdmRjc3RE1ONTRwWlBGdjF3a2l6Q2c3Ui9DOTc3SWRxT0dG?=
 =?utf-8?B?UjFPM1NVU3RQQXpoaVJFeENoN29mOWwxQjJiM3FkdC9PU2RIeXhuQlJ3UHNU?=
 =?utf-8?B?aDM4RzRMNnc4MVc1WDJhQU1HZVRaKzR1b0Y2bklYVFhJMG1mYlB2WjhnRkxK?=
 =?utf-8?B?OFp1cVFrV2t6dThYUTlPT1dNaFBHNTdKU3cxLzFkdWo2YzJOaXJpMHFwVkx6?=
 =?utf-8?Q?ZWc6FvT/1KfR1fNIRaBHuKuKGVWtMa0Z1mCoXv4qK8xYE?=
X-MS-Exchange-AntiSpam-MessageData-1: QujSba6bKQc+KA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b610a7e1-bbfa-4ef6-f00a-08def38d6cb1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:36:27.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQTzSaORLeCykk82Qh8FPoNj5Ps6AimI0bD6arCvV4dVFfeHoM/8XcflM4EzGOBwJdp57d7BUvSpmZoTwOt/aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878
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

This series introduces a copy of the lossless integer conversion
functions/traits of `nova-core` into the `kernel` crate, and makes
`nova-core` use them.

This revision addresses the feedback received on v1 by making
architecture-dependent conversions available via a dedicated `arch`
sub-module to make it more obvious that they are not portable.

This series is based on `rust-next`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Move architecture-dependent conversions into `arch` sub-module, and
  use dedicated trait names.
- Use `use crate::` instead of `use kernel::` for kernel imports.
- Replace use of `build_assert!` with `const_assert!` (Sashiko).
- `#[inline]` all the functions (Sashiko).
- Remove stray `#[allow(unused)]`.
- Group kernel imports properly (Sashiko).
- Do not reexport the contents of `casts` in `num`.
- Link to v1: https://patch.msgid.link/20260727-as_casts-v1-0-6ea704ff25d8@nvidia.com

Changes in v1:
- Update to latest version in `nova-core`.
- Make `nova-core` use the kernel crate implementation and remove its
  own.
- Link to RFC: https://lore.kernel.org/r/20251104-as_casts-v1-1-0a0e95bd2a9f@nvidia.com

---
Alexandre Courbot (2):
      rust: add functions and traits for lossless integer conversions
      gpu: nova-core: use kernel lossless integer conversion module

 drivers/gpu/nova-core/falcon.rs                    |  12 +-
 drivers/gpu/nova-core/falcon/fsp.rs                |   4 +-
 drivers/gpu/nova-core/fb.rs                        |   2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  11 +-
 drivers/gpu/nova-core/firmware.rs                  |   8 +-
 drivers/gpu/nova-core/firmware/booter.rs           |  10 +-
 drivers/gpu/nova-core/firmware/fwsec.rs            |   2 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   2 +-
 drivers/gpu/nova-core/firmware/gsp.rs              |   7 +-
 drivers/gpu/nova-core/firmware/riscv.rs            |   6 +-
 drivers/gpu/nova-core/fsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  24 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |  42 +--
 drivers/gpu/nova-core/gsp/sequencer.rs             |   2 +-
 drivers/gpu/nova-core/num.rs                       | 211 ---------------
 drivers/gpu/nova-core/vbios.rs                     |   2 +-
 rust/kernel/num.rs                                 |   2 +
 rust/kernel/num/casts.rs                           | 298 +++++++++++++++++++++
 19 files changed, 373 insertions(+), 280 deletions(-)
---
base-commit: dc01dfb37b34beeefcfe1c3055364d41a4070c7e
change-id: 20251104-as_casts-6a8882ac0192

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

