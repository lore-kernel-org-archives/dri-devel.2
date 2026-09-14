Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C7EC88E6F
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B62110E1EB;
	Mon, 14 Sep 2026 17:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EfCnxAfl";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD8C10E1EB;
 Mon, 14 Sep 2026 17:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZLGEM7VhH5RBWhT8oAPDwWWUiyWHlk6nNntxgQrAK0MDGIKGrYdv9jhXXvxiAI+sFKKMVGhcCJ9mDQCANnDPNJi0i9nz5zDMYfIfjEHxTaLhieY0ODZ9mX9KT7Qwz68gpuQ8HRsRckEDhO+Ho3ezHDu5qSuJjTgZV6qtOEQvepM6hMSgCQ66DZrIW2mZ6rPJh+o9A5vBAVOjHx2EOda53gK8DOOIny4LAp73Na0mIQZgrVgWJPdhg4vV+8grFkl4oGx2Vonj0ZNkyOOEvRSbugivC6ltllB9EgENtSPt/SlWupewvEHskv5FbtChBHbtyVpcNy5VfqSN6kj18Xb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rdB5sl+hWMWlLhEXroZ3nLSphAol+CoLrX+tiU7/ws=;
 b=qa2VX+71n8yoyrV02+CLMrf0gWTL9d7KpNtlbvZbhkT4Hk2r11wSnf2Q0wHPFsh4UNmT9aZOXkC3aDv6Vw0O+KIvErwPVrBxEdzf6fZDruyEi4gyIu1GxGcswoLlVpGLc0lNG7LeKStQ/vY4+mHHOjBjUm6zZJ9xiT/KAYa8lqH8WpcolShbZIKxCAwbd3470n21Zlq9by9puiPn4iNIadOMhy+iIIkc+fBS94PdGRE7uAcupYhMigpibhMABF97a8UtLr9CcFBXBGaKH3JOytaZT6s38Pi4djjX5MyZUtEj/5aAcL7Uer5ftrQsEbmLjbDCgpqKCVVX1znATDIO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rdB5sl+hWMWlLhEXroZ3nLSphAol+CoLrX+tiU7/ws=;
 b=EfCnxAfly3zVgpq8RX9rP1uH7Ie2caC+QeuuNC6WGrCzkiiSPjX+7pwipE86HG5tpTrFkeLBUheXB/NbvRPIC7V1uJ3Kwft327dHAS1RfWC2gtO5xD5mB6uxDQ4/0II3+Z4VBwWLL05dGxmy8+YsewDsHUOX4PyqNqXFSjrGIfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 17:48:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 17:48:47 +0000
