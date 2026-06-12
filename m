Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402CBCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5BE10F5BD;
	Fri, 12 Jun 2026 16:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="NLBMOfLN";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="MDNDcZwo";
	dkim-atps=neutral
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B834510EAA3
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:59:31 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 2579CEC0183;
 Fri, 12 Jun 2026 12:59:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 12 Jun 2026 12:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1781283571;
 x=1781369971; bh=JA1Rl6a/vTeZ5IR6A573kEspO/Oh48ACbWZzEGhjKYc=; b=
 NLBMOfLNDWpdi0Vvge5UxNOVvf8DPbKjEWFL2hwGqOmMicqs2joTm07bhYuLNzGz
 0SXIw0hlPPtAtYFouuhHrcRXxGvtHyQHO+w48jMDqzdK8XboAFXP8b4IA1TCh2Xc
 hC/13b2GfiZVgwn4sfLPgxNxiw0MhrEKTG0Q2Ia3JEMHWQavOgeUd8ntaut/Lp81
 vxATdMbOS+525pQnJr/QsFhg5dx/9EviIDInmyfoVlbIPgY6pyfk7mGTF598+cyT
 9T5jrD1OAGYc0o0o2D91m10uCubWYuB5axSKYNZN45dBTydeWLBP0ES6SwtwU3Bx
 i18RWHOjCWMXULd3HF7bkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781283571; x=
 1781369971; bh=JA1Rl6a/vTeZ5IR6A573kEspO/Oh48ACbWZzEGhjKYc=; b=M
 DNDcZwo/L6xYyGJxFCF6pyBupDWXBOJk+KRBMREjRp7JpLREQvZ1wxnVmhw9srA0
 7Z94iCE2RPAZ87LL9GtEYMvSPB6TwfGZgWQlSefNClA1MMyGxf/NSTWKA9a6vCjg
 2PS3t2Eyk8ukpeEDJy4Gt9lvplCRU/jzn/SFGRhXJGf5ADPJXKstQRO6YNhLDCn3
 s8mO7eVf3SZsXLGbeseKlY9ebxuRAYZYqGl4DoC5qE21BOfv8tRKqb+DXTC92VQJ
 OWH65Ab2dCBA+B8MaqcfZyla8edeiPDAuQfB5zaT9RcknmwBRAcQPkIjrsiMk+EP
 mRKcbs1B44RkPFYc/j03w==
X-ME-Sender: <xms:8zosar6F5gbc--qU4lnqGAB8juW7oAwCMFdu8Vh7_UMYSArHmLBybQ>
 <xme:8zosajKqRRred1fBo61zbHzpYkR97aHHhgMvwj1CikwzV7jltaSGOcFqG42vty_E8
 9fe1sCTChTxiNVNxhnbqBUnDbO3bJGgfP3gTq9DnVpzPVSzDjDTag>
X-ME-Received: <xmr:8zosaks_7vOydPJVTRqHVFuhi92EJvtx3Z1WLnLpr_jAqUXTjDxfqonolrU>
X-ME-Proxy-Cause: dmFkZTFK4BbIWe0NOhjcdMO6xfngXvxjqtqEanh4IEr51RKD//T1XvD8FBwDZTTz09hMDI
 G2UjD2RzCDFOFbXpXMdiydmD2vEEmpRrdEDzJGAZeCJL99C5B1ClcaSO0WCV8J7gkln1Uf
 b056NtK6X2GzkH2n4uC4dHto4d0LSDeW+4t6l6tpTwG9Lb50Mt58bRACHKPpE68T8b0SWG
 j1SRW6GpkFceHFoJeZRRFyQH2I8YeqN8hmPOL9AqFKyJ1lmmvsb/SFaIBm8uw21305JoRg
 3jqGCNtnOUiDXi11lrH82K8Pq1/tDynd19x2jjfTinaJfDcOSTeNoQfVYMZeO6PKcKP1Zc
 eEoF5jWeKik+VS15W/wIQ0pk92aaWZKh7sPzk0TMwP9lpptu/LpwJqQbJ+I+yDjrf+Eeal
 LLvBkCddtQtHIJE/fced4290aHk+KyeAilRG28tYjS4lYK7azMVrv1F0QFN3mebF5vifw+
 NWC34+wyKjwPHP7zgJ6lnSQ8FBaHl9j9S2J9afDbdNwYH31MQ+5+FfkRhJROoNwXCZeyah
 V+d41URJqyHxFNT3n67qluGSKWlZqU/l1L2CN17bNSk9AianiE5tficxTgX15F6Y9S9fLK
 7osyEzDgaLOpQ8H8QGc6xQ0az9oNhVILLIuOdun6BWWkg1LTqP+TqajcDnrQ
