Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9652FCA5FBE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CAB10E0D2;
	Wed, 30 Sep 2026 09:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kt1c5GKP";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D534010E0D2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:52:30 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34ca54bfc48so632786eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790761950; cv=none;
 d=google.com; s=arc-20260327;
 b=XchsBI9Mzyr19Wa0mGy7d+yf/AqA43hWdkPBzmY+xe9Vx25Bns+TF+EzM3QSVM7dmk
 bhssO95mYfHyloxRgYlvX/wvPocy9bMN/gjLuxeXTTwt+TeBbM7Vy0j/Wob9Tt19TUp4
 KNxnKs/wF/U90zRnyHhSXvW/20r2qL+E8GioS5kMrjrmLRwuU3TfG8m8gWmTVMGvUqvz
 PmTZ8qwA/bTeyZEG/dzn97uy0Xe08Hc1szIrpDRGtAAdV/4ToxX6/IkIPho0acIoGC+g
 8w2/Jc4j6cxXF8q+VhdiTLQkgFsnInmcrotmmEmLGq4nGZwJTqqUWL1e3qQ59l8K+8db
 EHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PRT+bVkpUAp+N5S99zEO9+WtEZoje0u1sUGfRr0LWg4=;
 fh=ArFq6KZdvLMIZ77FjKwK3xzsBRUsk1ZRmFwitlNrsZo=;
 b=OeXTFFQykEqx2c6SwrpTdwa1tk+CT3Ym7ZRbnJDptoen1eV3jqV32CTvC8NCHw4OO5
 jIQRTRxPc0dlF7ur/XpaJssFYzXoD7p2w3xDT0h7gQZ7i7q7M0SOClEmfSeDYeywrRTa
 LwT4CJ82sZdjiGGw+1GRcs7SwFT71k/7KYWeJ3LC4ZPNg1LG5z0y7ghiit48PMpf2e9B
 deGZYFtuVTlnH7BfG1jIiuPeY3TLJVBV3ybSV9Ev9L1sXRzbSa/V32BOUDq3D8sbKYqH
 bQsh6sjWvtRcbxvHyyIvZaCpn1x8Y/TEHWmAgrfltM7kRjOs1Tb77mrLBCKwyviwBtKz
 5Mfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790761950; x=1791366750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PRT+bVkpUAp+N5S99zEO9+WtEZoje0u1sUGfRr0LWg4=;
 b=kt1c5GKPhDB9uCWI/3GkU5KKi3TJ5KuVKsn2haxsUquhWq8YRSQZXSwS/SGBc2nmqk
 weczTzLPFzkb8iSNEcvnh+J1Wd7PZo8RsBnvy9Ae24YxGmZU2tKmtX+AAmflrlHnSuXm
 GoOzgE9pYCyTGekHu+Li4KqM4sWUhEdgGNuA1QvP3Fd/Khs8oW4MwLgTNxp0GCY5wDAj
 fO1eM2LcF8wBj6Oc58pLmHkMkNajRhsMYIs2oHi6v3wQ7+knC6oUlMBpOOr8M/WMNBs8
 GFV5+iiNT4zCRHNZpXCFS5/BcOuHCcAopN7YTTWrWRFg5SNwFK00aft9xt+RWO6M+XwW
 kBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790761950; x=1791366750;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PRT+bVkpUAp+N5S99zEO9+WtEZoje0u1sUGfRr0LWg4=;
 b=bUw574Qv0bkZQd53oaQQCHz1tu13vLL9olFXtknKAcsL7DW3bZ9Moqh4McZ154viK/
 FvUBFU/0dU71zqNigX9KN/UVViXWuOPtTVgN6+gUkp9Fi0pXJDZfkoa+gltBvwgino31
 jeioSk490gNDGaG6d7voY3jbkz1qFbDXsON59rmdbNaEctikvlm+MYRfz2v6RS7yaq+j
 /i0k4nbnOniUSjww3qxj5pOIAMC839YWvGhdziMbya8NbQe5L7Rzl1BcnlX5ixcWKi19
 7I/7KFcHJVW0pX47EEk86wnJOmbpm4OeWxfLyipdIpX2js0bWrK883s4ylSAUrfYzv34
 4Trw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuh9R06pRcMF73LWkui+SXH7GvYifbG6+wFBoMAXliaPjrnrhfqXihObsx8DkSWZ2tLBpcfLGcxME=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mmrFYeIpDewpQCApPPzk3wc/x/05j1EGLUw3EPniowZ5T4zk5+
 sE3Rn3HLO0QMnCz+vgSyJ9/XgqAxugwGTAtySLriY+03H3XUMQXEeYkjdfmiuoGaiHa4vVicG1H
 U7rUxh3t3iRYO0AscRi0ccPm72v5vbwc=
