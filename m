Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7B6CA5FDB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B20710F72C;
	Thu,  1 Oct 2026 16:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sqcjIrhK";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2610C10F726;
 Thu,  1 Oct 2026 16:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFu1ItTbNZI461ME+/DYxA1uA6b88t20HmvvbsHogeBSUODF7xOoerIWhoyWlAfoDdKs4eLf3gghIEsoq4V0/yX2lEaoGbZiRr2qhU95JLBjucG5802E8kj0M6+abhFPrlgOZfYW9PUoS7q6uQRAv1N+Eu7VZcfyQytvkJ55BgdBMtPC2qp9jOPnjAFHuOVLWIfYEQuX5SZ3QUVaItIW8KUiB9SPnP22J/TIyyd1AdLOEkTwIZEtjJW1XduRQlpjH3Ayqa15mX2EsCqB69JJO2DsHjZ3rvGp0BxcD9kDK1PK3ue+AN4sFz8R4sOCpsFQL3AOiglkzwJN0E4Ytp/zlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erQGEZKwVzU/jdvjKH8p65/2xVcPcww6ZLAB6KNMcbY=;
 b=PH0xvGEK1dw2fbchhyKb7bPisiGTMtFzODZHWdmd+8canTklKrmCovjIEmP7KYXF+ZUSB1n19xiiJdECaRBcEzwKd5h07SgJrb37S+fEXGATBM36RBfV/dF7/b0YeceDctkDLqBv9wtCmdXJ/APFyClnxR4i0UmcXd08k9qiGyvR1OXf7IW497AHT82aFmtbWXmIG6snrLXsxXKsZBvpxDLmA2QU9jiKKv/TqszQZnYrmntsCmb4JYs8F89D9R/0gSA4rdQ2Lr587Bn7ouqwob+02CC7b7n4dOo7LYaNga5gBMej8Nj/2P3SVDC98t0huvE6hEHJtUpZWZUZd00KwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erQGEZKwVzU/jdvjKH8p65/2xVcPcww6ZLAB6KNMcbY=;
 b=sqcjIrhK3wq2tdDCN9EzBypn9RbXpBKFTtfWM74ilCdvWkguxEeU6EbP/N/4vf+X83UsgROxQbudrL+KXBKm32MrlHw/KaB9htEhL+6m7U67z6hDHGJNf6ny8NtwSnrF831nqjsF+Uz0lCwtPLX7COArxxmiX4VXGWQXnHcH2nc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 16:21:22 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 16:21:22 +0000
