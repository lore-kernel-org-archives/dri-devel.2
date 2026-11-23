Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA2606A333
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EoaoBPCk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5421110EF1E;
	Mon, 23 Nov 2026 15:41:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0C210EF1E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:41:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22C0045A9D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FD41F00ACF
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795448492;
 bh=PwBm1IcM1lfZmkWEHC9cN+WkeWysjbiIwKr8KptSUas=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=EoaoBPCk5xlBbmcyZnLlAayGwUrD1lH9GkXZhVLwd6R3Sbgf2pWTuUc9fFkkVxG9O
 KRsYj3ZKAn7kTn9kTc9iRxnKgtcsfKXKyMRvxxnGSb7YazKCjk61Ci0xhQiaJZS9fo
 fDQ8//zpVBzA4XdMhhCmFeCwA30Tba+zOhWZBFICu7otJSlmUfDnupMUU8KPYNosGx
 r3QCPtpAWSkxvgmTf0bgfhYQTjDgZYtXg84kooCVq+mv2rdPABnwLyXLooKHyWZcAf
 Yvo8/3Ot1a0XbNJdFolHsyfzSTYGxbCzi6wfQX92YFIfzQJ9Ev8og+OKFGisN0E4X/
 9oXiOA8PyZrJQ==
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso2291582c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:41:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErH9ifzP6EDwaqUb0FuYIbctxREoR+9JfJApH/W0IZpxm7Nsk+jLNcYwzUknB460KNuRwhSgUgFsQcg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9c8uyOwbZvLEqzUKprVrONDdFFzeJlIrPIVSOo/mFIz87vLVw2
 F4MPIqmMizRr/iFK1SovVk5WMee8PVQe2ccjyTCS6SVgjvMQS8z8ML9qEF4WcSZdIOY6xhkeBKq
 BzV69wtXs0J3CYndaBM201VqiXeBDgw==
X-Received: by 2002:a05:701b:450d:20b0:1b2:4378:3545 with SMTP id
 a92af1059eb24-1b5568e825emr13210367c88.21.1795448492121; Mon, 23 Nov 2026
 07:41:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261011004248.1117649-1-agentzoan@gmail.com>
 <20261011004248.1117649-2-agentzoan@gmail.com>
In-Reply-To: <20261011004248.1117649-2-agentzoan@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 15:41:18 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8_90si7frBxHCtBqk=V+nr3WhkYbc8YYWTcAq=oL40eA@mail.gmail.com>
X-Gm-Features: Aa3M54qUVOXJZJP1GdyNU65SHuNK_sE0j5xy6sPPN1MXY2yoHWIA_tbhn9S-dUs
Message-ID: <CAAOTY_8_90si7frBxHCtBqk=V+nr3WhkYbc8YYWTcAq=oL40eA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/mediatek: mtk_crtc: Look up connector routes in
 the CRTC's own mmsys
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
> mtk_crtc_update_output() finds the private data of the display
> controller (mmsys) that a CRTC belongs to with
>
>   priv->all_drm_private[drm_crtc_index(crtc)]
>
> but all_drm_private[] has one entry per mmsys (mmsys_dev_num entries),
> not one per CRTC. mtk_crtc_create() gets the right entry from its
> priv_data_index argument, and the two only agree when every mmsys
> drives exactly one CRTC and the CRTCs are created in mmsys order.
>
> When a CRTC with connector routes sits on an mmsys that drives more
> than one CRTC, the lookup reads past the end of all_drm_private[] (or
> picks another mmsys' data), and the route component taken from that
> data's ddp_comp[] array is bogus. On an MT8189 board with connector
> routes on the external display path (CRTC 1 on the only mmsys), the
> first HDMI hotplug oopsed in the compositor's atomic commit.
>
> With the route tables currently in the tree (only MT8188 VDOSYS0, whose
> main path is always CRTC 0 and all_drm_private[0]) the two indices
> happen to match, so nothing in-tree hits this yet. It triggers as soon
> as routes are used on a path that is not the first CRTC of the first
> mmsys.
>
> Remember the mmsys private data mtk_crtc_create() used for the CRTC and
> use it in mtk_crtc_update_output().

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
