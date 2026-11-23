Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC9606A337
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhHvVIeL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1241910EC24;
	Mon, 23 Nov 2026 15:31:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E1CB10EC24
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:31:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCD01450F1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7FB1F000EE
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795447873;
 bh=5Zmzfenaqe/ABUcz0D1nvMINiY0TPaqXO2ZTdLBhjRU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=OhHvVIeLj+E8jjACmZyxOQsE9LLq2TL2ftClvwugpxsJm1tg23lNcFLQd0SGWplHc
 TWzlhIBDKuLOhLGZrVly6pVMQ6oWBArpvHDqz5nVxf0svxcdqjylyUoSeyh7z6xyhF
 SQRLZ3bux7XcahS8tWzmVdaMc/RcYAbrfHXlzehjfQ3//xvRaSpcALvlJPajTkIdRH
 CSmNEyCORb08sPFGiybftPt3O04fBgs9GzWRqKMudgC6VFdJaNPvO400OdzCN1jt/U
 c4GOc9ynGtjbcKSXfGhJGFfckZq5SwXYVbgZi5/ymHi48yEFdJXlUmDNBNce7RSqHQ
 nDPq2gL7TL3RQ==
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so5736616c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:31:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEs8CI3jsJGFHxxaAf7GQTP1eORFjsNA079qn3nuXBfsPb35bqBJoBmdgaQyyJS/WU1zh79DxINxUw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9XFxqPvgRnZ+yzUcJdK2PhTQgnuoUwrIB/cBWqM72xwLuB8smb
 mIar28y7tnQnA12u7DGqv3rQ6YeKBQ2lip8J+Fdn/FJDQSdHDGSNeRrYJEsDpLPtpL29n9U6lFo
 mfHyfZ3pc5QQce20/1DzIFani11hpyw==
X-Received: by 2002:a05:701b:2810:b0:143:5cb4:30 with SMTP id
 a92af1059eb24-1b5567b3391mr10425170c88.3.1795447872711; Mon, 23 Nov 2026
 07:31:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261010115539.9237-1-l.scorcia@gmail.com>
 <20261010115539.9237-6-l.scorcia@gmail.com>
In-Reply-To: <20261010115539.9237-6-l.scorcia@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 15:30:57 +0000
X-Gmail-Original-Message-ID: <CAAOTY_9N7q8vSOM1R-i0JzidoSnVmf7E99KKi458NGU=WTSnCA@mail.gmail.com>
X-Gm-Features: Aa3M54qyF59hFKqLYZAT2WpV4wdT_KYkLyV_ony0INzG1Z9OlyFKt_7T9Q9dDAQ
Message-ID: <CAAOTY_9N7q8vSOM1R-i0JzidoSnVmf7E99KKi458NGU=WTSnCA@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/mediatek: mtk_hdmi: Set tz_disabled for mt8167
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, 
 Fabien Parent <fparent@baylibre.com>, CK Hu <ck.hu@mediatek.com>, 
 chunhui dai <chunhui.dai@mediatek.com>, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
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

Luca Leonardo Scorcia <l.scorcia@gmail.com> =E6=96=BC 2026=E5=B9=B410=E6=9C=
=8810=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:56=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Just like mt2701, MediaTek mt8167 does not require an ARM supervisor mode
> call to toggle HDMI output.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 511cf7d12331 ("drm/mediatek: hdmi: Add MT8167 configuration")
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
