Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613DBCD5BBF
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 01:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C55410E2BA;
	Sat, 23 May 2026 01:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="fT1NcaLS";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3F910E027
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 01:04:11 +0000 (UTC)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64N0ei451171825
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 18:04:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=ZSYPnXqPgD1WmWUsBlypXTMK46Ru/H45VtdzBiXsUQo=; b=fT1NcaLS0als
 V0CzITn5MusJzO7wCLcepvtcBFTpq0bJwdQSvOVtuXxphbNRdr5w4GkHaTzTSf3+
 1R03uZUVNbYR09SXtNfze33jf0vl16nQtWNHx7IejIEpQwTNM6Zdr4URIJIP4IUZ
 /MxPR0PRQGLKj5okI7T8m28gwIvEkhfg4k5DlHcYM4LKRk6uMqHrbOKc8yy5HHtZ
 5eqDNEm/6fylQhFYaVIcSOMFDFs1Klh81XfuQ3MBoRuhLL4csUmWciCvrsH6JK3j
 sIxVPa7SHf06LM2veBJyy78S1WcvHjVGrhiGukFXNTCVAfsoQEefzYCSC/aL5enj
 hOGP41Rqtg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by m0001303.ppops.net (PPS) with ESMTPS id 4ea5x81qta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 18:04:10 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4853528d99dso3293415b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 18:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779498249; cv=none;
 d=google.com; s=arc-20240605;
 b=aB2iEyslv0JbJKVZ5SOzHLpOHe0i1CsbnCidPQDF2PraVRY7xIqOolE7r+qICxVbU7
 +6IyZvtSOao9oN/AsXGYDKRLWllac9cN6Cflj85AcGspXll81ZzePqIBebsHzadVNao4
 uAJw5WW/L+0dzfnTvncZkMtg6LddDvYcN+Cc0kgaVQyLrwONEJV0pPfvpa6YH7hQx4UJ
 l4If1I8y/wZX3R+2wmnPoBJ9lDoLUEFK8QfWDYwymfTCbVQS4+bYVsZOlcmE9BGYcqlc
 3LmqvFJixNyLvHitNQOqklSaHrNI1yAte8Nd5CNvo3OU+LlwyhOWBuMJMh5R91HsHPhA
 FqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=ckSywFlrQVuSq3t4EfSWLfDKEF0bsmOAyDZjQDxER6Y=;
 fh=MHaEzg+yD9LqADY6DSCFrYiiJVrks1XYuaaf+63fAvA=;
 b=J7HGwIxY/R4kAI7ErVCdrB3kS08LMI4c5CwijvF62FT6MXpiAc1bel47ngMddtmmrL
 2yJffGOc1o0RV0Uqohp8EcGpF98xWG7FNNCMNpQAtS6GI55GuTCd3tbKPYHH8fcuOmAj
 c07XpSZai3vACUUtx/UezEELNTErtLFQrwPFI3PPbUTLOm4i5t9ojB9/cIZxjlRmKDq7
 m0Qt5R8nVvuXsm3KYc6xkRxDSiPRQQuwKAsRFEyOLiSt5/V0rb4/mDou4yKXABP3RWzi
 CU4pkLHm6mATgNAqRdpX6VVpP7P6+JLpO1uLJd6w11N4bKufsdqnfi1ZGLj3/Gov1tq2
 kNXg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779498249; x=1780103049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckSywFlrQVuSq3t4EfSWLfDKEF0bsmOAyDZjQDxER6Y=;
 b=Bby+kq5gM7DIH2XfBXedi63UPJ/f7QyP73ny2GVHB1ThMYjM+VFcMjfTHsTPOoqhyX
 cZSMZ8SpSpSf3qC1KfhCz/wOxZtHsJGVE1qrpSc0LiF4e8fFKoYMlZ07kW7azS+JAk+G
 xXAcwC5/kmud2FtQcDDRMiqdOMllz0YmFuiF2fgyE5Pec0I1IsPraBLT9V1o2kQkk9Sb
 VF1NDvmObTDDXCDaMKAZb1E7YZzRxYhwe/S1Zird6g6Rb6usXU+oK2xWArHdKa/IxAHc
 AB/aN09B57Uwts0YcVyJQ5v2m1pvsaz+Kyvofil5DGCLMiAJx+p6HJ/nPXFH3Zifv2Zr
 oXgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8z/DqDUXUE4H9T8KdI94AfvaY/ePDPMPA1JxUNW4SKit6qZhEktom81BOZ2TWQ6nG8Ta+3AYAIGQI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhlJVUumgit72UNp2wNqoVh6dnuokfReacRJKifYj9TJTezwuu
 uk0pERGm0ubDc3TK8YpEBuAWNXm1kAz8asYL/uWDmxEPTT01q28+JvDmSoow/C56QSHMLFW7UjI
 6LqaJf7YdjpokFocj+c/8ynfb0gwz56Mu2xcQyLuekPm8pDXyyXgqC5RuE9cliGi3P6Pw2O6Pqh
 rZ6ocheH4D6/SzDJcThVGBZGVBjv3O8yChQXWE1GodB0A=
