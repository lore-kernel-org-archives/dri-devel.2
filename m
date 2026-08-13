Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E680DC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0CF10E3D1;
	Thu, 13 Aug 2026 13:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M7NVKX/Z";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36CAD10E362;
 Thu, 13 Aug 2026 13:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPGhKs5iflrWOMCLiY3BakGG8uJWcOp/3QZuHEezlv8s0NqPYuzq6QyOs5uuw4u7vZkxFXkfA2/JvxKg4IoTKbQSiiXgU0NEir9hWL0xb4JWBo5HTMkbYEqL+JA2zH80fxegZNOgpH3pngPbIAhG90TDTFqZWWlKKxBiW2y3B4i1eWggYg66EcuAKbmBxVpR1Jkb2zMzdQ0Hz602f1QFD3wLwrIT7Zmusbsun+RIs+hA5q7tQ0SeFDzJ34mvGvhYcx8bE1Ms0/pKTGVf61jftjzBK3Ib3Q5IrK0ibgoldy+lL14vl2YOYOJaPTBXWSNzxTyD+2LiKIbAJiwk96R/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+VxsV4bTodVz9z4kAqXw3Qe3vyCr8/ycvMo+fsL0M8=;
 b=llFNGYxT79MyM+ZbJnxvJZG87QmN7SIjEzHUkoJtwj0FAgftB1oHnD+ApXQndWCnBR9fI2neGaDpeoyg3jdfTx0Fp9Ww97AUpK1WYhh5T09e0h5GQeTGIBZUnro4yJtmNKsp5EwDm+UxXfusiXlmxctxn9wMVvlxgyXPPiXYXRxg7+X0N+Kx+gxN4QeCmcoaulAUgkjX2ZHR6zwzbkCdMueHH9VWwh8UevcVUb/kZc2aYjD8IK6p5yXNythkhC/y1u2/hEDAsnSNPqCs6xhy1SkSGVOSc7wazqB8LZS3OGlBY2b9genNaIJN5ENNvKL2qfPiYYkXHBwUHeRi+gcM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+VxsV4bTodVz9z4kAqXw3Qe3vyCr8/ycvMo+fsL0M8=;
 b=M7NVKX/Zd6YWy71n/OgFzXl3l7Kz9UwhR0mMAflBe/QPjCBRkoGROC8A35pwCKWniDoQBAP9Ee4Qh/fRULVJ0CWHbYbX4rVcAtJJLe6COmGJyXpdkKOTWjC4/HsrMdU8JFRdtZPg8GZO8DcyWRMneCiVBCLu+kwWwyJNJVP3e2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DS0PR12MB999264.namprd12.prod.outlook.com (2603:10b6:8:42e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:36:40 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 13:36:40 +0000
Message-ID: <b5dac2f8-042c-4b34-b845-9b5e2c5f132e@amd.com>
Date: Thu, 13 Aug 2026 09:36:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: Daniel Stone <daniel@fooishbar.org>
Cc: Derek Foreman <derek.foreman@collabora.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
 <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
 <e7bd40e5-b0fb-47da-aae8-fa16838f9185@amd.com>
 <CAPj87rMv1si7XBC4QRk_5yhn5+0558VTJnRq3NpU4pT-LqVz4g@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CAPj87rMv1si7XBC4QRk_5yhn5+0558VTJnRq3NpU4pT-LqVz4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0395.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::27) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DS0PR12MB999264:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b9ac55-417d-4031-1e19-08def93fe803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|3023799007|6133799003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 4KRZBxYGGgCoRLzrn7qquPjeBMOsQ+VsVWSbEwnjHViMfOykgpbuu3CQOiHeqBnVuy+t8rPybXyhcYvxmXNoojLIVKhNRV/xZv+aFVH9HX7DJJyn3DSE5/M1h3FnYLypy2WznRbzBGWZw9iLDiy1v+VPLIgeoNdXMI9UUF0uCCUOsrnBtSTglyxkay7P9ke0qKaJTdEbfw2X1RUt56f1M3cxsdJW8Zqd9KiGuLcg/VpSoEgos6h7xurYQw8JKFcHAC6ZAxs1AMG7P144whrN92cANdtdx9VPzY41UNG3vYJZvYWA2Y6vnzdws6W1JU4w8RGUB3e2MYNhT1Fy3OSnTcH1CDDqx6QulYCDxWlSUJS0ZXokMbMhwIROY5kHieAiHdikfVdmmrzOfFxqdZxSGWCIcF1e7YnXVHXDja7r4sjaYn5X/FulkpvHEx4QJc7nZURUMfzGvYCfoURbXNpTNP1UjlGiUtVCUzkWcYm/Qg2m2Nu4bpnxjDmM7XZVmmQONRDCmToMBIG7FSO/dHQiv9DT6haIio/v8OB0N5FwqIlGd5O0GR7Nx6vGpOCO+VmXr5ELbmmG3DKIy8FTFJMlkEGoh3W6wWlVXyBk1Y1l8BPKV9LDG8xIJz8o44yYE26QIPlGDAZIfv89Fqu4NO4W3agf401fuoLplk0Ex/MqlmI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRXeGNoc3FSVGhsSmY0aEc4OEdLUVkvOEVoUURJYkplaDJFN2dIeFF1NVJp?=
 =?utf-8?B?eFY1bXpNaVVyanNrMUtKZ3BHb2pSZTc4eElIU3pEcncwdS9Da1I1M2xBOEcw?=
 =?utf-8?B?SEpmbTVVZzlSRDNqcTBQaS90UWFFejFZSUVOS1czZ1RHQlNzNVQyVVF4NDlV?=
 =?utf-8?B?a1Mrb3hPSUVvNEZocFZwbUMrSUVKSnIvQVRidzVvcjRSTHhJWGFiZWFmVUEz?=
 =?utf-8?B?VWJlVDZETWN6MGlBSmNOeGQ2MSs4WmVuQ21ZNlBNbWdUUS92aUlQczlFRXFV?=
 =?utf-8?B?U2R0NlpWWmpiRG1lYVNVNFU0WVpuNFZaSEVHSnpOdndnOVBraCtiY3lXMkd4?=
 =?utf-8?B?dHNYNEdUMG5tRXlBaVVPUThJeGpGcGJYM2Q0cDdML3p4Y0NZTFYrNzN1YXhm?=
 =?utf-8?B?YU9FTEkzS3RlNTBwSjRtOFp5dlBqL3JSSGNFcHhoTUdRaGtPOVg3blhJbEhG?=
 =?utf-8?B?R21TVVViSXJKWVAyQW5uY2c3REIybjlHVkpuUmtKcU92emdqTnZGeENJYVlK?=
 =?utf-8?B?RjhNYno3OHVxcThUN09tQTh2VGJXWjhjdlRnaHcwNEhOU3czWHlUb0FOaUlT?=
 =?utf-8?B?YnQxUHBWSFgzSGJkeXpFblE3NFd5M3RGcW9EUnlIZWFHdmRLei9Ba3A0czZN?=
 =?utf-8?B?YjcwZG9iYUY1Q1daSkdzbHM4VG9GUTEyeFg5eFNtWXRiWUxtWkY5MlIrSDVY?=
 =?utf-8?B?elhuZ05NUURYVnFyc1FLU3pWYmFPU29rc3JOcHZ6Z2tneUJZbFVWYng5dmY0?=
 =?utf-8?B?NzVPWFNCUHhUclUvTzVRb2xlWTZKdWFhY2ViU2V4WkZSdnpyVWpQV1pCV2ZI?=
 =?utf-8?B?ZUg1T3RjMUltRjlDNTk5TGJGU0kzN29DWmpZTndudzdPM0NxR1pMSXFXRjhM?=
 =?utf-8?B?TWszQW5Sazd1ZHQyTVBGa2VnUTgrelV1YlRvcEZaRmxwZWxjS1BqNFg0WkZF?=
 =?utf-8?B?QjBvQTk2ZzM1QVN0ZFdZZEt4aWl5YUJINzQvTkNQSXl1dXB3UXVyaUpFQlVm?=
 =?utf-8?B?YmpVLzQzYlg1bmwzZTQvUGFmOGQ1SU9hY3A1QWRNQmV2N0Q3K2R3NnN4aTBD?=
 =?utf-8?B?Z3dkc2tMTkZyU285UktIUmlxb29NenFsaVRwVnkyaWllZU5vc09GaDVsRk5m?=
 =?utf-8?B?NEZPbXl5NWdXNEx0cHdxaUNjV0JSVHhjNUlaZXRjclVhZUhnL09WUDUvSlZV?=
 =?utf-8?B?amtXT1VaK2I1d2NzVVY2TjlURmg0TGZVbHdmb2pTQ1BIM2VTRmNUZkFqa3Rv?=
 =?utf-8?B?NUd3empMdEhJeG1yVG5yOFZzbXpjOWxDTEJvc3NUODRlb1JLT293M213UDZJ?=
 =?utf-8?B?YkdDaDU3M2MzM3dIUnRaeXZvOTNpbHNsY3Z4ekhObVpFUTZaRG43eHZSei9I?=
 =?utf-8?B?ODRHdFIwZHFNeGhqNUlUKzZOYTJpUTNybEVWTTN1ek8xSnVkTWZaQy9sVVlB?=
 =?utf-8?B?L3NRTnhWWW4xOHprY0V2dG9Bc2RGU0ZCUVF1WGFGZVBTUU9EZmZybXZHOHVr?=
 =?utf-8?B?enlaZTlwTUs5cGgxOUNOeXZ1RExPTmJFZFgzbVBZQ1dqNTczZE1KUXltZkFD?=
 =?utf-8?B?bGVMamxxanVoQ3Nad1BZQXdhVHhGemxkdS9XdFN0bnVYT1BnL2ZxeTVnUkVo?=
 =?utf-8?B?VUFrSytlNjlGQndDVERUcE9ndmFjcjNLSXpFRTUvYStGbzZxL3VGdzJ2eWk5?=
 =?utf-8?B?Tk5xdTVVSXdJc29vTHFwNUoyUmR3dXVxRm90ZzR1d0E4aDNkOVZERVN0WUpQ?=
 =?utf-8?B?WFE3N2JpYnVINDJMb0I2YjVmNGd0NXpKc2M3MzlSbGVSM1VUdHkwVll2UjQ1?=
 =?utf-8?B?UTR1ZU1KOTBudklIL3pjejlyVmUrcXFSckx3eDhiSS9uaXJCbWdzekgrY0F4?=
 =?utf-8?B?REloNFgrV0tBOUhRSE4yeWJCY3JPcTkwUUNabk1sSDNNdUcvZlpRQWVKMnph?=
 =?utf-8?B?cUQ3MWo1WnNiT0pzSnlUUS9XV2RnWko5cndMcG40MHRGUFNRanl6K0Y2UDVK?=
 =?utf-8?B?RThRaVh4VU5DeW1LYks0S092M3V2MTVrdVBjNktYVnZqY20yRTErc3JuOWRE?=
 =?utf-8?B?OXpYbUlWTHZvUzdGdVpERWNQR0NMaHhvL2NrU0VrekhWaTRCdkxuUTI2em9u?=
 =?utf-8?B?Tm5yOWdObzZ0VTJFaElvVnVUTlA5TUZXWVVreFJMcnpsSXRTa1BUTjBSRGdT?=
 =?utf-8?B?NEx3T3k2QmtxcDdNdDlKd0tvY281dEk1Ym9YZXZqQzAxSERCSzRweFJYSzVk?=
 =?utf-8?B?cWRnRWMxOEh6WlhtQnU5S1FhL1VLMHduSGFFUzBXU1A1YkViMDlnR2NjOVFa?=
 =?utf-8?B?VFA0ZmJGNkFWbEcvRDRtZEpyaWZlZ0ZqSThaVjdjMzE4VGdndG5uZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b9ac55-417d-4031-1e19-08def93fe803
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:36:40.5870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t+g5m6+Ydvu4WYagsDOy72T9Bo31pY67VDtA136OI6PVhtF51m4WqYwUYOnU1LQ8yav2YE8dwZb5NKytadezA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999264
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



