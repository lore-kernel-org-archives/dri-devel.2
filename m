Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3ECC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714A710F011;
	Wed, 12 Aug 2026 14:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Sh4tBRAP";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020107.outbound.protection.outlook.com [52.101.196.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10DA10F012
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho6uHyJJOcVrCouAALdfItM8NArzm907/CeyCYAu99CrcAR5qX6trUGXZJZnt/Qdc0ho5jt2xHyC/HBF/EBtKkUOTkeoM0tRjh3syactSo6l4yoNKsjlio5ZYl4QYnV+cJGLirC9Rs0zWcJu8znhwE0wlGfQq6Aijw418Y7r/VTaTclE2yYUcHK/Sy4xE6Rv+EENIH7kGX/BFhWfgrJp+mLNFDIGcfupd9I+yT2UeSxl/zGTRVq30cQ9qB0qF8LxJyktbc0/Kn6OWoKc9DFFKWSLCsYzqGcDjx/Pg9mcC0FR1yK17/G8VXgPlxwIcVT2nDnhczKgsqm6JbJ3ghvxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgMz8EmZAZ14kwKoBqdHuUPr1x1Na/iYVYzIXJ0ky7o=;
 b=dbJ89zX8kAWhSLzoSOI947P4Hdy9XmOYNy93E+4QeK0h0uiLjoSsj8HG1KN3BjHx59kRODZ2Tqy0avIdgNa8v2/DkX9eiH/GGG+jAxhDlRiPRXkG6p+jsJDuDKPvuGncEaa2Z/GZIy2RPbcesdscnSOWafj+lb3xjTxUOc1hNHiR4b1smMAOAXgo0kmvrgCnSzhxXV2ew9m6PDrYCBNgsEs57ggLTof5fe3svA7HPJf7aIOkh2+9+M9qSjVFIBK1sIB80blDT/OaQgvOFYcST1sedQDcfv3jCgkk0Fi5Z4ylDDx7AiPLlPmkDiqwIziEjk0CNxEz01yRnGH/6j0rcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgMz8EmZAZ14kwKoBqdHuUPr1x1Na/iYVYzIXJ0ky7o=;
 b=Sh4tBRAP0eZsAdujqSOgSxq0xP69Cy43vQXr1O0RC8Griv5QBF8XtOrhCHSCOKxBzoDVQPQvYRQqYvbnxC//hX007msa8zi6LXjaQiNRXlm0x+Rad2WeZmTy7GIc5bD6yN2wp/HjJ6cLgKYOUyjNZh6Bh34wFkFxvCoWPUY+cFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB7866.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:210::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 14:00:55 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 14:00:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 15:00:54 +0100
