Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76BF1061B19
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D9910E214;
	Mon, 30 Mar 2026 17:36:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u+Zuo1fw";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 376A110E1FC;
 Mon, 30 Mar 2026 17:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXPitejKFNOnjej0KjePkzIfR5Zb9tklcQpKHc46lOFmpqcwt32TLBJSzEGqcWYXYniF2yvAXYT6uetDU9qFOJeZdw/VnwbTlU65x1bZ9whRoglJmtgteYHRoNJMa0hYli0ljg5KbT8wxH7K44QGRP+CcI+iOK3hvDbqZa4BasZkaVSFN6C7wJ5kXnS/jxncD5/NcZPEbvMcVIdgz6RoMQ2LQIfoTMvsCj1v8Eyjou9P/A2Z4clQ7xiLAIrzpanPpkGXN7uK7DarRd6Du9rJk+Q9qQQ9nICZm4+lGvrtmbz4IMJZ6eQASws+FLjcpOWDZ0BHJZuQxbx4zsT8dMH9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0kkc2wlCVsv5E5XvEzCudkwZ0qToaZZIXHqgwgWDog=;
 b=vNuxEKAfT461nSYj+DN9S0G7F2NsEJV28+KCtiE1YrwqLVq23nOhLWsTE0aFlhbRneBhcVtIMZ3cyF9p70RIYa6DVfyPYgmnDjeIx5IjaOC49J79x/pwiBL5vw0p9f7lVGuVlWNlRWDUUQvsYzvK5oByje1oDnknriSKR7KBa8p3JVZKOcr8sBdmHbwfH/DkmmGRXxhgCfSMErsPtFIm7aysN6AudHjUjG4FH8jC/X4KAQg9ebDw06X9ESK0yLTsdR48n4vwD2tEhKvOHgRSYSFip7Eyj5UoXj0sofY3VUdZ+1ZhLLql0oaYR4reXhS+dXQ6Pke4TWFBRMADSXuuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0kkc2wlCVsv5E5XvEzCudkwZ0qToaZZIXHqgwgWDog=;
 b=u+Zuo1fwfdFN/xxwjV6YYAZTkAAHO0fbIg9rq2BU3bdxAewyKUTjlM3cimrYpPtl4zLkVfuWZCog7aWvyXw7Ir9UjMHd28fH5I0/++KXj5/45/a24fSmM7wuTix1fYl59DZuB+2/JxjFFE6mhmJK5/upJ2LYzOJEAtjOPHqVQqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 17:36:42 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 17:36:42 +0000
