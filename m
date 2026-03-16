Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038B6F53D79
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F46910E2BE;
	Mon, 16 Mar 2026 17:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t+Ws/0gg";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C517B10E2BE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 17:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCBrpzY6F1mZ/es6xzrCCLPO2ItwuriRZe45jn//Oq8/rckL2n14f5ucYeAgIZ9Juq9PWYrwW3KpbB5mEdln9ROT8ZDZGnQ1KPFStOsxW5Y+I3wKVqcJ4QrkI0S7ZyZfu2bF9v2gA+nNP8NQi+OXrYk4b5VtLssfXzoClcgyNEZSau1Wz0xbLUHps6uhLdFxtqkkwcrrLj4XHvxWuQkBkd+ecX2MTx2/o44LdRzjJ1lOFyB9TbltIBOrRKq6Dki53qfpWsIVpnsxch1TpAR4TYphW+duupMCFcp2v5dvfaw0Weaynwb486N+XM/S8YJZK3uYHkO+tDOlLOk8jDzi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQNwQwyzrqZ6cScjn0R9Td5SA5Hn9IT0GNnk7L2ss/M=;
 b=u4vUgRFNGJwJ03J/P/a4mvs+1hN9WbTDUsYqq4TnQu+FdROmkmxCyfKlwhsg8uWpt9cq+cA6HxXMbUdxq9FY0j8KmLlA/clX1Bi0jfEDW0xxAeIVQwVyy24yGfBiW2EzA6fg0RRnmJMHSZkTIVjh5bvDLAjY0WxhF4E8Ra813IBbFw5V92Yezyx+GfbkGrS1gMuvAcIwnPaZBRSSPTwO3YCMQAb8f+Dnhj7Y3YtdmRZ66im+XIFFJavj9/5X/Uc1ORYsK1CpjbvfuRp8rqVGz0htKQRRygdPORdVZ4SJNDRDVazw6o/+moBemU+OP+ojBFwPpG90kZZ3+vVkOu5+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQNwQwyzrqZ6cScjn0R9Td5SA5Hn9IT0GNnk7L2ss/M=;
 b=t+Ws/0gg4eYjWgA0aDekbYfZ1u14Om7DmFsb3RtjGQeJrXGh5ybXU4G/AXglexU8gqaI9Pr6+/6MxF5KMjemc51QnHMPSit67YyFdkY6IICzuI6Z3p37W6g2hk/n5dnXTyRkTvjOi/F1mO305Qn+kH1G6sgdYH2T2VhFyx7ilJg=
