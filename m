Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED764C98324
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2364010FAC8;
	Fri, 25 Sep 2026 14:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RgfCkIA9";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E632310FABC;
 Fri, 25 Sep 2026 14:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diKeXp8rY6bYgvbhyq9tRfJQMXu2r1PdMkq71z6yXnudWPsO3eBzzBpzoKVSkxohbIs3IioEMNRPCIWIAGQi8tZJXE75dpwTFZE2Z2LqGGoChgCqJY0f0LFLOPE+D60pSS7iZuX9ISXIsM2FO/DGGDlFVSjmeV2k/2LBBSXGQmFqcruhxh47XSN1pRFlgxDw8tO3AMbC+n6j5xFkKgoe8zfIco28OjeWxQ+Hb+K6ldOEagx77nc6PWPMzgAL08120hfvLH0yO6FvjfdcVjM8TjVlL1dsZ3e2yGNm0pLuuu4+lC3oC77APPGwh5w4Wo3pKZAduHq+x/6w2Srzkg/XYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok0DJyNkZQcQMeHkdTkYqnEmiAl7UYk/I0dlTU3U6+c=;
 b=bm2jxqlQOWZvtMc9t6Bv4KGvBpVEY9LUrtgeL+3qoHsSI/sdDzRSxJSxNf62cBMR8dVliYBh8U+RMXLPZaDinw7uXf3UpUHpGbxVf2rmdF1zXL3+a7CP0dXJKl10QPE7p1/ks7SHiqYqlP5mTSlNjMk8hhLIcznv8hvyYsSLXX/3NjkC9x8QpZ+4NwAaFKOAyr7wjXQhTumxO8+dROHLL7DXvkJSgilWUMh3wc16+imU7gIhm1TS0rtYFLOxkXuTYeFj3xxPkqqDqJr21cd6W2/8Cu7R4assWGwQeecI4Hk9TeibL1f2MO5hIQJb0lukQAhGwvBIR9B8WwwaeQpW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok0DJyNkZQcQMeHkdTkYqnEmiAl7UYk/I0dlTU3U6+c=;
 b=RgfCkIA99tnQxeAwU7xllfWp2b9txMWsws8Wlhgm5h8ME03Tfxs/4phv/lccxeL9cTyyam4jU+zUS9Q6AndWtQBn4oC1gsyAUBQ2/dVTceNAd7GtU5LYVCJ/+P7k5ziRsYpnMMuTXUqBiD9syJycGnELM0+Bzu733YT10MDmJz8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:00:53 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:00:53 +0000
