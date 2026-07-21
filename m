Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBDCC44533
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12F110EA0C;
	Tue, 21 Jul 2026 13:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cN3iMM45";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461E710E364;
 Tue, 21 Jul 2026 13:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgEBnbLw4F+0oCGxO5k6whJkT1oavFyQ6wSnSK6OyV3OdR6B51qiaYHQoHdGvV1VvZ6TuSyF8YeQsP9NEgl6pgNShbpSeDb2p8JDw7jT0wSCLkCofG7EHcvBiOM1i4eeIdtFz0xPhFzNyxb15qejbQutox2X+mvHp7N4V4g6IcS2WeUuaTLPJkOvc9cDiGNtLYUjvoQKb4e5xYwrvz2nSDxZLDJ1BDf6Vy52HejSP6PZfhsac6vwKVa7ij1rDKXiNzs+KpiA6ehqM9kv+tSxeu2Lfj9vyGnjfQm8Zn5Z/YqhUpi2P5mM3xsJv2aWm00PZscb5o1WvGi8CrcNcHGHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/APmSaMOyunPxERsCF2xJdqPIGqOvgajzqOZY4u9rk=;
 b=UEiYneZ2xIUgmWwN1H7pqFmnH4dEX6eBVqR7LAjssOqO19nwkvln/IGtfpGgbiMFUe8FZIEQsodkNcse8r7niMD4K/ZEart+d4Q3G6+5uOMjVaf4I0NskHjunQrhaiVly48tWI+1XLI/mhpdEJyiCmHU4PjRjEKDPa8UP820diwfxcY04cvzy62aZSSkWgzrjW+LZ7wqr6MuWAnY3Jc/K7URDSvazRt+EtfZVJT2GangArazfwrNCE9oXnDFr+OqvqJZwPj1XEBW0pFoGOKTxfFtwVLo1i4KBKYprrfb0U2oh5sc50807tmDtR1GeEtqjAd8n3ae+K8Rml7bHL2/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/APmSaMOyunPxERsCF2xJdqPIGqOvgajzqOZY4u9rk=;
 b=cN3iMM45n077GIWmmJnc3H+nlcVSlQmgfeFdtWRxT+Ws26JgPaoeNSnLeLYY0lY/QzBX6xaXP19cDOksVI+KPfEFdAAZ1a3D+bvZZtr46oY7SKVj4HxOn15xvlMM9Cfezbk8Xs68S2SLxeXdd/R0mmydXp4MbpDDlupN/yPZ/Mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by SAWPR12MB999115.namprd12.prod.outlook.com (2603:10b6:806:4e3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 13:55:18 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 13:55:18 +0000
Message-ID: <b670d594-0582-4c91-8264-88d1de5de1d8@amd.com>
Date: Tue, 21 Jul 2026 09:55:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
From: Harry Wentland <harry.wentland@amd.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Robert Mader <robert.mader@collabora.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Daniel Stone <daniels@collabora.com>, Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>
References: <20260703073230.19982-1-robert.mader@collabora.com>
 <6d8806b8-fc71-4699-82c4-7189a0ea2284@intel.com>
 <bb5918f5-a6da-4908-9332-18e0df39c005@linux.intel.com>
 <7d58b289-eabe-4d68-9080-c7202b0f60a0@intel.com>
 <d42d5750-f3c5-4e2b-baa3-514b87e59e86@linux.intel.com>
 <361dfc91-94e8-4289-9b3e-5280803d9257@collabora.com>
 <a7887776-c26c-4f6d-a662-2d8ef005ff4c@linux.intel.com>
 <2fa23cb1-b4c9-459b-a0dc-31960313a243@amd.com>
Content-Language: en-US
In-Reply-To: <2fa23cb1-b4c9-459b-a0dc-31960313a243@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|SAWPR12MB999115:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e10b3a-4537-410e-8ff2-08dee72fb296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: W5GWgUaYb3MOU8sJKWeCyfA+V5FNTbVEh219si/TNHFw2pXNi+MG6CTvQF7Z4uv79NCN2PFPmsCtlFzkJs2R/mzY/lPTds92q7+GUnAmx+y/AB2nRn9uAtihL7AMEDxZl5uzZanq7xaof5xYVmTLdD/brB9dgmcVCedKoqKE3GFD2/y1igkJ6j+3Cham5wf06JUH3AihyFhtbP8Rqf7QTWIesaHipl1caqoI3MRFp6TAXIQHXLDT6A5zU9VcGaEDDe6eo822UpzQlOpJ5MX8mJ8WVwwG/B1QDR4ZaPH9kDbJKeze3nsiMCc/MtTvbs0rZGVGHghwUBZc2RwVWyZnI8dPrD0GXlO7M0SDm9xkzOP192Eeg85FFugZg6Dupp/7N/nSbCZp4rLlVj8CrcIdW30EF+68J2hYh2QTCbDyqYEw0rppu1KFkoTQDPoopB8936Weg5f/GuHbQCCFo/AbQFQFEiFKPf1kSURbNILRXQGWs9/kgDtx74IdaUK86kqZ+gNGr3XZ2XDb7Ht9KWwINf7pCejK6s358rlOyKK5GOpszFuhauLoIQQlahZuTxANxNvNpOS9KI4i7AtO+yK24vlb5IlisbS9dkqfQxZB663z1+NPJf5ScXep1wnOPHcEtOyPTPRF+nsyQEkc0hP29xWlAYtbAO7GaZI0km15T7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7003.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHFaNSszYmhIMTV1MmtJTnhUaHpjWWs0d3JnNVhoUHpETW5LQjVtSWhzL2xz?=
 =?utf-8?B?RWt1aCtHdFhrMjBrMW1KOVE2VGZrS1pzbzVhM0FlWDBPZVhFbzZDUHNibDBh?=
 =?utf-8?B?MnhoRE1iME0vNTlNMzBobGtKVzZVR1Q3MnY0UENKRkRXbGxtUzhnTDFZb1A0?=
 =?utf-8?B?aDVTdUhSenh2eVF5Q0luQUQvM1EyWkcwTjJxVjIySVdiaTRibkFVOXZ3SXhZ?=
 =?utf-8?B?V3J4Z2s4Zm54a0lNWHQrNjM3eUhGQk5QRElGUUxVMnJDTDA1SWhleVZxb0Z3?=
 =?utf-8?B?Ynh4bklYOFdrdkgrSGxzRU9XRDE5d2c3M2FhQ2dTRWordGRRajRWWjliQ0pj?=
 =?utf-8?B?NnJwazR3QnlmM0p3YjBqcVRlV0F4UHl4WERnVmRXRnN3dk9ISzZZT2tLL1ly?=
 =?utf-8?B?MjVWSjYwUnVsTmNOZWNaTG5lZ3lRbGNGRFZ5blpQY2NQSzl1cEVnVGhCdmtF?=
 =?utf-8?B?b0kwOHNCWmE2NzY2L0tlVnZrd2RhYWRLemdzaWozYVBrbHJJdTVQTkk0VkZh?=
 =?utf-8?B?RmlpcEZTMzl3NUdYNkxHYkNqOVlQdU1nZXV0djNvUE5ZNW80eHRGdDliRURO?=
 =?utf-8?B?OE5abjdTcGtwRTFWdURDWFByajhyMXFCN2dCMWlzRTRhUTdiRXRRN1hybW41?=
 =?utf-8?B?dU05NXJvL1kzNXordkRsdXdUd2dHdXFQUFErckpxMm16ZEpzeU13ZldpaXFs?=
 =?utf-8?B?a0hmM1I5bGwxOWNKVzVGRUZBSUhxd0hHVlFvMlEwUUVOTnN5a2xXUXhZWFJ4?=
 =?utf-8?B?ZlF5enNkY29jRWJYeU11WDFIRnc1Z2Q0U05aRDVHN0JNVGNuVSsyam0vWVJS?=
 =?utf-8?B?bDcxVnp0aHlBdnY3TEQzR01zd0F1cFZWMHdBQjdheUpPTjRidGtYUE8vTTJN?=
 =?utf-8?B?U2s2ZS9EMXVFVTlUN1BZVnFlNlNBZ0hrTXNTZmRzUmU1Nlp1dWNONDdjcjVz?=
 =?utf-8?B?K0NZMEE5eXNIbGpKQUNqeWFFeklocjFpS004ZzdkWk5udGQ0N0FlQkpYN3dD?=
 =?utf-8?B?bVJiZE1LUjlMbWk3MlR5bFJ4SjFHcjRsbzJtMFYrY2s4VGY4TEU0ZmwvZ1h4?=
 =?utf-8?B?bnBCOHVxcnM2cVdybXphNlErN3d3cTJXdTRBV0RRSGtFenRvaXlHbXMwc2Fp?=
 =?utf-8?B?d3BZb1B1NW42VmVpblVWVEhoL1lvdFZVczlmdXdiSis4a1o2d2FOZ29MbEFi?=
 =?utf-8?B?UFV5YWJQM3VYK0tMdm4ra1F1OUJZWFlqcTZiUDFoM0ZCc3V6QmhTdzJDdW9G?=
 =?utf-8?B?RUV2SjNraVYwajlvNnhpUzhpNFlFZ0VMSjlzb1haR2lHVnVzVTdmb0k5cEZB?=
 =?utf-8?B?QVcwMkhzd3RxM0s3OTFreVdLU3lKaFpOOTNhR1U2dmliZ3UwOFFQZlNXRmpp?=
 =?utf-8?B?QzBPV3VZYy9ZV3Iyd1owVlJDUGRjTWUxL0lXcU1IRVBYaUJoNVYybGIydmE0?=
 =?utf-8?B?ejBwSFVHT2Q0eXVNUXN0NW5OVU9OV3h3TkpESjB2UXUzSUhLVmxDK0szK0th?=
 =?utf-8?B?MCttUjV1RHJIN0ZjaUVsK296NU9ycGxRME1ValE1OEVHbEx2ajloSUNnRHpM?=
 =?utf-8?B?M2RHUUFUTm0vYXJRYlkyYm9zMEVuUGZmR3ZkQzE5d1BUSHRSbnRQdTJzZ1Ns?=
 =?utf-8?B?ajNTN3hHM0l0M1lOdldEYXhxdDVXWWE0ZUpBWnZCQTA4MXpINWNpMU4wcHJo?=
 =?utf-8?B?N3QzU240WDRlQW5haENLcDAzdFMrU1ZLYlpMSTJYYlhwQnlTcW53Rmh2WFgy?=
 =?utf-8?B?R2N3TW9leWpCdzgvL0N1TUR3ZmcveHNScHZsUGxHRG0xWU45cE8wdnN5NGxF?=
 =?utf-8?B?bUZoZlM5bzhncnBxUWJ1cnR6aWlSMmVJMWdtNnlUSXg0T0dzd2FRRUdhQldp?=
 =?utf-8?B?aExXT2ZLUXV0RXp0d3hvdzVjbmJuaGYxcnd3S1pRYld2aWR4S1FIdmxOZW4r?=
 =?utf-8?B?ZDNLNVZ1cjN4bDJZM0xFS0NaNWJRcS9tVWduajdWeG0vYUdzREpMNWlVRmdO?=
 =?utf-8?B?eWxwVklJOHppcWE5MXdPc1p6NDFLVkU2L0xKRmxiOEhvOUJuSEtXWldBRnNQ?=
 =?utf-8?B?S05uREdMNFpSRStvZXlldW9DYkI4UXFYemJyejVZU3BybXJ5N0dBREhCbjVz?=
 =?utf-8?B?Z29nandoYklJWHZQaFVENTl5dXRBTG43L2ZxbCtvSTJXeVJRbS9KNXRGYzhP?=
 =?utf-8?B?QnVNQ2t5UnZIbVhWcHg0QW1EanUrdEZ1N05GZ3ZvdHJRQWgrZnA4Z3dqakhm?=
 =?utf-8?B?Ty83TCtlQXR6VmdhdXJtMlB5V0xYcDE4Z241eHByQzUxa0pNeEZjT0dlWjVY?=
 =?utf-8?B?S2VDejNoVXd1dTlkdnYvd0NLKzcyUkN0VzNrL3NWUnd5ekUwMEl6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e10b3a-4537-410e-8ff2-08dee72fb296
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 13:55:18.0658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xQH2nBA5QN0H0P13QSbJO4STzp2v1b7X186mqC+COxQW2g8cAe34Pc4ZjLGjVTmEZidYkYwFflYJW2vurnMqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999115
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



On 2026-07-13 16:05, Harry Wentland wrote:
> 
> 
> On 2026-07-09 07:49, Maarten Lankhorst wrote:
>> Hey,
>>
>> On 7/9/26 13:14, Robert Mader wrote:
>>> Hi,
>>>
>>> On 09.07.26 12:02, Maarten Lankhorst wrote:
>>>> Hey,
>>>>
>>>> On 7/9/26 08:44, Borah, Chaitanya Kumar wrote:
>>>>>
>>>>> On 7/7/2026 6:31 PM, Maarten Lankhorst wrote:
>>>>>> Hey,
>>>>>>
>>>>>> On 7/7/26 10:03, Borah, Chaitanya Kumar wrote:
>>>>>>> On 7/3/2026 1:02 PM, Robert Mader wrote:
>>>>>>>> The client cap is currently advertised unconditionally, even for drivers
>>>>>>>> that do not support plane color pipelines. If clients supporting the later,
>>>>>>> s/later/latter
>>>>>>>
>>>>>>>> like Wayland compositors or tools like drm_info, enable the client cap on
>>>>>>>> such drivers they will be left without both color pipeline and the legacy
>>>>>>>> properties COLOR_ENCODING and COLOR_RANGE, effectively breaking YUV->RGB
>>>>>>>> conversion support.
>>>>>>>>
>>>>>>>> Prevent that by only marking the cap supported if there are actually planes
>>>>>>>> with color pipelines.
>>>>>>>>
>>>>>>>> Note: while the color pipeline replacement for the legacy properties is
>>>>>>>> still under review (1), we can assume that it will work as a drop-in
>>>>>>>> replacement.
>>>>>>> This change will but a driver can also choose to export colorops like programmable CTM_3x4 to achieve the same.
>>>>>>>
>>>>>>> We should also perhaps document this somewhere that if a driver supports LEGACY properties, it is imperative to implement some version of it with the color pipeline line property.
>>>>>> Would this be doable inside drm core? Implement the color pipeline properties, get the fixed pipeline for free?
>>>>> Right now, the Bypass(default) pipeline is automatically created when we call drm_plane_create_color_pipeline_property(), we could come up with a similar helper that could also create a pipeline that replaces the legacy properties.
>>>>>
>>>>> But this can't replace the existing helper entirely because some HW (though unlikely) might not support YUV buffers.
>>>> No need to do this for free, but a cheaper way for drivers to implement legacy
>>>> properties by only implementing the pipeline would be nice, similar to how
>>>> atomic also implements legacy modesetting and universal planes.
>>>
>>> I really like this idea - should we take it to the corresponding series, https://lore.kernel.org/dri-devel/20260623164812.81110-1-harry.wentland@amd.com/ so the initial implementations for AMD and VKMS directly do so?
>>
>> That would be great!
>>
> 
> If I understand you correctly you suggest to map legacy COLOR_RANGE and COLOR_ENCODING to the new FIXED_MATRIX colorop in a generic way, instead of having drivers advertise them separately. Do I have that right?
> 
> It's probably a good idea. It should be easy to make that change after merging the Fixed Matrix series with YUV support.
> 

I sketched this out but both VKMS and amdgpu have HW generations
or configs where no color pipeline is created. For that we still
need the current way of COLOR_RANGE and COLOR_ENCODING handling.
Because of this the code to create COLOR_RANGE and COLOR_ENCODING
based on the color pipeline is not really simplifying things, but
merely adding more code.

At this point I am not convinced adding helpers to create COLOR_RANGE
and COLOR_ENCODING based on the color pipeline is a net positive.
Maybe in the future that equation changes.

If anyone is interested I'm still happy to share the code. Just
let me know.

Harry

> Harry
> 
>> Kind regards,
>> ~Maarten Lankhorst
> 

