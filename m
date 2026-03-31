Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6723A1061B2B
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 01:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A40F710E7CF;
	Tue, 31 Mar 2026 01:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="YVcT+Qbw";
	dkim-atps=neutral
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0015610E7CF
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 01:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1774919919;
 bh=0owlCERj6gBEP9bncwJSFnotM1/dSDt0HIHcpsl1dUE=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=YVcT+QbwDdC00rcSr+a8kFqiqRzTPKYBuDu5NTUCiA0zUJoGruoFPCMAp7nanz8FY
 sX1OTi6JrZqmq886kMVpQzSmDBzCFMplJJKVS7Vi1e9pCLWQZpU26W7rE7q4wY9+Z2
 Rd7Ky1O0tUaP4OnM0vYb/57cUniHqGUJ3bsDXc74=
X-QQ-mid: zesmtpsz6t1774919917t48c7f87e
X-QQ-Originating-IP: 73VvFKCdPCWg6XgecUK7wdpE0n5+tLRhYX+nOTNzZcQ=
Received: from [172.16.12.51] ( [58.22.7.114]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 31 Mar 2026 09:18:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10548730784965286243
Message-ID: <AFAEA46A791878B0+9fe68e46-8d8f-44f1-80e3-dfad2de51832@airkyi.com>
Date: Tue, 31 Mar 2026 09:18:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com
References: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
 <FE1BFB774BE13241+54b8a8ce-5a8c-495d-a53f-65a2440924fb@airkyi.com>
 <acphlgK6ZmBitGJL@venus>
Content-Language: en-US
From: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <acphlgK6ZmBitGJL@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NUTz4BkILuKLAqpNKFPHbFLgq2niF47NiSVqRtUS4oK4g8ZpaJ2hN2CN
 WdbHwkUTBDaLWG+RrW97tXB1Q2epQPyoq/A6Dx2McVtnlu/bimEHZwBAPBL0NVR8YAlWpKR
 Ma9nt0JW7MNnNwI7vIaqhK2W5xKlCK1z4FlsuIafWDGmYo0V+7QVui+3atfq9K/o53YxaUJ
 B9nkNArZaEndwSldx6qADtXedmiqK/1UMJ2l2SmkPA0NPXEg7AB/SxHeqIaQcsjqM+aw6g8
 mzGpsCEgix492U8c20dJJ/8INbx4TpDw9872I6F+D6sP9y8sK3v5tsC6w4EEwzwgff2xgB/
 uexNoKpAMVHhpxnitOgTzHdnItKty3aa5LJy/nuIi8wslyxM+CTJk2r7zboT6lX1PIxidq9
 Lv3fYqVWOAzNaisAYxV3WYxaHISXaCgg+QgACx7gAftHqYDmz/Ja46XPl/Qt6D1rylGecmL
 /cg1dcIUTHRQAbA4zqFkh2Xte18RoTu3iTjUIHVsunBs6wOTWEPdu49Bmr2zjAmVm8pSGup
 uPUoIPsY2lXChb5S0kS0RW0KmXxoP8++ODFLZg0rWiGqP7NIygxJgNZterSmLbKUNNyb91j
 vjmorO59eeJ4WVDeYgUMEJ3hn4Ehkjnfb3OhyAwbUvssbSXO3EvIvGkQ4t+pHfzMGxIsZ1n
 LdbDRSj8NlXwcgD77Fw+O8PST27qqr/4CWeppTtkKEd1/U64lQ8OER0CoJmmbDbOTxHRXae
 rEThcjqr2zJa1byry3j4fZ0SR4J1yHPELJOp9LnFJ/6Z8lq7YLdUeLkMN1wHja8DtNchpMW
 jbgO5TzTEluG0QgAjvqqVbPhlbnDkqNdxCiSqHCoCnTdsTszRsMTk/JWu81ITGmM1L1S+aj
 enOG14vrCM4mbQ4QKEnAUILavz0EPZe3G0dJmfTdH7k34I9rpVMXyklevCXqs79JZI88M0p
 tQ4IoPJ2FRYD1A+mYVk6Z4H1+ufLJ6sc99qmAXQthT68RT8C4U2Vtkje4
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
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

Hello Sebastian,

On 3/30/2026 7:50 PM, Sebastian Reichel wrote:
> Hello Chaoyi,
> 
> On Mon, Mar 30, 2026 at 09:34:15AM +0800, Chaoyi Chen wrote:
>>> There are two parts, which possibly need some discussion:
>>>
>>>  1. I added a dedicated bridge callback for out-of-band hotplug events,
>>>     which is separate from the hotplug_notify. I have a feeling, that
>>>     there might be a better solution, but haven't found it.
>>
>> Could you explain what an out-of-band hotplug event is?
>>
>> Can't the drivers/usb/typec/altmodes/displayport.c respond to these
>> hot-plug events? Thank you.
> 
> That is what generates the out-of-band hotplug event in the first
> place via drm_connector_oob_hotplug_event(). The oob in that call
> means out of band.
> 
> If you look at that function it calls oob_hotplug_event() callback
> on the DRM connector, which is then implemented by
> drm_bridge_connector_oob_hotplug_event(). This function calls uses
> the normal hpd handling (shared by in-band and out-of-band) and I'm
> patching it, so that the bridges are aware of hpd explicitly being
> provided out-of-band.
> 

Ah, I'm actually more concerned with the specific types of events.
For example, the "explicitly" provided HPD you mentioned here. 
Isn't drm_connector_oob_hotplug_event able to provide those?

I assume you’re looking for an oob event that is propagated along the
bridge chain, rather than at the connector. Is that so? Thank you.

> Greetings,
> 
> -- Sebastian

-- 
Best, 
Chaoyi

