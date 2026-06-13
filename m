Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79282CD98CF
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 22:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB23F10E1BE;
	Sat, 13 Jun 2026 22:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="igpbZWWh";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68C110E1BE
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 22:25:15 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65DJM3jI1442333
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 15:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=GRdIE6LSM1bH8RC9lncAbOJ2JdACIXbSk43KFW5xUf4=; b=igpbZWWhgcAG
 UQRhHeAkQUcQT9YS1C1yizMLyYubisFvGTIHjvXAP5Yq4zFuMdy0J6izagbAVYGE
 Oh4Rla1pSyswX57EwIqs6wjhCDpr7SSai2oeugc/TSvmNQ5+HA4Puhr8hB2sZfKm
 K24vuXIvlgHEIVuujAPmgQN4D9olXWM87UFrSbGJUSfPnONyzsT6/QOd4nUKplB6
 +eaVfmM5zaV0rySMY0pM1OEcco2PwpNZ4z+evfY3ySdK+6zvdWUdR9NvkMhTpJgz
 2PddCQmkEQIS46pCY7lwRWXYNf7regn3XsKqdJFxiGmJlAP+qmzk4l0OhsbMgxA/
 LQsjKjm8TQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es4vy1ymr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 15:25:15 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6b5976d74so4175446a34.3
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 15:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389514; cv=none;
 d=google.com; s=arc-20240605;
 b=dBEsrSmbppRyB1uwoS7X2dByS+tVCoQ94jympR4D2SrnzZPP9A+HGMzJP1OY/dwpD9
 ZQ7iE4MJrh0YK4K4rgV2l7bpHT0HGvVhZMXC9G7F+TGkzg2uPnQNGMel+zeziAC/1/HS
 yR+z1P2FIqJ7zvK585XA+mQEct7vw73iF+5J/dGx2PNnlgHHvNdkAAJEGsAnpadiuMYE
 ZZAe8MUN3oQAaommap5ioZsff0bQH1lwAozFcvOTUxRA/mlrpwNZW/Fzj6pzXFsYj8Vv
 LUCPtcF1lkJDhygk/tVzhyZD3X+y4XmsYkY9QpL47rlUJ5Rvry/HoIq2wIfL5eYPK/2A
 /3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=6/EAQqigRSI18sLOr5BrBLiEKIx0cvrRCkfg6C7SoSw=;
 fh=r4UMMPAet1oiQZL5SokogPSqKQn8ycBkRLOGVOhJx9k=;
 b=YEX05+DZH2oHnl8ocnAgUL9H0cd95yvYyRMK/7kTwtVqr9KPMKsjobzoade17bJJz8
 r4kmWxWaNuH+S7QRNt4cm8R+lo0oJIq5V6BpcEI4Wyz2D/shyDdAQAw5J9DgbPeDB7y7
 KX7BMukh9ax3Hppj2FiRmiLE9q/DGLa6Fu0+8KuUWgNC0ATAcUHYli5qRB3jg2epGG8c
 o6uqlnoU9pR24CSmq0jMzAZWOGdk3wkdkABKA5jgC7z8vjfx2PmOXYmE3hqV5/EDdJOt
 uNjC3SoUH5vHPzsEAHfjxv1Ebyk8Z9B8aZF81gAxbzWRcRynLcO11ORj4pnk/m1396cN
 CrdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781389514; x=1781994314;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6/EAQqigRSI18sLOr5BrBLiEKIx0cvrRCkfg6C7SoSw=;
 b=nhoGnN63bUp3j8S13jbO4AzrXOWuhpA3RYumvX9o84mgK0qp4ECYLho//VVta3R+eB
 gTyzuVyhByNcAiFXZGEfz54hHphCcld1lx0Ng/QN/A93aRTAm1Na+IXEs1/yPvTQGVTQ
 VYonmHrbMnczAx1e4Ns5jvgYJoMQeQT2m6GzaJiLMxSwp5SfETjht2Frm0WcB02IAI5Z
 YIKqeVJ32tFH1T3TQ4n9o+1sjSuPsDT1iOzy5Od3en85Jt1MgVblAEVgXw843ah5HFYy
 jp7/ECdIul+E4BUbXXHBL6fh20SfGyC+31k1fe4eQoMPF3ARi0lVv8lyLq1tqzyC8SHy
 uDmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8y7jHJoMzZ79LshIL2+6tDPc7YaJ/b9hYOrM3jNhEtO6xatppKMZXBp3JXdbHKJqUiESoeAiKJeOw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywxa+VctTeLaFeUF/H/YzgIPVcsjPp4eWy+L3mZHRU/A7Hdiflh
 njynqyVnCdtwyEJDAoI8qOepNYeaQ3sVsPBcTIFoFaLNbBFpgyPSZBU3RoEzVFVUfNpc62OuIQ2
 J/aPsxf3c62YG/M8SkzoLYjlUNsVIC+FLFA4DfQkibhEjwyFt2GnLt0rlIKfNsjEXXbZ0nZcNWn
 7v4EK6OKdEaYE/nDrbFn0txBg7tOt3sNq7tDPWsm+w88c=
