Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBF606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PLArGcC/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE87810E5DD;
	Mon,  2 Nov 2026 10:46:14 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE2610E5DD;
 Mon,  2 Nov 2026 10:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDqsYta+sD2q5o8p0DPh7y6Wrcz5zoiHh2zaQ0PwrqkdOIG55q6EzUTS/pnz0c6tHkqdLoek/qRHeah6DRJcts0bUsdIVgQSYmSmhvOGhjVop8ufE7YjF8UYdIDm/RG0jUvVIrB+gL6Ip+Yw4m9zXqqwSjgckoz+Z1hZ4NNkGGHd8sepWpurTfQB7SsWvJa5TjaV4ok/AOP5wb/K7XQgFfN4L/S2/6XjukBkDKRBvaf73/g1BRVkaI4yx7kECcxx59KxpMN4ZYvWziEolStObq7VolQzhhZ/95LPwazwxDpGRHmviS+HBBDeg4q7X97IdSXT0Yx9FBMeNRMCrLPrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYhKLsJCXbY3Viq9xoCBiDnByextfZ3CPyp+K6Xi8/E=;
 b=wKRIDzUscgmgoo+nV7k4CSdO6IISoGJb+WFgrFslNEi5U0sNSPyufX7PFUWNC5LubL+7Z3ZprBB5C6sMGETQsrLNiFm5x1B8H7CogXViVR4ue+GY4f8mp/tzZpefLOacBFNSBpliSlZ8HEsNXXr4ZafnDpj7SSyZ510V0sdCMCiglGJ36n16q7Yq+hCT4qA6iV1BNMkM5R9qdDmwjUkJosK2fp5y/kfpg1b9prlS7KOTKz/QrYiZVfQvLXO7sQf0s+7aJ0dF97N/NymPeOGUtaz8/oHA7FA48UC3OQGQfuqatcnvMLKYm3eOfBrAGmoIGv7hVht2qANxdY17MPWFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYhKLsJCXbY3Viq9xoCBiDnByextfZ3CPyp+K6Xi8/E=;
 b=PLArGcC/jKWZNkDPdyiL4+fJhQXEGQtmieDEqX7CzN6E61DIOcph2VInPrmD6EHN3n7MOGPs9xAI7VXuGHMxY79uDZuS321RvkkNfEe/1pjA+ioDcaWmstTVqgRe2M23YdC/mr0nsEqBNxGUq7wI8VIQE1pAMxa6D/XCEbBat4I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:46:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:46:05 +0000
