Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D9606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ScMHru2V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B813F10E2F0;
	Mon, 23 Nov 2026 16:06:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47AF610E2F0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:06:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D3596236C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D651F000ED
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795450004;
 bh=l4IBb4xjYzTBoSi6YXuP+odsV5j50E3nqTxEjgiJFXU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=ScMHru2VIvuBRXLr3rU7S50QEYGVjq8CNRcZ90X1RmgFFmqUXmI3YULA3G4VvlSEq
 6mWi0Mkcg2NuWySrlMfFaQ4/x2Y4L6H8elSGIcBStc29EiUNOuhieiTLqJpRHA7mWU
 GR8SMyiofhxm+IP4nVcQwSQZzhs3MV1VXi+S/zSDs4xJP2J2jqOTFed7e+gIF0Ss+C
 SHJj9cl6aFc/v7iLXUiIWzzKBMuJU8l0Mp/CyL1OHWbZXjGWWJt9D5TqcYLtSuWfeB
 KnvoDyxvXa6KA+WRga2yvZfaxAnV3N2jlDdP+Cpzr6WRV6vy+ctOrPsqL/m7vH5am+
 cXJXpWRXCxqUQ==
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so5804072c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:06:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErHN/mczdzy/n0GblsRCky/cW/HGHK8qMQvbYsPrL48lpd+t7yMOpCb2oVW1849PhJBWLGla6fNxVXY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+j/HcsQfz/4qi3o1JPDptsesKe8hSGxX1DI2r87yh3N/OtEAc6
 I3AXVIkgC54COfvMWBaxKpJO5ePVKtSRRj+NCI0sPwkKknupjlfz1itS75uw/OX3cYbClf39gsZ
 iGBeg0tjqPZxK8SPtJOosCgIqxwOt4A==
X-Received: by 2002:a05:7022:b056:20b0:1b3:ac53:da84 with SMTP id
 a92af1059eb24-1b5568e371bmr13106997c88.32.1795450004014; Mon, 23 Nov 2026
 08:06:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
In-Reply-To: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 16:06:30 +0000
X-Gmail-Original-Message-ID: <CAAOTY__tykvuoNWOD3ZMy1etCEwPPJrvY=y5xOO7h7DL=ErRdA@mail.gmail.com>
X-Gm-Features: Aa3M54q66gFGZx_hKSNABqOrF2C_XAAy0XYCXxVeneDbJLO5H6L8BwiOx2EzBXg
Message-ID: <CAAOTY__tykvuoNWOD3ZMy1etCEwPPJrvY=y5xOO7h7DL=ErRdA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: mtk_dsi: do not enable HS clock in
 pre-enable for LPM panels
To: rva333@protonmail.com
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, 
 Gary Bisson <bisson.gary@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
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

Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
=E6=96=BC 2026=E5=B9=B411=E6=9C=8817=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=
=E5=8D=886:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Roman Vivchar <rva333@protonmail.com>
>
> Commit 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during
> pre-enable") moved HS clock enablement from mtk_output_dsi_enable()
> to mtk_dsi_poweron(). Later, the commit 3e191eddbdcb ("drm/mediatek:
> mtk_dsi: Enable HS clock only at pre-enable") moved the call to the
> mtk_dsi_bridge_atomic_pre_enable().
>
> However, mtk_dsi_lane_ready() explicitly sets mtk_dsi_clk_hs_mode(dsi, 0)
> so that DSI panels with MIPI_DSI_MODE_LPM can transmit initialization
> commands in Low-Power mode during their prepare() callback. Enabling the
> HS clock unconditionally in mtk_dsi_bridge_atomic_pre_enable() overrides
> this before panel prepare() runs, causing command transmission to fail.
>
> Only enable the HS clock in mtk_dsi_bridge_atomic_pre_enable(), when
> MIPI_DSI_MODE_LPM is not set, and restore mtk_dsi_clk_hs_mode(dsi, 1) in
> mtk_output_dsi_enable(). This is a no-op for non-LPM bridges.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 76255024cadb ("drm/mediatek: mtk_dsi: enable hs clock during pre-e=
nable")
> Fixes: 3e191eddbdcb ("drm/mediatek: mtk_dsi: Enable HS clock only at pre-=
enable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
