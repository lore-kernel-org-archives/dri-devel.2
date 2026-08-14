Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB20C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C26D10E12C;
	Fri, 14 Aug 2026 18:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="d6xYEaQm";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7207210E12C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 18:08:58 +0000 (UTC)
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EGjMR0821719
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 11:08:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=a/wc9xo4pjSkf0rMp8r6iOmUU+t5ZmWTQnIQx
 +L/D38=; b=d6xYEaQmpmHsPwXDpM7XK27KiFnHnsIokOzJfYh6cGJbio2XJKBjX
 /h3xhpzsDh8tbWTJT583gLI/yDX4cGZvVEPaKUbZyRzZCpnCgKhQCp38vM1VEiCz
 Zy1qm06P9t9bUeLt+bXfuQqvdKaZRw7mNMaCnaHXWqb/kgDvUEykX1fHs8uYCdrd
 SzBlzNwulpc4kZwEe497bGS790kfW9lcIHzn0mAuyBy0CRu+Yne4+W7CsuwGCJBY
 iyG1+EoeB4iFke/eE7qg6DvHcPrrHipwl/RjJLvIjQwHpXDN5t31d/0lsGT98ou1
 BXPD+YVxkJrKvZfX+cvxntAkQu6GfzwTw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g1kpn6qq3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 11:08:57 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7ee59eeb8c1so881311a34.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 11:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786730936; cv=none;
 d=google.com; s=arc-20260327;
 b=dCxbYF4siLly7pQ+8VfiDLmNF0uIF/xHFIA57tYg/n207f+mOHk/HHeF4HibHkbp9b
 wfwRwljg1OVjgBed+wtl/gyQ28ZD4yaP4Phjlcy0Zjbr7ePtBM9Tp2L1UlAxTRaH9yFQ
 zcIxNXLgbjMYfei0pwd8toSyN7/NsdP7XZJB1QQ/Sn3l2ph5ehVXQx1PEyOXVt0AxVfG
 ufSg4/wuhN+GNwPVB1G+sqrTUiLbGufMXOBmII4OjAx2Ymiz2T+cavSoeEHqylfWA3AY
 O7HvEHYOGtJXy9lBtrlQJs+jRlO9VH4dUGPkqyS11O7x9wvqilxgDcd09mpEeTdPOKGH
 +LRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=a/wc9xo4pjSkf0rMp8r6iOmUU+t5ZmWTQnIQx+L/D38=;
 fh=8epGCpXfheyx9WPG+1KERdn1F8j2viNLcrlPiCuZ/LU=;
 b=S0q1lHiWq5Uh1cPge1tW8Xj28sKhe0eEgyADSxaG9wM/e3P5qWbIpbVrWKwGsJmXZ7
 jfJeHId99Zb0ueldXxL1spFktNqpd7x9W1lkAtuMR+QXXVxC472bclaXh/az2AaOJDil
 9J/I7CesOJqW/z0LpTkEAq4486QvQN8rLozYON6sbHEdb2WZNAATAZ9D7r2kYP3RjSvx
 YzZ+Q79VxR9C6RTbu1EUhpIGO5gIlSNZ1YmsGWyk1pYy6jH44mVNudQ7826T1qDSV4MB
 b3m/whbiK+4rzRJgncBhM3+aSCaRrlOKRU5BTcx12uSB0uCh1ruxAt679TBMxcio9k43
 Dffg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786730936; x=1787335736;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a/wc9xo4pjSkf0rMp8r6iOmUU+t5ZmWTQnIQx+L/D38=;
 b=SOYarPAGP6QoVBkrZguxMWSHn0NmaORaNVkRzpFg0g5iIFxWzYirVdcA5b1w7xLBbI
 tBfRFOeB/Nn7BcnBpPwplvhSq7CJKR3WUAx4YckUtOz42WIPM1FazjD2N+X++TaMeEEK
 r3LIlFVqKRyQDgyg7fvEsBRt8h7JGC4ukzDEOrF2NRZSjzS12KzMH5m+GqEb9hrQWCIJ
 qJ/pH/oTQIA8qTx+Jaiid4Pi/UPab5c2FddVoHmrRiNhM9hptsZ1WJvgjYW+bCPtiCjz
 BBEM/wBIYXSwFqVVVd/bln6jfaaKM6R0gng/ODcMX2us71wCu8eGdkpvZvJn5xBvId8/
 gCiw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/ah5qlUtk2ptamsrTPDzmKV54j7qILYEk5lDihvTNnklksIgMgp8qVrFNAzZ1EVeTmGtdzEg/f/0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjJ1bnGEl7kLVzv62mVPnCiE1roV3RfuGv/OrQ6sIcyr7jjohj
 ueXL57BOX3bp/apFn39v+SCpwjFUQuI7HuEOvVK0Ct2It7XuON09lnGYbU/XNA+qBPL1PKPWP4P
 De3w7HF3wNAB+3o5ciK3M54Fe9h94WIJTdaJTf0PhkjYYWUA307omIn/nuA3hNuRIe1B1NL1Yex
 U/k09jFJvVSO0BYmRoaL3sqG99BxABGerNcnVBLBPoPLs=
