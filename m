Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C13CC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED9710EC75;
	Tue, 22 Sep 2026 11:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="La+kn83r";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BBF10E38E;
 Tue, 22 Sep 2026 11:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG8jQQZZ9nUMapxqUStIWcH3Z3fV+R4DWxE96H1UcjptP6PRsSG9rhgVDMpXGfo4byGCRYYzJ5ix5LApCd7dy8zF8yaerCk3lRS1MUwIEpnFspH/ss3IaXBadq+pCG7j+iJuYNidBQ+SB1Tinukj8FQhGtcR1TruQboDjF8gtxSG5UmOMwJC9q5rLG3NertTer5sgHAc65g/nvh1tO9+XJpNsQ2MgtTxy7+BgFpiWP+ayDEXbrnOFu1Vy/Us5kPiQ2Xx8RIEGqog46PLg4HpUegT2Bn/XTTJIXTD84Mo20+eDKHvSLv258h5BOEEqRVEieExbLWQOHdm3d9MQREfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtmWi4qHddIEHVBVk+dQP05cctTm80zUuXTO0VSRFBU=;
 b=YhP7wurT6F5u3RWvjVyn+eWu3J52WPxwwOZK4lfOd/TfeWv5pWg+fUo5IGITA8BbJMvDxB9+wADGqMR6jNNwTyMkzjTI8mCkeRAeDraFOLd8NbABCOAgair4bgHxS3juw5enPQYYEH0JZnWjbXjZeSJ6Vkf9BQYGdUbn73M94G+11Lo3ZE5+E8cEPB/VtYGwt7p58WCQwF5MIEzP9kEEw9g0wIy2wYIjVgd4er58VwdZDk1iM9S0/wUBFfGnB8GunFzoJRi72GZ2rdDCNhwsLyrEg02TXUSChVgTA538qKe9bZY0hneRfcgZKnyIlucynskfiy9RFBEECgACz0x8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtmWi4qHddIEHVBVk+dQP05cctTm80zUuXTO0VSRFBU=;
 b=La+kn83rNLmR3Xlk2E+PGRb836GQb2kDP3SXtDR3jJZ2b6wmdi+K9C9uPSkSY7cSeL7anYZL1SrhuR6CT/1vOwK86R3VDOD/9tRHxPcu35odUnHYb4fzblN9K+ZVIK8fLs0pBgy0+o2Io1Ow9CNRErwz9unpYwbrIPoxLR58Df4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 11:41:35 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 11:41:34 +0000
