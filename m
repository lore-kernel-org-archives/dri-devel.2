Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52746CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C87410E289;
	Wed, 13 May 2026 15:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YDyUX2nU";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4941F10E289;
 Wed, 13 May 2026 15:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ggreko1jy4qb5ITnKl+tgVK89oqUcmRl1B3UTnhi4yB8DQy+blSarIvXZj+eV9L9Ndd98KxLDAt3hIUOmbkAErZr/DUDO7IV3OHlAyigt32jEfzqvke6GsdDqYVAmwN8PLLgTZAcEEMuwHQswtHtKRzY+OqDaxXHXpSEU2dDBSIIkbLWOZvvM8g6gzbKUKKNudpQQPmZR7HORhSkDGeeArrZg3m9LoKt4c/zLllXZWCiIAOztAFdJqkO/BBZqNwhu6u3t4H/QQPp1MUpSR1dopXLUCh1UXuLaj+m7A3NaGauCC/zCGcoVwnbgrKe2bByGI+IgF6+M+ShSbJdwVTMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JIYxK2rB2EHEx8hTNCIir0LgwxFTwd+VZ/2P4Kqu2A=;
 b=U2J4Wg2iniNVkQ+tH4iJNSvx71HYqtApKQSDi5nRTZLWoRcxmhoaF9L/S+8FubsYi21BaBz8COsui5rX3SLnqxshgFyrm+jgVAsr6/Wwtv2GG9SgMyO2lMN5RxGmO/1Ouc75oVogTZ3y53F4ephUlAKr5JffBNb1Cf6Yzw6vWi3jQwxNsIprPLgYYgAlFRgfmzogVfS3EUThaFpiv8FaNo9ucrHg6fU1Xomg61tqJ3UZnsBUarxbRUP0WMBG4H/KBj3xGuxuFoEaby0UxaY8WU2X8r5OVrGjqMkxitFJYfk9Ur5yXGXpREPW0nohGIUoPX7CJhkIWdWFefOc3qlxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JIYxK2rB2EHEx8hTNCIir0LgwxFTwd+VZ/2P4Kqu2A=;
 b=YDyUX2nURG14/eCLetnaB+9072Z+7ruEMYibB7K1SLGUcll0foISho0CXy/4bvE4EE+r+2wNINX5Ow4jz2XQdHKFjUaHHOiyrurPmGhKNvTrWzekresFOPJJUr7CVOfyoifpIUlwxx3RWNwo2u/ggwZE4qqro6HvQaYloGmpreA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 15:42:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 15:42:14 +0000
