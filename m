Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1E5CD6E64
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E53E10FAC9;
	Wed,  3 Jun 2026 08:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="nKQcJ8O+";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0E410FAA9
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 08:54:26 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-9156b74006aso211740285a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 01:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780476865; cv=none;
 d=google.com; s=arc-20240605;
 b=cRdjQwKlHasRhKTRQo3EpJteUD5h+9VH7Vql+rEbivi7y2Az8bzedmCnq3eWVcyHny
 Sm3hWyHRhnTQOn9uXX4HoeZ1Z9ZdoJoE3niYsC7+W+ypGtxsFF8+UFKBHBREkstKi+H/
 xfBiE/hKTHwt8i3bO6ca8/1G8MZe6RhgnNr1uzWe7/DXjDe/qz2S/5jxtmA+eILqNA6p
 ya+88ZRG9kk7d8q14h6hyxyFbYTznAl8oFnaapE5aKu3jxbTfQ436DTxDi8s0elm28u8
 3sSzGlAj2T5Tw9F+Q7to8Hbh7RLED5wU7zM65bHuMVQHcaxDSeui6BSaxO3iBUW1SFCq
 Zc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g7JX48xUqE191PjwdvrWj7w+4oUCIR2hhRFUmFcQpEw=;
 fh=5yQywHInXOZC80KG7MN8WnVNPCGZyuUtiFB2wWRWBvg=;
 b=UY4xSIuHvnVs3sOxbI/9rS+27XhSuQOKUBJGzF+3r2aLJdLBIejAcEG5Txn3oMJJj2
 2N9p/0Bb7VkVqO4o4jnQiP+iPfiWFNl6dGvZonSfOPxhCuVgV8e75PBAME7IPfds6Wdl
 6yM6GQGX00l89dd7ggfOzpXRjZPaxQf/VVaoYuqFDijI55AqZmZAz7c2+ejg5Hlei3ML
 Y6v5X27FbV7KAogaJdqCfuJzWb1H/UyV7EBZkHVsW/yrBu08c+xjqHA7qhfZAwyNH4qz
 f8sVww4JyhlOG1LQQF1dQAg6fDrzszFE1qPA2nLDTMaI0PSXznDl8MnTuDYbV6GBOGdK
 LxlA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1780476865;
 x=1781081665; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7JX48xUqE191PjwdvrWj7w+4oUCIR2hhRFUmFcQpEw=;
 b=nKQcJ8O+rXeDcuEg7gjflBcK8jiLub4FSN08eZneLZJszmQwHeOhHg+6JdKM3Yi5oe
 7imD3eZicDeCfzBO+enLxGQHpNJbXe1dHlGzKQv1u3pOzhMUfWHp0FrokoiWh5i3nuyk
 Dmrb6XxQrgdQn0mVUrdPg8kvglq6LJt9JFK2M3VXT+7rmFtFWW/y0bWD+GIGgltBG+q0
 TgM+1xU1ViAbel7JPadSiJpVpk26tJFEMWVSEu3XHGFguBPV7ccox3FsYWoPJYUjws/2
 t8YR0rAN1l7WQTcKmY8aZg4CG2FFSnutm3moSg7x6O5S4aeezZA36RZLWbVELTlFRoYP
 VscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780476865; x=1781081665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g7JX48xUqE191PjwdvrWj7w+4oUCIR2hhRFUmFcQpEw=;
 b=Ly9zdCekj5+SyRWyAFC1ZtZeNTdFdxYEMkQE4nKReNLKyI4cdL29H0L3SKcFdSu7D5
 JNfHcTOkzDiiLKPZsvpQo8BvFN49t/qKc6DX3tlvZouUziEEYNm8mQi8PdZjRTJ/1kyS
 eGRwSQiQ0vxfxjZChqgX3HoeH091NWhquX4W5uFmqDpii9iekku/d/5lXNh97rsOqdcp
 exJuqP/+uLT6/k3+mISFn/BqHjLONih9B6X3eMBvhA6d8iYQBKc9wkN0EiOx4nxylz6X
 4G2adewomfjSe20D1F29Gje9vG/VQ0p76rX+WsutHzUeTL6Ny1jlRBa8LrPeKZk57P44
 BR1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ93SNtvbAsP1FhIrWCaAWx7RZHtlG3kQ/KV8rqkHqRBeJKIuw1FmD1OGFDi1r87irv24sMxUqiDXEM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdjI/etIQV5Zw/irVL0lVKhEmlDEmUkMsLU4wVsWT8pzrKlmif
 WcdUOjDZdEntJRJpv7fhOH6LNmp9i7FHbr3YabyKe5FVIT5kJqnooqqHgNr5RVarjZiXO36UgtJ
 8NNngrzqoC29TETZD6oC6+x+qciPirDb92O0vta+W3Q==
