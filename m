Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF68C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A4310F47B;
	Fri, 17 Jul 2026 07:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XzwXHaSN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2595310F441;
 Fri, 17 Jul 2026 07:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ta7qpqJvJksd+eT4Kc3NGBsxtY65KXpGk6dXooOTpNEfoIRnF7kNJsptOA8Ahr46xyZ7Z0b5adMGqBEZDvxNMgY2gD4fcjjDPVzrkzIZ0QakSERQux4WMdcYr1NJLbiticl0bDpNSm/kiZ24aa4HJaD5l/vx2QNGP8fNMgSAITTZXtYqYlkABkDHtDfJgREFSUvjJsJV5GuB6UneUbDpGUMHOg5Ksb9+Y9CsVuGtgd7VwFrdrTx7MRk5oQYmOFolNnrDn6DyOYIAQz7jdnf+z4aKuY5pLH4i/1NhfP4TEg+TifkjmTuqsGLl5en65+rOKGBagnhTGf0B/qrRtFZzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUWVf/Q0jqKGAiQYJmsIFewdqMi0tGbXZh8gYppPWJM=;
 b=JOIabzS+cA5fxLPyMIdUIAAZMGy72rAgJvzzYe6NkzHa+DfvDd1py0Vjyo9ZhUqrqw7Ti+ODo3qkHCxqfJthaHQ4XxIeJF0Gq8AFFrELuYMZbqP5A7u9WlnGKGnFCYDt1IW6bvgDnqPBPLmOy9S2rWbSMHPXKZFHnazfipyEBt4d37tLOmK7T6oiRlSuEgEPTUIApb/TML3DULzQnUFy68lJMB5wO8OCAGvR7BPmHlPi74F8Dl5zGwsRyVuwG+3tYXrWHfMWyIRzeDbwroWDfdSpBsVjeHalnnaGFkmSdym7MK6N3lil7bvrv4ARNDpu2c8oeeA8gProHcIqFYZ5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUWVf/Q0jqKGAiQYJmsIFewdqMi0tGbXZh8gYppPWJM=;
 b=XzwXHaSNzSw/aLfib1DMpM/kJT7IlK0Wqs+RCFpkj5gx2gessQWuvq8jY4d/B3nTuLloQdHuirCGXQo9W2n2J4Eb1CuXUUT5UktYvBgSdxi6+cfwojhElPUNX+6g/WtNnX6OiQeS5H9cukZLHkdm14lfrD53pCuP6p7voIKP4jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 17 Jul
 2026 07:37:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 07:37:26 +0000
