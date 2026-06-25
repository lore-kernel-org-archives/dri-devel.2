Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED91CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EED610E0F6;
	Thu, 25 Jun 2026 12:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gUvQjC4p";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F69510E07C;
 Thu, 25 Jun 2026 12:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCU5X1HpEfeXKHTujH2zuqJi66oefMIEJVHr3xGzA7qEIiHTjJMAcp+NGJO5f1anjo/GUxuqw0zBaROhPyOR1iS75IXwTg7SCaQDzF45FK+W1Sq3DOfU0uXQYemHq2XdUMFoab73oWykhwEJOIPH4tNNl7duRkIhz0cEQuiX531EYcb5MOC5I9AJQY2xqAStRBKPxkwepkTXLfJMJkUPjBT5kWQomoX+7V65sIrowVSqVtikpm2vpcUdJa7BcczEtHAtdtupSdg+ZqAeImLG2AD+mtGsbPrsHZ/orhYrJZKfPzyx7abNUhNEOqNDPqm5sPiGshcmmkJ6+UuDgj23Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGZcZd6Pw49rXJyFhW+khF0ZUBYamAH+CGkRnKVxGoM=;
 b=OFLxnGqNPYlKCLEBRNW4WxduR+VdFoePLxes7MfbuBFraYfEhfzMpQx7Ve5LEl2tkoj1p+NzFaMGXWDtqKMdCyj9WXMFWmBG4Pr5nIQDVW6vsIFVbyfMO3BqjURAe9HIyZ05Dcjg7zJAofq3K6TTlEc1LKN+ZTlNPWqkWTdvpZq18klT+BfJCSszjJP96jJ7up1tl18xuE70gkUq5+0AKqvL0UVMa0/X5Kg4uVF62+WNDBpP3dX2Mw9o7O0++l07UarByiuavesKgD8mFFs5gHlFOEAj0MlCwe/Wi+MnOI1csc121SnIskSraFaWqX1aC6ni4URwmB44q2BoU4CKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGZcZd6Pw49rXJyFhW+khF0ZUBYamAH+CGkRnKVxGoM=;
 b=gUvQjC4pCHNMsltnRBOfAy1N34votuydby+MWVmbPhYmKBD31NJO0FcyivmWaOFLNze3iGxvVO3Z87A2TBfPPtfmn6A4BF/3vTlggYEiIuDuNQPZS1nsEgMCKo+/xkVtEgbVYa8dxl6sryGLAlEhF3tQcrsetBpcH9hUZ7FcMSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 12:50:21 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 12:50:21 +0000