X-Gm-Gg: Acq92OHalgPsYgF+0OUOgMVAtM9hnApGuG8YoCCVjYGeBxTYfchBdgmS82ZMJo2zCbD
 XLF0a2KStYJgi/MUEuEJu3pWKSoi7gkbK/pRaqjGMskVgDXlq+2w6jGVtiZFZCpE+kDul2PkBAD
 BZ5GLZEKpjUcDfCHtkBxfkYRgsA3Wzz2SGU7jKnv7dxxNdEZJrqRYIEmNoXcu5+pBRAXyFOzSeJ
 oCFqoFyOtSR+F7p/uiCMh6ouP89ZnpM6IcA+wsakV7D9YzrMGU8jGbNDo6UZvvi3CUYiTIa+9kP
 kgGqDD1k2vvdXVtN
X-Received: by 2002:a05:620a:470d:b0:914:e3dd:17fd with SMTP id
 af79cd13be357-9158a6cce06mr407596485a.6.1780476864872; Wed, 03 Jun 2026
 01:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-2-b2d984c297f8@oss.qualcomm.com>
 <paiohsil5pmvm7cf6jxrhaj2225bgvlt3scrag4x6gbkyosow5@l4tbakbnxcvo>
 <CAPsqS2Tt0JbHhJLHBsbJ2YfZW913WNfoSXpSa+8TD1T9CV8V3g@mail.gmail.com>
 <9879f670-8a23-407b-ab45-673904ad4a86@oss.qualcomm.com>
In-Reply-To: <9879f670-8a23-407b-ab45-673904ad4a86@oss.qualcomm.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 3 Jun 2026 10:54:13 +0200
X-Gm-Features: AVHnY4JxR71JOH6mKjWdwqMelPGIBYkdeP3ekd-6Gg14JWpiLQqO3KnjrrlcThc
Message-ID: <CAPsqS2R5kr1-UqhijjgAfU9D1VnyEd3pCxOagHyesHSHpN4_8g@mail.gmail.com>
Subject: Re: [PATCH 02/15] accel/qda: Add QDA driver documentation
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org, 
 andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org
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

On Wed, Jun 3, 2026 at 7:22=E2=80=AFAM Ekansh Gupta
<ekansh.gupta@oss.qualcomm.com> wrote:
>
> On 20-05-2026 21:17, Tomeu Vizoso wrote:
> > On Wed, May 20, 2026 at 4:12=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>
> >> On Tue, May 19, 2026 at 11:45:52AM +0530, Ekansh Gupta via B4 Relay wr=
ote:
> >>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>>
> >>> Add documentation for the Qualcomm DSP Accelerator (QDA) driver under
> >>> Documentation/accel/qda/. The documentation covers the driver
> >>> architecture, GEM-based buffer management, IOMMU context bank
> >>> isolation, and the RPMsg transport layer.
> >>>
> >>> The user-space API section describes the DRM IOCTLs for session
> >>> management, GEM buffer allocation, and remote procedure invocation vi=
a
> >>> the FastRPC protocol, along with a typical application lifecycle
> >>> example. Sections for dynamic debug and basic testing are also
> >>> included.
> >>>
> >>> Wire the new documentation into the Compute Accelerators index at
> >>> Documentation/accel/index.rst.
> >>>
> >>> Assisted-by: Claude:claude-4-6-sonnet
> >>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>> ---
> >>>  Documentation/accel/index.rst     |   1 +
> >>>  Documentation/accel/qda/index.rst |  13 ++++
> >>>  Documentation/accel/qda/qda.rst   | 146 ++++++++++++++++++++++++++++=
++++++++++
> >>>  3 files changed, 160 insertions(+)

<snip>

> >>> +Usage Example
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +A typical lifecycle for a user-space application:
> >>> +
> >>> +1.  **Discovery**: Open ``/dev/accel/accel*`` and use
> >>> +    ``DRM_IOCTL_QDA_QUERY`` to identify the DSP domain served by tha=
t
> >>> +    device node.
> >>> +2.  **Initialization**: Call ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE``=
 to
