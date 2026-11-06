Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B848606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KvF3MU9p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C7A710E9E7;
	Fri,  6 Nov 2026 09:55:40 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D925410E9E7
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnNbaqk2/qQ1kLSU8KFigA28/WyxgzIvwUolhm6sxbOoDl9RNNBeA0r/8tyj/OYHf86Stjyzc3OsQS+Hq1WnMFcPTzR9z2lE71sTwDw/Qmd2hR2tdeKgma5AgcbGJnz4lHcfQM+dKdz9KGAtdl5htGf92u7jlPSV2nNN9Z6R6nIL934IooTv5Ps74OHO8RzA5Z9+pBDAf4nsqHcUaKdr1fvS7onk1HG6oisqEB6GY0lYUFxdSEol72XhG5lZhXK8Adbg1osEvOviuOU8GoEa34u4zP+FJpSpOnvm4Xpxqm0Qkuy9mWJ3Yh4t4EX9XVZ5yBFuwu+hGE+XQr+WAvc1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP239nmPVbLGvFfv8SkdItuz20fnijRQl/xs6NAWlsk=;
 b=NweVAAS/gu/AKxe/WgbxHOhmoT/3dOc2NucN7lQgKzUokj+ilW46ZGh0wzcCbujefiSGh4wkBUbcI53hGPDyuQlxMmUv1bl3wcJIVtUz77WLRzdghMqX8zQGW8jZjBaQqh2MLl1VwuWkkDN+uktcw4ntPXxMvLIWSw87xuxMBzU6rwv1n5y/Rydaw1g0ounba51nld2HFEwb1g955Kzcjj+CGKxYkbvwULfmvtXMiLGjf0rtEJqwkyzWjD/pPRhywomogDs8HzwO/aEDTv1Kyq9kXp0q3RqXq3Jed9Dg1mOxjdBlKlgoHZpVHXZsWEDQvMhVLGNaG1tuQYlyqF7TvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP239nmPVbLGvFfv8SkdItuz20fnijRQl/xs6NAWlsk=;
 b=KvF3MU9poMK43D/+Ay/1gmAUuyJiPXk6+V/TSRpb3a6CBZc26aAW5L3HbwZhCx40SGWee/xV0he8rRo+yaLsxWwh/csa/bM0LwLIduJuk02pd4wBTbMJo6dYHTcgMtd+VECrlWVWNv0mHBVFDY+RlU/vcjqzn4dTwMhV4mm4c6U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 09:55:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:55:28 +0000
Message-ID: <a37fc9d5-ebc6-4a31-b393-11a09a73eefe@amd.com>
Date: Fri, 6 Nov 2026 10:55:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/syncobj: Limit the number of handles and use
 kvmalloc for user-sized arrays
To: "Yu, Fei" <fei.yu@intel.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 madhurkumar004@gmail.com, mripard@kernel.org, simona@ffwll.ch,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com, tursulin@ursulin.net,
 tzimmermann@suse.de
