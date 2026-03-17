Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92B3FED9EC
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324BF10E3E4;
	Tue, 17 Mar 2026 17:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wK0i+3aj";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011019.outbound.protection.outlook.com [52.101.125.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B482510E3E4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEpUNk98bMsjf7CvrSdesBnmfWLLoFgUsY0nmZceGOWAwYDsq3HHshTp3NDlDLuHcwpGfQ2r5VvDBXWPhXP9cl9/D9PyPJeCw+8lFlNakZPY1IfqFxskkRAS7kFxy9+GJsMNeGeIXZVij6x+KIctSTu1/CE5NS45WZYHNaCRtgeHEdNEU9vNTUA5ZOY/qA1sGi5kMI6gYdGduWx3k0Jy+dBHOfhu2WbJZFDaZP1VLR+EJ5F+tMo76xk+LPZjoIq3z+59y0kfJJqoGBRLBT1dRFMHHCkTgf18gzyVD4VKeizjD3rUFOvCpZlnO2VNpl4L8kushKtC6H3xAiyZOc7aOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18ZQ2NcXr5EADxd4BvwIKDmYuOGH1cA8nU52q6nK0oU=;
 b=iGvr0pZgBpRNnsYtvnrzbF2qlijDhJPS5igy1JcOCkwvGrigoM3z0/GnsJlrNLq6nxjDiijXdcUontBYvPyHL7yRMYMQQsystmVpApCybCk3k2d/z+XH5OrExF2lSq+E8Emh4RBAa8a0QzHxcYYoQ+jjfY+A8EV7+YYN5cTzIQFgromcod0D4UacdI77V0i1puld+NZbi/PSE2QbYqEKnfRJE8QO0MYJ90oMTFH5wxIGzoPakxfVYRkuh7FwBaoYOj9K15ogJSzhKpRujFUXNQHzfSnnsv8UPJu79AJhDMkihXY+IV/jxEc25PxDGtbNTDjuoa8Vy370KcEI8jHj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18ZQ2NcXr5EADxd4BvwIKDmYuOGH1cA8nU52q6nK0oU=;
 b=wK0i+3ajObzRzgPEYed3z6Z54c2vdgUf7eQ30JV4FPKOYBoVuoGSREagvngk4dryWTKXkWtHRUGPSz2kpbsFilTLr4GR5EcR0L6RxNH0bUJoJF/DdY7ThD2BMlr7sxWTdM6UfB0adtzetHKkG6/DG1rSuEkrUNZOH7N13tVlI1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB13912.jpnprd01.prod.outlook.com (2603:1096:604:36b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 17:10:21 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 17:10:21 +0000
Message-ID: <474c1eff-96ea-41b8-81fe-970caf796e6e@bp.renesas.com>
Date: Tue, 17 Mar 2026 18:10:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/20] dt-bindings: display: renesas,rzg2l-du: Add
 support for RZ/G3E SoC
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Tommaso Merciai <tomm.merciai@gmail.com>, geert <geert@linux-m68k.org>,
 "laurent.pinchart" <laurent.pinchart@ideasonboard.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <cover.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
 <ca022fdbba5236c36e0cb3095db4c31e8e0cb1b8.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
 <TY3PR01MB113460BED5F6F944C0FD4DDB8866FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <TY3PR01MB113460BED5F6F944C0FD4DDB8866FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS7PR01MB13912:EE_
