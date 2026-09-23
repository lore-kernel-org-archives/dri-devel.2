Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C26AC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F37D10F1A8;
	Wed, 23 Sep 2026 20:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sOVZTlG3";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3958B10F1A0;
 Wed, 23 Sep 2026 20:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX6MG3cOWeXlBnp/pScFzXT1iqdAO6a5Qk1DvqtMd884aTqFmeg1YlZYLJB8VW2u87vbPrhr66qZWYnHxJ8fzQrs86LStsg1rjWB1hPp5RPI626vWE0S6EZdOFGYoHFXVd6/Ga0ZXmfWvWBDB5Lvc7f0z1jDKnauOBWll66/mLWBniAPKTanfesuPMSbwQqnNR0sUmIYVmFvFaqsUywyEwBjlKoOW7cAZCGPWKlUYKsH4Z4YYrtv21Axc0UsUfLHox736EDGwlmyRYSTAN/DtdZK4NhOP9LmdKLZdcfBiN2V+H6PskAQi28+0oYUKlrINKbjegFKGCIl9qp9mJ7h3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJU25BpP7vhg4ZyuhgqzRA1+R9oYwoB0OvEDMzBuEfo=;
 b=VkGN4ZsdcOGqTkLrX/Zlm+QWINbFqB6BtiNSKtEbrDbJqz/lvEdAmnRNDHRwY8LA9i3+X9PIaLTBZUhM3fSk1jfx1TjgPpyuShOIiuFdU1aTI677nOBcbjK+PM4CgcPUYGCpqCUZVJ/GVlihv6JyHV9OdDMzJIJgDyoXfpCjouCl1iGT1LkBrhFQRaeAOeCXaxienKHYl/N/p+R07lv1DfY+XprCK2oT4zHrETFuXaHprN44fx+ESWLpBH0+oZ6E9V/fiTOF47xRIxDBNVO3V8hPjh6zHhsUB27doVaMR6KA52o5Zs/LigSKipCv9k9f7DPvwLtz7gccEtdqgkHgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJU25BpP7vhg4ZyuhgqzRA1+R9oYwoB0OvEDMzBuEfo=;
 b=sOVZTlG3N9rTZYyACaPqK4TwMk9ZNjTSXM2iuDpywUJFXXq4u+S2BYHe1iyEdRfF7s8/utozgfA7m1V4R4m1173Vlqu6udCtVP/sMsLJCT2bHE+i8KkpH0TtMGkzAww6a0oArjQ3oGS9BO9pw4FIN21CHNkxbbmDT/WvnTuhsek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 20:12:30 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 20:12:30 +0000