References: <a6a2ca76-94dc-4616-8160-d756713e22b9@amd.com>
 <20261106053503.1437526-1-fei.yu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261106053503.1437526-1-fei.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3e179d-948b-4b6b-0576-08df3bec1661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|376014|366016|261021121427099003|11063799006|56012099006|4143699003|261028144727099003|261022105027099003|5023799004|261026121527099003|261026140227099003|10067099003|22082099003|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: ++ntfpAU0ycvk+SJytTDJGE9ECtT/yrX9mC6hXJqx/RPXB0qyDWly+SWSxmxcpo19GufIwPoZ89Gf5O4SP4jSqKXel9x1dCKlJys49IowULJWvw72hEh1TB0t8UFkODJMXikwGQ6Z05chLPOWj572jZqMzzKCVPUdWhIPQwEm4PugkzrnZA+OFQMibVtAn4qc8iU+VDEhaySRKKlwZ/KxhPbhMrq6szy1U86x6ok+oHEEY0X8ONLEe9coXFi2VUEMMC/aZzukiT25RwpuwtoX4CqRlYAyZniYH8KWW0k//NIm2FveLqbdAs+kkRRZ1+j0GO3dCH6rkOFLyjQzXwotD/ckBAFx4I+OZj0zuLwBWZTISMDG1rmz9eMKylkXQ6Rf7jxnhRF9kMc+TmX6Qrec/FWDrO8KCRkC8kAxFdp7erCUqviZWbQRlEC67rLlvfDL5ED0fQPv/1qbBloeGHjY+eZZ9x9BNeD3x2QzhBWvphBhQ/wVBLtqOgb+8+Q74+UaWEJ2foSWQqmt4AaMQP6hVOlyyxploDMq/uE3GSuFLUhcBVoaGKDcmZU3YZMh+Ej8dRQiydQjMMZBMtmEACQGUtgPfe6t8atDPGLzflZXycz3PyfdDHI/y31wsD+fbh3P55Ea6V0a9Ozw4sM2zwILx7NKu9LJicQVP4wuEJtogw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(261021121427099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261022105027099003)(5023799004)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDM5dUtvaXY5MFNQd3Y3WWRpb2pJeHJGZWRjWlpiakFBTHluajR6WEtLa1Qw?=
 =?utf-8?B?eVBiQ2pERnFIb3VNT2IwalBxekhwOW9OUDJRdTFiTk1OWFcyR1MvU1FPSm1B?=
 =?utf-8?B?bVVaUktuckV2SURZMG1EUmVrWVpJVHV4eTRVMVB5Ym1CR1dmMWRMcUVtTTcr?=
 =?utf-8?B?b2pYclhCRmVxSml1cXpPaVp4Nlk3N1NqWHV6dlpQNGdGM0ZpL243NkRKTUR1?=
 =?utf-8?B?bk9RZ2VhanlIWnc3aFRtS3V0aTI4a0RHK1lDd0VQTWRLZU1ERWcyeVdEZXUw?=
 =?utf-8?B?bmR6aHJCZ2dvc3BCOENJNncxUGxadnEzOXBsZTVQd0hBT1ZFU0t5UXFjK01E?=
 =?utf-8?B?ek4zZ3VXRnE2d1R3eHZpcU5YcWMvRjBIMTErblFpR3ZXbFZlNGZ6dWxYc283?=
 =?utf-8?B?ek1mTUdsNkZTWXR2cHNUeDBkRzRITmV3Y2VDeVhkdWh3UGtNamE4UCtDL3gy?=
 =?utf-8?B?cUhCOUJlbW1WVGtRWkdvWEJIT2puZUtGc1BBaC9Fc2YrMi9kWWtMaWdKZ1ZS?=
 =?utf-8?B?WFM5RmNyS3Nadmg5dUR6QVlaWjRyRzlucjRRR0c4NkZnYk9yWVc4V3NmaVdx?=
 =?utf-8?B?UDBUYk1TZnRDa2s1b05vRUFXK01MbVNPT2hHbTFMeTFoY0dubEQzbndQa1V0?=
 =?utf-8?B?dEFTdHdFMFFpc21ZSkkzQm9xOHRKQzIxVHhWSytMbDNrSnkxQ2VvWHR3S2lz?=
 =?utf-8?B?ZWRaWGlnWWNJS3VBSFBtZ1MrMk1LQXR4TDJRU090NnlqLytCLzJGRlU0VDU3?=
 =?utf-8?B?dUdlTEkyaXdZNnVoeUNuQ0hJSnBkcWRCeFVjcWJWSmN5djdaYnU5QlZEQ1ZP?=
 =?utf-8?B?V1hWNi9NRzdiaitKaDdqK0NrQmhzMW1qd2NKR1FNVklEWCtyV0J3NC9OQjYr?=
 =?utf-8?B?UmNVQ1NVM0JMV1hNUzZ0NjRwRHdYZVhHRm11M0MzYUZXYjhSMk5oM1BPY0Ew?=
 =?utf-8?B?amVqRlUweEFoTVRwV2pjWTR6MC9KZllWd2d4Y2g1OGJ0Ylg0OEpEc2VEcitI?=
 =?utf-8?B?ZDM4MUE3K2dUOFhxNXRlWDkzc0x3R1o5RUZJdDdxOHVRQ1o4NFg2dVR4c3cw?=
 =?utf-8?B?alFJS2xxczFzSHFUdWVRa0M1MXZpL1VqU2RkSW0veDBzSW95cXpDOFNXMUVl?=
 =?utf-8?B?akxEOW5PdGswRk5ibnBjanRBOHVNSEpnZTl5cWh6L2d0R0p4RXF6WjdMWVpU?=
 =?utf-8?B?L1UwMmJEM1FObDIrcTI3VUhDOEhCSmpadC93ejViOFhZQTBxZWtlL25LeDQ1?=
 =?utf-8?B?WENZM0tmbzlxa0Y5UG1TS0I5TEw2ckxzdWVvd1dJZmoxaUZReHZxNlQzZmdv?=
 =?utf-8?B?YlNRK3RvLzBSOURoK1lLT1k5RGNwWDE0SlBnaFI2T2QrR05HUzFacTJYMFZC?=
 =?utf-8?B?MWxCTFd5bW1jeSt3YVByNE1kRi9wenJRbmhUUEpaRkpOR2x1a2FDd1JST2xr?=
 =?utf-8?B?TldMMEk1bXJJL3IzSDdNRk5HeE9qc3lZTUZqcUxzOCtPd2Y2bXpiNUhVS0Zn?=
 =?utf-8?B?NlJvZ2M4elRWVHNCUzlqZWxZdlBDbGxyWHVBb1ZKTHJyY2JQaDRuZ0JpbDMv?=
 =?utf-8?B?aE1EN2pVMWR4bCtKRUFMdjBjMExjZjNkaXUraTUwNSthZ3RreDJzTENpclpI?=
 =?utf-8?B?MjVvZGJqV3NkK2g2dzNsb05wb0tYemhZMzBMN0hJNTJRM3lqRnllVmNRdTYv?=
 =?utf-8?B?UnBEM1lQdlhkWEo4RTNTemUwczJieFpSdGtYSHN6NUx5bllyTm9JZFA0NHIw?=
 =?utf-8?B?MmtySkRQS2lBRllGU3l4VFdZSXlsRUhIdjA1MzZkb0NoOWxIeFd1eVlmVXVN?=
 =?utf-8?B?UEZJNUVGQkhlNm4wWWFZZUt5QTFucjZaL1JaQ3FuOElVTmtMNFg4bHBXZy9H?=
 =?utf-8?B?c0dIMVdqWkpERlhHaXhDN2d1N3l2RFlWdHFqWHVCUFEvTUZicFhiMEpIWm9z?=
 =?utf-8?B?TkRkb1BYM0x1NWlTakN5OUFaUW1jMExkaFVuVXM3WTE2dE1lREdKM0lqdDQw?=
 =?utf-8?B?SStSU2NvazNrSUtXU0R6R1N5UDRCNWNpcFlRMzllU3RtRHpOUkdMcVdsS0sx?=
 =?utf-8?B?UERnQ1BYQVZxSlBMSEpWTE12L2dSVlZoRTRqUWMrNm5SL1hlSktwR0d3QUFI?=
 =?utf-8?B?SFltTXVnWktpZ2p4YWl2bTZmRjFhTTh0MWFVR01lVjBmVkQ2aUlSdGFWTzYz?=
 =?utf-8?B?OFVqUVVuN1NpcENhRVZyaHcyZXdiSXlya1gvWHRCTjlQN0N5N1pkZzl0Tyt1?=
 =?utf-8?B?WXZJeSt5NkYxTk12N1FQSWNiTjNQN0pjSTV6cEZrb3ZDL0xvTU1mMlU2azFG?=
 =?utf-8?Q?qD8H9eiMTed4iGiSfM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3e179d-948b-4b6b-0576-08df3bec1661
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:55:28.7030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBFc9sRr4gGNpCcMKlpBwrk8sAZWX8HZjtMuuNLMkqZSuRbZLtbGBGGuIu4ksZke
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9708
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

