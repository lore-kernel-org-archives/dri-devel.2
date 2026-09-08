Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57C0C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1E510E9F0;
	Tue,  8 Sep 2026 05:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TK/yG1AV";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37EB710E9F0
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 05:17:26 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-66fc7196ca0so2389670d50.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 22:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788844645; cv=none;
 d=google.com; s=arc-20260327;
 b=RaKq6RTzf9LRpc9zcOFguRufzJ4P6OjwllIlHYAOplJdInI3+g+s9g94guFpMzBUSx
 DCOd/9i25kNie2z9w5bY6+CmXdoKARamLIm14odutP6qyiLKWnZEq7rDQDqLmIxbB/cM
 R1ViVTCmaxTkuv/97w5asVmzL/MUxGNlaCKhsmuXjBNPOt5J68VspADunQe+QzlKSRrQ
 /ZkYTVcqI6pgohkEcaGbl5xObIQcdCaFqHdPQEhsmc8lw+CJrAdk1mdLi28FvlU8PLop
 0/KolokXrEo1pb412Mbyc5ybfgVUdWcELXdcN9WXjBEYWAhmSW9Ee3VAMJwFAe5l3ZlV
 xaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7FCFgCrO8nYxa4w36rz8tfzjeCQplkAjHhgkmQ0tkA8=;
 fh=bJnCt/34SShorKEiVZ5JBNsml96m4cWEDbffbUA55eE=;
 b=MZhom/jyC23CD/B9w5UoQGLlMX/m2XrRH9c0CpUnhVqqGCXC2M0vsm5WmjZABNQJBy
 Cy42HUIM8hFm49lc+gbGfV3sLsWJIGvU7CrOrCT1tI7xxiRbbKw/ra1Xe+9NEvcTol4N
 6k/DpjzB5mpZoB1uo2Ex+PwmXjUyvQv/FbchwF5aaggCEMgk1xaKON8h6wPlICDluicC
 0lB0m+SezGbxPCDB8JVG+YNoTRmGUn3RpNCbrGtOB15Lwn5R8IDKn1ffo9YprbR3BPi6
 Ti7ZZsK3t0dtzTumQYmRc+R/hXhN2wvaTEeSXq7idVK6gnQNr5I8yBq8Iciz6P+dZzyv
 LZ9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788844645; x=1789449445;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7FCFgCrO8nYxa4w36rz8tfzjeCQplkAjHhgkmQ0tkA8=;
 b=TK/yG1AVCHzuPGs2E4JALlf7zUXv6vThNwIz2hMpJerx2DfO1oX3TXchJ3b1wbqTGG
 e+norY29+JbnV35NsEZ6X5vXlWNHLgFpPh9SZBoDobbi6fo6pCAeY4cEGGGe3Y30SmZg
 JcTyBxxReuzJkEIT2SKJOi5iFWUsxvd/j8iJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788844645; x=1789449445;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7FCFgCrO8nYxa4w36rz8tfzjeCQplkAjHhgkmQ0tkA8=;
 b=hy/5tOImMAm9uKzoQEfZEwwZKYw7szXXbNQzcdKXQG0D5rGSVk6nUQFQl5fzi2oIZi
 clE8ITkenOfNmgoyJCp+e97DXRsC1S1xdT19ZOzyoC7ehDEPCletEfk6+elb/u0LUIxf
 jZsLa2m6ZDXwIjQR7z8s5tdsFxBIzeii0RVlQiyFYs0hoevnNVVHzga2a8mZ63LAiH6O
 TpyoCB6lBNq8yN1BDA3FbEICtUqpxAXxnEYL+uUX95Ke4YDmCUrHYe4w37GveA8MEW1S
 2IXqh66Z9p2V6RScOxOwJsSpwzcLmKx2BdCqklAwRGyX+m9SIjSe9UW3EjF92Nd7TP/2
 k/Sg==
X-Gm-Message-State: AFuF++ngalT/G4SV0qtXruVxE725dfxNXj2R/hqtFVVdShJaptk5Tl3t
 1uDkbAVgOA4VXYSene3QI56G75yTUPN1Ol10ksU+cE5arv/2b47zsmGB9MoA9piWReEvlelvalH
 pAKQxV6ZWXL6SZIT/4ddDaFLpVakY6S+ziK95Y7Ga
