Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D1AF54AD7
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E271310E658;
	Tue, 24 Mar 2026 16:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="HBFheeye";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4B010E658
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:40:39 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8cbc593a67aso530833285a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370439; cv=none;
 d=google.com; s=arc-20240605;
 b=YnjT37HRTTnjd/ZLgZwRsskgX9qyxGdDsCui1XKJaLvxc6j623dzh6BhLhvKQFcIpu
 j4Q4fty23wk37A0sQKn7wj+vs3Jyugf/iySpwqwMTrIJY9nj3lr7piGTbT3x1OdfUraS
 7r5m6ReMFxk2eS73iHhMClMbDryLuAGpsEWYkXr/CJakNBWgJ5YWi3+GlVKQMS7kHtiV
 tn6FKuHVvapFkoSoU+7GRG51HLtSNXR1qhTKQOdY6w8a2j5INLUoJqoBFcaVZIDBdSS0
 OPaKLXZ2siP9BbRDZOdO7+fWm1qdy6tU+DPmxu5/XjGQG5jyD5MvLwsO9KTQRKTvrGcO
 Db+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gBMTqCLRvm3uqegKLoybGB22QvW/ii0uVVkQCijjJks=;
 fh=ir6LHLAT0V7rzWE1adlAHZi64bukNOsohdzeTy7vhJw=;
 b=X49fTpfBKFzxDC/Y2rX7SvDHtXf8MTi8kMDam2RvW4nnVsqIdHpFNFO5kt6nNj0vsy
 K578VXIiOh/VWelelvu7mRXJrVbfDxdJ5LJ0s11WzmM1DAetXUbMGbFOe/7HdlcVNV5n
 pIbETeLemeJ4f14SZRPlgy51E2rutd3lgi85yqdbCaz3DSCyIDeA5v2vwClxoy0o6M08
 QnktvBmDkKukBdhqYLPWyWaT3jF609v8E2lcqFld8WMXAhTlTs5oehlHYzjDslbODxT2
 WVugJ9NXSOQus8swAflYsPWcvofcJNn31lZRZjKMmtoXmgZzHBSykokFTdMVDgFxKCRl
 L/lA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1774370439;
 x=1774975239; darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gBMTqCLRvm3uqegKLoybGB22QvW/ii0uVVkQCijjJks=;
 b=HBFheeyen6ULQlpgp930cYG7L9M4Lwb+QT9Tuygz1UM2lL7giVO8a0ldO1l2gtEZRh
 M4yb5Z2elJZohHKFuqrMoGxQzkDGEfvqj67wlUsA73xYoZg2oL8/brsfLX/8Sny00u+u
 EdnTBmy8XmxAIvPoueDu6GOc9WCu8EtF1tgWblzPqj58g4LJl+M0Kxi9FXLIVKc9Qjpr
 ionoF2PEvvlnhf6nlDJHdlfTA36euaRNR3Q5OVRvYEUl4z9lfgy7MDoiUjjf6G4C5j3e
 aBjS+B5MRbMb/0DGcPIt/60/7yl331noEvZs978UFgeWGkKKcnOZguga6NutvxSTTIZc
 xi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774370439; x=1774975239;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBMTqCLRvm3uqegKLoybGB22QvW/ii0uVVkQCijjJks=;
 b=J6GEDISRTAgqo1SJHN9BOgye9kcqowld/iL541I5/c8gWj6Ie/Aecx21h2OC4w1UbC
 vPoxPa4rEQ3jDTTk83AJDwPly2D8o2l/CvghuEpE6GutFdF95W8o1Rj+RRFjO3Bf2oyC
 ZVB3/L3Q8fKN3o/2eOuMbGgjM+2W7xaztAHKrjj/Xyen6KcIZjJW8bwLKVMooQIZUDbN
 XECJXJqsh4mpmoILzIB6KWtrh5PkG7XcsG7Hi/QqCEoc59+vRWvFdynEsVRrjfUnijJd
 vAj5TV1EtKXHdGewI0rsXN7hBFXgCjZES/nYAz46SRYxk/NQerN/ir2AMFs2adbIWmYT
 vf4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUclIgBn7INdpD3cWZMAEs67TUyltJMClAz0+zKPmSinx3hrcFEPgl4+1PqpWQbgSvowS4srgVuf2s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1ODj2c3BoZAV+8m6vfWLzbVwPJXCUEznzzvpQkc0gekQKnvlv
 tAIlr0Wq32KJ+3BYGzHDgCCa4svnqj2yht3h5wApl4FHtcGm3vPd/85Psn9kWrJ9i+OkNDTeTzk
 OnT/tmmMXWWWcPqIVlnHZuZYrlJwX4HWEnkcK0gu9Lg==
