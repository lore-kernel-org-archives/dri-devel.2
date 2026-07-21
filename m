Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039E1C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD8610E32C;
	Tue, 21 Jul 2026 15:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="vEJNvq3R";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021127.outbound.protection.outlook.com [52.101.100.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A4810E32C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZOJ29kVWF7Ns1yvlZbv5QWxKDOb0hFQxS1BrkGRa4sqIR41STP3lTNk7VIIJF0YcbJIRqxRcy2lk927iXkfJojdkD/IT6fiZeMZrrmt66RTzqO3tBeemZOC9/6Jk9FccWCY3b9CcXy9VaEWPc+I3Pfwo90kr5nO/OLSmVuV/c5MyW7JnR20XmXdAIbixJG+Xf2l4iJYMrwJYpwhLsLAiNhdpfYVP4+WQpoqh/mVqylQmfvpzzapNI91OumRhzlSVXUAF8jbbacLiThHlejZrn2NrhLNYdmYQ8mi0LUhP8qyyJfJyTU2I2IO4wlQvMOxJrRdLMrecN9q2LA9J8OdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2439dyYGLUPvxySGVkJvQybXe6WHfivhyPe/hd+8z5M=;
 b=sEsalY44D2nBOjppUTcyztd61KQmQRVd2wPV2/r9JWvIsHHF4B7sPeUPd0PJo5mwH3zA2JpX3CmfZdSixczpUu+nK5hWjMOagm8D8H+cQAq22FN4LuEJbD9RfbT96U1/k8kEAZd5ytVYUUqCVpYwgF7FWUb6w9l5EJj8dvJHDd4HzIQQciAChexfPXAoIidBUm8hW0D6UpEgQN9SLVpxHlLwpgCSCwSi6PmXXi5R1pNxAM0Z8ZPxposMCqhQHtlcDaoDqdRoglidVlKekjiR+pC+SM2Xv6erWLT2Rvnz8udp5Wzr4qcbyPwrOBSCa0iLB+LNWGl2s/2M1XzUsdbK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2439dyYGLUPvxySGVkJvQybXe6WHfivhyPe/hd+8z5M=;
 b=vEJNvq3R8KGWUH90ujkFBaD3M2iZ66oBm4b8rq8xtLFQ5S/k/MnAZjqfAc8nob4iwTvvdSlHUa0yYYcQDykK5iS7/Y78pdCThNUDlVjdsNDhddcrlcFKvf0psvgSQTLaXKw3bdytmFqFoG8XKfX4njTfnICp3Rk2cF5yD/e9gh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6690.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 15:06:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 15:06:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 16:06:04 +0100
Message-Id: <DK4CC5M4H2H3.1UJYQ9LMNA0UR@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/8] rust: io: register: allow paths for relative
 register bases
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
 <DK4BO8HWCEPO.3VN9LIY5UQXKJ@garyguo.net>
 <DK4C92FSD0VC.3SXDWMMZQMC6W@nvidia.com>
