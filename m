Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CD1CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A0CE10E244;
	Wed, 30 Sep 2026 10:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JXDuHapH";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5906010E244
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:42:30 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33c24422d4dso6129446eec.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790764950; cv=none;
 d=google.com; s=arc-20260327;
 b=HULSiAXBf2LS5a5XzKpRsWroZqIKWL8joAPwLBhRQfTwNg3oY/AHhjf3HmIQV1Z6W6
 WrNMdKAdyzx00h2g8JUhlUZ3QbfFZd4BuUaQJagmS/yaFM+vx+PCdIGcP/HVAH0HQrGy
 NaLHqfx4G+kbIJUDglMPWIuOUflsXr4Tg5sSt9z//UiWInY96/m6r4PEyGuMHNyDzOGS
 1FE6wwksmEAGsiLsaBnxjpMVfOsuHKK/E+l32XwKexPV1LRTS+h/WAjP7+TCKMCY5i+a
 yf3nxhdPlTuLEDKpv/HVGDV2F0nWemfjvGAaxJhYtsReVWdtRj5+iwgErfVhw5S7K8LZ
 zj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BJzAgwbp6neWrPgsw3mH4T/Yci4Kta5JlaoTPrqtAW8=;
 fh=LhAoIDqBXYUipcUskuVzYw5Qwp6Rex76lwgUTUwi3Mc=;
 b=LsmhF8hjMhrvzYIbHEjOmqH4dDw6EJ5Y194RNpM3WL1mJu+E598TDgwb3k80mUAOaA
 AkuY9nK/jmOwGZUlVcEe9Thl2jqZ81YpLCMSQnnO5/fiCkDnSYqnIYuaZVMo9UimG2Gk
 c6pvi85N+KYlKAXZiFlKFtONWWPoVKnVUZZi9U0J5dqxmica5EfCepuIQucxIgzrTVF5
 oVUhn4ZZXYDmMpy2j02EXtSOm93k3We2wzsgKbuh+y+vx5sgSb0L5n54cfmiXMFQGitO
 iavsLRMzs/YfkIWVQccvBtAZA10VIlCOasn4zsHurDOzvopCvqCG1Wm166xHgPaQoWSO
 clgQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790764950; x=1791369750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BJzAgwbp6neWrPgsw3mH4T/Yci4Kta5JlaoTPrqtAW8=;
 b=JXDuHapH5cql4kIvN0za2TBfiJw0caCovjvTgoGUa4wuNLm7bVNVoGIKfVD+3Z0ZzF
 embu8OwMKZ7/cDU9TCrj2lpt5mMb2RTyWo5HJvymSeJWWgu8y8w4/B2BZbZ91OS8WXxc
 DfhRf3ICvUh3V65hO+8WjNYMc9tPbVnblZFEcMB8wtQ1RenkL97QQcFdYVD9+7gIFDwZ
 Q6Eu/BS1dgHpMYGjSLwzxLR7Dlp7/4LF7ADt3rBVcO469d8NYhi/X7Kln7pYjq+0HjlQ
 c2MuJZlGb8LbmtFZrKHE1VPpQ5bjKz3KfucwmC79R15MrhYGxt3IQIwMOr0V8E+kiW8N
 hxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790764950; x=1791369750;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BJzAgwbp6neWrPgsw3mH4T/Yci4Kta5JlaoTPrqtAW8=;
 b=gUTwGVQrVjWEQboGewj4RpAkN3JAssulr/E5b7sT1Bijb3ifblT/g5N9KYqJPlWd+v
 6X5G8qLyQH3WJoaZUCmdyVfV+SiEad+yvZY5SKmy7vvSn8XArz5VPxcCpIudXVI7Ttuj
 DIvaomjghQVZt8bO5FLKdWj11Q9C3N+Y2aY+74Tzzef+BjcIxQGHPL7I5NLnlO21vVSm
 IuMLbvQzvWhP31E8YdpUbdyHuFg52ZvipUKm7lL5wFV4Mb1TLjP+XaLUB08mqjesYz0G
 KcwoXwXGVe7fvh5PmvZqvSIGpQJzZhJu2ZYy3ASUnAsimPjNND3HljbEgxlpxBng6mdk
 unTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlSrTj4WRdfN14cs58NEuZtGdermiVMf6OpuPjuq073ORaa5k/wBfkVi6jjp70zgOhQhskBhw2OCw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK+rODE+hgruL70PRWbf47wm2tgD3TggCuL11jTMnDEKt6/xd8Z
 mYTowQMnMdwG5HVzspQ2+MJgoKIloMSVhRPKUZyj2UlgWInCAkn9ieopgff+TN/nN0NiQXEASIA
 lqCrJWpke2zdxGKZ6fHhZ326BQIeQmwM=
