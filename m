Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25CEC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31DF410E044;
	Mon, 29 Jun 2026 07:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fgULqBQP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504CA10E044;
 Mon, 29 Jun 2026 07:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCRNeg7HEz+9K/IjixE8M0r4UnmCUoIQABjre0/4Rz4RBfv8Bu3izCa7kwBqfeSr9EzYUsRP4sN6fAgeryAVYxnVQg7J91e9QTEFwgcFw/kqFJZU4ppPuaQ016KYH2FALTecEAWedJGuYUMTxQQKJPXB7SEuS49H8ec9VnVqIZ3vIVF0h4ruGndpmSk1PTTyE2izkQlm4qaXIH1RlyBYVwz4hL0xUEdq1QpHDzCYd8vMhsh8qywulw+9/lXhHlUHTiNF1W53EAey8/Gm8AwPiocBFOi3vU5JBiX2EaikGrHaID68XWcsYUeqC7GtS3YLYqGDAEvccLBWSa/Y09wYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba0TW5byYSBvv8g4I4jtWT1FEsA26V85VFr2F9GLDW8=;
 b=rWib+73aaZcMFFGJREOumvksKL8E0mPMLhjGpSTwUFqAbF8XpMek/udu9qsHexgc5sGrWhIlXl7K29Km2lw0/wi/Qmvd9vDgLbgli4FeWrmzVZP+WpCaVXQm/GvdBLTD7/jbx651RhuyQ01Zc9bASEf4aGFw03aM2pe/51CJU1Dt+29fOWGhYWcNducFgPHm+j4vhQfFvOldQAQHSipJErO4skY/qUf6MngdspF+cDXGOitPnydGbR41rvhQoVIGAxyJhdSMkbkykyn0o6Hsw9MIZswn7CLy6sASiu84EtZfe+nbptLfC7ssyv6MKH1g65TdviM7WvJs1272wI/YKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba0TW5byYSBvv8g4I4jtWT1FEsA26V85VFr2F9GLDW8=;
 b=fgULqBQPPcNhMosEGqKZLy23dRretfRBHsJMGDj52PSuRSI5SS+QnQhRknbCffqB5dq2M5mgSqBEshjlMNDz8PFagnGac+kfORf8wHu9qIj6EN8Fp8rlWg4P2SnYhTaLarTqflf+AzKlsliWNLU9UR6vAohZq8OBF/mLulN5gpzuY7bofNJGxqHUjXh7ThcZ71sxr/BA2ZCgAnsJPVjSCatd7C12JYwcwW8ireybNecUN+NIsndVu1O6C66OsxzlUTZUxtculWzAYJn0fV94Qpgo4kWZgerF1VVJqbmdDLwOyvtkClDO1kvFPWC517yp5DyfauvGA+d5F5vyUWiigA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:49:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:49:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 16:49:10 +0900
Message-Id: <DJLD9NK839PY.1MNE49NII0BGS@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/6] gpu: nova-core: gsp: move boot code into local closure
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
 <20260619-nova-bootcontext-v1-3-45193cd0a2e5@nvidia.com>
 <DJFF1W6VGY4Q.2PV5MEPMFXIDB@nvidia.com>
 <DJFO5A5XN2EO.22B58J2O6D4JG@nvidia.com>
 <DJG6S20KHJK3.TKRZLBYUPGG2@nvidia.com>
 <DJGZX2MGM1DD.3VAEGR7G5QVBE@nvidia.com>
 <DJH2L8IY3GGC.3NBPX6YNGPL82@nvidia.com>
