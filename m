Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B416DC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C250810E67D;
	Tue, 14 Jul 2026 09:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J1cqXL0s";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD9810E037;
 Tue, 14 Jul 2026 09:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFVoJz20mM4K2RJrTOzVkSbSlB7hPPzbxLeyrWF0dD/caI53v6vYWRg//ucX3pSqF2DaTicdq/YdsYSv2q1L0G2DAk4Nb5KUSJnOp/338XPb1Cy9YPZikpUHNMpZMxYgvR/MjoWWOTKikPHOlinEzLbNkuSgb2pOEToZQWmOK9kp0EnhuaqiNcYSfpKmmOVhR7yXvroKGBr7nZxrnnxgWGRsG+oPx47lLhlhCjhyeGYLcx/4OuGqX7tiiJiu3Cmj49JehPY7gne9VqUkcbQV5tyKVLOMSD4us6NnAYr2Y6xHrHiPCAjfUL/GrGCr+Kkx/TEmUZY1oXWeEee0VaTTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYU1FMKbQMbLFpU+z1o17vL3ux8g2rvKY42RiYqU6aY=;
 b=oIuB7dg4OS+AZE68zJoFDfM0C6ZiWsqVNxrBxXJm9wC0T6SStHhq7evHS/QJL08vDcxGP2muC9Jm7dekBtRcRwlau6gC19SNMjndfgrtonnfzzGDQSkGFPlWg6wTDE/ZUbYfW43Y+21Z+v0zIez1q3O7eG6uUdKCAIAKHCkKq3T1rWH4NkWTxzWbJM0hDMHYQugdfufAW/ZflwlOMZ+ggyESnj9lrBcODwtinV88iGIFkx+H/WH0cWId7SocP4yvKHv87ojE66q/K9AYUIv4lEY6kBJzeyJy78J73icVX2AvMbanxh1e8ffNcwFdBO2DbuEe2mRgq0GVxL7VjE6bxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYU1FMKbQMbLFpU+z1o17vL3ux8g2rvKY42RiYqU6aY=;
 b=J1cqXL0sCB0ujarG6miUUdaq22u35omJ9p4nGDp00rk2Nu77V0DSZE8RxUH2Y2tOIvmBUXTCoa/sbgK+w8x8Z6Afm4rr8iPgmIeBhGTEFd0MSpIHSl3CGJQu07EXmmpCQdTRjgcheBtaX9v0dFvq0Vuv3RmQ7amX2MOpW8roMD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 09:21:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:21:06 +0000
