Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4609C88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 17:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD9810E032;
	Sat, 12 Sep 2026 17:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="eK0+JV28";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022135.outbound.protection.outlook.com [52.101.101.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 314AE10E032
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 17:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQodm+L+D7p/bIvhsWOlrLXffDchEGI2nfNwWQjACiO4OajdwB00FGb32+XaWdv0ai0nJfpc9HHb6lZFnAgBomldIad8gEEXtlJO43eoSN9qCm/pwGzTqiDwLOIO2BgKHkjkoBzrK20o6v2zEca5unCawSHGrMbuJhZ0Qf/BucidNXC4LfLBLNwboeHoIlgwQi290yCMNOZVRX3zbjR6HfMxOskQMAQZGkxt/5FqtNtDS99pgCJJ8Qvimbrv8s5TO8B9L69x1kMmKqOmANyVzm7KK0zETOOmTIDTH0oggsFT3KHBy3TgLZad6zq8sZ+nraQDolQKjxA8kcYHETKEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc04RWX5vYN3N7w1FwaKzLvfAOFHyGBQ5E3srbnicdg=;
 b=OoTqLEYkyVB8n5ikG0Ac4c5pRtCL7CwFIHYAwQrnrxXAXGQWJot35pA+jKs1fpmB40htW3ck0GuImXblcXuz//6IJxYHDKVsiSUdUR24t6wlPjowCaa7c57w0E4EIgP4x6P/cfCMX3v2UaQJV6VdBtOSmtXkJnE/oPBfgWQUYcykeXF12PY3XjymUPCFlZX8ULjHy/2En2rMlTCsaeoRGuN8CwGdK2yuxMG9qwO6eSuLO7ac9woNO4PvwaFtc60H8prZQHvtx61fWOs/ltncYWMZdWLZYLenPn4Qt/fHasd+pHFXwvEyaL2doAAamzLI76a1KSTVJmCItQyKKv6aBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc04RWX5vYN3N7w1FwaKzLvfAOFHyGBQ5E3srbnicdg=;
 b=eK0+JV28K9VLRuTZ8qzbBzyDoiu97C2KNhhB71lCbKeyoCvvuPmAY2LnHiV51PR2z00Zi44VV8vIzjfTN2z+qgG7FQfS4PknVvNo7SXmN05i0bZDpQ1ERxnenD2wF2vDfMksVcaIz4vfl+qVefbEAsrOj3wdb1bQbGtWtGS94xE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB2309.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:78::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 17:55:34 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 17:55:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 18:55:32 +0100
Message-Id: <DLDJ4S0AJ5X3.HW1TYFLP4PXT@garyguo.net>
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>, <dakr@kernel.org>,
 <jhubbard@nvidia.com>
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>, <ttabi@nvidia.com>,
 <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] gpu: nova-core: gsp: retain the GSP-RM log
 buffers after unbind
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260912071842.622696-1-vladazaharova2018@gmail.com>
 <20260912071842.622696-3-vladazaharova2018@gmail.com>
