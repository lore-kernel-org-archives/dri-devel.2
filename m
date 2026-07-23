Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5201C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 05:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 238B410E2C1;
	Thu, 23 Jul 2026 05:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OKDHQzDE";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B1710E2C1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 05:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCk8R4uPgEtzu+na8L1ZmIwPjI8TwgTSaDmkXr1eGhvS2SoMVI8CTqLRRSMEihmzkIwMImZ4o0CXOYSKz7UB0gaTIWop78kH9+iLyRajVNRPqg3r/GI72oPCxc11odQf6ZuIliwGQaA7igdUrwZKXhSqiZbjJs7qptq1pJB5UVa/VV9W2Wjt6oLKjzn0usDNoHMfTdVVwwGT/x3rMZ8+hbnfLpTD/lRiEna5rWrYsttRTVodiypysLszvM96Qrvp8ISBntMbpZCIXZXxkNtxbl0xtcNn8xjUJw6T18/UykQLTjkbiE4i5O+TaqbLcAvVDbR/Hlat/+JqzV4aM/w9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX8FY4wsCQm9+BBcOTa9PLQk7wbj8tIEntHlsOXTxck=;
 b=Ih19g+9T0MT8lOB8oaV1rRLyYrGRWOqiEjRlr56QRx4dQeucw9+JhizjuN5I7vtSHXIRoM71oL7bl7soKpwrmG2pYojE86EJLxymQxZOZnIHBDY81z4cJxT7kO4QPaDqRi4InHMdHowMz5Z1uqrdPoXiN9q0n61760W1y5Y2PmBfo1SbAZPEMY1EBZETsptE6tEe9KbR91wLFuqoOAAe/wWIVArjxnS3rtCOBF0TAtXwKSBicplncyBAvEDcUbcqIt+wsx5lzlJw9cOKmhS5C8FDfAbfsq2dpfEf5xP4N1td9jTKwKhwaS1vyWBihd9YBRvodyKNQZKCwwgrqnlU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX8FY4wsCQm9+BBcOTa9PLQk7wbj8tIEntHlsOXTxck=;
 b=OKDHQzDEx6UZg5ZgkdM6uFmFmSHFfT4CmUKgp6mxZ3u+w4Aztzq9iRL1JLf0SnT9bXeXgRDWlgH9EQQvXL8iqlJIHP9DR30zTLDIedwNqL8oGqvqDbDf82HbPw/tUOQgDm62IUMS3JQmqFNxofL0/aUmtO7fTfSjDHfxa/6rLSQ5azE/s6tQNwAPMtuKTw5cYXMNEC5TBb4IQNgJcCshP/vijSDRkWEuyc71Owj6hsm6T83Frf1u2lKCp9eiT6enFQzFTNPZt5vGFxA/U+036wklypxLQXhqqWYG1jOKM7CRStkikMza4vE/oKd2P+NLh7WE9AFNJaQBkzGfAP2RiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 05:02:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 05:02:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 14:02:12 +0900
Message-Id: <DK5OQWB04ZRE.1AHZZ9O7MPA75@nvidia.com>
Subject: Re: [PATCH v2 05/10] gpu: nova-core: split FbLayout into FSP and
 non-FSP versions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
 <20260703-blackwell-fixes-v2-5-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-5-8e3d8bc32bb9@nvidia.com>