X-MS-Office365-Filtering-Correlation-Id: dd88be79-995b-4b9d-e8a4-08de84481246
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gxQyiFA8eQH0LI0Iv6SMenpM3ZuddAmUXs0LQoGftGduiGKchiR+HY2M5t7sSrqGYeDinGAneHw0WUjYsH6C+TnmvRKIuDNGcqWOpZb94AA6hxW1kV4Ujpnhy/LgRlgcDToeqaQgey2FWi6jlGOhgjhYEcMXaSdU6wWBBRmMzslXV+22QEqUhASUVvYu9J0pwnE7qwjyaMH2Lk7f+ZHcadKNcwZcd9R09V78/Epi+zBwR+U9ANhWGkWlhKgQIN3v6I/byTACnV//uqlpIaIXYiU96SW6CAThm3ZIYZZKX0zznzkQPoGgSar2hEVkUSWIpL2O8Idlk4Do1r5gfDo2hnVbU/olOppbiRdJfEtPfhlUEktIrGQ7W9UWMFW9JQEu6XoeayyYIfAUY3UZHkptnkIuJFtehOP2k3E/5aRWjs+TnMshuvGiMcXdio7pv2HKNfOsK3H3/dBFEaE9+2rJ+MxU55hMsrbriyEcIzEqttefALypSftCtq5qux8ZrR93kWPXarJtYIAMRAssrRFypZlJxaeyIESIIlwaLhHObM+DaL6gDkp+T23eks0kGkJoBlQRTh6SCSEaC/icKMIZVXV1p7aFczstjiPRouiXL9R7fC7fIDRP2o0sdccR8oDjESfxfID0mBDHQFd/b3UaTySxpnbCAnQfazn/BrRknK84fN2i4ire3HsRSYOklCQdVACeFB24eHJ8nkBDJBY+sn1HLyQAvK3m8/q6u7DCZ8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm9tRmd0T3VaOU9wTzB4RUdRd0dhNUNSSllNazAxQzZ6Tkk2K1hWaGlkcUk0?=
 =?utf-8?B?bmJPaSt6cmxPL3JVaFRBSzBKbjA3a3FxVmExcy90eXZWUngzanpvbUhpQWI4?=
 =?utf-8?B?VmVmanErUHpOSkxHVEc5dmtnTUc5cmtrTUk2aXB2WkcrTnlFTUYwMmRQeG02?=
 =?utf-8?B?V3JkeHRGNFpLTjdiSG40WUJhSGkrNXhuOGl6bnkxVWhRN3grQ0lTaU1CR2dN?=
 =?utf-8?B?NitpVEFvRGtNY3crd2VOZklKMkk1cUF0blR2azU2M3VUNi95UHBERUx5ekVB?=
 =?utf-8?B?c2NOQkc3MUFVeVlrcHRacldQL1BoTnBEUkQ5RGhIZklSeStIeTdHZFRjZkZK?=
 =?utf-8?B?YVFCOHBxSjkvTWhoZElBTW1iR2tYYzUrMFRXUWtQL1BYTUo2elBZdWg4MUor?=
 =?utf-8?B?aFpNNk9MUFhQN2IxclNnNTJUMG1VY0t0UDdXQ0VLcGU3OWJzcmE3ZEt1Sld1?=
 =?utf-8?B?Qkdrc1Y3aGFDM2QrMEtPYkdiZThKUUxKU1NCUFp5MW1kUzFVNUJBZXM4Wk5Y?=
 =?utf-8?B?SkFrWE1FbWYyZ0lBS1FnZXhoMWlRSlNSZDlkc0RVOExRVE9SV1RVTWIvenBh?=
 =?utf-8?B?WWpqbXVNOFcrWndDOE9kRzE2U3hsc2RLenpkNWpxRXF0cW92ZnNTZ3AyM3Jz?=
 =?utf-8?B?bkJtNTlVejE4SDFGY0dXVWVYZ0U0b2Q1d1NjYVd3NkV1d3o2ZW15Vld6Ulgy?=
 =?utf-8?B?V3hORGc0aHdBUDFaN0JPY2tobk9BeU1NNXhLT2k1Y2NoajB6SURnU3R4N2xY?=
 =?utf-8?B?V1hxZlhmM013eUlURnJyVXJaVW1QNGMralpDNHpQMm0wTTNkam5yYjB4RFds?=
 =?utf-8?B?TEsxcEI0cGxvcUo2SmxEWWU1dDl2YjhFV2xoalJhOGhycXF6cWE0dGl2Ritm?=
 =?utf-8?B?SmZLM0ZOdUdRSTJwWWM4QXo2NmQxNnhxZkpGK2hhUytWMU11OTcwVjhFcisx?=
 =?utf-8?B?T1FiMWRmNnVBRURiUE42dVhzTUR0VnFQNzRBdEphakU1RUlZbXVGNlRsdmEv?=
 =?utf-8?B?dk8yS2xrb2paQ3J2cXZpbENWNHZEOTFreUZ2YmxtazBEdnBmMCtKQnpadzNh?=
 =?utf-8?B?ZVJiQzM5TFB3TEp3bkpuazlZVG9QZGZlTEkxTDRCSWxiWGFnRVpqRVNHanpJ?=
 =?utf-8?B?dGJ6aVBkQkU2UktSR0g5MmttRGlHdlpXUmZmYTExTkhBVU9Yc1hyUEtOSnNK?=
 =?utf-8?B?V1ppZ3FRQUVUTTRKOGlrYlJGY0h5cGo3OEN4WmZScnR2SzN6RGp6bExUNzNi?=
 =?utf-8?B?cExIY2VLVHdRUTloKzFvYmNYMndsOFJGenN1MVJPRXJVRDFuK2JJVjAvWjNH?=
 =?utf-8?B?bUx0TWhZY3d0UVFVaWJQYjZVWFJVaE1pbGZBZG91a004UHEwblhsU2owUFJl?=
 =?utf-8?B?c3ljbzBYcXpMOFBkdTZlRHFpVGdwRDUrSCt2YTNZSlBROFl4bXZDSG8wNlFy?=
 =?utf-8?B?TzNvZDA5NWFxV3lXV2tGMVRkUHFZU3RxZkx2ZVRvREY2YVgxUEtsS1ArTXFo?=
 =?utf-8?B?VGJSYWU2eVRGVlNjWldnaW9iQjVFNDZpR3R3ZEZhemxUWjBNalJvRlowQ293?=
 =?utf-8?B?UCtSejczRWVYUkRWM2FSc0lzemIxWUZPTFFVTzNwODhrNTdjdlE4MmQ0RU1j?=
 =?utf-8?B?TDVxS1FGU0w3WThqQ2NwZjJpRWdSQjZkV0M2cXFpcnM0QlZJNUw5Nk0wOTRW?=
 =?utf-8?B?M3JtL0JGKzBGdE1SMjl0eHNjcVJEaGxPYldpc1Q2OTI0enNRNktIZmY0TXh6?=
 =?utf-8?B?ZnY2b2xaWStxWWh5NldIZ2R5S3NodVFnU1BLYk9RYU5qNlpNbmFTdGNUVE5l?=
 =?utf-8?B?YWNRKzhxdEpqN0x6SzZBR0tuTmdjVlZ3QVNtQktPVCtpMzlyQk9jRCsyOE5V?=
 =?utf-8?B?RTVPYkVhQ1ZXZEJiL0NTL2RxdW9WZGRGUXNiYlppaHVRSnNiZG8rNTZZS29h?=
 =?utf-8?B?cXRHdGIwU1B5cEFISzY3WEszRHZpOW9ZckYvMWVSaFZaWlNCZGFqMmxyd29q?=
 =?utf-8?B?Y1NTbFI4VSs2bTkxRnVZa2luWEQ2S25VV1BGNFFhNjVHV3lKR0JUek8vYSt1?=
 =?utf-8?B?SVdXQnlCbW9ZcXJpY1dpWTl5MytIazVCS1pnYzBPWHlrSUZjcjkxQzZPYUg2?=
 =?utf-8?B?MGErYzdIMWZyQStzaXpLaU9LbFdkRGlkT2I2VkJjTEhBM0JtdTBBVko5blJF?=
 =?utf-8?B?UVIxeEhXdEt5ZWFCcXFxeDN0YlZkMWZXNk45MTVmR3VxVnhPU2daZ21DREFu?=
 =?utf-8?B?amdxL3pQaWJIb3hzTVpLYlNBVXlnRDg1eVZ4S1hsUVVyb21YSVF1eHdGOGxq?=
 =?utf-8?B?UVRCektEUWhKeEhWNEs1L0tIbklHNGJSd1MvMmFRRG9mVE51eW94UE1Kb0o4?=
 =?utf-8?Q?IC9/24TOK+WcYh1EvbwiFWXa6HpCxD8bKc64S?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd88be79-995b-4b9d-e8a4-08de84481246
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:10:21.3227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/7n0H07atpdopVldS6XMFirrs2btk40i9hfzinrEQfRS0Yecv1Lw0OlAmrFpN76yED8v5a4JbjE11ff+XNQMOsIwztmnzxcTc/D9cublWk/IABb7SwZxzsnBH9H/ivi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13912
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

