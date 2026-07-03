Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CADC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7EE892E0;
	Fri,  3 Jul 2026 10:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EY0NZium";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5600892E0
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2bB9l35hSqBoxqDkG880ePreafMnUXyOCQKV5X36TcV7/bsrPPmQSRThW2Mtg6+p8RKS4aWEQOC3emTbsghY1u4P5keUBPW64JrMTgnom2BmQSGWwjhEbNFFiHqnlwKeQIOmJjyWni70pCV9xxCP/XSLLrgjrGE2YIipIx+ss8be9Wu7V6Tp6Ymdm/xXuTrOuKBt6p2Oq2IvfP0YwB2WeIdyxYJ7zEKBm4F1fECrVbl9ojjedEhdu+1gwg6L50j9j2t4yARgx4h2UMVoOJmtnGowwoGVgfb/gM0gLDdioIbN3ndsOe4D0Fzu3FjfknAgjUsceDxSIuFC/QkYOUt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO+Ex3CIr7hPGmYKxtDaX10HI+Iwe3Pe5ksAWEkTr60=;
 b=Xp7W1tEhaWVhtnVSqGsLUewXsyRszrQ9wW1dYF3WU+D0jlRmCeAq4BOzWCZCviUMrkxh1oxjIYMRX7NRfy2cqoQdZ3W8bfpPeP236UzHYj6LX6g/fzfus+1fvkWt9tyJeph0HEMU7Mz67jBlzIA2pgp+G5lb43lVgwzCAAeXBrxSrNzowisQv/LqpYlYAL3H6D8iM5Gwk2f0vzfkApxrx5mmdKZZykfFg+fJBeDj/ONT1VKBEKeW4xjR8/80lRWmcOxzUZtkTwoW62eLwp1Ak3T9o7sSZQYx5SjKEFasGAQhY/ADcTippZk3ZHPWFTUPUbuLH0WyVlAseWx2hXkY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO+Ex3CIr7hPGmYKxtDaX10HI+Iwe3Pe5ksAWEkTr60=;
 b=EY0NZiump+Wfxv3dOimwczGJZ883L3FQMY0E/c7HFpZZg1ilzQft6JJ38gHAszXMskOutodd1rJdNDmjOCLEVgAtCtijGOdG1SQg7MzgEw58VseL35vUl3f4pwycSsfkXyCZvKbc/Sy8gJwcva3S6cClkfTlMNlbE4U4Py4YLMGE3osplRAfIz4rSVbGAnnfiKg378K9fv8wOLpe7dwQMxTsW0AS04Z/2L84ZfYwQb7rXnPPzDxsyszCvId5TuGc0V2bq3CT7AybC/FAX5mu9k0fATsIF1XhkMXXAox/pSsH/zFXNDQ46W9/B5EO1Z8L8afTzD/bvpjF4lFjY+PlBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:19:20 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:19:20 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH 0/4] rust: Add support for reserving of ranges of IDs
