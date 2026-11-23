Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22B606A327
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhnTzYnn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6236510E153;
	Mon, 23 Nov 2026 15:44:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F0C10E153
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:44:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2993640281
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC021F000C4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795448692;
 bh=+aUeA+MT4pQzgTYYY3MzWDtwE8dPdBjMFRXJtpyXdqA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=BhnTzYnnqJZs1vlF2CbvKQ/jCtr+tzHhysT2ctBbdZUiMpjyTYRZHYHy0h8WY5jUY
 po9bO4YN9TLw/x+knH+4j/7M2Qx68Gm3U2LNvzs0nECU49h3zxUCf/iIb2tINB6ZTB
 KvpJe1vWWs37yzxOy69glevzwCB8cIew1fpzXvgU11jubtINVOj9Kyacl4dD4G7rfr
 ee2WoAzM1E2Y/zm8TqrVmvDSWOs4uOOHe5vn5UGvEgT7r8VASO7h3v1iwp2v4llynk
 W2+wNLpVKtELoKoMI+N1HjDdE8sum0OuHdKFa+ZXyriwZtjiAU2ImwvTF96bkhDz6K
 HqAX2YIeSnxYg==
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1b5786e099cso864899c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:44:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGj2hcPHXlEGwbgQEEgTxUxCTWm9snZWmT+560ZxTAOtQHaZc2hq0+XJAm279VJkG3qwjv8rPBN8JM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/R4JRFow8To0LPs9OK1ix9cey1cDF3xjjAvc3X3aXsjELuVJnh
 G8grezRkTJxCLTrfVUZx/mkIPJl51iP/NydeQbgqTvKYhNqJ/9wSyl5X+/VUwRGfDUZKW8uGwVl
 0DRhMmnq0YimpYPd83DnzociLxLRGcQ==
X-Received: by 2002:a05:701b:2514:b0:16a:c6f2:60c2 with SMTP id
 a92af1059eb24-1b55689fcb2mr10691688c88.12.1795448691498; Mon, 23 Nov 2026
 07:44:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261011004248.1117649-1-agentzoan@gmail.com>
 <20261011004248.1117649-3-agentzoan@gmail.com>
In-Reply-To: <20261011004248.1117649-3-agentzoan@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 15:44:38 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8CtsEarnY804MbUcL+NewYha8kpKZL8cELYKkgr9YGng@mail.gmail.com>
X-Gm-Features: Aa3M54p47vp69xabIIzK4WtjBR9vqd7GfhDX7meoGYcQvi87327NFNEbYgSVxFA
Message-ID: <CAAOTY_8CtsEarnY804MbUcL+NewYha8kpKZL8cELYKkgr9YGng@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/mediatek: mtk_crtc: Skip the empty connector
 route slot in destroy
To: zoan37 <agentzoan@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jason-JH Lin <jason-jh.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 Nancy Lin <nancy.lin@mediatek.com>, Nathan Lu <nathan.lu@mediatek.com>, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

zoan37 <agentzoan@gmail.com> =E6=96=BC 2026=E5=B9=B410=E6=9C=8811=E6=97=A5=
=E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=8812:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> A CRTC created with connector routes gets one extra ddp_comp[] slot for
> its output component, and ddp_comp_nr counts it, but the slot stays
> NULL until mtk_crtc_update_output() fills it in the first atomic
> enable.
>
> mtk_crtc_destroy() walks all ddp_comp_nr slots and passes each one to
> mtk_ddp_comp_unregister_vblank_cb(), which dereferences it. Tearing
> down a CRTC that was never enabled therefore dereferences NULL: unbinding
> or removing mediatek-drm while that display path was never used, or
> an error in mtk_drm_kms_init() after the CRTC was created.
>
> Skip the empty slot. Nothing was registered for it anyway: the routed
> components (DSI, DPI, DP_INTF, ...) have no vblank callback.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 01389b324c97 ("drm/mediatek: Add connector dynamic selection capab=
ility")
> Assisted-by: LLM
> Signed-off-by: zoan37 <agentzoan@gmail.com>
> ---
