Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7930F94CBB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 02:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143F710E1CE;
	Wed, 22 Apr 2026 02:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MMX40lpw";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DD910E1CE
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 02:04:02 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2d9472c97dbso455096eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 19:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776823441; cv=none;
 d=google.com; s=arc-20240605;
 b=CnKqZOqTZ9PbZ03XslG4XGPAF8j/Artx0xw50V37tFlJUDfr5OdpCfnCY1+STpRtdc
 X1l5HJIPa0yevEb0v6Oe4qBU00ZEA1e/5fQ3z4OfpE3FWStGozq433SbVYlI6wWBeHX1
 n39m+5HR7qwtSDsnh+bEXYePNU/XO4MEX6gLjTooHo7mznKP8WANjrbGrO/Arxw4tH0a
 OA/souxoADKWdmoowrNf2lZidqoGjjL7Ad8pQs4TAK3cdXNTjsT9VVhZ3zRyighYzOES
 595BY8miS9QP5KRrPbY4YO0PQ7L4JVJ3RvnQpwGHNsZCbkpx82fv+47UQL8ZKbVvCYLN
 BAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KXwfE/915Iuu5tjJxurXwHhruslbzJKEkqu1zMBps88=;
 fh=emlPOgakJl44lhYnIb3LAxZPhcpOY1rWT1BLrrdLbtY=;
 b=T1VMFMMCfCBUKQZO6jhXIIvIkja27eIAz36PgtjUQMVuv2i7b/dv+qYMGFtfPTewES
 dIx2q9Ll5k1//t9sg2Lh3pEHc3BPj8Tr9plDE5grb3qc4vRC8R7PNIWSCLGgkRSDEGT4
 8VnpGqanRtaWVoqhC3/UWzcVe09PGxRw35t9YTgENH/ym5xqoPQiu3KqTej7caOcM3IE
 3PFjzbbkTTDoBJPhi7O/F98oVGCiGx4JVNCDmCkyC/zI9Y1I8FSKgYw3H0dKCS/n7qaF
 gA99nYeYK/j3ETsy5Zmreg4XkOEt8NiXe2N5xv4VeIwFrQ44zCDB3RN9z2TpYoPk06H6
 NvAw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776823441; x=1777428241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXwfE/915Iuu5tjJxurXwHhruslbzJKEkqu1zMBps88=;
 b=MMX40lpwSkLkXa5xuNL7NFoydsliqBjKZLUEi3dTbo3QzEF9QfCG3yFLo6g2gKhgCX
 0bk+L6YM28yBWs0kl9CM88AgBKikxak/Wt+kwtfzaoE4eox7uAPW6MLwYRndjxdFU5bg
 cSxcFAuGVRwx8J/rA0W4lD1P0HCfJlFseyxmjLWO247j2E5J9tof/bE3iSti6oorGHZw
 ttE2CfZT2g87niu+cWPl3jeOaf52iurRWWcwJeKpEApP6neyTTn155h3qq2B3WXFOGPi
 bi6Xo+bClHQ0GGpCytE7VdI8CgyntQFuwDSHewyMVfy3EfZxHnOikKFOLRHVr0oRPPID
 IhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776823441; x=1777428241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KXwfE/915Iuu5tjJxurXwHhruslbzJKEkqu1zMBps88=;
 b=O/kM+xw5MBzi9CrEUD3UBgKE25LQ3g2T10HpoDWb9CMYA7YEt4GStGRmRWotevnzux
 jD6Px+0zLE1Lf5uBdHfhH7cp4W1MZR7BnfWEokY4Vh4NjyUO6GfplxU0kB6ow9Lj0wN3
 IpXm5CISO1gynJw2GzcKPfvLcpOTZZ+YXA1KKEAUtl86+21iSg/ICETVrU8gN9pTyxvR
 bFiDlj1yE8e/MveOp4LJ+Q1EJGNDSfC/fv7oTHxShqrLfL8EEbgLVHg3zOQx6t7PBEja
 KPYn057wgVSDRXU/JbfAHjvD6x0LGNa/EgwddV+o3IsGscfpmb8KsPX2LN6A/Z/OUqVW
 ATZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vCoyUA36NM4a5VPvoNk+Pih3AtbhrB3uRVJAos9U4v0HQCQrmCxcVASawbO2chXB9Ef9E4CNyzFY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzH1ZLnu5fEi1UGwvVrAZpdIsHz0+Bk9yWyKNXc2+DfQ+YB+c0a
 jRUeE7xe6eDIqpJdj/Rsmcpu18jQpGNlfM6hosI1o6aCuKByNDm7mUQKSWsYXHk5GkY/t2+CRiv
 XH25hx/vbQoqRCApnRrEi62F/Pf3HJwU=
