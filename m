Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9917606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lzQ25eWf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C04810E520;
	Fri, 27 Nov 2026 09:33:14 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0821128DD
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:33:08 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2f0414c1062so47337085ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795771987; x=1796376787;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z0HAmZPkkL929InieJ6NG6YqendguBQ6bWYFHNZs/RU=;
 b=lzQ25eWfFPU6XvEatSNr3VcJ6M6e/mOWPUWqetjFi1TYzv4og9HCHufU5b05acPF8m
 rHbyc3XQRWQZ8+z1BIL3ZTV8YM01nLyeSugSv53UisjZPS0AYv9ijA802lh/iotV18h+
 cTU0t9mzEpBwGamOJwjutzkR7qpaHuuqSVmjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795771987; x=1796376787;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z0HAmZPkkL929InieJ6NG6YqendguBQ6bWYFHNZs/RU=;
 b=goeEipEc26AhCdDRIAlNaRcpk81i+q96HV4zVS/ghy03zE0OU6TTQi/IHUqLcmAcoH
 UOTXxgLB2nv1nVrRz/vROJlXhtLjvlq9xSvEJW5Dojd4JcXxgsjzAVngoo7mEsTVjBR9
 kPIosxqJRADqINaESS7V2gr9QoDa7jLsHFVIFJ+zzkOFLeNbAdkN8zpR4XfiW8OfcrcA
 F+BPbcjQQn6h3Z9AdwhyamERASbj377NT3n+hRSb4uejvNNhHe7TqonF1EEON7cnfh10
 QRaNnH+tI7q+VXdnuoQUull3jgam7kTr2U5TjXDy85rxwidtVw583RPF7AYwsr7nEh6S
 Q7Cw==
X-Forwarded-Encrypted: i=1;
 AL+hErGgfc/79irWC5WswxEVmyQ/D1FB5FTGWeKlv8wwpqlcWeFUuO3wFzD4dFP6ha5cXzLXuIKUFzbwa9A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/4BkPCl/+J8A1/6ykWVesauKB03s7/wkjepRqC5jyIBM14X5bo
 PmCFHfffG+BYA/lzRbnBmlYB7h+V4sG34YTc2ebimwk9HZLPPJ6e2b9KjVINfLdbwqLuTqPlEat
 GOZI=
X-Gm-Gg: AZFdTZcO44eikIxT7nQHJ8gbwud1nZW/Wt+j4AmA6kVHbF/EFKXATfa5YBITO+bcuYR
 l13KEx8o/0KiBFvMzImMyYrT/w5v2Bluiz8eHseL5a66TQvHySe6xzr8gIVMF3tRaDlRrTo1DTJ
 xcPUoffLrRrpSYAbqXHbkKCM6P5giPz3KNP77zjbzNH4haNx8y7q71x4G9qBO2n9c4dGdDyIBsk
 LulPklAp3uKcgUvCGkYdcHsF/MakB7BMwXPBBpV005FMq0JsUbErzd8hI9pv95DrjE9MygaWgoB
 b8BELGLNIGpncgn/ugYWnO0CC6Nu0DQk3ZAdK1CoZ54d5vnGsw7CbCYmratEKxMy+2FbpvbM0aR
 4YP1yXQmtl2N04guYCYCf3oRKGWFJzlsMqg/1mOzQrpdhbQcimozJ2TpjY6iekJB/ag+YqcL28P
 PwYYA4HwhJSOke2/ZMMFSSGjSw3wQeLezJuVYBygZHLlFvj4q/tt6rcUJAKxJ/SJAHd8lUy60zt
 xkAEHlIJiP0o/98WuurQ9UwoL7V6oOG00PXwmbUWbRZhIHjRUlQnPIE83ZBj/ZkewqJiSNjpMzQ
 NMRWB22CgULad2LwZU35bzNIiMYGvGqZKQHvp3yU9eBunn6qPEct9dpjvSdPesSQoV8=
