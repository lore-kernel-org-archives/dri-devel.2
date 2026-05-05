Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACE2CD3436
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336B710EAC1;
	Tue,  5 May 2026 12:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PF+/wRPh";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEB210EAC0
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:51:18 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so35126325e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777985477; x=1778590277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WL6hIXNjqO9eQYOk0bzf3kfNarrgt7tuj4UAONPEut0=;
 b=PF+/wRPhrmWiogX3yqiMZrPBK2AAY/dZKzuCvOZhpftiJbjepjoF4Q7wHeKk2cpOXn
 1mf9y4qs6dallvnv+4dOauR4184UlcAou5OHK2ImMLlfozjo7ah3aLGrMErxs/9H/y13
 DomJt/nZSokdrHmMCmxxiOm6ZV47iVO+Y2IufXmQ3TGzD4SH9YnskSr9MoC+XVlohJGC
 +H6GoTQGp+SCvp149CQu5J9KjbDA8rJ4hypHsHyoIQjweeo3z4uATRCUzOxEOhD5auc4
 i0GGqviL7zmxM0Iquiklvqeq5gYdloHg0fo7VuQnVFPzGtZwRAiYq7fAyIq4XqBNnylY
 6w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985477; x=1778590277;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WL6hIXNjqO9eQYOk0bzf3kfNarrgt7tuj4UAONPEut0=;
 b=BZJJoV2cZxa0zSLUQArFKUrjFxyW9WKEZdH/WuN8rvawDh0SJu27WiO9HD7tCtul5r
 tNuWmlmkaP9FiuoKbnqfU8bTn6R36Gv/I0425g5PdMYPf+3une08UzoQJKtILWu18pSr
 PgvrZUXoJmmHByMYrrKYmvaUGStBnzXbNBbhmDZW5vKyIvj7dYBLg5+FNZ7cMqkzoDBz
 wDMEuw26B9jiY73tcyQhnENdxHoOE316Uc+tuE/ms4kSR8W/xjdWbDrt6RHZL/NnUpXY
 5ySsjDz488cNMJ7QN+5J2ksnITLOpFIbfOi0sOp4qacS708+UPhzA/wFlNhmbARuUgO5
 ib7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SZsufR5vlWWTiMPzHsLVQePRtGWzmlJfnniqYuIfmmw7CQrvumKiU0QEh+EeG/2lc6S6PlOyCPNA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfyztnfzajQTkn9w1HKaaTaBURRYa0WeBG77DCBD/1+HauCLlB
 a2exSHLCDKtFGRqyLJZMkNB+k3NmtQS2vfe0mSqP9mR3h4TkTyC2Vo2GNz68KxDd3kg=
X-Gm-Gg: AeBDievj0/NBuDNU3AfBLk1OQ8eS+q/lWIf0aPEBpyiSPUKOgMmMwLNk1EYBTeZL+2h
 5S+tIrUbEap60mJGMOnpAiWOs8EQn/B5u2G3t5LyRx5BP35gUhbW5NAALIKyZH2KcTwI0siQoeS
 myembCwySkedQkHSZxeW2ACBFYiAdvBBDPn4EAwmPu49hChL+VBHSYpnuPH4HqxyzIiWoOYan6D
 vJPKqujRaIN7d6wTPq2U+bZnBmIa4H5In3jgIA5YNZsgscWImkU45pmAWwcd0nYjDX2OPBR7LPZ
 uMInKOyWaKXSok+1AqBrd7Roz/MzUavH/564C3LACsZyHwSYyZkFc6fe84G2RHaOdbfTf13boAQ
 1yKCw8mD98aTwUEHQyaq8ANyJVpPBQXREAtCMT0ClJgvQxCbCVWmYBj4QufHda/21kclq9kC8V8
 G7mV7QyHE9PoyR6X2sgVU+0MqxovmTznsBH4lILAl4K80hIYJB+ajG750=
X-Received: by 2002:a05:600c:14c2:b0:48a:65ab:8059 with SMTP id
 5b1f17b1804b1-48d142725a6mr41495705e9.13.1777985476983; 
 Tue, 05 May 2026 05:51:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f249bbsm3976785f8f.36.2026.05.05.05.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 05:51:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Pengyu Luo <mitltlatltl@gmail.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, David Heidelberg <david@ixit.cz>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260413071043.3829868-1-arnd@kernel.org>
References: <20260413071043.3829868-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/panel: hx83121a: select DRM_DISPLAY_DSC_HELPER
Message-Id: <177798547605.553197.516489276305082905.b4-ty@b4>
Date: Tue, 05 May 2026 14:51:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Mon, 13 Apr 2026 09:10:19 +0200, Arnd Bergmann wrote:
> Like a number of other panel drivers, this newly merged driver
> needs DRM_DISPLAY_DSC_HELPER to be enabled:
> 
> arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-himax-hx83121a.o: in function `himax_prepare':
> panel-himax-hx83121a.c:(.text+0x1024): undefined reference to `drm_dsc_pps_payload_pack'
> 
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: hx83121a: select DRM_DISPLAY_DSC_HELPER
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/defab7b01e0848e004077d7d8dcc04d305ea1a27

-- 
Neil

