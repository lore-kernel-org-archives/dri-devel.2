Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D30C79FBB
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCC710E8BE;
	Thu, 10 Sep 2026 21:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="HSShwN0F";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4B710E8BE
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 21:46:52 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ALUQjT3205208
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 14:46:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=34rO3ZRR8/6lJeLn2tK/hPbU+iCzRxdjHgkar
 zOLMXI=; b=HSShwN0FrymjYG5qNRf0CMBfnhePNJV9y0JeJyI5jdqAaaq/PrPHB
 c1581E30p9GFnnazNniNb9sksl4p9IN6s3FpB8n7up87kzm1HdmtJNaRg7YjHZjj
 POITXyPedcLgbGod7tH/mBI19U+TksTWPmmdnJO93QYH+Nzzy9JRtgSH2+EDMTcK
 r51IwKg8yoT2rUT/JYPg4G7lZ7jYBKTSlFf0fuQj0f4G/07gH7L1PhOiSUDhnU3x
 D3n2XgY7dF2WHnVthLRlkq/9RPgJN5/Q9AJ1YHSNFDYFAt68Pt9JZkgQBY9QqBdI
 Kzgu+KX8UHDABADfyBZeLXxhMnBJUoyVA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gkcyeswax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 14:46:51 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7ec6685adabso378447a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 14:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789076810; cv=none;
 d=google.com; s=arc-20260327;
 b=EuJhsxKA938fM6+pWmarwJnFfTi+pnxy/Ip9bVE0oAL5AtpKusT8cWkUULWevjngo+
 qMJxsugzmEc+2vXYJwUey3PH62yj009yIXNaIKgMNXhGZVJlSJfxCFNDf02N1t8+eHcx
 3fTG+LFUpT3Nuq7pj7MyMdonjJgZxO1tybAKk7+AEpfqhaNMB0jeLAPfgfaPydSpWetA
 RGfXWPVaL5xUv/zI6P53bqJqzTVAQS1mMLPMe81+KirmVsyL3+1mOyydQmM+8fOUSbwn
 ZWDUx0/ZGU1SjSY3K3wlYx8BcMaAOAwNz2WfwMBLlQdBZxWwRpIAEVULffNJSDY8YECv
 oJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=34rO3ZRR8/6lJeLn2tK/hPbU+iCzRxdjHgkarzOLMXI=;
 fh=gvsel+DoflrZZrhKxUSQbQ5kJ3LRZKufOM2uZt8Uc3Q=;
 b=B0IXpCtwAkACVC4CBF/voVMoZOMMwsMZXGJZAcxC8B2lqpP4N+a12tjIbrmRfVZ0QA
 0SefYF1WWTBuTgtta7u/0sbNlqRv5MHOcl4WzU56CQJdltByOWZlgSdUfIv/K23eRRht
 Xti87M2kne8oXgwDHYB1aBXwkIHDpAKA1a/jt7RVqAy+rIH6lUUwPdG56gSaspyVw0iZ
 zQXqBJ12D/mTPD5EwWFCZTmWOf3kuVEjnBWE6GQAo0QE4IMoWvZWOASZWtcRz/ff3oSf
 VSjuBtvTjbFv7oFsi5ueX+4/mjNyAwr3ACIAnv5QWnHwwDqWV6ObhDPr1PNqqPpTaFzm
 sGgQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789076810; x=1789681610;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=34rO3ZRR8/6lJeLn2tK/hPbU+iCzRxdjHgkarzOLMXI=;
 b=l85pKnYbj4Joz9H74ItWl8eq4BOl5SUvqSrvkBMwhXn9oXS4pymNqQjvjTE77NhoRx
 VzmnotMG25NRFy4+mInKERZU14yCtlrZsqyd9+oPpf1XdYkZvtyv9wmcWwHEHqp3CUib
 m30rLkMrkGOhBEb1JkqJIkbcV+mCoeozv3qic0xfXBaqL+MLxDVodIPdVlJyA2ZdLfGB
 SjtuEElG5gdV0PpZBPCNRy1qFBDXl0duWCl8k2CgRZBvzV4MaRx/HegbxYGGJbKX3ObH
 g3aImwu4eGzq+aSjqn/ruai4hwNCo/nsfp0DbP0F0b13dJixbKcJtt0B3NEwOUVUecyK
 ft6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEWxULCDP+9nvwzPE2BUXeuZybwlQjLAipmejKshvU7ypZYecfJarHi0rhWsrmocBqdZhrwJkDAF0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++laJ3PxijennkPRyYLpOcbskDi9Xk7Yc6BNjw0bzFG99aoW/B7E
 CR6nv/xF+YqZePTOod6RGoJvJRumtU5W94oVGLm1B14T5NFjiIlVM7DQpmbLX/EFdeMZc96mvcV
 Gpa8HJFhQHm7M+pbntY/eZ4EO0l3zk9Go7FMgCMLCL+fA9DkANpolsQd5qGaUFU7GB2uWUOBWYZ
 Wf3pclOQVNVPw6lXR9AvwERs0CfWWEj9OJCPEHRyFjCV0=
