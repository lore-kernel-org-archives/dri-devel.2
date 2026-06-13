Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29F3CD98CF
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 22:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC19310EE8A;
	Sat, 13 Jun 2026 22:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="rsF2tE+d";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F0C10EE7B
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 22:32:29 +0000 (UTC)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65DKYPce1596299
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 15:32:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=92RmcGHbhf5Dgq7ILHGOiuMda6Ei+OUfewhzqJcCUNQ=; b=rsF2tE+dN2jV
 8eSKu+oUcO7wcwlrfJk9Pn+sNPKnf6ltXg8x/OTwIZ84uT53mMdFnfRTfogreJTl
 ux59CUebsLYlnA7MhUawpqRbFwNyIqdqkq9zLr1FwMv9slGPLI1CNtJ24Lfu0llZ
 Rk6XPtUNx43hUJLKH+gKhMifA2LssSZ6uKuYy5WjsYzmHXE78JtBry5Pbeqw52kW
 ejazSNvM4mpnSf8D3usXWACDowFONzH008jjUEsbGk43T1GWP2zxiWOlql5NU9iX
 kSspyuuh/5nlyZq/g+/vZoFqs8rDYdQb1QLQUgbtulXEJrCOyULq00O3JLm4c3KM
 aNoVDcyGww==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es6gh1r7q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 15:32:28 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6fa8bba1dso4426118a34.2
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 15:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389948; cv=none;
 d=google.com; s=arc-20240605;
 b=C2bDr1sYrLZP4NZtj5HnSd7o+aIGpwFB/7nbrILlRWVa3HWnKQ22L7QlfT5vGj2ERM
 I3pwzI7fb6ORcw+TMMp3efCiSd5l9pS0eIIHogILfqJJsiDN/Vl72ixo8mLtqX4TWD1h
 0VJSprpoFMpVK1mOODImVsIAGgch+eJ0JaLd3S54IwfYiS0Q9FnQVVjGxM/8ghXYcmCV
 7+PRzwinPhqfq/RvyW9hduu4MCgCxhiQNW/C8UkyCrYKp2RoB2tdNniWNprcxq0ShbEm
 DNfIYwkFWagwyrwRFrVCZmGxyrUyORBROOfGI6fN9wVMcUYNTYf6vrxbTQ31jE2eqt7r
 Wslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=PY5KrR9iMJ26IpdWUfDs9HsxqKRAuKri6MmYIkjb96M=;
 fh=9hteZQ4+KOa0+Iva56trpYAxs/XF6aknbua9EQ2WiwI=;
 b=hkt919WaNvUI22yEvWn3lbqR6itwy02Bf+QSzPgTIlUIHkjbbGlgXK0lednw7FUN7z
 chMYPviRorHB9ieG+YwK2YoquASce27UlD06Fau6eTAQz7/gNQmWuXDhH5XaUTBQBCUR
 UlnzJ2spGHURTu3PMcQg/o1z8VJyLhP3KY5gFmAwNZmsZzTcUIobiICe1FCyvZAWcpcu
 FyaeD02b/hA/XozuZsGcUgDVIF2P8DPCNEFaH4exrYYltxnM5f/e5hyPuLocPN0MOTca
 ayQBPaHEGnnUgpLsfgWAqv5Rh+NXra1qRryOZp8NGcJoUde08G6t3RwCKW0FIp/kg8NX
 aMJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781389948; x=1781994748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PY5KrR9iMJ26IpdWUfDs9HsxqKRAuKri6MmYIkjb96M=;
 b=d5yFEPcuMtqK7KxlfzUZ0ENFJqDkva1fE5/QZDvS1RTlISuXFdHXNnZm/7XG9OnDGm
 4/AhroU18s3aPUeEhYhXA+TXfWIa9nMlhAdhJ6R8G6QQEixsgZrUNxJCDq0QbmINf4tj
 ssJFxQb2eMTKdCfDHzRAshS3qLo2wzn51OqnH7jNZ52I+HHbKa9kXhJBIxvmZFmrUS/v
 go79w/oAIqUkVshfRWkAMaLg09pGHtG9fP9H5pE2GKFRL4lxXKqfMkACnhv+qz8mpqq/
 fe9DNu+ASY3Rn+Pz29jjTjkQQZSoe5ffgayPsQwlEn2lz6s/KGPyxqZxhNcf+u10p/Zr
 +QYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GyAldQr4t4m+DHDzGvKzqGBkYUtxcScr3JZLg3hs69SwJKipcHsfQ8fL43XZ+tdeCD9cruywGMwE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFBiKZumzzcvMwxrGlvU4bOFqr8pe4Nx3vBe6QzPnJmcl3X0hx
 CKtXJJJ/N+y1yHpQvixDj6CIAepmzhzavj+b73w5kKx/9zjqzLLE18CAMh3x4tKaW/ZisRL2dUi
 dKanHrKYklQIdyfiu60ir1XlLYUZg9CtlrDnOxfedJL0IZXyY1xNWKdltgYKkV8tgipm9/AJiWG
 GzfpwOOoNX+os02RhK+s1efW7OR5Y3Go6g/Va2oied8SU=