X-Gm-Gg: AeBDiessWMsCLFCibIf/pDEG0hOqe6tmCEM+WBY27K6X+iuT7DvmL6sSuo+CnvL0+VC
 YOIs7EavjIkuP27Emk+er8/8IBg3GmttjfmJhrckrekZu4/rs+j7RW9cgjBJ7k8jRbqO5f3Km8U
 5pXFizxsJQiSpfRyhjGicwihZ3kNYimhHZyLFjWygD7XLcqYAnNLT+3wcQQMqmzMeevB/9nkLix
 YNGFQjhwernd+MMu+jVBzMn1a7cZF4287gG8kr4lJg2SqZldCqfJlq3kWlxyABexvr2DiPobQD0
 n4ao5nwWOGg+2BP/0iqmJaZLRqzh6GJbOfBHkMQ6C4JqpmTd0JymDgRQtvl9cMZp7Vj9qoXkr+/
 ah9BS
X-Received: by 2002:a05:7022:5f01:b0:12d:b654:8180 with SMTP id
 a92af1059eb24-12db65484bfmr455959c88.2.1776823441162; Tue, 21 Apr 2026
 19:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <a06133f7-3093-4733-9786-bc46c1453e06@gmail.com>
 <b8d04414-18b5-40f7-9ea2-88b30ff5bea0@amd.com>
 <c7865b27-6bf1-4df1-9520-c9ef6b3ef368@gmail.com>
 <4751cf03-d3c1-4d5d-af8e-39ad7c8ffb84@amd.com>
 <7472bfcf-8c22-4ac7-b903-a883cdb8f1c6@gmail.com>
 <8fe8b78b-5294-4319-af92-a4fb00527417@amd.com>
 <8846bac5-77ff-4439-ac5c-c33cdb4a94e3@gmail.com>
 <964c3670-fad3-44ce-bd93-2057bca2dcb8@amd.com>
 <08ad2301-3163-4497-8869-fa4cea30b384@gmail.com>
 <e5c00f2c-0819-48b4-b66e-71b9a40a7235@amd.com>
 <686713fc-c762-4b1b-88b2-d486d4f38ac6@gmail.com>
 <de6777c1-1165-4ace-a5a7-3004aa9ea8c5@invisiblethingslab.com>
 <d045e25d-0bc5-4056-b4a2-9eda73fb5be7@gmail.com>
In-Reply-To: <d045e25d-0bc5-4056-b4a2-9eda73fb5be7@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Apr 2026 22:03:49 -0400
X-Gm-Features: AQROBzCq3JY-5ArkKnDyVVr-Wl_czV3R7nte4oTZblqOBZ3Fd9cc3qiKy3Gryh4
Message-ID: <CADnq5_Og_eAA2QkN_TM=AqY2rz_B6cwbm5tePzwrAXzK3BypGg@mail.gmail.com>
Subject: Re: Pinned, non-revocable mappings of VRAM: will bad things happen?
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Val Packett <val@invisiblethingslab.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, 
 Xen developer discussion <xen-devel@lists.xenproject.org>,
 linux-media@vger.kernel.org, Suwit Semal <sumit.semwal@linaro.org>, 
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
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

