Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D24DCD4F54
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C9F10EA9E;
	Tue, 19 May 2026 06:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sxKuhout";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135E510EA9E
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:36:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 78EF260052;
 Tue, 19 May 2026 06:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915E7C2BCB3;
 Tue, 19 May 2026 06:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779172614;
 bh=7AaeSvfyqPMp9R+dhmGlKn/SXtEA+e23F3uNc8wGbDU=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=sxKuhoutbBtK0thy7g5VaN56hzdcLoA0tILrxGQOek5+j+K/xXcdlk7QLBdLhYcJd
 ON7Izh0cieqjaKKnzTWscuOox14dF0WZROd5EZ1b0Dge0P2DhT+XCTnym3s1ZZjGJX
 KQHPS3qrU+Z30q3sodjyEBu1OI28g5L1IvExI3ZE0KU8QBGPcSc8drqsaNTsEZ7TWd
 ycoA5MW5zdgtgaeSr8GQqSNHrnPLUHm5G3x/vzRN6sMUSDJP5qFnWeksX3Sgd5fT/W
 238OQVJtmsy0ggkXFLpOOs+8wfxS0WZd62q7RsjV2L8zsYusvz1yKgUQ+c5KZSZShu
 Gon7WAJKaUpew==
Message-ID: <48fdaecd-a8b9-473d-aad2-35f5e459f161@kernel.org>
Date: Tue, 19 May 2026 08:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 05/13] drm/meson: encoder_hdmi: Use CEC phys addr from
 display_info
To: Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20260518194744.2483580-1-jonas@kwiboo.se>
 <20260518194744.2483580-6-jonas@kwiboo.se>
Content-Language: en-US, nl
In-Reply-To: <20260518194744.2483580-6-jonas@kwiboo.se>
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

On 18/05/2026 21:47, Jonas Karlman wrote:
> The dw-hdmi bridge detect() func now updates EDID for the connector.
> Something that ensures that display_info.source_physical_address has an
> updated CEC phys addr when the hpd_notify() func is called.
> 
> Change to use display_info source_physical_address directly instead of
> re-reading EDID to set the CEC phys addr at HPD interrupt.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

> ---
>  drivers/gpu/drm/meson/meson_encoder_hdmi.c | 26 ++++------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 55c0601df3c6..1b9a1d9ed3d3 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -330,28 +330,10 @@ static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
>  	if (!encoder_hdmi->cec_notifier)
>  		return;
>  
> -	if (status == connector_status_connected) {
> -		const struct drm_edid *drm_edid;
> -		const struct edid *edid;
> -
> -		drm_edid = drm_bridge_edid_read(encoder_hdmi->bridge.next_bridge,
> -						encoder_hdmi->connector);
> -		if (!drm_edid)
> -			return;
> -
> -		/*
> -		 * FIXME: The CEC physical address should be set using
> -		 * cec_notifier_set_phys_addr(encoder_hdmi->cec_notifier,
> -		 * connector->display_info.source_physical_address) from a path
> -		 * that has read the EDID and called
> -		 * drm_edid_connector_update().
> -		 */
> -		edid = drm_edid_raw(drm_edid);
> -
> -		cec_notifier_set_phys_addr_from_edid(encoder_hdmi->cec_notifier, edid);
> -
> -		drm_edid_free(drm_edid);
> -	} else
> +	if (status == connector_status_connected)
> +		cec_notifier_set_phys_addr(encoder_hdmi->cec_notifier,
> +					   connector->display_info.source_physical_address);
> +	else
>  		cec_notifier_phys_addr_invalidate(encoder_hdmi->cec_notifier);
>  }
>  

