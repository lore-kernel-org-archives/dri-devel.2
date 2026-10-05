Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F4ECA5FF5
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2EC10E1FE;
	Mon,  5 Oct 2026 21:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="ZM6DHvvK";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DD510E1FE
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 21:33:31 +0000 (UTC)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695IDC7F3120552
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 14:33:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=DoTDLnxWo+vyBFg2XZXFvqT0SQiCp8iD3nRLl
 DuEKK0=; b=ZM6DHvvKxW2/pC1CNOsB1mPJd6PbhZ1d+WNZzXdBrKg698H4Z/JQ5
 r0k6m6sXmm6aWVzw4PcxIIMpG4KSIKqnAh1JWHxjY4yBbDpwkBvZq8yHY7XYROJW
 qECJPI6+JWo1ArTnAp5BS2i4q4B0I/v7dabXmzWUc6u58Pz8j/TId07ZUViW5zwE
 rMwqm7hZdQ2V3Sg7Xx8zTKqtozkoj7nU3DgmRjKjsh4kBdBlB3eL0I+cq4EJADOU
 4PNzyETYw5o3jQ81IXaTVRrgBpiJ5jVYjWecv1q3ldplR7E9Ohpr5tKJ5mNX7TUu
 8iYh9fuqG8hTKmdAxXx+qEfUjDlqrbhhA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h2yef89qp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 14:33:29 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-81447a16061so4979419a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 14:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791236009; cv=none;
 d=google.com; s=arc-20260327;
 b=SUWoq+7v0+mA7x9ftb1Y/zBapRy9AgcV1X2R/jh1+gb8qlcV8WJ1qaeYFCNUm/iGWV
 cUgP9cXJInBR26nlzk9nlY52zbHdwLumQJsNBduBeZ9BSXrLRqAEyhgc/tXKxfTyBZ1E
 g9hwzU68YsDcLPIZiN/ar0HWzARx83kv+xK+48N8azowdYac2I8jidi7rQhvdsELzCmF
 uPtspPt2t65opFCh5bZv9VKV5jLPiBjOQTBl6Iw5EQFflW92RDAqVfWxhos+hiiv7oPp
 izSuM5gErRLwcbb/Ma2cbFDtvlog9dqYbeHVUUwOYiQl5eJQmfRGRkLyjaKOqCu2HUSz
 VDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=ghbzX0NgXdNhpA6B0OeBfQfvRP9XoL8GQxYtfbQBaKM=;
 fh=f+HbonJz7zcHJ2J58AnHyNrFJuMePgDxLApFfNYnBWs=;
 b=o7jNyYnF6fB6d3YHe6AEiA8XfUUtf6+0zTeuDThnTo2KyAbFVAzBD1qJwmCNrshp3M
 9ZOfWeBAcfyteW0OIIdyDGcB0shIUL7RiWrLj1o75bZWylnl+Y43euuCSamvXEvjDShd
 xPdaJxVvWcw+unjQPJnUZLNON5BbhpDOTsVyu3Y/UMfE479xETP+c8i3czU0Uh+6vnm9
 CKo47Kf97k8KW/mvQQsRNrhjkKhG02l/7XBemxfcQ9EGHpAChFc84ClyOf9fzMXn1sIy
 /1JNYe122QlDvb1GLlefZMSIB9jJLoN6gielGIAv58JALqQHvVz6P7MDHN6jMuZFd9ru
 WhBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791236009; x=1791840809;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ghbzX0NgXdNhpA6B0OeBfQfvRP9XoL8GQxYtfbQBaKM=;
 b=ID7fiIB+SnjPy41hHgSse/93ZyqOpJBIVs6NRUHrxu443RwxqFntaRtbjk15nGc/3d
 ZqOLQrKe21ZRsAjCtBnXuPl+0oi2ECEPUyvtb0x81bp3eU7MVMIe2pKbpFTONQ7Y3luZ
 or3D1JlRKxM+maOJL70wbDXDlUi7lKipHI1vX57b4TuRdCi47iWaV6BkQkbwu2vBpti+
 +lPHeb3GlAzJPL4GtSm0dXmkyScVXsxIxSFj63s6mdl8yfSePtKnhvN35/Co2tHt68bn
 8xX6GPFaS/xi2x10NMeUR+0hN7cD8GkUQaII8jkHwUXbo35C8y++mw9OnRKDrH+3ZfKi
 5zbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxEqMxLzNuGCMfBmYpX8GGPkIFFSGRslfwt9BIWQIHInG3QT+A7L5cBaXhfVPBcCKo1aqEcPOsYIk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kFo6v1pEabmBOZSLz/imSCOIao6dEhyuX4HWcHYn/WU4YbNeF6
 nwBjxSwQtXr7u/zMFsM2m3pKJgNleuc7haAstCRVutM0nSyxDjbk4Ld0ZWQIFhflH6qxDAJ8wvs
 7AGh42pQkB3C15fOHxp1ZrhgtKim8+O/jPR9SDfAOEtR75T1cojl6cfG4ibXgchEdEPJYUz2yq+
 2VFT6wqiL9p6rq54siQ3qObvWatvXBIy+t7VyFLzvBM8I=
