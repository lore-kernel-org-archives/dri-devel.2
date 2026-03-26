Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E91910ED661
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7669D10EE57;
	Fri, 27 Mar 2026 13:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="S+c8kVnG";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F0F10E025
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 22:55:57 +0000 (UTC)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QJ6v1l3537767
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:55:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=gWmaYzOqDIhtbUb8Zs5Nf1ednm4S50xRfwW0Jz6U+w0=; b=S+c8kVnGsspV
 a654lLZZ0b8EsEWQ7eZrMsM3U42hl5QQn43gPcbCwg1iIRVkzVp2dRFBMOENsKwv
 SFukOMCLHJB+BVExRhe9tAQ85TnRLm8BMieG/xu8T5GxAF4nxZYBRBXXNSu81mfz
 72IHHjWgJ7wrMUq4HLUK01uWKkwfjjbYiSew0OJdVYtTd9jpySKJMO9QYnD5wD1F
 hO4pop4o2ClGk5kOI5qvHHOrYSB5X7rKufRQLoSTlAVCrJgs3+MLzJEtviKWKK4E
 rl7jpexzUWHR2QNxm3b2slr+Jfm5udNi6cLbkjrHBtc/MhaQw/bPV2OzMvUx4TNz
 3tP95BR8hg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d51u79e55-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:55:57 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-41c08879ba3so7882106fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774565756; cv=none;
 d=google.com; s=arc-20240605;
 b=FCO3AAVXvOpGxLn2AXlsb6RjV2ThvToUoRg/KVvK1YzNQB8QFk/Ty7PIcgBAug5h7G
 xRNS2ISyTA6ou8SEgZERsKYYkp89fgG23VouoMi9BWT/3PnxEXbslU6Dx20DgOci13K2
 /WEkcp4g2ZdOIqcsTINSjLXMImJzx0UNdZEfjStcxhig0keeCerKHVjtqGq4/oKeZeYK
 4kS/8TNvvMZiPrAEnnVmXK4KeeJaYIYDViAmhi/5DNz3iVdp3DAKwR1XoRTrpNJGK1RC
 OfvpPzr7GcQCUE8RtZSnxaeKYuECh6r0ePza8l9eGBlCN1f6WnABcw0JPC1ivh8ILkr/
 z8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=VGlyvxOOFksgPXoMLERC1kCayld4eO3E5k/3hyTOpHg=;
 fh=TKkx7tFt7K5G9O3tEY78ujwsCpO8CMLeFGkx3wJzAhs=;
 b=iu+PunW/lAz2+D05EVsYjQkbcrjqAB73eOprXj7Hwf6HhYS8MUdN1gR85CBTnYipy8
 KRCQ3q7TbEAykSQEarhRjZ+cvhm4Be92Q/Gv0BytwXgCbitlYppdKFBzjINVetBrafDg
 pXC+hcf3qJhiFpoprqFScnweZjUWUD1VN1ScGXcmr6t0Gq8rftIfbddvSHzdP3mR1QRr
 2YjbuzAwZdFr5okWXNB/FajeKTH7HFAZLV0A1C6dTC35+zO1GzuQnb8jvTkRRzemWxbl
 3RZ/dVvagfg4IngpzjeMer7czp9OITy+oK/t7BqrzARRyRK8DVbKmRDKiMkSoA27msGB
 8hVg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774565756; x=1775170556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VGlyvxOOFksgPXoMLERC1kCayld4eO3E5k/3hyTOpHg=;
 b=ZHGRHfGTZZXzhSRJXZxxq10q0Z/du9HwejQirsOmv264Jqj5Y4kakTyyaSIbHNIwFn
 ODjSCe08JSllIwmIZOqhROMNJUKcxbHHBfUmKVudV7JBsJiqbD8/ZZcchheO/DbKvlQF
 YuGMtMgVqVFNDGRCR1yB1IdTetqXbU+D5DyQR0Vz9RWPoYimC87BICcfRLIbUaAa0Ghr
 ZlFTaSULzIVwFhAKZm0kJs0PBPAjbFdZiCHhTCEVag2HYVIetAfbJ2xUp/ajh9tVr7iR
 QRQ8MUgTbyj4bnFW4SBE69knqyIr1OdxAAORVhAzqwkz11aNXYW0yKPogEzrXmhoNw0A
 K16A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEgUd7Y2mrjp5aA2TjZ6H+HZ0YuKfwdM2iAAbMoK72/EWcnFWU0ULwzpciRlUL8oC/5OQoSAEzPVc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOfDBbeecuCl/gmnjk2AKwvvGgVU5dUGCvcrw6/5wbZ1ixWgjN
 nTe47EVnADzWkDnYh57br90Ioc9x0rfDpFZw6YYqBXiJDuwUMD2sG/NkFTN9zoyohpS2cDcqqLe
 Vkum0SAPi10j60EsbEWJl5ijEMeZzfvKUyCrHucOIcvctxbxCn1xHPW1I+8vBlbdwuwChrhwxha
 eN/d8RrCG0PT+A6T253zk+8MHdVqZNbr6IgRgMGtg2WYM=
