Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67641CA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C670C10E27C;
	Mon,  5 Oct 2026 16:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TsaGlRur";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F26310E27C
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 16:53:43 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34c4a0870d2so1349011eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 09:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791219222; cv=none;
 d=google.com; s=arc-20260327;
 b=dH7wLX0mGWtRJlsWF1lBGBeKMJMHkyfcH9rTDR/1d5OdxUlkVZo9ZIBKAzKB+8VJZN
 J+MHUKUIMhSZhkjeQ89rIrHpf1ZbDe3N25zoTizbzMlKifgPqq0hZAKyC8mqtMazN/3u
 BnLIxk0GhMSvBW1ByrF+sIu/IVZuv9dpPq9CwACc8rj97nidB1hCKVnoQk6gy/e9of4P
 oW5+4WWfl6lmvMeUu2JOEA01z9uSALMvFFfLJq/yhNjSmDu61TZa1PJeslUK69sThU0M
 B1Hg0RR6U5Am6HEzfae+M7q2dbYQz+5KXFws3S9N+z6NsOLurwU7QlGIHn+TrqLTwGrV
 HfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z0gmFEDsIHtz0UHp2ElZOBRyG9knCsE2/mBdJQGZCe8=;
 fh=4yN2+KAN3UtF5eFJySLIDdagASToP1GtMUvF3yGuFgI=;
 b=BwJzHf71rOT45DptjsTscNC7bstHIUoJVs3RWfaAK8LHTiLRpRZl4kqbcO4U+2wFcL
 oDubpriqNbjDxJDVbFIhixu0GxqA0/FJP6eda4NmjIwQGfCSyAwQ9aKRQazfatHM4C/F
 Fmy92H4R+HrURfMhgX1e34WIdPEE9Duv+ZINmeOzePQD1ZckoyZk9xWMJfsJZi9Xrlx7
 GunSe0e1u7kVsQC6n6r/KB6miOzWCqMj0se0+lJ5CPYbOYqziw8j2i2hePKcC/gV6I70
 NslmAQ/I7GJFeZsIfe9a78i+UGmTt7baMnpiB/caFNz3QlaJvVOxlJ1YhtgkFIw6uQBT
 yh4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791219222; x=1791824022; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z0gmFEDsIHtz0UHp2ElZOBRyG9knCsE2/mBdJQGZCe8=;
 b=TsaGlRurzCCxQ23uAh22OWTAzpk/DQk2lUzT4b6mO9r/9Hg/3lqLA/SBCJYvzHyIMY
 36wg4PjVxxwszCnukC+gm4uQKMXn0096Qj29AIolR0BD227Fy7O5sBUn7g6AH2VRQkkE
 XzSxSP8rdPqKGtu6VxDNAtZ7pZhpzeUChLl0DaJEzjzH74EhSzvqwHCOoh2y2ImUI09b
 WrLlebdknzXuyxPGWmYu0AKe4SPahncfpbh1ufHJpbvQaFCeF4Hh+6hyoTANRZ4gE7yP
 /MBhVxIr4quc12ezr7zspTsG1tp/uhGbpTU9KQBpiQqZZti3UYI6jE9xeKj9654hY9rP
 5ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219222; x=1791824022;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z0gmFEDsIHtz0UHp2ElZOBRyG9knCsE2/mBdJQGZCe8=;
 b=Z9k2szaKXCyF6qyJU5OWyDmJ/5PBgMZGsbV6I459mIvo50ku7vl08HABB/Tadr2M+B
 Ru2KhVPbCSBzHP+yf9tGQlr9KesSYXe5u85WQot6Z6PkNUHx2WQJ8bpvycj8dxIgITo+
 aweGQj+iV8EesEIgRjDoJoELt2ACmFkxAC6I8vQKqORYscs/dtTEKHxjCmlHBuo1FyTZ
 +bEcVl336i7j/XRz3Ckj7PSb2Urkisj/5FJEaj+BxbhxyiAaM5I2aGHIG6e9Cv7U8xpE
 W/F7CvXyIMjq2tKjwrqVKEnkp5jS+uySCaVXJ93kfekwQrc8W1MS0aR0rLUej6JVxU1P
 P6Vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFygoKd8ZuzySc/8WPWdLZQXOBFt3YVoMcgA8EGgggNR+YmKYwActVqwrKK2Xi/6+vvz1+ANUkY6A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m92f3MCh1ie+QtC+JuXJ+fQ8qIWDGCnJI+4KY1P63criw0H5aF
 0u6niwc3Is5LxzIMvB+iIhS9E4bJ3iuq0cnK3cKwuykSCZOms7Un3Hqe3ki75z53lERSow2Kuvr
 2ClxnWFVcdJEldNepO2ynAza96TJ07lA=
X-Gm-Gg: AYBFou2nZisVjRRyZptSLrZA0/MiafeNYX8m0C20u3woKwXohMJH5HTX5rkplB5WgMP
 yR6MR0rQQaAQpE3X8bhXk+YwcPJukvOvLNpLOl46KGaxjJjd2ydKfPO6iepSv031owy+qZ8IMsE
 HEPHpKnqpbQjr/VF8bBAzvrRNZBG5coHlSC9RRhbVUyks4A2an6xLKPWgJ8eIZxCyDmjvCRsNZq
 J0gSzSQVioXYpDSCmskMAmza9MabXLN+q6eRhxo7708kwjlMX8w9kJsHBYEAgsVPPgjvC0AGkRP
 hZhDLDRPG2/WUb+pVmIynwUTgvLUm1jq/eI9BBJDOU5FnsKy3/rCzu6QCqhx/8YsVPeBdr864Ms
 BMd6Et25yZR5p
X-Received: by 2002:a05:693c:8804:20b0:351:202c:c7a5 with SMTP id
 5a478bee46e88-351202cdc40mr6426669eec.0.1791219222183; Mon, 05 Oct 2026
 09:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20261004164121.193514-1-clamor95@gmail.com>
 <20261004164121.193514-2-clamor95@gmail.com>
 <asPQ5FgHe87XQJBT@aspen.lan>
In-Reply-To: <asPQ5FgHe87XQJBT@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 5 Oct 2026 19:53:30 +0300
X-Gm-Features: AclHuK80gf8oQpP3oXOiwBy9nGlcatk2lN-QYD_5rDpDvRkaMQwRh_t86WEgBCw
Message-ID: <CAPVz0n1-v-AcKg8O66q074N3gOZQD1Z6k6O+ae6yJS_-NvT6UQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: Document Skyworks AAT2870
To: Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
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

=D0=BF=D0=BD, 5 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:31=
 Daniel Thompson <danielt@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Oct 04, 2026 at 07:41:19PM +0300, Svyatoslav Ryhel wrote:
> > Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lightin=
g
> > Management Unit.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/leds/skyworks,aat2870.yaml       | 127 ++++++++++++++++++
> >  1 file changed, 127 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat=
2870.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/leds/skyworks,aat2870.ya=
ml b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
> > new file mode 100644
> > index 0000000000000..014678616076f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
> > @@ -0,0 +1,127 @@
> > [snip]
> > +  backlight:
> > +    $ref: /schemas/leds/backlight/common.yaml#
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: skyworks,aat2870-backlight
> > +
> > +      led-max-microamp:
> > +        minimum: 450
> > +        maximum: 27900
> > +        default: 450
> > +
> > +      max-brightness:
> > +        default: 255
>
> Should there be a min/max here as well?
>

Seems that you are correct. Thank you!

>
> Daniel.
