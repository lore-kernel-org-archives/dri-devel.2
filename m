Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2F5F8E497
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA7710E27C;
	Fri, 17 Apr 2026 03:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="maGnk2vL";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 077FB10E27C
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 03:16:29 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso47354266b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 20:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776395786; x=1777000586;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6B16lAS+/P6RphVwCE0A3no+3noLJancV31wnqccNK4=;
 b=maGnk2vLG0uSxwzVtoXor9XDsjreOKtZYqoU0HKC3I4LZf/wVdISCvOJkt8UboDy7O
 NTxPV2Seq2O3vBHOMKd8vaHB2PR11ZSNDWmMrxRP4qTwoHucuu5REDhqA+0npi2+P/8S
 ZBppXpYZAJovKkujMYfsyw42J3IRz8i4AljbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776395786; x=1777000586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6B16lAS+/P6RphVwCE0A3no+3noLJancV31wnqccNK4=;
 b=Ka00jZecf2F34vbHd4j9oWfKiVMf+EDIFKC3n8yyaFK7rkfHkfXPcAH1346Ox1mKXU
 d+VRsLzZmA/X6/jz2o53MgbuJYyMk2P1L/P3Tl0l/9sUYrO4ijID1wbSTYTYtfC3rWEn
 O5EQ/zOJ1pmOTfQFEskMRgtipgst2zqu1OVij3kJDGw+8PydM8UmJlx30b+F7hF2BsF4
 FYqzrT7v5Q1ugaFcyXBQbpnAfsoESs0ACgODv1y1jbhcnoMYeXbgQnFJxDkQtJgsYr1P
 ZZ0/ZLT09Gdv+C5ZtbDB3R2k4SDPN5FZXA4pxqQwPoBNflAbKyt99d6ldcRdnvD6QiI6
 Wubg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RSVv/9v6CtoYOh6heRaxw8sQJo1v8n9JYWod5qeDbsir/mxJ7T7DQ5rAide2kK0e4kt9VAr7Arhs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkJQV+9pbMoU7reoiOv9xu2BXplMqgZ4dZmIRvPnoDnJKNS4o1
 jldQ9L0HoLPTzyi56fiM7eiKVkVr1EXTlQdZ7y/Fy6LzzlNOj8HpnjC7w0LD6EA7bm7l54whXhk
 PgD5hkQ==
X-Gm-Gg: AeBDiesVISKprCQ4W3Jk/z5JPcsp0nilUILaqtcG6a1XW485VAokyBf+EIVFY8vpp6w
 PMmyPrgruP2dUoHpuF0dWskJFzNPW/YCv0YLblYIGTgizLzqahWZtIH2HkbnD9befMSD1/o3CUn
 qo/SttJ7EHbTljTePsPK4LKyo+z7YbDbDbDY2zH0FAILM732LXUKRcS3SQ0uO6bHyOiq4Lr9Jwb
 gh9wVArkJDUIbuDdtsmzKBBI6nAjxzQspzj6jxq2pBOuMX5c6m7ApUqVhZqNPxEXE/CWqFsimG8
 TaCqHTGtUBBEqZjYOljSAn2CIU5gC/cH2HLMuLSDbR8E0J6MvCwIW9YuI3B6n2mP2aiApJx5G/h
 sC3TclkiZulXpv4oaKSNsZLUwtt44Av4Rd3l8PxmbDVw2Gxm8ZKQK06IsA+Cf1tSRVLnFthYC6a
 bE0t/19k6mEBwRTRJm09zWYq9s5dSsxc9i9X9uHsZs0UB7iijZgSjC/cV1o3qHkmCT0aIYnqqb
