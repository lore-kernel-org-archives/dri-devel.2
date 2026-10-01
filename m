Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E4CCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 317C510E219;
	Thu,  1 Oct 2026 08:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pxI2WJS4";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7E210E20F
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:07:54 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a01b560392so6028725e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 01:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790842073; cv=none;
 d=google.com; s=arc-20260327;
 b=DB25vCeLCLawHIYvHhlcvjkte+Iww6ymft1YJmlD1+Xzm11+N19yAehv8VrgSqT+Vv
 j2YFE2pMuqA1a6uQqkjEZWSnyFdhf5V1MC7f3xo939LYAN9ODQfQstA1Z2ZL09mKtPAP
 ysZnt+8gLtMKSV0hi+BYOwKtuCOLzAilFLmwPiDvLr8QM5rYgqnXsps7sOaYJ1vw2t2f
 k/lB7htlxZgjU14YHm4DZL8c9BVOqk+Oyz4ya79bcV2fsmzurdGsdbELRsSbPWz4KwsZ
 yWQrkvFryCpVk+LHKzHH7zntxKoZZ6t6Z2QX2JMFMUb5Dr5VT1JqmBlEKEweKuunmIrT
 uTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=18zLq0gxDFVMpNFIuebbzGpXcEbEbepSMRwKNaKe0Ds=;
 fh=GLMp9UgBEizH9D1dJjhWbesmqBH+xZ2Y5n1cTnBp6wk=;
 b=dvsRXphb+pFiyh+03Oe8hjXB8jkhNKOqauADAd0Ol1BCFcHnTd95SBkjl9p0bbcotM
 8RR901z9x22zImSRYka0aBR3074Ebr39SwnJtH9bIT9VZ0CTh1Zaet6ACXIgQ5uPi+A+
 O9zv8IczZdYHbJjv/ThhCwcwPYDGwEOUh1sFUXWMOIvs8hiXI9naSer481A4uxWeaypL
 HXdSrmMYOliUJX31fV70HpLnfBUKF1+Fhb9jz3y6CnZb4nEsqrpGRNUkXpu8PNliguma
 Ic90rrFHBDiRBQEvZRfUjw6djRqHHmcqX58FS5T3JP3rAnU/+8EKIUr+eEO17GU3eDtt
 gFVg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790842073; x=1791446873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=18zLq0gxDFVMpNFIuebbzGpXcEbEbepSMRwKNaKe0Ds=;
 b=pxI2WJS4pJm8AFJN2IWifRD80G+iM8MOvy0380TpawC/NT7OTc2MTzVua2/FvBVn4v
 5jVTNKP4d2zivNYX1gcGASrXNMtgH9HhBkMlX4v5yyq3Kg9inqj1SrNEPWroQL9laN/P
 Rkieq1VuUciXL4fXWhPTZj0ptRBYlOh/qJg2QZbKpsN9phjxWcBEo6bnGye1JMNnd+uh
 Grc+mJX5JuxUWFBwlvRsepXRZOVWyzD3G/PWh62b/30wCwa0OwV0s9P5/P6I6kZscwx3
 i0xyE5WDu2xc/YdhZJC3T9ffo77fL8lbR0U6kx22rVzat7zRmr7ydhYxhTwlcZXfO0Un
 2MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790842073; x=1791446873;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=18zLq0gxDFVMpNFIuebbzGpXcEbEbepSMRwKNaKe0Ds=;
 b=umZ2os2hjywgecPA1P+C960TdnoL/wMN4b3cK741AYCY5TWSpxY9X7e3c6h9Mxm2gs
 3n4cY+8s2F30fMBaH4grqBPjKEpQlzDfR9FW4IHr/PKnIOEhUHKOBMBpdkZJenRuDVfq
 58QJl+tmEgIprze9hi8CfiXiW/s0w3MDrzn6FKqxobHZhdDvbAdxkVsov7LeddKOqgiw
 ay7x8BW4YP9LgMn+bDV8FWtrPcebj+v4tHXBECVUb7moZ1AsXnAjPa5oj7CvQzdtRqsh
 3nLA3Q3d0dJatTbWICyT8CfliTCQLsh+5jdmb5kwJoMwjv4xotyJL1Z/JxsDaAJ2mtYE
 qv1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9spYVQDxm20lKh4s492knQtqb2sYOR6VSD1kh2vXZtfTP7ZZitY/Z9mjdwhhtMvzDFqSjER0q39U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ms8/08BpjmSHcC1YhCyen2ehSoFi3ZqPaPURBrb4X5z+cCEVYs
 OOpuQ/9hq8wo4HQ/1CGmrOdLGYZJorod9154QG5AizG85yeYawdx+R9MWmQ/UgLKBC0LzzlKwlS
 feE+H+sGN1K74tLET93yqUB39XaG76/Y=