Message-ID: <9a917ebe-9d9d-409d-8913-89b448425726@amd.com>
Date: Fri, 25 Sep 2026 09:00:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] VESA DisplayID fixed DSC BPP value support
Content-Language: en-US
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Yaroslav Bolyukin <iam@0la.ch>, Yaroslav Bolyukin <iam@lach.pw>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Wayne Lin <Wayne.Lin@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20251202110218.9212-1-iam@lach.pw>
 <5d1fc27a-eea0-4995-8b8e-46006144ae7b@0la.ch>
 <5b7332c6bc0c7b7f9ba0d95477a5b9f438a07ff6@intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5b7332c6bc0c7b7f9ba0d95477a5b9f438a07ff6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::25) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 7320a71c-3bd5-44fc-b592-08df1b0d6950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: U+CTrM91UcRJtEB0es6/jKuyVFj3T5hD+Bwcm2tsKyDPTDGCS6vTTafc6LAciUNxykidRFBo15aztYr8MKRxzLcYx/tM/MYhRuc/6LmLhMmg0cC94eNCHXASZmiuwXIlqUrKNAvvbEfQB88rF4L6rU2v4269wzctmszVe79u5ihcegAQnLV13AazpKZgUX+biRG0O5GCyMpQGkC4xLx2RP2wjVmKRpWU/+gshJk54qM9btDOTBrZ2D0SNShSQ9d7shiqlLwzddbYA+WPLexUvKYWYzHPLZvFMTJmZolPc17mJtWvoZd2h9pk34xQRGMkm7ve2hdM4NlTYdBX0zMleI/itWZmJsOLJ1AVHjWFm50lP1Im7YMSB8dXTnuJii6qiH86CXfC/GwpS2pVCtYl5U+Ua4RvYGnpPo9jt1Y/WPdYOWatUUC1v4P9TgsZt3wcTNxcKWZ8eVmiYhg62fBkkSpuvz8hv0DK6HCr6slltNsG2UK7Ks5RYTMPZvONgLToO1NlbpEBIhoVAbOhaZGQpJrXH8dFDQX3fv629K924VzCm9ts9tZoPx35twyRiVuiV94ofhy4v+wzk7xN6i/2Hiy8sP+jaV550wd5rUa9cq5QVBWj3Yg5rsinXlF8Mwp6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTlRbXl4YW1FM3NFTU5STkg4Y0QxVUhuZ2tPdThOejFLejhNR3V6bVp5Z21Q?=
 =?utf-8?B?bzRRNzNPYkQ1NDBNeUFsZnpRWDAxV0dlNWR4ZW9ENTdiOEtPLzIyMjN5TmZ5?=
 =?utf-8?B?TmpNN0tYUkpHaXBHakRIVVBQeXhISGdhSEQ3UDljd21YRHR2ekE5Y0JQYVlP?=
 =?utf-8?B?N2k2ZDdNa2R6eEUwWi9uSm9pbDVYb2pVR3lOcVZEaUE5UE1LYzNON3NnVTZ5?=
 =?utf-8?B?NGdsYzE2UkpVRHBpZHN4aHE5WGNjeXlNTDVTMERHQzFxSzBCOVdGbCtuL1VD?=
 =?utf-8?B?MUg0WlBkZHZjUVRzdHNhVkxLd2J1U1BCdkhXSkhIbk9hZ2loMXM3VnFtcWVr?=
 =?utf-8?B?SXpWcEsrSEJiYkxGM0d5NEw0T2VnZXpFeVFWM0wzWWc0Q0VUSDdxeWZqcldz?=
 =?utf-8?B?QS9nRC8yZGtwWTlPTmFpa2EydnFnZWlJanhyTlRNUEYycDd1d2xoelZWYUU3?=
 =?utf-8?B?b1pQN2R3bDZkbHR4ZENHbFF5bGFnSG15WWthakhJMitLVHFNaUNhVVIyTEcx?=
 =?utf-8?B?YXRFb3VmRnhQcFd2OUorQng2bzk4djFsd3lTNWhiazZMTjRGcy9RSVk1LzBN?=
 =?utf-8?B?NjdRQ2ZTd3FyZWpGM0xsL2Z4M2l4dGZoVUYyUklkUUltQlhnZWtpQWlkeVov?=
 =?utf-8?B?RmVqMmpVOG1ldWZ6QjBmcFVubXgvZjBCZFk4R0ZGOGx3Zlpkc24xM09ZaUk4?=
 =?utf-8?B?cEd5UTRNajhMWnBFbXAxdEg3eHpINElTVTMwYlB6V2ZHanFTcUptZDNxTFlZ?=
 =?utf-8?B?bk8yK3drUnJTSnFqVEpiRzEyd2NQc3NDellkdG9SSzkwbWx0bjR2QXRvOUtt?=
 =?utf-8?B?V3h0TlVVM0RDdFBKM3ZueEVjbkFzYVFiYlREUHo4eDFHKzJlU3RMcXdFcXlK?=
 =?utf-8?B?RlljY24xeHo0b2JtTmJsZ1FjQjhkWDZiT09ZWHBZb0ZCV0xnMDBoTExwWm04?=
 =?utf-8?B?SFpFWGJlR0xudENqSXZHd2M3QkJxNzJ0QXF2c05oYUZuTWQvZERJU1NNdWlX?=
 =?utf-8?B?Q1dJUll1RFIzdmhnVHFDU0FYQ1dpZlFOU2ptMlFOb2tRMGFlOVAxaGl5WnpS?=
 =?utf-8?B?UlUrOTE5SytoeFBwSjJpSDlkSm9Ec29CWVFwSTA2a09vSWM3MEVMMlFwSjF3?=
 =?utf-8?B?dzJOaXdhUStPSzRXZWFNL2dkalFBaGxqR3hHQ0pENDh4VVJqbkJSaTRyV3ZR?=
 =?utf-8?B?QjFYTFYvNXlEYlFYQUM3UzlkZ3A5QjgrOTdzZERXVDBKUkoxVTlyY213UWZJ?=
 =?utf-8?B?TUZUYlAwL3R6QkRvUFlEN05veHRqeFd1ZVg1SStwVEIwYjU5Q2JLZldzRDNa?=
 =?utf-8?B?WkV2MkFQZ3E2ZGh6R2FoVThkL2E2cE1yc21sSHBIWno4OU82TFEyNTNxd2Yz?=
 =?utf-8?B?MGNTL3E1cVN0T3Z4bi9JdmJBUHRsNnE2QS9zTkRMVzhNNEljd2J5aXE5c2F2?=
 =?utf-8?B?ZHhkNXVWSUl5QVJHb2lmbXRvby9kaGV1dy8xejVHdDBMVGpLcUxVcXRjaTdp?=
 =?utf-8?B?QUNHSXB3azF6YWsrR2wrMktzd1BGbjVrU3dpZHg5T2lNQURMYTI0a0FJbDVN?=
 =?utf-8?B?UVYraU9sbitsK1JER2h3SUtyYW9hSE1BeVljNDFHc2xwUFQxaGlvVjQ1MTFN?=
 =?utf-8?B?SmRDdmZFaDE0ZmZJZWZGQURkRlI5enJXVCtZaUxCcWVVUmZ3RUNyc0VoMzQ1?=
 =?utf-8?B?b1poRTJYZTJOKzF1Ni91N1FWeUUwNHVDM29lWFNncSs1RWhOb2VERzBrRFBD?=
 =?utf-8?B?WXlvOXE4c1REbzhudUduOXozWXFSN2ErVXBYdzR1MUY1ZjZ1L3E3dHRKRm9E?=
 =?utf-8?B?eHFEbkROQTM0SzNlcHpKZDZFTXpjSlpicVZNT0ZHYlA3ZDY0Ui8vdmxsdDNh?=
 =?utf-8?B?VFd4Ry9NeUhJa1RPZVkyUXhKOUxJdzhBZS9abjdWRjdnT3h2MmRDQ0hadXBs?=
 =?utf-8?B?czZoUXU0bDhGb1FsUDE2MG83aGV5Wk1KMmhybVFMc29XdTJKZEx2M2hRQzJY?=
 =?utf-8?B?bndrcEFMTG9OT1NhNVZ6RXR6aW4rV2xaZldJL2FaQXF2WkhQMDdPaE5iU0dm?=
 =?utf-8?B?aGFnTTVrVnU3ODdadE9PSkdEdnk1aDI4NWdmbUZRNGtrbWkxcFBjQjhvT2Fm?=
 =?utf-8?B?blJONGlJZ3duaHFzT0dKWlBaRCtGaFg3SURsWTJUMjFMN2hQUCt3RWVXeUQ4?=
 =?utf-8?B?QllGYXByclhOdklBZ3ZqZFZuWXVoVE82UjVMMXdGY1Yyc2hFUXBvMFkyWmZj?=
 =?utf-8?B?ditoRUhkNkx1bjJXZGlnUlBGWFZ3UlNFbm8xMENjUU5kUlBiS1NMTURGaVJH?=
 =?utf-8?Q?XFPkNLATvYhIj8jhLO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7320a71c-3bd5-44fc-b592-08df1b0d6950
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:00:52.8055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsqzNf3r9fnEDr+1Oga1fGfVzpfJXoHTSeWyDMWv5KrOSgNPkgQhcL5JIc11nom8qbk6n/5QVlu/y/zCJTr7zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
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



