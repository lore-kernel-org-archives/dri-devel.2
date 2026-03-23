Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3D2F532FF
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BDE010E63C;
	Tue, 24 Mar 2026 09:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="eLtemJKK";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FCD410E041
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:56:04 +0000 (UTC)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NEBMGc753722
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:56:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=/SbFMZE76p3gfmGbK12ObrHMOu+elkT4/3PXLPlFc6s=; b=eLtemJKK4Has
 CmgOJDrPyaoCnUKj/6m6pqv7c6rX5uKoNz278WPHV0NiaUJpobtYFO2c/H2u68V6
 rUcPfFnGGMkA1R9FznzGaso1EetXEsib33uPa8YS5DWKk/0H2+KRC5WmKpB4cexD
 WHP7rDQAp69Dwi6aLhiv0mxz/YtBATdPlBxZtCUbBSkgvz/ZWuCH7WY9e+9QunMn
 U71mnXfpBfmdW222Bg4EpE/mrvmdhA8ahhryGTBsBHhUVMfP+BPmcCKkhg/LGSi4
 aPVDqho1R8TPq9TMs70rd1fcR4pcGEwLRzN4l/Xx6Hgq2nJapc1J6r1TnayJIgy3
 wnJnWEn1Dw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d1r9t60s9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:56:03 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-40f192cf4b6so13321620fac.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774277763; cv=none;
 d=google.com; s=arc-20240605;
 b=HCaJIYgAQC9lplsyeiD6zdv8eof1CZb5xdqPRMykZc5ymZEq8QTYCG1ttX+Kk7Xzij
 CTjRn5hyr7n6PPwFjFTcZkCJ5U8zDZl/K02/pTNsjxFhZymPcj+i5SDg2h2QfiMOYFHM
 Clx5iU/vMXQz8dEMfj2X1pAaLNnbEQ+sbYlDqx7LBvD/KXAzpg1DYRwO4Dzr3erXKEKC
 +ma74VeFZiApNNwNtfpjJzyllhRvwwBfYGyOLX7kyRuw/Vm4NgteZkkYeE6VLlfZdnqH
 w8ij8KO+Ul0BUtTquKToIxg2rtwQtYjtZcpE0dBfeuD4qLfpZRKr8toYSsHWA8KQrFuT
 0Gdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=/SbFMZE76p3gfmGbK12ObrHMOu+elkT4/3PXLPlFc6s=;
 fh=5YQdr2Nox9z6FllYA7RsVF5/7jnzUt+Y5pVBZ/axmdE=;
 b=lmppDQWglMSX2S9WYZhT0/8fxPnVKiQw4BR69KULQnT2nhPSOZLXE/qMA0MMSiIMjH
 3LF8XHgs8ci4qSq9nIP1dyvptwE5D3guLijdbLXfAtgr1kTGTfvackAdgxd+HHjVWB3x
 oz0EaE/bkILYf/oaX1aCz6VyVEHXXhIuUdqSuvxjLPF4Wg5yaU5qtdTtwf1GM9v5mk5m
 q3G2Ml01bi7DKwDt3whOf6fSuJKIlWrNH5XquyTpZe8ndGeEadFdOGgGfBwJWM+I45OQ
 0UjDjJONM/2h6gUBNLepr9xyHyqJZcNyVZND7hsP+t1BXxHeTetsWLzEKqum5pEG9I76
 29yA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774277763; x=1774882563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/SbFMZE76p3gfmGbK12ObrHMOu+elkT4/3PXLPlFc6s=;
 b=Kl9vWbk6oisX7QS6w58Ng5e612229dDyuUnFoahB3CtDg6HKWiwoQi5xl3CV1ou1T6
 iPDBBmUxSq9sWSv3fO8mV9RhS1iRL22YF1pI0606GBROelUJjN8w3AfxMnmIUZ3QRO6z
 vFaspLS21fuxy2pBLFVZJtb1z1vuxJqmdeUfulK+rAPQvJBs/Ks/qjXp3ll9B6hnh5li
 7RPFmCE9i/NrlM7yQtH25lrrqVTY37PuzP0bp64egH9RGbTfltDzO8kGYklQnDm1XXIv
 V/L3h0yfw/kbmgVGI9o1B5BfxicND8bQCaB06pPBbT3KPCKleOmTKZ7VAr1EHAGhsn5k
 0wwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaMQVAKjugUYrS9DOI8uk5+3pvk2aKI3+eWV5AELd1KDNOp9cSUVz+l6zcnjlLTHA3TTA5meEnglA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxV2fQkDBjJMIieID5lDpx6+2GlpFDrtr4JWfq1ygmNNJYF0z+r
 RZr7LmgdbyPo6LbCgP1wdyJnglrH3epsY514TBxfYsXK0uh1mMCP8dQ1ZXONDCfYE0NtokTmPFB
 WesUo+mRm7+0RRiwNppsZZVLHWcbZe/m0FpIWFdDYZO0VvrTybNelzELyUeNyYKNMe1I7E6JUWU
 /pisg79e0W/99S/2fhNhYPluo6H9zbe91Byg9z+oJlwKo=