Message-ID: <5e643ba4-0573-4d1b-9439-25f05e58a8cf@amd.com>
Date: Mon, 2 Nov 2026 11:45:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] Solve dma_fence's problems by locking
To: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20261020100034.759183-2-phasta@kernel.org>
 <3e8bc11d-6f90-47a4-ae63-cf2ff37f1ff6@amd.com>
 <ca78cdb7c24a9be9b640db782168cdcc5fe30b60.camel@mailbox.org>
 <ed2728bd-1df4-478e-9e6f-a96dfd172b48@amd.com>
 <4a7294da65c8744ba6355730e304b5250d0ca351.camel@mailbox.org>
 <d13d1a6e-bba2-4275-984b-145e0252eb0f@amd.com>
 <320b6e7c75da6f05c015e89df0e2c7d11f20d70a.camel@mailbox.org>
 <22d66945-8854-442f-a69d-fe02726eccda@amd.com>
 <f9a47d563f896e0789fffa72df5847e2878cbe5e.camel@mailbox.org>
 <5d15d668-7191-4e96-922c-82982787b50c@amd.com>
 <3a81450158fe5a46d76257c5018eaf5592168f18.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3a81450158fe5a46d76257c5018eaf5592168f18.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b3b191-a3a6-4abb-804f-08df38ce7eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|921020|261021123027099003|11063799006|5023799004|4143699003|56012099006|261009223027099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: FQ7cRKwTLvk5FaY+OYg3vJJJEroWhCsS7zbKjNzChmGFuUbKjrrcl65ZMAEm+iTbzYQFQ/xVLWSoP2+YvmBJ8B7yPC8VENAJ6dVF1KarTu51h92i9bGiCX3iyDsiXMPhTNt9e8nMmNkn1Sfd2OCK3kPmbW+JDL1/cQvzWy/sn30bLn1RAPWMPrEaAei3bXJt07DpUioH3dcjUSh+SSDbLjm4jkbqHqPI17MBay4OLsdzOi0s51UP5e7G3pX3CIIZwK78R5uspCu8tpuVJK8/xn/C6X3gKveBaok6OmiB6q0bB4+wlptCxzfy1iEy31aQN7n/133wiBfnnT5mQWCLe3qgxDlXH9mTz3WKi+ZiN2Pl7uCs5D+V1JYbXd1Fb7hS27dvDFpCQF73CD6dkj4hx3og2vomL+kK4qc5/K0cKQX7IVfJdEkGiu5L8m44sdyg/6+CiWbBM/kl68K89dtmKuP4Fz9jAyWLUy9pwCaaiZvFYToBKYRK4x25cJL66Zc52UWFeLIkb2ok4tQheh5GDsKUNuCTabxogTtRHMSFiWebOZPMGA/ViZNJG1utfrfUnfG/gBtGxAiS1K+Qa/2C2ekWPw8bWV+Wwc3T4R8n9AUbZoW9EZl3vh8zaHjq3iL3fjrZcyU4DpVYILBXPniZbzKhoubaET65yz3CoNj+mHr3Hlzx8/+FTfbWuPVbLuKi1InN4bappzIeuO9p61Spcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(921020)(261021123027099003)(11063799006)(5023799004)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHlUazZ0SmRVOWhoYWtBVklqL1p5aExOMDczSVZMaEc5MFBDSjY5V2NtOEVQ?=
 =?utf-8?B?YkZid0hXeCsxVjRBa0JJU01qTnJmUWNLQjlCTVJaN2VmT2p2WDBBWWo1QXNJ?=
 =?utf-8?B?Z3g2Y1JWZVEvcGQyajlUa2lrWFdmUnEvSlNuNEJXcE1ReERiazg0UFE0ckx0?=
 =?utf-8?B?SmFOMG9VM1pOMHdjUHk0eGt5TGVHQ0dObTRSbno3bWIvdGc1dXlwSmJWaDEw?=
 =?utf-8?B?SFpobHBseDJmRjNCbmx0MEpESTFXN2xjNTJUc1I2SXZzMHBhdVByVmpIN1VW?=
 =?utf-8?B?U2plMDVoSEgxa05pSzJKdXVnTEU1ZUhZNHRKWWY4bEY2MFZ6SmV5cmZjVUda?=
 =?utf-8?B?bGk5cktLQlQrRUg4VitnMkh0TndPeHg3Um5HSytzSUVyUGkweVpaSHZLeUps?=
 =?utf-8?B?eGswQ2hWN1NaTFRzOVc4aU1CMWN4SFM0WGJleHR2akxkbktBWElLcWNXWUYx?=
 =?utf-8?B?UGhjdjZBNVNIano0KzI5ZzhZSmZsSmtGcWJiZ0t3TzNCTEUrbWRrTThXSXJJ?=
 =?utf-8?B?RmJQdGZCNmltMnRKQ1RMNVdYelVGelpUY0ZsclBja3A2dFhLS3ZmMzJUY2JX?=
 =?utf-8?B?K3VXUkNxS1FsbTZaN0E4RUgxS3hpVnBUZWtQRjRoM0l2T3pyVVlIWXl3K3cx?=
 =?utf-8?B?Um9nVWVaWEdYMHFhbjRTV0FiYVZzamNNTk40dy9rVlJvd2dCbDdiQ3VTb0NY?=
 =?utf-8?B?bzhsMkRHNVlTK0hlWkg1TkNJVFRHLzV3Ykppc0xCUkxtTUJ2SytDNEpTaG1z?=
 =?utf-8?B?SFg4a0NtbXk1MHpjS0pNWEdrUXJBMmxuOHhXZHdFNGE5dHpNVnZsYlZ0WVdw?=
 =?utf-8?B?VjE2eml6WkIvTlNWUStLSWMxb0NHWFR0NjRHRjRqQUViTk5EelAwTVR1V2Z4?=
 =?utf-8?B?aEtOYnd4a2lLVzBGVkJ4ZjE0TlZkUEJ1WVNTU3k4YkdhdWhjbXpydVZxT2NW?=
 =?utf-8?B?dUdzNDMwQk8zRnZFbUxYQmZYZ0RYYTJTc21SOEhSTFdDV3hJN1hudm1nSlQv?=
 =?utf-8?B?VzlIVzFXWkRZeGlKM2xmRVFQbU4ycWJweGlJOE9FK2M5ZUcwL2pMZkQ5Tlc1?=
 =?utf-8?B?VVJuWldmN0lqVncyMW8xTEpsOVJrM2lZZ3FDMEdjY3lPbitTeXQ2V2hNdS8x?=
 =?utf-8?B?amlDRTE1ekg0dEhEUUxTd2hOQmQ2NlE1b1FrSThxRkI3c2Erb29qZTdtWmVX?=
 =?utf-8?B?UjVIcHdsSHlTK05qUHpibjY1MENmYUpVdTNsVS8xRGNaRWJHZ1NHRmdkb2lN?=
 =?utf-8?B?d3hncE5LVUJLeloyWHM3OXJ3SGcvWWFxdG9OS0lKamhYejdYSUxDYmNSNU1z?=
 =?utf-8?B?enhQQ210Y1F4ZlBJSkFxK2dFVjdFb0xKUVBFTmtmMDBJaFlTUm11Sk5taU01?=
 =?utf-8?B?THozK2ZmdFovSlZHY0VJS3BBNGVRMUJBZkRjenQzTmNGYnVvVlRnbEg1WHZR?=
 =?utf-8?B?US9vRWE4ellmR24vV2NMUHlienNjSUlYMWdyd2lRRWZnODV4Y3ZuWVJyM2VC?=
 =?utf-8?B?cXdmTFMyQXpmbiszcVhwQVhFOUdQUlMvaE9rWmc4MjF6UTg3RHZxb3F6engz?=
 =?utf-8?B?YjFjNWpodWg2UHdzS01wdTczYzFDaTU5WGtVMHRvN2xQTVpKd2JNSGQ2TW1M?=
 =?utf-8?B?UnRmTG5xUUlicXBERGFRdGhuU0NVRU9RRWliaUJXTWRteE9halNTT2hDUzJD?=
 =?utf-8?B?YnpUTTdxcys2V0pRUmtwVTBCdlAweUhuVndKMTFsZkZqNTUxYXBCWmUxOTk2?=
 =?utf-8?B?bTREN2phQVhnd2ExZ0lxdm50YUoxTTI4YVpKMDliNEJUbmxrWGM4RG5aZi9M?=
 =?utf-8?B?MHFlaEhRK0NTR00yOUxGdk13di9saldvK0s4VmJtUnNSbTJSRkpBK0VQQjFH?=
 =?utf-8?B?MlZ4c2I1ZklXWDRJSVBSSTJSbWNCeWtXRjNidzlURDk2bVY5RHlQTjNnajRy?=
 =?utf-8?B?dHYycEY3dE5RenpvUDJreVFJY1Rta0lMQXA4S01YMHRzRWU1NXpYd1A3S2g4?=
 =?utf-8?B?STgrWkR1T05JdTBHOC9lbHc2NUF4eHpXMy9CQnl5VHpvdFoyZlYvSVV5KzFn?=
 =?utf-8?B?ZlQ3WDBqUHMxbjFkTHpCSXZrczFsS05Cdm4ydVVSWkpMczdKVmdjcjVzSGFY?=
 =?utf-8?B?dWJRakZ3MFYzQ2ovYms5R2RuTy8rUzIrL20rcENtc0ExYTBLZER4UHloS1I4?=
 =?utf-8?B?Y0pXMEIxc0xGengvd1h6R3hzalJkR0xnVms0b2FDT0FhSkI1RXdmVjE5TkxU?=
 =?utf-8?B?WGNRc3FJMUVMN0dMU1BLMVlEMnVTMzJRV0wrT1F6YWRNcTE0VGlvQ3ZjeFNC?=
 =?utf-8?Q?MrgAvaup8s2wWf0FMW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b3b191-a3a6-4abb-804f-08df38ce7eaf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:46:05.1295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORHRPEd9tyMaLudUpbSW2qe4zm9JAME0+K0yw+iyIWsXRY5W8oP5TWk4FrZB1N+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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

