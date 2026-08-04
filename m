Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD1AC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7934810E0E2;
	Tue,  4 Aug 2026 04:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ns1z32IO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422F810E05B
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWdHhTXGRXCf83ABvV9CoetO0C+xYK/QsFY9rFyTWOiWHd5TEm8mzT8+SFTSxYRT/Tbm8caE+kzUGUBVK2plX4KdH0qVKgml9rb4DGVEuHvVeQ+5JpIG6XvmmBF0BFCmDJJYudMVckOAbO8S6Kbn3RiiLwdFDP8hEDsNYU9L/DF8vhHDXfj5hM/3dp6W3NjhIK34jRmk4FzGC/t2F6EBd1f0E0oqIFaK1soe/J6hg/n7G7ImFOMr+1kMZhJMvj0ru1SVC7xBEnrEbEUoQkTC0Qi7MkziCuyrWL9Nr1nAlwG82NePm32jhGMHchPUarxQCn2qjYmpUWCazlvDP2imOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ1rl4waHtnQmVEcblpIZjZDVu8mK2QTChot4f9xgPw=;
 b=GGt7xQt6cYdb3QykHr9MiHNpbIHRoWMqf9NznPixs/PE0bWyk4PW37tq240stj+i8J0KAmhElTY+66iuBzakoeRMDv1lEpcrAovGAgwq7V8Ju96Adpm3okZ/LbPlStCghRcnTkwGuL93BjSikPFecAZsPfpFliYd6dd0d6Zy8qfwVnbUAy06JcbkCVyNeNOtPd9hdvo/5v6oa2pBLws0TvsuNosiikMlOGYSMmLVO5pQlgCtvtkJbNEl66IIIQKx/LtJ/7T9dCWs71V5Yo8T022kcHZN+wmfKqoLAsEH3A7jKoWXu5a49HE+Q5whRT1KbfYTMBCAySt62VwdZCPVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ1rl4waHtnQmVEcblpIZjZDVu8mK2QTChot4f9xgPw=;
 b=Ns1z32IOBDobWtQjTEXJUJKfaiDdv0v+3FtI/ukWTK0B7lvQgnKeXqA03FdwzG16gIOAb3SrJZoJoG8VVmVyS/8WL3IfaIVA0V4oT1LtHn/uvmzkdI40lEQRxkB2EPjlrfCZPhaP44ZrsBeAlH6Ivw3VZ2RM7tOkRDaHLCr9oD7cmBrKTKn2TWcONPqgxawSRzXIYpEbdSgfgU6xQd1/rvNnLNYUn/PNEhSPa0ejotF2o8MQHgSSHyI/PvsunLln9ZuqZzN+yErrSHFVRyia+xbCAN4al9wavoq5rP0P1Byr4nAwHQhzXiC5VxYg7UWuFKVCoZklKebHyWKsgYK0cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 04:02:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 04:02:52 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 13:02:46 +0900
Message-Id: <DKFUZX7537VG.1T9PS1E3S8NKR@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] gpu: nova-core: correct FRTS vidmem offset
 calculation
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
 <20260724-blackwell-fixes-v3-1-01aa6a54e3fd@nvidia.com>
