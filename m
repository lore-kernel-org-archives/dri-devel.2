Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B55CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 23:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13D510F161;
	Thu, 11 Jun 2026 23:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="md1FMUhb";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B1110F161
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 23:02:38 +0000 (UTC)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BEf4R42133335
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:02:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=ob92Tq2R57wAiMWenfqpV0H25NaZcFwlwctuc69C3Js=; b=md1FMUhbMLo8
 Fh894GG//O50My3HeLIl+N1moRtgU28J41XgC7IeNjtkXzdqb3Q4pJbloUb0sI57
 9jVz7NnQpwJ5bDPV4npoEbwYzhg4rgAl9HiKES6OFpGviFE4XpNWf6+El9J9dJ7B
 Yo/EOv0vO3lg0CKH0IeKIWviH2o6Ji1sS4icJbrVsodYNItHLNAjRW6ZraJMViyk
 n/FyvaceZSOsCn5SwSysZB4DgzxdCuNLNoHpkBe5q1vDh++JPpSH4eLPJhsKjRSE
 bq0UWdRUpM7b1KbePNQSfzI9YgeqCUP1xW5dgvSck3N00OzgCLYF3SsitjHsc7bI
 ag85db8yRw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe81s9w0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:02:37 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e74781faaaso842270a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218957; cv=none;
 d=google.com; s=arc-20240605;
 b=CNnDlbNTUU3xI3tfJBppKq8tGXQ9VcIu2zz8tAtuIdgNuPuWisIr9YNjCWG5PAxZSh
 VC4ihoe89+U86IOXJDg/CmhkOvFF87PEGSoHl0WEYyU7KJjFEl9x4zqe+DbM4Mgb59Dy
 5yCjnpYMa3i+A8rgFnIU7wP9XW/M2lhhJCFcFkDUQSU1L95ryRMbAosYE9kd4dlm7Y2c
 xWR13PS/NZTqqhZ5JWyKAGRui7QGhAU0Zd0aqgbKH3qB8ZxMKytVnMbbbD2Hx/xHL8BR
 ADuDYfUfyzDim/DmZIRQQxa3ld9F2qLVNBp9UG012+v1Dq0NpKOkbWJSxiu3I+LZLRsL
 47yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=WY5Yrlv2Sc7Wnv9jSySuWH/Jl8+9GO4Ig0Gi7133UjE=;
 fh=tYY7InHlS5vewjCAMrDwHN/+ii4f4KGN8nKNLmzfxq0=;
 b=Ki4odP/Jg8XGdOgDrd4Jhpkl2QUyAZByj+bSkMTpoU4rIDXhBDLrrfMIvKpb+c4gA0
 qUpfe5mhSvLFi/9gl8gaLvJRdJ3f8C1/sScHUYBrWUF31i+ekgzD6NrqdNnMualzHf5m
 t3b2yaNhG0p1Tekc/3kc5VIglkNnoWj/nYJzULGuei5pIxWRT5dUyAUyMvYusyLyOViC
 MgukH77pGyIrihC21nXS+4SuQ/Q80fW4NUy7QxyS+/usvMzC7/sY0KLseB7SH1Pcdsko
 79w/0Y3StNQhVNGhnnzx8/PLy6TUq3zjVwRzAypMmVbt0ZJm34tP1x7KHEOtVASkKupv
 80lw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781218957; x=1781823757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WY5Yrlv2Sc7Wnv9jSySuWH/Jl8+9GO4Ig0Gi7133UjE=;
 b=L5vQ6vrFjd8oHSSXWTwwDhDlBAAYhv1dvQP5cTPmVaEEi+FniUKJtiGkOJ3gscikQ0
 QyduAhc/cuV5Wie8EAjOefQRX2bLvhyAmmP98naOTy6PL5nXiL7KnoCILtKYbc919+40
 OtIcDbCv4QbE8nqbeU3gbP0NeRndIeGZM7F/nZiymOZqJraViBPaIfJKvlUXh4alWraP
 3PPAYBM/vGT6SCuhHBR765Mn8bu9sDfJ7jNBA75cKHEmeAIJWSUFTxdNd73lrVpbC2Pw
 QchYYmdjtETgKZuiXsfSJ87SoJADiWXwtrFsEXUtmj11G7eG7sx8V7QgMoMQHCo0FPr0
 oc0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PiF7Y2KIH4QL0ccnnLZR2FS2agI2rkdPYfHp02yXhmIkcPXuBP7ffcu3H5tpaIwSlP/dbVMA5au0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3p68UPHDzZlqklHd8Ua1NlmE/YIkSzHOwtZTTltqzZkWRL+Hh
 kh+PBKWtM+KnvWUWBSWGMvA7KPipPKdDWetD3TwROtH7X5z6Zu22wGXLWwY3GkppIGV6rD7AV6A
 e+UqEeRAVez45TrFSLHddeGFb7kTLH6XfSLobBk766sVuFDVxu4Wlo+351wxt6MV3KVm9iOGUsp
 ovYhdH/4xMIEBN+/luPwL8aFZ9VDxrxmrzsEDJOHGjwSI=
X-Gm-Gg: Acq92OH2+jHUH/g3VBSZp+eiyvuWR38hUOzF7e0qjFHMQMCeOp7RbiO72+PvviQ+9sL
 CDIiJJNjs3O1nfzgeevx0V+OCQ6BWgxuBRtbUrhxDtB9bRsmkMm7AggpB1BIlwm8mesrKR2793E
 sefgnGlsauMDGfUoV0x06h0nz3qRmEIiqNcxvtObmkTPy+QFmRJqF7MR0vZTkplK7aTWKCMyTrz
 G4sU3ZSCxA2X0Y3xNHk7Q==
