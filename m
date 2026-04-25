Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FC1FF885E
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA2910E50C;
	Sun, 26 Apr 2026 06:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="Eeb0frCn";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A4310E04F
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 18:10:15 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-89f87257904so74383616d6.1
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777140614; cv=none;
 d=google.com; s=arc-20240605;
 b=AQaBueCwKPkBMTi07e7/XaHHjJxE2ogfBwlvcs8sceoRwe181xad+c8BvUfaTw2On9
 nnmgHhbIQgiaYYgz5A1XY2uw2jlsyR75XmA2dg8YVCNHEx9RNPvj1v3g0V24z+P5lP78
 dLD2xTv1k06U7r2CxBbezRfd5hnJuZ3hXhVeaXd1qXAVeFAR0xj5GohNHu3eVndZ83Wg
 +gC9jSCyUOWtUWsBbr3yD4jy4vyFOzby4AQZU00UAh2+KgrdBmRyG3T69edZ6mHOn9px
 XibyvCduesKCQ1JOhVG2QXVlMc8/BZiVox6OcczSQ1R+aU6rE562sRzMaa05XcETB8V+
 fhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HcPTXTJmSyH/IMfXTVMA724OkR4f1Jn719XgrTAy0hs=;
 fh=RDfbDT7gZ/PEQgROeKaFjvTImpyUx++uF8SA+/ab/VY=;
 b=UJ7v0XibHdOqeziTBO4KPYSmawi96xFUXQQqAhYCx8SeMxVP+xuqrugs42xVFyOYHN
 vB2AcMmd40rJMQ1fichhKplNrRc0bMirtJQfcTQT7uAch7i4N4UXe7EAbZCbzmSBwRaW
 04872lXKFlQ6ep2hps22hs6g/QS5odWZ8RstDqIWHQolPFi5FdL3aP/s7a2ASLAYa9F9
 cXzVjIiCk4HCu9Pa5gKC5zjK90Q5R507QAdW4Adl9HaHwCvwXfNcbi/PEobqYfpub/o+
 3XGq6LrHlYwHtEUqKjFlIojjObjQSfDtoFqt8jhnNo9Hhch9vidoHW7raa9GD+8tQn+W
 ETog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777140614; x=1777745414; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcPTXTJmSyH/IMfXTVMA724OkR4f1Jn719XgrTAy0hs=;
 b=Eeb0frCn2IXc4pcMhb9jXkKNU+M3SMzomLpn97lQQqDCoWM2A5iTdalF/9XoV6wKtK
 CaayEzN9CCkdO4229duR84x7Bo0wp4bAtARCIcnqubbC4xU0t+t5bA0nLTbTOldltccH
 OdTuxR+ymA8chV6JMMIQzZMIDywRHxoAO2dEgJOLTWEuxJrANQ+HEhrGcKuVawUm0tF4
 pKZJZCxa4MyaUjN2og3eKK5j2VqCXm+Ku5TELKmsCdUZEu1O+libCCL+w6/Kk/bCKB7c
 FF0x1W4J7/Gr40fuRQi38iSWQVlfxk0MmvBPlgjP7xjXuMe9CvDjKRK2a+epQaJWsarM
 U/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777140614; x=1777745414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HcPTXTJmSyH/IMfXTVMA724OkR4f1Jn719XgrTAy0hs=;
 b=VvkM9QwtxyHQZH5yPt0iU38LBetzMSmdDnZyIbTz79++SMKTshf0RxZJu1veUgIkm9
 sc0onzGR6FHl3u0Mu4Y79bJsX7yoTiEWz2aUp7EVslj4qijNMci18Ro0sOXRL0eMewhX
 1phwxsr70GAcKIH/xCWj+uqHcMQR3FaZW0U8rVoRgnzWJp1NBzX9zSsfUcpY69CD4/UF
 EiSEcNv+7ZF81u/jN2u1i/Ke2HqH0rDY9VEn1NRv2wNmrmXhp0pF8L+n9ijaSqs6/wCT
 NdluGd2wdjTyO5hvEzbGMTgCteWof2D74+kpblwtlH5/ohvs/ek40rUMRHXLViyawAHQ
 6vfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ly+KhxJYCKZUd/bCnlvyMz8P2+AS8L5EArVoZdihjYiYGJr1ua4pucK6edTwXj9pxb6hrP3s50No=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzueT0m698blnKgYw87TPtY8c3w1IwM8suE8rat8LDDmoqox3hf
 PU4ed+wLP3Z0DFZ/oltGmCgf0MbAtcN3TGYFVTRDY52vkdTsak/ENlUf6vfbPUQ1CnPAupoqSji
 AznBScd504RpamBLoe6yQzdCv2Xf8OlRvgoKLiuyJDg==