Message-ID: <679e18a5-9402-41dc-bd7d-58bc7714ff62@amd.com>
Date: Fri, 17 Jul 2026 09:37:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: allocate dummy_page without DMA32 on fail
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260714-radeon_32bit_fix-v1-1-42a99945f6e0@oss.tenstorrent.com>
 <11218edd-ae58-4966-8172-27b2435eaa1f@amd.com>
 <CAEev2e_gnmhYw_mV8zt2AnkY6Hj_F165veoAPaXhA_ej-5RUUg@mail.gmail.com>
 <7619ffd0-a77b-4596-a9ab-8e5172c929e2@amd.com>
 <CAEev2e8e4Q2zgQxkodBzNpXCDCFhE4femijQ_K8yQrKe7bXn=Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAEev2e8e4Q2zgQxkodBzNpXCDCFhE4femijQ_K8yQrKe7bXn=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f59b9ab-3cca-4869-4c82-08dee3d63fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|56012099006|4143699003|11063799006|5023799004|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 1ZPmLk7Tt98Kub87ZyEWmSZ6r2Eelh6Q0YFTbFnqy7Lq8aSiGUGIbmQN5QQ7w1IpTAQQFJQXuwX2KCPpvUOjFaGiXnHH8b8qBg/+RZMS60zweJrMt2iahrUfjJT7aHR9odIWBjZfLmVRPdd1FSjewbGesDuyHTpH/+uk/ArtduCO0qFbPBs/46eBB+dcJ1TEiHfi748W2nlSg6oA8sRitpO9ILfIs9vJAJ/41HzlqTWW1gXnW9uIGT68kSYcf3mzarmx+z5vanuBFLEqv6MiuY1hXe8MRKf5RbezhqXJxspP8icPssN2oh3a74C5NiyMAimzzUxgY/0fexkWApyNgRFs2v2mHT1E5FDey/o/jAcv6kBiBL5IM+N5/zyeZTU+Luc0H9Gfqw8VA5T5RFEwFN+UMpgxFX01zpDVxYfTCASXI4L+Xc5FTR+hBwFU+IDxg1IaY1zAIRY4AVuRmPaRhXDCFHiPpVbIXK8n4EYEJAvsu7i+U1Y5tWmodOQXaNJThdvUz5e2yKjzPxVlLgYUKLeO2iAMcycpCgF3cgDWW/17lQ5gfFzZGWJXn7SVK7aLtxUVmTXz/dINpesRXeG9HtENQ07sjSajQPJO6hqEhObKV94XNLdKDt0mxiCY/BjJx6/b1jbdE+kKlq0EUVW3F/pb9KR1sPOD0e9GGbJYYkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004)(18002099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ZVSzY1dXZhcjVFd0xaNHp3WTZmdDdibU41S3QrTTk4cWFWN1MvamlFcVNo?=
 =?utf-8?B?d1dqdllmbnJIK1JqcGt6RlYwcUlVd2Q5TzBoLzh2UVZVaVZGaGN5eWxzUDdS?=
 =?utf-8?B?MXZURit5WlZIMFJKcTFHS29pUzJrZ0J3Ulg5MHV0eHdzY1dmMWdtaXU0d0Ur?=
 =?utf-8?B?d095OUVCM3U2dE02VkY5RXZ6VVJFUHcvRjdaVVZ1RDljTU9RcnJTZkw5aTNG?=
 =?utf-8?B?cFlPMWxhSVlTVHg1MGJzNzVGNC9NSEpHUDIyZVVPMWhXU1NialZwNFd3bjVt?=
 =?utf-8?B?UndDZVFKZWhRRW9EVGd5MjVVdW90bTA4VDhMS3hEdkVIU0xSZFVXUEVqejRO?=
 =?utf-8?B?c1VDVU4vWVRqb0g0bXBUZHRDSUhSc3k2ZTRiY3hmVEZEdk1qcUlhb28xMUhO?=
 =?utf-8?B?d1gxWVJPU29hRzEycE5ENkF3WjZwK21IMXlxdGRBN3Z5emQzajhnS1FMZGt1?=
 =?utf-8?B?RzJ4UlBncnhUMTl5YnRxVlRXQnBWS3pkdDNDNWpMVnlFbU5COEVwbGFFNkdK?=
 =?utf-8?B?NFE3MFR1R01vU3VuOWN5Z1dOR3ZOTlFuU3dybGxPTVBvbjhmSTFSRUNzdlVQ?=
 =?utf-8?B?bnF6a0tzMnBiNUsyTnBtWW5XWHhVMy9uTS92SVdlNUZCWmVrV0dGZEgybGh6?=
 =?utf-8?B?aFN0SXVyUjZvM1JZa1RmMlpnSWNRd3JQbXBkWEUwbW01Q1B2ZDdsTERRaldE?=
 =?utf-8?B?K2JsbWUzVUsyT1htODY4akpFa1dkZmpTYkY4Q1h6NUtrMURzanhJRGZjMENy?=
 =?utf-8?B?Zjl5VThlZWNtclUzcytEVjV1WXhNZXR6dGV0Z0lwSC81R3RZc3gwT2M1T0M2?=
 =?utf-8?B?cEhCRjd4TERHd3I4d05aTUhJSkM0dzdwaEgxYjJHU3ZLd29QNmJKMjk2eHRI?=
 =?utf-8?B?Z2FHdDhUd3NWdk1xL2FSUGJJSHYzVEt6dmhycExjSGRjQzkyTTBFaWFRdXVW?=
 =?utf-8?B?cjg3RHBURHR3Z05XcjdFOTVNL1BjcTZxTjE5djhEcDRzK3dHaFNXcnFXOE4x?=
 =?utf-8?B?dEw4MWFzaXJrWldPa0wwaWxsNmlXN3RONlhEY29aNEM2T3gvelJJMzV1ODBJ?=
 =?utf-8?B?UmduRjA4WkVNQ0IwZi9WTk1DOE9iQnFTVUVtL251a25JTXJ3a1E4YnloWU1M?=
 =?utf-8?B?bkI4WTdaZ21BZlMzZm5IaDk0eEdPam92dWNUN1J2c0dtYzByUU1rTnNEUlM3?=
 =?utf-8?B?a3J5b0F0OTdTNGFNS3NUejdLNEZLZ01lMjU4R25NNkF0bGNVZEk0Z1BBL3JR?=
 =?utf-8?B?TWpiaGx1djRMMnlEQi93R2NXMUJrd1BMOEZCK1ZBN0RBVGxHbnJsbVUzZ0lu?=
 =?utf-8?B?U05JMG1TdWEyOFFLWlpyM0hFeVllL0xvL2l4aExXVmp5VEVWUlRkcHpLZkRG?=
 =?utf-8?B?Qi83bWhFTEh4ak1ua0VPd3U2R0JDYUFVeVluQXdXS0FycUExOHM2cXlVd3BE?=
 =?utf-8?B?eis1TGtORmtaSmVUS1NUOHVXUVh4SEg3Wnc2cXBhUlUyem5VZDVBQjIxSUxE?=
 =?utf-8?B?QnROQ1NrUWVTbzVBbTI0V1BRMjlBaExZYmhvazFvQ0s2alhFZFpCMW1SR2Z1?=
 =?utf-8?B?ckFrN1dmclFkWmwzNDVUeDFpZVVleWNsMEdjZWlGWXNlTU4xZWZoRVBkanZI?=
 =?utf-8?B?YTZKWlcvV254N1lTeVhTTmZGaW5hVDVNK25rNU03RWx6WU5yVXBmVTZ2L0t5?=
 =?utf-8?B?WW82UTFSUitsNVduTTZYK0hYVnlDQVZTV214bldDdm5tM0NMRkh3cHZKQXNx?=
 =?utf-8?B?YzJQelpZSXRXYW9hbDRNeWJ4dVQrM3hBTmpFYnVOYkpmSFZ5WlBsWThSS0V2?=
 =?utf-8?B?S3hWckptQ0JNaEk5NlU0UmZmRk9hRVJ3LzBjdmY3NGNXaDNIRGQxNDIrVHhm?=
 =?utf-8?B?Y3RJVXh1cGVNSEV6OFA4aHNFTENSQlB4Q3l6c3AvU2ZON1h0MzRIYU54SFFW?=
 =?utf-8?B?R2xWTjNvdy9RSWxBMjhWNFQzZklNbEZ5N0xDOWQ1TnJ0S3BvN0N4b2NvclNC?=
 =?utf-8?B?VEVhSU1HSXkxenMzT0lXYU5oeS9kUm11MmpwSTJ5cHlaOVZwREJEcmlpYnB2?=
 =?utf-8?B?anpkSlF0VG5YK3ZjUXRNdEhUZktVcC82RHJhd1hnYUZQMUgvWGFsVDJURUN5?=
 =?utf-8?B?VlJVVmFrLzQrTlFkVXR3ZnZnaG55Q3pIcEMxR3ZlMHlpa1hSTVY5WmxiWWZw?=
 =?utf-8?B?MWFlM2tacDNhL0tRQzhDYmVqZk84M3VRNmgvOXpMdU1jS2I0UkxGTjNnQjNt?=
 =?utf-8?B?c09ZV2FndWRFbGNwMkpJTXZGMG1xN09JU05YVHAxbGlJVWNZQnA5akRmdzNC?=
 =?utf-8?Q?YIqBanYv18Ck0CcWBU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f59b9ab-3cca-4869-4c82-08dee3d63fd3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 07:37:26.7760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47Jf7FklcyYGVkMXBPLgb+bPZ4RtWYPVihrdGl63GLinEH/RNsl+PSYo8aHkaRu9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
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

On 7/16/26 16:31, Anirudh Srinivasan wrote:
...
>>>>
>>>> What could be possible is to add a special quirk for your platform to not allocate the dummy page as DMA32 in the first place.
>>>
>>> So some kind of a whitelisted set of PCIE vendor/ID combos (with
>>> working IOMMUS?) where we fallback to non DMA32 ranges?
>>
>> No, what you are testing here is basically that display is functional and not anything else.
> 
> I think I understand this now. You're suggesting that we skip
> allocating the dummy page in this specific case.

Well that won't really work.

We had some minimal fallback to enable only CRTCs in the radeon driver but that was more or less only used to print error messages and not let people end up with a completely black desktop if HW initialization fails.

As far as I can see you can't use the driver/HW combination on this platform when DMA32 isn't available.

You could give efifb or vesafb a try, that is pretty much the same functionality as radeon without acceleration.

On the other hand what HW generation do you have? Maybe it's possible that this is something newer like SI or CIK? In that case you could try the more modern amdgpu driver, it should be able to better deal with the situation.

Regards,
Christian.

> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards
>>> Anirudh Srinivasan
>>

