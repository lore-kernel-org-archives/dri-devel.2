Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61738CD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B372F10ECEF;
	Sat, 13 Jun 2026 07:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+AWlFRy";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D40E710ECEF
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 07:50:43 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-491609cdd8fso7844205e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781337042; x=1781941842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mlm0YHGLM0VfFF/fXJEvgkWs1yTQHLEduURYTbkabJ8=;
 b=c+AWlFRy0Lwd7n8x+zu6vktcYi+W3ztRzBYPPf3h66cegnWtWuwh2B8VYjNPFqw25p
 opYC9Y0E8xTavBvRZB6kybj9PTvq+3SHxZgQ6mfFX23lYsM/TihEDIcf/kfjzYQtie4M
 bmF5y2nVLzMBC4AqvRa/V1jjozNFjrgjMJryIGJU9st/Hl6u4c2nNCl+n5mCrbexGXmk
 dK9chrEQ1mZW+865x1h1edRp4yjSBzo7luT2M1sUFVWDpjHQxLiGUYZfCHNYd2UhxOQD
 natVIHcGD57rSxOeKMQxOw4tE4oHnYSyleCjmOpf9gVfwPIB+TFg7AzDoLeaDp0HsTRK
 WGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781337042; x=1781941842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mlm0YHGLM0VfFF/fXJEvgkWs1yTQHLEduURYTbkabJ8=;
 b=a6NSg4ck9/SKv6xo+R9IsfrqYezxk97VEFwxummvGlUhlsgeIPU9yWGggi1+HjmFPz
 ErfE2JLh9T9Vij6eAwHf+tfy0y5kuakO8ZSBvhk5tbBIoH04jw/7dur3osi96JBBGX27
 HI78CHykczEwvn7kVV1gkekR+Rmq3NavhUlB/aFATjsYDYQT3JFb60cXAoErVtIghyiS
 Jna6okkG+n0qxB2oQwnvOPgn+fZ0xbPjOEmYvzlgmNhqhDiYumeIoJ6ydyX8AX0NY7h4
 b9/R3+3KNMtSBIFIIcWctqt3xrL8/VMXkPcP3tU5X5aIYrm+fsGqcXcwOAnYcJpHTHwQ
 122A==
X-Gm-Message-State: AOJu0YxfpGo3kqIRiT0E74NkYKzDLbhxu7wPaLDHOE2M3txrW0DWcSow
 rgywL5u6W4/lM2jaNkHEXuxt5rwpwWWJDjCeqe+ECaLAwN2Ns4mDGm4V
X-Gm-Gg: Acq92OFr/0LqfTva7DnsjdGEndHnHoD+IfmA3KvnQ3ClzaBQHZ3yd2yr1wKKhsHNOX3
 bHVDPlTOMSbixHHu459CqJqKYcCPRmKK2wa3KLW1/Sy17U9zNmjIoJxdrOgLnKntTU8+bvfRxQk
 6XU+dE57B6fViIFB7XMjkuk6R+pgU/Mm0fhryCXWEt0YDyGEk+uxvFkYeEa7GNNOOA5m6NRn4Wg
 Me2cKgaAGaJ7+/q9cv0ipBnZkFdFMD1Wu4DGFCdFz5WG9hT4vvde0EcQYE+BUD8x4zNK2my8U9Q
 6LRq49vpCen6Oozm3zcxeyjLJK+QD7owbOYMnZdZQ5pdFTW+Qc1tGgvwtruX+WhLr4OggrqPNhK
 BZZCWUsGtA+ktOvsHwz/uLzIJR7vfMPVv3CQhYPdVltrdZz/p/LEBBod76HUaEvmC2DNFg22bur
 8u8f8GjbwBRLC6OwmtlUfO64MyfAM+5J2DuZ2cY7H66tz9
X-Received: by 2002:a05:600c:820c:b0:490:5cd8:d213 with SMTP id
 5b1f17b1804b1-490ec4d3407mr76769065e9.15.1781337042183; 
 Sat, 13 Jun 2026 00:50:42 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm145232805e9.0.2026.06.13.00.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 00:50:41 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 Wentao Liang <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: fix refcount leak in sun4i_backend_init_sat()
Date: Sat, 13 Jun 2026 09:50:40 +0200
Message-ID: <p7BkDUOlT8udh62CkXD6NA@gmail.com>
In-Reply-To: <20260607030950.83636-1-vulab@iscas.ac.cn>
References: <20260607030950.83636-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 7. junij 2026 ob 05:09:50 Srednjeevropski poletni =C4=8Das je =
Wentao Liang napisal(a):
> When sun4i_backend_init_sat() calls reset_control_deassert() it
> increments the deassert_count of the reset controller, and must
> pair that with a reset_control_assert() call to decrement it.
> In the error path where clk_prepare_enable() fails, the function
> returns immediately without calling reset_control_assert(), leaking
> the reference count.  Other error paths, like the devm_clk_get()
> failure, correctly jump to the err_assert_reset label which performs
> the missing assert.
>=20
> Fix the leak by using the existing err_assert_reset label in the
> clk_prepare_enable error path instead of returning directly.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 440d2c7b127a ("drm/sun4i: backend: Handle the SAT")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



