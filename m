Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA17FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E7010E0F7;
	Tue, 28 Apr 2026 14:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FI4BMrG1";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38AD810E0F7
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777385444;
 bh=8U5hrdolA+y+3mG3AaoqX+B0mjaYuFRJDFtJJ0yiStI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FI4BMrG1hXG2CerAkIE98HWuFW4UGy71R5db0fNotmySofWyeW+iVcXPxvj6L6OBO
 OuClsBXSPBt6WHzbHsqRrn1Nkvn5ERDROxWu2iXCbJr2geCJiG8iYVbZPNhOg64BFy
 28x/mBtxR1nCBPwiQGuogAJvCv1Dp4dkhh3x6FwAkkb7qrze5JAC8qMUllLMqgtBZA
 9gRnnTqDg1JXTwrVCdNa71Jpi+JsyhkJ5RSkE8RtgdmG2OqoKZ0ALopGmbE1aCKZj4
 fJVxqJu0V1Rm8sQzZxiE75pnLa9Dmiv4UNp787Fo4Rc0/uPvCGmQGXJKI1LZ/aHGHk
 RtAxW/IvSxjRg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 16D9917E128F;
 Tue, 28 Apr 2026 16:10:44 +0200 (CEST)
Message-ID: <0143075a-098e-4275-b152-419700e4b7c0@collabora.com>
Date: Tue, 28 Apr 2026 17:10:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] drm/rockchip: dw_hdmi_qp: Restrict HPD event to
 the affected connector
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-10-d778e70c317b@collabora.com>
 <xwsnwqk2bqixswue7ajy5tfzxn6u7sfuqlpquywsrdj3bs6nmb@pv6szzdjjuzu>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <xwsnwqk2bqixswue7ajy5tfzxn6u7sfuqlpquywsrdj3bs6nmb@pv6szzdjjuzu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/28/26 4:53 AM, Dmitry Baryshkov wrote:
> On Sun, Apr 26, 2026 at 03:20:22AM +0300, Cristian Ciocaltea wrote:
>> Switch from drm_helper_hpd_irq_event(), which polls all connectors, to
>> drm_connector_helper_hpd_irq_event(), which runs the detect cycle only
>> on the affected connector.
>>
>> This avoids unnecessary work and redundant detect calls on unrelated
>> connectors.
> 
> This also doesn't feel correct. The dw_hdmi_qp is a bridge. As such it
> should be using drm_bridge_hpd_notify() rather than any of the mentioned
> functions. Would it be better to add the a corresponding wrapper to the
> dw_hdmi_qp API and call one there? 

Let me try that.

> Also consider implementing the
> .hpd_enable() and .hpd_disable() callbacks for the bridge, which would
> remove the necessity to call enable the IRQ in the bind function.

Ack.

Thanks,
Cristian