Message-ID: <d0889653-e835-4a22-b385-85cb19ee13a0@amd.com>
Date: Thu, 1 Oct 2026 11:21:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com> <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de> <arJ0huW356NjqpGR@houat>
 <CAFZQkGz9O8dZfmxEC5Fcpa2mRHXde+FFwu4JVz3fvKTzHT49LQ@mail.gmail.com>
 <ar6GxMRwcsTX8IaF@houat>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ar6GxMRwcsTX8IaF@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:610:e4::6) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 209ced71-47c0-40f7-2405-08df1fd8080b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PoxPEqmh+055Il+NjmjpamAvTkuD3j+ZELmUoY9Oq3AVtf2fIqyp6qmSfzMvRMfnljTZEAOlENj3xnB7cNnnv8lnbPtpM3BzF/HJigfM3CpvvWNTYO607NvL9hhJIXyuY34jhd4WYYyFLjI4cWXBcajXohWRPYHHSceMS1sbGExEbNypMLskl/n3om7+/L+m0Mw0AM7HfGPR00QleylziG6D0vDwNKdB28KTAMwTHVN+egqKkN3HL3WJFrpAacp1i2WGccRo2MFAhxZaEIuvI0zONfEsoKIaHHBjlHM+W8F+I6rYTw/JXRQTjQfSdT/sMmflmO/ftN4hLnDBn3p0SL2dB2uI4pAZsPvZexsRsj/F/RJPjKgM88opO6zBZVA8TIJZXrGBbT4TFC4jTkDoxu/D6SnVeAHSCdveVbxjV5M0Vw2SqFzFMC3bKDAFnZ4pPtZdg32hdc6uZhPzCbUvIvPU+uhOFcYnfj9j5yKXeUbjdTKm+oWo+wwhKUDtKSkZ6zuoOIJag2dMtD16D4LTqUeQaUOHc5YNre+ZSLC72Gd4/QPMZSAjaWVwCcKO8akkfsD9h/jbcQM/HL8uYmHm5g4OM0OXVFSjnKrkwZ8Fy3n4lSzOcnGaIMyhnuTE7oCEksEb1tfE6jvU9IKv8t6Rq5rbELztSHos2DgJqJeJitg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzF0OG5JMldobUIrK0Y4VVZlNHNZVEdnZzdSQkFhRzRXM0paaDV6VklrQzdI?=
 =?utf-8?B?bnNHOG4wbXM2dXRIc21BVzAzd1NxYUVRMUJsZ2xqN2JVUHQ1dmd0SmRFK0M4?=
 =?utf-8?B?NFRuS0pnUnJ2ZXNZWFNoUE50a0xYVUthUWZidVFGTE5aZmxqMlRpQytBU2V5?=
 =?utf-8?B?bjQrT25MTlpiSzJyTjFnclpzME93QUJJc21BYTlJTG96cHBHN00wN0ROQ0I2?=
 =?utf-8?B?MW1EaGZLc3EzZHJWS0hJUTZYWjY4WDFsQ1B6UnNiNjBvQ2llUDVMajRsUm9M?=
 =?utf-8?B?M2JRSU5jeTFtRjBnd0RWL0k5Q3YzeStqdmFFTitTZDFDRFBXRnpSQ2ZTa2xV?=
 =?utf-8?B?YU8zelVUVFJ3VW83V2hLRFNvQ1EyN3NJM0szQkc3RVVRY2NMWk9LSHpKM1JT?=
 =?utf-8?B?WTBjNmc1dDlVWVZkREFaRWp0VzRSQnA4eEZCMHllaG1YWjU1UE9iYVUvKzNP?=
 =?utf-8?B?ZTdWRGhyelZwOUF4eUU0MjR0QjRsc2NGZUJNL2lxMDhHQmdnZWZ6Y3pGZlVW?=
 =?utf-8?B?MTFXcEtEMnNQa3MvcVdLbjRYcDg2Wlc3WlRCQzI1a082UkFQa2hwdGNabHRR?=
 =?utf-8?B?OU9aazVnMGRsdWNCa0dHbmQ2ek82MnlwMS8zdlBuQjlzOFJ6ZjJXTEExL3lZ?=
 =?utf-8?B?U1NVNGU0YWFFbHc4OG8wY2F4MndSbUI3SGJwaHBpTTFNbUJlWVNoYmhheTlX?=
 =?utf-8?B?cmd6YWFpZGprQ1BPcEsvdVNnNWplaUQ4WjREU09ESFdkbG44MlNoMDFVUVRB?=
 =?utf-8?B?bm9iVG1adkRsWjNkWldyS1BMS09CSm1Ndi9jNXBPT05SVHllSkRvbUtBUUQr?=
 =?utf-8?B?SGhFdy8rN1VJWXZOVnNCc3EvSit2QjdDdVI1REYydHpiMk5DalZxMWN1Skw2?=
 =?utf-8?B?TUJ5emdxQ2Mvc1Q5OE5DaCswRjBDTXhCSlkzMWhXeUVGNGJxMFhyVklUZGJo?=
 =?utf-8?B?MXlwTjlrNWtwOXBSM2JpTkpNY2NRN203dWEyTUtyZThqNnRGZXVoMjlHaHZV?=
 =?utf-8?B?K0hiN2hHeTlvL2p0WlBqSWJNdjkxc1M5Tm1jNUU4R2kwbERiL25KVnM3WXJs?=
 =?utf-8?B?N2hsQVQvbldIZythVk95NVM1d1J6V09oeno3RFBCNXRHbGVtcjNyY3BITFBQ?=
 =?utf-8?B?ZytUN0xkMWpBNVA5dFkvc0xzRk92cm5USk1KWjZGWE5BZk9kZlNlTHZMRG9N?=
 =?utf-8?B?Rmx0UUtUNE1hVk03d1NJdjh5VUJJTW0zWlpLdVVxTDJnTEthcTZiR09UeFNM?=
 =?utf-8?B?dXppOEhHc3oveWhWL0tsQjFEODFaVXBVbkcwbnhSMVpYTWFmMUFuc2tKeDZo?=
 =?utf-8?B?U2dkWlpaQUFBRGFEakdvTUhIS3NvZmZRQktzUEp3N1FBU2oxbE8wbm92VEdq?=
 =?utf-8?B?ekVDSGhpT2F5VDJSWXNtZ1pWcFVZSnFvK3JaT0RMN2VhOFFaNmlPdzA0ekdS?=
 =?utf-8?B?YzdOS1NRWHlIOUNpNUJmSWNiNURaY0g1K1p1cnRBNkN4WitsMG5XSGMrcWhH?=
 =?utf-8?B?N1NQdlFnaUpvWHp3VmZuT1NCT3EybHNXeUVhMlhISW9qQ1NiaEtXWnJQWUFF?=
 =?utf-8?B?UEJhZlJzR010eFo0WjFmUXRGd0xNTklFUjVOV25MMWpGZjhkMjdaK2IwQVFX?=
 =?utf-8?B?SCsrcHhabDBuQ2RCU2JuQU5FdU52NEI3TEpBWmtGREtpS2IyZFlkNG5iQzZW?=
 =?utf-8?B?SnJIcHZ3bDR0bm0zUkRWRHpMekluTXNKQkQzaU9OZHR4NmQ5QmQybVlNU0xw?=
 =?utf-8?B?Uy9Fc0xBbXI5NENoM0RDc21hQi9uSXlyU0Q5YnVvMzVVRERHUU1JMFZoNjFr?=
 =?utf-8?B?VktiZmlJR01CN2crTmhySEYyVEdFakxGR1lqMnM2YkFJd09QdnV5Si9McGJR?=
 =?utf-8?B?NkJidVM3Qk1hcFZnalFnQVpDQXMvL2tOVlQwTlJHRFg0STlta1BIVXFnZ0t0?=
 =?utf-8?B?QytFWHM2Y1JCaUdrVTBnZ1pDQ3doK29aN01BbjFDajFlRVJwNmdMQ1lRM1Jw?=
 =?utf-8?B?VFFlNS9xZlozNEl5NmpWU3I1cWZpdnNYSGNDNkU4cW9UUkpIcisrNjgyRjkx?=
 =?utf-8?B?S0NFY294YmF1aXdnQ0tvWlZ1Y0M1RVhxOURWOUpCcm50TzhCWkVDS3lWclFN?=
 =?utf-8?B?bXlSRkRhY1BZM2ZmS2VwaVdOaGJtREdtUDQyQ3ozNlJ5WUtUZ3VxNnB4Qno0?=
 =?utf-8?B?S1JPOFpuVUpqaUpTMGdHTU54SDRjUG9pWW1kWldzM3B6amltTnY4N25KeUdl?=
 =?utf-8?B?TVExbmxXOEJMMTMzcTg4L1cvSGxka3hFOHR5MWVicFVZVlBHcVB6YlhySHFm?=
 =?utf-8?B?cFFXWXVqRWpaekNZbGoxZlJDSFRNWVlnTzdPbjJoKzlUY2hNV0lrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209ced71-47c0-40f7-2405-08df1fd8080b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:21:22.0276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeGSkFhzDp9uBzuesV+FtLeqg2lWRnH1JDQL+AvC4jrYpOnl0+C+prHXhGkUo5RjiP4EMo7Ncdq3EKPOxZGpAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560
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



