Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96A210F92E9
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0069610EC10;
	Tue, 31 Mar 2026 17:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GiCJjpE/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013033.outbound.protection.outlook.com
 [40.93.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 517D110EAB4;
 Tue, 31 Mar 2026 17:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5OAq/bngF0f4eBET5FP11+utW/tfn60BFNx/yRlcSRICXC+dppE1Cfrjmkz7IMdMwgu1nlpOMJEazyNzAwil0RWH/m088sUShcfPUmgtWBQP5ouzh9SDPFxc2D8WgfqcMF9TNi+KYss9LmuXHWVU3vD/g9xHwrlGQTkTSU8qcQ3gAqIAAvcKIl1gJ/4y7J4G0GqNxo1rWQbo01yIeLdgbhFT3tLT2lkR4We0BQ73A8CzhVEMzrVIL12RUiSLcVNc7mzJE6Bgzy4ngJzm8BLNHusHWfciTLpmi9DMPshgNHhP3yCWt5Xo0azx2YIoQDOZhtHOrk/N5y6Apz0T08oRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGwsU0MMe38vlWll4YzG1aMyykRkWQRX2OSgmEqlFrM=;
 b=FN46klQNF1ANl49DM3Z6cXZIfa9AgTvWi3IU0W59enmE2ifkJCb17SebDBZb0KW6DE+RcSjeK3IYmwiM2uh5GR8UUwk/oUOTNXRAPmETpfopqgz41R0/uU1yLQDPlIhhfn+su8UZ5wtnxYDEkgqvYK+HiP3sbnaOGR9xvl3ynKZtfGTGa4TxF/Vp+uXygRHkyH9DFOjMkX/pMnHeGU6aUYkWQgEABVCuktUO9c7gpt/lx3FmAbNolrQ/zRxT1Ccg8OVRm4I9zS5eGxhfyljO2O4hCv2rqUPmQRh5URD6wOATSLWva+Ie6kgaMczRryh2K2dXEdbTLCHmAFJR8NggQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGwsU0MMe38vlWll4YzG1aMyykRkWQRX2OSgmEqlFrM=;
 b=GiCJjpE/4u9kFenyKomh0XtspBwLWEjxvlTlAoIZFY74YsjUbR6JPqSfpDL6SOfYSuVTe1P5B8QbX/cKmUWDwEbsUBjd/vcDTfMTCxUTj6mQ5bJvDkg4/gHkMlVeSurnIf0BWafZKc5D7h/nYr1kvJBsTHEXAaxXhasANBKj41o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 17:38:00 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%6]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 17:38:00 +0000
