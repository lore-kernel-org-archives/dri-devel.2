Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39D6FC72A8
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 273ED10E08E;
	Mon, 23 Mar 2026 07:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="jOroDQBn";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6416510E08E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3dudFtQU/9DpOWseZ9iSWyEfgbBks9SCJqVVkeBkaYfObVtjGgwEpX5Xz4EgIJCVD+WYPm+djVu8LsME3rgzIT3vm9hyVbOK3LnK+G25WzclcEMbvCWE5DIGez9qFO1fVLREKIIdQkr4rdhTRfDUIvzij9yIbfzL8FrdnOUaOWEMYW55unKx9dhnf/DQBS/MWI7b5B6pMfvrmhSrEjP06+/YSTzF31qtChAkJYdbuUsv1/XpPZP0RIkNod+lsElS0H4Kv5AeuzVSCPU/QgdI7z4jFjLfG7p5EFRdaIQe1mWWeUAdFe5nj1zSXAg8CVnJ62lruILDGGlOaMeZIRa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Emc8os1r7XskKJ0Qce0vVV15F3fjfgn+jM8MudOUxxQ=;
 b=eSy1s91uM+B1jSKGF+TFq6M1TD1bkd0BYlneW34rOuBFkMQTWPYNUfSHRNJyvxIsKGBQ48i4nkFHtrTYQotul9I8K7N4lubyaZDs9SJoo19b3HkMXhmjy0E3UWyWrU9RSrrBa2vL9vaMGvIQsh34o08W9ALAiYtwmaY7UbYACh+7Bz8u2zdwhWf2+8WW5bjR3mlX0ZLc4hBImYy+SHiZDOXAvOckoPOqi9JL9gAY5+XPyCcMqJs1OvlIw1RxrVixjgP5kKeWXyBgRibcqU65zQfm2SYOv3dN9Hff9nIkz0ggiH8MIe1Ztpe1w4bSim4HvWW9vgL7RHW8REVkmQgGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Emc8os1r7XskKJ0Qce0vVV15F3fjfgn+jM8MudOUxxQ=;
 b=jOroDQBnAEPFZVzm6OOXdfA6+zVeKgZnxQxp7fLyCD4QuKCcPYht9yl3gSMTWScw2FV1Iu2ypdDyeCtfNl3GGRGUqll9Jkg8f8F/k5k1GfH+jmqX6QovKFTKb2nCWvbYMk1Tza+xfczgJExEVdh0vOlYuMyaZn2JDc2lDUPK8sxf2FuWLi4Ssae9PWgHdbAwFsDhb36EtC6heGKW0Gmipi/e6cAurirJDKHbVdmhAjTt2eWsDeKMJZrF0IV4B+BFHHD2l8gKo7jN9VJz7arBVfsI13yJDY7Km6HfI9qiStTSzrFQyxILREM5DObCpuqD8jWAOYuqFORxOMQXW7Mafg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA1PR04MB11333.eurprd04.prod.outlook.com (2603:10a6:102:4f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 07:21:08 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 07:21:06 +0000
Message-ID: <2fe36f04-97d3-4e99-97e9-7a3ac53cffdb@nxp.com>
Date: Mon, 23 Mar 2026 15:22:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] dt-bindings: display: fsl,ldb: Add i.MX94 LDB
To: Marek Vasut <marex@nabladev.com>, Marco Felsch <m.felsch@pengutronix.de>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, imx@lists.linux.dev,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, Frank Li <Frank.Li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com>
 <20260304-dcif-upstreaming-v8-1-bec5c047edd4@oss.nxp.com>
 <b7968f1a-c4bc-4bad-bcf8-407ff2d8db27@nxp.com>
 <dmqbmmpyi3ssvq67iqwbt6ww7tsaik7ifi5dnupmuhep7u5saz@ads5g7ette3y>
 <mx6b5svmvlonil4efuiaxcmtygn7lld3nj7gcxnnauaryt2yed@gohjshakc2g6>
 <40b3d1c8-0cf2-470d-8223-751240061735@nabladev.com>
 <xqy67fmh42k26iagl7wqrh2dbsn7c5fytwbkcksfzagefp327j@s5hg4lpuvy3q>
 <4e75f1d3-29ff-46a2-adb5-78a08f781834@nabladev.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <4e75f1d3-29ff-46a2-adb5-78a08f781834@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::11) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA1PR04MB11333:EE_
