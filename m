Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041B8C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 01:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB9A10E3FB;
	Thu,  2 Jul 2026 01:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eZnOURPv";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A76C10E3FB
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 01:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEs20J7yIu7tOk7J9PBuWZ1vF4vfIL4okQE+huy0BS8oI4OW69v4JxmZHo28aZvZYJUva7GbMn6n9p1xpzKfms1AhG0i/mfYBBYX4yrdBA+Ch47v4rjM5r4Xy7wCQFJhoJMoBktBORPzLS+lPMwTZqgzkQUkHnbTycz39n67iPVFLbUGp8o31u1a4vOm+A1Y4hUMkgKKflbWVVI3ojrBLt00GKKab+LmgaBhQsmf46+bB8k0JBrwis7KQhfrfhYsSujUzEiXKSCGZIPdLgQCGUy6GsxmGDBFuF9MK7Kjunhz3jtNLuWilLXx9o/5XWhdx8TDd1VSQqsZ85ASSjKOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlCSR3stHaeYTLNZWXbZwh4h86idJH/0ZpAD142SrGQ=;
 b=ReBLW7VNYgxYb37lhTlsZaQeGNI8IGP6yChgzQhE6rc2hSAPbe57NA+BK9T+fSrPsJgRCdBHfGrJ8k8L1JeAzVTeYBw+ppLjesgL43h8E2yug3AwbmubUuC3IXI7e3PdIU+Ybh8Yp4Q0QcbB1QgnVey0lmMx2sseb8tDv8y2y7f8eXYYZuN/c9+kk06zBxE+5xWDrXXp1k7A5ZCZfYYugcAGoihEJXlrdiK9YaWxgoCJwwHi8ZDQveUeUxk7Z+BZ4uqqYuSYAHnRR1Ad1eu1sAHNDLWrmwYggRvZYWldvtxtMqbaSD0yAxk11LjCgW1f/yUMvvphSVfUAAzXFbCALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlCSR3stHaeYTLNZWXbZwh4h86idJH/0ZpAD142SrGQ=;
 b=eZnOURPvLWc4HP+Eizt8Qqf66pSGLMD0Cr641QRL+WJxjR8Km6vPliwg7hwVp2y19DCxrYzpx4aydbhPSuUPannsVZaIDRXlKWSV8xVilYMZ20pWhdaB+YwlJnfgubIBlKqRXvpPyT3ZzMEtuhH8BtrV1C77R9hERrGnsI8/bCg/+59lFrBVoBVwqhCJbUMvDUmPyLCEdBYQT30xRVJMNj3/hrfxwaBgGLTa81nYMLtakmdt5RzR8WsobKuB3MFaR5wuzj3BGYKKPPHZUwrcJwoSSB4mL3mHbyuvpvEZ/ZYYafeZ39YeJf2H1NIRyKpGITFgq3rkgg/IKHaxpVo3Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 01:09:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:09:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 10:09:09 +0900
Message-Id: <DJNON0M9N1LM.SSDDO8N9AM2B@nvidia.com>
Subject: Re: [PATCH] gpu: nova: fix rust-analyzer generation
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260701-nova-rust-analyzer-v1-1-5209f486f10d@nvidia.com>
 <20260701123703.152958-1-work@onurozkan.dev>
