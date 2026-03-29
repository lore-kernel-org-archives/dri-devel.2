Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBDAF3D60A
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747A210E1D2;
	Sun, 29 Mar 2026 16:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ezXfy1td";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9061410E1D2
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 16:03:49 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7d751ef36ccso1976766a34.0
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 09:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774800227; cv=none;
 d=google.com; s=arc-20240605;
 b=BdsrbDafw7gbXVuFgSiQLJHGRHuq+xBqCqep4ygDmsl3+xn7cjUr0ABFdtjfqNGNKD
 2tRE2qUmTOh3n6bl2Vc9gqcK5eokp6HiFUMFnOTjS6ZUSlKZ5epFc4rCngPCqBLDTnOh
 w6CTPkemxY43Q1vjP4qICzwvcUKsfhcfrRNQMhw/A16GbLq2ugDUDQr7KweknPlPTkwN
 OhJ9C6WQR+lFKEpSqgM3JW/muAn34f8K//xkzaMxnhFp/b9NJ/laQNkHSifqB5h69HCu
 3GgJiN1DZnw804G6hnfrGLsk7twR2lk8eee29fUgdoDpb7TEQPiywwB5fQn0le/hHJzl
 RKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iuRiB7kx80/hvjqFvrfisUx6wOU49zwzAkhJWuxRZrs=;
 fh=fVmxYoHI90gERUk28yfSvzaep29mcYu5Z/uuQXEuGik=;
 b=CeNGQWWpp5WO1HAD9FXk4bM3FXFRRecrUkb6IwcOTkw9vR54iO6D+5W9x0PshsmNo8
 a4TI4spLYFtHYDNqAL3TGBXKY1C6EmK+nTlq9BE7CKmjCUzmZcHwD1l9QoGWcrMprq4q
 L79CehmofyiDpiR+MzXjhpYffge/XiCMr+Xl0dadyxga8J6YbXzLoQQ5NSGgwnvYBBYb
 CtWrNcWKsogbcKd7fU8WyUehipbilphNMLyMNNQyTWWZYn9kVrE6IiUnXwFe3c1voLaA
 z+/YJXtwoK8vLHTwPfHzDKtbnRx1RVeM4eSO2qjK9veST6LLawxLfUH45ApSpdXTfaRI
 AuAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774800227; x=1775405027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuRiB7kx80/hvjqFvrfisUx6wOU49zwzAkhJWuxRZrs=;
 b=ezXfy1tdFyjVOEoji0zsczkUdtCSDK5/tsdRbbkRcQR4DZ7VctFYreJovGY4ypkrRv
 Wv2br+gGP1EfTy9Byl+As/qt4kIx0pq+q87pMLgs65LSFwE42R99qK4Nr7XwzOYc8pGo
 6UXtVo4Mn0mkJ6vXddsdE7Q5tGEtgKWsruV24Awxu4vNQRSx0LL3ElFT9g+StOIpfO0c
 UuEfIh+ruk4LzV/jkBlUHzeiUb0uKCsYX0A38V99QltQlGlPeo2r15PTpm8jdVVs5qmr
 0MUptNZhyCUSNIAPd9Vp0y2gcJY7wy7gGlWuAhKIPcXjL8lCT4pEDLkoPV0V5NAjLhnE
 ouog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774800227; x=1775405027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iuRiB7kx80/hvjqFvrfisUx6wOU49zwzAkhJWuxRZrs=;
 b=R8zbkV7c4C5fX7sMBjB4euEs/xf/EAe6X+hiRgCUWr0FnqR/UrmjLjHadwLRHxT6qP
 VI86VJlqoJ2g0mp971yMYdoKbCV5g3ExvysJ6HEzQkPCZr5FGqLQ3qKyYnLidq0YkY/u
 MfUzWm3xb+OkZO33W/Lx0R4my7uVi/UFFZN7O2uhyuxzCMIeDAbzEpeuvdSuQq/kq5B9
 1rHY/OV5Bufqv84fHFfCltJB4E6cs5Uvi32VS4jLaOlPKS6RHS00Hel9bmC9ugfLstu2
 UjYp4ZdFyZLUMBbxmArQEPhV4GcUqKFngzsB1hqOuk7nK9YNWjcXWxTzYs0MC6ma35j/
 LrUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN0s8+ad5DRUbF1sy80nDgLFU8jbt9G2Pili2F8WrRXGt7ndo3xZsQDgqXMhaG7MzOCvUP9H8/ZOU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLGnliIIyo7hsz3wyroK5RfuzVz/evdbqXoOM+4cb3n0gvXPQ8
 dYRqQ5BChgGTxlfMmJkGdwvkvSzs1T80YppOTnaW4fpvlspIWXsepWnxEqfZzmw/qG8s2k7hlCK
 vtOmCBg3P+zdV3S886uM6BDHIkySGQ/E=