X-ClientProxiedBy: TYCP286CA0305.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: aa33ce24-52a0-429b-2f6d-08dee87790c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|10070799003|56012099006|10067099003|22082099003|18002099003|4143699003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: PZopmK5fGrCYruDGsFsAMmKQviufzJIEv07MQ4T4d4Ke+qRtS3VaPakGga+jX0g7JX6aOzsO+oXRSJWyZl/rvohUGbxz+3xNslSQGiOEGYiGT097usipO+UJdlL2Imunp/VxG3e4+gEUKzl0os7k1f2h2NTC295RGzriZo9h3KEhokoHvhx7+5gHdPrDueC9KKyYnMfHiF5IIsOmSweioHh1t8BFLhh8zUM+Q2Z7wGra4M33dCgCE0WdYeE+hrJ0qmf5EAUg2nFC2F1AlzC1J/IQcqTatDxki8LtK+M400GJ8FdL7PCiK9alxnnOpKQfAzSkbrNavLeTftdVckS1yi+OQR/jQKWO/lc6dpnMQP4i4NrIJsBw4EhxxxmR89n28w37YhQcUVvFtnl9MIZSt77YnqfwzPVD6kIUa+7GjW3HRSrbQKFQsnhVKrmwnVhBDlRfNJyArNLLn4YkXmGuN6Q5T3KbcCpsWMUTqYvBeKxIRpskbo1X7u64znHUSyY/w8mUbDL1U08Oy6TKtUxczOT4DM/Bq0paRh3WEbP+qLTWRK4Xvtjuz5nwypn9Tr++QCk3TPBXAx+1PvKJPlhJlJVOVpus4C6td1g3bO9l++eFhBPAKLyNM9CXzr25iGuOhhFMWuo/szPBLwYHEp3ehAh7wVwjxKCmSR++bY/6B2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10070799003)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWlpT0hGUFRpQ3p0cEhzTWFHeXhWcGJaZFl3MmtMU043RXBzNk84OElJWGIz?=
 =?utf-8?B?cXZUSHo5SHlpNm5lUWI3M3c2VXpaY3phOFlCRzdBQ01TY1pneEdCSlpnZzdH?=
 =?utf-8?B?aWxHSFJuVE1ld1lIM3FqS2tZbGxxSTlOa0tJTnV6ZUF3eCtMUEYxM0JXWGR0?=
 =?utf-8?B?LzI5MW1iM1I2YzAxOHNLLy9kUjV4cXJpWHJVTVd3QUIram5iTEhuU1pMSGsy?=
 =?utf-8?B?RzRGVjdzb1Q2eWlreHdSQmZWb3hhUVhiMmpVNU00ZlNvSjdaVlF3YUtZMEVq?=
 =?utf-8?B?VjVDc2pycDJFL0pMaFU1ckw0NU5IMWhycUZyN0NZSndFTG5RTy9iTXpSaW9u?=
 =?utf-8?B?U2RURFpxbEpWQTM1Z0xrTGtPcHUwZ0QraUZUN1p1Z2VNdmt3VWQvMEs2Z1lP?=
 =?utf-8?B?SWRYZjdhcmlaS1h5b0J3MmJWWk93ZUV1VzlRaUp1RytlZHUvUWRZMzVDY2Na?=
 =?utf-8?B?UHB2QkMyMkt3WlJadXBDUkhCRGtheWRVUjNJTEp5eHIrTkxTaG5PN2FxcGFW?=
 =?utf-8?B?b21oMUVBdzdhRGVVZWw4ZktkbUxxQnlvZFFneE1qeFB6NThzMzlWeDUrdTZ1?=
 =?utf-8?B?K0FwQjVRMW85YTQyTzAvRFpxQjZsMVNqclU5QkpTT3dUMlQ0QWhoOGxLSC9O?=
 =?utf-8?B?V3RDM056T3RqRXNGSm5NSGgyY1hxWUl2akNyZVRmNE1QVG9NRmsreDhoNFhu?=
 =?utf-8?B?UXRxY2ovTXY4SngzUnZRTHRCd1JnaUJzRlRUdmFFVHNDME4vUXh1ZWE5RTNp?=
 =?utf-8?B?MHp0dHIwSys4NHAreWVQaGk2S0ZQaUJ6QWxsUW5rRmxLRlBERllGandEVkRq?=
 =?utf-8?B?MmFEc1JVTlZzREF2REd5cDFvK2RHcG9JajBoU0Rsam9jWnliMHgyRUFtY1BN?=
 =?utf-8?B?QmViY01sWkhhWjVnSmVra3NJNVhvcnJSQXNkZGxOZmV6MDZ5U1FpRmp2M3FG?=
 =?utf-8?B?ZDhDUVJlQ2dESEtEOUoxZ1p0VDFzd2hZRkRadThuOGFJL2FKWUlCdy9JVE5Z?=
 =?utf-8?B?enc5TGF1Q3JkYmN5cFczV05rM0RNSnkvNmtnK3Z5SjZxNEgrTFdscnlYQVVm?=
 =?utf-8?B?OTJnUjNHNnhkNjRwT29aRjZRallSaVBoNllWY1pVQktpdnlTdzR3K2V6TlIz?=
 =?utf-8?B?OThjMGFwRERsSlNUSGFlQTg4YlNFaFJBNnI4OWJzd1JueEdWOGU2ck1hSnpu?=
 =?utf-8?B?bncxK1dtWUk5YnE1Y1p3bFJjcDV1YXdDNzN2MTZOb2N5RUkrY3Z4WFRsR3Q5?=
 =?utf-8?B?bXc4VzVTQk11cmMzd3dKS290aXM4NXFmMXdRM0gwU0hOUFBZZHlCbFBoVlZF?=
 =?utf-8?B?WUpsOWF6SDZmNW9HZG1sOXNaQjVXOEkxak5GYmFnZE5UL3JxR2FMZisza2d6?=
 =?utf-8?B?K0dSb0xEUzhsbCtZN0NYMTV3M0xEU2MwaXJRclZJTUsyazJtbWYycEZOM05z?=
 =?utf-8?B?Q1d6ZjU1bHJoTjEwOUMwSEdJVWh1U25vU2RLcXJQai9HU0JFOVlaaktBVEw3?=
 =?utf-8?B?cjlDb29ML1BnWXZOa0t3bjdJZHJWK242Z2NFWU5qMnpnb0dScDVwQnZhbEp0?=
 =?utf-8?B?Y2djSEpsY2FRMkpwa1ozcys2cGxEK24xVE9rZlQwS1U3SnozWkoyTVlkUDh3?=
 =?utf-8?B?N1A5WnR0Qk1SQ0lVeXhXdDhNaGRuNkg5bzlNMUlTNEVFakUvNVlQZVBoQkp1?=
 =?utf-8?B?ZnVSdzlPNXJlZmMrKzFXVzBUeUpPc0ZhU2kvUGpBQkw1VVV6MmY4aTIzbGtl?=
 =?utf-8?B?TjJTbjBLU2YvSEM5TEF5MlJCYzQ5Nk5JRmllNC9ub01yRzdMNnFoUm9keHdD?=
 =?utf-8?B?aUdnRldDQmJLVkdKSGFnRmFoa1VTdk04Wk03MTZJZEpzMCs4NmRlWG5pR01W?=
 =?utf-8?B?NFNHZTc2SFROa256SWRrMnVPQ05jUSs0SksrSExPSzJjWWJjZnI5dERYT2VY?=
 =?utf-8?B?MW1zTGdBNXR3eXgzdXYyQUFOV0FSY3lFcTB6aHV3aEZGeU5qNElEMVQyQVZp?=
 =?utf-8?B?M0FIbFJzcC83WHp1ajVwdk9ycHdvMjhHSEowQWxKbE5zVGdhWFlMd2p2QUxV?=
 =?utf-8?B?VHE1Qm96bDBIOHd0aDQwSVdPQ0NlZVl2ZmhrbDh3eGh5WEhKNExKTUZhbHF1?=
 =?utf-8?B?RUNrSUdVZ2l3b1NqeERzeXZCUDZEVGdhWTVRdmIxL0tER3lQMUh3d3BOdjBm?=
 =?utf-8?B?eWVpWWRiVFFYQ1ZKeml2RU9DY0xoMEhwcTlRSlZaWVFQcUtGdXJ1NWpJMEtx?=
 =?utf-8?B?M1p2RmxrUi94NHpEdlVsc05VR0h6TXNSWkovc3JVb1BDekw5c0trc2V2eUpN?=
 =?utf-8?B?WHdkTDV2L2Rhc1V5TGYxUnVvUHJKKytVZ28zd2l5Qnd5VFRIM1RwblZ3M0xv?=
 =?utf-8?Q?zeumpxqfD+LiFYVnI1KU5fnQBew1K95IrZFHfWvphKlpx?=
