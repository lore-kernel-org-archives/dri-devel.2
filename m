Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620D606D81A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=XDQ9prLj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3870B10E938;
	Thu,  5 Nov 2026 12:19:16 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4A41123AC
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 12:19:09 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3b08cf16decso1232397a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 04:19:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793881149; cv=none;
 d=google.com; s=arc-20260327;
 b=kdpeG6EAQ4kV9wM70IFT8VLm5nVUJd4751MDMGlkphBLBe+dgeovGIGGy+aEjWMcBE
 pXMe6JhK999xWSXAqnF4/mKphKEHb9HG1KgfnFWJ5LfJ7VAJMfPpjcMBglaWGxO5b3it
 wOD2O62DP2zzXy8iiMLVtFI9fwH/H6q25bxqDUArYsQiCtiQSbEyqhvI7Idbjsr/oh7V
 MfLCL/rSBhSMqmI+qdFfVhQNT5Yn1iQOzEkBz++ETjB5/5WceMKvKOPnJa1Wgo0o87kv
 smRbFbj8lXHdD0OPuRp81wyVY/j2GKd+OoyrmDN8E20T2AGpvGeDjQVOvF4Fi70W9X4d
 wCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bt4DUf+UH7jk0+BorwFH3uFk7RSEIMOEju+OL5ej03Y=;
 fh=a5dYdHSk+VImBRdrGcxAesftmQI7oJl5z2OQPnD4fcQ=;
 b=S4ZsZI+z00DARgHmyaSKl162U9iyLX0KbA048M2XpRewfgA1Z76049kDzrBZA+5rOH
 JsrHEMYMpqiqlRyAlf7/aOBhAclkeRimBUu0+PRka21IC3AJPguSaywmriGU3Q/4o2MI
 JNuPT5k04cT8idTx2JN0MPFB12wOdJsik2V+KFotDF3l12v6EE8aRoCj5qsEipem04Ti
 P8eq4BL010FCWkOxPqrQvn/sVaJsI7o5bFyIC/NMW1Eo+mNzmbxurXAXg9wg9sK6QFV6
 xfsYwBSWNn/Zx4+l0Lt/JfPlAvkojxxxb+biWZVpBtvZTFHQGWrC5Fs0c47aSdGSn+pC
 AKGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793881149; x=1794485949;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bt4DUf+UH7jk0+BorwFH3uFk7RSEIMOEju+OL5ej03Y=;
 b=XDQ9prLj1n8S40Cnu0+Vg+U4DuOt2+nBtA99QdVf69Zn4Sugllg7f4NtZ7OfYm/uXR
 ALy9elxv5cphRUzaXbwN4sXgOiS0EWEvIKQKykmhMfocjAw90F+z6CMrtlg79Igpi9WZ
 v2jOt9aXLi+zjjJIF1yJCOk3I5bUPt17DEQ6jtIkN/ueM3pLFM2EfZAeSLAPSvjJUvPA
 ZnNpIWBQam7F/LcunrzJgz8ZlNIgGN1sqwOI1vnMZ1MmO8it/H8riS+cdj+xtqcjICiV
 PA6m1304v46rJ/xlqyGNZLIDIaYCEr+EBMditw8zO61dnkH0oFRbDlxFQY5LFrMb7A75
 FYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793881149; x=1794485949;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bt4DUf+UH7jk0+BorwFH3uFk7RSEIMOEju+OL5ej03Y=;
 b=zai1I3caamTGHC0XeqljTDE5rZFY/ehx9pK/d6dNy0hL6z9NWpXFGdy536p125gm+a
 IPWdJMlIbB4c5H6ITNUu99BCCvelkdkIemZzQM5BP8BkJlGqSNgQ0yXDilHmuGivIsQe
 s5a1ztNEHYieZ0rUO1VyhR9OpK9pm4UPDcA5xn/8VQwxmbUdoC+9jR0IveXCOhsAcW5d
 9xyRRlcElSXdvuB3qNDuRo98m3pq98+JlvK0AF1WBo6f7tP/kYaU3vpyPYrUaexXxdh6
 kgZrhf/6uTZMTXAQ+bREuBRv6Drpg2MShdOcgCc/tcOHpnPjsWZSA1sVpik0piNcf777
 k8Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVrkPIFE+DvgpZ5XAAu8zLQhiyLu+g5aXX5NPgCgl61aUegpF2gdkYvAD8DMswsBf+A1wzrKnfMmk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/fLoqRosrFLAq3yOHZbF+cudrFHzbxMHPvO2lnAjQ20SKjpyiA
 tENVnDTap+07tvvDxWDG1hR9W4ejGLUBARGp+GnLRRqdhDKmvB9Nak59Zak8I/pHDC2K2XwLyUr
 3ntHJzcGUDm9TrroOJV0RfHS5lg80cBa3zYjAR6bLjw==
X-Gm-Gg: AYBFou3lfZrtuyx6dIdEFv6Quu4rDqVKfyIgdCzT54Yyn1P/F94D9xcjgA+YFUvzAxe
 4RdaQ4Id6d1AIfO71TMWAosDtIPIc8JR2k8oBcDww2z0LW1MlVgyCZ3WwdfWTj3Im8q+km/ce4T
 j3mN6uNY0SI4qPy+JSau88+YaWxCXHtT6K7j1Jmjt0q46vtiJoJYhJwrxYBONgklv5v0vzcDo0A
 u8oXnTdlDQ7quVprljUWtAg6OR54jWwmz8NNmI4Qyi0wV5ZfRGZ0MRXJKS0mdkjZFY65T1j8PjV
 +h9wWWMJdfrgjyVB5H9XeXpSx02tcjR3kEIOmPzIe0GSMvN6alUbdpms301H+LxPuBvOi+rtDvB
 No0x2sVC7AGQ7ILckEUNQeRjqEubDCSiLoxua
X-Received: by 2002:a17:90b:2741:b0:3a0:e4ce:31fd with SMTP id
 98e67ed59e1d1-3ae896f8304mr16451431a91.10.1793881149147; Thu, 05 Nov 2026
 04:19:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-8-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-8-1bb63ef5766e@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 12:18:57 +0000
X-Gm-Features: AclHuK_2VZ_bwNEEFECKGIAUHsyDmb8_QQvXN9pJrwLdMDPCY5CttgkKVemI1Rw
Message-ID: <CAPj87rPk=girxTziKY5ROV3ZYqGhKRz471BLWpkCjtvNNseuog@mail.gmail.com>
Subject: Re: [PATCH v6 08/15] drm/rockchip: vop2: Consolidate HDMI PHY PLL
 clock parent switch
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
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

Hi,

On Thu, 5 Nov 2026 at 01:01, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> +               if (pll_hdmiphy) {
> +                       ret = clk_set_parent(vp->dclk, pll_hdmiphy);
> +                       if (ret < 0)
> +                               drm_warn(vop2->drm,
> +                                        "Failed to switch DCLK to HDMI PHY PLL: %d\n",
> +                                        ret);
> +               }

I'm confused ... if we have switched to the PHY for dclk, then a mode
switch wants us to come back to the CRU source, don't we need to
reparent to dclk_src?

Cheers,
Daniel
