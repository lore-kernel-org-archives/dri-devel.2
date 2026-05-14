Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187FBCD37AC
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7071010E365;
	Thu, 14 May 2026 18:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sxq+hY1F";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F280110E365
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:21:10 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5a40b2bc96dso7959481e87.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778782869; cv=none;
 d=google.com; s=arc-20240605;
 b=Frsk196z5r6DRm393gb5Vbu2isXuqNvB9k1zjSdFMdInLtTMKKpcnpa5xObys1TJDq
 eBe9oUvkeb9JW4Ltu1NLZ1ULH2y+Uzqfwxo4PAx10qyq3o2ehefxJK3CjIpA8rYOHgbl
 LtvqAsf2wVTKhrry3pF96duprH062o7ycSavaEfb/atxUHSB988DTXy3ZJmdF0zr1UrQ
 t1jd5W7bO8QU5o2gPEJkaVbstL53N6crSXzsq5UDQ+IseCPkmos1rlpWIKAHSwwcwuEI
 GNbQuakL/cqwwYYg3HPJKSgSoSnSrs3PDkj5ugBT9oBq8PHfy1C3pWYT7CPcARLx3lNJ
 f5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9VzaPyNiCnG2bYdEp6C9uaWnOU2qbaQUwImHVjXg1wE=;
 fh=+FkbZlbBtytVDPhdkZUwrhWs3YN/heABm5bh+8ZSHJw=;
 b=dxf5rmeqtP1GbPUagZQL2CW+kXUqKPybPipFabAepO42u1r3jOYZL3YT6b5g/gmuqZ
 n9ZbeXICpOjzWiO9gJ73aebmFACkTWoThfWSt0A4+ug2yap/HiH5w+EI1eOe3CHiUrV9
 2m9lmzZbXy4x1Fl68y0ZY+CSLSFJw7i8DqPaB/7L6h8W6A63aJqCcoE5BymKMljzh5Pn
 cgvqoQz33dseK4eHUdj+3+cojo4HRJcHl0yEgKzDpEU2XXrHmAgZ4WfZ3ocFTxVbVeHS
 GeN/BnCEDke0pA+Eurf4VDk56R+DGi0pYpewrbwh52QcGQSh105fTJkqfDcAUiorKbox
 QVeA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778782869; x=1779387669; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9VzaPyNiCnG2bYdEp6C9uaWnOU2qbaQUwImHVjXg1wE=;
 b=sxq+hY1FRxtGBRsfLg3MXuQyA9Q/KT9nWtLRpXqZW+RuD//0wReVwTSrOI4KwZACpl
 wDyPodIH7LeM1MRjX5VwpwoOCC6YxmBilQ/V37N+11iWR9nmmeOvyV7BntHlRcrp5wUh
 XRxx8w29YO+vTQvIPl8VIrX5eAT9Wbt4qw6T3FyZ4I9RHPAe63RmXmPT//gf4N/Ofsbt
 AgDyC+4oQ1rImiUB9BOVKG3uSR9KPR3TzJZgKMbE7MayZzW0cJlE6eAU9bo6USOhMuE8
 uOtGD+g+GcL3ow9URUlkQ5NGHo1xquu5LyxJ27DWa70jHn5qo4sPU5E06xBiYh5DDw6v
 XE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778782869; x=1779387669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9VzaPyNiCnG2bYdEp6C9uaWnOU2qbaQUwImHVjXg1wE=;
 b=UtxS7JgeuswHwVffmDlzRgvQP8Lhl5+ZH+FlnCR3EDqFL2XJOduzB6qcRwYCxxO3Tb
 8bjfyGKPzooRlmjoMmbb/MJntuYEX+bGqZkCace60JW6AK1FD0eGmDg9P6q1xjYKNSND
 gGmlgx+WFEXk/ADjVDuBJXkpYtaP4hOy5WMW4fzvIavXDPlXzmqNsltkFbYh8f680pu8
 JLqn+tXSUzXU84qbbAMgXES8Q/ob0dVB9j4gXsAHuahNlx/ydHCi132i1O+wUVn3Z7jo
 OLtsPa0BfvK/L8nsFSTRVf81qeji/FaAfCRigCyfHQ77Ff6cpAsPQbhMkFN+vwz/kvBa
 gRxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ87NrGsdlMC97mwlpC63PGQRBHV9kOxrYGvi9/FXblVV053tOQDfBzHXLQiWmUlJvbtYbrlbEYa1Zg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtNLFIY0bdlN5VKM4LbWerVq1ByNjrAkk8ERsCvEIELFiwzzk5
 +Vu/JMtRsMgSDw7ir3TzkWVvXZDCSS/9TbVQ+f+KZAb1hBOYdoe7adUSNt9cKifgk/m93Y4m73j
 JbbYYGhXBgP1CMv7sx1+pBhcBpblBHk4=
