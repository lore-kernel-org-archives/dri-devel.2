Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0A4CC6B26
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CB510E4BC;
	Wed, 14 Oct 2026 07:13:34 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C0810E4BC
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:13:27 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c2dc8cb0decso68666066b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791962006; x=1792566806; darn=lists.freedesktop.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qjC7NwRckRsBLSkDSstLxhiqg8sLruOR8jtJeu7RHHA=;
 b=KbwncGNFQlvdKb2hmfDysYsiyo4RPszogyI5RtqfHRWcUbRf5kbcTIzLAty+sVAx3w
 DCt6Y5ux1AnrC0/oePz1nahVIJA22Im1zpyxczf3HMSjBpz4K+oHIcgMconmOscDO0be
 GsMN9yMnE80KA4vO6mlQfpUBf2gaYqqRxeeG7R9Pyv43xvheuniytUW858/pk/gUNib9
 O/eu1mhjB9puhDr8pCyYp6AxVgKkv8GtSfPT+fe9FI0LCnYeeDMtyBRoWfIvRlOu17Dd
 v3R/k4bK5ClDU8g3imi2M2wxSXVoO/GBJBcRnxpmZsw0ZqgTEjFq0X6NtNiBVKR4WF3h
 GySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791962006; x=1792566806;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qjC7NwRckRsBLSkDSstLxhiqg8sLruOR8jtJeu7RHHA=;
 b=sOSKPTiPrcX2PjFd58uLf3ed+yvn7LvmGstYuQX3EiJ/5nSgS0+9HMlt/VbYPKR8dk
 9nHnM/2KpFNpaSUoQ3qeU/CvFn5LmYk1OPcSgIvedkWVO7ge9Z/cSDyuzRGqXzL/nLBy
 H0ZtTxDzVahfFKEVDxwc0OXs0/cDAHru6VLa3lKjTceKvfbPiXc4rX5B8ulgyGLmloQp
 /X8WKxbDTsNtV1ieCK3zRpHaFo3kvnoFDoKQCoKrGatsyMObLYz6/hBdoWXsUTGNLNuq
 O8aH71HeX7iI7WDEiifMF69OG8jvky8ZKll2vaVOUPSlABO7O/uE3ie7TPMCIZQPBLAY
 KAlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBytyKXCMlTBwpVbPHWAO3RqnnEK1oPLXamtjjNRbNuI+Pj5Yi7595vYyndDJle36r01E+fYKAHQ8mE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJdEFF2o2rC+78ql7MEJod4DC1JaQlI7KX8hCWoTrznjiAacNWK
 XEjGaIXFuEWNtkWzWyhXeMhe2n70y3E60eE+gEfpVDu3IWJBpw+aoYKX8nGGr5H89eE=
X-Gm-Gg: AYBFou1PCDbd6s0D9gLl3+p9L2XiLhT5aB+Yj+3EbvB091BU1LYhvKVwAsp3UtOiYoS
 0ydLAQFxeyE7yQ366rzB7WfoXS+C0Ip5kP/tvqqf/W3EOGqBbKitgiQpG5hMVn0zGccEyniTlCe
 RdIX3MQvn7lhOczy2duamwqJMfJn9W1SRYVuyA8VcYBzWWsCNk9Zo0NgMOi7MinBbmXl+PXOW2J
 2Ji6V6lJxuw3zPXZBGZ5hNxuuNxw157oK5qIEf2YctnnaVA8xIH3qE2E/EvdhZJ8Yalcttl/EJc
 c1i6C57b6aK4ps/1SYe0U+mlf6c2AnXVhzPFavajb/Y315rhHk3ny+cOn/qDe/CVAfrAYb6W99L
 WFierULY7D9oCfBjAOkzeLa8fSKBJT7okSawGqTVH2mjZsiicr/kU8PPeJYqKdetr24kdd0nb/x
 TVROuUTLgoKfarhP1td0gxSqg3lLDYoucBgCPZnwZOz52tkLkMkY3Ew+ownXp61d9Uy5D5GFKEH
 Y9GpThoU879FJT8fC0ertgYKbpTytnVpgaXKksFYrM=
X-Received: by 2002:a17:907:3d0f:b0:c2e:40a0:7978 with SMTP id
 a640c23a62f3a-c31a9ff4c22mr1294994966b.9.1791962005877; 
 Wed, 14 Oct 2026 00:13:25 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c34adc25c89sm346173466b.45.2026.10.14.00.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 00:13:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 09:13:23 +0200
Message-Id: <DM4DIJZOLJC0.2KAZET8VYUDY0@fairphone.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add Samsung Galaxy Book2 Go
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Douglas Anderson"
 <dianders@chromium.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 <cros-qcom-dts-watchers@chromium.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>, "Jasper
 Korten" <jja2000@gmail.com>, "Federico Amedeo Izzo" <federico@izzo.pro>,
 "Luca Weiss" <luca@lucaweiss.eu>, "Hans de Goede"
 <johannes.goede@oss.qualcomm.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-3-7188e7ea7a15@fairphone.com>
 <fb634f17-de56-4f43-b139-3d040a35f019@oss.qualcomm.com>
 <DM3MSNLF42BV.1UV490PXB0C07@fairphone.com>
 <emdm463llmoi6vsv3zmfjddqrfaf2iubdnydsqye2n6ui56oae@frsvj6el3zvq>
In-Reply-To: <emdm463llmoi6vsv3zmfjddqrfaf2iubdnydsqye2n6ui56oae@frsvj6el3zvq>
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

On Wed Oct 14, 2026 at 3:28 AM CEST, Dmitry Baryshkov wrote:
> On Tue, Oct 13, 2026 at 12:17:05PM +0200, Luca Weiss wrote:
>> On Tue Oct 13, 2026 at 12:10 PM CEST, Konrad Dybcio wrote:
>> > On 10/12/26 8:11 PM, Luca Weiss wrote:
>> >> From: Jasper Korten <jja2000@gmail.com>
>> >
>> > [...]
>> >
>> >> Signed-off-by: Jasper Korten <jja2000@gmail.com>
>> >> Co-developed-by: Federico Amedeo Izzo <federico@izzo.pro>
>> >> Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
>> >> Co-developed-by: Luca Weiss <luca@lucaweiss.eu>
>> >> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
>> >> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> >
>> > Good to see the Lucas are in agreement ;)
>>=20
>> :)
>>=20
>> >
>> > [...]
>> >
>> >> +&usb_1 {
>> >> +	dr_mode =3D "host";
>> >
>> > Does OTG not "just work"?
>>=20
>> Is this a feature one would want on a laptop? On a phone for sure, but I
>> don't quite see the use case for the laptop to be a peripheral? But I
>> didn't try it, the USB basic setup was done by Jasper
>
> Why not? It's more or less the same set of usecases: USB gadget device
> (which can be a networking gadget, serial, etc).

I can give it a try!

>
>>=20
>> >
>> > I'm assuming there's no pmic-glink on this device?
>>=20
>> I'm not quite sure yet how the USB stuff works. For sure from
>> observation, USB-C only works when stuff was plugged-in at boot time
>> (UEFI?), and charger also only supplies any power (but not actually
>> charging) when plugged in at boot time.
>
> This means that something is not 100% correct, for example, missing EC
> support.

For sure some bits are missing. This laptop doesn't have an EC per-se,
it's got a "EMEC" - Emulated EC, where on Windows there's just a bunch
of drivers handling EC-like functionality.

So e.g. already for battery, we just talk with the sbs-battery directly.
I assume this will be the case for the other components on this laptop
as well.

Regards
Luca
