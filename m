Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5EE1061B18
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 22:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 764E910E77E;
	Mon, 30 Mar 2026 22:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kJnhCKUc";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7119D10E77E
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 22:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774909494;
 bh=RphenkmKp5cHZbTuPcy3VOdJH9R0n5lebz4MDGW0iN8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kJnhCKUcUJFcI9rTX+8uPRrlKQaxBe70PwrsqkIcSoQI8ZQWxUscNMnrh/LRVlTHE
 9hGfYLTHy0+rGNTKUPDou4Mt//azoT9jcZMfoa1OLhOgC7hSfWSPfDiKdcWlkZtN7r
 ZHfJ5mXIFGPsPbhFUNcghcP4/h1rFA7uIdVDjzhH5wA1hW+dNrjKhV2lNo4CL6w/3b
 syWWD2s09ujeXhx4eSoI8gVSxOJ7Cy+nfuQsXq0IwcbMHeHZyUS7L6ctlLHfm7vz48
 Y12kvdBaZvv9adgrmc3cVXWcGAARz4pZmcJvib1bioJL3e7GXX+ijfh3aWkfQPKjac
 SKbENZPsI5ZUw==
Received: from [192.168.1.57] (host-79-18-8-236.retail.telecomitalia.it
 [79.18.8.236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E3E0517E50D0;
 Tue, 31 Mar 2026 00:24:53 +0200 (CEST)
Message-ID: <7df5a59f-8f66-4764-bc85-59eadd0851f5@collabora.com>
Date: Tue, 31 Mar 2026 01:24:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 4/4] drm/rockchip: dw_hdmi_qp: Do not send HPD
 events for all connectors
To: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
References: <20260323-dw-hdmi-qp-scramb-v4-0-1d99df84883e@collabora.com>
 <20260323-dw-hdmi-qp-scramb-v4-4-1d99df84883e@collabora.com>
 <47972235.fMDQidcC6G@phil>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <47972235.fMDQidcC6G@phil>
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

On 3/30/26 7:56 PM, Heiko Stuebner wrote:
> Am Montag, 23. März 2026, 18:45:30 Mitteleuropäische Sommerzeit schrieb Cristian Ciocaltea:
>> In order to optimize the HPD event handling and run the detect cycle on
>> the affected connector only, make use of
>> drm_connector_helper_hpd_irq_event() instead of
>> drm_helper_hpd_irq_event().
>>
>> Additionally, move devm_request_threaded_irq() after bridge connector
>> initialization.
> 
> nit: Using "and", "additionally", etc in commit messages, is a strong
> indicator, things should be separate commits.
> 
> Especially as the sentence above just explains the "what" but not the
> why (interrupt firing, before the device is actually there probably).
> 
> If there are no other changes requested, they can stay together though,
> the "why" is somewhat obvious here.

Ack, will split this up in case a new revision is needed.

> 
> 
> Both changes themself look fine, so
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks for the review!

Regards,
Cristian
