Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC17CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 405B710E541;
	Wed,  6 May 2026 15:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kx3pizV5";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D967E10E541
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:02:47 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5a8738c178dso2524339e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778079766; x=1778684566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZrHT8jRgn9wlWslwwDOMFUBlZ/k/+GYgzkcTlTMrZnY=;
 b=Kx3pizV5zf37U87+YL644jqD9lLuF5oc0NktLRwQbtBep+nNsArT4e+l5cKz6o2yP8
 wxC32uTnYAcLqEmSrU06IvjaURpdBe82ymUgTTGlMCOlMxgpHGgtlw/461QBm2sGdsLX
 dX2ACkVQPqrh9z1VcZSP2WwtP4uRFzaNxddEflfS82k1sLhSdLe7kaQfbTOAUokWoecR
 f6x2PPYIu9lhQ1xFI+j9xZwgbw9q9Tp3c+p5pf80iRD/Qye/yZV/CWSWFVOA5T22gsH7
 Rd/5L9TPgVtJztf0zmtD1qC47QkUW5qudEtkidudx9iSjS5/ZhiyqQF1Gf/tdQ20W2Zn
 cLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778079766; x=1778684566;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZrHT8jRgn9wlWslwwDOMFUBlZ/k/+GYgzkcTlTMrZnY=;
 b=l+gcNUBFUSv0kt13gLaIsowWVKpd0mocIfcWuTZMpHUxk7hKQ6yJHzJpgzslAu68+d
 Jog++XZCT37FOcxJHdcoNOpPXtfWE53XaaivT2p1iwxjMoEsXqbUuxIQDZt9eLISTXof
 HsnG6tFw1oxdMt5Abv7LjdeedQOkK7m5K+49CcfsM59Bd8yNJx0uwlBn/R+EouTIFr4f
 rKVsz82ZBPKiJgmZj11pWL3kx7WzBgR8dAzHulZllYuGFG7u2KyW4WlSz9q9oKTrzDkF
 R/zk8mOpzHCdjPp8xui/G4YxL5PCotz5NqaPv/Y93LIGFjEZo807/AzmoBaU+4FnG7yu
 IYFw==
X-Gm-Message-State: AOJu0Yx/FLX/FGhs6dVfbNm+MKNJ/hfKtSA17fx/uzrM5PhKrKvX8aJm
 6JGXIDVxUS5JPV7m3Ah+lTTFgJ3Y7EXPlHfMuj8MZzh516o2W20/j7Y4
X-Gm-Gg: AeBDietaaFnJP8dNojic0uD/eO788CNcPF9OOC/Yt7o4G7Z2JOVwcc8ayNkJVmVxWPs
 VhpRQOLRq0cN99QwUVxv693NWmTM7f7OSsVG7Z1TWi57aXrJOUgHhoQCq2P6+lF1ptZp//UhiB7
 5rj22h2Se8/7uX3e3pq6HqFFHmjiWW8/ufK7LLM2HX+y/x9VkKloixrv1wBtrQp6X+XNHF4NQvv
 FeqYMRZTWRUTkPNoyR8H47q9qRHlQrECbFkMYwAWrLdTTIH2xgw9P+w5ywwAROfYlXf6r+Od6EP
 JTANI+3aNsY3Dci1nSP3wXfcS+KodifxMUA3GBm4oJJltDfOsYVpXR/Zde9I4ppbv9WRWEwEzpN
 7imWuvxR6oCZa9t0xkkKcDhrSbAj984YMtdfihoqH6N9dOHGLcmd6yWIVOLE9a8GVWIaddnlVpp
 rYvL/6AADbtIWR4wCQbiZVTcyidRHU3fbE4tPBAuFXOQSzrbp4SMroHw/+fgVNhgGPlT8tVOCdO
 w==
X-Received: by 2002:a05:6512:b82:b0:5a4:d4:5c5a with SMTP id
 2adb3069b0e04-5a887ce65d4mr1311119e87.28.1778079765546; 
 Wed, 06 May 2026 08:02:45 -0700 (PDT)
Received: from [192.168.2.20] (109-252-156-195.dynamic.spd-mgts.ru.
 [109.252.156.195]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a88867f754sm664935e87.61.2026.05.06.08.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 08:02:44 -0700 (PDT)
Message-ID: <7b8f06ec-dbf4-402a-a7bf-fe8227b4f8ba@gmail.com>
Date: Wed, 6 May 2026 18:02:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] drm/bridge: tc358768: Long command support
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
References: <20260311-tc358768-v2-0-e75a99131bd5@ideasonboard.com>
 <cfc703b5-012a-49ab-a42c-ff99c3ba6256@ideasonboard.com>
From: Dmitry Osipenko <digetx@gmail.com>
Content-Language: en-US
In-Reply-To: <cfc703b5-012a-49ab-a42c-ff99c3ba6256@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

06.05.2026 10:55, Tomi Valkeinen пишет:
> Hi all,
> 
> On 11/03/2026 09:48, Tomi Valkeinen wrote:
>> This series makes some small improvements to the tc358768 driver, and
>> then adds support for long commands, commands that have more than 8
>> bytes of payload.
>>
>> This has been tested on Toradex Verdin AM62 board, with a ST7703 based
>> DSI panel which requires initial configuration using commands that have
>> 8+ bytes.
>>
>> I tested the following combinations, by observing the panel visually and
>> the DSI lanes with an oscilloscope:
>>
>> - HS command transfer, continuous clock
>> - HS command transfer, non-continuous clock
>> - LP command transfer, continuous clock
>> - LP command transfer, non-continuous clock
>>
>> All except LP + continuous clock work fine. While observing the lanes
>> with normal oscilloscope is a very high level and vague view of what
>> exactly is going on the lanes, it still looks good to me: initial
>> commands are sent in LP, and then video data is being sent in HS, and
>> clock lane is continuous. However, the panel stays black, so something
>> is not quite right.
>>
>> As it doesn't make sense to send commands in LP during initial
>> configuration, especially with longer commands, I will leave that
>> particular combination unresolved. I'd be interested to hear if it works
>> on some other panel.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>> Changes in v2:
>> - Add reviewed-by & tested-by tags
>> - Rebase on v7.0-rc2
>> - Link to v1: https://lore.kernel.org/r/20251021-tc358768-v1-0-
>> d590dc6a1a0c@ideasonboard.com
> Any further comments from anyone? I don't see a specific maintainer for
> this bridge chip, so if there are no comments I'll push this to drm-misc
> in the coming days.

No objections
