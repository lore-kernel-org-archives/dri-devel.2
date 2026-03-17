Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C34DFED9EF
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DECD10E19C;
	Tue, 17 Mar 2026 17:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HjazmWe/";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD17110E19C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:59:52 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-59dea72099eso7000472e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773770391; cv=none;
 d=google.com; s=arc-20240605;
 b=Ji2vwwLgedm38CSxwQjefSEj/KCfy0YrdyDpw2iUuUbWxDW0ROKwcPxJOz0hY9pnNf
 4tDhMEzIVuO2Xn5Iusjw3ilt8K7Xq424R6mqsnHtz++/0rD/Kp8zTiUiiiNtP0+ONnoA
 EL4B5cghooGkBffMi/DFtxvScZkmxxObqAqtyNa7P+k8hsBf8XJXVfWBz4rRqQRkn9e2
 8HKlTuSzlwOFfVp9Gx2FCo8tTXu3T3KLZ5K9YcbJqp/PAOj7p4qO8WfefcQ6Xtg7Ox/9
 bL84LGdkxdM3DqLRftbAOrkB7BFnZwQlNTeqZhtQRpis5ame9bHxAfbX5uQBAXookwAa
 WK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F+zYh4D1AhciUb2qWsGCZrd2hODwBQKfeuM+1T1I6Ts=;
 fh=7V9FbAKDdIvgF0zbQj5KGXZCEwUQIL1HodpOGbgCzp4=;
 b=Bx3IGqZoOtAVho+3Bh6pkrjVW8A+dvxrHwfU9ie5aEXCZx6PCe1STrulchfSWdx3hD
 NN/cV7hW2hn9lW/xSfRwmjgj/dFWb24jZ42CVQilsv4RYpZc3OQ+xDWaSZYf/zAqUIel
 lRM4Z872JFuKpytAAwGDCYo815DK5SRvSp/Mhzk2m0cPzbQdr93fN15YZUbMwXQ7C+BK
 JHdV9w914LDT85u2EQsplP+NJfMPB/+QFzYv4gTuoeoFmMgCxx/9APdQVRtcqYCgImlL
 3RkoQ80CsHq1xNjYOa1LMGeJORjEH69N7kdGpSRQrx9k2nv8ZmF5Z6NF8508eUVeLrZ9
 cMag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773770391; x=1774375191; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+zYh4D1AhciUb2qWsGCZrd2hODwBQKfeuM+1T1I6Ts=;
 b=HjazmWe/UPetknqC/QomHCweO5Vq0eWzYcjmywiuQGErJ4iTCTWfJpstMIyPI99jZA
 5bKPjgD9FrY0Wxe6cvBP2/DloDtHdPPaaXWZsHG0nJSpRt6oyqaf6OsExKXNB7AHprnV
 svdX/uSlpCQuJhDwKS19ND8yhXrC3vU8RAuwZflOROLm+4kHusssabY9MPN3qA41h7qi
 amhYYG0BWfwoGwabdFte5St9qUrDzpxATQFYq+EKYgzWrMIO0/G3pNWgaWLY0yl+kUvv
 sK5OWNlbOeiZThc/rWG37Xrd+kh6aVWZZP1QfcRvsfrhmETDp1/3CyXxTxoyGkVkjrSB
 neyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773770391; x=1774375191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F+zYh4D1AhciUb2qWsGCZrd2hODwBQKfeuM+1T1I6Ts=;
 b=WSHQhptoEr5Epa5yqpGtLvO7kemS7f6J2OdxQU4TcfKsWVfClkVwQBcEXk9DU6TOUk
 zHwKyLudr6V17MSnqEwCn49l5OY4DHLe+WuKpXgQ8FFlf0vLTevBCesaCvXxueUHDKNc
 nlHAyQ5UbdchgO7PPgk0nEf6T1lIR6WSmF7xnlnanOnkC+1MrrHUaNogFLtk1SKgQzVB
 DqQ2qiNE0rysDVkMHiWE4CKt0V1E32UeKJvBMxWmMRCpS2aiBlOgzJToT7f4dH5AqSE/
 8r8pEx4HCcDmRJcWJbdmu2A3a/oWgELgtavPdAXvO8FqYXMRGZBAhpn35GECLNybXgMN
 hiww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRwod+BMG+dxmKVV8VDOOED46yBjVfIhdnwK5/WlM/P07sxT7rPZQoZ/uW0PAgsDbfLW0gWlRkVAA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4jk35qaVO2FpGRcrNWwfhIcYBvemHzDB6gZDvcHJGOmXjQi2U
 IaHkhC1Ow/tDuoraDN7O+Gvg71PA8tJeOxgIkBcHM0Jv6qHO0k4Hnueo0BX8zxXlyl1606BsrG3
 hhJBWfgOHGzkUrSAzvlLOxOJy4FkQKt8=
