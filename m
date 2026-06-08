Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E11CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C17810F8A4;
	Mon,  8 Jun 2026 18:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1b/BtVIq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E0610F897;
 Mon,  8 Jun 2026 18:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt8HBhecfJEIfaJXn2T+wmvno+UA/5BNAMFwfnFnM0oXMBT4I6BEMJj7fwKoYBfM8luvD/17YLnp5CJYUUYqz8KEV0V0ZLfOnwQOven1N42maoUWIE6YafBpUB4twAZQVhX3vIL1HpvMaJfVFxzkkPAfxjeOM/bK3DeJaT/th2xJVKGryQKoYpigGVjk6G14Xe5Ji1gh17G/XP92rLlxejh0+gmEnxeKIMbtFQVGxPIts2YVJbqzY2VpEPTZuwGlK/yeS5Qafvs5I5hhkuwWzl6mZ7bjSiU2JD5/hiFUZt5r1oUZ/eMDk4Lo32HVD1bTwVj8hxUbcdjOqw0Na/bKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg2N5128AJDZDGyXHMIjMDUtidBAZnI+luDEzTg2nwI=;
 b=dX/KpCbmVXjQAx6mbplsfVxFuRRRJ/iM38KVcZ9TF6zt0UFzttXvgQ8jHfli0+rF6+gMC5oY3+nu+c6mQMtV2tW8tybRKL0rHBUmpsdESa6HmDR+j5nFxTX8GjcSTwlbgzIQQ6IcT4Wide/GNHw6+ODYGoRcDlUmMUTDUE3nXPrrBwQwKva8lKIM2lcaNlkgH784bqfdQkS1t2okJNq4F0WBonsNSEEriCN4PXIUUDqvFamR+W7R4cN0zg20pF/E13RH9+jAYtQtfKmECTwSFs/qXL9Coth2JCvLUW2com5ud5/iXHqLan7IhQSp/Yp9T82IEUs4QbNu800XUde9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg2N5128AJDZDGyXHMIjMDUtidBAZnI+luDEzTg2nwI=;
 b=1b/BtVIq4L5QcQSpwp4CtSZhlAYKaNsk5QTl1f5b/7rnLAmnD5Jmpnl2457NK6Tp2b+M/Y8+4ith5Fkx6rU1mGCt8+mKQySJEQv1hRxgl7eFr7+hndjM2XO/pKh9F+nL0ujmztIvM7j0jkxGGkoyz2AkJFVdvNCLFCdaRGZchvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 18:34:20 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 18:34:20 +0000