Message-ID: <78da9dfc-561f-487c-8b68-0ea408819225@amd.com>
Date: Mon, 30 Mar 2026 13:36:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>
Cc: "Cyr, Aric" <Aric.Cyr@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <DM4PR12MB521342239D4CF694B4A68E0AE64AA@DM4PR12MB5213.namprd12.prod.outlook.com>
 <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
 <d6e190eb-4843-43ab-9706-fadabde9cbce@mailbox.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <d6e190eb-4843-43ab-9706-fadabde9cbce@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0026.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::8) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 52814942-ab17-4571-16c3-08de8e82e7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 9uTTFKUf2AmZpYr3muw+yG67UfSwFn3njCp7ZRAajl67c1x0mGnKYVBxtgwrQP76OsqpOkFePH7cA1Khq/I2nKbPsGJlqfkW2xi+aZAxBFjUu6sFvIaWUWGUpkLV/ab8miw/i3RzDTHWxcmOhOtibJY1KXenbiN5DpfcRAyfiNwKAnq6Iw9QH5ge2GfoZufw5LhbERHud049zboLz8gpjy301LxbW0/LMNwwKjVNSmIPIyi6m8yQHOPjD9tMmCfE1Hl8Cd1WbehuK2hYY3AQ/kAhNC6krey0UgD4uUnrs8B4AX0aTOeXYwXMebOah9e6vNNLkXhl9B7bPI4DeRNHl9s812/0ETwH6x9ES2DpL0xdQd7n0NhvLOXUGyykQ3y8MkaIvabJt0jOdrZmgmdMqYzSqMo9Gvh09Sn8XMNc5277M0BaCTzhbhwB5yev6miCahDp3mCKOLG6Wz97+hbhehvjBa/S0BmJ5LdjS6a3j6rAOGzhuh/xGP1iZOkzSqI4ssI5+um1f12pvihDsYxUzGoYklri/FI5vinfQGRTHMOTsbYtHPPxBfFC4x1RIlqz2OjHl1BijaCPEHJ9j/OvmIfBQa4iyPRV6PcaM7wBLq4IA2y56ecvObJZPIxsO11BmyzLzlo9m7c4vEtSnbPHClM4RF7kDHKNoh95SfaUhuBWnLbtcYpXJ5YL7Atuxrqb1cr0WcmPmxTMUXmt/L48cZkTvQbvrUav8TMAqgiUhjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJaVXo1T1JTL3dNYWNsWUdEOHJLK3RNSXFjc3JQVm9ndjFUN1RKeEV2ZkVM?=
 =?utf-8?B?MkcrbWd6NEk3MWVmajVTcWhxejB2MjVaM3lGLzM5OUlWT1R6bTBBVUxpaUpO?=
 =?utf-8?B?bWlCdjkwOW9PSGhsbVZDOFNtckhZTDZSdDYvOEVId3VrWlVlc1FOREp4ZGFV?=
 =?utf-8?B?dVpFeW50b2NvZ0RGMDNIRTlnT0xOMjdhY2hRaTl5WEN2aG9XejJscldITmdu?=
 =?utf-8?B?a2Z2aVpoeVBuT0QrSlJOb0VPaHpFWmZFQjluT0R0QUdUV2NmQWRMalFuVktF?=
 =?utf-8?B?bVA1d1ZSUFMvZXJHNERETzBJajhGelUyaVh4ZjBGRUVLS0xTNHFPMFFsQkNo?=
 =?utf-8?B?UmJoQ3l3S0pmOHlKK1pvTnNmWjB2K01PNnArNXh3WlMva2pmeThrZ0IxKzBK?=
 =?utf-8?B?MDJCMmZPMXlrTGlObGtHcXlhTk95bTI4QWI2UHJmOXlVcGZwcXYyRHZ2R2dz?=
 =?utf-8?B?TExWeVBRYi84UWRPNkI0aUVJNllwRFUraFRUWnB6aGtXNTQ1RWoxcGNodDB4?=
 =?utf-8?B?dXlUdnB6R2NGN0VQdyswV1c3THNqRHR5d3VoMmxtazI2M1F1aUlHbzBIbHJY?=
 =?utf-8?B?K0NYM3lLYWhrOHoxcUFKckNrQkcrTll5SEpRcWh3VHZZTHlaUHpXQ2FFYy81?=
 =?utf-8?B?RHpNZ1g2LzZYV3k4UTFEOGNSWWxSOGkza0JObGlab3BWcmxhZi91WjNKbldW?=
 =?utf-8?B?OFMrTFVTck5FWUYxZEJYVXlBRzhqTkUyV3IwQ3Y4MFlKZVlkVHUxQjlENzVG?=
 =?utf-8?B?VVR6cmtyTGtwd09aMldhWFM4NE9nTFptUm9KNTluM0tyNmZOaVJCZ2hLenhV?=
 =?utf-8?B?REVkc0xXOVd5M1c1eTdjaThzWlVvUm9VbFNuNnlOMEVITGFBUXNWNU9jM2U0?=
 =?utf-8?B?WlI0VkVJRXRsdkRLenA0M3RxbHdMRHEwVGVYaEhINzgyMlVrdjlYcENCTkMw?=
 =?utf-8?B?aXFoMXV4MWE0dHMzbUJnNnZneTQ1VnY0djZIRWJHTVRMdVUwb2dQZ2cyYVB1?=
 =?utf-8?B?Z0hSMktuTVhacHcrZ3NDb2REbjB6a3dxaGlBeThDMFZhNGdtUklnMVl4ZG5o?=
 =?utf-8?B?TmpmSFRKRktjWWZVZGQ4UythdU8zUnpZVncrZWE4dUJtamgxNlA4NXNPelB3?=
 =?utf-8?B?SVlVYklVNFc5bEo2ZnBmZnV1L0VKSG9LbXpQT1N2Ty9KSDZ5ejM2d2FFLzJZ?=
 =?utf-8?B?dExYa25lVkRCNVJnaWhNdUlXTEVMUW5LMHhxQ3lrK2xTR2VXWHBFcDJEN0Mx?=
 =?utf-8?B?amxyQlFrN1dDZkoxVXlTSlJNbk5xSkxidWFOd3ZDNjlTdk1aazB4bS9jeFF5?=
 =?utf-8?B?VEcybDgrYjhEVE9BZUlJbURtdk55MU5Mb012TEswY0plY3gzSTB0dWpGWVZ0?=
 =?utf-8?B?Z0RUUmordTlHekNKc2pCckR4VFJYbzEzNGhGVlVpRXdzQ01kei9RM3N5VXBF?=
 =?utf-8?B?TWhVdHlRZ1MzL0ZuVlF3U0UrdlMva1JTdlZsUThLb2VIRmdoNWRYd0pEMTRq?=
 =?utf-8?B?bFVPUUk5RG4xdEFyMnF2NTU0U0pxdnpBamZWWVZ0MkVXUkJzb0d1Ym5VZGZ6?=
 =?utf-8?B?cDYxNnBSbmU1aEY3Wk0zZkNXZjlVTXZFclcrVDV6Q0VKRzdhdUs3dHdrNzlk?=
 =?utf-8?B?cG1mMCtjMFRvZUx5TlpRVVZON2wwMStNT0ZDR01OQnp2Z0NTNmgxenloUGNU?=
 =?utf-8?B?eXhvK1VieFd5ejJrZlhTeU9vKzBhZ1N1VkZoMEh3WmNMaXZsSXprSk9DUFMw?=
 =?utf-8?B?NU52VGdXM1c3K2ZvOFk5cEcrbTE3Rm45UWU4NWJPMVF6dVdWSVFxTWV0N0lS?=
 =?utf-8?B?WlF0TkpxcnRzVW5QUSt2K0ozdHVzYWZUMG5yd3ZHZHVGTDcxU2puQndBMDh1?=
 =?utf-8?B?eEVvQ0ZZdk5oSVJDNGZjK1liODZLR3hJaVJyanFhUFd2V3gzeUdUZzhhR1Rw?=
 =?utf-8?B?dFRtdXF6Q0RpZzdUcW44bUxzb1VpWEtUNUlvSUFsUGJSMEZTazY1cEo3M3Qy?=
 =?utf-8?B?bkNiMUZ3cFhyanF2STFhb01GdGgrdEZlZXFhUTlWQmlYenpYaWYwajQyeGRv?=
 =?utf-8?B?NUpQaXRQcGhFZTd4ZmxvUDRqYTRBRVhDbnFzbVN5dTdma3l2NElITDN6VmRr?=
 =?utf-8?B?WS9QcGpGWlFWMGNSdjZoQmg5VU5mV09lbFc1S0RDSmNSZ3BGMWJCOXpFZVVV?=
 =?utf-8?B?MUlVc20zSVVQK2dUTTR4N2VTaXJpU0JIbWNwNHVEeVoxcmtGTEZpSmc1eXhh?=
 =?utf-8?B?REJYMjdXTnhVWVNaRVJpWnJnQUVYdUxMWnFxcXZtdlRPOTFteTg4NkVjSGRH?=
 =?utf-8?B?M2hQUkRKR1hyeWJITE4wWEFpckxtSjloRTFPRmUzRWxuaUVIQlljdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52814942-ab17-4571-16c3-08de8e82e7bc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:36:41.9431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PfoRLXGebXZDEYEmFrUR8aOf2Nr8yiQOvQsZo0BVniNi1hRhIOIjJ9GBjKAPtDefUEvsVvl82H19U1/aYzAHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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



