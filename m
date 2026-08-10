Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C3CC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7071410E87C;
	Mon, 10 Aug 2026 13:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciORlF4q";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012016.outbound.protection.outlook.com
 [40.107.200.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D8A10E87C
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2LsSU9kbUC8Jin6KO90A/NES6C/46deKGbmT0ORUC3wEJl9wcmLBIU3zCBhgfOBxIL6OpXg9Wb0ozw1ObmqEWz6oPr5AtWzKEb431JeyIpJHRyfMqW+xSgOUIeuD/TcqE+w2+r30oKqb0UU3BbE5cmNS+F91ew9kQAwbUVFhEBT4wI/EECAem0Jpl0KZK/0aqAze7nIHH1tR5mZXJjJ/TwVz04oTPm7DTjnj702UVcIxMA2zfc6LtozZRM+NchMy7JFW5PlSBLgxE7FUy3qWXHWXNoPKocyNFPHKsFHH3Za6/3FXO6AADh0WoE+cNBp2uIodrlXjgzG7IehUNZLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHH1Y5X/E7Qt/GiDUhAVJDn9w8o6GTcov3itovuckfI=;
 b=WmJ8VnOHWwix2Q7zf97/i+uX7CnzNmnzxF0e5oAntS+Lbmd6Lso+eer8gdCM4WY72DaodjLDbIKzARWgsIqXMwi2/BPB7rqxcY2orZZvYHOdvku380XcSt40EMn5povz9HnyIkrZ0+2Ga5goFTsFGfM3cATWVA86iMitW7j4CHcqMkI/QBFfrZdEZc8oEDrbi8ikcYhModsnXfHjqOBmIJ8BzdUm9Km5gHYx+tQoHTLpsQsTeNj8vvOMjvKksCCNTWpoto0S4MIYf9+wVaGxb2UXta+lnftpbHcq/sLwnl2v88V3WH8MyxKKNGIbPPVW8QCXqrziBVRJQb0yVu1tRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHH1Y5X/E7Qt/GiDUhAVJDn9w8o6GTcov3itovuckfI=;
 b=ciORlF4qYB1VGti51DkG+DRYjIWW1nWAoW1mspWb8ki/Hag32ZW3gTiSeMsYehenHW1IYtoGo58kluV73fM52vc/c3bPvKfaw7sPC38qVYzhGvDQS86kmcao/hLdXgLwHByYKLJyIrDxrejGb50q3vMW2o2S59E8GcbEcwz7Iy2nDMVYSmE1hpSpdrGwaoeZb8J2UGeDkqxeu5L3WVEsT+7VgobC1Y5yEwEvIQdLv5f/dedrP7qJLbPqvSvyruYdbztxQrNLwgCG8Yba5rkIa24Q8Ra5Xqs1+GJMLQAxa0KGvklQm+ILn+7eSxWxUHPmaFii1SiRoiIbL6xb1UcHvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:57:38 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:57:38 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v2 00/12] gpu: nova-core: add PRAMIN window support