Message-ID: <7bd814e2-0269-41c8-869e-fee424120390@amd.com>
Date: Wed, 23 Sep 2026 15:12:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
Content-Language: en-US
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com>
 <xlv1bj9peahm.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <xlv1bj9peahm.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:610:53::16) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ff8475-8a59-4902-f8cb-08df19aefef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|4143699003|5023799004|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: KRPPLmsf4I8HRkxIZfob5IgOzbutOqidDP+B/FJXmGUkb5uEKuaQtu4dh7tdxEIPWzulLq6WvkcIM1SXPyI2/kT4zTxY3jt8/4U4xq3GU1cb1OW2AvgzIXWFF+wKre2wnj8HxkVV/nU/xL1h+algstIiFKxI3V0RwM/qBbUX0if7YmNiyymFcTd7ZbF5A16Q0druGhp9DpU3n/B1lhzoPtZWwZoPY/BBFQNyfAsjS/8DyAA4btObPRg9subE508x7+MnSELACR/7INuuGGFX5tUwy8EPpgBB9IGroVk/Wvb3AukIPusf0G3FaKefQim6nGDi7WtePLKOd1PIn2OFSmI/RP2jjjMqZs+a/lHpKjLf6QZAz6CN6Wj+CDcWDlzafPQzMG+uOHb4nqdgWiE9M+YbzPFkgpa9qwQai9MJiWmk0ffjeEIwQkkPGZctdmB37UVS3xz58MiLY/anGp6IO/KfNe8ujY7s27aekbhp5hgjE30gHAzZjA8gwgrBielr0JV4girPxiEm0P4orYR83ReDuF0QwoZ4MMU9ahDh3Oqd9fJf0Ij4axVos5zjxXPHc5ZW74uAScthix23M2ujXr9mt8/RlIqsldRhMn3KXhQfMHQwDqOrZ0I4L73I37VV0povptkdPhS9ZTpBbQuYnim+iwY0LIOZLS2o2+e0vDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6921.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FkQ3YxTDJMSFl3cWNZSzgrVFVNbkVGMWtONmJEb2VHUlhOaEpDWUttVDMz?=
 =?utf-8?B?alQyeWhnbktsVWxnbkhpQmMzeW5PMG5Bei9EclZ5OXQvNXVwRG5FU1JlUHg2?=
 =?utf-8?B?K3MyTERPbDVqV0ZhbnAxQ0JTVmdZVHh3TWVjZGIrVlpxTCsvS0hmQnB3ZDll?=
 =?utf-8?B?OElDZy9QZDJoOTRhQi8vNUkxNTFROGR2R1ZiT3RWMUwyZFkvSjBGOXhJTzJH?=
 =?utf-8?B?TGNsSlU4QzFIcnFSWEk0dkNrY0ZOQU1BalE1bTA3emczYWlZUHVWNmp3cGJL?=
 =?utf-8?B?TVFQVGt3SXJ2ZXh1WGpxcGkrcThiczJqcGlmdUY4RFFDS0orcENwTDI3VWM0?=
 =?utf-8?B?aHRycWMyV0FySWZ3aDR1MlFvRG0yc2EvUUdraTRBVjA4bHRsY0ozNEpVS1RT?=
 =?utf-8?B?VmdUMy95TnZDd2RnM0hkM3ZwQkZ1K1ErNEREL05icDNVMnpUWm9tenZkYVdl?=
 =?utf-8?B?N0tCaUNKb3lKT3gzWnZUdlFoM1R2TUxXQ0txZTFDd08xZkFKWG4vS0syQmxl?=
 =?utf-8?B?UnQ2cjRudXNaUUhBbm9IS3VMMzFtS3g5SE1YT3JSQlRlNHZ4TGRZZmordHRw?=
 =?utf-8?B?Z2E1QlZBU0JEZGZFenFFYnpJa0EyQ29oVVdRVDROZENzUzQ4Z3Qvd2kwazY0?=
 =?utf-8?B?Y3RkUk9hU085LzRDa2JYZTBVOFZ5NmRnaTlZNkpRYkkxTW1mSDVVZkxJMWsv?=
 =?utf-8?B?SlA0S09WdzM5dG1hcDUyd1p0MVA4bDQwb1RhNXZBV1ZiMk5iZHBiNHhOU2Rw?=
 =?utf-8?B?VWkwOFh2U3ZYQ09yT3l1MWVBMlhuY2Z1T2lubVBDcDZ5aUxaTytWdTdKTE52?=
 =?utf-8?B?Tk9qRXRQblZDT1pRTWpUZGhldXY1RzNyaXFEbnc2V0l3TGhkbXVZeG9ON1pR?=
 =?utf-8?B?Mi9UMTFVS0lwUVFKTkZyVnZidmF6TDF4RnZhLzBMOWhPSDJYbVBuUlk2bjMx?=
 =?utf-8?B?Vkt5Tnd5cmloVExlTzNFMnJjN2dpWW9wV0lSM1lCK2RwTXJhR1F4TlZqSkJL?=
 =?utf-8?B?Q21taEd2VXVCZGNxM20wSlZLOUl6WGV4cjI0VXc1VjRTTWh5bjRpMll5YTZw?=
 =?utf-8?B?TThjZXdKaEgwMU9GQXlZTi9rRWZLTnFwc1VWSk9ybnRvMnRXS1pwS3VXNWEy?=
 =?utf-8?B?ZjZoQ0xHTzlBa0szbXJLeXBibjVuSXB4M3QvUE9VZVN2dS9DVGFhbjF1ZlZ6?=
 =?utf-8?B?ck5EczMzaWJsbXcrMk5qZkxxK1BrSVlUQmpLMXlrajFBaDNpSXpSMllVTHMw?=
 =?utf-8?B?SHFzRkxnV01vMXI3dlFRMWJieVhhODkxVlgxVG12b2piR1NNb0RGTUt2R2dE?=
 =?utf-8?B?Q05teVZuQXVTRW11djUvMEdlNkh4dWRJYTQ4MS84eTBLMGs5bDFLZERLWmxv?=
 =?utf-8?B?cFpuekZlSjAwaklNZ3FrMC9NaVk5MXdWN1dhWmdQVFZWK2xyQlVCSTNqYnJv?=
 =?utf-8?B?dVZwbG8ySTNTblVENEFKUW1xWk9KOXlBYVRtRG92eU1YSk5FdWU5bDcyYWtT?=
 =?utf-8?B?TTdYSElXdmJsYlhSdjhsVE15TTZvdlhNd3pJcTIvRkFjZXU4QTltdWtaMlVs?=
 =?utf-8?B?eTh6cFdxcjcvZDJWY0hvTjJjcVNCVE9tMTFjakVnUFNERGxCamRPR3BidzY5?=
 =?utf-8?B?VDlIOU9tNnBNOFhuS1laT2ozYnhiMmI2RHYxZGpObzQyZlprczh5UG91VGgr?=
 =?utf-8?B?WTRHdUg5TnNtcVUxbzdLRURMUDNRL0FORVlrb1B0SzE3NVNhelNrNlVBN1pL?=
 =?utf-8?B?T21MVnJKanVySUZoSmFCYVlNdTY3cDhEWXdZYVl5YkdLMnpjcjFpNHcrTVlw?=
 =?utf-8?B?eTNIVjljVjBibFh5VGpDdG53MXJ2M08rTnB2bENCcmdLVWZrTXlSQUg3V1BV?=
 =?utf-8?B?NDVTaWs2Ym9nMzcwcVB6M21WSWNrU3BBSHNEQkVweVZJVzNkVmhoazh5aENV?=
 =?utf-8?B?V3hYaytEem5EeXc2OGU4UmpzcTBlVXc4bW1aYVU2SVR6WDBEdzFlTFJ0NE5a?=
 =?utf-8?B?eWlZdnlCanZvejNjUVROczg4R3EzWmJXRDcxSVhSbjh0VlRWL09obzR2SmpT?=
 =?utf-8?B?ZkJqMXY1ZG51TWoreUIzUy90NnVtMFFqeGRIYzRNUklUenF5Zi8rZFByeDgz?=
 =?utf-8?B?dzNOVDNJVk5lakxTVC85dXlESkdzWnZKWVdmT01jbnJ1WWQ4M0dWcFpmTDVC?=
 =?utf-8?B?bk1BQnV3OTY1V2dEUXQzOU1jTnJvSVoyUDVHWkZ6RjZLbkx3WDZkaXNDd1BS?=
 =?utf-8?B?eUg1M0ozZ08xWmg5TDZoSW9RazE3ZVpCKzkvNFNSS0pCN1JFTVZMZjRZWmJJ?=
 =?utf-8?Q?WR9VmtE+aMwI/sQAtz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ff8475-8a59-4902-f8cb-08df19aefef8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:30.3843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHMr0E3KJUn2745lX30l0gaRSVrWpeefjQqhhv80TN5hTGBDJQhnlsyVVGnmh0sAfaFDXUCHKt1MORgAh1txyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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



