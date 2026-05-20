Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17141CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC0110E325;
	Wed, 20 May 2026 14:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AFMSxe8q";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46B410E325;
 Wed, 20 May 2026 14:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpOyo+/TLANd/IcVZ9iTeCzM+iWPvIpUT1PraH4IJiApMjDU21ebv5uX91/OFUVidUMeBZc5WuItNuE64zclBaSll75/qDo8dZUpKd7N8yNGRFZFgFIgm8HmTBwrkWYHkQRqpeLmzgWloksNjMFHUbmqEMjf6eSHb5piopJe1vX5ACblS0ptxx9d9zrNo+VHLsyRtqh2OSaw7p68ZVsaiFuIX2CLdAFKmmyy/uZcdaexH2/EE9lH01F3Pmk4aFriCj1lu1NmSghWgQOVvua8hRLdYqGvrf5+UqcNn69bVvvgf2B3u+ZY/I3ugBBUYj/fjoHppS285jUFz+kVyqjw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwRAxA2xjM/8GXGvL0/VQ+RAkvqW6+6IFH9/uO5POT0=;
 b=We3ER79Jy2bKbnqEV1OVK42Qb1c7++5OFc+hB8FN4QQvYtZibi+hzJgeQJjgzI4+1NTWRLO732aPOdMkNv+J38pNy3u6E5SSeUNVEdIepXqRsJEPACEpXH80YqS+YcSycf+B2HScBFlDWf6a4R2PjkqmRuy39kCfQ2B7z+pNYteM1c1SJrkOi1SN9gcWqJcJDEN2/7tAHNX0gOqxLbZKOmm2XMAigKXtnZsaooFQfZOGuhNZCgQgfHtvsTrcAKRAWimociXFT4g87hq8BXh3ivBSMJUbDdMn6bKnhS1wvrM/tEkuo6zzDfotJ7z8oSudBrH7I7iKVebxo1Ke95GENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwRAxA2xjM/8GXGvL0/VQ+RAkvqW6+6IFH9/uO5POT0=;
 b=AFMSxe8qijd1eEjDo/2vFAidfFNFj25gumlZ+DoUrcuQ6g/BiT6N2V7IMEFXCNoMxgSqZi5+CY2NpftyJ9ioVK5RWTskS1epptapbB5pVrERRZm9yLtJAJ7op6RIk+mdtvG108W/DZsdsu74ZTCC5zixTelt/gu9454QaSn78xU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 14:06:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 14:06:46 +0000