On 11/2/26 10:35, Philipp Stanner wrote:
> On Wed, 2026-10-28 at 14:38 +0100, Christian König wrote:
>> On 10/28/26 10:47, Philipp Stanner wrote:
>>>>> 	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
>>>>
>>>> This bug is exactly what I'm trying to prevent here.
>>>
>>> What is your proposed strategy for preventing it?
>>
>> nouveau_fence_signal() is consistently used by all signaling path to
>> both signal and cleanup a fence.
> 
> No, you miss the point. Look at the bug. It exists because nouveau
> thinks it can drop a reference now because the fence is signaled.
> 
> I grant the point, though, that this is actually a refcounting issue.
> The path that is signaling does not have its own extra reference.

Well yes and no.

It's true that the path which needs the extra reference should have one and drop it as soon as it doesn't need it any more. But the real question is why does that path exists in the first place?

What nouveau seems to do here is to install a callback on it's own fence to do some cleanup when the fence signals.

But that is nouveaus own fence, why doesn't it do the cleanup after it has explicitly called dma_fence_signal_*()?
>> When we stop calling callbacks with locks held and signaling fences
>> from dma_fence_is_signaled() and dma_fence_enable_signaling() nouveau
>> can call nouveau_fence_signal() consistently from all cleanup paths
>> with the proper handling.
>>
>> This makes it completely unecessary to have those cleanup hacks as
>> well as the nouveau_fence_release() callback.
>>
>> Background is that you can then put the fence context directly after
>> the fence is signaled 
>>
>>>> This problem only exists because we call the backend operations with
>>>> the lock held!
>>>
>>> Nope, this particular bug exists because Nouveau thought that it can
>>> drop its reference when dma_fence_is_signaled() returns true, which is
>>> not the case, because the fence backend has a race condition there.
>>
>> No it doesn't, the fence backend works exactly like intended.
> 
> You mean the lockless checking of a bit that is set under lock-
> protection works as intended?

