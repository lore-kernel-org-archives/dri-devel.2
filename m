Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1EFD6AAF6
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1951310E22D;
	Thu,  2 Apr 2026 17:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g5LcPuvn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A7510E07E;
 Thu,  2 Apr 2026 17:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDnjqIvfUtSzkWI/Na1/qFUX5prgAeZyb1icAxmluC46ZyVumum/oXT25vsBBaTUcGWNHHjmA1gorh2h9Hu8t4T6yhylyBbXtsGytBY53xGqDxr5D/GgI72MDLA6EaAB66dPbDacAdrqWyPo7SOFmkw2EB7PI2V8/G0JrOt/5cK+1VOKcGafetZHkIl5Q8VXEzc42N9fqWKXDJNo+JR13EBFe4C1+9Vj83C5xOMUuIH3SlQtMlaHeKYliQim3OXonfNqxzfe+n4xJB2pxHga1GbBHSD0W29XiT+PojRbGwxaZAB0q+2CJpOr42DhRu0erZoGiFJJ3dtYu0h+TR/p6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0XFe0xYiHgY0UWVxiokllC/RLbV31em7iWm2THFRAs=;
 b=qglp+TFd1uL4sVCnMImcs4V/+p80A2hlHCwQDC4FsdSUnDAGQ6ywL1buJgVjluVC/Y5sa75D9ULZe+amIUVlu3ckH/fyXmltLzdTOdi8XDkHE4Anf+dcy5i4pNHBrrMns0DWBwH9Ly5YnA8zjylZGQ52WheaAJVaEzBk4y+Hbij24rranJ3khETYV0Qsjf58n8JjAmTxn8nFtsCtkYqK6oSKWwyCAcnP6coRCVwTSsTt9GIYW4pX7VUs8KPZ94E/rktAfrcMHBV9ZQBnX8XE1ncRQMOWdGbXRC2eCDUYhbifBBWtc18kZ0HbXOCxPWJvjsH29wIpCrijYnHcsFeq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0XFe0xYiHgY0UWVxiokllC/RLbV31em7iWm2THFRAs=;
 b=g5LcPuvnCCCeVqaWRv70XrMhZNuWNjSfVXtGAIy/2ox4O43sIIgaIwyYqPfgIUsu/EJtSqgRjjgA7rSeQ2wFMTcnlcdyo+Pok1ItReD+2f+dsD/5mJpSBYdvpugbHLJOnkzyUw3M0KLYadjJZyrzN7Ka2TbpZilSFM0F6b4MOFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 17:07:04 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.20.9769.020; Thu, 2 Apr 2026
 17:07:04 +0000