X-Gm-Gg: ATEYQzzK8lzDD/vXQl59FvoD4b+k2zULmQdxDSDr+lTPJsvQbzJ4rJoVDD+ZlEJsGXf
 1tSQeWpzm6wchz84vfyX74I1ZOGFCFw3G2IxaH9HWXrUJOsPT76SklMElpcvX26/ckB1x+L6WAo
 3Lkrrz0YvxyKzbPArS7rRdr73GqygcxP2xJ5EFoxgYFrZ60TTD4Vhf/m02jLHyhIY9K1nkXiP3v
 HowZ4A+d9g2MGMdHRGJe3TK574kAzFKWCwW6NOCj307A21g9Rk+d5FNFnIzEIgm2DCPU+Yvlkwi
 TaXEzA==
X-Received: by 2002:a05:6214:4c88:b0:899:fd64:1b72 with SMTP id
 6a1803df08f44-89cc4a4b17bmr4992346d6.41.1774370438553; Tue, 24 Mar 2026
 09:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260306-neutron-v2-0-3019bd8c91ef@nxp.com>
 <CAAObsKDAzfib86rXqt9FjXV68yRkBzmijcyR+x=1MsPYd=MQWQ@mail.gmail.com>
 <PAXPR04MB9424214A1AA43BD0C36653E89448A@PAXPR04MB9424.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9424214A1AA43BD0C36653E89448A@PAXPR04MB9424.eurprd04.prod.outlook.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Tue, 24 Mar 2026 17:40:27 +0100
X-Gm-Features: AaiRm53CbFc93InqoWPuzM7Hgdphk6hKiv7txs_-MYRf2g9yYwU08oSWn-vL4r0
Message-ID: <CAPsqS2QXcgbi9_e4QmCn1Cgkr-bOVsY-E9qpZsFw3WYWWLugEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] accel: New driver for NXP's Neutron NPU
To: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Frank Li <frank.li@nxp.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 Jiwei Fu <jiwei.fu@nxp.com>, Forrest Shi <xuelin.shi@nxp.com>,
 Alexandru Iulian Taran <alexandru.taran@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: multipart/alternative; boundary="000000000000b0ab92064dc7cfe5"
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

--000000000000b0ab92064dc7cfe5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 1:12=E2=80=AFPM Ioana Ciocoi Radulescu <
ruxandra.radulescu@nxp.com> wrote:

> On Saturday, March 21, 2026 at 7:19 PM, Tomeu Vizoso wrote:
> >
> > Hi Ioana,
> >
> > Looks like the userspace portion of the driver is closed source
> > (libNeutronDriver.so)?
> >
> > https://github.com/nxp-imx/tflite-neutron-delegate/blob/lf-6.12.49_2.2
> > .0/CMakeLists.txt
>
> Hi Tomeu,
>
> Yes, it's closed for now. We do plan to publish the source code
> on github, but I believe that's still a few months away.
>

I think you may want to sync with your userspace team sooner rather than
later, so you can comply with this requirement:

https://docs.kernel.org/gpu/drm-uapi.html#open-source-userspace-requirement=
s

It could be good to also share firmware code with other firmware-mediated
NPU drivers if possible, or at least the part of the rpmsg protocol that
makes sense to share.

You can see my submission for the Thames driver for a link to the firmware
code.

I would be happy to help consolidate code between this category of drivers
if you want.

Regards,

Tomeu