X-Gm-Gg: ATEYQzyBr+11GcPYOlQQd9nqz6aRbtLspGVlchxOXKWb+OW6AEx0NsWiqg9QFbYePnG
 fVy5aTJNtSoALbNO52IqZi5hSG6woVix0S1HbIB8O86P0S4KqWSA81CitqTEr9pwzMmL89RYjTH
 RLau4ph5BSXqd/3FeAohGmkoNbf/y5VyAW8wYy72yKxhC0i32S3PZSRcfzokluIwAX+0bGAARuN
 TJfY1+8k2Dqw8DIN/qubg==
X-Received: by 2002:a05:6870:d694:b0:409:77a9:f951 with SMTP id
 586e51a60fabf-41c10eff3demr8063014fac.11.1774277762643; 
 Mon, 23 Mar 2026 07:56:02 -0700 (PDT)
X-Received: by 2002:a05:6870:d694:b0:409:77a9:f951 with SMTP id
 586e51a60fabf-41c10eff3demr8062984fac.11.1774277762035; Mon, 23 Mar 2026
 07:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260312184613.3710705-1-mattev@meta.com>
 <20260312184613.3710705-5-mattev@meta.com>
 <20260318140408.4677fff5@shazbot.org>
In-Reply-To: <20260318140408.4677fff5@shazbot.org>
From: Matt Evans <mattev@meta.com>
Date: Mon, 23 Mar 2026 14:55:51 +0000
X-Gm-Features: AaiRm53cK7A_m0KWvttAGgjGrqlnTSfUkM-9VEpOFaKWwlBtmEfLrXJeDgr0v_M
Message-ID: <CAFzAbJGdYpaw0rAwLxLqqzzUiaPjySLXYsnS+hWwF4-GkBmgyQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 04/10] vfio/pci: Add a helper to create a DMABUF
 for a BAR-map VMA
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExNSBTYWx0ZWRfX2h4073oQFBX7
 yoj/Vf4LHLy5aNg1q6WiQ9e8xzc1qjsygnN4aZDPnOw3N7WAdcVrFQjbc+P0w9cum7plYhdFJYA
 RNV+Aa3aF6TYfyxE3nBD3yaAKzkoG3hgv0guA3QMP1laj5C6f8ydCPTLLGLehGtklPlQL5r/aFj
 XodB+mVL/cr3XXmN6TSQgsZ3t8qnzIQ2QZAk05B0gPwfCXtX0rBy7/bTJ60WbWqK2McpXuKk/HM
 qQDvKmiMPE9GcH8LQPBmCGFSjqu6pRlq6lLa3+2rUtjQ2F3HsBNuNd0WqcE6BJ0vXfoi4KyHm2K
 zegLbjKZ9QPjpXleA4R9YYtk5BeW1RMY8/VhhoxOE7tUR1y5DmZmp6SDVXynkY3Q6usoIaxgjpX
 UUAYefOOzGsxYPT/qv96zNqZxKY82HZ9KTUeiHvtkyS9DTwmk2vYpx6O6ugN1rYl6fDqMskZoJA
 7rd30em+O10F28tFAog==
X-Authority-Analysis: v=2.4 cv=b8O/I9Gx c=1 sm=1 tr=0 ts=69c15483 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=Dv35txUGz5gI0hTa:21 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8
 a=cHgMKt-ThCp0vrf1_T8A:9 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: xhDVpn2mp53QtAYWif3Psg9Iz2SL-ImB
X-Proofpoint-ORIG-GUID: xhDVpn2mp53QtAYWif3Psg9Iz2SL-ImB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Mailman-Approved-At: Tue, 24 Mar 2026 09:12:22 +0000
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

Hi Alex,