In-Reply-To: <20260912071842.622696-3-vladazaharova2018@gmail.com>
X-ClientProxiedBy: OS6P279CA0039.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:32::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB2309:EE_
X-MS-Office365-Filtering-Correlation-Id: 31816ee9-1686-42c1-713a-08df10f70b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|10070799003|3023799007|6133799003|56012099006|5023799004|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: tPEtatsyG4UWlXUFfaokC/7nQB7AcVrObFcISCOOcwyebBbkJ7zrxBNiEk0eyiKmZKlVuHPyeF5HAS2dlfsaP1FUbxAkZ289uGA0PopScw1fGpAF7CBmbtcGl57xmmC7GRd6KKyxPs1q7tBNGx+P2Ckz2pzvX2r0yFdjcHNawd6v9AIJtmfJ3Er8f1wInuh17iLSONohNNz8vHcJs6AAJRmcUOj4xPLlnzCNxuqaAdjdW0itin03mU3yFooVpxE92yOzzpNDqYwCNSuAxC/K4ZVC08rUgkLSyNmYiOOVXDMBmAFRwPZtFg0Z1pVkry/n4k0CbAYqgkgCVGEG/8F81yDZFr8CWvGl3eRnsFd3eN1wYDbuGoNdaq9i46eKyricbqP/AVsLb9AE1wg4A7/6YpYS3UDCtQaIN1npPOHzSJ6RJ4rpOqlQH6s1vgRu2g7quoeDunPQVnXo21C8U7rq3yTK2AewVLuIHUQwD7SKkakEK4fUJptEZJY7CsLXI313vySaD+IVap3wkpdNE+hKrgAqLKjfN1LT45+563rqvwl8egxx8LQyLr1vNcGTuvhABoSlep8HVW0RfpEzzme2IRyhlGjNE0T7MsLOhm8CPkyBZqOfgYWXhy5JDpNwlFObBFV+ZsnL+RCRuT6/HLqDXUKmIysHUenzkAqHOavFgUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10070799003)(3023799007)(6133799003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZ5dElwRWJtcHFkSHRmWlprbWdNSTJsUUdOWWQrMmMrYm5keWNIL3RabEUz?=
 =?utf-8?B?SU5iaVpYZzZKNnJkQUEzbFpEZU9uL1NNR3lBTS9heGhKVGhpU3NkYWlOTTlG?=
 =?utf-8?B?eDBBVVdOak1acmZYeDBEQ2tWalBnWU10Mzd5bUFMZEZBS0xBWU5XbEg5a1Q4?=
 =?utf-8?B?VUdGZ3FOYm4xMy84bjZyYU82aWRTb3FseFN6NHJYbld2QUowWUYzNGxwNEUx?=
 =?utf-8?B?MXVHN2hQRlBhSjZsc2crN3VFekh1c05hLzB4Q01nTktNWUVtaFVub1BreGJ0?=
 =?utf-8?B?ald4eC9hWjYxaytHL0Z1WTZTYXllOXpPN0F3Y0RzUE83aGRmdTFqQlMvM2dZ?=
 =?utf-8?B?Q1N5akdlUTR0YzVZMTFnRnlVcHVMZGpkSC9qeFl3cXkzQlIvUzRUR3dLSHpC?=
 =?utf-8?B?V1ppWDZmVGhRLy8xR1Fyb1ZYZVJEQW1zRkUzSkxMR3c3OU1NOHlQa2plZXVQ?=
 =?utf-8?B?OFc0ZW5LYURnVURBblUxNSs5cFlPdjU4SmtDOEFaTEJEV3J1NXF0SWNqRS82?=
 =?utf-8?B?bFFod0NNNnBLUWFxelgzWllROTgza3JRSjJMN3Zodk1mVDdKZDJXbVRUSWdi?=
 =?utf-8?B?SlkrU3pQTlhvbTg5Skdzazllc3FrN01xcVhyR3BNajltcXY3L2FSRHBZVVBT?=
 =?utf-8?B?N0FkNTdtOThTdVJZOFRBUFpRaERJaC9lWmdyV3VlbWdPNjB1cWd3bWhEd0la?=
 =?utf-8?B?aUwxS2l6UnJCV1hSS0hyWjVyMHJQdkxvZUp0SjRZaXp0eEpndHh0VXlUbEM0?=
 =?utf-8?B?NzR2ZnEzeXArcjZYZStZWUJJajYrNjkxUVNMN04wZ0lDV2RvY0cwSE9SYW1K?=
 =?utf-8?B?QjFXWlR5bm0rWHNISnRIN25SV1lJNm5VSHFGMkJCUjkzc2VDTGVoT3FrZWVv?=
 =?utf-8?B?c2Zid0RWUXdwKzNrUEtYcFEyWU9Mb25ydHB1akhhNE82UXViaFZ2cGtwZWpr?=
 =?utf-8?B?Y1JMM2w1NmEzVEwwcFdlUzNIL29sYTZhM242bVlHWmZVK0YzSGE5YlhocVJn?=
 =?utf-8?B?Y0RJOTNDOXRNbVhyV3EydmwwQzRycDJDOXlrYkJ1cEF0WVplS2JhRHpUaFE1?=
 =?utf-8?B?WUZRc3FWcWE2QmV6NlFaZWRpeCtLM241MGUwZkpwU3BqdnMwR2QyVEtqMUxm?=
 =?utf-8?B?aXhlTVlpVExCb2d0VDNSTGpMTDlvTU15Ri8yOFBOK2Q4YUlrNGRqNGhPcG8z?=
 =?utf-8?B?OTNqb1RYYXVOVDNwRTBLYy9NMWdvdzkxZkxmWFdCdEtXajVtWnRDOEI4dlZK?=
 =?utf-8?B?M1ZmWjQzbWcxdFgvSmlMd2gzTWxYd1NUVkdzOE5nZGVpNEJMeTE1MjZHNFpC?=
 =?utf-8?B?RU5CTFNwN3pvbDErQWQxMVRaWC9YeWVpWW9pTERJRm5oZjZiMUY3TEFHVVg1?=
 =?utf-8?B?OG03RXMwMm5iT3dXdXJmbEtjVVZoWnBjSEo3S2djaFZEZnVsNHIwZHRyeXNk?=
 =?utf-8?B?azdJbGFjTEpOM00raWQ1TGpwdG5Zdm5QU1lFRGhPZjArVUltbXZVM3lUMDVR?=
 =?utf-8?B?SmVHWW1BdzFQQlhaL0I2UkZBUHk2SmE3cTg3N3VjWjR6UHJoUTVWVEx6akJE?=
 =?utf-8?B?d0RDN2srbmlJRmNGTXRZVVRJdkJOV3RSZ1c0NVU4KzlpZTNFV1hZaHh2cy9W?=
 =?utf-8?B?anNRVGlTbElacjhSM25CSUtxN3VHRkhIbzdDcUZQZkwvU0crdHIwMjhoS0ZF?=
 =?utf-8?B?ZHZvY2NmMDl5dUdKN0kyQlJ2cW9lR01mQXlHMzBqTEZBVFo5Q21PRERLdHpC?=
 =?utf-8?B?Uy9tanNNekxReTduRmdTVDYrRmFlUWM1R2tKV1FqcmxuaG1Td2ZtMzRjSnE5?=
 =?utf-8?B?SDIyNTRHWUNYY0J0WlVZb3U3U3VRMnE4YjQyS2xhRGFWdTVHZ0Y3eWEzT2VN?=
 =?utf-8?B?Z3JKeUlMaitrb29IaUl1bUl4b05HaTFtaGRNbE05VnFISXJsd2VaVUthS2pK?=
 =?utf-8?B?aSswanUveEMxb29XcG5RVGtqRElZdmdyeG9hU3VMN0hxdXFCQjFESDV2ODQ2?=
 =?utf-8?B?eFI3R1hPdmNaT1RuYmI3ZU9mN2llangxZUlQalR2WWJIY1hvTVRJMWUrdmxM?=
 =?utf-8?B?WDVONDJGS0Z0Y0l0R1k1MHkwUnJ6MGFpQlRoSzJRa0tPbkd1ZnVQQ3lDTDBl?=
 =?utf-8?B?V0VLT3h2aHlOS3pkbW0zNEZ3QmJtbG91SXJWNHdxTWYzd3lGNG45U0NsRm92?=
 =?utf-8?B?SGY3QjU3OEMyVitncTF3MGszeEJMRVlzYmdxWjk4dlFIYnNVakFwZlNqcEp2?=
 =?utf-8?B?SFRBd3JQOWZ6T3pOSk5UTUwwVFl2UGVjb3ArSVdrSGRrNGtiL1h5NnhWSWZr?=
 =?utf-8?B?czFVLzd2alg3OUZIcHcxV2hMT1BLMVZxSzdtdmF6K2dKMXdpcENpdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 31816ee9-1686-42c1-713a-08df10f70b0b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 17:55:33.9450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhhlURRXH7i1FSPbd9OjeJVFohxdTLjQLcrZAyJe3OmlL74bFGcAKnNLU1OLzvqwwlpbMDMuNjv4G/Px3gJMxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2309
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

On Sat Sep 12, 2026 at 8:18 AM BST, Vladislav Zaharov wrote:
> The GSP-RM log buffers are exposed through debugfs, but the Scope that
> owns them lives in Gsp, inside GspResources, inside the Gpu built by
> probe(). They are DMA allocations of the device and cannot outlive it,
> so the entries go away as soon as the GPU is unbound - and, more to the
> point, as soon as probe() fails, which is exactly when the log of a GSP
> that did not come up is the thing one wants to read.
>
> Add a gsp_keep_logs module parameter. When it is set, dropping the log
> buffers copies whatever the GSP wrote into memory owned by the module
> and exposes the copies until the module is unloaded. A buffer whose
> "put" pointer is still zero was never written to and is skipped.
>
> The GSP has normally been stopped by the time the buffers are dropped,
> but a boot that timed out can leave it still appending, so a DMA read
> barrier orders the read of the "put" pointer before the copy.
>
> The copies live in a "retained" directory, created during module init
> rather than on first use, which keeps the teardown path from having to
> reach for DEBUGFS_ROOT. Keeping them out of the directory used by bound
> GPUs also means a device coming back does not find its debugfs name
> taken by its own history; nouveau, which recreates the entries under the
> name of the GPU that just went away, has that problem.
>
> While at it, move the log buffer code out of gsp.rs into gsp/logbuffer.rs=
.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
> ---
>  drivers/gpu/nova-core/gsp.rs           | 100 ++-------
>  drivers/gpu/nova-core/gsp/logbuffer.rs | 267 +++++++++++++++++++++++++
>  drivers/gpu/nova-core/nova_core.rs     |  32 ++-
>  3 files changed, 315 insertions(+), 84 deletions(-)
>  create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs
>
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index 25ea43f1cbe9..1a1eb7f37075 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -12,11 +12,7 @@
>          CoherentView,
>          DmaAddress, //
>      },
> -    io::{
> -        io_project,
> -        io_write,
> -        Io, //
> -    },
> +    io::io_write,
>      pci,
>      prelude::*, //
>  };
> @@ -24,9 +20,13 @@
>  pub(crate) mod cmdq;
>  pub(crate) mod commands;
>  mod fw;
> +mod logbuffer;
>  mod regs;
>  mod sequencer;
> =20
> +use logbuffer::LogBuffers;
> +pub(crate) use logbuffer::RetainedLogs;
> +
>  pub(crate) use fw::{
>      GspFmcBootParams,
>      GspFwWprMeta,
> @@ -77,10 +77,6 @@ pub(crate) fn dev(&self) -> &'gpu device::Device<devic=
e::Bound> {
>      }
>  }
> =20
> -/// Number of GSP pages to use in a RM log buffer.
> -const RM_LOG_BUFFER_NUM_PAGES: usize =3D 0x10;
> -const LOG_BUFFER_SIZE: usize =3D RM_LOG_BUFFER_NUM_PAGES * GSP_PAGE_SIZE=
;
> -
>  /// Array of page table entries, as understood by the GSP bootloader.
>  #[repr(C)]
>  #[derive(FromBytes, IntoBytes)]
> @@ -101,49 +97,6 @@ fn init(view: CoherentView<'_, Self>, start: DmaAddre=
ss) -> Result<()> {
>      }
>  }
> =20
> -/// The logging buffers are byte queues that contain encoded printf-like
> -/// messages from GSP-RM.  They need to be decoded by a special applicat=
ion
> -/// that can parse the buffers.
> -///
> -/// The 'loginit' buffer contains logs from early GSP-RM init and
> -/// exception dumps.  The 'logrm' buffer contains the subsequent logs. B=
oth are
> -/// written to directly by GSP-RM and can be any multiple of GSP_PAGE_SI=
ZE.
> -///
> -/// The physical address map for the log buffer is stored in the buffer
> -/// itself, starting with offset 1. Offset 0 contains the "put" pointer =
(pp).
> -/// Initially, pp is equal to 0. If the buffer has valid logging data in=
 it,
