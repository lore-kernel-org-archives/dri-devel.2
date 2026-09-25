Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1126C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 06:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E0710E594;
	Fri, 25 Sep 2026 06:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="VfSJh7OB";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A444110E594
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 06:18:11 +0000 (UTC)
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4ZcZA2853583
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 23:18:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=3WDgA1GYWRcpEGSy8oblmXJsMBCT00PLjmGyn
 aUkoWM=; b=VfSJh7OBvNbRoHKtuhy9uNErUyzn+eXZDk8BcC/sRvPHfo7UivGiP
 ay2EkQdik72AZ4/j3b9dO1FG2s9xbABwemWI/8eZnf7GYlLCfMsMveUicB9pesps
 pHVAdBkf03Cz/QMuoAkhwCADtF9iVETfdMMnafULPSVJy76Ix5dk+ZddV7s73A2Q
 TE3Diy1OC2LINh817TszuzJLVaJgSvFTRyPmtfbL7NTf5ymTr4Exg5n/swBTvdVB
 zbjF5jpGrPfzYsUCxpFMYCEXPmOLaMDPEQ3w0UXneN3pt1rS3WoC+mECEgewPE/g
 0caJ3yDapKjnQ76nm7CV8mod/GZ19creQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gw8fg59p6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 23:18:10 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-806004ec379so542153a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 23:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790317089; cv=none;
 d=google.com; s=arc-20260327;
 b=L+wo3vsq0QGs7nFB3Spjw7omu9K+z+3RxfmNnlGH2adzwPP/lOozAvGgHoW11fQ4Sk
 rIA8okGcsxAsT2xjQGkpTro42XNFEA2YAS45AdeygVFN80kTliAIMVDPCZAblyRF6MSS
 EoSWrFHVnerlrj/zMUOCE5PozkpZ3tYS5LInGXTk21WLp4oMt2pTdD7Qo5z6Uz0jojI0
 8ypan1k4oxXsdnoP9Ixb4QzyCnjYCVO1d7teXmEDrgUF4aR03zd53zfl4eBGlADMflsK
 JPLqM9bRxhqILWbC+KwouyOg5BS5ugP+4jByvjW2PSM2b5agF515KPHz6bkEss5fp9//
 2PNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=WWSTTsacYSgu4KAWVY5Awo+LzcWeh9/1ap1jJZvGOTk=;
 fh=ScJzcmShaHEnZ2qo1kXXvYX4vfEohNuc9SNfSYfyVgo=;
 b=YqF1CtDPkVcZ49I+bTmJWTojoUwPargrprIKO5U8gIceThajnbncalsU7y+1dV7pKX
 4qL01xYWWk4O7c7H5TYgv5L3J2n7TDKBMh2kmcQlJt/pKdu6vQFBD9E4FJn1NISn28vH
 kVKsds42QzE8fu0Gh5ltFJuZEh6VPzG9FAZdMNh0HAWsjw7yp4reSQZmvLN7QAjX990G
 uVMhUwFmbPC5H6lUA3pCmzzAPIofROutuq0Nn0xU7WLVNv2JBcxPqXKtp2ndEmlM4zlU
 xEifCuOqIE/iBxKgc70v4KW7wlNQqwdf+fIFWtdU1TBHSBwzDCWEZck2LHZONKPY+xi/
 frlw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790317089; x=1790921889;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WWSTTsacYSgu4KAWVY5Awo+LzcWeh9/1ap1jJZvGOTk=;
 b=jm0gaJ5eJGLxjMhxJuBzeLAMUUaVIxd+7B86ceWNQBHxclhJF5n/O06yp/0eobgRv3
 g2fynvjUPcsp3kx7g6xfI2WGJv6v1hEV0F19sSI/9DVUyHi8v7QOfVP9yTFFece5Cn60
 D86cRqbto5deD2XO4/aPTD4PHSh26txgw7JxtOe6YuQEivrbqIZQhtAl5k0rNIePEXOD
 zm6f9RUbjzM3rUmpOJuZjO83UO+3Td49YG6bfcPUDvm4mZLydg4sYtpjd9Jeif3xZJZ/
 9BqgJ+1PFWp5aY4eOd9ZZcYyEINO/FPYCf46IVAGBVb6V8KKb1OFM2wHWaorY+FsXGbG
 SUhA==
