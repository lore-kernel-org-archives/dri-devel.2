Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E35BC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA4810E1EC;
	Fri, 10 Jul 2026 20:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EVHeUo/t";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012057.outbound.protection.outlook.com
 [40.93.195.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B969210E1EC;
 Fri, 10 Jul 2026 20:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKN/gN1vwq9deFmf+78dbctr/r7ZBATGVwupfF8D6alO9m+hZPctVYX/9hxPMERU4xK9uR4LUpYR2h4JhBOTMNFOZfvyJopRsVhIpi+0qtdpuLREjhHvLBuFvzCCB0IDPuR37MvvFfTVho3VUITXJQwsQhS853yxk6YqNdWSYWbbum7eDKzvojON3jgn6F3h3Fz/RlNRDq8/EUl2HOdaeyYr6N+cwLqKTB/bZ7eB9NGld9C1X5BDedhCkuJju6PJckdBDXRfa6ItmGeNq9gbTd4OYZwh3a2/aFoPYMAvvgueB9Crhd4vyMRZF/dmL9JyDYM99GYguZ0slcBK5nFbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW8MAzunHNNy02NiIwSIqbYKhJ6YvcSz76OOE34a+WE=;
 b=FDU5+4DRx4xFBFh1YKB2LC+R3pt7a6TLfdsXon9hHvJetulRm33W4AY4H4Yn8EUTMe1G2UeXgZT+sjXlEFzy5yh06TbXNrI8NwexmTNpJ4yAx4AX6gbBU8Cobqa7pW/e6zkr3hI70FW04wHZfv9QkP6pFp2QgZmufhZ7s1LPdUlkteUaUsaR1Gj3bNPWY7ITyI32ZFDVm0byPLiHRYWw6558iW2tnSWg1Wtz1JvsOhRSAhxBPwekScc96zqx6fp03VCFUWjzkXoSjPLrhffu7t6aJqPjSY13HxFQSEpejLzfb2hGheQEb5My4YunkAHIu9hq2T2SabrW/UcYb7CPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW8MAzunHNNy02NiIwSIqbYKhJ6YvcSz76OOE34a+WE=;
 b=EVHeUo/tVV3Zqg1EMhuoQc0O4WwWMmX+7oCWACPNBrY1XQQ8kTB80RZPCmrgQrALW5GFIe3G8DfvyA61n8iTXPTENcZK3Fhuf+1sHQUCf+ycg389SFPhnkMavPoqkn8wDDknx8RVjNXWNHBQgWUKJhiAYD5T/OeDWkxYrQtooB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 20:43:58 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 20:43:57 +0000
Message-ID: <e6f2a727-7378-4b02-9921-01a873f6001d@amd.com>
Date: Fri, 10 Jul 2026 14:43:53 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: amdgpu_dm_plane_test.ko fails to
 build due to modpost "too long symbol"
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org,
 bhawanpreet.lakha@amd.com
Cc: dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 george.zhang@amd.com, LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, broonie@kernel.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <fde3656e-9e22-4e4c-937f-7e8cb918da6b@linux.ibm.com>
 <54f6efe8-cab8-4fc8-bf00-f012b3224e54@infradead.org>
 <85931e07-60eb-4df2-bc52-773c63f27f6c@linux.ibm.com>
 <14e618d3-34ea-4bc9-b9a8-3783e2b61e0a@linux.ibm.com>
 <4ccaca42-03c0-40aa-9a4e-9b0514735b45@linux.ibm.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <4ccaca42-03c0-40aa-9a4e-9b0514735b45@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::32) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c295529-9131-4273-23ee-08dedec3f685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PSyUA9JfKK+ssXMtpWvJKXjTEQ0dpaTZJGrqDS8DLe+xAzkeCBDswqRXOVBVZ39ZksfBK7sCW9JjMHiZMe+EQIk0rA8ejAmhc8LKTMs/g5wQNYOezG3A1O1vLDG5MXKn3NvKa16CnHmjubiv3PK+IcBnQkzVDG9Ps1SR38e1Gfx6EwJTIHE+F1JmgZ8jjA9rqiG8Z+4xew61i2onibJrYaC5oPt/PyhVuuUgVu8aD2FquOSBnEcZUcgzHVZFSFcul0C5fbtmBk9E7j+9A3i9r6MoDYNqs9QgC+BxfOEkN7uD1x1Tg674A9to3uVsW4Y1NyIsc0NLSqoQVbcTZ1/jI0HLE0Oxs9DURk37048wzlMM6BKtiTlyGk7bHguDogklPkWHl+wIdexaXeDKflrHkuz1iOfU6i5Ocg0x4pXa7n8VrS+lzmA4bpuornegNtpxcZlQopJ/PWj7V4KI7Ece2ek05IdTah1YOiHxrYMiUiZLe+SdTfOG4tY5rK5dJdIvjdWGLVMiYUI11k8ONn60aNYPjQa2uT+hsb3u+HMtSq/O3LX045bt8/ziVPztPer8vUrmqi93VtYpVOMdFi0OpVKDMdJy2mluprB313hCoNeNw52Hgs+VoE6Hqsy8w9MR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vzh3UHY4U0ozaExmZy9BcWVweGJQL1VZbXp6YWZkcDRWenZrY2FITnQzK1BS?=
 =?utf-8?B?SDBrdUpBWGlxMFZKcXMwemJrVWozSitMZnc4Q2pNSEpZM3NNam9WL1phN0Fj?=
 =?utf-8?B?Q3MzTy8rMmRQcjZ4d0dSYVNYU0ZLMzdzY1A1dDJGcUlZL2hhdHh1L3I3eUE3?=
 =?utf-8?B?OGZnak55K0xEcTQ4ZHJHVi9zNVBiRzlZZHgrSkMvdFRzNURvMmE3WUp6ZVZm?=
 =?utf-8?B?VWtaU2FhYnhHWFNMWlFPbHpVQjAwc05BdnNoZW93aHhLWHI3OGFkR29WUGlR?=
 =?utf-8?B?ck96VlFFN2RZMmppeFF1clVlV1lJRElpSWM3OEg1T0RxcmZDZ3FhRzhCRURm?=
 =?utf-8?B?QVVqS0dOZWowSGVmVm55cDI3eWJtR09HV2NBZUxnODhJd242YUgra08wVTh5?=
 =?utf-8?B?a2ZsTCtRYldNczIrKzdTQVo5eDZ1d04zdlpEb0pJenE2ajcvamZDdnRteDFI?=
 =?utf-8?B?ZjUxMytOd0NPTHl6NXJYaFFzN09QQU5zSW41eWxxcDZLbldQQllGZ1JFekFq?=
 =?utf-8?B?dFZZNjdMNFpqMTdSWXNyWWNFbEtDb1M3V0dDcWlhZ3c3VTFFWUtJRXdvbWZO?=
 =?utf-8?B?VGUzWWw5MEpUQXZCRGdqZXVMYWRNK0J2N2tsa3FFV1MyeWpBUlJpcnRyMVhE?=
 =?utf-8?B?dkJrOStqYTRLK0U5MEloeDNuOE1QOUM4NUF0b2NQNG85cEVMWStYVGVBaVNv?=
 =?utf-8?B?c255cDBTNEhiSzJ0L2xING8rZDlKcVlZemtrRGRMUUUyYUNoaHRnbmtWNmp1?=
 =?utf-8?B?YmJtN1dDZ2d1OHFYZ2o1dHNGOUtzM2Q1eUV1bFdqQUYwLzJMZ1dsaGtkQ09L?=
 =?utf-8?B?QTBVN0V1UmFkNWU2WDdFRCt6dFVnVmxTRGVKaXhBSUs1YUJlZHVvWVJUZzhC?=
 =?utf-8?B?QzM1S0poVXVYM0M2Z3IxYUtGV3B1Z0Y1MlVMWTBmZ3VpS1BLTFplbDF1eHhB?=
 =?utf-8?B?SGFBL0JQTGFQVkJxdTNVVTljZGVaMVByUnlQNXprSWxGWmhsSTRSME5wdDJD?=
 =?utf-8?B?RXAybDhnK3BCbGRKSFRBVURyWTVhb0tmQytNQWRocVMzUWpiQkR1OU0xTHIy?=
 =?utf-8?B?M0Y2Ry8vVmMzSWg3SmxlTXZSTFRpNVh5V1FEczJ5Q29JMGZncUlkRXNTVnlh?=
 =?utf-8?B?TVNUekFsL2FuTWpYaVZkQVlpV09aOFMzNGJLRWxJeEV0aTFwbHcxRnlGU1lk?=
 =?utf-8?B?UDFLRExJd2I3SVpoQkpIcFU3MGxWYVl4eUJkNTgvTEQ2clYyMTRyandJeFpH?=
 =?utf-8?B?ZW5NUEFZSFc2a0gyNzNPRVlJY1B4RGphT09uN1Y1aVJNQVFWYzhSUXgzMXpK?=
 =?utf-8?B?RTVPVVB0VXpRdTF0cEoreFgyRjNTekZBYmNhbjBtZnJLV0lzc09iNFZ0NU1h?=
 =?utf-8?B?bUJsRmZ2bTFFbHBEUjFwWjB0ckcwVmhxZytqMndMaWFiNnh5bHlObWtxeUZz?=
 =?utf-8?B?ZFp0NWdCSDVvRHk1dGlKVDQyU3hxMndNaCtkaDl0QzlwK0wvSjdlbzRvRFNz?=
 =?utf-8?B?Z3JpZnJNT0t0Z0hkVHh0M1l1YUFsOEFLV3c2SGJ1UWZPTDZvQUU2U0JGWlQy?=
 =?utf-8?B?RmwveEdqaTlXaTRIR082OXVPMnFSNGp3MXRFQkVYRXJqVWZkckdjd013NWRO?=
 =?utf-8?B?cjB2S2NoeGpvS0luM0hMbmlyWEYxTU5zb0t5SnByRTcyZFF0SnZ1bis0em1V?=
 =?utf-8?B?ZTNLMDJoK3k5WGRHSWtMODhESTVVOGYyQjBlUkxKSkZ2VS9WYitOZ09DUldv?=
 =?utf-8?B?UjBTd0RlcStrMnVoRCthRzMrNWlTVk04VThjdHMvYmh1Rnd5dVZGZ29rUllw?=
 =?utf-8?B?d0F1Vm5SaEZ5bDcxWmU1YVZoc214K0U1L3VpV1NiSFZDRWxoTDJGRGVHNDcz?=
 =?utf-8?B?Qkk1REhkc08xcEgxUkFZWjdRVnJxb1dsaHFmZW1Ob3pldHB5TFJiSVpZSDhi?=
 =?utf-8?B?YkxRL0N3bTNrdTUxVWpHWTFQSE1HQndNRFhBR2xqMHhhQWNBalJwM2R2V0E2?=
 =?utf-8?B?aGNrcmhvS29UVjRQUm1NYmVVd2hSVitUVjB0V0hvcDlta2FYalIyZFQ5cllE?=
 =?utf-8?B?VVU1OFVqbUdXTDhuMndmNi9KKzJNQmlXRGxTK1QvM05Zekl6QzJpbjIwQWIy?=
 =?utf-8?B?dkVmc0NwaVZDL1RHZDlXTnNyYnZDOW5vWEdlblp6SUh1ZTk1TjIxaEV1K3F2?=
 =?utf-8?B?Z3dxeUh4Y29oaTl3enZXUUt0Z25KQ3VwSVBlQ3BwQW1KZGZKcDNyNWRBMEEy?=
 =?utf-8?B?ME84aFdiTVhtcXljMWlpUGZ1MUtNdHQ0VWlTWm05dWNsVUFJN1UxVW13NDd4?=
 =?utf-8?Q?8VdqdKpiTnnJZjNdB6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c295529-9131-4273-23ee-08dedec3f685
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 20:43:57.1014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5NMPFgSZL1FlNx0xVpKIIJIVd5fBRG+xbsNw0mClU3t9gr9qPeBRinmzazZl0JEqqAmmLrmp956/An8c2PytA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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