In-Reply-To: <20260701123703.152958-1-work@onurozkan.dev>
X-ClientProxiedBy: OS7PR01CA0182.jpnprd01.prod.outlook.com
 (2603:1096:604:250::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f49dcad-bced-448a-99d6-08ded7d687ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|376014|7416014|366016|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PirZ5rSl72wrqb7i5qXVt+O0Qa7j8NZnv6R/sqMrIiTXJmCe0+DrrY11O8nakztLlgfNXzrCGaBMEYD4TZ18nRs6lG5JrfbbBYmEW8NtupJPyZ7DBHt9HTWEZxVaMhFB6fJ5/wfUlCniCvxwkeXmT6X4Sb3x66rG2BYq/hxNtEqKAZpaSPALLRzibjvAkn8M+SivZsIyVL54Jz86On8FRWMGwtTyhqQtfp3OCOGmmpoPUNipPncPBvg4sGGC75Ib68axct6ptD+6AdXfl2dH4bZtr+CwBszbfPalFfLlT8jwaBm5y7COfmh+4NGZ4/BKKxn9t9YNwm/Hk+lYnL64dz/iVl+uIE9uCxO0/NEZi6WpzhM4lD71oTPvt7Z4HeGS/hafobLQUOrn5k+sV8ecOUKfPc3Zt+h9J2gUBxDiyG9/bEQgMvAiIqcMz5Yzi+vP31XyclZ8LkiacLGW6rt4B8nxGNq3kw1FxeeefI8jRdaFL8ximrrTYPqzd1hzroj5zqTHd22hvyai/S8LlILDpebuYr1OCcJTgNBa229AAxbMx23YfzDkmyzHqR+vTn337Jnwf6jR3EHkSU6CkimqNfOYn7d7R/deCrxNHdU7M0JjGBFYS7ikRUHYfDOCZc/cpi7nNN+fNIT0UYBxTx+JeYSlvqyH2dBIt8+39CjEwas=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(7416014)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTlSV2VJRXBzdngrdjBkcFUxaU5vY200TUQ2ODlDUVRXTFkyczE5THFyY1Fu?=
 =?utf-8?B?U1Uwdm1HRmJ2eDJpTWova2Iza2FFSjNFNlFKZ3p2Zm1lUWFPRml6cXBERGx2?=
 =?utf-8?B?VHY4QlEvTkRhT1orUk5IQjJycGJDdmxMMzZzSWdzQkxQZC9ZTCtrRm1GZStX?=
 =?utf-8?B?bEhaQWNpWDBHbTViYjRmTGVnZFppVHBaNFNrQUVjNjFuK2RWbTlpMTlTdXJW?=
 =?utf-8?B?eVhmUXFMNkVqRUVUbTRjcTkxSHIyaGdJU01lcDlwbVNTVUNNNStiYlQxT3Uw?=
 =?utf-8?B?U1kwUzRsQUMyTzlnZE90SzM1Vit4Vm01VzlyQU96S2h4OGdMVlFDUXVyb0Jx?=
 =?utf-8?B?b04xeHErdklOa2x5TERUL3lvYmVYelNZVXQ4V2pvZkpFaHU4VHZzbE80K0hU?=
 =?utf-8?B?dis0VDN0Y2MvOExrSnlNamgrL0d1TVh6TmMyQVZiVUVYV3dOUGppYjRPZVVI?=
 =?utf-8?B?RDFaL3NtaUhGWlBjdFNUTWVTbUZKQThzZDAxUHc4M3VXQVBMV2grK29Mczhj?=
 =?utf-8?B?RUozQUh6dDNSb1E2SUtUUE1sWUptMEcvRStML1RUbVllTjY5Tmxyc2dvbDht?=
 =?utf-8?B?S2FwWVZzQWVad3NFaWRPZHZ3V0grbEF4YzUwTzErdmdSVUJaZU9mK3lqVnB4?=
 =?utf-8?B?T2syMU51TEQvdEtJZUo5ZkJ4Q2dGeWg1d1NjM3FvczV6WDdacDRyOW1tNi9x?=
 =?utf-8?B?REFqc0V3dStYaXVISU9FUDM5cFc0aFh6RXM4c2I1ZjlLODZPMmNqTkJiSWYz?=
 =?utf-8?B?YnpuVU92bm5HYXZxTjdQN1hOaTkxdUlQcWU4TmhPS1VFSnVQYy96VHZWY3Ns?=
 =?utf-8?B?SVNLbTdVMERQaTRGc2tEbnFZclE3aGtiY1ZWV0lrWXVZYUVFWEFzMlhqVFlM?=
 =?utf-8?B?SW8zR3VKaVkwbXZjY1ZWakxVa3RqVVZkd3VsOTdjVVg4aVpPZENNZEF5MXlH?=
 =?utf-8?B?N3BZclNMQ0dWdFNXaGV0SmxEMHNrMmhvSEJmbm1xTnZYTXFEdnhrYmQ4Unpi?=
 =?utf-8?B?WFJablZhdmtzTHk1QjZOaUpKU3BHVmZyVU9lWEZCWm1iWUxkak5kcU55dytP?=
 =?utf-8?B?b0F1Z1hVaDhMelNNSGVIMW5BS041Ulh1UDgwRGxkTnQ5RnREc0ZjeUZ6UmRC?=
 =?utf-8?B?Rno0eXdzK1NndVRpcmpVbitoQVdSaGtCeFNQL0Q4dXQyTGNDSGc0ellRY3R6?=
 =?utf-8?B?ejJmcDBxcnhrK3pNNytkaC9jYTE5b3E0Z2pFZXU0anN0QU5IWUd5QnRRKytV?=
 =?utf-8?B?aVNHd0dSQmlRbndZZUp2NHBNQUU3eDM3Y1hiaVlJUmc5ZlUyTzdjV1VzRGJt?=
 =?utf-8?B?d25rQ1FWS3FmMC9lN2E5dFVTK21Za3NFUnA3L1RZVTdHTytPdmNBMFZJemVL?=
 =?utf-8?B?c1kwakJZblUvWTE0UzQ5NDE3Q2FGWCtheHlwK3hNRUNiSU5oYlRiRVlUNFh4?=
 =?utf-8?B?NVBFZ1FUQ1lxYzcrZmZNT0ltbS9RVTJ3ekl0ckw4eHhCYVV4eVQ5WWZjWCtv?=
 =?utf-8?B?V1g3TmYyK3RTZnNhMlZ1c3ZvQTN1TUJIbGJSdGQ3a0dlRE9iSFAwQTZjWStn?=
 =?utf-8?B?Tjc4QXk1WE1PQVIwcUVldk9jb3JENXBoak95WlhoS0tza1hMdllXdjJ3RHpq?=
 =?utf-8?B?WVZGc2V3Tk9nNERZTlZVdnpqVU41Z2VURjBSaURQOHFaNEVuMUttN2VSMkZ6?=
 =?utf-8?B?K2VqRE8rcC9OeWZQVUFvdjAyTkQ5M3RQK3JVWnRBVUpEa0lmV1pUaERYN1ZB?=
 =?utf-8?B?NnVBTkdyYnZQVW80N1Jyb0ViN2hYWmdTVG9aWkJKNzErai8xRUNYcXBSQW9h?=
 =?utf-8?B?R2VDOHB0TitwbjZuTUhHdFd6MXNzS01lb0NIemxHRHJUcXBKVTdBcUMvc2Vq?=
 =?utf-8?B?ZmVBR1BQVUc0dmZDaURvRTloRmJoWW8yT0xsekpXckFOQmZQUkQ2ZTluUFQx?=
 =?utf-8?B?dDQ0ajVwQUsxTExSL3pacmJHeFljSnYweWp1TG9pZlVRZFkxaC9uWHkxT00y?=
 =?utf-8?B?U0I1UHV2YWhzalZzSm9ibytNZktRZmdYMURQQS9DajYvMDZleFFUOTVrVGxv?=
 =?utf-8?B?cEFCWmVjZ1QydWV3dU5xTzRpdWRxVkZhNjhMK3U2VllIMUtzWklVTG1nZG02?=
 =?utf-8?B?UDljLzM5aFhlbzBSZWVNRC9ST00yL3A3NVFYeFpQaUt0OEZwWnhwZmRtVE45?=
 =?utf-8?B?U01UK1hkN0J0V2RjR2UrUCsvUlhUL25md3BwVGZ5QlQ1YThrcWhFdkVlZkJs?=
 =?utf-8?B?S05ZNzVUN1FoWU51ZmhEeGRkdmNrajVpVUtSSXJmaG5PUEc3OHlyb3BTT3Fx?=
 =?utf-8?B?dndnVndxREorZSt2NldNZW1VOUVqc1Z2emJReC9nT2orcW0xdmpocy9LZk5C?=
 =?utf-8?Q?FabjLWXD4aSMFsXilC/U28+AgAjjmquEkZ+DyzuJN4YMh?=
X-MS-Exchange-AntiSpam-MessageData-1: R9V77aiIBR062g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f49dcad-bced-448a-99d6-08ded7d687ca
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:09:14.4692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grSHBHX3tXw9+vX0CzviFKGY1Kij9/HQXIlf0NjEh8/xvcW7tmlfJ1WQyDKRXphaqBoXElIHmGuE8w48JUv/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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

On Wed Jul 1, 2026 at 9:36 PM JST, Onur =C3=96zkan wrote:
> On Wed, 01 Jul 2026 15:40:51 +0900
> Alexandre Courbot <acourbot@nvidia.com> wrote:
>
>> The rust-analyzer generator script recognizes a crate when its
>> corresponding `.o` appears in the Rust source file's immediate `Makefile=
`
>> or `Kbuild` file.
>>=20
>> Commit ca524e273c43 ("gpu: build nova-core and nova-drm from
>> drivers/gpu/Makefile") moves the build rules for `nova-core` and
>> `nova-drm` into `drivers/gpu/Makefile`, which results in the generator
>> script ignoring these crates.
>
> So this regression shows that generate_rust_analyzer.py should probably h=
andle
> this case better e.g. by checking and understanding parent build rules to=
o.

Ideally yes - I expect that this is something the improved build system
will handle correctly. The current Nova build rules are a temporary
workaround, so I wanted to keep this "fix" as small as possible as it
will also be reverted eventually.

>
>>=20
>> Fix this by naming the crates' module as a comment in their respective
>> `Makefile`; this is enough for the script to pick them up and restore
>> `rust-analyzer` functionality on them.
>>=20
>> Fixes: ca524e273c43 ("gpu: build nova-core and nova-drm from drivers/gpu=
/Makefile")
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> That said, this is a reasonable quick fix for the current generator as it=
 fixes
> the rust-analyzer functionality for nova, so:
>
> Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>

Thanks!
