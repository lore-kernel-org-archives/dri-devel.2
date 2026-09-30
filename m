Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8347CA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5048510E27D;
	Wed, 30 Sep 2026 16:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qp5qI6TF";
	dkim-atps=neutral
Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com
 [74.125.224.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33FB610E27D
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:26:33 +0000 (UTC)
Received: by mail-yx2-f41.google.com with SMTP id
 00721157ae682-8a860e532eeso52483377b3.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790785592; cv=none;
 d=google.com; s=arc-20260327;
 b=lyic0C+dg8ocuUQdDgTH+/mlVJNuk4V0ZVlWfdU38NtqKvUpp0qfBXeueYHvJ8amri
 mVZrjvdneXHrR9XAiSdoqUeuCwaaO7Vzz9Ei2143+ExEBY1AqaveKN4KwS4GLkUzKcj/
 0gYirZKDcIiJc/4TdsC9VZ4FpffikRkoeBBpelA+1MRTGAPDtIQuYF35+4yILqi0M4cD
 Nt9oM8u/esagGWlHBWInvDsl0rbV3wX2+bHxh1WMXmMZx9BLgLaRUCCcdoIgJ4xiuOT+
 g9QKhmbs/CcMafX55WUmQXAdHYDbOtG0NDy9uAyO/M4d7gywQeq58LVxMIIe9J3dhA0n
 ZmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IhetewjBy/ZOEbYKEMiflEbYSnDNrXKR9ujhYIYqZ9Q=;
 fh=TU2ZUI2zBzfCNtsezXnS5UvDCYYniDsgz10vVcR7qF4=;
 b=b2VdSzyOP31zgGhiSWts2Xxun1m1tNHIJRrTdgj4MclCw5kcjnGEVJPdBrp0wxGVhP
 cth34zXDEavhW7dlhIPKs7bgQyGt6Bc8xH5SWhpUUtmodbr0tj60/mjk8AoDVcE/WT2R
 zuYkjjOpP0IPpZ4EeVlZb2d6snz4wOVETBYomnAW6vQT6IGGDpzV70n95N+nIL4Lx9GG
 xcCHoHZ+eeXpiJaUNvbNWL3KKKQfLFEhXa9i6/I5WLTeG5ytcfE+qYOiE6Pr4pYGjyi5
 n/+qpg0pemIIzDGZQFnTYelnVx0StvPzB9ANfmR3silnwlbsCerKS7WY0KeKDZ30C79k
 qCoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790785592; x=1791390392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IhetewjBy/ZOEbYKEMiflEbYSnDNrXKR9ujhYIYqZ9Q=;
 b=Qp5qI6TFuzQ/NSuKAZn+PeKVWONFXCMGjHvymtZRM9Lx/4M8YFUUdXLfCf0vBVl+qj
 KSd8vs8V3kheCbBQnuo5am3ErG44tmYqpJ4KWy9dCHlrqm5VAmUaWLuWwM5CamiEduyH
 xMVYNQxkwWTAk7rNPoqgdHIKjTntzxcSniPB9Z7XC23XmarVY7fyoPx7x6Cwb8sFHjyC
 s1jNlzUt9kW/zWpFwqLCxQthDq6OQ+WclmQ9PwG7GjSzIK3DUCad5Jb+hhzIWTe5Sf71
 64vZW9QnTEZdirHh8fXLIaJPpDAnDoP6xvlLtiMQPHl57z3JbTwQSHi+Fxfhhh+dYG5Y
 ksCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790785592; x=1791390392;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IhetewjBy/ZOEbYKEMiflEbYSnDNrXKR9ujhYIYqZ9Q=;
 b=Qf/Rq792t7uAocYCoII3DhMaqLH/xus6uBDRZP/jxylVpN+mfHzZZvURehShrETRLQ
 eXAUOR4r6bR4AE6sD1gsRdcMBDODo4zfN8+kelchMJHL/kyUcraK4xMR5ELSpRyWK9+C
 CnI6hyKA5DiOF49+PGY24sOb4z52LPFf4RgHCwbREOAU+ORGxtlQTkJcOBPQeBGewzhl
 2NXrQOdUrL/jR+bzHHPwUeYbU99NFfZCrYBJ6LjyUg7TpDPZ674MTYe5U4zG4GYXZ0bU
 9k2j8Vd4+NmzFsE92VoM2/HNt3sMZ7z+BVi7YM7F8KW97px6Wtr7lrHQvHsmEQoCXNvX
 8BFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHvWGbVRTn8aY89XThUCepcK83HjBJqQoKKg2835E+dZi4Ml7Z7aZcvBMwYyjzNU4VGxOfcSfvxj4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJrts90ms41SyCBQnBvZsyKDPDbY9h1+m7BeICoIg7k/FtmxdD4
 A0wglPCyMv3C4JczvYF1YUaacz+C8ab9c3D/MruzU64y0N/wH4GBFseET35OB7V2IOxo95v3UiB
 CzI0Nz9BFc3cl03At0tsMrs5BE/92jkXkspEY2LMUWQ==
X-Gm-Gg: AYBFou0torY9I7wV6fjAGAVvcPsLCjiR6P6hIGZaZtyogLXMRv12Tkkc6dypJa+E6Zs
 1cYrv9ff5ML0zWHjI31RAQCmpPVAHBBwH/QJgEeb2UuDM7Dv6wH0MHhHUzivsM92C50l9PmyqYx
 8gvaMEGTqLCP3mcaA/x56TKhBN64fNI4H4phcQfY41ICM9IyYUqXQFn1sf2OjzNh9UsE3BpItbI
 kRYo+9AlocDrCdrKKb1kuM/CLj5VOTUUghjXUAFOX0T0HQoorD5QIRfTs61e0ETHiffScrJoJgV
 EDdbMcMSAEbBBbmdPIXq7qRqPCMvuTPhqASfQQu2wK/LTEf9GenSkvoMYNLnfV9P
X-Received: by 2002:a05:690c:e205:10b0:8a8:8945:c3ce with SMTP id
 00721157ae682-8ac92d31f55mr6394247b3.63.1790785591578; Wed, 30 Sep 2026
 09:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
 <20260727-spotted-winged-mantis-7aa1ce@quoll>
 <CAD++jLkX0m6_GJd4Pd1Ko4tghta4AXQ5ALZpLe_x-3xxqu1Cvw@mail.gmail.com>
 <668e83d0-a017-4f59-bc76-bf6c9a80b5ba@kernel.org>
 <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
In-Reply-To: <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 1 Oct 2026 00:26:19 +0800
X-Gm-Features: AclHuK8qxVxvhel2lglijF9Rc5ozZymwHXuo3kOm52fjKYrNUnWjF5DWZXE12Tg
Message-ID: <CABymUCP0Wk+wogyj=8CJJ5qrGtw6qe_FihB5vuSxBc1wVd37sA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics R63455 panel
 support
To: Linus Walleij <linusw@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
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

Linus Walleij <linusw@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=B8=89 15:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 29, 2026 at 3:35=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
>
> > This entire binding seems like stitching two devices together, which
> > might be fine (I don't even remember this stuff... two months old) or
> > might be artificial grouping of separate devices.
>
> I think that's a good point and fair pushback.
>
> Neil and Jun talk about it yesterday at XDC (1:15 into the stream):
> https://www.youtube.com/watch?v=3D6tNGW8PoSzw
>
> The current binding does not reflect the physical topology of the
> actual device, and the bindings need improvements. I have a feeling
> there is one display controller with two physical panels.

Sorry to confuse you. There are 2 r63455 DSI controllers for 2 physical
panels. This patch set aims to hide 2 set of DSI host/device and
associated backlight/power/reset handling in a single panel driver. So
that it is much simpler for DRM CRTC/connector and compositor to
handle 2 physical panels, just as they handle a single panel. No change
is expected at all.

>
> In that case I think it's better if we do:
>
> panel: panel@0 {
>     /* This is the two-panel package with one display controller */
>     compatible =3D "sharp,ls026b3sa06", "synaptics,r63455";
>     reg =3D <0>;
>     #address-cells =3D <1>;
>     #size-cells =3D <0>;
>
>     panel@0 {
>         reset-gpios =3D <&pm8550_gpios 3 GPIO_ACTIVE_HIGH>;
>         reg =3D <0>;
>          ....
>     };
>
>     panel@1 {
>         reset-gpios =3D <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
>         reg =3D <1>;
>         ....
>     };
>
> ...
> };
>
>
> Yours,
> Linus Walleij
