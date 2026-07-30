Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE18C54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D81410ED2B;
	Thu, 30 Jul 2026 01:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iNvEYWr2";
	dkim-atps=neutral
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 785BA10ED2B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:56:13 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8f29ec73064so10867566d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785376572; x=1785981372;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iJbMH1O3SVcEkSlnJAMLfzdQhNp7e7p3B0YbprP5koc=;
 b=iNvEYWr2+Nb3/IhHC3uhu5Y8vEkWaJkV4ffGbgJxvAtp6BHgXONLEinJqFF/OkfoDh
 1o5EC2iiWjcA/C9/YQjHUUAmxM1bEgXM07cbk5DzXaLg2Nw+xxJ6KG9zZ9t/gI/C3kW+
 XBjWk+13BJ2kM/tIFAiFldcD/SZW0Qb7c3Ths=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785376572; x=1785981372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iJbMH1O3SVcEkSlnJAMLfzdQhNp7e7p3B0YbprP5koc=;
 b=QEsXm8w2tX0ZfKqtwK/Dz/KxplmUddGA+7v3H3R/6kevxCpUbHMLsWTJfa3NZbWCDw
 dpMY4MCKWg4YFUtEGtawtrSkNeF/2DYklhsgsITtgTSSt/ndfu11gDcX39CTnGvva01B
 WR2IYbsYZuYijXQPsf0I1RbS2ZX2doJLCPG9wHYeeaikF5N5qpuFwsI5Mip1po1Fb7G5
 NR18ZIFrzItd+ZZm4SWwo5g6mX433TjsFkn2t+1unZLwGwD925rotkoPMAjkOCP/LNe3
 h9fce5EsqVCeSbIjVS7u91YWJ0u3cVs/u/bfcW5YoDwBpknTkXqkquxenHDTTiMUxaUW
 gpOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHkCTrR16LiPvqlv3EhFMtCzjYiRhad4GwYNNPcN5YLptcxTT+bhf5xFRtizmSkX3dUu69RSH3YR8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhNK0TC9aTQaCKc8ZgjBwWNheUcU/CK4YoVfTjBjCYtc9qr5Hd
 ZPC4PO7YBJtt2a7MGSswFTWt7Ik/hUADGczKCpKq69SGHPvl+fv2nu1hkQSsvIb2h8TbXe/o78c
 jLaE=
X-Gm-Gg: AR+sD11fV4Sf+ql/VLmxWxri+SmflO0mEDTZLM31UwrGmtUFzuVaxs2Sv7ey8Afu+zP
 sy9/hauP08bQaqyh+qf2ZuO3Y9Hu6gtenZtc5gB0B7g0Tct3iXc8b8Mkp4ag397NAjSe9vQDzwP
 0N8Vo0+SyKb+Ycdx/9A4Y+D4Na5srNsu72TumTyn+U5fVpe0WiN3bfl2rtf7irXLaBBQnjZwDl1
 5rc9Tt0KnUt88alX8F77fwPo6dw+UJ0nWXZwcJr0s2YZPLa8uOQF+hfQTd1mlYlO9bXgN/eL1L5
 crrbbhNOicTawAQn0uH5l6oIksSgMqw6RDqNrfAdtwHtpw/IB5j8xn06HRHtR4fTMG28rC7E+Mx
 8B2pt5+0rZVX7qXK6Wqdj4BRbIekk6/G7BCdgNKSJF5QmWLa/twV1caMl3vTPuQO/xAUdiS/AUn
 jFwH2UvwzalrQurojVsX+QMgmR4O7VQgMv4pd1M/mSEwOY4zsVN5g5DfZdlg6fjkePlDqDcBbUI
 DrYaUrNr/bDxgWKOMINrxF2Apg=