In-Reply-To: <DJH2L8IY3GGC.3NBPX6YNGPL82@nvidia.com>
X-ClientProxiedBy: TY4P301CA0104.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a94c5e-1c06-45f8-a69d-08ded5b2ecb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|23010399003|376014|10070799003|18002099003|22082099003|5023799004|11063799006|4143699003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 0iPXdnPs3rvcA+pTCxDQaA+p43Se7rF1EX2YclMD2me+56iHOHccVydWcMwiTBwx19vD4boqtgnvP5LBlBRIZTIEaHBYZ0jZKp85PrCmRN9jmE41BJK7lbrtwIXEt3mhDevB76NLL4lvJ1AXorZqdyupFg3NT9O2BpacN4ADGO1SfHz1l4bM+wo97tvPx8Y3XXHlcItytR/Scukx1IrqcqmbfBUR9/YXltcatd8buB1yzSIVtMPoqNRISkq4Z1EUKyFOogB5Gebgc8KDJrFTUOsHJsTPNvbZ5NCzCMrGZrVAAkY5eKnpBTvoGOG6PX+UQhfqdy9+a3HMRKG6KnJOrkGaGS01cKpa7AKp8EaDD8YcjYbgYRVYtfR17ZdSfmgfa0S4MrpzQTUJlTj8rj/Ij+wkrnp4//K6Dx4nYDZKMLcIZl6nuGY+TQ+JW8Qpl9pnjzNJlNE6Io5O0QCC1Lx75a4B58WGqrY21FP9yIY4Gffcs/EjHWMAM4bXhzh/GgCTYm5dkoo61K7dQx+7mUXHS5LRkxDUG8LqMU9TWDAjpF84RsYD/sIdA+Okvxlb/P/h6M8HUUEmW8m/9ZOF9NdMN7pph1Av3O9LvR9v6/aD7Sx/sXIiO8nzSvJi/Yzw0i+y8EhlITvLQ/6CXZXiVHR+63l9Kqi0FED8lK/bwx+z7Dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(10070799003)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZSODlabjVSQlFYOEcrdDU5c2pxSHY1aHZHOS9EVVljWDVTYWpVeHFnQy9m?=
 =?utf-8?B?cmtQQmNyS3U4OWoyR0NzMW9BVjRhbmxweGs0NnNrY2laUGNjMlptRERjTW1I?=
 =?utf-8?B?OEhkNnlLWGdrSHhZL25MRXF3MWpFYzFVdzZUc3JiV29EOGhJRjE0aDMyKzhN?=
 =?utf-8?B?WlZxRzZHUk5kMDlNRDNnWG5pb2VYSTB4SERuR0Rucm5IVlcrSjU4b2lTTEN4?=
 =?utf-8?B?UFhJdi95Wmtzd0RiOGdmenVOelkyeVlna29tMkR1M3AyMU1FMWlwU1NnWDlS?=
 =?utf-8?B?WnVOd3BQRGc1emQrUHlZRklFYTltVHBwdmd4R3NoTjRxOXJERTArRkxjV0s5?=
 =?utf-8?B?cHB2bm92RWFocitHUlhNZENObnc2UHY5ajhVaGJGQ1J1Y1JhMitWQVEvSTVk?=
 =?utf-8?B?dGNreGJiZWVjWmRRTVBaeDR1R1RyRG1oVVRGVXlseU05b2dVRWxEVnpRWEU5?=
 =?utf-8?B?b3FOZDd2b3FpRm1md1FONjFDREdRUkJYRWdiYnN0amdGUUtscDJCaFFKaWFI?=
 =?utf-8?B?YVVqR2d0VzZhUHJZT3RqTS8zeHJQUlRnTVNFbnZXdmtPQkhXb2hvNUNjWW84?=
 =?utf-8?B?bzVRdjhDMnM0UnNkSW1RK2d1ZGhpRVBNdzFSc1o4a1NLYWpPL2pjL3JPVW9T?=
 =?utf-8?B?VGpvakZVZ0E1ajV2dElWQjUwRjlYNzkvZEZHL0ZIaldBSmVCcUFDcnlkK0tQ?=
 =?utf-8?B?Ly8xSnY5bkhjSDY2SFZNRytYNUZRZXVUeUd5d2Q0QVMyUzJGem1LblY0a01x?=
 =?utf-8?B?M2dIRzlEVmRhQk95U1kvQjgrVGpJMXVFaG15UEE1RlJLMkU3b2pCV2ZtZHNt?=
 =?utf-8?B?ZjZGRk52TkljMmFBYVFEZW5kcnlRazQraFNhM3hFN3p1eWxQRmR6YkYxR2pZ?=
 =?utf-8?B?TXpaTXpDRGFxTE1rcWQxd2JGY2J1aHIvWmtmTGRjTUJlSGY3UTZhcUhvSnBL?=
 =?utf-8?B?SE9qdnR1YmxHTXJxWW51VUEwUVdsSFhTUW5KQUI1QUlCYlpBcCtIRXRaOUpz?=
 =?utf-8?B?TWZpRjBlUEphQ1V0VHdQNGZWcVBXZXpaUGxGSnNyR1NweDdUa2NEMVV1Z1BY?=
 =?utf-8?B?RXVZVFQ4L01pUnQxamF6TXlIVGpUay9IYVphNDhmMTdvMmxYLzh5MGdYVHMv?=
 =?utf-8?B?QkRNMjNjbktuS016K3FCcmhGVWRNeVdRcWNCdzFoSW5tZWlSNTJjSkVtWE5T?=
 =?utf-8?B?RlNzYUZJMStFWGFqcFliTnQ2dUcyM2wvZUZzeTB2OHdCcUp4RHBlWWpaSXpZ?=
 =?utf-8?B?ZkZQaWNUM2hzTHhLOTBGUEVLNTI4dXlCdFZLNjNyV1VtdWpuaGl6UW1OWmtl?=
 =?utf-8?B?YVUwRWxnVkxIVW45bnJzYWVyRmlTQzJqV2JIWWFQc1dJcUptdnRtdW9OdzVl?=
 =?utf-8?B?Mm54MUlpK2tBTXptOHNoL3JiQWNCS2NwSkF5THVGdU9LNUtCMTltVDRUOEsz?=
 =?utf-8?B?bC9QYXlIRTlNaXY1WlJmZENCVDFTc3JLWVVwK3g1MG9PSEREN0ZFS0dGd29k?=
 =?utf-8?B?WkRCRi91TjU0NWdkMmpFNFZCN3VqbzRxR3BVdm02dEFQbDdmQmF3aTVxUEdt?=
 =?utf-8?B?dE84RnF4L1Q1Q25sTUl4cWhBWFVpSDlsdmRGazJKT0pGd09qbzk0OXVxeDR2?=
 =?utf-8?B?QTFFQzU0SUV5eElMY1BMeWpIUmVYK3Nic2gxWmRYUzU1VFZqK3cyU2g0YnRG?=
 =?utf-8?B?RSsxMHJ3T3p6S21KRG9jc2ErZXJwYWRMb1pwRkZXRmZPUHd4WnZtWTRXTnpv?=
 =?utf-8?B?bkpsS1dtQllMM0NGVmN5cUVpdTR3S2dOTmpEMEUzOEdxY0FSRHNkdFRrY29j?=
 =?utf-8?B?SkM0VTlDanJPMzBFUXdhQjJDQWpPVEZKUEh5MlJFbDQxL0RFYjNnc1R6R2Mz?=
 =?utf-8?B?dkdPSnNOeVlpMk5xNUdueXk2UWZnYXgvMmd0d1Era3Z5NnprQXl6UmNNSmpt?=
 =?utf-8?B?Vmg1aGVvWFpIczFjTnZqbG9iTUxKaUZtR1JlWVp2OEd2eGhVUGYzS0lrVkRx?=
 =?utf-8?B?OVNmUmtLdlo1bkxmWWRXYnlWSC94TVZoczM1VzQyMERrS2FvV3BsWGpWd0t3?=
 =?utf-8?B?NHBJWWhGMUk5RU9nYXJGaFJpaFFTUjhsaSs0ZTVrOVJBR0c3b1BaMElMLzZh?=
 =?utf-8?B?ZGxlM1NWZG02aWhzRFRwNnQxZnhYMGxJV3BkNjdxL0xRc1hlWTc1ZXV3cTB4?=
 =?utf-8?B?Y0N0RGgzQUJSU1dybEM0ekV1VzJ5ZmxEdjVYQUdkaEN4cFpCNUVaV1lZVFRH?=
 =?utf-8?B?b1hmY21QZWNYTzNBcVVIUWdQckNOQnRXQWdkV2FkTUZwdUV0a1owYU9oeERo?=
 =?utf-8?B?S01NajFNWEpOYUQzR0N0K0p1akg1bGJmd21OTXJKTGoyNkxXQTBzRnhaNkhO?=
 =?utf-8?Q?rOKZOV8P8BrS4PLAxpV+6EU77krRayLkH1QrCwiKn2rwi?=
