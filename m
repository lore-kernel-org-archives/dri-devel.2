Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD32EC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0318C10E5B7;
	Fri,  3 Jul 2026 10:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="blWTXlxW";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A39410E5B7
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvxZWsO9iUdrCA8Md8WQlqziF4AGQLwcudkHV6QnrpVtOZb4SNK05SAbUFTNGSATKSxzW7yvrdf1QFx9nq04O7AV+vrddZB9wMQ2hcsEF2+8biEGUgrAjXBclpBtRC/QADKC9JFRDjXUwKscWxlKyL0xHcKzpJrJsXKcSB9qc9W60yBigymv5a82whNBeOd05wW2zXuE150hbsiv/iB0uZD3nPvtjq0yTF1KQDfOFgBb6IgwAnHFs/f4bmDbZp0n6FyDn7fs8m92VJm0CB6qiZ9hrKajtG/Hcq+uvVf/S9BrPSGK2zIOEhYgCkRrHCIn0BSpDXbWcwMcbyteFUyhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQKF9irGxaMhmaQnP9Z5CMt23TQ4X9LHI4hWw50gZC8=;
 b=XQ2PPX+4KfCtl+5oplA7Tu1iLkX2zjXyGoq+klopp6aO84R5aeQ2H6ni1ktEuzZYiKAMNkrsOhk2TdovpKZGdPMhiKCVLwIWRLJASYBq6+rwvox6Y+rMNr9sO0e9G24D0HpWfVNbx4n3U+Y69Qd/kfm9khJ0w0Byq4TPkQ+GQd4nld3Wxa9E+4gTcoMAhbf1wISSI2nGOLCNApvjUJQe06htvSNhzngc71OgYqv/gGv8ZoaErbyjzDMRz+qqWchWiLTRyWXXk8x+IxUQR0yoRwrvkpctSPINzlTmt+Q//CKAh2i/+ZRmvCZIkAiPGZL26APDAKW7Qekg70fK0xlJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQKF9irGxaMhmaQnP9Z5CMt23TQ4X9LHI4hWw50gZC8=;
 b=blWTXlxWeQ31jt6teQSgcGZSeSaYGmDp7DCW3VBE9ruY+jCSBu5rMKKH9hxNsWaodDd+kG7pVEZhoQtC6xVFOT2SUY1F8S+08ZUy6qD99q5s1CHnI29mMI/mXczdRG7HAGGkFtfusKSymZYsNQmJg5PAp9WLGKaW79+N++zRKWV9pcXcFEEzHK8KNocIfmvF7OsUuwpx1yoGaKgvERkOqyerbyuVcdU7frA+Z66V3LZ0mZoP6rqQNvo6AHOSuUt9SE5Hh9clQguEZSklqT9cQLqFw1olJ+BtHGrvQNuRVQaQl1bLfjowvZt2qgxY4B01MeuqiBQTMfdyBaWETTIckg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:22:17 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:22:17 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v2 00/10] gpu: nova-core: blackwell follow-ups and fixes
Date: Fri, 03 Jul 2026 19:22:04 +0900
Message-Id: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2VPS27DIBC9isW6VIyxMXjVe1RZDHhoaB2TGkJTR
 bl7cdxFpS6f3v/GEq2BEhubG1uphBTiUkH71DB3xOWNeJgqZq1olVBCczuj+/iieeY+XClxKZy
 RvXZGoGDVdV7pQVTT62HH6WLfyeUtZlMcQ8px/X5UFth0v+nQ/0svwAX3re4ldcb7YXpZSpgCP
 rt4Yof7nr/S56UOz3sps5iIV/4U8tjgIFEajUo7NNZQD6BQwdCrthvAg7JagnAd+3u4/t8HGb7
 EgtzGmF1cMl0z7wRMCsRA2tuxdHXE/QemGTvURQEAAA==
