Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A02F8E4A0
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 02:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9936410E26D;
	Fri, 17 Apr 2026 02:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WEs4xq/v";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10E110E26D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 02:51:50 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-671ff4b716cso270618a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 19:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776394305; x=1776999105;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wd5t5NGFSVzXqU9RGkBkQkd/pIwniRQhn3iHzrEtU+k=;
 b=WEs4xq/vY7e6XGV3GWnwZL2D8H+mvxtUHskmj/cE4PH+3wtGmJAy93SGnXgb7yHMIK
 jcwe84gpLkpVGZqfzj3h6P//quBLKoAsI0umy3H6MqmZUUOaCU5LgBCDlVQ5/EkOiYVB
 S3kykGAqoOPMzcKnBjd8lKg59LJqf649V0o98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776394305; x=1776999105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wd5t5NGFSVzXqU9RGkBkQkd/pIwniRQhn3iHzrEtU+k=;
 b=Rgr3fevzxVwgJt+1J9Nbahac91m69+NteMgr4/Vl7/dBP6iWe1IW8ZvacuLSsq8y81
 seIsKcAfXOVgkVGVmi49lzX5gIEbKL1vGylTQQpj+R9zhnOBqNR2124rpwOArzU46NC9
 tgB3dxTjLUXT+xegrbwJYHjXjIos2STlL3rp5BE+SBkS+EPr6XxBA28urLYZHr0cF5DT
 B8ch8wGp2gaFBuOpbbgYivoZezaMVEq136xL4ez9yIs/hDg4Xj39PTJJZQPuMCmdtmds
 CvLOFBfK9yh0QIz9RElxvc/ySsEGvdJd88Oyj/uXMtwpDr1/5GPreV/Ge4+Wj3DkCBa/
 vJ8w==
X-Gm-Message-State: AOJu0YxZpKIA7WUHwRWNo/fqDf3hgjtnXll6pTz5V0TL865cOyDkV520
 4SbKmKoBFclcWvYRCj1FEM67qkRyHMu3W6fFbkTp/xXs3m9Qsb+0NuTvQw7TJWt0I353wkD2JZH
 oGXipqg==
X-Gm-Gg: AeBDieuF9EPJgj6Zpr4LcvvYDgWDu1nOJwEnEqq+gsl3gWCReIxfvMydmU1CZyP/jKA
 2ZMD7EBATlOh0KwbTv0UA9p3uZ9g84GWm2NKYZgNG7fb16TOzYpoWSfj4LmS4mzdilpI/yM3dr1
 IrHRFe6G2hys5VbxcRNweviL4TuwmrkqKSayZHxk4IGBB/jxo8UEP7g76Xwp0JF3sQIzxlxKenj
 rHS8ukHJkrMPvN/7If5oKQa+9CtnDECLq0RL/VSA3o8PEYcOF0/9hatf1uOE63t02CEDXq0AJh8
 FPXUhXtyWVTK/FNJTDz55Fd+U1n/Q11heLc9Ft2dSa+lhbpfPmR7I6JYgkExLxZAX1RIpQk0+yE
 Ydnx8SVXEC6b8RXud/T32Qbz8BI8Rex1Nw9Fp1vmuzNn7+byZ4zTaSLtOB8+uEqSfjbPTe5otzX
 iKwtyGz5aJWBUqPV6C9StFl6+t62n0GalBxH3soVndnk1ZhVTlSQhl/V/Ipopb93nDgE7XvTNp
X-Received: by 2002:a05:6402:530e:b0:670:a2a9:fe59 with SMTP id
 4fb4d7f45d1cf-672bfed7667mr485562a12.25.1776394304827; 
 Thu, 16 Apr 2026 19:51:44 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com.
 [209.85.128.47]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c4d699b9sm28558a12.30.2026.04.16.19.51.43
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 19:51:44 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso1726195e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 19:51:43 -0700 (PDT)
X-Received: by 2002:a05:600c:c090:b0:488:c744:49b with SMTP id
 5b1f17b1804b1-488fb74a53dmr8888275e9.7.1776394302433; Thu, 16 Apr 2026
 19:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260416073722.719036-1-avinal.xlvii@gmail.com>
 <20260416073722.719036-2-avinal.xlvii@gmail.com>
In-Reply-To: <20260416073722.719036-2-avinal.xlvii@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 16 Apr 2026 19:51:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULvZNaotTXkNsGJSoKV8uMeOR=vYJibg+mPWOEMow_wg@mail.gmail.com>
X-Gm-Features: AQROBzDexCJRGhtY8HtWwW-Jw-W25x03MBl-po54PEmyDs9qcr1yECQnm80sK9g
Message-ID: <CAD=FV=ULvZNaotTXkNsGJSoKV8uMeOR=vYJibg+mPWOEMow_wg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/mipi-dsi: add
 mipi_dsi_shutdown_peripheral_multi
To: Avinal Kumar <avinal.xlvii@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 neil.armstrong@linaro.org, lumag@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
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

On Thu, Apr 16, 2026 at 12:39=E2=80=AFAM Avinal Kumar <avinal.xlvii@gmail.c=
om> wrote:
>
> @@ -1980,6 +1983,31 @@ void mipi_dsi_dcs_set_tear_scanline_multi(struct m=
ipi_dsi_multi_context *ctx,
>  }
>  EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_scanline_multi);
>
> +/**
> + * mipi_dsi_shutdown_peripheral_multi() - sends a Shutdown Peripheral co=
mmand
> + * @ctx: Context for multiple DSI transactions
> + *
> + * Like mipi_dsi_shutdown_peripheral() but deals with errors in a way th=
at
> + * makes it convenient to make serial calls in a row.

Between v3 and v4, you changed:

  make several calls in a row
to
  make serial calls in a row

Is there a reason why? Not that it matters a whole lot, but the old
wording seemed fine and it matches the wording in the description of
all of the other _multi functions.

Other than that weird nit, this looks OK to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'm pretty curious why you changed it between v3 and v4, though.

-Doug
