Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCEEC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A3F10F0CE;
	Wed, 15 Jul 2026 14:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="I7JFKQva";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023077.outbound.protection.outlook.com
 [52.101.83.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACEF10F0CE
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8YOCnzhdukjMJuRkhKDqUkIjWO6rVN3QmBYF35SPH1F/7oPhlgYXLDmXoMLSUxp1flDlfNbcokmC8A5RN+6vjptl4FcBLjRoisztH54MRHAD0FINNghZfQ0uyksaz/+yY9Ih37oY08jNLkrhK/i5QrokRZ5cD6nJMNjwrlPv/sifcFv6aLGkgNci0p/LUycUVZdIEAqpbQbZT22ArrDeCJZSJkr4ba+3X7rZT14nTC7CAhBNKS+ghECFqwCZpxmPOtgfc1cYqHf9zRPpeRSmuZX7sr2CkRgHFGiVb2TBPfN6mwzhcwtwzPkCe6bD0L0V1dK0/OpZ8HvVfLOhpos8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ0qLDrF/TZN32HMwFYZx62dstVyeAhl+CTJzCg8Lo8=;
 b=g3nG2w1t7zSTRZeoelHOlvL8l+cL2jfPoiHC8YeWq8bD6h+VfA/jXbL8SCvjlfXXa1WimBs7SFm/v6zl6Nq7TlAn9+hFzo0L2iyQ+wxGa7CEdZCuCHcLSaHp/m6hjpbC6JqnJ/nQkcn5tkTw1ekHpbtgnNmWwfSdluvSUu4oII5zmJiVwXFhkQsu1o+t8edEQ5SELDTb5n6biQ1wQhQif+wXeBISQS66lHcMhgaNN5EUmWl01sXMe/YvMGULq5a4l9KrNwX7Uuudw+RpIKqxpFSl5XNbw9dV1E2yV81gvQ1+/dxLfM+iBPDLfckmZUXkAQ+gJ8QkaPuo6Vd016RzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ0qLDrF/TZN32HMwFYZx62dstVyeAhl+CTJzCg8Lo8=;
 b=I7JFKQva2bzZYReeJamYOXcUrdeCYaEmAuILNaVL2Iyo5aLx1ofgTWxqFym+41eiT6FllS8+c0dkoJpxZ+amwua4Z6lHp5EuJDdREFRmCvv5skD+6O7qQTHGVSiXQNzxLGcT6XVUgwz018mCD4Uwr5gn4TPlpUetdPrwFqigFyt+vqe9X6JzsMGL2zL7UCZeMB+A5av3OPGEWyzWQ3QESqysIRWBwwRWM/FDLzxEarDxI+E1SIA4/qStEgyMc9pojBDRGoIuyg8y38GEIslgXzQGRTo3GK6Mc6DmjorArbIX6oZxVSs/JHJmQGlw1s2to0JrnOky3BVTVbbN1hPq/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by VE1PR10MB3903.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 14:14:44 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 14:14:44 +0000
Message-ID: <48f6f55f-43fd-4355-88b9-d2e2d0e26d07@kontron.de>
Date: Wed, 15 Jul 2026 16:14:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Fix problem with premature
 PLL locking
To: Gary Bisson <bisson.gary@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Esben Haabendal <esben@geanix.com>
References: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
 <20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com>
 <178410553814.253594.6153852459811911516.b4-review@b4>
 <aleQlpx73a5R8QgR@owl5>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <aleQlpx73a5R8QgR@owl5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|VE1PR10MB3903:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e906cd-ba20-451a-daa5-08dee27b6b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3wDZGtTKBem489zKEg3O4EZYiT4TQBGowyK1CEYDTqBJeat22Xn3k8XlqF7fe1TeCxaD9ou76WdGbiKpDpDgyRcU8EHxc9bK1Jo+WySnP0vRSO7k0L6E5CSh0G3afax91lkhJVJlYFeJWtMGwBW5gnN1QYSlzqhVtyHN6y+FtkXzUeWqcmViMexbhp5qKVhawO2wI4/PTIx8nl+vPYVOhFib2vr0Xwb0mIKc/eB01gFzV2WGws8BRtH94SGI1QQ/IbvswVStfYtcPf36NdIOF/A34q+6SEn0KSR/VIDQVlH99pakeLyZiKzz6WWy67L/MaIWr4K6vDdEENmcoE90/BxaivgnEMUw3Gl/b9Km+2qSCzs5FDuw8SYSZN6jS4KIbplE0S+/owgIRPH0arMWCoyZbjLBiHnDbuZdDxkvq9wBF8DcJzVLdkFdb41IOIxlFM2udAU/WSDRnjcFD1Zoi3YXQfdvD+nwVr9s0Y4lYFGx7r+R/TBHuX7Qbl17lJ00RyoHpdpG5oB8odT+l5HGANdYFzah2P3ce/LqMtSOzRM88EknwRvgHtZ5gN6BIItt+R6AWehNjQAsL1SkmAMDs609YC8hGrXzK8tb+y90OH/u+5Vdj7zYT9VIOnnH5srGRNIhTQSsMkNml0nW8oH/RPZIxcflZyIWqBTl861Xx8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTJmU2Z3NHorN2xnZ2g5T3R6c0RYSUsxYlR6Wnc2SUtkdERuL0VLdzJxN0s1?=
 =?utf-8?B?ODVYOHFPcERhbkhmOGpmU2svNmxrMkREeVdpejJDN015UTh1enZNeTFWU01T?=
 =?utf-8?B?TjZVRTg5Qk1udFluQUVlRU1UQXNHYmo0UlptbnYrWm9oMzJoRHRmMFZ0aXZ2?=
 =?utf-8?B?QUpSdXNaNDZ2aHRUUy9wWXRrOFBpM3R4SllMcVRZeWxKbGdEUkJoVmpZQXVu?=
 =?utf-8?B?Tkh6MHkxSnA5TG94R1A3Y1Fqd2Fra1VuMlBHYXpWV1BudjEwR0xYQ0kyYVRv?=
 =?utf-8?B?dHlHak1Mc1hITDR1WWU3a2EyT2FJbUkrRlo5dFdCUmVqd1hZdExUaE1RZ240?=
 =?utf-8?B?YW41eGVrVzBMcGpOOHhkS0tCNU9SamtZWDBNMHEyTHc2S2lwU3BjdnV1VFBl?=
 =?utf-8?B?bDFHQjdxaVQ4cGhsQXpSbjVDaXlaSlNwV1V2U2NpdnQ1MEMyamQ2bThMcC91?=
 =?utf-8?B?b1NIWVFZUzhMcFhUUnZXb3FScTMyZ3RudmZOb2NlWUp3NnR2S0gzL21wTWlu?=
 =?utf-8?B?YWRnQlpSci82aEZqOXRFbmZWUTNadkhmdHZsRHJyNnZVS095TkZJbk0vdnp1?=
 =?utf-8?B?dFZMeHd3cnkwVEpwTVJZeWdRdFVOSmJVQldFMXRHQUpyeHRkazhpZEVZSi9u?=
 =?utf-8?B?ZEhkVlhuM3lESUpaMzJ5Z3orVVlPd1UwQ1lBQjA1N00zVWg3anBBTU1td0pa?=
 =?utf-8?B?M21MSkYzckl0QkVnQWZGTmQ4anVHcUZMNzNrRUtmUU5DZVpCK2hzUTE3b09E?=
 =?utf-8?B?MEIrVStmT2pLQ1VIa25zQWRsUWVQd2RqQ0tnSXFrUXl4MkFZUkxRZmExbFYy?=
 =?utf-8?B?eWl3cDJ0VWdaNFB5eDJlemFGMWcrcGlzMCthWHdKNnNGbHYzT1kvRkZUMEU2?=
 =?utf-8?B?ZmlqOXdCU1d4T3I0Vk1mSkN1dURMckplaE05TzI3c2xkVGJ2WWVPdVMrV0hy?=
 =?utf-8?B?QUlsRFlxdWhiN2J5aFZtSmdFWkZXTXd2bCtEN0IvbjhVc2JpT2Z5YVZqOUZN?=
 =?utf-8?B?QXFuK05FcWoyNjRwTlJ6MUYrTnRpTTRuZFU4Mmo4cmJkNnFZb0tZUWFpcC8r?=
 =?utf-8?B?dy8zdVhMV2ZBalBPU2tFbnFpVk9hbU5XUWZveEI4MndWS2lGNmdDRmFtVmhi?=
 =?utf-8?B?UEZiR0RhbThnS3VubkhaQVk0RnN1b29PL1hNdmlmZXZUVGlQOWJLYkNvZEE5?=
 =?utf-8?B?MVJQV05oSDIzY1dreXBlbjNWeng4ZEMxTjI4K1hqUVlIZXU3b3hENTY5SHF6?=
 =?utf-8?B?M1hjVW1CZkM1VTlGSUI5NGdxU2dldGtQTFQ1b05PSjc3MnREZEl1TStFWmhx?=
 =?utf-8?B?dmhINWswV0tpaEdoMnBhRThOb3poZVJXTFh6RVVuQnI5aE4xdHUwSlgyY0po?=
 =?utf-8?B?U2xja2VXVXZGSE5tMVIxMTBTdmpmSUhBZUI5akdydG02OHVlUGFlSitlNHpw?=
 =?utf-8?B?ZjdudzVhVHdJTUtVOUl1WCtXNjlpekp4SUlYVkdidHdyREpQK25EeU13K281?=
 =?utf-8?B?MGN2TFF4U1ovRE5XNDFKNFErZXNzTXkyNnptOEdxb3ErSVBtUHQ0eTdHNzhI?=
 =?utf-8?B?c3Q5ditsdXhIV253OUdZRWprVWYwNUIxRUluUmJ3S3hxYTJmdHVWWUYyUUsz?=
 =?utf-8?B?eFprV1JnanZ4U0E0Qk0wbzFvL2w3dUNOTFIwbldDOUlzNGFhVVpZUUhWN2Z3?=
 =?utf-8?B?SGVlTXFYT0FEQ2kybFlDMGRqS0w4MmVmU1JaNFJ0QldjT1FLcGlpc2dyZVRW?=
 =?utf-8?B?bE5nQ2lINDlQRFdQcGI4TFdzSEhmU2x0WTFUODlnSG1ZdkVXRGNXRnZKdVY0?=
 =?utf-8?B?T2NHOEl2citrWllXWFMxRGZidGhRNE9DdGtqdzkraGYrc01xejJoNExZOHJF?=
 =?utf-8?B?cWdwMWtSaFZYdWVKMnNmSUJWT1B1L0h3dlBIbjdOdjRoMXF2OFpYTjQ2Z0dW?=
 =?utf-8?B?UUU3L2IvaGFjTHozTzBmZCtleXQ5Z0VPZmJQZjl5Z3UrVjQ0MGlkcmRyUlA3?=
 =?utf-8?B?QkY5b1IrajlwMExqbm5mS3JoZnZNZzNCQ2pqYlZuUUdKRVhRMDZnMHFsWmdo?=
 =?utf-8?B?WEppaUlzUlY5SnpiSUFQU2kyYi9LSUhmNXBhWEptYkxBZDl0bDVwSXJodXVq?=
 =?utf-8?B?MElpV1BqSis5eG5IZXZjYWlORXdYcVI4NXRHb29mYlBMN015MHE4VUJjekxv?=
 =?utf-8?B?RVUvdmFnT2tVVXNmUGpCRC9GZTErdldhaXplSHE4aGtxT3g1SXdCVG43c2N1?=
 =?utf-8?B?NUhmY2VYbnliRTFQK3QrRkx3Q2RLSlVONmpqd0lRY3RrRFUvbjY5cHU3Y2xK?=
 =?utf-8?B?djNPZTNrOEY4Q2taYkExUExDaXN6a0xtYW5nOUFNTEVEYllhbXF1c3lZNE45?=
 =?utf-8?Q?DyoBKQBr0UmJtpYM=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e906cd-ba20-451a-daa5-08dee27b6b1f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:14:44.0442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REt66xLkmE/z0dadWhsd1glfMHCx9uKlvTEJRtCuRlkMLAuQGXjnKYfVowzG/Yutmmlhh5pXg4mAiZk7hsEpNQ5bGFoZG9nqqLKo7aRELrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3903
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

On 15.07.26 15:52, Gary Bisson wrote:
> Hi Esben and Luca,
> 
> On Wed, Jul 15, 2026 at 10:52:18AM +0200, Luca Ceresoli wrote:
>> On Sat, 11 Jul 2026 13:51:15 +0200, Esben Haabendal <esben@geanix.com> wrote:
>>
>> Hi Esben,
>>
>> +Cc Gary
>>
>>> [...]
>>>
>>> This is the same issue as addressed in the patch by Gary Bisson [1],
>>> but changing the ti-sn65dsi83 driver instead, so we don't have to change
>>> all other drivers that could potentially be used with this chip.
>>>
>>> [1] https://lore.kernel.org/all/20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com/
>>
>> AFAICU your patch would replace Gary's one. Also Gary's patch has been
>> reported to introduce regressions but it hasn't been reverted yet. Can you
>> reply to that thread mentioning your patch, so everybody in the discussion
>> is aware of your alternative proposal?
> 
> Thanks for including me. I just tested this change and reverted my other
> one (mtk_dsi) and confirm that it works on my Tungsten510 + SN65DSI83 +
> tm070jdhg30 panel.
> 
> Tested-by: Gary Bisson <bisson.gary@gmail.com>
> 
> Note that the sn65dsi83 driver wasn't changed as I thought the PLL lock
> in pre-enable was on purpose. It was introduced by Frieder with this
> commit. Adding him to the thread to weigh in.
> dd9e329af723 drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec

Thanks for the mention. This was introduced to keep the init order
according to the datasheet. The DSI host first needs to put the DSI
lanes into the correct state in its pre_enable(). Then the bridge needs
to be enabled (including the PLL) in the pre_enable() of the bridge
driver. Only after that the DSI host is allowed to stream data.

Moving the PLL init from pre_enable() to enable() probably violates this
order. In the past this lead to sporadic issues with some hardware
setups (depending on the display and the DSI host). Some of this is also
described in the docs: [1]

So from the first glance, I would assume this issue needs to be fixed in
the DSI host driver.

[1]
https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operation