Yes, exactly that and it is not even a performance improvement in the sense that it makes things execute faster.

In other words we have use cases where the latency needs to be as low as possible and the state change that a fence has signaled visible to other CPU cores *before* the callbacks have finished executing.

Take the "gang submit" use case as an example, here we have two submissions to two different HW engines which depend on each other. After filling the common ring buffer submission A busy waits on submission B to start and drain the ring buffer again. This busy waiting inside the HW consumes power and so drivers try to avoid it as much as possible.

Another example is scheduling dependent page flips etc...
>> I agree that we made tons of mistakes here but that is actually one
>> of the few things which we got right on dma_fences from the very
>> beginning.
>>> A race condition that was allowed for performance reasons.
>>
>> Well it is at least partially for correctness as well.
>>
>> It is mandatory for quite a number of use cases that the signaling
>> status becomes visible before the callbacks finish because otherwise
>> you run into race conditions with the callbacks again.
> 
> That's not what I mean. There are two things here:
> 
> a) signaled-bit is read without lock-protection
> b) signaled-bit is set before callbacks execute
> 
> fixing a) makes b) irrelevant.

Not it doesn't. It prevents intentional execution of multiple things in parallel.

> But that's not even my point in this mail.
> 
> 
> I'm still interested btw in who is busy-polling on a fence, waiting
> until the signaled-bit gets true (that would be the "performance"
> argument).

Well that is the point I'm trying to explain. Nobody is busy polling the signaled bit! That is not why we do that.
> If you want to know when a fence changes from unsignaled to signaled,
> use this function:
> 
> dma_fence_add_callback()
> 
> problem solved.

That would enable interrupts.

>>> What signaling handler are you referring to?
>>
>> Take a look at the hack nouveau_fence_is_signaled() does for example.
>> The cleanup part the other signaling call path do is completely
>> missing here because the function can't take the fctx->lock.
> 
> Again, ops->signaled() merely has to read an atomic64_t and return a
> bool. Driver locks are not required here.

Yes they are. Take a look why nouveau installs the callback.

>>
>> Yes, but if we want to get away from the external lock concept in
>> dma_fence we must allow drivers to take their own fctx->lock inside
>> the enable_signaling callback.
>>
>> Just take a look at what nouveau_fence_enable_signaling() does, that
>> is only possible because the dma_fence framework has grabbed fctx-
>>> lock before calling this function.
>>
>> The alternative is forcing drivers to use lockless approaches for
>> their internal handling, and that is much much worse than that a
>> dma_fence signaling status is visible without taking the lock.
> 
> […]
> 
>> Just take nouveau_fence_enable_signaling() as an example, if we don't
>> use fctx->lock as external dma_fence lock then the whole approach
>> used here doesn't work any more.
> 
> My entire point is that the driver does not need any driver-lock
> conflicting with the fence-lock-order at all.

And that is what I strongly disagree on.
> I tried to point this out several times, but you keep iterating back to
> "this is what nouveau does".
> 
> That nouveau does it does not proof that it's necessary. It just proofs
> that nouveau does it.

But nouveau is a really really good example because it never installed the same workaround to the problem modern drivers amdgpu or XE have.

Yes it is possible to work around the problem in drivers, it's just not a good idea because you are moving the problem from the framework into the drivers.

