Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33BFCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 15:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3782910E225;
	Wed, 20 May 2026 15:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="YezjP4vp";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A488A10E225
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:47:27 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-90ca6f20872so730392185a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779292046; cv=none;
 d=google.com; s=arc-20240605;
 b=VQq26eROI93R5+kgLA/6VbTeYhi4DnFBtKVXIYwRoNfJKoyTYQ4dupX0bebxhMS/PH
 unJVGX+a3xCDkSxVIGeNSMJ3tVBMqIr5qZhZXHukMDG7Hy5kuxugd8omPfmNnVlTDPYJ
 d+KC9dnbXPAMS1vzkhtLU3XjuBhDrDOLvml3hx4aOEUmG4y8qhBAtpTy+Y/o2OinDY3L
 vmi0XVKlT9Mw38qHEVPNem6vHL1FWuH2fbUhWMpD9RNSfeIldV3jS9yeVxnpBp1g3WW+
 KS/Zs+hzgPQTL/24Q3sdcK64RvVK9vGAOCxx2/NDABr8/NKGpmSQnRwokcQEGskXkaRd
 qKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I5uPOQqH/io7bW7wdgpurqth07a6Aq9sxwItrhNv9yI=;
 fh=5zz4nc/uyVNpDjnWQHKsQ/4HtFJCAOTqa/T82rMpsLE=;
 b=ffHoNJvViG73mGk4P18JJFZunuQK6d6Zy/cHvsx7154x79eUCtfP4KOa7o0xqUMSBL
 cG5uwWLeLPxqCxjXSNiTqZVR/h8jFB049j66rSk7+TdnZNOqx46JYCltgw655XMGYUSK
 eP+3Ffxs20fsn0BnQUm6w0e69OnNiYiV2gNNwJup+hEHP0RlKQNcfdWj3173890c0u/T
 /3LxtANC7giBf+rXrIcE8vn1Ywyg80w16fnlgNU+nWdUguAGd4qD9OmH3FklcdpG43ge
 BZiXwjyy4SiO93bwCvoHxw2GdCWq8lmP1JUUw+R6GREM1ciOu3vMjlQz3oBbDp6Hsl5d
 FBgA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1779292046;
 x=1779896846; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5uPOQqH/io7bW7wdgpurqth07a6Aq9sxwItrhNv9yI=;
 b=YezjP4vpAmqCqamwvqKv/QlrVWSxlqtiH4YQtHBqBzOr7Q/QUgOMpQws4BFuy1VDGl
 6LHdvpo0RR5w7CdguwA2M9EVVJoyAtGbdR4gFQ14UgtUWdj8YhCjZ8mhPbe71rwyhnpQ
 7itXOmRPR0EmtL143Nqz01Ok/aZeGdJIJ2MCPCO24q4WddgX0B3HsrDR92ooxy7kafjz
 qjvT9gd+fBI/O6I5Hie7JImEotGNUlTiePKfdWQLLrixkHGtGjo7AKvrlTUPiFk7/cbE
 r7qDw2nFE2R77gUb82q968mYeqM/GeCQ+zANNvRVQih7NdvqxLvijpccVR33gHeWNtKY
 HmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779292046; x=1779896846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I5uPOQqH/io7bW7wdgpurqth07a6Aq9sxwItrhNv9yI=;
 b=B0U+/KHbxD7IwJBtkFrBMYrgzZI/QQIdMPapSa9p/e/oU2eNGqBOfqBHwbNBpVCn2X
 8juN+d3CZuA/0q1ygz7q1h1gb6MgX7DVr79QfZcE0sE/YQa7Q3Y8uRT6LbPbPBG+ahLP
 JuJjhKw4DZCrP8i1VxDOhlArBSCXVyc8ZbX4QRsKkond8iOLzGEFL0pUm2IEZZNFcO99
 Wlda0uSMLdE1lSoFjfpz76nm8HLsSt32MX0/RIz5NN5xJ7LF5AF+jj06VWMPPdTOK+/E
 W14HyBX3ym9C9sel3j6901WZ250ohtGTPhICKzLic2UtARz35imGhI7y4XLEsPH9266q
 r53g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+A4CBFRaKtUVykw4cpXGcmnRXl1PPKd0KLNLnMQwRBLqXekHIgd4XaxQf9oNsIQlAtdVnCiFcG5q0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyORG5v1RJm8wnc+tbtb4g+Ng6/4Zk0O43nZ/ZPHamlzSXoZlnA
 6oYeVf7lC/vy6RHfDSwPFww3ROCatRWWUOWmMywrK40aArsakyGgp/ev10QsWpmjASnD+E6MtTh
 VqEmqU+GJYJtM1xUubJGxNogfeos5FV+0F+JRT2klFQ==