X-Change-ID: 20260608-blackwell-fixes-30c9358c90a0
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0322.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7f7fa4-96e9-44fd-0030-08ded8ecf57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: m/8ZmV5evR3xshKliwZdFzOTY4IMpvSZaPzQjjykRCtYzRzyIIcKt3mFg4QRi55GrnU3I6bMkOKSNFhgedXzb5zA01Sx0c07qwt22iYzpF4XfpPlknhDnuJ4soyZpwGWcqeXg/m9H0C/NOd9WGzP+ao+0zi9vSZEgueQo0fOnaMjVji8eKfVP1c0QhYTL0sMmhOD0Tknu5Tf7rShb9aI3xTkJCrZEzeX8mQUM6A491SwM98VvCMsoSxlxwMN0zqhnGZqVjf1LHHQpbfTYVv+jUlD0kukgrZ0WQEZdKBZHjjdrtVxBpQdbdHvdMVG6V5Vtx14o55kv321CP0GO52OO5LxbnaWgXIPpy6MTApmsAz/BzEqqJoFxTUFVtEcHo3AGJjyqtITBx20EygKzhxwERA3PeYrEO+e4QaeClwHx9IidgEEBmN8MM9qTP6yAmBkjYYkO42n03crUEibReVaKLbi4wBObH713epIk6ew9kzvu4sGZ3NClPyrS1dQEVrYxEhFyftdrqgLH0c27gikA4DnHybfSbxzQ2hnQXyDY+PlqxeVxBcaWsnjJdM23TvnK2PNmT/PKRX6rfPZ2a7Up0r75ZMoTEyvznSED4KnyxZ1MnnFWBiyGAHdj7s8u2s7RWliv7o2C7YU3BtoFyzWvIt9b2hjt0zzilkICL6kzxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3BNblFEQVR4UnFLdFlkcHY4bHMxMEpqTlQvWFZrVlczVDlLYVZraEVzRjFx?=
 =?utf-8?B?Qm50ejlWL0s5QkY5N1pwNDk4Y1hoSlZFT210RXlERlB0TWlSOWhQMWcyMWdK?=
 =?utf-8?B?TGlIRnJIRUZpM01ZZU9kSERBM1FPZWUrZTBGdWFtbmNtQ3lXNThka04zZlh5?=
 =?utf-8?B?bjVYZVBkUHNYdWFyTnRNZ2k5d1dPbUxvU0tZYzlsSzdTVkV0MkFPWEtzanlP?=
 =?utf-8?B?bFBMUHBWd0EvbFRKaUJqM2NZSTFmU0NzbnBpZEhLTXlSRU5YVDJCa24vZlZN?=
 =?utf-8?B?cWI5UWJ4NTZFWnlyRXpkbERxeXdackZRanNSTDBJZjJFbk0wdUY0TGxucE4z?=
 =?utf-8?B?QlgzNmJhcXR2dVA2Vi8wdnZMeGJmZWxoVElWdk5BREMzSVMySGtLMFlVSmd6?=
 =?utf-8?B?S3YrQ3VIR2x6Q0lwYUJHK2Y1T25FcFVKaHUxNEYrMG10cmtjOFI5dnF5VFhC?=
 =?utf-8?B?VWlickpLRllFbVlIT01VTnl2aGYrRWptR25Oa0VKNXZ1VldPbXE0aGp6eXJj?=
 =?utf-8?B?emJCRTI1NC8wRVFQd0NxNXVCT2pMNmJXOW9EMlFncmtNVm9lU0hOUWRWOVFL?=
 =?utf-8?B?bTAxUnVIUllTYVVPNU5ORTVOZXhUSGhmcTA2SGFQdE5NYWtjcGs4WTNQVVlx?=
 =?utf-8?B?alhmMjdtOXJVd3dqbDBNMEluYnRHMEloRVhZazJCdnpyVzhGUWFTQU1mQVh6?=
 =?utf-8?B?R0V3TFo3a21aK1RXWGFoV1dEOFp4WEhIMVJvZThnLzc4cmdDMTB0cXJoRVlx?=
 =?utf-8?B?N2piYkFaWWlGRUdQMU1aTElsbm9jV1QvWW5pclhiNE5TN05LUkdlcVNWZG56?=
 =?utf-8?B?eTBLNXNGRk5DR29XM0M3K2FDTVZFMVlaY2Y3d3NQcTRvR3p6NDNwbit1Q05H?=
 =?utf-8?B?aHhHOHZYN1ViQ2ZQWk9vaUdKNzB2UjFBNXkzdS9abDRkbTBzQnZrd3FoQWEy?=
 =?utf-8?B?eWdPdnY4Sjdmb29Hbkg2dU90U1ByQkNzUm40ak9rN0JCUWloVTVlejlpUVVC?=
 =?utf-8?B?d040V25LRHV3SFJSUWRtM0ZTTU16WkhUdEFaMTBIQTVjNnAreS91cGtTRU9F?=
 =?utf-8?B?VUI3andmUXpRTlNPY0Y5dVFBbStQWG9QVzZnQmp2SXVsT24rcXZPQllqcXBG?=
 =?utf-8?B?aXcwdkszUC9yVTREQ0pGSVVxMnpRQ2RXeVFlU2YvdVJob2IzR0hSRmJkdTQ4?=
 =?utf-8?B?Vlc5dUJJaFd2Uk9rczVRK0FmN05vMDd5MDNaVVRLN1hiRjg5dFU3dHVaQ0R3?=
 =?utf-8?B?c21lNWc5cHhLaGdxQ25xKzB5Z29wc2VqeHUxUnRFSHR3OEhURDJFbHpjSGVV?=
 =?utf-8?B?b3IxcGF5b3BaNFVPMnVTY2RlRFAzSFJHU1p5MzdxcVpXREt0cVlUU1dZTEJu?=
 =?utf-8?B?QjZQVDF1ZVppYlNMdnZlU00zdkdGUzdVK1BwY1dLbWp3c3ZNTXRiQW9IeEtK?=
 =?utf-8?B?L1VveVRIVVFTK2NtYTVWc2wzV2hGbGd1V21LbTJuM3FneXlSN1NGOXN5MS9u?=
 =?utf-8?B?dkdrMXBPanM4UXZLYTkzYkJIenpudzU4bVh3eWhLUEZFTnY0Rk16em01Q3JD?=
 =?utf-8?B?Y1kwLzZVVmNYbDBiNVJ4enlDa2lVMW1ENXVKd2tscmp2ci9ua0tBZFoyczFo?=
 =?utf-8?B?RVhlZHJqSUZjVVEvTERsNU5nOHd2R0dadGtER3RVaGRTMnBDNzdrQ25DNlVm?=
 =?utf-8?B?RytUeFlQc2VrSUpHd09RWmx3alBNeWFONHo2TEJLVWZDTm1JNWY0VC90VFg3?=
 =?utf-8?B?UE1LSUR3STQzVEE0VEJIQ2Q5U3hHR0dCVlRiYnlZdnhBMHBrV3luY21EcVJB?=
 =?utf-8?B?SkF0K01hck1wenhXZjJ1TFdTbDVrcHdreGR5YmJDb3RIRm1WVmIzK21BQjdC?=
 =?utf-8?B?aDI3YmdzZTg0eGhaL0tYdHkweTUwK1JCNUhJQ1BLUjFjaWF0MmNvS0tCdG8x?=
 =?utf-8?B?eDdPcy8vbXNzYmpiQzVnQjdzVTY1ZkhtRWhyRnBrdEVvRzlsVXRwZnFtcEM3?=
 =?utf-8?B?eGErSFVHM1F0c0xrdlRITHYxS0ljakVKU2l1biswVGZYOWRpTHBoam54RG5Z?=
 =?utf-8?B?aUJUVzQybkY4cmJ2VFJybjBOdFZIaUs2U2s3ZDNLL1p1UjZPR2h0elYvc1hP?=
 =?utf-8?B?SjQzTVQxM0ZjQlFHclRXTzFZb2hXaStmRTE1SWk5bDlPY1RJeDlicSs0UzFW?=
 =?utf-8?B?ZTRUM245N2J1VVVONnIwaWY0UXhIV0pGbFplb3lObXJDVDlYQ05pdlcwMFdS?=
 =?utf-8?B?cXlzRy9POU1MaGFJbWQxVmE5K3o5cjU0cXRQeGRJdTk5RHZCaTVMc3FSYytm?=
 =?utf-8?B?bnlROTkzbFBEL0d2OWlmZURDRlc2YWxaaEtkVXpkbmxNcDdMMEl2T0RWTFdC?=
 =?utf-8?Q?mwLOY4J0UM1NwXkyV+86L+w8GpXbS2w0yy6yAmmb6YB8k?=