Message-ID: <556c53d7-0519-4f8a-a9b7-32094b573ee0@amd.com>
Date: Mon, 8 Jun 2026 13:34:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Avoid using zero AC/DC brightness levels
Content-Language: en-US
To: edson drosdeck <edson.drosdeck@gmail.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, Wayne.Lin@amd.com,
 timur.kristof@gmail.com, superm1@kernel.org, aurabindo.pillai@amd.com,
 ivan.lipski@amd.com, chen-yu.chen@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260526210048.1162477-1-edson.drosdeck@gmail.com>
 <4ebe7f6b-aa32-4441-84db-1b09cc69c075@amd.com>
 <CAMSsBRw16QVwXCWWq0aeoKcqe9soBF9x_un6fGj5A4P+iVCv-Q@mail.gmail.com>
 <d4cfb50b-3b70-4393-9d95-04566767c778@amd.com>
 <CAMSsBRxR9Ar6p0qyutfMcCmJb7yLUNwE-CRh1JHKa-PZHHzRTg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAMSsBRxR9Ar6p0qyutfMcCmJb7yLUNwE-CRh1JHKa-PZHHzRTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::21) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 9452d504-83ab-49f9-e463-08dec58c8de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: AydKnoQNsEWWv3R1hKBaVucD9DSbA1h+tGnwrDhU/wHxGdCmwafwB1LsKNsgwZIbvpIXDY2bfJ3Ccv6c7pp0baXYhZ8hebCZhGuVhRppvQvGsJyK+UkSW0cDjWJps6TaSBNl4E9D/wbvGM8vxJpi27jnIPLOmYrkagF6GGcZa8PFTSqev0vMzGlO7ZjVntSS5ee9Fg+JM2uFfdkNrLhZE58oQaiI2XwkSgKtX+3T7Sxy2vjCF7lgrXyXjtJTjIE4Ya+y1EV+AtS1PRBI8EcODVQhFIURp6ZxOb+I2VHlbldS+7HfYCZ61sW+KSJ/85E/RbAvMQSg5cjl4Ufiu2LIXJ6xB6jtj1WxL5SIpmXmTDU7A/0I8CQDlE9U798mIf6XzaWUF2oU0ERPHCDjEFfJ7rhhG/fJHN8MmpSmNw7lylS9aHlsrMdL1RDOBqh5eVLVamhnxp2AppWYcmAEm/Mni4CYcN+JfkEPSC0pHAZ9BgtAn6vhMFlsB17Lgf0tZhGArCxQzlyBLgYm/rQmfv+uBP81++AkUN/dqcOfQYpvKBJc/lh3s0JcW7Tph6s8cvBiYTGAOquuTiUM/ikCKgzhnmcfugf7KC5YIYOO334bUvzKWk/7U+KMgzBwLXdhES0AhJgZbe5FVRfqi59SXgMT+ni57nDDn2szkFUD8LuEdkZ+oNZ7LSwlsQcEQf268oQD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdBS3R4TDNvaHNhdEJSOFV1aXFPY1lSK1lGYjBoM3A0L0FGVDFiNHJ1Y3h0?=
 =?utf-8?B?TytZRGpDT0NObFdQd3FIS01UVGl6SjdNZmR2eU5QVFU1SnFMZGFFK0MxVVJs?=
 =?utf-8?B?dSt4V1JoL0VRUXdmNkxHZGh2T1k1YnQ0TFIvUUxDdm4vN1dMZU9XV2ZnUU8y?=
 =?utf-8?B?K1lIVWZqeEtTeXBNclZRV0RoQXNNU2pFOHlNL1BubWtmSk5zNW9Ua3RmcXRH?=
 =?utf-8?B?eEI1T1htd01mZ2pvY0tOQWFIeTFJak90RngzbUJHV3U4cG1FbnhrRmdSbGdt?=
 =?utf-8?B?d0t3RHNnZG93UThBSFhkUWhiakRIcGQvVURTT1YyWHVQRk93MExBcXR0eG9I?=
 =?utf-8?B?cGJHNEN1VmE5TWF4R2RHOC9RaG1XT2lmNjZFelV0c2FpaFZ1OVVFRG1QaG1U?=
 =?utf-8?B?VmZKME5WNG1hcGpacVZ2aWJjUVV4cUFCWUtJNzh1eTJ0aFkwS0QycmZjUVVS?=
 =?utf-8?B?Y0liaHRzSGhvNndLOElYL1pzdUw1RVdSZG84dTk4V3dSWFM0bm02Z25wSTVG?=
 =?utf-8?B?VW03QlJjb0czZ3MrbVFTeE1qV2JLTGIrR2w3cVE0M1FubGxvQS9kS0pERFZ1?=
 =?utf-8?B?MFY1NjVJVmtveGNIVmNpR3pZRFhPWERVbm9jMDZmVXg2WlovZnB5Nms4WXVl?=
 =?utf-8?B?TCtZQkJ2aUJtczE0OFlGU3JCS0FlSzh6NUxXbzY0LzY0NHVEaHlCaWUvU29W?=
 =?utf-8?B?bEVwTjNtSnU5L1FrNUsvaDVERkl1T2dvTEdZaWl6VnR6N3F5c29ldVppOTBi?=
 =?utf-8?B?T2IxT082V2l0eUUyTVlHaTk2UU45aGZNamF0RlVBaWtjYUJ4Q2duQVdqMHpr?=
 =?utf-8?B?RFdUK0NaMU0vaFN5SE9nLzJnOUVUQVExNHlmRGNXeVhPK01xZExNQUt0WS9q?=
 =?utf-8?B?NTVkQUhUVnN5YkZXOE5VS0xuZzNBT1ppaWVBK1NZMHpUNERaMnFoRGFMREVX?=
 =?utf-8?B?cVVhTENxWEpuVjNUbnh6UXJHckJHdm5VZTFHRklpeEcwcEgxWjVadGFjU1Zu?=
 =?utf-8?B?RVFjM21WWmZlRzNTQVg1RUtqR2ZWT1BuUW1UNUhEa2tBblVPekVGMTNzOFpP?=
 =?utf-8?B?NHV4M2NaNVZQMlN0MjV1SXBHai9KR3pZRGhVd29pOHNaWjg5S3JBZzdFNUNO?=
 =?utf-8?B?RVZ2MFF0MHdQejc0Vmw4ODV1b0tEa3h5TFd5ZlBYcW5HTEoyQ2hmUEp6TVZs?=
 =?utf-8?B?UzZoM3JDQ3pJc0hxQnFwRDFyMDVZVnNTSVhvK3Yycng0RS9NYkh2ZXFXSjRi?=
 =?utf-8?B?akRBamZQeDR3djNINHMxSHJUM0VCb2dMRndxKy9SQm1BVHdGS3VOeCtKdTk1?=
 =?utf-8?B?Q09aL0VOcmlueEZ0VjNrbDV5QmZFYjY1aG16dzRTMTlFZklHVjBRSS9tSXp3?=
 =?utf-8?B?aEd3STFteHdBTlcvVCtwY0ZBN0djTzlzYXA5bUdkRytkbmN0bTNFQ2tJUVlT?=
 =?utf-8?B?djcwWGZZMVpGSkZ5bXJ2RktaOWVrRm1CaG01TkJDUlZqSHNSSU0yUEdnZEZq?=
 =?utf-8?B?cEJmUzVuRndJUURpNkgzT3UxODNjMTBPeWwwb1ZkR3ljdzhMR2N6QllIVDlN?=
 =?utf-8?B?REdTd2l2N21LRHJ0OVFYWnpraU5FSGs5eXJmYTBUT29obTFsWGJYc1Ntek1x?=
 =?utf-8?B?SHpIditmcUpIR01OMEF4eUJvM0JRMEd1RzBoMVBYYnJSVE9oNFFHcit1d3li?=
 =?utf-8?B?K21hL0czdWJsTVFvTXNjdFYwTFRPWHlBckpWMWNBYVFPWWVsaDhWMlBFa2VQ?=
 =?utf-8?B?OE83dHI4WWt2RDJ4TE93VU9MMU9EK0tIMjVibTU5Y0VpSVZXUzZFbFAzTjFD?=
 =?utf-8?B?TGcrTi8rWEc5QTkxZ3l4ZjU0T21Na1BvNEczeHhmYmZRcDVmZ2hEQWx4cHd4?=
 =?utf-8?B?dTBrM0poQTBsKzRIRmpBZjBMSWJsQnFEeGZzMDZ5dWZlK2MyK2Y0bjVGQ3hr?=
 =?utf-8?B?VzVXYmFMWXFSQ2NHVVlia3JpU3hkeVg2ZGoySFdMWGdrVDY0OCtHdUhnQ00r?=
 =?utf-8?B?dlJxbjFLbnVGa2lOVERYVkpONkJsZlZMdmtWMHNKdXo3NUpZZDN1VGh2UGN6?=
 =?utf-8?B?NXIxOXYydkRSQXBxd01FbmFUa0ZXYkJ2UCtwa2lFdjlFZ3g3V2t3UnhVMmho?=
 =?utf-8?B?V01BaGdWR0xUWitmc2I5bVhWOVVKem4wNEVlMzZ0Yk54eG9yQXlIUGZtL25r?=
 =?utf-8?B?UDd0b1VWWk95K2JHZGVqYkVMS2tuUi9RN3V5S1cvMUNPSVZpeXJLNlBqWUlX?=
 =?utf-8?B?QzZoSVduUU5jSEFab0pLbWx0TUhVTnVpZzgyZVVLNFpjQTFYZGRJT3J2czhO?=
 =?utf-8?B?b1lWN01HVHNEY1ZNc1ZhaTlqUGFxcTkxN0xUQ3FmQnAzcUVRM3VhQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9452d504-83ab-49f9-e463-08dec58c8de0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:34:20.1566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwE4jDAvCNhZ28GrsH4FTMYtm/SSXbrIIEeCsL2UPC2T3urnKRWRqwL3ukj4Q9CTU0B9GFmlom32BM6qS+/e/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101
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