On 2026-08-13 06:29, Daniel Stone wrote:
> On Tue, 11 Aug 2026 at 18:42, Harry Wentland <harry.wentland@amd.com> wrote:
>> On 2026-08-11 11:23, Daniel Stone wrote:
>>> On Tue, 11 Aug 2026 at 14:54, Derek Foreman <derek.foreman@collabora.com> wrote:
>>>> Tying this to Gaming-VRR seems potentially surprising. Gaming-VRR
>>>> doesn't mean we're playing a game. We might be using it to play back
>>>> judder free video (where we'd like ALLM off to preserve the sink's image
>>>> enhancement), or we might be at the desktop.
>>>>
>>>> I'd imagine some users would still want their sink to use all the image
>>>> enhancements they saw in the showroom even when playing a game, so I'm
>>>> not sure any kind of "auto" decision making in the kernel makes sense at
>>>> all, even based on content type. It's a very subjective trade-off.
>>>>
>>>> To me, this seems like something a compositor would want control of with
>>>> a simple boolean property.
>>>
>>> I strongly agree. I really don't want to see more magic implicit
>>> semantics unless they're completely necessary for some reason.
>>>
>>
>> Yes, though I wonder what's the point of the content_type property
>> then. It's another one of those properties that's defined and unused
>> by all canonical upstream compositors.
> 
> Poor old Weston, no longer canonical ... !
> 

Apologies, I realized Weston used it after sending the email.
But it also doesn't do it dynamically but with a config file,
if I understand it right. So, it exercises the option but is
not super useful to judge how a dynamic/general purpose compositor
would behave.

> Seriously though, I see the point, I'm just really wary about the
> kernel trying to be too cute about policy. If you want to use Weston
> as a vehicle for an ALLM property, we'll happily give you one
> tomorrow. It would be static as is all our current output
> configuration, but we could also type up something easily enough to
> implement the content-type hint protocol for dynamic use, with a user
> configuration of 'enable ALLM if there are no games on screen'.
> 

No, thanks for pushing on the policy. These specs (HDMI, VESA) generally
don't think about SW architecture and treat a source as a monolithic
beast controlled by an IHV, which it is not.

Harry

> Cheers,
> Daniel