> Thanks,
> Ioana
>
> >
> > Regards,
> >
> > Tomeu
> >
> > On Fri, Mar 6, 2026 at 2:27=E2=80=AFPM Ioana Ciocoi-Radulescu
> > <ruxandra.radulescu@nxp.com> wrote:
> > >
> > > Introduce a new accel driver for the Neutron Neural Processing Unit
> > > (NPU), along with associated dt-bindings and DTS node.
> > >
> > > The first patch extends the GEM DMA helper APIs to allow bidirectiona=
l
> > > mapping of non-coherent DMA buffers. While not part of the Neutron
> > > driver, it's a prerequisite allowing us to use the GEM DMA helper.
> > >
> > > Neutron is a Neural Processing Unit from NXP, providing machine
> > > learning (ML) acceleration for edge AI applications. Neutron is
> > > integrated on NXP SoCs such as the i.MX95.
> > >
> > > The NPU consists of the following:
> > > - RISC-V core running a proprietary firmware
> > > - One or more Neutron cores, representing the main computation
> > >   engine performing ML operations
> > > - Dedicated fast memory (TCM)
> > > - DMA engine that handles data transfers between DDR and TCM
> > >
> > > The firmware is closed source and distributed as a binary here [1].
> > >
> > > The Neutron software stack also contains a userspace library [1] and =
a
> > > LiteRT custom delegate [2] that allow integration with standard LiteR=
T
> > > tools.
> > >
> > > [1] https://github.com/nxp-upstream/neutron/tree/upstream
> > > [2] https://github.com/nxp-imx/tflite-neutron-delegate
> > >
> > > Signed-off-by: Ioana Ciocoi-Radulescu <ruxandra.radulescu@nxp.com>
> > > ---
> > > Changes in v2:
> > > - rebase on newer drm-misc-next
> > > - dt bindings: clock fixes and renames
> > > - update DTS to match new names
> > > - remove unnecessary fields from neutron_job structure
> > > - fix use of uninitialized variable
> > >
> > > - Link to v1:
> > > https://lore.kernel.org/r/20260226-neutron-v1-0-46eccb3bb50a@nxp.com
> > >
> > > ---
> > > Ioana Ciocoi-Radulescu (9):
> > >       drm/gem-dma: Add flag for bidirectional mapping of non-coherent
> GEM
> > DMA buffers
> > >       accel/neutron: Add documentation for NXP Neutron accelerator
> driver
> > >       dt-bindings: npu: Add NXP Neutron
> > >       accel/neutron: Add driver for NXP Neutron NPU
> > >       accel/neutron: Add GEM buffer object support
> > >       accel/neutron: Add mailbox support
> > >       accel/neutron: Add job submission IOCTL
> > >       accel/neutron: Add logging support
> > >       arm64: dts: imx95: Add Neutron node
> > >
> > >  Documentation/accel/index.rst                      |   1 +
> > >  Documentation/accel/neutron/index.rst              |  12 +
> > >  Documentation/accel/neutron/neutron.rst            | 131 ++++++++
> > >  .../devicetree/bindings/npu/nxp,imx95-neutron.yaml |  96 ++++++
> > >  MAINTAINERS                                        |  10 +
> > >  arch/arm64/boot/dts/freescale/imx95.dtsi           |  28 ++
> > >  drivers/accel/Kconfig                              |   1 +
> > >  drivers/accel/Makefile                             |   3 +-
> > >  drivers/accel/neutron/Kconfig                      |  16 +
> > >  drivers/accel/neutron/Makefile                     |  12 +
> > >  drivers/accel/neutron/neutron_debugfs.c            |  34 ++
> > >  drivers/accel/neutron/neutron_debugfs.h            |  15 +
> > >  drivers/accel/neutron/neutron_device.c             | 239 +++++++++++=
++
> > >  drivers/accel/neutron/neutron_device.h             | 155 +++++++++
> > >  drivers/accel/neutron/neutron_driver.c             | 262
> +++++++++++++++
> > >  drivers/accel/neutron/neutron_driver.h             |  16 +
> > >  drivers/accel/neutron/neutron_gem.c                | 116 +++++++
> > >  drivers/accel/neutron/neutron_gem.h                |  14 +
> > >  drivers/accel/neutron/neutron_job.c                | 372
> > +++++++++++++++++++++
> > >  drivers/accel/neutron/neutron_job.h                |  43 +++
> > >  drivers/accel/neutron/neutron_mailbox.c            |  47 +++
> > >  drivers/accel/neutron/neutron_mailbox.h            |  42 +++
> > >  drivers/gpu/drm/drm_gem_dma_helper.c               |   6 +-
> > >  include/drm/drm_gem_dma_helper.h                   |   3 +
> > >  include/uapi/drm/neutron_accel.h                   | 130 +++++++
> > >  25 files changed, 1801 insertions(+), 3 deletions(-)
> > > ---
> > > base-commit: 6716101ae42949e98ad4b9e71eeba08c055be410
> > > change-id: 20260226-neutron-c435e39d167f
> > >
> > > Best regards,
> > > --
> > > Ioana Ciocoi-Radulescu <ruxandra.radulescu@nxp.com>
> > >
>

