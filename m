Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30226FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8522310EB6C;
	Tue, 28 Apr 2026 12:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5eSLDIpp";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFDC410EB61;
 Tue, 28 Apr 2026 12:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2VFmBFoPtH23XZpDv4DwT4+zPEGYv0Eyot/O9pj6b6NZzHp3ADfDAWDxYglmCKtMTEsLsTsZ55ceoCwbCkTzE4jXCPrSRj5b5kyTvhRFYlGJR2xMqGh0cHforj4Zgz61pPpazN+C4qTfqKjC2aJ8Tf2QcBviXQgl96A6H2dCDflygFh1Q/wN4vRKQiOFtNFj19risvpVqmVN64/z5hJsvAaU7ZSvriuLbjSlWxKF2+Kih/Kezbuj4MzBVNWMK9IWJnA+FsrsPjCz5dzUSm2rN5qLRKsIgecOfJMpgIUIak1GPNzs8KAetJQlLupB+BpNHZPJ9UC8SWoijtXuVkUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUqcCTlqnNkjX9TfMAwN8EmoA6eLlbMrg15ahyjBm9I=;
 b=BFofDGO+ZfHqyyobfIzatwke1T9qDkdbvWUmhPSFkRXiqh1UE9kVwd1kzNMS1SrBegViCUi9KTtGU6EpLzda4pYDSa1S5YZF+tbc+0gxhaxz83joAEjTYLh7Hq/Mwl3rMSa4J5kwFYnz2JbSRhZMTep5fs7SRVmaHkLXxQtHmsjP8RN/9N9bTbNVRuuUWefjjF981sL0NKttdc6wnOEEHcUMFnUl+VgP8Vjtc5iCg5JFecF06zzV3NbDmceuI1qWBnRnNWiNOZtiTB/zV0yP2KeAnWc/E5pjJZIA4zUH4wwGeZnkzs1gTNxoVSKZSkh/12AtdrrCC1kh/tEELf9QfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUqcCTlqnNkjX9TfMAwN8EmoA6eLlbMrg15ahyjBm9I=;
 b=5eSLDIppf+Uq9jUXLOCW/koLoF00uo/dEXsxWcQirHIXgYZEFrWKTYpINwYrWE4t+lg1F47xZe82unZgGD/RqApxuCyHDfzqGLhTSIPtl4D7b1lRgGtIpFrfh8waAJaNA8rBwLrLCKd4lGIUSV6GxAvtaWnXoW0qn5oQZ40oaxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS3PR12MB999240.namprd12.prod.outlook.com (2603:10b6:8:38f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 12:39:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 12:39:24 +0000
Message-ID: <40fb2437-4f4a-45ce-85a0-313436c8bb2f@amd.com>
Date: Tue, 28 Apr 2026 14:39:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix error handling in
 amdgpu_xcp_cfg_sysfs_init()
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Ce Sun <cesun102@amd.com>, Kees Cook <kees@kernel.org>,
 Meng Li <li.meng@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260428114521.364863-1-lgs201920130244@gmail.com>
 <a5bbcbeb-b2a2-442c-b2df-7dbfef8bf442@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a5bbcbeb-b2a2-442c-b2df-7dbfef8bf442@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS3PR12MB999240:EE_
X-MS-Office365-Filtering-Correlation-Id: cd385632-6fdb-4954-c2e0-08dea5232d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: oXdT2F406Su6vTmiYdD6/YKb2CUa89zyekg4z8Pbi+7xKku33Fi6oXcXNaKGQ4oOdJiUwHmbXv1RgdsfK7wuqX82nJIbiaazvJbtAxuU4fQBEmqM4wFbeA+tZ2FxrCcBk+vrzeN6/rO/HRKI9WCFy4vCIG08+MiZ8NR7J4w5X3Cm2T8qNAJyjbwvsNl+x0YOEH0pykDXAD4cG2mkkgcqCV3x8ZFOjsm27rQX85S1D0OuYrlX/T4GWAEidWeHMxdnfiG8fDNNhl64qzVqaP4rbswG394kG0E574b5P0Xrtc/Y+Rkx3vIXkAxRUCc93QjFE44XZwbW7K6dXrrTx+n8g4zjiRmt0ph8Ixo8F+iFJgP5xtgQDT/O1uajHLE1keMMpWsnEMUHZsrxmEpMuhpHQKJAI0KK3YxMU+z9bA01TrOlh2cs/cjvbMmtauZFO9Zjd4VxcJ0l9BPwEK8uEU08Cquwr2y7yC2wOy0YnBPFInVElFN8aLBDXK71vkNXsZzVBmGR40N8xC86NghsOnv7yldaSQQDI+X/0mP/YwW9ZyTErmIm/eEahQo7uNH2BpW4LoSCEkmufpJBC6njLp43naUpr3XUo/kVSHakEmlVoQYITFjVeYQPcM+mRpIqdyJPle+1FW2jcuAnFn4+3QTh6quZ496O9na1AdS2DiNwiduWXtuZLH3f853ehWFZSi691k37CCikTeXcI9M1n+t7cYJzB2vYaLn6vaY5493dhPqMhTMWM4GHrlXFbo9I4bc15c1DcWyqCQEsBJd27EPlbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXBOVXBGd2Q5RXZ0MzVGa29JMElta2dWaERram9yZFRnRGtad2RDRXZuL0Mv?=
 =?utf-8?B?bjVlWXlTa0RRK1dxenpiQlkxSDhWMlpsZzQ4eVFJYVdoUkQxR3pYb1ZTUjBE?=
 =?utf-8?B?bjlMSmRyZXNMVnhTYWRrQnVoL1JyaWRTdGU5Nk9ZRm1xZDBDMTZwU21uNlFq?=
 =?utf-8?B?QzEzUkgwSnVOYU9PZGQ2eVdUMFdrbGtqRVFBbTZ4SVc0Sm9WNzlZV0poMk9C?=
 =?utf-8?B?ZlU4dHQ4aGNIU2NnQzdzWm9aaHlCQzNQMGE0SXU0LzIrQ001S0Q4UUViTUcx?=
 =?utf-8?B?cTUwQVpuMmpaR1poVVVZK3EyakJqY1pDK2NJYWxrT3crS1JVK29EUTYxQWhS?=
 =?utf-8?B?VW9PS3g5bzBBRkFIb2ZHQXZTZUlXK1JRWStkaktSRTgzWGNCWW5JT0IzR3Js?=
 =?utf-8?B?ZzdGcEx0aWtJUHcxUHYwTDRwTFZoaTh5WE9WTHhDVnlGU3hYTzRONTNXQ3Rn?=
 =?utf-8?B?c1lONjRRdUhEdzg4eVFzWWcveWN5ZTEvQnI0d1MrV0d1M0RQc2lBelBYS3pZ?=
 =?utf-8?B?eWd3blFjenFqSVdGV1RzckJsRVJja3RERHR4ZWpGbVhxNS9hc2M4S2dKVjFS?=
 =?utf-8?B?TVltWGE0Ym5BVWVidE4zWjJqeUtxTjB0OHRBTzhpMk4vb1djM3JmVWlVUU9X?=
 =?utf-8?B?Y1ppalZEZVM1dHV5N29MUHFnUDEyaG1JU3RsTjlqWEtCM3NSdW9wRU9UUmlJ?=
 =?utf-8?B?N1pKeDZGcDdoTTQ4akZuZGhib2pkOVdOQTF1MEdoSGNXUFBRNjd4Rlc2N1hC?=
 =?utf-8?B?NGdGcEY4ZVpZTVBmTzMrVWJQMVZNeWlPSGJsK1NjVDhUMzVLakxha2R0eC9J?=
 =?utf-8?B?NDNKNDlrVnQwZTBFU1lTSUtvcWlWdjYzRHQ3bVkrY25jbUVVWWRhejY5c2Fp?=
 =?utf-8?B?MXFGaThtSWxMNGlMS1BiSnowMlNwdkJwZ29naEpzUGJ4d0VtSExHTGhYL2pz?=
 =?utf-8?B?cjB2U1djTXRKVi9CaWkzWHdNNHhWaUNsL2EzNGgrdmVGS2Y0eGtVMGZDMUk3?=
 =?utf-8?B?UVhud3B0WmNLSk5aQ0grb0VOWjhXb3VGZEZvVUh1R09WSmZoT1JaUWttRVp2?=
 =?utf-8?B?Q0E2NzZjUDY3d0lNZVhDOXVrYkxEK1JKR2pEUHpqRm92TXpkak9Hd0J5QXBZ?=
 =?utf-8?B?K0psSmQvOWVSNFN3VFRRT203L0lBVlhZdG1MQ285KzYrZzk3NTd6ZzFDWWxq?=
 =?utf-8?B?L3lWU2VMUXl6SGI3c1d0c25PTmE3NHJvTE5VN2cwci9IOExJbGQvREhKczFz?=
 =?utf-8?B?b1E3MUJHMjZKWWh1ZFBKUkMzUWFnalhUdWVFZGtURTJvak1LTExBbHg3Smlu?=
 =?utf-8?B?M2NqREV0NXptZUpCQzdMdVVpeHo1WStxWTlIa24rWWZTczlQNmtYQVgwVHJR?=
 =?utf-8?B?R0IwU0hkWmRGMW9xSFpCMkNvbjVkbWZPVzR0OHBGWU8rY0g5OVNGS2drMEtX?=
 =?utf-8?B?Y0orY2VFQ0dRTHc0ZzZWZVNReGU3M25iVFY1bTBDNXFhRjVGZGxJTisxT21N?=
 =?utf-8?B?VmZ3L0tMT1dDVkZvbE5mY0FRc1I0QXlEK2RpRWtUTG8vbVgvdWFQQU1VK29H?=
 =?utf-8?B?U0trb2s2cGFiREl4RzcxYWtSRTlGbTdTRzQrWGZVa0E4Y2NsWVlSR3Y0MEtk?=
 =?utf-8?B?QVliV3Y0c2RUdk91eUlqSVFoczdxVE84NzE5eUtyZ3lFVXpjc3BEbUNzbEZW?=
 =?utf-8?B?ZGpabWVaVWlVRzBFeGdrOCtQUnRRNFNXdW9LVlJZbHVjRmh3YXdDeC9yVThi?=
 =?utf-8?B?dEc0MU9BK2xyeU5RS1dOdFZNRzVPZ2NoWGlMdlh1SUo0OW04NEJpM1Nka2xF?=
 =?utf-8?B?WDhZZk16OTY1bko3ZnVrcTR3Z1cxMXluTEZKQ3laTXZ3QjFZcTVVN000blVy?=
 =?utf-8?B?dS9jajQrMXFldzE2dkZtdnlPZy93VGtCUHRPSXloaUozZ0F3N29JYS9vWEJx?=
 =?utf-8?B?Q1Mxbnl2SEJlMDdFcWZZWnFvM3hTSXRCUWpVL3Nnem1TSjRGc3Z2QjdBOVlm?=
 =?utf-8?B?VWxrd0NnbytIWTg3WXhYVkJSQTdCZCtRUHpGRHp0SVdzNG9kZzh3VWcraUdN?=
 =?utf-8?B?YVBHVW5XYlRvS2tiMUZES3hYc1pLMWhReGxYcHpuTnJqYjd5ak9IWHpFWTRn?=
 =?utf-8?B?emJzenJKNXVuOHdtNWR0QVBFcHBmYXRSSEFYRXg3MEtvQlE3a2QzdmdHcElu?=
 =?utf-8?B?bjFESFIyU1ZQVitWYkRsUjdqYTRjRVVqUjh3ZWlVMWlmaEpPWjlqcUd0MTFm?=
 =?utf-8?B?OU9QakFRbWNXOVJ2WXZiUGpmamVsMEJqUjIwRFdhYVMxdmR2ckVISU16cjhD?=
 =?utf-8?Q?owEymofDtGuv/eWD79?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd385632-6fdb-4954-c2e0-08dea5232d54
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 12:39:24.1564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wMXq68/hrEYKTZmHAkdk5+XD+rMDlBRWARdth1hOEgrxyNt7hPRiy6Ib1lfnaXL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999240
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

On 4/28/26 14:10, Lazar, Lijo wrote:
> 
> 
> On 28-Apr-26 5:15 PM, Guangshuo Li wrote:
>> [You don't often get email from lgs201920130244@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Once kobject_init_and_add() fails for an XCP resource kobject, we
>> should call kobject_put() to decrement the reference count for cleanup.
>> Otherwise, it could cause a memory leak.
>>
>> The error handling loop also uses xcp_res[i] instead of xcp_res[j],
>> so it fails to put the previously added resource kobjects and may put
>> the failed kobject more than once.
>>
>> Fix this by putting the failed resource kobject before jumping to the
>> error path, and by using the correct loop index when putting the
>> previously added resource kobjects.
>>
>> Found by code review.
>>
>> Fixes: 4ae86dc87850 ("drm/amdgpu: Add sysfs nodes to get xcp details")
>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> index cc5f4e01e38f..315e33a9d7c9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> @@ -948,15 +948,17 @@ static void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
>>                                           &xcp_cfg_res_sysfs_ktype,
>>                                           &xcp_cfg->kobj, "%s",
>>                                           xcp_res_names[rid]);
>> -               if (r)
>> +               if (r) {
>> +                       kobject_put(&xcp_res->kobj);
>>                          goto err;
>> +               }
>>          }
>>
>>          adev->xcp_mgr->xcp_cfg = xcp_cfg;
>>          return;
>>   err:
>>          for (j = 0; j < i; j++) {
>> -               xcp_res = &xcp_cfg->xcp_res[i];
>> +               xcp_res = &xcp_cfg->xcp_res[j];
> 
> Good catch. What about just keeping it j <= i? Seeing only one path to get to this error handling.

The usual idiom for cleanup in loops you will find in books is:

for (i = 0; i < N; ++i);
...
	if (r)
		goto error;

....

error:
	while (i--)
		cleanup(array[i]);


The while (i--) looks counter intuitive on first glance but is actually correct.

Regards,
Christian.

> 
> Thanks,
> Lijo
> 
>>                  kobject_put(&xcp_res->kobj);
>>          }
>>
>> -- 
>> 2.43.0
>>
> 

