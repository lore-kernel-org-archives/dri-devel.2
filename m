Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5B606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WR+9M1EH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5181810FDCF;
	Wed, 21 Oct 2026 12:20:52 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B6510FDCD;
 Wed, 21 Oct 2026 12:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNoxVN2b1ZT/FPSCEgiBjE2SxsWLiYwwDvVA6Kun8LwW40aZmkSyN4SKTXZg44aZS0VBmv8S5J0oTOkqdWc/4bORgckPdPkzHwT9zdUbgCbmN7gvN+Ituc5al6TWDt0QV/sRVAI3hKLzfNkkEApy3aFFSt9LHFVaAdC1xz9DVLwPlWNgbA2xMzNyVnE27jX4ysRW48rdBWyrOHcqpjhZFQ/7l0OSLEla4csTspwWfuxGezGlgTLpgvl3Ak0SBdlg+slvkhW9xDpjGaAX0JbSbN+o9Ts3n+ShKXbqxu1adrOmZwfRqfZu1eNKBMV4VU/pHBFhEJsAXwVdmL/sX9C4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSpLLHolbd5HizENSTYeslY/+LAx2dZVPJRFFDgPBX4=;
 b=mBIXCUBwaWlvgpM2mYrwUQEX0ydmMhqoPkrxeM4m78u4oe+yQC07XyQ4o7gpiAslCo3QHFf+/z3trTCQX+AMJCG4QDTjr4tGzQYg+94jACtF2yM0Op8UU3DiOAuNGXmIXz6Ea1d4zPIe5P/yqI6vjGYdxh+vUGoBAZAEBPIaK0zc0gZVWKj/EIVAlMEKQRkbE6F+BqVnX6HF9x+l56DZaN3KzK+YyAxWs5a6iK9CQRat4Wa4ljxLfMyIbCShyY+qKA1Q8l38pRFc8hWmeuzx1dQ0N9TibHsdrmaGSa/LPEEcOj1Iv9NAfN9j9yJtwxHyIf4KrMR4N6VOnw5J5b1v8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSpLLHolbd5HizENSTYeslY/+LAx2dZVPJRFFDgPBX4=;
 b=WR+9M1EHpMgFt3VoNAcmxMbbndvq07QFjclfPmcOqMsp6L5ou6j02es7er5fCRxCsuFn5vMJvw46QqxGE8nTWS37LAAioZDM7K6VAD05V6C+lXMOiH03FdJ0sTmPu8LKUirjihiK5QCUx0SiKptHedHBSAPTi5GPuVXuzC3nvMDG/SVUP9eNC0tRaEeSmuBaMnUX53ClC/0sanqkGMu6BSwngLaMpk5OIqSNAzweBu76M/jlNE55PTeqVWWa8nZEifrG7V+Ci5nngoXQ4onzouqcuGkt19p2tkkcfy6Y509tWJLzVnVQ20FQiW7SLumhwGYfz0qvnWFGiu2zRd2xCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS4PR12MB189445.namprd12.prod.outlook.com (2603:10b6:8:53e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 12:20:38 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:20:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 21:20:35 +0900
Message-Id: <DMAIFKNP08DM.12P9VGV6DCUWK@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, <sashiko-bot@kernel.org>,
 <sashiko-reviews@lists.linux.dev>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <ojeda@kernel.org>, "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 11/14] gpu: nova-core: gsp: cmdq: use consume_element
 to implement drain
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-11-dceeb8f360ec@nvidia.com>
 <sashiko-outbox-178822@kernel.org> <DM9QI47QSJ0L.2QMRVD4AP5WIV@nvidia.com>
 <DMA6GSC7REE4.1OL8XYR8JKJ3C@nvidia.com>
 <2cedd65e-514e-493a-a8dc-cba683c84fea@nvidia.com>
 <DMA702E74W05.2L7ZRW1M6H3NM@nvidia.com>
In-Reply-To: <DMA702E74W05.2L7ZRW1M6H3NM@nvidia.com>
X-ClientProxiedBy: TYCP286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS4PR12MB189445:EE_
X-MS-Office365-Filtering-Correlation-Id: b121e42a-3333-4fd1-e4a8-08df2f6db724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|23010399003|1800799024|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ex1x9lNroeb9/kmak9AHtxjOUFCnO65uEoh/fyMGWrjCEX8nxPYxyetvfdYriqDmWk5mTkpEbe+XGGNkL2jLPWRIJubXyIAAWA8Kb8SFCj01gtSGiHsrqnDWGgFqyWbaajDrDFSdTTCGuG4Kn3PyHSEgr72xSxk4tBPPmhOkzGTIqBhp33/0cTljXNRPO8N1NvRDO9ICKrVwWD9yFAjHqiYuqBBlnGgmLDMbXvbbUo4P78QynWdiOsis9q2l3SAYzJb1OhzxMaHj6+tcpmgmb8Kdicm7spUoZoYwYaFgRbH09fw1X0+85Qkmk9stT6QMIcaPBg1cB8zmSoofarV0TL8HI3fmtgX3p6Rz73DBMQrY3pYcWJqayyCI5pwnFQjT/53yz7DftnAhsBH6OvKQAAxZKInowcADjqLnBZf5th8JKBsePDC7rGdM72eRGoe/WEwWsmZvxEc/l0gUYHkTctxb22c2CwXa36h/grWsD72TqlVehh6lZg1JBD6yyZg1N7Ms6PKUKEWyF9dAOUEL8NUUZ34r+8ygBsMRuBbbCNsDKsWe1ecAXt14s8psxuaaXPVpgFBzt1rtLZADV6FF4vFxe3PKvj0iHhtFXnoH5urr5IHdbHs5gytq1c2EB1INZNHQd2e8i0FnaFKe48DQ57QkzoWqpEeisxXNEcdXVSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWhaOXRkV1c5OFh6aENQOGthVGVvR1VjMFFRQ0JpK0VxN3NPWUFsQmJoYWR3?=
 =?utf-8?B?UkM1ajBZVXNmekVkTnkvYzR2bXJPRkhzbW13Mm0ycnJhRy9pa1dZSHVNc25s?=
 =?utf-8?B?OE1LdlE2ci8zdnJtSWhsTmdIMW1YVElvdmxMbUp4dS9ld2tvT05PdXBjL1hh?=
 =?utf-8?B?c3JNS1d5SThGY2Ztb09vWWRQNFNscmZBazdpM25KK3RnU0NDUm5KNzVKb1k2?=
 =?utf-8?B?R1kyWm4yWGcwRnhjbHp2cEJINHJDNDNnMFpiRFpYSjQ5czlycWhyYmx0WVBi?=
 =?utf-8?B?VkFsUXVSMmtETk51VlBZUkpnLzNwZWlQaWxSRm9hYUFKSmh5VU96clpSeEhE?=
 =?utf-8?B?Vk1FaDlKU01OWmpQTVBxdDBpUTZ6TmFBaWxlZWRSOTlkSWdNMmR3K3JUb2hm?=
 =?utf-8?B?NCtEaEVZSHB5ZzNPbkZ1K0VDdWZVY2FMM0ppWGYwYUtQTlVuclZiSHFEbkRw?=
 =?utf-8?B?UmU0Z2pseDFreVl2MlRONUdpU1VWanpOWlh6RGdqc21GTEVXNFI1YlBwOGdU?=
 =?utf-8?B?a1N3OUlmQ01YWmM3RVJ3TFZQUzh4SVhyZGJJeDgzL1RpUlZoNlYxZVd5aXBX?=
 =?utf-8?B?Y3BmUVFtYU41Y1RzdnNwV0VUelp1ejBPZ0tTeEkwTmx6L0daTVNScHhyRVor?=
 =?utf-8?B?VnVvdmpkUm8yR01Ic1dUVVo5ejBxUnZIenpTRWNLQW0weTJQREdlUEludXpW?=
 =?utf-8?B?Q1hpREc2MGpUNjViWHNDZ2Y2dm5KWlg5a0ZxMTk0MGNqaUhGa0FQY3ErbWRP?=
 =?utf-8?B?RS9iMDUvdThxWnl3Njc0bE0zdTVKSTkyWEZBa1B1TlRNTDRXMS9WN2ZJSXZp?=
 =?utf-8?B?dk9yVEo5VEwvdzdEQmNpb1ZIS29Tci9DK0xvTUU1QkpEa2M3cFRGY3JTZXk5?=
 =?utf-8?B?UEFUcHI2T3NsVUUyZmhwMDdKbFJKajZOenFLVmRDQnZJc2o5bUN4a2ZGdzla?=
 =?utf-8?B?NFlpUysxTmRqTXEzYnQ0VUppWDFzZ2RHSisrRTVwTi8wWFdwMnB3Z0Q0eCtD?=
 =?utf-8?B?ZTQwWmF2RXIwMDZHcWljbDQ1QVhDa0hyZ0wzY2ZoaVZmSWFjOVkrVVZsNHIw?=
 =?utf-8?B?bnhGYk95WmV1NmorODF1czZVaWxnRlFUaGhoVXdLdm10K2RZV2NqZS9pRUtv?=
 =?utf-8?B?Ri9JVWFrSTVFNGtjYUpJRkdVL1ZRNXpmdExKZUhCMFVlbkVHNjJnNGROQlFV?=
 =?utf-8?B?eHpCSWdtNGFJZnc0VmwyVlZ2aE1uUVNiNTBxbDlDM2NQWjN5YVNtVTlEY1hU?=
 =?utf-8?B?OXAzK20wQ2Q2Y2FZc0FEYllIaXl5TVNVMW1IUDR6bzcxMEFabU9Rc3JoQlhp?=
 =?utf-8?B?M1VxelJ4eUtTQno0dm5TdlRLYSs4VjlYNFZKR1pCOHZmUm8vQ05adkpEd0dQ?=
 =?utf-8?B?czBXZVUxUFhsWk5pNWEzK21aVzVVNVYzNDhIT3ovZXBLTXVIRXVUZ2RBTUIw?=
 =?utf-8?B?aUh2Rm5xRlEzbXR0dEdERjF1dkprT1JHQVJYZ2J4Qi9iaVF0Qzc2bUR5TDVP?=
 =?utf-8?B?dTN5SUNZQ24va2VjMkpHWlZLMGV2QWtuWWhyNG8wTWFhSDBPMVYvQnhZckw4?=
 =?utf-8?B?c3VxN1VLOHpSM2Rla0JWamF2YVQzWTl4OW1hbEx5RUNmR0NnSHpRWldpbmll?=
 =?utf-8?B?RjFjVkVmaFVMOXB3T2xEbzdkYXhFbnFTbnUyUFM5WHZka2VBcEtWMlMwVjRi?=
 =?utf-8?B?UzJsS1BxS2FwRVJZWDFtcHcwb1l1aER2S0d1MXpuSmkwdk90bElWWDYzL0xt?=
 =?utf-8?B?U3JiQ3p6Ny9mdlE4Vnprdy9GeGdUekdYS2ZSek9DaHlBR2hvOFB5dFJVQWVO?=
 =?utf-8?B?T3d2VmZsVGprdmNETHNHbFJUMWFnWVBJK2RZSkRmUjlzZHRSVHpEdlp0aE1S?=
 =?utf-8?B?YkZ3dkE2WjB1aE5ZeHdtbUwvOWVNWDFmMWJSM0VIbmZLTzJPRmNvNFN3a2hz?=
 =?utf-8?B?WjBRZFh6OWU0OHBvbmlmbW5ieVp3dGlwQ2UwcGlUZmF6MzEzdTNRSlZwZzVZ?=
 =?utf-8?B?cmJ1UDdpY3BmVngvRnhUU1pJelJPNWNlajVTZnErU3gvekNrNWQ1eDhidDZS?=
 =?utf-8?B?dSt4VUJEU01maWF4WEVOclJiQWo0TVVJbG1uZXF3UlB1K2w0MGkwT2VaMExt?=
 =?utf-8?B?U2NjbktZcnFiS09BQlU0cVFHNndYS0FRSktMVFl6TFExaG1lcmF3OUQvWVNt?=
 =?utf-8?B?L2dnbUpXSFBqM1NtRDJma0VQTWlTOWpSWGxnbDNOcW1MK29yYURKUzh1Vllr?=
 =?utf-8?B?MVZLZm1WZE1xL3hxdkhINEl1RDFJSHRzd1VhQU41Y09EUy9HSklLOWw3ZzA1?=
 =?utf-8?B?Nm1mRm1jWDZQcWVGRGpxM00vWmJNRnl1aFNMSDJRdkRVYStlakZHOHV3Yncr?=
 =?utf-8?Q?uPVqgCIIqdhmu5KUtyLrPoPy48lHdfdZC5I9E/85Jel/N?=
X-MS-Exchange-AntiSpam-MessageData-1: NTyjt2eLAjirlw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b121e42a-3333-4fd1-e4a8-08df2f6db724
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:20:38.1996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3/PsMtYed/Q0t2GwNtfwgSpyR7ebKFIO+KOjKZLKlz/9bJqTUtQDGYxObXvjctg+GPBvhz/I3PMwXJiyV0Y7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB189445
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Oct 21, 2026 at 12:23 PM JST, Eliot Courtney wrote:
> On Wed Oct 21, 2026 at 12:12 PM JST, John Hubbard wrote:
>> On 10/20/26 7:57 PM, Eliot Courtney wrote:
>>> On Tue Oct 20, 2026 at 11:27 PM JST, Alexandre Courbot wrote:
>>>> On Tue Oct 20, 2026 at 7:18 PM JST, sashiko-bot wrote:
>>>=20
>>> [...]
>>>=20
>>>>> In rust/kernel/io/poll.rs:read_poll_timeout(), when the condition is
>>>>> false, the timeout check uses a strict greater-than comparison:
>>>>>
>>>>>         if start.elapsed() > timeout_delta {
>>>>>             // Unlike the C version, we immediately return.
>>>>>             // We have just called `op()` so we don't need to call it=
 again.
>>>>>             return Err(ETIMEDOUT);
>>>>>         }
>>>>>
>>>>>         if !sleep_delta.is_zero() {
>>>>>             fsleep(sleep_delta);
>>>>>         }
>>>>>
>>>>> Because op() only reads two u32 indices from coherent memory in RAM, =
if
>>>>> the monotonic clock has not advanced by at least 1 ns between
>>>>> Instant::now() and start.elapsed() (for instance on architectures wit=
h
>>>>> coarser timer resolution or under virtualization), start.elapsed() is
>>>>> Delta::ZERO. Since Delta::ZERO > Delta::ZERO is false,
>>>>> read_poll_timeout() falls through to fsleep(Delta::from_millis(1)) wh=
ile
>>>>> holding the Cmdq mutex (in paths like GspInterrupt::handle_threaded()=
 ->
>>>>> Cmdq::drain() and Gpu::new() -> Cmdq::drain()).
>>>>>
>>>>> Would it make sense to keep the while
>>>>> !self.gsp_mem.driver_read_area().0.is_empty() loop condition around
>>>>> self.consume_element(Delta::ZERO, |message| message.log(self.dev))?
>>>>
>>>> Mmm, that's an interesting one, in that I am not sure there are any
>>>> concrete implications but I'd like to fix it anyway.
>>>>
>>>> I was thinking that maybe we should add a special-case to
>>>> `read_poll_timeout` so it returns unconditionally after checking the
>>>> condition once if `timeout_delta =3D=3D Delta::ZERO`, but doing so wou=
ld
>>>> make the `sleep_delta` argument moot so I guess that's not adequate (a=
nd
>>>> the current behavior is technically correct). So I think I'll
>>>> special-case nova-core's `wait_for_msg` instead.
>>>=20
>>> Personally I don't mind the special case in `read_poll_timeout`.
>>> If you say, I want the timeout to be zero and then it sleeps, that
>>> sounds like wonky behaviour to me. I think it feels weird to have
>>
>> Yes, it's odd behavior by the function, but on the other hand,
>> it pairs perfectly with the odd behavior of the caller. :)
>>
>> Let's avoid special casing. Just let the zero flow naturally
>> through the function and leave it alone. Special casing should
>> only be added in special cases!
>>
>>
>>> this special case w.r.t. `sleep_delta` only because we are using
>>> constant values and that's a common use case. TBH I think it would
>>> even be fine to change `start.elapsed() > timeout_delta` to
>>> `start.elapsed() >=3D timeout_delta`, then it's not even really a
>>> special case. I could try sending a patch for this.
>>>=20
>>> I'm also fine with special casing `wait_for_msg`, but personally
>>> (maybe) sleeping when you set timeout to Delta::ZERO sounds busted to
>>> me.
>>
>> It's not necessarily wrong, depending on how you think about it:
>> "sleep, but timeout at zero" is something I've seen used (I forget
>> where) as to mean "context switch away", kind of like a cpu_relax().
>
> Here, it only sometimes sleeps ("(maybe)"), depending on the resolution
> of the timer and how long stuff takes. So it's really pretty
> inconsistent IMO.

The alternative if we special-case `read_poll_timeout` is that the
`sleep_delta` argument becomes meaningless, which from an API
perspective does not sound right to me. With the current behavior, even
if we pass `Delta::ZERO` the semantics of the function (which is "wait
for at least at least `timeout_delta` and sleep for `sleep_delta` if you
need to test a second time"), still parses. Special-casing would
complicate this, which is why I would rather lean towards doing that on
the caller side.