X-Gm-Gg: Acq92OHro/eNbGnJWmHT3lUvuIricM3lMaNB6tYLi5PrUT3ZfvsA5qIgS3z4xltdU/J
 xW3b9tQ/hUdhSxginVg2oW5nUl/+ozO9aZFbBRHfljNetAZK/6MNKBnA3cocmodFImx8TMOcHI2
 N4PZBF4Qnkp40UVCYgYGfQz/AawyG3F86L2lzZAY3wF4S8+dCVJR4pBH2vRIJuFi34skGiorJfZ
 YvEzwtHawULGz36uc749w==
X-Received: by 2002:a05:6830:2e03:b0:7e6:f7fb:9682 with SMTP id
 46e09a7af769-7e7846efe32mr7148465a34.2.1781389947802; 
 Sat, 13 Jun 2026 15:32:27 -0700 (PDT)
X-Received: by 2002:a05:6830:2e03:b0:7e6:f7fb:9682 with SMTP id
 46e09a7af769-7e7846efe32mr7148455a34.2.1781389947375; Sat, 13 Jun 2026
 15:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260610193158.2614209-5-zhipingz@meta.com>
 <20260611202555.B0FE31F000E9@smtp.kernel.org>
 <CAH3zFs3FjiCfOceVRin0ytKNdZ7Pgyv4ds=Dd_GhrRC_XcbNOg@mail.gmail.com>
 <20260612105928.200220b8@shazbot.org>
In-Reply-To: <20260612105928.200220b8@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:32:15 -0700
X-Gm-Features: AVVi8CcMGigExPKR8IpfZtGzrLOFWz5YTcGVhRoJFgHdM9ZEhG5IiCIsvSLW0hM
Message-ID: <CAH3zFs0nGMXV2N=6epd2-40D0tyxcXs8K0E7zX8-H1DcaDOj=Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNSBTYWx0ZWRfXzFqeL/HW19C2
 /rqHVR6HXWzvgkFG16odQRnaKu3NnA6wgoij0SXSIxVV8XmfRtOK0RhmWpdT5YdmMaDRgaH21kf
 /zsJVVhk2QFxm6cxEUpWocmAUjcAAyoAbYN+RPa9oXG6EFqezZLnEbk4A7Z8sdLo6oI6ks5f///
 R/NxM3oeTbf5SMWc/vXsuBtMhmKWFPFxK18K/dy0vLRen5Ga8nse39wSIs8aFZzM9urXunsA/3M
 r5n2/cRwObrZ+LAum5G5k/fXrUvbwdzYjNRra3xHWaN+ry8Dscc+dNc57cz5IVX6hgu7Wa/IsHa
 FFw+umAjbQsj1oTjvpiavs5OUaQFq1Dj+1wPA7As3LVFa0MoujscqGdLH8x/86UeSXOL+VWjqfk
 oURILjn0nNZwiPqjCEBUmb6Eo7tCjVuiN2gi+3NJLPdR+LE6HkeRyL1SDmISyUDQyv6bFMWi1Kl
 09ZJ5U5HvaaNj62kbRw==
