Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43562C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0DA10E30B;
	Thu, 16 Jul 2026 09:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="qCQNgE9A";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020118.outbound.protection.outlook.com [52.101.69.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7570D10E30B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFyFkTAcWPsg9UyjiF7nJv32muoUT1aJr3kRh94Q2S5QNk75wKkSpmU3SnNXkSfXC3bFKJ1IJbaoayRn7ASi1gYtW9eTqhk7CcvS3RFP6c5YGf5n3IXYVDYFRjMukeVf52ihT2ed0GYbWDFDY2+fpYKeuRKdPpsFe9smxeQ+qoP+kaSmcFP1/0RripGZdVfaeRY3FIEzsuK3wKoWQ4a4o20s2haLl79USyuLvzhLSB9tuKR8igN6X6q/sKpTLUP4igUFz88q1efHp8EhAcQz48e2L1rdp1hPkA/Vx8Y/HooCK35+XH7ZNg6lqwNX8jWBzYp679mMJNMMZqthyJ7dQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W47LesqVzF8iZLPJmiAuoXOv8msFtSDADJ7TmWa+6PI=;
 b=GIr/+ZUB7oUOBwIlNCwRdaOF7k8VCHFdPLykX66lDfN4Y63qqjOYd345slJW96n6LNZAbPf8ZtVxw1cweIGVDRSJBkH3tEgbSRG/5zOQUYRpvD1XCtUjVU+PghbfyBReTalUKCHx9yoqUXwzZmtlqomvSN2Zhwr54c+URAhBAgfAp4Wr7oztxWcQa1dNjpmum6vOjBAMNQ+SwXbJhmo+ok9Wq89399Uykq3p5i7yn+GBVB/Az9siBOBtr7cNSLOM1ezzqV4634JY5xOhFzB1PkrmoYnDIISS5udYX8RWkWrLqag15ysftFVsI7dXRUdN1nrS6nVfe81U///IWD4/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W47LesqVzF8iZLPJmiAuoXOv8msFtSDADJ7TmWa+6PI=;
 b=qCQNgE9ANRz8K6dIddx0qZnl/TP6y2ROF/AEagvUAV8TRtE5h55aSLkuMGeSoLUy28bjHsYC3Hkc2PDm6175nFMxOOSliogVEmrMTyp3GkH6iK/SIbbhuX+pPkhniuCGIKDFjKzQqCWssSNOegT6k0pHDdWYRYQUfvuYYif3X8ox8yp7jz1OtOk6lZFFsV84vYfUwtqCKGXVuN2yvbk21rG4U4lxUCzDh8xho+yxB72fc2fiFXCqoode9izEDoHbtvlXLTM6Gpr2Q65UzZgYyi7gRfKzwsEBYNwi0Za6VNE95DSpJdxeLZXdXdZHT35E2N/CuM9Bo6nS1HupZ9WNZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GV1PR10MB6730.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:86::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 09:38:57 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 09:38:56 +0000
Message-ID: <1d696494-3bd2-48a3-9c8d-e7991b33109d@kontron.de>
Date: Thu, 16 Jul 2026 11:38:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Fix problem with premature
 PLL locking
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Gary Bisson <bisson.gary@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Esben Haabendal <esben@geanix.com>
References: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
 <aleQlpx73a5R8QgR@owl5> <48f6f55f-43fd-4355-88b9-d2e2d0e26d07@kontron.de>
 <3962826.kQq0lBPeGt@steina-w>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <3962826.kQq0lBPeGt@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GV1PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a413acf-1400-4f59-d498-08dee31e0ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aZxeRdAyDf0DBnXJWI81uxw6iIo0E9ZRy1wWHu7SGpJUGFTpn7y1CJW5706PIwGaNXBXOhU+MVSpkTssYgTb4Kld93E3Bn++1GPBZooacSkHY5JIYeRfRbjRypPrGenmBOrojIblR2gXUT4gECx+iNEGiXdV7xeZZAqfyYlutFXUdC0EYsZS0it5gm5q7fSs0YQKc4KMt+BlM9h9pb2EjWQ6erkIJQ+FaYrDXW2RZIDe+fRCCkDj/XontOQtm3Cxr0lx5xk1a0tgK8J0P3oZy/oaXegpVMFYvUy9CpFM2rd7lmZNZzsjLKUgMYqpL1ZMXPRJYez9aSigo0HO859yflwH2M+J7R2CYqT5/TDjkwWDZndLkq9PAclokDomqqANNFO7iR5xN9kUYTfpOnWZYvVEylMiMAfLsp4xDojaqc9xo9LJZlfHNRvwqt8n7Z6snhGoJrfknlHXqhOmxreTEUK151gkhftf0fmEQuVjNd6w07dzXkiORqGcwQH5+1Y2dc/7fYEARpv0k6kibCTWHt5krp8DH0rqTwtg2aQpwDnnrNgHP/MdJ2f6LRNEVHoRwDjPmDA/qSQNtWwF+F1GfMfenUnxuPFmoXXM3G8KqXHz46bJUoAdXV9KzZHL5VXV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUVrQzlsU2FIa2tidjdrKy9wSXZ0ekNQK3dFaGNZd1JSZktJWU50aUE4UGVl?=
 =?utf-8?B?YVY5SHc0Vkg4dWVCYlVWckI1L1BtbU4rRExLQ0k3cm82QWM5dHFrdzJHck1R?=
 =?utf-8?B?OXFpUG91b2lPL2VncG1DWkNSVDZjYjNCdWJwL1Bucmd0bXhMTmE5TFpWNkND?=
 =?utf-8?B?VnNIMlBBQmZNMjBRU3JHT2I0aXY1VXAvZEZKcUlCM2tQWFFLNVBuTksvMGFD?=
 =?utf-8?B?V3dvMXUyQnZjTmV6TU1wN0hoTVVwUmpaWDFqQVhvdTl4Y3g0SEM0NnBRODlm?=
 =?utf-8?B?TjczcjVqYWlHMUpnSnVYd0xJNDAvNEJlRTN2RXdYS3FoM2syY2tyK1lIZVd4?=
 =?utf-8?B?d2NtTEpnU0hsSFMrbTdoVDBpcnhUUU5WUVlnbm5WdVRmK3h3YWREQis2bW1t?=
 =?utf-8?B?RGRwQXpuSWVzVjRna1EwYWhraEN1YUlHM0xVTEdzWWVMZ25KSkkrZ2h4NTNN?=
 =?utf-8?B?WFVERzJiRVlTNnU3dkxxY3I3eVpnazByeklmcjI2V2tmQ1RNMlJHM2ptMVZu?=
 =?utf-8?B?cmtiNDFhcFlXTWtVTDlLeVVBeG9MRERkNElZcThxR0IrbWZ3bjA1MHJTaCt6?=
 =?utf-8?B?UkpuOFY4MXRZMHlFU3BsNmVhUE5VTU95K3J0YWgvZEhETjBOY2E5cndXUy8z?=
 =?utf-8?B?UWY3eUtVWGEwUjdueHB0dVNzemlZdHVCMEhiSU9iSk03cTRnQUw5U1JEeklm?=
 =?utf-8?B?VVFJN20xTGJzaDJTOW5CTXFKWHNRYWVVQ2FrSWxDU0JodnAxMGJlM1NwRi9L?=
 =?utf-8?B?YXJ0bVBlT3NHUEozRlhNR0ZwcU9EaWpsT2lGV2xuK1lEZ2kxdUZHdGJVYjJZ?=
 =?utf-8?B?akFJY05EUUZKN2ZTWHM2dytHUXl0VU10U0QzUkxidEhJRFVKMTVTdU9Nbk84?=
 =?utf-8?B?dDlkMzR1VmR3WW8wOFl0OGNIVWVBMVBWcXQzUEllbXAyT055WVNQY21ZU2R3?=
 =?utf-8?B?RjRlRUhSRFRXdFowbUwxS2pRWDZ6T1cyYjlkNll2RUZOa1NQYWlhRmxySW1K?=
 =?utf-8?B?UElXR3BXN1hWSE1Qa01nZWZJem10eTNxWWEvTDNjSndhYXVnbWdCYSsrdGhJ?=
 =?utf-8?B?TEVJOHRvaDEzMHBmckhWZGlqd3RuWFd2cDBnWGo5aXRqdnFnZUpvdVdidVJp?=
 =?utf-8?B?cWtlSDVJR1RGUnJHdG96eFA3NWJZN05ZZjltNGRoNUV3cm9HK2hPanB3dEJp?=
 =?utf-8?B?QVJTZi9uSlpwMmdZKy9XMWhLaUl1NGltN09HSDRmNDJ1aGt0ZUI5Z1RucTBa?=
 =?utf-8?B?Vk9RT0dRMEZkaEFVOG43T1FXdzZHMWlwWU9sanlQeEJXSGZQQXJ5V054bExU?=
 =?utf-8?B?Sy9NZGd3VFVCYW02dUo4M0RkazRIdXJ6RldvQlRvNEdMS3FZWVpGWjI3SXNt?=
 =?utf-8?B?UDgyclU5cFpoTU50M1ZPaG1jMjV6amFzQTNjN3dWTk1wSVZMTTYyUTQwWXhW?=
 =?utf-8?B?cmI2cVVRRnVudUkza2t5M0lwaXA0cVIzakRyRTFIRllXd3AybkI2M0ZsQjFz?=
 =?utf-8?B?VEllY2k1L01LSU52Y2lqUEY0em9ZL21tRWNDWXpVOEJRMG5FWThWWjNqTWVu?=
 =?utf-8?B?U1hSK29ZNTV1eWpNNU9LaXhBc25XWHc5dFhVdlBTUUN2UDJ2bFZZN1p1WDZt?=
 =?utf-8?B?L2JiYnhGNzAzWnZHWDBJczRFcDJQZDY0NDNrNTR0T29FWWoxWUpQbmdydTlF?=
 =?utf-8?B?ZGRia0tsZEcvUkFtelFwOFhRQmdMbG9wYjVHanVmbnhhUGJkeXpGV293YkhY?=
 =?utf-8?B?MXdKQ1pweXhhYlMyRnByNW1yWGNvSlRneW1TeWx3OXdwUFdjQmFiWnFXclB4?=
 =?utf-8?B?TjdrNStsT1ZFU3A4NzBid3RzQjFBQWtRMVQxUm03aGd1d3lEMjNkSEpsMm9h?=
 =?utf-8?B?Y1l5U3ZQZlEwbTVIQTdENVpsSi96NGxzZ0xuR1phS3FMNm01eHZDZ3J6QTRI?=
 =?utf-8?B?bTFDczNiNlJ5am93MnZuTGErVHhRNHo4WXF5SDRDZThaeTF0TTd1bHBSVDlE?=
 =?utf-8?B?dDE1dGZGM01pWUs1NUhZTElSNVVDYkRNOEwrcU5nazdncFhnUmVHSHlJSldv?=
 =?utf-8?B?QkdBd2dIbm9TT1dzNVZFZ3lyVllXK1NDdkYwWWdqTW9JSDl4WjVhNHdBL0R1?=
 =?utf-8?B?b2doQ29jZVA0aEN6clJROS93Z3ArbU14eUZVSENoaEFPZUd0SGhySmpQcHAx?=
 =?utf-8?B?ekNrdkJRd0xvdW9HT1hoYUZTZXNGbGlWYkYzQWZCSUtxWXVNREJ0N2RZMlJq?=
 =?utf-8?B?TXJhZUFoWUlDbzJzWkd1Ly93bmVmK3VyT0dsQmt1dVBqWG9CRHZsL1UycmFK?=
 =?utf-8?B?QTAvb1ZKR1FYaWUzVnFhTFROOExnVTNnNDE3Q3dTNzM3V3pKMjlRMklvTmd2?=
 =?utf-8?Q?pPGG+ImKXYpEGzDI=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a413acf-1400-4f59-d498-08dee31e0ea5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 09:38:56.8844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0eVQzpMKHhXM26+BnAEZu6uxda5ebnFbweMnhvmxASIijcguleB05vzLtXyXDxXn/JVT7w88Df1yji0D2wqwHray1cECdWAHlz2lxH2SCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6730
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

On 16.07.26 11:32, Alexander Stein wrote:
> Hi,
> 
> Am Mittwoch, 15. Juli 2026, 16:14:42 CEST schrieb Frieder Schrempf:
>> On 15.07.26 15:52, Gary Bisson wrote:
>>> Hi Esben and Luca,
>>>
>>> On Wed, Jul 15, 2026 at 10:52:18AM +0200, Luca Ceresoli wrote:
>>>> On Sat, 11 Jul 2026 13:51:15 +0200, Esben Haabendal <esben@geanix.com> wrote:
>>>>
>>>> Hi Esben,
>>>>
>>>> +Cc Gary
>>>>
>>>>> [...]
>>>>>
>>>>> This is the same issue as addressed in the patch by Gary Bisson [1],
>>>>> but changing the ti-sn65dsi83 driver instead, so we don't have to change
>>>>> all other drivers that could potentially be used with this chip.
>>>>>
>>>>> [1] https://lore.kernel.org/all/20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com/
>>>>
>>>> AFAICU your patch would replace Gary's one. Also Gary's patch has been
>>>> reported to introduce regressions but it hasn't been reverted yet. Can you
>>>> reply to that thread mentioning your patch, so everybody in the discussion
>>>> is aware of your alternative proposal?
>>>
>>> Thanks for including me. I just tested this change and reverted my other
>>> one (mtk_dsi) and confirm that it works on my Tungsten510 + SN65DSI83 +
>>> tm070jdhg30 panel.
>>>
>>> Tested-by: Gary Bisson <bisson.gary@gmail.com>
>>>
>>> Note that the sn65dsi83 driver wasn't changed as I thought the PLL lock
>>> in pre-enable was on purpose. It was introduced by Frieder with this
>>> commit. Adding him to the thread to weigh in.
>>> dd9e329af723 drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec
>>
>> Thanks for the mention. This was introduced to keep the init order
>> according to the datasheet. The DSI host first needs to put the DSI
>> lanes into the correct state in its pre_enable(). Then the bridge needs
>> to be enabled (including the PLL) in the pre_enable() of the bridge
>> driver. Only after that the DSI host is allowed to stream data.
>>
>> Moving the PLL init from pre_enable() to enable() probably violates this
>> order. In the past this lead to sporadic issues with some hardware
>> setups (depending on the display and the DSI host). Some of this is also
>> described in the docs: [1]
>>
>> So from the first glance, I would assume this issue needs to be fixed in
>> the DSI host driver.
>>
>> [1]
>> https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operation
> 
> This link says
>> Ordinarily the downstream bridge DSI peripheral pre_enable will have been
>> called before the DSI host. If the DSI peripheral requires LP-11 and/or the
>> clock lane to be in HS mode prior to pre_enable, then it can set the
>> pre_enable_prev_first flag to request the pre_enable (and post_disable)
>> order to be altered to enable the DSI host first.
> 
> So IIRC if pre_enable() already requires LP-11 on data and HS on clock,
> pre_enable_prev_first should be true then.
> 
Yes, and it is true:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/bridge/ti-sn65dsi83.c?h=v7.2-rc3#n1051
