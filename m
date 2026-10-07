Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EAFCA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267AE10F5FA;
	Wed,  7 Oct 2026 14:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KGulpqVK";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC49110F5FA;
 Wed,  7 Oct 2026 14:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUWYs4qJgzearAdmWkZeYgkLE+orRNcVSn/fLTg8alaL5CvAKyqj0OVJBdGy0w88vj2v6ekJKxpGPby14AD+5RNs7DsEyxHfTxiin7QHTVNTR2PhtIOaA/f3LDZPL3NzRsHR/1VUGl4cy6E64GFKBaSKll5Ogk4gPWAQSlyh1+W4CcNohj2uvKvwVSIdMKH0OHSW+gaFtalY612NUhMoD1c72/DdPnroQtlOvTvbaeDb10hAKW1oXTJaUYRT4ILxQ5ixk0PhkW5ucSAYFGmazkoImJ7ldJ3R7vS1upChGAvIpS9EcA0fymEPicniW0/hWuVJHIiqMvnYiq58dm7Txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX1PvG5EYxpJwX8qOmLCfGnGeEDKoT8mflUTu+ET6LM=;
 b=wsDoHgbtmL9mQGXoNv+q/lNy/YErJSU1EU5M9tJJcLirK9stmq9Q+L+Z6l4duPQhlfib8x6aKw3oWo4X8zrZc5LKRr0sG2PARdcW3CcD6ZmpLgD5B1KXIQ2ra1IeyNx9WVz0Z/sC/qNRxyfC6gX7aQFijERM5/N3Gesevfe6EKzb7SCWQ/79pe+Jx8Nmr5jVdE/UE1T7nqZKkKrGT+fxLbbnjQVqIoWR9B5VOiR00jgd8tkTZE/jCyb0+d6Zig5MbeAQLr/RL/DK0YvUDCmMDY/xoNHPBir21rqV2XIjIETR0Ld2kwH7sF1AhOI34/u2OvHALPGpu3j+TbagRbnOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX1PvG5EYxpJwX8qOmLCfGnGeEDKoT8mflUTu+ET6LM=;
 b=KGulpqVK261I/XWkIk50qx2jScL5kP6WCftB6KcLhKXYdOt3I7vR2+O7Kq/lUtbRA3coSHhHBUPblobGU80RNb8tNSSowS2jP7aDWU0nQqbFoU97TvbJouFNiYch/u52v9Clv8s3MgZegn7eliuaZOlTZGtyTEMfQE2L1EYzPVc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 14:14:27 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 14:14:25 +0000
