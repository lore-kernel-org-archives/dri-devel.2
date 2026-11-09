Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A51606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNTYIhWy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF32210F34E;
	Mon,  9 Nov 2026 16:54:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF1F10F434
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 16:54:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8D4A41E7C
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 16:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD571F008A7
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794243249;
 bh=1HDtwLDGfSRrUZ/V7Ccnlt8XRob7ixLwnD6AArPjBEg=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=lNTYIhWyh0pZzKnL2tR9hpeq6ddbd8RQRirnojvBgYsvmM1l1rIJVGWiQamXZNFiX
 2yUV1ul3sJhA0O6Laskk3E2LTKXWvkAPJTRVtRzsBD8WAMOilp2Ocb3C/d6zaof0zw
 oMrHZndlwXz5TDjJqcIJFjuBPqnaqdevqnbvlXXpIZ8lRe7dmUB8FigPn/B/dwPoeT
 FA4X9yTQuDUujEt3e/aV4PeYZj99NJ9+tI/RQr1ducpwBYr76Yv106CRVQnA9PVH6h
 U89Z9FMuU6zAPVmXNCIQ35ki2rCJ/YFR+G5Z5KS3B04GcGfJA7Ir4v6WcqMkCMaIV5
 PEVC2/O7PoZrQ==
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-4b190cdc9feso611273b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 08:54:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErESkDKw7RxR22L09DiiRiIeDKRloC1wflIc2Kq8dQycvSBBhBTyO6ErOBt3tkA/79VfMVmosK7oEkU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+tU+RTv15UG9D5juMlxqXGTQCzOb163OhiqzIECC8BngR31o1O
 7LRDfxrckLsi8rbsxQFIDox04kl7L7dchehu7M8hQyajiFHefcWPr/VMmZWBtfuHL1g14u8nKtM
 86qC0uC7yKk+hg2yV/95wqdgguP2pSX8=
X-Received: by 2002:a05:6808:124d:b0:4cb:f21b:6f8b with SMTP id
 5614622812f47-5683cd808femr133852b6e.30.1794243248824; Mon, 09 Nov 2026
 08:54:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104185659.884455-1-jernej.skrabec@gmail.com>
In-Reply-To: <20261104185659.884455-1-jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 10 Nov 2026 01:53:54 +0900
X-Gmail-Original-Message-ID: <CAGb2v64xKf-w_Zuqqpg3Y=p9PZw+hdtW6hCdsXjR4Gxp_=gWpA@mail.gmail.com>
X-Gm-Features: AclHuK_bYfJMnl5Ic49VL29CSJbv2z-P7IUwDE--H7P2QG7_ODWK-Rv_7ZMYaAc
Message-ID: <CAGb2v64xKf-w_Zuqqpg3Y=p9PZw+hdtW6hCdsXjR4Gxp_=gWpA@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: dw-hdmi: Deinit PHY in bind error path
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Reply-To: wens@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 3:57=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmail=
.com> wrote:
>
> sun8i_hdmi_phy_init() enables the PHY clocks and deasserts the PHY
> reset. When dw_hdmi_bind() fails afterwards, the error path doesn't
> undo that, so the clocks stay enabled and every further bind attempt
> enables them once more.
>
> Call sun8i_hdmi_phy_deinit() in the error path, like unbind does.
>
> Fixes: c64c8e04a12e ("drm/sun4i: dw-hdmi: Fix HDMI PHY clock setup")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
