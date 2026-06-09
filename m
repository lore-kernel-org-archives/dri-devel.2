Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCAACD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 23:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1DC10E3C0;
	Tue,  9 Jun 2026 23:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="OZKBis2V";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B21110E3C0
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 23:48:15 +0000 (UTC)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 659GTEwS1835486
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 16:48:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=s2048-2025-q2; bh=2oke7nd3qgzSpwUghUx6
 5sQAoKy1HMHaETHva/Kk8Jw=; b=OZKBis2ViNPY7hO90BNGQapT/XbUSMHitxwk
 n9XV/Gazcj+2wD9m1KqBMuPmB9/KzpVT1nBJ6WPualsEDo7qL0Vtzy+VzpzOy4WO
 VJIhhmj08GYtZwFIjFfi83tEXNicBAxgVk0RaCm2kYxY8pYZ7r7p0XmODAFwWTKL
 TQm2udjgflTsDrm3B3obBvMx4aAmTTMePMUsDel0/p/JTzF3k6rH2qDUyVCJv8XZ
 rvlRdpBmF/Gt6Ek/OaG5ScR5kK8TQn1MNMSEQ16qjRMigOILwgvGGUt7t+zhrnYT
 ox3vb1WsVoPy1SXQ5ySWLbIoP0woSdDUhL2pkCkc2mLTW+2m1A==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by m0001303.ppops.net (PPS) with ESMTPS id 4eppd52vrs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 16:48:14 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e6f7f4e47eso281789a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 16:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781048893; cv=none;
 d=google.com; s=arc-20240605;
 b=WXbiY5znmwM3AI1IK/XmMk9uEL9z0c0qI66b7bQdnnOcxud7MRyZPhrzweE7zkbmRZ
 TQB1F0kjWVWUFonN/05wgvHaXVFdtWQfZr0lfZR8mei7PRZFS80b0XBDElzktJQohPvh
 GDFrIwgyy3uKrk2oosxBJprwiylUiQ9S3XIPy0WnHvpEsgkeBh73aHX5elxL5rOZlqnK
 H/0kaYwWdVwCBVRd+yugMiXkISvrdt3bJn11Ww8FMtdoC1KUIT2Vl+2ETTlKtmEU6fkH
 iFQrjmwjxLKAeZptBl08RkKrf59jNeSBJiwH01uD00io3M2gij5DCmnpdAQrumuwYA3Z
 V6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=2oke7nd3qgzSpwUghUx65sQAoKy1HMHaETHva/Kk8Jw=;
 fh=xbs01O89XOYDK8/vToBVfIBirtvCkSLaPNVTPiyyqI8=;
 b=FCsL6S29fMIFui2JJdU5trI6Zc+K0C0Jy0HkiRndIdFfXTU9gyiHCAiT9iStDAY9m0
 gph/wlCAvEEVBclEcezBjfFG8RGOEo9hEKB6VqRShra69BjOawWMkVMrJfCUd0gq/Yfa
 UBqVhqeOUcd9RaLOMyVInKNGR2AdHyRi2ct/CAh+ZWwm+pyvKdyv8n8YFsjkBE5XKQgf
 TjuClots/PhMKE+tTX3VhubSU0p5CVjl0WQ+jCWBLFtjhYByvFnX7UdmTzbYfdBMEsNE
 qXJfh9EzZ1JbClBckaiRa7+spNXRycA/+6dZQ2gq/xSbP6voG4PMx6g+XbEQQPP3NOt8
 tEAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781048893; x=1781653693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oke7nd3qgzSpwUghUx65sQAoKy1HMHaETHva/Kk8Jw=;
 b=ZF+OQSuK7ho3Fc+oIqJKsLyemVvgP2vHhcR5FMhDNEl5/uko/A+rsN8eSHbyDCBJ8e
 xUjVNhw/SwzBeNDV37b616l9CN4bNP+au4wSDDDzWYwJPuYgtuMKsDxrwFAZqDuHglAv
 P6zINlBkiVbTAGQzKzbrtCHTEKDBiDD8IRiQhUkts3vstEv+EDIAFLfFxOarurKGtt+2
 4jBgSZISkPJegnIVaon00sxs4zgEGMCQR6DI8NK7RQR7Wkgm+40qefHuYpNyhYOJkvsd
 CT90utmZlCCnrs1hKXhWeKkLKs33BSooIzqYQ+8q7r5PwHW5gKQHBdykzdOWgQYkmyiW
 iUIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+I9+Dg81RNNvcKMFrzc6I0x4OeFuRGMJUSB3uNJswhElcwSDjElqIrOQjQxbDBbOnba1mpogt4Zbw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWYl+LhPq4/X2Jb6DBeeoKingSW+QxrMfDdugL13RrpouQAwtz
 P9uC8t8kSR2GOCcLNSl8v7GKh8vLb+Yzl0iuvv+fk/9I1Xha8NQuN0Btr836x1F9GVa9zSxRLUt
 wTDd6r68aUXN/2ZwKSSMO3rAkz+ZJzUz5iLOIxCXDMaeB0uzfrrKHuDXM91VH5yrDd/7zY8fDiJ
 7uzFzRxdHpUMtaAuTxrmMH8J5jYe1/e39g1xXTk2zdaIE=