X-Gm-Gg: AYBFou0R/R7POkWrZEXE2g5lx2AKMMHO6GuobyhIDdVS7JLHVedZ5gJUaI6tVC5MzCt
 F0QXSXiIyh3/MtWmPFTDC4IuofIUWycbXB8e77X1qAbki6ZZxqW4Ud5Rqg9z4FfndRlQahLux19
 ULshD9VoooqrAmXJqq9Ma3pW2/O/a/Du7JQWgGhdjZeOjNsW4Lt4MtWYU/9RUaZVpK9kaqikFFu
 ymD7J3QGw9OCt4/R/UexMbgrX7ejOk5JW9i2Vkz4VUdI41qkLuSeNIFlPxXCVffNbaTV2wH0BuB
 s4EKSsT3GgyUS4kE018cqWYanSVVeCcgZuwcbNhGA0jUpJrK/HKdHhjoj2xhW4HPnCtMZChcUIa
 zYvqtQo0a7guYT7W2GTaR+qDvYSkvMePjlsxHwIAvCQ==
X-Received: by 2002:a7b:c319:0:b0:49f:bd43:5a1c with SMTP id
 5b1f17b1804b1-4a01eb388aemr28276965e9.15.1790842072599; Thu, 01 Oct 2026
 01:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
 <20260930133257.23210-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260930133257.23210-5-biju.das.jz@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 1 Oct 2026 09:07:25 +0100
X-Gm-Features: AclHuK9cX00JQ5BRsiOahPrZyoL_jqZij1NEb2GdYg1yn5CCJaNcWxmYljLqQbc
Message-ID: <CA+V-a8tQZONUkeZYFBTvO+L+FTnrq6AE_aJQsm7MFX9CBnA-8w@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm: renesas: rzg2l_mipi_dsi: Add support for DSI
 PWRRDY
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Biju,

Thank you for the patch.

On Wed, Sep 30, 2026 at 3:47=E2=80=AFPM Biju <biju.das.au@gmail.com> wrote:
>
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The register for controlling power to the DSI region is in the SYSC
> (System Controller) block. Add support for controlling the DSI PWRRDY
> signal so the driver can efficiently manage power to the DSI region.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Dropped pwrrdy variable from struct rzg2l_mipi_dsi_hw_info and instead
>    using feature flag RZ_MIPI_DSI_FEATURE_PWRRDY
>  * Dropped rzg2l_mipi_dsi_pwrrdy_off() as it is taken care by
>    devm_pwrseq_get().
> v2->v3:
>  * Updated powerseq API names.
> v1->v2:
>  * Switched to power sequence for handling pwrrdy signal.
>  * Dropped header file regmap.h and mfd/syscon.h
>  * Added header file pwrseq/consumer.h
> ---
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu=
/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index d67e1230b70c..5263b2b8f1ca 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pwrseq/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/units.h>
> @@ -38,6 +39,7 @@ MODULE_IMPORT_NS("RZV2H_CPG");
>  #define RZG2L_DCS_BUF_SIZE     128 /* Maximum DCS buffer size in externa=
l memory. */
>
>  #define RZ_MIPI_DSI_FEATURE_16BPP      BIT(0)
> +#define RZ_MIPI_DSI_FEATURE_PWRRDY     BIT(1)
>
>  struct rzg2l_mipi_dsi;
>
> @@ -87,6 +89,8 @@ struct rzg2l_mipi_dsi {
>         struct clk *vclk;
>         struct clk *lpclk;
>
> +       struct pwrseq_desc *pwrseq;
> +
>         enum mipi_dsi_pixel_format format;
>         unsigned int num_data_lanes;
>         unsigned int lanes;
> @@ -1396,6 +1400,25 @@ static const struct dev_pm_ops rzg2l_mipi_pm_ops =
=3D {
>   * Probe & Remove
>   */
>
> +static int rzg2l_mipi_dsi_pwrrdy_init(struct rzg2l_mipi_dsi *dsi)
> +{
> +       if (!(dsi->info->features & RZ_MIPI_DSI_FEATURE_PWRRDY))
> +               return 0;
> +
> +       dsi->pwrseq =3D devm_pwrseq_get(dsi->dev, "dsi-pwrrdy");
> +       if (IS_ERR(dsi->pwrseq)) {
> +               /*
> +                * This platform requires a sequencer. If we can't get it=
, we
> +                * must return the error (including -EPROBE_DEFER to wait=
 for
> +                * the provider to appear)
> +                */
> +               return dev_err_probe(dsi->dev, PTR_ERR(dsi->pwrseq),
> +                                    "Failed to get required power sequen=
cer\n");
> +       }
> +
> +       return pwrseq_enable(dsi->pwrseq);
Do we want to add a devm action to disable the pwrseq when the DSI
driver is removed?

Rest LGTM.

Cheers,
Prabhakar

> +}
> +
>  static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
>  {
>         unsigned int num_data_lanes;
> @@ -1454,6 +1477,10 @@ static int rzg2l_mipi_dsi_probe(struct platform_de=
vice *pdev)
>
>         platform_set_drvdata(pdev, dsi);
>
> +       ret =3D rzg2l_mipi_dsi_pwrrdy_init(dsi);
> +       if (ret)
> +               return ret;
> +
>         pm_runtime_enable(dsi->dev);
>
>         ret =3D pm_runtime_resume_and_get(dsi->dev);
> --
> 2.43.0
>
>
