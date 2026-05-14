Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B95CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 06:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73D510E138;
	Thu, 14 May 2026 06:08:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="JrftBeB0";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A4B10E138
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:08:29 +0000 (UTC)
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DLj18t1490693
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 23:08:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=CUfNd8j6o1cqzuTyhkUx5QHxT8WZBdIbLx1WShVD26M=; b=JrftBeB0hZ1C
 u9/4pXmowfTiMV+9zaUBxqBHL8hI/vpmgz/fqp2OwHpQGWU5Iv5WJSuD0h/uV0G3
 nO9ZfCV04i7VMuNq4iC0Z1ED4JixEmry8TU/qbL/XrDe2PsEhuSsIukh+RIEN9bh
 nV0Poj0YWnuvjK+vLJgr+PTTcO3Zj4DL2Inpyf51owJ38wz0vqrOVeKkoY+rrKs5
 5Gc2J1ZMzOeyrfN05Sx9NATUuLp043r/g5PF+Cw+RIQu07QEafML7+PihCQi57iq
 VTgj1pBLClgtpWkay28KW4QTF/U7SrPjIgKrANWPLw5YeiV3nX1HyefMpNbn1f4m
 XT9x5gQyWQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvnna27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 23:08:28 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7dcde7bf859so14365668a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 23:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778738907; cv=none;
 d=google.com; s=arc-20240605;
 b=QkJ9V7mbEtqTObg0l/x6IfWCO13GlfFtJVhk3hcTKEq0/Kjj6umYPhNWp6zd+QAL5u
 PHsTdA7lpjdL59qqk04+Wk/+i5BzrckYIjfWBWUbbHUZoByxzUViiYFR/HxEzFG+/LqH
 L2INFjB8XVF49Ai/Bf9YvbrlNbjystnVv4PhJtUaeUCg9SMKrJfa9ZubASJZszHXWXHK
 m70CUV4IyeioWbINaYtH46hExyxeWxDIrHacrQm/PbeK1/wC3SCgOLimxTI5IQ24x7bT
 CpcugQ9uE7bmtNVYEy6nUnO19KIG7bT2EJdEkAG/FpwK5QLsp2EcIn9TRNDd59kNdgAH
 SEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=0KylqHwUi+PjJPZEIhBEmMw13oAHMDcoOl6huUe5x/c=;
 fh=w/IVawKPyqS2dlEyHOUmbp3BCnfDnJIeoRC1oAkhf2E=;
 b=F4IPkJ9/IVP3hukbI/DNKmHljwGjKqeYPeghnhCgxgoGWiZdmN5B9op8c5fCm7TTAk
 NGCD3pRFDkSNyI46CkaZPGxofwwiQ1CT3vw1OF/baDAQ/ahYBeBSh/ogOrngqT8N43rG
 fC21mEz658GiBU8bZB9Ckdh3ZgdctyAUsS2qwsJPpdkc55sKUJp3EvHch1HPo8RrRMiO
 badc3nabfTMecPBY/FYHBXxF2/sGGt6/hL3AcFydThveJMq/r86ZbOT9xIZSUHIkWU3t
 gL2LNsOM661wrdQ/HAIqtQy4/XgqYXPJoRBXDCWFp08vkZ6bxtTQrb80RQz8DYlVtWH3
 lVxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778738907; x=1779343707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0KylqHwUi+PjJPZEIhBEmMw13oAHMDcoOl6huUe5x/c=;
 b=VwaLUWxByoxyiFYP13aMzvVNVdgFfrAfal/AyiPVzkjQ19lumTCz4VzzDGOBH8lrz7
 V4N+eOYb8HCyy1Dn6oYfXFngprfOUJZE3qgGK6EgCdiAxz8eA1BUTJKt/JwROaoIYj81
 EcSdFKWpW1X6LpRZKJRzBXIqzprm/q/iTy+j5vGNcj1OayniVf8Xb0ZRaqNYPiuyXMeL
 noDHFM8rPuNO07pV0WuICrzneSmTWvBpL/6SZNoz8vP1hbb3pRi0lNuPBVN7Hw8Vrv1R
 lW7vRiddAVt+oYTrn6Vy0O2wXF4bWG5CtItq9WB14tPqVC0VVOgo0g7Xstac17yBcV4T
 Cgrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mUHTCVZBSF8sEodJ/GYWJkrbYCcPEzBcL1cPmJNNIrp14WFQFrIdfEVCPk1R+DMa2VRGbKN0f4EU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXMIOffsMc1GKCvidBdq7hVt7soQxujMcCcjyI+Ziqc/pDC1GQ
 ot12q9amWXXCGJvrvWPAsdpYpKQAZdfdzsok/NVJ/GSd+sgRqF1VzWlVBpQHEq8Rx3EK8jaMiT9
 FvQOCpjvluymdBo1w2XxT+E3Au/6zl6rYjZDVgnpTwQ7l6Acfst//Xs/s+5ifga0CykEx1AgXiZ
 H5R7uJ6xue3obMAH0aVv2EBpPWZrXXbaw+Fo0u/VdMqqE=