In-Reply-To: <20260724-blackwell-fixes-v3-1-01aa6a54e3fd@nvidia.com>
X-ClientProxiedBy: OS0PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:604:24::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 535cff18-28d3-4283-d6d3-08def1dd4070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10070799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YEYYWmZqExKq48iHBuSMxBTwZgyaqZWDDy7xG1pTqrXhfGjXQrajln5aQJpFvfQCbtz2/jexzQm7rQfcu+0nAhZdpa+uM7uM8Ch/y3xc5ZSmuQjEkKvxVHS8bbOWLp4b27f4FRwP0xh0SmQMqa7xERP7CR6DIPv4VprjGR5e4njHlXDA0+OjROOyDa2mNy1iPNO1hvw8G58bgtyp6TXPkk1DmH/obQJc25cxOFX1w4aAv6ZE6isl84TvWlNeNMNmcSA3ZnlOFHiv0SN9lPo7c+lJ8u0w8HCMqDRL/iZFn74mzzCLevkWEjkeiteCmnIifW0HOw5NcyrDTTsDG+k8aFZxXyiJgEWACj7fleP5BA8KvZNFtPqHK62Vkp/zYhXbVjAcFi7PpPXk+fbNsDdEdFy341bz7BAuU9byQxQc3CpfEInD5isazaS2BzSMRfjAZNSFwfeyl0ZC0U5bulApBgW6O/MnylZtcx8rv8Egk+/3N4nnj0TMFKg/SCGCs4+xFuOES5jK7FxABLE0/6GWIIrnI51EjjHC1l2b7Q3wvWcKtpLGTwuVHkHO/EsNNLcZxDgmb2/nN1WPgx9r3bVyOqAM8V9drnntRY6Jh+MTP1KSCU6Sdb8U62ysW/F6TQ9Qrnu9xjMVCezOjdk0VOzrc5rIpqv9XzmM8S9MDbdcwOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10070799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VENTUUpta2pZWDJZUFdDMEhLbW50OGxZOU04QXB6SXpQYmI2dVEyVGl2V1dm?=
 =?utf-8?B?SEd3NHFXN2Y3ZTRSRHFUNldyaE53bVZjNmJBVEhiWnltRVd2OENyYnMydFZ2?=
 =?utf-8?B?MmdGeWpQUTl0TW1rZXc0TEkzUXdNRk5VTEErdkVxWlc5bW81RlpOVHVCd1VG?=
 =?utf-8?B?NmhtWUxPRWFCOGpYb0xFRDhsNDRIU0E2QUhnZnFqOGY0cWoxYTIzRyt2aTNl?=
 =?utf-8?B?RXNWQ1VMc0JDSlNBdlRRaFpSaHh3bFhoc1NHUGZTSUg5cGpkYVJncUoxc20x?=
 =?utf-8?B?VDFubE1seDV2TVVqZVE5NXRhY3h1RENMeC8xOElQdWJuTHNMOFlGZlVqNFVz?=
 =?utf-8?B?R2NkU0Zab01HeFRra3gwTkRadmJoQUthSityVGpBM01oTjl0RU12elhPdG9a?=
 =?utf-8?B?QWoxU1NPemlLbmFsTFBScVNaUUNFR2JlblVVRW1UTjlBZ2N4L3BQL1B5NGQ5?=
 =?utf-8?B?b2NxVjc2OGxxZ2V3QnRNTTVBVmEvdERpc1ByRVgzU3hBNnFSV3FLWUNUcHhC?=
 =?utf-8?B?N3RQS3lvcDZSZ3dFREhURk5uZmQydXdpRVdDd3NvajRHWXBDVXpmY1NZUVha?=
 =?utf-8?B?dVVUT2RnVVhqdjM0VEhGUE1mRy8yS1k3QjBMcHVvWDF0SThteVpOenpoUlZs?=
 =?utf-8?B?YUdSa3pKbU5GcGVJRUg0RUlnd3MxWVJUWmcyemF1MW50TVJ0WkkrOXY2cWh2?=
 =?utf-8?B?dTdNdzFPa2kxK0JZQ2ZOaU83NFA3ZDAraTFQSENleElHem9mK0VzRkhHNlVs?=
 =?utf-8?B?TVhJNkVDdkkwQlMzankwcWpuU2ZHaHVlaFo4QXhmSVZLeXE3VXNDRFZkYmJC?=
 =?utf-8?B?eXFXWVh2ZWFJT0huSFhGVnRrOTFXTFFYVjgzTmpIZGx4VUNEeGlsdVR1ZElt?=
 =?utf-8?B?RnM4bFJvT283UzhoZFF0cXNKcDVtblhsVHp2OGEvUmp0ZXpSSkhUUUpKcG1N?=
 =?utf-8?B?M3JiSVZxU2dMc0RyQUFEQXNrZnF1N2d3alB6TUdmeTNqN3F1elpqc3l4MmtN?=
 =?utf-8?B?QjZRbEhheS96bUdzN2pTZlVxdFQybkpnV0EwT2h2NjQ3VDNYRnpkU2tRWEx2?=
 =?utf-8?B?TVh4Z3dCS3IxMlRuSnBJNU9RTWI5QjFxVG8rbmxlUkRhNnZyN01FdnN3WnB4?=
 =?utf-8?B?dUR5WE9kQ2VOV2xTcGl5cXFKQjExSEtSYlJjK1c5Rk1qSDVWR2ZFSERtU1Bl?=
 =?utf-8?B?ekdGTHNabnhTN2lJSWJ2QS9Jb2xjTm4xeDZoV0o4TTVQZ1JQUHp5SmE2eWph?=
 =?utf-8?B?bDBVV2ZhdUMrb25GY3MxNy9OY1NjNzRJTUNzdkVxVlorTzZmYVNqcFRDaUZm?=
 =?utf-8?B?SEU1cVM4ejdVeUVURHRnQjZ6VGZNVGptNmVadmFkbURCYmhVZW9vTi9zd3h5?=
 =?utf-8?B?alpUV1p5MS8yMHRHcjJMTFRMREttWHlmOEVJc05saVZtTnA1U3ZROUJSRTIy?=
 =?utf-8?B?dTRDejhoWDA2MkhBTzAyUnFsTENRNE9VTm1wNWRaTzhUaEIwaUxkck84U0ZE?=
 =?utf-8?B?NnBwNHZzMkdybnhNckF1Ym5ubnB6RmhmelJYb3NUb3B2bFYvbkZwckpydi9h?=
 =?utf-8?B?RHlPZG9YN1RHZVBxd25ZcU1UUEV3RFRaNWlUa2FWWldOTmtOOXhqUVJNVUNQ?=
 =?utf-8?B?WnJDdHBSWngvdHIrVDFVOWhxTVl4Q0RVT09MR3B5V0R2aG51bnViVGdxZEgr?=
 =?utf-8?B?Y25wRlJFWnRTWlVTZ3lETHkvV2c2YVZrc05EOG9uRlRaS1FGbmhOMVBNSlFG?=
 =?utf-8?B?TWswRU9iRzV4aGZyR0xyTkRqQVV2ZzMwVVE0Ym55QlpPU0xBdUVnZkdiczRH?=
 =?utf-8?B?anppUlF6MjVjUmRnQXl2TEdYTTBZcnNxVGg2citodW1ETUU4OGNyMllKTDlp?=
 =?utf-8?B?RktUc1JpMDA1dktnZG1LU01wNVZKMlZMOGdINjJ5UTBia0s4QmUva3hpeVl5?=
 =?utf-8?B?Nys1SS84NnFVSWg2OTRUWlgwR004Ukx1dWhFUGh3UzlOWGx2Rlplbi9LMlhZ?=
 =?utf-8?B?c3RzWVltckNjZVNvSnd4bXJhMDA0Q0NBclNSVFdJODc5WGhyMENOa0xKclIx?=
 =?utf-8?B?MzRzSTMwbmdDNFBjWUhjSDJYSlVianRxbDVxTldTUUliS3FEZkdCRTdOUHhz?=
 =?utf-8?B?RU92UzBIZXJLc3RpalIyYVAwS2M2WUt6RGNzZ3ZRMDI3TmFHNHl0ajY3L3NY?=
 =?utf-8?B?VzZmQUh5WjYvbml5ZlVOOEhhcmx6ZGFiOGRiTWZ6bytUTkxrTzgzYU16ZEsz?=
 =?utf-8?B?ak5xeWlra2c4N2F2aGpoNlhqN2Y0U2lzTTh4RVgyR2w4cnYxcjkxSmpuL1Vs?=
 =?utf-8?B?MWhaSXV5d2VaVUdKeTBvemtGS2Uyb1FScWJ2ZmFFbDNQdDFwMXJ4MXRIdG1h?=
 =?utf-8?Q?pHlCNWLWnxc2tL2tMk9mvOXOLLgmhCt93Dkx3GCcKYcqg?=
