Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4A1CD3447
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 21:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC63C10E013;
	Sat,  9 May 2026 21:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GE01ClYN";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275FC10E013
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 21:51:39 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5a8891f0c51so2825363e87.1
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 14:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778363497; cv=none;
 d=google.com; s=arc-20240605;
 b=WAm4thR4a8du7tfpRKQrD5tR+H4Js1/FPr/iV9dP4wHdpWRdisygDo2hY/jyjpXeRk
 dYqBhrwk2ZHor3hMqjE+pnvW7EHEAwneFGna3uex8opPIjfDC2+sLUOpms06nGK7uTpE
 8UnFXJGKIj5KkdAvVyyglVB9Z4xKUjcdC2Bn3KcVWhKsouqatlETFdBEu3xO9mZmQY5a
 N3kHc+/DvQof1nUzfT5FpwongiPZOVSo44Ld/mTYpVsTDvaQh2hMJVsauSgNix3YVRJb
 4Uh2lSdZtmErrQLjV8IDDd/S29QJNphSifEb266tB3Gwi8sdzXlslmlVf7XB4/8atvAu
 6DKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pmoJ0zncVztoEGB5Fyotot3fMyh3LTsXg1G4a/N+lFk=;
 fh=YtpPKqYw6BSyB78oNCGNarBQVuDfoBJkg4D8YYLsZtk=;
 b=Mvp5trw6sJer5z7pXl42xX2UnIiYUo8qYiW+gaNDmZCBFWEQWIwqjz/5UDX+ugjhyl
 1/il5W2hUCgkAAmh1mqTlcuzgkwSL8mNFyyZ1TYdHtIbrXzlLa29P1KuA2/HXY+x2psA
 1+fUipsecAmp5GMWX7uj4Sk8ZvXOcdZBJW14Y5DRoOgFyeh1DgNVuVj5YaLNEOLCGp4i
 R7wH3I00zH+LDCgGDDiadHfa0pwfADf0F4hDY6ZI9PSI1D7LxL9wmNl537jZEzmwOgmV
 p258OcFUNkAn51+xZazGTtF0PoK5dWpcXVc5qq+/EX/CWRsahq6/YAG5ZvEPYKOItEuN
 TS2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778363497; x=1778968297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmoJ0zncVztoEGB5Fyotot3fMyh3LTsXg1G4a/N+lFk=;
 b=GE01ClYNbq4ef6KHBZLovB13qBTXvBTJgHawPzY+/1UeHl/MKyOSSJ7qetJH4AIZNG
 VTMEHYz3JcyAUbJua7k0aOc0dFKi1xAUdOgLscy3w3DdqRwEoM3O7T3XSEMqyQwfd+2v
 CT0XuhXy1SKp5KjvxwKy8jrr570YJi685v7OTR9v4AurMtdnpFgPoFPyzXv0IF6zZKDU
 /1rfCnf1TYcNiN/abtw+zW5t45elAJAmX0uai6p8n0Au5FhM/HyIwGZHfmnRcUSeM4F7
 N86+0BZzCt1JYpOFMEcMUrGQyhpWutWvefwWu2PJ/nNuBY7sC7QBdfJ2td284Dvlx1Xf
 Ql3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778363497; x=1778968297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pmoJ0zncVztoEGB5Fyotot3fMyh3LTsXg1G4a/N+lFk=;
 b=rvQHnnQY5+OulWKsA0o32pxayBVMveMHnp2AXluUni3bD/u6gWynGthHIf1HLUIV5X
 DWl6rBh2lo8Uov9YO1IUvcfi3BQGGvXWA9ocqDAxhAVmA3nJR9YPjJMCph42HdBBhyOk
 ZCJxo+8Dz2Wmra4UBfsAbMcw06wpD6P1Wl12pgap3YDH7jo8SVAQJyKarTYcIv45TjlA
 MuQtrUSzMDGAB8cCp2wLMpKzaimlXMDgZvD7w5RPdVw82CgAOuU2Imf4o49Nz3l4Ar0U
 v8QntSqg842uZON7biwZs59kIMRzR6MJ9ykMHWYzN+dEwVsJKYcqkiMPxUdORr7VUo0v
 lcMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NSn9m0gCFODG5B1BpmUy6TnO0sA0CDjUeUxVxdZRqmF3plkrvviDhLLptVGFXhoHbvxC+bT6L1k8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWj3y1Pb2Y9NVyVjzYlBk/jluOHA2xFLHUwkNuW13UCryLNksQ
 Ep/aGnB7BFvq43u8xXYoAhTFISIZUjsyXZLt9++ymntTSiGalN69dsFwMv/GSGBpxfZgRwc0gD3
 PS3FPWr2qols7AWk1VKgEBD6gbKi+yDY=
X-Gm-Gg: Acq92OEcaw7IEZG9Q5456Dh1kC18ZiMI52wvjlp9OO1X6gWYqP4kPhufj0VBjf+vKDa
 wzlPhhzJ6zGxkzflmL/ggyRHNbyKPHiYsPI7TjodllZfcp6mjy8Vf9WLKEHXdeLzhRAUlrAradg
 ODyS1DYpSQAfV5aAjFfsdLM9tz5D0m87JKNB5yCrGW4+k0SfXBDR9O9bXbQvSjXR8HXkL7/QzS4
 F2znGI9rUL8SCpSQV7fjx6KlM6a3SCpdJQo9H2wxF16XLHug9tLBSwXgCjSPu7htw6hu20PsaI0
 vvoOycy6r1tqv+NdRQNNDUoZptpvw4AbXx8wbMtLC0ZdJRZNi5LJtmUiPUjTBIHHzmAa
X-Received: by 2002:a05:6512:1293:b0:5a8:82f5:8d1e with SMTP id
 2adb3069b0e04-5a887ae6596mr6277755e87.17.1778363496893; Sat, 09 May 2026
 14:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260509-icna35xx-v1-0-688d3d4e10f9@gmail.com>
 <20260509-icna35xx-v1-1-688d3d4e10f9@gmail.com>
 <177836192983.1140170.1302751195131262657.robh@kernel.org>
In-Reply-To: <177836192983.1140170.1302751195131262657.robh@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sat, 9 May 2026 16:51:25 -0500
X-Gm-Features: AVHnY4I5YflKHkwlc2U_edUbwDTHpTOPyLPNatkDyf8Famn_WXTN3gmZWohLwUw
Message-ID: <CALHNRZ_NVnMBJ0+aBrc1MOtWz+NBX6vFahJcOWDmfW4A=iMhFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Chipone ICNA 35xx
 OLED driver bindings
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, 
 Jessica Zhang <jesszhan0024@gmail.com>, devicetree@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>
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

On Sat, May 9, 2026 at 4:25=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Sat, 09 May 2026 15:18:57 -0500, Aaron Kling wrote:
> > The Chipone ICNA35xx series of DDICs are high refresh, low power
> > MIPI-DSI drivers for OLED panels. The icna3512 is used by the Ayn Odin =
2
> > Portal and the icna3520 is used by the Ayn Thor top panel and the Ayn
> > Odin 3.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  .../bindings/display/panel/chipone,icna35xx.yaml   | 77 ++++++++++++++=
++++++++
> >  1 file changed, 77 insertions(+)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/display/panel/chipone,icna35xx.yaml:2=
8:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
>
> dtschema/dtc warnings/errors:
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/20260509-icna35=
xx-v1-1-688d3d4e10f9@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

Ack. Will wait a couple days before sending a fixed revision to see if
more review comments get made on the series.

Aaron
