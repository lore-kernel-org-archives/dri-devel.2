Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1821606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=fXtpZRrU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D11D10F665;
	Tue, 24 Nov 2026 14:30:48 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169D110F665
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:30:42 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8b9c51097e2so1668994b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:30:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795530641; cv=none;
 d=google.com; s=arc-20260327;
 b=c8XeKdNdhv7J85kMUN80I1P7dnBxAc5HxJhlmGejc+yqazKCvf23QY8+fsQ4S4vGbJ
 JkSHhFTsoZAtLVZELgleusQrAlDP55WweJWShp13IXizwziVr14Hy2iRgVSsqlm90+nl
 L+X71H0JEfEWE8WTlTAabmmzKuHDqhGU+7xWaZBjjQF4TQi+SAtFzTXaKE98GL3l0jP0
 /jQuIWmIZtJL45wmwEvg1VOGO2omTonLmJNAJvACjC+uaFSqahFbUzlEirrSFAElJfYj
 kIs8IfoGxIBNRM1pUgbkSdlmWw9nS1AZp5dThK8U0QungkMOUKwksLWVS28M8mzDuTxk
 u/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kFSlcrGHGfKA+EfrnFhI9X/nm4JGlc6mNtmuQxk7pQQ=;
 fh=AjifZRa91q8HNlFNWeNsLSfA2auETXzaDHpZy71YNd8=;
 b=ewB0tXFX4OMjRdwRG/ZfG3wNnRcb9aX8ljEXgZ5zY6sgAh8JrLlC2xEOjr0M40eTgv
 iYuXpMR7ju1khzNzPMmnhGMo4uyiALW7Q+rIfpeFEe1OmfbfA7a8+9ZNajd7sn6s8fPt
 GGDGzMhaeJB3hsqMNaJQepyrlnaaWoYqwJU8HsjDdfqFUB1Lf3ZqgmYH+i5J1Dga6u2X
 QwHoIGh3Umn0LV9AMUGQXdzln5bHtYxrjPPOK5dAHxNJD0vdPjmtP758fEZsIu7ke/Fg
 CL0zEbbbnzlBBGbvrWTPxoe62D9lLnY8gCVg99KGt7kP9G2tOQkdRdx/l4P+/9ZSa3Xq
 LTuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1795530641; x=1796135441;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kFSlcrGHGfKA+EfrnFhI9X/nm4JGlc6mNtmuQxk7pQQ=;
 b=fXtpZRrUcHP9kfU0E56joWyHARAInZWygPSy+O1P7hB6FxmqtB6XM6Am8jPB/k9LCw
 3OrgL69Y+rSKZ9hYp3Zi8MtDCzVfIPcdZTE79ZH1bIpnT+dztLrPjAfdi5Bf7NL5rDQk
 LuX3seNBJNYQHoBI2bQa/WD9aqKZ2w6PfgQsj6b6mixGV0KVJg/gFY3Vb4Z/IZSKtepC
 QW61/tTscLMVbg7h7UqttDuLCm0zZRntGmSMTGYMC/PX+KvhcL6iBiWSX4VjQwb5SpwN
 STkCPxrJSBOX8z/IJ0fPJBlMtHPYIfpp5uKUbI2BYahNMg+xW5IOBNFykyhnEOJ5vy40
 7+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795530641; x=1796135441;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kFSlcrGHGfKA+EfrnFhI9X/nm4JGlc6mNtmuQxk7pQQ=;
 b=vFavYn0ZEMtVYacDWsoGgnsg5xmJGovxOTyYsJW8rGBiTrAPPoJuqwddz1yHB0erus
 mU77KhkPbxl6LfqHGI/8XXvjqb7Fj06v5OT9yzGLzlEjeT8uMYIVg0Xy2vJ9unCTyEzZ
 YPpaJaeLOMxp0axhSa7K2A2HV6SoFRrrehhR+ULew3XBIYdm3nalynmoPWF/C1eb5Quz
 LFjztB4a0YK+2eaBE19S2A+ZMy/txD+wmbN6QIZA0NnrvK8jVVfVI55bcBjsT8KG4cEj
 5Z3//08UIHTPWPcKjfTQ4DFf1hIdwjCwIq1ch12f86W8wn62HWKZZueYNL1bHGw6cEv8
 B24g==
