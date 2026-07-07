Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8886AC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 19:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E90810E4F1;
	Tue,  7 Jul 2026 19:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="hSEMlMVf";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29E810E4F1
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 19:01:18 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cab97c86bdso18735ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 12:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783450878; cv=none;
 d=google.com; s=arc-20260327;
 b=F20I97KjkCc/B8741MD2xhmODB1a2h+DTzR32108CGy2k+nDDTGOqsxNsmWYOBiwXh
 M1B3x7eDK0A0cEvPcmIIKGUasOgql2R7XxJggSFcvm9N++8nS28H8I9/0hSgYA3G8i04
 EWV/6FmPR2tYehUjTC6LSpDfFBiYOP2chjmc+8f7bzUZVCifSGHT0D3f4/YOLSm5AXQl
 gXM2tbSGne5nsclmTZL+I8rlwsS5TriEg9VDANP3vaQ4ewPoHmrvq5sa0T+NG4/zDqZt
 S46l+xLNO2D3MyBg0nOPkI3Z5jraoJ3zf//r5fY2GBr+WzYidcbXaf5psC6b03mUAwR5
 fzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+gEkOp0eGJJxoxP/0omZEt8WDTb/s39aaadPNgZ5krI=;
 fh=FhHxvx/E9/UnbQGEigKYAIhGgOfaOpiKrFS7Alk7QpM=;
 b=oVtvIUmprXIGAOiSTtktAMeFEwqCoTqJDgWvaridE/FG2g7Q79n1IQVQvu/6LUalJr
 6UBGs24LAYmLk+/S8qTzBj579NPLam82GLWxWFHlIapYblmo9TjpXxfY9Pz9hLpGC6N3
 MCcCQzKP10VQjHQjrUL3KHrNY/Ya5pSi2/EdX0qnaYNXcSJGWm9DfA+DM1G61hLQAVUa
 slScG2FDwmwyxHvNF/DbXFB2hx6hhxNPFUu3YNcR6Qbvay5nF97hBdojGcgqpT3HXtUW
 edNoDOEECe468HmGAR3o3TEmm4gtpwVSupeNQ/kIqpLUEjJP5lwfYmC5KeNzNQE5dPSB
 kSsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783450878; x=1784055678;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+gEkOp0eGJJxoxP/0omZEt8WDTb/s39aaadPNgZ5krI=;
 b=hSEMlMVfU5qOBT0DksyAaRS6Wt6JBOOVdkaxnkqsX2NEMhEN6IrZa+KVKdNMU3+47+
 2M+fXdpxR9WdtqxpACN3uO646bV2Rn46HEey/8NngTuyLzyn0w6P1SVVuHOf9/HW7fRK
 qkhuI5/qHS44/x0p1zTfRyOPKBOGoLOgw6g0hUvxjcYA67DcHZQYdNEVU6dldQ86+2v9
 QyvFKWVhHdsi+zsrlPALUbXN/+yPflWylZHiKT5/pCGogp17lJf8hdn6yokndfqzJ131
 ypvlYDNsp5pbt/T/CSp8tHeJ+fLJjbVJNLvovMwzKnoGF4aiEmk4xz+sTyJtqXVI8oWf
 TxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783450878; x=1784055678;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+gEkOp0eGJJxoxP/0omZEt8WDTb/s39aaadPNgZ5krI=;
 b=guhFf9M13QrxSESlD5fzVM3KvidLUDhaMmoQ/xDJ9mmylC1GMbu8LTmpeb2bdSK/mJ
 6On3I62i8/LuosC6bwSqoNgAbABoWD0VXY/o9Fk+VhkZKLkLlAvTsHbiYwsNmF41ubri
 CoVbKLFzx7NBW3yvE+37EGdo74aqNjIh1gHrvEP1YxPSlYBB2kXj5Wu6SmeCxxgDaagu
 Hlbw7wYANdcxi6tFbaWEF9bEnCO1rhsF4EBGC3pShbxvDdV0cZHAnCkJtZJtu9IFy9Zx
 W6uB5ivOKIu3AwdK0JzGVxNvLEnz+27KgP8OAWZcMmgLc+4D0p22kbzQkCUrc0IS1GBw
 1rHg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7/6oUTa/LW0PQC6VwNGgRTHMA7nG9wOrF3ph6qnSGMCyNBaYEsifphDEApK1/gxTyuP1FqBjlNIA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQQqVGvqWUaXb4VG8bGUuAP9FjBLkdNBcjppSmf9suJON6ZNuH
 tigvSJmN1BejryXN6ONWWKWkDYfIfClPZKF9uhI7yAXJ63q3jCJKIafGBjHCi0nKpAFk2vGxe30
 jw9NEL44pgTsNeju3NEkxuigHClQ6UgCA6g/85kU=