X-Gm-Gg: Acq92OEqO2aoQpWSLsfktfw5wq0lgvoQ/vIn7F5QVEezzjWhruqTArJ24MOndHLAYxy
 p6QnDjRL+pgABDbR/+2/9f1jZHqcOlH67ZOJQdGD3HBauiKLEGIEBHt1G9HSuV3vNdOjHDVuuRs
 G99wFhBuCVZZ90YVkL6xD7VbPye8tD55SEkB5sKK8tRigPcc7kfS0FTXBNkz5lUgqIWCvgmsk1r
 j+U55RNzRlBEnu4/BSXzr/doLPYYNpbl/2uzeSs
X-Received: by 2002:a05:6830:608a:b0:7dc:c301:d0b7 with SMTP id
 46e09a7af769-7e3dcb27e85mr3708442a34.28.1778738907340; 
 Wed, 13 May 2026 23:08:27 -0700 (PDT)
X-Received: by 2002:a05:6830:608a:b0:7dc:c301:d0b7 with SMTP id
 46e09a7af769-7e3dcb27e85mr3708421a34.28.1778738906835; Wed, 13 May 2026
 23:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260512184755.4137227-1-zhipingz@meta.com>
 <20260512184755.4137227-2-zhipingz@meta.com>
 <e6928a10-77b1-4fdf-8bc3-cd0154b4d4c5@huawei.com>
In-Reply-To: <e6928a10-77b1-4fdf-8bc3-cd0154b4d4c5@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 13 May 2026 23:08:16 -0700
X-Gm-Features: AVHnY4Lk7AsZ1k9gNnGjrk1ylBU7xPjARj3UiyZ3EAOpFnNYqojJiXoPPS0-GYY
Message-ID: <CAH3zFs2W5cB5Jhk8pm9K=O3-DyN3tHm7h5q9Hu26ekV=_gBEvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH
 feature
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
 Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 1ipEfjD15Ek56NmuWH6Go1DNwSmbUYKT
X-Proofpoint-ORIG-GUID: 1ipEfjD15Ek56NmuWH6Go1DNwSmbUYKT
X-Authority-Analysis: v=2.4 cv=b/eCJNGx c=1 sm=1 tr=0 ts=6a0566dc cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=eh8E65cc9O_vH5X4jusA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA1OCBTYWx0ZWRfX1qGgXVZqLpBK
 vlVfTege3JPCCzupBLA2AXl4aNsFJ6bRk/W7E0WJ8UyVkZEtm8oJ/nmZcWpjqEkBoZjPwTecxrC
 eCEHBXKF0FXY4WdHZviPfztvt3g4oY6rckwWNja7G4fR0iEcTecfLyx9Qq6+PGRzEe8aaUoOPnT
 n5T8bSlDhUtYxnpIQZGO6dkwkDFZEBHm5K7yOmkL/HYkJ8rYHqwWT4iMfCbusAgU8KobZXoOKQh
 FVK0a6esi9O0+Yo3ll73M8XvZdiravbV8Jt0CUfIEGzmqSwwXUGNtmwVazXxMGcSSYx+Nvvp62e
 ICOch+6AMDJf/PsPHC1WL0kRwx8TRDwEBahtPiHgjzb3zLVM4i73f7YP+pwPTSAUd5J1ocWo9hs
 pQ+PnqArQ55UzUcoQiAVCoJp2lSOUfC4PEZD/yPDpV/m9KXeNfIsdTNjMQ55JGujAUSUdxMGTvy
 /4yi1tLNB5/lHkfb8ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
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