X-MS-Office365-Filtering-Correlation-Id: cacc4bd2-0c4f-4398-f7e0-08de88acbf7a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: sjbDLNaWQq/oPOMM+zRv2dMX7a7YETa1Hk2sCqzcza6okg8iRv07k+TTqh6pGrlnKOjvaj7tnNPinU+VwsUiQvrg7njg1dtengaVl3a9rYTNgZqtwotDOnNFtL78l9qQhBUKhSbe3EEBVtczxv6LIhtpRAhZqUiRZ/nNnLA4o2sBrONo6QZBV9JzHgkgoy8AWOteLUbMyuvWc664SVXIOYRvpjsXBy3rrdAViiUzbWSZ6gekygF4AsDvTa5O9DwSKgiHjteBeGZ+WP/Nb+eX6brc2UYKFyMxl2rYCvRIwcsESun6mzEA3G9h3kbcGq4rNgkopd7atqsCi2jZyYvdWApcBK2ZejqWmYgmbupWfZr2DIDyA72hGd5nSQOMOC8k8Nk89be0+cF2JoZ8Fvu8Uagmpp6HxRE51Oo6TegS+JJyWFE6TVEIa0LtQ1dvsyNZ3OpeGmt0ZICvRrdCCpC+sco9OC8Hu3QJzVjtNOttjpnrT/VQnpPS5LaHQtZNYcS4ho0nNUU6uNNzDDxChD5TA2Jpi1zfIMfUrPBuDhSSRvLtkFD15KAHJ3HOqAAUxeewaigpV2PXhtluEWprxntFieFYuqZbDfsnBO3WtPHTSd8aU6G4eBy/OfopPkN71k3qu4OzXjeskDWK6zOlpFU25Dg2YwFG1h6SRR0tZUKR6zPTaXCIi6Mofo78W3SwaHsDAefrwjTjkpkdJT3XnAsFmAuIaK4oxPBZSYW2iuxnOvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTQwNjBHeDZ1OEV2dGtnQ3RCemdXZlp5bzZrZ2xtNGtsdzYwSFlLWVlhdDBO?=
 =?utf-8?B?b0xHSm5ERWFrRjQ5Mml0RmZzbTZQV3ZwWXE2SG1UZjV3a1ZVRFpPaHJtMjk4?=
 =?utf-8?B?MlRsNmxDcTUxTGI0MUpWRkFrYnJCbVpWeWdXTm5JRnM3T2R5bjNwY3hUOGp1?=
 =?utf-8?B?MmxUeitYUnpaQ0ZqQnZzRWs0SlRFV0tSSEJzVDdqaGhrVWV5UFVTV3RTazlZ?=
 =?utf-8?B?UDJtek9uSXloYTFoZ3dUMWVBMHN6aE5PRytVZnFvZXZWZG5YMERsajRrclBO?=
 =?utf-8?B?bFcxVmYyQlp6SnNTTVVlVmU4U20rZDBvNmh6dFZKS3dZYU9wNzE2U000Sk82?=
 =?utf-8?B?blUrUTZMeE9zSE8xV2hMeXhMRitVSmpCd2hNMExna2NTMm15SG1mZ2Joc2dj?=
 =?utf-8?B?dlR1OTRiVSt2Uk0vT1NNU1pBWmZpbkc5aDgzbk9DY2p3NUNTanpuOHdmend2?=
 =?utf-8?B?VU4waDF5RGpnOFY2S0EyZk9Jc0FhM2Y1L2VERm1hUFlMYy9tR3ozdXAyajR2?=
 =?utf-8?B?cnp4VlQzYTFDU25WcVRTN3Q0NWdLWktnTVdrU2lxbEc1aC82WGhZVHFNWHV2?=
 =?utf-8?B?b1lVS3dZbTFPZ1BBR0VxdXVFY3IzWllRRGlpMjlDUUJ1QTVrSTUxNlNoS0tF?=
 =?utf-8?B?STJTdU9yc3dsT3dFOXJIMFU0M0NTUXlhSUd0WDN4UDR5dXpTbURLK0ZkWldk?=
 =?utf-8?B?RFZya0U0SEU5UkVsbUJ5dDlzKzVDNXRtdzErTnBxUVg4c0cvV0V4cGxtelln?=
 =?utf-8?B?Nk5yYnBHdE9QeTFjakFqeXpxRXJJOEVHNmZLbE5ZOWd2TThMT2IwK0IzUC8y?=
 =?utf-8?B?a1dEeUFhNVdIWVF5eUhmWFBHWi9xR1NDUGtpWEY4b2FBenZ0aThHdjlOOTZ4?=
 =?utf-8?B?bHEzVExhNG1YbDh2M1RhSjFOWVNGRWhpMkgzYytSM1hoQWl6OXo2Uk1qMGRm?=
 =?utf-8?B?SnRsR2RWSGZoVnpKWlI4WnNidW1mVllIUU1vYUprU1NWcXJ6b2kwV0NQUjJq?=
 =?utf-8?B?WHhDVElYL25JZ0FGWE1tUDZOSHR3anNDMVA0ZUVIN2k1WFZBYzl1NHRmWUpI?=
 =?utf-8?B?eFNkdTNva3ZyYWFwRlBUc1lRbUdaRWJmTERPYkFvcldPb1ZaaUN1NFEvQitQ?=
 =?utf-8?B?Qlh1UDFNa21iSnpLWUtFS0dzMTgxSC9sbjNBc2lveWFVLytGNkV3bXVhbDZ4?=
 =?utf-8?B?dXRLRkVkODk0eCtZNzdyUk95S3BSQm1rU05RMVNGZGp5em1LbGR5eTBGTEJ4?=
 =?utf-8?B?T1duSUkxVjNxL0Z4N3QxVTl3TXUxcjI3SDQ5eURCalJoOEs4SDExdTNzT0tX?=
 =?utf-8?B?N2FqM3lOL041VGJLVXpDYXRjS1FrWXQwYUhPdGd3K2tuNWlSVFEwZXF3ZDRs?=
 =?utf-8?B?MUVlU0swNGxGVFpERm1hWWdkN2h4NnBpUEVzdmNmaHZpZjlWRm5LTkZ6cGZa?=
 =?utf-8?B?WG5sOGxBNkRjYkVtQVExWmxwbUMxNTdhLzRsQzBHTDRJdWZVb29hd3oySHRP?=
 =?utf-8?B?cERicUllbkZSelY5dkVyTE1TQ0c4VWNlendtbUMzTldDbXpvb2ljVzNnTzhZ?=
 =?utf-8?B?U3Q1c3NMTm9uZDBpbTFoTktvdVdmbWpMSENDcjk5NjJYb1FFUWc4VkRVcE0r?=
 =?utf-8?B?b09pdXJPejZJL3JVQURtT0w1ay9NVkNRc1d1MkdSYU1BRS9OOTAvalRMaHEz?=
 =?utf-8?B?TVkrWGRPS3B1SjMycVIza1AyY0VIYU0wZkJjTjdsMHpZQXRvWGJselZvQnJt?=
 =?utf-8?B?MU5nbmNwY2d1M3RwYXRUL2M4S0pTenJZOXRCbnIrOHlBZVgxeE5aQUlDbEU3?=
 =?utf-8?B?ajd1MmtVNzNhcm9zNzEyTVlidGZqc0xCZWcwTGhVSzVmTmlRR3Q0bU5oQjVi?=
 =?utf-8?B?bjBjVFhYV2RzWkRQUG1yNFBKdWRrbWRzZDRIMjJUZ0NhV0htVGhhMUhKOVRI?=
 =?utf-8?B?NXlnTkwzVmtUSkxYVzl3VkFWaEc1MDBvUUNaZjBCSXlnbTdFOWl2Qi9kNUlr?=
 =?utf-8?B?MTdIZGNQVzVhTlFTMkRpL1ErclpKYnc3d2ZaeE5NUUlXQ09yLzZ2YndVVU9i?=
 =?utf-8?B?QlpyRDZpcjFKbjlBcjRFdksyZFN1NjdaQ00rMDdiaCswWEdEaExBckdZaEVN?=
 =?utf-8?B?d2s4THdGNCt0VDl1aDlrWldvcEtHcW1lclB2Tkl4bTFwdG4zUGszZVJFRk9E?=
 =?utf-8?B?blgvSU5pbDc2NnRGYlhOeGUvQnVkZEpVQTVZZ3hsb1B6NG5pM1VXN1dxNjh3?=
 =?utf-8?B?bHR1VWVsb043blBDRHlkMlFFTHFqMUNKNEF6d2hESlVScHdPekorUjNBSTB6?=
 =?utf-8?B?ZlVJRU90M0VGQncyNGtNL3NlR2I4RUQ5cmwzQWVUT2M5Tm1VZmxvQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacc4bd2-0c4f-4398-f7e0-08de88acbf7a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:21:06.5173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/i7zcUdMb8TKyzLkfsJq9Wp8ZsilnK+kifchWAl5ax9g3pFiX5TI0gkJyHoGk1+Vf3EzL5BsZWhQIuIkRFIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11333
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

