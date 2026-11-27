Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD6606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cxaJTaQt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D978B10E568;
	Fri, 27 Nov 2026 12:26:34 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85ADC10E568
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:26:28 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8b600fae14dso2936376b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795782388; x=1796387188;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6wJPtmDOKQWl0gKDtiuKlNF32reQWcBhdrSBFhz15UA=;
 b=cxaJTaQtyJA5TgLOhS7DF837uAFFvc0h79kLErQmyb2w0RenWGZO/LBnq+sKtmWKcI
 vYFuPcO4MQctcYyvXvj5anlsYlRk0KgvCc1Oc4RaQYkPrXcc3z3lKvznmPZ7EDn6+i9+
 AopnTBWUJBUKDU+R7MTyujvXHMN9eEtf2oDZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795782388; x=1796387188;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6wJPtmDOKQWl0gKDtiuKlNF32reQWcBhdrSBFhz15UA=;
 b=sL/EhZHtOQLqrhO3pRycjiRy3lCTXnJxC1cFU968zz0CqX6iadJXLlAicDDNtnVXGU
 f8Pbb2Q5htOE7rneyIYxMFmqTOgtsP02d0sDjYySwB5uLKHT8zeyqtTQhYMlsu0U7i02
 lMO9LztC+ILZrZiHVN6GdVQwSJqC0749kYbLclLBcQuGqulu+JZsCf3LXcMkIB2kb76R
 7YBN68PPGW+eW279f7+CHmlQY4IIpqZ7UpjseDELM4fpmLKN2zcLlVvB7HynKxvtAD9x
 FK+tkFxs4qIU8GldPKeMKM/r8sqK3HaN1k8PzGDYxmvCOv++RrGLHVd7FuRahQs2eYbI
 Lqwg==
X-Forwarded-Encrypted: i=1;
 AL+hErHBib5gQbA9Ivl1RXEyqD1cZS8ChULEMBvcADjELasKhq+xr5kejth9Cv08fM7u6NgyhSau2Y4zKqg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/aCfIfOEpML1rsH8c8HKtxBV70kYZLXeaCAZIB/HldVRXjzJfB
 JIoC0c0agi2QQSNgoE0QqghjRVMNO2dLo7eh/jZkI6Nlur/U6x6c8JNMkMLUu8FdnEoUrSAYcCL
 6WvHAhQ==
X-Gm-Gg: AZFdTZcoO+RTTSp8pyfjNWpC6BKSz2bwN6ZtjjFVV0hP4qvJJjf326zg27tRbV/FPcr
 kcA9r4/dCrHMZQbMP8Qomaf3kioe1/uAbCRZoDN5dvfT9pTOv8zzEeB7aZrZWDAuGSE+6FWdTFu
 mqV13OkfOsPi7CjE1Z5/j0bGIzx5TMzi+hDdpk/2xaxvP3oiYJa4jvNp7Y3u619WljToht2LBLc
 bLbLVd04w/UzN4Y8LCfljdPf8E+K9VDcqKKTf3yV8Ac32Lu2tKzev7giOWaxB37v/shZ8iQsRSu
 D0VrNjOtgdB/g+nMEBMMFjwUDhyujotgXx7P/bxarLKc+p5epZ0I8yORFxX6YpV9viYjKRw6ghW
 TbkcdjxJJTvWuUuVGXBhe5D3pfZGmySVJXQeElgSA3AVDCRDTHpmij5S8mFn1IQUS5PN2wXS5o6
 Lo9hapiT/aA0b41nYBJH3EHe2tNEW9KzLaGVkkOpZ0nLhIDYJKLwEvfNzA30nwvkFo53sHQfeqP
 E2L3chN7IPTkuiOqlFjYCQEmkLYZ1048JA3Od6XI+DzUwT27nagv6TrLmQNkw87G+O61XYgxjWE
 lDXlLOd8M/1eZHyHbW251dtEqDE8woxRGTtwzC0Bm+Vw+1Dz1EWgvQIYkguGz3BDHlE=
