Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A1606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QUH2zkPH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B863D10E596;
	Mon,  9 Nov 2026 11:05:15 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4617010F192
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 11:05:09 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso599345f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794222308; x=1794827108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gruXRLrwC50Q+01zYBAKobujyZnt2WH+acLyGLcBGqA=;
 b=QUH2zkPHctgVSW26yAKi8hMNLrqipjBfHK2Jn3r3/pi6ym7A9j7AQ945dkStNkxTEY
 7uSbN28ZsWFSZo1FwYHvIIDbh9Fmnrrb6sOqWWXasgyBKzP20R7jFFT52Wo6bh9pvKyT
 9EFuSDanevMoYuDXVp59THDbKfucZattykgtfFMf8TndUtU9TVb/a1hJGQw2w7tTlqvm
 K7UKVh24jX4jYetdfQLzGVLTzxFFXn05PINYJuRulUjAEYsTFroYyGXT9OBQItoJRDm8
 F6zGzeZAxrb12AtLXSxl6bqgq2IKzlJCaEj21uLhTNgjkcYZnLBZQPuPPllwDg+Ll7rL
 Kfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794222308; x=1794827108;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gruXRLrwC50Q+01zYBAKobujyZnt2WH+acLyGLcBGqA=;
 b=IQf77golR/EZMgf2jjUBSyq8nnkA2tDos8rQiE77LWMG85UBhvbNHFVkp6nFGP8okB
 Kln3EDDqIrugAqvLUE0jvI1abqOxoABVxN1q1QuBJoZ/LnDIMXw7I/s3zpA/Y1O5tSYC
 oGrx87C5vdJi0hnnyMHCtVqX9mN/894WqGRo0nIb4pSh/qG3vg3qoQuJOaJQjOalZxgt
 M6Q21bFuCxx4vK8c49iesxJTCso3iY6wxiOpoHfVCug64jmtWquF7zbv0UsjJ2PlmjuL
 xH/Z2OVeOArkiALBJn+VY0T0oZG7GYcMIwbJOYK+0GotI99cWcHuTTB6yZr22P896c4H
 KwKg==
X-Gm-Message-State: APuU4Z90DzLr0/1JUAQ7JU7GAkBR2ITJBYCwOMkG3JtMEv+KnIHYiUdA
 YGWP8FM+hzZc8eCi6WmIgPXrO+NxfI86I8U4F6ReMyWMoKAvDO2zpPnkQSCmf7fb6wk=
X-Gm-Gg: AYBFou38yXxp21KmRsd+/zckXplnWLdHE8ROHvWlEiAjGBgNc9x40/qver8PXrCrtS9
 dnMIenE+6433NFgilh+Pm7OpWASLkj31bqF4PUgDAtDLm97+kdEKLH1T5nC9hZM+DXuPu2kw6kV
 GmF76gKfcvyG8pMO62S8V+qOeywtQZ9mjhWoIpPiSfB0ktR9a06e32RZ0KVRZ0lWZqynzc/PGXH
 mO3XDSnd9nXeo3ctnm5utwIEdvIBFfogNDRGkhFqLLus+B63ZE0rMPJ7kbVhA3pZw+FpHl5ZvSg
 QXsjkKDnpal2wltHi6EDm/wXiRMEzc/oN1RgMo+Y+RAcSuFd+3gbYNcrekQQoYW4XNJ4TZ25rrP
 tdUF3EmsL32Xws6AO7HYU6TS6Tn6KJrKkRtfQWZXrHHgA6eRtEBhQ7gl6JRdHbQlsLfnRJjpjQ8
 Ng3wZDkrkpmcZiI7nE2JN+uh2nerE7GObmziuKH+xMpLiYZe+v6p4qM3f3n8PYmRys3TT/ksd5X
 4FpKgo/YcfiWUFdY98UOH6GaZqSHOiaqaa8BpGpn617xYoSWD8LGyIRvi8qh98p+QqUvKYIvWk1
 qKP571XFdCzjwMmMe5Tst7UhpgBwXNezVU+zsuBrfQo=
X-Received: by 2002:a05:6000:2501:b0:48d:f460:2c62 with SMTP id
 ffacd0b85a97d-4958c0beec1mr7604586f8f.33.1794222307486; 
 Mon, 09 Nov 2026 03:05:07 -0800 (PST)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596f9ab09sm8970489f8f.28.2026.11.09.03.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 03:05:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Shigeaki Asai <y-asai.0816@docomonet.jp>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, John Williams <porschemad911@gmail.com>
In-Reply-To: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp>
References: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp>
Subject: Re: [PATCH] drm/meson: encoder_dsi: load ENCL gamma table while
 ENCL is disabled
Message-Id: <179422230388.1497673.3746542387809770384.b4-ty@b4>
Date: Mon, 09 Nov 2026 12:05:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Sun, 04 Oct 2026 23:50:17 +0900, Shigeaki Asai wrote:
> meson_encoder_dsi_atomic_enable() programmed the ENCL gamma LUT right
> after meson_venc_mipi_dsi_mode_set(), i.e. while the ENCL timing
> generator was already running (ENCL_VIDEO_EN=1). Writing the LUT
> during active video stalls the hardware: L_GAMMA_CNTL_PORT
> WR_RDY/ADR_RDY deassert and the ENCL line counter (ENCL_INFO_READ)
> freezes, so every remaining write times out (~8s total at boot) and
> the panel ends up with a corrupted gamma table (wrong colors).
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/meson: encoder_dsi: load ENCL gamma table while ENCL is disabled
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0cb7f6d9e4b1d0a411b628ccf78695ad41c66570

-- 
Neil