X-Gm-Gg: AR+sD13fm9917NODUozB/gst2DKOo/pzRa/06msmfeUvllzrajKCLLVIdhim/wZzkn2
 0GuISUV5kZi8cItEMt9GjLfYvWUWRU9/t7r9p02UFxmUeDvU9w2Y+TtN1wauIojcP8mHIAdvPxe
 EyCztT/xYmop1BK7U7Jz6Va8r67gJuLsZiQDdUFDmrvMhZukS5SCuFn7h3fS9KyWeNgKzWII4D
X-Received: by 2002:a05:6830:2b11:b0:7e6:cfd0:42de with SMTP id
 46e09a7af769-7f3de6b701emr7076907a34.15.1786730936308; 
 Fri, 14 Aug 2026 11:08:56 -0700 (PDT)
X-Received: by 2002:a05:6830:2b11:b0:7e6:cfd0:42de with SMTP id
 46e09a7af769-7f3de6b701emr7076829a34.15.1786730935638; Fri, 14 Aug 2026
 11:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com>
In-Reply-To: <20260731211601.3033906-1-zhipingz@meta.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 14 Aug 2026 11:08:44 -0700
X-Gm-Features: AUfX_mwlB-c_b12QUk9Eql1rFFrxjUSfBybDtwz-Rrjnzx4bowh7ua1IH4K-wTM
Message-ID: <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Christian Konig <christian.koenig@amd.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=L7UtheT8 c=1 sm=1 tr=0 ts=6a7f59b9 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=SJExgD-b2JMLU6q38FQA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: IJLTR-nKnpgfsOd6GfcchL-SDnOJTGOU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEzOSBTYWx0ZWRfX4jW+QoJ3YM/N
 tWRZgqpfYUzNm/RViXK1ZtCN5MYkIE+TPtfLXWuRjEPMs3BO2YLUzoA8XZ/rnJKkl1kn5em8Hc5
 cPOJXrsk96cKL6SwNNuFiKeHJOU46Q0=
X-Proofpoint-ORIG-GUID: IJLTR-nKnpgfsOd6GfcchL-SDnOJTGOU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEzOSBTYWx0ZWRfX6lKhT4F4wjEC
 Yiz+9Di5h+rVu5/b/4d4Mr2lMpjjC0yzgdQOYku34YTVistc65qGiYfT9Y8RUKjbPG3P8eTeGNn
 00fqZ1k83uGGDxyzSd9s/mUzBfE92hWxQ7hXe6fOfF4jAeHSft0cpNbSKhCP5irDJ+xmdOE93ns
 CwdSRRZuTewelX167t8ovO3GLF9RJbSXd4hidUPcew1UWv8FBClvDakCkxZRJX1poLmE+Jz6uOi
 fD1QfOv3XpU8DGPIYIxNZPjZ3ZmZslpiWIiJLDjZ4ulzdp1Q91yromOY6m3pWnIIxABgLVZ+0Lq
 fbhV/vlhBVEW0x81WYDnhF7/JXxfzqoHuL65j2MU8FD9bH9Ats9MmxOBpakNnOPXRafyeQZcTog
 iC45MvwtUWk3y78OuvKYjEbzCKNZDJoNMDKfszxagCWaAV8z9m6shYrtp9DGTk8b+7q3YGr8l/e
 nqLdZhpOm4/J0lvRVGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
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

A gentle ping on this series, especially patch 3, which adds the
optional dma-buf get_pci_tph() callback. Could you please review this
when you have a chance?

https://lore.kernel.org/linux-pci/20260731211601.3033906-4-zhipingz@meta.co=
m/

Thanks,
Zhiping