On Tue, May 12, 2026 at 6:33=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> I have several suggestions:
>
> 1. In struct vfio_device_feature_dma_buf_tph, steering_tag is defined as
>    __u16, but PCIe TPH base steering tag is only 8-bit. We can use __u8
>    for steering_tag to shrink structure size and reduce reserved padding.
>
> 2. The flags field seems unnecessary. We can use value 0 of steering_tag
>    or steering_tag_ext to indicate the corresponding ST entry is not
>    available, which simplifies the uAPI design.
>
> 3. All TPH metadata fields (st, ext st, ph) fit within 32 bits. We can
>    wrap them into a union with atomic_t, then use atomic read/write
>    instead of memory_lock plus smp_load_acquire/smp_store_release. This
>    makes lockless access cleaner and avoids ordering maintenance.
>
> For details, see the text.
>

  Hi Feng,

  Thanks for the detailed review.

  1) Regular TPH uses an 8-bit ST, while Extended TPH uses a 16-bit ST, so
  so Extended TPH in Flit mode TLP can carry a 16-bit steering tag in
the request.

  2) I still think I need an explicit validity indication rather than using
  `0` to mean "not present". ST and Extended ST can coexist with
  different values (including the value 0).

   3) I also do not think packing the fields into `atomic_t` removes the ne=
ed
  for `memory_lock` here, because the write side still needs the lock for
  `priv->vdev` ownership/lifetime checks and the dma-buf list/cleanup
  paths. Open for discussion, though.

  Thanks,
  Zhiping




> On 5/13/2026 2:47 AM, Zhiping Zhang wrote:
> > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > so peer devices can reuse the steering tag and processing hint
> > associated with a VFIO-exported buffer. Add a new
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> > VFIO_DEVICE_FEATURE_DMA_BUF along with the TPH values, validates the fd
> > is a vfio-exported dma-buf belonging to this device, and stores the TPH
> > metadata under memory_lock. The existing VFIO_DEVICE_FEATURE_DMA_BUF
> > uAPI is unchanged.
> >
> > 8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe TPH
> > ST table (firmware reports them as separate fields with separate
> > validity bits in the ACPI _DSM ST table), so the uAPI carries both
> > values along with a flags field that indicates which value(s) are
> > valid for this device. The exporter selects the value that matches the
> > importer's requested width and returns -EOPNOTSUPP if that width is
> > not present, instead of substituting a value across namespaces.
> >
> > Publish the TPH fields under memory_lock and gate readers on a
> > release/acquire on the flags field; this lets get_tph() run lockless
> > and avoids inverting the memory_lock -> dma_resv_lock ordering set up
> > by vfio_pci_dma_buf_move(). Convert the @revoked bitfield to a plain bo=
ol
> > so concurrent updates of @revoked (under dma_resv_lock) and the new TPH
> > fields (under memory_lock) cannot race on a shared bitfield byte.
>
> The commit log includes many implementation details, why not remove or si=
mply it.
>
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 113 ++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   |  11 +++
> >  include/linux/dma-buf.h            |  21 ++++++
> >  include/uapi/linux/vfio.h          |  35 +++++++++
> >  5 files changed, 182 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 3f8d093aacf8..94aa6dd95701 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
e *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index f87fd32e4a01..28247602e359 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -19,7 +19,23 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +     /*
> > +      * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > +      * consumed by the @get_tph dma-buf callback.
> > +      *
> > +      * @tph_flags is the publish/consume gate: writers populate
> > +      * @steering_tag, @steering_tag_ext and @ph first, then store
> > +      * @tph_flags with smp_store_release(); readers do
> > +      * smp_load_acquire(&tph_flags) before accessing the value fields.
> > +      * @tph_flags =3D=3D 0 means "TPH not set". Writers serialize via
> > +      * vdev->memory_lock; readers are lockless to avoid AB-BA against
> > +      * the dma_resv_lock held by importers.
> > +      */
> > +     u32 tph_flags;
>
> As subsequent comments, can proceed without tph_flags
>
> > +     u16 steering_tag;
> > +     u16 steering_tag_ext;
> > +     u8 ph;
>
> struct dma_buf_tph {
>         union {
>                 atomic_t val;
>                 struct {
>                         u16 st_ext;
>                         u8 st;
>                         u8 ph;
>                 };
>         };
> };
> Set and get are done with atomic operation, no need for lock
>
> > +     bool revoked;
> >  };
> >
> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -69,6 +85,35 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
>
> ...
>
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @steering_tag: Returns the raw TPH steering tag for @st_width
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      * @st_width: Consumer's supported steering tag width in bits (8 =
or 16)
> > +      *
> > +      * Return the TPH (TLP Processing Hints) metadata associated with=
 this
