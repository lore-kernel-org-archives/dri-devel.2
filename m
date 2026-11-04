Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B65609CAC4
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AjUAAIFk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BFAD10E215;
	Wed,  4 Nov 2026 20:56:48 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24DF110E8DC
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793825800;
 bh=DFMoN9VaSVJOOLJDXLMmcmecZLc78udASKoTWQJ1IOI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AjUAAIFkiuW98FJu5/ylNWovxCKnIXervDCdQA9Fh+rgpKxR7cLC9LjGYn0/xDgvN
 DWOD0IX9qA45/2uCKokePyD9FH/mO/GX69INb+wLz7GtvLwG0dAvffxnF8C/0NbEWC
 /mdZCIG442dQaiRve9lBLwbkCqo3zst9+3FUxjsUlYcA2T0onpOAb0rjejTUdDC2qV
 VXbyWi0+92XST4OaZMgkU8AMALOZhHqAxdGouxgoNPMoufb/GcrShfQTXzgv1GaOLX
 8YraaGnH6x7gnOXPAzOkUzqIhEh2dimoCaPvn5+mBwScM3HyJYvymkvfsk+CCdSzgk
 aAWnlwKfjZJ2g==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 54F2617E066C;
 Wed, 04 Nov 2026 21:56:39 +0100 (CET)
Message-ID: <f9797a72-2fd0-4127-b741-dfc6cf3306f1@collabora.com>
Date: Wed, 4 Nov 2026 22:56:38 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/15] drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422
 output format
To: Daniel Stone <daniel@fooishbar.org>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Daniel Stone <daniels@collabora.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com,
 Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-13-6fab0fe43a9b@collabora.com>
 <CAPj87rOMjFEjOQ9TVgbGWu3gTwVjmjuFNtnFiyxbWO+g_RPqeA@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAPj87rOMjFEjOQ9TVgbGWu3gTwVjmjuFNtnFiyxbWO+g_RPqeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On 10/30/26 1:52 PM, Daniel Stone wrote:
> Hi,
> 
> On Tue, 13 Oct 2026 at 23:52, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>> @@ -229,7 +230,14 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
>>         }
>>
>>         phy_cfg.hdmi.tmds_char_rate = conn_state->hdmi.tmds_char_rate;
>> -       phy_cfg.hdmi.bpc = conn_state->hdmi.output_bpc;
>> +       /*
>> +        * YUV422 always transmits two 12-bit components per clock cycle,
>> +        * regardless of the color depth, which from a rate perspective is
>> +        * equivalent to three 8-bit RGB components.  Force 8 bpc here to
>> +        * keep the PHY PLL output aligned with the TMDS character rate.
>> +        */
>> +       phy_cfg.hdmi.bpc = (s->output_mode == ROCKCHIP_OUT_MODE_YUV422 ?
>> +                               8 : conn_state->hdmi.output_bpc);
> 
> Same question as for the VOP2: why only special-case YUV422 when
> YUV420 also needs special treatment? And presumably in a way which
> can't just be mashed into bpc, because the maths doesn't work. So
> would this be better off being handled as a separate output-mode
> adjustment?

For YUV420, the halving is already in the TMDS rate, so the PHY PLL output
equals the halved VOP2 DCLK - no special handling required here.

However, since YUV422 is not deep-colour packed, its TMDS rate equals the pixel
clock and therefore the PHY must get 8 bpc.  This is essentially what
drm_hdmi_compute_mode_clock() does, forcing 8 for YUV422 for the same reason.

I replaced the ternary (and the related comment) with a documented helper.

Thanks,
Cristian