X-MS-Exchange-AntiSpam-MessageData-1: T0kcOVKs8qY3sA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa33ce24-52a0-429b-2f6d-08dee87790c7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 05:02:16.3132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNV/vbfct7PrgtcB/l8NUgNOlYpFjAx2657M5webTXPKvsbqmeGTnaYcfwddE6lG/u7AYhEE/Yi1yVSk+XJHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
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

On Fri Jul 3, 2026 at 7:22 PM JST, Eliot Courtney wrote:
> `FbLayout` is currently used for both pre and post FSP architectures. It
> contains ranges for each region of framebuffer, but on post FSP
> architectures, only the size is actually used by GSP. The offsets are
> not decided by the driver. So, for post FSP architectures `FbLayout`
> contains essentially guesses for the offsets. Instead, make separate
> types so that we only store the information that's actually needed,
> rather than keeping around offsets that may not be correct.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

These patches (5-8) are the only one remaining from the series, which is
not entirely a coincidence since they are kind of a different series by
themselves. :)

The patch's premise looks correct to me; although I wonder if we
couldn't avoid the enum by making the FB layout information more local.
Its use in `boot.rs` is what makes it difficult.

Ordering nit: this patch introduces an architectural change, following
by smaller fixes (at least for patches 7-8). If the fixes had come
first, they could have been merged first and the larger change would
operate on a better base. This is not a request to reorder if doing so
is not easy; just a note for future series.