X-Received: by 2002:a05:6214:4404:b0:8dc:1f0:9f2f with SMTP id
 6a1803df08f44-908346e50fdmr6247456d6.17.1785376567419; 
 Wed, 29 Jul 2026 18:56:07 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com.
 [209.85.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908322fa6e2sm5364706d6.9.2026.07.29.18.56.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 18:56:06 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-8f29ec73064so10867346d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:56:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrrCApiUvytpe5ygIvWAu731djw0+x7Igx9IEqtFbOmg2bCjZRn2Gxrx1iFP2Ao0BNO/+0AxBc42ug=@lists.freedesktop.org
X-Received: by 2002:a05:6214:4411:b0:8fd:6de3:dd7c with SMTP id
 6a1803df08f44-9083483ca5emr5543436d6.62.1785376564584; Wed, 29 Jul 2026
 18:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-mipi-dsi-tl070wsh30-multi-v2-1-f47b937631d3@gmail.com>
In-Reply-To: <20260727-mipi-dsi-tl070wsh30-multi-v2-1-f47b937631d3@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 29 Jul 2026 18:55:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VvM22hHY7aMT116WOHSje-iiX8ins=AERBDX6Wjmct9w@mail.gmail.com>
X-Gm-Features: AUfX_myuQKARjHlVXkhj_QkTXUb0fQaqClD10h_YD1BRLPk_YYtqbXRTWf4n_2g
Message-ID: <CAD=FV=VvM22hHY7aMT116WOHSje-iiX8ins=AERBDX6Wjmct9w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi()
 functions
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 27, 2026 at 6:45=E2=80=AFPM Akash Sukhavasi
<akash.sukhavasi@gmail.com> wrote:
>
> The mipi_dsi_dcs_*() functions used by this driver are deprecated in
> favor of their _multi() counterparts, as noted in
> Documentation/gpu/todo.rst. The _multi() variants record the first
> error in a context structure and skip every later call once an error
> is set, so the return value no longer has to be checked after each
> command. They also log their own failures, which makes the per-call
> dev_err() calls redundant.
>
> Convert prepare() and unprepare(), using mipi_dsi_msleep() and
> mipi_dsi_usleep_range() for the delays between DSI commands. The
> delays in the GPIO reset sequence stay as plain msleep() and
> usleep_range(), since they run before any DSI transaction.
>
> unprepare() now disables the regulator unconditionally and returns 0.
> Previously a failure of enter_sleep_mode() returned early, leaving the
> regulator enabled. drm_panel_unprepare() skips panel->prepared =3D false
> when the callback returns an error, and drm_panel_prepare() returns
> early when prepared is already set, so that path left the panel
> powered and unable to be brought back up. Both functions return void,
> so the error was never propagated to a caller in any case.
>
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
> Compile tested only, no hardware available. checkpatch and a W=3D1 build
> are clean.
>
> Changes in v2:
> - unprepare() disables the regulator unconditionally and returns 0,
>   per Sashiko's review on v1. Returning an error left panel->prepared
>   set, so the panel could not be prepared again.
> - Link to v1: https://lore.kernel.org/r/20260725-mipi-dsi-tl070wsh30-mult=
i-v1-1-69160b83982e@gmail.com
> ---
>  drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 40 ++++++++++------------=
------
>  1 file changed, 14 insertions(+), 26 deletions(-)

Just as a point of note, something about your original email to me and
your original patch triggered gmail's SPAM filters, so I actually
didn't see anything from you until your first reply to Sashiko [1],
then I've been a bit backlogged. Sorry about that!

[1] https://lore.kernel.org/r/amU_GppAwt3XXPX-@gmail.com


Also: since your patch contains some minor bugfixes, it's probably
good not to hide under a code cleanup. Maybe a better subject line:

drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi(); fix minor bugs


> diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/d=
rm/panel/panel-tdo-tl070wsh30.c
> index 13cfe252a838..cd846e5ab2e7 100644
> --- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> +++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> @@ -35,6 +35,7 @@ struct tdo_tl070wsh30_panel *to_tdo_tl070wsh30_panel(st=
ruct drm_panel *panel)
>  static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
>  {
>         struct tdo_tl070wsh30_panel *tdo_tl070wsh30 =3D to_tdo_tl070wsh30=
_panel(panel);
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D tdo_tl070wsh=
30->link };
>         int err;
>
>         err =3D regulator_enable(tdo_tl070wsh30->supply);
> @@ -51,45 +52,32 @@ static int tdo_tl070wsh30_panel_prepare(struct drm_pa=
nel *panel)
>
>         msleep(200);
>
> -       err =3D mipi_dsi_dcs_exit_sleep_mode(tdo_tl070wsh30->link);
> -       if (err < 0) {
> -               dev_err(panel->dev, "failed to exit sleep mode: %d\n", er=
r);
> -               regulator_disable(tdo_tl070wsh30->supply);
> -               return err;
> -       }
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>
> -       msleep(200);
> +       mipi_dsi_msleep(&dsi_ctx, 200);
>
> -       err =3D mipi_dsi_dcs_set_display_on(tdo_tl070wsh30->link);
> -       if (err < 0) {
> -               dev_err(panel->dev, "failed to set display on: %d\n", err=
);
> -               regulator_disable(tdo_tl070wsh30->supply);
> -               return err;
> -       }
> +       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>
> -       msleep(20);
> +       mipi_dsi_msleep(&dsi_ctx, 20);
>
> -       return 0;
> +       if (dsi_ctx.accum_err)
> +               regulator_disable(tdo_tl070wsh30->supply);
> +
> +       return dsi_ctx.accum_err;

Style nit: in general, there are way too many blank lines. You don't
need a blank line between every statement.

>  }
>
>  static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
>  {
>         struct tdo_tl070wsh30_panel *tdo_tl070wsh30 =3D to_tdo_tl070wsh30=
_panel(panel);
> -       int err;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D tdo_tl070wsh=
30->link };
>
> -       err =3D mipi_dsi_dcs_set_display_off(tdo_tl070wsh30->link);
> -       if (err < 0)
> -               dev_err(panel->dev, "failed to set display off: %d\n", er=
r);
> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>
> -       usleep_range(10000, 11000);
> +       mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
>
> -       err =3D mipi_dsi_dcs_enter_sleep_mode(tdo_tl070wsh30->link);
> -       if (err < 0) {
> -               dev_err(panel->dev, "failed to enter sleep mode: %d\n", e=
rr);
> -               return err;
> -       }
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>
> -       usleep_range(10000, 11000);
> +       mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
>
>         regulator_disable(tdo_tl070wsh30->supply);

I support fixing `unprepare` to always return 0, and I'm glad you
mentioned that fix in the commit message.

...and I think it should be fine to disable the regulator even if the
MIPI commands fail. ...at least, I hope so.

However, I think the Sashiko bot had a point [2] when it noted that
the old code used to still sleep for ~10ms and try to enter sleep mode
even if the "display off" failed. That behavior is probably worth
preserving.

[2] http://lore.kernel.org/r/20260728015051.97FA71F000E9@smtp.kernel.org

-Doug
