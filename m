Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BE606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFWU1dbh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEDC10E8A2;
	Mon, 16 Nov 2026 15:06:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 506BC10E8A2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:05:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 290FE4634A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9881F000D0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794841555;
 bh=OLWrs6wHPjIfz7q4sqV0vSP15dB9qR0xZiDxNkgRnPs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=FFWU1dbhaoZvQa91GRdHI8OMpKROvy42/LGrcfuQXbdf73zihIiGdYVwNZODlPIbV
 Q5czS1aAFUldNovu3EQYEfoc8NHu+qSDhm6v6a8eCG4NjUp76kfyw8lV9DsKKVk32O
 CcIoLaAkJxaGHLILcqeNkWcM46hNELFAqOhyLM6uSFD20cXkC38iqTJWOeahtcSyYd
 gl0YXDYAHTXv1NBld07Xow1K8b2g7I8++GShq7P5vme83fnO0wDP07J8foPfiJr0EU
 +rycpV7xKfNuwSFM0D1jd7RIE4w+CF+RlYtMpdD4VUI53TH4XpcHTY33zunLN8yGxa
 pKvVYF2ayle9Q==
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1b3b4bcbfc9so4023494c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:05:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGaK76OP78+LFZYigExNvS9jlUXC6Xk7Lhw6kZMFW9+vQoC9L809QsehjyZHc7bSbes8mzy+QKVBNw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z946pSsOuu4abmIAmsVne4OzvRFTMmm1d7FJV631z/MCZKfKSu+
 rLhwoO1DLEYQ9ye6ZySeDc6BPZXFpmkZUC66LslYFc1t+YZTGYL4RhmCuBJfsV3rKxBZc45SaDW
 BjxXJWvD7YHVtSjJ7zFo1ns1Z5nzfrQ==
X-Received: by 2002:a05:7022:170a:b0:1b3:b3de:9232 with SMTP id
 a92af1059eb24-1b503115668mr9409313c88.9.1794841554483; Mon, 16 Nov 2026
 07:05:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260921113914.779393-1-l.scorcia@gmail.com>
 <20260921113914.779393-3-l.scorcia@gmail.com>
In-Reply-To: <20260921113914.779393-3-l.scorcia@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 16 Nov 2026 15:05:41 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8o7CQQ=GiRX9hiPOjWs=DMP_XSqhpz21d0cN_w3E5LdA@mail.gmail.com>
X-Gm-Features: AclHuK__YOxqBRiQVL1fHhE6d4s71_dwL_BIXyQUunv6tKh3Bya6r5Lxps8nc8A
Message-ID: <CAAOTY_8o7CQQ=GiRX9hiPOjWs=DMP_XSqhpz21d0cN_w3E5LdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/mediatek: Add support for mt8167 Digital
 Parallel Interface
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>, 
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
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

Luca Leonardo Scorcia <l.scorcia@gmail.com> =E6=96=BC 2026=E5=B9=B49=E6=9C=
=8821=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:39=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Add support for the two DPI blocks found in the mt8167 SoCs. One of them
> can be routed to a DPI connector and another is directly connected to the
> HDMI IP.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
