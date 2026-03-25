Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35454109C029
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8432410E1B6;
	Wed, 25 Mar 2026 14:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="gPPx5UtP";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022072.outbound.protection.outlook.com [52.101.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51E310E16D;
 Wed, 25 Mar 2026 14:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRaHB7CW5u+tS2pgnbrABSH7O0DYW6lHzNPe95Chd4G3qLY2dyT8ZoCbL1CYE13eC65T7ynpO90YPtLb8nlMgd8PbGRoAv9v7MhoMiw5JOPyohSfAKRQHauNIj8vpTK1SRdt6VZwcgH9KuECGlK9ZfCgt65kOtn1WRAHVuvmbbixOIRCiqyyaBYshotBpVccVC4G+sIims7K+g/O3PhAMxHt8H9MV/pt1eFXWkzR+G4uriSz7+EiqH5szuVzqrw5H8zW5OqZVUExpZfsBR24ATjk4cguezxCam7Y6uChKFp/5dHMagnluEscZdC8EZ+fV77klbKYrlXvgsMBcajZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZj6M/YvMlO3sPD0GZKMWU1sa0bNM13zwzP1YjNC+8Y=;
 b=MmpTwBCt3UXqeK2Q1nyOavmfqq6T6TESeGIpGXM4Aq9sNCNnN9DgoUEWW2Ok5zCQTJiyDfP7RJtqC9hT5i9JlGQ2zGtI610NSRPv1M06rzZ5gUfurEkwVHKkwPZZDlzlVRrlIxMngK4AC/d3bq0sqodXV6wc/dt0o39TXBtdvSWOTIB7MBAzajsWoniHvGOvGRfcpkeEvLPfAicRLR1ObjYpRINqIvHSSkeALQnqfcRfEK26bVNerrx57dK4TAfnigp0LUWQjWustxmddMomk2mADRv7z+i8SIykojQvcWTWQoNJ0L3g8V/7GODDKweII0ru5OtD/LBoLDF+2/t84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZj6M/YvMlO3sPD0GZKMWU1sa0bNM13zwzP1YjNC+8Y=;
 b=gPPx5UtP5zz7SSpluQA1sEaKD+LRruOPeAUVSrgv56hWunOJxxFkMt9DNuK/tJ309JmRv6dIAtFKS5V7g8tlDciaXzb87emgd9tnOp9bcowwmqRyhhgq4LMhOtjaM95T1+ZDo6maHFH76DCrjjGsTEyRP7h9P7NexQ3OtbX2D6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7762.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:414::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 14:55:19 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 14:55:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 14:55:18 +0000
Message-Id: <DHBY7MICRY6U.1YAZLYRZJTICG@garyguo.net>
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <ttabi@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: uaccess: generalize write_dma() to accept any
 Coherent<T>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260325003921.3420-1-dakr@kernel.org>
 <DHBVS7DX89G2.34ELW7TJAH7M8@garyguo.net>
 <DHBWR17G0AIE.30MDYBUT7PNZL@kernel.org>
In-Reply-To: <DHBWR17G0AIE.30MDYBUT7PNZL@kernel.org>
X-ClientProxiedBy: LO4P123CA0657.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: c16ed98a-005f-4a0d-64d9-08de8a7e8824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: w7CF+Bsr5PRyst5hZoi1v1Int+MXZfsrpi9HxNDniXb4OPBXUa+gCg8KhUshSKLZX1UGCkmF5BNY/ikF5qvB5Brbe5F4Pq/OfJoAosGySwy86SgvNUm2IDdBicSYzxj7YGOso8G4orsmCUA+2NRq3kiqtozMrUkxquh8rAaQgE76VhK4nNDK4aE5qfXVjOKqhIU3hRV3xf/cNse25zKahLx0XqpRmtKKrr9SPheUDWYl3kXEeCeFizSqlEYJic9trrA+jFJgLtvUDzhqnk3iL2okB/P2AgJFW+ViOJ5bYAucuDNgdBC4qAK0DpCpqoyxVudqI5SpAd4UoSl19VbhEcoFv8jLSz5pOB0REwon+1Yl30kGWR3Kl+TaAmmrXmEKWEFf+irYwhn7n1noMv87WgE34fJCTxQIM1KVcwlXNSW22gLALECXdjdvb8ZNSnc0OTW+2Q2XQYhIRS6kzX2zK6UQvLAbsfm+V3tfE1Yq/lXhA+e7Vjh9wJ/qORpZNjwkWKqUyUHMPRMiGeLN5OaHXbiNB0qT1HYk8B5O1paarT0lK1A68cXCg/7gPl/LAuxnvfAr3drfK3+cKQGmIU4wAEdKY+FfWx2idNruVYrKQBpVxPepblg7bE/x5DzgIoX3i6AOVAU3Pt8MvP5WYvKlwmPMo8kRIvnN7q5Jaj8hJgHVRva/U1Dx0Q6QKAxPQya+eY7Nd9+WLdTBw/J7TZQoGMBH7anIPmieJOtKSQ03NVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGtaM3VqRzdrNjkxNnlZNGJhZURJM2U3RkZBVlM0Y05nTjgrVk1ramlxOGd2?=
 =?utf-8?B?ZnlxV3UzVlhaZnNYd2RDTU1jUE1aVlJKZ1NzV3BxUTAwTmgwczBPbm01NGxB?=
 =?utf-8?B?ODV4TGh6R1Z6N25wbWppZzAyWEM2RnJGVnB6L0I3NFQ4UThoUlgyNUpjN3NK?=
 =?utf-8?B?WFhvZHh0M01obHNRTjA0Y2FGa1F0UVNVTlhVVmVQeHZBYUFXZVRwQUcwQ2M3?=
 =?utf-8?B?RGU0VWp0RWlXeU40QkxIREpHWVlpUjZxUnliY0VHRzUrZGRaeHU4M0lxb1dh?=
 =?utf-8?B?dzdNSmhTMTZ5dU1DZ3dXMTZObVE1WWhkbS95NHhud1loWUtOcmVrSGpnYkhF?=
 =?utf-8?B?WU5MNlVKTkt5WSt5YTdQVEZsSmYyUXFTL2htS2lqbE9rWE5UN1RSZWZhMUkz?=
 =?utf-8?B?anp2NGdKQkVZNGt0cUxZeXhWcTFDM1NTcFdyYjRzNVBVY3g2dG80elpaZHlT?=
 =?utf-8?B?R3JiNGxpVjJjN0RJeXhkZGtJeXhTQkVNeGFuNExtc3ZsMkxXczNkS01DUGow?=
 =?utf-8?B?QjdQZGlNRUtxQ0xyQ1JXNm94WUEySE8rY3d2Rm81c1pUTVNnblZaWENubFNn?=
 =?utf-8?B?SjVIcWZaQnRlQzR0L2tpRFRCUXpZSTJmdWlRcmkvS1JRVUFYWlQvYjZrUWxr?=
 =?utf-8?B?Nk5BL2xodjVObWNXZDZtWlgyblJZeVBQV2twTTFEV1N3QzVNWDRWUm1kSnE3?=
 =?utf-8?B?L3VzZVBleXJUSVJmSklIM1lVTHptelRabituQTBNWFZHYkFMWFVkcXhqMXdk?=
 =?utf-8?B?MkV0UUhTMUVWTEpDYlQzYWdJcGFGclJqNzZiejJKU1B5VTYwOFd2T3k0bjB1?=
 =?utf-8?B?cithQlpVWEQxdzdmQzJHNDkrQXZzdU9Nd2toRmpnaklOWFMrWVNmclBoNytk?=
 =?utf-8?B?QmRBMTFacURwTGZHckk0U21nTE1PdHcvSG9OVTJ2MmNHck5VekpyVXI1QzlD?=
 =?utf-8?B?a210Vnk3UHBoRlBXY0ZzSjVCaThoZEdNVUw3NklxK3RYZ0ZkbnQ1T2d3eVlN?=
 =?utf-8?B?U29FclJXbS9WdVREN1FsL2VYTzF2cDZlbUlGTmtRZExjWUV0STZmYlNuYVJJ?=
 =?utf-8?B?UmY3V3FpdlZ1UUNwcWJiTWNNWWZRRmYzSUhYQ2d6SmxoUFJJRVp1MVNBeU44?=
 =?utf-8?B?KzFqUWlqTlhKRUxtWTdOelJnZ1Bla0EweHRrY3ZKNEJmNkdkam56WVE3WU1k?=
 =?utf-8?B?dHVXdlZIODR5VHBEV3ZsS1RJK0xJU1ViUkwzU2lBTFZTWGRmZDAycXN3c2FO?=
 =?utf-8?B?Ujl2TXJacm1kMXJiZG04QU5tQzgyS1RsSFdWUVF5b0RsYU15RUxvNXdxSXU2?=
 =?utf-8?B?V3N2bnRWYlBJSFVSd3ljRjN4V3RQamh5bDBwNmxOZWxNcEthRWRZVXRNekdv?=
 =?utf-8?B?bkpudm1ZQmpGUFROTFl6OGJEbmdRS3F3SUp6eXJ4WTYvcE5xU1dBb01WQ0p6?=
 =?utf-8?B?UksyaUZiV3FUMU5VS0hpTEpaR2JLcGhVdDZFVGNqVHZjNzkvQXVNTTh4VSsw?=
 =?utf-8?B?alVVT2xKc3UyUGVxNE05Z2s3VHZHR3BxZ2w0alJiQ2VPak5TUjlhME10NUxL?=
 =?utf-8?B?NlpXeGF6SzYvVzM2SmVWM2tyK20vZWlDbTRXY1cyTGZkd0hqWmd2Mmpaenhz?=
 =?utf-8?B?bU1OMW9aSm5TT1BqMENpUkFUenBiUW5UUDNmQU53WVBvMC9SVmtYeXY2ZVND?=
 =?utf-8?B?TlpMamtZSmIvUXljOExhMUkwMFd3dUR6c3JQaG1OWHZwMGhTbEE4SE1oZ3hx?=
 =?utf-8?B?a3A1MlJkZStLcW5IcFdWRytscVpHUEZBdWE2WXVUWFZTUTFRc1RzQnJDWjc4?=
 =?utf-8?B?MWNoUGI3Vk9ZYzdzWFVNK2QwNEpNMnVRb2h0ajVla3VjL0M2YTB6VFJ3T0kx?=
 =?utf-8?B?VThmbWEydzNtZ1Y3ajhXZkpMVERJeDljR2Y0SVBkNFgwc2pVU0NKUUJlRSsx?=
 =?utf-8?B?UU9yeGh0SnJXcFhPVTROb1NhMHNZZ1pjMk1WeWhRYmVQVVdyTTVJWTBGWUZ4?=
 =?utf-8?B?ckd0andwMFBNYkl6MHhVRjIvZzVnTHgwM3JHWUhNWHlTNmhQalJjMlgwVkZC?=
 =?utf-8?B?V2s2V0VIeE9VdCtLUGp5MlNRSS9EVFdaWXRxb0ZaRFVCZlJZNFA2ZmhOZ1JK?=
 =?utf-8?B?T0ozMUZxcVlEdXc3UWo2UlI2aXZ4RFIrK0s0M0ZkSHZpa0FYVXRyRVJJdUc0?=
 =?utf-8?B?WjRxcHV3aGxFU2ZjcXFyVXIreHJWTXM1M01WTzlpT2JoaXcvbWE1N25UZkk0?=
 =?utf-8?B?TjZ1VXE2QW5nWldXY3kvS09KWnJ2cmxjdkdBeHpOWkg3WFVvNnlHMCtXTDVJ?=
 =?utf-8?B?bkh2YzRDMitkY0YvY1NZV01JM0o3eEcrQmdHK0I3eWNtYkMyUitPZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c16ed98a-005f-4a0d-64d9-08de8a7e8824
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:55:18.9054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zx1nXChAN7WXnZnm+yjiSfhYjXKVYK8RG43Oq0fRAJLNQ88Ys3IysQV+DHF63PpGdJzhwLLb9R2AF2Oi9FdgGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7762
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

On Wed Mar 25, 2026 at 1:46 PM GMT, Danilo Krummrich wrote:
> On Wed Mar 25, 2026 at 2:01 PM CET, Gary Guo wrote:
>> I think there is a reason, which is that it weakens the strong typing th=
at we
>> have. I think it'll be better to have this be
>>
>>     fn write_dma<T>(&mut self, view: View<'_, Coherent<T>, [u8]>, offset=
: usize) -> Result

Correcting myself, this will be

    fn write_dma<T>(&mut self, view: View<'_, Coherent<T>, [u8]>) -> Result

(without offset, similar to the write_slice).

>>
>> once we have I/O view and expect people to create cast views into bytes
>> explicitly.
>>
>
> There is technically no difference between the above and the below, excep=
t that
> for the above the user has to create the View first, i.e. it needs additi=
onal
> code. What's the advantage?

It prevents misuses. If you have a `[u8]` or `[u8; SIZE]` already, the chan=
ge is
going to be small:

    u.write_dma(c, offset, count)

vs.

    u.write_dma(io_project!(c, [offset..][..count]))

[
    PS. it looks like with current proposals w/ virtual places, we might be=
 able
    to get this written as

        u.write_dma(c[offset..][..count])

    a few years down the road if we're successful.
]

However, using a view will prevent you from feeding an arbitary
`Coherent<FooBar>` and just write it to user space. `offset` and `count` in=
 the
API really doesn't make too much sense at all if `T` is not array/slice of =
u8.

Best,
Gary

>
>>> +    pub fn write_dma<T: KnownSize + AsBytes + ?Sized>(
>>> +        &mut self,
>>> +        alloc: &Coherent<T>,
>>> +        offset: usize,
>>> +        count: usize,
>>> +    ) -> Result {

