Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45BFC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 22:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED4D10E97A;
	Mon, 17 Aug 2026 22:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="foaE+o5M";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AF810E97A
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 22:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787007548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tSiH1P+fBNDANlZzUdXC104+3CpOjWZPNRA5qqe4Zw=;
 b=foaE+o5MaZq8ghKGdeWZZEfk7ibCQ+E5A0X/NiOwT8YTIAhVSd0SvOrhxDLlIx0qN6xdBY
 RHvuFYL8MztZwV9TmNTyqMQ416dpGfEwsRwbt0wNOszvDw8XB9jq8fYd242jQac18q2FQ9
 wwrofO2zft6I0tF/SFvzCgzyqA11sp8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-7bcT4mysPFqkYvkX_UxcAA-1; Mon, 17 Aug 2026 18:59:06 -0400
X-MC-Unique: 7bcT4mysPFqkYvkX_UxcAA-1
X-Mimecast-MFC-AGG-ID: 7bcT4mysPFqkYvkX_UxcAA_1787007546
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so47448285a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787007546; x=1787612346;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rqGWJx78v4FRAZeWcBTMQYlunIdCeO9TuaYZ3v3TiUs=;
 b=PR7xs48+JCbEYVS1tdYIO77lRnG4+zwRG4FTZdo2irlnPPR0B+I+YntXRo4GMOwihf
 BqCcje85RL2FX1oEh3ooU0iu8JmVcS6bxshdRESNAnRvxO0NJKmY1LEyTXbnrv/RcQNE
 eYh3/BjKdlAyI2cu6ezM/xJF/2DsHET/dO0Iy+neyOKbqWSFktVJm+QWkZin6bscmzmN
 mCvW+a90tuCkZuZQxYIJ5VbsD60cFfN33A0Ng56u/f5htJj3qku0KDZDlbDkPiSm6Igh
 MNEHBfe6cL/4fawqJ4MkJGyW8CYF4Y+vxIrptmX+025xxLkJAbClxFY/SiG6je70Vzy1
 Y+Pw==
X-Gm-Message-State: AOJu0YxgQ7j7oiVOuNvPT9Wj11vUefMwHVwOMnnKda6idvQ8Ni/xpwVp
 jxr9sSPUd0XqOZk6oWzOb0hNUw2k+cbDmwf6kwTILDc7DueAMTRSqricyvJmaE2d8CstySc7uHU
 Dz/U6rIKJPEBs5Dviz2qPPSf/U5OYCgsx/LNRBOZnW44bYhpxLLe6BjjkJt1zqto8bcEx1g==
X-Gm-Gg: AR+sD12OfnNz0ApOY2ZAQWMcqlU6kZ5AIOrxDQL+8h8SEI45AhZuEiMrZEKwA5lWOFi
 xgTuhbRlgg2LKad0Dptd49o8cMjfSLXy+XNPzIq0Jo1pa2culXJsTk8uL7oTkbtfUDqsubAsVCu
 6/sHnjpDfMJKyCkE7x7r/tdTq5yeeXqOBqGC45Gyjk5u7ssWBIRUNHTZhUcCFuQLAidGgpWfeJ7
 wtz4x5P1dUFjp8uB6ryoHe5wzOE3cYk60FPd4xua8jmfmGffLvRmKHt9L8SNVZlfnC9//A5rqO1
 GhPX81SVUTpTHYEv39kIxfimeiW3SwwUCxARMUBbqfjLoVTknh9KfMi61uf/omYjzpDLLj3z
X-Received: by 2002:a05:620a:3190:b0:936:c5da:ea88 with SMTP id
 af79cd13be357-9370657081fmr306723285a.7.1787007546111; 
 Mon, 17 Aug 2026 15:59:06 -0700 (PDT)
X-Received: by 2002:a05:620a:3190:b0:936:c5da:ea88 with SMTP id
 af79cd13be357-9370657081fmr306719985a.7.1787007545687; 
 Mon, 17 Aug 2026 15:59:05 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937033cd76fsm154185485a.29.2026.08.17.15.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 15:59:04 -0700 (PDT)
Message-ID: <996d2033b1522090867e50f181e9b4daaab19861.camel@redhat.com>
Subject: Re: [PATCH 5/7] nouveau/gsp: fix vblank interrupts on GB20x
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Mon, 17 Aug 2026 18:59:03 -0400
In-Reply-To: <20260814235705.59132-6-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-6-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9wf-TgoqArN3wF8sk8glJE0SWxK2wtDpwZlNi1JL1h8_1787007546
X-Mimecast-Originator: redhat.com
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

On Sat, 2026-08-15 at 03:57 +0400, Mohamed Ahmed wrote:
>=20
> +
> +static const struct nvkm_head_func
> +gb202_head =3D {
> +=09.state =3D r535_head_state,
> +=09.vblank_get =3D gb202_head_vblank_get,
> +=09.vblank_put =3D gb202_head_vblank_put,
> +};
> +

You should probably add these two as well:

=09.state =3D gv100_head_state,
=09.rgpos =3D gv100_head_rgpos,

I don't think they've actually changed in blackwell, but it's possible
maybe they do change in GB200x so you probably want to double check so
we don't lose precise vblank timestamps again.

