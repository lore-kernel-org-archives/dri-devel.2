Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BE2CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A55B10EDE2;
	Tue, 19 May 2026 16:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="b7LR6Svc";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E7410ED70
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:56:09 +0000 (UTC)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JGReFF1529183
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:56:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=OJtNZW12z9Y05Vrht3lzMMxtJE0LDmlKnN/pERYf24w=; b=b7LR6SvcC44C
 UpwxWr7TYF+7fb+Uzzk2ww5cNZ9ld6C00isxqo7ahUos4G4ySo1jKCXpB2Kvk9LE
 Vc5ab3eqbVVbVgvRv/Cuqh3hqNMpNEkAx65HatqfUBopmFyDqeWWjnXqVkQofFA0
 F3AEy+31DqwwxGy+ncXGfgAWxcKdSH3ur1f3lNyw317XY//cX7BiE396TU+WLM31
 sCZ1a0LIOTRtK+anXD+bpch50n9pFuhxOKxtcXU15cZBamh0GVYLn8rF31dXg+9P
 oFOXOzREYfHk76+VyzzBoRuHef62cW3P6Fh3M7cp3cF16N52lABpWD2/D27H4B7Q
 C2nac3cq+g==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e6mm0snxp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:56:08 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-479d602f323so9974557b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779209768; cv=none;
 d=google.com; s=arc-20240605;
 b=NRE9AMzw2S3AKSzH5JCaZz3sCBek7YZJew4QYrvEjHGN1WF9UZm1lHmF6B+QdpVgOR
 plnKeqe1Ry0pDK66EKImtWSSz/cuYyr2mTZ4O76VQyHEaFWUyVF4s9La/WZHcDm0UJ8b
 25vO9E/28XKKEiKHLWBpc/4R2zbN3SEjmbNiNYJjV1FKYOtV8bZmJnE4vgXBHmbnBJWK
 5vpJOdqhpVX8Xdz765IR2XRQXR3QyEAc9v9cmx/pHgA1TcW7rY4OI189K/QrdQDmoz9c
 E0ahRFOW9KdzcTVHtDl8tX6SWP/kZByuLXe3bZEbvO4Sk+eOMp8PVI0KfzHlQ40tV/Rl
 ZTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=aJk9gSpAyyZLXyKE7r6q+vOPfRd8FFOsqzGXdkoLHG8=;
 fh=sCnCESpNyCmfnBgQk2Uy+Nc5HN0XV7YSxVR+6NXZwXQ=;
 b=Ff9p4bEs5TUlWsvzCRLl3rKswtkwo6hFsrWe086g0APyf+BZpB67B82Zza8qClsPs1
 R/mBxe1Sx5gdEX+F9A4OWpXusgcW0fbqGzcAt7vvJtLlZwpqvXV7Z8Pcp8zTTLZp3j83
 wq/UCGnpefgSH79NULrFitJ6CljuY0IAegAl35RzzNNICe4wuEnLKuk519LTLelbGQ3t
 8tiqUrZ4HvDU73wzs8JRoNrDTlMYSWKsQupGg007wh77X/Ofsb8TiwOymQ9Pgl0n3S6v
 OR6BNupYAER5C3GMPMA2NQG7mYKhCvipcuddZQYv1YESIZTDkbk46DeZExeDO8DPvTPr
 uROg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779209768; x=1779814568;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aJk9gSpAyyZLXyKE7r6q+vOPfRd8FFOsqzGXdkoLHG8=;
 b=A49uExHUQ1QQJHuo9BGmd1fvsm1U3c6XlFlwrElJruu9zVTksYcROjuwk7y2UtJIM+
 b5uJLpnq1py7LWSI6ZeDAniXhpbWl9iBWEHC7rD8WlJUItoDYBR8pqvsULY8kyW7jRoO
 9UbIiT0u7hZlFdDJb4xpFayRixrFFzAcMzdQ82jpEJhgGLjjENCogZ1nl3keIakOS0iU
 I9nNumA4FnRsA6RqWAhZScy96my9/9moBgleJYuMUo02Nonq9XPoJqdt/bYLkZ5qBtMn
 55CEYgS4TQSXH0ytLQQ+8fFSznSMGiD8F4+YZv16nKvQXHftydPUMD11ht6Dg8OdoSKQ
 HN9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bLmjNFjMFPhPPWVlGSu4Y+4m92UUncG+73NyColjYUQ2KcjH3v03mm2x14L+qKqiZtlZpguO3c8I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkRVi6i9QBXOPN04P6WhGO8r9eeAKMhj2Wl/mbyubX/I6xcpEZ
 MfpxwecFRmUJKWYuhdEL+mWsl4O32fuVOEfT1O0UK5HTnXzHkJ+Pqd+0xRcBpBn5DgTVQOIGzar
 LGgXYkMp2QvH43cMMF1ip6Nol/XDkwDcMjlYa8MtEFM2EP3Ln3J7q/64tRaFR3HqrX/8mj/hl7w
 JPd4MkNwhXFbVkmsW1pfHwkSacaTkESjldSSf6r3HLMuc=
