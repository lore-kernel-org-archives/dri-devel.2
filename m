Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C27FCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B8010EC72;
	Tue,  2 Jun 2026 07:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="OQZ6oiRN";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE40D10EC72
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:14:55 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6526fMFV2991996
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 00:14:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=GNbqOP8/vOBlC/5NmVa3CquXtyGbio1xnntDWh6iGKE=; b=OQZ6oiRNKfXF
 HFDFBWZ8BdlnmCUnJoqopQ8ht44IyIcRngTo5vzbD9eE3PHci7hw9MS25fO/+eto
 Ufhbzh5w0syuQ2ggQfOY2tYEThW6kK0fREz6MbHOgTTfppfQkpqdfn+SQPXexuAD
 Ie6ANRJ+b1YRc1xewkyhZx2bIIsI7MRe/jwOSfdaywuF9473KLIHfYoKIPRCh2Y8
 WWdocGE13zKd1J50r3VdsLTAZO5pqjzJkcYBoHjogiZO27cQxUvXRQ3zUmWXlq15
 g0ZF1xKWkn2Pxg3MqRPI0HmbFBBYIOMYNp9JoPpIzHq9+nA8JFAN2q0RoJ8mT7O6
 eVDAMsqcKQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4efwjxy3s8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6b5c2bcc8so3400965a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780384494; cv=none;
 d=google.com; s=arc-20240605;
 b=ZXeNZeqTirx5yopsQbD3bMrGvmppJiJaaaVbd1g/zEB5+XJ2llaipKkpY9sWEvFSaR
 l2rQs6B4OMma2CloUEgIkZAPRPTaSWaI+t/E7KevU47WZicgPg00YVm2Y99bdHjTBfew
 kyhBXiWBcT4ib/Jzcyf68q1O1tVRm3NLlM7p+TJ9tqCC4cNTGOc6ZxfaGYJGSL/32FoL
 G+p6yi1rlT1ir/0VqKGhayOuEN0m0veEy5qjH5dIi6vNGE6EaTv6ux+t5aq5quP/gb+8
 B8/keTRE92o9KoRp3olO/Dzz1Cth2QRtZLS80yfAsjgn4sNSX6NdNOatVr9P73EE0T15
 HiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=eU0M4rF9MI3wrJoAUMjH5Oo4i+TWDq0gEOuY0ahh7I4=;
 fh=Zk+xmFDazw265Hl04XBScJXwXRXK4vX0M7N1wNwCJXA=;
 b=eZtIJ+j6i1peAPjK1NDfxOxZ5BYkyxFi4q5r205Y21t4ToCxaGyYfz2eYslBYLmWx/
 nfyoI5QSlcdVe+F8LFltI4/lIAETeJDjdeQna+goY6DeE77HTUFhXHx0cOAy8lYc6By9
 gKdT6x4LzdwU3bcZ9hE6Pjr2ZD7Rb5sonQ6fUW5Ch8eZu/qljfDKc72CQ2h9A23S5MPp
 BbcoXmjIW9212ARCqdQ7MBw7xcoBR/BPg8hoQutDbj7UVadXVfOZqbRfYvP44E75XYkx
 UfynBx5kvGA48fMOoo9IbK4yHaa1RPDFvgUuM3RH0IIQAEqXvf2enwM9pxjWKbyk6MH3
 nY0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780384494; x=1780989294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eU0M4rF9MI3wrJoAUMjH5Oo4i+TWDq0gEOuY0ahh7I4=;
 b=kpPO/dyvhVxQy2A668jQE5Qs7yDHY5L+GCAoYGOoIXp+k9ONGPXBdwD66kHFgAwCyO
 ytw8oaHEtjFHpYfnaX8MjLv9KU1A6QQ9g8FoRBXTxNMMfdpt5LC/sNi3ULVfXViaW9Vb
 g28bmNJuOuGK3vIxnkTiFz2MQlTOxvNBo3RICNjdEa93w8cPcACtfrDjqv/LHeEC4WE6
 k5WFUdoXtRi86WEviEcfMcCgpYWjk7CAfs2yt4TdXsTs8xMPZKYHJeXocW69suws/n6t
 svBB6U+VAEfXDeIq+B6EkDj8ryduY4im54UyXwLHRfr/nH/6N2skM6CeoM6PVoaGfjbI
 3p0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NymuiKVOdjfShDHdxxL6VHY4ZWZxX/hYrn5Xy+EVNqlRm7zw6QrlsSf7dh0o+PqbuHx4GKOfUgrA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIfRY40/+exrFdAJlCVSRl+vGudWVzsYoaZmknKAn0Q6uMOaal
 Zd1BoE1PYZ//jwSitqSsashT99u1Y1Tj3Jj38SgRPauqQoudQQomjM9I/+woEsYrBcSevnnnRqo
 T9bivlQyXreVolN52GQJ9PIU+wzFWMiTeXQALNgkFsS3K4thVl8sXraEPBM2id55wDLsE8S06sY
 JzyYy4UkXxkoMr5d+B1+GO5rAfKYw3Q/5gZAVFsXHdHlI=
