Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AED0FEDA03
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF63E10E3C4;
	Tue, 17 Mar 2026 18:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nNBQb6wT";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0BE10E361
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 18:29:46 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5a12c19affeso297838e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 11:29:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773772184; cv=none;
 d=google.com; s=arc-20240605;
 b=RPIXFnoN1Pn0KYJi7PJDxpcwLzfv8d/pm4ABtJSefuw7ax7VaHeP9mnLFrukTu3Z8+
 oEAmPQa1p1XXCZnOdxsNlZLf9E6fyyrgzwaoPAPiUjJ0if+logJ2hbRZHJKs3DnnD6+o
 x3ORGnNXkeglR0UpCmE47VCNaHxt5pwGLs/lN4YUvaaJwQ042zasW9Drv21t/r4745qD
 Ef8azI+sGki50EyriWe3Ujrf5rOemyPsDbr7Xiw9YJbwxrWOMD3Dfvku9E6I/nPv5TCY
 Np/nThBc4Oob3Gk8zPaqkXyQRbDVozFBOEXeeTSsDG3eG9tBBt15SEbvLgBTsoFnT7d2
 L0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ReTvBCd8P9yyzfq3HfeJmsA/gm4KeOu6IvS40zFKzQ8=;
 fh=avESJORqq8HHF11NFmBZqbUzUlSDAyKb1fa9etfEXnE=;
 b=GlP6Yo91lnW4RFqaOfwHF2pNArPo6iphmrU3mo7MN3W1/h7NAkx6hlzUmCIHzN6hdA
 4wsTUlxw8WPNYbdJsk5/wac4rykeJVc+wkP+mECojHUd0veIaSpxbutxT67DixEFNUb/
 yG/6HiV1Qx3cq0xmnV14jMjYvCSlXGUt3LN+E6AEBeF8J2T+AQvtEN5L/bFwX66QGzkt
 3QjlMOzQM0SvzOFBNeaA/aJnramI7yu61907XGxX89hd/Yx2VzDnKLVtC2i7fZNS7Uxq
 Ky0jYHVXC5Ncl3fhHGFZ6iDWAz+hhluYr+P5AUDcJK0cNLMm8zJgLvIT9O1UBkiUbEZf
 LLzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773772184; x=1774376984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReTvBCd8P9yyzfq3HfeJmsA/gm4KeOu6IvS40zFKzQ8=;
 b=nNBQb6wTGZmHGlMZJvQnRyF4HVT2ySy5BL+jfOcjK2EQX/bEidIsRprONsF19FMxUv
 odkZeOCp4i0snoBEozYa84RU7guVIXh0givr7VwibcECN9AxeXsxRmg3v8MNIkinEZDR
 8JFVgTtn0z5OAXYPIjYwsaJXZ45oDqcpp/gk31de6M4k1rJxXZHS662eowuR3ekDfTgo
 mH+o3lk0vuLFSWigmnqVbqJRWkNWcYuPNBNLLH871ei2t7DD+2Wf/UJXUUWRq+xZvGtP
 3kop6V1DqKTHXWR7jy59vT6cR/IwoOpSnVCpwaKQYPXyMeSywhYh1rVWhM64tMAdHw2n
 bxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773772184; x=1774376984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ReTvBCd8P9yyzfq3HfeJmsA/gm4KeOu6IvS40zFKzQ8=;
 b=rMyLALU6W7wnW28nLRbs4HwvQxRRn13DbaCDHNZ4LAolRVJOB/de9Av81FzigSrgZt
 PzxqVJKeqwwaW0VJXL6zDqXoAxiocly4Nr9Syr7wTOMljIEEetCYiqx2tKS41FX3WSzi
 gdVNrV7I2em9lN2rBqhtflM0LA+2r3+207ZvKOTyNa3bkFdM7Cj43w6TiQcoOKjHiyR+
 q0faCjX4j2mRpsXBtTupZ1c8ToeN/ECAuDH2uaMVLd2qSkwi24GgDtzx9CFi5R5JsCpt
 ZxwbPchulti4RQn5OnO+r/S7FTe+NfUUxxGyBc+5Ve6xhEcdXdnXRUnc7695tdZpxfdT
 RfXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYlLv686VTpOSQFaPoAGEf5UHNji2KP8557QxlvphAI/X8vMm0I/kGBa1SN5Ovrai/65cpXwnTeDM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzACO4BNQzMGfMkHubVp+hg+H4pFsY7M0RrxlAbxbFBxUQcocV
 QCNcIQ9wLZiD7BU+aBf5rL07tJ79iXwc8ViIIFiJT/CU36m0oZUyJYB83TEU7p2zrR6oVKh06gK
 jdcvDDiAa7yllNMu6PJY557ZZg1WK9EY=
