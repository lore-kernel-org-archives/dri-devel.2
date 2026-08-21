Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75180C5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 21:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F5610E357;
	Fri, 21 Aug 2026 21:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lyI453CY";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D5010E357
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 21:18:24 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-394f4397662so173125a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787347103; cv=none;
 d=google.com; s=arc-20260327;
 b=JuoeiNdaRllCUK4DpVxybQgrekJYxFMehe0Fp9ma/8QFXTMlFw/hkS8Bz4dRzkaVKo
 paoecHYpLE389V3NjjObFFWtTRImIMqVLxd4UXZokOxbKJ2M5XHDeLruVhizPGkpOOCb
 E7+DBUlFRrQqjEhQBTb3vtMFxQxSfDcSMpH7DNBM5rrybIOlkpt3is7PXD8LqK60ZaEZ
 0Dzm/tNAF4l/jkC5+P6BHc/B+gG6YsNsrTRAAwTDvcUJ5PChFLZx6OkmTuXq2z7nxsuf
 GBuQFCc88jXq61lRPVPfQQNiCzPRdjBVz5nc+fVUsSyqWxqR6VbFVpvglmEOADLpN4aZ
 YOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GP7BnwG0/LtiFJQr9QJK94A+vGNuZ8dz0PfvWxEqYG8=;
 fh=IODq4BVtE8JU4pkginuK9OL/BakU7agbbWV50FXjM1g=;
 b=EAgAPTLV+/Ecekgd8lc3ItO5oOp6OJgGFMS/jTx6Of/Vs6w48/Jh0lGkbi8QUFkSyH
 YhUl5JzRXMIgSppgML3CQmE8wvjBwftDVxPiPF038rCglywdwr1VT6fVqWKFgj17VsEh
 dfssLl0SpPu26jY+zs1OBMn7/IV6ApJz/Em3sHee8lwvYbmVcPr+HESRjQxyCqueWRKT
 ecMTE3bxJSK7gHyvRYujywVD1+H/ddXzKipFVut3YHXUaoxykOQWzl4ESjIZp/RLE9dT
 q8nzybWg3L9S22RmxhSb64bnvaerI7OGYM4DQVp7OwJy3ov2IunxrzNgK1jRm33zmT2K
 p1VA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787347103; x=1787951903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GP7BnwG0/LtiFJQr9QJK94A+vGNuZ8dz0PfvWxEqYG8=;
 b=lyI453CYy4q64q1laTEa3uFpmunp7di4jpJnM2KXKkiaeyWsNkcSlgLvPI+64B4t2Z
 cQuzVo09sp7xu42mKcqyWCZ9YxsFxNKzvcla3UfxUfJD8VpiGRhKfMyUkSj3Y6859L3n
 +T2lrb8JTrlVoBLoF3dJT9AkGPUWbH/mTAouqiRPIDYk+i/NDdRBkGOpXNzDtkzHEwAV
 akByWLEsVkD530RmFO69KYHfZaF30efOREHxmzrW5oo7XeEroi0/T9Gm49DyXJC6z/ic
 hZVMlzE1FLX7jOiF+YCip0FdWjkUjMH6HqiwKW5iiP/9NHoB/PHAWxV5KXaT5/B5CxNG
 LMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787347103; x=1787951903;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GP7BnwG0/LtiFJQr9QJK94A+vGNuZ8dz0PfvWxEqYG8=;
 b=kemY8hUjW3wI8Kv7kHGmhK8giJXSSZ6KcDCiHavXVXvlAQD8W2ybj3wWtLPcVkNt3U
 FpBXAN2KnZxPTkxotz77ZhGcSBGx8SoIbG3NzzFYOhyKacTS0eCAXAEOINa2/+gN29Yu
 Le8DeOHJ3UIJRfocjk+ASdW9+/aa8p82EZ5nsmSWapsL4QP53GPR4fbizeG6CnY3U5EK
 TYtVdlN5FFnJ9OQqK1SIwznqGfE5ANxIbfVxqRcgAaN7NLI+coR+ODNf5eH5W/us7gTb
 IbYKH8vE4IQSM8Qve1mrG8lBVnxbcpOComKUINLEP6opvtzIwYvXcXCDP/sWBWp3tw/Y
 QY0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzSjQNSR9/Wy4JJH9J3jXrzy5ZFTa/65HldQsNpLX1EUNFfyhdDE5QE2JXANm4RWUxaKXZIK7QzFY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kpJYXXYD1q3IigsYGssq1PJ9yfUSnyHy6TiHdh+mNhJSdHc3/a
 oUP+3dqxzds+yTcLOPPmbAijpxvXIBvcFEOnN7jynOifHkpSC6G/zGleN9zoASy9ZkuE7UJJqDI
 3sVMxcN7BSKymtM5hyJkaCSbTmKLs6XA0/Q==