X-Gm-Gg: Acq92OGgcFhroGquE4VDKigcakfw72HRNhGTxi7rPcHDlu7Tt1pBmH4cCU6OnpHccFT
 4xklBznXN46YiY4XK+kC5wf9TNjCFidqLRiVNozQe3myohOX4EPa8SLOEtkBxC7prq5wzUu5tyr
 B++8WBv4k2tUF7FKbGVAx2QxYDfhkJEJoaeidEvU5oN/bbvv2C9ZKWJiY77KrmKV+isuEGMhHnQ
 C4EwDdwPuUaiQFMFdjnqWF+mj+nww==
X-Received: by 2002:a05:6830:4990:b0:7e6:fdea:7aee with SMTP id
 46e09a7af769-7e70ca37187mr16012133a34.24.1781048893423; 
 Tue, 09 Jun 2026 16:48:13 -0700 (PDT)
X-Received: by 2002:a05:6830:4990:b0:7e6:fdea:7aee with SMTP id
 46e09a7af769-7e70ca37187mr16012114a34.24.1781048892924; Tue, 09 Jun 2026
 16:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com>
 <20260608185646.4085127-5-zhipingz@meta.com>
 <20260609154634.46ee8328@shazbot.org>
In-Reply-To: <20260609154634.46ee8328@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 16:48:00 -0700
X-Gm-Features: AVVi8Ccv--t4yFPwVmIF6GS96siJpbic6hR37JvTtMZG4eYFQdBVvAgfn5CrAeU
Message-ID: <CAH3zFs2UEpVV2MDkPvd5qW=OAFZ=MFMn1FTTpGa=sM-Kc8vcXw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: B34iXJkRaZFfRtFiruqSKlmjyOz9n7Qk
X-Authority-Analysis: v=2.4 cv=FNYrAeos c=1 sm=1 tr=0 ts=6a28a63e cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=Udk1dkG43rCpktSCSPQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: B34iXJkRaZFfRtFiruqSKlmjyOz9n7Qk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyNCBTYWx0ZWRfX1kFTzItElApG
 0TCgNfmZM90obOFeMqVDFkmtagDVz884p+PCuP8aF6pLmENbByrO6Woa0FNBZnqTI1lmYdsC6Gs
 uJnlv2OskWD8S0LmJ8zxiK0dM8JlsQU4ydp33cKUX38d3iQ4oY8p0jPXrD0VjCy2RFj5RlJ9a2A
 b9818R6vIQgTfTIO7aL+EkgdhDNdMk/bTzIotwKb7D/irjt707wr+v6vICOZidQGkNbjUYaWgBb
 1PnOD2nlpZMhAsqe90M89F0X8KW8FP65L7LbOKc87ydP90JUbdy0llVw+wyVajZY4MQ/lWG14R9
 4tht1py5/briSos4jp91P1yVOWwaTxjowP6bXrpy1XLqERUw/xIKAvKi8uCQyBPK5gEA9NN01Sj
 6pkpkIZnQQq4O6UcW5kP/MGCBvPfl/vHrj675LuCyRioe/nggasH1RDXJblHUT6XeXADRTBZhAr
 lQBGKqmgiBqM0LTBL4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
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

> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_tph __user *arg,
> > +                                   size_t argsz)
> > +{
> > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > +     struct vfio_pci_dma_buf *priv;
> > +     struct dma_buf *dmabuf;
> > +     int ret;
> > +
> > +     if (!pcie_tph_supported(vdev->pdev))
> > +             return -EOPNOTSUPP;
>
> This tests for the TPH capability, but the TPH capability is only a
> requirement for functions that generate TLPs with TPH, ie. a requester.
> This feature is about providing TPH steering tags when the device is a
> completer.  Bits 13:12 of the Device Capabilities 2 register indicate
> if the device is supported as a TPH completer.
>
> Additionally these bits indicate if the device supports standard and
> extended TPH, which means we should not only fail if the device reports
> 00b, but should reject extended steering tags unless the device reports
> 11b.
>

You are right: pcie_tph_supported is not correct here.
Let me use a helper function to return something like this:
PCI_TPH_COMP_{NONE, TPH_ONLY, EXT_TPH}.

> > +
> > +     ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret != 1)
> > +             return ret;
> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> > +             return -EINVAL;
> > +
> > +     /* PCIe TLP Processing Hint is a 2-bit field. */
> > +     if (set_tph.ph & ~0x3)
> > +             return -EINVAL;
>
> Sashiko notes what appears to be a false positive here, the uAPI states
> ph is to be in the range [0, 3] and nowhere else says that it's allowed
> to be garbage for a clear operation.
>

Agreed - i will leave it as is.

> > +
> > +     dmabuf = dma_buf_get(set_tph.dmabuf_fd);
> > +     if (IS_ERR(dmabuf))
> > +             return PTR_ERR(dmabuf);
> > +
> > +     if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
> > +             ret = -EINVAL;
> > +             goto out_put;
> > +     }
> > +
> > +     priv = dmabuf->priv;
> > +     if (priv->vdev != vdev) {
> > +             ret = -EINVAL;
> > +             goto out_put;
> > +     }
>
> Sashiko notes this may need READ_ONCE()/WRITE_ONCE() semantics, but
> that may get fixed as part of the resv lock usage.
>

Ack.

> > +
> > +     scoped_guard(mutex, &priv->tph_lock) {
> > +             priv->tph_st = set_tph.steering_tag;
> > +             priv->tph_st_ext = set_tph.steering_tag_ext;
> > +             priv->tph_ph = set_tph.ph;
> > +             priv->tph_st_valid = !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> > +             priv->tph_st_ext_valid =
> > +                     !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> > +     }
> > +     ret = 0;
> > +
> > +out_put:
> > +     dma_buf_put(dmabuf);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
> ...
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..0ca26721849b 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,51 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must expose the
> > + * TPH Extended Capability (otherwise the ioctl returns -EOPNOTSUPP).
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_BUF.
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
> > + * distinct namespaces in the PCIe TPH ST table and may both be present with
> > + * different values. Userspace should populate the value(s) it has from the
> > + * firmware ST table for this device and set the matching VFIO_DMA_BUF_TPH_ST /
> > + * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a specific
> > + * width and receives the matching value; if the requested width is not
> > + * present, the importer is told TPH is unavailable for this dma-buf.
> > + *
> > + * This publishes the PCI SIG-defined ST/PH tuple for a VFIO-owned PCIe
> > + * completer. The dma-buf core treats the tuple as opaque completer-owned
> > + * metadata; an importer simply requests the namespace it supports and places
> > + * the returned value on generated TLPs.
> > + *
> > + * @flags == 0 clears any previously published metadata.
>
> This is overselling the invalidation.  It only flags the fields as
> invalid for future get_tph() requests, it does nothing to clear
> previously published metadata from importers.  Thanks,
>
> Alex
>

Good catch, let me re-word.

Thanks,
Zhiping
