Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745F2F9937D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D52A10E326;
	Thu, 23 Apr 2026 11:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xDicE70c";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A129610E326;
 Thu, 23 Apr 2026 11:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asqCtQKfmDcaobBVTbugr/0GI6WwTSkH73UiHDdCKaDTJY6I4PmO4NCp2mxW0umqqnhLiYEcI+LDRsizC2s7rivqXmpYma325kBAb+13W3mkf/6VN9Vp3LSagBPChnkq18VDuWzAV+C9gLznLQs2CceLM9cZp4VGZojaZuIpXkBmOAtFubvoMrgsh59vDXZZwJ3zRfzblx16S3yTXarQQka5DvbwGvo3gWqPXwdQrN4hdFKNDKK/6DDLL0pdl0izgGJthD5lkyEqnsNb3hnLAMsnbrdLITcx9InVqb3bYlraZWvRH/fmuVFzfxcvBcOXZykl5dYNMwItciQ3H+HJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jOhx7fYaxYWH99ZDRqMalp3oL/KHn7vQKbtWx9mAFc=;
 b=aV5Xj70wHDcU0FpwWa7ZrVmRN1nGb6Y7ESFwR/Ju0I72Zp9geUdJn03B6FHWCP4d3KtxbJXHWfefTFxHcJKXHC2dsjkhL8K7ioDGQkoB8rHw3if4pkkjLlI9FkHxyQxjK7RlcpxAmj6YpqGSo3UUZ+qXMLhpx4OmdZIncKn2mcg+cIisEpesXS61gliCztpxQUKeTgL0Fx/I4hBCMoBGSiPVubLpzE44vjVvHtlCRseNOQZfBsdbDtk4fh/Zc708yVJ5ZXfB1AUB9dnUpIp/e6Kgr01VN+EJ7t0/renJsY41t4BWv2iPlEKpOQUavZV011fJsX1MPFgmTATleZH60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jOhx7fYaxYWH99ZDRqMalp3oL/KHn7vQKbtWx9mAFc=;
 b=xDicE70cJvKB2Nd2UYU7QHLDdJz5OwU4jMpxrhtogB/s7JTyzZdWYd6ocTuOAmOHuicjymp4QtCFDpEj7Qc4JZYNr1cAK7mp4N4bsA9s0HnlNj/WwcZNpjsw6YZTgFmaYXqoIlZApgruWcgBOWKEjWBCFU2hHPrcTofeQL5702g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 11:52:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 11:52:56 +0000