X-ME-Proxy: <xmx:8zosaiLDIdvCu0iA17DKPUuAtoHtGpAFlrWV45g5zm1PGi6_KEa2mw>
 <xmx:8zosat91vUmE8zZvnIiLE28mpP9PgATMnG1nGwxHwsDuwWq-nxTK2w>
 <xmx:8zosarzpcvuk2a3b5raV4I5YOXjn1SQU5KSQI2kVapcWOdkKpn3u8A>
 <xmx:8zosaq7IFkOCOxkCz3nb1L1CgQEsnyoRp-yfpnBlaTbgUgjNghH18w>
 <xmx:8zosamfvzh2UcyxTWsCtpSynCSyClYEeUvo2H2fCNXIGDaPJaWLzyq3z>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:59:30 -0400 (EDT)
Date: Fri, 12 Jun 2026 10:59:28 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, alex@shazbot.org
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
Message-ID: <20260612105928.200220b8@shazbot.org>
In-Reply-To: <CAH3zFs3FjiCfOceVRin0ytKNdZ7Pgyv4ds=Dd_GhrRC_XcbNOg@mail.gmail.com>
References: <20260610193158.2614209-5-zhipingz@meta.com>
 <20260611202555.B0FE31F000E9@smtp.kernel.org>
 <CAH3zFs3FjiCfOceVRin0ytKNdZ7Pgyv4ds=Dd_GhrRC_XcbNOg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 11 Jun 2026 16:02:25 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> On Thu, Jun 11, 2026 at 1:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > =20
> > > =20
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [Medium] Unconditional validation of the flag-gated 'ph' parameter ca=
n lead to spurious -EINVAL errors, breaking the syscall trust boundary.
> > - [Medium] VFIO_DEVICE_FEATURE_PROBE falsely reports that VFIO_DEVICE_F=
EATURE_DMA_BUF_TPH is supported even if the hardware lacks TPH support.
> > --
> >
> > commit d57637d667ca6dc95def77a0a5bd339d62d4f506
> > Author: Zhiping Zhang <zhipingz@meta.com>
> >
> > vfio/pci: implement get_tph and DMA_BUF_TPH feature
> >
> > This commit implements dma-buf get_tph for vfio-pci exported dma-bufs a=
nd
> > adds the VFIO_DEVICE_FEATURE_DMA_BUF_TPH feature. This allows userspace=
 to
> > publish TPH metadata for a VFIO-owned device. It checks completer suppo=
rt
> > and protects the metadata under dmabuf->resv.
> > =20
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vf=
io_pci_dmabuf.c
> > > index 1a177ce7de546..0a0705c8dbea6 100644
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c =20
> >
> > [ ... ]
> > =20
> > > @@ -333,6 +360,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pc=
i_core_device *vdev, u32 flags,
> > >       return ret;
> > >  }
> > >
> > > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *v=
dev,
> > > +                                   u32 flags,
> > > +                                   struct vfio_device_feature_dma_bu=
f_tph __user *arg,
> > > +                                   size_t argsz)
> > > +{
> > > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > > +     struct vfio_pci_dma_buf *priv;
> > > +     struct dma_buf *dmabuf;
> > > +     u8 comp;
> > > +     int ret;
> > > +
> > > +     ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SE=
T,
> > > +                              sizeof(set_tph));
> > > +     if (ret !=3D 1)
> > > +             return ret; =20
> >
> > [Severity: Medium]
> > vfio_check_feature() returns 0 for VFIO_DEVICE_FEATURE_PROBE, causing an
> > early return of success.
> >
> > Should the hardware capability check (pcie_tph_completer_type) occur be=
fore
> > checking the feature flags, to avoid falsely reporting that the feature=
 is
> > supported on devices that lack TPH?
> > =20
>=20
> Will fix it with a change like below:
>  -     if (ret !=3D 1)
> +     if (ret !=3D 1) {
> +             if (ret =3D=3D 0 &&
> +                 pcie_tph_completer_type(vdev->pdev) =3D=3D
> +                     PCI_EXP_DEVCAP2_TPH_COMP_NONE)
> +                     return -EOPNOTSUPP;
>                 return ret;
> +     }

Typically this is done before the check feature call.  Thanks,

Alex