On 7/10/26 02:52, Venkat Rao Bagalkote wrote:
> 
> On 10/07/26 1:31 pm, Venkat Rao Bagalkote wrote:
>>
>> On 10/07/26 10:45 am, Venkat Rao Bagalkote wrote:
>>>
>>> On 09/07/26 11:53 pm, Randy Dunlap wrote:
>>>>
>>>> On 7/7/26 10:05 PM, Venkat Rao Bagalkote wrote:
>>>>> Greetings!!!
>>>>>
>>>>> linux-next is failing to build for me with:
>>>>>
>>>>> ERROR: modpost: too long symbol
>>>>> "amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers"
>>>>> [drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/ 
>>>>> amdgpu_dm_plane_test.ko]
>>>>>
>>>>> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
>>>>> make[1]: *** [Makefile:2165: modpost] Error 2
>>>>> make: *** [Makefile:248: __sub-make] Error 2
>>>>>
>>>>> The failure occurs during modpost while building:
>>>>>
>>>>> drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.ko
>>>>>
>>>>> This appears to be a regression in the AMD display KUnit test code.
>>>>>
>>>>> Could someone please take a look?
>>>>>
>>>>>
>>>>> If you happen to fix this, please add below tag.
>>>>>
>>>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>> Hi,
>>>> I cannot reproduce this when using gcc v15.3.0.
>>>>
>>>> Which compiler & version are you using?
>>>>
>>> Hello,
>>>
>>> I am seeing this across below mentioned gcc version.
>>>
>>>
>>> gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4)
>>> gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-11)
>>> gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-7)
>>>
>>>
>>> Attched is the .config file.
>>
>> Git bisect is pointing to below commit as first bad commit.
>>
>>
>> # git bisect bad
>> 2b147895be109e0860269a7a72c697cdf049a885 is the first bad commit
>> commit 2b147895be109e0860269a7a72c697cdf049a885 (HEAD)
>> Author: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
>> Date:   Fri Jun 12 16:12:21 2026 -0400
>>
>>     drm/amd/display: Add kunit tests for amdgpu_dm_plane
>>
>>     Add kunit tests for some functions in amdgpu_dm_plane.
>>
>>     Assisted-by: Copilot:Claude-Opus-4.8
>>     Reviewed-by: Alex Hung <alex.hung@amd.com>
>>     Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
>>     Signed-off-by: George Zhang <george.zhang@amd.com>
>>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  115 ++++ 
>> ++-----
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   51 +++++
>>  drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile  |    2 +
>>  drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c | 
>> 1204 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 1325 insertions(+), 47 deletions(-)
>>  create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>> amdgpu_dm_plane_test.c
>>
> 
> 
> Hi,
> 
> I bisected this build failure and found that it is caused by the exported
> KUnit symbols:
> 
>    amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers()
>    amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers()
> 
> modpost rejects the resulting exported symbol name with:
> 
>    ERROR: modpost: too long symbol
>    "amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers"
> 
> I tested the following approach locally, which simply shortens the helper
> names to:
> 
>    amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers()
>    amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers()
> 
> and updated all corresponding users and KUnit references. This resolves the
> build issue for me and does not appear to introduce any functional changes.
> 
> Does this look like an acceptable fix?
> 
> If so, I'll prepare and send a formal patch with proper changelog.