Message-ID: <dfb1a0d2-5b34-46df-9a79-5465952a9da7@amd.com>
Date: Thu, 23 Apr 2026 13:52:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: stable@vger.kernel.org, Robert Garcia <rob_garcia@163.com>,
 Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260417074010.1607496-1-rob_garcia@163.com>
 <6064b45a-b8de-4848-856f-383d2d06680d@amd.com>
 <2026042335-probation-heftiness-7399@gregkh>
 <4885687.vXUDI8C0e8@timur-hyperion>
 <2026042330-washhouse-amusement-db9e@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2026042330-washhouse-amusement-db9e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca19011-bc77-4bda-3ce7-08dea12edbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: sak7J2dJGk0vFMwfSY05YKbSofdrlVdD4KbSVL76CHB6WfyFZvrRWzuPpbly1poICRKuMkkFXXK4eVhfdtOyPR5Qw8K978OC+FvB6NeQtCKSv9mu5hpf0nF440ZIPGZJPS808o8ZjWnb7SGiZTAb/wMd1F6osdICyV3uWW4L4YnJEhJ5SnKNzqoxhuvrSJCHRbv3XARgN31/bpsLLBljWP5B+UAT4Tsk1pKT5nym3YAWcyGamtiNh+hWdRvEFsNqbn6GSnQuYWFUlMnf1ZC2RsXOOTsUuMvLkKZRhOpMx4Z5XKF4b+x1mYnJhvitBRZqo+DtGMV9LKCLsad9vB6K2u4iBf3QFud1U1lxQWHofSlDhUQKMBFuBFFTa3aZFhfChlxqILZHdbXRVrKS3RuIyqEjaiGVxvcw9Wtud6dvH6oxao+FcAxSz9kGpG3JKAkSD2/HiwXsMabr0t4NZqmxe2mrY2aKczvcYGfrx6pxVTxBPHjgoqLDHI2u+uH0/oL/6BsMaOg5Ti7w+AOiyCMaI1mBNWqvO45NYuMn1k3pyu169lIxDzFcGaqvNWPm+bXJg4fQh5RgAaVEq9OWcf4I1EkQERJhM35WsgnmlKTAaJ0ndDf5Ng0GpBAEMB4+l1ZgWPh3I4MDSwUkQGlJ2HLnziPPmhU8ultrqg+txi6yQOLdJ+kBwEasczdknO/WyDGLf0cCyv9ufV6nYgUBMMAKVQIXNLyokrVwpbnKFUFUSzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlBxanp6bVh6UjJxNGFBbmpVdWtnZDZSdEZyb0loWGJFcEVlQ2daNzQrdk5N?=
 =?utf-8?B?OG12cjU3WjJLYkEraGs1Z041ekdtZTFFV0ptSW13blo3WkpmVVJ3ZFh0OXcy?=
 =?utf-8?B?K1psR01BUFBiY3EzY0h1R0YzK3lzM2VUcXRKemk3c2krMGlVS2ZuTkJYeXNz?=
 =?utf-8?B?eHp4T3FORmxaQlF1b0VKMWlrMXFnenlUZ1NNYkllTmhMczRvQ0t0QVcvYnAx?=
 =?utf-8?B?ekxVVnJqVzE2ZVFVY1Y4d0ZkVWoxc1ZjbkNtQ1gzVk53OFo0S0FIWHZ5UUlQ?=
 =?utf-8?B?dzlKTlF1eGJVa0ZPR1FNc1VEbTlUdXQyZTVPTnkvd0tLbU5kUGlQb2N6dytQ?=
 =?utf-8?B?MnVUWkEyb2tKaUdpek5nZlJoNjhnMkFUQ0paQU1oVWs1cjgra05DN1ZWWjdx?=
 =?utf-8?B?UXh0VTlrc2t0aEJPWEZ2ZTdOMGRtQjVLWDhxUUJ3akZsQ1c5U051cCt3Z2ww?=
 =?utf-8?B?Z050emNsYm1NQTliSndtenhqZzh4ME0wN2JYeXVJY25hMzkwU2NlMWE2emJN?=
 =?utf-8?B?eTFZUW5LZ3JTUzFVVXB4eUIrL3RxZ0c3T2owUUltQTZsOERXaDR1K2lVaXpM?=
 =?utf-8?B?NFNnSnRMMnBUWkY0aVZzeDFzVlh6OXppb0FzS2JTUEN1Y0g2TzQ4b2VyaWZi?=
 =?utf-8?B?NE9KTnY1VWpZbUhPR1d3em1yVWpjbEtWSUc0dUhZc3NDMVJGTUNSdXE1QUZT?=
 =?utf-8?B?N2ovRXlhbUxFeTZ6VnhGVkhNL2VkVG0xbCtlU2h2b1l0ZVZpZTBnNXFsRHVy?=
 =?utf-8?B?eEFWWWxWOWUrZGVmeWl5ZVltMFBrUWZ5MG4wN0tLOWwzam52dmZtcFllOVB2?=
 =?utf-8?B?ZVdVazhSc1o3RGY2aXdkVXpKeGJTZFQwaVRmOE9IckZncXF2YXRQYmUwZ0Ji?=
 =?utf-8?B?bW1PYko3NmtFcERTMWxSdG03WTM0U05mbG1kMVd6WkxoZTZmUXBxSmVZRlBT?=
 =?utf-8?B?NWM0YWhwUi9sMVdhc05aM0l0RmcwRHNZOFVSb0FrdytTeDFFcXgreCtrVi93?=
 =?utf-8?B?QlE5a0FYbnZROVVIYmlBdzloYXpOaUIyYmZTZ1RTdzNZK2pua2xwa2tFR09n?=
 =?utf-8?B?bFRRcCt1Yk1qdWtlTEZxVDFZQW1ZTlVVeHhpcy9DZ210V1ZYK0ZBTkdOcTcy?=
 =?utf-8?B?djFVaUs1dXlrWTEyTU5pQU40TWxJUGhTdnVsSzhyRFoyMStGcEVWdFJwdlM0?=
 =?utf-8?B?V2thaTNLSHVWYzhiY0RzY3NXcTFHS0NRSldQU3p3TXpxZHBIUk9rL1VXV0xM?=
 =?utf-8?B?L3NlRzdVWm5GdGM2THF1cjBMbWFTaERmWVhRNkhHODc4ZkJXK1UvYjF5Q3ZY?=
 =?utf-8?B?emtScW1JVUtKTE42emZPeHZ1Zy9sUUxLck03MU9WeXE5RjVUbVRmemhhbmtn?=
 =?utf-8?B?bUVRMm1FSHRiWEdTZ0wyM3V2T1R5MW03c0ppZmd0NW5JYVFIMnhlU3QrTy8y?=
 =?utf-8?B?S2lqbjJtcFRFSDZRN3BLdEdoYTcwaCsxQXQ3WGhnR2xWeG9SSVRnNFRKdmFN?=
 =?utf-8?B?azFOczczdUoyY0c1YU8vSElkbVBHR2VnM0hFUjlUVjVlMkVQQXRRVXdYQy9o?=
 =?utf-8?B?RVFvcFVOcTFkNmNRdEc1b3llT0lRMXpCVnNFRmRqUnNXbjNFbTZxNU9LUUlk?=
 =?utf-8?B?V3VQMUJiK0M1MWN6eVNkMnVneTAwUDYwTkFEL0F4OE81ZGh6a3F0aCsxMVRP?=
 =?utf-8?B?cVJjcjNBTkJEUjhEWHlsbUxhOHRUMTQwWFpmUG9xbllkdzNNWTVvbzVaOFRs?=
 =?utf-8?B?M2JUSHRRb2duYTJjT0c1WkVHdlNJVVhJN2tIQmVFNU1TbFQzOEx0K0U5N0V5?=
 =?utf-8?B?OG1HcXVrYU5xencrNm5CME5ZV1FXb082a0d3WDJNT2ZZZFRVa2tkK2h3c0VG?=
 =?utf-8?B?cFVjc2w1YUIxOXFaMVlobFZnbk1lSnpRdGR2V1Zyc2FlK1JBanhUaG44ay9l?=
 =?utf-8?B?a25vTVRvS3FKaUFFYVl5Uk5IT0pKcFltNXErdzlVMGVrYVE4VWFEcVRVdUJv?=
 =?utf-8?B?cnYrVXZSYXdLMXFoTVZhOEhQVm95ZmxtVFFtaXowTVUxN3JjV0NQeW1MYmYw?=
 =?utf-8?B?Z0dPcVFoek1ZRjB0VmpFZU5oYmR2TDczajhIUzU4S243WGRsTXo2Z211MDBZ?=
 =?utf-8?B?cGdIM3dyVGZYZnJQTGs5SVM5b0pkR0UrdHM3U3VpdUlPNDBQNkRuc1dLY1Bw?=
 =?utf-8?B?dysyaGZHd2l1SEFrOTZhUU4zcEczMERLZ3lpUEZZOWlXQnVKS0lWMy9vT0tV?=
 =?utf-8?B?eUNLVCs1NnRyS3IrMGNlbkNXMVNsb28wOERMOXM3TEUzQ3Z5RWk1Vk5PTkNm?=
 =?utf-8?Q?YhfU/4MEUDKm/Adww0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca19011-bc77-4bda-3ce7-08dea12edbd2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:52:56.3395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zREms3hc6sztq2tjYHl8zcfBLg6NzXgiiSLmzfetbewh381ZoLK8tcE+g7OdZ019
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
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