X-MS-Exchange-AntiSpam-MessageData-1: /IMWtpYDKuRBag==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7f7fa4-96e9-44fd-0030-08ded8ecf57f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:22:17.7400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZSHN8DH4VDCtoWctEUpO/THqXJJKK9yBMLrX1Neuy5NdM9nFM6N8blg57OvkHIQV7q/doNiP5xuRVsWkvlfUg==
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

Several fixes and clean-ups for blackwell related functionality. In
particular:

- FSP communication hardening
- Fix for Coherent allocation lifetime issues during FMC boot
- Convert some raw DMA handle stores into &Coherent stores to help
  prevent future issues with the allocation not staying alive long
  enough
- Make FbLayout code more obvious and correct
  Currently, the frts vidmem  offset is calculated based on the non-wpr
  heap size and pmu reservation size, but AFAICT this is not right. The
  fb layout actually looks like:
  | non-wpr heap | WPR2 .. FRTS | PMU reserved | ... | VGA workspace |
  It's just by coincidence + generous alignment that the values happened
  to match with something more like pmu reserved size + vga workspace.

  Originally, I thought it would make sense to use the offset of
  FbLayout::frts to compute frts vidmem offset, but actually the offsets
  in FbLayout AFAICT don't make sense on post-FSP.

  `FbLayout` is used for both pre and post FSP architectures. FbLayout
  contains ranges for each region of framebuffer, but on post FSP
  architectures, only the size is actually used by GSP. The offsets are
  not decided by the driver. So, for post FSP architectures FbLayout
  contains essentially guesses for the offsets. Instead, make separate
  types so that we only store the information that's actually needed.
  This includes the actual reserved size after the pmu reservation so we
  can properly compute the frts offset.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v2:
- Rebased on top of 20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com
- Dropped applied patches ("falcon: gsp: move PRIV target mask constants"
  and "fsp: move FMC firmware loading into wait_secure_boot")
- Dropped "gsp: keep FMC boot params DMA region alive during error" - 
  will finish discussion/fix on the bootcontext series from Alex
- Drop "fsp: try to enforce exclusive access to FSP channel" as not
  necessary.
- Added some extra fixes around the falcon "halted" state
- Drop "wait for FSP boot earlier" since FSP is now at Gpu level in the
  bootcontext series from Alex
- Don't reset FSP queue pointers on error
- Add r-b from Alistair
- Return EMSGSIZE not EIO for FSP queue return message too big
- Link to v1: https://patch.msgid.link/20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com

---
Eliot Courtney (10):
      gpu: nova-core: fsp: limit FSP receive message allocation size
      gpu: nova-core: fsp: catch bogus queue pointer issues
      gpu: nova-core: gsp: ensure lifetime for FMC boot DMA allocations
      gpu: nova-core: gsp: ensure LibOS DMA allocation lives long enough
      gpu: nova-core: split FbLayout into FSP and non-FSP versions
      gpu: nova-core: correct FRTS vidmem offset calculation
      gpu: nova-core: rename heap size field
      gpu: nova-core: return non-WPR heap size as u64 from HALs
      gpu: nova-core: correct RISC-V HALTED field
      gpu: nova-core: wait for RISC-V HALTED on FSP unload

 drivers/gpu/nova-core/falcon.rs           | 11 ++++
 drivers/gpu/nova-core/falcon/fsp.rs       | 23 ++++++--
 drivers/gpu/nova-core/falcon/hal.rs       |  5 ++
 drivers/gpu/nova-core/falcon/hal/ga102.rs |  7 +++
 drivers/gpu/nova-core/falcon/hal/tu102.rs |  4 ++
 drivers/gpu/nova-core/fb.rs               | 84 +++++++++++++++++++++++----
 drivers/gpu/nova-core/fb/hal.rs           |  5 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs     |  6 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs     |  6 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs     |  9 ++-
 drivers/gpu/nova-core/fb/hal/gb202.rs     |  9 ++-
 drivers/gpu/nova-core/fb/hal/gh100.rs     |  8 ++-
 drivers/gpu/nova-core/fb/hal/tu102.rs     | 14 ++++-
 drivers/gpu/nova-core/fsp.rs              | 70 ++++++++++++++---------
 drivers/gpu/nova-core/gsp.rs              |  6 +-
 drivers/gpu/nova-core/gsp/boot.rs         | 26 ++++-----
 drivers/gpu/nova-core/gsp/fw.rs           | 95 ++++++++++++++++++++++++-------
 drivers/gpu/nova-core/gsp/hal.rs          |  4 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs    | 40 +++++++------
 drivers/gpu/nova-core/gsp/hal/tu102.rs    | 31 +++++-----
 drivers/gpu/nova-core/gsp/sequencer.rs    | 18 +++---
 drivers/gpu/nova-core/regs.rs             |  2 +-
 22 files changed, 344 insertions(+), 139 deletions(-)
---
base-commit: a73a398a68ca9b9e5116a617562471f16b8310c4
change-id: 20260608-blackwell-fixes-30c9358c90a0
prerequisite-change-id: 20260619-nova-bootcontext-401d6107e8fb:v4
prerequisite-patch-id: f0a0ce0462acc6881b0255d041605544baf85636
prerequisite-patch-id: 1d7f7da1c7c40eef0b3e522c2a0a4fa00b286bb1
prerequisite-patch-id: 43c5946acdef0a11227b405f6acd3480c7bbb79d
prerequisite-patch-id: 5ebfed11498a63a7e5652a0a4ee50ff4d1a188e0
prerequisite-patch-id: 04f4e5dfde6f418544eae9d44737521bb1ca571b
prerequisite-patch-id: 1ac856805341457a1f54c26a4b0a29ac40f635be
prerequisite-patch-id: 8c16161b095920e6b0c8f6ce40cd209a93437857
prerequisite-patch-id: eedb6aac0de88ef016ccbe5431e7ac723a0b8f23
prerequisite-patch-id: fdfc2db6deecbd77d098bbc8e0f74ad09efa5a3e
prerequisite-patch-id: 923137f8d2664b73dbf55df106816f8edf912f76
prerequisite-patch-id: bf5cf0653180963ccac35495dae05d1f2c8b1d70
prerequisite-patch-id: dfd10bc2d272d344b6746ce3a05c73773b743696
prerequisite-patch-id: 4980eb81d7fd2438bae1b535746795e4eb43725e

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