X-Gm-Gg: AYBFou2YqEJc4Ya7NO3IT/5+BsNbyrhTad47w5XNGseSMerHw4+CQdfw9zvbn/GvIPU
 KKQ1ByQ+slxK6sjYaazaHelVcnvVu9pbBRWl07SgX8j2PFiMDXFMH0G7jKq6aOHpUq9kSdWhurb
 wYgonAXJZTIce8feM+9P/eecifdBUZe69zbz9iFi+dD7ZzTp+I1YaKmRWLmnFXkAv+PQctAxBk
X-Received: by 2002:a05:6830:67d8:b0:81e:bb4b:2324 with SMTP id
 46e09a7af769-82285c55c03mr11907170a34.26.1791236009078; 
 Mon, 05 Oct 2026 14:33:29 -0700 (PDT)
X-Received: by 2002:a05:6830:67d8:b0:81e:bb4b:2324 with SMTP id
 46e09a7af769-82285c55c03mr11907148a34.26.1791236008493; Mon, 05 Oct 2026
 14:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
 <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
 <20260924233058.GA163130@ziepe.ca>
 <CAH3zFs2rhg6-b-pVDps1V8LsM4Dn48t4J4LFVyKOZtT4axdY=Q@mail.gmail.com>
 <20260928172939.GK163130@ziepe.ca>
 <CAH3zFs1mCujYjB=5ywo+huAjPJZQoe9u7NM4evNRYr5_ZQbcXQ@mail.gmail.com>
 <20260930121349.GD3401365@unreal>
In-Reply-To: <20260930121349.GD3401365@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 5 Oct 2026 14:33:17 -0700
X-Gm-Features: AclHuK9wPVFlctf6gP5X6sNuMnv1YN3Hk2l0PdMFBVaYzDmHBABydld70Lp-gj0
Message-ID: <CAH3zFs0-5yZzquCAS+RA=jerok3fikWs+hJMnp_91D37ccFtUw@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, fengchengwen <fengchengwen@huawei.com>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: IqxOC-cBJ7OzKiIEAZNifis0hwV3CmVc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX4oKAfJQJ+PZ6
 fnXqcU0XjuF5YMoIitIkeTYiRl247vUB3Sm/+5NuasBDZZ8p+I8J1fn4+OBMRtlhXtoCzdwbNfr
 LQeFmMM2CZOjb77WM7SagfGBITfcv4PG488V8TnjsaCrLYWtYRmH2IYTlhPtj1O7XI9NmTh9JoO
 dZuic7FbJO19h0YoypmIGECpg8AMuMs04Mj3fVnWCDy4zO/qwbkIxkB62DZroumElrMCvAMDDmr
 61uGUvcNZlfw0dZgBcUYEw+NjdUgNPJ0f8qxbfpboDGgxmlh4xjOfJBR/dfR6dpP77WpWYab1Wy
 dCIdCIA8JWBC3iIK/oM1J6c2dfb7CvtdTSxehO9NO6CcUnN/nyoM6jRBVUZwJQm7DPe5l6yGJ2Y
 h2UCkwDhZ+xP0YUmYDUzx1aiB6Wm6Yn+VtE8LxPRHNJBhRByhuhHPZi5Up/jBy9BqP5gBTX3r3a
 DFKLKQagGQAV4ZWKYzg==
X-Proofpoint-GUID: IqxOC-cBJ7OzKiIEAZNifis0hwV3CmVc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfXxwNEQ7vdtOSK
 ydWg5++WWaRH/Xv5I8wvdYR615gMeJlZBDc9c4NbuRYbl8fz10PsDeHX7lIU4uJL10ncNlqTXSS
 1UjbdAw7emrvk/yxQR5JVwziRnDlubE=
X-Authority-Analysis: v=2.4 cv=D/PSufRj c=1 sm=1 tr=0 ts=6ac417a9 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8 a=m_M2Mm9OkLXPgJTOvGkA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
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

Hi Leon,

Sure, I'm happy to explain the TPH side. I see you've set the dma-buf
patches aside for now, so I'll just put the requirement on record
rather than ask for a particular API.

On the mlx5 ODP path the mkey must exist before the first dma-buf
mapping, and its ST index and PH are fixed at creation. It's the same
ordering problem you have with ATS. At that point mlx5 needs the ST/PH
tuple and an answer to Jason's question, whether its traffic to the
buffer is routed directly (PCI_P2PDMA_MAP_BUS_ADDR) rather than
through the host bridge. What mlx5 needs there is the answer, not the
exporter's p2pdma_provider. Wherever the route gets computed is fine,
as long as the result comes back for mlx5's own attachment.