On Sat, Mar 21, 2026 at 03:37:47AM +0100, Marek Vasut wrote:
> On 3/20/26 9:23 AM, Marco Felsch wrote:
> 
> Hello Marco,
> 
>>> The LDB driver was always written with parsing 'reg' out of the DT, so
>>
>> Not sure what you mean by always.
> 
> By always, I mean since the very beginning.

Marek, your below patch is not accepted(at least for now).  In that patch,
register offset(s) are directly parsed by calling of_property_read_reg().
Without that patch, register offset(s) are determined via device data in
driver according to compatible string.

[PATCH v3] drm/bridge: fsl-ldb: Parse register offsets from DT
https://lore.kernel.org/all/20260104213712.128982-1-marek.vasut@mailbox.org/

[...]

> 
>>> encoding the register offsets into the driver was a mistake. The LDB
>>> controls two registers, which can be comfortably described in DT.
>>
>> Sorry but I have to disagree on this. It's no about if it's possible,
>> it's about if the abstraction is correct and IMHO the LDB is just one
>> subdevice of the syscon. For i.MX6SX the syscon is the iomuxc-gpr for
>> the i.MX8M and i.MX9 this is now a blkctrl.
> 
> Right, and the "reg" DT property specifies at which offsets are the LDB
> control registers from the start of that blkctrl. What is the problem
> with that ?