X-Gm-Gg: AYBFou1pzo1dt9UsgvOeIJhPnWJskxG6BoT/2GC3PVaRn9mDvVOWUf/3gTtj2uEEuu4
 7zCncRXYiQsyTa109GJ7V3ke6QVtmBUHs6Kv/PkZhiSpD7Bq5bTL6pj6/dY7YY1O5/WGEYOjX//
 GfZInWxCBX1yDBC8s+CnfwxIcDCbh00/DnH3WagYQ+nus6yyMBJLnEMAsdFB4WFGVVeBrX/I67V
 P4Fx75v3g/hzQYtdSAG7rZkBohDlQxsKWmH47ThVEpoPNDXksBBcPeQIJ8kZ7vFkeYPSIqUsyty
 eFveRyOfrCfT0gE1SAwNpDCadWLyNeL8Ka9L2o+c/JiZl2dddutp8rVpPUBNWS3O4Zn239fkJNI
 =
X-Received: by 2002:a05:690e:d49:b0:66f:c1bc:87db with SMTP id
 956f58d0204a3-66fc1bc8991mr4871587d50.52.1788844645029; Mon, 07 Sep 2026
 22:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260908050229.754977-1-wenst@chromium.org>
In-Reply-To: <20260908050229.754977-1-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 8 Sep 2026 13:17:13 +0800
X-Gm-Features: AcwNN1UvbZam4KMBF7rri3O2usHHuyHcUFKj6A3hEX1XxQedM-d5CJUALYS2SIM
Message-ID: <CAGXv+5FjHY36sHc+osF2ENjpz9Y97WDCzFEE0c+unXtyxR23Dw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/sun4i: Align VI buffer addresses for subsampled
 formats
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

On Tue, Sep 8, 2026 at 1:02=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> Commit 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to
> get display memory") dropped the code to calculate the framebuffer's DMA
> address in favor of drm_fb_dma_get_gem_addr().
>
> This turned out to be wrong in a couple ways. The hardware can handle
> pixel offsets within a sub-sampling block, but the buffer address must
> start at the beginning of the subsampled block for all planes. The
> hardware then does the interpolation internally. However the helper
> gives the address exact pixel for luma, which messes up the result.
>
> Instead of reverting the commit, calculate the intra-block offset and
> adjust the buffer address so that it points to the start of the block.
>
> Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to=
 get display memory")
> Cc: <stable@vger.kernel.org> # 7.1+
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Please ignore this one. As Sashiko pointed out, this could underflow the
buffer address.

Instead this should be sent along with another fix I have that switches
this back to the clipped buffer address.


Sorry for the noise.

> ---
> This is an alternative to Jernej's original revert:
> https://lore.kernel.org/all/3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785=
772659.git.jernej.skrabec@gmail.com/
> ---
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index 2e9cda45c04e..185e9e5211c1 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -207,6 +207,20 @@ static void sun8i_vi_layer_update_buffer(struct sun8=
i_layer *layer,
>                 /* Get the start of the displayed memory */
>                 dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, i);
>
> +               /*
> +                * The mixer can handle odd offsets into sub-sampled YUV
> +                * planes, but needs the address of the first pixel in ea=
ch
> +                * sub-sampled block. Adjust the luma buffer address back=
wards.
> +                */
> +               if (i =3D=3D 0) {
> +                       u32 x_diff, y_diff;
> +
> +                       x_diff =3D (state->src.x1 >> 16) & (format->hsub =
- 1);
> +                       y_diff =3D (state->src.y1 >> 16) & (format->vsub =
- 1);
> +                       dma_addr -=3D y_diff * fb->pitches[i];
> +                       dma_addr -=3D x_diff * format->cpp[i];
> +               }
> +
>                 /* Set the line width */
>                 DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
>                                  i + 1, fb->pitches[i]);
> --
> 2.55.0.979.g7e5102b832-goog
>