On 11/6/26 06:35, Yu, Fei wrote:
> From: Fei Yu <fei.yu@intel.com>
> 
> On 11/5/26, Christian König wrote:
>> On 11/5/26 10:12, Tvrtko Ursulin wrote:
>>> On 05/11/2026 08:18, Yu, Fei wrote:
>>>>  - The value is derived from the size of a kernel internal struct and
>>>>    from the kvmalloc() size limit, so it is not the same on 32-bit and
>>>>    64-bit.
>>
>> Oh that is a really good point, but most certainly a bad idea.
>>
>> This means that code working on 32bit then suddenly fails on 64bit, not
>> something we should do.
> 
> Agreed, a fixed number is better.
> 
>> I think I prefer a fixed number here. Something reasonable large enough,
>> like 64k or similar, should do for backporting.
> 
> One concern with 64K: today only wait and timeline_wait break above
> ~64K handles, because of the 64-byte wait entries. The other ioctls
> only allocate 4-8 bytes per handle, so on x86_64 reset, signal, query
> and timeline_signal currently work up to ~512K handles. In my v2
> testing, reset, signal and timeline_signal on 200000 handles succeed on
> the base kernel. With a 64K limit they would start returning -EINVAL
> after this fix, which I would rather avoid in a stable backport.
> 
> So I would suggest SZ_1M instead:
> 
>  - it is above what any of these ioctls can handle today, so nothing
>    that works now starts failing;
>  - 1M wait entries are 64 MiB, far below the kvmalloc() INT_MAX limit;
>  - it is the same on 32-bit and 64-bit.

Work for me and should really cover everything ever needed here.

> 
> If you still prefer 64K, I'll go with that.
> 
>> But I would still use a fixed number and maybe a static assert that we
>> don't hit the kvmalloc limit when we allocate that fixed number of
>> structures.
> 
> Will do. Something like:
> 
>   #define DRM_SYNCOBJ_MAX_HANDLES	SZ_1M
>   static_assert(DRM_SYNCOBJ_MAX_HANDLES <=
>                 INT_MAX / sizeof(struct syncobj_wait_entry));

Looks good but I have no idea if that really works or not :)

> Plan for v3, for -fixes:
> 
>  - fixed DRM_SYNCOBJ_MAX_HANDLES plus the static_assert, define kept in
>    drm_syncobj.c;
>  - keep the kvmalloc() conversion;
>  - update the commit message accordingly.
> 
> The uAPI documentation of the limit will be a separate patch for -next
> once this has landed.

Yeah work for me as well.

Thanks,
Christian.

> 
> Regards,
> Fei

