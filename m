Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15A0C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F3310E46A;
	Wed, 12 Aug 2026 23:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="UX2zrzQ8";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020079.outbound.protection.outlook.com [52.101.195.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD0910E46A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSj4HlFVsH6Sx9P2SjyVe4sTYXC5ivA+hN/PlXccDudV2UyDDBGOQfFNb26MMaN8ZV3rBEOj3QlQR275sYqaN5BvCaq1CzSWUGEmmDXihorPUNz/0ZrxVZ6w8XzhkZZQaaeKRgftKxAff0AWG5L0C5d3C8tGyh8E5kP1g2cNZx/ag3Ln6BZdyc1EH+p8nhNjHRGKgcdZDqRjRUTmP47SCV0sN31+L9RZx25BvCId8YZfYBXmMSD3qleK8KbtGKzlHzayvwCV1TChEGGXeX+piBMsI2q6u5fo9ohC5RLD+L1tzPYshEp2UdixXnHOXaLeG4auKBEUfwsCjQ+UvP2OAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBXfDJk5iI5PccRuyNiscv7ZrXLJhVlTigZa5TRCIqc=;
 b=a71VPbzqmHxOANge/hbz284ZRPM+WrKdo3sh6vm8FYJ0/wQZPzRs2bMwPWo4UP+OcZcKse9N797eTc5GoyNWqX44yRkSddEvZS5d9TH21gmvod4Sygb40NrHSMAIAreLTInVHdtos2F1dMj2zLwn9+3kvka14D/3c1V61nX71a75cP6oEZl68W0EQGV8g86KY7TETsSnvg8kz+S2ZM/x36SVWBaZ/6cj46vXIB0MnvaxnhSH6Csy9BUaz6uDcfem1kJL7AyOxkXCsFKHZUXjRb5MBsxkpY9p154/H2Xz5h2uEVBBDJirIFnbam/L8ofzykB6W6ui9fDVC418aCtyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBXfDJk5iI5PccRuyNiscv7ZrXLJhVlTigZa5TRCIqc=;
 b=UX2zrzQ8JAqcaEj+Ut3mXpML39m33RBy5vJCCNlL6MtqT+l7ZghBIZd0gzC9wRqZH4KGV3THMqn2Sx5hqwxdeKIGb75QOQ67719lH3v3N9qQ5nf2u8/hvzo8knVfe2ZqGRuxLqCuOXXQd5V2dmULY+RVj/JvwJ3FuhRBsSYuCW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB6177.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:24a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 23:51:15 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 23:51:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 00:51:14 +0100
Message-Id: <DKNDA8NXFQA7.1YHQZF8XDP83D@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] rust: dma: rename dma_handle to dma_address
X-Mailer: aerc 0.21.0
References: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
 <20260805-falcon-dma-projections-v2-2-4cc9f3f13ee9@nvidia.com>
 <3a87960b-8a20-4947-a8b5-d5197174317c@arm.com>
 <DKHATVF1WAE7.NGVXJQD12XQ@kernel.org>
 <DKIQEJX6H5A0.1D3POLLNZB9YS@garyguo.net>
 <DKNBM5C0CWIL.1Y659FEPPM2G0@kernel.org>
