Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044D606A33A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqHVOFQr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25ADC10E538;
	Mon, 23 Nov 2026 16:03:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4E510E7B7
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:03:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC07A42A1B
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F501F000D4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795449794;
 bh=LA9T27Ncxx+yiFs4glj94r98G+0HTVpceCAL9vn3vWw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=iqHVOFQrPft4VbHPO76CWA1BpOC8W4aQgOxO3192qIaqhDWkCGOtIb0zf/9957cRv
 OY85scrKfWlovZrSWtNcS3a9Q8U73Hfbm+coaw4eyVUB9BpYXPP8ufRQ1vqSyifmnD
 GtKhnQioCnsdrMqz0NNrpXa3I+lDjm/djiJOxcaenqqLRIsMyoPEbvKA0iIOmQ1Mqh
 E31X06nJhd3iS+BAkIES0Qj+kIUKrBf7FuZhY3tvLO7x6ZOFXEiTju2n2L6cG8mxtq
 GvbRtan+t8cXskamWaKeYYP9GvQgPhtp4s9+xxc2Rc3UJiBh83g5C7ROESeB/qhE/k
 2vch88fK6Jnqw==
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so4811537c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:03:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEzPCdrkqGxe0lx3KidzB6GSCEzr4N+uU/gZJKTdttLL7oD+VsGGlavTvOzIpLlYVhYiW4YqPvd9SE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+6OnbkghohXdaFaCbg8YqWHgwngBsqSVT8WT8ILOP2wkYK/gri
 Ei9LuKtZ3MqdgcMQ/M8eK1ETKkMyyO2VSWWpz5ygYJ6ySfiWo0io4vHuqTBXlxeeUB5rApUeMXd
 i1634CaXbVdromEZp/QAjl0zmuvk44A==
X-Received: by 2002:a05:7022:f118:b0:159:2c6d:fcc3 with SMTP id
 a92af1059eb24-1b5568d34cbmr10453148c88.33.1795449794126; Mon, 23 Nov 2026
 08:03:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106103932.1219696-1-fshao@chromium.org>
In-Reply-To: <20261106103932.1219696-1-fshao@chromium.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 16:02:57 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8GoSOkVYeH6qGYxidNJaHF+5sOBs9rbmNNT0JTRRyUhA@mail.gmail.com>
X-Gm-Features: Aa3M54pCW39BI00fZZY2JtJokM0N_1IJyOAlnAV7U4nNlRDiy6OFr5lwg7Buxk8
Message-ID: <CAAOTY_8GoSOkVYeH6qGYxidNJaHF+5sOBs9rbmNNT0JTRRyUhA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Validate gamma_lut size
To: Fei Shao <fshao@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Airlie <airlied@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fei Shao <fshao@chromium.org> =E6=96=BC 2026=E5=B9=B411=E6=9C=886=E6=97=A5=
=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:39=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The DRM core checks that a gamma_lut blob is aligned to
> sizeof(struct drm_color_lut) and at most GAMMA_LUT_SIZE entries, so
> shorter blobs still reach the driver. mtk_aal_gamma_set() and
> mtk_gamma_set() read up to the fixed hardware LUT size, which is an OOB
> read when the blob is shorter.
>
> Add mtk_crtc_atomic_check() and reject gamma_lut if its entry count does
> not match crtc->gamma_size.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 2f3f4dda747c ("drm/mediatek: Add gamma correction.")
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
