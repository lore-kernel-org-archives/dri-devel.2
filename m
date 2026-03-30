Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0615E1061B18
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1E010E711;
	Mon, 30 Mar 2026 19:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WZZGOEVF";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F8710E653;
 Mon, 30 Mar 2026 19:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPhrOLCyq1eAk1TtJGrc5BCRN5yuZRXFgJW6uGaixT9jU1V3MIoHm2jA7tI8h+6NFfNfMsYV9MS5LdXCuDw67z53cm2rK5pE7hrayFUSoP8rKD9A9RE6qE56YB7hT1QkcZ3CMjWYWEoxP/LhXEqm6gS8dQvcJLj24zexAou728/OgRbsL8UCz5nwaadh1L10mAVk6NblyKhcAYeEOdk/CqQDh8+mzp8jW514kMjybfAWEBap8mPCOIgt50oBeeiALkVsBF/thA82L0I61bNxqThEeKoQeiSugJ1b2mT3N2xnsSQAl/ngZZcD0Zr13wSCVxm0EJ+DmXz7aGszZ40JVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dN1fC1/tBnzAkXcN4UCYZt1aGqwlgOuCQbU/frxNFY=;
 b=orJvWYDBHUxEJ74j1kB93GuYzrc0fM8ABFh44B4z46mmqCzNN2d5/qRT1n0oWABoLOzjVn7Ha/V7bnCaTlnO20DFwJTFOvBvQ5Sk0AWxmdrQoWqG+6YYJOk19jJNaAJIpzP0/4D2m7/gVM5IM50y7Ts+uEnEIHTLlosK5Gg6uA229PGJ5FzCAR2+w1vKmX86Z7kz162oR9TtIxgUbnunGpFxf/it1PGZrJhB/vmeVRUXdhUlP34XpQHuCkBf6/mJdBWQwc/VOl5T3voSdxQRSy2qog5qDBPrd5Sn1bLFlwtYFw1taANd7R5OTqItiytZpJ5mPeOCHlXUzzz/ko00+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dN1fC1/tBnzAkXcN4UCYZt1aGqwlgOuCQbU/frxNFY=;
 b=WZZGOEVFDNJ/UzgyydwPQ9FjCBlqgsxBkJZucq5rAAz2cOzuiPGTQ1sJT4Kbid03iPwQlqjB4Xrm33ux+ZDyt2P6qW8blkSNDAI9DDlA17s7hY2NGWcgi/TR1qslR7fsn9Yiov6dyn4iwkD27mjRt1hX88ty/WDi+ckeOET5et8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:01:42 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 19:01:41 +0000
