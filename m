Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E68606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FyVcUUB9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB48112A1D;
	Fri, 27 Nov 2026 10:50:28 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1624C112A1D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:50:23 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8b5e5e64494so4239830b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795776622; x=1796381422;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g2Ork4q/Fz0rgLCbWsmRNw5g1k58/a2ERyPtpHF+EsU=;
 b=FyVcUUB9e2zyR3CQzDUNW0ZF7FR0hQs3gjSWzWu9sYXqE/A6xrJ5UCzfCyUhIlfVSN
 q8A7EYeRmihFs+7gvYcfikI9DDD/k8o/vRru7CPbDXrU2/ghywcqffRDPwBA9iBJTG5m
 +zcT2gErvWepLqoK7d/Kq7Oao8bu+IB6zx0EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795776622; x=1796381422;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g2Ork4q/Fz0rgLCbWsmRNw5g1k58/a2ERyPtpHF+EsU=;
 b=UM+PxjeJwz09pWPWaLF5ohy0ZM9r583Hqf0JFTNcCdlGxt4ufraWRQOmQdlpxh+BfA
 ReZNh4i8yEv+QYnFD65qybQT68gIVqSWS8pwgOq2vehf+KP0wQ4AGH9kvIHhxPJoOQKr
 cFWw4yvp0GiSnCLfKpVACgM3fRsB3SGiymTLBeB5C8tqp8iWhEXS2YGlZgHVDt6rkAZM
 ZNBzY3EA7Bkesy5lpITGyz5mBxKOWob+QQSOsDk0LeGP4C6orxJQcWQZTN/n0EwJ3hw2
 HYrYtNCpDLZcD66TPWZuNXZW4tXbE8YZCk3ul1bRhFzb8DcXC6ETa5FteXZ/PrefzUs3
 W2pQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEiZXcF0EhLf3R/RmMIMV1jBupw7W4U0KXvxv+BnLQvGbJZUH5DHQ5PWZ40CO4kI7fhZQhvvwY4jww=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8MEYtdNGGII4xqWWNGUpz9CH5j0Db0yTWE+1Ya1FIMVqE3uSGp
 lqJ/VFnoXIBPqPYaiDzqLdPmPDL6PE9jfr1Pegg/FLtst17nM7x4ZLw+ej5HuIun+eEd5WbdL6D
 5u2U8Gw==
X-Gm-Gg: AZFdTZcsFp7PZrgXdb7zBVkqrbuyNuhgKX364a4NA9+WJGg1OnvFMXz9aM5P4/ncEin
 b9NFflx5/EVe2H+iyJGus5oBzy6nR60+pk2T68Muh1Pu7Tv/DNJ44zSwLzs35PQAdTqZMfSR/KQ
 d6+UoWl/QN3tPXtHQacQ54hBik+kdYD1E280duj4nonVy/Gsim+M0Y2dw6EM/3klPUktR1DZlRW
 ymt9IMr115qxzL7M4IWF1wnO12JSKM0EfroUZyVxQX2fpU3lPMh2y/OpN7QE9pGY85P1nHMmZz3
 AnxXkemqBj9hXZkno1sITv1pYfIOHPYxS1SxP9FV33mk2NrasB7TdT9Y8nckSmtU7VNDnpBcKy+
 MSKTVa6jB/Vbb62Hgl1p9cWkYlpOVHm9GanA+mn3r38spZCITaz9o1XJ42cjdtlHS7hHoU6nLar
 nytnpAboRHyJF6xNBk1mjrH/sWCsIGIrqWiSMzrfcFhPYWL8VlD5A93tbaCMkyytctoQKral8nG
 d9aV/2x1CYp/+IXYVEESGpGoJPNsdMiUJqzZDTS5Ho9N2G+Pq9nGE8aO2sDO0SPBEWhs9BDu3V7
 JgodrTvvRloo4HtzA8E4/LQjlZt4A9ADc3qPbVLNcg6bo2bZuyv5GCEHGe6tJf1YPBU=
