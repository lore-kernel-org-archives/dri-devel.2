Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37286105F78F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9980A10EB75;
	Fri, 13 Mar 2026 10:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="oHFg/tto";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F344910EB75
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOhdb48ZaEsgRyfBRYJcLj2NlDuTwC6wwR47iNKZOhwF0SAOFBEFE7ykPG1kSPnLozkh+cqHbahWEhz7hpTVr0+zF5+Vbv0gsbBIKW5hnweMdLroaeZlzUNGnDj5RMlbLMCCWrzFOKtEvnCIprSvRBUUAWHMqRbAoZyvrT3WlkboM94wFViLLjn/4s3A6CxnFcsBP5QKdcCSx6fLR9VsuVWvJl4oK/3ix0cEKTHnX50JnFe/hfeDwzOZ1LwRTGOUD/yUXJxW9nWohspJQGj+ChJZCM4xMer0e1NuxW0489EUvh4H9Dk5kkKOQL6yap2PSxtXNxst+b6HD3wp2FNiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkwSYepmiRGfJNGOPJCoCNitH++Lcg5OwF/F8LKf3Ug=;
 b=JzWcbi9c1ok+f9YdDAaxBChDeW4xs2mEThbjaULU1riZS9iNaUKkcWhlgaA+6lXk+FVq7pcyTbwrOYpvJ90C/nekckZIXw6j+onzE73a9vYy5SWSnw605yKIDZxJvla1V/cQxFPkfH0PuI4Pi0N6SMyJbTUqFxUQMBv4CoqFs35QDuOOg6DN2xuwtS1wo/ko8D2YUzizOuqqCEUOAOSfb/OI/ax3W2zK0ENKH35lTrWPzc3GoZwHHKkS7BYJCEy96tuzZND5x2Tn40fYcKNTzGFaH9QEJiZ9SE8F2iIxMH2ekVBT6oIO3g3ilYyLDYhJMUf1VZlVBtPX9raLkM9HtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkwSYepmiRGfJNGOPJCoCNitH++Lcg5OwF/F8LKf3Ug=;
 b=oHFg/ttonu42h1JYXWFTFhEYzbqOZbQThb5NfuIXwC5sDG7DcvrfH6yT99NKoI208uD9W80zkFsIy6ksU2IYaGuJutDEtluCGC/BFgS2oXlKUdxn+TYCza6JSLMEiJzufj0gtw2YctL5oz3fxY/w7mM9Utn2ChR2p4CufIslTPzu16jGVk8oa62n67Jm0GUQgxezlFrWGX0Gow2ukI+E82dXDlb5J2tohsdczMk268N9HEMzssEC2qr2qjtVVFS9rIaJc5Vm58jRETniNNIMExIR5vZCsh98y+z0nrd6c00vxP5jNaOj5EYYYTqarQqy5pMEuM1wGoEzM5h+PwVutg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GVXPR04MB10996.eurprd04.prod.outlook.com (2603:10a6:150:220::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 10:21:19 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 10:21:26 +0000
Message-ID: <61a51c05-7730-4b7a-85cf-5f03a7985408@nxp.com>
Date: Fri, 13 Mar 2026 18:22:39 +0800
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
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <DH1KCR43169Z.200HRE4K6DNRQ@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GVXPR04MB10996:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef579c0-7218-4bfc-b3df-08de80ea48bc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|7416014|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 16hv7dz432YpvVbrm/gwGHiEfO8znMXvvK456DYlj1jYMs9IENrC1/OKembbUziOcBm9R6ufNJajc07ds39Lh9rXZL2JsCAbRNRySmQHg5Af27l4edvxjOIMyHKjQJNXGPezaiLdoNt9uudwhaCui93LBXqYlVjSom3Ia2DsRfUbQOrzTOphiRjQD88r+CVrnXnksIQpkgvTPEcAOKtQypsnSz2O9bbQm5Onp9A2p/8V1wmt22ItKUttbB8gSVpzRoCcFa+uT00R7br1bVUXnEHJYwVhiT2JKH2BldSaQ6njaHtN+XClw1KCXMYBRR6MlvByGxnWa0Q8D7BeAyM5QLGcZ283YtNDQcEMOdsPKWiX6A5gAn9S11UAJZ8Ife6Xw6nG4G93ps3d1MjxETZVkpOJVDKuOlbs16c71UYVwixaWhqkesprxVc+796PycLInRlpUy6rGEdV0zBzW3RDDpF820SI5rw6q89U63qGiBYlahdflMgfESVu2HwJB5sTLAMfwJsDSl9AQilT6vCEptZ4JSDbi0SFjofNQ3CKZv05ghBgVwGRWbZ9v/h4XsxXpMtHyfoSw1Kzw9L5Aw8LkCEHpGVbnf8pDLsxaD2kOgpRIdILrql3U1yGRuVXpuknJ4VWfO0nrQ1PVIuVJfqKpdKIVmFrVPQIbFvNPOwdLgrRcNcQDWhVsri9RsrCpgvfpwkrS1/f21nBnnblByn85jGqheqvjNjVbnOTUENQYic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHAzTzVrVmxlY3IrV0U2RVFZOGpIKzMxNUx1UUlKOTh0ME05OUhrVVNnblVi?=
 =?utf-8?B?U1ptTXRvaGVUSE1EdVM4cVNSbHFPNWxjUW1ZY0FubWZvZjVES25yV3g5ZEc5?=
 =?utf-8?B?NEdBZGk2NW5wa2tvQkdlUTY4ZVpMNmtDTFhya3A0b01vajZ0YlZmRVRQTkJ1?=
 =?utf-8?B?NVFhL0I1aTJ4M21lUXNXVTVQMVhUVlF3VzZXUGl4VlYvaTNEYlhpNTR5UUpa?=
 =?utf-8?B?T1VGNEd2R3pBR0Y1Rks0d2RqWnh0Um1GcUFnU3I3S28za2JyWlNMRVQ3Wisw?=
 =?utf-8?B?dG5TMldQSUJoTlJoTWdmNDhwZ0RRUUxmM1NvQ2w5L2pSN3ByZnNkcGc3T0pw?=
 =?utf-8?B?b2MrbHJwcy95Y08wWWprSS9vajFsaFdFdE0vc1lPNE94QmtyekJoekY4bWQv?=
 =?utf-8?B?OHNQcEQ5V25RRjg5bzJKU21VenNLN2NHMHkybndXd3IybENYVGZWNTk5eGVK?=
 =?utf-8?B?bnNiZTB0R2R5eVdIaTJSMnJOamdYV20yQmFlZFZ6NlhseFk5ckt6eDhKVzN0?=
 =?utf-8?B?OEw0RWdVYlRNMDJVdXlQRmIxemluOHM0SGdXOXZYazNCN2IvUGZ5SnRKSngy?=
 =?utf-8?B?QVI2aDh4Q0RWTmhJSjhaM0k0RlRaRzQ3MXdHdnJUbDIxQWZhRkxrbWRNUFV4?=
 =?utf-8?B?eWVRYkVaeHJTdWY3WGRLWEtodXRnSzNkTnhqQ2U0VE1rcEhzWVc1SWFLRWdT?=
 =?utf-8?B?cVNiZkV6ZjZ2NXd2VFJ4YXd6aUlTS2dUNWVtbytlVUNwZklaZjRsTUpvN0xB?=
 =?utf-8?B?MkU3by9oU05QUk1FbUZhZ1RqUHhTRURzK29pQnM0cTNQUWJKZGE3d0N6OW43?=
 =?utf-8?B?NWZyNTdvL1lIN1BCaTVQL0VRTy9mN2VsK3lCanhuUWR6bnhZREw1YmtYOG1h?=
 =?utf-8?B?SGgyZmQ0VEFKR3dWaFpUcDBnRGhsRlM0UWdpdWNZTHBpSXlBZ1AxK2FGTDNj?=
 =?utf-8?B?Ym40ckovU3QrQ1VQTHFBYlgySUFuSzBxM29LcG1uUTRqSDlGVExwaGZqWXlz?=
 =?utf-8?B?MUV4MXZIaWEwTVlBZC80Nyt2WmVSZ0FBU2ZNd0lPcUNzZmFucG5od2UvaU9E?=
 =?utf-8?B?SmdRZytJY3Y0YU1rK3NnYU9yQlRmeG9SUmV5ZlZmdTdTS0x6cFBodEFGVis5?=
 =?utf-8?B?VzZ0SFM1bzZpeGhhcjdkcVd0SXlBQUpkcVgrQTVyaWp1VzYwMU9ZYVR1MGo2?=
 =?utf-8?B?SWZHTDBWbEErNitxdjdma3lBNTkrYnIrbzRwMFQ2UXE5OW5Hc1VaZXhwNVNP?=
 =?utf-8?B?UzZ2L0ZFZk45dGd3czVORHEvT0ZpR3FEcDlRUUJlNjErcDJVU0tXVzB0VjI0?=
 =?utf-8?B?OTZIZDRCMStHVnlHNGpEc1dTZkdlZ0NUVnM2U2srcE1TRjJQeEI5V2psK3ZX?=
 =?utf-8?B?Zy90eE9HNkltSUhIMXFONi9Hc2JyaG5mYnBKVkgwZ2t5aEdWS2I0MkJQT0tE?=
 =?utf-8?B?VWRCd1RML0d4TDZlNVhPaTVRd3kxZEZIMkVGZ0JYczFqWUcrKzlCempnSjRQ?=
 =?utf-8?B?T1I2R1Z0U2o5NUVVQzIyQWFGaWFHM1B4QjBIdG9BeUNsTzVPZGJWaTBtYXZv?=
 =?utf-8?B?S0Yzc2drSXNod3NrdmhDdnhPY1dPRnFMdjU5akIwcGhzOTBqMnM2L0RXR2xD?=
 =?utf-8?B?ZkVwZFE0OXhRNVEreDRVNmxmc0NobFkzMmQ5cHNKOVQ0TUFwdXMzY0svSGJS?=
 =?utf-8?B?T0xDZ0RNNGFNN0h1OGJLcmVleGpMbDlCeWVjalYvdUpUZDk0NFc5eFBBTUlX?=
 =?utf-8?B?T1FqWVZBUVpXWlh4NEExQlJleW4xdGxYOGlzMzVSOW40NzVvUWg0eEV3ZWdx?=
 =?utf-8?B?QndGYjlYWi9YeFdod2ZIRTlqcG9EaDl0N0xxc1hyc2RiMmFPWVZPS3NHZkk4?=
 =?utf-8?B?bVJ2VkppWlZxRWlJUWYwN0tVK29adFp0QVlKS3MveXBMTWZiTWRPdmhUNjMr?=
 =?utf-8?B?WGhjMEJtdkQ0eVowNUNqdVk1SVRaOHJYUUJkQW9LaE9EK05MVWFEQmROVU1V?=
 =?utf-8?B?V2hNTHJwbDFBOU5Pa1Fxdnd0ajllTllMT3dsMEpwOStyZitkTGVCVEF2czFG?=
 =?utf-8?B?NHBmbUx4MDNldlpnelhwUUJNUnVWa0JnOFBjNml5M0x4QngrTW84cy83eC9u?=
 =?utf-8?B?dUM4aHg1dldVM2lwU2NuTTRCNVVaZXp5VVVSZkFEaXZkSlc3V0phNFFBRWZ3?=
 =?utf-8?B?Q1VmUlJNZmRKMTJLaVVlL2pxTk9RZEREZWRZS0pOdVlFOTZRR1k4VUhhNHJO?=
 =?utf-8?B?UHNlUEgyNXJhQVVNR2xDUThyTytrUHNpbUpmWjRUWThENHVuYXYvRXRweWFR?=
 =?utf-8?B?aEh6N1VrK0hGUnM2czlwL0NyUDZ3S2xlRFVOSlZUUi8yNndQMlMwdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef579c0-7218-4bfc-b3df-08de80ea48bc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:21:26.7192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNj4ViW/slHSXEH05/j+Za/e4OK2bu/InppNDa9dTpB9pYxysZ5sZN27lo5dktXohczkt6t0Mgz233aEu1WSIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10996
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

On Fri, Mar 13, 2026 at 10:57:04AM +0100, Luca Ceresoli wrote:
> On Fri Mar 13, 2026 at 9:33 AM CET, Liu Ying wrote:
>> On Thu, Mar 12, 2026 at 06:30:22PM +0100, Luca Ceresoli wrote:
>>> Hello Liu, Maxime,
>>>
>>> On Thu Mar 12, 2026 at 7:05 AM CET, Liu Ying wrote:
>>>> A typical bridge refcount value is 3 after a bridge chain is formed:
>>>> - devm_drm_bridge_alloc() initializes the refcount value to be 1.
>>>> - drm_bridge_add() gets an additional reference hence 2.
>>>> - drm_bridge_attach() gets the third reference hence 3.
>>>>
>>>> This typical refcount value aligns with allbridges_show()'s behaviour.
>>>> However, since encoder_bridges_show() uses
>>>> drm_for_each_bridge_in_chain_scoped() to automatically get/put the
>>>> bridge reference while iterating, a bogus reference is accidentally
>>>> got when showing the wrong typical refcount value as 4 to users via
>>>> debugfs.  Fix this by caching the refcount value returned from
>>>> kref_read() while iterating and explicitly decreasing the cached
>>>> refcount value by 1 before showing it to users.
>>>
>>> Good point, indeed the refcount shown by
>>> <debugfs>/dri/<card>/encoder-0/bridges is by one unit higher than the one
>>> shown in <debugfs>/dri/bridges. I understand it's puzzling from a debugfs
>>> user point of view.
>>>
>>> As you noticed, this is because the _scoped loop holds an extra ref on the
>>> current bridge.
>>>
>>> For other reasons I proposed a mutex for stronger protection around the
>>> bridge chain [v2]. With the mutex the extra ref is redundant, so in [v2]
>>> the extra ref is removed, thus making your patch unneeded. However Maxime
>>> asked to keep the extra ref, and so my latest iteration [v4] still has the
>>> extra ref.
>>>
>>> That series is still on the mailing list, we are still in time to rediscuss
>>> it.
>>>
>>> @Maxime: based on the issue Liu is trying to work around, do you think it
>>> would make sense to go back to the initial approach for that series?
>>> I.e. drm_for_each_bridge_in_chain_scoped() grabs the chain lock, which is a
>>> superset of the per-bridge refcount, and thus the refcount can be dropped?
>>> This would remove the debugfs issue, slightly simplify
>>> drm_for_each_bridge_in_chain_scoped(), and introduce no new issues AFAIK.
>>
>> Just my take on the chain lock approach - I agree Maxime's comment on [v2]
>> that keeping the get/put is a better than using the chain lock to ensure
>> the refcount is correct.  The chain lock could be added later on if needed.
> 
> Well, no, adding the chain mutex is necessary(*), otherwise Thread A could
> iterate over the chain while thread B is adding/removing bridges to/from
> the chain.
> 
> And the chain mutex is a superset of the per-bridge refcount, so when
> adding the mutex the refcount inside drm_for_each_bridge_in_chain_scoped()
> becomes useless (and slightly hurting as it makes the refcount shown in
> debugfs inconsistent, as you noticed).

For better code readability, I think keeping the get/put is fine even if
you add a lock(maybe RCU list is better than mutex, since the chain is
read often).  That follows the idea that you mentioned in [1]: "every
pointer to a drm_bridge stored somewhere is a reference to a bridge".
Plus, seems no performance issue with the get/put, as discussed in [v2].

[1] https://lore.kernel.org/all/DH0YC7M9YFU7.31DSHCPV381WC@bootlin.com/

> 
> (*) by "necessary" I mean it's necessary to support a bridge chain that
> changes after the card is populated, i.e. for bridge hotplug.
> 
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