Message-ID: <515d482b-8e00-4dd0-b66f-45cb4458bf01@amd.com>
Date: Wed, 13 May 2026 17:42:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Support 52-bit PAs in ttm_place
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512223154.18089-1-felix.kuehling@amd.com>
 <c113ce66-5712-4fc6-bbf2-45239a97f773@amd.com>
 <2efb0669-d0e8-4887-86ea-cf095e915689@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2efb0669-d0e8-4887-86ea-cf095e915689@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a9438e-aabf-4375-acfc-08deb1063427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: hbs51tX9Fr3fNS/yhRquGmuHYY2p+VkZoMh3WH1VdyXs11DTnHWj8Vp7Kntwms9sOFK/IqRCxSftmNE0plRdv+LFfSh7vYCkGdLrmcHq4RbPzb7yUJ5EUtg7FoY7CGyx/9cY+gCtf/Vo4tmNlsyF+zrDAc/X5FMPtDsC+w5+uITwx1E1/6K6ekJz5tmdZ4KWgQ+lUYfiWHhRy3S41/DPxAVw0M2B1seeuUPNLL3WojxngfPr+pGckFkogpwPBOJ29zZUFB0roywBAwysuMajOFp4EGdm1+0Od6o4m9yK8BnB01Pk1Ss1qepCsctXOQ3AQBn+Fa1oY6LrYZH3nZZuN35wzIHem0uHHW5x7NQKnPCB/pqaYKaYAPWRveMxy2iV8fgFzCrUASbFN8wOg0B3GdMzUEF8TgjDmh7BcOwUsLkt9y9bn3Qe0X6uiay53uKO2brycw0p0bPoTB7FgARtrfbLYHyQERcUkFoKgAkNkpSu1cVfUF3+YOO661eSFsrwJJTEUcZ5KWH/YKQynAHNhNfmYzOp5mumHCMTvnzk92Pj0CMAYEI9LKzQSLwrCkXGhytT0ex2hJN9KcFtUsTd1q7gAm5h3Ors2Y2iT52LPqkAgUTl8aF0bHvIiWm1XaqP4q04QXn6y+yGL+fs/x8NTE+x4CmJbww9KGYijUa8WbdJM0jJUudkhW5Pj07742eC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUx5d2E3aWl4QVJILzdYcktFVlFFT0hRUkowNmlmK1RuU085OWxMaXQwOE5t?=
 =?utf-8?B?OGZsOVhIUnlBYitRbG9KSEs2N0l5KzhMWG90UjNROGU0ZnNkRVhyS3NBWkMy?=
 =?utf-8?B?UStOU3JTcWY3Z29HWWRSTVhna2lqRXRRR0ZjR0xUdmxzbkZuaTFkeWFKWEJU?=
 =?utf-8?B?L2UxNlJFSy9IL1Facit3dTVHelQzL2UxWGxSTnU1ODdIcVhtYkdIZnFhS2dD?=
 =?utf-8?B?VGpMME53OEZXTXRTVE8yUlRCajRyYTJ6cWNUOFQvY0VYeW1EdjVPdG9zZDd0?=
 =?utf-8?B?TDZiR3JKbGNSSVRXeEgyVUVwYndJU2IzcjFUaWVPSjNsOWJyUG5qTGpNak5G?=
 =?utf-8?B?YjJtdXo2R3FndWJMdFd3bXR2YUFUSDBSNGNSSzJEcno4bGtpUjljUGtIVlMz?=
 =?utf-8?B?MnRSdFIrMXpqalVVaG9xRzcwbGZWcmFaMTlhdVpLYW91UmNSOHlFQzJ4cGMy?=
 =?utf-8?B?ZllkMlBSTjNzQXc2RUwvd0JpdWJQbStNbXRDaHFFYnN6b0VMdFpURW5sN2h6?=
 =?utf-8?B?MWpjUzNzUGJydlBIdDk1UHJ5dkRRVzlROHhIbFBaZmJ5dHpKMUZRb3pUQitR?=
 =?utf-8?B?M25lbEdPdURpbUtMTUFRMHNaNUtIVW9IYWhzTllCV1V6dVo4WVZVZW5OUm1y?=
 =?utf-8?B?aklocjdGOERTSDRNS201bXgxcGIxTjZtRHVVQ1Q5VnZMSWtsdjZmR3hMUm1l?=
 =?utf-8?B?a1pFbTIwbmpjT0tSdE1VWjBkV3lhazMyMW5BakY0Rzg3VEMwNGVkY2pvR2s2?=
 =?utf-8?B?OEpqK3dXeS9ZSTZEclMxM1loQkE2N2ttSTA2NUxacU5zdHhqN0J2ZFZzcS9R?=
 =?utf-8?B?RytNR3YxcllMM3FqSVRTOGZ4WVNsRHV5SnJkQ2Rhbkw1ZmhTaU92dmltOE0w?=
 =?utf-8?B?NmoyWDY4TGthcWZPVEdXYjdwNDlla3VTQU5mL2h0Sk45bVh1SlppYUZlUU1r?=
 =?utf-8?B?RklSVExZbjJsSWRKQTQvUThlREw0RVQzVDJjWWttQytHVkhpS3JxckJtZE90?=
 =?utf-8?B?bEMwUjFtU0Q0Yzl6dTI5b0JFZFQrUDMwSzVpRDRpVkFGNEVGZ2phYUtnZCtn?=
 =?utf-8?B?SEp0SHFYZGxJK2tMV0l0U25ubjRRTmc3c2paYXBldEEwQ042YzhPRDl6ZEUr?=
 =?utf-8?B?bmQxT2I4Nyt1OW1QUy91OHpUTzF6SVB4eUZRMitnV1FVVi90RmNTYVZ3S0VV?=
 =?utf-8?B?U0c2ZjdKK3JVYXBjR2h0ZjUwbGwzTVhBZThWbGxGRkxZTTY4L0NnU3FKMzRa?=
 =?utf-8?B?R1RTTHFycGhRakovMDFmTVhZTXIxWXB4WDZhNWsvQ1dBQXpFQXowU3ZVOGkx?=
 =?utf-8?B?cFFEenp4eEl2eldmazVXbnJuKzRDMzhZVG0zbDVkMHo0K0c3OGlSQXVCWUwz?=
 =?utf-8?B?cE9yQ3dTS3JTbmdHd1gxd1IxRGFmeGhQbEplSWZ1cjBjekJrZGFZclZobGVj?=
 =?utf-8?B?VmJjczNkQzk2WmRWSW1lMmFTWEI3d3lFQWJJWnVEc3liUDJlQzdoNUJNUlpO?=
 =?utf-8?B?NWtQamdIY1NrRjZsRFRNVFV6LzdDM0hTUm1uVFl5VldkNnRNY2pGY1FhUEFk?=
 =?utf-8?B?Z09vYXJteFg4Q2hxZTRPcmRLY2Y2L3BGdldVN2JBaHNHcHBoYTR4M0lYalk1?=
 =?utf-8?B?UmwvWlZrT25ldmhqZnhpTlp4OWhZWUVrTEtiMGtLK0RyeFY1aFEyQU8xWmd1?=
 =?utf-8?B?RUJMSmRjelpNQ3BSdk1TVFRMYTZ2Q1lBQUE0cVJ6dE1RWGFBZjZkazg1WXJK?=
 =?utf-8?B?cVRQVmNzZHBLUEdNSWl2M2hSVDBKOWkyY3MrSkFMUXpJcDdqMWVBaGFka0RD?=
 =?utf-8?B?N0FsbkE4UGFzb3B1ZDdjRWMrK2E0UGtJVDNUTTdrVG5wNndpeFliK3dkNlRR?=
 =?utf-8?B?bXIrV0E5RHYrMUF1SU5JOXdVN0pMQnY2c1JLcjEwRHhzSmlsOHZaMWlUUG9X?=
 =?utf-8?B?WVVUT2paRXBpTDl0QlZONkJjcUkwb3BuT0lxRnBXL3ZUb0dqVzlaaHZzK0lk?=
 =?utf-8?B?ajh2UlgvbldlRm5FZlFoYnNFSVI4eHdzQVZ5VU5UZ0txcVpnYngxMzlKV3RP?=
 =?utf-8?B?OE1Yay9SSFdNL1ZZSUZVb2pxdXIza3lFQ2JseHR0VnlLaTVsYlBKQ2hsd3la?=
 =?utf-8?B?cWRWYTVPMGpvd2IydTJuOUZsRzYzaU5qd2NxbmZ6NE5JaWRMbzFtWFZNS1pD?=
 =?utf-8?B?VDN0MFd1RDRzd0haUDF3c1Q4RURFQzZiOE9CZUx3S1dYNGlLQlZhVjBrZkhH?=
 =?utf-8?B?OE1qcUd5N0tIcTJqUUozbFQ5cUg5Y01OWmFWWjRuRkdoMDlpU2RYS1Irc0c3?=
 =?utf-8?Q?0zKD1KGPpF0n3SG6+m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a9438e-aabf-4375-acfc-08deb1063427
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:42:13.9627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBtd9w7h8ULmDDDukYZSc1rB+XVMF7A8FUgFtVb9bly4HmvqsVnI+Xohe5N68Hba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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

