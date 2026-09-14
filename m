Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0F4C88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85ADC10E1C6;
	Mon, 14 Sep 2026 14:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1bt1JA7E";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B5F10E1C6;
 Mon, 14 Sep 2026 14:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S88+k8Z6A6CKOMOqRmsI13olHkKKSpC5lybhar9TKzKmeVy9PRLS4/EUl2ytbO3A8dQtc9Dbcye9bkwAwbzOMqFQ1nVyuQj2E6tm/oQfftRqwCR9y+M8tBibah6XisHjKN844bLSIweCv1+nB8afnrXmq/UOJDKZNU5AdGNOWjcsd2Vrb0bwDSeJn1Rke74APXN13ZdE/kA0/qzfcYqP+Zh/vVeVUeHBhKvM5V/haoY8qD0j7kmpm07V2KGySVKvuv9JCMXL7Vr+btzUKa6mH7hdO0uoCTJGFcLeHdNtW7FRaVcfPLNeyjVDP54tMHnA4uPyrJUO68zsz9JQZ4LA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMYQA5hqkANy0qe67m4PQri4ZQlVrXu1IijAy+ho67g=;
 b=wkh2IZeXBFTaGo+POGfX44xbK9eWQBf+Mp1SRBTN28t+fn4HN9RuKmflTnvpVYjB5KOKgXfSZJ45EBl17wAF5ea9a/+/mjyuj7VQs7lIRZR+25/cAWCgAhrsoBVPXdWGKPRCcOQboWJZyUVEz5yh50D0H94w6/ALbo1Wz/PkGLcwTYMVa0TE0B6v+H5sLIZoMc1IfAutUTb8uG/tk+Lya2AOl73DnYOVTZUHeAESwrv+XvWnTHWpc6yKFMV+OulHF0v0aGh24IIh9tjzozo41mRHdsZdBcP8y8vP+Na3E5OT5PIElmqioS1HGOkyLkXLVbruPpZBJ+L6rK2A9lOvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMYQA5hqkANy0qe67m4PQri4ZQlVrXu1IijAy+ho67g=;
 b=1bt1JA7EUfOMDU60qDkaykDstzPRzUAC0NelOtgcJkBAAdF2tPAB3NIyCJHufzf3fMyqaEjjhk5HRsE5hdu3lOr2o3HY/2aTThapPqSbh+0nnbcOysR7C3zS6EeoBih7mWJNs7wP8JulYbo0UVviMlOszoRbrKVLlyib9UWvVG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:54:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 14:54:47 +0000