Message-Id: <DKN0Q8TTO2AN.1FSUS3RCSAB2U@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>, <sashiko-bot@kernel.org>
Cc: <dakr@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
X-Mailer: aerc 0.21.0
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <20260812120606.191456-1-vladazaharova2018@gmail.com>
In-Reply-To: <20260812120606.191456-1-vladazaharova2018@gmail.com>
X-ClientProxiedBy: LO6P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::7) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8b5290-8afe-413a-7f9c-08def87a208e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|10070799003|1800799024|22082099003|18002099003|56012099006|5023799004|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: zuXbgoDO8EKFzpudtkSCxzHbmoqb+Ol2vZIhruuwi7p/kvlzoYeSNAdirNNxR60JP9meEDAm6zNGrME8MawaY1Wv21cC5yz9pTeTEKFb5M5jiHkcbwhh15s8Agan9KjADZTNgr8cxm4VQAxM9552oQwJo2y7q0VVt6ldViKt7dFq4jP3QABYZb3jHWID0ToGiOovmaPWHJ6RpL+/3pZ2NoaLmudzFcyngM4gjNjU+RWNC32LMIYBBIwOBO04jvVN3nn6O4A2fD7AaR9DkjMmV5WI7SnXebisqOQ7kG2DI44+ocbeOUTnWhvFBVaqq2/1CrKbCp3mMdFzfMB0jePrrZjZQcQ6sjAp83FOTPduNWHwl3khPdZALU8caPzh2o5WoAmLPt1JR6lXHm1bM3qRSZq3sfhFRVnb2DOhVXKtLMoVsbaZDTBhFu29mF8rtrD7CEKzhDOsMgjH5nyYlP96IJ+t50Q05Kvdy+OUHypKZhQ9RkJefcOiLAmzoEYH+SBZzA2IuNGWK8j4TM8NkvM983cNIxqGoLU+lQaY2wVuofp7kEEG/kTl7hn2dQCdzV8CaOatMSxWacsrP7QYoqtrxNK7BtKIZoWDVsRDG7hUz1/kUy+Gfwo391AjA4E0SY9NQJoyFaYvSLqIyKq4hpJS/RlVlqFhNvD63nRyrAHsiLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3YwbTF6eWpELzNpRTZ2THphN2h6UWJ2Um5zL1htUlB0MnlKTy9PalNWTXB6?=
 =?utf-8?B?TUx5Nlk0a0dEekxkRXdnaWIwRlc4bkNyOVowVTlOZHA0NWpBUmIxODA1TFpC?=
 =?utf-8?B?UFplTDB6MjluUVg3RlZ4M3Rjc2JlMmdiRExxRWZFMTRRZGhXd2dmSVdsYjNp?=
 =?utf-8?B?NUM0VHdLSTZ2a1VEYWp0R3V1czJ4SENBWTgyaUxzSzRaNHgyejNBeUlJRDlG?=
 =?utf-8?B?YUVER0Q3UXorbU44QWEyd3VSQkZOVzdVYWd6MDZQSGFMSXhHcnhhYWQ5cFR3?=
 =?utf-8?B?RUhvanBhREpRY0p1VUJUbmxDSE1JbERVZ1dSYVNTck42akdVcWxEV2RpdGNu?=
 =?utf-8?B?eVNxb0NZYXp6QVR2aFh6R3BXcDVJQkxOdHFFUGhrclhJclRJd0tIeloyRnI5?=
 =?utf-8?B?cmloSDFCVVBxa2tJTmVmRHM5bkV0azZJcTdxQ1lEbSt2TmhQV0VWWE1IR0VV?=
 =?utf-8?B?MHE3ZnRXbGdYT2VwU2NkTkU3MGt3d2lhdDFZenZDQlpMbzk3QU0yZUc0VHZF?=
 =?utf-8?B?eEsxbEY2bkNiRlE1WDJkY2pMbjZLUXBlUENUUERwWXRkQzJhTXVrNFB4Ymd2?=
 =?utf-8?B?YVVMbnhaZm1xSzFCd2VsRSt5dW1uaXVqa2lQM3ZPWklEYklKamY1Q3ovbXhP?=
 =?utf-8?B?bE9PNFZXaWhySW5JODJJVzdIUk5WRVV3WG9aZDFXZ01Pd0RWS05INGtOZnJu?=
 =?utf-8?B?a29BcnhJNHJCZ0hnL1hWeG5EQkMwT2wzNFBVMXFBYXBNZjZwc0ErSmkvcTlm?=
 =?utf-8?B?a3NjWmhYcHZuTE5qQnN2dS80aUVKeDREVkVzVWpyTGVWNTRzWUNDeGZYQUMw?=
 =?utf-8?B?Vzk5THNCZG5CRVhUb1hmbXJFT2lmN1haV3pCZE5UVDVXc3lrNVdJekNsTlZk?=
 =?utf-8?B?V0RjeXAxa01qWGlKNXFETlJrS0dxd0V2MURrOEkwNWFyZVMvS2ZNZjJUSG5Y?=
 =?utf-8?B?VHllR2xJbGpoTjZIRzc3ZE9ablZ3ZmhXTkNTNXpNWjN3c1RnNHNDUUtPL1VH?=
 =?utf-8?B?Z3B2ZzQ4N0dJZDZrb2RjRTBWTm96SjBaUjhja2F1N2NGM01KU09XSFNlSjY5?=
 =?utf-8?B?S2gvZDdpVkYvMiswVUxXOGJ3K3ozWnpGZEllVEtkQVZVNWp1L21mczlBQktS?=
 =?utf-8?B?a0Z1Y1RwbUhhUnY4eGoyQ0poTEZkRHBEVmE3RXZ1dEJKSEppU2dhYWIrampF?=
 =?utf-8?B?Vk9xNGRmNzBBZFhMaVUwU1BnSE96MjdoZUFtREFqbHpkTGxoUVpXcDRzWnhR?=
 =?utf-8?B?RGlqQ0pnT21HaWFjRW85OVRiWldIUGRjdVVRUUVmVm1nQ0hjNHoyeXdhQUZo?=
 =?utf-8?B?YStFdUlJcFB2TDVNQXZWWkVnVnZlMi9WTkJidmdjbHdtRlFzWit4UjNTWW9E?=
 =?utf-8?B?aWN0dllEUzhQeWMrZkozVmdQWk0yVHl6OEFMVk5FR1d6OGZxa1gyQmN6bVh1?=
 =?utf-8?B?eU14d2NscUZYRkpOUENpWVNrTC90ZGpMUWM2NlJlajV5VS90YzRNNHg2ODV6?=
 =?utf-8?B?eTIxMHUrcUxRcEdFNnZSZzRYOFlHQ0s2aUFWbUw0RlR6TnNuSEdMR0tYVnhz?=
 =?utf-8?B?YUVsMDZVVUMwSXJVVE0xSitFQ0J2eVRUNnljcHNRNVUvSkQxc2k3ZXFidUdF?=
 =?utf-8?B?WVVDS2NjRk14dzJPcjVYblViQzlPT1h0NHpJNHMxdWIwNEVhNkx6V01UckhC?=
 =?utf-8?B?UlVLNW4yRWpoZndzOFFDS21mQ09FbXpNM2I4bnBzYk52VUcxTnVDR3J5THJO?=
 =?utf-8?B?T09QTGlnY3k5bnM3NERoQWZkWWVwbzJzVjRxcWtxd3k4aE5SbmorTEdTWVNY?=
 =?utf-8?B?SFBSMmFiQnNnUm9OMmJkbm1hOU5zMGd0Q0xjdEF1VStISDVyanZLZ25yVTNm?=
 =?utf-8?B?blNNR2lrL3RZWmhJeHNzRFFSejZKMXRpRWJ2bHU3T3J1Q2MvWWJHM2NWcGlI?=
 =?utf-8?B?VGlxYVE2TkNBRXVsem9RS2gvRDJwd1lnZERGbVFrRDVwdGpENXJoNEo3OGZB?=
 =?utf-8?B?NFRuVFdKcG55aktQRmZlcHNkclkvVTZiMlFHckZheTB1K0p2dXgrVzBYY1VC?=
 =?utf-8?B?TXM5U1BpSVBHaC9FbFF4L1IzNGdLQjlYR3dJZHlpUFJsWlBybndGbUhoU201?=
 =?utf-8?B?c2U0R3dZQ29JOEFidzk5dzJKeXdGT3VrK1B1dm8rL2ZjS05QN2ROMmZzREFT?=
 =?utf-8?B?clJ2TytOUkMyNGZGNURrOFNnMHJMTTFNbWFGM0ZPTXBjS2kvWXk3NjBLWFlP?=
 =?utf-8?B?OE9KWVFjVzFObEg2YTJQT2xXelBHaFlmdkFZY25ZQ1JQNjNJMXdNNTlWYnRw?=
 =?utf-8?B?V01xMXk1UTBmSzh3cnQxZ1VKdmQxNzl1bkRUSjZwbFgwcHBaa0wvdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8b5290-8afe-413a-7f9c-08def87a208e
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:00:55.1683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElwgPdv5pg29Tj/vNe4afirhaZKprm/8WcOtsek6XMnUVj1hKV7XvsE2Dx5YBDA/GJG3xqJgkJhagNxMmkvuxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7866
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