X-Gm-Gg: Acq92OEILez3SMXc+sIMaG0eMMxzbQzrZ3L6K23trydjZWKW+3rGwbzz5D1ErtnUNFT
 hk/yR9bpBsSIyoMR+8Bkec6Dd2CNRnChbRIIxhU3cOTxF7Jb7jG5EjcAIwK81UVNbXEGRw11UIY
 LTCrlJpJnIjGv49YQCoWBYl1ZlzSdwjl9v2NYud28gvqCgqPKaoE3GxiRknL84CljsA6djW3FqA
 fCxPpcKFiuzsXmN4pjc2BX6vdA5VW3+pFh4z3iI5XsqzQpUOfwEK3NsIIfkCEYHM69IdlbPrGTA
 /Z8yZG6m+O1llxBZYQ==
X-Received: by 2002:a05:620a:1d94:b0:911:fba0:6d02 with SMTP id
 af79cd13be357-914a0268c45mr5177385a.22.1779292045808; Wed, 20 May 2026
 08:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-2-b2d984c297f8@oss.qualcomm.com>
 <paiohsil5pmvm7cf6jxrhaj2225bgvlt3scrag4x6gbkyosow5@l4tbakbnxcvo>
In-Reply-To: <paiohsil5pmvm7cf6jxrhaj2225bgvlt3scrag4x6gbkyosow5@l4tbakbnxcvo>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 20 May 2026 17:47:14 +0200
X-Gm-Features: AVHnY4JWUX0pXGJu6GgwPpdJDM8Jh8t09gfswovnCTuU2k-U-QKXEr_LdCOWDYs
Message-ID: <CAPsqS2Tt0JbHhJLHBsbJ2YfZW913WNfoSXpSa+8TD1T9CV8V3g@mail.gmail.com>
Subject: Re: [PATCH 02/15] accel/qda: Add QDA driver documentation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: ekansh.gupta@oss.qualcomm.com, Oded Gabbay <ogabbay@kernel.org>, 
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

On Wed, May 20, 2026 at 4:12=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, May 19, 2026 at 11:45:52AM +0530, Ekansh Gupta via B4 Relay wrote=
:
> > From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >
> > Add documentation for the Qualcomm DSP Accelerator (QDA) driver under
> > Documentation/accel/qda/. The documentation covers the driver
> > architecture, GEM-based buffer management, IOMMU context bank
> > isolation, and the RPMsg transport layer.
> >
> > The user-space API section describes the DRM IOCTLs for session
> > management, GEM buffer allocation, and remote procedure invocation via
> > the FastRPC protocol, along with a typical application lifecycle
> > example. Sections for dynamic debug and basic testing are also
> > included.
> >
> > Wire the new documentation into the Compute Accelerators index at
> > Documentation/accel/index.rst.
> >
> > Assisted-by: Claude:claude-4-6-sonnet
> > Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > ---
> >  Documentation/accel/index.rst     |   1 +
> >  Documentation/accel/qda/index.rst |  13 ++++
> >  Documentation/accel/qda/qda.rst   | 146 ++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 160 insertions(+)
> >
> > diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.=
rst
> > index cbc7d4c3876a..5901ea7f784c 100644
> > --- a/Documentation/accel/index.rst
> > +++ b/Documentation/accel/index.rst
> > @@ -10,4 +10,5 @@ Compute Accelerators
> >     introduction
> >     amdxdna/index
> >     qaic/index
> > +   qda/index
> >     rocket/index
> > diff --git a/Documentation/accel/qda/index.rst b/Documentation/accel/qd=
a/index.rst
> > new file mode 100644
> > index 000000000000..013400cf9c25
> > --- /dev/null
> > +++ b/Documentation/accel/qda/index.rst
> > @@ -0,0 +1,13 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +accel/qda Qualcomm DSP Accelerator
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The QDA driver provides a DRM accel based interface for Qualcomm DSP o=
ffload.
> > +It uses the FastRPC protocol and integrates with DRM and GEM infrastru=
cture
> > +for device and buffer management.
> > +
> > +.. toctree::
> > +
> > +   qda
> > diff --git a/Documentation/accel/qda/qda.rst b/Documentation/accel/qda/=
qda.rst
> > new file mode 100644
> > index 000000000000..9f49af6e6acc
> > --- /dev/null
> > +++ b/Documentation/accel/qda/qda.rst
> > @@ -0,0 +1,146 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Qualcomm DSP Accelerator (QDA) Driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The QDA driver is a DRM accel driver for Qualcomm's DSPs. It provides =
a
> > +DRM accel based interface for Qualcomm DSP offload, supporting workloa=
ds
> > +such as AI inference, computer vision, audio processing, and sensor of=
fload
> > +on Qualcomm SoCs. It uses the FastRPC protocol and integrates with DRM=
 and
