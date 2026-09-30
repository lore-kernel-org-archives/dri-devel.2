Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E1DCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EA810E281;
	Wed, 30 Sep 2026 13:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKkb30sc";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E813F10E281
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:11:03 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-34b223602d7so1383625eec.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790773863; cv=none;
 d=google.com; s=arc-20260327;
 b=gFEadeL4uYUP9H65qfLSGUtU96/Rr0yS9uvdbQj9nE2yJ8ncy3VY+e8dqlt0ifV1Hb
 /QkZ7hzu/3Lf/As49WDFxoS1NPR91ij2hwv1Q5OeDPNuj0Pz7opF7kdp6eoQ/KR4iAhh
 seny6qd8ioxgT89RAEH6KkmKQhSST3J/CvZnPeYlUj/Iqo7VUR6fM1TBZ4JE+lMkL2Rx
 InUD3QZCs786XyJq0I7XtZ1Ei1mQMaajubAOHAxFzxhoIOTSiuMr+s2LhmizjfkuJsMt
 7NOg0+ATqmkGKprFFZaSGlJ75CdtqSvwdC4+V4YFKaY7NIMwSUcDmBWWMA9jT+V/GqV4
 LL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LAcpYy8Y+KFMyBoefBiZVG5Vh10XWP5p2hVnta/lBBU=;
 fh=cL+TXu9RcDG2czwDICBrfusHTC7j9GrHXJJSoMhd6xI=;
 b=Cy5RKRClubBfmO+E9Bq9TkBDLeha0Ik7QoFZ1+AVZnGxSzjDUZJTplVF1UQ6AE7hHu
 CloNqbSFKDl9V+562ftLkhgf27fi9TsN4OxJ6ScKx8+dzr5FXjBv1VOGEjHjHoXpmEdC
 KMHy0R7thr4E440/IqDsrDbZ+D0lGYJvIJCAbsfaGrfo5FJNi32AxGXUyAPoxblqU57j
 K6iWBpK2DKingd57xHTS+iDP9kbQkg5HreUV2b0Mf9c3mTdi0Z+U5QjupRJjqz+WzSEO
 Nv+9YhLlGdJWYW9IM9Y3EL4oJ3Tz18pM/zufPAuc9xL3L4vZ9oHhtPSPEve8Kj+rBou9
 QJSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790773863; x=1791378663; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LAcpYy8Y+KFMyBoefBiZVG5Vh10XWP5p2hVnta/lBBU=;
 b=XKkb30sc4FWOisngOlKVQskLVxv46pyvFesQCLiGhf8py9PF2rmxjIsTiL7fNLPUfK
 zk2B6ZGbViNbh5+x/KsFmqTMJCW/ciehnlYqeQoE4c30XUuPSPB67fYV3AI0fLAa/RbO
 Pz5e7Q9lBaBNtJwLIvt9UgwOQisDL5BtxuoVmlERmzGs63qyfOjkCiBGL88bOaD/Kklb
 6PbLTnoY5YhyshdAUn8PovLGnRn3K1aSWQjOZ4P8DsxNT8js9HKE21e84mwzzVquvDZ2
 AWAuvMNV8KEQ88BVudgrzOxJGIu/DRJAlXvbVDx39Jolv0z4VNLvPq9uUPLItmPYL6Mz
 0UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790773863; x=1791378663;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LAcpYy8Y+KFMyBoefBiZVG5Vh10XWP5p2hVnta/lBBU=;
 b=JOl/s+mON8dTtqTxqpRfnPTe4gm54keftXkRwTcaPCEFlGRxkScQG1VjIS0zk3yNvG
 QovKDVv74UlpJpurQbSm63TVm7hcWmbonxbxSIVg/+liSj7DNSSGAcseA+YCGqAYsU43
 MWSTQm+GfwvyBcoMBZf1B6qcEmb4jd4xHE94u61Z6FuDv5aod1iCYoucbUEMuK8zCQvr
 sSXmPTxBZ4tsDgHY8QPGFu2bUKoeHNH8xBBX3GZvbaFqQuHmn85xCEjBTThJujv5Z88l
 KB+gDmFGF1YsLhr9W+/YTTL+Svtlp0D1KIXu80vzdNgcqLoTx7ckO1hskUUn1/669XZt
 3OBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2OrxoT+lscMxYZxENMa60Dw2vFcizX/o/P14Xneo/qJH5dNVU5fg7xmvKgLVOWtlEXnTIpCv8Chk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLP//x0QiJzWdwfQ7wKBRfN/FtkyxXP9sHN/EYgYA6UpZKzFP2k
 pXKDdDefGB0e1xcbAAzSBdelwjV7briRuMgT5XugHLchSix4NUbz3Ak6mEgoz/yiPYHLpI88tyQ
 wGt5O5Mzo1GLVJD7xWilFnxDsnY0iicg=
