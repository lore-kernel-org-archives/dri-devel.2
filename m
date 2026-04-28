Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05DDFF886F
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE82E10E05D;
	Tue, 28 Apr 2026 05:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bESroe9i";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 245BA10E05D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGH0WYo3hH0sBAAVQa/lc2WveYvaEU6HXjnUm13KPE9NrOSJY3vk3BS0bHS+kyuqX9jo5NASdaQkj5/IOOMMArXiwpjjLfUyYcH3QSSSFqNdMjM6fCAioXLPPx3g0RB6D8gZNTT+tAMC2UFswafbmB0Gg/KAKcTk/Yr+v1hePLn8ow+5mSKrJ313CPVdimPBbPI9p/o0bPdS3kDPpDnRnRM6SZWCUY/GpvVq9lqDt/2MruvPsuq0oK7iMLrT/7+sONS+2UPPorOFvb90vOg/wiI+Rm9BP04bcK0yMHIUgRvcYMazxgWx9l+9RB/KjGKK3NtvCnXLDTsfGXw0dcETbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5sTrMMAqg3LhuL1ZB2/5Fc7KKvsTt2qwwHv5AG71mQ=;
 b=gZjuLE6OQKqVK4ib555Jd1KjHICJjGiarFejy9B9MCQYx/ilqQVRqtj2MKJ7M/Zgw7h/d89xy98zO4qujZtyfOnkPmsNPW3H8pEP6Pry8FYrtBB5wAMRNo1LrUKYgRkM4aFwV1QQ149+rzof9jc1TQUzX19l6VageqVp/1gaC/IqeqjnLUE1hproIeIi8dMerHVulmrcC111Sn2uu5LnQi7TIJ7RDvNknsO7jjDmvK2sxLvhAcOsBbL2tikFS8l1Lh3j9RduBVxk7B7sz3259ayRwpTi2DnRmJjmzUczdOiNd9nt0158BymnM9acbbnY8xGAkJGy1G2lRNORjI3p/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5sTrMMAqg3LhuL1ZB2/5Fc7KKvsTt2qwwHv5AG71mQ=;
 b=bESroe9ihy+7rBhPGCHDWQT7nsMGz3YP0upxzCCAG391bSiodlwfn/H9/MVY70XkLZ5xJxwZaqYxfIiPrpkCLBBrNkeutmHwg3X7T9xbcyEHV7sUIm5e4zudMLG4z/i03kX3+4s4pSksxtypZ3F/skaRcRayxDmUiAigwI8nlb288jNPwGPMzq5HJpUjsXfioFI2aDNZHaMgpJbfoC0ypf07eo4bl4WAV/RsZBnmhEu9q3nOYAsWaeLfUjBw2ahf8NhKTFd2otA0JLwLVmmOl3tphBlpwDXyqIqZwTtEtsSsyNTuPN/szBG/y5gi3A22JXUpw4KlhCyayudSgQZ/ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 05:18:09 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 05:18:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 14:18:05 +0900
Message-Id: <DI4J877ZNGZJ.19ANMEPOHXDV8@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 5/8] gpu: nova-core: refactor SEC2 booter loading
 into BooterFirmware::run()
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
 <20260427-nova-unload-v4-5-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-5-e145ccddae66@nvidia.com>