X-Forwarded-Encrypted: i=1;
 AL+hErEYm0DIMMWOTCM5NBz8IjNZ642kzN1T5oAF/AgQaJ5QITvXaEOM8VLdIVWcVVhFuqRdilDSEttr6Q4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9zjiUThEbUR/o3KJb4oSqTRG94L4n3M0Ga+NAKjfDO6AtnCy22
 jZ1Jg2dqAr/31Nl4LxL3c3gaKcX3QWWAFEG2zHx8m2QqGb7D2M7dKcAiPXblJuRZ5WmRsrTQO4L
 9s8VKfJQtgARBInvTLf8Nm7te4Pa59Oa7A92ZlTKw2w==
X-Gm-Gg: AZFdTZeFjNhmxmDb5ENdp6w3szCyq5i9+8tvfS9kjMedCyoY+zgckUyR8307vXYsbXZ
 Nhca2vWf0NkbStDITfN6dxuTCPdiW5uE1dhdYmOrl5zx2jPNAzwPZq9zzjKcZXH/R0Z9J7IsXmQ
 VxMLZ7svRWm0GzmPddIlgGqpWtnrlHaiaY8uRmgZl0I+bmHbSTJNrjoFiLaCeMtZZMmIGI5wET1
 pj71/1pZwpHwWpkbj6QPm617fi+KYDP1MjLOqYNd1boryQkXL3EmuX1F/XJ97db3mLE6r44Lxpr
 IT4JEL+FimV/cHsgXs6LoytF+bfYkG59MBJf1r4ZR0yDlyoQ+d5aAaufi9xUHOpR8d4g0k+PWrG
 QOLT6xBdLAtE1HP8t7nuf9w3F2PJ2wjGicg==
X-Received: by 2002:a05:6a20:2589:b0:3f9:797f:3869 with SMTP id
 adf61e73a8af0-4014d359938mr14437260637.47.1795530641542; Tue, 24 Nov 2026
 06:30:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-4-angelogioacchino.delregno@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 24 Nov 2026 14:30:29 +0000
X-Gm-Features: Aa3M54oeKn_H5KtwYJP7Cgtm4lKr9C1ncfB30nHv_jvzqMcIUhZDyb3veHGchVg
Message-ID: <CAPj87rOEtG9JqJsEZkatqrWUkerO9Xx93MBUrXXChJwCokE0Vw@mail.gmail.com>
Subject: Re: [PATCH v2 03/46] drm/mediatek: Export OVL Blend function
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, kernel@collabora.com, 
 Paul-pl Chen <paul-pl.chen@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Angelo,

On Tue, 14 Jul 2026 at 12:44, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> +unsigned int mtk_ovl_get_blend_mode(struct mtk_plane_state *state, unsigned int blend_modes)
> +{
> +       unsigned int blend_mode = DRM_MODE_BLEND_COVERAGE;
> +
> +       /*
> +        * For the platforms where OVL_CON_CLRFMT_MAN is defined in the hardware data sheet
> +        * and supports premultiplied color formats, such as OVL_CON_CLRFMT_PARGB888
> +        * and supports premultiplied color formats, such as OVL_CON_CLRFMT_PARGB8888.
> +        *
> +        * Check blend_modes in the driver data to see if premultiplied mode is supported.
> +        * If not, use coverage mode instead to set it to the supported color formats.
> +        *
> +        * Current DRM assumption is that alpha is default premultiplied, so the bitmask of
> +        * blend_modes must include BIT(DRM_MODE_BLEND_PREMULTI). Otherwise, mtk_plane_init()
> +        * will get an error return from drm_plane_create_blend_mode_property() and
> +        * state->base.pixel_blend_mode should not be used.
> +        */

This hasn't been true since 9813e158d13d. I know this series predates
that, and this is just existing code, but it's another instance of
'lie to userspace and fix stuff up behind its back' which we should
get rid of ASAP please.

Cheers,
Daniel
