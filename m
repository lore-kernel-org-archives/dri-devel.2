Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC62C5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F6E10EE7D;
	Wed, 12 Aug 2026 07:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="iNM6f8xU";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazolkn19013074.outbound.protection.outlook.com
 [52.103.35.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D3110E39A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 05:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7H53ifq3fXgyxC5flBef0nBWFjvPGqIT0P98TH5+P0pTAbInGGQG+F7iV8YFiq86o+aR1Bqd0A1sO22vmzXzxMlqtaPfbwk5M5ik6dXbYOLebRTAJUJZ9x5SOOO6iWtfH4crDbgxPYRQDAmEGXQ9l8VtYUB37qcy20kAJyLC8Ly8NRnBD6t/FvyC5djxaHE4K3otgjLjWRU+P35mxTQxkBJyXqHQikGDiwbc7ZFYRiCy3oZXBCXrFKMdQkIADHJFHGUoZA/X4i4I1TZHsue3QpiKH/BmctZeb4WcyOtjLoCx5q3ij+o8wgKG0f3Mi3uQ8OwaRzhsUvMzjmr8RBroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2bNJLtB4E+KHCrcE7ucUrW4d+1CU3jDq4OxRDdQllI=;
 b=bKrcmz2OYdo9y/ugjrjbrYHm369NqEvJylrufxEDWLM8xGryhpSzr/tIkBwfWZZkgHPXCLHuWqUC36ThOWPbdSvoFliZljSnr3Tj2hALnjE/M1clejMGXalBH4lfdU/sihGCbhiC3Nn3I+62Zd1YaTGTzxrhvHx0qXjqUB/JskPc8M7cpleJHXxiJ0yKtl5u8Wr35YoziwNVVsl3Hc9b9F7fX3iTEKCE+I23sadxZKMnXSxpLMb3K/A+rXm5lwQX0IJOngdyAXmsn4/s1YaZiWSWXwZIXsw2RhyWzyFzYnml7VwLzHK/SBDcRR1uzHUv6F6rAW+u/JnYY+cOcFj+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2bNJLtB4E+KHCrcE7ucUrW4d+1CU3jDq4OxRDdQllI=;
 b=iNM6f8xUYLvW9cpaVGrf+6hPGJCCKWAFs1ydM3Z0YcvGpKXmWc7YcDYKN2YDSB9+eUrWAnQ0WUGDbX9SKLanMIfx8K69xmxz21h5j5OVQeKNxMn0B2ct4Uq3TX+SaWjk4mnnV1MUMXCNTWaBRdOiD4W+83YM0yS23UzNAPClHOXddvX5SzM65Mt5SJNgvXPR6PDuxU2W8Nim/TLopH7UtbCPpnN7alVnuXtNQWGXm9bB0ejAlg3t2OujzK06z18RSsB8UH4DRJH910dqXVQbS2Qa8GEJPpTUhmRJ79D3/xjdMjGLrLhNXqRYdCYKLnUyphxgAi3rtJ8s1/N/7dZvVg==
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:5a5::8) by
 FRWP190MB2485.EURP190.PROD.OUTLOOK.COM (2603:10a6:d10:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Wed, 12 Aug 2026 05:44:46 +0000
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380]) by DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380%6]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 05:44:46 +0000
Message-ID: <DU0P190MB244579F0C395F1F41CA729A8BCDC2@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
Date: Wed, 12 Aug 2026 09:44:40 +0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Muhammed Subair <msubair@hotmail.com>
To: Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Maxime Ripard <mripard@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Andy Yan <andy.yan@rock-chips.com>, linux-arm-kernel@lists.infradead.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: RK3576: rockchip-pm-domain fw_devlink device-link failures for nested
 power-domain nodes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX1P273CA0032.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:20::19) To DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:5a5::8)