X-Gm-Gg: ATEYQzxPGVEkQmsDyBzd6LTOI0HQvW/wYkMbXor9YpfB1jHwUn95NjrjsSXvmAAnvgN
 UiOQrydSeP+SYE313xc8UCp/R6yPgweBJAzGSU2boHieoonQIHbC9cP8O4EV3isIsmPgNz59wu1
 RJTLvhXgvNKg/dvH4Vg/xj6oNC+owzEA3hQGLkz5DYsoVng6iu/H4hSLKn5Ym2ulztUGG/A+o9g
 1rLmt7mSIjAkYiSaqC+4Vowex9xWP42ICwO6Ds+UjP/HZODdTdri3SsWvMfMXBOr9yDYghwwtb2
 e3W7X+DJ
X-Received: by 2002:a05:6808:1a1c:b0:466:ff3a:c745 with SMTP id
 5614622812f47-46a8a3eb1b4mr4305468b6e.21.1774800227277; Sun, 29 Mar 2026
 09:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260325040457.2113120-1-jason-jh.lin@mediatek.com>
 <20260325040457.2113120-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20260325040457.2113120-4-jason-jh.lin@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 29 Mar 2026 11:03:36 -0500
X-Gm-Features: AQROBzDYnGEvrmF9Nv8aKI46KCu4qNGcGl029nctsf-3ar7uJysAlIX7PTC3c6A
Message-ID: <CABb+yY2cjMskJeXsn8+hZj2DcFs05yabHbSaGT5XSi0fn45zCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mailbox: mtk-cmdq: Remove unsued
 cmdq_get_shift_pa()
To: Jason-JH Lin <jason-jh.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Nancy Lin <nancy.lin@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>,
 Paul-PL Chen <paul-pl.chen@mediatek.com>, 
 Moudy Ho <moudy.ho@mediatek.com>, Xiandong Wang <xiandong.wang@mediatek.com>, 
 Sirius Wang <sirius.wang@mediatek.com>, Fei Shao <fshao@chromium.org>, 
 Chen-yu Tsai <wenst@chromium.org>,
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-media@vger.kernel.org
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Mar 24, 2026 at 11:05=E2=80=AFPM Jason-JH Lin <jason-jh.lin@mediate=
k.com> wrote:
>
> Since the mailbox driver data can be obtained using cmdq_get_mbox_priv()
> and all CMDQ users have transitioned to cmdq_get_mbox_priv(),
> cmdq_get_shift_pa() can be removed.
>
> Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c       |  8 --------
>  include/linux/mailbox/mtk-cmdq-mailbox.h | 12 ------------
>  2 files changed, 20 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index d7c6b38888a3..f463f443e834 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -123,14 +123,6 @@ void cmdq_get_mbox_priv(struct mbox_chan *chan, stru=
ct cmdq_mbox_priv *priv)
>  }
>  EXPORT_SYMBOL(cmdq_get_mbox_priv);
>
> -u8 cmdq_get_shift_pa(struct mbox_chan *chan)
> -{
> -       struct cmdq *cmdq =3D container_of(chan->mbox, struct cmdq, mbox)=
;
> -
> -       return cmdq->pdata->shift;
> -}
> -EXPORT_SYMBOL(cmdq_get_shift_pa);
> -
>  static void cmdq_vm_init(struct cmdq *cmdq)
>  {
>         int i;
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mai=
lbox/mtk-cmdq-mailbox.h
> index 07c1bfbdb8c4..a42b44d5fd49 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -96,16 +96,4 @@ struct cmdq_pkt {
>   */
>  void cmdq_get_mbox_priv(struct mbox_chan *chan, struct cmdq_mbox_priv *p=
riv);
>
> -/**
> - * cmdq_get_shift_pa() - get the shift bits of physical address
> - * @chan: mailbox channel
> - *
> - * GCE can only fetch the command buffer address from a 32-bit register.
> - * Some SOCs support more than 32-bit command buffer address for GCE, wh=
ich
> - * requires some shift bits to make the address fit into the 32-bit regi=
ster.
> - *
> - * Return: the shift bits of physical address
> - */
> -u8 cmdq_get_shift_pa(struct mbox_chan *chan);
> -
>  #endif /* __MTK_CMDQ_MAILBOX_H__ */

I think the simplest would be to take this with the other two
predecessor patches.
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