X-Received: by 2002:a05:6a00:32cb:b0:848:77b3:579a with SMTP id
 d2e1a72fcca58-8c87b8da4f3mr22988331b3a.17.1795776622496; 
 Fri, 27 Nov 2026 02:50:22 -0800 (PST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com.
 [74.125.82.170]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87344184fsm12727257b3a.35.2026.11.27.02.50.21
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 02:50:21 -0800 (PST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-386bd881d39so8853515eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:50:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErHDCjfVI68wxNie3h9o0/ChWK7L29Qc5Fi/0PAa/zcRzmAnnLfRUSblQa63x51ouvye4UznQ931mkc=@lists.freedesktop.org
X-Received: by 2002:a05:7300:824b:b0:386:9c6a:3e87 with SMTP id
 5a478bee46e88-3869c6a3f0fmr19991102eec.15.1795776620365; Fri, 27 Nov 2026
 02:50:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-39-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-39-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 27 Nov 2026 18:49:41 +0800
X-Gmail-Original-Message-ID: <CAC=S1njuORK1R2QCwjh1Lk1yw15Povito9qr1ZV6QP-Dw=oY9Q@mail.gmail.com>
X-Gm-Features: Aa3M54rQkdVsbW33JjuQjGjC9MCiVwfA-JMszG-a0o7TcRXKKUJN-zbdfm4qHSM
Message-ID: <CAC=S1njuORK1R2QCwjh1Lk1yw15Povito9qr1ZV6QP-Dw=oY9Q@mail.gmail.com>
Subject: Re: [PATCH v2 38/46] drm/mediatek: Enable bring-up of
 multi-controller CRTC paths
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
> Introduce support for actaully bringing up a full crtc path that
> features multiple display controllers: this enables acquisition
> and writing to multiple MMSYS and MuteX instances to connect the
> multiple display controllers and enable trigger signals from the
> various hardware sub-components at the same time.
>
> This currently only works for rather rare display pipelines that
> can make use of multi-controller without DirectLink architecture.
>
> This change is also the final preparation to introduce support
> for handling DirectLink Display Controller paths, found in the
> MediaTek Kompanio Ultra MT8196, Genio Pro 5100 MT8894 and also
> in the Dimensity 9400 MT6991, Dimensity 9500 MT6993 SoCs.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_crtc.c     | 513 ++++++++++++++++++------
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.c |   6 +-
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.h |   4 +
>  3 files changed, 398 insertions(+), 125 deletions(-)
>
[snip]
> +static int mtk_crtc_init_multi_controller_properties(struct device *dev,
> +                                                    struct mtk_crtc *mtk=
_crtc)
> +{
> +       struct drm_crtc *crtc =3D &mtk_crtc->base;
> +       unsigned long controllers_mask =3D 0;
> +       struct mtk_drm_private *priv;
> +       unsigned int i, j, k, z;
[snip]
> +                       mtk_crtc->controller_idmap[z] =3D mtk_crtc->ddp_c=
omp[j]->controller_id;
> +                       z++;

`z` is uninitialized.

> +       for (i =3D 0; i < mtk_crtc->num_controllers; i++) {
> +               u8 controller_num =3D mtk_crtc->controller_idmap[i];
> +               struct mtk_drm_private *priv =3D mtk_crtc_get_controller_=
priv(mtk_crtc, controller_num);
> +
> +               if (!priv)
> +                       return -ENODEV;
> +
> +               mtk_crtc->mutex[i] =3D mtk_mutex_get(priv->mutex_dev);
> +               if (IS_ERR(mtk_crtc->mutex[i])) {
> +                       ret =3D PTR_ERR(mtk_crtc->mutex[i]);
> +                       dev_err(dev, "Failed to get Controller %u MuteX: =
%d\n", i, ret);
> +                       return ret;

If a later iteration fails, the mutexes claimed in earlier iterations
are leaked. Unwind them with mtk_mutex_put() on error.

> -       ret =3D mtk_crtc_find_suitable_dma_dev(priv, mtk_crtc, output_pat=
h);
> +       ret =3D mtk_crtc_find_suitable_dma_dev(mtk_crtc);
>         if (ret) {
>                 dev_err(dev, "Could not find appropriate DMA device!\n");
>                 return -EINVAL;

This is a legacy direct return. It needs to jump to a cleanup path below.

> @@ -1446,4 +1700,19 @@ int mtk_crtc_create(struct drm_device *drm_dev,
>         }
>
>         return 0;
> +
> +err_free_idmap:
> +       devm_kfree(dev, mtk_crtc->controller_idmap);
> +err_free_layer_stages:
> +       for (i =3D 0; i < num_comp_planes; i++) {
> +               struct mtk_crtc_hw_layer *comp_plane =3D &mtk_crtc->hwlay=
ers[i];
> +
> +               if (comp_plane->layer_stages)
> +                       devm_kfree(dev, comp_plane->layer_stages);
> +       }
> +       devm_kfree(dev, mtk_crtc->hwlayers);
> +err_free_crtc:
> +       devm_kfree(dev, mtk_crtc);

Before these error jumps, mtk_crtc_init_comp_planes() and
mtk_crtc_init_drm_crtc() have already linked `drm_plane` / `drm_crtc`
structs into `.plane_list` / `.crtc_list` under `drm_dev->mode_config`
(via drm_universal_plane_init() / drm_crtc_init_with_planes()), so
freeing `mtk_crtc->hwlayers` and `mtk_crtc` without calling
drm_plane_cleanup() and drm_crtc_cleanup() can cause UAF. Please clean
up the registered planes and CRTC before freeing them.

Regards,
Fei