X-Gm-Gg: Acq92OH9HKEfbsBvuQP1NK7oz6i0bE5bPfoDTkcSa/ClikkCjMXDLJvVOdwLQFuelUv
 TvsZl7kVu1zRFShD4jraf3ai72wE+G10r7yGeFypfKxitgK8Vg+c3PA2Cm/Vsd8dH6IvL+KogAa
 B+eLxk51Hj6IINXQwsp1E5da1UrqBEnUbqQaP5x99Tk2pA+XpcR8fH3QIpnPBPNIxN+dBUtYCoI
 nfMybVaqQg+7RayQCU=
X-Received: by 2002:a05:6808:3a14:b0:45e:f0af:5148 with SMTP id
 5614622812f47-482e572b473mr12912263b6e.30.1779209767848; 
 Tue, 19 May 2026 09:56:07 -0700 (PDT)
X-Received: by 2002:a05:6808:3a14:b0:45e:f0af:5148 with SMTP id
 5614622812f47-482e572b473mr12912231b6e.30.1779209767200; Tue, 19 May 2026
 09:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260512184755.4137227-1-zhipingz@meta.com>
 <20260512184755.4137227-2-zhipingz@meta.com>
 <e6928a10-77b1-4fdf-8bc3-cd0154b4d4c5@huawei.com>
 <CAH3zFs2W5cB5Jhk8pm9K=O3-DyN3tHm7h5q9Hu26ekV=_gBEvw@mail.gmail.com>
In-Reply-To: <CAH3zFs2W5cB5Jhk8pm9K=O3-DyN3tHm7h5q9Hu26ekV=_gBEvw@mail.gmail.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 19 May 2026 09:55:56 -0700
X-Gm-Features: AVHnY4II7Geh49KwlOFnaMEUnIiyWZTiYUlxcqTc_0jLUETaJ7j0xzUGRx7Zyn4
Message-ID: <CAH3zFs0u2j-PdNjmtCuu8rZm5F0aVQYFo3NuSk0ptByUwrz2ng@mail.gmail.com>
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
X-Proofpoint-GUID: V8C77IXhgTA4Z7SdaWswz4pR0xM3ilZd
X-Proofpoint-ORIG-GUID: V8C77IXhgTA4Z7SdaWswz4pR0xM3ilZd
X-Authority-Analysis: v=2.4 cv=UN/t2ify c=1 sm=1 tr=0 ts=6a0c9628 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VabnemYjAAAA:8 a=i0EeH86SAAAA:8 a=Tw_J5DVj0enz2h0_CHoA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2OSBTYWx0ZWRfX30nw5aV611SN
 Zn/0GuR1JkShkB12uEj4kwzrcVXty4aNn3btZL4QQwxIsrWlF8PLacbVOiPmlhfJvCaGnh5dJPx
 3kUoEnc5X2/C+xKIuJSKwx6mv7t3+T69ewTI9MZCJTcdTdTcy+tlcU3IeKNUpNdyk+jxwOFSHpd
 5XAosskvyadHZtEUNjFwmLO6Azjout2BVzpj3d4eExW7qpYCRBOWMFoBVibo54id1GmItx7vBTC
 VMmfiO+zfp2PPAg27Z031xfk0DMVUlWe0mVDJBU1xEiIom98yfggVEe2ZkVR48yY77cV+/YlXsr
 CpK47ZfQ9ZJuLVpSwOiYmRPbEzdkqmo2YonD8RV4/snB5ze/fkxb67rNVAhOtPQoogjSRw0F3HP
 QPN9jmEWpoqGJVkjFo43EXhVPKfuZnkx5hgPlJhwNlJn8gUdPovoW9rwifetLbuY8/xq0qHs+8z
 UVsBRNjSDTypCD1W6eA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
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