>>>>
>>> My impression was more that central design criteria for dma_fence (like
>>> module unload of the driver who issued your fence, which is designed to
>>> live arbitrarily long) were ignored, there was no clear guidance for
>>> drivers how they should use what callback, and then driver problems
>>> were solved in dma_fence, for instance with this shared lock. So same
>>> story as with drm_sched.
>>
>> Yes, exactly that.
> 
> Good!
> 
> So we agree that the dma_fence backend should give clear guidance about
> what a driver must, must not and should do in its backend_ops
> implementations.
> 
> Right?

Correct, I completely agree on that.

> Because so far the conversation sounded to me like "the driver must be
> able to do whatever it wants and therefore needs to be able to grab
> whatever locks".

Yes, because that is something drivers should be able to do. Not allowing drivers that is a bad guidance from the framework.

It pushes the drivers into the wrong direction of using fragile approaches.

The much better guidance would be to have a single signaling path in which drivers call dma_fence_signal_*() so that drivers can start to cleanup after doing so.

It is still possible that drivers mess things up with both approaches, it's just that I think it is less likely with that one.
>> And that is strong evidence. Nouveau is actually the perfect example
>> of why this approach causes so much trouble for driver
>> implementations.
> 
> Calling Nouveau a "perfect example" is like calling Ronald McDonald a
> role model in dietary choices.

Oh that is a good one. Thanks for brightening up my day :D

> Nova is being written right now, for reasons.

My point is that nouveau is a good example just because it is so broken.

Take a look at amdgpu, it does the whole interrupt signaling with RCU protection and doesn't even implement the is_signaled callback for the same reason nouveau has bugs regarding the fence signaling.
>> And such guidance should not exist in the first place.
>>
>> It is up to the driver if they want to use locks for their internal
>> state protection and the dma_fence framework should absolutely not
>> enforce anything it doesn't need to deal with.
>>
>> That the dma_fence lock should protect the state of the dma_fence is
>> something I can perfectly agree on, but that does not include the ops
>> call chain because that isn't dma_fence state in the first place.
>>
>>> The only evidence I have ever seen is the fence-list-lock, and it's
>>> just not clear at all why any callback would need access to that.
>>
>> Because they need to clean things up after signaling.
>>
>>> Let's walk it through together, shall we?
>>>
>>> ops->release() and ->wait(): deprecated
>>>
>>> ops->get_XXX_name() -> never needs driver locks
>>>
>>> ops->signaled(): "Driver, here you read an atomic integer, the sequence
>>> number, and tell the fence backend whether this fence shall be regarded
>>> as completed"
>>> No need for any driver lock.
>>
>> Incorrect, you can only work without driver locks here when you delegate the cleanup.
>>
>> In other words either to a worker or the ->release callback, both are things we try to avoid.
>>
>> Again see nouveau as a perfect example of the problem.
>>
>>> If this particular driver also signals fences through an interrupt
>>> handler, it can take a list lock, then signal the fence. The ops must
>>> not do that.
>>> Why would a driver need both modes, sw *and* hw signaling? And why then
>>> is it supposedly the case that both paths need to keep a list updated?
>>
>> Because the signaling through the interrupt is mandatory for correct,
>> the signaling through the is_signaled callback is then on top for
>> performance optimizations.
> 
> is_signaled() never conflicts with any lock, see my list above.
> 
> I think at this point you and I should really first get in sync
> regarding what the backend_ops are supposed to do, because we seem to
> turn in circles a bit in our discussion.
> 
> And the only ops that seems to be controversial and that informs the
> nouveau argument is ops->enable_signaling()
> 
> What should enable_signaling() do, in your mind? What should we tell
> the driver to do in there?

The enable_signaling callback let's the backend know that some code depends on the fence to signal.

The backend can do different things to enable that, e.g. enabling HW interrupts, start a worker to suspend HW queues, or start a worker to poll the status in certain intervals etc...

The point is the framework doesn't know what the backend needs to do and it also shouldn't limit what the backend can do here.

What the framework needs to do is to give the right guidance, e.g. check if enabled signaling is called multiple times and only forward the first one to the driver, check if the fence is already signaled, check if the backend is even still around...
> And why does nouveau even implement it, when its interrupt handler will
> ultimately signal the fence anyways. Since, as usual, nothing is
> documented, and one enable_signaling function carries literally the
> name "no_signaling", I don't give it the benefit of the doubt and just
> assume that this is broken, bad design.
> 
> 
> My impression is that ops->enable_signaling() and having an interrupt
> handler signaling fences is mutually exclusive design-wise.

Well if a backend wants to implement both use cases then it is necessary for it to enable/disable interrupts based on calls to enable_signaling.

And when you have only one interrupt control for multiple fences then you need to common lock to protect that one interrupt control.

Regards,
Christian.

> 
> 
> P.
>>