Some more comments inline.

> ---
>  drivers/gpu/nova-core/fb.rs            | 70 ++++++++++++++++++++++---
>  drivers/gpu/nova-core/fsp.rs           | 15 +++---
>  drivers/gpu/nova-core/gsp/boot.rs      | 26 +++++-----
>  drivers/gpu/nova-core/gsp/fw.rs        | 95 ++++++++++++++++++++++++++--=
------
>  drivers/gpu/nova-core/gsp/hal.rs       |  4 +-
>  drivers/gpu/nova-core/gsp/hal/gh100.rs | 10 ++--
>  drivers/gpu/nova-core/gsp/hal/tu102.rs | 24 +++++----
>  7 files changed, 178 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index 273cff752fae..fd60f93258a9 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
> @@ -144,11 +144,30 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::R=
esult {
>      }
>  }
> =20
> -/// Layout of the GPU framebuffer memory.
> -///
> -/// Contains ranges of GPU memory reserved for a given purpose during th=
e GSP boot process.
> +/// Framebuffer information required for GSP boot.
>  #[derive(Debug)]
> -pub(crate) struct FbLayout {
> +pub(crate) enum GspFbInfo {
> +    /// Concrete framebuffer ranges for host computed framebuffer layout=
.
> +    Ranges(FbRanges),
> +    /// Sizes of framebuffer ranges for GSP-FMC computed ranges.
> +    Sizes(FbSizes),
> +}
> +
> +impl GspFbInfo {
> +    /// Computes the framebuffer region information required for boot.
> +    pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmw=
are) -> Result<Self> {
> +        match chipset.gsp_boot_method() {
> +            gsp::GspBootMethod::Fsp =3D> FbSizes::new(chipset, bar).map(=
Self::Sizes),
> +            gsp::GspBootMethod::Sec2 { .. } =3D> {
> +                FbRanges::new(chipset, bar, gsp_fw).map(Self::Ranges)
> +            }
> +        }
> +    }
> +}
> +
> +/// Framebuffer ranges needed for GSP boot process.
> +#[derive(Debug)]
> +pub(crate) struct FbRanges {
>      /// Range of the framebuffer. Starts at `0`.
>      pub(crate) fb: FbRange,
>      /// VGA workspace, small area of reserved memory at the end of the f=
ramebuffer.
> @@ -163,15 +182,17 @@ pub(crate) struct FbLayout {
>      pub(crate) wpr2_heap: FbRange,
>      /// WPR2 region range, starting with an instance of `GspFwWprMeta`.
>      pub(crate) wpr2: FbRange,
> +    /// Non-WPR heap, located just below WPR2.
>      pub(crate) heap: FbRange,
> +    /// Number of VF partitions.
>      pub(crate) vf_partition_count: u8,
>      /// PMU reserved memory size, in bytes.
>      pub(crate) pmu_reserved_size: u32,
>  }
> =20
> -impl FbLayout {
> -    /// Computes the FB layout for `chipset` required to run the `gsp_fw=
` GSP firmware.
> -    pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmw=
are) -> Result<Self> {
> +impl FbRanges {
> +    /// Computes concrete framebuffer ranges required on non-FSP booting=
 architectures.
> +    fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Res=
ult<Self> {
>          let hal =3D hal::fb_hal(chipset);
> =20
>          let fb =3D {
> @@ -270,3 +291,38 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, g=
sp_fw: &GspFirmware) -> Resu
>          })
>      }
>  }
> +
> +/// Framebuffer region sizes needed for GSP-FMC boot.
> +#[derive(Debug)]
> +pub(crate) struct FbSizes {
> +    /// VGA workspace size, in bytes.
> +    pub(crate) vga_workspace_size: u64,
> +    /// FRTS size, in bytes.
> +    pub(crate) frts_size: u64,
> +    /// WPR2 heap size, in bytes.
> +    pub(crate) wpr2_heap_size: u64,
> +    /// Non-WPR heap size, in bytes.
> +    pub(crate) heap_size: u64,
> +    /// PMU reserved memory size, in bytes.
> +    pub(crate) pmu_reserved_size: u32,
> +    /// Number of VF partitions.
> +    pub(crate) vf_partition_count: u8,
> +}
> +
> +impl FbSizes {
> +    /// Computes the framebuffer region sizes for GSP-FMC boot.
> +    fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
> +        let hal =3D hal::fb_hal(chipset);
> +        let fb_size =3D hal.vidmem_size(bar);
> +
> +        Ok(Self {
> +            vga_workspace_size: u64::SZ_128K,

If this is a const, do we need to store it here? Can't we define it and
use it where needed?

> +            frts_size: hal.frts_size(),
> +            wpr2_heap_size: gsp::LibosParams::from_chipset(chipset)
> +                .wpr_heap_size(chipset, fb_size)?,
> +            heap_size: u64::from(hal.non_wpr_heap_size()),
> +            pmu_reserved_size: hal.pmu_reserved_size(),
> +            vf_partition_count: 0,
> +        })
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
> index 5b782aa2e3fd..533fb95573ab 100644
> --- a/drivers/gpu/nova-core/fsp.rs
> +++ b/drivers/gpu/nova-core/fsp.rs
> @@ -31,7 +31,7 @@
>          fsp::Fsp as FspEngine,
>          Falcon, //
>      },
> -    fb::FbLayout,
> +    fb::FbSizes,
>      firmware::{
>          fsp::{
>              FmcSignatures,
> @@ -136,14 +136,14 @@ struct FspCotMessage {
>  impl FspCotMessage {
>      /// Returns an in-place initializer for [`FspCotMessage`].
>      fn new<'a>(
> -        fb_layout: &FbLayout,
> +        fb_info: &FbSizes,
>          fsp_fw: &'a FspFirmware,
>          args: &'a FmcBootArgs<'_>,
>      ) -> Result<impl Init<Self> + 'a> {
>          // frts_vidmem_offset is measured from the end of FB, so FRTS si=
ts at
>          // (end of FB) - frts_vidmem_offset.
>          let frts_vidmem_offset =3D if !args.resume {
> -            let frts_reserved_size =3D fb_layout.heap.len() + u64::from(=
fb_layout.pmu_reserved_size);
> +            let frts_reserved_size =3D fb_info.heap_size + u64::from(fb_=
info.pmu_reserved_size);
> =20
>              frts_reserved_size
>                  .align_up(Alignment::new::<SZ_2M>())
> @@ -153,7 +153,7 @@ fn new<'a>(
>          };
> =20
>          let frts_size: u32 =3D if !args.resume {
> -            fb_layout.frts.len().try_into()?
> +            fb_info.frts_size.try_into()?
>          } else {
>              0
>          };
> @@ -339,15 +339,12 @@ fn send_sync_fsp<M>(&mut self, dev: &device::Device=
, msg: &M) -> Result<KVec<u8>
>      pub(crate) fn boot_fmc(
>          &mut self,
>          dev: &device::Device<device::Bound>,
> -        fb_layout: &FbLayout,
> +        fb_info: &FbSizes,
>          args: &FmcBootArgs<'_>,
>      ) -> Result {
>          dev_dbg!(dev, "Starting FSP boot sequence for {}\n", args.chipse=
t);
> =20
> -        let msg =3D KBox::init(
> -            FspCotMessage::new(fb_layout, &self.fsp_fw, args)?,
> -            GFP_KERNEL,
> -        )?;
> +        let msg =3D KBox::init(FspCotMessage::new(fb_info, &self.fsp_fw,=
 args)?, GFP_KERNEL)?;
> =20
>          let _response_buf =3D self.send_sync_fsp(dev, &*msg)?;
> =20
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index c347558aa8e5..14fd96084746 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -16,7 +16,7 @@
>          gsp::Gsp,
>          Falcon, //
>      },
> -    fb::FbLayout,
> +    fb::GspFbInfo,
>      firmware::{
>          gsp::GspFirmware,
>          FIRMWARE_VERSION, //
> @@ -50,23 +50,21 @@ pub(crate) fn boot(
> =20
>          let gsp_fw =3D KBox::pin_init(GspFirmware::new(dev, chipset, FIR=
MWARE_VERSION), GFP_KERNEL)?;
> =20
> -        let fb_layout =3D FbLayout::new(chipset, bar, &gsp_fw)?;
> -        dev_dbg!(dev, "{:#x?}\n", fb_layout);
> +        let fb_info =3D GspFbInfo::new(chipset, bar, &gsp_fw)?;
> +        dev_dbg!(dev, "{:#x?}\n", fb_info);
> =20
> -        let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::n=
ew(&gsp_fw, &fb_layout))?;
> +        let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::n=
ew(&gsp_fw, &fb_info))?;
> =20
>          // Perform the chipset-specific boot sequence, and retrieve the =
unload bundle.
> -        let unload_bundle =3D hal
> -            .boot(&self, &mut ctx, &fb_layout, &wpr_meta)?
> -            .or_else(|| {
> -                dev_warn!(dev, "The GSP won't be able to unload properly=
 on unbind.\n");
> -                dev_warn!(
> -                    dev,
> -                    "The GPU will need to be reset before the driver can=
 bind again.\n"
> -                );
> +        let unload_bundle =3D hal.boot(&self, &mut ctx, &fb_info, &wpr_m=
eta)?.or_else(|| {
> +            dev_warn!(dev, "The GSP won't be able to unload properly on =
unbind.\n");
> +            dev_warn!(
> +                dev,
> +                "The GPU will need to be reset before the driver can bin=
d again.\n"
> +            );
> =20
> -                None
> -            });
> +            None
> +        });
> =20
>          let mut unload_guard =3D
>              ScopeGuard::new_with_data((ctx, unload_bundle), |(ctx, unloa=
d_bundle)| {
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index 2590931262af..3b148147cb18 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -29,7 +29,7 @@
>  };
> =20
>  use crate::{
> -    fb::FbLayout,
> +    fb::GspFbInfo,
>      firmware::gsp::GspFirmware,
>      gpu::{
>          Architecture,
> @@ -215,11 +215,65 @@ unsafe impl FromBytes for GspFwWprMeta {}
> =20
>  impl GspFwWprMeta {
>      /// Returns an initializer for a `GspFwWprMeta` suitable for booting=
 `gsp_firmware` using the
> -    /// `fb_layout` layout.
> +    /// framebuffer information.
>      pub(crate) fn new<'a>(
>          gsp_firmware: &'a GspFirmware,
> -        fb_layout: &'a FbLayout,
> +        fb_info: &'a GspFbInfo,
>      ) -> impl Init<Self> + 'a {
> +        #[derive(Default)]
> +        struct WprMetaFields {
> +            gsp_fw_rsvd_start: u64,
> +            non_wpr_heap_offset: u64,
> +            non_wpr_heap_size: u64,
> +            gsp_fw_wpr_start: u64,
> +            gsp_fw_heap_offset: u64,
> +            gsp_fw_heap_size: u64,
> +            gsp_fw_offset: u64,
> +            boot_bin_offset: u64,
> +            frts_offset: u64,
> +            frts_size: u64,
> +            gsp_fw_wpr_end: u64,
> +            gsp_fw_heap_vf_partition_count: u8,
> +            fb_size: u64,
> +            vga_workspace_offset: u64,
> +            vga_workspace_size: u64,
> +            pmu_reserved_size: u32,
> +        }
> +
> +        let fields =3D match fb_info {
> +            GspFbInfo::Ranges(ranges) =3D> WprMetaFields {
> +                gsp_fw_rsvd_start: ranges.heap.start,
> +                non_wpr_heap_offset: ranges.heap.start,
> +                non_wpr_heap_size: ranges.heap.len(),
> +                gsp_fw_wpr_start: ranges.wpr2.start,
> +                gsp_fw_heap_offset: ranges.wpr2_heap.start,
> +                gsp_fw_heap_size: ranges.wpr2_heap.len(),
> +                gsp_fw_offset: ranges.elf.start,
> +                boot_bin_offset: ranges.boot.start,
> +                frts_offset: ranges.frts.start,
> +                frts_size: ranges.frts.len(),
> +                gsp_fw_wpr_end: ranges
> +                    .vga_workspace
> +                    .start
> +                    .align_down(Alignment::new::<SZ_128K>()),
> +                gsp_fw_heap_vf_partition_count: ranges.vf_partition_coun=
t,
> +                fb_size: ranges.fb.len(),
> +                vga_workspace_offset: ranges.vga_workspace.start,
> +                vga_workspace_size: ranges.vga_workspace.len(),
> +                pmu_reserved_size: ranges.pmu_reserved_size,
> +            },
> +            GspFbInfo::Sizes(sizes) =3D> WprMetaFields {
> +                non_wpr_heap_size: sizes.heap_size,
> +                gsp_fw_heap_size: sizes.wpr2_heap_size,
> +                frts_size: sizes.frts_size,
> +                gsp_fw_heap_vf_partition_count: sizes.vf_partition_count=
,
> +                vga_workspace_size: sizes.vga_workspace_size,
> +                pmu_reserved_size: sizes.pmu_reserved_size,
> +                // When only sizes are supplied, offsets and several oth=
er parameters are not used.
> +                ..Default::default()
> +            },
> +        };
> +
>          let init_inner =3D init!(bindings::GspFwWprMeta {
>              // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGIC=
` unmodified.
>              magic: bindings::GSP_FW_WPR_META_MAGIC as u64,
> @@ -237,25 +291,22 @@ pub(crate) fn new<'a>(
>                      sizeOfSignature: u64::from_safe_cast(gsp_firmware.si=
gnatures.size()),
>                  },
>              },
> -            gspFwRsvdStart: fb_layout.heap.start,
> -            nonWprHeapOffset: fb_layout.heap.start,
> -            nonWprHeapSize: fb_layout.heap.end - fb_layout.heap.start,
> -            gspFwWprStart: fb_layout.wpr2.start,
> -            gspFwHeapOffset: fb_layout.wpr2_heap.start,
> -            gspFwHeapSize: fb_layout.wpr2_heap.end - fb_layout.wpr2_heap=
.start,
> -            gspFwOffset: fb_layout.elf.start,
> -            bootBinOffset: fb_layout.boot.start,
> -            frtsOffset: fb_layout.frts.start,
> -            frtsSize: fb_layout.frts.end - fb_layout.frts.start,
> -            gspFwWprEnd: fb_layout
> -                .vga_workspace
> -                .start
> -                .align_down(Alignment::new::<SZ_128K>()),
> -            gspFwHeapVfPartitionCount: fb_layout.vf_partition_count,
> -            fbSize: fb_layout.fb.end - fb_layout.fb.start,
> -            vgaWorkspaceOffset: fb_layout.vga_workspace.start,
> -            vgaWorkspaceSize: fb_layout.vga_workspace.end - fb_layout.vg=
a_workspace.start,
> -            pmuReservedSize: fb_layout.pmu_reserved_size,
> +            gspFwRsvdStart: fields.gsp_fw_rsvd_start,
> +            nonWprHeapOffset: fields.non_wpr_heap_offset,
> +            nonWprHeapSize: fields.non_wpr_heap_size,
> +            gspFwWprStart: fields.gsp_fw_wpr_start,
> +            gspFwHeapOffset: fields.gsp_fw_heap_offset,
> +            gspFwHeapSize: fields.gsp_fw_heap_size,
> +            gspFwOffset: fields.gsp_fw_offset,
> +            bootBinOffset: fields.boot_bin_offset,
> +            frtsOffset: fields.frts_offset,
> +            frtsSize: fields.frts_size,
> +            gspFwWprEnd: fields.gsp_fw_wpr_end,
> +            gspFwHeapVfPartitionCount: fields.gsp_fw_heap_vf_partition_c=
ount,
> +            fbSize: fields.fb_size,
> +            vgaWorkspaceOffset: fields.vga_workspace_offset,
> +            vgaWorkspaceSize: fields.vga_workspace_size,
> +            pmuReservedSize: fields.pmu_reserved_size,
>              ..Zeroable::init_zeroed()
>          });
> =20
> diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp=
/hal.rs
> index 46428c623087..ddd356fafc1e 100644
> --- a/drivers/gpu/nova-core/gsp/hal.rs
> +++ b/drivers/gpu/nova-core/gsp/hal.rs
> @@ -11,7 +11,7 @@
>  };
> =20
>  use crate::{
> -    fb::FbLayout,
> +    fb::GspFbInfo,
>      firmware::gsp::GspFirmware,
>      gpu::Chipset,
>      gsp::{
> @@ -42,7 +42,7 @@ fn boot(
>          &self,
>          gsp: &Gsp,
>          ctx: &mut GspBootContext<'_, '_>,
> -        fb_layout: &FbLayout,
> +        fb_info: &GspFbInfo,
>          wpr_meta: &Coherent<GspFwWprMeta>,
>      ) -> Result<Option<crate::gsp::UnloadBundle>>;
> =20
> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-co=
re/gsp/hal/gh100.rs
> index 270703d0f5c6..6fc6d487e4c8 100644
> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
> @@ -15,7 +15,7 @@
>          gsp::Gsp as GspEngine,
>          Falcon, //
>      },
> -    fb::FbLayout,
> +    fb::GspFbInfo,
>      fsp::FmcBootArgs,
>      gsp::{
>          hal::{
> @@ -136,13 +136,17 @@ fn boot(
>          &self,
>          gsp: &Gsp,
>          ctx: &mut GspBootContext<'_, '_>,
> -        fb_layout: &FbLayout,
> +        fb_info: &GspFbInfo,
>          wpr_meta: &Coherent<GspFwWprMeta>,
>      ) -> Result<Option<crate::gsp::UnloadBundle>> {
>          let dev =3D ctx.dev();
>          let chipset =3D ctx.chipset;
>          let gsp_falcon =3D ctx.gsp_falcon;
> =20
> +        let GspFbInfo::Sizes(fb_sizes) =3D fb_info else {
> +            return Err(EINVAL);
> +        };

Mmm I wish we would avoid that, this is another example of a runtime
check that should not need to be performed.

In this case I think we can, as we also have access to the
`GspFwWprMeta` which contains the FRTS size information that we are
using. We would just need to construct the range from it, pass it to
`run_fwsec_frts`, and we remove visibility from a lot of information
that this method didn't need in the first place. This could be a
standalone cleanup patch that comes before this one.

All the same (and again IIUC), the GH100's GSP HAL `boot` method should
be able to work entirely with `GspFwWprMeta`.

With these two out of the way, the only place where the FB layout
information is required becomes the construction of `GspFwWprMeta`;
which should give us more opportunities to make things more local and
remove `GspFbInfo` altogether, maybe by making the construction of
`GspFwWprMeta` a HAL method of `Fb` so we can hide `FbRanges`/`FbSizes`
there?

It's still not completely clear to me, so let's first see if my
suggestion can be applied and what the resulting code looks like once it
is done. But I sense room for simplification. :)