X-MS-Exchange-AntiSpam-MessageData-1: LvaaCdu5uiEpow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535cff18-28d3-4283-d6d3-08def1dd4070
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 04:02:52.7545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UFRR8kXZ3j7ocVY7rj19w/wE9xZNeNWDPQ+IPrbj7CTsrys1THnR4ALMZ5s8phcJNk1+qwM2RGyx2ndeYPsmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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

On Fri Jul 24, 2026 at 3:56 PM JST, Eliot Courtney wrote:
> Currently, the frts vidmem offset is calculated based on the non-wpr
> heap size and pmu reservation size, but this is not right. The layout
> actually looks like this:
>
> | non-wpr heap | WPR2 .. FRTS | PMU reserved | ... | VGA workspace |
>
> It's just by coincidence + generous alignment that the values happened
> to match. Instead, define a per-architecture reserved size at the end of
> the framebuffer and use this plus the PMU reserved size to calculate the
> frts vidmem offset.
>
> Fixes: d317e4585fa3 ("gpu: nova-core: Hopper/Blackwell: add FSP Chain of =
Trust boot")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/fb/hal/gb100.rs  |  1 +
>  drivers/gpu/nova-core/fb/hal/gb202.rs  |  1 +
>  drivers/gpu/nova-core/fsp.rs           | 27 +++++++++++++++++++--------
>  drivers/gpu/nova-core/fsp/hal.rs       |  4 ++++
>  drivers/gpu/nova-core/fsp/hal/gb100.rs |  6 ++++++
>  drivers/gpu/nova-core/fsp/hal/gb202.rs |  9 ++++++++-
>  drivers/gpu/nova-core/fsp/hal/gh100.rs |  9 ++++++++-
>  7 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-cor=
e/fb/hal/gb100.rs
> index 6e0eba101ca1..51bd0c0bede6 100644
> --- a/drivers/gpu/nova-core/fb/hal/gb100.rs
> +++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
> @@ -78,6 +78,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: B=
ounded<u64, 52>) {
>      );
>  }
> =20
> +// This PMU reservation size is r570-specific.
>  pub(super) const fn pmu_reserved_size_gb100() -> u32 {
>      usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment:=
:new::<SZ_128K>()).unwrap() }>(
>      )
> diff --git a/drivers/gpu/nova-core/fb/hal/gb202.rs b/drivers/gpu/nova-cor=
e/fb/hal/gb202.rs
> index b78e0970f66d..8ec30afcf701 100644
> --- a/drivers/gpu/nova-core/fb/hal/gb202.rs
> +++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
> @@ -71,6 +71,7 @@ fn pmu_reserved_size(&self) -> u32 {
> =20
>      fn non_wpr_heap_size(&self) -> u32 {
>          // Non-WPR heap for GB20x (see Open RM: kgspGetNonWprHeapSize, G=
B202+).
> +        // This size is r570-specific.
>          u32::SZ_2M + u32::SZ_128K
>      }
> =20
> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
> index 1475485bded3..30e53df81aa2 100644
> --- a/drivers/gpu/nova-core/fsp.rs
> +++ b/drivers/gpu/nova-core/fsp.rs
> @@ -134,20 +134,31 @@ struct FspCotMessage {
>  }
> =20
>  impl FspCotMessage {
> +    /// Computes the FRTS vidmem offset for the Chain-of-Trust message. =
It is measured from the end

Let's say "It is measured backwards from the end", so the direction is
clear - I assumed an upwards direction initially, which is intuitively
how you tend to measure things that start at an end offset. :)