On 2026-03-30 12:20, Michel Dänzer wrote:
> On 3/24/26 20:20, Mario Kleiner wrote:
>> On Sun, Mar 22, 2026 at 7:11 PM Kovac, Krunoslav <Krunoslav.Kovac@amd.com <mailto:Krunoslav.Kovac@amd.com>> wrote:

snip

> 
>>>     I believe we don't have surface info in that code, but one way to work around it would be to use spatial dithering for FP16/ARGB16 and rounding for 10 bits. But if we just switch to spatial, some of the earlier complaints about 10-bit output having one-off bit errors will be coming back.
>>
>> Looking at all callers of resource_build_bit_depth_reduction_params(), they all have access to the associated "struct pipe_ctx", which should give access to pipe_ctx ->plane_state->format of an associated display plane. I could prepare a patch that passes the pipe_ctx from each caller into resource_build_bit_depth_reduction_params() and that function could check if a 16 bpc framebuffer is in use and switch to spatial dithering down-to-10-bpc in this case, and leave the rounding/truncation to 10 bpc otherwise.
> 
> That doesn't really make sense, the output of the display HW colour pipeline has more than 10 bpc regardless of framebuffer format.
> 

The output will be determined by the link bandwidth, display-advertised supported bpc, and userspace-selected "max bpc" on a drm_connector. This could very well be 10 bpc, 8 bpc, even 6 bpc. Or are you referring to the internal DCN HW representation of the values? They're higher, but that's somewhat irrelevant.

> 
>> This workaround, that you also propose, would be the least bad of all bad solutions.
> 
> Seems pretty bad to me, mixing up things which aren't directly related.
> 

I'm not sure I follow. Dither by definition is about relating the input bpc to the output bpc.

Harry

> 