Message-ID: <32f96551-358b-4874-8fd1-a685b02853e1@amd.com>
Date: Tue, 22 Sep 2026 06:41:32 -0500
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:806:f3::31) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 1013d3a1-1eb8-4581-1d26-08df189e7466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|4143699003|22082099003|18002099003|6133799003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: u0eXfKTgGAOiVnIFrGLa5qes6wywAoxtcbGmSW6zEKElAJJyjGtssq0Oo2bM905xHRow/n4sji1CuO6jJ2/oNGtC1VZThWQOH2uqlKEKg5Jz33NKJRsulTK8jM6HlZqK4a8zhAdVxsmADcyjFpw/wBZH2ElI6KRJMUrXC832tsqGz1OSO/B5uBYUpAlyv2fYTD3QPEAtaWUEKLONo/9KHOWyaykF7f7YY1BYwJN0qq3tcPOrWaziTmICGJx+uuYXHuJhcAtbnYgC8BeJs08uO3til3a6LbUnuw5aJE3lUlavNuFO+p/ALi1LWCI+EUeK61DdC5V79Roe6uKvOhmPwBZSsfg8qO8zkGftMJPE1JJbOkPMpzKGXm5cO4k15dyTyGTHhWk3AlxUqwfG+7b0JuZVDvNNb0dUNQF2U0kw9WOnvKd0grdwLAZtC9EoYRMcSXxxUhpt/Ex7vCygjLWaEmphtDlS7+krJnHDw2wltTOUTKbcI3qLt5V6VtruIrcGRyoJS0yhNZJGISyyuNGqAHhjT7jWbKp9+AEyaoUwXC53l2sztAONrjYDnRuENuWDEYnEiRePgYrgOymXiLjEZIt1+POIM8fAf3oSiAfIdZoWOK3Zp8ERNaMiHfmQo6L7G0lOFnTa4jMr9UyebU+cI2sbfyCRxT10xjzpfACym7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(4143699003)(22082099003)(18002099003)(6133799003)(5023799004)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1UyQ2dib25uaWhpdjYvSjR4MzF0MXY2dE0yRUhSUm4ra3lvNFFXd2NNOU5S?=
 =?utf-8?B?RHBhSkhvQm9tK0M3eVdNTHIwbk83MlJsV00rWEJBcnRaV29tcTg0YngxSUwr?=
 =?utf-8?B?eXBhR2hmZzgwWHB6SDNqSVFIbTVHUkpISjFDek9qZGJJTWExM1RHTlNXazlE?=
 =?utf-8?B?aE85TkpLM3RhbFI0VjVaM3ZFUU9oUWtJMFF2emN6NmErbHV3SEpjNktseExL?=
 =?utf-8?B?LzFsU0tRcksrSnVmOUV5QU9GWHFFczRZT2JXb3ZleStVSW55THRPbGl6TGdC?=
 =?utf-8?B?c1dEemc1WlRSRjFkZjlRTDZVelorYzVJWTN2WVl3NXAyaFdRamZKVUROWVdI?=
 =?utf-8?B?WVlvQlNMcGMzMUhMQkMxR2gxd0MvcVFxMkREeUllb2ZjbldDU0VBbTBsSlRl?=
 =?utf-8?B?a0F4cmwwR25URWlQWUxGZ1NXYjVqcXhGRXdncjFtUFNvVlk0K2t2Wlc1Q3E4?=
 =?utf-8?B?SG5oYzZUZDBKejJhNGZCV0x4THMyd3NtSjBFSzdVZUJkU2kxLy9ZYi9yM1FH?=
 =?utf-8?B?T1RpRDl3VXEzM0lhZk5ob2dJcnRmTlpVMEs4a3plaU8rMmtnd3FSUGVUaGVm?=
 =?utf-8?B?UHB6SGFNTFVBaCtpQ3B4dlViVVJiOUs4dG90cUdyUjVrNWQ4SDQ3MW5HQURk?=
 =?utf-8?B?MTdBNUhjamMyVnVwanlDYnR4SmFuTnZHazFYK25iZW00OEZlNHRubi9JbmdJ?=
 =?utf-8?B?ZE5nQ2Roa0FzL0Q3U0MrWS9SZmYvQi9UYTBFdWZOcWtGa2RnYXJLcFd1d0VC?=
 =?utf-8?B?ei9uZEVGazI2VDVwcDJRa3lHR2dJOGtyU29UeDFnZTJFTHcxaStLdWI3NEt3?=
 =?utf-8?B?cGprZ05uaXAwY2ZJYTNRYzJONVU3RVR4aEpiYisrTWVkQ0tSS2NGa2FVVXFr?=
 =?utf-8?B?RXZWNDZKOTZ6NjhnVzFwdkx0SzVjcmFqWXVORkdhbHhIUTZScUhXQ3JPNy8y?=
 =?utf-8?B?cHZjR3VaaDBsUjVwUHRYeER4cUZ0YmlNYzdlR2V3YXFsbU8wRXQ4dHhwRktO?=
 =?utf-8?B?cXVSd2NnYWdoUnRvN3VYSlNjUnJOUmJjZUlMZVdGYStFemk5eFdnSVpKb2pX?=
 =?utf-8?B?VjVBdGFvd0VNcnRuaVZMUkE5blZpbnN4dDNIUFpmclF1WjdPbG83bVoyN2d5?=
 =?utf-8?B?YStjY1VnUlJQYXhqSzVleFZxUm1LOXNRRjNnVCtHRWFMc2poTTcvT1A2eDRi?=
 =?utf-8?B?aSt4dzM3b0RkbjRhVGFwT01uWnRpUWNKYStKbEU1RmZoa2RPUFZQWDVYRTFZ?=
 =?utf-8?B?UUxlNzAxaSsvZ1FNZWNvTVRHRjBKVHpJM0RjNzhUQkx5RnRGQmdscmtkWVVF?=
 =?utf-8?B?UGZOY1dkaHZuQ2ZYUnJmRmdITXFTN3E0UjRGb2tsK0xhVmlXK2hWR0Y0ZWZy?=
 =?utf-8?B?RXIzRmcvZmV6ZDMzVXpWczYrS0tXTTNoZkVEdFJEZnFtQ0xFWGVBT2lzWm9Y?=
 =?utf-8?B?Ti9wcjYrNURrV1ZwYmM0SEJQYTR1aHhDZFgyVCtYSnhHT2VyUUgyTWNTdnhP?=
 =?utf-8?B?R2RSQ0F4YlZ2QmxLMUhEb0lSYUw0TTdxN3A2b2wyNEpDbUNaTHltWnNEeEtt?=
 =?utf-8?B?R2dMeDhRSjJ2dG5vRUR3WmtjYUJMWTdDeFRtUUM5Ukt0ekVBamU5dG83RDZ2?=
 =?utf-8?B?eVV3VkVWSmFmVTZXTzdUUGtielkyWlQzNWMvM0JzaCtidm00ZlowTUJsRWto?=
 =?utf-8?B?eHF5YTV2YWZpbEhzdURrZTYvRUo2cDlOWFFGRitKSHNzTWJXOG93bXJLRW1S?=
 =?utf-8?B?U2FtUW8vVXpmcWRoMSt2Q1N1MW1uMGgvUUFZRmlVSm9lbGU1THZUU2lCN1F5?=
 =?utf-8?B?cmJsUWp5M3IyZjQ1ZGI5NmZ6YnJ0VXBDTkRIcFRvcUJCczJYM0xKKytobHA4?=
 =?utf-8?B?R3YzaW9BWlZZMUsvcnBndmlPTDJUaXIrbkk1d1JnOHMrajJNS01VeTlPNXlE?=
 =?utf-8?B?Ukphc05RNW9wR0dvY1QxMUNLaXFwUUVZQmZtY3NQeU96Rm5lc2EzR092ekFh?=
 =?utf-8?B?MUNjM3lXaC9GNDJ2L2JyNFpyblRRQnczNDJFaTc5YkpiVzRqWFNIWDhLYi96?=
 =?utf-8?B?dkhNRmJqKzRZdysxTmlPQllRRVlOSjBEbnZRVDZUUGVyYlJaeGRWRnhnM2F0?=
 =?utf-8?B?SHdXRVdQZFBEaVpRSHlheHFybDQrQldteVNLblNZYTZSSVRxdFh0WmZ1ME4x?=
 =?utf-8?B?Zm40UmpaZHJMa2tSSXpIc3lCaGpoWEJjUHBEci9tOTVVYVR5RVgyN3dORXVo?=
 =?utf-8?B?NnZzSklVcE9MRWNrSEV1RkdrUENjN3ZvbDNqOTU5emJ0WFg1NVdIRTVxcFdF?=
 =?utf-8?B?SlA0bksvTStRYXkrZnk3aGQ5RlRjR2QrYVYyQ2NXL216Q0VnaFc2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1013d3a1-1eb8-4581-1d26-08df189e7466
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 11:41:34.8562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwusvC3Waaay9v+tNQQYb93KJ876ldXq0GkEvD9g3syrsS3lYBOzMr5Sn946Jg6ayRHdnaGTQC1SqyWF+NuuMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130
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