Message-ID: <b5f1ee1a-e066-42a7-be52-53055f67a1c4@amd.com>
Date: Thu, 2 Apr 2026 13:06:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
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
 <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
 <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
 <6251230.iIbC2pHGDl@workhorse>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <6251230.iIbC2pHGDl@workhorse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::29) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d765b4-4f25-4d02-ac67-08de90da435e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: JIQsaQugLfNNbXO4nRl97vIg2dxnjEBOP6M8O6bLNViXxW+YO33jDABhzV4WVjPUJXJgs3RgW/h39vcW7Ik32dplY60CRHevnOozcR9R2diJX0/NIO0LjS6dliDzO8TFDDUqQ+8Cdr0RxD7cizGIWbavOXchAm+xd01H48HyHCI/DuQO48/plbuc64GWXRGaavwwYlaUIralEMaBsG19NtZXKNqdjLBRBcvsuYFvLA9PARgKpEcdScSXX5oHEHHCb3ywVW48Ls0T70TVwKYpqRlqBcFonc5xcyNRk/pRkmf6FnVe4pM1K2t5J03EoB3J4mK3r28M0fM6HGMZKAhhW1+H7/J0ki1qfEjZxqsevkM/NP+jJIZ+iBk2+TIOGrFB9HgLLIubuUDpfOhKxStrdkgFx218Ae+97VqbCp6vLXjHWRZi2cuo3syujozhCXdWm6hMwgKut/pejI/EPAYBJ2JF/nq6A2guuOXLo+J03fTvUepH/ZtTGcQir9H/WRunY1TrayIwiFKPs/u9Qy+wXPJIUy8i+g0BDqNqYICU651UkDUpFtNaTWSfYiMKoTkHowJMVcnrYh8UsASwGdryitBvvdTkVlzS0gDBuKeIfSgbadrMgLsRvGkRxWn06iP4qPOybWx+/SASETTowBNNDl1JpLvk3LLd/v2+Fl89okGnyigXazGX74sSfK3Mzgej
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3VjWEZLY2Z0SEpYSkttbE1wYVp0ZHkyZHlaa0FONnZMQUJCMkM4WXd3UFM0?=
 =?utf-8?B?MGV3WkZFSEF1WTRtR3VDYWhoY2FvKzFCVktLQWVBQUhXRjJEemVDNHR3OThm?=
 =?utf-8?B?TTZYR0JKVmI2LytkRlhvL29WZEpiMThnQ1E3cEV1djJGZEk3ZGVCZ2J6eEd5?=
 =?utf-8?B?ck5PcjBwc1A5TW8rZmNwemZVRk4wK2t4SzNuZjd4V29wTVFCdmNFbW1PdGx2?=
 =?utf-8?B?eEd1ZXpJMmVhRk1XSkxxNTNmaU5tQkFxSkcyNW1rb1hvV1lmc05keWVKekpD?=
 =?utf-8?B?bXFXSDFnVGQzMXd5OWkxOWhoRE9LZnhYUXFTUWRjK2xrRDhXSHEycHRHNXFk?=
 =?utf-8?B?RXlNU2VENHpnSEgxanBWQTRoYlduNTFrQ29sTmhEQXJULy9FOVdYSGRsclpF?=
 =?utf-8?B?aFJYd3Z2ZDVLR3JSa043dkNZaXRBUUJvelE3U2thMnNYSEZ1YnlETHFDTDVo?=
 =?utf-8?B?S3dJMEQ0NUFqWFRvc0NWeVYrRWltb29qbFByeEFoZU9aYTRvWFdVNk1zUW1j?=
 =?utf-8?B?M1hveWZobWVoZ3dSLzR3bVBvT3RjbVNscTA0dWFKVFVQTE9DaWoreGJaZWVt?=
 =?utf-8?B?cW9Jc2txL0dIcEF0MGJKaktlbFNQemgza0VYNzRZdVJHLzlqS0NpSXlnSks3?=
 =?utf-8?B?U1VoamVXRDQ1MzduZkxwSjN3USticnRVNFllOXlEQUlrdlpjdkoxSW9aV0pN?=
 =?utf-8?B?NXorOEo3MnptN3d6YSsxMm9nbEdrMFdKSmF2QnJHTnZUNEg2b0VSWG84cWIv?=
 =?utf-8?B?OTJURWZSV3RaQy9zTEVMZzRXUFN6VGFKNlEvMnYzaktUOWJESEtrTi9oK0dL?=
 =?utf-8?B?UUdJTks1QTc2SnZGVzVZMlZNMTZnNmJJU05HWHpjbGdGWE1GdVJ6MWRabU93?=
 =?utf-8?B?SWxPRCtlM3FQZUF4L1Fnb2dxVE1GSUpHMkpzQWhDNWdKTitpMnBmMkhNeUxX?=
 =?utf-8?B?TllUZXl4VzBjeFJPRWJHNjU0VmxIbmlyaFRqYzhSWGFUa0h3bHBUU1N3dnFL?=
 =?utf-8?B?S1RBYXBmb2ZpSUNYZHA5c2JlMVhUSjlOTVZCQm5TOUFvVTBVWWVzbGo5U3Zq?=
 =?utf-8?B?RGJsUHc5QmQ5b2Q0bS9iVlNrL1RMMWZHMk1EUE5YajlGdEgvcXVISEgybnli?=
 =?utf-8?B?VVhKcnVjR0JtbWlaK2pXeUQ3cVFTRmZ3VFBic1gyNExJYkZpZEdDVlBlcnlP?=
 =?utf-8?B?ekVIRVVYUDc2N2x2QWxlTnlPaEJoa2ljMWlKTTRKNlRjVDlRbmNzanhkZzQ5?=
 =?utf-8?B?RVpaNyswc0UxWWhtVnIycjZIa1ZMUzRqTWNSS2FZM2RkSmQ5dTFESEswOFJU?=
 =?utf-8?B?bE9mK0ZIeWl5MmFzS3BOMFZETHMrMGR2SGJmL3Z3djRJUm5OcjJ0OXpENDRJ?=
 =?utf-8?B?ai9WWkprbDlvaDA4UERMNWVyQ0ZBbjk2OC9MNWlCa0cvUW9jd0tlc0NlRGRJ?=
 =?utf-8?B?VTgzUXZ5U283VmlHdXdZVGh3SXlpbHdmY3oxbG5IWlkvc2N3RlJQOGUwSFRk?=
 =?utf-8?B?N1RncXZxZUFxNnA1Qnl2NGFOT1UwM0hZNHJWOENmOGptc2l0QzhsbmF1Ny9T?=
 =?utf-8?B?NjhpR1NFbEVzR0xmRDJRWm1jelQxeWt5WGF6MUpqQndBNk01NmpHT3N6OW5F?=
 =?utf-8?B?bExBd2ExWGxuWmJScCtwL3hxR2pIR0dNVDFKRG4wSmZMdWViM04zSVNOQWVI?=
 =?utf-8?B?TWZHaVNPRjNvc3VoT0g2ZWx4R0tidTZvWXpZTWhVQlQ4VmhtNW1NWUFNSE5S?=
 =?utf-8?B?U0NXSlVybDdHVDkzM0cvSk9BT1hLZVBYdjZFWVprUkQ1WDEwZFFLSE9iM2E3?=
 =?utf-8?B?c0EzbmhIM0ZaRnkvdm5wVk05ellURVArZnRuOHNnaHAxd1MxM2ppSEMxQkE0?=
 =?utf-8?B?YzJCYlloQXg1Q3VmRzQxM2tGTEx0YlhiNDMvRTFOeERqTlFhenMvbGNIblNG?=
 =?utf-8?B?TkJzUGtMQnd3RHQ5bUhTUFRUSjRzeFpPUjNsWmdOSXcwNUQzc0ZjOXdLU1Zq?=
 =?utf-8?B?Qzg0WHJtQUl0cTdXVnUvaE85bFR1VXZzQU5wRGp5eXlpcjZaMzlSbDM2SXBl?=
 =?utf-8?B?YTF5SXBlVnpadlNzU2FST05uNlRhL0xGcWRkeUNjZFF2akdBRVF6Mlp3WlZQ?=
 =?utf-8?B?eXczUytNaDdhM0p4OGowUERzZUlBaXZMV09OUGw4TlFZRkR4ZUxkdzZzQnBV?=
 =?utf-8?B?SHQyNmJxRkNpc1NVOFNPYTBzSkFFMDloSlFLQUFDbHFhZ3d4d21Rei9KUnVV?=
 =?utf-8?B?aEEvakZtQ3lodGx3M0VxOEtXK3VoamhxTUFrMjV2ejV3aytHTFVmUFcvYm01?=
 =?utf-8?B?VzFQd3VpaWFxTGpOUGVja04zcFBIZmVwY0pWaXhad2d2WTNkYjl2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d765b4-4f25-4d02-ac67-08de90da435e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 17:07:04.1569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pVS8fmUxL5E+sYOHqZeXDREz09l/FkCOkL+P1lb9IwAymiF6l72v2jRkcEhffKeEzx2qg7rW6pdrqul/dj67w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897
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