X-Proofpoint-ORIG-GUID: kV9ykwBvKLQw9ELnlOU2zl8VsIutoZ3c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNSBTYWx0ZWRfX7rIwtX6uPEar
 gMSgwaz4ZGkfmKWIF4rmAsWmD/13NkgwA/k5rE+5Ei5ayjdCojyWSyNoiBPn5eQSgckIersGdhW
 MRR8h3hExD9dVNntHmPWHMqq5kD39Vw=
X-Proofpoint-GUID: kV9ykwBvKLQw9ELnlOU2zl8VsIutoZ3c
X-Authority-Analysis: v=2.4 cv=Da4nbPtW c=1 sm=1 tr=0 ts=6a2dda7c cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=vvh9Qk1aVFpNxidmG9UA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
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

On Fri, Jun 12, 2026 at 9:59=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 11 Jun 2026 16:02:25 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > On Thu, Jun 11, 2026 at 1:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > >
> > > >
> > > Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> > > - [Medium] Unconditional validation of the flag-gated 'ph' parameter =
can lead to spurious -EINVAL errors, breaking the syscall trust boundary.
> > > - [Medium] VFIO_DEVICE_FEATURE_PROBE falsely reports that VFIO_DEVICE=
_FEATURE_DMA_BUF_TPH is supported even if the hardware lacks TPH support.
> > > --
> > >
> > > commit d57637d667ca6dc95def77a0a5bd339d62d4f506
> > > Author: Zhiping Zhang <zhipingz@meta.com>
> > >
> > > vfio/pci: implement get_tph and DMA_BUF_TPH feature
> > >
> > > This commit implements dma-buf get_tph for vfio-pci exported dma-bufs=
 and
> > > adds the VFIO_DEVICE_FEATURE_DMA_BUF_TPH feature. This allows userspa=
ce to
> > > publish TPH metadata for a VFIO-owned device. It checks completer sup=
port
> > > and protects the metadata under dmabuf->resv.
> > >
> > > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/=
vfio_pci_dmabuf.c
> > > > index 1a177ce7de546..0a0705c8dbea6 100644
> > > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > >
> > > [ ... ]
> > >
> > > > @@ -333,6 +360,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_=
pci_core_device *vdev, u32 flags,
> > > >       return ret;
> > > >  }
> > > >
> > > > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device =
*vdev,
> > > > +                                   u32 flags,
> > > > +                                   struct vfio_device_feature_dma_=
buf_tph __user *arg,
> > > > +                                   size_t argsz)
> > > > +{
> > > > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > > > +     struct vfio_pci_dma_buf *priv;
> > > > +     struct dma_buf *dmabuf;
> > > > +     u8 comp;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_=
SET,
> > > > +                              sizeof(set_tph));
> > > > +     if (ret !=3D 1)
> > > > +             return ret;
> > >
> > > [Severity: Medium]
> > > vfio_check_feature() returns 0 for VFIO_DEVICE_FEATURE_PROBE, causing=
 an
> > > early return of success.
> > >
> > > Should the hardware capability check (pcie_tph_completer_type) occur =
before
> > > checking the feature flags, to avoid falsely reporting that the featu=
re is
> > > supported on devices that lack TPH?
> > >
> >
> > Will fix it with a change like below:
> >  -     if (ret !=3D 1)
> > +     if (ret !=3D 1) {
> > +             if (ret =3D=3D 0 &&
> > +                 pcie_tph_completer_type(vdev->pdev) =3D=3D
> > +                     PCI_EXP_DEVCAP2_TPH_COMP_NONE)
> > +                     return -EOPNOTSUPP;
> >                 return ret;
> > +     }
>
> Typically this is done before the check feature call.  Thanks,
>
> Alex

Sure will do =E2=80=94 move the completer check to the top in v8.

Thanks,
Zhiping
