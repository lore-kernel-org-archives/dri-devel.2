Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9B810A3D80
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32FCB10E99D;
	Thu, 26 Mar 2026 12:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="PYzdRwiV";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020110.outbound.protection.outlook.com [52.101.195.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544AF10E99D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 12:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7uBUj3V6/mLnnBfITJ99CRcDNs1mrKY/E8mwYEwwd/x4II096ndX24HNo+nrLGhEvSdp1bZ/qX7Sk3AoKAmGCx/DlN/WTcwHJ4LSYye5vVDASGp07cvAo5Cdvcz4oBaToIk6FvrR6A/LZCYeUzdQaTZF80zg0yDnW2pc72gtjGgBNt1Sx44JqAIY/beNSKL5S9ZL/6tW3wnHUj4jM//h9/X2x4ubITgdsERkkyjo1EXhTweXLmFvzmsg/erjSLMTzeiUmvamAfgmJ3SbBNJw/hOfVM9cnDdn5AaA+p7DgA4++Bb1BRvTJNb0YByzf/0WNUPtRAwqgtGgwCfjt4yGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBO1wypXs8uBRvRt6Vo2arXt5v9vAbFzasEfK+4flzo=;
 b=DCpBAXclGtFLFCAmLVjJwuaBLTk+w69WY7weoUM9DNi2ZdpPybUxgZFypNyYOe2cxwS+nhhoJkLu0qlIj6ZroCMVcmOBmgeX+d9DREVBB5UXlBnBN30/N7+s9ypOqoaWPQ7Pevm++7XHb9JFuCPGM3y8to/BrHp7Huk1iaLicYP7hBD+QFlm6CaV2m/X+HKE0+K2KpXR0WjSCcVC2+31ty+IFpHtXM8tNmnt+pK0qvj9a2SH8fdChAusbceJV8NuWdOFIRnFu8M4hb316Qk3jpOI5APx8L/tg3S/OL4el0TrXlZuhCXPprfQaUGzFaKvSRzCv6F5gzK6p2blkPleEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBO1wypXs8uBRvRt6Vo2arXt5v9vAbFzasEfK+4flzo=;
 b=PYzdRwiVotod8SL5MmymskDvdGPdhusgzkxBa+qgnMKSDUcyQhVcCe6kcjdJ4+9FUqKDMKWxwJuAZeKys5SoZy5gXteqyFpEOttV9lJHJm2i+7jhrS0RnZHO+cj2SfJd4gYAYkPCyKUblZU0SVgtmWd1SvGdV+3tyD78Tcao2E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5352.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:25b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 12:03:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 12:03:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 12:03:31 +0000
Message-Id: <DHCP6NB4HWXT.2L5XXIX1HNPRY@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
X-Mailer: aerc 0.21.0
References: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
 <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
 <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
 <DHB40HKJD3OC.OMC04LASMS4G@garyguo.net>
 <DHCFJSHKE4ZB.3M1FFI3K5R670@nvidia.com>
 <DHCG03J1G63T.1A973DEM7DHQ3@nvidia.com>
In-Reply-To: <DHCG03J1G63T.1A973DEM7DHQ3@nvidia.com>
X-ClientProxiedBy: LO4P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d068a5d-e828-42d6-840f-08de8b2fb34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: j/d35ceA0KsO06m8Jo8R5CI1mcGAIgak/mKYvnENXK0MEgdptk0QQv5F9ybU8bu3kOk2qu60EXbly17iDwK32Mf+ytmHUM4rrXNtuOT8AclSIBkdRfq2KYkd/2N1sFRbiwAAUL5/A4D9SFZZH8dv3eSyNBbyqMK4JcywnPF2d8Cj9gj6k2fi9ywWHnktIl800FhCjDAXXVU9pHgWLw8Uc6O5kELxsun7/o52bkSKOgVYELtrk5M2ZZEYHTWGQ9MDQSdnK1WcoEJo19lr7h3nE4kmPGcJ0cGUG7h4vrR5rMHSRzyBPxXzFZ/f9gq6g6qD5TjdxmT2C9Y1abz33vSMlz3+zakb0EH/b0K4bgHcNfH3YMjAhbAt/ZvBegeCMW+PT14MnjPabN9tZQGAtyh5Wg3Ojz449PGhmAONpifZt3FbQWkAEpn3862pMJI0CchDzQq1Jv57bJ2U4BEh0fFzwAJ8o6ZsdkCcYm2veATIbmxI8Xthxip0r+osprRlKewCZi3lRl1W5b9dX5ec9YHpeLQFA0NCE1iVMbUvUXK2H9DZzW697WAT9+Ux5mwz0nwEveOSmBMaErKM7Y0mCrM3Z8QPOmy0tIVVoBTN4T7qd0C9K8E4jTBl3oTwivf7Uyv/FvxN0QcZHO08gFUt2CxRFSE4kyffrmit1huBBndh5bWiJT84x7Vq1VX6mb7gnNPF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFQvQXRqREtxazBPNll4MFhsSnUvTStLNVNYc3R1cXp4VW1tS3hLUi9QVllF?=
 =?utf-8?B?dGdsQjRhS1piemppVHAyL0oxTTFCaFl2dkljKytPTEl6eVozL296M3JpNHRw?=
 =?utf-8?B?alVudndiRmZURDEyRS9STlZZSFduY1E2TEQ3TC93a3l5ZGp6ZjRRSThZT2Ri?=
 =?utf-8?B?WkIzVXQ0S01MNllYV3RLNTNPMmVKQlRKUExBQzY0emdmZHlMMTJlZm45Mksw?=
 =?utf-8?B?UFJlNGpVN0JBbE1JMzRaVDVMS1IwYTY1dDltczBwUG9OWGlwOGNvWEpOZXdJ?=
 =?utf-8?B?a2xGbjRZRUpJREYyejVQZ1p6aHYrbWFDVmJuSkcycXhzY3NZMFd4Q25ncEZY?=
 =?utf-8?B?RFBJQVFrdXkwRUp0d1ozT1daQmxqYk9xVkdobXdpWUlWUHF4MHJqTjhNd0lJ?=
 =?utf-8?B?Z0hCb2lSOVlkejNEbFRWNzB0QWh0enVKYTFaVHh0RlZXTlR4ZUVZazJnMVE0?=
 =?utf-8?B?cFRYVzlsaEx5cTBnS0hvaUVBSVp3dHBoK0pSZ0JKTVVxRDZ5czVIdmJuWWRj?=
 =?utf-8?B?b3VLSFNDWTRXZkQxcUdIQklHSk9MbzU4Mis2OW4yLzJ2MUdLQWE2VGFyc2dI?=
 =?utf-8?B?NU81TGJ6SlJmVm5PUkcwK2xlYi9ia2hYL05QQmdONFNFenQ5Yk9vSXNXemQ1?=
 =?utf-8?B?NXRzdzBvVGpNSU1YN2UvMmQ4QUlreEEzYXJRaUZxM3hZQW9qSk9ydURUM21W?=
 =?utf-8?B?eUVvbnlnK3BBY3JZUDJnSDNMMmUvMmE3eU5JM2VmcVVobEdvbytJdll3Mm80?=
 =?utf-8?B?NWphejZNaXBpNjBHQWZyVDZwRWVPWFdrYk9Ka0RBbVhReVY5MjZmYTArRUV5?=
 =?utf-8?B?L3RCYUhZYU4zOU43OEduZzJjaWdXaXVCK2lpQUlZaHF4ZmlyekpReHg3VGcz?=
 =?utf-8?B?b1dlajlLeVV4SWYyamJleHZQSmVhY1Z2QnhWYVFYcnhzam9jbTZVNWJqYTF4?=
 =?utf-8?B?WUswdkhMKzhHOStHQzh3K0pKSEk0UkVMSEJnMlpFVDBZWnppRlVSMUpZT1I4?=
 =?utf-8?B?YW14TGpjN2E2bkNtaXhLWUFKQjI2bkVKSzRFY1REdjRWajdlVjkzU0VBaXUr?=
 =?utf-8?B?NUN3Ry9BU2pYam92YlpXS3g2WUI3dVlFL1Bvelg1b2N4UjJLM285Y1cvQmc2?=
 =?utf-8?B?YTJUR0hoTkM2YWZPejBwWXJtSnA5ZWF1VFNXc0NSQU5iR3BGajFMbzBYUmNu?=
 =?utf-8?B?TzVhbEZuZmN6OSthaDQ3bkRNdG5kRTc4Z3laWWlibjZlVW5MNG1hUTlHTlpL?=
 =?utf-8?B?d0tjbUZNY0xjV1ZJQ0NEMkkyeTJHQWhYcVpxakpZamxBNXZaa1VhSWp4SzZM?=
 =?utf-8?B?UGF1YkhTVWhvNDNKTUQzQTdkWFZkZXRCM3c3cFR6dit1QlFVZHA4RlRDTklV?=
 =?utf-8?B?c0gxRVBtWFZiVU1aMHN5WVpBR3Z3VHFSZWZlUkY0Nzg5SERuaGhsTzllWGJm?=
 =?utf-8?B?bVBTWWpST21OSEJSVVN2M2E1VTZTZVRFTWJiOXdqT1BaYk42SUtKNVBMYk45?=
 =?utf-8?B?UWcrS1ZGN24rbUczQ0JsWGUwZytLd0k1THhoL3NMZUMzZFFnT1c3ajBRbTF3?=
 =?utf-8?B?VFNQb0VyRVlLVzhkeWtPZG1zVStDWFZwRmZsM29pZ1JuamZaYjd3YmJtV2xi?=
 =?utf-8?B?YWZWeUtEKzFpeDhUdUJKNXlVSGFpa1ZzcUx2dVNjSmdpUzdwRWEwYm1aVDVD?=
 =?utf-8?B?b05BZksxNlk5UXpPV3c5SExWeWZ5KzVzU3UvbkZ4N3NvRXQyZ0pHUitaTWV3?=
 =?utf-8?B?eGhhSWU1aFZMN043Sk1QUVNjMHRXT3E2dXdXSDMzN2tJNWh1aUM1VHFkMkQ5?=
 =?utf-8?B?UjZzUFdQcjRYd1crc1k1b3NBVUR3TUJZWXUxWUpleS9QajBtY1dpVDNGQ0RR?=
 =?utf-8?B?TWRmTEoxdjFzc2dHaTlDbnJlcjdqM1BWL2xKMkdlNEQ2aWsrai9jdFFkOEs2?=
 =?utf-8?B?cWJDYjNGdWN1cVNhT3ltdy9NVjIvaG1ac2d4WWRKMHMwS3cvd1ROM2lBREhH?=
 =?utf-8?B?TDJtYU1vVTBpREQ4S2JGL1REQTV5OFBOSnRnRWRtZUN2eG5OWHU3c1dnV0o5?=
 =?utf-8?B?ai9UM2RnMEpScEZIMGM3eGZyc0V6OFVEK0s2dWczT2wrbXhIYWw1cmF4SzNt?=
 =?utf-8?B?SHlxN3VSckNDcERnWGFkUkNzNFZ6MXo4MU54UkpEQUp1SzJxbjh2MWJ2RlFi?=
 =?utf-8?B?UGVhS0F2a1FGd0NpTmUrem5pblUxMWlOMEdVNnRMb25lNXZkb2VXb01EM0VN?=
 =?utf-8?B?NXR3MFNSS0YzQ1pnT1p1bUttK3VpSytJMEJoWlFvM09FUTZzZXEwNCt2ZXJl?=
 =?utf-8?B?dWFIZDEvaXNwcW1vS0tyT1pkMTVNOXl6VFdxeCs5VndkK2cvZXVyZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d068a5d-e828-42d6-840f-08de8b2fb34a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:03:32.1937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcUQsnyQ8SOTIt+atnkfie6JoiQJYMBNYto9VhD1rwEGRVnxQtbhOqoLsTaE4W31h2MijDqtOr8FiKzfNtiKqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5352
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

On Thu Mar 26, 2026 at 4:51 AM GMT, Alexandre Courbot wrote:
> On Thu Mar 26, 2026 at 1:30 PM JST, Alexandre Courbot wrote:
>> On Wed Mar 25, 2026 at 12:15 AM JST, Gary Guo wrote:
>>> On Tue Mar 24, 2026 at 2:44 PM GMT, Alexandre Courbot wrote:
>>>> On Tue Mar 24, 2026 at 1:44 AM JST, Gary Guo wrote:
>>>>> On Mon Mar 23, 2026 at 5:40 AM GMT, Alexandre Courbot wrote:
>>>>>> `driver_read_area` and `driver_write_area` are internal methods that
>>>>>> return slices containing the area of the command queue buffer that t=
he
>>>>>> driver has exclusive read or write access, respectively.
>>>>>>
>>>>>> While their returned value is correct and safe to use, internally th=
ey
>>>>>> temporarily create a reference to the whole command-buffer slice,
>>>>>> including GSP-owned regions. These regions can change without notice=
,
>>>>>> and thus creating a slice to them is undefined behavior.
>>>>>>
>>>>>> Fix this by replacing the slice logic with pointer arithmetic and
>>>>>> creating slices to valid regions only. It adds unsafe code, but shou=
ld
>>>>>> be mostly replaced by `IoView` and `IoSlice` once they land.
>>>>>>
>>>>>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bin=
dings and handling")
>>>>>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>>>>>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kerne=
l.org/
>>>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>>>> ---
>>>>>> I didn't apply Eliot's Reviewed-by because the code has changed
>>>>>> drastically. The logic should remain identical though.
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> - Use `u32_as_usize` consistently.
>>>>>> - Reduce the number of `unsafe` blocks by computing the end offset o=
f
>>>>>>   the returned slices and creating them at the end, in one step.
>>>>>> - Take advantage of the fact that both slices have the same start in=
dex
>>>>>>   regardless of the branch chosen.
>>>>>> - Improve safety comments.
>>>>>> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9=
f6e8f3ce3@nvidia.com
>>>>>
>>>>> Here's the diff that fixes the issue using I/O projection
>>>>> https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@=
kernel.org/
>>>>
>>>> Should we apply or drop this patch meanwhile? I/O projections are stil=
l
>>>> undergoing review, but I'm fine with dropping it if Danilo thinks we c=
an
>>>> live a bit longer with that UB. It's not like the driver is actively
>>>> doing anything useful yet anyway.
>>>
>>> I want to avoid big changes back and forth. We could use raw pointer pr=
ojection
>>> today, which could be fairly easy to convert to I/O projection:
>>
>> Thanks for the diff. I have adapted it to work on top of Danilo's
>> suggestion to compute the end indices first as it works just as well and
>> is cleaner. I have been running into a link error with this conversion
>> applied though - let's discuss that on v3.
>
> Mmm, I guess this was because the optimizer could not prove that the
> slices were within the bounds of the command queue as the expressions
> passed to `ptr::project` were too complex with that version and this
> makes the `ProjectIndex` check fail. I have better luck when doing
> something closer to the diff you pasted.

I'm considering switching the projectiong `[]` syntax to become panicking
instead, given that the slicing use case quite often is indeed hard to prov=
e
(and also, we already have panicking comments).

One option is to just change `[]` to do that, another option is adding a ne=
w
`[]!` syntax to denote panicking projections. I'm more inclined to just the
first one to keep consistency with Rust slicing syntax, but the second one =
is
okay to me too.

Thoughts?

Best,
Gary

