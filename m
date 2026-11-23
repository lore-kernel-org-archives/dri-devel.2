Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB5606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhxF28VO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893EB10EF35;
	Mon, 23 Nov 2026 15:50:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5181610EF6D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:49:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED2C043312
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983E01F0093E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795448997;
 bh=SCQzlcbNwCmuhr5iFrK9gJq6siqjEJF99ctxEcILNVU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=FhxF28VOIx6y+hROoeNp60dLhhrLpae7rXzvw5rF7qUHPlYBCLyMDNMQrcWOhiw+K
 JOho/jbZlZPyi/MQG4qrbOTx6O2AC+OlL0ImJHsNE0LlHpxtBfDzhLu35Yc3hfleS2
 ihgiKn7z2XWHEBsgVwvIEcniBlcJpVjzCmrj4zEmHNqUfPvlqH3QNhxNUqR4e/eo3H
 h6lnzAzDOV+cx6KIn2xsrZSX3gL8aAGSYVRRpmSdUv6WOpi6ANFIcZ0ulo0yf2is4j
 URk3Qs2PoDSTaxmIQ3BmGcwDoC8R99MU4xDeAYvMS3AV/kqFPabpp+UfMAigDS9p7q
 wXQ2sWK9pU6yg==
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-3869f03af6aso2567554eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:49:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEu3/Q8ID4nKJX6sih9620hzpotJzEiDPPyflhsBn66R7ofZeBhTE5sfl7sUWd76h8GRtNsmPFhZ94=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8u9sLhh+5sINTFYc34FaEPRuJE+Ul/FMwgAn3Gnhx/QPONyJ3o
 uV7Y7ZpY0VhEAy8Gh/S234/3fOilPqu9oaS7SeLmPbJqbQ9mLQJGSFhp0Gwp3vOppUaUq+G9qns
 HcQUDPHnelH/iLOP1+PULuyHgKRnOYQ==
X-Received: by 2002:a05:693c:8943:20b0:386:af00:e9a6 with SMTP id
 5a478bee46e88-386af00eb48mr3600530eec.2.1795448996995; Mon, 23 Nov 2026
 07:49:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261011004248.1117649-1-agentzoan@gmail.com>
 <20261011004248.1117649-4-agentzoan@gmail.com>
In-Reply-To: <20261011004248.1117649-4-agentzoan@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 15:49:44 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8NSXSj64NBQN11kLs1ik0YXWH1FZ5gzJtzWYNEozQ7Lg@mail.gmail.com>
X-Gm-Features: Aa3M54oYdPL6VD3WqMQ7QRwBmptZ5_Vy6FcQra7b4AqYYR8h27_8PCC_wigfSRA
Message-ID: <CAAOTY_8NSXSj64NBQN11kLs1ik0YXWH1FZ5gzJtzWYNEozQ7Lg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/mediatek: mtk_crtc: Pick the connector route on
 every CRTC enable
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
> mtk_crtc_update_output() only picks the output component of a CRTC
> with connector routes when connectors_changed is set in the commit that
> enables the CRTC. But connectors_changed only says that the connectors
> changed in that commit, not since the CRTC was last enabled. A connector
> can be attached to (or moved to) the CRTC while it is inactive, and the
> later commit that only sets ACTIVE then has active_changed but not
> connectors_changed:
>
> - If the CRTC had never been enabled, the route slot is still NULL and
>   mtk_crtc_ddp_hw_init() dereferences it (mtk_ddp_comp_clk_enable()
>   and so on).
> - If the CRTC was driven through another route before, e.g. a CRTC
>   shared by an HDMI bridge on DSI and a DisplayPort output that is
>   switched off (DPMS) while the monitor moves from one to the other,
>   the pipeline is set up for the old output.
>
> update_output() only runs from atomic_enable and the lookup is a short
> loop over the routes, so do it on every enable.

With modification, applied to mediatek-drm-fixes [1], thanks.

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