This looks to me. Thanks for catching this.

> 
> 
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/ 
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 1b564cfe2120..b58225338bc4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -328,7 +328,7 @@ STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
>   }
>   EXPORT_IF_KUNIT(amdgpu_dm_plane_validate_dcc);
> 
> -STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct 
> amdgpu_device *adev,
> +STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device *adev,
>               const struct amdgpu_framebuffer *afb,
>               const enum surface_pixel_format format,
>               const enum dc_rotation_angle rotation,
> @@ -378,9 +378,9 @@ STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(s
> 
>          return ret;
>   }
> - 
> EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers);
> +EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers);
> 
> -STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct 
> amdgpu_device *adev,
> +STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device *adev,
>                const struct amdgpu_framebuffer *afb,
>                const enum surface_pixel_format format,
>                const enum dc_rotation_angle rotation,
> @@ -419,7 +419,7 @@ STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(
> 
>          return ret;
>   }
> - 
> EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers);
> +EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers);
> 
>   static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct 
> amdgpu_device *adev,
>                                                    uint64_t **mods,
> @@ -927,14 +927,14 @@ int 
> amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
>          }
> 
>          if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
> -               ret = 
> amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, 
> format,
> +               ret = 
> amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(adev, afb, format,
>                 rotation, plane_size,
>                 tiling_info, dcc,
>                 address);
>                  if (ret)
>                          return ret;
>          } else if (adev->family >= AMDGPU_FAMILY_AI) {
> -               ret = 
> amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev, afb, 
> format,
> +               ret = 
> amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(adev, afb, format,
>                rotation, plane_size,
>                tiling_info, dcc,
>                address);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/ 
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> index 911fb2d73e22..55c33e051aee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> @@ -92,7 +92,7 @@ int amdgpu_dm_plane_get_plane_modifiers(struct 
> amdgpu_device *adev,
>   int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
>                                        const struct dc_plane_cap 
> *plane_cap,
>                                        uint32_t *formats, int max_formats);
> -int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct 
> amdgpu_device *adev,
> +int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device 
> *adev,
> const struct amdgpu_framebuffer *afb,
> const enum surface_pixel_format format,
> const enum dc_rotation_angle rotation,
> @@ -100,7 +100,7 @@ int 
> amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct 
> amdgpu_devi
> struct dc_tiling_info *tiling_info,
> struct dc_plane_dcc_param *dcc,
> struct dc_plane_address *address);
> -int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct 
> amdgpu_device *adev,
> +int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct 
> amdgpu_device *adev,
>   const struct amdgpu_framebuffer *afb,
>   const enum surface_pixel_format format,
>   const enum dc_rotation_angle rotation,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
> amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
> amdgpu_dm_plane_test.c
> index 46c9af432e37..fc84f5a08596 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> @@ -579,7 +579,7 @@ static void 
> dm_test_fill_gfx12_plane_attributes_from_modifiers(struct kunit *tes
>          plane_size.surface_size.height = 1080;
> 
>          KUNIT_EXPECT_EQ(test,
> -  amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(
> +  amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(
>                          adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
>                          ROTATION_ANGLE_0, &plane_size, &tiling_info, 
> &dcc, &address),
>                          0);
> @@ -623,7 +623,7 @@ static void 
> dm_test_fill_gfx9_plane_attributes_from_modifiers(struct kunit *test
>          afb->base.modifier = DRM_FORMAT_MOD_LINEAR;
> 
>          KUNIT_EXPECT_EQ(test,
> -  amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(
> +  amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(
>                          adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
>                          ROTATION_ANGLE_0, &plane_size, &tiling_info, 
> &dcc, &address),
>                          0);
> @@ -1187,9 +1187,9 @@ static struct kunit_case 
> amdgpu_dm_plane_test_cases[] = {
>          KUNIT_CASE(dm_test_get_cursor_position),
>          /* amdgpu_dm_plane_format_mod_supported() */
>          KUNIT_CASE(dm_test_format_mod_supported),
> -       /* amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers() */
> +       /* amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers() */
> KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
> -       /* amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers() */
> +       /* amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers() */
> KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_from_modifiers),
>          /* amdgpu_dm_plane_helper_check_state() */
>          KUNIT_CASE(dm_test_helper_check_state_viewport_reject),
> (END)
> 
> 
> Regards,
> 
> Venkat.
> 
>>
>> # git bisect log
>> git bisect start
>> # status: waiting for both good and bad commits
>> # bad: [5c73cd9f0819c1c44e373e3dabb68318b1de1a12] Add linux-next 
>> specific files for 20260707
>> git bisect bad 5c73cd9f0819c1c44e373e3dabb68318b1de1a12
>> # good: [8cdeaa50eae8dad34885515f62559ee83e7e8dda] Linux 7.2-rc2
>> git bisect good 8cdeaa50eae8dad34885515f62559ee83e7e8dda
>> # good: [aac7863446a8e0cf380f4a5087bc3cdc9b8c14c0] Merge branch 
>> 'master' of https://git.kernel.org/pub/scm/linux/kernel/git/herbert/ 
>> cryptodev-2.6.git
>> git bisect good aac7863446a8e0cf380f4a5087bc3cdc9b8c14c0
>> # bad: [fe28d02cde5372d7f71cc6132ccdef37a98ac750] Merge branch 'for- 
>> linux-next' of https://gitlab.freedesktop.org/drm/i915/kernel.git
>> git bisect bad fe28d02cde5372d7f71cc6132ccdef37a98ac750
>> # good: [0639cb26862afe4e35a689a8b5df8b9117c19f52] Merge tag 'drm-xe- 
>> next-2026-07-03' of https://gitlab.freedesktop.org/drm/xe/kernel into 
>> drm-next
>> git bisect good 0639cb26862afe4e35a689a8b5df8b9117c19f52
>> # good: [4e9c8a9c322427055c4892183d266ba391af1bc8] drm/amdkfd: drop 
>> struct kfd_signal_page wrapper
>> git bisect good 4e9c8a9c322427055c4892183d266ba391af1bc8
>> # bad: [ea33aa1545535fdb4c1a208b7bfd63314c3a4aa2] drm/amdgpu: Drop 
>> legacy ACA log RAS error data code
>> git bisect bad ea33aa1545535fdb4c1a208b7bfd63314c3a4aa2
>> # good: [a17e79d01f22182a9fcbe79fcbe2ad1477d43e0f] drm/amd/pm: 
>> Validate pp_table header before reading size
>> git bisect good a17e79d01f22182a9fcbe79fcbe2ad1477d43e0f
>> # bad: [7a561c2b1b63abcffb55f625c0d0adb68ab2961a] drm/amd/display: 
>> Simplify boolean checks
>> git bisect bad 7a561c2b1b63abcffb55f625c0d0adb68ab2961a
>> # good: [53ef33c084c5778cc2dcd1efff25e31b6e231141] drm/amd/pm: 
>> Validate Tonga PPTable subtable bounds
>> git bisect good 53ef33c084c5778cc2dcd1efff25e31b6e231141
>> # good: [fe5966d4fdcbed91e6b3478ea6c89d9915d6ed4a] drm/amdkfd: move 
>> TBA/TMA from system to device memory
>> git bisect good fe5966d4fdcbed91e6b3478ea6c89d9915d6ed4a
>> # good: [7a39b1c3b2e6b27f4230a20ccf9ac5a2737fa8b0] drm/amd/display: 
>> Replace repeated no-native-i2c checks with force_i2c_over_aux field
>> git bisect good 7a39b1c3b2e6b27f4230a20ccf9ac5a2737fa8b0
>> # good: [88ae862060f05cd8279e764832f04eafafa505d8] drm/amd/display: 
>> Add more KUnit tests for amdgpu_dm_colorop
>> git bisect good 88ae862060f05cd8279e764832f04eafafa505d8
>> # bad: [2b147895be109e0860269a7a72c697cdf049a885] drm/amd/display: Add 
>> kunit tests for amdgpu_dm_plane
>> git bisect bad 2b147895be109e0860269a7a72c697cdf049a885
>> # first bad commit: [2b147895be109e0860269a7a72c697cdf049a885] drm/ 
>> amd/display: Add kunit tests for amdgpu_dm_plane
>>
>>>
>>>
>>> Regards,
>>>
>>> Venkat.
>>

