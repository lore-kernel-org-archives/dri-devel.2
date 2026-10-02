Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E224CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 23:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C75610E501;
	Fri,  2 Oct 2026 23:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cd4svtH8";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A9910E501
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 23:30:10 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-9178e92b27bso2624756d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 16:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790983809; cv=none;
 d=google.com; s=arc-20260327;
 b=FPZM8FrIipoOuTWsm+hBQTIjYFcEFFZLpNMkG/+ye1/HRMGJVCy1/QUtWIf7Jm2I+4
 JNY9ey3LOMZ1iDF5Ptu1neX0QCNQ44v4dfNAt3aSOvAwf7UDkf0+Ct3Sjkpbt7s1rIBF
 dlcpOgGA/bf8QsuFYFNeyCMnLvgfc+8bK6qsxVwQCVjaAVq5pbzQ7L/Ul9qIsEaTRjXC
 v9HhQ8iNZijnpdLbZ2xJUcYQlsO/tFxWTZO5qYWodytUYT2OOPkGUeafZrE3FGjp6dhP
 33irKcLItjAFCM2JVPqrYTb8yoTGAEC9Ed95qxNE0pQf8OZ4X9UsstyPhQLvdxZxOovP
 27CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bovas2WAEGD9Xsa1cngl8uKLJL1gfGRL2y54+LLnPkg=;
 fh=/1aKwgeiSnSC3mR+KjgcQNx2t8n4UX+nuEBynB4xUbM=;
 b=bHCAAcw3tXVNqoFENNTYFXcwSDTnJuzQxypQA3j8FtjFnOYBJ88YJ/oGU5qdNJhYQw
 R0OQcdPShhwV4Y4fMYOuaVL227Djm+A58qgyuOofk++DWkrr3ubr2wkIIh4Z66iGoiso
 wooLF8cMvvjw12p0qd+JXrPYACh/FHazkvvuHQHOer4q89IxZt0VW3oIR1g2sVKkVh//
 e0jngekgI/86dJq4IbsP4FEmgBzDTJ8WqqHjj/YogPcEKPM4I4dTsnh3iIsrnIm4Ahnk
 KgBDbdnM2k4ZkBOYR8b3OOL6HuwGZqfyCf51HuTdPMJwpjVpNsmu2/j1Oc8MwNShfscA
 E3og==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790983809; x=1791588609; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bovas2WAEGD9Xsa1cngl8uKLJL1gfGRL2y54+LLnPkg=;
 b=cd4svtH8jdnn1x9zacpLRg2ful/24zl+TxzYRkOQg3zndUopbiN0p8gZgNqudwMXaF
 bcn3MWiWbySSrZhcJDfPRlQPK5L5XyvRldlgUp6AwfEZxZYGemCzYAjMEzZJ+Agdkf6k
 cksy5HGeSUmkW7BhO1Cbgn+dfZecFP/DmLStET65wHy8J/x4HvSpHrdTrNdyH9Jh2Xx0
 3eOEjHpHhy8u8hspxM4NfU+hYpyiU651ZGx1Xbr0y5xyOkDCUUE5A33/ZEKXQS/a5QQp
 qB6DSrX2vFu64s85fdGr45ij1P+HsCOWuCi1nt3v53vjeB03vYx9FZiZQz1ETHwmo7jA
 GPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790983809; x=1791588609;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Bovas2WAEGD9Xsa1cngl8uKLJL1gfGRL2y54+LLnPkg=;
 b=hdgRnGxwqJpuAwp9tjsWjqVx5YUgol0uWDwUAmPB1QUqJ41DBRvR3N6OulENzRx5cg
 ESAOoEthMvexVCwnyPmyxfLHWwQd2ypifuQ2XFzC03+B/WGz+kJUr3xR7LajdjGCj+h4
 KVUqILwa/QKKJcEgDC0bowSUANNDXVAujLUZSzN0EFvTdIvBCcNYFSXho4vKfCk7FYbX
 606j4AVXuNLKuRg3VYDbNMSv31RCd2KOUGTpPncqPuK84+1IPhZjBKAkXKiD5GTbEnnu
 lEfh+kBXL+3X9yN4Qhi8L//i10DPYtDRiXdyEbRFliCKD870iYOAn/ft50SdTcby+gXT
 EnkQ==
