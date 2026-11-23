Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32017606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIPojpav
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6433F10E7EC;
	Mon, 23 Nov 2026 15:55:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B19F10E7FF
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:55:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43BE54483B
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722031F00A3E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795449324;
 bh=3G6I2HBy1UTihgVzffidRJ8qc0m2dAG1ryDyw90kJ+U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=YIPojpav0O7GuwdQ8vBLY/e71DVXviFdsS44PLAZ6U3mzJmNA6TR2JMjsN8z5lxCr
 DbkvMGQFYOuHHzjMf8u668uvyZWYP73Ki5QI4dd172ddRmjLFNCa1RTUNH56JBlA59
 DWJcJyl8C/QXuR7xiGNwKc63hL3TIUzKnOEhWm6p/JSDwbCrHijVfhs4JXS77SRl23
 /lEkfV1otEaHf0WCm2jhnwz3dRQVyDEuB/CgyXWuGu6IpZPRjTt1E7VOxNwDDZILJd
 Wh0IWvZYsXb6pcvxsO9MTrZusQddlEn9jgt7S6z878feRaXG9PYA+wtFIkq7dSQc6L
 qisckzr3Lptsw==
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1a2af4c8d00so5860683c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:55:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErFKLzWYH0l7luEq3yWOxBCZoqYWJ165VLM1GjObfEyA8xxHXoT55ZB92idf4JQCSX9KIeTWw3v1fQ0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/HuzXwDL9WPALnEXd1owuW9vhrtCcYEhrL2x5iAfZ+o0tCgBSz
 ylwPCTAO/ppd9tUtlQPj0/QU24JhVscDCAXYGA45b2SZ7aWJufD0ECiI0FgfvG/XB4VMGYMj2H7
 wTkHC/Ka9hbw16MLkc4ehqRChMVOvIg==
X-Received: by 2002:a05:701b:4212:20b0:195:49ee:94c7 with SMTP id
 a92af1059eb24-1b556877b4bmr13673422c88.8.1795449323806; Mon, 23 Nov 2026
 07:55:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-mtk-dsi-long-read-v1-1-0b6d9b67c011@protonmail.ch>
In-Reply-To: <20261105-mtk-dsi-long-read-v1-1-0b6d9b67c011@protonmail.ch>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 23 Nov 2026 15:55:09 +0000
X-Gmail-Original-Message-ID: <CAAOTY_86OXNzY1ZCM-TkRHJBL2D251TmMUAb7KciJ=J67zzpdA@mail.gmail.com>
X-Gm-Features: Aa3M54odlecVrJk7CoDKPAKnCFnRzxRnnufzNqT2mcMd-MnXgiezzVi7wDx4zUE
Message-ID: <CAAOTY_86OXNzY1ZCM-TkRHJBL2D251TmMUAb7KciJ=J67zzpdA@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/mediatek: dsi: Fix handling of long packet
 reads
To: bengris32@protonmail.ch
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, 
 shaoming chen <shaoming.chen@mediatek.com>, dri-devel@lists.freedesktop.org, 
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

Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
=E6=96=BC 2026=E5=B9=B411=E6=9C=885=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=
=8D=882:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Ben Grisdale <bengris32@protonmail.ch>
>
> mtk_dsi_host_transfer() decides where the payload starts in the
> received data based on the byte count returned by mtk_dsi_recv_cnt(),
> treating anything longer than 2 bytes as a long packet.
>
> This breaks long read responses with a 1 or 2 byte payload: they are
> treated as short packets, so the word count from the packet header is
> copied into rx_buf instead of the payload.
>
> Fix this by checking the packet's data type instead of inferring it
> from the length.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 21898816831f ("drm/mediatek: add dsi transfer function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
> ---