X-Gm-Gg: Acq92OF3eW3T3gIfIDmRpoX5BOP8WPFCEE6qlhv+kSlMX7lCJiDSqVzDUYvGUL9B5hX
 xWzZnqSL65Jn2egw3MBuFuxTH06WqLCoja9KwQZl6zEqP7ZhtHM/FgeT/rpvsppqyITKsRzaYta
 WfrWG+a16om6ZHvj15YCsQOP2jQjMcCftQJNpNy+azV0cKZESl1LunT7EKlho5mqvtOQq+Po45i
 eFi/8Lg08oDFmgvAyYA3EoY8xSb9BBHX8KXOwFMIRDLYxqeAqE=
X-Received: by 2002:a05:6830:b8a:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e6d22714f0mr1524749a34.8.1780384494168; 
 Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
X-Received: by 2002:a05:6830:b8a:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e6d22714f0mr1524729a34.8.1780384493717; Tue, 02 Jun 2026
 00:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
 <20260601174734.GB2487554@ziepe.ca>
 <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com>
 <20260601184838.GE2487554@ziepe.ca>
In-Reply-To: <20260601184838.GE2487554@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 2 Jun 2026 00:14:42 -0700
X-Gm-Features: AVHnY4Is8GEC0NoEl3YOomYHVUTID0QdEceI4eqR8x2YX12M9DU2UU8lLqhKsf4
Message-ID: <CAH3zFs0Lz=oe4coFS=Ws14rKsY_Wi0=ueT1DGx+YpaSvt=DkAA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NiBTYWx0ZWRfX0Kb3KShZqR8A
 j3pJNE+DUBAXjR0rtiqOcp5DhncHNwtD7I8ULfJbxrTleXl9FH0OP9NPRWgz7LTgFbr/XMlqceI
 gfbaGvt1HRTeYJrQaH2G2CcAHhzHGJXDC8Fkm51+/6MSKqAM52CEc2HmECtPXIgSmkarb/7YQkq
 4ytvUhUA8+vSerbNI5A5Q1Uy4Dne1rsgTytmXzpnqMnFKoBR6MLXB0URCI3i4Hw+TP2iOZfP/DL
 X4BKDS34l4kJV7W96kTMgKWu+wGQ0OQ8SnxLpHxh1fedqweHPEXEUWfQnG+oUdm4zqIpyrb5rib
 XI8gJAklbBJ0yFDCDiotfyhBE9hhTstK+bVN5Y4eHV7hmSyHEeaSDtf5vyyojJ8njU+rlEg/TYG
 1wUsqkAxNtXYk/IE7DeULQfJgXRWzvo5zRNvn2XM9nbwXI+EaYB29Zy4eDkytEyhbQdvVGBO2YE
 yGDfTuCThY0niu/cU5A==
X-Authority-Analysis: v=2.4 cv=araCzyZV c=1 sm=1 tr=0 ts=6a1e82ef cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=9jRdOu3wAAAA:8 a=80MmiaoySdvbWJADnQkA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-ORIG-GUID: CIcMHFF7wm7MCISj7aM2hnKZhf8m8Q5W
X-Proofpoint-GUID: CIcMHFF7wm7MCISj7aM2hnKZhf8m8Q5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
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