X-Microsoft-Original-Message-ID: <33aa66b2-cd6d-416d-b1ef-20cc83e0ee10@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0P190MB2445:EE_|FRWP190MB2485:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e624363-e529-451c-6805-08def834d0cf
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|8060799015|19110799012|25031999004|37011999003|24021099003|23021999003|55001999006|25010399006|6090799003|4140399003|5072599009|53005399003|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2o4Nnh5NWVscWg4czlyWkJQNWlKbHZqREVhbmtDcGlrZVZkb25oUkt5Vkxi?=
 =?utf-8?B?QjFJblowbitqd2diMUg4d3BLUmF0bEdjTEIyV2J6MUNxd1dqMHp0V1c4ZUpG?=
 =?utf-8?B?dnpRdmpnVTVxSlgrZ2xHYTFQaTljQ3FvdE5RTHpRMDY4elYxSTFSUzU2SDVG?=
 =?utf-8?B?YWduNWxlTmcxWHZFWFJ2S01KNW9VNWdMNGxQMXltaHFZNTZjSitseXRMdFNv?=
 =?utf-8?B?b3Z3SDd6ajFTMkV0N3BlVUJpL1JDS2h0ZmMrMGJ1Z2Q4SGl5bC9CSTdXb3Bi?=
 =?utf-8?B?N3B5R2Jka0tpb2ppODZsbjgrcGlvS3U2dVlBWUJXRHVwcXByMlh3MStsTWIy?=
 =?utf-8?B?QTZER3BoaGJvRG9aQjJkVmVGeVlZRVJsa3A4aDgyRnV1MjhZNTRoQWdma2R1?=
 =?utf-8?B?bGIxU3VRT1VrcFdHU3JyR2NGeE16VURXOFM0MjBKOHpwUzEyQjM2NXE1cGR2?=
 =?utf-8?B?Uk4xN1Nrckk3Z2FhMHVtd3VRQ3Q4OWJzZmJjeFpRU3c5REtOeVlEbmdET21r?=
 =?utf-8?B?VURZVzVXNUQ4angzaVJvbHZ5bEV5WTNYa3pIUEJJb3ptRUhPbEtXL2JhV0Y3?=
 =?utf-8?B?NXJRNWRkR2d1aUw5VndMQUI1UVlwS1JTUDFpdVRkU295ZXNOYWU4aG0xN0J4?=
 =?utf-8?B?YXpQQThEeHVJOEVGVmJSWmd0VGJpcHpGL3VaRjFOMmJjbmwycUExeTh3V0ta?=
 =?utf-8?B?MUJleWtSMXludGV6N1JFM1dnb3pMTWoyZDhLWlJYbnBaeGtvZCtldjBheFda?=
 =?utf-8?B?YVFtTU01ZUZYczk0RUNRekM4eWxOTlUxSmI2RmxlK3RIRFltVGhUMUpBUmpt?=
 =?utf-8?B?VXArdmVSNW5mYnQyd2hkZi9FR2ZOMGdSWkhFU3BqZTlnV3VSWGZ1b3p3azRB?=
 =?utf-8?B?aFYxOXY4VXMvNElIdVAybDJYb3lqNWFIQkZGSkNOZm5QZzc1a1FhUXZxRmlm?=
 =?utf-8?B?TXRVd3kzL0xvUjlyNmNka0d4VUYrTksxVXBlZHFLMnoyK2hEYkprWlk2eFJw?=
 =?utf-8?B?MGRIN1ZwTWxwaWdTZ1FyK0hweHNGd0VCTVYxTFp6WWtUamM1emhLMy9OVlk2?=
 =?utf-8?B?ZGpDM05lYThhUUdxY3FOSzFSa1NYWi9PTWgxUTdlTUxOb2FYcW5LTDYveCtn?=
 =?utf-8?B?ejc3T3p6N0h4Sis0RVhFT1lHbHF1WXVYT0pLRCtlY2NYMm9nak93TkJtamlE?=
 =?utf-8?B?Slk2NmN4Z2VsZTVJWE44ck4yTUtlT0pNeTJ1ZEo1c1hQOGtMWEh5QjhVRmJY?=
 =?utf-8?B?dkVSWVE4Zi8vZmF3Q3JJTXVXK05hUUsxbEdDMnBMZzZUTzF3bDd2Rkd6UXBw?=
 =?utf-8?B?bG8xV20rSnpXcDhRWS9FRkxyV2tLbmszUnRrdHFRVEFKQkxUaWRMLzVqVjA1?=
 =?utf-8?B?dUxQYS9xSkVIYlBJL1RGSktOa21OODJvVE5mQjA3V0F3VWZvbzJuTko1Vklj?=
 =?utf-8?Q?oqRxyjAG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjVOUEYrd3VOSVNRdjZMOHlBeHZMdzE5R0plZ0QwSTNZc01WWVQ1NlhBZHpV?=
 =?utf-8?B?a3R0ZFROZ2Nnd3NNaElRL29LUEFvZnJ6TG9OZjRhVGRjckN2UFRSRnI1QlNU?=
 =?utf-8?B?cExFK1hQdGFJaG4vMHd6cWcxZkRnM3phSWR1WjVqd21leHZsSkJveGhENS9I?=
 =?utf-8?B?Y1lZTnZsblNueVpobi8yK3Q0MXRSVFFYTXBBQ0N2QzBGN29ab3dCWkkwSllI?=
 =?utf-8?B?Q1lJOFNjeW81ZG1UVjV4Q0owdU1sVnJtNk9RUTZjQUZvYlRDUWdFUU9wZDFx?=
 =?utf-8?B?MGRRbUNoS0VPRVpHWlFwbUc1RjVSTFRXVFI5RXhvNXhDM3dTdkxZTCsvZXhC?=
 =?utf-8?B?YnlDTlo0YzF6OXlmajAxK3F1V1BvRzJabzdPNm9GVW5xKzhNVHlRNXdtdzQ5?=
 =?utf-8?B?VlZPbXFKMk1ZemlFSkVKeVJPYWJQeWJ1Wkh3VVJGclZ3bTNVcmJ5aWpnOFNV?=
 =?utf-8?B?ZHRHZkRHRE10N1VHbW4yY1hneG5OREFGOE0rYUYyN0tralBON2RxM1AvUXVp?=
 =?utf-8?B?U3hJdVpJcndQTHloV2hZa0VXV1Z5NERqb0hpQnNsbzEzUnFDQlQ2SkI1SWly?=
 =?utf-8?B?clN6THNBblE0TDdsZzNidkliZDFxQzltMFNCVU9ZU2RJMEJuQnF4OWJtZEVX?=
 =?utf-8?B?Mm51U3V6bWtLUkM2QXZCR2hWUWNNYm8rUUNIWVY1YTBHOHYvcTZGdVp0OWhP?=
 =?utf-8?B?dzdMNUw5dEI4Y1JWQzV6UFpESzR5RWtWOEJrUkI1cXBWd1duU3l3VmtyaDNm?=
 =?utf-8?B?NVNZbmc3NC9STElaMy9RMUlZVHVWNUxYaHFiM1F1Skxyc0lrVWY5ODBmQmYr?=
 =?utf-8?B?bzVkYjZlRUJ1Zk5ZYW5MZ0h3K0NXSTBkdmVRU3k4MUQxTXBieElLN1pLT2o3?=
 =?utf-8?B?eC9lSzdpdER4SFEzRnBldjNNMnNVSEhmQ2VaVmFGWENMNVgyQmc0WW9UQTBn?=
 =?utf-8?B?TmpNWVpBVVQxTFNRaFhyWVZBMzVsdTlpMjc0VjU4RmV1emhQazFrSjc3N1RT?=
 =?utf-8?B?dXE4Z2JSbHFBb2ZNV3lLQ3ZLdkh3NDdGb1pyNjVTdVhKNnlrVlp0R1hJYzlS?=
 =?utf-8?B?d1djczl4NW1pQUkvMnNzWW9oS1AwUjZScGdhQWdORXlFUUpINGhuUkhmOFo0?=
 =?utf-8?B?RDlzMEdXK2grR0J0azFOdGU4MjdnWUFQRFhNN1pSeTgzcVFpU2tyTXNKYzFB?=
 =?utf-8?B?ZDhKSXpES2hmc3c1U0RObS9jdUdIRGxUVHZycXBFaGIwNWVIcC9YY1I2YlhJ?=
 =?utf-8?B?dGNPbk5VYnhGSWEvUkFLcktWd3JZNlZGWDkzTTFhd2ZjNDNIZFBSSDNQRmRr?=
 =?utf-8?B?K1pUVFlBZG9rbWdNZHFKa3ozZmQ2R1RoT3lxREZhaTFmM3M2TC80NEFnTzNK?=
 =?utf-8?B?YjBpR2Vib3FrcjBFMGxQbFUyM2JIdVo2aTdwTkh6aWFLN3dCNDJEZlBVeUV0?=
 =?utf-8?B?NXZTM1NYZkZJc3N2R20rckE0UjJSNDRySDFJMzRPZGdvb053VElLbkFxdFQ0?=
 =?utf-8?B?UHVvTm1OZmEvNmFRcUNDZWt4VWM4VDBYVjdSTkQ2b0szV1BnTjBwenhxNWwr?=
 =?utf-8?B?djM2Q1NiM1h6cHdmWnYxZWZ5QnA2TGhxTHhMWmtvb0FLNENIVmxXT1F1eTFK?=
 =?utf-8?B?eDFNZ3puV0ZUWTdwaFVuQ0pyaEd5dVJEVGNZdEwvemxCV2g0d0p3VFRzQTBS?=
 =?utf-8?B?Y1VzVTdGdTlOc2ZMWXlNVzJpdEszREVmbEVhYVB3Vi9GRG9aUXk4UUNyakov?=
 =?utf-8?B?eCtTZUVDblhybXZEL2gxbWFyb29xTEJ1WVhiZUVJYm50TW5CZWpnTkVKVXNQ?=
 =?utf-8?B?MnZRTmxPK1NsbzAxK3phbnRpelNYMjBxT3IwaEE0bTlIZlpjNlAzSGZVMGc4?=
 =?utf-8?Q?7fEe0sEcvltOU?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b33f1.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e624363-e529-451c-6805-08def834d0cf
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 05:44:46.2651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP190MB2485
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