In-Reply-To: <DKNBM5C0CWIL.1Y659FEPPM2G0@kernel.org>
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: b9223b7f-b7c5-4a14-5970-08def8cc98c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|10070799003|56012099006|18002099003|22082099003|10067099003|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: 3a5mcQv5pdAGG23PQqBf1a3uQcwRn9EQhOVaZoZhGA/K7R1nCIeCPdIF7tEACSoWgkiHDRchiaupHSd9oeAqR8n+rSko0yK9Wl3JsZxCeJV95vQRYkT1fF9XhXVty+CP4E9/yVYltSj5lIOZyLNgLe4ABUrf8/NezcK+8GKWOxvK3Wxlvj3HonZ4/zgH/TR4+fejCsHLk8KXhV3PcW/rkj4Y1mzRXDcbxKa/cSUkaaA8ZXK7mDNWmYPSjAd8xCjeNhpmw2KPASM00Rb5ZNEfPUHWz2edPizfTfwp3n2cO1owjD/wMemGj7rTC1TK0i4pe7DGQZiEJjCB/XZQPwoTLrQL5DPabVMviX0Px5b5V70qe3uMf48Z5P3GCh8IWZbkHT4gjzi/+UWyhWxVHDCCwMMXJTM3nagmeB+NE4E/at9XCck0Lpo6oA8n4RfdeuMTU8s5BzSDAtzs2GNySOLHJlgkYGg0GZM/PLB1zCsLzs7tLL+p9Bj+qiO6unx0N9ZtDmF6WG+6I1PbEP8HICP7y45z1qZEu3dvM7FbssEnrYBr/b7zKaq2krCi4QE0gBg/A8Mv9Bdp3jxTCdMpyOPilzPNf5Ar0g1MfllOWt5UuQ2fKlUEGS0E4UclrZ4Np3Tr2ABsQwnV1nPtzrmtW6QlxHcJVsNgWKfKLKFebDLLTAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10070799003)(56012099006)(18002099003)(22082099003)(10067099003)(5023799004)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elU0aERkR2NTYWpnYjhFRGZkQlhLU0dxM24wMXZ2TGptWGpoMUMzYjZyazhi?=
 =?utf-8?B?RURqaWZmVHBNV3NCSmlnQU51UUxZR0lRTHBkTFdyQ2twNldpNlhUeFkybVV4?=
 =?utf-8?B?Ukp3V2ROcjdob2JUR1hBZEoydTBsYkFHb0VXZjdzb3lPZkRHVUR6NnZvM0Yz?=
 =?utf-8?B?YXM4TFFXeGtOdkl5M3lscjVaSjlVb0JadTF0REc4ejhEdm1wQk90ZUdLSzJY?=
 =?utf-8?B?SldOclJqN0JmeEU4SDVieGJWVGdnWTV2bnNsNm5wcmU1TXFKSUo0cit1WEly?=
 =?utf-8?B?ZkFDRVRyc2pGQnkxVlRpMjBvVVdFOVVQUkk4VUhkMTNRelVBdk1YS3BuSlFh?=
 =?utf-8?B?Y0tZcUpZMmV5VllhMGhwY2p4YjM4N1Y2WmxDdFc4WHNZNzBqQndGV2U0SG9r?=
 =?utf-8?B?WFErbHRnam4xajVxcE9qNUtNa0lQUXh1SHQxYzJ5Rk5IdDlodmFwK3d3UjFN?=
 =?utf-8?B?SlI1ZWNqV3I4bStoak5KZDdVOFpFc1ZFd0Y5K3VUWTNtRC9EZi9NSXdHeWFu?=
 =?utf-8?B?QUNKYnY4NkZVY0tuUzNLeUhPRlBBMnh4L3ZKT2VOU3VJRHl6VkFBVDJURkQ4?=
 =?utf-8?B?K2d1SmhRZjliWkN3OEtVeWh0OHE0bWRhWGQ3Z1ExWitVbk1qbWhwcjJUWXcz?=
 =?utf-8?B?cDg1M1F0TExNL2xxQ1dadEpUa3RHSmdQNEkxem1IeUhEYXIxaTdTMS80NExz?=
 =?utf-8?B?dWFKMTQxQURyT0lERTVGbkYvRFd2eGQ0dUZ3Mlc5THM1RVVEa2tmdDdwVUto?=
 =?utf-8?B?bmZmWko3M3pSQUFnSER5NHd4cERzM1pvQVVoYU9nbTFIRGtiaFhtUi9JQS82?=
 =?utf-8?B?T05pWFV1VzdDQ1NiVmdldytXdi81UzI1UWRuVjNJdTREdXJvNFpUM29pNVgz?=
 =?utf-8?B?N0FaZUtNYVUrblFIUEYvbnltYmEyM250WW1IZ3lGVnRQMERMTEc3V2NBL0Y0?=
 =?utf-8?B?Z1RONFJ1anZ2dWNsTm9FM2RrbHVWL2N1ZTJUaFlHdFRPZnAxa2llTWIySng0?=
 =?utf-8?B?a1ZhVDBISjVpWjlrQVMyZkMwY0ZrR0o4MzMrNUphdnFoQXZHNmd1WXB3ZkJV?=
 =?utf-8?B?T2ZSTHBpcWNOMnlVTjJpZmNWd1pkUzN0bEUraStaQVcyWm5xa0dxVjRNcnlq?=
 =?utf-8?B?OHRBUjlmeGZkNkFndURPRWdyMEw0aE1XYnJRczJOZ05kVHhXemtMQ1FNUFNH?=
 =?utf-8?B?VGo2eE5GRnpScTJrdy9hTXdtbGF5bWNUL205akdobUN3QytHa2FzVDlQQ1Fv?=
 =?utf-8?B?ZElUVUFwKzJxT0ZhNCs5bWlIVkJrOVNPNGpMVlpHTUYvaTd4Rjh2c2N4WnJR?=
 =?utf-8?B?SmtuakMyZEZ1TnNneGNpZzhWcVBabWgrdFhiR1dCK0RtK25GYmhWZkF4ME5s?=
 =?utf-8?B?NUVCYWdjUG96MFdHN0lsaC9TMHJHNFdmaEFQNlBncnhPN2hidUZoOTBadmlC?=
 =?utf-8?B?Ums0VGlHSmJrUjR4ZVF6a3k3UHU1MFdUelFrS0FSclFJSUJtK2YrL2FHL0Zq?=
 =?utf-8?B?dk1aaHBNK1BzZ0llc0FnWTF6WFd5VkNwL3h5RDRjQm1kYlRCdjNBc1NwVWxC?=
 =?utf-8?B?T2JWQ09RY29tTDIwYVBZWm1JY0FOV0I4dU5SeEIvWjZNT1U2WHRlMThsbVk1?=
 =?utf-8?B?T1h2T0paUzZlT0pkRG5ITE0wVHliRFVKVkxYaFJXY21ibGJ5MnBhQS9uSjhz?=
 =?utf-8?B?dTlkRkVpYlBUc3hZYWJaWGlrRW05TjF2cVUvdnhFWFowcEhobmk5VmNyRzR2?=
 =?utf-8?B?aGttMEhCNjVoS3pYWStpb3pibWhjN3lNcXRLZW14akdoN2RDYlZyRVh5cmNv?=
 =?utf-8?B?Q1pVWHlKNS9WVXh1aGVGQ3RJK1o2Ui91bVhXcW5MTVp6QzNaS2xTdFJsR29v?=
 =?utf-8?B?a1ZoN1Q4TXJ6OUVvcTBWL1o0RFNhTE9zSkdVM2czd2Z0Z1UxSlo5U3d5TTVp?=
 =?utf-8?B?ZkloZHN3UktuSElXMUZzTXh5cGtmZ0dnOTU2Vkppd3JJNWhUL2ZQUWdJWWpT?=
 =?utf-8?B?VExEb0M1Q0VkcU10NmxHNUNGY0lvakd5Qmloa2Qwb1RnSVZNbTRUZDhFMUg3?=
 =?utf-8?B?VmlDdTZsY0QyVFZpMjVxNlRHSktvV21TRnlZTEdMaWFId0dPSU9iN0NSbTJR?=
 =?utf-8?B?d3dzTmhWVVVQbG1uWm5QZHRJSytPUFppbXdjT21GY0JESHM4V0VZWXBaYXIr?=
 =?utf-8?B?cjREdWgrUmdYa3RySFE2TmFKQ0F6WHpBV3hKNUtvYXk2ZzRoL0drUUJhVDhP?=
 =?utf-8?B?amJPdlpyL0txRWVsZ0hBdFpDTktJdEllUHFzdVJBa3JIVmdFRFEveWRENjcv?=
 =?utf-8?B?bE0rcDV0eTFLVzR1akJsWC9sV3ZDSWp3ZHpaMUl6V3I2UU9zS1ZnQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b9223b7f-b7c5-4a14-5970-08def8cc98c6
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 23:51:15.4170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IM0aEU3tziWvF1Io948ItfyaVJ+87HYR5NpSao/OQ6p/bnRJNrNkOFOLb4mV6pQLdccCMErl+vUHit24+A0Zmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6177
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