In-Reply-To: <DK4C92FSD0VC.3SXDWMMZQMC6W@nvidia.com>
X-ClientProxiedBy: LO4P123CA0209.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 9873b418-137f-4278-01be-08dee739962e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|10070799003|376014|7416014|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RrMvGdoH+U+4FmYXfO5y9C75EjkVcMMl+lu0+RVUjM0sby0d+O5/jsVkK+wLyMOdVqS3pcSgYz6iY66x6b+U+da6n2oSEUxxNE725veCtfSF699JrKmuC39vJa78pVlW2nKrIgBUX/S5IcG767cTtL1VOnzkdrh67iK4DIThVUFIEL9fxZaHnRgoD/notrWPhyr1DJKUVSoWsOtH2w5rr60KxqIvLbpDKSnPcPZz8FZDwmNeGCXh+VbEj125ibiwx0QHyIjcAdiiRAz/x2fIb9Demyu6C2MB+uzwN7Wjdbupe0jIYecdYk7j+BSrILIPO8c3qqi/8Os8gWRdjV4FaLt95QlqDNUkl307UowW4xHkLb2xZGr7W0xJtfh4LfC73tK/wEcmlwyrTfppY4dXujW0v0nxq+qK/QcK9+u0CfwCH/DNeYbdqaO0RtwoCuEeO+tRvRJaW+PXN/rx3Yc0icgIGxNCQcC956NGiqGpKXEXonfO6g9LeOKQ6YW2KP9a1l5aWROHsHI+xUh6j7L3ue7qtcCSOHWPzfGacxSz4MrLZJPjgWk1FBaPOBQAvtCZIRJMfmlnbYChu34v5mHIAKYmHTAFbCaExxw168S4glfwkIqG/xJHmH3kQ+ssDVKKlFVbSaK6loFdBoHJGYEAi2bwFm2McOlPvkhTurmxz1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(376014)(7416014)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REkzR3NhdStvZkR3N011VFNNb2VVa2Q0eWVGUmlua2drT1Z0VlUyL2JGN0E0?=
 =?utf-8?B?SGg3LzBNaTFwdUkwczJGbitaY2swUXBIdW5jNWxGUkQzQ0VBNURtZDBpUVhw?=
 =?utf-8?B?WnFlaDVCRVB5YkZuWVVvZFFhbUFOS1l3U3A2aFJCMnQ3Nk0rV0htNHA5c1Nj?=
 =?utf-8?B?eHNTeUpLK3hpczdEN1NBWUpxNTU1MjFOaGJtdmM4TjM0QTFsMmxLUllGbWFV?=
 =?utf-8?B?ZCszTHZLZ3MvUlUrenB0NTlwemdmQzZ4czJTSUViYTYrcmxhRVFVeU1VSGdK?=
 =?utf-8?B?RUxqSVVHLzB3bTEvYlk0NUVBTTVvbzQrbTY1ZGZ4YjhubVBlL3J5Vm16S1FW?=
 =?utf-8?B?bWJMdkF5cWt0R3NCVmFoanltMHFDb0t6RjN3cUR4YlV1OTkyQnllV0luM3gx?=
 =?utf-8?B?YkYzdFN5MmNFYnZVV0ppQ3dwRVhRZmFzZFNSUzBiN2FUTHZHM3NBcElYczhz?=
 =?utf-8?B?bVpETkg4KzJnelR4bG5rZDVyUE5jWG5TWGFNc0lhYitzOGZFRXpFNDU5aUFD?=
 =?utf-8?B?aDNrUFVoNmo4MTd5TW5VUU5SUHJ3RGpnalF5enl4WGY1cjdibm1XbHpLMVJK?=
 =?utf-8?B?a2t1ZU1kZThxbVRjZE8zbzhWMHR0R2o1T3F4aURMWmV0YkRpTXczbXhOQ1l0?=
 =?utf-8?B?MTErd3J2bDI1UGpZd01zQWd2QU5HYnNWRXZLc0xCZ1I4LzVCd2RDZENUb2Nw?=
 =?utf-8?B?K3JoVTRHK052THVXajBtb2tObUlOOThSVkdNQkp5cjFqQ1dSdzlLOTZJYmZ2?=
 =?utf-8?B?TnVMcTNkK2ovYlJiZ2FUem1UalhWZVR6Y1BYbDRXbUFSYUE0clY2UmM5Z2dv?=
 =?utf-8?B?RTlVckFoZmNVUjdoaXdIRk5RY25haHZKN1hsWnJvN0lzTGNoU0dETW9yT3hv?=
 =?utf-8?B?bTNDMFU5NENQeFdrRzhLRFNMMGZuNERjd1Z3YWcxWFczemVPTGp3akNEUDdP?=
 =?utf-8?B?SFQ4Mllsc3F1ZFJqbHNWaFBXb0tSUHlZT2JoM2lWdmhGeHpYYVNObnBGOUk3?=
 =?utf-8?B?TVRNbE5oNkNmMmN0Q3ppajJzVHY3ZVQvNlBCZWZnQVJUSk55c1VMVE94b0ti?=
 =?utf-8?B?VFoxZllnQTdaN25JL3VQelhnc3lsU09XZmdGMDQ3RkZFVXRRSVN0Qnc5SmYv?=
 =?utf-8?B?MXdLNDNkeU52S0pJai9uQkFBTVJUTW5Zb3Z6N0JWZVRXaVV4SWR4L00wTVhQ?=
 =?utf-8?B?UlQ5TmVZK0NKQURkZ3c2NUZDVDRmRXRtd2tmN29MUzF2aUFoMnJERlp4bkF6?=
 =?utf-8?B?R2g5RkxZaW5oZDBJclZ0WE5OY0hhRmJ1TkQ1VHVHVkdTaXNkaDd5dE5JbWZN?=
 =?utf-8?B?OGJaNnJabUF5TmFYVWkxYjZiY2VPYVI0TURnc05mYmIrRjVjUW03aE8xUUVp?=
 =?utf-8?B?T0UyRi9ORmJKOGh3TnlkRndaSkt2SXo1VEFUcWszMW1lR21JWTUxVmMrMXp3?=
 =?utf-8?B?OFRUU0NQeFVPUUVNVERvV2JSOGRVdEZyN3U1SDZ0TVJvSEo5d2cxUnlieUV3?=
 =?utf-8?B?eEoxV3BqWFg5eGdlUCtFdjRlbGhqdXk5aE1mbkZ5bklHQjM1amxBZzZ4U25n?=
 =?utf-8?B?amZJaUtDS3Q1eWErWVlyUmM5TlhUbm9ycWtUcFZsdkhyeXB6MmYvK2szdEVJ?=
 =?utf-8?B?YUljY0pVR0JiWXhpcGZLNDEvUEVMeW96RU5XQ3R6OUw3TkdXN0NNSkd2SFN3?=
 =?utf-8?B?V05aYzMvT1djT2l3UG4zeHdjNUV0ZW91VGhTdFFTRVc5RC8wQlFEVWVlbDB4?=
 =?utf-8?B?ZWNpSVhwbEtPblFKdEJzZER3WC9ZaUp4TG00WmhCZmlkcFpPaXNYUWFKb0JS?=
 =?utf-8?B?T202Y2pHWUJwdFlqSXhOTjBjMVhKNzZZVk5vMGJCRzZUYWc0eldHTEdvNFp6?=
 =?utf-8?B?WjVzVUREWVNHcG9neHU3dlg0bFJXbyt4M1hGcGpZT2FhZUNzUHd6VFRBK212?=
 =?utf-8?B?RS9jb01PQ1h0UHhRU0VGM3htNHNrb210bC9mc1hidVo4ZWxNdGRGcG4rS3lX?=
 =?utf-8?B?NGQzcjl3MkpKM0c1TDRaYS9EVHprUE9IL0JwVnV0WC9xNzhFYVMxb0Z5ZDdl?=
 =?utf-8?B?YXBrMEFDa3M4NkJWRnZ5Z0hKb3RjMmlyWjhxK1RCeWM2dUxaRllLY3ZkS2hk?=
 =?utf-8?B?NHlHdEtiSUxzdmxEMFJrSUIxeW8zYzk2N0dCK3pQTVNOYWx0aTFrY0JrcklO?=
 =?utf-8?B?Ykd0Zys4RzBxZTBHalo3aG95V0t3ek5sTldheDgzdWJoTU1aNHFHTnUwN2Fz?=
 =?utf-8?B?c0s1TmJKNGlXN05xcWo3eTdTdHZyYnZYRWU3L1hLYWV1bzBlSVZFZ09PRURM?=
 =?utf-8?B?TDNFYkNTcDZ0TWlLcTNabVRWQU5ZSXR1NWZWWDNUZnhRUnlTR0JKdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9873b418-137f-4278-01be-08dee739962e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:06:05.3024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7ejIyPh2pjDqq+asA4nqGu+hPkRCMYOvggcqjguxL4xNyNFyBj/LaX3mM2s7HhQ0z2Ual0KaTLWoZxWaQWBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6690
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

