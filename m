Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4D3CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 14:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D2310EEDB;
	Wed, 13 May 2026 14:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A6iaWMQ8";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E590210EEDB;
 Wed, 13 May 2026 14:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DS9VvgDjLOh/YsvelOjwPxKrWCbJfqBYkGGg91BpcIsgSnK17Gi9wSzuZcQCRWy94z6zUUcfBg4Se5QiAY4tmqN01wRlJHvZ0W34FBJ+MYOAYUfLHuA7j5ZwN/ZMdujf/h2ijOi28+OjQcfrhA9Q4BOULvdt8GzQoAUYS3ochGn88vcyj7FfC1I7whUbODWreJNW5nseYEFQBelzpKEOf//RIT62by28OuH8/x2IQrawhdZMLm/fV6zX6OFkY6Y6sA7XPfBkOqyAVRG8ne7xU95em8xJQWQEuGrQgn4Ris6STaDFJHETvsWFJEr+rwZ7INl02x3Y15yx4kT/chu0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW8CoeKMMAuTTR/4sg6w0Cz8eY91Gar20UAfbbYmJ4Q=;
 b=bOQiijjEcIruSC125MU2odqAPpHnRt0Jgu0xxg4o5yqdsmpmmnKbpmUtf6fdT4ZLFb2igsm8WQlR/M7P5YhTOKNvWsKjV4D3hC9DPzYa2yPyK702k/46P6LDeeMdMbWDOsI0Ed/u56Ov+tWABKKc1o20LOarWTb2KgwS2ZeOU14GUZEcms4v5T4pwG7OGqZ0CmZBwKrp+PKBbe2/c0TuX4DraXL1TkDW60E3FYs3b8h1fnFpJ+xhV26gA0/E6luD7tvQBBIm4ETWouxZHCgeDHqBvDox9WFml4+Nk9lM8dJoSq0lyDgfrR6rUY1Aq9CwsF7kWj/UUuWcdunnEM9NUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW8CoeKMMAuTTR/4sg6w0Cz8eY91Gar20UAfbbYmJ4Q=;
 b=A6iaWMQ8w6tjGhRsVL4xmooPol0/mZWfKq/YlKMNjj8SRFm3/toP3t4anWIbl+OXmqt3zzJSHmA8TiLdyahuWAcVBAisRzsEooHRCytzUbnno3ncRw/df4whI5W93SmnwglQ7AQbNYogCzJcAZSt+c0fRlS1JA5iOGd4qFZfG+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:50:46 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::8434:dc50:a68d:7bdd]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::8434:dc50:a68d:7bdd%2]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:50:46 +0000
