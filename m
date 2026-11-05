Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D4606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=Z6peKvgp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DC01123B1;
	Thu,  5 Nov 2026 12:25:41 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B08A1123B1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 12:25:35 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3adc4590de4so1582627a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 04:25:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793881535; cv=none;
 d=google.com; s=arc-20260327;
 b=Qn+v8WTPA6dfdJUyiFWvZLCBnlmrKp5dWnoDC/Ax58sWMlAxFz/qGPqkL++nQ4FyKa
 u9B6ltNP9R3Dc5jmoHoFgJyc+x9u3YlKajgmHlRJIxFx8JAK5UWft0Hg0KQCenzQICFP
 Zfzkm0E0CvFVn0Y4bQFwq67H71Txm61OxOKhh3narzWipGuEjMcwcVNBLhGB1kY953KQ
 kt3si9pLL0sKsgFgepr5VQv+ti0x+//9kBSdzer65ZerS17TZRdZECWX8hLcE4XaZ6Jn
 /urNRiVhGmfm7Nh7oaiSfjxqlHQDc/3FMZrF7DgJBNLbjcDl3ckjWetbKe4rzAbslpuJ
 D40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZvGn0TWxKmoxK6KM44Y6QgeDgPYc9rdxIcbth936aAY=;
 fh=iwQJZK3WtvcUCQEph1hYvDRQZr2gyRuT0kULK7wTpfg=;
 b=F2cKW89bAecIUTqlU20MaGVs+kZjBGNia95LLYDk1OQ50Dv7Bz02WwD7QtZD3i5+Ko
 wNCY74vlcwBf1ewRklfmbNlxgnpd+Iv/BmQMaEnAWVMJ6nkv8s8lxM52NbeuIUFpLd5h
 Pjt8RJeYUbWbrFxao5sEFqpM+EU4r9c5n7Y4jHdxzHJJ3nk9yjZ44XqF2ZZ7XQiGQiMX
 zM6gOgakzGkIZDKv46xyuPHuSY/emb/Ykcj7+p1DR0wTtnbVvV+WC1Kt6W5MmSMSy5oZ
 4FtvXK2+qGqutzEGTtvzr+3ft9RvlOZlDiByqQyEvPWDXYUeBA3LPlvPwIAomVllO20a
 jA3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793881535; x=1794486335;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZvGn0TWxKmoxK6KM44Y6QgeDgPYc9rdxIcbth936aAY=;
 b=Z6peKvgpEkJJrDNMn/JlMy+etj4ef6GfB0Vk+5sZq9dCCMvffZ9WlWi7Egg5uSccIu
 67fkR0dXE92P28V9W09HS8Hm3g5W+Ui6Oa7PCHo/2ExWydYyn61XALA3nwZBfUNJ3RAW
 Qg6inyX4rlW2/3gIT1lQiiGfZsZvEcZrOBl8CHzoZSA313U3mzlwkEu7T/Kd04b4l2Jb
 QDzC/un723GN5RnFu9+bTiD86y7Wk/vO5DLPnFS/77smfxGMwj/fzpIvI1BwVxXG9EC3
 v6UgcRqUYWsFrUna8Nlu77CRCsLlmbXr69EWWw2CHn1q2lL/AlKmzuUZtnLy/epEtNpv
 JLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793881535; x=1794486335;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZvGn0TWxKmoxK6KM44Y6QgeDgPYc9rdxIcbth936aAY=;
 b=xKsrSCrlO+3yaWycECTCT/zPnA2DEKh2ebfPqd6bdQDF6b8nViN6lMIJqrIk7QlBvb
 8klWg6XxSDWqm4TBsZPiaXpIQzItbIu7uKrz03Px5mWzfOiz9Yz2jVyWWoQqz5f63q7R
 uWTjzEjz6/yK6gLWp/2JCMf4EOGq7hCqayL81hnio1NRpnyCSjlSos2IUE5ci4VMB70i
 Kg19PFr3IcMGsJ/ExHuNoOaKxHg5oJIqSRc0Y5uawHwgIu6zq9xXXnyfToE/T05rSCfl
 gWUURrGU3D82apg/AnxomE1XszZLeR+SOVXnraO5XcU+zyFlTej+lXPNc6Je/zIRTAxM
 FKUg==