X-ClientProxiedBy: TYCP286CA0353.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: a09b5d3f-7b11-4f29-a235-08dea4e58949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yevpNq8D/fItB237sm5+JsbK9uIXi+IMpVsLhB77AkR1S1mEiu0uPODJcMYzg1N6is8mA3n1lI7FMdrkWX8kH4Az5wB5OxjY80c6ks7DyKAY5dQdxTCHoz881U76akI5WjzOfIjkcdwRUgyHlIdT9yZ83wB4IOmr9Z8ni2dvmByA44cQX/3zusWecBCgBOkBkd5N0q0yvN/0DF4eWsqmMwxEV8txIsdHfCq8M6Viu1nKfkEjLJ+6jddIuIurTz0ydviCwI3CYSVkyMXUkEhoJofjrvkIoWXyBQ2eSnPqsVB58aZSNW/FmcDumlwlIvcSAJTv9/GZRUXDyHQq0jPfTgN1LgzG1O2tphznEr2rv+pcOQbp3Z5sTN04yb8xdVeMG7Yp6nS+9wVaKia7DyS40hTUEizDmtGPOaMQl0T5rHTqe0R8dyY3BRjV4QvxIqyQ19Pv/FjDWQcSoGYZAXrZaksJSb023x3iYp6/7S1sFdXOsrOCmRgCOu0AQz6ZxUuXB21uGnFWuBSDa4r7TIjCWyaNcJtMqlc3mhiWUmP1fTJv0iRgKKesr09us74CVrJWy2b1WSoPS+AsyYeKPHfd7rRjWtv+xCUTntxDixFma5T3G7UotWvQ9ScupmW7kZ/hUD7WSgn/77ia4cUfU+B3saZv1+zwPtBcgDnvtgHXLTUbW9ciK6wyy9tW0riJhxJ0SffbUUoXxOu3l534V0fjAt8KZLP84CgbUUWWpDb42HY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWF1cEY1YXBKTjJzTzRyNWRUcTYrTXFld3ozbldmL0dMYlZYVTIzUGVkT2lQ?=
 =?utf-8?B?a2NJd1lrRUJpcDE4Qmp4WHd5QlZjbnphbnlFdlBxY2s0MElGUWNhMDA1YjhU?=
 =?utf-8?B?RWcrbWgwVVR3b3JESHpzclRjbHBtdVhVNnNQV2JkNDJuZVVCVDNtL245ektX?=
 =?utf-8?B?SG9odk1pNkNHYUVSUGUzQ1d5b3ZpVEprbzhJN0lDT01zbHRNQlV5TE9zTUpk?=
 =?utf-8?B?YWxRK2pkZ1Q3QlZEdk9Kc29JQmdCa3ZYbTRTZGVTMWxVV1ptcGtpOVNCdDlp?=
 =?utf-8?B?WktSQVRmak5pUytER3VWRG9CQytIek5mMktVNE1MMjZIRGJycVduN3VJRFVm?=
 =?utf-8?B?Q1RDRzFvZmV1V2x6OXNWaldlcnM4NmVURVJrbW5Lbml1ZVMzeklYcmVVZjBm?=
 =?utf-8?B?R1RTL3lHT2NwcGhyZnA5Rk5kbmQ3Mm51eEkrUjI3ZGZaUVJpYldaYTByUkN6?=
 =?utf-8?B?UC91MFlNNHk5ZzZmU1NVSUlOUU5VSWdJT2lvbGlpMTNZNDBSTEhVOHowTkVG?=
 =?utf-8?B?TlVLR1l6S3FDMU4xNTFCWmtWU1JBUlVCUEZ2cWQyM0NGc0Q0NmNYZmwxTklv?=
 =?utf-8?B?Z3NKaFNmLzg0VUNqQ1lGV0hEc21EdDJrUmtSUHBPRmpMUGFoSUlyVlFTZ3NV?=
 =?utf-8?B?SHpIWjJqcGk1RnRSa29ZMUxSUmNZbFBPeXh0dUxwT1pKL05iNFpWL2VvQUNq?=
 =?utf-8?B?MjNPN0tkQ2V5aHc0dWRyWmZvU0lORk5BQnFhZm96ZCtrSjVlTGw4WTZwS1Jl?=
 =?utf-8?B?UGRiRjZxNGdKcnRQSUttNXRVSXI2NU82R0dZNUtGRXpkSW5JZWdOL0tnVDBl?=
 =?utf-8?B?TVVIZDBjcVZ6OWZiNi9mRTk1bDZsa1I0YjM4bVVwZWgvMExXQ3IvY0ZzKzdR?=
 =?utf-8?B?Vkk1d2NvcTQwNnFjRG54b3greHRVSWErcC9JKzRLVUZ1Wk5HaW5KdHFnbTJj?=
 =?utf-8?B?aS9rc1g1bElnL01sWnUzUGo0ZTlrRFBrbERXOXVPZHhGN0Z6Sk90NUFLSjlD?=
 =?utf-8?B?MElySmk4SE92SnBmY2l4YkpMTDBIejZGY3dLelpzdGxoakJSdWZ0b0xrNmFy?=
 =?utf-8?B?R3RlTzZGM3NvNFhvUzJ6c0pkalpQdHU2OU8rMzdHemJqOElHQm9vWlVjMFhF?=
 =?utf-8?B?aG5zdHAvamJZMmo3eWEzSUlHQnlPa2p0RGRGY2hkUDJwTzB5Z0RvT2hGTXcv?=
 =?utf-8?B?RStMQXl4ZGVnT2lxQWU1U3kvS2ZEVUcza2NWaDNkR2p6U2sremVWeEpSdmVR?=
 =?utf-8?B?RE1IMVNyUlRKYzk3SW12VXV0TFNhZU9xdzN3YzcvZnFYaVNCK01FUi8yb1Qr?=
 =?utf-8?B?eFR1MFUrZ1lINXhYM1BPOTF4RWtKdVNHWE02NWQ5YXhyZTZPaldzYmJUN1Mr?=
 =?utf-8?B?NFRyUVJlZTBGWHF1UVY3VkNDRkRBc1dzNXdCeE5PVWRqcXplVC9WRUxXSVl2?=
 =?utf-8?B?MnZISWRucFdvY24wdDlocndwakYrVGNSUm1wT09meEdwSHBqcUdnMmhZNmpH?=
 =?utf-8?B?UjZncDB3SS9FektkaUVRQnJRODRybXRyRGNaaFluZndtK3Y0NTJLUUI4YUhR?=
 =?utf-8?B?ZkUrMk5uekJKRXBuZ01Neml0cU9xdVFYL0F4ZzkrODR3dmcvaWlqa2p3bTZq?=
 =?utf-8?B?bHNqbVd3Ukc2S3ZaZzZCOWFlcHJVeFA1MEhud05GSWFSeWVWT3dld0ZDT2hP?=
 =?utf-8?B?WmtNKzZPalM5ci94OTgvc2dEd0k3MDBxb2lHc1BPTThNYVV5YjFMdktCOUlw?=
 =?utf-8?B?OGh4V2tmVTRGR2xsWnB6Mlpwd2RwUkhhaFNZdDBKVS9WRjIrcUM5M3U5SkUy?=
 =?utf-8?B?SndiQ2RBSFhBYlhBTGVNQ2UzYmlZaHhxeVdjNXJEVm5kRjF3S2ZJckp5WnZ1?=
 =?utf-8?B?K1pZZXVuMXdIVTZXSWhORGgwZVRuYnh0MU9ZYUpmeXNybUNla1Vwd3N5M3Jr?=
 =?utf-8?B?bTFIOEsxMldYNFJKajducU1NRjI1eVVYaWc4YXQ0bEZxeCtEVU10QitIVG5H?=
 =?utf-8?B?UHEycjhzOXg1cWRkUWhEZEMycmpRQkZoZXVHTWgwRjdTNmFqeElheTFSQzhO?=
 =?utf-8?B?eW1PZnBDK0lrQzZ2YkdqcWU4aUhHQVlZZVpCUTE5MDBPdWJ0TjQxZXRGellB?=
 =?utf-8?B?YkdOcWNrc1dDZnllaGQ1dzFxK0ZtNUhJODVPM1NBOURZRUE4ZVZVdUxHRzhN?=
 =?utf-8?B?L1BXVlkvMVd4NFQzMXhBK1NZQzNIdTI0T1VUZU9lT0R5MCs4TDZWNjZuWXFF?=
 =?utf-8?B?Q1pHa1NQaVhWbUlOZWdRcDJRUVZ3UVljUmdOMWo1MSs0RjZzWGpMSXVqVXpw?=
 =?utf-8?B?SzUxN25KdXFaTmUxYjF4ekszQVRzUDZsei9mR0RNVjZyM0tySmVSRzg0MDY1?=
 =?utf-8?Q?uzRTCxQvQhtXFxd+FYfkXmGpMj9RNwsM04txv198aPeY/?=
