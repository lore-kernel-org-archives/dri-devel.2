Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E86EC9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B6610E518;
	Wed, 30 Sep 2026 04:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhG++YhM";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E897C10E518
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mc98tlDmYvlii+tnXWBRZuIjAOmcwdM7DsrPoPDBcJO4ITZQOWx1O6bmaOh9BEx/ZEZR1vKTfpU8uR1BqdS9QiGhqZy3a1T5599teCWuWry2ek4sgMrhX5LVK+g3gTSIYp3x7PKrT6ActwHxnG6upi5eIEXUDzyxrghcRy5FM4oSwAOAuOZGhQoMGGsHLRS0qEFvfYrqcFipzAcc8gqKriQeGYZKF0Qd3kNyUih8C72zTpH3GPTldDr9q/6iopFabQ0VpjKCAahtMelpsBMpooM0TllC2Iy4XLmyflTc7rJZPOsxv8Dd9fY1xf7IWcN+INf94cNzHmcRrqRSogbGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH6pKEf8r0rBJJFaLchvfNmMEr3UhoQ+B4Esu8I13y8=;
 b=W+5ZIIy0ZEHCDh/9E4O5MbfHRVPshsvssL+HG9w+DVt0ooGduYb6Ew6/wlDRTz41bCmZAomIMzQutnPbeIQqY4QFd0iuZEipUMLYlu0LTT6JNdzzT0N5oa58MX6/pVdR5jNCHJcF4TSOSJJIbuYY7CGPwF93h6mYmGHXU/bT/C4BGsgQ0SDUj8JIzK0TF+h5zXbdzEP2M1NlEfii0fzCkPFUN0aS+zFilEhHoyDKiEbQaMHDFs7X7xKqHjEU19gthJvjOV5tDoDpqaBMQxnvGHkMAOcozDunJZTp/pV9X8efgBnCoXG3p0tpR7SdwTMoyr3XDj8nyfoLidkkoC1HVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH6pKEf8r0rBJJFaLchvfNmMEr3UhoQ+B4Esu8I13y8=;
 b=qhG++YhMNaXIL1WAoWQQ0H+f2UgPjT5qHLT/ctwnIvNCVoCfy2pSd1Bh35JNpsPbEM4XGGyrkJTwWPsAED94I4Z8kjASsr01GZiHTtB1jieF3CUE6gZD9bluBxRErJHco0Fwj6spaL694p+8HnBR4fZ/y5pnejdNNkZMDSaYIIdtH/eGhD0bMqtiK6RiG0uMrwvS6BkINT178A9H3ieaev16YKbKKUB9lElw0h19lv6hd3W6mgTqaKPpOxXiLguR8irhy/E77Huf8feJuFXxNNbv0Y2U4lp2fq6f4skhH8xAKSerHCoU0qkcpsqko6X4aSjsJA1Kw3+dH3ek2kIVfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 04:50:26 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 04:50:26 +0000