|Hi Rockchip/kernel folks, I am bringing up an RK3576 board on a 7.1.x 
based kernel and I see the following early boot errors from 
fw_devlink/device-links: [ 0.260388] rockchip-pm-domain 
27380000.power-management:power-controller: Failed to create device link 
(0x180) with supplier soc for 
/soc/power-management@27380000/power-controller/power-domain@0/power-domain@1 
[ 0.262168] rockchip-pm-domain 
27380000.power-management:power-controller: Failed to create device link 
(0x180) with supplier soc for 
/soc/power-management@27380000/power-controller/power-domain@0/power-domain@1/power-domain@2 
... [ 0.285927] rockchip-pm-domain 
27380000.power-management:power-controller: Failed to create device link 
(0x180) with supplier soc for 
/soc/power-management@27380000/power-controller/power-domain@18/power-domain@17 
The board otherwise boots and the affected domains appear functional. 
PCIe/NVMe, HDMI, Ethernet, etc. are working. The RK3576 power-controller 
node has nested power-domain children. These child domain nodes contain 
properties such as `clocks` and `pm_qos`, similar to RK3588/RK3568, and 
`#power-domain-cells` is present as required by 
`rockchip,power-controller.yaml`. My current understanding is that the 
Rockchip PM domain driver consumes these child nodes internally and 
registers the provider from the top-level `power-controller` via 
`of_genpd_add_provider_onecell()`. However, fw_devlink recurses into the 
child fwnodes and tries to create proxy supplier links for dependencies 
such as `clocks`. Since the child power-domain nodes are not normal 
devices, this ends up as failed links from `rockchip-pm-domain` to 
supplier `soc`. Is this expected noise for nested Rockchip power-domain 
nodes, or is RK3576 missing a DT/driver annotation to prevent fw_devlink 
from trying to create device links for these internal child nodes? I 
compared with RK3588/RK3568 and did not find an obvious missing property 
in RK3576. I also do not want to use `fw_devlink=off`, since that hides 
the issue globally. Could you advise whether the right fix should be: 1. 
a DT change for RK3576 power-domain nodes, 2. a Rockchip PM-domain 
driver change to mark child fwnodes as internal/not devices for 
fw_devlink, or 3. an OF/fw_devlink change to avoid creating proxy links 
from generic power-domain child nodes? Thanks, Subair|