X-Gm-Gg: AYBFou0jt6DYx2sMhGns7ZSdV3JGmJyZnbsy2A6FKBx21yCbAKyXRue8Ok8rqEsbwRM
 C+trUgX4H9dqBJ1MZYpTM8I1a5sDcPyX6FFLwlLsdZfZYaS/Y1ZUwQ7x6pI2UKXh+v7sAJc31vB
 Rvwdk2fqWUjblaE1tkMzk9HfCxT1sKNYM0mAYO+u41Wsirbn2YhO0CwgyJf8j6HNRFjuONw5zCJ
 n9jcf5WqDjN7kQ1Jcfr1dRr9QDCUC01R3gFmf1dg2swZPKLJ0kayQ6QCIqjqYIimj7SEPBiHxhM
 7KMMODCx9YYkGWxPVDws1S23ZkfPpRXGlWs9luSh0TpZL3nQJ49Oq3JHGvQzqSlgEJmXLDx0/eX
 tAwLi+0oOW9Iz
X-Received: by 2002:a05:7301:4b06:b0:33c:16f1:2e11 with SMTP id
 5a478bee46e88-34cdb6ed6b1mr1708219eec.7.1790773862800; Wed, 30 Sep 2026
 06:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
 <CAPVz0n2F8LBqFs2bJERmgvdNYgtt1OEVtK3++CP9y0gxW7gCGA@mail.gmail.com>
 <arzn-TNbOlqXqQgd@orome>
 <CAPVz0n33c_uwfhsSguEfFfJ3FV=26SPtNTEpHes9f5RjnPDA_w@mail.gmail.com>
 <arz1wzEI_7e7ruKi@orome>
 <CAPVz0n12oiuc=5wjeNCuNtJpe-M7Ys=rHn0TOExc0qkweVQnuA@mail.gmail.com>
 <ar0HCfSKR9yr9Z44@orome>
In-Reply-To: <ar0HCfSKR9yr9Z44@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 16:10:50 +0300
X-Gm-Features: AclHuK9PDl69Sotr67TThU9DWzl51KL70LQ5tx9814AsWsSrWDYmjdY2XxCFv1M
Message-ID: <CAPVz0n26bPgAYjAdpqknPdMeQgYd=QEfZLX2VsACmkTQNJ581w@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 15:58 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 02:56:26PM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 14:46 =
Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Sep 30, 2026 at 01:56:40PM +0300, Svyatoslav Ryhel wrote:
> > > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13=
:50 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Wed, Sep 30, 2026 at 12:52:18PM +0300, Svyatoslav Ryhel wrote:
> > > > > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=
=BE 12:19 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > > >
> > > > > > > On Wednesday, September 30, 2026 4:05=E2=80=AFPM Svyatoslav R=
yhel wrote:
> > > > > > > > Document 8-bit CPU parallel MIPI DBI Type B interface provi=
ded by
> > > > > > > > Tegra20/30 SoCs display controller.
> > > > > > > >
> > > > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > > ---
> > > > > > > >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++=
++++++++++++
> > > > > > > >  1 file changed, 138 insertions(+)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/displ=
ay/tegra/nvidia,tegra-8bit-cpu.yaml
> > > > > > > >
> > > > > > > > diff --git a/Documentation/devicetree/bindings/display/tegr=
a/nvidia,tegra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/te=
gra/nvidia,tegra-8bit-cpu.yaml
> > > > > > > > new file mode 100644
> > > > > > > > index 0000000000000..f0dab608b2936
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidi=
a,tegra-8bit-cpu.yaml
> > > > > > > > @@ -0,0 +1,138 @@
> > > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > > +%YAML 1.2
> > > > > > > > +---
> > > > > > > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,te=
gra-8bit-cpu.yaml#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > > +
> > > > > > > > +description: The display controller in Tegra20/30 SoCs fea=
tures an
> > > > > > > > +  8-bit SPI interface that closely resembles the MIPI DBI =
Type B
> > > > > > > > +  protocol and is referred to as '8-bit CPU'. Each display=
 controller