Message-ID: <eb9b60f8-4eac-46e4-be9f-8ba1973c24ae@amd.com>
Date: Tue, 31 Mar 2026 13:37:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8676926.T7Z3S40VBb@workhorse>
 <eff61423-a854-44c1-8634-30e2bd61e005@mailbox.org>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <20260326155305.736b4e64@fluorite>
 <7461820c-e3ab-40f5-98d2-9878e60ba2ad@amd.com>
 <20260331132822.5ac57253@fluorite>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260331132822.5ac57253@fluorite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::9) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b384ad-9ada-442b-2b27-08de8f4c40f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: RWDgVFEBrGGJe0iw4SguAqdVix+C+FAi+sHGtmvyoUZCbSTEkAdg+xCCvXaS4ejE+hJzcXRByBBwlnHaLaR84A1qd2AShehG+dGdkcaX4FmHD9ghjmV60YU3H8H8vrMINfxmxDF+TbmLOcvzUu7kZG7OmtLOv64iOMu47kJQvjWQGBzqmGsy7lSRnH8A7nuW+jwGQmN+mGl+Yonx7oS0HXFbV5QYgz05uiicP1bQAfULrct9VbqZHwXZNEIiP3bAFdn49j1ThilVQKJLKR1YqxR8NAPBmVKj4uf1DCQSh6xNuUUNh8g1AFdy9fcWStDw/ElGc22YoGWSwYMtVUHBhOcisxZiK1jZKLNacUE6Nu9foaLd7Zw0Nu3qgdqmFsaXPuPOR1VJxO3ceja8v5t/kOf3GnnObDU195aFxNJLmUrQF0jKswMQ4CqMqZZQ5vbQlVA85k/L3gWnK4SkW2XpeFlQ4jdq/XINgZmsn3+LSLVMADXPJlbgSI2rVJz1oP9xuMqA+VWe1HbdBQWF8zNzlMTrtR9DvOzoWxDZltPhGlsTUAMxSWs9m3PbdZ6JxLVJXjj4CC7zx/Cdv4F17sPv0rehLOfa31AVdkKyvSYj+aeVLrfIIXXdWwaLTMCgxqdKpM6yZ0V3xvKFT5VGBcfMLVuvRUiKWx+0L697+YjGPQDDwcQ95EdDnCK+DM0SjITh05MaBWhCPp72sNfEoKbuEdfe89K5980bzmtZcVZ6isc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDN2Mk5TUGxhSHNQa2xEL3EyNmVkR0k5eWU4ZWNBck1ZMWpsTkx1RGRSblp5?=
 =?utf-8?B?eXorSVBmRmlzSjdtVHVld05ER3ZyZi9CZmVsUVhXVWV5SU9RZGVDbytGWVo3?=
 =?utf-8?B?ZU5ZSnhrSWR3cG1SbGRubXcrdHVTcGZtUHJXRThwUlJaaU44SWUwSXhVMUZH?=
 =?utf-8?B?T0xlMDVZSEhkWDAwcURPV2hxbEhGbXVWKzNvUDE5NmZMTDRrTURmakZFTkNu?=
 =?utf-8?B?enc2RW5tY0VUellUd01uUVllZHlPRStvQzIxK29KdXo5N0dEeTZuRkRqQ3R0?=
 =?utf-8?B?bTg5aTFQdzA0bENrL3VGZERCb2M4cUJGbjRLNG1ScGo1alM1MGtIRTE3Szk3?=
 =?utf-8?B?WUJWbmtPSWVaSlRHUlZaN3BqdjA3RGgyeWdSa0MzK2hRZHhzemR1S3pMYjlY?=
 =?utf-8?B?NitGNHNxbGpIM2V6dmNKNHZlemoxcUNFZk9ZVHh5bGNZY3JkVmRDZTVicmM2?=
 =?utf-8?B?czVSaDlidEl5WGs1NEZIdlZ6QVdXQ1B6VzNveVl0Z2FySXB5RTA0YVFYZlJE?=
 =?utf-8?B?Q21UR0VCNVY5dTcvOGYvT1Ruc0l6NWtXekxETUdSejBtTGhBRDlXdGZXLzIw?=
 =?utf-8?B?QkVZSStXZFFpVm80aFEvSnM4WEE3NU9mQmRKc3J0MkpUTjVSYWtnVk8vYVA4?=
 =?utf-8?B?aHZYV2xJV09wMmRoWSt0SGhuRDdKckJrZ0JqMytOYks3Tm5xMHErR0JNQnVh?=
 =?utf-8?B?SWJZL1NoT295RXhISDM5aE84dytRaEw2MFRZa2R3S1RLeEgxTWFWZGM4S1dM?=
 =?utf-8?B?UlBwQVNPV3lWKzloeVd4ajMyNUlyM0dUUXhhKzNzV25FbmU3Sjl4ZVBNM0Zr?=
 =?utf-8?B?Rm90cGQ4cCs4aTg2VGpVLzAxbkdrdkVwekJIbG9uWFg3TFNVUi9oUUxCbTFE?=
 =?utf-8?B?VWtjTXBZcEZyNGFRdklDblUwL3p0b1JIaU95V0xEUWl5MUdqRUtXSGRmREtV?=
 =?utf-8?B?aUFoNFBzYUZsS2tVMTNsTlpoREkyem5OVTlKWjhQN3E0ejFSMVlqNkdJUUw1?=
 =?utf-8?B?UnJEWGY4c25ISk1IaFNGT1ZSby9NZXc3ZHBEanZtV0FRQXFwLzFRelJlSGpY?=
 =?utf-8?B?bkFGcEN5VGVGQlVvNHVsd1Q1WGVKYnZ1LzhKQ0ZuMExDTzNTUXhxdDNCbXdS?=
 =?utf-8?B?V1RhaDlycThCV0VXNTIrOCtTQm45T2xKSEZ1aFlrS2U3VW8wQmJTcmNMeEQ4?=
 =?utf-8?B?SFFIQW9MK2RiV25hUHU4bjFFbWdKMytPc2tvc25SamlhYUNDM1hvVGF1WURX?=
 =?utf-8?B?NUpTai9qSnZuWVFDVU0zTFZiOHFPZmFMUjlucmtUUUVrRkhEaUVGQ1VpVENs?=
 =?utf-8?B?VE1SNHdndWRwcURKbHZpZ3lTSDRWWU9USmpvZ2V6ZXlBUEYxSnVEdVNqcUVD?=
 =?utf-8?B?TmlPcnpiVGxtMDY5UmlaL1lsOHNpVU1rMjZzSVpwM3FJdFZhekZ5MmsraVgw?=
 =?utf-8?B?N2ZrS0I1Rks1dWVwZk9jNk9lSm9YMDhxOTdBTTF5enJOS2o5TWdTVFgvQ0ZV?=
 =?utf-8?B?VmxnMmx0ZUNJMS9PQ2hqcUVKM0tyS1dHdGtJYzFpL2J3VFE3eTUyNlRYeWVN?=
 =?utf-8?B?bHorb3V0d3ZyQWtWVWowNzNrZmllcGh6ZHgvTnNjMWd1SlNVRWdRa2NFdTZr?=
 =?utf-8?B?RkpMUUppVS9yUEpJaTdzdzZLS3NHc1V5L0w5ZTZ1a0dOb0VxNWRCWStBQVlK?=
 =?utf-8?B?eGRCdmFRSmxpZFcvckNCLy9TS1QxOTVQaDlWeGxwaGVzU1kwZ3lMWC95dHJW?=
 =?utf-8?B?Z0VKUDBGbW9kdTQ0Q0pKbXU4Y2NMOTh6VUw2WVVsbHI1V0pGU0I3MFNXUlFq?=
 =?utf-8?B?QUx4cjN0a2hlSS91ajFBbzAyRFI1aWs2bElnb2NhZExZaFNPKzFrZTZsYVh2?=
 =?utf-8?B?NUN4NGxqYk1EWUxPekIwT1BrY1YrYWlZNWxUclozZkV0RnZjNkRpUzRNN0Fl?=
 =?utf-8?B?THZFcDBQQkFSbGl6ZVNGbCt5ZnptcjdjQUZZd1J1WEJrbVFWK3dvbkpXN2lD?=
 =?utf-8?B?T2FHZm9ieU1zcU1qWDNkOERMaHljczhOQU5TMVZhelNWWW9EaDRRVDBEWWpR?=
 =?utf-8?B?ZnlDSE4zSXhFNmxHU1dFN0N3K2pDcWRQZldmOU9BRVErWHpLb3NCVVhicWR1?=
 =?utf-8?B?MEQ3Ujl4Z3A2Nmw0aXFMc1ZLenczWGppUGw1aGc3NlM2UGpwT2g5emdPZy9D?=
 =?utf-8?B?RGtWaXhJdlhkY1pFSmdMY2JKaDMvRlQ0V2pjWHVOWU9Hb28wM0szeHVkT2RQ?=
 =?utf-8?B?Z0dYVjY5QXRuLzIvd0gwVDdjOTc4Zzg0Vnl5UmVLRDJEVFFpSTVOTGFoQStl?=
 =?utf-8?B?eGxEdlcvN2xlRmQvekJEWmZ1R3hSWUw3UU5VTHlLaEVLNStXYUJVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b384ad-9ada-442b-2b27-08de8f4c40f0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:38:00.4616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iuGsEQvCXkdEVeHGyhE+5wlLklBdDtOq+d6JIr5zcimm6574/Fscrr4gn3nh2n3i8dZ6G0xr1DypQqkM+I+xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
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