On Wed, Mar 18, 2026 at 8:04=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
> On Thu, 12 Mar 2026 11:46:02 -0700
> Matt Evans <mattev@meta.com> wrote:
>
> > This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
> > DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
> > commit by VFIO's ordinary mmap() path.
> >
> > This function transfers ownership of the VFIO device fd to the
> > DMABUF, which fput()s when it's released.
> >
> > Refactor the existing vfio_pci_core_feature_dma_buf() to split out
> > export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
> > this new VFIO_BAR mmap().
> >
> > Signed-off-by: Matt Evans <mattev@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 131 +++++++++++++++++++++--------
> >  drivers/vfio/pci/vfio_pci_priv.h   |   4 +
> >  2 files changed, 102 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 63140528dbea..76db340ba592 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -82,6 +82,8 @@ static void vfio_pci_dma_buf_release(struct dma_buf *=
dmabuf)
> >               up_write(&priv->vdev->memory_lock);
> >               vfio_device_put_registration(&priv->vdev->vdev);
> >       }
> > +     if (priv->vfile)
> > +             fput(priv->vfile);
> >       kfree(priv->phys_vec);
> >       kfree(priv);
> >  }
> > @@ -182,6 +184,41 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_=
buf *vpdmabuf,
> >       return -EFAULT;
> >  }
> >
> > +static int vfio_pci_dmabuf_export(struct vfio_pci_core_device *vdev,
> > +                               struct vfio_pci_dma_buf *priv, uint32_t=
 flags,
> > +                               size_t size, bool status_ok)
> > +{
> > +     DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > +
> > +     if (!vfio_device_try_get_registration(&vdev->vdev))
> > +             return -ENODEV;
> > +
> > +     exp_info.ops =3D &vfio_pci_dmabuf_ops;
> > +     exp_info.size =3D size;
> > +     exp_info.flags =3D flags;
> > +     exp_info.priv =3D priv;
> > +
> > +     priv->dmabuf =3D dma_buf_export(&exp_info);
> > +     if (IS_ERR(priv->dmabuf)) {
> > +             vfio_device_put_registration(&vdev->vdev);
> > +             return PTR_ERR(priv->dmabuf);
> > +     }
> > +
> > +     kref_init(&priv->kref);
> > +     init_completion(&priv->comp);
> > +
> > +     /* dma_buf_put() now frees priv */
> > +     INIT_LIST_HEAD(&priv->dmabufs_elm);
> > +     down_write(&vdev->memory_lock);
> > +     dma_resv_lock(priv->dmabuf->resv, NULL);
> > +     priv->revoked =3D !status_ok;
>
> Testing __vfio_pci_memory_enabled() outside of memory_lock() is
> invalid, so passing it as a parameter outside of the semaphore is
> invalid.  @status_ok is stale here.

So it is, arrrrrgh.  Thank you for that; I've found a couple of other
choice bugs in that RFC, and will resolve all of this in a repost
soon.

[snip]
> > +
> > +     /*
> > +      * The VMA gets the DMABUF file so that other users can locate
> > +      * the DMABUF via a VA.  Ownership of the original VFIO device
> > +      * file being mmap()ed transfers to priv, and is put when the
> > +      * DMABUF is released.
> > +      */
> > +     priv->vfile =3D vma->vm_file;
> > +     vma->vm_file =3D priv->dmabuf->file;
>
> AIUI, this affects what the user sees in /proc/<pid>/maps, right?
> Previously a memory range could be clearly associated with a specific
> vfio device, now, only for vfio-pci devices, I think the range is
> associated to a nondescript dmabuf.  If so, is that an acceptable, user
> visible, debugging friendly change (ex. lsof)?  Thanks,

(Jason, your comment noted with thanks, replying to you both here to
save electrons.)

Great question; a formatting change there is inherent to moving to a
DMABUF (which generates a "/dmabuf:" prefix to a user-defined name).
If we can accept that it changes at all, then I agree this then should
output nice debug: at least the cdev name and resource index, and
we've the opportunity to include the BDF too.  I've added this; an
example line of /proc/<pid>/maps:

    ffffb8070000-ffffbc040000 rw-s 00030000 00:0b 5
      /dmabuf:vfio0:0000:00:03.0/1

Note the file offset used to include the resource index up at
VFIO_PCI_OFFSET_SHIFT but this DMABUF version doesn't do that, so I'm
proposing appending a "/%u" for the index.  Above is a map of BAR1,
offset 0x30000.  If people feel strongly about the existing aesthetic
then we could keep the index encoded in vm_pgoff to retain the same
offset field in /proc/<pid>/maps, but it'd be less neat masking it
back out in a few places.

The default name of a DMABUF acquired through
VFIO_DEVICE_FEATURE_DMA_BUF would still be "/dmabuf:" and I think it
should stay this way since a better name should be supplied by
userspace.  The default at least differentiates them from VFIO device
fd mappings.

Many thanks,


Matt


>
> Alex
>
> > +     vma->vm_private_data =3D priv;
> > +
> > +     return 0;
> > +
> > +err_free_phys:
> > +     kfree(priv->phys_vec);
> > +err_free_priv:
> > +     kfree(priv);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool rev=
oked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_p=
ci_priv.h
> > index 5cc8c85a2153..5fd3a6e00a0e 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -30,6 +30,7 @@ struct vfio_pci_dma_buf {
> >       size_t size;
> >       struct phys_vec *phys_vec;
> >       struct p2pdma_provider *provider;
> > +     struct file *vfile;
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > @@ -128,6 +129,9 @@ int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_b=
uf *vpdmabuf,
> >                             unsigned long address,
> >                             unsigned int order,
> >                             unsigned long *out_pfn);
> > +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
> > +                                struct vm_area_struct *vma,
> > +                                u64 phys_start, u64 pgoff, u64 req_len=
);
> >
> >  #ifdef CONFIG_VFIO_PCI_DMABUF
> >  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u=
32 flags,
>