Date: Mon, 10 Aug 2026 22:55:22 +0900
Message-Id: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WP227DIBBEf8XiuVSAMdh+yn9UUcRlSbaqLwWCE
 kX59+JYlVrt02hnz8w+SIKIkMjYPEiEggmXuQrx1hB3MfMZKPqqiWBCsZ5JukYz4UzT+oWZDh0
 DwZlV0AZST9YIAW8v3Mdx1+lqP8HljbE5LpjyEu+vvMI33y+6+48unDIaQgu9NLrzxh3mgh7Nu
 1smcnzu8Ajf11o574nEmgS07ifMYyPdYI1kmvEeeg+WKW+dki3nwhrXB8nqhKEjf1+tn29ttOA
 031fwpwjn2hgi5VqBsa2xAHosolZ4/gDLTgIoPQEAAA==
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
X-ClientProxiedBy: DU7PR01CA0042.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::26) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: b99a12d2-37b9-4345-04c9-08def6e7567e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|18002099003|11063799006|56012099006|3023799007|10067099003|921020;
X-Microsoft-Antispam-Message-Info: GPiDo10vUC/VaDto6n9fIi+1XkCyEzIVICr+9qocK2Z0YSfk3osITdfDa2dMG+Wr7xGpR7QqBWQCursTrNSQI9/Rl0ad/1vki0is4EYJgrAAY66TNrF4jCPn8e+KalXZ8503gbCwQDacFktv4GUljp5tcnWZzvxFG51MIxcHjLJW83lrcC6wfMKw3VPQiPaTLsxmiZzBajU3kGpcO2MXz1yo3SAEf40TxhcgO1OyYWjWENjuPX9NGuEsmCRsYm1INkrKztIdU7GGkhPOXXqzsXdVXaFqiN42j5dvvyInVb6y6HJ91Q7nqKOUEuDJcDoDsC8+XNv3HfeJ/fSLVSCyZgzHnjyirvFsaiGuQbhsYUxkNuJtGzcFg+b9D4fZD2asdWxMhof/VEgPgjbFXkDSXzcH7+lqe5mIQOGcMg8NnV1dzNo2c6mlYxGiDcnlTSFbe0yK+NpiRtQAk+nBhTyd23/vpXtrVGd7VTztCLZdU503/2rsppoAuYyYvacqPCCHG6GCJbui+iuMgmDJ2IG71wMF5W0ZbJpmpN9VuMC7NauPWR0HXSI/loUaWodmLFyF1NJEbJqYK9rcgyu7ElNONWonOBWCX46c9xJmRJwUPwQSyZm+SNQip++bIaf8y0sB6ypHPWoO1N4n8u398LvLIkZ78ltiL1zYf6rod4mx1bk6SCsNnw6JhD0XQrOw3nfGN6wC6wNY4LtaibZANGz6hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(18002099003)(11063799006)(56012099006)(3023799007)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWgxWDhYTzBvZ2FGZXJxWmRzU1d6RVpKdWtuRC9jUkdyakNWbDFvY0ZzT3hR?=
 =?utf-8?B?NzQ4QlNPUzk1eEM0QnlHWHhQa3hUb0RXUG5aMk9iNUYvUmpyR2hENTFXTEZJ?=
 =?utf-8?B?Y0VSTkJVdGVCK2pTSU4zOXVtRnpjcnV0VkFuZ09oTzhoTlAweDU3eEJGeG9y?=
 =?utf-8?B?ZGx2VXVPcXIxZURBOFIzT2Z5WUFRT0g3RyttZ25jTnh1NXFJaTdIeU9DbzdK?=
 =?utf-8?B?eHZPdXVXRHl6TDAxSWs0U01OYWtJVDRFajZrK0RrVzBWL1NqaTVRdDF6anZP?=
 =?utf-8?B?WkFONEdpalhKK3pRYkxTZnRBaHcrSnQ1MmZPclptdHM5bDFkWDJ3M1ZyN2tN?=
 =?utf-8?B?TGtuVVpQamNrd2MzaHdLRk1XTEphVmI3RVRSRDRLL241Q25ZMGplZldwaWt1?=
 =?utf-8?B?eUZvcEpFVC9EUE9KMjBESzBRaUorQ0hrU3pObWFBWVI1Qm0xUG9TcEZrTi8v?=
 =?utf-8?B?M1pJdWV4NVNhdTVaMEREbE9DSW82ZWpjYytxWnU3NUluMjVFUnBGNFY1SlVI?=
 =?utf-8?B?UEFnMWVFOXV2NXFUSC93U2NQUXhURmhDbGxSOHpqNzhhVEZEbGsyNXlNSWZH?=
 =?utf-8?B?V0QwMmozMExJTERSTlRhQzZLNU5FL3JWMFZXN1VobTcvdGZKL1FVeHVwUUpl?=
 =?utf-8?B?L0cvSWU2NS9ZNStwUnI2dW0yUGRwTTI0aXlhdUdCaGZ6SDF5UXhWK1gzcU42?=
 =?utf-8?B?SFAwWGZkc0wvRmRaSGN3Z2pSNUs2Y0hrTElVVWJ0WWsrWWV0NzFMR3MvczEy?=
 =?utf-8?B?WUpHNVRTSDFuVHk4SnhGb1NDOW0vbTM1aTlQTTRjUlZ0Yi9icDlOYzQwcjZ4?=
 =?utf-8?B?QjhEZ2ZvU2h1K1FmWVBvTWJ5ajIyQTAvL1d2N2hWUWdNZXMwVzdVM1diRFh3?=
 =?utf-8?B?b1pQYUJzNWhYYmZQODR1NUIyYXFnL3RtV3k1Q3QvaXRVRHVlM0t1K3FKaEtU?=
 =?utf-8?B?TkY1Z2cydW5hVlNwb3JOUm5mc1VEOE9NTzh5VzRhVlhhNUtPdG03NXVHY1pn?=
 =?utf-8?B?ZlBQSTlhY1p5aGdrVXZxOEpFVjBOTnRZUlJrcksrK05iZ3lJTlJBcnI2OTE1?=
 =?utf-8?B?dVZWamVlU1hXcUhjUXhmMzRlVWZWR2VHQ3djZTZIM25hMmVpU2ZGUVRtUjJL?=
 =?utf-8?B?UVVvTHp3bE0vRHY4T2R5MU45M0ZHcHluSm92Z1dSR25HSkx6cUhyMUV4K1V3?=
 =?utf-8?B?d2VNRm42MjN5dDNyWG41Ym9aS2w3UGFZYmxEeVZTR2pPVWp6ZmRwY2thWEZE?=
 =?utf-8?B?alRQV0tRV0hvd09UODFmNVBlRzl4QUZSSmNBK0JtWEw3dUxlTkx6MGFadXVT?=
 =?utf-8?B?WDVNOUJXNzNwSHZjU0ZJWkVwUHAzMGMzb1FQaExaaXRIdU92NkJIenU2cXUy?=
 =?utf-8?B?U1czNG5YTzVBVXd3eTFvcE1XTUttZCtCUXIzU2pLQ1I4QjEvRXI5SVpPVk9N?=
 =?utf-8?B?TzhGRmxGemVWYmppR040UzArK29iMWpyQTZUTFVZenIzdytaYms4RU81WHRu?=
 =?utf-8?B?TDF4Z3NHdzlteHh1alNxS0F1MjVYMVNLbGxWV0V1VXlhNnVLekdOZHVwTjh3?=
 =?utf-8?B?WVNNQzcrOFJTbnRkRHJjT0NkSHJpL2YyM0VpZ2dvTUlmcS9Od3ErR1BMcnNI?=
 =?utf-8?B?bTE4SEU5b281R2d2NFpyY3NmanVtVU9BNHlPUVpQdE41OGV5aFl1NExObDZ6?=
 =?utf-8?B?V1N0WlBsM2ZjRDZRLzZ1NEJlZkZqTHF6bkkzTHIyaWp2UnBxdEYwejFYWHVM?=
 =?utf-8?B?bXFRT0pGZnhxdS9hZjlKQXhGRWlibERrWkVoaFpJVXBlbkw1U01PdzNHRkZR?=
 =?utf-8?B?czhNek5reERjbHZHN01GUWVLQlI2cXdSMlRKSGhHTEZ6aVQ5UDFiVjE1dnBS?=
 =?utf-8?B?M3RnR2pnK3Y5cEpKaTc4WGZ1b2xjS2NpS0h5NHpONTJKa2tPRHVxbXFSU3hj?=
 =?utf-8?B?SnJ6ZGtmV1pZbXIzYjZHY1RyejNsSWlrVXNXKzc1eUtFQzA5TUUxZEMwSi9a?=
 =?utf-8?B?c1U0WFJld1kwVnY2TUczTk9adGZFbUxacXVBWFlHa2lHMGg3MWtVK2hNNGRt?=
 =?utf-8?B?Uk5nZ0NCTzlCT2lpWGNqUWMzM3N1Qm9zaGNTdEFYZ3I3K2gxNHVkRFFHSWdt?=
 =?utf-8?B?eUl0MURtVUV1SHRIWG9McWFFYy9jbHFRdmswaUdWbkEwSERib2JGYlplUzhO?=
 =?utf-8?B?a05YM2hQOWRZYkdpNWU0NEFSU05mUWs4V0EyQ1c5WUd2dDZDMjg1bmZGaEpO?=
 =?utf-8?B?MEp5c2k0UGF1QXcrT2x1L1RnS1ZYeWt5MnMyTjRkdTZXQk9RVkIyMTByYWFn?=
 =?utf-8?B?cXhrcThKRlRYbzU4a0ovZlp6MXBEcndTc1JUYmxJeExtN3RublBWc21ad0I1?=
 =?utf-8?Q?JIXU+9Mdae44rSH7P7xRO0+mUcPX7J0zOIfO2hM5vX5bo?=