On Wed, May 13, 2026 at 11:08=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> =
wrote:
>
> On Tue, May 12, 2026 at 6:33=E2=80=AFPM fengchengwen <fengchengwen@huawei=
.com> wrote:
> >
> > > >
> > Hi Zhiping,
> >
> > I have several suggestions:
> >
> > 1. In struct vfio_device_feature_dma_buf_tph, steering_tag is defined as
> >    __u16, but PCIe TPH base steering tag is only 8-bit. We can use __u8
> >    for steering_tag to shrink structure size and reduce reserved paddin=
g.
> >
> > 2. The flags field seems unnecessary. We can use value 0 of steering_tag
> >    or steering_tag_ext to indicate the corresponding ST entry is not
> >    available, which simplifies the uAPI design.
> >
> > 3. All TPH metadata fields (st, ext st, ph) fit within 32 bits. We can
> >    wrap them into a union with atomic_t, then use atomic read/write
> >    instead of memory_lock plus smp_load_acquire/smp_store_release. This
> >    makes lockless access cleaner and avoids ordering maintenance.
> >
> > For details, see the text.
> >
>
>   Hi Feng,
>
>   Thanks for the detailed review.
>
>   1) Regular TPH uses an 8-bit ST, while Extended TPH uses a 16-bit ST, so
>   so Extended TPH in Flit mode TLP can carry a 16-bit steering tag in
> the request.
>
>   2) I still think I need an explicit validity indication rather than usi=
ng
>   `0` to mean "not present". ST and Extended ST can coexist with
>   different values (including the value 0).
>
>    3) I also do not think packing the fields into `atomic_t` removes the =
need
>   for `memory_lock` here, because the write side still needs the lock for
>   `priv->vdev` ownership/lifetime checks and the dma-buf list/cleanup
>   paths. Open for discussion, though.
>
>   Thanks,
>   Zhiping
>
>
>
>
> > On 5/13/2026 2:47 AM, Zhiping Zhang wrote:
> > > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > > so peer devices can reuse the steering tag and processing hint
> > > associated with a VFIO-exported buffer. Add a new
> > > VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> > > VFIO_DEVICE_FEATURE_DMA_BUF along with the TPH values, validates the =
fd
> > > is a vfio-exported dma-buf belonging to this device, and stores the T=
PH
> > > metadata under memory_lock. The existing VFIO_DEVICE_FEATURE_DMA_BUF
> > > uAPI is unchanged.
> > >
> > > 8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe T=
PH
> > > ST table (firmware reports them as separate fields with separate
> > > validity bits in the ACPI _DSM ST table), so the uAPI carries both
> > > values along with a flags field that indicates which value(s) are
> > > valid for this device. The exporter selects the value that matches the
> > > importer's requested width and returns -EOPNOTSUPP if that width is
> > > not present, instead of substituting a value across namespaces.
> > >
> > > Publish the TPH fields under memory_lock and gate readers on a
> > > release/acquire on the flags field; this lets get_tph() run lockless
> > > and avoids inverting the memory_lock -> dma_resv_lock ordering set up
> > > by vfio_pci_dma_buf_move(). Convert the @revoked bitfield to a plain =
bool
> > > so concurrent updates of @revoked (under dma_resv_lock) and the new T=
PH
> > > fields (under memory_lock) cannot race on a shared bitfield byte.
> >
> > The commit log includes many implementation details, why not remove or =
simply it.
> >

sure, will do!