On 9/22/26 07:28, Javier Martinez Canillas wrote:
> Mario Limonciello <mario.limonciello@amd.com> writes:
> 
> Hello Mario,
> 
>> On 9/22/26 03:33, Javier Martinez Canillas wrote:
>>> Hello Mario,
>>>
>>> On Tue, Sep 8, 2026 at 6:41 AM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> At Display Next Hackfest 2026 we reviewed progress moving brightness
>>>> control into the DRM connector properties.
>>>>
>>>> There is a range LUMINANCE property that will default to 0->0.
>>>> Once a driver attaches a backlight it will be updated to 1->max.
>>>> If the panel supports the minimum backlight turning off the display
>>>> the range can later be updated to 0->max instead of 1->max.
>>>>
>>>> The legacy sysfs interface is synchronized with the DRM connector.
>>>> When a compositor using this feature is loaded, sysfs writes are disabled
>>>> to prevent legacy tools from going out of sync with the compositor.
>>>>
>>>
>>> I don't think I agree with the direction of this series. The main
>>> issue for me is that if the sysfs interface is disabled, then I don't
>>> understand the value of doing all the hops between the DRM and
>>> backlight subsystems...
>>
>> The reason for all the hops is that users can switch between compositors
>> that support this and don't.  If you're in a compositor that supports it
>> that compositor will want to affirm it's in control.  If you're in a
>> compositor without support then you should still have a way to change
>> things, and that's what the sysfs interface exists for.
>>
> 
> That's Ok but still doesn't explain why it must go through the backlight
> subsystem. Both the struct drm_backlight .{s,g}et_luminance() callbacks
> and the struct backlight_ops .update_status() can call to the same code
> to manage the brightness.
> 
> For example, in amdgput this could be amdgpu_dm_backlight_get_level()
> and amdgpu_dm_backlight_set_level().
> 

I guess the other point would be not storing two sets of data.

>>>
>>> IMO when a driver sets the DRIVER_CONNECTOR_LUMINANCE feature and the
>>> client advertise the DRM_CLIENT_CAP_LUMINANCE capability, then the DRM
>>> driver should be in full control of the brightness control and not go
>>> through the backlight subsystem at all.
>>
>> OK but so let's say I start at 100% brightness.  I open up Kwin, I
>> change the luminance property to 0%.  Let's pretend that backlight
>> subsystem doesn't get updated.
>>
>> Then I log into Xorg + Xfce.  The luminance property should be left at
>> 0%, the brightness subsystem is 100%.
>>
>> The hardware would be left at 0%.  I press the brightness up key (or
>> call brightnessctl) and I can't change it because backlight subsystem is
>> 100% already.
>>
> 
> Not really because struct backlight_ops .get_brightness() will be called
> and this will query the HW state (in the case of amdgput this will be a
> call to amdgpu_dm_backlight_get_level() as mentioned above).
> 
> So the HW state will be changed and both subsystems are going to query
> the same information.
> 

Thanks for pointing that out.
