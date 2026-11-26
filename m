Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C707606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=moxIXqf6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FB510FFFD;
	Thu, 26 Nov 2026 07:52:42 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 333C610E73D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:52:35 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2f0426a65e0so42420075ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795679555; x=1796284355;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2BAeP825lkaxoabnMfIBpo2jQjykn0ii0H1E+c/o1R8=;
 b=moxIXqf6d4T9FztX7hXdlJFpqcW+tMYFtb0C8wfyAqwZuljtLR/rsaZO/ZhpQGITgB
 YS6qANMUdyTdiA4UW4Bk4inuhawxIp0fnAueFLfx6Ze04BWXDoDPLUcW0BDR1b1LUDXA
 hdFgM2hM4Lw+IbeZiT22jUqUlCph4MQMCYgNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795679555; x=1796284355;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2BAeP825lkaxoabnMfIBpo2jQjykn0ii0H1E+c/o1R8=;
 b=LFxpjzGUFFh+vIIm7VT/YoNMxOKwqIMDwGAfXlkOyC442s7ll6xIFX+bojPeUY53lP
 7mrVl3RMbJnvEhHhJiqqJhyO/mYo68qBFMR7btkQBYqiYSklFTpRsttBpGXUChFpOlaU
 uw7Hg+7Tpw3FywrOx31foAnI8WLHbEoaft9WlAX4HOdWFH3g+kEZntGpmAYRA7rNxF6c
 kfViJi3VyY5EK/5zmLAm2jSyYy3kc93aYoU0IGxl+aHSZ6pv9g4rcXoWEH1dvynXJdok
 f7rzqvEom0KLp+mtqMI7aEuJxvAGfq42v0O03dTX/YYOQVF7jQBd1numRvCzYPORupRq
 A06A==
X-Forwarded-Encrypted: i=1;
 AL+hErF20jdahpB1d0SwcbdE9M2F1ZdOH3RVFRcQyGo2p7z8oG0ZsQ5+JUzR7o9lXXvr+Tw2T0rprGTHLgI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/h8Y+UjRrb4tFzSXIHFgLhsh6yBtOSj1w4S8dklHbfpNxNZ33e
 3/3n/SUTDBJnw+1IZIKObmwlU2WgYyI1n7J9VafX4k1DYtIJnB17f5q5B+h3mfx0uCnO1qhtaHJ
 QJtMn+A==
X-Gm-Gg: AZFdTZfXGub3JIxUmFdNvay2RS2RyQlWbJxuX7vI2toqTJo/IxCZ2CtgpnM/Estz7W5
 A0ygmpJwGRpWoKaWU1BAOPUo6vc+2xRhEv4S9nCpJGUe7CDZV1HC0cvrrRe+0g/wYQWdqE3lrPK
 CqDrSgtxe7ES3OTpPiomBXlCErXrbLrQryrrSOH83ilRuj/sH/a43Hmm/dq5hpeA9uOkHA7NJ9T
 r6ZO4U4JqhBLgz28owMb2gJX7ao87UY1jXmUGjtDg8NSl6NwGXrZqaB1OSoPT8fBhSeKQJX+oSC
 baTDkpJvViW4swWe3dqovejJEx5j5Q81Jx6Fj1c2ETlYDyKS2Vv5tom+Xqxe6E9xz82iYEAvHYf
 /excm9VFk6u2YthdXelFDFfswCVpVdWwm0Fe/6YxkHMRCI1NLI7osseYF05cN8WRhnI2qzZJ7Vn
 l2Sd0Ckqn63r9BT+MTxAlgTyuiQ2/jMlr2DbI3Id4TqCacVbNrOdfsqD6mDx5WrglH+WobL6w9G
 sXxh/2ephCgjL7RMzFmtx4rPzryRLKJl6C/GGs4B6t/SPP3etWcORXH9KINoyXLSTmq3EnND5ZB
 b0gT4ijfUlF4TkOvbXyRss9JWhL6gm10/8eno2d7GpEN+iizvU0ixxlFXohWM1H9i04=