X-Gm-Gg: AYBFou13YCB7GaWneuRxXJJ1u7Sv24k3+OgHl6Icgjb4Wyr70Kl17bYuMtC4U9+/kyh
 FVqY4L8E0upNjRcVLqq9Wunbz6ILvNFuKRUXFOy9eXq0T9GKpUWfDy41eplL5nVDc0bu49WBKGj
 mgOq8ilb+sd9KkTFMmLfHeClmJfB2aLKDi5Am9kFlI9pNnyErUORVN2TL/Nch8a9AfA+Trt9feT
 qZIETjR+FQ84F8BzXvHm1DP32FSID3UF8xF6Mi3KcAKwyPvXQt71tPYnpqhlh+7Ewq/mVLw+J6+
 ePUmZ5nT1ZXSzMZ5tD2GYYoUar0DLRtbNEP8b8VlRMqO8O3Rk+qVSz1q/L7FVs0eFajepZLF677
 ydrRtZvBNfNz9
X-Received: by 2002:a05:7301:2624:b0:342:d7a0:2f40 with SMTP id
 5a478bee46e88-34cdbbd634cmr1436523eec.7.1790761949877; Wed, 30 Sep 2026
 02:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
In-Reply-To: <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 12:52:18 +0300
X-Gm-Features: AclHuK_PjMkrSZpZDbHZxmDO9H7m9qGOop4eAvIoUg-ZusCaq49UWziUnYzuIM8
Message-ID: <CAPVz0n2F8LBqFs2bJERmgvdNYgtt1OEVtK3++CP9y0gxW7gCGA@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:19 Mikk=
o Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wednesday, September 30, 2026 4:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > Tegra20/30 SoCs display controller.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvi=
dia,tegra-8bit-cpu.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,teg=
ra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,t=
egra-8bit-cpu.yaml
> > new file mode 100644
> > index 0000000000000..f0dab608b2936
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit=
-cpu.yaml
> > @@ -0,0 +1,138 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit-cpu=
.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description: The display controller in Tegra20/30 SoCs features an
> > +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> > +  protocol and is referred to as '8-bit CPU'. Each display controller
> > +  provides two such interfaces, which can be used to send MIPI DCS
> > +  commands to initialize and control the panel while image data is
> > +  transmitted via 16/18/24-line RGB.
> > +
> > +properties:
> > +  compatible:
> > +    const: nvidia,tegra-8bit-cpu
> > +
> > +  dc-gpios:
> > +    description: Data/command selection pin.
> > +    maxItems: 1
> > +
> > +  rw-gpios:
> > +    description: Read/write pin.
> > +    maxItems: 1
> > +
> > +  cs-gpios:
> > +    description: Chip select pin.
> > +    maxItems: 1
> > +
> > +  data-gpios:
> > +    description: Specifies a set of 8 gpio pins used to transfer data.
> > +    minItems: 8
> > +    maxItems: 8
>
> Based on my admittedly brief research, according to the TRM the display
> controller can drive all of these pins - of which there are two fixed
> sets as you mention - directly. So we'd need to describe which interface
> the display is connected to in DT, but not any GPIOs (which they really
> aren't).
>

I am perfectly fine to not expose any gpios in the binding, if this is
preferred. Only question, which method of interface checking would be
preferred. I assume if primary then nothing, if secondary - boolean
prop "nvidia,secondary"? Feel free to share your vision.

> > +
> > +  nvidia,init-sequence:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: Device specific set of values used in DC DISP_SPI_INI=
T_SEQ
> > +      registers.
> > +    minItems: 4
> > +    maxItems: 4
>
> And AIUI this is panel-specific DBI commands the display controller will
> transmit. So ideally the display driver should receive this data from
> the panel driver.
>

This is not panel driver data, but it is panel or maybe even more
interface itself specific. TRM has no clear method of generation of
this seq I am aware of. Maybe I have missed smth. These 4 entries
co-respond to DC_DISP_SPI_INIT_SEQ_DATA_A_0,
DC_DISP_SPI_INIT_SEQ_DATA_B_0, DC_DISP_SPI_INIT_SEQ_DATA_C_0 and
DC_DISP_SPI_INIT_SEQ_DATA_D_0 registers of DC. Maybe you have some
info to shed some light onto method of generation of this seq. Then it
could be simply removed from binding and calculated internally. Thank
you!

> Thank you
> Mikko
>