Hi Biju,
Thanks for your review.

On 2/15/26 09:11, Biju Das wrote:
> Hi Tommaso,
> 
> Thanks for the patch.
> 
>> -----Original Message-----
>> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
>> Sent: 13 February 2026 16:28
>> Subject: [PATCH v5 09/20] dt-bindings: display: renesas,rzg2l-du: Add support for RZ/G3E SoC
>>
>> The RZ/G3E Soc has 2 LCD controller (LCDC), contain a Frame Compression Processor (FCPVD), a Video
>> Signal Processor (VSPD), Video Signal Processor (VSPD), and Display Unit (DU).
>>
>>   - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
>>   - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
>>
>> Add new SoC-specific compatible string 'renesas,r9a09g047-du'.
>>
>> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
>> ---
>> v4->v5:
>>   - Dropped renesas,id property and updated bindings
>>     accordingly.
>>
>> v2->v3:
>>   - No changes.
>>
>> v2->v3:
>>   - No changes.
>>
>> v1->v2:
>>   - Use single compatible string instead of multiple compatible strings
>>     for the two DU instances, leveraging a 'renesas,id' property to
>>     differentiate between DU0 and DU1.
>>   - Updated commit message accordingly.
>>
>>   .../bindings/display/renesas,rzg2l-du.yaml    | 22 +++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
>> b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
>> index 2cc66dcef870..be50b153d651 100644
>> --- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
>> +++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
>> @@ -20,6 +20,7 @@ properties:
>>         - enum:
>>             - renesas,r9a07g043u-du # RZ/G2UL
>>             - renesas,r9a07g044-du # RZ/G2{L,LC}
>> +          - renesas,r9a09g047-du # RZ/G3E
>>             - renesas,r9a09g057-du # RZ/V2H(P)
>>         - items:
>>             - enum:
>> @@ -137,6 +138,27 @@ allOf:
>>
>>             required:
>>               - port@0
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: renesas,r9a09g047-du
>> +    then:
>> +      properties:
>> +        ports:
>> +          properties:
>> +            port@0:
>> +              description: DSI
>> +            port@1:
>> +              description: LVDS Channel 0
>> +            port@2:
>> +              description: LVDS Channel 1
>> +            port@3:
>> +              description: DPAD
>> +
>> +          required:
>> +            - port@0
>> +            - port@1
> 
> 
> LCDC0 has port@0, port@1 and port@2
> LCDC1 has port@0, port@1 and port@3
> 
> Looks like from the above port@2 and port@3 are optional??

As we are using the the same compatible for both DUs the only way I 
found to differentiate betweeen DU0 and DU1 is the introduction of

	renesas,id = <0> -> DU0
	renesas,id = <1> -> DU1

Like proposed in v4 [0].
What do you think? Suggestions?


> Also not sure to make port@1 for DPAD for consistency with RZ/G2L??
> Do you see any advantage by making port@1 for LVDS0?

I'm planning to rework v6 with the following:

   - if:
       properties:
         compatible:
           contains:
             const: renesas,r9a09g047-du
     then:
       properties:
         ports:
           properties:
             port@0:
               description: DSI
             port@1:
               description: DPAD
             port@2:
               description: LVDS, Channel 0
             port@3:
               description: LVDS, Channel 1

           required:
             - port@0
             - port@3

> 
> Cheers,
> Biju
> 
> 

[0] 
https://patchwork.kernel.org/project/linux-renesas-soc/patch/4986c5a3c5cda9e754ed1f9f7121b32e9bf4499f.1770030493.git.tommaso.merciai.xr@bp.renesas.com/

Kind Regards,
Tommaso