X-Forwarded-Encrypted: i=1;
 AKwUvByIeKDSP1BLRvTn8rrKdlERiyCiBZJz9BMYiFIX5qF9M3LIw2snIuMSq0rQ1l6549sfedp6tQmIuhE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9piSuT2s3215LfZkROADj/CEELYEi5N/S/Gx4jOFo70aftJ2Vc
 bqhKnipgUAYmNwNP9+krz4ZbaH6uc0cl2mb7yzKxcnRaimt8NuPAaE5mrg8PddF+cVO0AKK6sGx
 xeH4ciYmOo1m/bgp3kVYvO+jG7EP8Bt0Eqim8+2k61Q==
X-Gm-Gg: AYBFou2XqTyKGYMt/ZyaO3C00ocdLiV4dmqw16AGUX2pyFWrLf97FbWGPhYKKCwnesH
 JISsumE8bgasPJpIsdVbSD3/W9q4VJ3wxvN6QN1effqFl8mNCae5M+gV7rFRhMc9ITMxHqKyfm3
 V4ksKX0WQyr11o9NU/Vfg+hqiJv28Bb1n4DGmo4ZMpowzD2J3F3pjMQULdM2/C1X5AN8uuxEf3r
 6Jqoh6zD0YjXvMNBYw638waciewHh1klrBfa0LHCRUy2+dO8RTX5BEbsQfnK9pMt7lfA+pnp8nt
 8jk0fArbamxSd0ZgAceXz4EDQly6bmiSha9PDklOgvVaKiUocHk7ZN4OufhcqRWrcV1kYFnq2sK
 lTcef8IxMRQn5IPWZ+TN+uVLNnogBuJJ9Zpb9
X-Received: by 2002:a17:90b:180d:b0:3ab:2d46:1dd2 with SMTP id
 98e67ed59e1d1-3ae895a5c46mr17306949a91.6.1793881534904; Thu, 05 Nov 2026
 04:25:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 12:25:23 +0000
X-Gm-Features: AclHuK94D60Hc87aFX4xe_hS9QfUHnTA410grumPTEjY5dxN4dgYm-_Kh7IGrsk
Message-ID: <CAPj87rMQdE3eeUxGSb4oQfB4Adry6UV8CvhGoTKtdKGQHdSo4Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] Support 10-bit YUV422 and 8/10-bit YUV420 color
 format on DW HDMI QP
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
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
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

Hi Cristi,

On Thu, 5 Nov 2026 at 01:01, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> Changes in v6:
> - Added new vop2 patch "Disable core clocks before dropping runtime PM
>   reference" (Sashiko)
>
> Changes in v5:
> - Added new patch "drm/rockchip: dw_hdmi_qp: Do not mask error code in
>   atomic_check()" to fix a pre-existing issue reported by Sashiko
>
> Changes in v3:
> - Updated patch 3 to skip any hardware programming in the callbacks
>   gated by drm_atomic_helper_commit_planes() after powering down VOP2 on
>   an atomic_enable() error (Sashiko)
> - Ensured VBLANK events are sent immediately when atomic_enable() fails,
>   hence preventing userspace processes waiting for the page flip
>   completion to hang indefinitely (new patch 4, Sashiko)
>
> Changes in v2:
> - Addressed several issues reported by Sashiko
>   * Reset AXI before detaching the IOMMU domain, to close a theoretical
>     window where stale or in-flight DMA transactions could fault or
>     access memory untranslated after the domain is detached (patch 6)
>   * Fixed resource leak on vop2_enable() error path (new patch 2)
>   * Balance state on atomic_enable error paths (new patch 3)
>   * Avoided division by zero when computing max_dclk (new path 4)
>   * Fixed VOP2_MAX_DCLK_RATE overflow on 32-bit (new patch 5)

I think everything in here should now be solidly reviewed. But if this
series keeps on collecting unrelated patches until Sashiko decides all
of VOP2 is bug-free, we will never get this series merged. Could we
please keep this series focused on the useful bits at the end, and not
keep on adding speculative new Sashiko-pleasing as artificial
dependencies?

Cheers,
Daniel
