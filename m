Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF305C88E75
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 00:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD5F10E0CE;
	Wed, 16 Sep 2026 00:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="b4jRgCuo";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B27010E0CE
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 00:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789519376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGse0lGtGHSILpOr5QMAUERvmnhcCgoXhrGdKRPvFPo=;
 b=b4jRgCuom9XsjlQvWCzdOJJfsHBtv2U3qHesmFaRLVeCbAmNUSOPMCCFXja7qRvL7aGA68
 zJoYhbSuG1dwyVkeB/yXd2vDWWItQi0E9gWw7AsA8cAZHaPW9LaVMp9S2bSlbvaSE9GScT
 4I+kC4qozCXdsxvzt3WfGBHWYRwfpyQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-PxEU1PBZOI-cewHM3sLkCw-1; Tue, 15 Sep 2026 20:42:55 -0400
X-MC-Unique: PxEU1PBZOI-cewHM3sLkCw-1
X-Mimecast-MFC-AGG-ID: PxEU1PBZOI-cewHM3sLkCw_1789519374
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39deb05ef51so3667508a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 17:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789519374; x=1790124174;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mGse0lGtGHSILpOr5QMAUERvmnhcCgoXhrGdKRPvFPo=;
 b=L2KgEAca8PKp+npVm/suPPpJhMZARPoV05QCtVk6A/1d7L4dgy1uia46lumTnF/J9l
 GPmKNv3pFzPTH3Q6VXL7ERaoGX3lmuqjiknjc8Qok2RAeMi4qd0qB6wRhS1veZ4CXmlQ
 TfPFyZzFcIYzeu+yAcH7h+MgVapD3cvT7e5u0xnmwdL6aZ7ipbk8WorN8VdMCThJRt7v
 qNlXX7Bp3CktIYR8Il2Rei8ysDmfYgwXtNKurjJGSuFC8A99gP1YTQsVDi8BImzEeSzr
 rQ6zrPCRirs79PkcQ5F3fQW0JuXeiN0LQJCjBJeDleAnhKh6NSPypA8dhm9cvzNcJfbf
 QUDQ==
X-Gm-Message-State: AFuF++lAt66ZJxwmnJrF9bEGH373sTo4NTDFYBxIoI88+XsWq1scHtsc
 2HrNeKPVvfnsGlh7jL9jgaVKBq2ve44HW3WWzzpbTOzrsqiGdJEXSx1/Bl0NadRFowONHWJKMDL
 PQAtRtvslrMtI+KEuUTQ88XQyRiz3gxHMtBRGucOBfqsAKois/PkSl8zjue8aoninJDySl18GAn
 NfTE5ypXYsP+jMC/yX70Bl46U6oL0L39ld+RKuZo3l5XwJ
X-Gm-Gg: AYBFou2Q908rUjptZpMYrBnq1z32Qr/eWKKR6iveU1yF1OgWH6WtLmdcjRQRNzroSmx
 yK18kuRnoPdcgUrjeoK7crfMayqS70x2nMH/+4Dvt5QTLHij4XeAfykVkO8C6ge/H9zJOolhLlf
 lPWl1WUXQ/OxxRw1ye6xLfwbxkJRSqVxm6228RtrmT0jKxdGttXBPzUPaD+/at1xL5BpnFELCck
 VmXhYqc4mzlc881
X-Received: by 2002:a17:90b:5281:b0:39d:f050:a010 with SMTP id
 98e67ed59e1d1-39e1e263d08mr1734219a91.1.1789519373699; 
 Tue, 15 Sep 2026 17:42:53 -0700 (PDT)
X-Received: by 2002:a17:90b:5281:b0:39d:f050:a010 with SMTP id
 98e67ed59e1d1-39e1e263d08mr1734159a91.1.1789519373138; Tue, 15 Sep 2026
 17:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260916001603.22394-1-lyude@redhat.com>
 <20260916001603.22394-2-lyude@redhat.com>
In-Reply-To: <20260916001603.22394-2-lyude@redhat.com>
From: David Airlie <airlied@redhat.com>
Date: Wed, 16 Sep 2026 10:42:41 +1000
X-Gm-Features: AcwNN1Vs8ufolmqLJX-ytdf5rJExuz1QFL1qUEVtr1TxWyGYdEA5LkZ7nRPeWL0
Message-ID: <CAMwc25rP6u9=0PxN_OpYUs33cNqoiYYEFpwN4FKPQyHvNb+=Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drm/nouveau/gsp/r535: Add support for
 INTERNAL_GCX_ENTRY_PREREQUISITE
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, 
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kees Cook <kees@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>,
 Mel Henning <mhenning@darkrefraction.com>, 
 Danilo Krummrich <dakr@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JMkLhoDNMjZW33WWDGgCa3TjNhlQkbAfg_0yucSGCPU_1789519374
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