X-Forwarded-Encrypted: i=1;
 AKwUvByz2MhKp0nSuZv5rTQIHd0Xy49tyZLJC7KA1MonhzUveFADLSRamjlqJeqxFWzpUPlnExWTbyucIT8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mtl5VByYIrhGf1PpFRjsJNrR6yITxg4f9AB/jVhRiBdVPW/0Xl
 YtuHfczpVVKVkvb3wuOtU+l0qdz4OvGU4KsTuU0xIFL51cG7KCOVZ419tGzdGMOX9H3+MbvweCN
 xaM1eKaSVpVnu8QR7b8Np4Xv7g7Y90R5/K1hPM8Zd+/W0kF0ODxYJXB8RWNCR0V6Si5DSvOWx9u
 NwP6NuLfsdKqQI6Pq1KC3XftKHQYM1ONVaJr4rEhpOtnE=
X-Gm-Gg: AYBFou35asnX0TSQLT79ZvF6rdWjDbEUoBIBb99SzxbGTIu5BZDlRJ5hUEUAXxjOTzc
 h/GSVMT9wUg6HX5kj+PH6iWKZCs5KhL3x5FoKqqSPQP9A2JlrptnzvUyJ+lGITg5Dw9nzuZI3BC
 s0oROKIbmeYHTTvHKocCOMD2e41S7sbrWMMPiCQruVeY0H4Ys9v2d81TOXgrzuryTckRc89WRQ7
 knoEL4eCqfZ//dt9t8=
X-Received: by 2002:a05:6830:82f9:b0:7fa:ab72:9e04 with SMTP id
 46e09a7af769-81917b2db88mr973114a34.28.1790317089419; 
 Thu, 24 Sep 2026 23:18:09 -0700 (PDT)
X-Received: by 2002:a05:6830:82f9:b0:7fa:ab72:9e04 with SMTP id
 46e09a7af769-81917b2db88mr973099a34.28.1790317088755; Thu, 24 Sep 2026
 23:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
 <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
 <20260924233058.GA163130@ziepe.ca>
In-Reply-To: <20260924233058.GA163130@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 24 Sep 2026 23:17:57 -0700
X-Gm-Features: AclHuK_a6wmm00-FfvYFNpJ3gDBJ82g8ChC1_PoUtBfo_Ku3z4dlkY61TNU4smg
Message-ID: <CAH3zFs2rhg6-b-pVDps1V8LsM4Dn48t4J4LFVyKOZtT4axdY=Q@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: fengchengwen <fengchengwen@huawei.com>, Leon Romanovsky <leon@kernel.org>, 
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX1JWeR39EnFNi
 IZmdJhBTUVIN2/4kSoLJZ7n9vXxYU0pXb/Hbif9dqVe5/eC6+KcTyjQqt2YW4mEEgO96reis83h
 aqIePuLBlc6xfiWHksIKxYbtzSCYVe4=
X-Authority-Analysis: v=2.4 cv=RJomjIi+ c=1 sm=1 tr=0 ts=6ab61222 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=9jRdOu3wAAAA:8 a=5X87G3sW8SDPY7NpsN4A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-GUID: b4prdj-PduOxvQUi5kkrQKvwNM_sr2-o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX0hxa4BOHUycQ
 pKsIqScNMLgwRJG/wAjbz82BLzBm+jVBHtTdnLY+tUYmZ5r+iZHUx/IzB+bh8ZLW9c2/4QohI0G
 iAjBrSVGDcDZ3EBHqgG6mWgXLtYckeOqklpW0bQU2dMyDV2ARtcQAcKBsTMH1xuK2d/Usl4Et+N
 5N1uJXdXn5+tjb++w8y5I34kDfAq1LsKhXYKsXliMJf79bnNkklbEz5EeoxO8yQiKt/UhrCzuqB
 lkg42Sk8xLED8zJFbWynT7mAY+FG0dh/kewc15WwEUTt+GF2bvgZRAT6Hwq8I4WkT/L5DE3LQS2
 rXD4lftvS7xNlSHE+Kn4KUNGsGa+JgeFbVBtkU+JRir+4INqpTulbt4UsI1k44WIAyNdR6yLVrF
 w0k2axnzb9f+6/OLDLP6z7A2eg7l7JfVkm/VTLvqNB8d/DXK8DFLosizad0Yyz+X3hyXWDL8wM7
 jgwoL+y229g0TlBWqnQ==
