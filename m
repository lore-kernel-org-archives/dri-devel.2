Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64591606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgkdVXM/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B2B10ED3E;
	Mon, 16 Nov 2026 15:01:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F66B10F04C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:01:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 197D745FAD
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14F41F000CF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794841288;
 bh=jsBT0FZpMNikULzHhEfNl07JkOQbHVwUC1+MdqdHryk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=WgkdVXM/UXQ+P/8FVeaG3uctBI70rCd3thyWrq8PgYspDz9O/pUqZJCa/8rQC4dng
 GwQvURFQU6YqndYAWAZ+TcpG/e0NSDMfGsot24t5yN08P/NOW0Vlq9uPzUqL0nRjoq
 2djWIcrsZbuCPc30DJtuZunOnH5WgsljMzcZvo+pLvGWprScSYdlu7b07fh0ag0Srv
 rrtUbpJWtwTQdt5FgOQ/cZYb32UPI9QkJfcOWKzeaBcu9PCTMnK4EqEcIQGPNX1o9P
 rGL1oO6kpYd6v6D2/nw/jGQoOKFKHVzZML+cscsIHCPEiB7J21GQkvEWuJkmAemcrp
 dzKTZN1W5AJ4w==
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1aefd1bf74aso2644773c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:01:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErH05EsX1RMG6RowyATI18e8JdiOYqLILkOgyenwXw01iBRqhn5csWN/hGuWq1rWdlpoF5Vgr/KDygQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8PLmgAU7lJv0OepW6Wi9bom4+aJruFnpHUz5lTxbDLmsS5iXJj
 BKv3I5lqiBWIyw2iRzflefPdOFIsuQip05Cc95pkS9srHB/+uDQDU115EYEx6oIY511aqW3GVer
 bJ/vczzKCLbnIK93x7WlFB8fSW1NboQ==
X-Received: by 2002:a05:701b:4648:b0:1ad:1574:aa9d with SMTP id
 a92af1059eb24-1b502f8a3femr9454273c88.0.1794841287247; Mon, 16 Nov 2026
 07:01:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260921113914.779393-1-l.scorcia@gmail.com>
 <20260921113914.779393-2-l.scorcia@gmail.com>
In-Reply-To: <20260921113914.779393-2-l.scorcia@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 16 Nov 2026 15:01:14 +0000
X-Gmail-Original-Message-ID: <CAAOTY_9W4MmG74gMgXx=6-QncXs2-DqdR6FqjckJG9bsevyWnw@mail.gmail.com>
X-Gm-Features: AclHuK8ZIdYSrxKs1dMZwhPrKku_6kwGWxmzNQVSAncsA778TJy7Qtii6vDGXkQ
Message-ID: <CAAOTY_9W4MmG74gMgXx=6-QncXs2-DqdR6FqjckJG9bsevyWnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: mediatek: dpi: Add
 compatible for mt8167
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
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
> MediaTek mt8167 SoC has two Digital Parallel Interface (DPI) blocks,
> one can be routed to a DPI display while the other is wired to the HDMI
> block. They are not compatible with any other device, so add a new
> compatible to describe them in the device tree.

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
