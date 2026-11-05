Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C9606D818
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1YwZjkbL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F0610E657;
	Thu,  5 Nov 2026 12:25:16 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB3410E657
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 12:25:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zgw6yzrxtP8JyTAa2mz84ZJkUDPlPUpDUSvcQfkk2N2P/xDXElN6uOtRv4kgtdcT/uR9fZZEQRL5CvYJiWS9As6AqBYNgCHrFU5uVctGqYIlzj4UrQVqbbGagA7Qn+2CaHvNr5FWkDt2iegKnOJicFuVH8XtJrqxIUNyMxlQrzzpIUsxXgAz7+gO2Rw3Oewptf+MtpdIlS7F3vlbss9dNApsQNFNADtnDI1OGT2BS497lZpvN8VC604MXYJ/Viub5Cegj2LAm12xoLVCacuoa6CplCaWx0/HsDe3sD3Tp+TlbtwAUKhZ3TB8GS7v2RCNjNgcrf+Up1R1Aj4CfVkidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I0a9hAJPTnpUKx/dgbfBVJSbgdJISGfDfRvHfkKFjU=;
 b=WErZFxNvN9PHd/wD7Es/60MCPx7ZUW/uLsND12QMwpSbWCYas1ljYhe9rvtdAvV1/TMVidWI5jJU4kRDbbKdAkEgt5sd9c+u8FA9WEHCjeuQ74LOtIAhxrTHpc0bCibn8GDLdyOz+ZKxCICQjagG2slbc1psOu3TF3xiZ0SpmgOXhU8HInfhN6TpXCZqM2Hrag8LlUTnIcdmAQ4z6LfmBqKnPz/AMx4C+RkiJYEtim/2YdEHdXMAGMYFAMfPDwgKd2BilG2ntt0Y8Oj61gSvCZbwwFW52Ci0DUlpWk6z59faZZfkCX8ZcX/ZJX/6fxHBCZBEvBoMHaKyYELmbMTGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I0a9hAJPTnpUKx/dgbfBVJSbgdJISGfDfRvHfkKFjU=;
 b=1YwZjkbLIUHcozd6No4GTPC8j5AxhS0ldXQjaOobzLmgAx1Nb2jXtEyauA1Dqpsl8lBY+hzcgHrf3qjFZm95AFGkea8wdSTlatsVvgya0Re0x7XJOYNMvtguCVdHxiEWvwFei6UaXjP5sSBTMdMIQjWuX8msiJOl2fm7Zs8FbvQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 12:25:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 12:25:07 +0000
Message-ID: <a6a2ca76-94dc-4616-8160-d756713e22b9@amd.com>
Date: Thu, 5 Nov 2026 13:25:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/syncobj: Limit the number of handles and use
 kvmalloc for user-sized arrays
