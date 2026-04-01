Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD30FD3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D30610EC86;
	Wed,  1 Apr 2026 07:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VquHuVrp";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010048.outbound.protection.outlook.com
 [40.93.198.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511D110EC45;
 Wed,  1 Apr 2026 07:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQKZXFnlhnYt/k5Txaa9fbgl6Kdj+XFQf2R2RBO1rh0nfSVopPrWYkV3tzJ58WxHgpAvlvLEuUV6HMN5z6LGE4LNBSA7OsjUXhyUy0lFSI7a7WFBt/PsZiDdwcyiq//ragoWE/SfC1nYwGGC8VgxUb+yBay3kqC1XobZCj/mTsnwv5Lukohs2LRveRiN9fe0ocx7n6XIFG5AEPkplbfYlvjOo875OaHQ0HPyu4wMoC7JG735RprKsfRDmp3QxEjPhwU9L43U4+kcEaRZV13QsQ/HaEbLw8r6XR6AY/nCEtB3yymD/k1bi+G0PsAcmZrQNinqpgXp9XLNR/jqjIrnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv9cdViS9CXcHoOOoAe62au0uQxm7SoUiy/smewy8Qk=;
 b=yAZwJJUzrQFoNPHqKW3LPCiAbvhc392z6SMPH758R1tT8D8R4I7aVvWitFlBKjV6oSGHXBLQ/eJslBZOZu38BnVxRZhvIK6xHNWWxMOmTh06ZO1+cMp1yBVywwIBldVBR3dBxU7zCUX+eUuegNV5fIHJS1LSylQGYTUrWwpKvlCpu8fvN2Oo01qXwjdnCvvyYHufZIHZsdTwnp3RSq+9D3YHtfi8TeNX3RF45JJ1fotsBPeHB0/UyGN0JyiqDdbzubboSWQNI0o8WydNU+zYtuiaFGU6+w7hpRND5U4xOWYTMa+xUCV1f346w0UZBTPdXqu3BT1tcGAJf74MqtJXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv9cdViS9CXcHoOOoAe62au0uQxm7SoUiy/smewy8Qk=;
 b=VquHuVrplmH7h6mXneHXaXWbtdPGepSx9JOUaxE1B9ihmHeO85k0T2C4nTav6/gvyONYcVHq/xHQfuP7F01fTle0OvpcILefXZvQDazUsw0ADBqgHs/exBaAnN7Em4kynTTGKzmPunySZxX3bLIREGjy72uYjdLoI/bbefHisQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 07:24:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 07:24:02 +0000
Message-ID: <d37e1e34-8a9b-49dc-ace5-76f23c0375e3@amd.com>
Date: Wed, 1 Apr 2026 09:23:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, lijo.lazar@amd.com,
 Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
 <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
 <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
 <CABXGCsNcRQnQmsZJAhfJPsR71HXU5+CG4URJiX03xkPJD+f7SA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABXGCsNcRQnQmsZJAhfJPsR71HXU5+CG4URJiX03xkPJD+f7SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:208:fc::49) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 4426f3ba-34f8-40e8-cc38-08de8fbfa659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: T60jR7QounJy2K0rCqqlRKBbR4VGevxmKUIZRhxf9in7iZOhBP8PX3cs747llRqaMfvI6dJ0lrXAvxabjsCRvC0s1F+sRiwNfFvCQsPZP9ynJn0PxHt9OgQTaEkLVHLg6XNrVj2mu4xjNnGulrVrRyBnoFTxO0EInCDlGcwyDmHoDz9A3J9oCuqKZCzXBWiQUJjYuhzNeUy08vcraApbvuQhyILm0Owj2QWXpuHq3lP5HyFy3O08trBJKgoYeel4HNHe6TTVAEZuSSOXGUAYxLwaZ/ST3HYX0NEYOjQ2rIBGCYA8+RrsecSRlPm6zKNf5/70jiphrchW7gGmLQNav47bLkt3MaH14QbN8Vw3oxkAYUZ+hKQL9ce+ifLQpv4WJfc6Eg1sDXv5M1NxUwH5F3ib4yHhKj/POcTOEHfIQll142Bq0zcdnYE5sRMmp6qsVrIgezmGi80tVkGS5BlF8ATK9QbzXX9R86mDiDpBZ5QyAhXHCm+GdxOQuow0V6oWIX9E9VOkwv6/b0LOxEfxmj+NtupieKKd/aadkE3JKE/RZXYII6mr/rhqefloJyeSQkAwUtm9BvNPmFhFomZd9nQiTYe+3an6a00ViX2AvRoPjoMx/GvNoNtDLfk3+B/ott03UORH9MLDYlr0N4WjrbyAjuPmmjEWyObqdOc9PIPN/HtfCw/1xuZ8tneMFFrshZ9F7ICISzQEWzr9vZQ0shRMjFO0PEc4r1HH+M9rjb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZWc1lqQ3l4N29wUHl4bkJkQ2ZQZkV6SVJtUUg4RCtNaE42dldaNlZpckZH?=
 =?utf-8?B?Ymk3MFhhRnpyMTlyOVVrOGhhWG4zUUErYlp4WHdCUGNYRE1ZQjRDZHBCRTF3?=
 =?utf-8?B?aVRNc0RIeFJxWVBaTHljckZCNHhNZkVjMHJYeWd4b01Rb3hJbEozTHZlZEhB?=
 =?utf-8?B?RFBQOTVwSTFZYVNSQkJCakdKaGM1VXFIZUx1ZGF1Z3Y2YVgwY1Yzd1VZaUFL?=
 =?utf-8?B?RExjdW5kaTI1aFZvUjRYZU8vYXdPYUpMa1pPNnBsMDN4UWdtUnBFV0JFeWwv?=
 =?utf-8?B?blQzTjVkaUhOVk5Ra2ovRXBmb3kzL1lkY1F5M21LREl3a1V3NzdsMzVISDd0?=
 =?utf-8?B?STk0ZXBDVzBzc2VxVi94Qm51UjNxTHhMcnlsWXhMS0VjVmNVbUIxd1VSWUlZ?=
 =?utf-8?B?Q3JsUE1YNUFVdWs5bUJISEJsRlYrMUVDNHliS1BoYlY1eWhDb1l5YmdvWGVW?=
 =?utf-8?B?QnYzWXB5WDI2MGloS2Q1czlmM0FNalBudDduYWFQUEdhV001OEpUTWRkWkt3?=
 =?utf-8?B?ZGJOeWdjeU5RNVFjUW5HcjQvUUs1OC8xR3lGTFB4OThoTmVRUDJkTzcyQkxq?=
 =?utf-8?B?c0dNRndpNkFrZmVRMVlrSU5xa2ZmUG1oRGowWU9nSkdaTG9UL2pHVUd2a1FO?=
 =?utf-8?B?TmI1VGRsRlZXSUpIUnJSUHlnYk8zdTNtUnA1NzF0UFRRNTVhczZ0V1dua3dL?=
 =?utf-8?B?M05qTVc4a1MvTGNJNkw2ZTludmZhdXhMelBCY3EvUjVQSGRPSDVUOXBWUVEr?=
 =?utf-8?B?NXZORWFqZzNaVGNJNS8rOE9oMVoyUVZJRGhweXlCRTdQa2FNRkFveFpmUjl2?=
 =?utf-8?B?cW9Ic2JVWEluSFl3NGJKaG5zanN6OWtzQ3VzNDBHRVg2OFFYajF0M1hMcE1M?=
 =?utf-8?B?TFZQNURWQVZwTlBsL3R4UFFFYlVibkNqOE9YbithbmxPYnBxZ0JnQXhtYlhM?=
 =?utf-8?B?L2pydXhVNkNoQVVvbnJ6VHc4V1hvR2xOS2tuSW84R0s2NEw3YTQvRUdCSEN4?=
 =?utf-8?B?T2dxWkpzeC8ycGlNTGN5TmtBU0pTVEx3bnpuc3lhMkJXQi9BRXBNSE5KU0tt?=
 =?utf-8?B?cDVONXhKSDIyWWdHNS83N1JVeHVNZS9MeEdiV3RnY0d1L2RhR3MwK3JXcVVO?=
 =?utf-8?B?QnRkQzZZdlJGRHFDMnNvK0VxVFh1dDNEZGpFSmFLTGZGcEdlSTRLcDhhVFFh?=
 =?utf-8?B?NmM5SXRjeTdmMG9YWEdTRUNrZnE2dWJFdHNhVzMyQm5xUXFjZ2ZLMUhSajRr?=
 =?utf-8?B?VFl3QVlUMmJoeFY3UTgySlNrK1pUR1RTM0hPN3l3b2pvcVo3Q0RsakZyVUN1?=
 =?utf-8?B?RDRjU2hNS243OUlHWmU3NFFrRUIxdjl6Q0pZS0JPeVZNT0RHdEFDNVRkVmZB?=
 =?utf-8?B?aHh0d0VsN3FZMGlxa3gyeE8xVWF0cmpueFZ1L1IyNFFSTkJuZW9jVGR1MWxP?=
 =?utf-8?B?ejJrVXhiTnRTVnB5Z3R5bSs0M1lrbkhUSkgyUkdQZ21DMDlubUxvY3c0RGZP?=
 =?utf-8?B?Vm43Umg0K3VIb3pSczB2SWw4WDJTYitzUlNrZnFteTRqMjNwd3lyWkJrRTZP?=
 =?utf-8?B?c2dnNHpFSkpxM1E1YWhzaFBVRzc0L2pqRVVKVDF2aEM3VHFJYjJwUStIaFRs?=
 =?utf-8?B?b2NIemx6VzY4bURhSDFkM3B5ZkVJZDY4NkpjcTZjWitXQ09uM3pwUWwyTzhF?=
 =?utf-8?B?WUpxQ20wZnV5NU9vZjJCdjV1OEdLczgvNCtxSlJtNjVqK3I5SmlFMSt3ZEV3?=
 =?utf-8?B?SE9ubjNoL3M3eHQzWVZuWERvRWhiV2xwTjdZWjBuRjlHbVBWS24zcHF1QWxu?=
 =?utf-8?B?QWs4L3lxWmx4NXY5RG0xVTY4THFHdkwwZXQzOVlFb09pQkoyWGc0MEZVNmxk?=
 =?utf-8?B?MjBVYTFQcTZCTk5ZY0x5SStoV3NSTlBxWDJLTHlMTlJJdzY0cmtqNFhiQVkv?=
 =?utf-8?B?aU5LcGtLT3JWMmJQMnM5amFPMEVKM1J1NlpsbS8zaFFmTDAwdXYyempTb3Ni?=
 =?utf-8?B?VHpuQ2ZtcERINzRwNU0xWXNwQmlxZ0FnM1JJa2R5b1FMRzRNMDArekZDTWlp?=
 =?utf-8?B?YzFnMm5CN240LzFuOTR6SkovQTZRY2N3UXlBVzR2S0g4UW5La01KbWpuRzNW?=
 =?utf-8?B?b2c2SFpmR1NRVGV4cVJ3eGZWM25aOFE3NUhFUmdHajR3Q0lZeHlDSVBuaThY?=
 =?utf-8?B?Unh5bkZiRHBUV3NmTWM2MVdGWEpkV1FjSUdTYjVIeEY4dmdkUFk4eWZOcTMv?=
 =?utf-8?B?dDBuQSt5UTFEVnBId3VYVEQ3T0JGaWgwYVJyMTFJb1N3cXNzQXJjcC8vT1Y2?=
 =?utf-8?Q?qd1X2uKEy6/9aF3L8F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4426f3ba-34f8-40e8-cc38-08de8fbfa659
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:24:02.7304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vb913LPaFxV3j0rj6HM+ibhlfSWaKnQbQRaBEHFGnskDNpJ+NV7t+OH4sPNN4uJF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
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