On 2026-03-31 06:28, Pekka Paalanen wrote:
> On Mon, 30 Mar 2026 15:01:33 -0400
> Harry Wentland <harry.wentland@amd.com> wrote:
> 
>> On 2026-03-26 09:53, Pekka Paalanen wrote:
>>> Hi Michel,
>>>
>>> I have some opinions as well.
>>>
>>> On Tue, 24 Mar 2026 17:44:21 +0100
>>> Michel Dänzer <michel.daenzer@mailbox.org> wrote:
>>>   
>>>> Per my previous posts, my concerns are:
>>>>
>>>> * The meaning of the "link bpc" property value isn't defined well
>>>> enough vs things like dithering or DSC, which will likely result in
>>>> compositors / users overestimating what value they need / want,
>>>> resulting in compositors spuriously rejecting configurations which
>>>> would work perfectly fine, and/or spurious issue reports.  
>>>
>>> That is ok. Compositors need to understand what the numbers mean, how
>>> reliable they are, and act accordingly. Knowing the lower bound for
>>> link precision is already useful as it guarantees a minimum precision.
>>> It is up to the compositors to decide how they communicate this.
>>>
>>> Or course, assuming lossy compression is not too lossy. Maybe
>>> lossy compression should be forbidden by default unless explicitly
>>> enabled by userspace?
>>>   
>>
>> I disagree. While technically lossy, DSC is perceptually lossless, at
>> least according to the designers of DSC. If I'm not mistaken this is
>> all based on extensive studies.
>>
>> The decision to enable DSC or not has an impact on the power consumption
>> of the HW, in ways that are often nuanced. Userspace has no way to know
>> or understand these nuances. This should be in control of the driver.
> 
> I guess time will tell.
> 
> Are you saying that enabling DSC might have disadvantages aside from
> image quality?
> 