X-MS-Exchange-AntiSpam-MessageData-1: H6HWh3st1J2rHA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99a12d2-37b9-4345-04c9-08def6e7567e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:57:38.6772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yez0qtGORVr0iDn3cKN4Hf0RBuq+DjIWqcnWoeltvL9NhLJGmY8F1wSjpTJs25rBuklkovrUyTihp6XnAyHZpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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

[1]: https://lore.kernel.org/all/20260518180342.2387845-1-joelagnelf@nvidia.com/

This is based on drm-rust-next.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v2:
- Rebase onto Gary's IO register projection series
- Drop Region::try_subregion patch in favour of Gary's reg projection
- Convert Pramin code to use Gary's reg projection
- Fix const {assert!} -> const_assert! (Gary)
- Add #[inline] to shr_exact (Sashiko, Alex)
- Link to v1: https://patch.msgid.link/20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com

---
Eliot Courtney (6):
      rust: num: use const_assert! in Bounded
      rust: num: reject Bounded::shr overshifts at build time
      rust: num: add Bounded::shr_exact
      gpu: nova-core: mm: Implement Alignable and Debug for VramAddress
      gpu: nova-core: mm: Add the memory management HAL
      gpu: nova-core: Add self-test assertion macros and config option

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
 rust/kernel/num/bounded.rs               |  36 +++-
 17 files changed, 988 insertions(+), 3 deletions(-)