X-Gm-Gg: AeBDieu/HlisryrBlDzAXjp1Nc7zFK8qEy40tG6gEBqjPulu1Th/sI18qGcZqCD8XAq
 M6bki/pVnblyk1X4Cbj1qLj97pgDTKO5TElW96M2P0hAhdB5TSIFf3vNgEdU/UpEByZwsdl0zaK
 6IE+oB2ysEZpFTYdAgerRyyqyzuG1cfhiOpi4f5hVoW6Y9XuF7Sy438yxwA54hxoLbTh+3W1Uo8
 QIyiwGj5seQcZ6GcI4zezRHw9brqFjzuYjTm1x4bqFuY7R+EWdjJPBnLM0csv7fV47M52jFW2Ob
 PZW5bICnOk0E4YydHiOqe2+2KN9FtwXTjuuo7Zob8q+jzQbu2d66vgKk9xIT+lVzN1QMzL4oTG5
 ldgw5
X-Received: by 2002:a05:6214:e85:b0:8b1:f069:3f67 with SMTP id
 6a1803df08f44-8b1f069473cmr348052086d6.27.1777140614077; Sat, 25 Apr 2026
 11:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260425031011.2529364-1-dennis@ausil.us>
 <20260425031011.2529364-4-dennis@ausil.us>
 <20260425112844.GB2964234@killaraus.ideasonboard.com>
 <45evt7lkzuykoqsc2z27hsvm7fasmn6sr6gbjtdnme54jauehf@dmvon2o5emzd>
In-Reply-To: <45evt7lkzuykoqsc2z27hsvm7fasmn6sr6gbjtdnme54jauehf@dmvon2o5emzd>
From: Dennis Gilmore <dennis@ausil.us>
Date: Sat, 25 Apr 2026 13:10:02 -0500
X-Gm-Features: AQROBzChrS7gVlPnev2Qw5PvTHOSVj5tSgsWsZxHd0olXAmf20o-DIbcxoWnR-Y
Message-ID: <CAABkxwt1=n=CnrVfCcw+EHjqjfsLkp67POk451fV8Gqw4vdnQw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] drm/bridge: simple: Add the Lontium LT8711UXD
 DP-to-HDMI bridge
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:46:56 +0000
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

On Sat, Apr 25, 2026 at 9:24=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sat, Apr 25, 2026 at 02:28:44PM +0300, Laurent Pinchart wrote:
> > Hi Dennis,
> >
> > Thank you for the patch.
> >
> > On Fri, Apr 24, 2026 at 10:10:08PM -0500, Dennis Gilmore wrote:
> > > The Lontium LT8711UXD is a high performance two lane Type-C/DP1.4
> > > to HDMI2.0 converter, designed to connect a USB Type-C source or
> > > a DP1.4 source to an HDMI2.0 sink.
> >
> > As far as I can tell, the LT8711UXD has an I2C control interface.
> > Shouldn't it be an I2C device ?
>
> From the datasheet:
>
> The device is capable of automatic operation which is
> enabled by an integrated microprocessor that uses an
> embedded SPI flash for firmware storage. System control
> is also available through the use of a dedicated
> configuration I2C slave interface.
>
> My guess was that it can either be an I2C device or it can function as a
> simple platdev with no I2C controls. Please correct me if my
> understanding was wrong.
>
> But now looking at the schematics, it seems to be connected to I2C6.
> Which means that it should be desribed (and bound) as such.

Hi Dmitry and Laurent,

While the schematic shows that it can use I2C and has been wired up,
it also shows that both MODE_SEL and I2C_ADDR have unpopulated 10k
resistors; as a result, MODE_SEL is connected directly to GND, putting
the bridge in autonomous mode. I confirmed this by running `i2cdetect
-r -y 6`, with the only device on the bus being the HYM8563 RTC at
0x51. Without reworking the board, the device is not directly
controllable and just runs autonomously.

Dennis

> >
> > > Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm=
/bridge/simple-bridge.c
> > > index 8aa31ca3c72d..42c1f3d5ba0c 100644
> > > --- a/drivers/gpu/drm/bridge/simple-bridge.c
> > > +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> > > @@ -270,6 +270,11 @@ static const struct of_device_id simple_bridge_m=
atch[] =3D {
> > >             .data =3D &(const struct simple_bridge_info) {
> > >                     .connector_type =3D DRM_MODE_CONNECTOR_HDMIA,
> > >             },
> > > +   }, {
> > > +           .compatible =3D "lontium,lt8711uxd",
> > > +           .data =3D &(const struct simple_bridge_info) {
> > > +                   .connector_type =3D DRM_MODE_CONNECTOR_HDMIA,
> > > +           },
> > >     }, {
> > >             .compatible =3D "parade,ps185hdm",
> > >             .data =3D &(const struct simple_bridge_info) {
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
>
> --
> With best wishes
> Dmitry