X-MS-Exchange-AntiSpam-MessageData-1: CN1j41bhkCXVhQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a94c5e-1c06-45f8-a69d-08ded5b2ecb5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:49:19.0142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVD9pM26SMExYOa+LatBQ3CwRmtKXSYZ+iaPh2jaTpPqgu2zNqPTjQlevXN7BcJKMKVZgKGWTP6R9a3NVAXNmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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

On Wed Jun 24, 2026 at 3:36 PM JST, Eliot Courtney wrote:
> On Wed Jun 24, 2026 at 1:30 PM JST, Alexandre Courbot wrote:
>> On Tue Jun 23, 2026 at 2:40 PM JST, Eliot Courtney wrote:
>>> On Tue Jun 23, 2026 at 12:04 AM JST, Alexandre Courbot wrote:
>>>> On Mon Jun 22, 2026 at 4:57 PM JST, Eliot Courtney wrote:
>>>>> On Fri Jun 19, 2026 at 10:42 PM JST, Alexandre Courbot wrote:
>>>>>> The next patch aims at replacing the cumbersome `BootUnloadGuard` wi=
th a
>>>>>> more local and less intrusive mechanism to run the GSP unload sequen=
ce
>>>>>> upon GSP boot failure. Doing so requires running the boot code in a
>>>>>> local closure, which changes its indentation and would make other
>>>>>> changes difficult to track in the diff. Thus, this preparatory patch
>>>>>> moves said boot code into a local closure that is run upon construct=
ion,
>>>>>> so the next patch does not need to re-indent code that changes.
>>>>>>
>>>>>> This is a mechanical preparatory patch to make the next patch easier=
 to