Message-ID: <7461820c-e3ab-40f5-98d2-9878e60ba2ad@amd.com>
Date: Mon, 30 Mar 2026 15:01:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
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
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260326155305.736b4e64@fluorite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::10) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a442ae-5c1d-493a-c11f-08de8e8ec78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: V6hknlNg598xTMf80R9iWWYVaJ3R4HgJL4zrUwRziI6BUOm2vHJcejZWskIBCsePa70uiKuMfR5v6I9lFR8v4EnSiihSHbRyRhYPL70bKaqmdCBRKLPZ8E1yo3jtWQpYp3izpE8wiLMW0sFPRHkO+3BxIQP1LjRnvMDNs47knLvekVq6MQasUJhHFL/+3upwh6gwffZUO0H1iSFplZ7/bJkV/TlVZlxX2t6UDTLic74bMAyMJ5T4APjc8r7T6qwaAdcAZkqifXpgGYzfL8Y0dUPKZ3dvUBy8zQmmtlHjQYYhrQqdqNyR4BHoTuc2oiWLbhwqq8tYZpMzUBrfEUQUdufnTBPnCk7rEzDs2BkoT9Y1iHmV8DAfWm26eWY1RsLb6JsX/gKUGBjcwVM4Brgu0bmSKZH6ymCRECXfzR1rIIGVRR5tklYR7sDVS/TMN+0h03Smt59i3pn7DimR9OuJ0QVAiCiU/fhT/OvWPUTlWYNLfNFy/LeshlccyS1rWWb2v0+ezbVKRlSiI5g66OQCvMp7u0MIENDW/35o25ca4Oxdjzo77p3ONJAe+DjK5IDP9Oomv6Q/v3y+QVW/7FqT6CtPO3Q4ALG7qpQDQRZRYXAhjxw/fQLoM4r/KPJ3iHfeBDP8W0xWpYzrkmlHspfQHaitbuM3ftdoyZkvi/IYCcMMp5p9XBDXwpCcF+v7Tie7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2tQR1ViTzB5b29CY3YvbDY4c2l2aHpxU1VTcHU3ZmliYlpKTlRWY29IZlJv?=
 =?utf-8?B?aGV3TGtIRkdEc1hsVDZ4akNzSFVoa1VuVkRtTEZrcmxEZmRGOEZ0K203RzZt?=
 =?utf-8?B?LzNObS9WaE1POXQ5N3ZNTE9rUHg0enFoR2lob0JGZ0ErMzNNWEtpNnB1azlJ?=
 =?utf-8?B?YmFSK2p2M1d4WmkyVWJXOGdKaUdzS2JDMlJqTkZ5QWZmRWFOcng2c0h0WER3?=
 =?utf-8?B?YllSbVZKV3ZqTFVDdXpEcGRvK05MN3hEZ1lORUxaRUtVNHdtLzZYZjBVUFhy?=
 =?utf-8?B?ay9lYnc5TVZMRFZmblZCd29SVzF6QUxRZnd0TWh2dnpqL0EvZ1hYR2xaVUxw?=
 =?utf-8?B?M1JZSjFSejRmbGJjbW9rWEpwaDczRWhVWTlKOHRJSXZVMFF3ZFpmS05ycE9B?=
 =?utf-8?B?QmRCNDRFc0FqSUFzYkpGaHFUVmxaTldhUCtZNnBlWlZrY0JnWFVaVm5TWFIy?=
 =?utf-8?B?YlBsWUhHbTgvZXdZTGtTSWFLc1BaT3RoQm1zcFYyUnMvQk1FTkRTc1RNZTdw?=
 =?utf-8?B?cklud0JKVnhkaXJNKzNOMklRYWdZVG5rNk9zWk5OcFZ1MFVRMEw5b09EUkNm?=
 =?utf-8?B?dEhwZ20zMUtrZGRYMkQzRWJJSjhjZXZDdEdtREUxbkVPZUR6THQ3TzFFVkVT?=
 =?utf-8?B?UzZKSXp2NkJsRWd1Z0NjVk9LbVVVV083RUt2bExIMkdwWndwNWRwUndnNWVM?=
 =?utf-8?B?QnNTNHlkWjY5THhwTDQ3clRrN3JHTGxNUGtRdk52dUhhZTFZY0xYbm1JMlhn?=
 =?utf-8?B?YnEwUVFnRWVlL0hwcnh4dk44cGIxSTZHKzJDL2JpV3p4L2w0cmZmTHJBK2VP?=
 =?utf-8?B?V3BFVVRCYTNFQVUralZpUUVuVjNuclIzYStLWlJuVHhqSnl2VnZiNXVBRXRs?=
 =?utf-8?B?MDI4SU00YnJZdElzMXdPelNEQnd3SkR4SzZSWUkvVmNrb0k1OW4vSU43RVY5?=
 =?utf-8?B?d1gwY3RGb1JpSkdCaTB3WEkrR1c1c3FMRjZrUndDb254a3ExQUFwVDhMSFFz?=
 =?utf-8?B?NVJQQ01QNXcrNHpuNThvVVhaZGlodTVxSForaGtwM3BFc2tDZmtYeGRMbWt0?=
 =?utf-8?B?MjZSYURXRzJCbk9SenBIa2tvdUhTWG4wckhmNkViVHZXMTU4dkNabjNHZ0Jx?=
 =?utf-8?B?MGlIMVFnUHczNWlXV1Q5ZXJYL3BjQ2tvcjlhSzI4TnR0YjVjTmVRSk5aa2JC?=
 =?utf-8?B?UFRlYzQ3WEI4RFllMVBBbTZIelFSSVZXSnJvTFJJSTNNYTRFMURDY1d4NVRX?=
 =?utf-8?B?V2g5R2JiQnFoS3pIZmFOUXBVQmJiMkxja29DdlQ4VUZXWTNuaWQzVzdVNW5L?=
 =?utf-8?B?S2dRakg5U1VXekVaRW44MURKSUgwbU4wUWVQY3lmOW5yQytoamZOaWFhbm9S?=
 =?utf-8?B?VTZsTlZZNGttT1g1am1ZUGZjMUVaYWkzWFRZeTA3YXV6bGhueHE5TFhHZDMr?=
 =?utf-8?B?K2dVa2MxMFRBdE5NU0dNdXAydHFWWGlLTVRPQjk0Tk5EbldrY0JzNStyNUxS?=
 =?utf-8?B?K3JycG9WNkUyKzQyRVVDQ2hNYjYvMnVWUlBiSjFib1kzVHV6b0t5dFczQ2dV?=
 =?utf-8?B?VEg4SXcyQlgrVXIrRlF3MktzVlUrZEVWOXNEQzhiWUR0TEQ0M3BFWWtpT2hB?=
 =?utf-8?B?QW1iT1lDYk5teis3S2xtcnNOQ2J3Z0pjZEoyaUFoWTN0cGdPekNkOUc2VDBO?=
 =?utf-8?B?TDV2Ni9ETFBUSERxdU9YanlpdmdQbDZGWE42anl6bGkzdUJCUmFzeG80aVVI?=
 =?utf-8?B?UTdkYjQ2UXFuM0UyNGQ0ZkQ3cXo4cExsK0o2WUJXRkpYeXhpUlZ3TlBjWDM0?=
 =?utf-8?B?cXFhZGVleEJqeUNkUlUrSlpsaWJLWUJpS0UzV3o4cXAzZ0hWemdlSFplZDdH?=
 =?utf-8?B?enkwV3ViaUlobHlMVFk1Q0xhNFlnQXlzNHpSYXBQQkdlcytaSWZTays2SVBZ?=
 =?utf-8?B?NDgyRG5UQzhnY2QzdWswZXVJd3N3Q0tXcy9uczY4Y1IrbEpMVGFqMVB2ampu?=
 =?utf-8?B?YWMwRkxhM05zeWd4M2tVRE1YMDJuRTJQNGxQamVvalloRG9GZEI5M0ZTUm96?=
 =?utf-8?B?ZVJQRFY3aW1kMitBSXFpUkRBZE0vSkJKREtKVmNxT211MDlqNnVHVzBsbU9r?=
 =?utf-8?B?bGs5V2c3S1FVZ2lISnRRcGtTbUtWaHg5YThIWG55SnJkSm9CaC9kNGszN3l2?=
 =?utf-8?B?bHNidHpvVGRoQVF4dzJnWGorRk9wTkw0dkFVenNiYkRqNW1QNUg3czVrWmJS?=
 =?utf-8?B?MDVNZVl6c1hkeGxkanA4Y0p3b2NTeE00QkdTb2RUTlFxNUl2YjZVTnl4UVNa?=
 =?utf-8?B?dUhHdGFjeG9DeFR5Wk83TVBtWmM4MWQ0NEtQWjArbkNDZ1E4MDB2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a442ae-5c1d-493a-c11f-08de8e8ec78a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:01:41.8636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe4k1XDiJJsLoVCwYmxGBZ/0ySG9zmHkB34gQS17MOxxvRGe6khEWP9uDO+ORH/wqvdGU76e7n6U2UGe62prwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
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