On Fri, Jul 31, 2026 at 2:22=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> w=
rote:
>
> This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
> export path, allowing importing drivers (e.g. mlx5) to use the
> exporter's steering tag when performing peer-to-peer DMA into a
> VFIO-owned device.
>
> There is no separate in-tree vendor kernel driver for the target device:
> vfio-pci is the in-tree driver and the targeted device is managed
> from userspace via VFIO passthrough. That is why the ST has to flow
> through a uAPI: userspace owns the device and its ST table, so it is the
> entity that can configure a meaningful value for a given dma-buf. The
> kernel-visible participants are still in-tree: vfio-pci exports the
> dma-buf and mlx5 imports it.
>
> On the effect: the endpoint's PCIe ingress block uses the ST as
> an in-band instruction for the incoming P2P TLP -- selecting a target
> cache partition and, on writes, an in-flight operation on the data
> before it lands. The dma-buf callback keeps this opaque to the
> framework -- only the producer (userspace owner of the VFIO device)
> and the consumer (endpoint block) need to interpret the value. The
> dma-buf get_pci_tph callback itself is optional, but workloads that
> depend on the endpoint's in-flight operation need it because fallback
> does not produce the same result.
>
> The dma-buf hook is intentionally generic and discoverable rather than
> a private side channel. The exporter owns the completing address
> space for the dma-buf and decides whether it can provide a meaningful
> ST/PH tuple for that completer; the dma-buf core keeps the tuple opaque,
> and importers merely request the namespace they support and place the
> returned value on generated TLPs. Exporters that cannot derive a
> meaningful tuple simply return -EOPNOTSUPP.
>
> TPH is advisory: a steering tag that is not honored on the path (for
> example an intermediate routing element that does not forward the TPH
> prefix) is ignored and the request completes as an ordinary,
> non-TPH transaction (PCIe Base 6.4 sec 2.2.7.1). This series therefore
> targets the same-Root-Port / common-switch topology, where the ST
> reaches the completer; cross-Root-Port P2P is best-effort and is not
> gated in the uAPI, since supplying an unused ST is harmless and there
> is no discoverable "TPH routing" capability to test against.
>
> Patch 1 folds the reserved 0b10 "TPH Completer Supported" encoding into
> "not supported" in get_rp_completer_type(), so only architected values
> can reach the TPH Requester Enable field. It was previously posted
> standalone to linux-pci; per Alex Williamson's v12 review it now travels
> with the series, which removes the cross-tree ordering dependency and
> lets review tooling apply the series as posted.
> Patch 2 adds small PCI/TPH type helpers so drivers can query the enabled
> TPH requester mode and the device's TPH Completer Supported field
> without reaching into pci_dev internals (and so callers in
> CONFIG_PCIE_TPH=3Dn builds get a clean fallback). pcie_tph_completer_type=
()
> applies the same reserved-encoding fold as get_rp_completer_type(),
> inlined locally so the helper is self-contained.
> Patch 3 adds the optional dma_buf_ops::get_pci_tph callback plus the
> dma_buf_get_pci_tph() importer wrapper so importers can fetch TPH
> metadata from an exporter under dmabuf->resv.
> Patch 4 implements get_pci_tph in vfio-pci and adds the new uAPI
> (VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
> Patch 5 wires up the mlx5 RDMA driver as a consumer. It also enforces the
> dma_buf_get_pci_tph() steering-tag lifetime: the tag is only valid for th=
e
> mapping it was queried against, and the mkey's TPH fields cannot be
> reprogrammed in place. mlx5 therefore records the registration-time tuple
> and re-queries after each dma-buf mapping is established under
> dmabuf->resv; unchanged tuples continue with the existing mkey, while
> changed or missing tuples fail the remap rather than continue with a
> stale hint. For vfio-pci BAR dma-bufs this is expected to be a no-op
> because invalidation is revoke/quiesce, not movement to a new backing
> placement, and the userspace-provided tuple is not changed by the
> revoke/un-revoke path.
>
> Build-tested with both CONFIG_PCIE_TPH=3Dy and CONFIG_PCIE_TPH=3Dn.
> Functional validation on the target topology: PCIe analyzer captures
> on the P2P TLPs confirm the ST emitted by mlx5 matches the value
> configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-end
> P2P workload only produces results consistent with the endpoint's
> ST-selected in-flight operation. For example, with userspace
> configuring 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer-to-
> peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
> ST=3DF0h PH=3D2 HV=3D1":
> (TLP Captures)
> 08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
> F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
> E0200000 -> AddrH=3D000020E0h
> 00080006 -> AddrL=3D06000800h
> 90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-
>
> The dma-buf get_pci_tph interface has also been exercised by a second,
> independent importer: a different vendor's NIC whose driver is not yet
> upstream, locally taught to call dma_buf_get_pci_tph(). A PCIe analyzer
> confirmed the ST it placed on outbound P2P TLPs matches the value
> configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, the same result as
> with mlx5. Two unrelated importer drivers exercising the callback
> end-to-end shows the interface is not tied to a single consumer. That
> importer change is out-of-tree and not part of this series. For that
> second importer, with userspace configuring 8-bit ST=3D0xe0 and PH=3D0,
> an analyzer capture shows:
> (TLP Captures)
> 08200260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D1 Attr=3D0 L=3D8
> 4E00004C -> RID=3D4Ch:0h.0h EP- Tag=3D4Eh
> 00170000 -> AddrH=3D00001700h
> 00200006 -> AddrL=3D06002000h
> 10E00000 -> OHC-B ST=3DE0h PH=3D0 HV=3D1 AMA=3D0 AV-
>
> Changes since v12:
>   Patch 1 (PCI/TPH, new to the series): the reserved-encoding fold,
>   previously posted standalone to linux-pci [1], is now the first patch
>   here (Alex Williamson). Sashiko could not apply v12 because of that
>   external dependency; with the fold in-series and the mlx5 leak fix in
>   linux-next, v13 has none. The code is unchanged from the standalone
>   v3; the Fixes: tag is dropped, since no code path can reach the
>   reserved encoding today and the patch is hardening rather than a fix
>   for observed silicon.
>
>   Patch 2 (PCI/TPH): inline the reserved-encoding fold in
>   pcie_tph_completer_type() rather than calling the helper that earlier
>   folding revisions added; that helper was dropped in folding v3 per
>   Bjorn Helgaas and Wei Huang.
>
>   Patch 3 (dma-buf): no functional change.
>
>   Patch 4 (vfio/pci): also gate the DMA_BUF_TPH feature on
>   vdev->pci_ops->get_dmabuf_phys, matching
>   vfio_pci_core_feature_dma_buf(). Without it PROBE reported the feature
>   as supported on a device that advertises TPH Completer support but
>   cannot export a vfio dma-buf at all, so nothing could ever carry the
>   metadata (Alex Williamson, who raised this to uAPI-affecting
>   severity).
>
>   Patch 5 (mlx5): keep the !dev->st early-out in mlx5_st_alloc_index()
>   ahead of the pcie_tph_get_cpu_st() call, so splitting out
>   mlx5_st_alloc_index_by_tag() neither adds an ACPI _DSM invocation on
>   devices without ST support nor changes the errno userspace sees when
>   the _DSM lookup fails (Alex Williamson). The commit message now
>   describes this rather than presenting the split as a pure extraction.
>
> Previous link:
> v12: https://lore.kernel.org/linux-pci/20260715204008.3911275-1-zhipingz@=
meta.com/
> v11: https://lore.kernel.org/linux-pci/20260702181025.2694961-1-zhipingz@=
meta.com/
> v10: https://lore.kernel.org/linux-pci/20260630224328.3218796-1-zhipingz@=
meta.com/
> v9: https://lore.kernel.org/dri-devel/20260622184211.2229399-1-zhipingz@m=
eta.com/
> v8: https://lore.kernel.org/dri-devel/20260615065912.2177918-1-zhipingz@m=
eta.com/
> v7: https://lore.kernel.org/dri-devel/20260611161546.4075580-1-zhipingz@m=
eta.com/
> v6: https://lore.kernel.org/dri-devel/20260608185646.4085127-1-zhipingz@m=
eta.com/
> v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipingz@m=
eta.com/
> v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipingz@m=
eta.com/
> v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz@m=
eta.com/
> v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@me=
ta.com/
>
> Zhiping Zhang (5):
>   PCI/TPH: treat reserved 0b10 completer encoding as unsupported
>   PCI/TPH: Add requester/completer type helpers
>   dma-buf: add optional get_pci_tph() callback
>   vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
>   RDMA/mlx5: get tph for p2p access when registering dma-buf mr
>
>  drivers/dma-buf/dma-buf.c                     |  32 ++++
>  drivers/infiniband/hw/mlx5/main.c             |   1 +
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  11 ++
>  drivers/infiniband/hw/mlx5/mr.c               | 151 +++++++++++++++++-
>  drivers/infiniband/hw/mlx5/odp.c              |   7 +
>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  52 +++++-
>  drivers/pci/tph.c                             |  55 ++++++-
>  drivers/vfio/pci/vfio_pci_core.c              |   3 +
>  drivers/vfio/pci/vfio_pci_dmabuf.c            | 120 +++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h              |  13 ++
>  include/linux/dma-buf.h                       |  25 +++
>  include/linux/mlx5/driver.h                   |  15 ++
>  include/linux/pci-tph.h                       |   8 +
>  include/uapi/linux/vfio.h                     |  43 +++++
>  14 files changed, 517 insertions(+), 19 deletions(-)
>
> --
> 2.53.0-Meta
>