Message-ID: <7ce2627c-4a64-4cc2-b464-64d7bbdbbf1d@amd.com>
Date: Wed, 13 May 2026 20:20:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: Support 52-bit PAs in ttm_place
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260513141253.20410-1-felix.kuehling@amd.com>
 <4a91b7cb-e395-4ecb-854f-3dbdc6ae0a42@amd.com>
 <6dc1e113-c06e-466d-9db2-4e2a2b34ff83@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <6dc1e113-c06e-466d-9db2-4e2a2b34ff83@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::6) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea2be3f-d362-4402-bd6c-08deb0ff03dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: auLdNOgVEJF98LmF5ZhkbnkkVHiFLXulbO9w2lihRfo+qQFwhTCE1e6xwWV8lYIFD2qPyWIw9+DZ4/2RNkqLSuMkmqNov1RxAsMNeipB2dRhz7RccmKNLx6irejPcNcEsSmYMFd4uMipYT40itgI+tzBnqSKkCo7MaZkdlQBQY/byTJGpGIkFZXlIeCTyNbWufIyYC1bryCVax2ZfOz5xZfkb3qbNxe+Tz/FIAWbNVI3TkrVHBSzAuCrDaDyP41MBog4qh1r+r4vVOulNxXfKbz+TSBFMiz2wgZFrBahsP8wC2wB1J3g2LL/Lzgqq1tYlTHPDgK2Ln+vTKePsmcgAo9ETCTiFDMVcuru5frG4/GKGLfR/7JCtM+aXQ8jXuiMPCKMVxmuZaVLlomfjKsJZcOfe7MJEvKb9lxTekD1QLvkqJM7Q41A2vMKF5fYgL4zGjcMNx92j99EWXqshTaKjG2a0RNNkKAZfmYRSXinZTrWv2L/yUrzsEYr8gKZMEUQfa9It0RsA8HghiNLVai49uCRLAHcwgJueeD8VGYEYiNy4Bpqm9/0dd1wn9tWZsgrT7x5noBZW0JsPL46dp2R7fknIG8e7TlrUx+RvpGYr+98ipuHg02Mfrf3ZUuzgiAbyTTKCJyjWlzktK1ro6DuOo76cdgVH/QLYap718yAR4VYpJMgnKJS8aE16ndor+h4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVY2YkVxQ013REJRWUxtZmdESHZoYzVHRjlKUnRMemxJWkJlTk5ZNEMwVzJ0?=
 =?utf-8?B?WkhWaE4xT2dCMWQ5K3RBYlM3NmZUWGFJZ0ZkUHdJdzJ6MENXVHZiU0J0S3pZ?=
 =?utf-8?B?aXdzS2o1ajZkMkhhUWx3aGpxNzN1SkR6c29wMnFEWUkrSjEyNFVFRG9JQlUw?=
 =?utf-8?B?cGExVE1Ub0llTkljNE92dkxVSnp1c1JHSzZsd0UzQXJsMnZPUlZHRVo1aCtw?=
 =?utf-8?B?K2NXb2ZwUmIvTlltZE1SL2lpbk1FKzdYUzh6YWtLZHdTVmQvc2NabU9FVW4v?=
 =?utf-8?B?U0Y4cUF1NHNwVE9XS2loY2w0ZXg3M1dtLzBua05QeWVUSTlpLzVLN2FoLzNJ?=
 =?utf-8?B?QW0wczc4dlpEdW96d1U0Mk0vZ09rTit0eE1PODIvelVSODI1eEd0Zk5zY2Fo?=
 =?utf-8?B?VkpqSnc0UnpLLzFzZWp6ZThlSXFjOVoxRFdxRHgzZ0REd3NVUUw2enRleHBp?=
 =?utf-8?B?R055eUVYSHpQWGR5SmxNTWl6eWZ0TXlvdVF4cldva2NOKzkzcTNqU0ZaeFZp?=
 =?utf-8?B?M09EYW9KZytzNlFlbW9tb01ReVRucGMwdjF2Qi9vajJOSEw1emZOcFRmTmhO?=
 =?utf-8?B?Sk9jdzhVM2VNRW11RDJoOE1qRkJjcGF3WFVuUFpUNXExdDBzM0NMUGR0NHdQ?=
 =?utf-8?B?Qi9SVWtPYUQzWTVETU90QUxpaWhnZktGdkpoZWc2RXc1dzJOaDRPUlZPZkdC?=
 =?utf-8?B?WHU3ckM5T0VqMkszZDQ5NmRJcHZBK2pLYTBzUEh1L3dDRnRsOVhHNm94V2RT?=
 =?utf-8?B?RGJSaHY2L3dYNXNoVDZEZ29VL3JLekpNMXFCbUJMY0xhQ0NDZkV0dFNvMEtW?=
 =?utf-8?B?Ny9sZFBJM2t2NjNpWVVyRGh5bVUvNWZ5ZGtsREFKUFlEZmZhSTB0ZmxibnEz?=
 =?utf-8?B?RXFwcWkxQVRWWDlZNEszNEZxakcxcSt1VWpOcnZqT1VEb2RkdWx0Nk1kb3RB?=
 =?utf-8?B?dWZGT0V3M0MyQU5KU2FyODgva0d1ODRQa2FDTjJ5TjE1dEJveDBTYWMyeHZq?=
 =?utf-8?B?MzdxdE5JTWZPNzB1ZDdrbCtZazNtcU9MUk9qWDFkQVFydDZzOE9yU1picG5J?=
 =?utf-8?B?NjBGVDJoeVF6OGxXdmpXTGtuSXVZUnc4aFp1Q3RQWk9rMVhsbjlTbHJpZExQ?=
 =?utf-8?B?Wm9YdFdqLy9CUi9mNUF3dGUzYnN6cGNUZnFjSDdaYkp4ckdvcENVQjBjK3ZU?=
 =?utf-8?B?ZTA2MEJtR2JoZ2c1c3VGaFM3d1VDem9OZ1VQVi96cit1Vk82Zy90bHBIVDls?=
 =?utf-8?B?d0l6eVl4Y1pmaEZMM2FwM1hza3gwWE9VMXVtLzFkeExkdlJYWkJaZzlUaUY0?=
 =?utf-8?B?aHd3LzhzREFvL1RxN2RxWGFxQTdhYnRUTXFrcW1yMVpsSFdUbmc3d2UrRmph?=
 =?utf-8?B?anRpZUM1Z2tkdzhaUzRrY1YrS3hMR3J3ejJnNC9HL2VtWjdVaDFPYy9CQzY5?=
 =?utf-8?B?WU1MbGh5K2E4cXpBVkR0RU9hOGdnOFB0MDB2OEtlaVMwU0hDY0hiV3JsTXll?=
 =?utf-8?B?bU1JWDUzRWRKRUhwL2hFMmR4LzdvUWp6VitGd0Jxclc1Skxna2ExaTQ0S1pk?=
 =?utf-8?B?NVlvVnhVWHVqcVFKMjhxM1RBSDR1U0VPaVR4b096MEduTlYwblhJTHpNcHho?=
 =?utf-8?B?czFQeHRSTDJxTTdNOWl2YlBxTHd4YVU3NTlzamNEM3NicjJXQTcycEJJLzNT?=
 =?utf-8?B?NkxBNmdKWmtaSHlFZ1hMdFgySjdnOXp1WUtaenRDNzF3bEV1VHZNRXVwaXkx?=
 =?utf-8?B?bVRtZXgzVXc0dFhRd05wRjVvOU41MWd4VFhkcUhabXFYcUtsSlJiWW1rOUQz?=
 =?utf-8?B?Q2QrMDFHZzRVSnFhU2lvU1BqZUV6a1c1dzdzb2gyRjhvREZVaXRJSnFteVN0?=
 =?utf-8?B?ckE0bmFhTDZIQWpqSHJPd2ZBZnRMK3BtejUyMEFnTTZEbFJUWFVhZFAzUXI2?=
 =?utf-8?B?ejBWcElQd2FhR2tPTlJaNkxPYUZJWFcwdjVEeWZiNXA5UFVXUW9MNUs2Tm9U?=
 =?utf-8?B?SXZzbkdYNWxRcTdTQUhXaDdYQ1ZoWFZlVUcwclBXOE5EK01QZFRjWGhBOGh0?=
 =?utf-8?B?SmQyTzhMNUNObnBMV0tvNWFMdGdvTm5kTU04NU9rWFhFMlZvVHNmVmJsR29s?=
 =?utf-8?B?SW1Uci9yMGRsS2pnMlFYdTVDd0FhQUYwRWJOOHpPZFJRYVdZb2JhSDlHc2Ur?=
 =?utf-8?B?ZjB4SlBSZGZpTXVaeW94RGNZWlVDODhraHNBNUVmbm1oRVJTeU1FQlJQWlJ3?=
 =?utf-8?B?ZGlVbGV5d1FwV3hXKzJxd2tBVjBJWGMzQlBhRmRvN2h5Y2VmYk1lcWg2TWRp?=
 =?utf-8?B?RXEzdUExbEtRVm5ZbytYNUlYY1RvcjAzd2NmV0ZnMlNVMHliSXVMQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea2be3f-d362-4402-bd6c-08deb0ff03dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:50:46.4568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbyMKGmzLgijav1+cdQMXRYGwQZ9+uljciUgIMnRZlGm6PhaxmbTy7PJdbdLIbYlz+ELpdRW11748kV0hIWuXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
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