>>>>>> read. No functional change intended.
>>>>>>
>>>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>>>> ---
>>>>>
>>>>> I agree with removing BootUnloadGuard, but I think it's not great to =
do
>>>>> a bunch of lifting into closures then manually handling the result. I=
t's
>>>>> error prone imo (we already had several bugs relating to this kind of
>>>>> thing). Instead, what about just using ScopeGuard directly? This lets=
 us
>>>>> avoid lifting into closures (which is a bit noisy) and avoids manual
>>>>> result handling for failures (which is a bit error prone). With the
>>>>> `GspBootContext` it's fairly easy to do now:
>>>>>
>>>>> ```
>>>>> let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |unload=
_bundle| {
>>>>>     let _ =3D gsp.unload(ctx, unload_bundle);
>>>>> });
>>>>> ```
>>>>
>>>> Yes, initially I wanted to use `ScopeGuard` but ran into issues when
>>>> trying to make the references mutable. However it looks like you have
>>>> been able to overcome these issues, thanks for taking the time to craf=
t
>>>> a patch!
>>>>
>>>>>
>>>>> I confirmed that it's also compatible with the v2 of this series that
>>>>> has the mutable Fsp - you can stash the context inside the ScopeGuard
>>>>> data (then making a &mut reference to the stashed context for brevity=
)
>>>>> or have a separate unload context type that doesn't use FSP or someth=
ing
>>>>> (could later be type parametrized along with Gsp, for example).
>>>>>
>>>>> For example here is a rough diff on top of this patch series (you can
>>>>> change the Result<Option<UnloadBundle>> returns to like
>>>>> Result<Result<UnloadBundle>> if you want to centralise teh error
>>>>> handling of a failed unloadbundle although currently it can only fail=
 in
>>>>> one location):
>>>>
>>>> Yes, looking at it it looks like a cleaner approach than using closure=
s.
>>>>
>>>> The only thing that I saw as a regression is that now each HAL needs t=
o
>>>> call `Gsp::unload` itself in its own `ScopeGuard`. I don't think that'=
s
>>>> the HAL's work - `Gsp::boot` should be the centralized point where thi=
s
>>>> happens.
>>>>
>>>> But we can make both work if `unload_bundle` is passed as an output
>>>> argument to `GspHal::boot` instead of being returned:
>>>>
>>>>     let mut guard =3D ScopeGuard::new_with_data((ctx, None), ...);
>>>>     let (ctx, unload_bundle) =3D &mut *guard;
>>>>
>>>>     // `unload_bundle` is a mutable reference to the
>>>>     // `Option<UnloadBundle>` in `guard`.
>>>>     hal.boot(&self, ctx, unload_bundle, &fb_layout, &wpr_meta)?;
>>>>
>>>> The boot method can fill `unload_bundle` early, and if it returns an
>>>> error then the `ScopeGuard` will be able to use it. Also, and that's
>>>> nice, the HALs don't need to use `ScopeGuard`. But output arguments
>>>> aren't really something we expect to see in Rust.
>>>>
>>>> Another alternative would be to separate the unload bundle constructio=
n
>>>> from `GspHal::boot`:
>>>>
>>>>     let unload_bundle =3D hal.build_unload_bundle(ctx, ...);
>>>>     let guard =3D ScopeGuard::new_with_data((ctx, unload_bundle), ...)=
;
>>>>
>>>>     hal.boot(...)?;
>>>>
>>>> It removes the "1 boot -> 1 unload bundle" symmetry, but on the other
>>>> hand it also splits concerns more clearly. And it removes the awkward
>>>> return type of `GspHal::boot`, which come to think of it was another
>>>> smell that things were not in the right place.
>>>>
>>>> The main drawback I see is that we now need to build `Vbios` twice for
>>>> TU102, since it is needed both for the unload bundle and for booting.
>>>> But the solution is the same as what the v2 of this series does to
>>>> `Fsp`: the BIOS is a GPU-wide subdevice that is likely to be used
>>>> elsewhere, not something to be confined in a GSP HAL. So I say, let's
>>>> extract it and make it also part of `GspBootContext`.
>>>>
>>>> How does that sound?
>>>
>>> I think that currently it's confusing because we have two concepts in
>>> use with very similar names. We have "unloadbundle" meaning what we nee=
d
>>> to run to unload the driver, and we have "unload_guard" which is for
>>> running unwind stuff if we error. And for the most part these things ar=
e
>>> the same, but they might not be (e.g. in my other series where we need
>>> to keep certain DMA allocations alive just for the error path, but not
>>> for an unload later, or when we are partially loaded). So it might be
>>> nice to make these two things more separate.
>>>
>>> I think that trying to build the unload bundle separately
>>> (`build_unload_bundle`) is confusing because e.g. hal.boot() still need=
s
>>> to handle unwinding its state in case of error, so it adds a strong
>>> assumption that unloading in success is the same as unwinding in error.
>>
>> I don't think `hal.boot()` can unwind its state properly - or I should
>> say, I don't think it can unwind it better than just running its unload
>> bundle itself.
>>
>> There is little point calling `Gsp::unload` from a HAL failure as it
>> just queues an `UnloadGuestDriver` message (that the GSP wouldn't be in
>> condition to process) before running the unload bundle. So here we can
>> simply skip the guaranteed message timeout and run the unload bundle (or
>> the relevant part) directly. But even doing so doesn't guarantee that we
>> can recover.
>>
>> For TU102, the unload bundle runs two firmwares to reset the GSP falcon
>> to its original state and to remove the WPR2 region. I don't think we
>> can/should run them selectively, as they don't undo work in the same
>> order as the boot sequence - or even from the same microcontroller! For
>> instance, FWSEC-FRTS (GSP falcon) sets up the WPR2 region, but it is
>> tore down by Booter Unload (SEC2 falcon). So the best we can do if
>> something fails on the boot path is run the whole unload bundle and hope
>> that we can recover.
>>
>> For GH100, the unload bundle just waits for the GSP falcon to get out of
>> RISC-V mode, as a consequence of the `UnloadingGuestDriver` GSP command
>> sent by `Gsp::unload`. The problem is, that in case of failure that
>> command cannot even be sent as the GSP is not up! :) So the unload
>> bundle will either succeed immediately (if we failed early) or timeout
>> (if the GSP is already in RISC-V mode and stuck somewhere else). It's
>> actually probably better to not even try to run it in this case, and
>> just wait for the GSP lockdown release to try and address the DMA buffer
>> lifetime you raised.
>>
>> Which supports your case that the HALs should be be responsible for
>> their own unwinding - only not by running `Gsp::unload` IMHO.
>>
>> In any case, there doesn't seem to be a recovery path that we can
>> execute reliably in case of GSP boot failure. So making the HALs
>> responsible for recovering does indeed sound like the safest solution
>> (with TU102 trying to run the unload bundle, and GH100 doing... I'm not
>> sure what :)) and should address the issues you raised - but please let
>> me know if I missed something.
>
> Ok I think you are right w.r.t. it might be simpler to not have
> significantly staged unwinding logic in the HALs. That said, IIUC, in
> principle, it could unwind a bit better than the unload bundle. For
> example, if we fail before we send the CoT message, then we don't need
> to do anything to reset. If we fail after a CoT response, then we can
> wait for GSP to halt and then try a falcon level reset if that fails. If
> we fail sending the CoT message, then perhaps it needs a FLR to be sure
> that things are properly reset - I think these are some options for
> trying to ensure reset on GH100+.
>
> I think we could centralise a lot of this reset logic, e.g. overall it
> would be send guest unload, wait for halt, then start trying various
> resets if GSP doesn't halt. This could be some HAL methods I suppose,
> and Gsp::unload just deals with running the completely common Gsp guest
> unload + calling the HAL bundle.
>
> So that fits with keeping Gsp::unload out of HAL modules, but also
> keeping the ScopeGuard run unload bundle in HAL boot() etc so we can
> allow HALS to e.g. keep resources alive until GSP is definitely reset.
> Then in a follow up we can harden the reset process to handle more
> cases.
>
> WDYT?

Sounds good, v3 will do the following, which I think aligns with the
result of the discussion:

- Anything error happening in `GspHal::boot` is the responsibility of
  the HAL to handle,
- After `GspHal::boot` has returned, `Gsp::unload` can be called safely
  so `Gsp::boot` does that using a `ScopeGuard`,
- No closures. :)

For now the error handling that HALs do is rather primitive (TU102 runs
its unload bundle, GH100 waits for the GSP lockdown release) and I am
not sure that there is room for improvement, but if there is the layout
should let us address it.

FLR can also eventually be handled at a higher layer if need be.