X-Gm-Gg: AR+sD11i14k02tNJATO16C8Hwhyq0L7u/ygOhWbSt4XABwLAeejtW95+FrK+PvidRMY
 5OIVWc4LrepB/mee9Uc/etmdhLzAmBCYMX2kTKbxqZ8yvwq7hr738m7iVoA13GsUDBkmxdu9ySa
 UDnCRhENNweHAleAPhWjpIDLR7LHnarE/cZ3gwf/bh0OWy2jev76Sn8Bw12UVyBXSA1Ou2MnjPP
 c6RX3KLTMX9udPGeeiCZ3AacowDpPNrRtNAuqqypeB6sfexTo8XxPmSaScz0KOJDf7V7X9XfDBa
 6UksIlniDbe9ROKvU2i65xgI589i6HrCK/i5fuSHtwqpZl27I5NRI4CWhVHqL0/tbc+GK8A++97
 b8sjC8nt+S92kJ+UrXlnRLjRbThH56zSWnwl/kdbM8Q==
X-Received: by 2002:a17:90b:4a81:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-395c35b913cmr7201623a91.4.1787347103487; Fri, 21 Aug 2026
 14:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260821195224.809173-1-alexander.deucher@amd.com>
 <20260821195224.809173-4-alexander.deucher@amd.com>
 <48b5b000-81b9-4cd0-9750-ec4ba910d96d@amd.com>
In-Reply-To: <48b5b000-81b9-4cd0-9750-ec4ba910d96d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Aug 2026 17:18:11 -0400
X-Gm-Features: AcwNN1UR5uvUmWY7DtQkLF71TlMDs68DJpoudBcpIuQ6A-VadIfE6D-QWihT_nQ
Message-ID: <CADnq5_Oh_v=cus-5Xqer+gO9rw_k=RR+y39KSEFwMsMoYDTJXw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Documentation: add initial UALink Documentation
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Joseph.Greathouse@amd.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Aug 21, 2026 at 5:06=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
> On 2026-08-21 15:52, Alex Deucher wrote:
> > Document the details of UALink on the GPU.
> >
> > Cc: Felix.Kuehling@amd.com
> > Cc: Joseph.Greathouse@amd.com
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   Documentation/gpu/amdgpu/index.rst  |  1 +
> >   Documentation/gpu/amdgpu/ualink.rst | 74 ++++++++++++++++++++++++++++=
+
> >   2 files changed, 75 insertions(+)
> >   create mode 100644 Documentation/gpu/amdgpu/ualink.rst
> >
> > diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amd=
gpu/index.rst
> > index b2ab182236efb..ba2ee73278672 100644
> > --- a/Documentation/gpu/amdgpu/index.rst
> > +++ b/Documentation/gpu/amdgpu/index.rst
> > @@ -23,4 +23,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA)=
 architectures.
> >      debugfs
> >      process-isolation
> >      amdgpu-glossary
> > +   ualink
> >      ptl
> > diff --git a/Documentation/gpu/amdgpu/ualink.rst b/Documentation/gpu/am=
dgpu/ualink.rst
> > new file mode 100644
> > index 0000000000000..1e0a6c52b7b7a
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/ualink.rst
> > @@ -0,0 +1,74 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +UALink Support
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Connected GPUs in a pod can directly access the remove memory on anoth=
er GPU
> > +over UALink.  Unlike RMDA, there is no copy involved; it is direct loa=
ds/stores
> > +over the fabric.  Shared memory can only be accessed by a remote GPU i=
f the
> > +memory was exported and the importer has been authorized. For the memo=
ry to be
> > +shared, it must be part of a unified physical address space shared bet=
ween
> > +nodes.  This address space is called NPA (Nework Physical Address) spa=
ce.  This
> > +address space is partitioned between the GPUs so that each GPU has its=
 own