Message-ID: <b3582f75-c98b-4697-9db0-871fb2730a54@amd.com>
Date: Tue, 14 Jul 2026 11:21:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove unneeded semicolon
To: Tvrtko Ursulin <tursulin@ursulin.net>, Chen Ni <nichen@iscas.ac.cn>,
 alexander.deucher@amd.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260714073903.3646544-1-nichen@iscas.ac.cn>
 <3e109b17-539d-49be-a096-bcd669fed5ae@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3e109b17-539d-49be-a096-bcd669fed5ae@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0312.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 5377e184-4fe0-4db9-3b08-08dee1893bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: SYCtHfjvp7+w0q7QK8FWv5lZQAvCwxOMtvBYbEAlcKT1dqiWxjxvkdWYCOFJ3jYUCeosWG0n0J665BUi08cAs/gVkw4FeIfXwgyBCng5CXn6dQt6wuMFPNWoOoCzYEArD7RpqMwMF+AijwKHZ2WGioFbjPIVNnlh+kh0JQ91gk1VYQIUFJXGz4IVfvcTn/c7cVUG9+A8P65HzSmxfpmLLlOpuIGXNkFVUXMwA3ZMmAt4EbbfwHo14B336E8row8iaMg2IGce9f/cSceyUPgAlMMWT15WrjQYW7SFrCTtQj2WxJbqWBJ/3J2zPx5yDULIEIPtNFf2egYp3+9YX8Xkzt/dVIK/lHYBTJ8MH99ctJK9E2oxNCYdT1V9l9iTjlM8daOzNukavycG8/oTcblf982aJSoi0z++LvYr1cfVcH5Qtp4nsJ+5Y3urItOhbuIUt6HZ4lOJN12D8iVyWnpI5TGgswZQr4DjjnxKcRhvR2hOECA3YILUto/i1xRFOhIc+tb373/hOEbWMCYhWqdJEaZUmFDmhM06nODUs7lfu1QB1qOf0TcXBgz0Z/rGQ57W9pD7n28X+OGfFOth1TI8WWy7fLoi+PLQOr/3q5Yq0pOIfxHo7U+0O3L93o9HiZQKcvz7AaVEai9NqbM+gWUANgJH6W5Wb+bUcEMlCjPkxjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXcyMUtEZDBxTnlqdGd0YVdVRXd4a25xUlBvT0dVbDJrOXhZREtiQ2hXaXdy?=
 =?utf-8?B?K0Rta0R4MUlBRkRnZFkySWl4Q3MvR1NNVVRnWXBnd3pEUkNseHgwZVZLNzFy?=
 =?utf-8?B?bjFibEFyM2xOWTV1NFVrNFMwR1dFWVJYcWoyOS80UnMwbEdETFBtTUwrUTNJ?=
 =?utf-8?B?RDBrUGxTVlRjVHJGL3pCc0tUN0dSUHA0QW5teDZGblhzdFBsVEpSV05lRVky?=
 =?utf-8?B?ejFPMVV4U29QdUxJaTNSd0ZROGJwcEpuYkxHTFVFc1FRdytRQ2dkS2xuTHpV?=
 =?utf-8?B?WGpNZWRldGFEVjRQS1NYeWhtUnpobmpHRWYrakFHRGVRcVNsL3FiQTVENGVu?=
 =?utf-8?B?aFlaTGt5YlRHZFlkcXRXczlVZjVnKzRuTDM0Ly9Scm92MitCQkxlS25zbWo4?=
 =?utf-8?B?cElFNEx2MWFNTmpsMDZMa2dSTlE3RWhmUmpCMkhrQlNsc2xjMWY2TVdyVTZp?=
 =?utf-8?B?N2xEZHBJRENRaEZoUlQxWlV3TG9qTFlseGZLVTBlellkYllzeUxMRENFdU9V?=
 =?utf-8?B?RVJFV0NLM2FPWlREYVpleVlKSmRZanpSdHlYWlRtbks2WGQ0ZDFYZllSM3JK?=
 =?utf-8?B?VkZQUGgwa1VubVljb2hpNWpaSlVmTDhsSldNbzdvSU1XMWlkQ1FqN1hLVVRH?=
 =?utf-8?B?UTMwZzF4YVF6OXczNTBoMVRzUHcxOW9KcmpKTTN1WW1weER5Z0pzRnJKLzAv?=
 =?utf-8?B?cVE5eWRhTmJ0elA2ZktWQk9MYmZESEVxSU1nM0ZFeFZlNzdIb1dZdG1OdElo?=
 =?utf-8?B?MUgwS1pRMjRZZGhXUDNZLzkvRXppZUloQWFOZHdPc2hqUTBmeXNiNW9aT1R1?=
 =?utf-8?B?dk1rUStnTldFdUZyUmhSbzJiampGWTFCbk96ci9hT0hjTDRzSTJweXJiK1l5?=
 =?utf-8?B?SFVMcTh1VHZ5Sy9LNklia0xmN1U5eExKOFpXMHcvZ0dORGlWM2NZbm92YzF1?=
 =?utf-8?B?elBWb1MyRnloUm12dE44Q09hQTJXVFhuVC82NUNkMXFnd3ZHbjJWUUNmeUtY?=
 =?utf-8?B?cm52ayswNmFETzBLVFRNYjlNRzRxcHhoWk16WjloWER5VDl3RnF6VzlIYktn?=
 =?utf-8?B?SktuV0d3azVIckpXUitzbHExZi9HcTFSQmVZZVIvYzNrNjdDTGFkRWN4dUlr?=
 =?utf-8?B?SU1Gc1RRQklGbnI1WFV2OFNVNmxJckVKUkZsL01ya1VjWjVDc3lSelRKNE5s?=
 =?utf-8?B?WXpwU3EyZ3NZeXVhQm56RlYxbWpUNyt5ZGV5K2R2Sm5nRlZjaGsrUVdkamNa?=
 =?utf-8?B?bUpLQm11a1BTcVFjUHlqTlZ1NE04RFBYUlloczQ5TGFKUTQ2RUx2NUFXd3BS?=
 =?utf-8?B?RHRkN2ZPWnJIbkNVRkNCUmhSTy92WjV4SWk3ay9BZnArTkc1WkhiTTFpbGFG?=
 =?utf-8?B?VGxLR0R2L0lveG0wZXplTlE4ZGlHczUwWndXR0tYdDIvYzVNTWI3emxkbXdh?=
 =?utf-8?B?b0R5azQrVnFSRE9BbExKVCt6YXQvY1prV2dDaXplUm4wUW5qZjhEamdFd3RO?=
 =?utf-8?B?dU5nWXpaZlZUTXZSMDJBdkNKVkNzZDkzSVo2V0ZDVmhyMTg0R2lDWkhzelpx?=
 =?utf-8?B?Mm5uSEtYeWNYbmFXYmRvY1ZRWGt6ODE3WVd4UC9VKzhZdXhhY2dxV3htT2ZO?=
 =?utf-8?B?dHpLNG1ncWVQL0FvRVlkM0lScjYxNUs3dHltWmxqTEh5Tnlib1kvTUtGMGpB?=
 =?utf-8?B?SHZnb2JMWXMvRUg3WWtXMnVTcFV5VVk4MmFFVlRqaTU1RmpSb2hBSU1TT3JZ?=
 =?utf-8?B?OWpHb1VHem9zS3hqYzFJMlk0ZFQxR3FzOVk1YmUrZWpEaVRTWEl3dEpYaWpF?=
 =?utf-8?B?SlZuSUxwYjRBSEhvMHNvQkdUZjJsM1o0aHppSVhnSm1qcTNPblFNTStZckQw?=
 =?utf-8?B?Ry9MNmdXZ0xZRjFvVGVTWG9YaUVicWNHVGsrZGM4WjNpd2ZJLzJlbVJrMUVY?=
 =?utf-8?B?TUVDbmtzM1JBc3AySU96NkE2dE5ndHIyanVudXBQSzRkWXhHa0d6dDZINmUx?=
 =?utf-8?B?Y3ZXRy8vaHQ3RmpqcEdoejc5NUxoSTRYUVViZ3NudzVlOU9NZlhpSXNXMXVJ?=
 =?utf-8?B?akgwVDVYYjV1bzJZRVEwUzUxUkVqYUIyS1V6ZjZhMFJpOXlyYW53SG51K2lm?=
 =?utf-8?B?NloyK01xQ1IzRjNyQVlXNDFuREFDd2RaVUh3OFRlQzFsb3EvM2k0YXBZZktn?=
 =?utf-8?B?QVR5MmptNUlpeUxlWXJRUC9RMlN5VlhueUFTOTEzRHNMWVlibE4yalZldkly?=
 =?utf-8?B?a1I2NlVLd0VRNU1TZzlST08yczZHcjYvSVA1NjNyZWZOTnQ0eEFBcnY0dGtn?=
 =?utf-8?Q?NhB27UWpUgvUv2ccZW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5377e184-4fe0-4db9-3b08-08dee1893bc6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:21:06.4654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJVeMzEe0yZyba0dHBx4LVZ4iEtLwRmS4vR73ASqgu/C2lbqc35N/PwNiOs+iLV7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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

On 7/14/26 10:02, Tvrtko Ursulin wrote:
> 
> On 14/07/2026 08:39, Chen Ni wrote:
>> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
>> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
>>
>> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Christian König <christian.koenig@amd.com>

@Alex are you picking this up as well or should I?

Regards,
Christian.

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> index ce1d08f112a8..c5cde42333d8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> @@ -211,7 +211,7 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>>         default:
>>           return -EINVAL;
>> -    };
>> +    }
>>         switch (args->in.operation) {
>>       case AMDGPU_BO_LIST_OP_CREATE:
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Regards,
> 
> Tvrtko
> 