On 5/13/26 16:15, Kuehling, Felix wrote:
> On 2026-05-13 03:08, Christian König wrote:
>>
>> On 5/13/26 00:31, Felix Kuehling wrote:
>>> fpfn and lpfn in struct ttm_place are 32-bit page numbers. With 4KB page
>>> size this can support up to 44-bit physical addressing. Grow these to
>>> unsigned long to support larger physical addresses.
>>>
>>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>>> ---
>>>   include/drm/ttm/ttm_placement.h | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
>>> index b510a4812609..3e88869c0f58 100644
>>> --- a/include/drm/ttm/ttm_placement.h
>>> +++ b/include/drm/ttm/ttm_placement.h
>>> @@ -81,8 +81,8 @@
>>>    * Structure indicating a possible place to put an object.
>>>    */
>>>   struct ttm_place {
>>> -    unsigned    fpfn;
>>> -    unsigned    lpfn;
>>> +    unsigned long    fpfn;
>>> +    unsigned long    lpfn;
>> That should be uint64_t instead, long is CPU architecture dependent and we clearly don't want that in TTM.
>>
>> But apart from that looks reasonable to me.
> 
> Thanks. I sent out v2. What's the best branch for getting this change upstream? We'll need it on our NPI branch in the interim.

Arun will push it to drm-misc-next, if you also need it in amd-staging-drm-next you need to sync up with Alex. But that shouldn't be much of a problem.

Regards,
Christian

> 
> Regards,
>   Felix
> 
> 
>>
>> Regards,
>> Christian.
>>
>>>       uint32_t    mem_type;
>>>       uint32_t    flags;
>>>   };