X-Gm-Gg: ATEYQzxpTNXEIP4LyDanto1+b/pEaMdYCXOZhADsYhaRH4hjUUOFarzoIKbrtdbq04w
 RrKYrV9yjBCehIKNTy3bbndi4zTLwIuRaSWdn2jL5lGT2Fv5XOuP0/qubAFppApWspjcxY2S0Lr
 VDP4K/6PGvYgWOmkdqayZXepPtpZOa/aM/VnSoetQRRZFwPPnJykZdsgbY7cofxqYGl/ag/qp+k
 0des/h3XDGx9ySXL5aTWiZqevAJPHm8pY1v+dO2UJSuNQOSMQac6eAQasZcQl/vUiva40aKwgPM
 /4nlecbp4LW3UDj42QxRKWOOQkmFwQReD0BYT2D/mE0mmaKsyFu5GpDbKfDvBZif/xJs
X-Received: by 2002:a05:6512:2313:b0:5a2:7901:a513 with SMTP id
 2adb3069b0e04-5a27901a7camr426839e87.7.1773772184154; Tue, 17 Mar 2026
 11:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-ch13726a-v2-0-28aa46bcd6d0@gmail.com>
 <20260317-ch13726a-v2-1-28aa46bcd6d0@gmail.com>
 <20260317-helpful-proficient-pronghorn-ef5e1f@quoll>
 <CALHNRZ-hvAY5EzLMb1To8+pdtE3GUCDZZu6SddoUd5dZxTjnVw@mail.gmail.com>
In-Reply-To: <CALHNRZ-hvAY5EzLMb1To8+pdtE3GUCDZZu6SddoUd5dZxTjnVw@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 17 Mar 2026 13:29:32 -0500
X-Gm-Features: AaiRm50HgqgjbuPX-50F3bbn8pQSL_8CmnvMBK9-YO7OK126DaYdRACviZGF9CY
Message-ID: <CALHNRZ_B+W6-OmBY5ZkfQyEfPDjhr5R+aDpTLm=byJuMduV0fQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add ChipWealth
 CH13726A AMOLED driver bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
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

On Tue, Mar 17, 2026 at 12:59=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com=
> wrote:
>
> On Tue, Mar 17, 2026 at 2:33=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On Tue, Mar 17, 2026 at 12:23:07AM -0500, Aaron Kling wrote:
> > > The Chip Wealth Technology CH13726A display driver is a single chip
> > > solution for AMOLED using MIPI-DSI. This is used for the AYN Thor bot=
tom
> > > panel.
> >
> > A nit, subject: drop second/last, redundant "bindings". The
> > "dt-bindings" prefix is already stating that these are bindings.
> > See also:
> > https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicet=
ree/bindings/submitting-patches.rst#L18
>
> Ack
>
> > Also drop all references to "display driver", even if you meant hardwar=
e
> > thing.  Driver in hardware is suitable only to motors, haptics and LEDs=
,
> > but not to displays. AMOLED driver is fine, display driver too confusin=
g.
>
> Per the data sheet [0], my understanding is that the ch13726 is a
> ddic, a display driver integrated circuit, which is a class of generic
> chip that gets bundled with multiple panels. This data sheet doesn't
> use the specific term ddic, but others I'm working on do and the term
> crept across for consistency. I can change the description to avoid
> confusion, Is 'AMOLED driver' enough to imply that this is a common
> chip supporting multiple panels?

Sorry, forgot to actually paste the link [0] in my last reply. Adding now.

> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  .../display/panel/chipwealth,ch13726a.yaml         | 66 ++++++++++++=
++++++++++
> > >  1 file changed, 66 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/chipweal=
th,ch13726a.yaml b/Documentation/devicetree/bindings/display/panel/chipweal=
th,ch13726a.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..b490c6757bb98c0752ded=
78b8fea3aaec853c7b2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/chipwealth,ch13=
726a.yaml
> > > @@ -0,0 +1,66 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/panel/chipwealth,ch13726a=
.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Chip Wealth Technology CH13726A display driver
> > > +
> > > +maintainers:
> > > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > > +
> > > +description:
> > > +  Chip Wealth Technology CH13726A is a single-chip solution
> > > +  for AMOLED connected using a MIPI-DSI video interface.
> > > +
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ayntec,thor-panel-bottom
> >
> > Why compatible is completely different than commit msg, description and
> > title are saying?
>
> See above for the general explanation. I don't know what the panel
> part number for this is, the only thing the odm described was the
> ddic. So I'm describing where the panel is used. There is precedence
> for this, for example rocktech,jh057n00900 containing
> gameforce,chi-panel. The downstream driver code I based on also
> supports displays from retroidpocket, so I'm also trying to leave a
> simple path for those to be added, should someone care to.
>
> > > +
> > > +  port: true
> >
> > This goes before reset-gpios
>
> Ack
>
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: DSI virtual channel
> > > +
> > > +  vdd-supply: true
> > > +  vddio-supply: true
> > > +  vdd1v2-supply: true
> > > +  avdd-supply: true
> > > +
> > > +  reset-gpios: true
> > > +
> >
> > Drop blank line here (it is port+reset-gpios+rotation in three lines).
>
> Ack
>
> >
> > > +  rotation: true
> > > +
> >
> > Best regards,
> > Krzysztof
> >
Aaron

[0] https://www.scribd.com/document/910879274/CH13726A-SPEC-V0-0