On 2026-04-01 08:46, Nicolas Frattaroli wrote:
> Chiming in here to basically agree with Daniel and underline his point with
> some evidence.
> 
> On Wednesday, 1 April 2026 10:40:15 Central European Summer Time Daniel Stone wrote:
>> Hi Harry,
>>
>> On Tue, 31 Mar 2026 at 18:47, Harry Wentland <harry.wentland@amd.com> wrote:
>>> On 2026-03-31 08:50, Pekka Paalanen wrote:
>>>> People who care about the picture quality down to these levels will
>>>> likely want to know and learn about these techniques. They may also
>>>> want to explicitly control them.
>>>>
>>>> In time, when these have been used enough in the wild, compositor
>>>> developers will learn what makes a difference and what does not, so
>>>> they will adjust their reporting to end users. The most important thing
>>>> for the kernel is it offer an unambiguous and stable UAPI for these.
>>>>
>>>> Policy belongs in userspace.
>>>
>>> I don't like this as a blanket statement. There is a lot of policy that
>>> intersects with HW nuances, whether it comes to power or otherwise.
>>> Taking away driver vendor's abilities to optimize will hurt the Linux
>>> ecosystem in the long run.
>>>
>>> IMO this needs to be evaluated on a case by case basis. There are
>>> many places where it does make sense to give userspace a greater
>>> say on policy, but we don't want to push driver (HW specific) logic
>>> up into userspace.
>>
>> It's not something that's _just_ specific to a particular
>> display-controller manufacturer or a particular IP generation though.
>> It very much depends on the usecase.
>>
>> If you have a laptop and you're trying to give a presentation,
>> applying dithering and/or DSC makes a lot of sense: you don't want
>> your battery to die, and the projector's probably going to obliterate
>> half the colour anyway, so might as well as go for the most efficient
>> thing.
>>
>> If your laptop is plugged into your big display at home to write code,
>> applying DSC to cram the highest possible resolution + refresh in
>> would make sense. But if dithering only results in a marginal power
>> saving, and your laptop is charging anyway - why bother degrading
>> visual acuity?
> 
> This kind of encourages me to say that the meaning of "bpc" here should
> either be reduced by all compression (of which I see dithering as a
> primitive variant of) or left at the uncompressed bpc for all compression.
> 
> I'm leaning towards the latter. 10bpc lossily compressed to 8bpc is likely
> a better choice than plain 8bpc for visual clarity, so making them look the
> same to userspace would result in some odd choices. At the same time, having
> a separate way for userspace to know of any compression techniques applied
> on the output would disambiguate that for those compositors that really care,
> and would also mean we don't have to make subjective judgement calls for
> anyone.
> 
> With regards to DSC for example, any vendor's decision to enable it by
> default does not necessarily give us a good precedent for what side to
> err on. amdgpu flips on DSC when it doesn't have to, and this has rubbed
> some people wrong: https://gitlab.freedesktop.org/drm/amd/-/work_items/2043
> 

