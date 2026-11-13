Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF1606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rcVejacT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B57610F004;
	Sat, 14 Nov 2026 16:24:54 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF53D10ECAE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:24:59 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3ae3b5b1027so246301fa.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:24:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794601498; cv=none;
 d=google.com; s=arc-20260327;
 b=cj4xgOV/fIU84PzO0/bMOmNfi/X0iB65lZzqHH7/Gig7J8EfNJacJwr/vjGMiTSPvH
 8gI4nKGutLGYMZucKU9queXeJ6GVH60K9s2K95b7jPZknVYAy6gEL1gxSvK6BUtT4mmY
 ayYA0v6WtohcQXE11cW7+38KP6APJk6FDdkoACwasa7nfN1eJ6CvxuOkOQEBnlQMGR5c
 rlyMg6YRzOUtyHBbZwYAPc6K+7AEaOG5rxdYHtLL79ziUbpArUSiDe+RUPoExAuhqd/P
 jkDsh2Sbolq1RZolMUsvMRqGqticQzLUIU5QdvADhvSr+BQZ/kJXfDivuR7lhxXeQyd0
 OQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WU1bfrRJnySLXBq2fMTwUjF2uo3KDqqVLdyu6MbMrY4=;
 fh=zoxaxzIOT6ltR0HcNmpfJfcJIJbGwuH0NETdoyup5Eg=;
 b=UA/yHyMgal9DptebvTzzg9x2wQ5gOZVAe35xWCAs8upEZoIYYDspUhsZv5X9770ERj
 wr70KaP+E/fDeUsR/UrdxhEi0iyLdwANzfCiY5wwqWEZLOZSshSi5dbVUF6lGE7VACxQ
 u2y29YGTL7nGYV4TWQJSdhUrxOwJnt5ZfIB7TAG8yKFw/AdX7i+6PI3YeDa/uyOPHPq0
 3F5NZOIj7VoEQaA31vn9cG/t5Y1zWc/hdP3c+EL9FrLRMQW77nSURfYCabnI76C8JxD3
 oaT3WNYzdoWuVbLCYEIQXb4Xfr0ZB5IhNcrV7Mr6avR43omCiD2F2yfDnxVyA90tl1q/
 nYQQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601498; x=1795206298; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WU1bfrRJnySLXBq2fMTwUjF2uo3KDqqVLdyu6MbMrY4=;
 b=rcVejacT1GsjWiSuAMW+oVwjUTSl2Yeb6pOYzp6k+RjJKd+RIu2HxEujC/Zi1htYss
 CMWPWOGw2NI75P30prJ3OnqLZ+Hcfvq8zbRz/4sgY/dC1khkTXuYy48ZrBV8oso7yu4k
 Pkm8Sgvml+djH0borySyM83qzLfk+QcEzwEoSb7jepBe4L6P1YSFMvbdY0ApxJEl9J5j
 5fi4GpDY1lYswqNE74DOpcp4jWjhZf8KUUdOj7h1AigOezUDbxuk3BBRRQOQDaVBvxft
 nKzOBn0OnABpWOjg5dGhGrRAeBt/6GX3NcVT/CK0ybFjjRWCjc+W8Jp8WjI9jBlDrib/
 2f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601498; x=1795206298;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WU1bfrRJnySLXBq2fMTwUjF2uo3KDqqVLdyu6MbMrY4=;
 b=atMVolvwxNu9WFZGHxlAyu9P83hHExd0mqwsuvv1IF4CjuY9b95DMNG25altIK8qfT
 oMCr3tezq+UNGOcYHArzH3XxGtld6XEdVFvkqRfwjRb8nwiQTaPBVzR2K9Q2rhMPq1CX
 q8AinDAYznP2vL9kbk5llEQhmoxpOjgGQ5vxaO4Qd9n3zzLmgRP6LWX8GovHOHdVRmls
 4T2BYxSF0IID01ENBIMPI1DA2w0OvEwsAFe5XXWH3DTOmgAK463pprJ4WeXFJ8IKz1h9
 Vj5rR02CH7aFupvmaRrTCxrvcd6MLSR6mN3M3CAOa3C+eFj8g+RhsYUVycQ7BvXZn0Zk
 y1fA==