> -/// then pp points to index into the buffer where the next logging entry=
 will
> -/// be written. Therefore, the logging data is valid if:
> -///   1 <=3D pp < sizeof(buffer)/sizeof(u64)
> -struct LogBuffer<'a>(Coherent<'a, [u8; LOG_BUFFER_SIZE]>);
> -
> -impl<'a> LogBuffer<'a> {
> -    /// Creates a new `LogBuffer` mapped on `dev`.
> -    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
> -        let obj =3D Self(Coherent::zeroed(dev, GFP_KERNEL)?);
> -
> -        let start_addr =3D obj.0.dma_address();
> -
> -        let pte_view =3D io_project!(
> -            obj.0,
> -            [build: size_of::<u64>()..][build: ..RM_LOG_BUFFER_NUM_PAGES=
 * size_of::<u64>()]
> -        )
> -        .try_cast::<PteArray<RM_LOG_BUFFER_NUM_PAGES>>()?;
> -        PteArray::init(pte_view, start_addr)?;
> -
> -        Ok(obj)
> -    }
> -}
> -
> -struct LogBuffers<'a> {
> -    /// Init log buffer.
> -    loginit: LogBuffer<'a>,
> -    /// Interrupts log buffer.
> -    logintr: LogBuffer<'a>,
> -    /// RM log buffer.
> -    logrm: LogBuffer<'a>,
> -}
> -
>  /// GSP runtime data.
>  #[pin_data]
>  pub(crate) struct Gsp<'gsp> {
> @@ -165,9 +118,7 @@ pub(crate) fn new(pdev: &'gsp pci::Device<device::Bou=
nd>) -> impl PinInit<Self,
>          pin_init::pin_init_scope(move || {
>              let dev =3D pdev.as_ref();
> =20
> -            let loginit =3D LogBuffer::new(dev)?;
> -            let logintr =3D LogBuffer::new(dev)?;
> -            let logrm =3D LogBuffer::new(dev)?;
> +            let log_buffers =3D LogBuffers::new(dev)?;
> =20
>              // Initialise the logging structures. The OpenRM equivalents=
 are in:
>              // _kgspInitLibosLoggingStructures (allocates memory for buf=
fers)
> @@ -182,36 +133,23 @@ pub(crate) fn new(pdev: &'gsp pci::Device<device::B=
ound>) -> impl PinInit<Self,
>                          GFP_KERNEL,
>                      )?;
> =20
> -                    libos.init_at(0, LibosMemoryRegionInitArgument::new(=
"LOGINIT", &loginit.0))?;
> -                    libos.init_at(1, LibosMemoryRegionInitArgument::new(=
"LOGINTR", &logintr.0))?;
> -                    libos.init_at(2, LibosMemoryRegionInitArgument::new(=
"LOGRM", &logrm.0))?;
> +                    libos.init_at(
> +                        0,
> +                        LibosMemoryRegionInitArgument::new("LOGINIT", &l=
og_buffers.loginit.0),
> +                    )?;
> +                    libos.init_at(
> +                        1,
> +                        LibosMemoryRegionInitArgument::new("LOGINTR", &l=
og_buffers.logintr.0),
> +                    )?;
> +                    libos.init_at(
> +                        2,
> +                        LibosMemoryRegionInitArgument::new("LOGRM", &log=
_buffers.logrm.0),
> +                    )?;
>                      libos.init_at(3, LibosMemoryRegionInitArgument::new(=
"RMARGS", rmargs))?;
> =20
>                      libos.into()
>                  },
> -                logs <- {
> -                    let log_buffers =3D LogBuffers {
> -                        loginit,
> -                        logintr,
> -                        logrm,
> -                    };
> -
> -                    #[allow(static_mut_refs)]
> -                    // SAFETY: `DEBUGFS_ROOT` is created before driver r=
egistration and cleared
> -                    // after driver unregistration, so no probe() can ra=
ce with its modification.
> -                    //
> -                    // PANIC: `DEBUGFS_ROOT` cannot be `None` here.  It =
is set before driver
> -                    // registration and cleared after driver unregistrat=
ion, so it is always
> -                    // `Some` for the entire lifetime that probe() can b=
e called.
> -                    let log_parent: &debugfs::Dir =3D unsafe { crate::DE=
BUGFS_ROOT.as_ref() }
> -                        .expect("DEBUGFS_ROOT not initialized");
> -
> -                    log_parent.scope(log_buffers, dev.name(), |logs, dir=
| {
> -                        dir.read_binary_file(c"loginit", &logs.loginit.0=
);
> -                        dir.read_binary_file(c"logintr", &logs.logintr.0=
);
> -                        dir.read_binary_file(c"logrm", &logs.logrm.0);
> -                    })
> -                },
> +                logs <- log_buffers.scope(),
>              }))
>          })
>      }
> diff --git a/drivers/gpu/nova-core/gsp/logbuffer.rs b/drivers/gpu/nova-co=
re/gsp/logbuffer.rs
> new file mode 100644
> index 000000000000..22c47f199169
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/logbuffer.rs
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! GSP-RM log buffers, and the debugfs entries exposing them.
> +
> +use core::convert::Infallible;
> +
> +use kernel::{
> +    debugfs,
> +    device,
> +    dma::Coherent,
> +    io::{
> +        io_project,
> +        Io, //
> +    },
> +    prelude::*,
> +    sync::{
> +        aref::ARef,
> +        barrier::{
> +            dma_mb,
> +            Read, //
> +        }, //
> +    }, //
> +};
> +
> +use crate::gsp::{
> +    PteArray,
> +    GSP_PAGE_SIZE, //
> +};
> +
> +/// Number of GSP pages to use in a RM log buffer.
> +const RM_LOG_BUFFER_NUM_PAGES: usize =3D 0x10;
> +const LOG_BUFFER_SIZE: usize =3D RM_LOG_BUFFER_NUM_PAGES * GSP_PAGE_SIZE=
;
> +
> +/// The logging buffers are byte queues that contain encoded printf-like
> +/// messages from GSP-RM.  They need to be decoded by a special applicat=
ion
> +/// that can parse the buffers.
> +///
> +/// The 'loginit' buffer contains logs from early GSP-RM init and
> +/// exception dumps.  The 'logrm' buffer contains the subsequent logs. B=
oth are
> +/// written to directly by GSP-RM and can be any multiple of GSP_PAGE_SI=
ZE.
> +///
> +/// The physical address map for the log buffer is stored in the buffer
> +/// itself, starting with offset 1. Offset 0 contains the "put" pointer =
(pp).
> +/// Initially, pp is equal to 0. If the buffer has valid logging data in=
 it,