On Wed, Sep 16, 2026 at 10:22=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> OpenRM's runtime PM handling looks a bit different then nouveau's, one pa=
rt
> in particular that differs from us: OpenRM actually consults GSP to ask
> whether the GPU should be allowed to enter Gc6 and/or GcOff before runtim=
e
> suspending the GPU. In the event the card isn't ready, runtime suspend is
> simply delayed for a few seconds before retrying.
>
> Implement the command used for querying GSP about this,
> NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE, and check to ensure that
> the GPU is ready for runtime suspend in nouveau_pmops_runtime_suspend()
> using this query. If the GPU can't be runtime suspended, update the last
> busy counter of the device and then return -EBUSY from
> nouveau_pmops_runtime_suspend() - essentially delaying the runtime suspen=
d
> process by whatever autosuspend_delay_ms is set to.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> ---

>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c b/drivers/=
gpu/drm/nouveau/nvkm/engine/device/user.c
> index 23d11d8221cb6..c47d6daa9e5aa 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> @@ -27,6 +27,8 @@
>
>  #include <core/client.h>
>  #include <subdev/fb.h>
> +#include <subdev/gsp.h>
> +#include <subdev/gsp/priv.h>

Including a priv.h seems like a layering violation.

I think you should define a nvkm_gsp_gcx_ready and then call the r535
via a function pointer in nvkm_gsp_func.


>  #include <subdev/instmem.h>
>  #include <subdev/timer.h>
>
> @@ -189,6 +191,41 @@ nvkm_udevice_time(struct nvkm_udevice *udev, void *d=
ata, u32 size)
>         return ret;
>  }
>
> +static int
> +nvkm_udevice_gcx_ready(struct nvkm_udevice *udev, void *data, u32 size)
> +{
> +       struct nvkm_object *object =3D &udev->object;
> +       struct nvkm_device *device =3D udev->device;
> +       struct nvkm_gsp *gsp =3D device->gsp;
> +       union {
> +               struct nv_device_gcx_ready_v0 v0;
> +       } *args =3D data;
> +       int ret =3D -ENOSYS;
> +
> +       /* XXX: We don't know any way of performing this check outside of=
 GSP, so just assume
> +        * things are ready for non-GSP clients.
> +        */
> +       if (!gsp) {
> +               args->v0.ready =3D NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_=
READY;
> +               return 0;
> +       }
> +
> +       nvif_ioctl(object, "device gcx ready size %d\n", size);
> +       ret =3D nvif_unpack(ret, &data, &size, args->v0, 0, 0, false);
> +       if (!ret) {
> +               nvif_ioctl(object, "device gcx ready vers %d\n", args->v0=
.version);
> +
> +               ret =3D r535_gsp_gcx_ready(gsp);
> +               if (ret < 0)
> +                       return ret;
> +
> +               args->v0.ready =3D ret;
> +               ret =3D 0;
> +       }
> +
> +       return ret;
> +}
> +
>  static int
>  nvkm_udevice_mthd(struct nvkm_object *object, u32 mthd, void *data, u32 =
size)
>  {
> @@ -199,6 +236,8 @@ nvkm_udevice_mthd(struct nvkm_object *object, u32 mth=
d, void *data, u32 size)
>                 return nvkm_udevice_info(udev, data, size);
>         case NV_DEVICE_V0_TIME:
>                 return nvkm_udevice_time(udev, data, size);
> +       case NV_DEVICE_V0_GCX_READY:
> +               return nvkm_udevice_gcx_ready(udev, data, size);
>         default:
>                 break;
>         }
> +       return ret;
> +}
> +
>  int
>  r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_suspend_state suspend)
>  {
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h b=
/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
> index b6683a5bf870c..fd1170037c030 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
> @@ -782,6 +782,13 @@ typedef struct NV2080_CTRL_INTERNAL_INTR_GET_KERNEL_=
TABLE_PARAMS {
>
>  #define GSP_FW_HEAP_PARAM_CLIENT_ALLOC_SIZE      ((48 << 10) * 2048)   /=
/ Support 2048 channels
>
> +#define NV2080_CTRL_CMD_INTERNAL_GCX_ENTRY_PREREQUISITE (0x2080a7d7)
> +
> +typedef struct NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS {
> +    NvBool bIsGC6Satisfied;
> +    NvBool bIsGCOFFSatisfied;
> +} NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS;

Have you confirmed this struct didn't change in r570,

Thanks,
Dave.

