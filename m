Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AFC105F7BC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6B010E468;
	Fri, 13 Mar 2026 15:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="jGTeG0gc";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C76D10E45E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:47:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6B9B51077B0; Fri, 13 Mar 2026 16:47:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773416863;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=pd3lTWjZ+5rSyJMewkwT1eT+19Jc15PppiNJcmSogXg=;
 b=jGTeG0gcswCkMeJGtupDnz72P0d6dI51r/nmE4P4w55YUQ16dGl8KS+2sOuA0lowqveU4M
 Yxds52mkPDbMqzq6DTB3WZDzuSG/0dWwHof2IxGvZHV4JJ/Xliug9O6+v8igmgm5MkD2Kp
 Gxz45U/QfjzeY+l2EZ36wqfTrYfQoqS1WqYSpucyRaVMpHbaiuAy74k0n3Q1a5q0m4NUkW
 Mn8K1c+2PUQtjc7U0AioKQ2h+d6DPvWhJI3AjHZcn2d//VoLPJ8pco12r66m4xa87lgCPC
 adhiF49yTUnlA5A5f9GpDXCFHP+FrhOoEUyg2mcROG1PIkDsbKFx5w/XfEnM/Q==
Message-ID: <3c6d81c6-500c-4ff6-b923-9f446678a6bc@nabladev.com>
Date: Fri, 13 Mar 2026 16:47:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imx: parallel-display: Prefer bus format set via
 legacy "interface-pix-fmt" DT property
To: Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260110171510.692666-1-marex@nabladev.com>
 <30511e1e0ffd6579091fc4ed1cad084fd81b9c96.camel@pengutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <30511e1e0ffd6579091fc4ed1cad084fd81b9c96.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/13/26 4:33 PM, Philipp Zabel wrote:
> On Sa, 2026-01-10 at 18:14 +0100, Marek Vasut wrote:
>> Prefer bus format set via legacy "interface-pix-fmt" DT property
>> over panel bus format. This is necessary to retain support for
>> DTs which configure the IPUv3 parallel output as 24bit DPI, but
>> connect 18bit DPI panels to it with hardware swizzling.
>>
>> This used to work up to Linux 6.12, but stopped working in 6.13,
>> reinstate the behavior to support old DTs.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 5f6e56d3319d ("drm/imx: parallel-display: switch to drm_panel_bridge")
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
> 
> Applied to drm-misc-next, thanks!
Thank you
