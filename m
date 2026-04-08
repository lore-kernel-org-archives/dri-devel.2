Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0B41073CBC
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 14:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5572E10E66F;
	Wed,  8 Apr 2026 14:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UHP6DPMP";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011070.outbound.protection.outlook.com [52.101.125.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36CB910E671
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 14:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI499ZyTd3uG1Ng47605dEX0uLcAXKy9BpLg4nqqDrr6RcBFL5AkM2qOduQcSIfpOq8N0m8ZKffnH2LU1C9S0l6s4kPfhymzqXVDcyppuGCt/nTq08WUlbUI9jQGOEK5ksCq+HPYKxfLMpB4qmbx+We7HV8TzDTHEEV4x088bkQN4GG+5ir7301ZZvYJSMrOSiSli27Zo41GMpuAYz1zMJeB6gVZcN15+NvSUh3Q5r9MPrry95YprLrknbKsMU1GmVdOv1dy+GQZmWSiEsnBY6R/f2FJbV+3PWduCw9Gio7cMUswNR+JFIo5s5lzn6ZMRKeOY3nVrftWHBbeLmCNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSWqPhACchELO3Aeu8zLqrdwOye6gXcglDsPmeUIU8g=;
 b=foONqPw5YLuhy2+vcqmYbAPiAzXjeCdNPTPfI0lqtpJ4KZfdQHO27Qg9JcI/DkntHOZF01M4QE4PEztauKs949JPwYcbLxsLbtti3IwBTgVYjj6AlZ6jbK7v54UyFbuQ+6SSXJfJopW46NmQdaa20iJbwunth6HipD8lZJf1oq3uXRVIHqw4vurwUwraUxdSOSmPB646Hyo6L2v9sRHFVPJJu09b1wmxPCyVXg5LaDAuwEYfhO6GOugItBD2kSk74XrJUPSbvIJw2xowBXK0hcjbIq15I7gCOgH0JX/rB2ecwGOijt7N+lkmT1A7Uin8esxRF+ekjRO2OLWm1WoCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSWqPhACchELO3Aeu8zLqrdwOye6gXcglDsPmeUIU8g=;
 b=UHP6DPMPDz0uzVkSeMAYjSVJsOzguI+i0WmDJKVNixuLI1N6cMjFkz70QSWMRa/OdVWJXzkZKm9Etrjv+X4Br4Y930uq+jc3W2QgYxJpzzLmmK5F0NF4P8tS33NuqIOTQOZ+LRSVudWGM2I2B5LX+1iVM2KVZtBz+4vq1GWin9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8125.jpnprd01.prod.outlook.com (2603:1096:400:11f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 14:02:27 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 14:02:27 +0000
Message-ID: <dafdbdcf-98db-473c-8122-296af1922e6c@bp.renesas.com>
Date: Wed, 8 Apr 2026 16:02:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/21] dt-bindings: display: renesas,rzg2l-du: Add
 support for RZ/G3E SoC
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: tomm.merciai@gmail.com, geert@linux-m68k.org,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <8f814f22ff62dcde6153260e2c8c29a5415c9a89.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <20260408122436.GH1928916@killaraus.ideasonboard.com>
Content-Language: en-US
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20260408122436.GH1928916@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::16) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 020ad335-25cb-4fec-cb68-08de9577777a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +3bC3+Eyosl3GledeiuGemxLWEmWtkgIEKDP6rxQzi/9hklB3pSG6SsraZRWYd33hkQxZ8/uQUy58jtFrLDQ6kTYnDXikYxId9a7ZjGeq0fK10gnHX2KkeOntcvTSg4oWVLa6lCnxkrI4350/7wjz6n1k8APltNmvM3UqbINURszauNHRZwBU7F1fc9im3L24FNrpaNT1ff+slxo3Jb1A2AWQ2JiBDJn4RuqhMAzVz5rrnFGtiMnOK+Kve7snGAl46ahkB/lxVwPtBUBqDqM8QofotkqhLRmr0Z9/2qOe0e6INp42lwAnXlwzxwCFT/Ytsgx+m4IaUBUDHXYbC2Mz/Sn3qCYJjyI1uT7Q7sY9sCHmk37gugwfm1Qf3gOtK87B6HL38GJbDAFkcK/BU2pMhoCAVIj8954ogCWByJX8sMxKkiMU4QVlCSX2jGPzwLS3I7AMH1JbmzRjHnB8dcT8/yvZ6Pge5UcNiVKC0kz4awti9n7b/URKY7qyHOEFX+UdnQmAPEnJzoVkWvRJNmk6AaMoyZKF4aThHShlP+AC2ZbQReOlft3aSW6eZI7JKkMBODLIC/LV1XL1gt/Le82yy48vB7EHW6kCuiR0GcfX16gULA/3DDR1TyLPffUzirBvHCH+tL7DwUAMEuJVmKWN1iAExVXrlxR8CR5GVFpHNH09G+IxS9o1yPPZvx/CdMgj4DYRbcS5V/NiqAyPt6jQOHUb118PN3xNIg3EFN+hYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmNpZWxSL3pBcUs4YXkwdGZwbGxVRjRpZ1p1VE5TWEJSU25pOHczNFp2b1U5?=
 =?utf-8?B?L0FKN25jWENDK0ZLSXZycjJ4emJzdmdvdlIzdVhNak9QaWdLaHZKbGlVd3BF?=
 =?utf-8?B?Y21tNWh2bVFPMWtvVk9SYlVvd2RQdDdYUGdlaHNVVVk5NVZ5eEdSNTNURmJz?=
 =?utf-8?B?VTZPR0lvUm03ZHpaWUtIY29qRmlua3JFb1plTXhJdFRZcWp5enpKaisxdnc4?=
 =?utf-8?B?eDRnWWZSZ0lhZnlMZ3BuZ0NYTVpldmhKQzF0bDdQditUMExDTU1icnRzSlcw?=
 =?utf-8?B?NnBab2VTYjI3dWtnZTJXUkRoQ0xnZHErM1JNbCtLaWpwL2Y2R3dIQTJDRnor?=
 =?utf-8?B?dGp4MU9mTWhYSGo2UytZN25maWhpSmpvY3RRVS9lajVnc0hmbE04UXpUY0tL?=
 =?utf-8?B?Q2hVTHN2eUl4ZGtMWG8zQkdOSUxtZHlvdW1hSzcrOVhmNjlvb2hjYWY2djRE?=
 =?utf-8?B?VnZNN2x2WVFITEFtOXd6SDlQWEpmYUhxZktOUFpUVTNwMk9NSHlsejhuTU5o?=
 =?utf-8?B?Qmx1Sk5LSy8rSTdMbjhMTFBxYWhhdmhoMWFvdEFNa0xGRU9UcWZxbzI4N00x?=
 =?utf-8?B?cUtjRDNWOGpEUzIreDFoWTRmRHZDR0RwTXYzVHc5UjdJRzhrN3ZJZzJySlFZ?=
 =?utf-8?B?VGk2aXpvQnYxNWhldHdiZjMyNHhLT014WVlZcDZXRGo1ZDBmd0F3eFlaL1Fz?=
 =?utf-8?B?eHVFWitWRXhHNm0yMEwwa2l5UUxkRHVHOFVzVGJ0MDlabmlXQVZaa29JVUJ2?=
 =?utf-8?B?Wi93Y3g5WWdPejdkci9xSERHczE0UEtBSGgrLzJPVnRVUEUxMDljeDhHWGxC?=
 =?utf-8?B?d3JjaFF0bDdKbnpBei9OVkxaSVZ5c0hZOE1GWmJHNGlUZk1kd3dZRmxTeUJ3?=
 =?utf-8?B?VzBCUzY4eEZ2RVFhRDF5S0pMVHQ1L0xxZDBjM2NhMUVMRU5BcHdlUXZKMlg0?=
 =?utf-8?B?ajVBNW40SXh3bmRUMG4rWm9VNk9nWXRzRWN5aHkyRC9LTjZlSi8vUHk4ekpV?=
 =?utf-8?B?VS9xWkt2MThjc0JKYXNuc2RrMW5CRVkrS1pTQnkzK2pyWCtwN3lPSmVNNlJ1?=
 =?utf-8?B?YzEwMjFZelEwR3lsWW1tL2R0dzI5Vm0zdTZvVjA5TUF0alErSG9iaHl0N2N2?=
 =?utf-8?B?THZIMSs0NDZkZnFESmNMMDMweEJNNjVxaGw5cTZRUldLNXAwSThFQ2gwUHNM?=
 =?utf-8?B?UnRoTDd1Q0J0VDRBV05sckR2V0RHSmpZYmIvQXYxcGxEcExoejVad0dXbGpY?=
 =?utf-8?B?UEp5RGp6bWlJSWN3T0YzL2dFdXErQy9UeUdlUkxGWFNNMlNqTkZEd3RzOXF5?=
 =?utf-8?B?RUtyajgrSEFMVDI5dDVMTHZuVzdyZzErRkJyK2VDdlZkQTBTem9xRldONXJF?=
 =?utf-8?B?eHh6TUFTNzJkcWJsbWhYdDBySlhpVFBXS3liZFVDODd0VWEwd3paUUtmVW9z?=
 =?utf-8?B?L2N4d1U2VHRzZXlFbjlFbC8zazRDZkt2c1BMNmtvZXREUVZ4dUVrMmlEa2tT?=
 =?utf-8?B?U0lRaHVZd1FiT0pCQmFpN2diakpaZ3haRnhvdDR6Smxid0RPSThsNlJqYnNB?=
 =?utf-8?B?U0laTjhtcXNZRy9acVBYaFJQalFnVEJyOG1YT0ZPckZMb2x3TEk3dzZRek5a?=
 =?utf-8?B?UUcvNDNhNVpwdkNQZmtveDlMc1BRdUN6cFlMMXc2VWhscWlJdEVqb2k2V2RO?=
 =?utf-8?B?ZTFZNmZmc0UvV2pHek9XZWhLTGszK3dWZ2dtOG9TWEpPc0lEZzBwa3hCTTY4?=
 =?utf-8?B?ZDFqUHEzTkI3ZUlGVy96cy95aWdqemg5eStSbWh4R0hCZGZHVS92eWc4N1dJ?=
 =?utf-8?B?SXBTby9mNS96dWUrWDdtaXBEaGw2SWhCYmNpZTlEQUVUc3ZwVWdlbkpiMk1Y?=
 =?utf-8?B?Q0JJV0hsbzRsQm4zQklKekg3anN4SngxekpSWVRsbCtFU0VrNEtLbkhRM1kz?=
 =?utf-8?B?RjlkZmdvRVN2SDMydjZuMmF3YkMrcVNWeFRkMy9pU0FCWFZJem5UVTd2MWh6?=
 =?utf-8?B?Z1k5OE1hczVlck9XV0pUcWwzN1VSMTgyZVQ0cGYzYW9GUzM5Nmp2NFk4WE9V?=
 =?utf-8?B?ek9aWmZoMEFLc0QxWHZnSDd0ZmRvbkVnUXAzZXBycmJrUU5rMm5BVlhMZ3VH?=
 =?utf-8?B?NktrWTZHRk1oQkYzWDA2L0Uwckxxd0tDQk5yTHNMeHZoWnl5ZWhFMmZqMWlG?=
 =?utf-8?B?eFNaVGNjN3VkZXBZMTNPbzdWNHdaOVZxb0M1cGF6NG5NUEZwV0JBVkZGTEJo?=
 =?utf-8?B?QlptM01YNzhFclpzVTdqeThaWXFQMEZlcERsbHlhNmMvYjVaTkg4RnZ3a3JF?=
 =?utf-8?B?a20xVmNvcjJma0JkYjhHQjJ1NDZ2L2JONlBGOVh3S1I1OHViSW9GWEhwdGNw?=
 =?utf-8?Q?Jpqj8ecI8GYPQwIVP3Ee22dnAV460hZc2phNL?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020ad335-25cb-4fec-cb68-08de9577777a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:02:27.3320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7+hWMax7PpJnHbkiqpEDPsHbYGOVkoFuSZ56XHn12pH7a8arp8a8yl/bA+gKF/NJ3D+rXpomTQJhOIXnPFsMlSW86/WOPV3U9sAuHDBJEmMV179u1SeiXnnVctAnprI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8125
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