On Wed Aug 12, 2026 at 1:06 PM BST, Vladislav Zaharov wrote:
> sashiko-bot@kernel.org wrote:
>> Does this code need a memory barrier (such as dma_rmb()) between reading
>> the 'put' pointer and copying the buffer contents?
>
> Not in the path this code is written for. snapshot() is called from the
> drop path of the log buffers, which is only reached after PinnedDrop for
> GspResources has run the GSP unload sequence, so the GSP is no longer
> writing to these buffers and there is nothing to order against.
>
> The one case where that does not hold is a Gsp::boot() that fails by
> timing out: the GSP may then still be alive and appending while the
> buffers are dropped. The copy is best-effort there - it cannot be made
> atomic either way - but reading a non-zero 'put' and then reading
> contents that predate it is indeed the pattern dma_rmb() exists for.
>
> I am happy to add it, but there is no dma_rmb() abstraction in
> rust/kernel at the moment: sync/barrier.rs only provides the smp_*
> family, and smp_rmb() is not a correct substitute, as on arm64 it uses
> the inner shareable domain rather than the outer shareable one that
> dma_rmb() needs.

See
https://lore.kernel.org/rust-for-linux/20260609-rust-barrier-v2-0-30fcc48e1=
cd0@garyguo.net/

The abstraction part is being upstreamed via tip tree, so they're not curre=
ntly
present in drm-rust.next. It'll be there when the next backmerge happens.

>
> Would you prefer a small prerequisite patch adding dma_rmb() to
> rust/kernel, or is relying on the unload ordering acceptable, with the
> requirement spelled out in a comment on snapshot()?

Sashiko is a patch review bot so you won't get any response by asking it --
although I suppose this message is written by a LLM too.

Best,
Gary