On Tue, Apr 21, 2026 at 9:34=E2=80=AFPM Demi Marie Obenour
<demiobenour@gmail.com> wrote:
>
> On 4/21/26 12:55, Val Packett wrote:
> >
> > On 4/20/26 4:12 PM, Demi Marie Obenour wrote:
> >> On 4/20/26 14:53, Christian K=C3=B6nig wrote:
> >>> On 4/20/26 20:46, Demi Marie Obenour wrote:
> >>>> On 4/20/26 13:58, Christian K=C3=B6nig wrote:
> >>>>> On 4/20/26 19:03, Demi Marie Obenour wrote:
> >>>>>> On 4/20/26 04:49, Christian K=C3=B6nig wrote:
> >>>>>>> On 4/17/26 21:35, Demi Marie Obenour wrote:
> >>>>> ...
> >>>>>>>> Are any of the following reasonable options?
> >>>>>>>>
> >>>>>>>> 1. Change the guest kernel to only map (and thus pin) a small su=
bset
> >>>>>>>>     of VRAM at any given time.  If unmapped VRAM is accessed the=
 guest
> >>>>>>>>     traps the page fault, evicts an old VRAM mapping, and create=
s a
> >>>>>>>>     new one.
> >>>>>>> Yeah, that could potentially work.
> >>>>>>>
> >>>>>>> This is basically what we do on the host kernel driver when we ca=
n't resize the BAR for some reason. In that use case VRAM buffers are shuff=
led in and out of the CPU accessible window of VRAM on demand.
> >>>>>> How much is this going to hurt performance?
> >>>>> Hard to say, resizing the BAR can easily give you 10-15% more perfo=
rmance on some use cases.
> >>>>>
> >>>>> But that involves physically transferring the data using a DMA. For=
 this solution we basically only have to we basically only have to transfer=
 a few messages between host and guest.