On Tue Jul 21, 2026 at 4:02 PM BST, Alexandre Courbot wrote:
> On Tue Jul 21, 2026 at 7:34 AM PDT, Gary Guo wrote:
>> On Tue Jul 21, 2026 at 12:00 PM BST, Alexandre Courbot wrote:
>>> The register! macro currently accepts an identifier as the base of a
>>> relative register. This requires base types declared in other modules t=
o
>>> be imported into the module containing the register declaration, rather
>>> than allowing a qualified path to be used directly, which is arbitraril=
y
>>> limiting.
>>>
>>> This series allows path to be used as relative register bases. Since a
>>> `path` fragment cannot be followed by `+` in declarative macros, the
>>> `Base + Offset` and `Base + Alias` forms are replaced with `Base:
>>> Offset` and `Base: Alias`, inducing a syntax change.
>>>
>>> The first two patches clean up the macro's internal dispatch and
>>> arguments in preparation for the change. Patches 3-6 gradually add
>>> support for the new syntax and update docs and examples, while
>>> preserving the old syntax. Patch 7 updates Nova to use the new syntax,
>>> and patch 8 removes support for the now unused old syntax.
>>>
>>> The series is structured this way so the Nova update and deprecated
>>> syntax removal can be merged separately, as otherwise the whole series
>>> would need to go through drm-rust.
>>
>> I would like to avoid adding new features to relative registers as I asp=
ire to
>> get rid of them entirely with typed registers.
>
> This is a fix rather than a new feature. Relative register bases should
> have been captured as a path since the beginning.
>
> I'll be glad to remove relative registers entirely if projections can
> cover their use-case better, but I would not withhold a fix while a
> replacement is not visible yet.

I'm not seeing this as a fix. Nova doesn't need to use a path, and requirin=
g an
import is hardly a restriction.

Best,
Gary