X-Proofpoint-ORIG-GUID: b4prdj-PduOxvQUi5kkrQKvwNM_sr2-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
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

On Thu, Sep 24, 2026 at 4:31=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Wed, Sep 23, 2026 at 11:24:56PM -0700, Zhiping Zhang wrote:
> > I don't think this belongs in the importer. Every in-tree dma-buf
> > caller of pci_p2pdma_distance() is the exporter, in its .attach,
> > clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
> > habanalabs memory.c. There is no importer-side caller.
>
> Right, and they shouldn't be doing that, but it still has to be
> checked that the st is going directly to the peer device not the host
> bridge. Not using the distance, but by the PCI_P2PDMA_MAP_BUS_ADDR
> indication.
>
> I fear you will need some of Leon's series to make that happen.
>
> So probably the proposed change to dmabuf ops is far too simple.
>
> Jason

Hi Jason,

Thanks for the comments.

Agreed -- the tag should not be handed out unless the routing is
PCI_P2PDMA_MAP_BUS_ADDR. That can be enforced conservatively on 7.3
with two changes. I can fold both into patch 4.
```
In drivers/pci/p2pdma.c, make pci_p2pdma_map_type() callable from
tristate VFIO_PCI_CORE:

    EXPORT_SYMBOL_GPL(pci_p2pdma_map_type);

and in drivers/vfio/pci/vfio_pci_dmabuf.c,
vfio_pci_dma_buf_get_pci_tph() gains:

    struct dma_buf_attachment *attach;

    if (list_empty(&dmabuf->attachments))
        return -EOPNOTSUPP;

    list_for_each_entry(attach, &dmabuf->attachments, node)
        if (pci_p2pdma_map_type(priv->provider, attach->dev) !=3D
            PCI_P2PDMA_MAP_BUS_ADDR)
                return -EOPNOTSUPP;
```
For the query to succeed, every current attachment must therefore be
BUS_ADDR, and an empty list fails closed. The walk is protected by
dmabuf->resv, which vfio_pci_dma_buf_get_pci_tph() already asserts.
During initial registration, mlx5 treats -EOPNOTSUPP as no TPH and
registers a plain MR.

On the current behaviour, for the record:
PCI_P2PDMA_MAP_THRU_HOST_BRIDGE is a successful mapping path, so an ST
can currently be returned and programmed for host-bridge-routed
traffic. The mapping remains valid because TPH is advisory, but the ST
is interpreted in the root complex's own ST namespace rather than the
endpoint's; consequently, the endpoint's steering hint would be lost.
Returning -EOPNOTSUPP is therefore the honest answer when the route is
not
BUS_ADDR.

Two properties are worth stating explicitly:
 - The metadata and its callback are per-dmabuf, while routing is per
attachment, so this deliberately uses a conservative all-or-nothing
gate across the current attachments. It may withhold TPH from a direct
importer when another attachment is not BUS_ADDR, but it cannot return
a tag while any current attachment has a non-direct route. An importer
attaching later does not change an existing importer's route, and
future queries reevaluate the current attachment list.
 - I kept this on 7.3 rather than rebasing v14 onto Leon's unmerged
P2PDMA/ATS routing series. Any route that 7.3 does not report as
BUS_ADDR therefore falls back to no TPH. This keeps the set
self-contained on merged code and avoids queuing it behind another
series.

I plan to send v14 with these changes. Please let me know if you see
any issue with the implementation above.

Thanks,
Zhiping
