Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496C3CA5FEC
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 11:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B00910E176;
	Sun,  4 Oct 2026 11:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="be3GSZ6K";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E0810E176
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 11:47:02 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6aa5d092211so1399375a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 04:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791114421; cv=none;
 d=google.com; s=arc-20260327;
 b=A3AGm0C1TMl2iO+6RhhlcLXicxHN6RVeTOGLxqYs8Yapvln57fFgNJNsqI5ctDabKm
 tkfZVHSDXu4v98sje5TIHMcTsOM79yLUHoaXEvpyIQ2Q83JacqIgP4ozPfPotsZzAJc2
 awPPCa+HwNzmgmLKpIy9WbowTuup0W3UhS6NglvmEJeKdQ4q25EA99KTBzdLFnD/MW9U
 HukXF7lkJTUMIcsfS7EZUloXmzQ8ZRaPt/4A3p8wDlLWhl2b+ORmjRAVKGrXtYst87Gi
 Fz2bE8LDFejy8kyMqVZR8eSVLxlb9RMCX/NI7oI0OPN2+BYFXRbBZMRn1Lo/cWHpw++B
 eb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZRz7JbcncLnLcW42dvDfeGGoX+dHR78wDKr4f8pv6C8=;
 fh=U+ehCflfUvk3NqdissXflTD15z3ZyC7L5HF7oh29VMI=;
 b=RyayNqJ5kp2tJDHuKJnnSBMcxW8dJRaft/g/z66e+r3mfDh6Yh123JM7ZaYdyQj4TY
 1InrzhDWTSUpUfIY/WsMzCA5QHEXTTEVUjKvfxZ9UGvjmCjhGfos3WeckWNlSexhB+hN
 +OXKknVXsDbJS9xbT2D8KYOw2LioXv3eVm0pVKQrg78uUlvuVDJw1mal/s8y+NPRmju5
 ABJ859ozcR72n02w8AsY7XojShQdhAJUP1M3bTkPKcSrtQNTXN/cxtgQe2+lEeeeoY+y
 TlfcTCrNGgKPTdfZNbzcQ9fqpm5E2ma8ZhkHIKLVzdrY4DUy409ufU2NX0QsgsQdUU1a
 4zPw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791114421; x=1791719221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZRz7JbcncLnLcW42dvDfeGGoX+dHR78wDKr4f8pv6C8=;
 b=be3GSZ6KhW9q0d0EhSCaWWCG2jSVM2t4td1qZSBk5HsTvL3Pt6k7WK9Eq4LupTms9F
 tFQ/FDPVOmo+DErmkUm5+mKUcIk4R4vb62AVxhzk3WY8u7cIt5as80V5wmeDwKKgED5t
 G1/pnfEXsKoXEdyYUWKmWxULA20xlYr54ndM8sD/ALzJsYR7HDFr0YevqR+vL6RVPWC3
 /R+dKYVSZNs+Q737dQzhNcjyO6+sj0sIdVtPCuxyirrzcksLguD/IGLrr/YDoxhWhlYB
 jBEfhvJtE37SiADl33negSyRsFkB24D8maNWvziCNcyStmjKAW5fmI8UtFDKvXKbfj4n
 tbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791114421; x=1791719221;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZRz7JbcncLnLcW42dvDfeGGoX+dHR78wDKr4f8pv6C8=;
 b=Ch21a5vJbrD2JotIJxgih2svaiy4CeqgLe8HAfOw0CJ7weNksm6b+/IXJIVID/u0bK
 mxwWyJsR/AxEtQunEJIwMXCU7H/J5o/xK0AiOb3tEW50t8cQQs/ICoQRHdhjNTZmaDAW
 vZZHsm9F+ORVksZcw3fexDg1pjiv7p1jSxgtcD7E8S3dX5akNPzWp8s2GX1248b9HGwp
 iawEX7jEuuzLj+2QCAxyo3f/DLZJyAm19nGn+Bz7/9tI2+IUxZrLcSI8sJomg/uFlvUn
 kVXf3Rn8j2n+W0k0On+3xNwRlcDzgvFv1CVFPwFFl2HsiNIJQBZyEBnXVVcdMH/vXcHY
 3B+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlHIyk8WZJHTzhh3UkHED2TEf7FAcZ5eAa/CFHLzGCBLFYZorqQnw3eFu/tLMnLNbUhfupP5DjOoM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKba9J7si2dJdoX/6A6tylMx+f7yGmWImIMeeo9OTNgs4vgMyTI
 rlmp1gl/A8CPJS3vtNxieBJdf6+MoUkATBRJQRzlQRf6UozZMwn2c5QzNhkj2pASRtEsqDLYcRQ
 C44idKcG8XJjZDBGi1u2S8LQ1RzQnNYY=