I fail to see a convincing explanation on how DSC degrades user experience.
No video or anything. It's somewhat difficult to judge the merit of a
ticket like that.

> The goal isn't so much to push driver logic into userspace, but to give
> userspace a view into what the driver did, so that it can decide whether
> it's happy or wants to try again differently. This means userspace isn't
> ossifying on a set of parameters that made sense a decade ago; drivers can
> still modify their decisions as they develop and hardware gains new
> techniques.
> 

I agree with this goal. First, reasonable defaults. Secondly, inform
userspace, thirdly, let userspace set different configs. In that order.
To get #2 and #3 right we need the conversation that Michel started.

Harry

>>
>> If you're a media player, then you're in a good position to know what
>> would be good to go over the wire, because you know (& are possibly in
>> control of) the format over what comes in in the first place.
>>
>> But everyone's tradeoffs are different, which is why sometimes the
>> best choice is to ultimately leave it up to the user. If you dig into
>> any media playback device (STBs running Android TV, Apple TV, Fire TV,
>> et al), you'll see that all of them ultimately allow overrides for bpc
>> / colour model / subsampling / etc. Those aren't just there for fun,
>> but because they are usable to real people, and it's not possible for
>> Amlogic or MediaTek or Rockchip or whoever to statically decide that a
>> certain configuration is going to be best everywhere.
>>
>> Right now we have drivers making magic per-vendor/SKU decisions,
>> without even so much as a feedback mechanism to userspace (unless you
>> count debugfs, maybe) so it can even figure out what's going on, let
>> alone control it. To properly support some of those usecases,
>> userspace needs to be able to control what goes out on the wire, but
>> as a first step, it just wants to be informed of what the driver even
>> did with the properties we gave it.
>>
>> The end game of this isn't Weston logging something to stdout, it's to
>> surface things to userspace so it can guide the kernel into making a
>> good decision for usecases that may not be ones the silicon vendor
>> decided was 'probably the best thing' however many years ago.
>>
>> Cheers,
>> Daniel
>>
> 
> Kind regards,
> Nicolas Frattaroli
> 
> 