X-MS-Exchange-AntiSpam-MessageData-1: kjCzk6jUltj5PQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09b5d3f-7b11-4f29-a235-08dea4e58949
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:18:09.2724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K64+/zzP1QLMg1HpCQVW/ks8SkVZbFH87QkF/DHNscc7x38f/eJAVjqscC0WlZ7+ApdQlN7afcnzkNZGHd2hlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
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

On Mon Apr 27, 2026 at 3:57 PM JST, Alexandre Courbot wrote:
> From: John Hubbard <jhubbard@nvidia.com>
>
> Move the SEC2 reset/load/boot sequence into a BooterFirmware::run()
> method, and call it from a thin run_booter() helper on Gsp. This is a
> pure refactoring with no behavior change, done in preparation for adding
> an alternative FSP boot path.

nit: this isn't no behaviour change because it moves a failure in
BooterFirmware::new to after a bunch of messages to GSP and GSP boot.
But assuming that is fine,

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/nova-core/firmware/booter.rs | 30 ++++++++++++++++++++++
>  drivers/gpu/nova-core/gsp/boot.rs        | 43 +++++++++++++++-----------=
------
>  2 files changed, 50 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-=
core/firmware/booter.rs
> index de2a4536b532..6a41690e72c6 100644
> --- a/drivers/gpu/nova-core/firmware/booter.rs
> +++ b/drivers/gpu/nova-core/firmware/booter.rs
> @@ -8,6 +8,7 @@
> =20
>  use kernel::{
>      device,
> +    dma::Coherent,
>      prelude::*,
>      transmute::FromBytes, //
>  };
> @@ -396,6 +397,35 @@ pub(crate) fn new(
>              ucode: ucode_signed,
>          })
>      }
> +
> +    /// Load and run the booter firmware on SEC2.
> +    ///
> +    /// Resets SEC2, loads this firmware image, then boots with the WPR =
metadata
> +    /// address passed via the SEC2 mailboxes.
> +    pub(crate) fn run<T>(
> +        &self,
> +        dev: &device::Device<device::Bound>,
> +        bar: &Bar0,
> +        sec2_falcon: &Falcon<Sec2>,
> +        wpr_meta: &Coherent<T>,
> +    ) -> Result {
> +        sec2_falcon.reset(bar)?;
> +        sec2_falcon.load(dev, bar, self)?;
> +        let wpr_handle =3D wpr_meta.dma_handle();
> +        let (mbox0, mbox1) =3D sec2_falcon.boot(
> +            bar,
> +            Some(wpr_handle as u32),
> +            Some((wpr_handle >> 32) as u32),

nit: should we have // CAST comments here? fine to ignore this since
this this patch is just moving code though.

> +        )?;
> +        dev_dbg!(dev, "SEC2 MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1)=
;
> +
> +        if mbox0 !=3D 0 {
> +            dev_err!(dev, "Booter-load failed with error {:#x}\n", mbox0=
);
> +            return Err(ENODEV);
> +        }
> +
> +        Ok(())
> +    }
>  }
> =20
>  impl FalconDmaLoadable for BooterFirmware {
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index d39da38c8918..e75c4b235aab 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -136,6 +136,25 @@ fn run_fwsec_frts(
>          }
>      }
> =20
> +    /// Load and run the booter firmware.
> +    fn run_booter(
> +        dev: &device::Device<device::Bound>,
> +        bar: &Bar0,
> +        chipset: Chipset,
> +        sec2_falcon: &Falcon<Sec2>,
> +        wpr_meta: &Coherent<GspFwWprMeta>,
> +    ) -> Result {
> +        BooterFirmware::new(
> +            dev,
> +            BooterKind::Loader,
> +            chipset,
> +            FIRMWARE_VERSION,
> +            sec2_falcon,
> +            bar,
> +        )?
> +        .run(dev, bar, sec2_falcon, wpr_meta)
> +    }
> +
>      /// Attempt to boot the GSP.
>      ///
>      /// This is a GPU-dependent and complex procedure that involves load=
ing firmware files from
> @@ -173,15 +192,6 @@ pub(crate) fn boot(
>              Self::run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, &=
fb_layout)?;
>          }
> =20
> -        let booter_loader =3D BooterFirmware::new(
> -            dev,
> -            BooterKind::Loader,
> -            chipset,
> -            FIRMWARE_VERSION,
> -            sec2_falcon,
> -            bar,
> -        )?;
> -
>          let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::n=
ew(&gsp_fw, &fb_layout))?;
> =20
>          self.cmdq
> @@ -203,20 +213,7 @@ pub(crate) fn boot(
>              "Using SEC2 to load and run the booter_load firmware...\n"
>          );
> =20
> -        sec2_falcon.reset(bar)?;
> -        sec2_falcon.load(dev, bar, &booter_loader)?;
> -        let wpr_handle =3D wpr_meta.dma_handle();
> -        let (mbox0, mbox1) =3D sec2_falcon.boot(
> -            bar,
> -            Some(wpr_handle as u32),
> -            Some((wpr_handle >> 32) as u32),
> -        )?;
> -        dev_dbg!(pdev, "SEC2 MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1=
);
> -
> -        if mbox0 !=3D 0 {
> -            dev_err!(pdev, "Booter-load failed with error {:#x}\n", mbox=
0);
> -            return Err(ENODEV);
> -        }
> +        Self::run_booter(dev, bar, chipset, sec2_falcon, &wpr_meta)?;
> =20
>          gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
> =20