On 3/31/26 19:12, Mikhail Gavrilov wrote:
> On Tue, Mar 31, 2026 at 7:38 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> Applied.  Thanks!
>>
> 
> Hi Christian, Alex,
> 
> While testing v7, I noticed that xa_erase() and xa_alloc_cyclic()
> use plain xa_lock()/xa_unlock() regardless of XA_FLAGS_LOCK_IRQ —
> the flag only affects lockdep annotations, not runtime locking.
> 
> The XArray API provides separate _irq variants for this:
> xa_alloc_cyclic_irq() and xa_erase_irq(), both defined as inlines
> in include/linux/xarray.h using xa_lock_irq/xa_unlock_irq.

Ah, crap I wanted to double check exactly that but then had no time for it.

> 
> I confirmed this by hitting the same lockdep WARNING with v6
> (which has the same locking), and by reading lib/xarray.c:
> 
>   void *xa_erase(struct xarray *xa, unsigned long index)
>   {
>       xa_lock(xa);              // plain spin_lock, not _irq
>       entry = __xa_erase(xa, index);
>       xa_unlock(xa);
>       return entry;
>   }
> 
> Should I send a v8 using xa_alloc_cyclic_irq() and xa_erase_irq()?

Alex already applied the v7 so it would probably be best if you provide a delta patch on top of that.

It's then up to Alex if he can squash the patches together before upstreaming.

Regards,
Christian.

> 
> Thanks,
> Mikhail