Hi Laurent,
Thanks for your review.

On 4/8/26 14:24, Laurent Pinchart wrote:
> On Wed, Apr 08, 2026 at 12:36:55PM +0200, Tommaso Merciai wrote:
>> The RZ/G3E SoC has 2 LCD controllers (LCDC), each containing a Frame
>> Compression Processor (FCPVD), a Video Signal Processor (VSPD), and a
>> Display Unit (DU).
>>
>>   - LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
>>   - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
>>
>> Add a new SoC-specific compatible string 'renesas,r9a09g047-du'.
>>
>> Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" to
>> allow up to four output ports, and explicitly disable port@2 and port@3
>> for existing SoCs that do not expose them.
>>
>> Describe the four output ports of the RZ/G3E DU:
>>
>>   - port@0: DSI (available on both LCDC instances)
>>   - port@1: DPAD / parallel RGB (LCDC1 only)
>>   - port@2: LVDS channel 0 (LCDC0 only)
>>   - port@3: LVDS channel 1 (available on both LCDC instances)
>>
>> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
>> ---
>> v5->v6:
>>   - Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" and
>>     explicitly disable port@2 and port@3 for existing SoCs that do not expose
>>     them.
>>   - Reworked ports numbering + improved/fixed ports descriptions in the
>>     bindings documentation.
>>   - Improved commit body.
>>
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
>>   .../bindings/display/renesas,rzg2l-du.yaml    | 30 ++++++++++++++++++-
>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
>> index 5add3b832eab..32da0b5ec88c 100644
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
>> @@ -61,7 +62,7 @@ properties:
>>         model-dependent. Each port shall have a single endpoint.
>>   
>>       patternProperties:
>> -      "^port@[0-1]$":
>> +      "^port@[0-3]$":
>>           $ref: /schemas/graph.yaml#/properties/port
>>           unevaluatedProperties: false
>>   
>> @@ -103,6 +104,8 @@ allOf:
>>               port@0:
>>                 description: DPI
>>               port@1: false
>> +            port@2: false
>> +            port@3: false
>>   
>>             required:
>>               - port@0
>> @@ -119,6 +122,8 @@ allOf:
>>                 description: DSI
>>               port@1:
>>                 description: DPI
>> +            port@2: false
>> +            port@3: false
>>   
>>             required:
>>               - port@0
>> @@ -135,9 +140,32 @@ allOf:
>>               port@0:
>>                 description: DSI
>>               port@1: false
>> +            port@2: false
>> +            port@3: false
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
>> +              description: DPAD
>> +            port@2:
>> +              description: LVDS, Channel 0
>> +            port@3:
>> +              description: LVDS, Channel 1
>> +
>> +          required:
>> +            - port@0
>> +            - port@3
> 
> Why are ports 1 and 2 not required ?

About this we had a similar discussion on v5[0]
We are using the same compatible and:

- LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
|
--> then has:
	port@0
	port@2
	port@3
	

  - LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.
|
--> then has:
	port@0
	port@1
	port@3

Then port@1 is required for DU1 but not for DU0.
Same port@2 is required for DU0 but not for DU1.

[0] 
https://patchwork.kernel.org/project/linux-renesas-soc/patch/ca022fdbba5236c36e0cb3095db4c31e8e0cb1b8.1770996493.git.tommaso.merciai.xr@bp.renesas.com/ 


Kind Regards,
Tommaso



> 
>>   
>>   examples:
>>     # RZ/G2L DU
> 