X-Gm-Gg: Acq92OFIlW2JclAc4I6vUq3grnOd9kzJUrYLuyO5vupe248kLbqSWhlz8wqFNJv3pUe
 Xd7rjAVa6ybnli3v7D+Sij37jGKQ6cOqXSsnYWof7ZzrRH2tyAgHfiIAPaoAcmvmMFPYY6PR0fd
 3z3wL9+gcSc7ylUqtRJgaTJFk8zWNlpoXS3EKyU4Y3fandrSrDlRD2K08FyIkS43ZjjFqGXeBgT
 kOVf3dqdT6e2Mn4vh5Y56iXJ4zkHJaExKl8ypjcxC1DdVXjspJUcLmgNustaAy/DtzstQzzz+Yu
 bewoVJY+5lHr/9mDbDNJn71e5vVj08EY6Uaw8ev4BTx0AFaLMleHokjeGIC5zwAo4WkBnbgGsew
 w3Zs=
X-Received: by 2002:a05:6512:a8e:b0:5a8:d14c:a14d with SMTP id
 2adb3069b0e04-5aa0e612dd9mr62162e87.18.1778782868840; Thu, 14 May 2026
 11:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260514-icna35xx-v2-0-45acd1dfa566@gmail.com>
 <20260514-icna35xx-v2-1-45acd1dfa566@gmail.com>
 <20260514-ambush-salvation-ce6616190390@spud>
In-Reply-To: <20260514-ambush-salvation-ce6616190390@spud>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 14 May 2026 13:20:57 -0500
X-Gm-Features: AVHnY4LodS78wV4Pv4nIlOxmJkr0uXWhKDVmV5qztzmHBoRa8eR1jCxw_j852JA
Message-ID: <CALHNRZ8ukiSM2+uj+Qg6rVbUjjFeo88HQjLZsFHbHBs_GTy_1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Chipone ICNA 35xx
 OLED driver bindings
To: Conor Dooley <conor@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Thu, May 14, 2026 at 1:07=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, May 14, 2026 at 12:24:49PM -0500, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > The Chipone ICNA35xx series of DDICs are high refresh, low power
> > MIPI-DSI drivers for OLED panels. The icna3512 is used by the Ayn Odin =
2
> > Portal and the icna3520 is used by the Ayn Thor top panel and the Ayn
> > Odin 3.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  .../bindings/display/panel/chipone,icna35xx.yaml   | 79 ++++++++++++++=
++++++++
> >  1 file changed, 79 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/chipone,ic=
na35xx.yaml b/Documentation/devicetree/bindings/display/panel/chipone,icna3=
5xx.yaml
> > new file mode 100644
> > index 00000000000000..6464d8d0cf86d5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/chipone,icna35xx.=
yaml
>
> Filename matching a compatible please.

Does this require splitting / duplicating the files for each ddic, or
can one be arbitrarily picked and the other stay with it?

> > @@ -0,0 +1,79 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/chipone,icna35xx.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Chipone ICNA35xx display drivers
> > +
> > +maintainers:
> > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > +
> > +description:
> > +  The Chipone ICNA35xx are a series of DDICs connected
> > +  using a MIPI-DSI video interface.
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - ayaneo,pocketds-panel-top
> > +              - ayntec,odin2portal-panel
> > +          - const: chipone,icna3512
> > +
> > +      - items:
> > +          - enum:
> > +              - ayntec,odin3-panel
> > +              - ayntec,thor-panel-top
> > +          - const: chipone,icna3520
>
> Commit message should state why these ddics are not compatible with one
> another.

Ack. Short version: some of the mipi vendor commands don't match.

> Rest of this seems okay.
>
> pw-bot: changes-requested
>
> Thanks,
> Conor.

Aaron