X-Gm-Gg: AYBFou3VBsSKb+Pn2QTSO79Co5YsYbaK8USoqjjIthdNXmSAAt9u4xEM7fJda9MwTeh
 CZQmmVEiLm4cc1wsd/hZZRk3P2gN4LoeQ37M++vYwvjyR++m0/OTeXpqerYhaKRTho57dm0Oy+m
 c7cTBl/aspxAFv7EGkLbSFwwcy4iSRRyfawDx0ZOyEd3xhM9Wto4wxtDeW41rp88IIcVnN+wmQM
 tEQrcWIK42NEOsLrpw=
X-Received: by 2002:a05:6830:4129:b0:7f3:7679:3957 with SMTP id
 46e09a7af769-803ff332b68mr723751a34.10.1789076810369; 
 Thu, 10 Sep 2026 14:46:50 -0700 (PDT)
X-Received: by 2002:a05:6830:4129:b0:7f3:7679:3957 with SMTP id
 46e09a7af769-803ff332b68mr723727a34.10.1789076809796; Thu, 10 Sep 2026
 14:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
 <CAH3zFs2XnH6gT0fO4=WLi4x1SL2+Y0S=Jo45SWkR=unPegQ8Hw@mail.gmail.com>
In-Reply-To: <CAH3zFs2XnH6gT0fO4=WLi4x1SL2+Y0S=Jo45SWkR=unPegQ8Hw@mail.gmail.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 10 Sep 2026 14:46:39 -0700
X-Gm-Features: AcwNN1U2vgRHKRn8sAdEsH5URCI9zdOW1d6Q2VaosXC6fruMYOU8HDIF5GUbJzY
Message-ID: <CAH3zFs2X8=x-XMXhwC7_aUZivCCPQOSuyXMy-ryKqxLEFY9u-Q@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer
 access - ping
To: Christian Konig <christian.koenig@amd.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI3MyBTYWx0ZWRfX83W+KLgbUexH
 7zCg4zGileN/BSP8zSS2GJl+OlkyS8m+Np5GQP55hT9qfYHSqXi39kaC2McSlMu/7dOQ6pKPSGN
 4BXhmdOuQq8AWrFVUQ2y57ez9xy1dOZ5CPvU1G3Ae1KOA3bOOfxbOYNQwWgPVckTizla2c830Uu
 ayBEe9rQSz4Ly2V2FdvvQP2oGDoWMcTrYYdrVjBPSPyfDbx/n6PrB35wxcjke9DAluY0pipSSLt
 2CM01cZGzDoyKZRfJthQ5+D41EynX+k4Xzt9sk9TgXmkb4wO23ekAC6T7JNVsTZqOnPvfw6szQ7
 bTrIdA1e4QiQkd7h/Jq0v3tzvBTqTKnmRW7ZbrjXEu5DGxkSPHsQFViReDzvE5gcQuCQOobRysG
 /rscYpFlkePCtVQuAH/sMQZFMLGnfpO24Ox89JzJjF5+TZvSJf7c8Nh/lafBLkQrh3YeeCCRiuC
 IwC85uo/6Fx4jrmry/g==
X-Authority-Analysis: v=2.4 cv=C/t8WgP+ c=1 sm=1 tr=0 ts=6aa3254b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=LrQvNoTgmBG0NaGk8QkA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI3MyBTYWx0ZWRfX/K+AeJFvv0pi
 Fx72LYE3NQhlW/j2TuhH42n36QZyiAP3ybYtsakyiQJE6A7fc2d3S7g1eT2I3Nyztf7kqkW8wtU
 iTOxXAcfKNq4s736M7hbjyuT8AdPHBQ=