X-Gm-Gg: ATEYQzw5KQRlcPeDSNrFxaNm+8ahcVtlfCEoDUlCunAgQNuCPLP7HdrqBYGOtyVDuDQ
 XfXV+f3a3Qm5HP7CmtHetON2cBSfoL/iO0sgISWY14e9Nstv+n4zaVUWp9/497SYCRvK2DXStfx
 +iRP+Cl/dykDRjsC3ZcDddaAF1n5a/6ldwlFp0htPMkRzLSLLU82XQske4xWUOChRTdN04/kNCa
 UQ98nu8GqT0a7LbJSZLHQ==
X-Received: by 2002:a05:6808:1b20:b0:45e:fd68:3dd7 with SMTP id
 5614622812f47-46a7aa42abemr1548512b6e.32.1774565756386; 
 Thu, 26 Mar 2026 15:55:56 -0700 (PDT)
X-Received: by 2002:a05:6808:1b20:b0:45e:fd68:3dd7 with SMTP id
 5614622812f47-46a7aa42abemr1548497b6e.32.1774565755966; Thu, 26 Mar 2026
 15:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
In-Reply-To: <acW2BwQKaUbS3eL9@kbusch-mbp>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 26 Mar 2026 15:55:44 -0700
X-Gm-Features: AQROBzDisNUSNgd3TlIskyBeYU1qigTy8IXoqXl2UWp2Iq9LIcNA3h_mkSfPwow
Message-ID: <CAH3zFs1nbAKpYxwzMcwpC_Sdy+3tE0n0wUzxJ411gV-q1O++qQ@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: GWERgCZw1jKshPz0s_V_xt6HbPKSzHnW
X-Authority-Analysis: v=2.4 cv=cIvtc1eN c=1 sm=1 tr=0 ts=69c5b97d cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=NFdbOB6VLuGm633tFYQA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2NCBTYWx0ZWRfX9yedUhJcr94h
 GFrv9nOo0T3d1ah0BOgSWLoGrwbJeVAsAqtAqnx8+rL4yBZhwnc6ZhGE18U/+dBiTyMZ8rq6EY6
 Ypjd4g4GlBUuLV51VjvQvv8Gi65j+HJ7WdzfxxDEmDnLBObTd1tsu3iqYzu0XRSELiWGqryROvs
 +Qp10CaGydi1djQkNHZn6hm+sawV6u3XtIKlwxqQf9vafD9nSwA7Stnut6AYLrXKjNtJ4EwORwX
 yQnq78aluUUSrFGO38XUJF/g9Y75c0vLESwzWaN+WdGYW60qOgzUxvwfAktl6gzB9oCIJKMn1k0
 eiPv6tSXyOfjxYTjs7QUC03qZwnzD/dBSVxHe1WrYb1djoOYZNXiNq0x+P+FREoG32jFOzoIFx4
 2Go7+5CG/nKcMLXfIkcHdz98qC3C4/HgKoskBPEfkxNitLb8DMHy2u3cuB4c3Jd6DgYsZJc3v+N
 CZQjoenXaZevpQzknHw==
X-Proofpoint-GUID: GWERgCZw1jKshPz0s_V_xt6HbPKSzHnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Mailman-Approved-At: Fri, 27 Mar 2026 13:46:04 +0000
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

On Thu, Mar 26, 2026 at 3:41=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> >
> On Wed, Mar 25, 2026 at 10:25:34AM +0200, Leon Romanovsky wrote:
> > On Tue, Mar 24, 2026 at 04:46:02PM -0700, Zhiping Zhang wrote:
> > >  struct vfio_device_feature_dma_buf {
> > >     __u32   region_index;
> > >     __u32   open_flags;
> > > -   __u32   flags;
> > > -   __u32   nr_ranges;
> > > +   __u32   flags;
> > > +#define VFIO_DMABUF_FL_TPH         (1U << 0) /* TPH info is present =
*/
> > > +#define VFIO_DMABUF_TPH_PH_SHIFT   1         /* bits 1-2: PH (2-bit)=
 */
> > > +#define VFIO_DMABUF_TPH_PH_MASK    0x6U
> > > +#define VFIO_DMABUF_TPH_ST_SHIFT   16        /* bits 16-31: steering=
 tag */
> > > +#define VFIO_DMABUF_TPH_ST_MASK            0xffff0000U
> >
> > This extension of flags is basically kills future extension of this
> > struct for anything that includes TPH.
> >
> > Add new
> > enum vfio_device_feature_dma_buf_flags {
> >     VFIO_DMABUF_FL_TPH  =3D 1 << 0
> > }

yes we can do that.

> >
> > > +   __u32   nr_ranges;
> >
> > add your "__u16 steering_tag" and "__u8 ph" fields here.
>
That is what I did in V1, Leon.

> You're suggesting that Ziping append the new fields to the end of this
> struct? I don't think we can modify the layout of a uapi.
>
> If we can't carve the space for this out of the existing unused flags
> field, I think we'd have to introduce a new vfio device feature that
> basically copies VFIO_DEVICE_FEATURE_DMA_BUF with the extra hints
> fields.
>
if not using the fields in the flag, then we probably have to
introduce a new vfio
device feature.

> > >     struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> > >  };