X-Gm-Gg: AYBFou0VAOpLFh8nB38ljADgOkFCZaY5BZBmLMvv9rQfqU3fXJd/Gk4sFWpd8X4QSN7
 1mtFn5CIbbYXf8i1+Kpt9CE1xHhM9719Ln1U2oBkwCKz+Q6A3qsr9Hj6W5W3+dgiEc/RNIrSvGW
 RuPTodt48aMEN7fXx6W/MmORREzujF+xOdE5Q/WwsVmYPnUPJTKtZ/CPhzbBYjIF3uFx+xa6oNN
 y/Pzp7GdzHseNvZ7NgsbUF+F9317VwSQQdYkKTHvRillG8x2vfi7MqrMOYBjYZ80pCoo+rHQZ6J
 iGedf3zCsyhUtw+KoQdAY23/Narx+39+Lp25bi1iXn8J9P8fJ2FV8sxLiWq87b6XaaRzx3IfpAk
 XVUNR99MzEA==
X-Received: by 2002:a05:6402:4021:b0:6ac:aec6:a3b9 with SMTP id
 4fb4d7f45d1cf-6afad90627bmr3827480a12.24.1791114420829; Sun, 04 Oct 2026
 04:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20261004102758.84436-1-26rote@gmail.com>
In-Reply-To: <20261004102758.84436-1-26rote@gmail.com>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Sun, 4 Oct 2026 19:46:49 +0800
X-Gm-Features: AclHuK9M0MD-4wDlLCu7PKAzHiucnOaIPii0zTGjuitof7jNo1-BtNJqT62chRk
Message-ID: <CAH2e8h6RPMF+Tod==XKjAbjmnzUKs1skCpvN7_YuGyao9m2baA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: round up the compressed INTF width
To: Joonhoe Kim <26rote@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jun Nie <jun.nie@linaro.org>, 
 Jonathan Marek <jonathan@marek.ca>, Alexander Koskovich <akoskovich@pm.me>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, "P. Lewis" <liu224806@gmail.com>
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

On Sun, Oct 4, 2026 at 6:28=E2=80=AFPM Joonhoe Kim <26rote@gmail.com> wrote=
:
>
> For DSI with DSC, drm_mode_to_intf_timing_params() scales the INTF
> active width by bpp / (3 * bits_per_component) and rounds down. The DSI
> host computes the same width with DIV_ROUND_UP, both for the pixel clock
> (dsi_adjust_pclk_for_compression()) and for the active width it programs
> (dsi_timing_setup(), from bytes per line). When the division is not
> exact the INTF line is one pclk shorter than the DSI line, and the DSI
> FIFO overflows.
>
> Example: a bonded DSI video-mode panel, 952 pixels per link, DSC 8 bpp at
> 10 bpc: 952 * 8 / 30 =3D 253.87, so the INTF uses 253 and the DSI 254.
>
> Round up, as the DSI host does. Qualcomm's downstream SDE driver also
> rounds this width up, and Pengyu Luo needed the same rounding on the
> Legion Y700 gen 4 [1].
>
> Tested on a Lenovo Legion Tab Y700 gen 5 (SM8850) with that panel, with a
> module parameter selecting the rounding: rounding down, DPMS off/on gives
> no vblank and 14000-17000 DSI FIFO error interrupts per second
> (dsi_err_worker: status=3D4); rounding up, the picture comes back and the=
re
> are no errors. Only tested on this device.
>
> Link: https://lore.kernel.org/all/CAH2e8h6oinKxN1ndcvHCSc+=3DbFLXVVDZVAVF=
0cQHoiaMvEwhPQ@mail.gmail.com/ [1]
> Fixes: f9ce482d7dc0 ("drm/msm/dpu: fix video mode DSC for DSI")
> Assisted-by: LLM
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---

Thank you, Joonhoe.

I am glad to see someone is raising this. For most tablets, the
horizontal pixel count is not divisible by 3, so rounding up is
necessary for them. Besides lenovo Y700 gen4, rounding up also helps
dsc display on gaokun([1], patch initially provided by White Lewis)
whose horizontal pixel is 800 * 2.

[1]: https://github.com/whitelewi1-ctrl/matebook-e-go-linux/blob/master/ker=
nel-patches/0003-drm-msm-dpu-encoder-fix-DSC-width-truncation.patch

Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>

Best wishes,
Pengyu

> This does not touch the divisor discussed in the RGB101010 thread
> (bits_per_component * 3 vs 24, with and without widebus); that patch
> was dropped from the series pending that discussion [2]. This one only
> makes the rounding match the DSI host. The panel here uses widebus.
>
> [2] https://lore.kernel.org/all/20260321-dsi-rgb101010-support-v4-0-eb28e=
cebbfe8@pm.me/
>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drive=
rs/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index ba810f26ea30..2ac517db50fc 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -134,8 +134,8 @@ static void drm_mode_to_intf_timing_params(
>                  * TODO: replace drm_dsc_get_bpp_int with logic to handle
>                  * fractional part if there is fraction
>                  */
> -               timing->width =3D timing->width * drm_dsc_get_bpp_int(dsc=
) /
> -                               (dsc->bits_per_component * 3);
> +               timing->width =3D DIV_ROUND_UP(timing->width * drm_dsc_ge=
t_bpp_int(dsc),
> +                                            dsc->bits_per_component * 3)=
;
>                 timing->xres =3D timing->width;
>                 timing->dce_bytes_per_line =3D msm_dsc_get_bytes_per_line=
(dsc);
>         }
> --
> 2.43.0
>