> > +GEM infrastructure for device and buffer management.
> > +
> > +Key Features
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +*   **DRM accel Interface**: Exposes a standard character device node
> > +    (e.g., ``/dev/accel/accel0``) via the DRM accel subsystem.
> > +*   **FastRPC Protocol**: Implements the FastRPC protocol for communic=
ation
> > +    between the application processor and the DSP.
> > +*   **GEM Buffer Management**: Uses the DRM GEM interface for buffer
> > +    allocation, lifecycle management, and DMA-BUF import/export.
> > +*   **IOMMU Isolation**: Uses IOMMU context banks to enforce memory is=
olation
> > +    between different DSP user sessions.
> > +*   **Modular Design**: Clean separation between the core DRM logic, t=
he
> > +    memory manager, and the RPMsg-based transport layer.
> > +
> > +Architecture
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The QDA driver consists of several functional blocks:
> > +
> > +1.  **Core Driver (``qda_drv``)**: Manages device registration, file o=
perations,
> > +    and DRM accel integration.
> > +2.  **Memory Manager (``qda_memory_manager``)**: A flexible memory man=
agement
> > +    layer that handles IOMMU context banks. It supports pluggable back=
ends
> > +    (such as DMA-coherent) to adapt to different SoC memory architectu=
res.
> > +3.  **GEM Subsystem**: Implements the DRM GEM interface for buffer man=
agement:
> > +
> > +    * **``qda_gem``**: Core GEM object management, including allocatio=
n, mmap
> > +      operations, and buffer lifecycle management.
> > +    * **``qda_prime``**: PRIME import functionality for DMA-BUF intero=
perability
> > +      with other kernel subsystems.
> > +
> > +4.  **Transport Layer (``qda_rpmsg``)**: Abstraction over the RPMsg fr=
amework
> > +    to handle low-level message passing with the DSP firmware.
> > +5.  **Compute Bus (``qda_compute_bus``)**: A custom virtual bus used t=
o
> > +    enumerate and manage the specific compute context banks defined in=
 the
> > +    device tree. The bus was introduced because IOMMU context banks (C=
Bs) are
> > +    synthetic constructs =E2=80=94 not real platform devices =E2=80=94=
 making a platform driver
> > +    an incorrect abstraction for them. The earlier platform-driver app=
roach also
> > +    had a race condition: device nodes were created before the RPMsg c=
hannel
> > +    resources were fully initialized, and because ``probe`` runs async=
hronously,
> > +    applications could open a CB device and attempt to start a session=
 before
> > +    the underlying transport was ready. The compute bus makes CB lifet=
ime
> > +    explicitly subordinate to the parent QDA device, closing that wind=
ow.
> > +6.  **FastRPC Core (``qda_fastrpc``)**: Implements the protocol logic =
for
> > +    marshalling arguments and handling remote invocations.
> > +
> > +User-Space API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The driver exposes a set of DRM-compliant IOCTLs:
> > +
> > +*   ``DRM_IOCTL_QDA_QUERY``: Query DSP type (e.g., "cdsp", "adsp")
> > +    and capabilities.
> > +*   ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE``: Initialize a new process =
context
> > +    on the DSP.
> > +*   ``DRM_IOCTL_QDA_REMOTE_INVOKE``: Submit a remote method invocation=
 (the
> > +    primary execution unit).
> > +*   ``DRM_IOCTL_QDA_GEM_CREATE``: Allocate a GEM buffer object for DSP=
 usage.