On 2026-03-26 09:53, Pekka Paalanen wrote:
> Hi Michel,
> 
> I have some opinions as well.
> 
> On Tue, 24 Mar 2026 17:44:21 +0100
> Michel Dänzer <michel.daenzer@mailbox.org> wrote:
> 
>> Per my previous posts, my concerns are:
>>
>> * The meaning of the "link bpc" property value isn't defined well
>> enough vs things like dithering or DSC, which will likely result in
>> compositors / users overestimating what value they need / want,
>> resulting in compositors spuriously rejecting configurations which
>> would work perfectly fine, and/or spurious issue reports.
> 
> That is ok. Compositors need to understand what the numbers mean, how
> reliable they are, and act accordingly. Knowing the lower bound for
> link precision is already useful as it guarantees a minimum precision.
> It is up to the compositors to decide how they communicate this.
> 
> Or course, assuming lossy compression is not too lossy. Maybe
> lossy compression should be forbidden by default unless explicitly
> enabled by userspace?
> 

I disagree. While technically lossy, DSC is perceptually lossless, at
least according to the designers of DSC. If I'm not mistaken this is
all based on extensive studies.

The decision to enable DSC or not has an impact on the power consumption
of the HW, in ways that are often nuanced. Userspace has no way to know
or understand these nuances. This should be in control of the driver.

At most I could see a "never do DSC or dither" toggle, if one is really
concerned about this, but I don't realistically see use-cases where this
would improve user experience, even for users that care about color work
and correctness.

The YCbCr420 case is different. We probably want a way for userspace to
understand that half 3/4 of chroma values are being tossed out. This
would be significant for RGB content but insignificant for YCbCr420
content.

Harry

>> With my compositor developer hat on, what I'd want to know is
>> something like: "How many bits of information can be passed over the
>> link, allowing the display to present it in a way which can be
>> perceived by the user?" With dithering or DSC, that would be a higher
>> value than the physical link bpc.
> 
> Sure, but this is not that. This is only a part of that. You would
> also want to know what the monitor does with the signal, the depth of
> the data path to the panel, and so on. I'm sure those are completely
> off-topic for a KMS property.
> 
> The kernel driver won't know how acceptable temporal dithering, spatial
> dithering or lossy compression are, so I don't think it should be
> deciding how many bits of precision they add or subtract. Exactly this
> makes the link bpc property a well-defined fact rather than an estimate.
> 
> The documentation of 'link bpc' could be more explicit about this.
> 
>>
>> * There's no clear use case.
>>
>> This is generally a requirement for new KMS UAPI.
>>
>> The practical usefulness of the corresponding weston MR is dubious
>> per the concern above.
> 
> I think the example of RGB 10 bpc to be degraded to YCbCr 10 bpc rather
> than RGB 8 bpc is an excellent use case. I had another use case in
> https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850#note_3115686
> 
> Mario Kleiner had excellent cases as well.
> 
> Maybe these just need to be spelled more clearly in the commit message.
> 
>>> That the link-bpc property does not consider DSC and dithering?
>>> Two things which the max-bpc property also does not consider?  
>>
>> It's not (as much of) an issue with the "max bpc" property because
>> it's just an upper limit, the driver is free to use a lower effective
>> bpc.
> 
> FWIW, 'max bpc' is a workaround for faulty sink devices that claim to
> handle a depth but silently misbehave. This is also why I called for a
> "desired bpc" setting in the Weston MR, to not confuse with the "max
> bpc" setting.
> 
> 
> Thanks,
> pq