Date: Fri, 03 Jul 2026 19:16:03 +0900
Message-Id: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwML3eSMzBRdQ4u0REsT42SzFLNkJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAGIHcgxoAAAA
X-Change-ID: 20260608-chid-18fa943c6d6c
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>, 
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
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0108.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: e22a49e2-0bb0-4b77-8779-08ded8ec8ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: +zsVKT/zG8gF0OB2IgnTTPPXicU5j7Y+hC7HsMG/V9gTqOiyn/Ljn11fzAAYs5i2dSsN5W0JKonFwOQldCrXchjnx29PfLZPl3dXc/FZO7m5BVF55L67tK2i3Rjg2+u8tQE8B2T/dJ2jmTvOzVo8depzzenMedUQWj5QwpNepkzihu+CIz8vPMy2939uFZCTK64+PZ0U2AXhOzRCljHBUtEhynz+pz6W+Euk7VDt8u3UNA5mWXEFN7YVn4ltYN3YycFJldKrfNpWE76VxUoHr4fxcGvbpmRh2LyPHZaXSXvi14xl6FwuRanLJhR7wodZ+pijTw1CUoVFbruwyOVnNq4+FPIK2NjIRAwzHGu46GuLnOuQTwhiMwz0rnMi7j20ljb8LfuxagfkP36fjpjHs7ftzqzID7HFF5MyTn++aaS8WS3dRjU9hfdXKXplRfmMKMrYKF6+NYHe0EmHw133oTcB9k1IixQbWrTQduV0USaa77f3/VNOVKENMkzEE6sELG6jt3Mi3p2xqovpxX7FUiUb2Kt4sRgtuJ0dtQHK4fXlLhe4GbVg0fRq9PqBgof0oB+SFzZI1ShmDUdkatddHyBdMQqxwDZemswga4RHJfBombgHo7A0iZJCQ1jrKo2bvTJ2vYiz4UbiJWZvAqfieayVM4smC1PDPd/jR36lzl4CuU1TOWvP802e80AZefAQo3C2ivVYqoGTIvCaim9X5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVuOXNCT3kvSGJYaHQ0VnBxNjM4Ym85eEFtTEgyeWw4N1htd2Z4U2JzWElV?=
 =?utf-8?B?U1FrWmtOeExBYndIdkdDTW9POXgrdXdFTW5FQ2xYKzU5bjVGclVpYXROL2M3?=
 =?utf-8?B?clN6YkNBU1FtMWc2Mjc5R3pNMVFFWFY3MFlhNjlXejlEKzRSNU8xOEt4c2xs?=
 =?utf-8?B?SnFHVlZVaWdJVElTN2xyeTdLYjR2VmpjZG5ET05KbHBCRk43YnoxUkFxZ2h3?=
 =?utf-8?B?aDFoUlptL1NaczU3YWFzVnd1SWhCa1R0UUxEaThRN2c2dGJBRGQzbmtRY1pu?=
 =?utf-8?B?aXdqcmhjUUQ0WXhyWHRja0ZPL2ZudnBQN3lRaHdpVnVNRVhRRm1pL0hQazQ2?=
 =?utf-8?B?ck1sZ3Y3N2pTTTQ2SjdtMGhXT0p4VEttdUNlczhsZW45UW40TVRjcWxkd1RL?=
 =?utf-8?B?NXluRXFEWjlNa1QrRmxCSXorME5nSHptV2F0aHg2OHAyTmRuVUEveVJTWHR2?=
 =?utf-8?B?d2tvZ1hkS2hCM2gyaVIzelpTSTF2eGFvRG84NVU3dlpFNVBIaytueEZZbWRL?=
 =?utf-8?B?clNDRVhNOFBoWkM3Si9yNlBkQVVoWmc4dEQ5bDVHNG1RUWxJUUcvQlhLME83?=
 =?utf-8?B?YU54UG5oYmR0M1N0bDhJbUkzSzZXTm8xcDZmTlVQY2FyR3hVQmdZTkVwd0hO?=
 =?utf-8?B?UUw4Uk1yOWI2dXJpY29VR3JFOWFRc1JNdjAwNlhSNUs2cm1nSER4MmNDYmVs?=
 =?utf-8?B?Q29WRzJYK21nMTZka2NrbjdsK0p2ZEpMWXB6bFRhZ3h6WnBNL21lRlhydnJE?=
 =?utf-8?B?SWxDdk9DeTgwUkp2djhjRWVaZTFxakhIVmZWdVFtbEp3QzVseWQzT0dkWWtN?=
 =?utf-8?B?ang0eHpHZ1NSVkRJbXNnM0cxWDF1c2pYY0trY3ZzdlpydkllM3VTekJud3dE?=
 =?utf-8?B?eW9aWkhRekc2MmRhaHFNS2FkeFM1SnlkYXpVMk1nZk85VTFrWEhCdVdDYUdH?=
 =?utf-8?B?bWJ1Qzg0YVUyNU1yeDVnVS9EVmZjSnNtZzJ2WURUYUlxZERmcnMzdlRleUZX?=
 =?utf-8?B?ZFNMdG8zSjdrZlAxaE05L3Y3U1ArL1ZSZDVERElMTXd2Vm5EbERhVWV1bUg1?=
 =?utf-8?B?Uko5TTRQUk5xeXlkNG9nZ2ZOZ2ZMTFlLdEJkM3pnRmxSYzAxVTEwbG5DOVlq?=
 =?utf-8?B?WWJQMmt6YnRTc0YrdWxURnpRUXZBekpmeTlJcG5pMUoyZUtFVGliRHQxMDRN?=
 =?utf-8?B?NnJMYTlJMCttbjlmUVdDTnFNb0pEaElkQkttaWNlTEphOGtrSUFVM2s5TEIx?=
 =?utf-8?B?RVJWVVZrelp5S3V1NUd0MVV3TmUwY2ZLU0RReW84UnRLQW9HdWVUT3lQdSt5?=
 =?utf-8?B?SkVMSW1JeFR3RXNnK2N0bldzaklpd3IzQ1hENzVYalpwVDkxU0lBNm0wVWFV?=
 =?utf-8?B?dll5aWtZUjlRTFM5K2pvWllJR1ZpeldiTnc4N0hKVXg3Zzkwb3VMOElKSjB1?=
 =?utf-8?B?OEs1ZEFzQmRZVEh3SVo2UndTMGNBSFY4Qm5raHZESFV5bHFMS0xkRGhjNmZL?=
 =?utf-8?B?VXY1Um9QUWwrb25waXBKeVdENmlSbWdZL1lHc2U0Ynh1Z1VIeXBmWjFaQTZp?=
 =?utf-8?B?V2p1T1JjZHJtUVY3alJGelVlUUFzNm9NYi81VDJzSldPYVVmN3ZWaThVSWM2?=
 =?utf-8?B?V3BCMG9OMmEwQjFqN1ZWL2xqV2xIdUpYZHJBeUZhVWQzd0oyaUljc2xISEF1?=
 =?utf-8?B?MUJjRjRCaFgvMnNIMDNPaG83R3AvMUtWbG54Z0dQZEJXMUhUY3NHbFJBdlBZ?=
 =?utf-8?B?UFlwNjVpY0JLRVhaMjFKM1dlNXVDT1cwWHpwWmhTaEE2MUFvbDUrMkhRTUdI?=
 =?utf-8?B?S3pGRnI2UmJsQ3paelYxRDBlVS9EMVR2OW5mcmV6TGo2ZDBQOFVtQVJTQU9X?=
 =?utf-8?B?WXlZbmZKZGpzU0IwN2o0aUd3TVBaTStmY3hmRWU1cGNvMzFDMXJ4RlBpVVhk?=
 =?utf-8?B?Y0tBSmlNdk85ZXZDVGxDU1dNQXN2OEthL09UbXRFOFVtTGhrRnNMSTlqajRz?=
 =?utf-8?B?V0xuTzl3ZDVxa2lsUXdJeGNnaXZLemVoS0p4WVdPOHJZYXZWeEVmdDJkRFZy?=
 =?utf-8?B?YW5lck1BR3ZITDZ1emRzY1Era3RuU0luY0dJUFdzZ0N6WGN1N1c4YzNhMk4y?=
 =?utf-8?B?cm5xaGVNWDE5SHZNTGh2Vm0vL0w2b0ovV2FWMXBTVmhGWEpmc0FzVE9uWmRG?=
 =?utf-8?B?T3BMSmowYktPUFpPVjBtSEhwUnJkWWZJYkw5VjJPVm9UbWsvUi9hZHFGaFcv?=
 =?utf-8?B?VUE3VjMyOXZRb05GS0gxTjJqUFpEdW9YWHBoRnVtSzFvSG9YS0JzZElrQisv?=
 =?utf-8?B?U2VmdUVKUG9WeHFPWmRqRTVqMTJ1UG5KNWczR2p4L09aNTZSZXB6YWU2UEdZ?=
 =?utf-8?Q?OJGZZOSoa25gEee/pzajuT6Lj6vzEqWGhkCZ68/YjcZVU?=