X-Gm-Gg: Acq92OE/eDFi7ltr3mbkOehoVDGwodQCdJ/833cdZkQJZ5dh7bXsZgit9jy/JXGpcaI
 evqDe2HSPwjOEnoO5RJMkHd5NSuiZ53vqKcxnfbFVNWTYOdpGIzR9uITpf4Xd1fc+tuWUXUmP9o
 oSCegqDMUs7UMBKlL6rpG/ZSkIvXWTf9ppSVVwYt98Xu/Xksf5SKvDJBJ/7yQpuFi3mGQP7tkaX
 F0T
X-Received: by 2002:a05:6808:f0c:b0:479:de32:b310 with SMTP id
 5614622812f47-48549902f22mr3459524b6e.0.1779498249491; 
 Fri, 22 May 2026 18:04:09 -0700 (PDT)
X-Received: by 2002:a05:6808:f0c:b0:479:de32:b310 with SMTP id
 5614622812f47-48549902f22mr3459507b6e.0.1779498248992; Fri, 22 May 2026
 18:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260519201401.1558410-1-zhipingz@meta.com>
 <20260519201401.1558410-2-zhipingz@meta.com>
 <20260521160412.4fa75406@shazbot.org> <20260521162437.406085db@shazbot.org>
In-Reply-To: <20260521162437.406085db@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 22 May 2026 18:03:57 -0700
X-Gm-Features: AVHnY4InmgAbt-a7ZIoyl3OFAhk-P34lQOEjx6K7zj7MuEim3oYM-YaMDsRZ4E8
Message-ID: <CAH3zFs1gh6UZewMf9GJ6CtO5v0yWNokp-eZQ8G2QnyAyxD7-wQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vfio: add dma-buf get_tph callback and DMA_BUF_TPH
 feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=daewG3Xe c=1 sm=1 tr=0 ts=6a10fd0a cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=LZULGAC3ikq4sroI4wUA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: WHEXQw9e1CBChz8p9sspJFNigJ7T1mqy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDAwNyBTYWx0ZWRfXxojKTkmpngz+
 63CgqN3mgCb2xL9eO8afsGLXdSeVpVzD2RWSMpKtaR0i1L+O5kZlEwWd34MFmeLftTOOwGRdT6J
 Fzo+3fFYqr7QdFZVOH8KTTtj6rcC9VUW2ET61ntP+sdJOqYkaH4NQpyv2dJXT1q+6JvdA178Lum
 7B9gAs0+wbVRDxtifRNkrS3cwVeWxGb0RlhdfeVTlYPyAixZRrSLt062/vGgA2EMiy+GEL5H13s
 WdEixqFZVorAHvS5rSdyKo16eiUCnLceZBlXw+qZDSmalH6mcJKpf5lxeKJel159RF+sAFGP+AS
 kUxpigRuVoD3+N4YH+KedXCLSI2LhPLSXGOkk6sLGR+wqqPIdnroCw9AWVFZ0QzCkS8CN20fnTQ
 w7gglh3jMoSQZCCOOTBGdGxKJUpy4WDPWrGW1mU+Tbr+w/IEhWnyitqZSwbyhK+9d0LbnH8aHVE
 xlrA2bKJdSMEr7C2I/w==
X-Proofpoint-GUID: WHEXQw9e1CBChz8p9sspJFNigJ7T1mqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
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

