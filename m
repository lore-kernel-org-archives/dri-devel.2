Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B3FC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AA010E049;
	Mon,  3 Aug 2026 17:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ilTz7EDF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71D510E049
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:04:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EAD24331D
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A571F00ACA
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785776680;
 bh=n/iOnG2AgOH05ZK960YynpPzVU3vp84xiLR+imEY/xU=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=ilTz7EDFtHNfXmhP/huN5N3HdbumDZlyjG48BjpB0rHnz+2bHocp9RaYN5/k0mvv+
 /RpCo6h94xPzJDdW6dsL0/F7v6ZlGg071Adj9WrXCLBjHEerHHzGMqXOR6RymX4CLA
 MVZ2ixLXG97fZHiSD4BgmMAHviwcSrpBGPjwGss1YwXOCHpOs5T5kfHU7crMrS8Jsb
 zK5NqGgx1jDRnhh8xWeaq0w7eJVPpJNNj0qY8Db70C5K8jF6KYtGGUFSNgBf83J1nn
 B/cudKs2WY5dMxxrqQ/Mu8Gvt3MtRlb91sv+3kzur2ZtGcdmBWuzVTDrIrHlw8nlKN
 30fx4qTuaQ6bQ==
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-39da69c5ba3so33506531fa.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 10:04:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpraOYtyIJl4BN6r4CG9uxXxqsJd6nc6M6PsYmjMHO7pkVXuPGFKHK94nA38/SuvunjYGSKisC209c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYUqGl6f3gIOPSbehhDq+6PzVxznPO5kowongZ7FOnqxY9wYFU
 LkFEMAlFXmxPdecz1/WYTay1Mnc8cO+4kztoMGYjZjVuYbL/UxneBaqNgBkHH1Hjv7EqhsNnvro
 zktpDxITkMVapzIMkd1NDONeteQXH1Gw=
X-Received: by 2002:a2e:a593:0:b0:39b:4371:dbe6 with SMTP id
 38308e7fff4ca-39f8616c4d5mr23211641fa.16.1785776678644; Mon, 03 Aug 2026
 10:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <3f5ec952ad80cb51efebf2fe230df50259041a23.1785772659.git.jernej.skrabec@gmail.com>
In-Reply-To: <3f5ec952ad80cb51efebf2fe230df50259041a23.1785772659.git.jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 01:04:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v672PXcS7zLtGLrVQs0D00Pvh97pUo=tgPMCswJMbg7=Rg@mail.gmail.com>
X-Gm-Features: AUfX_mx02KEK-kEu0E0pYT9Oatt7b9Hz1g3PJFr357J8Y3_fc2ljcAF3lcI4DE0
Message-ID: <CAGb2v672PXcS7zLtGLrVQs0D00Pvh97pUo=tgPMCswJMbg7=Rg@mail.gmail.com>
Subject: Re: [PATCH 09/13] drm/sun4i: tcon: Drop remote endpoint reference
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Aug 4, 2026 at 12:11=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> sun4i_tcon_of_get_id_from_port() never drops the reference taken by
> of_graph_get_remote_endpoint(). The function is not only called during
> bind, but also on every mode set through sun8i_r40_tcon_tv_set_mux(),
> so the leak accumulates.
>
> Fixes: e8d5bbf7f4c4 ("drm/sun4i: tcon: get TCON ID and matching engine wi=
th remote endpoint ID")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> index de2d66623f7a..67047e3b657f 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -972,6 +972,7 @@ static int sun4i_tcon_of_get_id_from_port(struct devi=
ce_node *port)
>                         continue;
>
>                 ret =3D of_property_read_u32(remote, "reg", &reg);
> +               of_node_put(remote);
>                 if (ret)
>                         continue;
>
> --
> 2.43.0
>
>