> +/// then pp points to index into the buffer where the next logging entry=
 will
> +/// be written. Therefore, the logging data is valid if:
> +///   1 <=3D pp < sizeof(buffer)/sizeof(u64)
> +pub(super) struct LogBuffer<'a>(pub(super) Coherent<'a, [u8; LOG_BUFFER_=
SIZE]>);
> +
> +impl<'a> LogBuffer<'a> {
> +    /// Creates a new `LogBuffer` mapped on `dev`.
> +    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
> +        let obj =3D Self(Coherent::zeroed(dev, GFP_KERNEL)?);
> +
> +        let start_addr =3D obj.0.dma_address();
> +
> +        let pte_view =3D io_project!(
> +            obj.0,
> +            [build: size_of::<u64>()..][build: ..RM_LOG_BUFFER_NUM_PAGES=
 * size_of::<u64>()]
> +        )
> +        .try_cast::<PteArray<RM_LOG_BUFFER_NUM_PAGES>>()?;
> +        PteArray::init(pte_view, start_addr)?;
> +
> +        Ok(obj)
> +    }
> +
> +    /// Copies the contents of this buffer into memory that does not bel=
ong to the device.
> +    ///
> +    /// A buffer the GSP never wrote to yields an empty vector, as it ho=
lds nothing worth keeping.
> +    fn snapshot(&self) -> Result<VVec<u8>> {
> +        // Offset 0 holds the "put" pointer, which the GSP advances as i=
t appends entries. It is
> +        // still zero if nothing was ever logged, which is all that is t=
ested here: a buffer that
> +        // was written to is copied whole, and making sense of "put" is =
left to the decoder.
> +        let put =3D io_project!(self.0, [build: ..size_of::<u64>()]).try=
_cast::<u64>()?;
> +        if put.read_val() =3D=3D 0 {
> +            return Ok(VVec::new());
> +        }
> +
> +        // ORDERING: LOAD->LOAD ordering needed to order the "put" read =
before the data read. The
> +        // GSP has normally been stopped by the time this runs, but a bo=
ot that timed out can leave
> +        // it still appending.
> +        dma_mb(Read);
> +
> +        let mut snapshot =3D VVec::zeroed(LOG_BUFFER_SIZE, GFP_KERNEL)?;
> +        io_project!(self.0, [build: ..]).copy_to_slice(&mut snapshot);
> +
> +        Ok(snapshot)
> +    }
> +}
> +
> +/// The log buffers of a GPU, for as long as it is bound to the driver.
> +pub(super) struct LogBuffers<'a> {
> +    /// Device the buffers belong to. Also names their debugfs directory=
.
> +    dev: &'a device::Device<device::Bound>,
> +    /// Init log buffer.
> +    pub(super) loginit: LogBuffer<'a>,
> +    /// Interrupts log buffer.
> +    pub(super) logintr: LogBuffer<'a>,
> +    /// RM log buffer.
> +    pub(super) logrm: LogBuffer<'a>,
> +}
> +
> +impl<'a> LogBuffers<'a> {
> +    /// Allocates the three log buffers of `dev`.
> +    pub(super) fn new(dev: &'a device::Device<device::Bound>) -> Result<=
Self> {
> +        Ok(Self {
> +            dev,
> +            loginit: LogBuffer::new(dev)?,
> +            logintr: LogBuffer::new(dev)?,
> +            logrm: LogBuffer::new(dev)?,
> +        })
> +    }
> +
> +    /// Creates an initializer exposing these buffers under a directory =
named after their device.
> +    pub(super) fn scope(self) -> impl PinInit<debugfs::Scope<Self>, Infa=
llible> + 'a {
> +        let dev =3D self.dev;
> +
> +        #[allow(static_mut_refs)]
> +        // SAFETY: `DEBUGFS_ROOT` is created before driver registration =
and cleared
> +        // after driver unregistration, so no probe() can race with its =
modification.
> +        //
> +        // PANIC: `DEBUGFS_ROOT` cannot be `None` here.  It is set befor=
e driver
> +        // registration and cleared after driver unregistration, so it i=
s always
> +        // `Some` for the entire lifetime that probe() can be called.
> +        let log_parent: &debugfs::Dir =3D
> +            unsafe { crate::DEBUGFS_ROOT.as_ref() }.expect("DEBUGFS_ROOT=
 not initialized");
> +
> +        log_parent.scope(self, dev.name(), |logs, dir| {
> +            dir.read_binary_file(c"loginit", &logs.loginit.0);
> +            dir.read_binary_file(c"logintr", &logs.logintr.0);
> +            dir.read_binary_file(c"logrm", &logs.logrm.0);
> +        })
> +    }
> +
> +    /// Preserves whatever the GSP logged, so it can still be read once =
the GPU is gone.
> +    ///
> +    /// The buffers are DMA allocations of the device and cannot outlive=
 it, so their contents are
> +    /// copied into memory owned by the module and exposed through fresh=
 debugfs entries. Those
> +    /// live until the module is unloaded.
> +    ///
> +    /// Does nothing if `gsp_keep_logs` was not set when the module was =
loaded, as there is then
> +    /// no directory to put the copies in.
> +    fn retain(&self) -> Result {
> +        // Copying is only worth it if there is somewhere to put the res=
ult, but the lock is
> +        // dropped right away: what follows allocates 64 KiB three times=
, and no other device
> +        // should have to wait for that.
> +        if !crate::RETAINED_LOGS.lock().is_enabled() {
> +            return Ok(());
> +        }
> +
> +        let logs =3D RetainedLogBuffers {
> +            dev: self.dev.into(),
> +            loginit: self.loginit.snapshot()?,
> +            logintr: self.logintr.snapshot()?,
> +            logrm: self.logrm.snapshot()?,
> +        };
> +
> +        // Nothing was ever logged, so there is nothing to keep. A copy =
from an earlier run of
> +        // this device is deliberately left alone: logs from a run that =
failed are worth more
> +        // than the silence of one that did not.
> +        if logs.loginit.is_empty() && logs.logintr.is_empty() && logs.lo=
grm.is_empty() {
> +            return Ok(());
> +        }
> +
> +        // Take every allocation that can fail before the previous copy =
of this device is
> +        // dropped, so that running out of memory here cannot leave it w=
ith no logs at all.
> +        let scope =3D KBox::<debugfs::Scope<RetainedLogBuffers>>::new_un=
init(GFP_KERNEL)?;
> +
> +        let mut retained =3D crate::RETAINED_LOGS.lock();
> +
> +        // The module may have been unloaded out from under us while the=
 copies were taken.
> +        let Some(dir) =3D retained.dir.clone() else {
> +            return Ok(());
> +        };
> +
> +        retained.gpus.reserve(1, GFP_KERNEL)?;
> +
> +        // An earlier run of the same device may have left a copy behind=
, and its directory
> +        // carries the name about to be used again, so it has to go firs=
t. Nothing below can
> +        // fail, so the replacement is guaranteed to take its place.
> +        retained
> +            .gpus
> +            .retain(|gpu| gpu.dev.name() !=3D self.dev.name());
> +
> +        let scope =3D scope.write_pin_init(dir.scope(logs, self.dev.name=
(), |logs, dir| {
> +            if !logs.loginit.is_empty() {
> +                dir.read_binary_file(c"loginit", &logs.loginit);
> +            }
> +            if !logs.logintr.is_empty() {
> +                dir.read_binary_file(c"logintr", &logs.logintr);
> +            }
> +            if !logs.logrm.is_empty() {
> +                dir.read_binary_file(c"logrm", &logs.logrm);
> +            }
> +        }))?;
> +
> +        retained.gpus.push(scope, GFP_KERNEL)?;
> +
> +        dev_dbg!(self.dev, "GSP-RM log buffers retained\n");
> +
> +        Ok(())
> +    }
> +}
> +
> +impl Drop for LogBuffers<'_> {
> +    fn drop(&mut self) {
> +        if let Err(e) =3D self.retain() {
> +            dev_warn!(self.dev, "failed to retain GSP-RM log buffers: {:=
?}\n", e);
> +        }
> +    }
> +}
> +
> +/// Copies of the log buffers of a GPU that is no longer around.
> +struct RetainedLogBuffers {
> +    /// Device the buffers came from.
> +    dev: ARef<device::Device>,
> +    /// Contents of the init log buffer, empty if it was never written t=
o.
> +    loginit: VVec<u8>,
> +    /// Contents of the interrupts log buffer, empty if it was never wri=
tten to.
> +    logintr: VVec<u8>,
> +    /// Contents of the RM log buffer, empty if it was never written to.
> +    logrm: VVec<u8>,
> +}
> +
> +/// Log buffers of GPUs that are gone, and the debugfs entries exposing =
them.
> +///
> +/// The copies live under a `retained` directory of their own instead of=
 next to the entries of