Received: from DS7PR03CA0319.namprd03.prod.outlook.com (2603:10b6:8:2b::27) by
 EAYPR10MB997807.namprd10.prod.outlook.com (2603:10b6:303:2bf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 17:05:19 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::5c) by DS7PR03CA0319.outlook.office365.com
 (2603:10b6:8:2b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 17:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:05:18 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 12:05:07 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 12:05:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 12:05:07 -0500
Received: from [128.247.81.246] (mz02jj9v.dhcp.ti.com [128.247.81.246])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62GH56Xl1168853;
 Mon, 16 Mar 2026 12:05:06 -0500
Message-ID: <27a87cb1-d3f0-4e95-8fd1-9d49bf435a85@ti.com>
Date: Mon, 16 Mar 2026 12:05:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: ite-it66121: Disable HDMI audio capture stream
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <ple@baylibre.com>, <neil.armstrong@linaro.org>,
 <andrzej.hajda@intel.com>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
 <j-sahu@ti.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
References: <20260312193355.1348842-1-sen@ti.com>
 <unsq4jrmlmwmkh4l6yz3vpmzifqpfxcafluawnxwxixuxg2mcf@gpou5yjbyc62>
Content-Language: en-US
From: Sen Wang <sen@ti.com>
In-Reply-To: <unsq4jrmlmwmkh4l6yz3vpmzifqpfxcafluawnxwxixuxg2mcf@gpou5yjbyc62>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|EAYPR10MB997807:EE_
X-MS-Office365-Filtering-Correlation-Id: fa448c03-61b8-47e1-a007-08de837e334d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: PTVIYC8bg1k8qBBlR5qpwM6suw5JJERY7uEgtBuPiH7XDPFnihb9OeVkHyRymBTvP5krUD9DLEcmpw/4xkvdtea8robd8VZ2kQSUyxWrUcD/MwY7j5w4R/iZm6KqCGmWMchSdp5uH6+MNi34xCD+IW9ruWw6EUlG5T6GHsOj3QQ4T8r4IKF+eiNKqp3JqKny7unO5OiC9GjzBF11nlkcZKp8ULKwA3qGv5qbQQjdjn4GgiG5bbbfPbBbLXsdjhgP//hQgn5/xvEgMDujF6ccAb3pVnK/4+tYWFrxjABMY4z8ZGF4PpKNu5DqHtUGQ6vsU930RFcf5mDwvsGfY0ceWqWi5vH+UMqNe6mpgc38CjI+utapxUzuPQZ6i0cBR+EhYqOuE13bsU8Wr8B1Yx/wR+IRpcYNibbY2BzRYNexbvXKq7qI0b9AY7qVTyahj8rYKBgniukkZFsoNeNmwq4Gkpnjalmf26zKl4fG4Y8Eolp1JvTV7ALULDcok/veH6KM8zF/a7Fy4uTu0ZzeFaCoIirRBqgle4uylBTADkP/+SJEb/SmHL1X0TVd3W/yCpVfvHRzSF2vJY5+dXYidWXNplhyG00Qy333JMi+2AN71R8V9HWALXFnz7BCzG+ADdCUqwy/bf2nKNGZzsR3lL+Zl8/Cn/1oscQ7gXLmrGGpAEgX2lNXh/G6I2W+qYMLvCVdwymfLqz5y6a+32IBSKmcB8oFqakYlvTnqUUAe4wtffYTusIG7scshujM9LzwWTgEAli7QMqr4omqNk1CzBj/iw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dIfIA+Vgna87UgElpzm88yvFf5jY4ECQ2TQlxO+QzABgSO/emlo3rB+lvwdoq6pnQcb9L9BaCXn5XLG3XnaB4hbsyDNLtnhB/g7sHuisu97QcHgW/9tRPxzYJPVIj9A2LNEqHrazGmSh4Ae5VuGMd+C379CPBgUSxxt7byGa4ZMCEJfzf2xRQNRE8ugONrjtLT9U8lbiK5Y3ghXZ68ASUIbGeMXhd1UaVaTDGFKGZ74Umvrv/ZFWMT5WuXtzmpWwIvKrp2rWAjlEeQuZWG/hUAz4R9gx9QZVdeUHfS/b7S3EtCswH75cFL7Re3uNiQ5fKfKx1JDTmpX7RUmJ0A8r03kpBkjQfickinlN3xXu180RKzWrSNID6JViIbTTJe5mgjN7Hhx1YD4K2Wl8dVn++Td7j8bMASR3Qh5CQX5gWy/l+SQglIzQbYeXUPDkhfHc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:05:18.2020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa448c03-61b8-47e1-a007-08de837e334d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997807
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

On 3/13/26 20:59, Dmitry Baryshkov wrote:
> On Thu, Mar 12, 2026 at 02:33:55PM -0500, Sen Wang wrote:
>> The IT66121 is an HDMI transmitter and does not support audio capture.
>> However, the driver registers hdmi-codec without setting no_i2s_capture,
>> causing the codec to advertise a non-functional capture stream. Userspace
>> audio servers such as PulseAudio then attempt to open this capture
>> device, resulting in errors.
>>
>> Set no_i2s_capture and no_spdif_capture in hdmi_codec_pdata so that the
>> hdmi-codec driver only registers playback, matching the actual hardware
>> capability.
> 
> As you hopefully have the hardware, can I suggest instead porting the
> driver to HDMI helpers and HDMI audio helpers? The
> drm_connector_hdmi_audio_init() already sets thesse flags for you.
> 
Hi Dmitry,

Thanks for your feedback.  I dug the code base a little bit more, and I 
sure can try to convert the legacy hdmi_codec_ops related APIs to the 
newer hdmi_audio funcs and test it out. Hopefully there won't be any
regressions by this conversion.

Looks like I just need the following new drm_bridge_funcs:
  .hdmi_audio_startup
  .hdmi_audio_prepare
  .hdmi_audio_shutdown
  .hdmi_audio_mute_stream.

Please let me know if there's anything else to consider for the 
conversion, I'll take a stab at it and send a separate patch.

Best Regards,
Sen Wang

>>
>> Signed-off-by: Sen Wang <sen@ti.com>
>> ---
>>   drivers/gpu/drm/bridge/ite-it66121.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
>> index 329fa47a5701..a1b2c3d4e5f6 100644
>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>> @@ -1476,6 +1476,8 @@ static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
>>   		.i2s = 1, /* Only i2s support for now */
>>   		.spdif = 0,
>>   		.max_i2s_channels = 8,
>> +		.no_i2s_capture = 1,
>> +		.no_spdif_capture = 1,
>>   		.no_capture_mute = 1,
>>   	};
>>
>> --
>> 2.34.1
> 