Message-ID: <aeeff331-8b2e-41d8-acf8-d5d758935d38@amd.com>
Date: Mon, 14 Sep 2026 16:54:42 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <05b669e6-1c66-4789-9916-b8030e232385@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:23a::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: c86af5b1-6339-4bc8-1902-08df12701edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +iS3BFLHJeucFKuQopg/c0MNTCY362bwWjov+MIQXiC1x1g4Ap0Urtk4F0RjeQXbx+Ifme/q+geS0fyZF0REuxTCsan+FwIvutUjfEOGZZn0lWVQRM3BjMiX4HVbp6bDjdytcJr7uPMl+mtoS8Afvh80PJS0W4bd9XI2MJ35DEWGdRXzS+Ad8/rK5xXR0zw3wbVXTiwIZz+iI+8W7RZnmP08J/qaiKjGbvjPgRx2v8NsiBFRJ8g1hSKnBikpUh1BvTkxfDKJL//5fN7d25E2VPNCr7Ug6phCqmojKSzo3yMxlahrhwRLTM/fgILbklyoo9V8pmq5f+7PAZprNBnYmmxyrPoBZ4G7kN4TifT/ChazpWuhV/8+szp5AYbrX7W3Y3BiyB0cCHj2QQF+cuIRjS/mCnHcYIxzvkzW1hPTPVQK5fgzjlzYLSzNc4kJlXqg6aJk/w4jJBbKKbwdyfGi3INl/NVuXJkXt9NXuWKAP/fH+KIZrCYTVtsHLTPEKkmB1vhOvS2g6ePgCJWetDkzMXi67KYCyBKgs7D9Oue/flpaKiZGfM60OT+h8h/COsZId2iJwOFhAUnuDxwOHh5Z5M5rXGID9FlxucSl/GoCtPonu2LCGmcvpCSYEEhiEvrrnl/K2EYvfDCq8fg8WwDhW8NVPCflj/IXGZFelDwftOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VxT1RlL0pqS09makd5Q2JBVWtjamVzRmpaRlprdWttUE5sbStpSmo5bW5v?=
 =?utf-8?B?dWFpK2ZsbmNHVGo2a05seTAwcTU3R0dFcHFkKzB6RlY5Ym42Q1FMNEZubmZo?=
 =?utf-8?B?d1I4ZlRseDFqM1hSWWFEUHF3Rk95R3hVcWgrUUxTdlo1N3FGMUlzVGs4cGE1?=
 =?utf-8?B?ckp5NjhTN0VRcjI2ZWkvenNOdGlPTmozWlhwMGVNQVNheERKUUg0alV1Tnl6?=
 =?utf-8?B?YVNoYmxGcUgvME0xb3hUUjNSdk1ZTFNYRXZQSFV5bktEUGFlT1B2cVE4alVZ?=
 =?utf-8?B?bkxpRFpiOWJGdk95ejR1UUNtZTJNM0luMyt6aitOWmVKcWFxMzRWeGYwc0JG?=
 =?utf-8?B?Z0J4YklxSFRrbXlxb3NKdG95dUVoVHl4M3FaNGRIQ3JuNnVjT2M5OU9MdjU0?=
 =?utf-8?B?OXF3SHZ2L3lqaDY5V05sb2RKWWZ0Rm52M0FKcm5GNDhRSTZUUEN1SGUrLzM2?=
 =?utf-8?B?NWpZL3A4cjRZckhVaWpXaksvY1U1WTNVU0d1SWxab0VrYWFHUzRaNXQzUVlC?=
 =?utf-8?B?aVFYaFZ2ZzBvMEEvWkRCdmlkaFBOVUdrU1UyZDJtSGJRY1BJcXpGSjIzamY4?=
 =?utf-8?B?V0RVODVTVk9iMVRuS0RNdXhrOE12T1lrc1JaSTR5MHAzUDlpU1o4cTRrNVg0?=
 =?utf-8?B?NnFTblY4RXdSQ2htU2lySlY1RW8yQXpIQVhVZ2JYQUFtZnl3b2I2M3BzS1Yx?=
 =?utf-8?B?bitVK20yaWdpKzRjR2I0K3VNUVVOaitpYlpqUDQwWFFIZk5CWFJqZ1M0WEZq?=
 =?utf-8?B?WXMrSm92eGhwVUEwdkdNTjJZWFIzWVpIODBZUXEzOGhiYXRkazUvaWgzS3Q3?=
 =?utf-8?B?aDhRNTdGNW8yQzlyK0lJUlpXZWdUWVluMGw2aFRxczRTSndVTVIzQzFEanlX?=
 =?utf-8?B?bmRjRnRGZE5GNnFWRC8vRENFSEFxblBKekF0UDZjTGZLS0VxOVpQcE9CMmpD?=
 =?utf-8?B?SGEzNmlUUm8vSEVHTFFHYmFJMjM2YUxBYkVqZG9raE9pQlRkQTBuK1ZuV1VO?=
 =?utf-8?B?MzM4S3hxY2E3SkU2eXhMK0Y1STVmaE95L1NxSnYvL3FWRmRjRWQwbDBIRDlG?=
 =?utf-8?B?b1g4bzhzS3gyQXgyVUtGWTZTbFF2WjBsbVY5OFoxRVA1V2hEdWlmRGhpcU1s?=
 =?utf-8?B?RnhTem91eCtUUkFQZDRRdWlaczRPeitta2NaYWhpQXdQS3hZczJROG1QcXJy?=
 =?utf-8?B?MDlndThpSTFOcFhCbXpUSEpKVXNFejhTTUEzWitqRCtnd05XdnpYdStsOXJI?=
 =?utf-8?B?ZjlyaUJhM2VFNEdoeVgya2c2UXJ5aXovTGpIWENjeG1PdVpTQzVOWEhwZ0Fa?=
 =?utf-8?B?cVJaMTcreHZQRjBFVUozemFIVDVxSTJjS3VMV1duZmFoTVBRS2NCUklnZHRM?=
 =?utf-8?B?Q2x6M3FSeWxiUjUzZG9RbGRiM0tzMXpYRnlOWXIyS0xld1cwY0l1ZVlIWUtS?=
 =?utf-8?B?d3VJM3UwdjFFOGtxMlJQOEcrQ1NVSWVKaThINFVCSkIxa2VaR1EyOUdSY0lK?=
 =?utf-8?B?Nm9scHVuUjNTWEh0a01FTEF4cHlxRzIzbGcwTmhKRlZER2pnZVJ6a1lFKzlh?=
 =?utf-8?B?ZE1vcU1yM1VzQ3NaQnRtVk5ibHJSckZaMlFyMTJXa2hsUE10WVpKbG4yaHU5?=
 =?utf-8?B?dUErWkppaVRMSGJ5VEl4eEJOenNqZFV0VGlQQ0ozWHdKa3JDajc5eFQvMmJw?=
 =?utf-8?B?QzA3OTFxWkNiRk5RZUwyTzJrd2MzUVNuYmNpMWlaTGpsZmNRdjRxUzhzU2sy?=
 =?utf-8?B?cXhwKzRYOTE4bjhwVm1pcnRqVU9DdU5YZ0hKU05hSmdudXdBQ3pkRWFTK1M4?=
 =?utf-8?B?M2pSTjdSMXBseld3QkRDWkQzajU1ZW1FTmd0Z0E0VG1WR3hhRXhpdnAwUXlD?=
 =?utf-8?B?RmpFNjdLem1wbHFwMmZlRCt3cisvbHovcmRSNkFPeXJhUytRbUxNdEY5aDc1?=
 =?utf-8?B?VDNsMktldjJ2eDYrU2E2ZHhOM3prMEFMMTdEWURlMjN3MEE2cmZlYUJheExs?=
 =?utf-8?B?ekR3UkIrN2hqSG4wQ1RPSWlZU0tGcGJuUUlaU0VISk1HOXZTejJ3L1AxWEJV?=
 =?utf-8?B?b1NwS1BTdEg3OGw2bTZHaE1GOGNrc3Z3SEpTaDd0Q0x0UVR1bGJLSjkrN1hh?=
 =?utf-8?B?OUVlWG1QdDdFbUxGbCtXS05rQ1htbTh6QTBmWFV6dmlrSWNoeGhWS0tiK2VK?=
 =?utf-8?B?TjJOYkJvTnNQQzcwdVhIMmd2UWkyYTNmNWd4VkpORHNFdlNGSmFtM1V3YWZm?=
 =?utf-8?B?dldlSC9ZNTRmRGJ0UFo3dDN5Vlg1bEtMSFpUcDNjRXk2M25mdVhmdm9CZU0y?=
 =?utf-8?Q?q4M5UchEoQm+Qy8Ity?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86af5b1-6339-4bc8-1902-08df12701edd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:54:47.5539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xk7HpoyD35bfqaQuAY0lgn7PcOk/uQsGPsmR0EYP3fovONOJnwucFqHk4PDUEUC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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

