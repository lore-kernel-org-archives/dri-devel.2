Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309E606A909
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QtXMsVV+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EC410E6A9;
	Mon,  2 Nov 2026 17:04:48 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4761D10E69B;
 Mon,  2 Nov 2026 17:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+AfY82zEFdgIJDl1P/o+z/EgQ+l0ypOcAkIlrOSW4Q1kjW43sTS26bq4m0PCEMPGqXBpn/hXZWmCeqZzfXj07ryv6kSWLN85UsyWadbyAt55yEfgbpPMEit2QkNXOiJnfh2zO143ov6H8nHj+kXE+8G/Da/+/rQG6WA0aaTPy9Nl/PVIegOTUnbTajSq+MdID19ugYf+F4ukbv7y/5dGnLoLD764IDGfD0CEezB03o20adqeBgaaj+o2vYLlfDTmk7stcsoaUBO0X8EVzTLUOX11VJIWS48esxREbOifawHDGedvwtGbR/6RLBItIveFjGhMg6vLPm6PfZwW2zNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLi0+v4ms/cGqT+iPFNpIKjYcjqC5r299hphoblLr5E=;
 b=LIf6lAOVzbLc04Abk243MTimn7rGowC20FNpWdoBX/wJ+ii/Az+r/+gMSPapguUdazPneCSEiuReeuEiM2IV5Ae45FKxYdQ00GPe4CzukZnLkg9sYXznuvNLyUFSPkhZY+pnzIk738kbXhxTfs9lFkpiT5ufyPF5ytgbGqTE9bqnbCg5GSHm31430ok1wKQSjilYqtNQ+D2v1qgJK7g2WYnrBGITf3fgto01gjL8+76LMf2lI7bMM+R7PiviFB7w2U6X3yeu5l5BiRf3qlZqVHAa8o9V8AgaAF8rg7M+k9JdtC6V7OkHKQfdmFWpNtZZK29tgDC/dDChhuwSYgobZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLi0+v4ms/cGqT+iPFNpIKjYcjqC5r299hphoblLr5E=;
 b=QtXMsVV+3CXaLDYgKrQu9xe0JPQ7s+nkrUKA7ayC0tjcqRectjxs1SXBm5xPakv0GH4bFr+RfqkDQXl8XpeBikAdKhltTWj9lD/45KOBST3c1rsbgvz17gXaCw9uyek7iVF0aFQwJ3vy294C6QcDUZPXkF8Oef1gpu+SJcN9zV4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH6PR12MB902451.namprd12.prod.outlook.com (2603:10b6:510:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:04:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:04:37 +0000
Message-ID: <a7bc59fc-0615-41a8-a4df-eff0d8fab8ab@amd.com>
Date: Mon, 2 Nov 2026 18:04:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/amdgpu: add wedge event implementation
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
 <20261029152000.22001-4-pierre-eric.pelloux-prayer@amd.com>
 <0c8f89c5-b02b-491b-99a5-f881ea82a804@amd.com>
 <5d224d9e-514b-4d24-a272-8bf8c1267116@damsy.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5d224d9e-514b-4d24-a272-8bf8c1267116@damsy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:208:23c::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH6PR12MB902451:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbaa82d-da41-4c5d-a5a6-08df39036004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|22082099003|18002099003|261102123227099003|56012099006|11063799006|4143699003|261021123027099003|261021121427099003|261022075727099003|261009221227099003|261026140227099003|261022105027099003|261026121527099003|261009223027099003|261028144727099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: lKnbYqnqROv0C0ZvM51KdCgC4HbKdWOhD69yguRhF1VFKHZv4KEQ9u6wHJyp+muGDIOauMvvtcdwlw16gsf8GYuVX343zqT/x8445btk8M/6g+nRHqms1f/FT3dV3wYCRhdAMhCI/NOjc0xBA94KMhub6/+8JQfwrh+/KED7VJ5/QgkspEs89ehQezCbO5EJz6ADAo9nGZkmKQGbVw9wn3Le9LLHpAGEH3+ZoCFH/EtFbmdmegEA0bitUgbdNAxDi1VUV9eLBzH/T6mXc/+7cS1ooWkjNo4WB58zt7cmk/UwdvXSy1fVRwUG5Vf5g9usQbfv/KqEsqE+/SkXelP5hTcugIs3C3L7XCXNqdn/bzE+Jqh3493ECvpEOSwMoIbRHKzzZ3X/kXGZ2d1JXu6TLcuCXiXKL5aDDh8bEwwS+tc6gW6BMyJNKwAYHnCbh3JbfY6RBN/mXobWqSGQBBI4ej5RJb47FBA0BdRQKnzsC9SVyXqP3EescAe/f7RXO0lxuEuoMFkhkjtB33bNrUDZlluxAwbydMZ9zoJKgZ2gXVwKBR0C+WGETpmOmyt16EHUqbaI7xP/nTwTsdDHObeG+V94vPgHELlGIjUaVHJ+VCWxMIxuNQhwKykt0Gr7WDzH+zVjfohEbuadAsW9t4zAMWLzH4YXUZfsEA6tyM0xa/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(261102123227099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(261021121427099003)(261022075727099003)(261009221227099003)(261026140227099003)(261022105027099003)(261026121527099003)(261009223027099003)(261028144727099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXpnL253aTFKVDJvdmFBZTdlaXhMRExnZDlvNXZUNDl6bkdlSHdCclRQTG01?=
 =?utf-8?B?d3IvSlNBVGJLV1NlSjJudDl2RzdJMVRqVDNMcTJydi9VWmp5OTFzc25DQkFS?=
 =?utf-8?B?dHMwNm4zaXBqM1h1WHRFVHA1SVpHSFhaSDdieTB3byt0akJHdDVtZ0N2U1k2?=
 =?utf-8?B?VmJpbzhtWTlGYWp5ZVVadkliNFJRMVg1WGRKVncvY3VkbWg3Q1p5cVJlc0VQ?=
 =?utf-8?B?aHd0cmxoWndvd045S1BZY1lmcUx0WENLWDJIaVF2eW5oWXZKWG9jU2VGZVdQ?=
 =?utf-8?B?dFE1YXN5Y1Jza1h2blVOT0wwSmQ1UUtDRmNKWkt6M2hPWTd3QWZvUHEyV3JU?=
 =?utf-8?B?Qlc1bFk5TlNsS1VGNk9uenROL1IzaVdGSkl3WHJWemtnU0FucEpmU3FLMzVS?=
 =?utf-8?B?UzFLMU9nVmxWenZ1WUdZbXlValRRbkhSaDBBdktqTElNaDVSOEtWTVNCd0c0?=
 =?utf-8?B?ajZDeTd4QlFYK0UrUEg0aDRoZVV5WnJQRzIyaWlJY2VqcWdKQ1d5RjArSTJr?=
 =?utf-8?B?K1huK0hCTVVTWEEwamp1eTg1NXF2ODJFdVVTZjRsOVVRT2lUWk8wZTBiUjJS?=
 =?utf-8?B?Mmw1alZqZTZ2bWRDSmFzTmdEY3ZOTmQ5bWhVVVNabjQrUUJoN3N1NGMxY3oy?=
 =?utf-8?B?N1ZlSEw3ZFBmUXRETGt0Z1lvbVZzS1FHN052Vm9TME1vLzlucWVsZnVKVzln?=
 =?utf-8?B?WjhVN29Ma0V5SVM4TjMzYWhtQ3FJbU83TFdVRWFYK2NTM1hCUjQyNERRNFF4?=
 =?utf-8?B?S29iNDBiR2ZzZ2lVYmVrNGdtWW05TlY3VmxiRzlJS1cvOWREMGk3OWp2aElY?=
 =?utf-8?B?TTJScU52REhBamJ0WUNRblR0ZVJhQ1JWWUNqWmgzVW1IQzFudjhobk1lN2FY?=
 =?utf-8?B?cTNicWJiZDRMYnl0aTBITHJPaUN0aDBPdFNtRVRPYkVSdE5TRmw1cFFMcmN6?=
 =?utf-8?B?UkVSKzZpWlFOajU2N0ZFWHBxZWN1M3pCdHdJdXViVzZDK1NFejlBM2Roajl0?=
 =?utf-8?B?RExteWhWazZMczJFcEsxQ3VTUFBRd05KMC9BL3FpRTlUelZkMVBTNTJCa3RW?=
 =?utf-8?B?clVlZlNOenlWa0VMN3l0Qmw0YlBrQUsvTEsyU1R0cVVVWVRLcUIyakNhRWJV?=
 =?utf-8?B?bHZmQlFVSkVuT1hwNXdXWk1lbUxwLzZwK0tFTm4rL1JsWHp2cTc4NmEzdk1l?=
 =?utf-8?B?TWNXam1TNkVXZWUzSlhONFZENDVxYTFBVHlDQ1lyMWx6SFoxNDhRTUpoMXEr?=
 =?utf-8?B?K0xYUVlCcU1ZNTB0Sm5UQms0OE1yS3JheHk0Q1VDZ2FyRVMyWlN4UzFJWGlo?=
 =?utf-8?B?RDcvWmVwRkFmcmViOS9GY0E3blhCU1NSdlR3UU1hK0xmMU9FS21iTGludnNt?=
 =?utf-8?B?ZzRNR09vdGY4a2F4MXFRM1NVZmpEcnBJVzJCMjZERnB1MnZ6eExOdzNWZ1Zs?=
 =?utf-8?B?N0psMmxuUGthRktSWEtQUjRHblVVcDlUd0Q1T1VWMzZkNWxUcHE4b2VTbllV?=
 =?utf-8?B?Z1pFYml2dnhCd0lwQmNNbUFzSDZpSkJJY1JqRmFNekcybnhGYmpmMnpGdmt4?=
 =?utf-8?B?ajgvNHZaNzB3bWlBSVpiZGZlUzZYMUd4VTlEVUZ0RHRSSGsybENZb0JSc2Mx?=
 =?utf-8?B?N2FmbGI2aFgwOG9ZaWZaK0FuajI3UFRNMHVsVnB2aFZIZ1dDcU1CYXhtUTg1?=
 =?utf-8?B?MUsxUlk0TStBbnkxN2xwakswVlRBSWxhMklrMTFQMmVJWkdPdnljcEhYNUxW?=
 =?utf-8?B?N1kybVNhaDB6Nk51NTZCd2FLZGZRdTIydXJEckxJb3pFTTJjUGsvOE9GQTh6?=
 =?utf-8?B?aHliTHl0ZEVLWmNxZjh0YUs5VGYxRmVGVHpxV0FTS2dDUzBqeUkvTHArSXNz?=
 =?utf-8?B?c1JRRlVUcDczd2JDbDFyTklkSGFsNVRzRzhoVksvVVJMazAyZjdINU9JUW5E?=
 =?utf-8?B?VWl4ZUR5eVcveXdIb3VXOS9kVFMveURicVdmNy8weFVmMTRKOTdNclVpMmZa?=
 =?utf-8?B?cWNwTXF6MTRrUXIxWTVQNldPcFJoV0VFVzNyRkxPVEMycVhtU2dORW5kQXNu?=
 =?utf-8?B?dnRaRWg3MzFzVGxadHdTbHhTS0p3MFFKOVhoZmZFMFRNOHVtajR1ajUvckUx?=
 =?utf-8?B?eW1FSVN5RXdpS290S3cwUjBWOXBSbGNYUGRFeG5ybmlTYTJRcHdaSWhIeVFj?=
 =?utf-8?B?aUlwTEo5bjh4eE51NEdhdFdmRzNJMUNSbHQxeFpEeDg3K3RZQkNxQXJGUHFl?=
 =?utf-8?B?clN1ZmZoeE1QZ01wK0ZXVUZpQ0xYVGNGbFZadk5Vd2NVa2V2T1Z3QkMvTFlS?=
 =?utf-8?Q?XST+bkUAdDYXtJ0jJ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbaa82d-da41-4c5d-a5a6-08df39036004
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 17:04:37.0786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGdt2DjedGnEJZ2aLeUc/FFgrH0h+z9dSCHhJ8VbH0ptHYnRnm8turT6J1l0REm3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB902451
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 17:44, Pierre-Eric Pelloux-Prayer wrote:
> Le 02/11/2026 à 16:44, Christian König a écrit :
>> On 10/29/26 16:19, Pierre-Eric Pelloux-Prayer wrote:
>>> When a job times out the kernel tries to reset the GPU to get
>>> the system back to a normal state.
>>> Sometimes it's useful to disable this process - for instance to
>>> be able to inspect the hardware state at the time of the hang.
>>> Since leaving fence unsignalled might affect the system's
>>> stability, this commit enables the drm wedge framework for amdgpu.
>>>
>>> When a hang condition is detected, the GPU isn't reset but all
>>> the pending fences are signalled and the hung GPU cannot receive
>>> new work. For KFD it's implemented by making
>>> kfd_process_device_data_by_id return NULL if the requested GPU
>>> is wedged.
>>>
>>> When the user is done, it's possible to trigger a GPU
>>> reset.
>>>
>>> The auto-recovery is still enabled by default, and to use this
>>> feature one has to either:
>>> * boot with amdgpu.gpu_recovery=0: not recommended as it disables
>>>    recovery for all GPUs
>>> * write 0 to /sys/kernel/debug/dri/X/amdgpu_gpu_recover to disable
>>>    auto-recovery for one GPU only
>>>
>>> Runtime power management is disabled when the device is wedged
>>> (because we can't submit any work to the GPU).
>>>
>>> Assisted-by: LLM
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>
>> Looks mostly reasonable to me.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 13 +++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  3 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  8 +++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 34 ++++++++++++++++++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 12 ++++++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  6 +++-
>>>   8 files changed, 83 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 34bbb30b6f0c..cd4959486c94 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -989,6 +989,13 @@ struct amdgpu_device {
>>>        */
>>>       bool gpu_recovery_enabled;
>>>   +    /* Set to 1 when the device has been declared wedged following a
>>> +     * hang: it no longer accepts new work and pending fences have been
>>> +     * force-signalled. Reset to 0 once the device is reset back to a
>>> +     * working state.
>>> +     */
>>> +    atomic_t wedge_status;
>>> +
>>>       /* KFD
>>>        * Must be last --ends in a flexible-array member.
>>>        */
>>> @@ -1374,4 +1381,10 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
>>>                  uint64_t uid);
>>>   uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
>>>                      enum amdgpu_uid_type type, uint8_t inst);
>>> +
>>> +static inline bool amdgpu_device_is_wedged(struct amdgpu_device *adev)
>>> +{
>>> +    return atomic_read(&adev->wedge_status);
>>> +}
>>> +
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index fa301c71b782..d119de477284 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -1465,6 +1465,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>       if (!adev->accel_working)
>>>           return -EBUSY;
>>>   +    if (amdgpu_device_is_wedged(adev))
>>> +        return -ENODEV;
>>> +
>>>       PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>>>         r = PM_RUNTIME_ACQUIRE_ERR(&lock);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index ec2514079919..641b7fe24951 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4110,6 +4110,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>       }
>>>         adev->gpu_recovery_enabled = true;
>>> +    atomic_set(&adev->wedge_status, 0);
>>>     fence_driver_init:
>>>       /* Fence driver */
>>> @@ -4362,6 +4363,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>           amdgpu_sync_free(&adev->isolation[i].prev);
>>>       }
>>>   +    if (atomic_xchg(&adev->wedge_status, 0))
>>> +        pm_runtime_put_autosuspend(adev->dev);
>>> +
>>>       amdgpu_reset_fini(adev);
>>>         /* free i2c buses */
>>> @@ -5155,6 +5159,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>>>       r = 0;
>>>       list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>>           amdgpu_set_init_level(tmp_adev, init_level);
>>> +
>>> +        if (atomic_xchg(&tmp_adev->wedge_status, 0))
>>> +            pm_runtime_put_autosuspend(tmp_adev->dev);
>>> +
>>>           if (full_reset) {
>>>               /* post card */
>>>               amdgpu_reset_set_dpc_status(tmp_adev, false);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index fb60a99f43c1..617d4eec4e26 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -459,6 +459,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>>       uint32_t handle, initial_domain;
>>>       int r;
>>>   +    if (amdgpu_device_is_wedged(adev))
>>> +        return -ENODEV;
>>> +
>>>       PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>>>         r = PM_RUNTIME_ACQUIRE_ERR(&lock);
>>> @@ -961,6 +964,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>           abo = NULL;
>>>       }
>>>   +    if (amdgpu_device_is_wedged(adev)) {
>>> +        r = -ENODEV;
>>> +        goto error_put_gobj;
>>> +    }
>>> +
>>>       PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>>>         r = PM_RUNTIME_ACQUIRE_ERR(&lock);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index 4204c3c750a8..53fa9fa83ae7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -730,6 +730,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>>       struct amdgpu_job *job;
>>>       int r;
>>>   +    if (amdgpu_device_is_wedged(adev))
>>> +        return;
>>> +
>>>       ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>>>         if (!hub->sdma_invalidation_workaround || vmid ||
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 0b8d0a79dd45..f72c9c690c3b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -24,6 +24,7 @@
>>>   #include <linux/kthread.h>
>>>   #include <linux/wait.h>
>>>   #include <linux/sched.h>
>>> +#include <linux/pm_runtime.h>
>>>     #include <drm/drm_drv.h>
>>>   @@ -185,9 +186,35 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>           if (r)
>>>               dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
>>>       } else {
>>> -        drm_sched_suspend_timeout(&ring->sched);
>>> -        if (amdgpu_sriov_vf(adev))
>>> +        if (amdgpu_sriov_vf(adev)) {
>>> +            drm_sched_suspend_timeout(&ring->sched);
>>>               adev->virt.tdr_debug = true;
>>
>> I think we should just completely drop the tdr_debug approach from the VF handling under SRIOV.
> 
> 
> Can this be done in a follow up patchset?

No, this here will basically deprecate the existing tdr_debug approach for SRIOV.

Regards,
Christian.

> 
> Pierre-Eric
> 
>>
>> The wedge event approach should be completely sufficient to handle all of that.
>>
>> Regards,
>> Christian.
>>
>>> +        } else {
>>> +            struct drm_gpu_scheduler *sched;
>>> +            struct amdgpu_fence *guilty_fence;
>>> +
>>> +            /* Declare the device as wedged if it's not already. */
>>> +            if (!atomic_xchg(&adev->wedge_status, 1)) {
>>> +                /* This ref will be dropped in amdgpu_device_reinit_after_reset. */
>>> +                pm_runtime_get_noresume(adev->dev);
>>> +
>>> +                pci_clear_master(adev->pdev);
>>> +
>>> +                drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND, info);
>>> +            }
>>> +
>>> +            guilty_fence = to_amdgpu_job(s_job)->hw_fence;
>>> +
>>> +            sched = &ring->sched;
>>> +
>>> +            /* Prevent anybody else from touching the ring buffer. */
>>> +            drm_sched_wqueue_stop(sched);
>>> +
>>> +            amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
>>> +
>>> +            /* Start the scheduler again */
>>> +            drm_sched_wqueue_start(sched);
>>> +        }
>>>       }
>>>     exit:
>>> @@ -439,7 +466,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>>>         /* Skip job if VRAM is lost and never resubmit gangs */
>>>       if (job->generation != amdgpu_vm_generation(adev, job->vm) ||
>>> -        (job->job_run_counter && job->gang_submit))
>>> +        (job->job_run_counter && job->gang_submit) ||
>>> +        amdgpu_device_is_wedged(adev))
>>>           dma_fence_set_error(finished, -ECANCELED);
>>>         if (finished->error < 0) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 14a72a406d37..2393cad36ac0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -781,6 +781,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>           return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
>>>       }
>>>       case AMDGPU_INFO_TIMESTAMP: {
>>> +        if (amdgpu_device_is_wedged(adev))
>>> +            return -ENODEV;
>>> +
>>>           PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>>>             ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
>>> @@ -913,6 +916,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>           if (info->read_mmr_reg.count > 128)
>>>               return -EINVAL;
>>>   +        if (amdgpu_device_is_wedged(adev))
>>> +            return -ENODEV;
>>> +
>>>           PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>>>             ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
>>> @@ -953,6 +959,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>           uint64_t vm_size;
>>>           uint32_t pcie_gen_mask, pcie_width_mask;
>>>   +        if (amdgpu_device_is_wedged(adev))
>>> +            return -ENODEV;
>>> +
>>>           /* The clock limits are only available while the SMU is up. */
>>>           PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>>>   @@ -1187,6 +1196,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>           }
>>>       }
>>>       case AMDGPU_INFO_SENSOR: {
>>> +        if (amdgpu_device_is_wedged(adev))
>>> +            return -ENODEV;
>>> +
>>>           PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>>>             ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index ac18c2be6ecb..b95dddeaccc5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -2424,8 +2424,12 @@ struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p,
>>>           for (i = 0; i < p->n_pdds; i++) {
>>>               struct kfd_process_device *pdd = p->pdds[i];
>>>   -            if (pdd->user_gpu_id == gpu_id)
>>> +            if (pdd->user_gpu_id == gpu_id) {
>>> +                if (amdgpu_device_is_wedged(pdd->dev->adev))
>>> +                    return NULL;
>>> +
>>>                   return pdd;
>>> +            }
>>>           }
>>>       }
>>>       return NULL;
>>
> 