Message-ID: <1bb144d4-f9de-4e81-8abb-126267886c1a@amd.com>
Date: Wed, 7 Oct 2026 09:14:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/edid: Honor overrides when DDC is unresponsive
Content-Language: en-US
To: Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20260917135949.2552704-1-mario.limonciello@amd.com>
 <1efb1842489bc50e87ab0476e3d3ad861d6ef807@intel.com>
 <8fd336cc-6dae-4a9e-97d0-0c5eddab589c@amd.com>
 <a0c27fb3b765b41eeedeb102295a0ee473efe08a@intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a0c27fb3b765b41eeedeb102295a0ee473efe08a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0165.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::20) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b91d14-6d54-449f-2899-08df247d4a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|5023799004|3023799007|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ITm0MmWd/QJ3KvyRT3XxhkuSDiL6vrI7PRwjbZe3cdCpEIt1fklYN+Nbo9PeJkGPKotkHSjiqtRpw8Yp1z6fLV1dfl4zmBmyP2adiT7LpKQDpordqZIzlCH8r1tVtAZE8M/swSDa96O7aRKkf8HBBKDRHMZIN6bp/a3ooIl5QU1Y4ypfXYvapHgD7EiOcKKsYQP+VJLruFhVwVFjXBiIe8L7DSv4Vhk2LM9LQPLSIRlQhyfLIKPskno/LUnia8PPEYkY4gVKBB5H6ovBMpMUbn08blYvnlTdMWhjicVShbmKfg6Bxkc8nsbkzQ+BGHl9O77zYlJy/qlE8IdcyTdRho0JKYj2nQD2p5cMxHNMDfrt6qlkm5rSI4v3Jc4HTp9H+P60ChdRKX34aFHyZbYjivknHdIULcR9m71fn4BdgUcXPGzX/L1+sIqfFDSfIFYXhRfgKclyyslZP8CuWlS7Qg/DYXIldQg8BxG38g6mh5aeWN7D7okCHXZ2PEzaqKrwWILXWD+JPUQNVfptfKR64Mhv0DBiln1CiuTJcN4Bfh/ITs5b9H+7n4HuTQ5sMHP9x+/KHg3mzuI/e7THKNtA7AxKYQwwA6XG3SU3tQQSkSOImRaTIIw37HJft6SKfd8v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(5023799004)(3023799007)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnllTzE4OTM2NGZJdC84a2lYN3RRaDhoSGNnakI0bnBXRjFDY2QxZzRlZDdw?=
 =?utf-8?B?NEpGaHR3NEQzVndYK1BlS3M0OVZmWDNKbUZJdE5HQ2hYVVpzZlB0Z1Flejg4?=
 =?utf-8?B?eW5DSllIaWNHUnZkTjVOZk56NG4wMzRYajQ0ZHZUZTcxNzgrSHFJRituM1Qw?=
 =?utf-8?B?ZkgxVGxiSjJ4YWE4cERXbEtjQlovZS9YOGwwU2VFKzh3L2QrZTFHK1BINXY3?=
 =?utf-8?B?dHgxNXVTQ0ZVQXVYNStTczJhWUErNUkvdCtwckVQeGV3Q0NlNmlGdWpHWXVW?=
 =?utf-8?B?Z1N2VXgvSm5abG14RndReCtqUUlVZlUxc3J3MWgzYVd1Ym81QWVzUWxHWGlD?=
 =?utf-8?B?TWxkSnhRVWNaVi9TMUxWYXU0dWJFTTZjU0xWOHNDZGhhZWk4WjRaY0IwMDJy?=
 =?utf-8?B?ejRxU2swYitkSEF1SFdNTkdKK1pvS3BtVUJtTGtZdTNPSmpWY2dCVmJ0cEJJ?=
 =?utf-8?B?WDgwTHd3TlpnZjZyQUVFOHVDYWZkaWpZVnFEU3NTOVpZbk9ka0tRQ0RoTGs1?=
 =?utf-8?B?L2N5TjRUem1STUNRVlBBZVZYMmh1Z2hsWnA1bG5iRWovc3BmYlBPbW9XcDZq?=
 =?utf-8?B?Z2NCWEMrMC92SjhSeDNxQ0EvR1l0WnkrdlA4MkUwSVJ1UmJxTUpqRzFFbnpQ?=
 =?utf-8?B?OFoxMWJWK3BaZjFGbFBCNXZkMlprWWZyRmN6QTZsOFJXOTlVcnBDNlROVzgy?=
 =?utf-8?B?Z3kyMUR4KzlQSDkxYWNWcUpMc2hYTWUyOGRablkweDk5R2ZvbnFidEkzODcz?=
 =?utf-8?B?UFhiZDVwejQ1RUpsZTNSaW45MTBTZkhWUms5cEhvaGIxdWJpcDBndEtBVHZm?=
 =?utf-8?B?cmkrcW1ZTkVYZDJEWlFDckcxMlpJWUdIR085QTFTUjdPWlplZ1VyK3pmNHpU?=
 =?utf-8?B?NFJaazdmMUNkVmVwQjF6VTNRNlcyajFMMjFMbVZYWXhZRHFwV3VYWlFpaUl2?=
 =?utf-8?B?QkJsaVc3MWpWcGVZL0Era1dlaDJJNDd3ZUpaUUpmenRxYm9leXd3SHVmcXVN?=
 =?utf-8?B?Mnk0aDROVjlSK2ZRK1A1MCtTSHJyMDl6NnhYU1BBV04rbGFlSlNNSDNQTXk4?=
 =?utf-8?B?cVZieWxteU9La1MzakxGbHdKUnFMQk9ERWYzcnZmWUNWMHpMSFNqMDMrYlNG?=
 =?utf-8?B?OFFyc0FVVGRqRnk0S01VQXgvNHZnZFllTDMxNVhUZkxFb2hHYjZUS2JkaDdk?=
 =?utf-8?B?TDNISlowMTNIcllTUGVCQ1hDY1U4QUpxak5FUEpJeDFIN2FXRmJpVlhUMzNM?=
 =?utf-8?B?ckJNWDgzakJoaUJJazJoK0R5L1F0NGZkbEtBendxZmZxdGZHQzJXM3NJc0I0?=
 =?utf-8?B?UDM2VmdoWE9xT0l5UU85b2VNUEwyalBEejVBR0lNSlJQSnF0aCtTaGNZTkNT?=
 =?utf-8?B?eUgvbWZKcWxmakMra3hxRlNLYmZPMkI1enpwM0EydG9BVFAyRitXY1VHSXhi?=
 =?utf-8?B?OXVvT2w2R1VwOW1WSUJtcWZHMUE4RnFIZVl6a0Nxc3lBZXVKUG9hWEN1TVlJ?=
 =?utf-8?B?QlNadUlJQ0hTM0k0SmhRQnZJc0hXUmJ4YVBsUGZURnlPb2R1blZ6VUQrZ2hv?=
 =?utf-8?B?cjdadGtxQmUzV29yNkNlWVZaVldOclh2TWsyYVdrQTd4RnB1K2dhZzB5bk54?=
 =?utf-8?B?c1lwZmtqTzljUHFLSTZrNXNINk44ZmttV3JBampBNG90MFdPeXNyTWxlUkJZ?=
 =?utf-8?B?ZlBJOXdCenZIQnFkdWxIVnRSWG5ZbEI2SUhqMWhnamtzSkpWY3UwRlNuVHcx?=
 =?utf-8?B?QUdlWmtTSG1FZ2hRc1FlVXBBMExYZCtsR2RzNW9XQ3ZHUTVML2N4TEFoeDBD?=
 =?utf-8?B?Z1BEcjVmazhDZWdXbGppbXdwM09rQXpSZVJaWHFYM2lVdVQ5NDF4ZGFsWndQ?=
 =?utf-8?B?WWFEbkNsZWxSUVhSa0FEUFVySGFxS1Y3Q1g3ZDNGaVdSL2VzNVBZY2Q5RkpN?=
 =?utf-8?B?WTlUbWdDQmZOaVROR2xzV3FoN01ZTS9rSi9MbEdrSnViVlR4cmRIa1dGQmRn?=
 =?utf-8?B?OWY3dG15U3NIbytkMk9XRDBvajVHNzBTMy9aU3FMZHM0MmU0K2VFcmthVUVK?=
 =?utf-8?B?Yks0VWJMeS9sZnpIeFo4dmM2WklUaFhqU3NLSmgreU5OTThpQmFnY2EyeWtC?=
 =?utf-8?B?eVRIMzRyams5eHBLbWxRMlFyWVlRcGlTUEd4QWJtcy9GaHo2WklhM01pQm5u?=
 =?utf-8?B?aXNSMzlQamUveEw2aUJKRTJrcVBlUEVacUF0cllXMHgvUmZYRkhhdENtMkx5?=
 =?utf-8?B?NDlmL3p5VzNDUXkvM1VoWUpYY2VKNm9SeC93Q0JrRnFuZHVGNGhTWUhndDJN?=
 =?utf-8?B?bmVQdnBVZFVWaHkySkErOEN2YVZIVkZIYVFpcWFraDZhTEt4WVFDQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b91d14-6d54-449f-2899-08df247d4a82
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 14:14:25.1388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bd2AWLvlpplbX6lKnBOFandjW4dzPBb6HUQTW4Dy2ByopG21HaWNcfdqRevGCjqnf/GKlwUpOPrgBvMgxQlyIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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