I modified the commit message and pushed into drm-misc-next.

Regards,
Arun.

On 5/13/2026 7:57 PM, Kuehling, Felix wrote:
> On 2026-05-13 09:19, Christian König wrote:
>> On 5/13/26 16:12, Felix Kuehling wrote:
>>> fpfn and lpfn in struct ttm_place are 32-bit page numbers. With 4KB 
>>> page
>>> size this can support up to 44-bit physical addressing. Grow these to
>>> unsigned long to support larger physical addresses.
>
> I forgot to update the commit message. It still says unsigned long. 
> @Arun, can you update that before you push it to drm-misc-next?
>
> Thanks,
>   Felix
>
>
>>>
>>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> @Arun can you pick that one up and push it to drm-misc-next?
>>
>> Thanks,
>> Christian.
>>
>>> ---
>>>   include/drm/ttm/ttm_placement.h | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/drm/ttm/ttm_placement.h 
>>> b/include/drm/ttm/ttm_placement.h
>>> index b510a4812609..ab2639e42c54 100644
>>> --- a/include/drm/ttm/ttm_placement.h
>>> +++ b/include/drm/ttm/ttm_placement.h
>>> @@ -81,8 +81,8 @@
>>>    * Structure indicating a possible place to put an object.
>>>    */
>>>   struct ttm_place {
>>> -    unsigned    fpfn;
>>> -    unsigned    lpfn;
>>> +    uint64_t    fpfn;
>>> +    uint64_t    lpfn;
>>>       uint32_t    mem_type;
>>>       uint32_t    flags;
>>>   };