On 6/8/26 13:25, edson drosdeck wrote:
> Thanks for looking into this.
> 
> I tested the proposed change and it fixes the issue on my system. With
> this patch applied,
> the initial brightness level is set correctly during boot instead of
> starting at the minimum level.

Thanks for confirming.  We'll include something like this in a future 
promotion.

> 
> 
> Em qua., 3 de jun. de 2026 às 16:23, Mario Limonciello
> <mario.limonciello@amd.com> escreveu:
>>
>>
>>
>> On 5/29/26 14:13, edson drosdeck wrote:
>>> Hi,
>>>
>>> Please find attached the requested ACPI dump and EDID files:
>>>
>>> acpidump.txt
>>> edid.txt
>>>
>>> Thanks for taking a look.
>>
>> Sorry for my delay.  I looked through your acpidump and you don't have
>> an ATIF method (which would indicate preferred brightness values for AC
>> and DC).
>>
>> I had expected this case is handled by
>> amdgpu_dm_update_backlight_caps(), but it appears that only sets min/max
>> not ac/dc default levels.
>>
>> Can you see if this helps?
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 832223c06b3f5..e2831bf48eaab 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -5213,6 +5213,8 @@ static void amdgpu_dm_update_backlight_caps(struct
>> amdgpu_display_manager *dm,
>>           if (!caps->caps_valid) {
>>                   caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
>>                   caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
>> +               caps->ac_level = 50;
>> +               caps->dc_level = 50;
>>                   caps->caps_valid = true;
>>           }
>>    #else
>>
>>