X-Received: by 2002:a05:6a20:3ca2:b0:3f8:99b4:bef7 with SMTP id
 adf61e73a8af0-4014a17aa7emr29605266637.7.1795782387873; 
 Fri, 27 Nov 2026 04:26:27 -0800 (PST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com.
 [74.125.82.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077babfsm12672117b3a.5.2026.11.27.04.26.26
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 04:26:27 -0800 (PST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-38692f62b22so10827045eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:26:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErE+0JyX/J8bdmSW+qhjdPBEtzFFcbKi1kT5Ctw/EGD+u8ljompzLA4KmuMTXlK3IcAHcmuXB78u2dQ=@lists.freedesktop.org
X-Received: by 2002:a05:7301:4d0c:b0:376:a6d7:8f6f with SMTP id
 5a478bee46e88-3856ec3ec8bmr25649718eec.17.1795782385135; Fri, 27 Nov 2026
 04:26:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-47-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-47-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 27 Nov 2026 20:25:42 +0800
X-Gmail-Original-Message-ID: <CAC=S1nh8TnQeGfW+At1vCs3ie=7EYiG2R9xSTyfZ1A4mW0+CGQ@mail.gmail.com>
X-Gm-Features: Aa3M54p-uqcPZ0BTjnlZ-C4P_vANwYAAc7cv53pfujMjetYD2ahEumQx7Kd9jG4
Message-ID: <CAC=S1nh8TnQeGfW+At1vCs3ie=7EYiG2R9xSTyfZ1A4mW0+CGQ@mail.gmail.com>
Subject: Re: [PATCH v2 46/46] drm/mediatek: mtk_drm_drv: Fail init only if all
 paths are invalid
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, kernel@collabora.com
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

On Tue, Jul 14, 2026 at 7:47=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Up until now, if not all display controller paths were valid, the
> driver would fail probing and refuse to bind components: while
> that was a good idea before, now that mediatek-drm gained much
> more flexibility, it is finally possible to gracefully handle
> this situation and register only the valid paths while leaving
> the invalid ones unregistered, without any crash.
>
> Count how many output paths are found, and then count how many
> have failed probing: if there is at least one valid path, avoid
> erroring out, so that at least some outputs will just work.
>
> Of course, any path failing is not a clean situation and must be
> resolved: in this case, function mtk_crtc_create() still prints
> error messages so, even though some output works, that will not
> go unnoticed, as a quick check in kmsg will show the errors that
> made a certain path not to register.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 82d844b6abf7..7c9cb50909c8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -394,6 +394,8 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>         struct mtk_drm_private *priv_n;
>         struct device *dma_dev =3D NULL;
>         struct drm_crtc *crtc;
> +       int num_failed =3D 0;
> +       int num_paths =3D 0;
>         int ret, i, j;
>
>         if (drm_firmware_drivers_only())
> @@ -460,15 +462,29 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>                         if (!priv_n->data->output_paths[i].len)
>                                 continue;
>
> +                       num_paths++;
> +
> +                       dev_vdbg(drm->dev,
> +                                "[CTRL%d-CRTC%d] Path Len:%d, Controller=
 Order:%u\n",
> +                                j, i, priv_n->data->output_paths[i].len,
> +                                priv_n->data->output_paths[i].order);
> +
>                         ret =3D mtk_crtc_create(drm, i, j,
>                                               priv_n->data->conn_routes,
>                                               priv_n->data->num_conn_rout=
es);
> +                       if (ret =3D=3D 0)
> +                               break;

Since patch 38/46, mtk_crtc_create() already combines all controllers
(`order 0..N`) for `output_paths[i]` into one CRTC, so only the leader
(`order =3D=3D 0`) should call it.

Relying on `if (ret =3D=3D 0) break;` instead of filtering `order =3D=3D 0`=
 has
a few issues:
- If a follower (`order > 0`) appears before the leader in
  `all_drm_private[]`, `mtk_crtc_create()` gets the follower's `j` as
  `priv_data_index` (setting `mmsys_dev`, CMDQ, and `conn_routes` from
  the follower) and breaks before reaching the leader.
- If `mtk_crtc_create()` fails, the loop retries it on every remaining
  follower for the same CRTC.
- Patches 38/46..45/46 don't have this `break;` yet and register
  duplicate CRTCs for each follower.

Skip `priv_n->data->output_paths[i].order > 0` in the loop (starting
in patch 38/46) instead of breaking on `ret =3D=3D 0`.

Regards,
Fei

>
> -                       if (ret)
> -                               goto err_component_unbind;
> +                       num_failed++;
>                 }
>         }
>
> +       if (num_failed =3D=3D num_paths) {
> +               dev_err(drm->dev, "No valid Display Controller path! Goin=
g out.\n");
> +               ret =3D -ENODEV;
> +               goto err_component_unbind;
> +       }
> +
>         /* IGT will check if the cursor size is configured */
>         drm->mode_config.cursor_width =3D 512;
>         drm->mode_config.cursor_height =3D 512;
> --
> 2.54.0
>
>