Thanks everyone for the feedback.

For v6 I plan to improve the cover letter to explain what the
Steering Tag concretely does on the completer side and why it
applies to P2P - the ST is consumed by the endpoint's ingress
block, not the root complex, so it's orthogonal to cache snooping.

I'll also include test results showing ST's functional effect on
P2P writes. In our case the ST is used to select in-flight data
operation.

Is there anything else you'd want to see addressed before v6?

Thanks,
Zhiping


On Mon, Jun 1, 2026 at 11:48=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Mon, Jun 01, 2026 at 08:17:15PM +0200, Christian K=C3=B6nig wrote:
> > On 6/1/26 19:47, Jason Gunthorpe wrote:
> > > On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian K=C3=B6nig wrote:
> > >>>> When you have a complete open source driver stack which utilizes
> > >>>> VFIO passthrough as the interface to communicate with the kernel
> > >>>> drivers then we can eventually talk about that.
> > >>>
> > >>> That decision is not up to dmabuf
> > >>
> > >> Yes it is. This is the DMA-buf API which is added here.
> > >
> > > It is a DMA-buf kernel API that is added, I think it is overreaching
> > > to try to veto a VFIO uAPI that calls it..
> >
> > Well as long as that is a private interface between VFIO and mlx5 I
> > have no objection at all.
>
> Well, as you know, we are using dmabuf to mediate many of these
> connections now.
>
> I don't mind a "private" interface as a starting point, but it does
> need to discoverable and negotiated without weird module dependencies
> or symbol_gets.
>
> > But when it starts to affect DMA-buf I need to make sure that it
> > works for everybody. And without even being able to test it that
> > becomes really tricky.
>
> They should have an argument how it can be used for CPU backed memory,
> IMHO.
>
> > > This exposes a PCI SIG defined TPH capability in a reasonable simple
> > > VFIO uAPI that can be re-used by any other device that happens to
> > > support TPH on inbound MMIO. The uAPI has sensible general semantics
> > > based around the PCI spec.
> >
> > That it's implementing an official PCI spec is a good argument.
> >
> > But on the other hand looking at the spec it's not really specifying
> > much since everything is architecture specific.
>
> Yeah, spec doesn't say what TPH does when it is received. It is
> intended as an opaque channel between the source and target.
>
> Even on the CPU DRAM side we make an opaque call into ACPI and the
> BIOS returns back the right value to use for the CPU. The whole thing
> is agressively opaque as to what the values mean to any particular
> device.
>
> So I don't have an issue with VFIO supplying a value for MMIO it
> owns, it fits the general architecture.
>
> > > Anyone can repeat the demonstration Meta outlined in their cover
> > > letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
> > > analyzer and you will see the PCI SIG defined TPH bits set the way the
> > > VFIO uAPI says they should be set.
> > >
> > > There is nothing uniquely tied to Meta's device here, or unusable by
> > > someone else's devices. Arguably this is actually a mlx5 feature to
> > > allow VFIO to control its TPH generation HW.
> >
> > Would it be possible to demonstrate the functionality with some FPGA
> > implementing an PCIe endpoint?
>
> Sure, you don't even need a special endpoint, any endpoint that
> doesn't explode when it receives a TPH is fine to illustrate that mlx5
> is emitting it correctly.
>
> A fpga reference board with an out of the box PCIe IP demo is likely
> entirely sufficient, and you can use a FPGA logic analyzer to inspect
> the packets.
>
> Though keep in mind mlx5 is formally supporting TPH in a growing
> number of kernel contexts, so we do test and verify our device is
> working properly as an initiator. So I wouldn't advocate anyone
> actually use their time on FPGA :)
>
> > Doesn't needs to be anything funky, just the ability to exercise
> > this for basically everybody who can spend a few $ on the HW.
>
> Topologically you also probably need a PCIe switch as the CPU P2P
> likely discards the header.
>
> Jason
>
