Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F32C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AD510E586;
	Fri,  3 Jul 2026 06:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="C0z5ENmq";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F8D10E586
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:57:25 +0000 (UTC)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rkfb977994
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 23:57:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=s2048-2025-q2; bh=1ooYXEhr8R5Avu36PkA1
 fDBaUkP8RkT4tBNox1TcVoA=; b=C0z5ENmqDzbJ1NLEJsUJo9CQ3N/uTO7VUwp4
 kfTj0sxCwlKtZcFAbfH5EzA4i/QyE7hzmnXKp60uoJGQ6MOgjGVYxymZs1LzEGgR
 KK/MabO62rFu7yFaRhdUXbWVs6RszHi4Llfrvj+O2Ur3DURJFa0bbiYbtGGtmf1S
 48+CP9y9ZSyGN4WLNaqbVQgnwIsdkrlxGhdYdoaiAHm7xF2MwkQzJeva9fd6d3Yw
 oQ3EMU2riwO6WaSrWDjGw+BApAFcAp1tWa/vlThjMXh9zmTVaUOIm+H2kTLvSMGL
 86M/qI56en4xsmMLOVp5WIYEay69OIWSI0Mz0mScKxmp2zYwIw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f63k01cp2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 23:57:23 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e74781faaaso333120a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 23:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783061843; cv=none;
 d=google.com; s=arc-20260327;
 b=Dd5csR4R+dtZ3DHiZwKUtykLk1TTHIpb3IacETdTvWqApwMdAbW+Tm1YqqRNSSQHlQ
 UnSkKNER6s7i95leBGgjeNAM3HhQvEAUJi1/XfVha8lY0Rmon5PPhXjRlECIUjxJWjtJ
 yobUYHmwjOuEu3/bkjT2XAZQQ5avi7jsMLcZOWoJA3joCuupCDXR5l5Zi2qF371LjXVb
 F3yFi06bGLMbKRUZRiPDHx+WAohvbRITxfS0a7ekLGwbvCpQViKa/zanMCS5y38bZIai
 oZovquqenkGlMEQVRBnw3sX631apNmQrznwLOlF9mrY2c2GdV8VLR9rllIeZ4MJC0r4b
 90Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=1ooYXEhr8R5Avu36PkA1fDBaUkP8RkT4tBNox1TcVoA=;
 fh=xIB15xRunwqiOx9ZEko+LbhshZEQTRaB7HZc6Ji611c=;
 b=ISAg0RvnFtyde+vSEYkv54UkRo+B1JxL/0yH5YevSa10t0rfxQQH74sgpOZN129kwK
 QtRlEBFWu5Pia5jMyapW77xA5n8SKeNLMpWxJ4krQPnGT4LEl0SC8UdhLFWrMJG3xIaY
 KLC/MMDSnZTUZ+QiJk8mrHwuxM7w2vHf51bL4HtfOVe66Y662+X2a+WahWT1i2oyqDY5
 x9v/IzX9qQJO5i/GMMVz+kioHw5A2QfIgsqS8qh8gQzfhcgEsvV9mA5buSHZPLoBcup9
 5Hb+c61c6OtAaDan7gyETlzYHUa06mMTmKRf25GSC1k+WGOODDfYxMPPlLxNvZwX9ea6
 x5bg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783061843; x=1783666643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ooYXEhr8R5Avu36PkA1fDBaUkP8RkT4tBNox1TcVoA=;
 b=ZyyFU0JKveTKt0U8lET0v7R644Bxe/PtaKnq3MbmPE94ieBnMkPo1D/+L1dEfZvcWe
 qrz6KmZUQz9hI8M+V6LoYqFxw0IAJVIVZtybPLnYo/gt66CeBrCnmF0niTmBBY/TyrFi
 JSJn7unu9A00TdTsrmyj4nkPueq6RtxxMoBRaF6Md/WVZyJ/WbxtcsNIfbmanUEIEai/
 DNa7U/FcjPSe8qiSTNIqnNOS5T9ETpwjEF0MakU1L0FGKwx4BbTWR9g9RTcWU3yS+cB2
 W3VUNqrXy8wCt82QjI9TsxA/bZWhDAGQrWYVAorzPqKu0rR4s6Bcq2cKZSDPRCqRve4T
 O54g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Q6ipLE0qFDA0BYOFPuKzzC1DX93eQ8VonU2RjR5G3vwlLaKlPnG6FBw51rS9ZwhR5Y+SP9QH+K+c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy058+shhiHL1q7iLC/OtuGVTfs443y1RxBo9t6gYv4PSjsLqRU
 aMz6phEOFJJPqXqqvClL9d84fxaNqcGul/VPMsRhtnN2FcwbtgBudTvm+xfwm3dUfggVhQrq0mt
 aj5ba8QngOjndh2DihWpNq2oq9ZT628bUBhJSI7QFfycXvxH/cDU3Y+fJAzZMOa1H5kFjibDfck
 zg4p1qyVmZeXU4An7XXZU7kazHGsAVCOgXoRR+WOns2dk=
X-Gm-Gg: AfdE7cle8gQIV++DFR+cI9GV4VphKzbLlqy+om90h0kUKDiEfbkYkZLfJzIhOHLh8mb
 WEynWAgAx1fWdEEYsgZvJBLMiLggYSjyrAymKUDXDagFwE+sme3YihIW4H/TjjB/rjAGKAGYy+a
 f5VaDMKL/HaUQ4yZiiP3FuBhpwT6hJOgIcE4znE/3DshTKv9AtUTLO0ecNvKSYi3jN8kuIx7WvS
 IutjmyxK5f2Qid7Z9UwvEXpBWUasA==