X-MS-Exchange-AntiSpam-MessageData-1: ay38IvFCPLnwYQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22a49e2-0bb0-4b77-8779-08ded8ec8ba4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:19:20.1143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1bvbzAi+XTDl33LlbuaOn2zQAzODX95uxrpbY4Zui8TN+JR9d5sAcZlsPe8zK0a7iCtzw5S0NcTnGGtt/B0uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

Add support for reserving of ranges of IDs, with a usage in nova-core
for channel IDs. This entails adding the helpers+users of the C bitmap
API for ranges of bits, then users of that in `IdPool`, and finally a
user of `IdPool` in nova-core, `ChannelIdPool`.

This is based on drm-rust-next.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Eliot Courtney (4):
      rust: bitmap: use function-level cfg on kunit test
      rust: bitmap: add contiguous area operations
      rust: id_pool: add contiguous area allocation
      gpu: nova-core: add ChannelIdPool

 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 134 +++++++++++++++++++
 rust/helpers/bitmap.c                |  22 ++++
 rust/kernel/bitmap.rs                | 244 +++++++++++++++++++++++++++++++++--
 rust/kernel/id_pool.rs               |  68 ++++++++++
 5 files changed, 456 insertions(+), 14 deletions(-)
---
base-commit: a73a398a68ca9b9e5116a617562471f16b8310c4
change-id: 20260608-chid-18fa943c6d6c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

