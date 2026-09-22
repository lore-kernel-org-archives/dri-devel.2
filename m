Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31A6C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9BE10E71A;
	Tue, 22 Sep 2026 15:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YWlkcbl/";
	dkim-atps=neutral
Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com
 [74.125.231.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF0010E71A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 15:06:09 +0000 (UTC)
Received: by mail-oi2-f12.google.com with SMTP id
 46e09a7af769-800ba39944eso6146a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790089569; cv=none;
 d=google.com; s=arc-20260327;
 b=T/qnoeJ4KMAJNyLpYJYfGexnXN9EwkuEtsy7c8p5NPfhE68yzbvXAVz8gkSFxOCGzn
 ECtMvfuVHqw3N1t2T56hwnz4k1GE2EiBw1hSspqMOOUUhmtgh8cqDbL0ZhdjY0C0IAOe
 Mb/iB+/1bIIdj+OJ67EP8hyGDEBkzuaaYGokRJbQp4Om3mpjWuSniw3VQrCfiple68gq
 NSrdtv6kt9yg2rIeDnC+1Cotp1RDGfgEkJle6ZdhlF1bJ+kqDlrriWzUF/MOd4wBneRg
 j2G9Bd9EgWCC0QpUaUxo9S7SmxCWbsHMp36Aj0V6tq7MQ0i+ug3Yf8ebsPJ0UuLO/1AR
 Tsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UkF8/vdFwFhIlxbTxtZ4OfBy/J+EAcxCqWudSjYRllg=;
 fh=1UjoyB/w2Rg+kV1e1DGea6yJaha6zZvfPBRwftkBv+E=;
 b=GkToE1ydf4gYThfSdHF1Plr1qSPvHWRN1QFYjB7gCzDAhdpr81Oz0NWjbW7ShQRppk
 AZBaYD4MMiivGfnY5aYb5K9JhgOVqvG+C7tsJ4xyq75eSht7vJPHwFhYHv2egRJFYwoT
 RtaMPHENQA2dclrRtbfjU3KVVR9drtghQoHQGzwk3tBMAyE48O+c4TcZwWkzKK8MHJaZ
 r0KZktmR+V4+aMliZXiFXWwHiz9bnD3N1KyYExO77GoqNj+FVD16eVkmc2Wu4nR//p/Y
 2xXVMmlb2iV/36pqnGUnMrxU1hahABlSY6Gtx7NELn2m+tOQmNV4GsFxNZBLJJxk4Mh4
 KmVg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790089569; x=1790694369; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UkF8/vdFwFhIlxbTxtZ4OfBy/J+EAcxCqWudSjYRllg=;
 b=YWlkcbl/FM5+O243Gw4yssvubaFV7VRAN4E8DGbfeZ32DaRWWo3YXOC+R8Nn3Myv91
 FhIQ+o9RB22aDvUpv7+Y0zDsfCLRs5rvtcIGr/2FTshVhIQnsF4tm3PAay5GPUZe4XjP
 O2X5PT7c9vh93ba9Rw/na2u+cTMGSvS03/kJEqfmGoZKym3VQpa8FrjnN6kzOlkpwxjk
 ynbni2Gl7jcCLjApfeA7rrsFWpriN4wwFd555kZiPx7Z62IgFnLOhu4Y59HvOKJnol44
 BK+GX5OIkcHhCGvQfj5+9bTuKG0FYlXjp0VN85Qcjb3PXfG5nGBCVInSrJuxMy+tbq/N
 ZjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790089569; x=1790694369;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UkF8/vdFwFhIlxbTxtZ4OfBy/J+EAcxCqWudSjYRllg=;
 b=c6Nrcxgj8qaidj4YmT8jdXi5Pb4TfWhqDCh0r5boO+Yh7rElKYQen3ictucBMbCT1w
 u+aaWiZu7GfxtHzsqiiM+9w+5jWrePqG/fs/+QmgwnH+CSpL8Ek41BsGm1362XQNk0S6
 VeH/+4W1qhjIg7ZzLb9G2RWeds3c+bKURyr8isQ7DkHGv5XncNgpynOeIKuQaaF0SfPT
 cLou9G4HGWOjzxBvUtcvsqbA18v+gyxgiNi10kn4oUm+ZvxuS6u4hXkkN7SFDdFFEJ6r
 w/YROGeFS6iZ9y6XrRb2Br8IJ1maTVjCCKGh5zJj423zS4xPU+gBQLmg53iQ7os4+kUP
 TJrA==
X-Gm-Message-State: AFuF++lIR88EM0OM0HN1p4u+eV6k3JaAs9bRnmTT0N1Q8rKjrjz/wkrw
 UikJkF2+BEYmsAirKyzILdxwPfRL1Dp6tUwb1SXZWspyIh8pT6kbPeK3HUM1hzmDTiHVUMaa2qf
 UsBenqoOrGjhSkNDrOtiRUBEERBKNtyo=
X-Gm-Gg: AYBFou0JNqpL+zeG36OAh+Flj2E/r/cHfFG0jXuPbEJdsCU95IKiEPQr94LrqNvadM7
 C+3CAnRjncY6J3myhEwEXle4zIGZh6eflO0jXRtEwvnWLSsPRn9xm1s6ISUvpR8uFfntFMAxJUP
 sqDTLLi3AyZCIbytibjMdQ2BqSK1svOCArPS9t41aXqacKFo26lhilAHA23QtnM5h2sdH5/fQXZ
 qvCHMvv0Xx2t/PayyfX3CjLR9uRdRopJHcaHdXBFesO1DpVUXZLEIGiSbE9WqcIptZIaW1U4vF/
 8UE8EY/tNxtUclkBM/y5Ol7gFcDwkNj2Uq/DHbEw+2LsUuON0VQvrq9S+pdnc1aBmzI2a7zX9Uw
 R+mVHu3KdmqPcyTkd8ugPUrd+QyzLVuC0+MzWwX4WnA==
X-Received: by 2002:a05:6830:710b:b0:805:24d6:cb5 with SMTP id
 46e09a7af769-80e1e2cd412mr15435182a34.3.1790089567093; Tue, 22 Sep 2026
 08:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260922071807.2533884-1-airlied@gmail.com>
In-Reply-To: <20260922071807.2533884-1-airlied@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Sep 2026 11:05:54 -0400
X-Gm-Features: AcwNN1WCc1J-PDBCZhZYxVxsotQxDDlpubu-GLAK738d9Deq071zD5m-4kdMkkM
Message-ID: <CADnq5_NL3OtNOGGP2Cmhx0F7fe0coqQVR-md8mXZuxuX+FyKhg@mail.gmail.com>
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode
 callback (v2)
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
 kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Dave Airlie <airlied@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Alex Deucher <alexander.deucher@amd.com>
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

On Tue, Sep 22, 2026 at 3:18=E2=80=AFAM Dave Airlie <airlied@gmail.com> wro=
te:
>
> From: Dave Airlie <airlied@redhat.com>
>
> This changes the vgaarb client API so that the user can pass a
> private data pointer into the register that will get used in
> the decode callback.
>
> This allows a bunch of pdev conversions in the drivers, and lets
> some future vfio cleanups be nicer.
>
> I'd like to merge this via the drm next tree but also fine with
> it going via pci.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2: fix loongson (spotted by sashiko)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
>  drivers/gpu/drm/i915/display/intel_vga.c   |  7 ++++---
>  drivers/gpu/drm/loongson/lsdc_drv.c        |  4 ++--
>  drivers/gpu/drm/nouveau/nouveau_vga.c      |  6 +++---
>  drivers/gpu/drm/radeon/radeon_device.c     |  7 +++----
>  drivers/pci/vgaarb.c                       | 13 +++++++++----
>  drivers/vfio/pci/vfio_pci_core.c           |  9 +++++----
>  include/linux/vgaarb.h                     |  8 +++++---
>  8 files changed, 34 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 62b5b4a23f17..1344b2b1bd16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1435,10 +1435,10 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_=
device *adev)
>   * Enable/disable vga decode (all asics).
>   * Returns VGA resource flags.
>   */
> -static unsigned int amdgpu_device_vga_set_decode(struct pci_dev *pdev,
> +static unsigned int amdgpu_device_vga_set_decode(void *data,
>                 bool state)
>  {
> -       struct amdgpu_device *adev =3D drm_to_adev(pci_get_drvdata(pdev))=
;
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
>
>         amdgpu_asic_set_vga_state(adev, state);
>         if (state)
> @@ -4208,7 +4208,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>          * ignore it
>          */
>         if ((adev->pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
> -               vga_client_register(adev->pdev, amdgpu_device_vga_set_dec=
ode);
> +               vga_client_register(adev->pdev, amdgpu_device_vga_set_dec=
ode, adev);
>
>         px =3D amdgpu_device_supports_px(adev);
>
> diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i=
915/display/intel_vga.c
> index 4966fd7eea92..0889edb36190 100644
> --- a/drivers/gpu/drm/i915/display/intel_vga.c
> +++ b/drivers/gpu/drm/i915/display/intel_vga.c
> @@ -283,9 +283,10 @@ void intel_vga_disable(struct intel_display *display=
)
>         intel_de_posting_read(display, vga_reg);
>  }
>
> -static unsigned int intel_vga_set_decode(struct pci_dev *pdev, bool enab=
le_decode)
> +static unsigned int intel_vga_set_decode(void *data, bool enable_decode)
>  {
> -       struct intel_display *display =3D to_intel_display(pdev);
> +       struct intel_display *display =3D (struct intel_display *)data;
> +       struct pci_dev *pdev =3D to_pci_dev(display->drm->dev);
>         unsigned int decodes =3D VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM=
;
>
>         drm_dbg_kms(display->drm, "%s VGA decode due to VGA arbitration\n=
",
> @@ -331,7 +332,7 @@ void intel_vga_register(struct intel_display *display=
)
>          * then we do not take part in VGA arbitration and the
>          * vga_client_register() fails with -ENODEV.
>          */
> -       ret =3D vga_client_register(pdev, intel_vga_set_decode);
> +       ret =3D vga_client_register(pdev, intel_vga_set_decode, display);
>         drm_WARN_ON(display->drm, ret && ret !=3D -ENODEV);
>  }
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongs=
on/lsdc_drv.c
> index 3fd828d23271..5a13df31eb90 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -254,7 +254,7 @@ lsdc_create_device(struct pci_dev *pdev,
>
>  /* For multiple GPU driver instance co-exixt in the system */
>
> -static unsigned int lsdc_vga_set_decode(struct pci_dev *pdev, bool state=
)
> +static unsigned int lsdc_vga_set_decode(void *data, bool state)
>  {
>         return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
>  }
> @@ -291,7 +291,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>
>         pci_set_drvdata(pdev, ddev);
>
> -       vga_client_register(pdev, lsdc_vga_set_decode);
> +       vga_client_register(pdev, lsdc_vga_set_decode, NULL);
>
>         drmm_kms_helper_poll_init(ddev);
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouv=
eau/nouveau_vga.c
> index 29a801124e56..6662e30466f2 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_vga.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
> @@ -9,9 +9,9 @@
>  #include "nouveau_vga.h"
>
>  static unsigned int
> -nouveau_vga_set_decode(struct pci_dev *pdev, bool state)
> +nouveau_vga_set_decode(void *data, bool state)
>  {
> -       struct nouveau_drm *drm =3D pci_get_drvdata(pdev);
> +       struct nouveau_drm *drm =3D (struct nouveau_drm *)data;
>         struct nvif_object *device =3D &drm->client.device.object;
>
>         if (drm->client.device.info.family =3D=3D NV_DEVICE_INFO_V0_CURIE=
 &&
> @@ -103,7 +103,7 @@ nouveau_vga_init(struct nouveau_drm *drm)
>                 return;
>         pdev =3D to_pci_dev(dev->dev);
>
> -       vga_client_register(pdev, nouveau_vga_set_decode);
> +       vga_client_register(pdev, nouveau_vga_set_decode, drm);
>
>         /* don't register Thunderbolt eGPU with vga_switcheroo */
>         if (pci_is_thunderbolt_attached(pdev))
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/rad=
eon/radeon_device.c
> index 9523240110a6..cf8a6bd00c77 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1076,10 +1076,9 @@ void radeon_combios_fini(struct radeon_device *rde=
v)
>   * Enable/disable vga decode (all asics).
>   * Returns VGA resource flags.
>   */
> -static unsigned int radeon_vga_set_decode(struct pci_dev *pdev, bool sta=
te)
> +static unsigned int radeon_vga_set_decode(void *data, bool state)
>  {
> -       struct drm_device *dev =3D pci_get_drvdata(pdev);
> -       struct radeon_device *rdev =3D dev->dev_private;
> +       struct radeon_device *rdev =3D (struct radeon_device *)data;
>         radeon_vga_set_state(rdev, state);
>         if (state)
>                 return VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
> @@ -1431,7 +1430,7 @@ int radeon_device_init(struct radeon_device *rdev,
>         /* if we have > 1 VGA cards, then disable the radeon VGA resource=
s */
>         /* this will fail for cards that aren't VGA class devices, just
>          * ignore it */
> -       vga_client_register(rdev->pdev, radeon_vga_set_decode);
> +       vga_client_register(rdev->pdev, radeon_vga_set_decode, rdev);
>
>         if (rdev->flags & RADEON_IS_PX)
>                 runtime =3D true;
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3de05aee7859..3e58b2c05c85 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -51,7 +51,8 @@ struct vga_device {
>         unsigned int mem_norm_cnt;      /* normal MEM count */
>         bool bridge_has_one_vga;
>         bool is_firmware_default;       /* device selected by firmware */
> -       unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
> +       unsigned int (*set_decode)(void *data, bool decode);
> +       void *set_decode_data;
>  };
>
>  static LIST_HEAD(vga_list);
> @@ -935,6 +936,7 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
>   * vga_client_register - register or unregister a VGA arbitration client
>   * @pdev: PCI device of the VGA client
>   * @set_decode: VGA decode change callback
> + * @data: private data to pass to callback
>   *
>   * Clients have two callback mechanisms they can use.
>   *
> @@ -956,15 +958,18 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
>   * Returns: 0 on success, -ENODEV on failure
>   */
>  int vga_client_register(struct pci_dev *pdev,
> -               unsigned int (*set_decode)(struct pci_dev *pdev, bool dec=
ode))
> +               unsigned int (*set_decode)(void *data, bool decode),
> +               void *data)
>  {
>         unsigned long flags;
>         struct vga_device *vgadev;
>
>         spin_lock_irqsave(&vga_lock, flags);
>         vgadev =3D vgadev_find(pdev);
> -       if (vgadev)
> +       if (vgadev) {
>                 vgadev->set_decode =3D set_decode;
> +               vgadev->set_decode_data =3D data;
> +       }
>         spin_unlock_irqrestore(&vga_lock, flags);
>         if (!vgadev)
>                 return -ENODEV;
> @@ -1464,7 +1469,7 @@ static void vga_arbiter_notify_clients(void)
>         spin_lock_irqsave(&vga_lock, flags);
>         list_for_each_entry(vgadev, &vga_list, list) {
>                 if (vgadev->set_decode) {
> -                       new_decodes =3D vgadev->set_decode(vgadev->pdev,
> +                       new_decodes =3D vgadev->set_decode(vgadev->set_de=
code_data,
>                                                          new_state);
>                         vga_update_device_decodes(vgadev, new_decodes);
>                 }
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 6757054e9d87..b04ce3ded08c 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -162,9 +162,10 @@ static inline void vfio_pci_core_debugfs_init(struct=
 vfio_pci_core_device *vdev)
>   * has no way to get to it and routing can be disabled externally at the
>   * bridge.
>   */
> -static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool singl=
e_vga)
> +static unsigned int vfio_pci_set_decode(void *data, bool single_vga)
>  {
> -       struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev)=
;
> +       struct vfio_pci_core_device *vdev =3D data;
> +       struct pci_dev *pdev =3D vdev->pdev;
>         struct pci_dev *tmp =3D NULL;
>         unsigned char max_busnr;
>         unsigned int decodes;
> @@ -2159,10 +2160,10 @@ static int vfio_pci_vga_init(struct vfio_pci_core=
_device *vdev)
>         if (ret)
>                 return ret;
>
> -       ret =3D vga_client_register(pdev, vfio_pci_set_decode);
> +       ret =3D vga_client_register(pdev, vfio_pci_set_decode, vdev);
>         if (ret)
>                 return ret;
> -       vga_set_legacy_decoding(pdev, vfio_pci_set_decode(pdev, false));
> +       vga_set_legacy_decoding(pdev, vfio_pci_set_decode(vdev, false));
>         return 0;
>  }
>
> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index 97129a1bbb7d..71a364669eaf 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -33,7 +33,8 @@ struct pci_dev *vga_default_device(void);
>  void vga_set_default_device(struct pci_dev *pdev);
>  int vga_remove_vgacon(struct pci_dev *pdev);
>  int vga_client_register(struct pci_dev *pdev,
> -               unsigned int (*set_decode)(struct pci_dev *pdev, bool sta=
te));
> +               unsigned int (*set_decode)(void *data, bool state),
> +               void *data);
>  #else /* CONFIG_VGA_ARB */
>  static inline void vga_set_legacy_decoding(struct pci_dev *pdev,
>                 unsigned int decodes)
> @@ -59,7 +60,8 @@ static inline int vga_remove_vgacon(struct pci_dev *pde=
v)
>         return 0;
>  }
>  static inline int vga_client_register(struct pci_dev *pdev,
> -               unsigned int (*set_decode)(struct pci_dev *pdev, bool sta=
te))
> +               unsigned int (*set_decode)(void *data, bool state),
> +               void *data)
>  {
>         return 0;
>  }
> @@ -97,7 +99,7 @@ static inline int vga_get_uninterruptible(struct pci_de=
v *pdev,
>
>  static inline void vga_client_unregister(struct pci_dev *pdev)
>  {
> -       vga_client_register(pdev, NULL);
> +       vga_client_register(pdev, NULL, NULL);
>  }
>
>  #endif /* LINUX_VGA_H */
> --
> 2.54.0
>