Message-ID: <41428e7e-22e3-44d5-afdf-8a72165883f5@amd.com>
Date: Mon, 14 Sep 2026 19:48:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: zero reg_state buffer before filling it
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>,
 Alexander Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260914135650.87591-1-Dmitry.Chumachenko@cyberprotect.ru>
 <bc9cf07a-ef97-490a-b98a-a05bc9f5b186@amd.com>
 <05b669e6-1c66-4789-9916-b8030e232385@amd.com>
 <aeeff331-8b2e-41d8-acf8-d5d758935d38@amd.com>
 <c4f2f082-8956-4f20-af92-119b873c3759@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <c4f2f082-8956-4f20-af92-119b873c3759@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 177feef7-2739-4303-0894-08df12886d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RcWGEMcxgORxcfDO6XBQr2qMCp0aK5AV8cHaeQdFKhN9+cUVPGhRU4g94EmcbZU2GhsV7jTDJ7DwzmZGJuXuv0g8EW5H/qFFG7fJdHMKQrLfr6tQw1Tr1sia9vhwocd8bJNivH1Kkh0Ww43SySEiUSJHGnM/B7YndBPwzioJa20tqmSoZq0u00MqyQWApgqctSzfw8WRAdF2rscw7Ic6waUuxLPfBKPcjX4HTMxTuS3ZVd/kCX3saI8Y1+uZaK1zZ4hmetvrsGTV2n7vI0dTkjAY3/uZYgN+SnvuNYFejJ6x7Q2sEFNWGA0oEhIYI4kQz3Xds3i8VMoo8MY036CDg198Pr9L1X28ZGSjvXsnY1rQd+D5BKO0oskQ+yelQf5DyiyGdauw2Xyyio88wUPCpS5sKfQjlvyFvjjJZY/2QTqUEJBncvv2SqpNScGmNjdDU5CcItSXyvIRX1P0TkgLQdtKonoj++ii5aZ5t4nZKTfA8bqJDqkDVheqRdyW1N+6h0w7dznw1ofW34b75y8iVl8JlWCHtfexT6eB4csGE48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVdjeVg0T1Y5cjN0UisrV1Rod3ZMRHNCQVNOVVQxUmFGSFp6RWF5ZkJySW1X?=
 =?utf-8?B?Z254NEJXWDkrME9PTUg3L1dIRXVWQWtRN3B0LzhzUHFocFBCeHVreW5jYlAw?=
 =?utf-8?B?aUFXS0hzTkpFZWtPTDJURVczM0V4WHRxc09uN0FkZno0V2NrSXIyK3dTeGhp?=
 =?utf-8?B?eUZSSlAwM1F3TkNzVnh3eEZQa1gvblB1MHEwZ1NRTnhzK3J4ek4rbFF0MjMw?=
 =?utf-8?B?elBnUjFiQjdUMElIc3B4Y25YQllOY3lidkQ5NTFCeFFyZytKOEtBVk5MckJw?=
 =?utf-8?B?OGtwTmsxdzF1alROU25Vb0NTU3IxK3ZXSEJkV0xMUTQ5YTJEcXNaM0VnQyta?=
 =?utf-8?B?Ym5HaFM4U3JobTBIZExScHhvLzFUM1ZIZlduU0cyTHBqUCt6dzd2Q3N2ckVz?=
 =?utf-8?B?NWpJZHRrblZDUk9QakVLRWcyVXg4RExONitYNVJVWmJPcGZPczVnUk16emxz?=
 =?utf-8?B?M251RzMybnFBMHhoR2IwWjNtU00ydXdodmI1Qmh4bHhNR0dwbjBnNEVXcDRC?=
 =?utf-8?B?cnY4SllLMHhEamRVZjVEL0lrMFBwMUxPMGVIYlQzYlBEZ0JlMXNqRUZRNXBS?=
 =?utf-8?B?VzNta0NZZFlmd01zWENjTjVTRGgrYWVhYmxqbElpUFNndm9iUVFIWnpYRWFn?=
 =?utf-8?B?a256TXorRWgwRWNTQUhCOVJKWmNCbWZXWXE0WHoycWh2RVFGZGxHMWI1QmU3?=
 =?utf-8?B?aFhEV3dkVm5VVk5uNTBWc0F0Q1lwRW9HdThRaFRjV0JIMzY5UE9KQWVXbnFi?=
 =?utf-8?B?S0NZbTNBYXUvSmcycnRPRXFnSGVaSjV0cDZvazh5cTU2Z0cvQlZZR3lhd0l3?=
 =?utf-8?B?dkJJb2dzWTJDWlROaEJSVGJXOG9yZGJyZllSTlgzL0ZGSk9nRW9UaElpU2Uy?=
 =?utf-8?B?bkRYVlplU2FqdGlvR3ZML2RHcmVKbHlzLzhkdDlZTnhlKzlDbmRsZ3hnWVhM?=
 =?utf-8?B?OUFZMEVYOXNMZlB6TUUxdkNITTNMT2k2MnlrN1IvYWpZak51Z1JNSTNnMzNa?=
 =?utf-8?B?YzlKOU80NnZZcldwK3dYaDBoRHJNSTZYa2hEWGQwaHdHcWxQbEJoaWp3cTBx?=
 =?utf-8?B?OVpzcm1RUGRnTmdWUittbkhXWmVUMSt0MDFhNFIyUElOR28vQ1h6T3UybTdp?=
 =?utf-8?B?MnA5cTkxdjdWQ0p4bXA2SjRpQkxOSWZRcXZqaTl6dkVsZERKWStYUzRlejVw?=
 =?utf-8?B?cHloS1FVOE1ucXJNWHBmY2k4aDZVa293QXhWMForTHRhZjZNdzZLdEhheEtt?=
 =?utf-8?B?NStmdGwrUjZTM09LQnU3aHFKTTZoUVo0S3NJenRZNFp4TUtRNFh2aDhTYzdm?=
 =?utf-8?B?WEloOW5VUDM2SlBDcG5kaFZLOTFVUGNFYTYwZmNvTkJiVE43OTlIWEtCMEpJ?=
 =?utf-8?B?R29sbWh6aHF5ZXBiUENtcXZaNkYwNkM2LzMyWmh1TDhpOHBFN3I2WUg0c1ZN?=
 =?utf-8?B?MGhsNEtZWTRSc3ZIR3hqemZHTmZuL3BpOXQ4ajF2WDdEUnJ3YXhJeUJMOU5R?=
 =?utf-8?B?cW1BM2FlRzRCU0xIWE52allWTkM1MXN2N1AvZjZwVUVHcUFQMXNxbFdncVQx?=
 =?utf-8?B?bTNrVWRHeVp6eDJQTWFya3ZaRW9nRndHRXM5S3Y4a3FjY0xkbmRSMU8vTlJ2?=
 =?utf-8?B?SHF5QW1lTWpHQmxMSjJpRGZqclZvNEc4cElQTGR5SjV6NjZOQzFoQXlUMGoz?=
 =?utf-8?B?T1ZXN0E4ZUJvRmFRWUVPVkUzVUd4ano3Szh4K0QyaXlONjBjMEU4NEp5WkRj?=
 =?utf-8?B?ckFvL3dLRTNpdGxRNm05aWI0a28rWGxUWlFjbmY2czVWQ2lDU0tnNVdVRFZn?=
 =?utf-8?B?Qmt2NTJoN0RjNlZuOG1wR2dBZWxUVy9zM0NmQkdENUtjRHk2NUJWTDc4aXUz?=
 =?utf-8?B?MDlKYnZET3FWbEJUNEJ3VVBUZldvektZeTF2QU9OSlhkS0laeVhFNysvb0NU?=
 =?utf-8?B?eHllWWJsQytZcU0xdmZzWVl6eFE4a2pVZ1lSZmZBU1JYL1VuZXZTT1hpeGkr?=
 =?utf-8?B?emNueHd4OG03dkVzb256SWlsSnZtYlJjWjhtY0h3YS9OYzBtd0JNSTdKOTUy?=
 =?utf-8?B?WC9tOE5Cb0l3Mzh6cFF5UlNkcmlWQTZ2ODF6QzZqb1BET1NVK1ZtT29NTjJ3?=
 =?utf-8?B?bzJFY1AvTFhiYnUveFgwL2VRSHVqVkt6TUx0WHprWk80Yi9ZRHdhVnlsNVJm?=
 =?utf-8?B?Y09Rcnl0NXZTZDI3aS9iV1BvRVpiWTE4Zm9aWElCeitMMVAwRG1aRTJzY1dq?=
 =?utf-8?B?K0NseDRPZjBYVVBMWUZMVlJlYTBpWkJzaEg1YlJPTFl6ZXZQV0xTWngzMEpH?=
 =?utf-8?Q?WaHDvuyDOifuov6diq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177feef7-2739-4303-0894-08df12886d63
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 17:48:47.2142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jt9d/CPyicV1Q82kPfKzROA/TSSiS6vQdkcf19+cvMqcsxGwdLaiVF1qxT9/uq+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156
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