X-Gm-Gg: Acq92OGM/Oow2+WcJPvi29Bxgc8SXzD6ANJyG4IZPLZYW2I8NvpYICkG69OPm1jM3ue
 G3faSu+YuhHoz37l3JuKki+gCVwlqRG22yr5tRKNyJKji7MBPN/1FunrZ1P2OIGracmimYMce+T
 tztf2c++fDaOK4TicZHR/MDkqJrCc8xhrabiXstemPjR9wLeo+NuY2Jj/zNBMq//10SCjhzceLa
 0A0p9vc93b6Im+s5qsl6A==
X-Received: by 2002:a05:6830:6187:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7e78e75e354mr3483166a34.14.1781389514238; 
 Sat, 13 Jun 2026 15:25:14 -0700 (PDT)
X-Received: by 2002:a05:6830:6187:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7e78e75e354mr3483152a34.14.1781389513778; Sat, 13 Jun 2026
 15:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260611161546.4075580-1-zhipingz@meta.com>
 <20260611161546.4075580-5-zhipingz@meta.com>
 <20260612111001.5b7206eb@shazbot.org>
In-Reply-To: <20260612111001.5b7206eb@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:25:02 -0700
X-Gm-Features: AVVi8CexW_WJJGnDTI4HN0FLeTaWayUrCy_spJuvDIJixjLtGyyKLpDTD_UhDYM
Message-ID: <CAH3zFs0Nr6PCEVj0+iyAt6bdOVdQCnmNOCVuJ-5v7xAtKFuXMg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ef0NubEH c=1 sm=1 tr=0 ts=6a2dd8cb cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8
 a=e6IX7qM6bnzC-tgAjTwA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: RLkc35kZ5Mg2WWNLF_SCduQAGhuYQy71
X-Proofpoint-ORIG-GUID: RLkc35kZ5Mg2WWNLF_SCduQAGhuYQy71
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfXwykVtQse6Nr6
 5uLka8vWOCUY1xedtHrL2O1o9kXk0xTghjBwTUsF5svrPFfED11mYx0E4GlyJ2Su27WK4UOa1pV
 DtkVfHCnosOaqGHiQYcwoBfQrGdIRSQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX/ip6cgAv9vd1
 /YyZ/TBuCcBakvtzJgHURRtnJQjuYZayNbL+YsvnoojUCWfJdsl1EAqIvknhjsmKnR4Yr6XrRaj
 mQEsRxF5D4nS9GJyZVeiFjaq9qdYZ9ZscBHDZWo+vL6Z+T3ZJsO9rvPvdIMcVeKCPDZzJgzgTxT
 DUsNDlqpBhYfUjjSsTvv+Cis97POxQJPWxDVyqi/J6mM/3TFYUUR3HSqSno9DBeQJOckgsxOwX5
 bah/y3Gq499oG+J6U/knfxElS3mVGO2aLt3ddIPP97tQiIy9fizanFwt5jiUbcjRWebEm2iMbW9
 i1OCGStNLoD2ZJ8UaqCHCk/Q4sLw02kfHxe0nXS4lTrnG7RbJm5KRra04LzGQS3HKF+5jVuzxG0
 OKpfgcTnS5a/eA1elYpm9sL8k5gebQmQFCpefJ/y6UMI01ueaSJifMS8Xvh3ASExXd+NldTI59+
 2hPK2HbR8Ps0TG93JyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01
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

On Fri, Jun 12, 2026 at 10:10=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Thu, 11 Jun 2026 09:11:19 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Implement dma-buf get_tph for vfio-pci exported dma-bufs and add
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> > for a VFIO-owned device.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags, and get_tph() returns
> > the value matching the importer's requested namespace or -EOPNOTSUPP.
> >
> > Publish and read the TPH descriptor under dmabuf->resv, matching the
> > locking used for other importer-visible dma-buf state. The SET ioctl
> > takes dma_resv_lock_interruptible(), while the callback runs under
> > DMA-buf's asserted resv lock.
> >
> > Reject requests the device cannot consume as a completer:
> > pcie_tph_completer_type() must report at least
> > PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> > PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Validate fields before the completer
> > check so userspace gets the narrowest errno.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 94 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 37 ++++++++++++
> >  4 files changed, 145 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
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
> > index 1a177ce7de54..0a0705c8dbea 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -3,6 +3,7 @@
> >   */
> >  #include <linux/dma-buf-mapping.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +20,12 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
> > +     u8 tph_ph:2;
> > +     u8 tph_st;
> > +     u16 tph_st_ext;
> > +     u8 revoked:1;
>
> If these bitfields are now all protected under dma_resv_lock they
> should be grouped together with a comment to that effect, no need for
> revoked to get kicked out to its own storage unit.  In [1] I'm
> proposing runtime modified flags each get their own storage unit, but
> for more isolated cases, so long as we keep track and enforce serialized
> updates, I'm ok with runtime bitfields.  Thanks,
>
> Alex
>
> [1]https://lore.kernel.org/all/20260611213539.4100590-1-alex.williamson@n=
vidia.com/

Sure, will group them under one comment.

Thanks,
Zhiping