> > +segment of the address space in which to export its memory.  Each GPU =
maintains
> > +a dedicated set of page tables for their NPA space similar to GPUVM.  =
Note that
> > +this mechanism only allows for GPU access to remote memory.  The remot=
e memory
> > +is not CPU accessible.
> > +
> > +Exported memory is not pinned.  The exporter may need to move memory o=
r make it
> > +unavailable to the importers.  This is handled via remote TLB shootdow=
ns on the
> > +exporter in the case of TTM evictions or MMU notifiers and remote pres=
ense
> > +checks with retry on the importer.
>
> This is no longer true. We ended up having to pin exported memory. This
> was also discussed with Christian already. In principle it's similar to
> how DMABufs in VRAM are pinned for RDMA access.
>
> Remote TLB shootdown will only be used when exported memory is freed in
> order to remove access by remote GPUs.
>
>
> > +
> > +To access remote memory, the driver can map NPA addresses into its per=
 process
> > +GPUVM page tables just like local memory.  Applications use opaque han=
dles to
> > +represent remote memory.  GPUs in a pod communicate with eachother dir=
ectly to
> > +exchange NPA addresses between importers and exporters.  If a node goe=
s offline
> > +or is reset, their peers will clean up any remaining refrences that ar=
e lost
> > +when that happens.
>
> One important point here is, that NPA addresses are exchanged between
> the kernel mode drivers (through the scale-up fabric). NPA addresses are
> never given to user mode.
>
>
> > +
> > +On the importer, the NPA space is like another physical address space.=
 NPA
> > +addresses can be used as physical addresses for GPUVM to provide GPU v=
irtual
> > +addresses to the memory for processes using the GPU.
> > +
> > +On the exporter, the NPA space provides a way to expose discontiguous =
local
> > +memory as a contiguous address range for remote GPUs.  This allows the=
 exporter
> > +to locally manage the pages mapped into the NPA space.
> > +
> > +Remote NPAs are managed like another device specific TTM pool similar =
to
> > +doorbells or VRAM, however they cannot be CPU mapped.
> > +
> > +
> > +User Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Two IOCTLs are provided to export and import remote memory.
> > +
> > +Export Memory
> > +-------------
> > +To export memory, a UALINK handle must be created for an allocation th=
at can be
> > +shared with another node in the pod.  To do this the exporter calls th=
e GEM
> > +UALink IOCTL with the GEM handle to the buffer it wants to export.  Th=
e IOCTL
> > +returns a unique 128 bit handle which can be shared with the remote ho=
st.
> > +Calling export on the same GEM handle always returns the same UALink h=
andle.
> > +The UALink handle is destroyed when the GEM object is freed.
>
> More precisely, the UALink handle is destroyed when the GEM handle count
> reaches 0.

Thanks.  I've incorporated your comments.

Alex

>
> Regards,
>    Felix
>
>
> > +
> > +Import Memory
> > +-------------
> > +To import remote memory, the UALink handle from the remote node must b=
e
> > +converted from a UALink handle to a local GEM object which represents =
the local
> > +reference to the NPA space on the importer.  If the memory has already=
 been
> > +imported, it just returns a new reference to the existing GEM object. =
 If not,
> > +the importer queries the exporter to get the NPA address.  Once it has=
 that, the
> > +importer can create the GEM to represent the NPA space used by the all=
ocation.
> > +The GEM object is then exported to the caller as a dma-buf. The dma-bu=
f is
> > +leveraged for dynamic attachment which provides the ability to revoke =
access
> > +when necessary.
> > +
> > +
> > +Device to Device Communications
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Devices communicate via a protocol implemented in firmware.  Mesages s=
ent to a
> > +remote node generate an interrupt on that node for servicing.