> > +*   ``DRM_IOCTL_QDA_GEM_MMAP_OFFSET``: Retrieve mmap offsets for memor=
y mapping.
> > +*   ``DRM_IOCTL_QDA_REMOTE_MAP`` / ``DRM_IOCTL_QDA_REMOTE_MUNMAP``: Ma=
p or unmap
> > +    buffers into the DSP's virtual address space. Each accepts a ``req=
uest``
> > +    field selecting between a legacy operation (``QDA_MAP_REQUEST_LEGA=
CY`` /
> > +    ``QDA_MUNMAP_REQUEST_LEGACY``) and an attribute-based operation
> > +    (``QDA_MAP_REQUEST_ATTR`` / ``QDA_MUNMAP_REQUEST_ATTR``).
>
> Explain, what happens in the users don't map the buffers into the DSP
> space. Will DRM_IOCTL_QDA_REMOTE_INVOKE handle the mapping or not? What
> is the difference between those two modes?
>
> Would the driver benefit from using GPUVM?
>
> > +
> > +Usage Example
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +A typical lifecycle for a user-space application:
> > +
> > +1.  **Discovery**: Open ``/dev/accel/accel*`` and use
> > +    ``DRM_IOCTL_QDA_QUERY`` to identify the DSP domain served by that
> > +    device node.
> > +2.  **Initialization**: Call ``DRM_IOCTL_QDA_REMOTE_SESSION_CREATE`` t=
o
> > +    establish a session and create a process context on the DSP.
> > +3.  **Memory**: Allocate buffers via ``DRM_IOCTL_QDA_GEM_CREATE`` or i=
mport
> > +    DMA-BUFs (PRIME fd) from other drivers using ``DRM_IOCTL_PRIME_FD_=
TO_HANDLE``.
> > +4.  **Execution**: Use ``DRM_IOCTL_QDA_REMOTE_INVOKE`` to pass argumen=
ts and
> > +    execute functions on the DSP.
> > +5.  **Cleanup**: Close file descriptors to automatically release resou=
rces and
> > +    detach the session.
>
> I'd have expected the description of the actual example. I.e. clone the
> app from https://the.addr, prepare clang >=3D NN.MM, QAIC (https://foo),
> run make, run the app, check the results. I'd remind that DRM Accel has
> a very specific requirement of having the working toolhain in the
> open-source.

We have been getting submissions lately that don't fulfill that
requirement so I will point to the precise part of the documentation
that explains it:

https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-usersp=
ace-requirements

For an example of a submissions that complies, see:

https://lore.kernel.org/dri-devel/20260114-thames-v2-0-e94a6636e050@tomeuvi=
zoso.net/

Most importantly, notice how the proposed Thames Mesa driver generates
machine code for all the hardware units, and doesn't use any blob for
that.

Regards,

Tomeu

> > +
> > +Internal Implementation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Memory Management
> > +-----------------
> > +The driver's memory manager creates virtual "IOMMU devices" that map t=
o
> > +hardware context banks. This allows the driver to manage multiple isol=
ated
> > +address spaces. The implementation uses a DMA-coherent backend to ensu=
re data consistency
> > +between the CPU and DSP without manual cache maintenance in most cases=
.
>
> GEM usage?
>
> > +
> > +Debugging
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +The driver includes extensive dynamic debug support. Enable it via the
> > +kernel's dynamic debug control:
> > +
> > +.. code-block:: bash
> > +
> > +    echo "file drivers/accel/qda/* +p" > /sys/kernel/debug/dynamic_deb=
ug/control
> > +
> > +Testing
> > +=3D=3D=3D=3D=3D=3D=3D
> > +The QDA driver can be exercised using the ``fastrpc_test`` utility fro=
m the
> > +FastRPC userspace library. Run the test application:
>
> pointer
>
> > +
> > +.. code-block:: bash
> > +
> > +    fastrpc_test -d 3 -U 1 -t linux -a v68
> > +
> > +**Options**
> > +
> > +``-d domain``
> > +    Select the DSP domain to run on:
> > +
> > +    * ``0`` =E2=80=94 ADSP
> > +    * ``1`` =E2=80=94 MDSP
> > +    * ``2`` =E2=80=94 SDSP
> > +    * ``3`` =E2=80=94 CDSP *(default on targets with CDSP)*
> > +
> > +``-U unsigned_PD``
> > +    Select signed or unsigned protection domain:
> > +
> > +    * ``0`` =E2=80=94 signed PD
> > +    * ``1`` =E2=80=94 unsigned PD *(default)*
> > +
> > +``-t target``
> > +    Target platform: ``android`` or ``linux`` *(default: linux)*
> > +
> > +``-a arch_version``
> > +    DSP architecture version, e.g. ``v68``, ``v75`` *(default: v68)*
> >
> > --
> > 2.34.1
> >
> >
>
> --
> With best wishes
> Dmitry