X-Gm-Gg: AfdE7cmwZv8H5g7M8ymU6TE3ilHOE+Z9rzjCg9E4QgjMXaL5c4vpKHM51HM5IvWpIvh
 Q9cANFn4fwV3oUXlUcijsxqlLFL7Kq4u5JWBFXHbTnoNvKUucQVZd4dSDoH9PPxaIUK4NXkvQwb
 VgcU8kUgaqVUH+ZZCT7GOfwqggAnOrPcGa9O/G5jJngSmH/SySjp2hdXkPQb/kJeBMANvhbydWT
 4Ze0IJMoFG2OdWH6SLm1o8iIq1V8XJJ9PruiL6ki+iK2TW/MTN1ekjBIvsjrWzlYK1xUdnM0dVg
 u8Q5RD4i0kKKOT36h2bM8V1D4ljIwA==
X-Received: by 2002:a17:902:f705:b0:2cc:6df5:62a1 with SMTP id
 d9443c01a7336-2ccc9cfe5e8mr4326205ad.20.1783450877735; Tue, 07 Jul 2026
 12:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260625170828.3335431-1-natsu@google.com>
 <7202d2dc-b6fe-440e-88b0-aefb26c38b86@collabora.com>
In-Reply-To: <7202d2dc-b6fe-440e-88b0-aefb26c38b86@collabora.com>
From: Yiwei Zhang <zzyiwei@google.com>
Date: Tue, 7 Jul 2026 12:01:05 -0700
X-Gm-Features: AVVi8CfqZRK8FjQuAUJC_3d57L43GEZFnnGMpVl0zr846a_sRmyOwX1vUSPqcgA
Message-ID: <CAKT=dD=YecudFK1L9wJ22BO41qXt7V4Qm=nNQQiuwheKejoHdg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Don't detach GEM from a non-created context
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Jason Macnak <natsu@google.com>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Mon, Jun 29, 2026 at 2:39=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hi,
>
> On 6/25/26 20:08, Jason Macnak wrote:
> > Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
> > Don't attach GEM to a non-created context in gem_object_open()")
> > to virtio_gpu_gem_object_close() to avoid trying to detach
> > a resource that was never attached due to a context
> > never being created when context_init is supported.
> >
> > Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default p=
aram if context_init is supported")
> > Cc: <stable@vger.kernel.org> # v6.14+
> > Signed-off-by: Jason Macnak <natsu@google.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_gem.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/vir=
tio/virtgpu_gem.c
> > index 435d37d36034..66c3f6f74e9c 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> > @@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_o=
bject *obj,
> >       if (!vgdev->has_virgl_3d)
> >               return;
> >
> > -     objs =3D virtio_gpu_array_alloc(1);
> > -     if (!objs)
> > -             return;
> > -     virtio_gpu_array_add_obj(objs, obj);
> > +     if (vfpriv->context_created) {
> > +             objs =3D virtio_gpu_array_alloc(1);
> > +             if (!objs)
> > +                     return;
> > +             virtio_gpu_array_add_obj(objs, obj);
> >
> > -     virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> > -                                            objs);
> > +             virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx=
_id,
> > +                                                    objs);
> > +     }
> >       virtio_gpu_notify(vgdev);
> >  }
>
> The following scenario still will be troubling:
>
> 1. vgdev->has_context_init =3D true
> 2. virtio_gpu_gem_object_open() invoked, GEM created and not attached to =
ctx
> 3. virtio_gpu_context_init_ioctl() invoked, now vfpriv->context_created
> =3D true
> 4. virtio_gpu_gem_object_close() will detach resource that wasn't attache=
d
>
> Add obj->ctx_attached member to struct virtio_gpu_object. See
> virtio_gpu_object_attach() that uses obj->attached, do the same for
> virtio_gpu_cmd_context_attach_resource().
>
> --
> Best regards,
> Dmitry

Hi Dmitry,

WIth context_init, resource attach/detach is per-context based. So a
simple obj->ctx_attached won't work. One would have to track in the
guest context_init ctx for whether a bo has been attached or not.

Another option is to accept this patch and live with the case you
mentioned. We can consider that "invalid" user behavior.

Best,
Yiwei