Message-ID: <1f83130d-f58b-4720-b60c-5e1326757932@amd.com>
Date: Thu, 25 Jun 2026 14:50:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reject mapping info for unmapped BOs
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
 <72aa8cb3-2b48-4b08-ab17-788c3dd18fe6@amd.com>
 <CAMuQ4bXYumKw9jTJ-FpCYfnzipR9jcFVSbp_k=LAbModoinRsQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAMuQ4bXYumKw9jTJ-FpCYfnzipR9jcFVSbp_k=LAbModoinRsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a204ea-1289-4f69-003b-08ded2b84fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: t7sekzVim4V0lZT63KljUi3IEEreIK1TSW5uUvtzhRgeXg3lAAKgJ/c+Of2fv63MXQku0WNga6tdMs6SKLGiJxFkFYCCODX/kG2OOjI46qX4jgHlOhAmlMD1FZJqf2kYDSe3JbaYuL/WNQVC1oXk98K+lA6IgF3of0NaXTvIHqRp4yKEooeEzOOoq0WL4vP5DR17YaUoc0Mu/MZGpMjupi/gCY1M5LsL3zCpnEL5QjeTbIFHt4Xp0PRXVuoyi4ZQG5wCuEfeppfOchJGgWie40axSTgo8A4pv1GKjJvA85iflC1nOaFgjNEbzJuipyASbW3ASHN4Ijz2WmGFgmhRKiT6wIg677SRsz2xioSXSwxt12vyvjeVZ88l1Ax6TFDEs7WBUpjZZJ6xvCY812+Q8Cps6v98Fv0I4a+UD+b/vNO5ondHQKVkvvZfoxcglYXw415MT/R6dHz94Bw0fAHlnKJ+awp4Rtom2GyfWqStRjWqfDMT9yQHLTx44biS5ConzsrPVMzVu3Z2Xw/C7RA39ixm+3D6af2D/duvCrXURWPHiQkEX9YPzlpVFbMwuT4tEZ1B4eRObHx93/ksNjRYBH6mZ8hhF6R2z5Z7c5Li4FrRPo4j4tCdlk3NkRqSlR2P/30e3fOSFMb9xAwcF9/HSfPVB1Mmw3CDrtclqltLQWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEREaHR6MnFNQUNzNS9SdXVOU0p5bHdTRkhOc1lvcVE2M2Y0Rk4yVU54d0RW?=
 =?utf-8?B?ZE14c0tTY0pFWDlVcE81RjF3UytiNmUyRVNVb3pqeHFJYkl6OWV0YTl0RE9p?=
 =?utf-8?B?VWduR2NGQnR6V2FqazlYTk9PMEEwUXhtdE01ZU10dm9KbFh1QnFpTUF4VCtZ?=
 =?utf-8?B?M29ITHRNdkVVTFJUNDBsMHJ0NkZlZkd4UndERUdTeFJRcnVQdGs3OWRSL2d5?=
 =?utf-8?B?aWJUcEZGNnA5ZEhURGFiNExjOWM0K25LMWZOUm9hL2hxL0dPcnVFUHZFb21N?=
 =?utf-8?B?aW53eUwzQ0UrVUp2RTRxZXZabVRCdXdXTWNQaTFWbTZBL1NCQUF5SWIvUWRR?=
 =?utf-8?B?UkZvaHRQTGlaOFAvTDA1UTFtN2pLUGdaZTRtNTQvQnB2OTFsbFVYMWxvUFdV?=
 =?utf-8?B?VjJtZ1loanBQYlQwcXc2dllZZ3o2UVVrOC9JSStIVWcyYlluUGxXcEdkeWZw?=
 =?utf-8?B?a3VTZXJvTkgrT0Z6cFh3VHk3TGhXOWRkeGorY2EwSnhzcEMxUGYyai9ORWRM?=
 =?utf-8?B?dDRKSkRTOWkvVlpHazh1cTFjMlhRbDVvblF6NlVaZDF1UUw2SEgwODUrcUhC?=
 =?utf-8?B?WmRPVm5DaVZZRHRkNDA4VHkvT01KbURlaUc4U2JEd09sOUVrSFgwVmhtOXBX?=
 =?utf-8?B?NGh0R0ttVWErK2J1RGN6ZlBIelQ5aTB4bUkwaU9PcGVDamhwUGxTZHVvY09P?=
 =?utf-8?B?dlhmUWpqdm9CTmdoTjZGWVkweU9BK3p0VkU1cVU5bnk1cFc0alBodE1WQU9K?=
 =?utf-8?B?aUg3OWJ5TjJwOEszWGlnTnFLS2VVUHcrRmxvUEl2ZzRhckpxRDc1UnYvdG5p?=
 =?utf-8?B?elg5d1NxVTVuL2gvcE9tYjJhd1ZMOEkrcmt6NHFrQ005L3hqdm92a2VnZUFP?=
 =?utf-8?B?TlJBVW5qRmtpakhPbTFuZnlhRXJtSWNqZXJyY0VzREpPS3lGZFF3NXRKdmp6?=
 =?utf-8?B?Q3BRZDZmVXV6SWcrQ2V6TGUrRS8vRGpJeDBuOXBXMStZSXd4VE5Ya2YwVWxJ?=
 =?utf-8?B?b1lJaHZvNkhsQVlzeENnUTRBTWZuZG1uV1pTaXVCdTkyZG5XQ0krUzBZcE9Z?=
 =?utf-8?B?L2hhQ3ZTdW5ZbVpBK2t2cFpGUE5NNE9PZmVIU1Bud3I0SkVYR2pMYjVkZ1V3?=
 =?utf-8?B?aTJaOFh3eEN3TnNvNXU2Qmprai9IbFN1SUMyelZyNXZLcmJkS3hSbWFHS04r?=
 =?utf-8?B?RXA0c2ZlaVdDd3N2VnpRMG9CSkJBQ2ZOQlRnNy9vUDhpNklWVkxNaHhGQ3Jy?=
 =?utf-8?B?eE0yTW9hVmJ6di9uRVkwRk1weHNRRmh1ZG5sVTVTR1ZsL2tBL0c3MGl6Wmdn?=
 =?utf-8?B?SkdJM2tNMGdMMG5BbHdxL09lL296Z1VhSjZrTWwzUXJ5c1dxc1YvZW5jOWk0?=
 =?utf-8?B?M2ZkWFpIdmtROXlNSVVac0NOdFpYUUFTVlF5dWtDNWxCTU56a01XajljYmFk?=
 =?utf-8?B?NlJHQjNpaUwyN2xWdXgzN01uemtxbTJzUUVqdHZvaURjekc3MjJyNllVaVU4?=
 =?utf-8?B?bmJ0RWZTMkFpQXlGTU1EL0hQQU1QbHBmUHhCVENySzZVMTlPaUUrajNsRlRo?=
 =?utf-8?B?SkJMVnJsNkpsZGtZWUhBYVJoRDJKQi90dSswVE1EaXVpVXZWZHVZODhxSmVG?=
 =?utf-8?B?WUpHNzdsMU5oc1VPM2tmWUh1WWp3QWZhcUh2dzhEanI1Y3ZBWVZqMVZrWUEz?=
 =?utf-8?B?YUVhSHUwaGo5ZG8zQVptR2ZSaVRQR1VWQm1oNnRGeW1XR29tQmR0UzVxRzBt?=
 =?utf-8?B?QjQwazF0WXZPZ09ZT1hReGYrMHdMMzYvMUppTHJFWTJHWERqQkJSdEl4ajZ5?=
 =?utf-8?B?bXpTWTBnRk0rTitBU1dKNUc1cUZVKzNqU3FwWGVMODZlWVRFbmNaOUF3U1hI?=
 =?utf-8?B?SnUwUmovUGoxTjhybjVmWGlySWd6WWtlZnplamVkL0g5ZWovYkgxZ0htNk5v?=
 =?utf-8?B?SThVYWhkYlVGM1FnOWYrS0xFRVJEbXVSYjRRdE40VmFPYzAvcEg5VDVlOFZM?=
 =?utf-8?B?WVIrZy9jb3lWaGpuelQzUncrVEVUQlNCRjIwL2I0SWR0T2FWcXJBTllGUFp4?=
 =?utf-8?B?WjFSbXVXNXByTEZ2UnVYakdHTHRZT1Z6dGo2SndtWXJzTkVIZUY4WEJ4US82?=
 =?utf-8?B?T1lMMGlTTHB4R09MMlpiejJqNWpvbFNGbUVtZnlMdTlLdGpRT0FkeE5XaW8v?=
 =?utf-8?B?TWhaenVmcVNQVHpaRVNVV3NkbW95VzhLU3o5R2NQOHVYY0lxOWxKNmxTNGJY?=
 =?utf-8?B?Q0RoeFlSckkvRFNYL2tZdndYVXhjM1ZEK1g5MmxZbmhybDdiUEZZWXNTZm9x?=
 =?utf-8?Q?y6Xjcvlz88LN4v/cxb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a204ea-1289-4f69-003b-08ded2b84fad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:50:21.4848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7SjpiRHEHedwxgTsoQ29pxJpRA4ItX1dw0x2MPTd17ZNOlTcLvXQQkyQXK8Hfri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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