Message-ID: <c9fbfdaf-2a58-4423-8dc5-6e29a88f6293@amd.com>
Date: Wed, 20 May 2026 16:06:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] misc/syncobj: add /dev/syncobj device
To: Xaver Hugl <xaver.hugl@kde.org>
Cc: Julian Orth <ju.orth@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <c6c91de9-a34b-4b50-a3c1-d42bf7631f8e@amd.com>
 <CAHijbEUzWZC4GAMU6YGV42gOYkrQaMZZPiwS4Erb4H1J-fh_8Q@mail.gmail.com>
 <69dcbcc1-da58-4d34-bfb0-5c8d33b75d59@amd.com>
 <CAHijbEWqc2+kSkk3i_LxB2PQ6XwUetw1UkdUdXJfdv3zgKd1kA@mail.gmail.com>
 <38551bfe-75e1-4978-b57d-adc43cebc85e@amd.com>
 <CAHijbEWHp960qvZFoK7+9ppHAqkAR7=UQhtMUccqWzGd_pFPQA@mail.gmail.com>
 <5ee6d5af-ac48-41d7-a19f-e08a3c5b7d19@amd.com>
 <CAFZQkGwmeipZnvmBkcE7KhvUSMkSE=fzLBZtiMyhv3mM04Vudg@mail.gmail.com>
 <dff60378-4e47-4753-8878-feec6e1c2690@amd.com>
 <CAFZQkGz=UJqaJ_eTwKBy1pAg5xL+PLibh7W1vYf7JD7Jrx-LZQ@mail.gmail.com>
 <53edf0b5-e733-4b96-87d7-3307275500c0@amd.com>
 <CAFZQkGxpPm081Fz8UtDuBA1PKD42+9YDA+cc6fbSpfawXwu9+g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAFZQkGxpPm081Fz8UtDuBA1PKD42+9YDA+cc6fbSpfawXwu9+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fa798b-97b9-4634-eea4-08deb6790733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003|5023799004|11063799006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: 7OpWPTtRHid9cGBpyrX1pfLsQshnFvsiAvR7eSku5pVcjPU0OCVhan2G8zBbU0WF1ewXRgO+1sMD8VQj/eP4eE1W9X1Rr4527rLkGnCtCiZsB3OYZSIi2OWGFIvyKZpiruEY/8MZfvejDY5GQesyxy3oWVGYxrZfj6E6cJlm8DD0BGbPUznYEFey+Zd4o3EiSKapgmnycWBSqiYVtsT5TlaNVzYhs5GWH04GhYQYp+zwiAhJIJhjvFhq4zQR5ilzeLJ9gPwiXxpQLO6wZS10/WgnoC50DfzqL9ds9HJKwdRKASUmDmZu1TFTyF9IOWUxi5/VxILFQx1zCVP+C7lFiOHHGLSpuEWR1velcWesuP/JagOct1ailXhT1kRRGdK3RM195neWg4heGYEsWT4hUc+XQZ79p54U4Ks4gVQfUOJsMqBLX1VK/IGksBB7o+puXup1hATyNyUTCURbzp/OvbcD3z4tRR/AIlfKS445nGS2CiABpD7XdFbDQzmSBH6ozxOdMhSIt2Veb/1a8rJjTzKzIsHv+y5/w3gSlbq7kk2CNGo6XwD63Ut+HXArm2qjjElUp03j1L4O4KINrH4ADFyQO0kapaa3TJWlYrVuNK9o9jsH8gadZ5Y/OuJG4jL3EHrT8nGFJ0ZHK6yBIN72BVGe7jrD+c31V2leuSsABUr3oPOrZWHkMGnymfU+TEtu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(5023799004)(11063799006)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxkRlNWblZidkc1cTJzNGF6R3EvN2dycGExd1lZdXhDWkMxUmVMSVFlaW9N?=
 =?utf-8?B?WVNBajFVcEhwRFVjNXJLQ294L3lrQ3ltWDJiUEU0WWlLa3lEWmV3Ulp5VlZy?=
 =?utf-8?B?VGVwbnpNZ0NKNUZZZ2cwbmVyNEZHcE9zWHV6aVVNc0l6SmhXQVBDaE85TWF3?=
 =?utf-8?B?REQ2U3Q1azhtY1NuTEVOK1BpOE5nUnVWSjlnT05JcVVHa1hCeVNhL2FiNnhZ?=
 =?utf-8?B?MW1MYm1kZzhEb3RnQmk2ZGN1cFpEUVkybStZYW45R1JGZXp2QUJWc0gvamF3?=
 =?utf-8?B?aFBxRVFZdUNKZWQyZ2V6OS9mNHRib1JUN3Uwem9DSU5CamMwVUxGMUk2QTZL?=
 =?utf-8?B?eVBFcXpKR05jK1pnZUJneEZWcFM5aXRwQjhSUlEwdGR2NWJteEVRamhNMlk1?=
 =?utf-8?B?R2pLalJHT0ZJa0Z3aEJ4WlhTY0FFSWsyTzhtRXUzNDQ0ckdrNjl6VURBK0lC?=
 =?utf-8?B?eHQ3RjBVbU9FcXZrTFdJRFBMYWc3SnY1clVjZGVWVWMrS2l1akQxa2pmZmJK?=
 =?utf-8?B?cFVvT08zZWs1RW8zbTBNS3JWSkoxSFYrVGlpdXROOC9ITzNyeEZmUnVXZnEr?=
 =?utf-8?B?VlJ2TmdoaEJYeU1KUUNnQ3lNbktuSkRic3MyU1k3T1gvalgydU5DMHRKd2lT?=
 =?utf-8?B?cEs1cG01azV3RFl6UmlRbmlWT2NZVlZRdnY1bURjUEdxTUxYL3dHRnVSWFl4?=
 =?utf-8?B?aTdEMTVyV2VNQ214bm9VaDJtdTVQQ2ZkK2dZU2IrejVTWUE2VGVjaGFETG1X?=
 =?utf-8?B?MFdINFV2RWJWTHF2eVlLMVdRTGs1VExSVFJPcUJ4M05BRXdGdVFYOVI5aFNS?=
 =?utf-8?B?TTdScDR4MTlFY0pqaTZuZkd4SnZxZVloMjRRejB5a1o4S3EvV2JIa3VSZXVp?=
 =?utf-8?B?UlV1SmEzNXRwckVlME9UaFc0dGNkR01JMGZqQ01FN0M5cTl3TXFGTzROTnl3?=
 =?utf-8?B?bm5hQXVvUWV1eEN2LzVRU1F5M0djbUpSM0VkVVJZdk9PTWI5MTM1c3kwcUlD?=
 =?utf-8?B?Smt0dTJyUDF0alltNG5tbm5zYUk4VDMxRHVmQ3pnYUErK3lHRUhuaVVBb0lI?=
 =?utf-8?B?SEZvM0J5M1g2T1pCZDVrZENaOXZzUmlqMjBNQ0taVEQ2QU9BRW82MEdwK0pB?=
 =?utf-8?B?R0pFLzVCSU9hSnkzSjFTa1lRSTVNSjd1RSt1c2YyVVo4VmsxTC9aRW9scklu?=
 =?utf-8?B?WnRZTWRkWXRIMVYwZ3QzZjd4WTdLZit6QmRxcUo3T2Z2QVQrZFJjZ0hKL1Qz?=
 =?utf-8?B?TVdVWmNpb2lNL1dyVHdRTFk5ZHBGZng5dm1UbkdLSVV5OUMyNlUyUGxKRUY5?=
 =?utf-8?B?RjE2Y2dDdSs3TVJ1VVdueWgveWJ6MG8rSkY3ODQybzFQVVE5VDROa29QVlpP?=
 =?utf-8?B?NXMrQW5HNDVTbXhIWEI0MlhhQUJJTUNTbjVGWE1YbnZqT1g1RmRWWkdtZDMr?=
 =?utf-8?B?bHpnb1AzYVV3SVlJQW5aSlVOT0EzdWFFdGlwd0VURXA5S29VaC9JVlNYaUIv?=
 =?utf-8?B?enpjVU9HZzNMT1lNRDFlQitUUzZOQnJiVHZmbjcyQmpqZzF3Zml2d0hheW10?=
 =?utf-8?B?RW5jQit6aFhFM0l5VHI3RGtTZUNWWjZRei92cUN5K2dFczN3TG1QUnpUdmZM?=
 =?utf-8?B?RXhaWHRQdnNGbDdIVDNoemcvK3FSQm9tQU1pZmVpYW5BaUIvbTdLY1d6MkVQ?=
 =?utf-8?B?S0lvWm5lQnArNmoyVGVYL3JOeW1kRXI4RWdjN0I1WXVvd1hOd0huM1hHMjRN?=
 =?utf-8?B?WVVNOWovYnBOcXgvMTA3Y1N3bXJ2dGg1UTBFVDVKR054RnVURWI4T0pWd21F?=
 =?utf-8?B?M3NUUGk2ZjV2RUJQQkQyVnNZU2JkaTE0OGViNlA4bUZNMGM5eDJrMVRuT1Nw?=
 =?utf-8?B?NUN5bVFhUk03QTJQMmwxM0IrOWFtQmZLUVlaancwZzBXbEZpamtscWpGaUk5?=
 =?utf-8?B?Zm5KeHFWalFLSW1nVjh2SFFxdnhGVVhkM1BXYWw4SWJCQTFFSGFSZStFSE9J?=
 =?utf-8?B?Ukd0ZVlkRkFpVHFCNnpHOUtUQXdGM1dxaGRqd0kyeHlVNTVWdEt2SlM3QkR0?=
 =?utf-8?B?VEk4Wm00RlhQcHlTYkNkd2xidm40UnlCWDZCWG0vbUp2RzBZbDFxWDFORmVE?=
 =?utf-8?B?SDdUNzRPOU1WTjdKYlc5L3lWNGdJZEs1TVgzcjZyRmtlV1JFQWRtVXp5V1h4?=
 =?utf-8?B?OU9icXkwQkpVZS9Cak9VNDF2cXNoUkEvd0YyUTRwOGRuMFhiRHdaSDFTT2Vi?=
 =?utf-8?B?dDNXblJ4MEdZaVhzTTF1VWhOUTZBN2JnQktKUXNKeWpyei9ES3cxTVE2VXRD?=
 =?utf-8?Q?mn2Z3eq4TD/79fg6TE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fa798b-97b9-4634-eea4-08deb6790733
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:06:46.2837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGB9x8W4fCJMLpslSV1FKUmJph2CJnYYwWDMhDm5vwzQoQELHBxmtgWnGU757T0F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610
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