> +/// the GPUs that are actually bound, so that a device coming back does =
not find its name taken.
> +pub(crate) struct RetainedLogs {
> +    /// Parent directory of all copies. `None` unless retaining was aske=
d for.
> +    dir: Option<debugfs::Dir>,
> +    /// One entry per GPU.
> +    gpus: KVec<Pin<KBox<debugfs::Scope<RetainedLogBuffers>>>>,
> +}
> +
> +impl RetainedLogs {
> +    /// Creates an empty set of retained log buffers, retaining disabled=
.
> +    pub(crate) const fn new() -> Self {
> +        Self {
> +            dir: None,
> +            gpus: KVec::new(),
> +        }
> +    }
> +
> +    /// Creates the directory the copies will live in, enabling retainin=
g.
> +    ///
> +    /// Does nothing without `CONFIG_DEBUG_FS`, where a [`debugfs::Dir`]=
 is a zero-sized type and
> +    /// the copies could never be read back.
> +    pub(crate) fn enable(&mut self, parent: &debugfs::Dir) {
> +        if !cfg!(CONFIG_DEBUG_FS) {
> +            return;
> +        }
> +
> +        self.dir =3D Some(parent.subdir(c"retained"));
> +    }
> +
> +    /// Returns whether copies are being kept.
> +    pub(crate) fn is_enabled(&self) -> bool {
> +        self.dir.is_some()
> +    }
> +
> +    /// Releases every copy and the directory holding them.
> +    pub(crate) fn clear(&mut self) {
> +        self.gpus.clear();
> +        self.dir =3D None;
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/n=
ova_core.rs
> index 11fe1d2858a9..557cc611f3fc 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -33,11 +33,21 @@
>  // TODO: Move this into per-module data once that exists.
>  static mut DEBUGFS_ROOT: Option<debugfs::Dir> =3D None;
> =20
> +kernel::sync::global_lock! {
> +    /// Log buffers of GPUs that are gone, kept around until the module =
is unloaded.
> +    // TODO: Move this into per-module data once that exists.
> +    unsafe(uninit) static RETAINED_LOGS: Mutex<gsp::RetainedLogs> =3D gs=
p::RetainedLogs::new();

One global is already too many, we don't need more.

Consider instead to put everything that needs to be shared between multiple
devices in a single struct, and smuggle the pointer to it via a single glob=
al
`static mut` in place of today's `DEBUGFS_ROOT`. Then we just need unsafe i=
n one
place.

Something like:

    static mut DEBUGFS_DATA: Option<&'static DebugfsData> =3D None;

    struct DebugfsData {
        root: debugfs::Dir,
        // You can put everything here, and still have initialized during m=
odule
        // init now..
        retained_logs: ...,
    }

    struct NovaCoreModule {
        ...
        // Put this last so it's destroyed last
        debugfs_data: DebugfsData,
    }

    // Module init
    fn init(..) -> impl PinInit<Self, Error> {
        try_pin_init!(Self {
            debugfs_data <- /* construct everything here, safely */
            _: {
                DEBUGFS_DATA =3D Some(unsafe { &*core::ptr::from_ref(debugf=
s_data) });
            },
            driver <- Registration::new(MODULE_NAME, module),
        }
    }

    // Probe
    fn probe<'bound>(pdev: &'bound Device<Core<'_>>, ...) -> ... {
        // Coerce this back to `&'bound` is okay because DEBUGFS_DATA outli=
ves
        // registration and thus outlives bound device.
        let debugfs_data: &'bound _ =3D unsafe { DEBUGFS_DATA.unwrap() };
    }

Best,
Gary

> +}
> +
>  /// Guard that clears `DEBUGFS_ROOT` when dropped.
>  struct DebugfsRootGuard;
> =20
>  impl Drop for DebugfsRootGuard {
>      fn drop(&mut self) {
> +        // Retained log buffers own debugfs entries below `DEBUGFS_ROOT`=
, so they have to go away
> +        // before it does.
> +        RETAINED_LOGS.lock().clear();
> +
>          // SAFETY: This guard is dropped after `_driver` (due to field o=
rder),
>          // so the driver is unregistered and no probe() can be running.
>          unsafe { DEBUGFS_ROOT =3D None };
> @@ -58,15 +68,25 @@ impl InPlaceModule for NovaCoreModule {
>      fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, E=
rror> {
>          let dir =3D debugfs::Dir::new(c"nova-core");
> =20
> +        // SAFETY: Module initialization runs exactly once, and before t=
he driver is registered,
> +        // so no probe can have touched `RETAINED_LOGS` yet.
> +        unsafe { RETAINED_LOGS.init() };
> +
> +        // Creating the directory up front is what makes retaining possi=
ble without reaching for
> +        // `DEBUGFS_ROOT` later, from the teardown path of a device.
> +        if module_parameters::gsp_keep_logs.value() {
> +            RETAINED_LOGS.lock().enable(&dir);
> +        }
> +
>          // SAFETY: We are the only driver code running during init, so t=
here
>          // cannot be any concurrent access to `DEBUGFS_ROOT`.
>          unsafe { DEBUGFS_ROOT =3D Some(dir) };
> =20
>          // Fields are initialized in the order written here, and an init=
ializer that fails drops
>          // what it has already built, so the guard goes first: should re=
gistration fail, its drop
> -        // still takes `DEBUGFS_ROOT` down with it. Nothing would otherw=
ise, as statics are never
> -        // dropped and the module is unloaded right away, leaving a dire=
ctory behind that the
> -        // next load cannot create again.
> +        // still takes `DEBUGFS_ROOT` and the retained copies down with =
it. Nothing would
> +        // otherwise, as statics are never dropped and the module is unl=
oaded right away, leaving
> +        // directories behind that the next load cannot create again.
>          try_pin_init!(Self {
>              _debugfs_guard: DebugfsRootGuard,
>              _driver <- Registration::new(MODULE_NAME, module),
> @@ -81,6 +101,12 @@ fn init(module: &'static kernel::ThisModule) -> impl =
PinInit<Self, Error> {
>      description: "Nova Core GPU driver",
>      license: "GPL v2",
>      firmware: [],
> +    params: {
> +        gsp_keep_logs: bool {
> +            default: false,
> +            description: "Keep the GSP-RM log buffers in debugfs after t=
heir GPU is gone",
> +        },
> +    },
>  }
> =20
>  kernel::module_firmware!(firmware::ModInfoBuilder);