X-Received: by 2002:a17:907:a088:b0:ba0:9335:b133 with SMTP id
 a640c23a62f3a-ba422add0eamr43094766b.11.1776395785689; 
 Thu, 16 Apr 2026 20:16:25 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com.
 [209.85.128.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba454d1bbb1sm9392266b.38.2026.04.16.20.16.24
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 20:16:24 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso12554055e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 20:16:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+JHXxcwKhbvdfMRj78Q9qmsEFfD0ioqWGhb85oC6YLJlD/A0ga+NbyC2IgnIcl0BRf/uqanbTkrDw=@lists.freedesktop.org
X-Received: by 2002:a05:600c:4749:b0:488:c6e9:1e0c with SMTP id
 5b1f17b1804b1-488fb889385mr10117175e9.5.1776395783651; Thu, 16 Apr 2026
 20:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260415235608.8138-1-chintanlike@gmail.com>
In-Reply-To: <20260415235608.8138-1-chintanlike@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 16 Apr 2026 20:16:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UCyfjiqcpYCM5ePz-auX4g=i_+i78ivvvyA8R1XtAKzg@mail.gmail.com>
X-Gm-Features: AQROBzAwsYbziGgQpkL752_pXQ9udf5ercbmr6ZwYWnUl7ilIP4BDknODTPK-ns
Message-ID: <CAD=FV=UCyfjiqcpYCM5ePz-auX4g=i_+i78ivvvyA8R1XtAKzg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: novatek-nt36672a: Inline command sequences
To: Chintan Patel <chintanlike@gmail.com>
Cc: sumit.semwal@linaro.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Hi,

On Wed, Apr 15, 2026 at 4:56=E2=80=AFPM Chintan Patel <chintanlike@gmail.co=
m> wrote:
>
> Inline the command sequences and remove the nt36672a_send_cmds()
> helper.
>
> Small wrapper helpers around mipi_dsi_dcs_write_buffer_multi()
> are discouraged as they add indirection without improving
> readability and can increase code size.
>
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> ---
>  .../gpu/drm/panel/panel-novatek-nt36672a.c    | 36 +++++++++----------
>  1 file changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu=
/drm/panel/panel-novatek-nt36672a.c
> index 7e8b5e059575..2f75200806dd 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -79,19 +79,6 @@ static inline struct nt36672a_panel *to_nt36672a_panel=
(struct drm_panel *panel)
>         return container_of(panel, struct nt36672a_panel, base);
>  }
>
> -static void nt36672a_send_cmds(struct mipi_dsi_multi_context *dsi_ctx,
> -                              const struct nt36672a_panel_cmd *cmds, int=
 num)
> -{
> -       unsigned int i;
> -
> -       for (i =3D 0; i < num; i++) {
> -               const struct nt36672a_panel_cmd *cmd =3D &cmds[i];
> -
> -               /* cmd->data[0] is the DCS command, cmd->data[1] is the p=
arameter */
> -               mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd->data, sizeo=
f(cmd->data));
> -       }
> -}
> -
>  static void nt36672a_panel_power_off(struct drm_panel *panel)
>  {
>         struct nt36672a_panel *pinfo =3D to_nt36672a_panel(panel);
> @@ -108,10 +95,14 @@ static int nt36672a_panel_unprepare(struct drm_panel=
 *panel)
>  {
>         struct nt36672a_panel *pinfo =3D to_nt36672a_panel(panel);
>         struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D pinfo->link =
};
> +       unsigned int i;
>
>         /* send off cmds */
> -       nt36672a_send_cmds(&dsi_ctx, pinfo->desc->off_cmds,
> -                          pinfo->desc->num_off_cmds);
> +       for (i =3D 0; i < pinfo->desc->num_off_cmds; i++) {
> +               const struct nt36672a_panel_cmd *cmd =3D &pinfo->desc->of=
f_cmds[i];
> +
> +               mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, (const u8 *)cmd=
->data, sizeof(cmd->data));
> +       }

This isn't quite what I meant earlier [1]. Instead, the idea would be
to fully get rid of the table "tianma_fhd_video_on_cmds_1" and replace
it with a function. The function might look something like this:

static void tianma_fhd_video_on_init_1(struct mipi_dsi_multi_context* dsi_c=
tx)
{
  /* skin enhancement mode */
  mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x22);
  mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x00, 0x40);
  mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0xc0);
  mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0x40);
  ...

  /* dimming enable */
  mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x84);

  ...
}

While that may seem a lot less efficient, the design of
mipi_dsi_dcs_write_seq_multi() limits the inefficiency. Writing things
like the above also allows you to share code better. For instance, if
a second panel is added to the driver that uses the same sequence of
commands for "dimming enable", or setting the resolution, or turning
on "UI" mode, you could create a helper function to share the code.
That is impossible / awkward with the tables-based approach.

Eyeballing the table, you could also potentially optimize things a
little bit if it matters. For instance, I see a big sequence of 0x80
going to lots of registers (without seeing the panel datasheet, I
don't know why). Potentially, you could do things like:

  for (uint8_t reg =3D 0x8b, i < 0xa0, i++)
    mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x80);

I dunno if it's worth it. You could try running bloat-o-meter to see
if the code is smaller, I guess...

[1] https://lore.kernel.org/r/CAD=3DFV=3DWtjW5WWmjeb2zwF2PjiJeZv1jZS_UKZ0bT=
1658=3DCkwVA@mail.gmail.com/
