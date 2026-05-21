Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD724CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152B410F338;
	Thu, 21 May 2026 14:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="B0KS206S";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB1F10F335
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:13:11 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-83659d38e38so2460113b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779372791; cv=none;
 d=google.com; s=arc-20240605;
 b=iLBQzH4ce7kMl+Ll9s4rMsuM9EEDsNOs4Bkq33+IvN+UOdGZPnhUxACM5R5Hay7dtX
 J9Q9CCT0GeIuzV44Savfyj0W0q9DxTrLvn0A3JsmDhXPa6cGSjLhkxl88hmE9xg2LjlJ
 fGSpZx6Y+aHbEJP2A5uW6UV7IGFTrkeN/9dr+qqNryb/3mV6/pNe/EPAQY59Zl0VAG8V
 hIHdN+9FBUH0c4YGhfPEP08rwjw8txaA4vbH/dL1jJLl4TmT1J0slexbQ3nUf0S+nuLX
 HfkxTbhCg15S4+pPy2NMPA/Na1VQjyF3cJHVwWZ9BzVOFnUANC3Px7AcLTk4XNNRzPiT
 6sFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=REP4STaURwNBwYLUxnT2eThrBHI2vGspRNmg6btJygo=;
 fh=arxgmCB4ytKU1PEWQnMtdkN7qzuZbszUqrpOYERCkpk=;
 b=ZAg99/rhPtdJHTUeJBziCDlWIvq9t4X69n/15TG9bbE33+9DEQZq2i1wj2S8FNjvuY
 3t4bnK2dBKWTcdFTeJBNZmTIV+nk7ErF9erFMLoDL7T+zYoMev3pCW1M+g2stcsNiQ4V
 3+jDTC4RoSUfcBgbAI1JbmzZ836onINgFzMs4nDkae7DPK8S0ow+39gpsHkw0lFGriaY
 I2m5c/SATVSaWx0OXUrhHa8Yi6FYkAzLaQTCuKvY3nSivJgTFQe70HWe2mhvdomsX8aa
 AfXEdSdpfdvVlOkzrealHo1gRxjSxT6lcVlKTSI8Zdf2F042OXwLDqbHmXZMyLJJ+/+m
 F5Zw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1779372791; x=1779977591;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=REP4STaURwNBwYLUxnT2eThrBHI2vGspRNmg6btJygo=;
 b=B0KS206SJCDMlPBj3enN0FsCW+bO+4qoyBjEbW/roKfA8sJwk/nfyATTMyS+9k1Bsc
 F+j7F9k2ubY32CFqKo+cXnsazki1e1I0ster1uIDj8Kyy4sHYuZuBlDMrUX6BCpQIuSW
 Pgb5txZ6LQ53Be20KEG+ZVZN8Uf6ptBqiZqDxwOGJcu8JMOHGhkvpqFT/FA2jmj0+IHM
 OYywnIpcZYYvDnk7z367KV+anBeBUnuGIVtvFj/8dUDCFqBEwaqhHo1JrWYKDpECAt0K
 z14Hb9qOlw8IkC1saAzEr01e/V8QRYPio5xwP/XNk6oko3d7OY1/B5Baj6BS6QwTnLLk
 6zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779372791; x=1779977591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REP4STaURwNBwYLUxnT2eThrBHI2vGspRNmg6btJygo=;
 b=dGLssJ0YAz/jqCQQlJnz0JIzV26HhDDSli/aarIBShZ9NVwEKRMAIxqwqSdSOpFmwh
 GOasCV8yTGlBzwq5ta8NuiIEctQxzkQTeVoCdR7/1AKD/rfqhwO8cT9Bu5ivvJ9hkhLY
 okTyErlLk+apYTZx74RaXFa/oPZAe0cxPP4xGu2BXx26THtaSqnFat0ksqgvnbRCvD9t
 aA6scwvhMg/WV6IiroaAx/l5WTOVVl6tqZuNx0TKCiwXSnR+YK3i9hJv+dbil4j1w6dX
 5SjRNq2SSFcZWaxU0c2xuKv/oBB6X5LoRMcqhgL9ZMjd1LmtCk2cIdZwwQpiL6b0g9Zs
 1+tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/eNpq4dkwU7co3tqHIrteiQ6f6wuPSXGsvexQLaBpMe0NuVYn0HpTUVaKLiKvkoinqeRXyZZvPS0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySY9v0Iikw73Pu0woVYeaZUpUZPVS74COIskVCsG01iHywt1Ri
 cw/cl+YC17FHdhFpoq1VHtN8BDhKsk0KjMpDK+VkQ6zKM8gZFmo8JMqz3shIUC0Eub805fO6/L7
 NBGWIu8UrQjjk3cG7IN0AYrpEoAxtXMgen+rp3Cv2zQ==
X-Gm-Gg: Acq92OEBJaktlAdGnSLgumUSisLW4RyetufhOhPi8ppFyU9DAVCFw/R4szd28HSJWXK
 HdOqsqKOoGxbopkD7jQJkdnODoljZnSQvmvsLT4AadXCNmPkfHS2czfi142hxrDbbUzPxro57vh
 UfJYpWbgomh3NCrbaJOMHU+OyNRRdbkAbZeKzDHHquniut2dsF7ndtY420XXX1lWxYRN5ckckEO
 e0UVzTwSgYatZH0OdCTzzQImwTwWXoPRVPVSHD20rzAm3D5HjBXhRxfJL3ZWKwW2QzxhU84ehL+
 h8z29VhAoo1aJWBPlzvudM8cMeHo0v/Vf0tygRc=
X-Received: by 2002:a05:6a00:170c:b0:83f:2568:d45f with SMTP id
 d2e1a72fcca58-8414ae0067emr3410992b3a.23.1779372790773; Thu, 21 May 2026
 07:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
 <20260423-color-format-v14-3-449a419ccbd4@collabora.com>
In-Reply-To: <20260423-color-format-v14-3-449a419ccbd4@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 21 May 2026 15:12:59 +0100
X-Gm-Features: AVHnY4IhuE52xfR4O7ZsBvGU9UxEW_nGPaKeUuOJKbLW6yd-ftNZQIcte9EpFTU
Message-ID: <CAPj87rOgkSAhVzzHyuKEGPxVYeDhJKLGVNrBA2BkG00gvMJjYQ@mail.gmail.com>
Subject: Re: [PATCH v14 03/28] drm: Add new general DRM property "color format"
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel@collabora.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 wayland-devel@lists.freedesktop.org, Werner Sembach <wse@tuxedocomputers.com>, 
 Andri Yngvason <andri@yngvason.is>, Marius Vlad <marius.vlad@collabora.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Thu, 23 Apr 2026 at 20:04, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> +       } else if (property == connector->color_format_property) {
> +               if (val > INT_MAX || !drm_connector_color_format_valid(val)) {
> +                       drm_dbg_atomic(connector->dev,
> +                                      "[CONNECTOR:%d:%s] unknown color format %llu\n",
> +                                      connector->base.id, connector->name, val);
> +                       return -EINVAL;
> +               }

Shouldn't this already be ensured by drm_property_change_valid_get()?

Cheers,
Daniel