--000000000000b0ab92064dc7cfe5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24, 2026 at 1:12=E2=80=AFPM Io=
ana Ciocoi Radulescu &lt;<a href=3D"mailto:ruxandra.radulescu@nxp.com">ruxa=
ndra.radulescu@nxp.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Saturday, March 21, 2026 at 7:19 PM, Tomeu Vizoso =
wrote:<br>
&gt; <br>
&gt; Hi Ioana,<br>
&gt; <br>
&gt; Looks like the userspace portion of the driver is closed source <br>
&gt; (libNeutronDriver.so)?<br>
&gt; <br>
&gt; <a href=3D"https://github.com/nxp-imx/tflite-neutron-delegate/blob/lf-=
6.12.49_2.2" rel=3D"noreferrer" target=3D"_blank">https://github.com/nxp-im=
x/tflite-neutron-delegate/blob/lf-6.12.49_2.2</a><br>
&gt; .0/CMakeLists.txt<br>
<br>
Hi Tomeu,<br>
<br>
Yes, it&#39;s closed for now. We do plan to publish the source code<br>
on github, but I believe that&#39;s still a few months away.<br>
</blockquote><div><br></div><div>I think you may want to sync with your use=
rspace team sooner rather than later, so you can comply with this requireme=
nt:</div><div><br></div><div><a href=3D"https://docs.kernel.org/gpu/drm-uap=
i.html#open-source-userspace-requirements">https://docs.kernel.org/gpu/drm-=
uapi.html#open-source-userspace-requirements</a></div><div><br></div><div>I=
t could be good to also share firmware code with other firmware-mediated NP=
U drivers if possible, or at least the part of the rpmsg protocol that make=
s sense to share.</div><div><br></div><div>You can see my submission for th=
e Thames driver for a link to the firmware code.</div><div><br></div><div>I=
 would be happy to help consolidate code between this category of drivers i=
f you want.</div><div><br></div><div>Regards,</div><div><br></div><div>Tome=
u</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
hanks,<br>
Ioana<br>
<br>
&gt; <br>
&gt; Regards,<br>
&gt; <br>
&gt; Tomeu<br>
&gt; <br>
&gt; On Fri, Mar 6, 2026 at 2:27=E2=80=AFPM Ioana Ciocoi-Radulescu<br>
&gt; &lt;<a href=3D"mailto:ruxandra.radulescu@nxp.com" target=3D"_blank">ru=
xandra.radulescu@nxp.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Introduce a new accel driver for the Neutron Neural Processing Un=
it<br>
&gt; &gt; (NPU), along with associated dt-bindings and DTS node.<br>
&gt; &gt;<br>
&gt; &gt; The first patch extends the GEM DMA helper APIs to allow bidirect=
ional<br>
&gt; &gt; mapping of non-coherent DMA buffers. While not part of the Neutro=
n<br>
&gt; &gt; driver, it&#39;s a prerequisite allowing us to use the GEM DMA he=
lper.<br>
&gt; &gt;<br>
&gt; &gt; Neutron is a Neural Processing Unit from NXP, providing machine<b=
r>
&gt; &gt; learning (ML) acceleration for edge AI applications. Neutron is<b=
r>
&gt; &gt; integrated on NXP SoCs such as the i.MX95.<br>
&gt; &gt;<br>
&gt; &gt; The NPU consists of the following:<br>
&gt; &gt; - RISC-V core running a proprietary firmware<br>
&gt; &gt; - One or more Neutron cores, representing the main computation<br=
>
&gt; &gt;=C2=A0 =C2=A0engine performing ML operations<br>
&gt; &gt; - Dedicated fast memory (TCM)<br>
&gt; &gt; - DMA engine that handles data transfers between DDR and TCM<br>
&gt; &gt;<br>
&gt; &gt; The firmware is closed source and distributed as a binary here [1=
].<br>
&gt; &gt;<br>
&gt; &gt; The Neutron software stack also contains a userspace library [1] =
and a<br>
&gt; &gt; LiteRT custom delegate [2] that allow integration with standard L=
iteRT<br>
&gt; &gt; tools.<br>
&gt; &gt;<br>
&gt; &gt; [1] <a href=3D"https://github.com/nxp-upstream/neutron/tree/upstr=
eam" rel=3D"noreferrer" target=3D"_blank">https://github.com/nxp-upstream/n=
eutron/tree/upstream</a><br>
&gt; &gt; [2] <a href=3D"https://github.com/nxp-imx/tflite-neutron-delegate=
" rel=3D"noreferrer" target=3D"_blank">https://github.com/nxp-imx/tflite-ne=
utron-delegate</a><br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Ioana Ciocoi-Radulescu &lt;<a href=3D"mailto:ruxan=
dra.radulescu@nxp.com" target=3D"_blank">ruxandra.radulescu@nxp.com</a>&gt;=
<br>
&gt; &gt; ---<br>
&gt; &gt; Changes in v2:<br>
&gt; &gt; - rebase on newer drm-misc-next<br>
&gt; &gt; - dt bindings: clock fixes and renames<br>
&gt; &gt; - update DTS to match new names<br>
&gt; &gt; - remove unnecessary fields from neutron_job structure<br>
&gt; &gt; - fix use of uninitialized variable<br>
&gt; &gt;<br>
&gt; &gt; - Link to v1:<br>
&gt; &gt; <a href=3D"https://lore.kernel.org/r/20260226-neutron-v1-0-46eccb=
3bb50a@nxp.com" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.or=
g/r/20260226-neutron-v1-0-46eccb3bb50a@nxp.com</a><br>
&gt; &gt;<br>
&gt; &gt; ---<br>
&gt; &gt; Ioana Ciocoi-Radulescu (9):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm/gem-dma: Add flag for bidirectional=
 mapping of non-coherent GEM<br>