On 5/20/26 14:33, Xaver Hugl wrote:
> Am Mi., 20. Mai 2026 um 10:08 Uhr schrieb Christian König
> <christian.koenig@amd.com>:
>> Well I would say the other way around is a pretty common use case.
>>
>> In other words the compositors uses the internal GPU for composing and displaying the picture. And the client uses the external GPU for fast rendering.
> Sure, but that's not what I'm talking about.

Yeah sorry for that, I wasn't sure if I misunderstood your use case because it's usually the other way around.

>>> - the buffers from the client stay valid
>>
>> Buffers from the hot plugged GPU don't stay valid. Accessing CPU mappings either result in a SIGBUS or are redirected to a dummy page.
> Again, not what I wrote about. The buffers are on the integrated GPU.

General rule of thumb is that as long as the exporter stays around the buffers stay around as well.

>>> - the syncobj stays valid on the client side
>>> - the syncobj becomes invalid on the compositor side
>>
>> Nope that's not correct. The syncobj itself stays valid even if you completely hot plug the device.
>>
>> It can just be that the fences inside the syncobj are terminated with an error.
> What about eventfd created for a point on the syncobj?

The eventfd unfortunately doesn't has error handling as far as I know, so when a fence signals with an error condition then the eventfd you only sees that it is signaled.