X-Received: by 2002:a17:902:dac6:b0:2e9:5eee:e085 with SMTP id
 d9443c01a7336-2f03f1d85b1mr150767765ad.19.1795679554512; 
 Wed, 25 Nov 2026 23:52:34 -0800 (PST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com.
 [74.125.82.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f04a49cfffsm90876525ad.46.2026.11.25.23.52.33
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 23:52:34 -0800 (PST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-386c71feeeaso3102172eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:52:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGnDpSPVcPglQLNi5QHYfNBZTTMDWZ7OCwfyrKZZgrpvjd8JjP8Wr9r+osk5vUTfIZWMyTpcCShXVo=@lists.freedesktop.org
X-Received: by 2002:a05:693c:87d8:b0:386:b896:319c with SMTP id
 5a478bee46e88-386b8963d3amr10022337eec.35.1795679552269; Wed, 25 Nov 2026
 23:52:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-18-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-18-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 15:51:53 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngJz=WR=dynO0O4FiAW3rqADNCvEGa9cPn1b-Dfkxi6LQ@mail.gmail.com>
X-Gm-Features: Aa3M54pxRAeFEOdKGCuQ1O6Bt_XOraD0DZxugIMunZCy7TNnnfXexdvBZJe7MKU
Message-ID: <CAC=S1ngJz=WR=dynO0O4FiAW3rqADNCvEGa9cPn1b-Dfkxi6LQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/46] drm/mediatek: Add support for hardware
 multi-stage layers
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

On Tue, Jul 14, 2026 at 7:45=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for adding support for newer, more complex, display
> controllers like the ones found in the MediaTek Kompanio Ultra and
> Genio Pro 5100 (MT8196/MT8894), add support for multi-stage layers
> as in newer hardware, there is a special strategy using multiple
> hardware components of one (or multiple) display controller(s) to
> form one single layer.
>
> Multi-stage layers are one more step towards extra flexibility of
> the Display Subsystem, making it possible to change capabilities
> of Display Controller Pipelines depending on the final application
> of a board: for example, one board may choose to use fewer layers
> per pipeline to achieve more pipelines (more concurrent outputs),
> or more layers to achieve less, but more capable (as in offloading
> and in achievable bandwidth) concurrent outputs.
>
> This currently adds boilerplate to support this hardware, but does
> not yet implement the IP-specific support for MT8196/8894, which
> will be done after all preparation is done.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_crtc.c           | 304 ++++++++++++------
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.h       |  15 +-
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  12 +-
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  12 +-
>  .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |   2 +-
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |   9 +-
>  drivers/gpu/drm/mediatek/mtk_disp_wdma.c      |   2 +-
>  7 files changed, 246 insertions(+), 110 deletions(-)
>
[snip]
> @@ -992,15 +974,15 @@ static int mtk_crtc_init_comp_planes(struct drm_dev=
ice *drm_dev,
>                                      struct mtk_crtc *mtk_crtc,
>                                      int comp_idx, int pipe)
>  {
> -       int num_planes =3D mtk_crtc_num_comp_planes(mtk_crtc, comp_idx);
>         struct mtk_ddp_comp *comp =3D mtk_crtc->ddp_comp[comp_idx];
> +       unsigned int num_planes =3D mtk_ddp_comp_layer_nr(comp, comp_idx)=
;
>         int i, ret;
>
>         for (i =3D 0; i < num_planes; i++) {
> -               ret =3D mtk_plane_init(drm_dev,
> -                               &mtk_crtc->planes[mtk_crtc->layer_nr],
> -                               BIT(pipe),
> -                               mtk_crtc_plane_type(mtk_crtc->layer_nr, n=
um_planes),
> +               struct mtk_crtc_hw_layer *hwlayer =3D &mtk_crtc->hwlayers=
[mtk_crtc->hwlayer_nr];
> +
> +               ret =3D mtk_plane_init(drm_dev, &hwlayer->plane, BIT(pipe=
),
> +                               mtk_crtc_plane_type(mtk_crtc->hwlayer_nr,=
 num_planes),

I hope it's not too late for new comments...

IIUC, mtk_crtc->hwlayer_nr is the CRTC-wide plane index, while
num_planes is only the plane count of the current component.
When a CRTC spans multiple 1-plane components (such as four EXDMA
blocks on MT8196), hwlayer_nr is 1..3 but num_planes - 1 is 0, so no
cursor plane is created.
You might need to forward the CRTC total num_comp_planes to
mtk_crtc_plane_type() instead.

>                                 mtk_ddp_comp_supported_rotations(comp),
>                                 mtk_ddp_comp_get_blend_modes(comp),
>                                 mtk_ddp_comp_get_formats(comp),
[snip]
> +static int mtk_crtc_init_layer_stages(struct mtk_crtc *mtk_crtc)
> +{
> +       unsigned int prev_master_layer_component =3D UINT_MAX;
> +       unsigned int master_layer_component =3D 0;
> +       unsigned int comp_idx;
> +
> +       for (comp_idx =3D 0; comp_idx < mtk_crtc->ddp_comp_nr; comp_idx++=
) {
> +               struct mtk_ddp_comp *comp =3D mtk_crtc->ddp_comp[comp_idx=
];
> +               struct mtk_crtc_hw_layer *hwlayer =3D NULL;
[snip]
> +               if (master_layer_component !=3D prev_master_layer_compone=
nt) {
> +                       hwlayer =3D mtk_crtc_find_hwlayer_with_comp(mtk_c=
rtc, master_layer_component);
> +                       if (!hwlayer) {
> +                               drm_err(mtk_crtc->base.dev,
> +                                       "Could not find layer master for =
%d!\n",
> +                                       master_layer_component);
> +                               continue;
> +                       }
> +                       prev_master_layer_component =3D master_layer_comp=
onent;
> +               }
> +
> +               /* Add the newly found layer stage to the correct layer m=
aster */
> +               hwlayer->layer_stages[hwlayer->layer_stages_nr] =3D comp_=
idx;
> +               hwlayer->layer_stages_nr++;

hwlayer is declared as NULL inside the loop. On a second stage
component for the same master layer, the lookup above is skipped, so
dereferencing hwlayer leads to crashes. Declare hwlayer outside the
loop.

>         }
>         return 0;
>  }
> @@ -1039,6 +1112,7 @@ int mtk_crtc_create(struct drm_device *drm_dev,
>         struct mtk_ddp_comp *dma_comp;
>         struct mtk_crtc *mtk_crtc;
>         unsigned int num_comp_planes =3D 0;
> +       unsigned int max_comp_stages =3D 0;
>         int ret;
>         int i, j;
>         bool has_ctm =3D false;
> @@ -1121,20 +1195,54 @@ int mtk_crtc_create(struct drm_device *drm_dev,
>                                                 &mtk_crtc->base);
>         }
>
> -       for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++)
> -               num_comp_planes +=3D mtk_crtc_num_comp_planes(mtk_crtc, i=
);
> +       for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++) {
> +               struct mtk_ddp_comp *comp =3D mtk_crtc->ddp_comp[i];
> +
> +               num_comp_planes +=3D mtk_ddp_comp_layer_nr(comp, 0);

Passing 0 instead of i here skips the `pipeline_index > 0` check in
mtk_rdma_layer_nr() and over-counts num_comp_planes (also carried into
patch 38/46).
Pass i (j in patch 38/46) as the pipeline index.

> +               max_comp_stages =3D MAX(mtk_ddp_comp_stage_nr(comp), max_=
comp_stages);
> +       }
[snip]

Regards,
Fei
