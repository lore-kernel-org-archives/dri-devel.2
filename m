Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63860A261A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=irMhvc0X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9050410E7FB;
	Thu, 19 Nov 2026 09:33:15 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012067.outbound.protection.outlook.com
 [40.93.195.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD9E10E81A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUeCVolqSVP0NHQ70fWcnkkHJK5tdN8ZCXmTI4ds+OxDuBl1miyBXTjtKL3YPja9SF/OvmNji1cbchceRa35c0hkqUSJOJwJBHkjtVYlXLolZYj76SBf5BzCCYWdXaukhooLVZOstOO5J4/l6x8MZ++P84UXoO0QDSfNq702wrO/eJeFCPfNYJfLrkuCqkJQbt7cljPe7yG3pSHnYEYFktIeOpAo0TgObmQgUukWEeWxyOCoazz8sbsdVcKTHwmk27nqux2SDRrVhi0M/EuHw+TOh7NLrqOmOHXmE6FGUh+9hMvbLotAxc8VDa5Hm/vASj9cAOzeUO+0hQnOq9l54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cuhH0yKP9zkgU7ikEO626/c/fe95rHqNiqNBNV2gVI=;
 b=R8ehjCmFRhWBIByya1wpmrUbXbHJROEBTA0VPwPRAKeCSZQupv5jmxqeG9UyZ+eM4OoPKohKqDU5NtCY9gmPSeBMrjGupb9W8hybAjURg6N/1aHp1/BycXVGFI6JWyWuuDifeF0KL7nKCAtxrm8cW20YS3tPfwTxiw6WIv2frqjdsvbFAPUGTCQtm0TT4Nr6qOyHnwYGYI6Cjwwj90L1wzFov/dawZGdsYM6E+fHtwaAiEJImw24U2ilTBJSKSfkCIeQbmtUWFJdILsd+9AArD1gWCuoGZmJHtgabrB29jWagvAbXAps3xSHox04FLXCLd6iZHhndVJKAY51mAi9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cuhH0yKP9zkgU7ikEO626/c/fe95rHqNiqNBNV2gVI=;
 b=irMhvc0XGyl1h3mJWCm206+1sabT+1cKD2Lf9h3EBv4rkjRuihaCRFUta7ykz3YbtqSGqgYjIzINIK5zW7y04Y/l8ifhqDjzcLeLptsz3C+BeFESH8KIoaecDKEFcPPXZbAkA2o/4o1rpYLPPBuROMiWJHdb4eh2bGTxSwrYVtM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 09:33:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 09:33:04 +0000
Message-ID: <a7f9e0f3-b299-4d40-9230-106003725dc2@amd.com>
Date: Thu, 19 Nov 2026 10:32:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
To: Danilo Krummrich <dakr@kernel.org>
Cc: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
 <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
 <ab99758408df682c68a3792cc3014b77d6e1c8ab.camel@mailbox.org>
 <c2dd46ea-94d8-4720-af37-897c91809338@amd.com>
 <DMXJ8TBSZJJ4.3HG0OJDI9URTT@kernel.org>
 <8da4a8c0-1740-450c-9cf1-1a7b21d12997@amd.com>
 <DMXMSIQONGUW.1RRNS7I6LACD6@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DMXMSIQONGUW.1RRNS7I6LACD6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:208:23b::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c3e06a-6b79-4470-b5d4-08df46201c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|261022113327099003|261022075727099003|261021123027099003|10067099003|56012099006|5023799004|11063799006|4143699003|261022115727099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: H/p1xkeALXXHmPUQ4j4xEXdLXf1QE94J2IgYAP4dN37cB7C514i5JvNZQeZ9iVP9KaehDvbH7YNbfR+pVO6HCu5QEEH64Eb9n1Hj9ugS+ejv6C6xVQDwnZjCo73SZXOfSeQRCQ0KFDbTh4GK6GkVyN5EXW0LdaZHLSBV9idJDvDB7WgtoGxzcfRFkcuz9FOJuRglUUJZQnaD0BW4927t/xyZH5PSVyic38T+9kKzM4viitBI2+OPEtouaMyS7PW9+TKqVY9J3Rj4m8N4uWY1tSig2FkWylYuAWCk27uXso0u/qAC57pN6+aB4sRAUgMuHkB2HB3QVTpyOohdPPQnhcCEHbVZ6g0exK0gn4tRWAvakrU33NvzSO5rtWHHlNzYhBsYLFIqKnmXC2x/WOOuRe/ABceFG4ylpSIu2oMDBnWmO1WYVDnHhrEeINXndLhs4YaZo7SR2BXj3u/Yb+mZbvFnBJM0I/SCGmJYeAuCUKqBJVJwOd/F7ipY8SmGMPkEhUSoEJPf4ZuFqZ1Vi7oVrPMbROPYyzLbkl3ASXdYuxIPeePHAdeGr13wJO/f98ayGoE4bOQvZY4FZW3QLJZOFRAjiVX34CMcQVgoyyWgMX9KY88HLDM4bCb+ZS+VsqAVW5z31Ge4nlMW+fFDwZ4oZlLRqYTflemGo0oFrgQ+p+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(261022113327099003)(261022075727099003)(261021123027099003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(261022115727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHF2cVRtNEppU3JaODk3TlFEUW1Rc0dCOUdEWTJBdldSVEUzZVN4eFQyRnZX?=
 =?utf-8?B?d0tRcjdYUmw1T0wzamV3MlUyYVozUzJ2dFo2azE2OEpndWdWanVDbGtWbDZ3?=
 =?utf-8?B?WmlwK0dHcWZTZFg1VmNyNmt6S0JDS08rRGFKTGYxR28rV1RlTE93NXNoV1NY?=
 =?utf-8?B?YkRxR3cyYnMxOWNPU2JpczVDRlBrZjY4WGpGQWtiV1dTWUpjbEFUUFM0NGgw?=
 =?utf-8?B?ZWdKeHEwVWh3QklJK2pHdFpTM21lQ3pzQ0hOMDhVR2xlbllBWDhoWlQ0Zm5U?=
 =?utf-8?B?aE5vWGo0VndLZlVDeWxaRHpuTXZpMXhmK2d1blBudW8yNUlYOGdneERhT2Rw?=
 =?utf-8?B?NEJWNWNLcy9nYnRxWHM0WE9oTy9aNVF4dHhYT2x0MXZ3SGIweGM1WTR2Nzdk?=
 =?utf-8?B?R2p6bWxQN3JqOU9HUkx5KzlSNVNNTXpSZ21IVFp6ZHh3STJqYzhVKzlEcXZh?=
 =?utf-8?B?RzBDWFU1dXpjeDNqanlNRVh5cy9FZE9MN2tvWmlmNzZ1aWJQaVJrU01HWWsv?=
 =?utf-8?B?WHIvdGQxMHFZU1JJL01ZblFpNGR4Yzcva3p6MnRmVllvazI3NW1ITjJ4L2ZH?=
 =?utf-8?B?QUswMWhKR2dsRUMwamF0QXFobWROa3NZQkYvbjljSW9BdFcxUmZWUGRIL3Ju?=
 =?utf-8?B?ais0MmlRQ3N3YzBtTTQ1dWMxVFpiTnBQMVYwV01mT2hneDkyeUpBd2NoUTZW?=
 =?utf-8?B?bkU4R09YSU9oM0QvYWpRZkJTMFJaY2NQbjJ1U1dqQ0p4NFBUd0I2QjU0YVda?=
 =?utf-8?B?S3orVmozd3FoZnNHNjB4M0JISE8zd3F3SFNBZjFNU0xmV0NrRlFzNkFuUHc3?=
 =?utf-8?B?ZEJUR0lPa2p3UlVpTXNWdUEwaWUrWTRwOEZxL2ZxNW4yUUtVRktrZ3p6dUNq?=
 =?utf-8?B?Zmc0Y01MbEFnMjZpVVFaN0RWS2xRODkrWVJ4WSt4UWRjZ1VSTEJnMFFwUGtX?=
 =?utf-8?B?N2dNcXh2SWFRd2tQU0lGcWEvT3dML29pMTJ2TVlRVlhDTSt4bi9XcmxkL1NZ?=
 =?utf-8?B?Z3FRMmQxTDZaUHZRYkswSi9ydXQ2OEZPbnQrbVRhQzExRFY3SEsxcjFlUUth?=
 =?utf-8?B?N0JPOXZiL3V3ZC8wMjQ2dlRqNzEwQnd0TFNoSXdpRGdjUVAwNU5UVnRkZFFD?=
 =?utf-8?B?SVhVUWI5c2RLdkgyMHBZVWMvQnZ2OWFjTXNreTltMEEvblVKZ25lSnllSFc3?=
 =?utf-8?B?aGdjQlQrYXp1TDJkSnord2hlVjcrOURxNitIQTdxRU9nRzVES0RYeng3NU9O?=
 =?utf-8?B?LzNOSTEwd2JKSXRpK2FiTnI1QnhjN0pOeXhBM2psdkF0M1U0UzNPcGNvSnNQ?=
 =?utf-8?B?czhLd2c0UG5qdm8vVm8rKzhwcDE4b3o2SHRFc3dTTHNjaENHMW4xaUcxRWJZ?=
 =?utf-8?B?UVljTmppVno2QUFxYi9hSTdFb3BIN3JPUDA3THUwUUJ4L2dHTGVvbExYYXQ1?=
 =?utf-8?B?RDNLbm96dWVQQS81U2xsR0VyREZYY0JGcG9neHNBWDN6bFlkR3Z3THJuNVFk?=
 =?utf-8?B?UlBGYTFUaVF2Sk15VzFlMkpUbkZRVUZvWEt6Sm8zQWFSRG85aVEwSnF4aXNE?=
 =?utf-8?B?Ukt4WTNTaUVmNkxwUEROTENrTGJzRXg5ZlFMQUJLKzIvQU42MVFjOEhaK1Bz?=
 =?utf-8?B?aDZNSm5hV1MxVi9IdlprdElJVGRJY2lnOHY4dDEzSTI1WTV5dk9rR3VmVGJz?=
 =?utf-8?B?cmZPR3VqaC9ndVI1c2YvSGd3WGM1RldiWkdsbVZmODRET1EzUzk1SFZlYS96?=
 =?utf-8?B?d2tzcWxvQTZTVWlRTm41bXlLb01Td1VTck9UYU1kNHUyaUpGUG1CencwL056?=
 =?utf-8?B?LzdrRS9qZnkvbFJodTZmSkJDR1V6WjJ1YnhVMWViamp5Vk9hUjkxTGdYdGNP?=
 =?utf-8?B?SnJwWERONE5CbHdkWVdtUVNISVlyNXVMR3k2UmFOS2VObm42SjVsdmRVVjd1?=
 =?utf-8?B?NkVQckFGMVNteFlHY3JLdWdyVXNmNldVMWVPd3Z0R0dzU0pQQkFFZVBQMHNj?=
 =?utf-8?B?Q1FaMXAvZ0R6Nmk0Q0IxYjFoYUNoc29CZTJqeFJlSFJsZWdGbzdKK3pGa0pU?=
 =?utf-8?B?WFJTZ21CNkxjTmJKa3pVaVFTRU5DVHZwZUdFU0I4ZitYVEFWa3BxVkZGaFVS?=
 =?utf-8?B?ZzNxUG9SMW5UVGpnUGpRWDZsNHJTODNrS0RjandsczlDMjRUa0ZhZndVZXFm?=
 =?utf-8?B?ODVqaWFyRTllTGRTTzhNUUt4cjQ5R1hyZkpZa2c3VFpkenBUOGsxdG92dVBk?=
 =?utf-8?B?eU1RSWZmTGpUR2NhRzExcm5sMElwT2d1cGEzMm9aYmh1alM3UFNNTUtLMTBJ?=
 =?utf-8?Q?DqXAQLH9Lyc6Ccrndp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c3e06a-6b79-4470-b5d4-08df46201c56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:33:04.2104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIyJviBl8JDu3QwkTPCvVTiIcEsueLFgYssubSDzCqovKTN7JVA29ybTIC1v8lgt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 17:36, Danilo Krummrich wrote:
> On Tue Nov 17, 2026 at 3:50 PM CET, Christian König wrote:
>> On 11/17/26 14:50, Danilo Krummrich wrote:
>>> On Tue Nov 17, 2026 at 2:40 PM CET, Christian König wrote:
>>>> I completely agree that we can't fix things from the dma_fence code, but it
>>>> is our obligation to tell the user that something very very bad happened.
>>>
>>> That's the point, we can't infer that "something very bad happened" from
>>> dma::DriverFence being dropped unsignaled.
>>>
>>> In Rust we use the RAII pattern, and drivers structurally embed a
>>> dma::DriverFence within the struct that represents the corresponding hardware /
>>> firmware queue (e.g. through Jobqueue).
>>>
>>> Consequently, if dma::DriverFence drops unsignaled it means that the destructor
>>> of the structure that embeds it (which does the required HW teardown) did run
>>> already.
>>
>> Oh WOW! The signaling state of the fence should *NEVER* be bound to some
>> object lifetime.
> 
> Let's engage with the argument and understand things before throwing
> overgeneralized statements like this around please.

well first of all I'm deeply sorry to be so bitchy about that and reacting emotionally.

It's just so massively frustrating to been proven right with design criticism over and over again and seeing nothing change in the long term.

> Realitiy is usually much more nuanced and what you say doesn't hold in all
> cases. The case described above (and clarified below) is one of them.
> 
> I assume the fundamental reason why you say things like "software object running
> out of scope is not an indicator that the HW stops doing something" is because
> the lifetime model in a lot of existing C DRM drivers is backwards.

I partially agree, yes.

HW drivers generally face the problem that managing lifetime have contradicting requirements.

So you often find a lifetime model which is SW stack centric with applications referencing device drivers, device drivers referencing HW resources, etc...

While from the perspective of the HW you want a lifetime model where HW events define when the lifetime of some object can end.

> Drivers often reference count representations of hardware resources and hardware
> states and hence keep them alive beyond what their actual lifetime should be --
> even beyond driver unbind.

Yeah, I agree 100% with that. I know why drivers do this and there are unfortunately really good reason for that.

> This causes lot's of issues and I'm looking into fixing this up, see my talk in
> [1] and an example from Xe [2] for reference.
> 
> That said, in Rust we don't have this kind of ambiguity, lifetime and ownership
> of resources are well defined and the core infrastructure guides drivers
> accordingly.

I disagree, you do have that in Rust as well.

Background is that the fundamental problem of having two signaling directions which want to define lifetime differently doesn't go away because you switch the programming language.

Rust still makes it much much better because the programming language has a well defined model instead of C where you can mess things up trivially and need to rely on developer discipline to get things right. 

But even in Rust there is still the need to give HW drivers something like a template in which is defined how things should be done and what things need to be avoided.

> Consequently, it is perfectly reasonable to assume that a driver object that
> owns device resources (such as DMA memory) will, in its destructor, tear down
> the hardware to not access any of the resources it owns anymore.

Exactly that is a pattern I have seen many many times before and I can say from experience that it is very prone to human errors as well.

I have worked extensively with OCaml which to be honest looks like the grandfather of Rust, but Rust does a lot of things better in my opinion.

See I have like over 30 years of experience with that stuff.

> For instance, think about how your logic would apply to e.g. DMA coherent
> allocations.
> 
> Those are allocated with e.g. dma::Coherent::zeroed() and are freed on drop().
> They are then owned by whatever object represents the lifetime of the HW using
> this buffer.
> 
> Following your logic, we'd need to conclude that a dma::Coherent allocation
> needs an explicit free() method independent of its destructor as well, and have
> the destructor print a warning and then call free() anyway.

Yes correct.

> Now, eventually drivers would just call free() from the destructor of the object
> owning the dma::Coherent allocation, so we wouldn't win anything.

No, exactly that's incorrect.

See the problem is that you rarely can tell HW in a linear or synchronous fashion to stop DMA operations.

What drivers do instead is to send a request to the HW saying "Please stop the DMA operation" and the HW answering with a response which takes the same path as the DMA operation itself.

Only this way you can be sure that there are no more DMA operations in flight between the HW and system memory.

This is even nailed down in things like the PCI specification for example and it is something people get wrong over and over again.

> More in general, in Rust the object taking ownership of a device resource is
> responsible to deal with the device related state that makes use of this
> resource regardless.
> 
> Insisting on an explicit method call is not improving anything in this model.

I'm not insisting on an explicit method call.

What I'm insisting on is that the response from the HW that the DMA operation has stopped is signaling the fence.

And not that driver tell the HW stop DMA and then continue and dma fence is automatically signaled without explicitly saying that is the signal that DMA operations are stopped. 

> To get back to dma::DriverFence: This is slightly different, as there's two> different signal states, but the fundamental guarantee is the same: If it is
> dropped, the HW has stopped accessing the resource that it guards already *by
> design*.
> 
> Signaling with an error on drop is arguably the correct thing to do, since if
> the operation would have been completed successfully before already, it would
> have been signaled already -- if it drops unsignaled it means the hardware was
> forcefully torn down (e.g. on driver unbind).

I think the most defensive way would be as last resort scream loud in the logs that the driver is somehow buggy and hasn't signaled it's fence, wait for a certain amount of time (100ms?) as safeguard and then signal the fence with an error.

>> That sounds like an extremely bad practice to me. Just imagine anybody
>> grabbing an extra reference to the HW state object to inspect it for debugging
>> and the fence not signaling because of this.
> 
> That's not how it works.
> 
> Rust ownership rules will guarantee that the driver fence will be signaled with
> an error (if not signaled already) if the HW state object is destroyed (i.e. its
> destructor runs that tears down the HW). But that doesn't mean that the fence
> can't be signaled (and subsequently be dropped) independently through the
> completion of a job before that.

Yeah I have to admit that I misunderstood that part, it sounded to me like you want to always bind the fence signaling to some object lifetime.

Again sorry for that.

> 
> IOW, the HW state object (for instance) owns Jobqueue, Jobqueue owns jobs, jobs
> own driver fences.
> 
> If the HW state object drops (e.g. on driver unbind), the Jobqueue drops, which
> makes their jobs drop, which makes the driver fences drop.
> 
> At this point the driver fence either has been signaled already because the job
> completed before teardown (but wasn't dropped yet), or it will be signaled with
> an error in its drop(), which is fine since at this point the HW state's drop()
> is completed already and hence the HW is stopped.

Exactly that is what I disagree on.

Stopping the HW is what makes fences signal and that is what this tear down process should block for.

And not the other way around that the teardown process signals the fence assuming that the driver did everything right.

> Besides that, reference counting HW state objects is bad practice. HW state
> objects have a bounded lifetime, so there's no point in reference counting them.

Well the question is can we enforce this?

I mean there are usually only limited options from the compiler side to enforce things, but we should still push developers to use well proven patterns and coding practices.

Regards,
Christian.