X-Gm-Gg: ATEYQzzrrN41MPM4amiZdaSI0gcJxILUqjgA4zGv0tYD8oNc95bn2oLCpj4yRcwwCX8
 eW/ysr4f0oGKLzUUsmhzuBh+vEC5YdkEC9dk6Y9h+TnCSDIEGBJtABIc09Btklv9RQbXEKPxB6S
 P64ryae+Wobo4ZIhsJ3ZeauCvLedeAfkNFFAROntVyOsNNBJ8hOnQLDmCSivoVka7xaUxZ0KNSL
 ZLSw1XmF2jL8oNPSVX7FMdUt3QDHdFNWz/m2fAWu9b+7ikgL/lXykXFr/N/Yuau1J7dg4FtHTY8
 sAHDJyzv4VF47guZt8Uw0onjWIL9FHP09sNvQdTMNIqFH5mEjm3ARWwnQKDjXfjyPEYi
X-Received: by 2002:ac2:5308:0:b0:5a1:184a:9ed5 with SMTP id
 2adb3069b0e04-5a27957d8afmr139720e87.2.1773770390562; Tue, 17 Mar 2026
 10:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-ch13726a-v2-0-28aa46bcd6d0@gmail.com>
 <20260317-ch13726a-v2-1-28aa46bcd6d0@gmail.com>
 <20260317-helpful-proficient-pronghorn-ef5e1f@quoll>
In-Reply-To: <20260317-helpful-proficient-pronghorn-ef5e1f@quoll>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 17 Mar 2026 12:59:39 -0500
X-Gm-Features: AaiRm52DSjIDHjqtjh1jdGSgRBArLiGl3iFNb-9lQ_KTulb8xhu_BDo1QivMeo4
Message-ID: <CALHNRZ-hvAY5EzLMb1To8+pdtE3GUCDZZu6SddoUd5dZxTjnVw@mail.gmail.com>
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

On Tue, Mar 17, 2026 at 2:33=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Mar 17, 2026 at 12:23:07AM -0500, Aaron Kling wrote:
> > The Chip Wealth Technology CH13726A display driver is a single chip
> > solution for AMOLED using MIPI-DSI. This is used for the AYN Thor botto=
m
> > panel.
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetre=
e/bindings/submitting-patches.rst#L18

Ack

> Also drop all references to "display driver", even if you meant hardware
> thing.  Driver in hardware is suitable only to motors, haptics and LEDs,
> but not to displays. AMOLED driver is fine, display driver too confusing.

Per the data sheet [0], my understanding is that the ch13726 is a
ddic, a display driver integrated circuit, which is a class of generic
chip that gets bundled with multiple panels. This data sheet doesn't
use the specific term ddic, but others I'm working on do and the term
crept across for consistency. I can change the description to avoid
confusion, Is 'AMOLED driver' enough to imply that this is a common
chip supporting multiple panels?

> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  .../display/panel/chipwealth,ch13726a.yaml         | 66 ++++++++++++++=
++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/chipwealth=
,ch13726a.yaml b/Documentation/devicetree/bindings/display/panel/chipwealth=
,ch13726a.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..b490c6757bb98c0752ded78=
b8fea3aaec853c7b2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/chipwealth,ch1372=
6a.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/chipwealth,ch13726a.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Chip Wealth Technology CH13726A display driver
> > +
> > +maintainers:
> > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > +
> > +description:
> > +  Chip Wealth Technology CH13726A is a single-chip solution
> > +  for AMOLED connected using a MIPI-DSI video interface.
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: ayntec,thor-panel-bottom
>
> Why compatible is completely different than commit msg, description and
> title are saying?

See above for the general explanation. I don't know what the panel
part number for this is, the only thing the odm described was the
ddic. So I'm describing where the panel is used. There is precedence
for this, for example rocktech,jh057n00900 containing
gameforce,chi-panel. The downstream driver code I based on also
supports displays from retroidpocket, so I'm also trying to leave a
simple path for those to be added, should someone care to.

> > +
> > +  port: true
>
> This goes before reset-gpios

Ack

> > +  reg:
> > +    maxItems: 1
> > +    description: DSI virtual channel
> > +
> > +  vdd-supply: true
> > +  vddio-supply: true
> > +  vdd1v2-supply: true
> > +  avdd-supply: true
> > +
> > +  reset-gpios: true
> > +
>
> Drop blank line here (it is port+reset-gpios+rotation in three lines).

Ack

>
> > +  rotation: true
> > +
>
> Best regards,
> Krzysztof
>
Aaron
