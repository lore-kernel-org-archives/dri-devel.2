Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC0606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bBl+V99S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF94112617;
	Fri, 30 Oct 2026 02:10:04 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F485112611
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 02:09:52 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c4697404c2bso17562166b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793326190; x=1793930990;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8+suxdvpWfA49QbPWxx4r9URTG9HBHBLF3h4jRuGu5o=;
 b=bBl+V99SFPeg1E8P62QEedj10CduSGJCgzckz+4LH+Yh3IrMmgqKpx2m52uFWUtWbi
 KKzgDYiOocIDT/hjPQZIqhut8bszDle76tYnNmUSq6Ayk5qjvvVktkm5WxYrhUPk4dFf
 sbGJAqt+l9R4QBER4c6sUCGw4+h+R0gdsrurU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793326190; x=1793930990;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8+suxdvpWfA49QbPWxx4r9URTG9HBHBLF3h4jRuGu5o=;
 b=pPDJw4E9B17FTxfCcKhSoiqZmMervDEldDhzvOovWlGdEfuYcacc4O76FkEZL6gccM
 GlgKn06YNSBgyIEB1oJrttLORs6MbnE7F8YZjahQ7fWNcbeN6QxcMjFGRwDFOA5s5ps7
 48qBjA58kd94jGbwOHS3mh8kIb3wHKirPjiapRzvWldbFUBNXtyCNA7ofNaUbnQHBGmT
 51R+qGJSEZtibVxnlMaI5u6Ge89BJrGFPd/AiAEnz/2fIXQpI8nrL757IW2bb7JfC3J+
 Q/dyenqTgCnPSiyxrNF4EjOXsrEtsz3Ocpeea9dB9DYad7mK3ppacDh9X7G6JAVIBQ1/
 k82w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxY3ArrF1yK6T77jH8CPTroj+a5dZ8K/J0+b9AvV2R1gFTyA8ymRMFGZfyu/xOmO5v6aGiHlqRv5qw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLNX9gipGRokMmoCWM5hhZbtr4seIZ04VbtwNLbWGC1XnoUY1wR
 slP6VSZ0dq4dO8V9M964gVIFMALN8mfOkGXwTOGT0Ui8iCTJZv5P0Vb6og9uPr+iEYfglXjVDgI
 58DF6GzX4
X-Gm-Gg: AYBFou3ZdH4PhzCQxVz4XFwqYQwrJtrLzYxGrx9uMH9pt77br2/0ebdC4afxlVyd9UJ
 k0LVNfmYbtRna+xGcX0awr1CUjDX9gpxL7GvoC0+w/SWvFkzNKyjlCjSnsHUZGnT+vx1DFLzvff
 L5S/prwutBqIygqe74DcpZgBP+ZKts6H204gdDTPCHYu+8cbvUTZI4jAyOhgCF4P1Bmunu93FUV
 QOKRI578G3Vk1bTq4foiZQFrHaxfe1AztRtZMCK3bx2OeCyAQzqeIMbRIrJvxfrg7jUGqRnlCeH
 mORYCVKErIauqsinnPzLDifZGF3OP1idy9x4+BZsLWdQIFqAtll3j8nM9aLf95emZtFy3YQQG42
 /9N+yLbUf6QNaFl66fd9gNyaWpPURpJnZD9Sh1JStiFzx31DhXnRqJlipu/7M7Q0/bRg8huLqnQ
 +bQxKKI7g98aUufK5z0NZSecTRtDKptEkr/stiw0OnN0YKfQ40muRGCW45ZO4Jqp/8FbuZb6O7i
 ogDTzhTwV84nYvadIQEhJXOOy7r6uPFHmkoQwtoOEzx+XxooqBuSJAY34UUcSYecOqZBJcr8Pws
 qmlHg4ekrA3cxFklkU+lpTnrv3nQlgFOdZKe1/RAaFhcmWo6FNNUek6Ra5hA7BCKSApArg==
X-Received: by 2002:a17:907:3e20:b0:c26:1649:47a5 with SMTP id
 a640c23a62f3a-c4ca7a9b0d6mr65848666b.27.1793326190582; 
 Thu, 29 Oct 2026 19:09:50 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com.
 [209.85.128.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabcfdb9dsm8510366b.27.2026.10.29.19.09.48
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 19:09:49 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so1229055e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:09:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzB2gLkNvLiXfIpUKW5CUOFoM7WlihIoYtMVL093+SGFR5gpwLy4HDZ1SkrSrETNtubuLIG+LxT8kQ=@lists.freedesktop.org
X-Received: by 2002:a05:600c:3b97:b0:4a3:5a91:5f64 with SMTP id
 5b1f17b1804b1-4ac18e5dcbamr15731855e9.27.1793326187453; Thu, 29 Oct 2026
 19:09:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
 <20261012-mipi-multi-series-v1-3-6a29add1ec92@gmail.com>
In-Reply-To: <20261012-mipi-multi-series-v1-3-6a29add1ec92@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Oct 2026 19:09:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uki7Q5JxB0TFFBHCAc2k3WHes_C9w+tt-gkyPfxjxboQ@mail.gmail.com>
X-Gm-Features: AclHuK86ihCZ-uLYu1PO7sbohTJtFnXFnyxUkp4TJBSVBWEeSWA2MHF2bUC1_mM
Message-ID: <CAD=FV=Uki7Q5JxB0TFFBHCAc2k3WHes_C9w+tt-gkyPfxjxboQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/panel: innolux-p079zca: Use mipi_dsi_*_multi();
 fix minor bugs
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, Oct 12, 2026 at 9:36=E2=80=AFPM Akash Sukhavasi
<akash.sukhavasi@gmail.com> wrote:
>
> @@ -108,24 +103,18 @@ static int innolux_panel_prepare(struct drm_panel *=
panel)
>                         goto poweroff;
>         }
>
> -       err =3D mipi_dsi_dcs_exit_sleep_mode(innolux->link);
> -       if (err < 0) {
> -               dev_err(panel->dev, "failed to exit sleep mode: %d\n", er=
r);
> -               goto poweroff;
> -       }
> -
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);

The patch looks fine and I'm OK with applying it.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

However, it could be better. Specifically, you could change the
".init" callback to take the "dsi_ctx" that you've declared in
innolux_panel_prepare(). Then it doesn't need to return an error and
you can get rid of the whole error check after the call

  if (err < 0)
    goto poweroff;

That could be a nice follow-up patch.


-Doug
