Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C789FF492D
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 02:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F4D10E118;
	Mon, 30 Mar 2026 02:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GtwsXvE1";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013032.outbound.protection.outlook.com
 [40.107.162.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369A210E118
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 02:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwnbWOIOgiWbT05fvk66ECqnsGh8Yi8N9MZoxbW1Hfok3cmdjEgkd163M1faqDsHyOOrIhhdMboDmvuim9312BRgDoTyB98jAUoRKGfWLtWjp0CF5SFpIODo2GtE0OTuDC15KRmiDJ+bnshv/b6U3WUlbcK2KRXaisRztdHOzoX4d/4WQTI/V/ZH5BP0KbfNabqPWSn6h7IMqdVzcOtFlftFeO69605uaWyXC3mTbBFi2eYsm8iRAO9yOe0cyVnkaI7fCJ2Emiz4vtCiUkk+xnIM3k6gl++wpoGg8AGDhKmu/pTuKvuhHAe0n2Ys/9nSGQnzNcOb19x2nkRQqjwNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz7dWtpsypB3O28NYs4Uw9RevgM9QrHDi9jtKhdWQNE=;
 b=WqvnlayOTN024EcRFSC+Zm/BNmJOhQsKbV3bLCNUz4+k9p0CjsT9hDlbcHOLkU9/CEhixww0oyuA9/uKEA9dBeJSv364G59JvckjdRHgzMeox0pK8ADpLM2MRaI4xfGxFAOE/I5r3mpet+lKRLfReHyoDXONLYuEJGNQFDafnuqs2n1Hm3UQkp/Oqgr1ilLKEB6zEUaXHZiKZRoFG/CwSMX9Yunf4RnIkiF17xM2lwpp03ENxb9GNNxtLs0osuCk8qd41LUGiD4kNQZ7HRWNIfPi7IzEXVkgRcJ2Txt3ZCo2inY7Qwajt5Rg8nJ0FmLv++O15wKYcEeOG73OEHVP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz7dWtpsypB3O28NYs4Uw9RevgM9QrHDi9jtKhdWQNE=;
 b=GtwsXvE1GU4M2gBNR5pC39mCXxM5nGOeuxoJUj63woDE10zxhTjd4Jg0pVm5j+1AVozYWfeEekX5izvwuV3i9n2ELVFcW+bH/bkArMMfdO3T5w4ej8//EOozKSUEAxuTa6RwDFOGIdgVdt9p/XZ4/lr43RRS+yOxe+w32JqpoKZfI72QKa3ouF/xdKdM6/k1Riw5Bv7RN89yCZCj2sSxUrOAPiBpRhXBQ8DsOcEQ0byJHIoWaX9XCYTa0eeT5bFH7Vui4uHIWS42YsLqz0p4Pd0MqLV9ShfY+f7qT1ri6SE+pWMMBqn32Q6ej7ql4IcynzS6dWE0ag3h7yuhAC1ZvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU2PR04MB9082.eurprd04.prod.outlook.com (2603:10a6:10:2f1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 02:03:57 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 02:03:57 +0000
Message-ID: <aabe88e5-70f9-4ea1-b750-e425970a2761@nxp.com>
Date: Mon, 30 Mar 2026 10:05:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: bridge: ldb: Require reg property
 only for i.MX6SX/8MP LDBs
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com>
 <crqzju5cqhvmy5msxvuquydmnpb2ft2t3gsyr6qsre6ccqjvzz@46gfcrelczsr>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <crqzju5cqhvmy5msxvuquydmnpb2ft2t3gsyr6qsre6ccqjvzz@46gfcrelczsr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0062.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU2PR04MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2cd202-bb55-4cb6-45d1-08de8e009a4b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gYVyiWifvJ8jhka2+DIqsOeW+HE/wQfWkxX8zjx5740NMnrNvZISmT2r1GoyqNnrWCj+ePxu40ZrYuIWyad/KBx7t5xwv1yRi1C8dGCFJR9IMIfCxwrIxdY/zMle+nIzIVet2EWA33nZhlDrE2LweZwUswocUFr/Q6IMvzcUWuDWySD2sp/Etsx1YW/qmHA8PNiBTSQ9kqJ1QiH8Qmu3K6WeeUmqg8J1QkXQdyeTDI/bi6kTwGMhEgsKeWMUS2awZkJWlJaMmZO7Um23t3IGcNUAawL9aW6dWD5AvFrotxg20yeXvjC7CikuLmd5qPKlzUEASNu6jWN514+Iaev0oBhcZKF6dqtZzU2mbFdETpGc0jgRi+cNALMssa49xD0CLBdqVtMeg9kTwo1T2hussB6fyt6Q575YRcUFPGSTIm4Bm1ojiXeHrRqUhlv59bJkIsbHFG0yT8bxwEkyvCJQgS+KgmkejyLZ9Xu/0KYiY95gi2g9NRlBVHlxQwHisg4sCSfDTOS8ypvmGP4aCU+L0UH9yTOPn+bL1VKMZP3V0XJPz3XSeLHmVvulX7kV6JyTAI1Xch7KR0JOBKuHX2VVxx2AnwhREFD/qfOYiweMg9ZnTfAcO2ubHzpesitsPISweRc2z2oRpx33bQq9Kh6u1NeM/bXP7YcEWm3JcGGK8ljJVRoowYWTQJXir4HTtGgb3Qy73Q9kIOeCKeREvKSih5PWtSqdfKHaiudTL1xGANI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjN0d29PVXJtMGZmcFJ0KzBsdjNUMXdwbmxMYzhBaVlQNkJweUxyRnByT3Jw?=
 =?utf-8?B?dDd2bkl5c1Yvc0ZDY0dlMGFiNmFUY2NjYUFYZzVPTFlub2ZuQm1pWXRMOXVI?=
 =?utf-8?B?TDQ5MWpHcUZGSUVaWXdIcHk4U0Q4RlBYQ1V6SXVpRnk4UDFndndEd1dtQ3NN?=
 =?utf-8?B?d3BacjNPNVBwWEpvQkR5eFhtRnZ2MGd4Q1c1STRxVlFoWjRjTWxPSGRqZDc0?=
 =?utf-8?B?TWppN0U4cFVyMm52cm9HdXQxZmNFT2xRYXF3d056T1plRDdEWmRjcXpWd29D?=
 =?utf-8?B?YW1BT2FGN0pwZU50V0ViaGR6UE5BdU1PdzZGVm5ERDhiN3BxWWxjNzFsYUpj?=
 =?utf-8?B?czJSTUdISGVNYjNaM3pxeGxHTjF1UlI0aExMUVlBbWRkc2l2cktkNmRnUGZE?=
 =?utf-8?B?QXkvYll4MGtFZFJmK0NuUGZkWmV1K1lTMXFjYzMzR3lIcWtZTE1VS0tlMU5D?=
 =?utf-8?B?Vng0WjVHdHgycEsxR3RwUXFkSnU2ZXppKzJ1ZEtkUjBvbXFZUzFnNmV0ZGVs?=
 =?utf-8?B?UDc4YzE0V3BCMUNDSnlUN0s4UVJBbGt4L1VZUEhoNU1Oc3RJVkJSVGlmNWVX?=
 =?utf-8?B?MkZFWVFVQ3NHcE5oTHpVaUdNd05ZQ1Nmek5XTjA2RXpWN0laRit3SDdpTjk4?=
 =?utf-8?B?Z0F3QkRSVUVhL3UxMmtSN2drbWxPOEFJRFZoRVd3bnVtUUtHUjY5NnFuem1p?=
 =?utf-8?B?dHMwdHoyYStMOG84R0NNcTk2eUtpcVN2K2lhZGxtVmpXaTNxTW90RkZyalpL?=
 =?utf-8?B?SnFtNXRNNU5hdnRvL3hGUFRuTnViZUhLRkVBV3RXbW9LdzhFU0hBdmhPNVdR?=
 =?utf-8?B?RDV4b2xVWURNd0UzYm9oN1hYZ3kxTmZqaHVLMEQwTkxVUW5BQjR4dnBxMEl0?=
 =?utf-8?B?R1pFSno1U3VQSHJwL2J0QnA1OGdjWnJhUHVzclFpT0pVS0xsQkZBc1grOFg3?=
 =?utf-8?B?cXpQOEV1UENFcmp5Qjc4OFpjaHZoSG9ydjhBMGxLS2lNVXZPbnJvRWt1QU95?=
 =?utf-8?B?aU53MlpPaWdVRDNZR2JXY0dWVSt5RHpRWld6NlltNVBMQ0RZdEMrUVJwWUNz?=
 =?utf-8?B?Y3NETzI0WXNROXRIdnRML29XS1I1bDBPb2NnUW1Ib0ZZTDhuWk1DMjBXaEhn?=
 =?utf-8?B?UmJOQlM2U2dvSktlQUltZnFFSGxFUXg5N0RyT0lMQ2p2Z2VFWGRPMTltZGhs?=
 =?utf-8?B?L0ZiSXQ4WDRKOGJ5ek40ajN0Ry9zWEorZjVmTk93REQ3eGtXaDdtZVBpb1Jo?=
 =?utf-8?B?VmczUW1aMGhuelk2N1MrSHg0SFBxWnRidlBHb05MNVF1U0R6bXg4dEFKMU55?=
 =?utf-8?B?Z2tVTXFodHFEM0NWWjQzUVR4UlRGLytEYUVBK2pnZ3lNc0Q5K3F6aWJwMm9h?=
 =?utf-8?B?OXU3QzUzM2J5dVRnYUdka1lYdjJZRU5UbWRidERBQjRPYld6MXZyL1dwRDRr?=
 =?utf-8?B?VUsyNDRjQ1hnSXo0VTFQOVRNbmhlQkw2M3VZTkJmVktRZkxjcEc5ZDNNc0Fs?=
 =?utf-8?B?blN6aTJaSkNVSkdJZEd6WmtvQU55WVJMWHoxVFRBdTY4eE5zY0FraEJzSGRt?=
 =?utf-8?B?M25NY1NwdzlHMVcxSlBGcXU2bXNRNG54L29nbmlENXV0eXdJeUJTbUs2eklj?=
 =?utf-8?B?WEFuZjhUSHBCekNhRUtKRzM2bi9jSm5oV2NXM2l6V2I1QnlES0o5a2tMam8v?=
 =?utf-8?B?aTl4OUdWcHMrQUd0a1Zhb0tSVHJVNTdLYTh5d0pFSThuRE9OOWtFWndNWFBz?=
 =?utf-8?B?UlJZeTIxU21OTSs4ckwyamY2VjBHT3ZRZjJIT2xuR2V5aTNsdDJJdnl5QWVJ?=
 =?utf-8?B?dFpzR0tBNU84cUJJbldSV0YreG45YXppSG9HbjNUWG0za2JNdUIySnUrRkRx?=
 =?utf-8?B?Qi90SW51Y25VN2ppbXBrdDA0Y2dMdVJ0NHpNaW5HdHRKcWJHZnFrNHl0YUds?=
 =?utf-8?B?VE9mTCtFcTRYSEp5dU1sYkpqYkgxOTNjbUdyb1hLZnByWVc1ZXBqSVBRWkdC?=
 =?utf-8?B?a1p1WHgwWVkxMmlZN0FXTGViamMvanpNazhFQndBY05uazVNZjA1WXZFODc0?=
 =?utf-8?B?ZTV0YXVlcFdyMUF5MlAvelRhdlBsdUNXT3FVeG1zTGZ4UW0yT3dETjZOQXBG?=
 =?utf-8?B?cHF6MGQxUklCZzRnbnphV3pmTTZpNzdXa3huUk1GQXRRZVVMZERlcFRULzNZ?=
 =?utf-8?B?amE2cno4Y0tTalhHTkxhYjdIR0RzMjNnYW5xUEh1UTRkdVkwRWtLQUg2a2xa?=
 =?utf-8?B?V1puL1hTdmRuREs5T2d3Q3JmcHgvazV6NHJ5NWxtWHNPbS9LdjI2QVhFbEJB?=
 =?utf-8?B?V0svOVk4V0NTRUhkbHZSUEQ4WmNFdllMb3NQTHJYNnMzWStqZmtqZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2cd202-bb55-4cb6-45d1-08de8e009a4b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 02:03:57.4546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mJgdITzmdI8RdfxYrHXjOH5CmGe9/RbJKSYwwTMudEBdvhiAf9NX60Ob7tMnSVgh6X1xq1K/apU5RacLM7fQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9082
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

On Sun, Mar 29, 2026 at 07:42:23PM +0200, Marco Felsch wrote:
> Hi Liu,

Hi Marco,

> 
> sorry for not writting back earlier, the last weeks were quite busy.
> 
> On 26-03-29, Liu Ying wrote:
>> LDB's parent device could be a syscon which doesn't allow a reg property
>> to be present in it's child devices, e.g., NXP i.MX93 Media blk-ctrl
>> has a child device NXP i.MX93 Parallel Display Format Configuration(PDFC)
>> without a reg property(LDB is also a child device of the Media blk-ctrl).
>> To make the LDB schema be able to describe LDBs without the reg property
>> like i.MX93 LDB, require the reg property only for i.MX6SX/8MP LDBs.
> 
> NACK, we want to describe the HW and from HW PoV the LDB is and was
> always part of a syscon. This is the case for all SoCs i.MX6SX/8MP/93.

The reality is that i.MX6SX and i.MX8MP LDB DT nodes are already in-tree.
People may take them as ABI(not only for Linux, but also for other
potential projects which use the LDB schema and/or the DT nodes).

> 
>> Fixes: 8aa2f0ac08d3 ("dt-bindings: display: bridge: ldb: Add check for reg and reg-names")
> 
> Therefore I would just revert this patch completely.

IMHO, it doesn't make too much difference between my patch and reverting
this offending patch, because of the ABI, i.e., the reg properties in
i.MX6SX and i.MX8MP LDB DT nodes are supposed to be stable.

I feel that what you are asking for is even more than simply reverting
this offending patch, that is to say, completely disallowing the reg and
reg-names properties for LDBs across all SoCs.  But again, that would
break the ABI.

> 
> Regards,
>   Marco
> 
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>>  .../bindings/display/bridge/fsl,ldb.yaml           | 23 ++++++++++++++++------
>>  1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
>> index 7f380879fffd..5f6dc2b11d7b 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
>> +++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
>> @@ -28,6 +28,7 @@ properties:
>>      const: ldb
>>  
>>    reg:
>> +    minItems: 1
>>      maxItems: 2
>>  
>>    reg-names:
>> @@ -68,7 +69,6 @@ required:
>>    - compatible
>>    - clocks
>>    - ports
>> -  - reg
>>  
>>  allOf:
>>    - if:
>> @@ -83,12 +83,23 @@ allOf:
>>          ports:
>>            properties:
>>              port@2: false
>> +
>>    - if:
>> -      not:
>> -        properties:
>> -          compatible:
>> -            contains:
>> -              const: fsl,imx6sx-ldb
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - fsl,imx6sx-ldb
>> +              - fsl,imx8mp-ldb
>> +    then:
>> +      required:
>> +        - reg
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: fsl,imx8mp-ldb
>>      then:
>>        required:
>>          - reg-names
>>
>> ---
>> base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
>> change-id: 20260329-fsl_ldb_schema_fix-4fe01c42bff3
>>
>> Best regards,
>> -- 
>> Liu Ying <victor.liu@nxp.com>
>>
>>
> 

-- 
Regards,
Liu Ying