---
base-commit: 4c9ba407018e8deb06dbc643112bac8f40404f95
change-id: 20260804-pramin-split-950e210b6e3f
prerequisite-change-id: 20260721-typed_register-176eab3abee7:v2
prerequisite-patch-id: d58e4b8a0fabdeb9363b30f1aa28ca0d42d5190e
prerequisite-patch-id: 5f0c85c6bea0600a4b0bd28b389351e71010a846
prerequisite-patch-id: 8094bc0f51da3764837321c84d71d9c49ac2ac3f
prerequisite-patch-id: cc38839e9c3d9866bd889d89b7e2fdfe609ffc5b
prerequisite-patch-id: 2e919d4f6db02e9d9ed51081a1a803b12f67535f
prerequisite-patch-id: af8a6b3f4bed0953fa8d8f7c1b9e52d746aeb6b2
prerequisite-patch-id: 131291b0a4dc1ee7e43dd038f6f99fc5dc0eb99b
prerequisite-patch-id: 12288c2ebdd58989c5fdabab6237137dd12da566
prerequisite-patch-id: 8224018b7cfec0b00cce46b238abd9f68240e187
prerequisite-patch-id: c7676cbc77ff50b2b7bf13b28c8b7c971285cc9d
prerequisite-patch-id: 1aaed2df7816f907a9403d693be068ddc9a2e43c
prerequisite-patch-id: 04d879d32289f6d715c97ba0cc94b5e94371cc92
prerequisite-patch-id: 127be60ba6331574f6784cc8a5013d4f91b47df4
prerequisite-patch-id: 97fde91d1a5eb35efbbd43e99f595d8bba844cb5
prerequisite-patch-id: 77292e35e0b794e12c0ba7eea16f89c76d899757
prerequisite-patch-id: 95bfd46c2861a2da0179630b02565398d79d55a3

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