> >>>>>
> >>>>> No idea how performant that is.
> >>>> In this use-case, 20-30% performance penalties are likely to be
> >>>> "business as usual".
> >>> Well that is quite a bit.
> >>>
> >>>> Close to native performance would be ideal, but
> >>>> to be useful it just needs to beat software rendering by a wide marg=
in,
> >>>> and not cause data corruption or vulnerabilities.
> >>> That should still easily be the case, even trivial use cases are mult=
iple magnitudes faster on GPUs compared to software rendering.
> >> Makes sense.  If only GPUs supported easy and flexible virtualization =
the way CPUs do :(.
> >>
> >>>>>>> But I have one question: When XEN has a problem handling faults f=
rom the guest on the host then how does that work for system memory mapping=
s?
> >>>>>>>
> >>>>>>> There is really no difference between VRAM and system memory in t=
he handling for the GPU driver stack.
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>> Christian.
> >>>>>> Generally, Xen makes the frontend (usually an unprivileged VM)
> >>>>>> responsible for providing mappings to the backend (usually the hos=
t).
> >>>>>> That is possible with system RAM but not with VRAM, because Xen ha=
s
> >>>>>> no awareness of VRAM.  To Xen, VRAM is just a PCI BAR.
> >>>>> No, that doesn't work with system memory allocations of GPU drivers=
 either.
> >>>>>
> >>>>> We already had it multiple times that people tried to be clever and=
 incremented the page reference counter on driver allocated system memory a=
nd were totally surprised that this can result in security issues and data =
corruption.
> >>>>>
> >>>>> I seriously hope that this isn't the case here again. As far as I k=
now XEN already has support for accessing VMAs with VM_PFN or otherwise I d=
on't know how driver allocated system memory access could potentially work.
> >>>>>
> >>>>> Accessing VRAM is pretty much the same use case as far as I can see=
.
> >>>>>
> >>>>> Regards,
> >>>>> Christian.
> >>>> The Xen-native approach would be for system memory allocations to
> >>>> be made using the Xen driver and then imported into the virtio-GPU
> >>>> driver via dmabuf.  Is there any chance this could be made to happen=
?
> >>> That could be. Adding Pierre-Eric to comment since he knows that use =
much better than I do.
> >>>
> >>>> If it's a lost cause, then how much is the memory overhead of pinnin=
g
> >>>> everything ever used in a dmabuf?  It should be possible to account
> >>>> pinned host memory against a guest's quota, but if that leads to an
> >>>> unusable system it isn't going to be good.
> >>> That won't work at all.
> >>>
> >>> We have use cases where you *must* migrate a DMA-buf to VRAM or other=
wise the GPU can't use it.
> >>>
> >>> A simple scanout to a monitor is such an use case for example, that i=
s usually not possible from system memory.
> >> Direct scanout isn't a concern here.
> >>
> >>>> Is supporting page faults in Xen the only solution that will be viab=
le
> >>>> long-term, considering the tolerance for very substantial performanc=
e
> >>>> overheads compared to native?  AAA gaming isn't the initial goal her=
e.
> >>>> Qubes OS already supports PCI passthrough for that.
> >>> We have AAA gaming working on XEN through native context working for =
quite a while.
> >>>
> >>> Pierre-Eric can tell you more about that.
> >>>
> >>> Regards,
> >>> Christian.
> >> I've heard of that, but last I checked it required downstream patches
> >> to Xen, Linux, and QEMU.  I don't know if any of those have been
> >> upstreamed since, but I believe that upstreaming the Xen and Linux
> >> patches (or rewriting them and upstreaming the rewritten version) woul=
d
> >> be necessary.  Qubes OS (which I don't work for anymore but still want
> >> to help with this) almost certainly won't be using QEMU for GPU stuff.
> >
> > Yeah, our plan is to use xen-vhost-frontend[1] + vhost-device-gpu,
> > ported/extended/modified as necessary. (I already have
> > xen-vhost-frontend itself working on amd64 PVH with purely xenbus-based
> > hotplug/configuration, currently working on cleaning up and submitting
> > the necessary patches.)
> >
> > I'm curious to hear more details about how AMD has it working but last
> > time I checked, there weren't any missing pieces in Xen or Linux that
> > we'd need.. The AMD downstream changes were mostly related to QEMU.
> >
> > As for the memory management concerns, I would like to remind everyone
> > once again that the pinning of GPU dmabufs in regular graphics workload=
s
> > would be *very* short-term. In GPU paravirtualization (native contexts
> > or venus or whatever else) the guest mostly operates on *opaque handles=
*
> > that refer to buffers owned by the host GPU process. The typical
> > rendering process (roughly) only involves submitting commands to the GP=
U
> > that refer to memory using these handles. Only upon mmap() would a
> > buffer be pinned/granted to the guest, and those are typically only use=
d
> > for *uploads* where the guest immediately does its memcpy() and unmaps
> > the buffer.
> >
> > So I'm not worried about (unintentionally) pinning too much GPU driver
> > memory.
> >
> > In terms of deliberate denial-of-service attacks from the guest to the
> > host, the only reasonable response is:
> >
> > =C2=AF\_(=E3=83=84)_/=C2=AF
> >
> > CPU-mapping lots of GPU memory is far from the only DoS vector, the GPU
> > commands themselves can easily wedge the GPU core in a million ways (an=
d
> > last time I checked amdgpu was noooot so good at recovering from hangs)=
.
> >
> >
> > [1]: https://github.com/vireshk/xen-vhost-frontend
> >
> > ~val
>
> I think it is best to handle things like GPU crashes by giving the guest
> some time to unmap its grants, and if that fails, crashing it.  This shou=
ld
> be done from a revoke callback, as afterwards the VRAM might get reused.
>
> Does amdgpu call revoke callbacks when the device is reset and VRAM
> is lost?  It seems like it at least ought to.
>
> As an aside, Qubes needs to use the process isolation mode of the
> amdgpu driver.  This means that only one process will be on the GPU
> at a time, so it _should_ be possible to blow away all GPU-resident
> state except VRAM without affecting other processes.  Unfortunately,
> I think AMD GPUs might have HW or FW limitations that prevent that,
> at least on dGPUs.

The driver has supported per queue resets for a few kernel releases
now so only the bad app would be affected in that case.

Alex

>
> It might make sense to recommend KDE with GPU acceleration.  KWin can
> recover from losing VRAM.
> --
> Sincerely,
> Demi Marie Obenour (she/her/hers)