X-Forwarded-Encrypted: i=1;
 AL+hErF1UZ/2csi+Ep7mjM+WAIWsJlGwjdiN/EUBriHXP2EMvHB/thuSzGJOBuqk9d1rNVX4rdtO4q0Panw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+qppL4AJUPLJL45x+z4e5DtHepRyJHaHrF2aKTcU+gL8RbqZcE
 tPAWVquHIX8+uoFVDrcs75dro+USHrd3UrTCesWvrPzL1R8xaWowukESW5eDnDiGBgu9xLk7GeU
 Bif9oIbl06JD2c5i6YL48mK8YwbuVWEw=
X-Gm-Gg: AYBFou3BaIlMQPkYnaHD87oAQjkcjpI1Z5eG9HNGlFSSNHKsqMZeuEoJ0i23ks3UL+z
 qVCKNT5VeUx5UnKda/+HkdmGBBh9DhtkKp92mtamhkOgtqdIsdJPYOc0tqX3fNtD1xrPHs+buGO
 ctzp/5M3mHioVmlwsV+OlRtAqOzWyZnVaGtVlR6fAIzIPL143tM+HBlBhCoUIm63OcMMYKcu992
 f9yVEEQ6JQLQ1lM73Kp9RG1D76jy8tGJYK1XSUPBMUnXA2FrOGUzfQvgFuamVT00yZz4jW+W3RR
 TU/yS+ZaDTg3dTHEMqoJ0P5P+0RTRmthkgOc/naUoEronfR8iC0lsSEyieVJ03GetPtrSa8HFNl
 1Xh3/tZlL6dvPffYFSVuy4zdUOy6Q11n4tW+NmTePAIiLLhmvR67jcx5nGFWBs2JYWiOG09A=
X-Received: by 2002:ac2:4bd3:0:b0:5bf:f87e:3d25 with SMTP id
 2adb3069b0e04-5c17075fbeemr1839415e87.2.1794601497810; Fri, 13 Nov 2026
 12:24:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
 <20261112-vop2-fixes-v2-3-8218c1cf8ac8@gmail.com>
 <a5b52d95-7fa2-4148-aa02-cfee6f195e1a@rock-chips.com>
In-Reply-To: <a5b52d95-7fa2-4148-aa02-cfee6f195e1a@rock-chips.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Fri, 13 Nov 2026 12:24:46 -0800
X-Gm-Features: AclHuK9InRTgWzumTIOYOi5MivIL20TRnUBG8RNDv3yJlv7_a6OpEdGqBKKf5lU
Message-ID: <CAEy9hNVKy6sTA70B8kfhP7eBFCUFobFn4SvXUGMxzCs-bpXW0A@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] drm/rockchip: vop2: Fix the HDMI sync polarity on
 RK3588
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, cristian.ciocaltea@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Damon, Chaoyi,

The TRM names GRF_VO1_CON0 bit 5 the HDMI0 vsync polarity and bit 6
hsync (7 and 8 for HDMI1); the driver, like the vendor kernel, uses
them the other way round.

The HDMI controller agrees with the TRM. With patch 3 and 1920x1080@144
+HSync -VSync the driver sets bit 6, and VIDEO_INTERFACE_STATUS0 reports
-HSync +VSync; with 1600x1280@60 -HSync +VSync it sets bit 5 and the
controller sees +HSync -VSync.

v3 keeps patch 3 as you reviewed it and adds patch 4, which swaps the
two bits; with it the controller reports both modes as set. Please
shout if the TRM is wrong here.

v3 4/8: https://lore.kernel.org/r/20261113-vop2-fixes-v3-4-08ae37e83b5c@gmail.com

Best regards,
Arun