> Another (future) problem with hotplugs will be if the sync file hasn't
> materialized for the timeline point when the device is hotunplugged,
> since there can't be an error on the fence if there isn't one. Or
> could userspace somehow set an 'artificial' fence with an error in
> that case?

In general the answer is yes, userspace needs to take care of inserting fences when wait before signal is used and the work can not be submitted to the HW for some reason.

Currently we only have an IOCTL to insert the signaled dummy fence at some timeline sequence, but it should be trivial as well to insert a signaled fence with an error code.

But the compositor needs to be able to handle that case anyway, because it can be that a malicious or just buggy client just never inserts the fence.

So that a device is hot plugged is not different to just a client not inserting the fence in the first place.

>>> "invalid" there means either
>>> - the acquire point of the client is marked as signaled, before
>>> rendering on the client side is completed
>>> - the acquire point of the client is never signaled. Since the
>>> compositor waits for the acquire point, the Wayland surface is stuck
>>> forever
>>
>> Both of those would be a *massive* violation of documented kernel rules for hot-plugging which could lead to random data corruption and/or deadlocks.
>>
>> If you see any HW driver showing behavior like that please open up a bug report and ping the relevant maintainers immediately.
> If there are no error codes with syncobj yet, then to userspace, the
> latter behavior is exactly what we get, isn't it?