X-Gm-Message-State: AFuF++nsV5kHIWXucT7esoJu8696boWmU3OTH3Dlnlzx0gm135KAJF7a
 qDSS84jph3gSzNhUBmYke83c3LCRp0nIRCSWJYj/M5Y7GoqconQG4fcNmqHOsQcopBgTBbGKz7v
 yYIHG6XPCpqBWjdTaZZpNuDp3KEKjV9Q=
X-Gm-Gg: AYBFou1lVkaU/mJ2R7v5k6lrfrtlnJ6gdLSn8OnwliD5TipKkQd1uHn15x+kdfxGSR/
 3kDgJSSEhSR7oWp5zvJzM86dVOokLU2IB93GBjWFDNtwRGcn2IZpoQdZMsQ+jexu0ZcIehxIy8C
 +qEyVIShtFfMYHTUwUYq7bg6yb4Ck4odqEWRdOuUkipz7DCjHehaqUAzHQOml4haPpahQmH4yTr
 9E9U2OmZLlqUfzj1GDoqMY+CCiLTYLm7sohGm0SRx7S6gSxObqFck7F4op29aXpEyg1TMD7AS7F
 adAWAPmn+67laWBNZ4Ze5yPBF5HYJy6Dwx5Fbqy5JckImANSZ3+gQLom2o66l560elBp8kSpy9D
 ACpjzFBVGCWk32n0WDNN6kS2BgMgfxIZC/qXVBakUcA==
X-Received: by 2002:a05:620a:172b:b0:93a:2e8:5afa with SMTP id
 af79cd13be357-93e50feb9ccmr188518785a.30.1790983808980; Fri, 02 Oct 2026
 16:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20261002212833.9674-1-fzeruhn@icloud.com>
In-Reply-To: <20261002212833.9674-1-fzeruhn@icloud.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 3 Oct 2026 09:29:56 +1000
X-Gm-Features: AclHuK9rjOUUMpjG387IHnEilLqBy4AfDp78Y1XLf07vnG-EkqsHFL56vRwAE6c
Message-ID: <CAPM=9tw91hPiAfwRP=y6Dr=CFgYboO+Z94_1dVwt41exGokj5w@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: keep MOT set between messages when no_zero_sized
 is set
To: Finn Zeruhn <fzeruhn@icloud.com>
Cc: dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, 3 Oct 2026 at 07:28, Finn Zeruhn <fzeruhn@icloud.com> wrote:
>
> When aux->no_zero_sized is set, drm_dp_i2c_xfer() cannot use a bare
> address packet to close the transaction, so it clears MOT on the last
> data packet instead. The check only looks at the position within the
> current i2c_msg, so MOT is cleared at the end of every message and each
> one is terminated by an I2C stop.
>
> This breaks E-DDC reads of EDID blocks 2 and up. Those are read as three
> messages: a write of the segment pointer to 0x30, a write of the offset
> to 0x50, and the read. The stop after the first message resets the
> segment pointer, so the read returns segment 0 again.
>
> On a Pimax Dream Air (three EDID blocks, native timings in a DisplayID
> extension in block 2) connected to an RTX 5070 Ti with nouveau, block 2
> reads back as a copy of block 0. The checksum is valid, so nothing is
> reported, and the connector only offers fallback modes.
>
> Clear MOT only on the last packet of the last message, as the commit
> that added the option describes. With this, block 2 reads correctly and
> the native 7104x3840 modes are listed for the Dream Air.
>
> The same problem was pointed out by the Sashiko review of the patch that
> sets no_zero_sized for all DisplayPort connectors in nouveau.

nice catch,

Reviwed-by Dave Airlie <airlied@redhat.com>
>
> Fixes: f0ddbb1eed18 ("drm/dp: add option to disable zero sized address only transactions.")
> Link: https://lore.kernel.org/all/20260827015758.0B4FB1F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Finn Zeruhn <fzeruhn@icloud.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 488fd123a01a..7676285c19f8 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -2192,7 +2192,8 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
>                         msg.buffer = msgs[i].buf + j;
>                         msg.size = min(transfer_size, msgs[i].len - j);
>
> -                       if (j + msg.size == msgs[i].len && aux->no_zero_sized)
> +                       if (aux->no_zero_sized && i == num - 1 &&
> +                           j + msg.size == msgs[i].len)
>                                 msg.request &= ~DP_AUX_I2C_MOT;
>                         err = drm_dp_i2c_drain_msg(aux, &msg);
>
>
> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
> --
> 2.56.0
>