To: Tvrtko Ursulin <tursulin@ursulin.net>, "Yu, Fei" <fei.yu@intel.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 madhurkumar004@gmail.com, mripard@kernel.org, simona@ffwll.ch,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com, tzimmermann@suse.de
References: <39be711e-cd56-4a04-87ee-6aa2a0b69779@ursulin.net>
 <20261105081845.1230910-1-fei.yu@intel.com>
 <9c1805b5-06ae-426f-b286-9bbd43538afb@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9c1805b5-06ae-426f-b286-9bbd43538afb@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:208:335::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: e46d8255-35db-45dd-65c9-08df3b37d3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|261026121527099003|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261009223027099003|261022075727099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UN2/GRaUP0FVNZq09Lzcl8KZPSSycYEBwGGnsZ/3bvGnIs0lPkhNPS7kCGyYYxDFq/3qcT8/DhFcE87hwC1jPkfgWI7gUXSFHPf+D8Xm5LR/5k/IWj2I2CH7A9Jq5XqaUdBUf0dAvug/dvmF/Zf5UakL/q70DLmw4wOT4fjlNOVxKXWYEqyNWksT5OmdMlt97jPPkX1y+bC2vyWklDvQxJp3/KJ71IITcDyrQVvxO1Qm86QQpDhtDOspOK0iiJXnTLAZMd21ilbH4AeEidEvz962w6nR8E/DhXRLTVokiw9PWGk1FbMArb48xXEeryBRh1Lef+GD+HPTBig4aXd0LM92gtawfWrzud+XWh16meSQRhkwhkaCESnwjRslyF7xCLfv9R27mT6JbtbPVlx37oAcszdBkUOCc+YrMa+eh7ChwqeZd6VixTIs39tezStqVAboH1rowifDcjL1Imi04jqGw8spRnWIoxsN4KpseoP68qWECZfnNr7IeS9UnAIRTqdR6/MAVqQavBQ3KyrYKOkJlZuEEgqL5vEeCJY83bZhhN4mnRX7wUG89QKX1phZa+7BkTZ8WhLpgPgwChu4hBQPQN4NICTNy1xSks5EuIFdyo4uwh6IcPJdDpIOfDjk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(261026121527099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDNQUHFqR3A4dmpSNW0vaTVWNXQ3TTZiRWZwOEVHOGRLN0ZhVUtTZFRBWWhq?=
 =?utf-8?B?T3l0VGhWMzVXS05JbitKZjdSMXEvSGo1ZFlFVTlOWEg3ZFJpaTZzM3dQQ0pw?=
 =?utf-8?B?N1RZRXR6L1lRZmk1d09hczRTczNiOG1pWE5heGRBdUVhME1BalF0c3Z1b1g2?=
 =?utf-8?B?MC9SMHNFcGpZOGJPZm9pNWxXRWxGYjNFQ0swMjJsV3NSYXBWcms0K1NkMG9y?=
 =?utf-8?B?Q1kvOEpYT0lIaXAxSWpCZnIyQWZUeG9zRzBxNSt5OU0zMnZoT2V3YWFEeEI3?=
 =?utf-8?B?REhRcnlkejJTQWp5MEEwNEgwbEJwRjZQVGUvUmdqbGM2OThvRWRXbEhBQlVh?=
 =?utf-8?B?VEkwSjNOdnRiZ1YzSjRXV3IrbVlsUDExTUFsclB5cytSaVRmUVFIRWllWWhJ?=
 =?utf-8?B?VG81bzZzM2MvWC85OG5JWlhGelZjZFlsL0wyQTdUTDhyWTV0emFhQURpWEVI?=
 =?utf-8?B?UGNTYlBTWjE4NGxTSU52NUpvMCtBMUVCamxjZ1ArUVRyZzBGQ1RabnhhVi8v?=
 =?utf-8?B?dXJKMTBDMyt4Rll3Y2RFdWhyRFJTbHJ5QWZNcXh6YU1jdHZXSnFwbGxFckJO?=
 =?utf-8?B?MlpkUVNjOFZWdXRrSkgraUpraXAwS0tQT2JIQ3RQc3dsT3BaZWhoUW9SZ0NF?=
 =?utf-8?B?VE1FUmtNZGV4VUZYTlFvSlFQQWRzbVErWTMxT0krVDZBaWE4TU9MdGNJcXRT?=
 =?utf-8?B?M2RHank0WTd1NzBPZnp2K09DL2RhYmpHc0RxdUlqU0J1VnYwMExDL21uOVJx?=
 =?utf-8?B?ZXByTzRybXJPdUtKZVcyUld4RE14ODFCVGhIS2lNNTMwVXh5UWs1S0crZHJw?=
 =?utf-8?B?TmJYdzhFd2hYemhOZmdQcjg4RklUNlpRSGczWlQ0K0o5ZEJlS09DUmROMTk4?=
 =?utf-8?B?L2RYMDNieHdHMEVSMEdXQ3MvYVIxVS9tMHVKbHh5dnZ2MmFtMG8yTzhVb0M0?=
 =?utf-8?B?MlVqWTNhOVlPM3Q2SjUxT0pVVWIvUUlNaXM4ZjhzZGg3c0VSOU13c3NiSko0?=
 =?utf-8?B?WTdqdkdUMnZ4TmJJQlkxQTZzbllka1pMdXNqcy9zY0hnUWZVR0JuYzQ3TjlH?=
 =?utf-8?B?MGNRUCtzUGN6S0dGQzd5bmdtMzBqQWFjYnFRTFhRTlhEdFNpYUd1L1czdkgw?=
 =?utf-8?B?WGh0eTFBeVdoV0libVpudUQzSTRXaHQ3UHpGNzNPWFdCdnJURWFuaVladUY0?=
 =?utf-8?B?SVg5K0VmdEx2UzVTTzExOU9zU0Q4OXVFVENGK2pzK0RZSWdUZVY1azNSRjFL?=
 =?utf-8?B?Y2Z5emh0aThucHBoNmRLR25odm5UbzlSMUt2MkVnU0plVWVTYjR5RXRsRVBk?=
 =?utf-8?B?ZzlkeXFBZC8vcEljalJYMStLdzNWcE4rNDFoelk3bUI0MStlMDZSZFE5Nnhk?=
 =?utf-8?B?TTBpT0Z0NHpySWNtZWpSYUpVcHRTU1hZNktka3lGaHRMUjNGRzNiWVI0bE0v?=
 =?utf-8?B?NjVaS2ZHaTFEZHZPVk9xcnFOWFZwUkdHcjY2K0dmUlBzcEliTWJBdkxkOHlD?=
 =?utf-8?B?MXBkTVZMemVEYVJOVjRBL0x5TDFRdmNLd1pvcXU2WFlDMVpILzBuQUVCOGhI?=
 =?utf-8?B?SWNpNnNhY293VllIaHpmZ3B4bzhFUW9HaThuZjJIYkhTd0VORnVqNnVVUmtU?=
 =?utf-8?B?NmdTd0ZDUVZEK1Y0cnZmMERweDhTRXNTZEhuR2h6MEFOdEpVSll1VVZ4Uzh0?=
 =?utf-8?B?VXZGT0h0enFDWnhNNTJXVm90QmxpcUxqeitsQllPbVQ5M1RQQ3pQOEkvTmUr?=
 =?utf-8?B?M2tNcjNWSVpMQWNFa0dlK0dVMjNLT1hrQSttdTZiZjFpcS9ldFRqUHJhWFlF?=
 =?utf-8?B?RXZWem5NSit6N3ZVVDhFRCtaaktBM3g1clhENUVVN28xZVZaV09aZnhvZk05?=
 =?utf-8?B?eXY3MzR4L2Q1SERJVlVTVVJFdklESFdFM1BseXJsY1NpbWc5MFg2N1RFNzhs?=
 =?utf-8?B?YUd2NXl4bmZ3QWdKUlJlNm1Ydm1uNHVBeHJDeEZZbmt1UXhuMEZCY2xJb2Ix?=
 =?utf-8?B?bHNMTDVxak9EMU5mYWcwVjRjeDVncnZtaUJmWjdTTkpscDZsRlo4NXAwUHNS?=
 =?utf-8?B?bU5MTGN5RTVydmg0Y0VNQlJRU3BTZmVjakpxYUJ2OVhsRVh0Uy94Kzh5YzFk?=
 =?utf-8?B?Z3RtMUw2YTczWEpGM2F3TWtzbjVaNWpWYmF4MG1rWFpXSWdFZHZwM3pmOFV2?=
 =?utf-8?B?Sm1scjlqNXVVZUkzU0NHQ0FUQ1FIL0RaSmhIaEJlTGgwUHdhZURHSEUzYXNY?=
 =?utf-8?B?c3VROFJPbnc4ZnVTRCtSRkJtMms4MU4xbkdsR2NKLzhzY1ZIMm52Y1lnWnVz?=
 =?utf-8?Q?7c3hPY6sTEXfHvW94y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46d8255-35db-45dd-65c9-08df3b37d3bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 12:25:07.3146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSZQSuaycYJOKUr3vTofgcYAxts0pC3E1vXlmZPxnocwzAlitZ9CodITb0FEgJSz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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

On 11/5/26 10:12, Tvrtko Ursulin wrote:
> On 05/11/2026 08:18, Yu, Fei wrote:
>> From: Fei Yu <fei.yu@intel.com>
>> On 04/11/2026 10:27, Tvrtko Ursulin wrote:
>>> On 04/11/2026 09:44, Christian König wrote:
>>>> On 11/4/26 04:09, Yu, Fei wrote:
>>>>> +#define DRM_SYNCOBJ_MAX_HANDLES        (INT_MAX / sizeof(struct syncobj_wait_entry))
>>>>
>>>> I really wonder if we should put that into the uAPI files?
>>>>
>>>> Not that userspace is potentially using it, but this is part of the uAPI
>>>> and makes sense for documentation purposes.
>>
>> I thought about that, but I'd prefer to keep it kernel internal, at
>> least for this fix:
>>
>>   - The value is derived from the size of a kernel internal struct and
>>     from the kvmalloc() size limit, so it is not the same on 32-bit and
>>     64-bit.

Oh that is a really good point, but most certainly a bad idea.

This means that code working on 32bit then suddenly fails on 64bit, not something we should do.

>>     To put it in drm.h I would have to replace it with a fixed
>>     number, and that number becomes ABI. We could not easily raise or
>>     lower it later.

I think I prefer a fixed number here. Something reasonable large enough, like 64k or similar, should do for backporting.

>>
>>   - Tvrtko's series below avoids most of these allocations. Once that
>>     lands, the right limit may be different, and an internal define is
>>     easier to change.
>>
>>   - The patch has a Fixes tag, and keeping it out of the uAPI header
>>     keeps the stable backport small.
>>
>> For documentation, I could send a follow-up that adds a sentence to the
>> uAPI struct comments, saying that count_handles above an implementation
>> defined limit is rejected with -EINVAL. That documents the behavior
>> without fixing a number. Would that work for you?

With Tvrko's patch to avoid most of the allocations in the future that approach sounds reasonable.

But I would still use a fixed number and maybe a static assert that we don't hit the kvmalloc limit when we allocate that fixed number of structures.

>>
>>>> That kvmalloc_array() + the following copy_from_user should probably be
>>>> replaced by using vmemdup_array_user(). But that should of course be a
>>>> separate patch.
>>>
>>> Btw I tried to do that some time ago:
>>>
>>> https://lore.kernel.org/dri-devel/20251106132645.28208-1-tvrtko.ursulin@igalia.com/#t
>>>
>>> I have as local, more recent version which applies, but apparently never
>>> sent it.
>>>
>>> Interesting part should also be the other patches from the above linked
>>> series which avoid allocations altogether for the vast majority of cases.
>>>
>>> If there is interest I can re-base and re-send after this is merged.
>>
>> Thanks, I wasn't aware of that series. I'll leave the
>> vmemdup_array_user() and points array cleanups to it, so we don't
>> duplicate work. Happy to test it once this fix is in.
> 
> Thanks - just to clarify though - I understand I wait for your patch to land and then rebase my series, right?

Right. This here is for -fixes, cleanups are for -next.

Christian.


> 
> Regards,
> 
> Tvrtko
> 