On 10/7/26 09:10, Jani Nikula wrote:
> On Sat, 19 Sep 2026, Mario Limonciello <mario.limonciello@amd.com> wrote:
>> On 9/18/26 04:41, Jani Nikula wrote:
>>> On Thu, 17 Sep 2026, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>> DRM's EDID read helpers probe DDC before consulting debugfs or firmware
>>>> overrides. This preserves connector-detection semantics for drivers that
>>>> use a successful EDID read as evidence that a sink is connected, but it
>>>> prevents drivers with independent presence detection from using an
>>>> override when DDC is unresponsive.
>>>
>>> IOW, your use case is that you want to use an override EDID with
>>> reliable presence detection other than the DDC probe, and don't want to
>>> use connector forcing.
>>>
>>>> This affects AMD Display Core, which establishes physical presence from
>>>> HPD before attempting to read the EDID. When a connected sink stops
>>>> responding over DDC, the configured override is ignored and AMDGPU falls
>>>> back to a 640x480 mode.
>>>>
>>>> Add an override-only EDID reader that does not access hardware, then use
>>>> it in AMD Display Core before trying ACPI, VBIOS, or DDC sources. The new
>>>> helper preserves DRM_FORCE_OFF handling and the existing preference for
>>>> debugfs overrides over firmware EDIDs.
>>>
>>> It was quite a bit of work to unify the firmware/override EDID handling
>>> to be the same for all drivers. I'm not exactly thrilled about exposing
>>> a mechanism to *only* get the override EDID, just to allow drivers to
>>> deviate from the unified mechanisms.
>>>
>>> The goal was to plug in the override at the low level, hidden away from
>>> drivers, to make it as close to the normal case as possible. One of the
>>> follow-up ideas, which I never really got around to, was to do the exact
>>> same validity checking in _drm_do_get_edid() for override EDIDs as
>>> regular EDIDs.
>>>
>>> I'm thinking maybe we need a way to allow drivers to define a
>>> drm_probe_ddc() alternative as a connector callback? If you set it, you
>>> can use another mechanism for presence detection than DDC probe,
>>> otherwise fall back to DDC probe. It could be used in the regular case
>>> too, if you have a reliable and quicker mechanism than DDC probe.
>>>
>> Well I guess the real reason that this deviation in amdgpu exists is
>> because of the ability to read the EDID from ACPI.
>>
>> See dm_helpers_probe_acpi_edid() for what it does.  Should we bump that
>> up to DRM core so all drivers could use it?
> 
> I guess would be nice to make it generic, but I'm not sure how many
> places might break. Maybe some of our cases might get fixed! ;D
> 
> I wonder if it could be opt-in in the connector?
> 
> BR,
> Jani.
> 

Take a look at the approach I came up with and see what you think.

https://lore.kernel.org/dri-devel/20261005194546.1712792-1-mario.limonciello@amd.com/

> 
>>
>> It was added to admgpu for consistency with Windows behavior - Windows
>> pulls from ACPI first.
>>
>> But if there isn't appettite for this being used everywhere; yeah maybe
>> switching to a callback might work too (I haven't prototyped it yet).
> 