X-Received: by 2002:a05:6830:4411:b0:7dc:cd0b:58bc with SMTP id
 46e09a7af769-7e78473e9a9mr114898a34.7.1781218957157; 
 Thu, 11 Jun 2026 16:02:37 -0700 (PDT)
X-Received: by 2002:a05:6830:4411:b0:7dc:cd0b:58bc with SMTP id
 46e09a7af769-7e78473e9a9mr114839a34.7.1781218956672; Thu, 11 Jun 2026
 16:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260610193158.2614209-5-zhipingz@meta.com>
 <20260611202555.B0FE31F000E9@smtp.kernel.org>
In-Reply-To: <20260611202555.B0FE31F000E9@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:02:25 -0700
X-Gm-Features: AVVi8CelQJPHsRb_TsddVOxCGdtZJzAKJ67zmwHKr7MIkmqZ8rgse99DfYGSmhU
Message-ID: <CAH3zFs3FjiCfOceVRin0ytKNdZ7Pgyv4ds=Dd_GhrRC_XcbNOg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfXwu7/eBsosiBa
 LJAWM3XCBveh2Y+YE4u6+DBKJnMYwRja/RQdqDiznAp2RAbDwlBNvK9zHgjvRf1gP9kRfmVP4Fo
 weqgIEKPEAm83hmR27RUvkA52ihjGKh3EdAgYBZStUB8EMpanuydrDX7BdzTlFbtBGlg6HCs6po
 7hqMLyTqHuAJdQ/QJ4G/S1EpkEBzm4cT54+zmCAMAFcmC5Jra+Sem7gCOvA3Jcz0gmpWICCq7Tq
 vTQeeABX1Onz5SDM2Uf6yt/01JGccwmCWjtxzSxPwx5sqKaRaHHfoBn8vD8u1lVKXEn5qyJo46t
 dKiNQQYr4h10ISxLZkX8w5/qRyQr774aGpMGQJI18Th+RQ9DsefSSMG0oR77acLPU/O33Jv/A7Z
 0oTgKkhXRdUDEmksFTRk96+4SWlBPyoEUvGs5oWqC7oD+/xGS5+lgasY1v1eU1AJPRs9ygw2b9L
 aUY0iyK/1a5k23h7ZOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX0fnWgezLsO+V
 6XzUknm+P++mZ/Gy6L5g7b/38RTv9ybvPBCftGnheA0D2fvt1fWiW6y4GJPzrDik/Hdg4XrCZQs
 nYLWx4wyFicHowk/5SmkioqAgWvx8Ew=
X-Proofpoint-ORIG-GUID: SX0VUwdBAJUZxMVO-fWSuMqXDSDu2Gca
X-Authority-Analysis: v=2.4 cv=ToXWQjXh c=1 sm=1 tr=0 ts=6a2b3e8d cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=vvh9Qk1aVFpNxidmG9UA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: SX0VUwdBAJUZxMVO-fWSuMqXDSDu2Gca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
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

On Thu, Jun 11, 2026 at 1:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> >
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Unconditional validation of the flag-gated 'ph' parameter can =
lead to spurious -EINVAL errors, breaking the syscall trust boundary.
> - [Medium] VFIO_DEVICE_FEATURE_PROBE falsely reports that VFIO_DEVICE_FEA=
TURE_DMA_BUF_TPH is supported even if the hardware lacks TPH support.
> --
>
> commit d57637d667ca6dc95def77a0a5bd339d62d4f506
> Author: Zhiping Zhang <zhipingz@meta.com>
>
> vfio/pci: implement get_tph and DMA_BUF_TPH feature
>
> This commit implements dma-buf get_tph for vfio-pci exported dma-bufs and
> adds the VFIO_DEVICE_FEATURE_DMA_BUF_TPH feature. This allows userspace to
> publish TPH metadata for a VFIO-owned device. It checks completer support
> and protects the metadata under dmabuf->resv.
>
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 1a177ce7de546..0a0705c8dbea6 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>
> [ ... ]
>
> > @@ -333,6 +360,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >       return ret;
> >  }
> >
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vde=
v,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_=
tph __user *arg,
> > +                                   size_t argsz)
> > +{
> > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > +     struct vfio_pci_dma_buf *priv;
> > +     struct dma_buf *dmabuf;
> > +     u8 comp;
> > +     int ret;
> > +
> > +     ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret !=3D 1)
> > +             return ret;
>
> [Severity: Medium]
> vfio_check_feature() returns 0 for VFIO_DEVICE_FEATURE_PROBE, causing an
> early return of success.
>
> Should the hardware capability check (pcie_tph_completer_type) occur befo=
re
> checking the feature flags, to avoid falsely reporting that the feature is
> supported on devices that lack TPH?
>

Will fix it with a change like below:
 -     if (ret !=3D 1)
+     if (ret !=3D 1) {
+             if (ret =3D=3D 0 &&
+                 pcie_tph_completer_type(vdev->pdev) =3D=3D
+                     PCI_EXP_DEVCAP2_TPH_COMP_NONE)
+                     return -EOPNOTSUPP;
                return ret;
+     }

> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_E=
XT))
> > +             return -EINVAL;
> > +
> > +     if (set_tph.ph & ~0x3)
> > +             return -EINVAL;
>
> [Severity: Medium]
> When userspace clears the TPH metadata by passing flags =3D=3D 0, is it r=
equired
> to zero-fill the unused ph field?
>

Not an issue.