> =C2=A0static struct nvkm_conn *
> =C2=A0r535_conn_new(struct nvkm_disp *disp, u32 id)
> =C2=A0{
> @@ -1496,6 +1523,20 @@ r535_disp_intr(struct nvkm_inth *inth)
> =C2=A0=09return IRQ_HANDLED;
> =C2=A0}
> =C2=A0
> +static irqreturn_t
> +gb202_disp_intr(struct nvkm_inth *inth)
> +{
> +=09struct nvkm_disp *disp =3D container_of(inth, typeof(*disp),
> engine.subdev.inth);
> +=09irqreturn_t ret =3D r535_disp_intr(inth);
> +
> +=09/* The FE interrupt vectors are message-based on NVD5.0. Re-
> arm the
> +=09 * low-latency vector so it fires again for any event that
> latched
> +=09 * while we were servicing.
> +=09 */
> +=09nvkm_wr32(disp->engine.subdev.device, 0x611f34, 0x00000001);
> +=09return ret;
> +}
> +
> =C2=A0static void
> =C2=A0r535_disp_fini(struct nvkm_disp *disp, bool suspend)
> =C2=A0{
> @@ -1568,7 +1609,9 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> =C2=A0=09struct nvkm_device *device =3D disp->engine.subdev.device;
> =C2=A0=09struct nvkm_gsp *gsp =3D device->gsp;
> =C2=A0=09const struct nvkm_rm_api *rmapi =3D gsp->rm->api;
> +=09const struct nvkm_rm_gpu *gpu =3D gsp->rm->gpu;
> =C2=A0=09NV2080_CTRL_INTERNAL_DISPLAY_WRITE_INST_MEM_PARAMS *ctrl;
> +=09nvkm_inth_func intr_func;
> =C2=A0=09unsigned long mask;
> =C2=A0=09int ret, i;
> =C2=A0
> @@ -1722,7 +1765,12 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> =C2=A0=09=09nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
> =C2=A0
> =C2=A0=09=09for_each_set_bit(i, &disp->head.mask, disp->head.nr)
> {
> -=09=09=09ret =3D nvkm_head_new_(&r535_head, disp, i);
> +=09=09=09const struct nvkm_head_func *func =3D
> &r535_head;
> +
> +=09=09=09if (gpu->disp.class.root >=3D GB202_DISP)
> +=09=09=09=09func =3D &gb202_head;
> +
> +=09=09=09ret =3D nvkm_head_new_(func, disp, i);
> =C2=A0=09=09=09if (ret)
> =C2=A0=09=09=09=09return ret;
> =C2=A0=09=09}
> @@ -1766,12 +1814,21 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> =C2=A0=09if (ret)
> =C2=A0=09=09return ret;
> =C2=A0
> -=09ret =3D nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type,
> disp->engine.subdev.inst);
> +=09if (gpu->disp.class.root >=3D GB202_DISP) {
> +=09=09/* GB20x deliver head-timing interrupts on the
> display's
> +=09=09 * separate low-latency vector (interrupt table
> instance 1).
> +=09=09 */
> +=09=09ret =3D nvkm_gsp_intr_stall(gsp, disp-
> >engine.subdev.type, 1);
> +=09=09intr_func =3D gb202_disp_intr;
> +=09} else {
> +=09=09ret =3D nvkm_gsp_intr_stall(gsp, disp-
> >engine.subdev.type, disp->engine.subdev.inst);
> +=09=09intr_func =3D r535_disp_intr;
> +=09}
> =C2=A0=09if (ret < 0)
> =C2=A0=09=09return ret;
> =C2=A0
> =C2=A0=09ret =3D nvkm_inth_add(&device->vfn->intr, ret,
> NVKM_INTR_PRIO_NORMAL, &disp->engine.subdev,
> -=09=09=09=C2=A0=C2=A0=C2=A0 r535_disp_intr, &disp-
> >engine.subdev.inth);
> +=09=09=09=C2=A0=C2=A0=C2=A0 intr_func, &disp->engine.subdev.inth);
> =C2=A0=09if (ret)
> =C2=A0=09=09return ret;
> =C2=A0
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> index 996941c668ba..2590b22663cb 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> @@ -44,6 +44,14 @@ r570_gsp_xlat_mc_engine_idx(u32 mc_engine_idx,
> enum nvkm_subdev_type *ptype, int
> =C2=A0=09=09*ptype =3D NVKM_ENGINE_DISP;
> =C2=A0=09=09*pinst =3D 0;
> =C2=A0=09=09return true;
> +=09case MC_ENGINE_IDX_DISP_LOW:
> +=09=09/* GB20x+ report a separate low-latency display
> vector, used
> +=09=09 * for head-timing interrupts. Expose it as a second
> DISP
> +=09=09 * interrupt instance.
> +=09=09 */
> +=09=09*ptype =3D NVKM_ENGINE_DISP;
> +=09=09*pinst =3D 1;
> +=09=09return true;
> =C2=A0=09case MC_ENGINE_IDX_CE0 ... MC_ENGINE_IDX_CE19:
> =C2=A0=09=09*ptype =3D NVKM_ENGINE_CE;
> =C2=A0=09=09*pinst =3D mc_engine_idx - MC_ENGINE_IDX_CE0;