> > +      * DMA buffer for the requested steering-tag width. 8-bit ST and =
16-bit
> > +      * Extended ST are distinct namespaces in the PCIe TPH ST table, =
so the
> > +      * exporter must select the value that matches @st_width and must=
 not
> > +      * substitute one for the other.
> > +      *
> > +      * Return 0 on success, -EOPNOTSUPP if no metadata is available f=
or the
> > +      * requested width, or -EINVAL if @st_width is not 8 or 16.
> > +      *
> > +      * This callback is optional.
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
> > +                    u8 st_width);
>
> how about rename steering_tag to st?
>
> > +
> >       /**
> >        * @map_dma_buf:
> >        *
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..53b2bbd9fc1e 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,41 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) m=
etadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DM=
A_BUF.
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) a=
re
> > + * distinct namespaces in the PCIe TPH ST table; userspace should popu=
late
> > + * the value(s) it has from the firmware ST table for this device and =
set
> > + * the matching VFIO_DMA_BUF_TPH_ST / VFIO_DMA_BUF_TPH_ST_EXT bit in @=
flags.
> > + * An importer requests a specific width and receives the matching val=
ue;
> > + * if the requested width is not present, the importer is told TPH is
> > + * unavailable for this dma-buf.
> > + *
> > + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
> > + *
> > + * The user must set TPH on the dma-buf before the importer consumes i=
t.
> > + *
> > + * Return: 0 on success, -errno on failure.
>
> -1 and errno is set on failure.
>
> > + */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +#define VFIO_DMA_BUF_TPH_ST          (1 << 0)  /* steering_tag valid */
> > +#define VFIO_DMA_BUF_TPH_ST_EXT              (1 << 1)  /* steering_tag=
_ext valid */
>
> It could be represented by judge whether steering_tag/ext =3D=3D 0
>
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +     __s32   dmabuf_fd;
> > +     __u32   flags;
> > +     __u16   steering_tag;
> > +     __u16   steering_tag_ext;
> > +     __u8    ph;
> > +     __u8    reserved[3];
>
> How about:
> struct vfio_device_feature_dma_buf_tph {
>         __s32   dmabuf_fd;
>         __u16   st_ext;
>         __u8    st;
>         __u8    ph;
> }
> If st_ext is not zero means it valid, and also with st field.
>
> Thanks
>
> > +};
> > +
> >  /* -------- API for Type1 VFIO IOMMU -------- */
> >
> >  /**
>