On 9/14/26 17:25, Lazar, Lijo wrote:
> On 14-Sep-26 8:24 PM, Christian König wrote:
>> On 9/14/26 16:45, Lazar, Lijo wrote:
>>>
>>>
>>> On 14-Sep-26 7:30 PM, Christian König wrote:
>>>> On 9/14/26 15:56, Dmitriy Chumachenko wrote:
>>>>> The reg_state readouts return szbuf bytes but never write the pad members
>>>>> of the headers and of amdgpu_smn_reg_data (and, for pcie, the fields
>>>>> skipped when the upstream port or AER capability is absent). The sysfs
>>>>> buffer is a plain kmalloc(), so those bytes leak stale slab data to any
>>>>> local user through the 0444 reg_state attribute.
>>>>>
>>>>> Zero the buffer once the size is known.
>>>>>
>>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>>
>>>>> Fixes: 081a6eda2b25 ("drm/amdgpu: Read aquavanjaram PCIE register state")
>>>>> Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
>>>>
>>>> Good catch, but stuff like that should be handled by using kzalloc() instead of calling memset it manually.
>>>>
>>>
>>> It's the default sysfs buffer allocation which may not be used entirely by all drivers.
>>>
>>> The concern in this case is that driver is telling it has written x bytes whereas it could have left some fields unfilled in the buffer. I think the fix is fine.
>>
>> Wait a second, is that because of messed up padding in sysfs structures? That is usually a really big NO-GO for upstreaming.
>>
>> Structures returned to userspace must be padding free, see the tool pahole for how to double check that on different architectures.
>>
> 
> It's an explicit padding like below for alignment. Those fields also could go unfilled.
> 
> struct amdgpu_reg_state_header {
>         uint16_t                structure_size;
>         uint8_t                 format_revision;
>         uint8_t                 content_revision;
>         uint8_t                 state_type;
>         uint8_t                 num_instances;
>         uint16_t                pad;
> };