No, from userspace side you just see a signaled fence. It's just that you need to export the timeline point of the syncobj to a syncfile and then you can call the QUERY IOCTL on the syncfile to see the error code.

>> When a hotplug happens all operations of the device should return an -ENODEV error, even when exposed to other devices/application through syncobj or syncfile.
> Okay, that at least gives us a way to fail imports somewhat
> gracefully. Normally, failing to import a syncobj is a fatal error in
> the Wayland protocol.

So the task at hand would be to avoid importing the syncobj into a driver. That should be relatively trivial.

The only real problem I see is if you want to create a syncobj without having any device whatsoever.

>> One problem is that only syncfile allows for querying such error codes at the moment, we have patches pending to add that to syncobj as well but we lack a compositor with support for that as userspace client.
> As long as the error case can be detected with an eventfd,

Yeah that's the problem. The eventfd only tells you if the operation is completed (or at least has materialized).

To query the error you would need to ask the underlying syncobj or syncfile directly.

> implementing that in KWin shouldn't be a challenge.
> 
>> Well the question here is if the device the compositor is using or the client is using is gone?
>>
>> If the client device is hot removed the compositor should be perfectly capable to import the syncobj.
>>
>> If the compositor device is gone then you don't have a device to display anything any more, so generating the next frame doesn't seem to make sense either.
>>
>> What could be is that you want the compositor to be kept alive even when the display device is gone to switch over to vkms or whatever so that a VNC session or other remote desktop still works.
> There are two GPUs in the example I gave. The compositor can use both
> for rendering (in cosmic-comp's case) or switch between them (what I'm
> trying to do with KWin), or use one device for rendering, and another
> for importing the syncobj.

Ah! I think I got the problem now. You basically want to avoid importing the syncobj because when the wrong device goes away you are busted.

The reason we didn't considered having the IOCTLs on the FD is because if you don't import them and instead keep them around you can run out file descriptors quite quickly.

When you have an use case where you receive an FD from the client and do a one shot conversion to an eventfd that will probably work, but for keeping them in the long run you need some kind of container for the syncobjs, don't you?

>>>>>>> 3. It removes the need to translate between syncobjs fds and handles.
>>>>>>
>>>>>> That's a pretty big no-go as well. The differentiation between FDs and handles is completely intentional.
>>>>> Could you expand on why it's needed? For compositors, the handle is
>>>>> just an intermediary thing when translating between file descriptors.
>>>>
>>>> Well what we could do is to add an IOCTL to directly attach an syncobj file descriptor to an eventfd.
>>> That would be nice.
>>
>> Take a look at drm_syncobj_file_fops and how drm_syncobj_add_eventfd() is used. Adding that functionality shouldn't be more than a typing exercise.
> Yeah, this patchset already adds that functionality (on the new device).
> 
>> Do I see it right that this would already solve most problems in the compositor side?
> Skipping the syncobj handle step would only reduce the amounts of
> ioctls the compositor does, but afaict it wouldn't solve any
> compositor problems. At least not as long as it's still tied to a drm
> device.

Yeah, you need something like a syncobj container or dummy DRM device.

> For device hotplugs, the only new thing we need for correctly handling
> syncobj is a way to receive errors on the eventfd.

I need to look into the eventfd code, could be that this is somehow possible but it's clearly not something I used before.

> A device-independent way to create and use syncobj would still be
> useful to us though, both to simplify the compositor and to improve
> the software rendering use cases.

Yeah not sure how to cleanly do that. We could have a dummy /dev/dri/rendersync or something like that, but that would be quite a hack.

At least I understand the requirement now.

Thanks,
Christian.

> 
> - Xaver