The problem is that ...

> 
> Look at e.g. imx8mp.dtsi as an example with blkctrl and LDB as a subnode
> with "reg" DT properties:
> 
> 1938                         media_blk_ctrl: blk-ctrl@32ec0000 {
> 1939                                 compatible = "fsl,imx8mp-media-blk-ctrl",
> 1940                                              "syscon";
> ...
> 2003                                 lvds_bridge: bridge@5c {
> 2004                                         compatible = "fsl,imx8mp-ldb";
> 2005                                         reg = <0x5c 0x4>, <0x128 0x4>;
> 2006                                         reg-names = "ldb", "lvds";

... i.MX8MP LVDS bridge node is fine with the reg property, but the property
is not allowed for i.MX93 LVDS bridge node according to commit[1] while
commit[2] requires the property for all LVDS bridge nodes.  See the contradict
here?

[1] 3feaa4342637 dt-bindings: soc: imx93-media-blk-ctrl: Add PDFC subnode to schema and example
[2] 8aa2f0ac08d3 dt-bindings: display: bridge: ldb: Add check for reg and reg-names

To avoid the contradict, how about requiring the reg property only for i.MX6SX
and i.MX8MP LVDS bridge nodes and making it kind of optional for i.MX93 and
i.MX94 LVDS bridge nodes?  Overall, in terms of the reg property, I feel the
LVDS bridge nodes look similar to reg-mux/mmio-mux(See reg-mux.yaml) where
the property is optional.  BTW, there is a mux-controller node with 'mmio-mux'
compatible string in i.MX8mq syscon@30340000:

iomuxc_gpr: syscon@30340000 {
	compatible = "fsl,imx8mq-iomuxc-gpr", "syscon", "simple-mfd";
	reg = <0x30340000 0x10000>;

	mux: mux-controller {
		compatible = "mmio-mux";
		#mux-control-cells = <1>;
		mux-reg-masks = <0x34 0x00000004>; /* MIPI_MUX_SEL */
	};
};

We never know if HW designer would put a mux-controller next to a LVDS
bridge under a syscon device like gpr or blk-ctrl in future i.MX SoCs,
so the optional reg property would buy us some flexibility.

The below patch is what I propose together with a Fixes tag for commit[2].
Since commit[2] is not in v6.19 and v7.0-rc5 was just released, it seems
that we have time to land the proposal fix if it makes sense.  WDYT?

--- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
@@ -28,6 +28,7 @@ properties:
     const: ldb
 
   reg:
+    minItems: 1
     maxItems: 2
 
   reg-names:
@@ -68,7 +69,6 @@ required:
   - compatible
   - clocks
   - ports
-  - reg
 
 allOf:
   - if:
@@ -83,12 +83,23 @@ allOf:
         ports:
           properties:
             port@2: false
+
   - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              const: fsl,imx6sx-ldb
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6sx-ldb
+              - fsl,imx8mp-ldb
+    then:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mp-ldb
     then:
       required:
         - reg-names

-- 
Regards,
Liu Ying