On 1/9/26 02:15, Jani Nikula wrote:
> On Thu, 08 Jan 2026, Yaroslav Bolyukin <iam@0la.ch> wrote:
>> Hi,
>>
>> Now that every patch in this patchset has a review, any chance this can
>> be picked up for drm-misc-next?
>>
>> Or should it go through amd-staging-drm-next, given that the main EDID
>> change is only handled for amdgpu driver right now?
> 
> As I said in [1] I'm hoping to get Ville's approval on the approach, as
> he had earlier concerns [2].
> 
> BR,
> Jani.
> 
> [1] https://lore.kernel.org/r/b0b1567707c91806e3758bf0b678c2038dffb3c2@intel.com
> 
> [2] https://lore.kernel.org/r/aPF32XpVst5mPVz7@intel.com
> 

Ville,

Can you take a look at this series per Jani's comments?  Here is the 
full series lore link if you don't have it.

https://lore.kernel.org/all/20251202110218.9212-1-iam@lach.pw/


>>
>> Best regards,
>> Lach
>>
>> On 2025-12-02 12:02, Yaroslav Bolyukin wrote:
>>> VESA DisplayID spec allows the device to force its DSC bits per pixel
>>> value.
>>>
>>> For example, the HTC Vive Pro 2 VR headset uses this value in
>>> high-resolution modes (3680x1836@90-120, 4896x2448@90-120), and when the
>>> kernel doesn't respect this parameter, garbage is displayed on the HMD
>>> instead.
>>>
>>> Me and other users have successfully tested the old (v3) version of this
>>> patch (which was applying DSC BPP value unconditionally, thus incorrect:
>>> https://lkml.org/lkml/2023/2/26/116) on Vive Pro 2 and
>>> Bigscreen Beyond VR headsets, and have been using it daily, it is known
>>> to work and doesn't seem to break anything else since 2022.
>>>
>>> Previously, I didn't have enough dedication to get it merged, I hope
>>> this time I will manage to get it to v6.19 :D
>>>
>>> Regarding driver support - I have looked at amdgpu and Nvidia's
>>> open-gpu-kernel-modules, and both seem to have some indication for this
>>> value; however, in Linux, it is unused in both.
>>>
>>> First patch implements parsing of DSC BPP values and display mode VII
>>> timings flag which mandates that the DSC BPP value should actually be
>>> used for this display mode.
>>>
>>> The second patch implements handling of this value for AMDGPU driver.
>>>
>>> The only thing that I don't like in the current implementation, is how
>>> the value of `dsc_passthrough_timings_support` flag is propagated from
>>> the connector display modes to the mode created in `DRM_IOCTL_MODE_SETCRTC`
>>> handler (which is used for VR display initialization in Monado and
>>> StreamVR), it feels like this flag should be initialized by the kernel
>>> itself, but as far as I can see there is no correct way to do this, as
>>> the timing constraints calculation belongs to the individual drivers.
>>>
>>> Another problem with how this flag is set, is that there is no hard
>>> connection between modes creaded in `SETCRTC` and the modes actually
>>> defined by connector, so the current implementation searches for the
>>> resolution and refresh rate that match exactly declared to obtain
>>> this flag value. This might not be correct, as device might not support
>>> the other mode at all, but the situation won't be any worse for the
>>> existing devices, as the currently they don't work at all, and there
>>> is no other known devices on the market to check their assumption in
>>> regard to this part of specs, and the spec does not describe how that
>>> should work.
>>>
>>> Both of those downsides are due to the fact my understanding of DRM
>>> subsystem is not that high. If another implementation would be proposed
>>> by AMDGPU maintainers - I will gladly implement it here.
>>>
>>> v6->v7:
>>>    * Print DSC bpp value in fixed point format instead of x16
>>>    * MSO should only be enabled for eDP, not the other way round.
>>> v5->v6:
>>>    * amdgpu: only apply dsc bpp to modes that match exactly the declared
>>>      modes with this flag set.
>>> v4->v5:
>>>    * The patch was split into multiple
>>>    * Disabled MSO parsing for eDP displays
>>>    * Disabled MSO logs if not used
>>>    * Minor codestyle changes: lines moved around, naming, passing of
>>>      function arguments
>>> v3->v4:
>>>    * This patch now parses timings support flag on type VII block, instead
>>>      of applying it unconditionally. Previously I didn't understand the
>>>      spec properly.
>>>    * Now it also is not being applied for non-supported and/or non-VII
>>>      blocks in amdgpu driver.
>>>
>>> Regards,
>>>
>>> Lach
>>>
>>> Yaroslav Bolyukin (7):
>>>     drm/edid: rename VESA block parsing functions to more generic name
>>>     drm/edid: prepare for VESA vendor-specific data block extension
>>>     drm/edid: MSO should only be used for non-eDP displays
>>>     drm/edid: parse DSC DPP passthru support flag for mode VII timings
>>>     drm/edid: for consistency, use mask everywhere for block rev parsing
>>>     drm/edid: parse DRM VESA dsc bpp target
>>>     drm/amd: use fixed dsc bits-per-pixel from edid
>>>
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  16 +++
>>>    drivers/gpu/drm/drm_displayid_internal.h      |  11 ++
>>>    drivers/gpu/drm/drm_edid.c                    | 102 +++++++++++-------
>>>    include/drm/drm_connector.h                   |   6 ++
>>>    include/drm/drm_modes.h                       |  10 ++
>>>    5 files changed, 109 insertions(+), 36 deletions(-)
>>>
> 