On 9/22/26 03:33, Javier Martinez Canillas wrote:
> Hello Mario,
> 
> On Tue, Sep 8, 2026 at 6:41 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> At Display Next Hackfest 2026 we reviewed progress moving brightness
>> control into the DRM connector properties.
>>
>> There is a range LUMINANCE property that will default to 0->0.
>> Once a driver attaches a backlight it will be updated to 1->max.
>> If the panel supports the minimum backlight turning off the display
>> the range can later be updated to 0->max instead of 1->max.
>>
>> The legacy sysfs interface is synchronized with the DRM connector.
>> When a compositor using this feature is loaded, sysfs writes are disabled
>> to prevent legacy tools from going out of sync with the compositor.
>>
> 
> I don't think I agree with the direction of this series. The main
> issue for me is that if the sysfs interface is disabled, then I don't
> understand the value of doing all the hops between the DRM and
> backlight subsystems...

The reason for all the hops is that users can switch between compositors 
that support this and don't.  If you're in a compositor that supports it 
that compositor will want to affirm it's in control.  If you're in a 
compositor without support then you should still have a way to change 
things, and that's what the sysfs interface exists for.

> 
> IMO when a driver sets the DRIVER_CONNECTOR_LUMINANCE feature and the
> client advertise the DRM_CLIENT_CAP_LUMINANCE capability, then the DRM
> driver should be in full control of the brightness control and not go
> through the backlight subsystem at all.

OK but so let's say I start at 100% brightness.  I open up Kwin, I 
change the luminance property to 0%.  Let's pretend that backlight 
subsystem doesn't get updated.

Then I log into Xorg + Xfce.  The luminance property should be left at 
0%, the brightness subsystem is 100%.

The hardware would be left at 0%.  I press the brightness up key (or 
call brightnessctl) and I can't change it because backlight subsystem is 
100% already.

So it can't be a clean rip and replace; you need to keep both active at 
least for a while.
> 
> It would be better if the hardware specific logic to do the brightness
> control is factored out and used by both the struct
> backlight_ops.update_status and the atomic modesetting state check /
> commit.
> 
> --
> Best regards,
> 
> Javier Martinez Canillas
> Core Platforms
> Red Hat