In my earlier reply to Jason I said a later attach doesn't change an
existing importer's route. Christian pointed out in the patch 16
thread that it can, because the exporter only commits the access path
when the mapping is created. I was wrong there. The mlx5 patch
re-queries the ST/PH under dmabuf->resv after each
ib_umem_dmabuf_map_pages() and fails the fault if it changed; with
vfio-pci the tuple only changes if the device owner sets a new one.
The route check belongs in the same two places, which I think is close
to what Thomas suggested.

Alistair, adding you for visibility since you're picking up the
mapping-type work after LPC. mlx5 TPH would be the second user of
whatever lands there. I'm happy to help: I can implement the TPH side
on top of it and test on a CX-8 and a peer endpoint behind a PCIe
switch, including analyzer captures of the TLPs, or I can take on a
piece of the work if that's useful.

Thanks,
Zhiping

On Wed, Sep 30, 2026 at 5:13=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Mon, Sep 28, 2026 at 02:47:46PM -0700, Zhiping Zhang wrote:
> > On Mon, Sep 28, 2026 at 10:30=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > >
> > > >
> > > On Thu, Sep 24, 2026 at 11:17:57PM -0700, Zhiping Zhang wrote:
> > > > On Thu, Sep 24, 2026 at 4:31=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.=
ca> wrote:
> > > > >
> > > > > >
> > > > > On Wed, Sep 23, 2026 at 11:24:56PM -0700, Zhiping Zhang wrote:
> > > > > > I don't think this belongs in the importer. Every in-tree dma-b=
uf
> > > > > > caller of pci_p2pdma_distance() is the exporter, in its .attach,
> > > > > > clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
> > > > > > habanalabs memory.c. There is no importer-side caller.
> > > > >
> > > > > Right, and they shouldn't be doing that, but it still has to be
> > > > > checked that the st is going directly to the peer device not the =
host
> > > > > bridge. Not using the distance, but by the PCI_P2PDMA_MAP_BUS_ADDR
> > > > > indication.
> > > > >
> > > > > I fear you will need some of Leon's series to make that happen.
> > > > >
> > > > > So probably the proposed change to dmabuf ops is far too simple.
> > > > >
> > > > > Jason
> > > >
> > > > Hi Jason,
> > > >
> > > > Thanks for the comments.
> > > >
> > > > Agreed -- the tag should not be handed out unless the routing is
> > > > PCI_P2PDMA_MAP_BUS_ADDR. That can be enforced conservatively on 7.3
> > > > with two changes. I can fold both into patch 4.
> > > > ```
> > > > In drivers/pci/p2pdma.c, make pci_p2pdma_map_type() callable from
> > > > tristate VFIO_PCI_CORE:
> > > >
> > > >     EXPORT_SYMBOL_GPL(pci_p2pdma_map_type);
> > >
> > > No, that's been rejected several times already.
> > >
> > > > and in drivers/vfio/pci/vfio_pci_dmabuf.c,
> > > > vfio_pci_dma_buf_get_pci_tph() gains:
> > > >
> > > >     struct dma_buf_attachment *attach;
> > > >
> > > >     if (list_empty(&dmabuf->attachments))
> > > >         return -EOPNOTSUPP;
> > > >
> > > >     list_for_each_entry(attach, &dmabuf->attachments, node)
> > > >         if (pci_p2pdma_map_type(priv->provider, attach->dev) !=3D
> > > >             PCI_P2PDMA_MAP_BUS_ADDR)
> > > >                 return -EOPNOTSUPP;
> > > > ```
> > >
> > > Also no, this has to be done via PCI_P2PDMA_MAP_BUS_ADDR which also
> > > enforces putting the determination in the right place in the code
> > > flow..
> > >
> > > > Two properties are worth stating explicitly:
> > >
> > > Ah! AI!
> > >
> > > Jason
> >
> > Thanks Jason, I see what you meant by Leon's series now:
> >   https://lore.kernel.org/all/20260928-fix-p2p-acs-v4-0-v8-0-404453b9c4=
35@nvidia.com/
> >
> > Looking at v8, it seems patches 1-4 can stay functionally unchanged,
> > while patch 5 uses dma_buf_p2pdma_map_type() on its own attachment for
> > both the initial TPH query and revalidation. Is that what you expect?
> >
> > If so, would you prefer that I wait for Leon's series and rebase the
> > whole stack on it, or split the series so patches 1-4 can land first
> > and patch 5 follows after Leon's series?
>
> I would like you to join me there and explain to Christian why the
> importer needs access to the exporter's internals.
>
> You are already second user for the same functionally.
>
> Thanks
>
> >
> > Thanks,
> > Zhiping