> >>> +    establish a session and create a process context on the DSP.
> >>> +3.  **Memory**: Allocate buffers via ``DRM_IOCTL_QDA_GEM_CREATE`` or=
 import
> >>> +    DMA-BUFs (PRIME fd) from other drivers using ``DRM_IOCTL_PRIME_F=
D_TO_HANDLE``.
> >>> +4.  **Execution**: Use ``DRM_IOCTL_QDA_REMOTE_INVOKE`` to pass argum=
ents and
> >>> +    execute functions on the DSP.
> >>> +5.  **Cleanup**: Close file descriptors to automatically release res=
ources and
> >>> +    detach the session.
> >>
> >> I'd have expected the description of the actual example. I.e. clone th=
e
> >> app from https://the.addr, prepare clang >=3D NN.MM, QAIC (https://foo=
),
> >> run make, run the app, check the results. I'd remind that DRM Accel ha=
s
> >> a very specific requirement of having the working toolhain in the
> >> open-source.
> >
> > We have been getting submissions lately that don't fulfill that
> > requirement so I will point to the precise part of the documentation
> > that explains it:
> >
> > https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-us=
erspace-requirements
> >
> > For an example of a submissions that complies, see:
> >
> > https://lore.kernel.org/dri-devel/20260114-thames-v2-0-e94a6636e050@tom=
euvizoso.net/
> >
> > Most importantly, notice how the proposed Thames Mesa driver generates
> > machine code for all the hardware units, and doesn't use any blob for
> > that.
> >
> I believe QDA checks all boxes for accel, as there is available
> opensource userspace, opensource QAIC compiler for IDL compilation and
> LLVM supports hexagon arch.

I must say that I'm at a total loss regarding the userspace portion of
this driver, despite spending half an hour looking inside the FastRPC
branch that you link from the cover letter.

Can you please explain what do people need to do to:

- run an algorithm of their choice on the DSP,
- execute inference with a common ML framework such as TensorFlow Lite
or PyTorch.

The documentation I pointed to earlier explains in length what is
expected from the userspace portion of the driver, which is more than
just being open source.

Thanks,

Tomeu

> I'll try adding these details as well.
>
> Thanks!> Regards,
> >
> > Tomeu
> >
> >>> +
> >>> +Internal Implementation
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>> +
> >>> +Memory Management
> >>> +-----------------
> >>> +The driver's memory manager creates virtual "IOMMU devices" that map=
 to
> >>> +hardware context banks. This allows the driver to manage multiple is=
olated
> >>> +address spaces. The implementation uses a DMA-coherent backend to en=
sure data consistency
> >>> +between the CPU and DSP without manual cache maintenance in most cas=
es.
> >>
> >> GEM usage?
> >>
> >>> +
> >>> +Debugging
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +The driver includes extensive dynamic debug support. Enable it via t=
he
> >>> +kernel's dynamic debug control:
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +    echo "file drivers/accel/qda/* +p" > /sys/kernel/debug/dynamic_d=
ebug/control
> >>> +
> >>> +Testing
> >>> +=3D=3D=3D=3D=3D=3D=3D
> >>> +The QDA driver can be exercised using the ``fastrpc_test`` utility f=
rom the
> >>> +FastRPC userspace library. Run the test application:
> >>
> >> pointer
> >>
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +    fastrpc_test -d 3 -U 1 -t linux -a v68
> >>> +
> >>> +**Options**
> >>> +
> >>> +``-d domain``
> >>> +    Select the DSP domain to run on:
> >>> +
> >>> +    * ``0`` =E2=80=94 ADSP
> >>> +    * ``1`` =E2=80=94 MDSP
> >>> +    * ``2`` =E2=80=94 SDSP
> >>> +    * ``3`` =E2=80=94 CDSP *(default on targets with CDSP)*
> >>> +
> >>> +``-U unsigned_PD``
> >>> +    Select signed or unsigned protection domain:
> >>> +
> >>> +    * ``0`` =E2=80=94 signed PD
> >>> +    * ``1`` =E2=80=94 unsigned PD *(default)*
> >>> +
> >>> +``-t target``
> >>> +    Target platform: ``android`` or ``linux`` *(default: linux)*
> >>> +
> >>> +``-a arch_version``
> >>> +    DSP architecture version, e.g. ``v68``, ``v75`` *(default: v68)*
> >>>
> >>> --
> >>> 2.34.1
> >>>
> >>>
> >>
> >> --
> >> With best wishes
> >> Dmitry
>