On 10/1/26 11:18, Maxime Ripard wrote:
> On Wed, Sep 23, 2026 at 10:07:16AM +0200, Xaver Hugl wrote:
>>> Couldn't we make a sysfs write trigger an atomic commit then? That way,
>>> it would always go through the atomic commit path, no matter whether
>>> you're on a "legacy" compositor or not.
>>
>> That could cause stutter.
> 
> Is it really that bad? I mean, it would be only in scenarios where the
> legacy API is being used and I would expect it to become the standard
> pretty fast anyway, no?
> 
>>> It probably would, but it would create a precedent I'm not really
>>> familiar with. Hotplug events are kind of separate because it really is
>>> a hardware event most of the time: you get an interrupt, and report it
>>> to userspace. And it's largely outside of the properties space (except
>>> maybe for things like edid).
>>
>> If there's any property changes, userspace does need to be notified
>> about it. Whether the change is caused by hardware or software doesn't
>> matter.
> 
> Yeah, it turns out we already have a precedent for this for HDCP so it's
> not too bad I guess.
> 
>>> If we start having the argument that a property changing must trigger a
>>> uevent, then it means that we can expect *any* property to do so
>> For anything modified outside of the compositor's control, yes.
>>
>> The client cap avoids needing uevents for the luminance property
>> though, since backlight control is exclusive to DRM if the compositor
>> supports it.
>>
>>> "the compositor needs to be in control of it" can apply to many, like
>>> color formats, positions, tiling, etc.
>>
>> If there were other APIs that desktops relied on for controlling color
>> formats and similar, we would indeed also need a client cap for those
>> things, until definitely all software is ported away from the old API.
> 
> I really think this series should be split. We obviously need to address
> this, but it's kind of decoupled from the UAPI itself, and is only
> relevant for a small subset of its usage. And yet it's all we talk
> about. It'll be easier to merge in chunks and decoupling the legacy API
> handling from the new uapi.
> 
> Maxime

How would you feel about a (temporary) Kconfig that lets you pick which 
API to support?  This would effectively mean that we can get the new 
UAPI integrated without worrying about implications for the legacy API.

We can then get compositors all lined up to use the the new API and then 
bikeshed the compat between the two to let us drop the Kconfig.