> > > > > > > > +  provides two such interfaces, which can be used to send =
MIPI DCS
> > > > > > > > +  commands to initialize and control the panel while image=
 data is
> > > > > > > > +  transmitted via 16/18/24-line RGB.
> > > > > > > > +
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    const: nvidia,tegra-8bit-cpu
> > > > > > > > +
> > > > > > > > +  dc-gpios:
> > > > > > > > +    description: Data/command selection pin.
> > > > > > > > +    maxItems: 1
> > > > > > > > +
> > > > > > > > +  rw-gpios:
> > > > > > > > +    description: Read/write pin.
> > > > > > > > +    maxItems: 1
> > > > > > > > +
> > > > > > > > +  cs-gpios:
> > > > > > > > +    description: Chip select pin.
> > > > > > > > +    maxItems: 1
> > > > > > > > +
> > > > > > > > +  data-gpios:
> > > > > > > > +    description: Specifies a set of 8 gpio pins used to tr=
ansfer data.
> > > > > > > > +    minItems: 8
> > > > > > > > +    maxItems: 8
> > > > > > >
> > > > > > > Based on my admittedly brief research, according to the TRM t=
he display
> > > > > > > controller can drive all of these pins - of which there are t=
wo fixed
> > > > > > > sets as you mention - directly. So we'd need to describe whic=
h interface
> > > > > > > the display is connected to in DT, but not any GPIOs (which t=
hey really
> > > > > > > aren't).
> > > > > > >
> > > > > >
> > > > > > I am perfectly fine to not expose any gpios in the binding, if =
this is
> > > > > > preferred. Only question, which method of interface checking wo=
uld be
> > > > > > preferred. I assume if primary then nothing, if secondary - boo=
lean
> > > > > > prop "nvidia,secondary"? Feel free to share your vision.
> > > > >
> > > > > The driver currently uses the GPIOs to program DBI commands, so I
> > > > > suspect we do need some way of controlling those pins. Or is ther=
e a way
> > > > > to have the display controller program the pins and send commands=
? That
> > > > > would be much preferred because it would more accurately reflect =
the HW
> > > > > design and possibly also simplify the driver because it doesn't n=
eed to
> > > > > parse the GPIOs and then also not use the GPIO API to set the val=
ues.
> > > > >
> > > >
> > > > From what I know, GPIOs must be used and freed after use. Sets of
> > > > GPIOs are defined and remain fixed for primary and secondary
> > > > interface.
> > >
> > > So you're saying that we need the GPIO handling in the RGB/DBI driver=
 to
> > > prevent anyone else from using these GPIOs and potentially messing wi=
th
> > > the DBI communication?
> > >
> >
> > No, gpios are used for dbi communcation while their sfio versions are
> > used to transfer RGB data. So there is no risk in external
> > intereference.
> >
> > > It feels like there should be a better mechanism for that than requir=
ing
> > > the DC driver to request all the GPIOs. Maybe these should be exclude=
d
> > > from the range of valid GPIOs?
> > >
> >
> > NO! These gpios can be used for random purposes on devices with non-RGB=
 setups.
> >
> > > We can make sure that device tree isn't going to use these on a given
> > > platform, but there's still the risk of users grabbing them via sysfs=
 or
> > > the chardev API.
> > >
> >
> > Well, defining them in the schema as it is now and adding a note that
> > gpios specified in the binding cannot be re-used/shared may be a
> > solution. But overall it is impossible to reuse gpios dedicated for
> > dbi by hw design. They cannot be shared or used for other purposes if
> > dbi is used.
>
> My concern was that somebody might try to use these pins as GPIOs, in
> which case the GPIO and pin controllers are going to interoperate and
> reprogram the pin functions, potentially making the DBI interface
> malfunction.
>

If 8bit interface is in use these gpios cannot be used for anything
else. You can be sure of that.

> Or is there some other hardware mechanism to prevent this from
> happening?
>

yes, pins are physically linked to the panel

> Thierry
