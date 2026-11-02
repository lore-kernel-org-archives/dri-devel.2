Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E6E60A3808
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wZRsj34w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBADD10EE75;
	Mon,  2 Nov 2026 13:40:59 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE00710EE53
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:50 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so20161205e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626849; x=1794231649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EEkPJ5sYCs2riG84XpmGHlS11U398nauVojefjsmFUk=;
 b=wZRsj34wC8KIhYsWPOJ5D012ObPZSfZ7qwe3s8bGWCujvMj+0aFfEVx95PRJMTy9+t
 IMeAfJBEfsG/gLIfjzX6oTEU51GPj7ArzD9wKOFLSZFUaG/FNxTAgmCwEoTWminMjJa7
 nwv66Nt5+ywooGb29hFcIqQLVFEgk3C/eicj8lZpNFuwUVVwaFwUP+zSBnwRHpqVRgfw
 J6Wt8pP8WR88AfC8zKJsRRHbyy2cunvWO3AeiTdltlJAjzHoVdrkkwEEgG0X7ofvgga6
 4pRpxhamAy/UszRVdUy9aACZoP+ljOaHaS+/PlcNNu2YzeGrgppzo0ADsW8q/sxmszfI
 sDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626849; x=1794231649;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EEkPJ5sYCs2riG84XpmGHlS11U398nauVojefjsmFUk=;
 b=rkb7J2OwGHGuJL22ITw4/Ti3GGlE6q31ZGxcEeZfOvas1Omxz8hkNtP2Teo4hhxccw
 LHBbqjtd8nurQ2Xri2YuGDECJWx1JPsaR1Pf8OqbM7Z8Ww/kCi03zGnttVzD54drxUcY
 KITYX5qFD4EPh5y3fd0Hm77Fwr827Lars4GLtVr5q613umIfs3TixC9rLXqQTiMNho7Q
 2THePld4UQn3ImfwfK3S3W08MRE2e2P4wZyRNXA47/jCGnlikn5+GV9Midzfiq/uM9RI
 Vlej8Mos6xODsREWY5C+s7OS3D48mA3nxIDJ2kAqz+JlsRbbW3HtbaU1t5tpiqnFpGNz
 5q6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8twxDajsCuUeqy92zM+54JEl/YZaTgS3JjcfVk71cKS9OrAJ4aIqMJNNOWPPCTRmizT6YhXosL9M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJVWKjAdEuZhqJ0aTcJ/Xi5aoeE5GKH4KN3J1IuD2o0zK6PHAqk
 SRaYSkYcnNWRz6gmfac7E8yoqfJAZXR1e2H5BZUjl2mPJn5hrNCU1RQ7JB/04mP4zeo=
X-Gm-Gg: AYBFou1AEsNsB5Cv5LrRViB7S0UIVedqk1p+HxoOcgkZg3dSlmT0rLOlSzMyNJ6Kd7h
 2Mt49XY2LPuLVEwNM8557cokXGTi9cCV9FTqLrjqSA4ALipPxBqyy0yBMIVtDgqWjpGebRAgqXN
 6y/QDlcmI5jY2WeXWcuVLs0XddMpg68KFsh/5+ddMPC3ynvbCeh2TylsvfBgivzMPL8HeZrgUdH
 M+eSgWuC4WWE7fhjDOw+/mOxiaIGxQQc2zG2wcsNVJV++ra8TPTB40XhhpnS+mOp41vw15yleLq
 Ia556zUJJr+67FRs74f+jUyibPRHjnhTn2kP9s0ApkHmHeqHtHm+FIJIF2vfh7c4d8z+nV6KAky
 as4H37NyWrlX0VumvrTrKd5Q7aLEonn8Ar2MCgBnTDn+aB0SfichCuCdEKDrkdxgqPZXgyvSNiz
 P9m5Ihq6EwnALQE/lzRgfxviAsmJqwUvpGyrJgpEKD0OYnl/M8GLa6zdhlzonUP7/4vhWSq8msz
 +zZf201ACVse0aKEuh5KsbZ2CHcZtjJ7rhgoOeZCWCdKliXsC1Dh7kOtbmHpzU6OjmCS7GJQj7K
 hBio2lELfalZ0jIyOOw/KUsAyuiCsKodfDG5MThD5y9+0J8eJQ==
X-Received: by 2002:a05:600c:8b55:b0:4a1:ddca:8b66 with SMTP id
 5b1f17b1804b1-4ac19234a06mr223771975e9.31.1793626849036; 
 Mon, 02 Nov 2026 05:40:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:47 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dianders@chromium.org, jesszhan0024@gmail.com, 
 Hsieh Hung-En <hungen3108@gmail.com>
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
In-Reply-To: <20261102043215.990351-1-hungen3108@gmail.com>
References: <20261102043215.990351-1-hungen3108@gmail.com>
Subject: Re: [PATCH v2 0/5] drm/panel: Use mipi_dsi_*_multi() in feiyang
 and rm68200
Message-Id: <179362684683.3310106.2850734684775211382.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:46 +0100
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

On Mon, 02 Nov 2026 12:32:10 +0800, Hsieh Hung-En wrote:
> This series converts the Feiyang FY07024DI26A30-D and Raydium RM68200
> panel drivers to the MIPI DSI multi-context helpers, as suggested in
> Documentation/gpu/todo.rst.
> 
> The first two patches fix pre-existing prepare() error paths that leave
> regulators enabled on failure. The following two patches convert the
> DCS helpers and initialization sequences, with command failures
> propagated through the cleanup paths. The final patch normalizes the
> RM68200 hexadecimal literals.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/5] drm/panel: feiyang-fy07024di26a30d: Fix prepare error cleanup
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/439e9dcfb3ba4980522cbb2c33eff5f9f321db64
[2/5] drm/panel: raydium-rm68200: Fix prepare error cleanup
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a1b23a5bc8567c16552e5e16cb6e9d59c54d262b
[3/5] drm/panel: feiyang-fy07024di26a30d: Use mipi_dsi_*_multi() functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6b84154cdc1a4ebc237b308640d2ecd67aa90cb6
[4/5] drm/panel: raydium-rm68200: Use mipi_dsi_*_multi() functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c8e7ae312688b05836376d11420bcaa4893053e6
[5/5] drm/panel: raydium-rm68200: Use lowercase hex literals
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/57a2f4d7c90ba17a5bb84ce6741927e85896f413

-- 
Neil