Date: Wed, 30 Sep 2026 00:50:24 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 7/9] rust: id_pool: add contiguous ID reservation
Message-ID: <aryVEFOG5VLiQGaF@yury>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-7-0d6cca376cff@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-chid-v9-7-0d6cca376cff@nvidia.com>
X-ClientProxiedBy: MN2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:208:23c::23) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0101e4ff-28d8-4c6c-5b72-08df1eae580a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: njDt9ZW43QV3wIUIaMFA/+E+VJKomwr7pVIKGpqJQDzAXtb3GKEwV2umVfLB2h5hCYZH4A3BPms6qhnO/qUpSY9eEsN5T0rAh8QDM1jd0pgmWWwuG5iWEI+9Io/NkVQUObcdgBQDM4MUkyUfaDVEfqjagWuf0vXp2K0l9twAVcHowWoWEOIFLLaBsxoQZAZnevYcgWT8cQk7s61xDYKaLI+HUQjnM0hhvSwasIPIXa56vALl1F42tSLtCo6LcluVZK4FDqkh5eexpyF8NvXM0aL9MIgmQZH2BFhoybGGYThGPtJKCvcKw7E5PhMIl2qTvaPB4i4ZxGK1gy3CnRGxccsGEOmTtf4EwmssTYQn7B5pPebKrrdcc1nFHRaly1AAKoaWfUAvJiepHuvkK+8+KWxDa/3L6mXfqJVBWbvSETD5v/cYe4HhJWo0m0K45CgmCvgDhg6a61YDatm/fsvKka6hHc+sqFMmZX7rQ2aAR9sLn9KWqPlh/iNHFZ8akF+nUS/o6chyl3Y3x3v2OdKDchemoWU6Q/NTiaf7fQr4wiUzRpwuclPlxiIwvtfJf5+CBuwOh8uIpChNcNe/h5MLtmCuPuBgi4/mfxz0rEYUvY/8iHzCc/3d0kWnm9rVTfu7TOoT3zQpYgtNACJnbw3spZJ6PxUoWDxJFtE/hVuJPzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nFUaTbUUfE04Gmiog2RzdLZbillFR9r/ZzVIYCpuyZZfnIfEts3ynOH/jpvM?=
 =?us-ascii?Q?FDT51oSkhfaA7tRMRhfjEpA7YF/UaxpqdgMMz9QF077W7QN2+hqFvA0cG+FM?=
 =?us-ascii?Q?twFQEjJ47RskqkV/9RyrZ/suexspTxM1uoVNn7MJFPC/oK1RFPPr13V9JNh8?=
 =?us-ascii?Q?J+fE3FjG4Xt26pelYhazMFvllL1kSOGF1W8FsSLDwU5gdjw4bN30AfXauNVC?=
 =?us-ascii?Q?sBEf8Xgj56t2sg/4tIvUgPZdGi+Au3fVV2hqEk/VX1yXKVytW9K55mJq04eY?=
 =?us-ascii?Q?5vyVUoIPhOZ4VoQwMOfGI4eKgZ50s11Im1TNMsPxVnEsh3Fo/gYZX+KI/Haf?=
 =?us-ascii?Q?F6BzWQsJ/5G63tF6Zw/vubqsMqlGw/moG2QlZ4xCKj6oren3ILMrx8UkP/Xh?=
 =?us-ascii?Q?SzZ5sjvNheT8WaI+f4OitdmYE2xPJ8c6ik3DOpYpYuy/MllT3Ps5G4sGpZ4w?=
 =?us-ascii?Q?MD1LhSg7NuzSscmElwsgFNwKtQtsKM9n4ApxxnN3VQkr96G7U2NKlY96ghvu?=
 =?us-ascii?Q?COZR0nbIp4YyaxSrwQ+GdhWNYb96zRMHx0xrW0HPlnBXr+P4ISGCqBQ/gQ0s?=
 =?us-ascii?Q?k3bHP21vBwgbm2iGOWwME1RL4Gl2v33RlgRKhsHGOjQUgH4b4RmCsGo1SYuw?=
 =?us-ascii?Q?V9cau6YPonUxo9ovVdyUdXldKSpSZPFh+vuj4KDjFsqxfsHJ4Ot94j7bkosy?=
 =?us-ascii?Q?jSR9NnxM1TmukqrN/qAhU/5tHzCDV78QCsRGIitqwezzVtoTmgiIdNFb9gKM?=
 =?us-ascii?Q?zXZKdEKW1lFMGpJy4wnLrYUK1g7xcsrIlJjkx9TGNfipzWequRMSeLO+AWXB?=
 =?us-ascii?Q?dGG3rPG0G0JsrQDaLXguSEtWvFgApH+L4n+97r+dr1oVFAtmxvIMfwt3RAGZ?=
 =?us-ascii?Q?BMc43zuaKx+pb4AhudIeZtWFudLj4UMbJJz7vPMyfCJi8oR7DaxS5asSs9BB?=
 =?us-ascii?Q?P/b8BV+JbNM7Cu5te3DL045Rs7jNoLjxKezE5cQSggeWmV/caLGD+Xud4Tct?=
 =?us-ascii?Q?PHn4fsbxLMcNVpP89bHi5Veu0Wup+DCio+/I69V6ZI1f7GJgfhI7IQ5anwaW?=
 =?us-ascii?Q?oF6C+gzITXNaQyf4xz5p9IBOzLIaIzaeeLIHY9lNJHgbQKKDGwRrEAwk0s1Y?=
 =?us-ascii?Q?V+/3EFLDSBhDY5/yrXaNqb7Eo9swFcOzA+9JIe9yEekOTBEPtwKg0Bvfoobg?=
 =?us-ascii?Q?KcCUSHiMyA3KM+BiU6NkHNM7jp0YN+so0C0dKa4dyjMjKPxycDIldtDjJ/cM?=
 =?us-ascii?Q?FFoMw34wdpzFZxnh6Un2vl1an/v0vUWIZKRPWqeCDm7HIenrwD5tsOCrOtuD?=
 =?us-ascii?Q?Vl4DmiI+8AXR7d6IzHIcP0ZuUkiSOVRqrG7boA6Vzyt2pu9tj5lu/DjN2SN8?=
 =?us-ascii?Q?h1eDCKoMZI7o1iLiDXrNko9WYWsv0jBMH7byUqgj/ZcgVZW91CJOq/te9NgM?=
 =?us-ascii?Q?osZSthAzSRlH/IOohCqgENjjjM/a6B0Ag4Vh5gKKNomtWGs1XU+qknxJu6+Y?=
 =?us-ascii?Q?dn4gEwFrFB+60MBDJ+mkN/5vQ1jZskS5lsz9jWwdhFTE7ehBPCS0pGlzeMKG?=
 =?us-ascii?Q?UJFJKEw1PYM3giShpBPupPWuiid6kUXaHGqZony9mme2SPka/mIiemJb89LJ?=
 =?us-ascii?Q?2OTjbMW9UfvTDiKu7iCp/sweGyUahc3zDlcj32BTq+KHQ7m2VE0VAHmY7YpH?=
 =?us-ascii?Q?wkcRm8A7zJyONSWCRv3QXmCKO4Ctw4Y/DEBb57yD3f5YcjzM51OjY2SNcBuB?=
 =?us-ascii?Q?TM6hWSs1Ag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0101e4ff-28d8-4c6c-5b72-08df1eae580a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 04:50:26.2435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaqJh5Lv2GgNDTC0+dMt72JgavKawQorAuKYYxAJtAmzCoFWIRMh6ppyc5DtRUaTum7KK9Cx0O/PdyvXrBse8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
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