X-Received: by 2002:a17:903:350f:b0:2ef:e285:7086 with SMTP id
 d9443c01a7336-2f04eebfe91mr212881565ad.13.1795771987231; 
 Fri, 27 Nov 2026 01:33:07 -0800 (PST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com.
 [74.125.82.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f15663fsm115216075ad.76.2026.11.27.01.33.06
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 01:33:06 -0800 (PST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-385c497bf94so7535464eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:33:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGZGyHMnEVcNHDBvQPcoXC3g1UHaxDeHf5kt90QeF+2ErKdpOHXkvroljZmE7zXd3C3AuRweM7z6/M=@lists.freedesktop.org
X-Received: by 2002:a05:693c:414e:10b0:386:a1ae:6762 with SMTP id
 5a478bee46e88-386a1ae6d5fmr20784587eec.36.1795771985456; Fri, 27 Nov 2026
 01:33:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-38-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-38-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 27 Nov 2026 17:32:28 +0800
X-Gmail-Original-Message-ID: <CAC=S1niK0HHMLpm+i9YLTeASvhM=qDy6oD2t24pa_32wKNsuqg@mail.gmail.com>
X-Gm-Features: Aa3M54pRArGKHVMgeqwG1e8L5StTOP94fleg1U4pb_vICTi6qu6Nmly90U-l36k
Message-ID: <CAC=S1niK0HHMLpm+i9YLTeASvhM=qDy6oD2t24pa_32wKNsuqg@mail.gmail.com>
Subject: Re: [PATCH v2 37/46] drm/mediatek: Prepare path builder for
 multi-controller architecture
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

On Tue, Jul 14, 2026 at 7:46=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for adding support for the new display controllers
> featuring multi-controller w/DirectLink architecture, expand the
> path builder to recognize whether a hardware component in display
> controller related output path is getting its input from internal
> or from any external (to itself, but still internal to the SoC)
> display controller component.
>
> When an output path is found, it is also necessary to understand
> the enablement order (in terms of mmsys/mutex other than PM) of
> the controllers, as that cannot be done randomly: for this, the
> initial path builder will start storing an indication to whether
> a component is either in a leader or in a follower controller,
> and then a new function mtk_drm_set_path_orders(), called when
> binding all components, when initializing KMS, takes care of the
> looping through the path and setting up the order between all
> of the follower display controllers.
>
> As of this point, no multi-controller SoCs are introduced yet,
> so this code will not bring any functional change on any of the
> currently supported SoCs / display controllers.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.c   |   2 +
>  drivers/gpu/drm/mediatek/mtk_ddp_comp.h   |   2 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c    | 374 ++++++++++++++++++++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h    |   2 +
>  drivers/gpu/drm/mediatek/mtk_drm_legacy.c |   3 +-
>  5 files changed, 351 insertions(+), 32 deletions(-)
>
[snip]
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index cccdd58b848a..75b3fd56d6af 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -185,17 +185,26 @@ static int mtk_drm_match(struct device *dev, const =
void *data)
>  static bool mtk_drm_get_all_drm_priv(struct device *dev)
>  {
>         struct mtk_drm_private *drm_priv =3D dev_get_drvdata(dev);
> -       struct mtk_drm_private *all_drm_priv[MAX_CRTC];
> +       struct mtk_drm_private **all_drm_priv;
>         struct mtk_drm_private *temp_drm_priv;
>         struct device_node *phandle =3D dev->parent->of_node;
>         const struct of_device_id *of_id;
>         struct device_node *node;
>         struct device *drm_dev;
>         unsigned int cnt =3D 0;
> +       bool all_privs_found;
>         int i, j;
>
> +       dev_vdbg(dev, "Populating private data for all controllers on ID%=
u\n",
> +                drm_priv->data->mmsys_id);
> +
> +       /* Avoid variable length arrays and allocate an array of pointers=
 to privs */
> +       all_drm_priv =3D kmalloc_array(drm_priv->data->mmsys_dev_num,
> +                                    sizeof(struct mtk_drm_private *), GF=
P_KERNEL);
> +       if (!all_drm_priv)
> +               return -ENOMEM;

mtk_drm_get_all_drm_priv() returns bool. Return false here or change
it to return an int instead.

> +static void mtk_drm_set_path_orders(struct mtk_drm_private **all_drm_pri=
vate)
> +{
[snip]
> +                               /*
> +                                * Paths are per-output: set order for th=
e new output
> +                                * by finding the order of the same outpu=
t number of
> +                                * the previous controller and incrementi=
ng it by one
> +                                */
> +                               src_path =3D &src_priv->data->output_path=
s[i];
> +                               src_order =3D src_path->len ? src_path->o=
rder : 0;
> +                               if (cur_path->order <=3D src_order) {
> +                                       cur_path->order =3D src_order + 1=
;
> +
> +                                       /* Order found: check next CRTC n=
ow! */
> +                                       order_found =3D true;
> +                                       break;
> +                               }
> +                       }
> +               } while (!order_found && max_iterations--);

IIUC, this only works for up to a 3-controller chain, which needs at
most 1 update (0, 1, 1 -> 0, 1, 2). When there are 4 or more
controllers in a chain, it needs at least 2 updates (0, 1, 1, 1 -> 0,
1, 2, 3), but the loop stops after the first update (`break` +
`!order_found`), leaving the orders as (0, 1, 2, 1). On the other
hand, when no updates are needed, `!order_found` spins
`max_iterations` times unnecessarily.
We need a loop that stops only when no more updates are needed, i.e.,
drop `break;` and loop `while (order_found && max_iterations--)`.

Regards,
Fei