On 4/23/26 13:40, Greg Kroah-Hartman wrote:
> On Thu, Apr 23, 2026 at 01:34:42PM +0200, Timur Kristóf wrote:
>> On Thursday, April 23, 2026 1:22:22 PM Central European Summer Time Greg 
>> Kroah-Hartman wrote:
>>> On Wed, Apr 22, 2026 at 04:11:15PM +0200, Christian König wrote:
>>>> Those points are certainly valid.
>>>>
>>>> I've also up-streamed a patch which completely rejects userspace
>>>> submissions who try to use the CE.
>>>>
>>>> The problem is that those BUG_ON() can lead to a deny of service because
>>>> they crash the whole kernel.
>>>>
>>>> A BUG_ON() is only justified if it prevents even worse things to happen,
>>>> e.g. data corruption or it would crash later on anyway just not so
>>>> obvious on what is wrong.
>>>>
>>>> Otherwise we should use WARN_ON().
>>>
>>> WARN_ON() crashes the kernel as well when panic-on-warn is enabled, as
>>> it is in a few billion Linux systems :(
>>>
>>> As this commit is upstream, and in other stable trees, I'll apply this
>>> as it's not nice to have a simple way for userspace to crash the system.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Sounds reasonable, if you feel this improves stability.
>>
>> That being said, there are many other ways besides this one for userspace to 
>> crash the system equally easily.
> 
> Great, please fix up those as well :)

Yeah, trying to do so for the last 30years or so but it's like fighting windmills.

But how goes the saying? Security is not a state but a process.

Cheers,
Christian.