X-Proofpoint-GUID: WfAeCWQvXgVFciDmzq94ai5BRFLxxJUZ
X-Proofpoint-ORIG-GUID: WfAeCWQvXgVFciDmzq94ai5BRFLxxJUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
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

Hi Christian,

Third ping on this series. The only patch still without review is 3/5,
which adds an optional get_pci_tph() callback to dma_buf_ops:

https://lore.kernel.org/kvm/20260731211601.3033906-4-zhipingz@meta.com/

It lets an exporter report the PCIe TPH steering tag for a
peer-to-peer mapping. The callback is optional -- exporters that don't
implement it behave exactly as today -- and nothing else in dma-buf
changes.

The rest of the series is settled: Chengwen acked patch 2, the
automated review is clean, and there are no open comments from v12.
Alex is holding his ack until the dma-buf side has been looked at, so
this one callback is gating the whole series.

If you have concerns about the API shape or the locking, I'll respin.
If someone else should review the dma-buf side, tell me who and I'll
take it there. Otherwise I'll check with Alex and Jason next week on
how to proceed, since 7.3 is in rc and the next window is about a
month out.

Thanks,
Zhiping

On Wed, Sep 2, 2026 at 1:53=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> wr=
ote:
>
> Hi Christian,
>
> Another ping on this series for your attention. Pls see below for more de=
tails.
>
> Thanks,
> Zhiping
>
> On Fri, Aug 14, 2026 at 11:08=E2=80=AFAM Zhiping Zhang <zhipingz@meta.com=
> wrote:
> >
> >  Hi Christian,
> >
> > A gentle ping on this series, especially patch 3, which adds the
> > optional dma-buf get_pci_tph() callback. Could you please review this
> > when you have a chance?
> >
> > https://lore.kernel.org/linux-pci/20260731211601.3033906-4-zhipingz@met=
a.com/
> >
> > Thanks,
> > Zhiping
> >
> >
> > On Fri, Jul 31, 2026 at 2:22=E2=80=AFPM Zhiping Zhang <zhipingz@meta.co=
m> wrote:
> > >
> > > This series adds TLP Processing Hints (TPH) support to the VFIO dma-b=
uf
> > > export path, allowing importing drivers (e.g. mlx5) to use the
> > > exporter's steering tag when performing peer-to-peer DMA into a
> > > VFIO-owned device.
> > >
> > > There is no separate in-tree vendor kernel driver for the target devi=
ce:
> > > vfio-pci is the in-tree driver and the targeted device is managed
> > > from userspace via VFIO passthrough. That is why the ST has to flow
> > > through a uAPI: userspace owns the device and its ST table, so it is =
the
> > > entity that can configure a meaningful value for a given dma-buf. The
> > > kernel-visible participants are still in-tree: vfio-pci exports the
> > > dma-buf and mlx5 imports it.
> > >
> > > On the effect: the endpoint's PCIe ingress block uses the ST as
> > > an in-band instruction for the incoming P2P TLP -- selecting a target
> > > cache partition and, on writes, an in-flight operation on the data
> > > before it lands. The dma-buf callback keeps this opaque to the
> > > framework -- only the producer (userspace owner of the VFIO device)
> > > and the consumer (endpoint block) need to interpret the value. The
> > > dma-buf get_pci_tph callback itself is optional, but workloads that
> > > depend on the endpoint's in-flight operation need it because fallback
> > > does not produce the same result.
> > >
> > > The dma-buf hook is intentionally generic and discoverable rather tha=
n
> > > a private side channel. The exporter owns the completing address
> > > space for the dma-buf and decides whether it can provide a meaningful
> > > ST/PH tuple for that completer; the dma-buf core keeps the tuple opaq=
ue,
> > > and importers merely request the namespace they support and place the
> > > returned value on generated TLPs. Exporters that cannot derive a
> > > meaningful tuple simply return -EOPNOTSUPP.
> > >
> > > TPH is advisory: a steering tag that is not honored on the path (for
> > > example an intermediate routing element that does not forward the TPH
> > > prefix) is ignored and the request completes as an ordinary,
> > > non-TPH transaction (PCIe Base 6.4 sec 2.2.7.1). This series therefor=
e
> > > targets the same-Root-Port / common-switch topology, where the ST
> > > reaches the completer; cross-Root-Port P2P is best-effort and is not
> > > gated in the uAPI, since supplying an unused ST is harmless and there
> > > is no discoverable "TPH routing" capability to test against.
> > >
> > > Patch 1 folds the reserved 0b10 "TPH Completer Supported" encoding in=
to
> > > "not supported" in get_rp_completer_type(), so only architected value=
s
> > > can reach the TPH Requester Enable field. It was previously posted
> > > standalone to linux-pci; per Alex Williamson's v12 review it now trav=
els
> > > with the series, which removes the cross-tree ordering dependency and
> > > lets review tooling apply the series as posted.
> > > Patch 2 adds small PCI/TPH type helpers so drivers can query the enab=
led
> > > TPH requester mode and the device's TPH Completer Supported field
> > > without reaching into pci_dev internals (and so callers in
> > > CONFIG_PCIE_TPH=3Dn builds get a clean fallback). pcie_tph_completer_=
type()
> > > applies the same reserved-encoding fold as get_rp_completer_type(),
> > > inlined locally so the helper is self-contained.
> > > Patch 3 adds the optional dma_buf_ops::get_pci_tph callback plus the
> > > dma_buf_get_pci_tph() importer wrapper so importers can fetch TPH
> > > metadata from an exporter under dmabuf->resv.
> > > Patch 4 implements get_pci_tph in vfio-pci and adds the new uAPI
> > > (VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadat=
a.
> > > Patch 5 wires up the mlx5 RDMA driver as a consumer. It also enforces=
 the
> > > dma_buf_get_pci_tph() steering-tag lifetime: the tag is only valid fo=
r the
> > > mapping it was queried against, and the mkey's TPH fields cannot be
> > > reprogrammed in place. mlx5 therefore records the registration-time t=
uple
> > > and re-queries after each dma-buf mapping is established under
> > > dmabuf->resv; unchanged tuples continue with the existing mkey, while
> > > changed or missing tuples fail the remap rather than continue with a
> > > stale hint. For vfio-pci BAR dma-bufs this is expected to be a no-op
> > > because invalidation is revoke/quiesce, not movement to a new backing
> > > placement, and the userspace-provided tuple is not changed by the
> > > revoke/un-revoke path.
> > >
> > > Build-tested with both CONFIG_PCIE_TPH=3Dy and CONFIG_PCIE_TPH=3Dn.
> > > Functional validation on the target topology: PCIe analyzer captures
> > > on the P2P TLPs confirm the ST emitted by mlx5 matches the value
> > > configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-en=
d
> > > P2P workload only produces results consistent with the endpoint's
> > > ST-selected in-flight operation. For example, with userspace
> > > configuring 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer=
-to-
> > > peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
> > > ST=3DF0h PH=3D2 HV=3D1":
> > > (TLP Captures)
> > > 08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
> > > F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
> > > E0200000 -> AddrH=3D000020E0h
> > > 00080006 -> AddrL=3D06000800h
> > > 90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-
> > >
> > > The dma-buf get_pci_tph interface has also been exercised by a second=
,
> > > independent importer: a different vendor's NIC whose driver is not ye=
t
> > > upstream, locally taught to call dma_buf_get_pci_tph(). A PCIe analyz=
er
> > > confirmed the ST it placed on outbound P2P TLPs matches the value
> > > configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, the same result a=
s
> > > with mlx5. Two unrelated importer drivers exercising the callback
> > > end-to-end shows the interface is not tied to a single consumer. That
> > > importer change is out-of-tree and not part of this series. For that
> > > second importer, with userspace configuring 8-bit ST=3D0xe0 and PH=3D=
0,
> > > an analyzer capture shows:
> > > (TLP Captures)
> > > 08200260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D1 Attr=3D0 L=3D8
> > > 4E00004C -> RID=3D4Ch:0h.0h EP- Tag=3D4Eh
> > > 00170000 -> AddrH=3D00001700h
> > > 00200006 -> AddrL=3D06002000h
> > > 10E00000 -> OHC-B ST=3DE0h PH=3D0 HV=3D1 AMA=3D0 AV-
> > >
> > > Changes since v12:
> > >   Patch 1 (PCI/TPH, new to the series): the reserved-encoding fold,
> > >   previously posted standalone to linux-pci [1], is now the first pat=
ch
> > >   here (Alex Williamson). Sashiko could not apply v12 because of that
> > >   external dependency; with the fold in-series and the mlx5 leak fix =
in
> > >   linux-next, v13 has none. The code is unchanged from the standalone
> > >   v3; the Fixes: tag is dropped, since no code path can reach the
> > >   reserved encoding today and the patch is hardening rather than a fi=
x
> > >   for observed silicon.
> > >
> > >   Patch 2 (PCI/TPH): inline the reserved-encoding fold in
> > >   pcie_tph_completer_type() rather than calling the helper that earli=
er
> > >   folding revisions added; that helper was dropped in folding v3 per
> > >   Bjorn Helgaas and Wei Huang.
> > >
> > >   Patch 3 (dma-buf): no functional change.
> > >
> > >   Patch 4 (vfio/pci): also gate the DMA_BUF_TPH feature on
> > >   vdev->pci_ops->get_dmabuf_phys, matching
> > >   vfio_pci_core_feature_dma_buf(). Without it PROBE reported the feat=
ure
> > >   as supported on a device that advertises TPH Completer support but
> > >   cannot export a vfio dma-buf at all, so nothing could ever carry th=
e
> > >   metadata (Alex Williamson, who raised this to uAPI-affecting
> > >   severity).
> > >
> > >   Patch 5 (mlx5): keep the !dev->st early-out in mlx5_st_alloc_index(=
)
> > >   ahead of the pcie_tph_get_cpu_st() call, so splitting out
> > >   mlx5_st_alloc_index_by_tag() neither adds an ACPI _DSM invocation o=
n
> > >   devices without ST support nor changes the errno userspace sees whe=
n
> > >   the _DSM lookup fails (Alex Williamson). The commit message now
> > >   describes this rather than presenting the split as a pure extractio=
n.
> > >
> > > Previous link:
> > > v12: https://lore.kernel.org/linux-pci/20260715204008.3911275-1-zhipi=
ngz@meta.com/
> > > v11: https://lore.kernel.org/linux-pci/20260702181025.2694961-1-zhipi=
ngz@meta.com/
> > > v10: https://lore.kernel.org/linux-pci/20260630224328.3218796-1-zhipi=
ngz@meta.com/
> > > v9: https://lore.kernel.org/dri-devel/20260622184211.2229399-1-zhipin=
gz@meta.com/
> > > v8: https://lore.kernel.org/dri-devel/20260615065912.2177918-1-zhipin=
gz@meta.com/
> > > v7: https://lore.kernel.org/dri-devel/20260611161546.4075580-1-zhipin=
gz@meta.com/
> > > v6: https://lore.kernel.org/dri-devel/20260608185646.4085127-1-zhipin=
gz@meta.com/
> > > v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipin=
gz@meta.com/
> > > v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipin=
gz@meta.com/
> > > v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipin=
gz@meta.com/
> > > v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhiping=
z@meta.com/
> > >
> > > Zhiping Zhang (5):
> > >   PCI/TPH: treat reserved 0b10 completer encoding as unsupported
> > >   PCI/TPH: Add requester/completer type helpers
> > >   dma-buf: add optional get_pci_tph() callback
> > >   vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
> > >   RDMA/mlx5: get tph for p2p access when registering dma-buf mr
> > >
> > >  drivers/dma-buf/dma-buf.c                     |  32 ++++
> > >  drivers/infiniband/hw/mlx5/main.c             |   1 +
> > >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  11 ++
> > >  drivers/infiniband/hw/mlx5/mr.c               | 151 ++++++++++++++++=
+-
> > >  drivers/infiniband/hw/mlx5/odp.c              |   7 +
> > >  .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  52 +++++-
> > >  drivers/pci/tph.c                             |  55 ++++++-
> > >  drivers/vfio/pci/vfio_pci_core.c              |   3 +
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c            | 120 +++++++++++++-
> > >  drivers/vfio/pci/vfio_pci_priv.h              |  13 ++
> > >  include/linux/dma-buf.h                       |  25 +++
> > >  include/linux/mlx5/driver.h                   |  15 ++
> > >  include/linux/pci-tph.h                       |   8 +
> > >  include/uapi/linux/vfio.h                     |  43 +++++
> > >  14 files changed, 517 insertions(+), 19 deletions(-)
> > >
> > > --
> > > 2.53.0-Meta
> > >