Ok, got it. Yeah that approach is perfectly fine.

But we should still us kzalloc() or at least do the memset at the IOCTL level and not in the backend.

Regards,
Christian.

> 
> Thanks,
> Lijo
> 
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 8 ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>> index 72ea37dbfea8..0086de0f685d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>>> @@ -610,6 +610,8 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>>>>>           if (max_size < szbuf)
>>>>>                   return -EOVERFLOW;
>>>>>
>>>>> +       memset(buf, 0, szbuf);
>>>>> +
>>>>>           pcie_regs = (struct amdgpu_regs_pcie_v1_0 *)((uint8_t *)buf +
>>>>>                                                        sizeof(*pcie_reg_state));
>>>>>           pcie_regs->inst_header.instance = 0;
>>>>> @@ -702,6 +704,8 @@ static ssize_t aqua_vanjaram_read_xgmi_state(struct amdgpu_device *adev,
>>>>>           if (max_size < szbuf)
>>>>>                   return -EOVERFLOW;
>>>>>
>>>>> +       memset(buf, 0, szbuf);
>>>>> +
>>>>>           p = &xgmi_reg_state->xgmi_state_regs[0];
>>>>>           for_each_inst(i, adev->aid_mask) {
>>>>>                   for (j = 0; j < xgmi_inst; ++j) {
>>>>> @@ -776,6 +780,8 @@ static ssize_t aqua_vanjaram_read_wafl_state(struct amdgpu_device *adev,
>>>>>           if (max_size < szbuf)
>>>>>                   return -EOVERFLOW;
>>>>>
>>>>> +       memset(buf, 0, szbuf);
>>>>> +
>>>>>           p = &wafl_reg_state->wafl_state_regs[0];
>>>>>           for_each_inst(i, adev->aid_mask) {
>>>>>                   for (j = 0; j < wafl_inst; ++j) {
>>>>> @@ -902,6 +908,8 @@ static ssize_t aqua_vanjaram_read_usr_state(struct amdgpu_device *adev,
>>>>>           if (max_size < szbuf)
>>>>>                   return -EOVERFLOW;
>>>>>
>>>>> +       memset(buf, 0, szbuf);
>>>>> +
>>>>>           p = &usr_reg_state->usr_state_regs[0];
>>>>>           for_each_inst(i, adev->aid_mask) {
>>>>>                   usr_regs = (struct amdgpu_regs_usr_v1_0 *)p;
>>>>> -- 
>>>>> 2.49.0
>>>>>
>>>>
>>>
>>
> 