X-Gm-Gg: AYBFou1W66hnSkSB7cQc2QQYVsNNTSuN2nNSJWmBdDBTgImlYZk9V/GCNjycXcJpVTE
 ymXysuGzDnhtO46ox8v0L+Yo99hdnXS2zyKEpyz9/oFO8WECg6vd2wTT51IW4ut5iiUZFSUzkG5
 Ma33naA4+fW572x9XhD4uT2XdfhpBJJesCtpF42eoPk87r4FJ8WyLMW6vQTXQUd0imZqNMDzMU+
 1mOMeLlGtSRba67zmArDtqNWSy9zEEHrU9ag+rNScZz4YDfbg4ctpukUs8lHIDQnId8V1kURJhA
 Y1BSoxau03tc6FkHSe9IP7q89201aXE5K593W9faUlUQ4Y9F0+bi7NkvwGc1UNGmKq0rF0rE4D3
 ZVBAnFjnHkk3OGA==
X-Received: by 2002:a05:7300:2a95:b0:34b:e2cf:43b6 with SMTP id
 5a478bee46e88-34cdd0a96f7mr1217151eec.2.1790764949439; Wed, 30 Sep 2026
 03:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <arzMF0wjcF_SVxpE@orome>
 <CAPVz0n3Oc4ocUWrtGgd-MdrdJ3SgDEi8onOkXi92o7hAn3y0Ww@mail.gmail.com>
 <arzlR8mCg9d_z62L@orome>
In-Reply-To: <arzlR8mCg9d_z62L@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 13:42:17 +0300
X-Gm-Features: AclHuK-DuyyAs9z6BpVs9PR86an08DuP-rLMFIX2UP_bIS5QjiwEsXp1jDjGZck
Message-ID: <CAPVz0n0jnitNemUyhi9C2SgbRbJA9CinY1DrR-r7gnN=CaYGiQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:34 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 12:00:21PM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 11:47 =
Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Sep 30, 2026 at 10:05:32AM +0300, Svyatoslav Ryhel wrote:
> > > > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > > > Tegra20/30 SoCs display controller.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++=
++++
> > > >  1 file changed, 138 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/tegra=
/nvidia,tegra-8bit-cpu.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia=
,tegra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvid=
ia,tegra-8bit-cpu.yaml
> > > > new file mode 100644
> > > > index 0000000000000..f0dab608b2936
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-=
8bit-cpu.yaml
> > > > @@ -0,0 +1,138 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit=
-cpu.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > > > +
> > > > +maintainers:
> > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > +
> > > > +description: The display controller in Tegra20/30 SoCs features an
> > > > +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> > > > +  protocol and is referred to as '8-bit CPU'. Each display control=
ler
> > > > +  provides two such interfaces, which can be used to send MIPI DCS
> > > > +  commands to initialize and control the panel while image data is
> > > > +  transmitted via 16/18/24-line RGB.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: nvidia,tegra-8bit-cpu
> > >
> > > The description says that this is a feature of the display controller=
,
> > > so adding a new binding and compatible string for this is not the rig=
ht
> > > move. This is all covered by the "nvidia,tegra{20,30}-dc" already, ju=
st
> > > need to extend that with whatever is new.
> > >
> >
> > How would you model it? I have tried to model 8bit-cpu as a bridge, sim=
ilar
> > to how DSI bridges are modeled. This reflects interface used to link RG=
B and
> > panel, without inflating existing DC binding. If you have any ideas in =
modelling
> > this, I am open to any suggestions.
>
> My suggestion is to integrate this into the existing "rgb" node, or, if

Not an option since it is not clean RGB and there will be no way to
distinguish RGB from 8bit-CPU.

> that becomes too convoluted, a separate "lcd" node (or "dbi", whatever).

This is fine by me but nesting nodes without compatible feels weird. Oh wel=
l.

dc {
  compatible =3D "...";
  rgb {
    dbi {
      ...
    };
  };
};

>
> Thierry