X-Received: by 2002:a05:6830:82c8:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7eb4cc26248mr5970984a34.17.1783061843332; 
 Thu, 02 Jul 2026 23:57:23 -0700 (PDT)
X-Received: by 2002:a05:6830:82c8:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7eb4cc26248mr5970963a34.17.1783061842839; Thu, 02 Jul 2026
 23:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260702181025.2694961-4-zhipingz@meta.com>
 <6ab4c781-2409-4015-aac1-01d5cc1b9f6f@huawei.com>
In-Reply-To: <6ab4c781-2409-4015-aac1-01d5cc1b9f6f@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 2 Jul 2026 23:57:10 -0700
X-Gm-Features: AVVi8Ccw8yAXcsgDvWHGsVO2xij76p-6UW92x4FC6KeN1aOXDWOhO-jLzIpoK30
Message-ID: <CAH3zFs31yd9uyo3waOT=SxCGaKGBfxdAv2XDQ+9dQyuo-cCV3g@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=fJkJG5ae c=1 sm=1 tr=0 ts=6a475d54 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=wlcL9-RM8ybxaKpgEcQA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2NCBTYWx0ZWRfX3Iv90P8ZmMgv
 Hn6VZCcvylgOzX57Fv7Hc6/nzO6xxGlLuEJaooIDo+1YISHL12PZML2Ph8IhI9y1WKp3GaVmTq4
 aG8fsSrbpus2zC1n6Q3iEPmRPCesK/Q=
X-Proofpoint-GUID: _FBV6ioFNcDA1Qvqtoi8486fJlqVT2EW
X-Proofpoint-ORIG-GUID: _FBV6ioFNcDA1Qvqtoi8486fJlqVT2EW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2NCBTYWx0ZWRfX6r3fBtGUPpcz
 yljFSMQzufDepyn8lGhtlZNMPng/ELBigolHTGK698pnKzsbL4sraBF6OCmuHDb0xrWW2BQBNuA
 Sd0fpoJBc37j0yKHnRBZrKZbdm9A/uQDnLALN9yjiPwOtEWUO90Zta1T0nufGsBhEEsx2O/B3BG
 bkfk9106ZxlBXtKulU7OWXmwaTlkfgOOyP9xIdSkTXch76un/pSPD4WAsdzan7YiI68ut6KIPxT
 a0wnBIW0U7jjPHBWGfZgvNIWz2ZgCMvHUe8Tei9jxN2vbF1oCPMXdfArpBVzFAuwXF1yq9e15cB
 3TIUdftWVDFckXLjhRIX6QnEwBTUJZ1TdN7Sjqeg60yKYvUibwSchSScm+xx8a3xKvu01p3HlEB
 TVC5nGToMR/fNKUIlVDfR001WYgsJdRLfqHepvLOEYXEPaNYYNIyDX0O0o7vsH8OAfXvMmuZQf2
 n+9BsS2F7f3uF2ha6fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
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

...
> > The attach path reads @revoked without holding memory_lock. Annotate it
> > with READ_ONCE() to document this intentional lockless access: the read
> > is a benign early-out, and a racing revocation is re-checked under
> > dmabuf->resv in vfio_pci_dma_buf_map() before any mapping is handed out.
>
> I believe this modification (@revoked) might be related to resetting the
> bit field segment and subsequently identifying a concurrency issue. It is
> recommended to submit this as an independent commit.
>

Thanks, I think the @revoked part is still closely related here. The lockless
attach-path read existed before this patch; this only annotates it
with READ_ONCE().
The bitfield-to-bool change is needed because READ_ONCE() cannot be used on a
bitfield. The real check remains the dmabuf->resv recheck in
vfio_pci_dma_buf_map(),
so I'd prefer to keep it in this patch.

...
> > +
> > +     /*
> > +      * Updates protected by dmabuf->resv, @revoked additionally
> > +      * protected by memory_lock.
> > +      */
> > +     u16 tph_st_ext;
> > +     u8 tph_st;
>
> how about: u16 tph_xst;
>            u16 tph_st;
>

I'd prefer to keep tph_st/tph_st_ext if that works for you. They map directly to
ST and Extended ST, and non-Extended ST is 8-bit, so u8 tph_st reflects the
actual width.

> > +     bool revoked;
>
> why not move revoked before or after tph fields if it don't take one bit field?
>

I kept @revoked there because the comment documents the locking for these
dma-buf state fields: TPH under dmabuf->resv, and @revoked under dmabuf->resv
plus memory_lock.

> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
>
> how about: u8 tph_xst_valid
>

I'd prefer tph_st_ext_valid since it matches VFIO_DMA_BUF_TPH_ST_EXT and the
"Extended ST" wording used in the documentation.

> > +     u8 tph_ph:2;
> >  };
>
> ...
>
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +#define VFIO_DMA_BUF_TPH_ST          (1 << 0)
> > +#define VFIO_DMA_BUF_TPH_ST_EXT              (1 << 1)
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +     __s32   dmabuf_fd;
> > +     __u32   flags;
> > +     __u16   steering_tag_ext;
> > +     __u8    steering_tag;
>
> how about:
>         __u16 xst;
>         __u8 st;
> and it corresponding to VFIO_DMA_BUF_TPH_ST/ST_EXT
>
> Thanks
>

If that's OK, I'd prefer steering_tag/steering_tag_ext in the uAPI. They
match the PCIe "Steering Tag" term and seem clearer for userspace than
st/xst.

Thanks a lot!
Zhiping
