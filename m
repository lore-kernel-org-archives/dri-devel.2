Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A0EFC72AD
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 13:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C162C10E0EE;
	Sun, 22 Mar 2026 13:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sGfYkYhr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A5C10E0EE
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 13:58:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B9F0444EF
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 13:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9B7C2BCC7
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774187885;
 bh=mgyMy2hQLKznZrbyYfmh+EZtwjOUXGpz7osuSEWQEio=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=sGfYkYhrSR/a3HIae86Azb73dfrYupxBwZ9YiGV38yk8JbNelSnNPHP1oGRuaNuG2
 4uutQnvVybt3z+XTRpusu+gKAo5pxPPohTzooquIzASMZbQpX0ZUwWxuJWHlxYyBIm
 HQqnnv+zYoW9E4p4j02CEIdhUXsh2WnQIQB9CiwjVVmckJNemFaPgqLWCEsxG8BMhQ
 3hQaRUoCX5E8u3i+UTXjkqdjB4r+cAL+6mEj/pPNFeEvZr9HUfRBH7HLDlukqewmuB
 nH0QTD0MKNPYwCe3CxuSJPtuEmg879BcT/8CxW3kLuCqEIEZTuBOiiUoFcJ1fC5/bF
 c7D6a+ZC2Mp8Q==
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2c0ea57fea7so3926788eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 06:58:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUXD34CIYYD3vTYNNgSrFqPII3OP2CXKJeq0zGiAQFf0LSvi38Hkx/L7po5LCpQE2+btkH6DVQO0l4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTDUNNpLSJsN9aDNqeeDCM8oe6L3lN5Q2detCKja+WIAXNc6Kf
 4Lkxa7KyNVqy8S4PdHxTTZ6qUcC+I18SZ+LGSF7xU6eEA7UB+e14NWTSiXae0/emcoKJUzTzZxp
 7eulgMRWINxMAQ7Xclg0r3wpIQ4D62g==
X-Received: by 2002:a05:7022:31a:b0:128:d24a:a5ba with SMTP id
 a92af1059eb24-12a726cafe2mr3483365c88.20.1774187884248; Sun, 22 Mar 2026
 06:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260311094929.3393338-1-wenst@chromium.org>
 <20260311094929.3393338-4-wenst@chromium.org>
In-Reply-To: <20260311094929.3393338-4-wenst@chromium.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 22 Mar 2026 13:57:52 +0000
X-Gmail-Original-Message-ID: <CAAOTY_86VxSUmNisk5aiapTNUGFGUu0gHr76E0RKKT0pd1mr-Q@mail.gmail.com>
X-Gm-Features: AaiRm51YKpNxHHSZ_HLZmjHIKksalh8pxeIcHKSYGkrLrVcQdpuypJr4oUdO1Tc
Message-ID: <CAAOTY_86VxSUmNisk5aiapTNUGFGUu0gHr76E0RKKT0pd1mr-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/mediatek: Set dedicated DMA device and drop
 custom GEM callbacks
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-sunxi@lists.linux.dev, 
 Paul Kocialkowski <paulk@sys-base.io>, linux-mediatek@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Chen-Yu Tsai <wenst@chromium.org> =E6=96=BC 2026=E5=B9=B43=E6=9C=8811=E6=97=
=A5=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> In commit 9b54a32c7c6a ("drm/mediatek: mtk_gem: Partial refactor and
> use drm_gem_dma_object") the MediaTek DRM driver was refactored to use
> drm_gem_dma_object, but custom callbacks were still needed to deal with
> using the first device of the pipeline as the DMA device, instead of
> the MMSYS device that the DRM driver binds to.
>
> Turns out there is already partial support for dedicated DMA devices in
> the DRM subsystem for PRIME imports. The preceding patches add support
> for dedicated DMA devices to the GEM DMA helpers.
>
> This allows us to just set the dedicated DMA device for the DRM device,
> and drop all the custom GEM callbacks. Also drop the .dma_dev field
> from the driver private data as it is no longer needed.
>
> There are slight differences in the mmap helper: the VM_DONTDUMP and
> VM_IO flags are no longer set. Both were lifted from drm_gem_mmap_obj().
> VM_IO probably doesn't make sense since the buffer is allocated using
> dma_alloc_attrs().

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Also remove reference to mtk_gem.c from the Makefile
> ---
>