On Thu, May 21, 2026 at 3:24=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 21 May 2026 16:04:12 -0600
> Alex Williamson <alex@shazbot.org> wrote:
>
> > On Tue, 19 May 2026 13:13:49 -0700
> > Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > > Add a dma-buf get_tph callback for exporters to return TPH
> > > (TLP Processing Hints) metadata, and add VFIO_DEVICE_FEATURE_DMA_BUF_=
TPH
> > > so userspace can attach that metadata to a VFIO-exported dma-buf.
> >
> > This should be two patches, the first extending the dma-buf framework
> > for the get_tph callback for explicit approval from dma-buf maintainers
> > (who are not even copied here).  The second the vfio-pci implementation
> > of get_tph.
> >
> > > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > > uAPI carries both with explicit validity flags so importers get the
> > > value matching their requested width. SET is write-once per dma-buf;
> > > the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI is unchanged.
> >
> > I didn't see what motivated this write-once change, I thought we
> > understood that it was a userspace problem that the tph values need to
> > be set before providing the dma-buf fd to the importer and that races
> > relative to that are a userspace ordering problem.  Write-once seems
> > unnecessarily restrictive and there's no justification provided here.
> >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 134 +++++++++++++++++++++++++++=
--
> > >  drivers/vfio/pci/vfio_pci_priv.h   |  12 +++
> > >  include/linux/dma-buf.h            |  21 +++++
> > >  include/uapi/linux/vfio.h          |  35 ++++++++
> > >  5 files changed, 198 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio=
_pci_core.c
> > > index 3f8d093aacf8..94aa6dd95701 100644
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_dev=
ice *device, u32 flags,
> > >             return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> > >     case VFIO_DEVICE_FEATURE_DMA_BUF:
> > >             return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > > +   case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > > +           return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > > +                                                    argsz);
> > >     default:
> > >             return -ENOTTY;
> > >     }
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vf=
io_pci_dmabuf.c
> > > index f87fd32e4a01..be1c65385670 100644
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > @@ -19,7 +19,24 @@ struct vfio_pci_dma_buf {
> > >     u32 nr_ranges;
> > >     struct kref kref;
> > >     struct completion comp;
> > > -   u8 revoked : 1;
> > > +   /*
> > > +    * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > > +    * consumed by the @get_tph dma-buf callback.
> > > +    *
> > > +    * @tph_flags is the publish/consume gate: writers populate
> > > +    * @steering_tag, @steering_tag_ext and @ph first, then store
> > > +    * @tph_flags with smp_store_release(); readers do
> > > +    * smp_load_acquire(&tph_flags) before accessing the value fields.
> > > +    * @tph_flags =3D=3D 0 means "TPH not set". Writers publish a non=
-zero
> > > +    * value only once per dma-buf and serialize via vdev->memory_loc=
k;
> > > +    * readers stay lockless to avoid AB-BA against the dma_resv_lock=
 held
> > > +    * by importers.
> > > +    */
> >
> > Can you outline the ABBA hazard, I'm not seeing it.  You're acquiring
> > memory_lock in the feature SET and dma_resv_lock doesn't appear to be
> > held when calling .get_tph().  There's a lot of lockless complication
> > here balanced on this claim of avoiding a hazard that doesn't appear
> > present.
> >
> > > +   u32 tph_flags;
> > > +   u16 steering_tag_ext;
> > > +   u8 steering_tag;
> > > +   u8 ph;
> > > +   bool revoked;
> >
> > If we still used memory_lock for tph, these could be:
> >
> >       u8 tph_st_valid:1; /* memory_lock */
> >       u8 tph_st_ext_valid:1; /* memory_lock */
> >       u8 tph_ph:2; /* memory_lock */
> >       u8 tph_st;
> >       u16 tph_st_ext;
> >       u8 revoked:1; /* dma_resv_lock */
> >
> > The existing change of @revoked from bitfield to bool has no rationale
> > noted for it in the commit log.
>
> On second thought, what dependency does anything here have on
> memory_lock?  I think we're jumping through hoops to avoid a lock we
> don't even need.  If we just want to serialize SET vs get_tph we could
> have a mutex on the dma-buf structure, or use RCU if we want to manage
> it locklessly and make sure get_tph always sees a fully consistent set
> of values.  Thanks,
>
> Alex

Agreed, we don't need memory_lock in this path. For v5 I'll instead add a
struct mutex lock to struct vfio_pci_dma_buf and take it in SET,
get_tph,
and around the priv->vdev =3D NULL store in cleanup.

Thanks,
Zhiping
