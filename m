Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357C3FB5EA3
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 02:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9940810E40A;
	Tue, 17 Mar 2026 02:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KnQeHEDn";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011056.outbound.protection.outlook.com
 [40.107.130.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BE710E40A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 02:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfqjZHjPJq+eaHgvVKnJBR3xr8E9H/A1/3nTTYBaMWw75T3hE5AZGHHkmPZOUJuktJ26uKAbT7XIra3bLdwIk8/fJhr+qVx3XmPyMPtUkx7ugyROtkBmVaU2kU18JDFyK1bSICA5FI17unhUBqJhY15M+PicGuy5yK4NY89u7OPsC4tm6XsGUaF+Gtn0q40V+iGAzTC/THc9KCFd6FouvmimMwFRYPXzbjtC5OPcQ6HaQN4kyxvsnhpgKyYW554S4r/fTJf0UTgk8cXbBjce+K3XEB0mKbGwQ8fIQJ3L4cXeZ/8j2vF4c6f4C/PdMurbd35afIpmrb4xUCiU0hUM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RloZfcIjhkzOh5FiHk4WnvscL0rxQffgDatArsL2VHc=;
 b=J2/Zyt1OXT9cJxKil2cw/AEMMZAbxi1x+iDICBlk6No0mbLUhKQpkU3xkLG/l7375uESFgfGVuBax8PVNKZyZCX2Bb34PiDztF16MngUdnGqlPiHFIQSdKB+KjKATLlK8mVJJGIXxWWC6Q4cQwTZHybWay+Nn8/UTOBs7IDxPJKcmoNcFhXrTlx3g7Dft8EB4sgKk22Y/MPONWrMsj3ofCjW94+2aQ15VArFofhJmaXWRuJSvQgVWZTjonrNDy4QbolF+vj9LcrSBGfImvl0G0zCYJuqaIqkjy2lrS8eI14HTBmPx9Sy5QKzAJQWsqk06jwFtZrH8jiw/hBrdlZfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RloZfcIjhkzOh5FiHk4WnvscL0rxQffgDatArsL2VHc=;
 b=KnQeHEDnIL2JlKh353yL/SCtz51Kq/BRml/GBfzWj8Z0VaIt8QTIyQs1WozltjFJGQsL2USc7X343vHVclGeNeuEsuIyCrXqy7QaQLwW3/GDvDjP1aZ6HRCo9e2UyCMiDbcr1CI0Vz2BmdGnualp0DKHii1t/WYOu4fGaeUL/k6Gw3X2nRo/l29GwXSVG9RtTcFhnqfRPl2EdFx0LR/Xj+Spy0SrGpBYMPlkEKgDzY92CzTzw2z7aWZeaRRy5zDgX20ry1Fk8PhxnAfoi0CUd81NGFliAnzqGvlzcNgKp4qi3FpJ2ixlM7icJp5/aQdrq6Dvvc3/9FzybUol89PLlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA2PR04MB10346.eurprd04.prod.outlook.com (2603:10a6:102:423::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 02:03:08 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 02:03:08 +0000
Message-ID: <df7006cb-d1dd-4a72-8ef0-2f27ca0143cd@nxp.com>
Date: Tue, 17 Mar 2026 10:04:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: Fix refcount shown via debugfs for
 encoder_bridges_show()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Marco Felsch <m.felsch@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260312-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v1-1-b9ba3d844732@nxp.com>
 <DH0ZD9UFY68E.2C1ISONVIO42L@bootlin.com>
 <53c257df-9800-48ed-a975-d7bfe4d71be1@nxp.com>
 <DH1KCR43169Z.200HRE4K6DNRQ@bootlin.com>
 <61a51c05-7730-4b7a-85cf-5f03a7985408@nxp.com>
 <DH1U1NUNGZTO.13UP9EXCAC2P5@bootlin.com>
 <b25719e0-21d3-4919-b95e-22b22bdbb388@nxp.com>
 <DH45VL1LHCP3.2MWX4VKP46H04@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <DH45VL1LHCP3.2MWX4VKP46H04@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MA5PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::16) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA2PR04MB10346:EE_
X-MS-Office365-Filtering-Correlation-Id: b2025c03-1645-4f0a-96fa-08de83c955b5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|19092799006|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: ZPgwIzayO287ZWSOK2IX4HK2Ip4HHQwr8jym8nSVf9HhiIiCRuIDbe7nX1dv/k0ujMeZLvCZGB10cqpwOnPs0Cwd851xGKLqQ1fmqKd5cuo7+mloSZLBmRooshG252A71smaAkwo3TyeBN2yC4WmzmPF/0hcavcjXobaqgFjRhlW59GTxDXHn69Src6zYcNK6OAZyAUWt6DTHcfcnH2xtGLwn2n6nvDRCA7MNXEUK3nzfpNc/s+7oLl5pczYoP1MWgHJ+k1dwXlpQW2RxsOpGVKPIZj81Qau2ImcCcpvQ8MdPkmeQskPj7NAkBooKeIfQkL0UdYf0sPnVXm6dVkuLfUmyxB+hNmh96gEI6QFHkYxSgoBVfrvzfr9ab0YtehsP46S3AoB7Ccc5zX5gdFjThOegseU9tjiyZ9+QX5FqUUSeO/xoDcOcAD+lTRDuFwjbpAV/Zwkd+h5CRJLouOB7PGSbc4tGnsr4Xd65Mh/Y7qL+K7HYmpkoB4ESMGBHJyl6rXalNuVp+FPnssnuzn5CKObRnG5PvXeeSplQS7CupxVYEIhVfjW2Mh0EE+4LsAS+8HfvdLASK0jHaBBGORZMZ9ho/9w+k/ViGUFRkjLvH7kF4iOtsXDMsX0XOQdBlQv6kl+DDpS3/RZUrhoqru4XTBK8QMhelwoZ9SQBZMsU1OgkTmefmEYqOiOO8Pln2AI4tH8d8a4cO83lzrddXGrylBAmnD2MAzPpzfYu+Xx8Qk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0FZVWhQejFHQVJIcDlQeXRLbTBvVXczUmk5UUN1TklhT2h6c0F2QUorRFFm?=
 =?utf-8?B?ZW9XUjdVSlk1RFJidkZxQTFmTEQxZnVjVE9ZTVVIMnRnVzM5Um11a1cxUE5R?=
 =?utf-8?B?SVJHUWRWMTZGMm1NT091M2JENFNNMGJzdHc5ZDVKcnNScmVBc2FpQXNHUjFt?=
 =?utf-8?B?TTcxR1l2WnEzaFppQW9JYTB1NG81d09rdC9lZVNseU1YaXpNeGNKcFVLY0FR?=
 =?utf-8?B?eXhXT2RESHFpc3doTnowMVRtSnliTS9XVnJmVFZxM3JVcTBtQzl4SVFaWlM3?=
 =?utf-8?B?eEM1c0o5c1pOeXlsbS83TGE4dm93MGJkVVZoZHNmdlAwZDZoQ2N4aWJIQ1Bo?=
 =?utf-8?B?S3B0VDN5ZnllV3Q4Wmpxbi85UFgrMEpiV0RzdmJkZFlMZExQOG9yeTd1TEFR?=
 =?utf-8?B?eVJqY3VjTjh1NjBDbWRmTkF0OGZQeDhHeDF4enVWQkJYbmhYS0JCS292b2l1?=
 =?utf-8?B?NVd2c2VvWHMxUHlGMjZRTkptQTJwQ0o1d0lOVWt1d2VQTFh5SkkzUENURmpE?=
 =?utf-8?B?UlFkM0Z0bjNLR3luSTBtMXE1ZmUxWDJEa1ZjNUkvdGJBSWMvMGFwdjJaREZI?=
 =?utf-8?B?aWx5a09LWW9PV0dXck0yeVhEQmcvRGs5bGU5cytiUXJCOGxyT0hFa0lXMG9Q?=
 =?utf-8?B?YWx2cGlvcUZ1UGxmRTd3R3dhVEJYQTVhanRDTE9aN3ZCTnB1emYyTzFFMFkz?=
 =?utf-8?B?S0FPbGhFTkhQQncweU9Zc0xqTThRcUllbXVhZlRmTmlFQWN5amF4N0RYcytK?=
 =?utf-8?B?YWs4UFUvclN0dGpSSUxOQW9LcDV0U1VOWUlQMVQzYkdwRnVGbzhjeHJVVkVv?=
 =?utf-8?B?MzVUcUp6VmV6YnV1aXZ4emRodE1XNUF5b00rMkJQeDRtaVN2SkNGQVhNQTdm?=
 =?utf-8?B?M2pEUGhBTHNrakY0VzBHc3I3UWtOOFNmNVZsV1Q3bmJNQXpwL2pzZXdJbmJs?=
 =?utf-8?B?cFVGSmNTMkRoZXNVSkZuYUZVeGdxS2ppc3h5Mk5mQjNNV2JEL1pnNWcycVVz?=
 =?utf-8?B?K0JxTUVXZWltbTg3MWJKT1FUa0xCWmczTDdTNDdqbTJQNFR2d3VEVzVxcWd2?=
 =?utf-8?B?MzR1c056cjRSemxLZWVGd044Q1VlaFhjbjlTL0w4RW9lMVF5UU5kcWVFZE9k?=
 =?utf-8?B?TEliaUpQc2NGK3NGZW1tcS9tczJjeWNxbUV2ZGhtbGU2cm9XekVramd6QkFF?=
 =?utf-8?B?Z3ZZWkY1L1JlSmRuNDIxd05aeTdtT0ZlTXhJbTU0TnJUVFNxS3hjSUdFVjZN?=
 =?utf-8?B?WUkvaCtleWl1THBySS9wbkFpR2RWeGh4UjR4NHdWbkRuRE9aYm5oaVlORTFo?=
 =?utf-8?B?THhqemQ1Nnl3R2lQZkk4SStScWpwLzg2aGVoZ2t1VEdKYmhLYW9GaFJQRXdK?=
 =?utf-8?B?S1VNT2lzODQrQjRTWmdKQXhTRGFzMVVaZDZ5SFcrSjJOb3hTWXBuSjlsM01N?=
 =?utf-8?B?U3ZFblJWU2lNV3g0ZlQ4bTRnZGZrZEZEOGRHamFhMWJJcFpuWXR1ckNnSWl0?=
 =?utf-8?B?WWhsVDAxOE5TaklCNzRPaGM1Ym8raUd5eE10cUxNOWVoNkFnNmpkMDVCTU1O?=
 =?utf-8?B?Z0FPaitIOFdoSUhMUGlueFdnUWN6TDBmd2NPek9PMHZDWHdTT2ZIc004STIz?=
 =?utf-8?B?WHN0SlE0K3FMY3lyYXltazV3T2lJSTl2UjRYQVgvNHpCbDY4WGFBYlZGT1Q5?=
 =?utf-8?B?b2M4Nml3S0Ftc3EyK1ZPMlF4ZmRBdzNZRzZPcTRtWXNhM2libkNzckNRYXFO?=
 =?utf-8?B?dVVUdm51R3I2Zk5oV08xN2ZHQmRVY0pFUW4zTFRmRVdUMVFKWjQwemt2NUM1?=
 =?utf-8?B?UHVxSFIwa25zcHJhUUJqSFdPdUgvSWFZdG1uQWtMbzJCTStnSXU0QmczYmgv?=
 =?utf-8?B?T2RPV3MvTC9IYktHQ1hzZExIYnNDMVdTczlLNHZSS0tlUGM2NlNFVVNOT0lT?=
 =?utf-8?B?TENRRlE2a1dwS2lBMFk5dWV4bWdvZFIyZWEvYlB5N3BaTll4Y090amwyUlR3?=
 =?utf-8?B?MUpvWWVlN1JodEdnVEVjR3JRelJwTEpwWmVXZC9LZTV0MHBpeVp3SWRQSTVz?=
 =?utf-8?B?d2tzQS9adGhITU1aUksvQ2VLUnQzWGRYenM2ZjJnSVR3VDE1Rjg3VitXN254?=
 =?utf-8?B?Tm5IQ2N3QmZGcG9iVElxTkdtS2IyUGF6d1JZVEZsM2NyaURjM1dhZjEwaUJ0?=
 =?utf-8?B?akNucmlhMzZNZUk5emI1bkpSOHZEdVp4d3FOOVQ0bUl2ekVCNDR5N0xmSDZK?=
 =?utf-8?B?UTlERnIzLzQzQXNSblkzSlhKZ2I1WHhoTHlJQThIMTh2TExtOERJenN2U0RB?=
 =?utf-8?B?MDFZUXVXeFhzYmd4V3VCRC9id2twMjRnNUpPQTU4ZlJ1cDN2a1M2dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2025c03-1645-4f0a-96fa-08de83c955b5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 02:03:08.5911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IlbCmh6KFoveNuDe9o1Gi7Y1iDu3ZJ7o1w7WuP6QSLVPJ4QWV3s9e++SLbEU9kgbUSFij61YXRwCOKIWpB5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10346
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

On Mon, Mar 16, 2026 at 12:14:23PM +0100, Luca Ceresoli wrote:
> Hello Liu, Maxime,
> 
> On Mon Mar 16, 2026 at 10:47 AM CET, Liu Ying wrote:
>>>>>>> @Maxime: based on the issue Liu is trying to work around, do you think it
>>>>>>> would make sense to go back to the initial approach for that series?
>>>>>>> I.e. drm_for_each_bridge_in_chain_scoped() grabs the chain lock, which is a
>>>>>>> superset of the per-bridge refcount, and thus the refcount can be dropped?
>>>>>>> This would remove the debugfs issue, slightly simplify
>>>>>>> drm_for_each_bridge_in_chain_scoped(), and introduce no new issues AFAIK.
>>>>>>
>>>>>> Just my take on the chain lock approach - I agree Maxime's comment on [v2]
>>>>>> that keeping the get/put is a better than using the chain lock to ensure
>>>>>> the refcount is correct.  The chain lock could be added later on if needed.
>>>>>
>>>>> Well, no, adding the chain mutex is necessary(*), otherwise Thread A could
>>>>> iterate over the chain while thread B is adding/removing bridges to/from
>>>>> the chain.
>>>>>
>>>>> And the chain mutex is a superset of the per-bridge refcount, so when
>>>>> adding the mutex the refcount inside drm_for_each_bridge_in_chain_scoped()
>>>>> becomes useless (and slightly hurting as it makes the refcount shown in
>>>>> debugfs inconsistent, as you noticed).
>>>>
>>>> For better code readability, I think keeping the get/put is fine even if
>>>> you add a lock
>>>
>>> The [v4] code with the removal of the extra refcount would not be more
>>> complex. It would be a bit less code (no need for the DEFINE_FREE and
>>> __free()). Maybe it'd need an extra comment to clarify when the
>>> drm_bridge_put() is called.
>>>
>>> [v4] https://lore.kernel.org/all/20260113-drm-bridge-alloc-encoder-chain-mutex-v4-4-60f3135adc45@bootlin.com/
>>>
>>>> (maybe RCU list is better than mutex, since the chain is
>>>> read often).  That follows the idea that you mentioned in [1]: "every
>>>> pointer to a drm_bridge stored somewhere is a reference to a bridge".
>>>
>>> That's true. However while it's an important pointer hygiene rule for
>>> device drivers, for core code it's OK to deviate when there is a reason.
>>>
>>>> Plus, seems no performance issue with the get/put, as discussed in [v2].
>>>
>>> I confirm performance is surely not an issue here.
>>>
>>> All that said, I'm OK with either option:
>>>
>>>  * no ref taken when the mutex is added
>>>  * ref taken when the mutex is added (as v4) + your patch to fix debugfs
>>
>> Maybe consider to take this patch first, since it doesn't hurt.
> 
> Yes, especially as the current debugfs output is non-intuitive.

Agreed.

> 
>> Even if
>> we end up with the first option, the refcount is supposed to be correct
>> anyway.
> 
> Well, if we apply this patch and then go for option 1 then this patch shall
> be removed, or the refcount shown would be one-less than the expected
> value, instead of one-more as it is now.

I meant that if we go for option 1, then a single patch may introduce the
protection for the chain with the mutex/RCU list(whatever), plus remove
the change done by this patch.  This way, the refcount would be consistent
over time.

> 
>> Luca, do you think this patch deserves at least an A-b tag from you if not
>> a R-b tag?
> 
> I've been waiting a bit in case Maxime or someone else wanted to chime
> in. I'm reviewing it now.

Thanks.

> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com/

-- 
Regards,
Liu Ying