&gt; DMA buffers<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0accel/neutron: Add documentation for NX=
P Neutron accelerator driver<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dt-bindings: npu: Add NXP Neutron<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0accel/neutron: Add driver for NXP Neutr=
on NPU<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0accel/neutron: Add GEM buffer object su=
pport<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0accel/neutron: Add mailbox support<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0accel/neutron: Add job submission IOCTL=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0accel/neutron: Add logging support<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0arm64: dts: imx95: Add Neutron node<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 Documentation/accel/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt; &gt;=C2=A0 Documentation/accel/neutron/index.rst=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +<br>
&gt; &gt;=C2=A0 Documentation/accel/neutron/neutron.rst=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 131 ++++++++<br>
&gt; &gt;=C2=A0 .../devicetree/bindings/npu/nxp,imx95-neutron.yaml |=C2=A0 =
96 ++++++<br>
&gt; &gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt; &gt;=C2=A0 arch/arm64/boot/dts/freescale/imx95.dtsi=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 28 ++<br>
&gt; &gt;=C2=A0 drivers/accel/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
&gt; &gt;=C2=A0 drivers/accel/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A03 +-<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 16 +<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_debugfs.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 34 ++<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_debugfs.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 15 +<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_device.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 239 +++++++++++++<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_device.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 155 +++++++++<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_driver.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 262 +++++++++++++++<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_driver.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_gem.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 116 +++++++<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_gem.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_job.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 372<br>
&gt; +++++++++++++++++++++<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_job.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 43 +++<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_mailbox.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 47 +++<br>
&gt; &gt;=C2=A0 drivers/accel/neutron/neutron_mailbox.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 42 +++<br>
&gt; &gt;=C2=A0 drivers/gpu/drm/drm_gem_dma_helper.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt; &gt;=C2=A0 include/drm/drm_gem_dma_helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt; &gt;=C2=A0 include/uapi/drm/neutron_accel.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 130 +++++++<br>
&gt; &gt;=C2=A0 25 files changed, 1801 insertions(+), 3 deletions(-)<br>
&gt; &gt; ---<br>
&gt; &gt; base-commit: 6716101ae42949e98ad4b9e71eeba08c055be410<br>
&gt; &gt; change-id: 20260226-neutron-c435e39d167f<br>
&gt; &gt;<br>
&gt; &gt; Best regards,<br>
&gt; &gt; --<br>
&gt; &gt; Ioana Ciocoi-Radulescu &lt;<a href=3D"mailto:ruxandra.radulescu@n=
xp.com" target=3D"_blank">ruxandra.radulescu@nxp.com</a>&gt;<br>
&gt; &gt;<br>
</blockquote></div></div>

--000000000000b0ab92064dc7cfe5--