On Wed Aug 12, 2026 at 11:32 PM BST, Danilo Krummrich wrote:
> On Fri Aug 7, 2026 at 3:04 PM CEST, Gary Guo wrote:
>> On Wed Aug 5, 2026 at 9:39 PM BST, Danilo Krummrich wrote:
>>> On Wed Aug 5, 2026 at 1:32 PM CEST, Robin Murphy wrote:
>>>> To be fair, that is sort of the intent in the C API as well, to be cle=
ar=20
>>>> that DMA addresses must not simply be treated as physical addresses, a=
nd=20
>>>> aren't necessarily address-like in general e.g. comparing two=20
>>>> dma_handles is pretty meaningless, since they could have different=20
>>>> values but still refer to the same underlying memory, or vice-versa.=20
>>>> Adding or subtracting offsets within the bounds of the original=20
>>>> allocation/mapping size is pretty much the only arithmetic that _is_ v=
alid.
>>>
>>> Yes, I did suggest a dma::Range type [1] for this purpose, such that on=
ly this
>>> kind arithmetic is possible to do.
>>>
>>> The dma::Range type should have a method returning its embedded raw val=
ue which
>>> then can be used to program registers etc.
>>>
>>> This patch is only an intermediate step, that clarifies that intent of =
the
>>> current usage of dma_handle() (or now dma_address()), which is not to s=
erve as a
>>> handle.
>>
>> I suppose with I/O projections now it's rarer that people need to operat=
e on dma
>> address directly? What do you envison as the use case for `dma::Range`?
>>
>> Also, I suppose we can also represent dma address ranges as `Io` views t=
hat does
>> not implement any accessor methods, so projection still works on them.
>
> Yes, that covers most cases. What about SGEntry cases and CoherentHandle?
>
> For instance, in nova-core we currently have
>
> 	for sg_entry in sg_table.iter() {
> 	    let num_pages =3D usize::from_safe_cast(sg_entry.dma_len()).div_ceil=
(GSP_PAGE_SIZE);
> 	    for i in 0..num_pages {
> 	        let entry =3D sg_entry.dma_address()
> 	            + (u64::from_safe_cast(i) * u64::from_safe_cast(GSP_PAGE_SIZ=
E));
> 	        dst.extend_from_slice(&entry.to_le_bytes(), GFP_KERNEL)?;
> 	    }
> 	}
>
> which could become
>
> 	for sg_entry in sg_table.iter() {
> 	    sg_entry.dma_range().for_each_block(GSP_PAGE_SIZE, |addr| {
> 	        dst.extend_from_slice(&addr.to_le_bytes(), GFP_KERNEL)
> 	    })?;
> 	}

If we have `DmaRange<T>: IoBase` and `fn dma_address() -> DmaRange<[u8]>`
then you could imagine doing

    io_project!(sg_entry.dma_range(), [panic: i * GSP_PAGE_SIZE..]).address=
()

A caveat is that it's slightly tricky to implement `IoBase` for `DmaRange` =
due
to the ptr_metadata feature being unstable... That said, this could be work=
ed
around.

Best,
Gary