> > >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > >
> > > ---
> > >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 113 +++++++++++++++++++++++++++=
+-
> > >  drivers/vfio/pci/vfio_pci_priv.h   |  11 +++
> > >  include/linux/dma-buf.h            |  21 ++++++
> > >  include/uapi/linux/vfio.h          |  35 +++++++++
> > >  5 files changed, 182 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio=
_pci_core.c
> > > index 3f8d093aacf8..94aa6dd95701 100644
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_dev=
ice *device, u32 flags,
> > >               return vfio_pci_core_feature_token(vdev, flags, arg, ar=
gsz);
> > >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> > >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, =
argsz);
> > > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, a=
rg,
> > > +                                                      argsz);
> > >       default:
> > >               return -ENOTTY;
> > >       }
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vf=
io_pci_dmabuf.c
> > > index f87fd32e4a01..28247602e359 100644
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > @@ -19,7 +19,23 @@ struct vfio_pci_dma_buf {
> > >       u32 nr_ranges;
> > >       struct kref kref;
> > >       struct completion comp;
> > > -     u8 revoked : 1;
> > > +     /*
> > > +      * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > > +      * consumed by the @get_tph dma-buf callback.
> > > +      *
> > > +      * @tph_flags is the publish/consume gate: writers populate
> > > +      * @steering_tag, @steering_tag_ext and @ph first, then store
> > > +      * @tph_flags with smp_store_release(); readers do
> > > +      * smp_load_acquire(&tph_flags) before accessing the value fiel=
ds.
> > > +      * @tph_flags =3D=3D 0 means "TPH not set". Writers serialize v=
ia
> > > +      * vdev->memory_lock; readers are lockless to avoid AB-BA again=
st
> > > +      * the dma_resv_lock held by importers.
> > > +      */
> > > +     u32 tph_flags;
> >
> > As subsequent comments, can proceed without tph_flags
> >
> > > +     u16 steering_tag;
> > > +     u16 steering_tag_ext;
> > > +     u8 ph;
> >
> > struct dma_buf_tph {
> >         union {
> >                 atomic_t val;
> >                 struct {
> >                         u16 st_ext;
> >                         u8 st;
> >                         u8 ph;
> >                 };
> >         };
> > };
> > Set and get are done with atomic operation, no need for lock
> >
> > > +     bool revoked;
> > >  };
> > >
> > >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > > @@ -69,6 +85,35 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *at=
tachment,
> > >       return ret;
> > >  }
> > >
> >
> > ...
> >
> > >
> > > +     /**
> > > +      * @get_tph:
> > > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > > +      * @steering_tag: Returns the raw TPH steering tag for @st_width
> > > +      * @ph: Returns the TPH processing hint (2-bit value)
> > > +      * @st_width: Consumer's supported steering tag width in bits (=
8 or 16)
> > > +      *
> > > +      * Return the TPH (TLP Processing Hints) metadata associated wi=
th this
> > > +      * DMA buffer for the requested steering-tag width. 8-bit ST an=
d 16-bit
> > > +      * Extended ST are distinct namespaces in the PCIe TPH ST table=
, so the
> > > +      * exporter must select the value that matches @st_width and mu=
st not
> > > +      * substitute one for the other.
> > > +      *
> > > +      * Return 0 on success, -EOPNOTSUPP if no metadata is available=
 for the
> > > +      * requested width, or -EINVAL if @st_width is not 8 or 16.
> > > +      *
> > > +      * This callback is optional.
> > > +      */
> > > +     int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *p=
h,
> > > +                    u8 st_width);
> >
> > how about rename steering_tag to st?
> >

I'd like to keep "steering_tag" in this signature if you don't mind.
The verbose name keeps the signature self-documenting.

> > > +
> > >       /**
> > >        * @map_dma_buf:
> > >        *
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 5de618a3a5ee..53b2bbd9fc1e 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -1534,6 +1534,41 @@ struct vfio_device_feature_dma_buf {
> > >   */
> > >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> > >
> > > +/**
> > > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints)=
 metadata
> > > + * with a vfio-exported dma-buf. The dma-buf must have been created =
by
> > > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
> > > + *
> > > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_=
DMA_BUF.
> > > + *
> > > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext)=
 are
> > > + * distinct namespaces in the PCIe TPH ST table; userspace should po=
pulate
> > > + * the value(s) it has from the firmware ST table for this device an=
d set
> > > + * the matching VFIO_DMA_BUF_TPH_ST / VFIO_DMA_BUF_TPH_ST_EXT bit in=
 @flags.
> > > + * An importer requests a specific width and receives the matching v=
alue;
> > > + * if the requested width is not present, the importer is told TPH is
> > > + * unavailable for this dma-buf.
> > > + *
> > > + * ph is the 2-bit TLP Processing Hint and must be in the range [0, =
3].
> > > + *
> > > + * The user must set TPH on the dma-buf before the importer consumes=
 it.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> >
> > -1 and errno is set on failure.
> >

This documents the kernel-side return value;
the -1 / errno form is what the libc ioctl(2) wrapper presents to userspace.

> > > + */
> > > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > > +
> > > +#define VFIO_DMA_BUF_TPH_ST          (1 << 0)  /* steering_tag valid=
 */
> > > +#define VFIO_DMA_BUF_TPH_ST_EXT              (1 << 1)  /* steering_t=
ag_ext valid */
> >
> > It could be represented by judge whether steering_tag/ext =3D=3D 0
> >
> > > +
> > > +struct vfio_device_feature_dma_buf_tph {
> > > +     __s32   dmabuf_fd;
> > > +     __u32   flags;
> > > +     __u16   steering_tag;
> > > +     __u16   steering_tag_ext;
> > > +     __u8    ph;
> > > +     __u8    reserved[3];
> >
> > How about:
> > struct vfio_device_feature_dma_buf_tph {
> >         __s32   dmabuf_fd;
> >         __u16   st_ext;
> >         __u8    st;
> >         __u8    ph;
> > }
> > If st_ext is not zero means it valid, and also with st field.
> >
> > Thanks
> >
> > > +};
> > > +
> > >  /* -------- API for Type1 VFIO IOMMU -------- */
> > >
> > >  /**
> >