On Wed, Sep 30, 2026 at 11:42:56AM +0900, Eliot Courtney wrote:
> Add `IdPool::reserve_ids` which allocates a contiguous range with the
> given offset, count, and alignment.
> 
> Reviewed-by: Burak Emir <burak.emir@gmail.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

> ---
>  rust/kernel/id_pool.rs | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 384753fe0e44..06a4c71c4c6c 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -4,8 +4,14 @@
>  
>  //! Rust API for an ID pool backed by a [`BitmapVec`].
>  
> +use core::{
> +    num::NonZero,
> +    ops::Range, //
> +};
> +
>  use crate::alloc::{AllocError, Flags};
>  use crate::bitmap::BitmapVec;
> +use crate::ptr::Alignment;
>  
>  /// Represents a dynamic ID pool backed by a [`BitmapVec`].
>  ///
> @@ -240,6 +246,32 @@ pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
>      pub fn release_id(&mut self, id: usize) {
>          self.map.clear_bit(id);
>      }
> +
> +    /// Reserves a contiguous area of `count` IDs at or after `offset`.
> +    ///
> +    /// The start of the returned area is a multiple of `align`.
> +    ///
> +    /// Returns the reserved range upon success, or [`None`] if no such area could be found.
> +    #[inline]
> +    #[must_use]
> +    pub fn reserve_ids(
> +        &mut self,
> +        offset: usize,
> +        count: NonZero<usize>,
> +        align: Alignment,
> +    ) -> Option<Range<usize>> {
> +        let start = self.map.next_zero_area(offset, count, align)?;
> +        self.map.set(start, count);
> +        Some(start..start + count.get())
> +    }
> +
> +    /// Releases a contiguous area of IDs.
> +    #[inline]
> +    pub fn release_ids(&mut self, range: &Range<usize>) {
> +        if let Some(nbits) = NonZero::new(range.len()) {
> +            self.map.clear(range.start, nbits);
> +        }
> +    }
>  }
>  
>  /// Represents an unused id in an [`IdPool`].
> 
> -- 
> 2.55.0