On 9/14/26 16:45, Lazar, Lijo wrote:
> 
> 
> On 14-Sep-26 7:30 PM, Christian König wrote:
>> On 9/14/26 15:56, Dmitriy Chumachenko wrote:
>>> The reg_state readouts return szbuf bytes but never write the pad members
>>> of the headers and of amdgpu_smn_reg_data (and, for pcie, the fields
>>> skipped when the upstream port or AER capability is absent). The sysfs
>>> buffer is a plain kmalloc(), so those bytes leak stale slab data to any
>>> local user through the 0444 reg_state attribute.
>>>
>>> Zero the buffer once the size is known.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: 081a6eda2b25 ("drm/amdgpu: Read aquavanjaram PCIE register state")
>>> Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
>>
>> Good catch, but stuff like that should be handled by using kzalloc() instead of calling memset it manually.
>>
> 
> It's the default sysfs buffer allocation which may not be used entirely by all drivers.
> 
> The concern in this case is that driver is telling it has written x bytes whereas it could have left some fields unfilled in the buffer. I think the fix is fine.

Wait a second, is that because of messed up padding in sysfs structures? That is usually a really big NO-GO for upstreaming.

Structures returned to userspace must be padding free, see the tool pahole for how to double check that on different architectures.

Regards,
Christian.

> 
> Thanks,
> Lijo
> 
>> Regards,
>> Christian.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>> index 72ea37dbfea8..0086de0f685d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>> @@ -610,6 +610,8 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>>>          if (max_size < szbuf)
>>>                  return -EOVERFLOW;
>>>
>>> +       memset(buf, 0, szbuf);
>>> +
>>>          pcie_regs = (struct amdgpu_regs_pcie_v1_0 *)((uint8_t *)buf +
>>>                                                       sizeof(*pcie_reg_state));
>>>          pcie_regs->inst_header.instance = 0;
>>> @@ -702,6 +704,8 @@ static ssize_t aqua_vanjaram_read_xgmi_state(struct amdgpu_device *adev,
>>>          if (max_size < szbuf)
>>>                  return -EOVERFLOW;
>>>
>>> +       memset(buf, 0, szbuf);
>>> +
>>>          p = &xgmi_reg_state->xgmi_state_regs[0];
>>>          for_each_inst(i, adev->aid_mask) {
>>>                  for (j = 0; j < xgmi_inst; ++j) {
>>> @@ -776,6 +780,8 @@ static ssize_t aqua_vanjaram_read_wafl_state(struct amdgpu_device *adev,
>>>          if (max_size < szbuf)
>>>                  return -EOVERFLOW;
>>>
>>> +       memset(buf, 0, szbuf);
>>> +
>>>          p = &wafl_reg_state->wafl_state_regs[0];
>>>          for_each_inst(i, adev->aid_mask) {
>>>                  for (j = 0; j < wafl_inst; ++j) {
>>> @@ -902,6 +908,8 @@ static ssize_t aqua_vanjaram_read_usr_state(struct amdgpu_device *adev,
>>>          if (max_size < szbuf)
>>>                  return -EOVERFLOW;
>>>
>>> +       memset(buf, 0, szbuf);
>>> +
>>>          p = &usr_reg_state->usr_state_regs[0];
>>>          for_each_inst(i, adev->aid_mask) {
>>>                  usr_regs = (struct amdgpu_regs_usr_v1_0 *)p;
>>> -- 
>>> 2.49.0
>>>
>>
> 