On 6/25/26 11:07, Yousef Alhouseen wrote:
> Hi Christian,
> 
> You're right. I rechecked the handle-open path and bo_va should
> already be created for this file, so I do not have a valid reproducer
> for the NULL case.
> 
> Please drop this patch.

Well wait a second, I think you stumbled over something here. It's just that your bug description is not correct.

As far as I can see it is possible that between drm_gem_object_lookup() and drm_exec_lock_obj() the handle will be closed. So in this case bo_va will then be NULL.

It's a rather small race window, that's why I asked if you can reproduce this because we would then add this case to our IGT tests.

But if you can't reproduce this then well it should still be fixed. Just update the commit message and maybe return -EINVAL instead of -ENOENT.

Regards,
Christian.

> 
> Thanks,
> Yousef
> 
> On Thu, 25 Jun 2026 10:46:24 +0200, "Christian König"
> <christian.koenig@amd.com> wrote:
>> On 6/24/26 19:20, Yousef Alhouseen wrote:
>>> AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the BO's VM mapping and then
>>> iterates the valid and invalid mapping lists unconditionally. A GEM BO can
>>> be queried before it has been mapped into the file VM, in which case
>>> amdgpu_vm_bo_find() returns NULL and the list walk dereferences it.
>>
>> Mhm, that is not correct at all.
>>
>> The bo_va is created when the handle is opened inside the filp and not when the first mapping is created.
>>
>> Do you have a test case to reproduce the issue?
>>
>> Thanks,
>> Christian.
>>
>>>
>>> Return -ENOENT for an unmapped BO, matching the VA operation path that
>>> already rejects missing BO-VA state before touching the mapping lists.
>>>
>>> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
>>> ---
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
>>> 1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 212c14d99..4b2699931 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>>> struct drm_amdgpu_gem_vm_entry *vm_entries;
>>> struct amdgpu_bo_va_mapping *mapping;
>>> int num_mappings = 0;
>>> +
>>> + if (!bo_va) {
>>> + r = -ENOENT;
>>> + goto out_exec;
>>> + }
>>> +
>>> /*
>>> * num_entries is set as an input to the size of the user-allocated array of
>>> * drm_amdgpu_gem_vm_entry stored at args->value.
>>> --
>>> 2.54.0
>>>