The opposite; enabling DSC might have advantages, in particular in power
efficiency. And image quality impacts are negligible or (perceptually)
non-existant, from my understanding. Afaik, Apple, which prides itself
on image quality and being a platform for content producers, enables DSC
by default on their systems.

>> At most I could see a "never do DSC or dither" toggle, if one is really
>> concerned about this, but I don't realistically see use-cases where this
>> would improve user experience, even for users that care about color work
>> and correctness.
> 
> I'm not familiar with DSC, so I cannot criticise it. Dithering OTOH
> seems to be obviously suspect though.
> 
> Temporal dithering - what if your refresh rate is 30 Hz for some movie
> playback?
> 
> Spatial dithering - what if you have a low-resolution screen?
> 
> I would not assume that dithering is always ok, and always achieves its
> theoretical results.
> 

Quite possibly, but we haven't really seen complaints about dither other
than in scenarios where people explictly test that input pixels equal
output pixels exactly.

>> The YCbCr420 case is different. We probably want a way for userspace to
>> understand that half 3/4 of chroma values are being tossed out. This
>> would be significant for RGB content but insignificant for YCbCr420
>> content.
> 
> Do you mean full resolution vs. chroma sub-sampled to 2x2 blocks? I
> would again not assume "insignificant", because it depends on the
> picture content and angular pixel density (can you see individual
> pixels at your viewing distance). Gray-scale text will be fine, but
> colored text is another question.
> 

Yes. I think downgrading an output to YCbCr420 (chroma sub-sampled to
2x2 blocks) is a significant image quality impact.

> I'm fine with proceeding with these assumptions, as long as it is
> acknowledged that these assumptions might turn out false later and have
> a contingency plan.
> 

I guess that goes to Michel's question about what's expected of
compositors here and whether there is clarity... I'm not sure
I really have an answer on that other than documenting our
expectations.

Harry

> 
> Thanks,
> pq

