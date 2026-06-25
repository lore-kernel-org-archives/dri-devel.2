Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120CCCDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 02:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171A910E0BB;
	Thu, 25 Jun 2026 02:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="EeGLCO/V";
	dkim-atps=neutral
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC7C10E0BB
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782352908; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=0HI8u0E+ADzDZfgRytV6ZPmS1dcxKzkD8fe0hOt0kNU=;
 b=EeGLCO/VixrijzcrMS6ga8PZyDcNLha/Bi4gKji0HKf759j7I+3gaJLHmBiRCdtvrMPLbqsPnQlwnAxQjo2zpkjJYm9lEB6RKBe0pHgo/0l97yBSlkBjzSiDEJWLOnzEnGH+SMQQx2XMdV2dqX+9qlHwMAXuvcmdJU9wuSbUbK39cexuKfIFrPNhnMplm9GptgLJTzSD1hZ2jOmhlGC9JgaSarwqN+mys5jfXJw4aswEAHUhBDFonGunVFf4qZKi1B6TumLexHR0L5oF9yacQS9bVPQYtOAiMmKhYoPYNLH28pp0Pc9Hwmn7XAzrONuATNTxyHGw0wtk88l9sxhkbg==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1482914|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_social|0.125752-0.0564426-0.817805;
 FP=13348672268204241752|7|1|6|0|-1|-1|-1;
 HT=maildocker-contentspam033037025160; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i4qbIdQ_1782352905; 
Received: from mail-oi1-f173.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i4qbIdQ_1782352905 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 25 Jun 2026 10:01:46 +0800
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-48633190849so726066b6e.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:01:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8OAM49g5rmQTFSXik/JB0C5l0Fq4y9Jf/+EZ8idpnKeAHlyhDAMt7b8ld8YcUzsXT1c7gmzVYCSwM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKOCF82ZeW1ytw1vBk9fj1BSAZWueDffHoW42t4hOfeLTLWrCr
 5Dcz9s/fIEcU9HEIu4ad7gXajdqazoSXTr+Gun2HZZ5nN9GZF4VrjB0HE2zaDTdhPMVatG0wLFX
 kh6OGzX4X8AMK4didvh1P/o+B2063Z10=
X-Received: by 2002:a05:6808:6a96:b0:491:7c98:70fb with SMTP id
 5614622812f47-49218a120a4mr612720b6e.43.1782352905100; Wed, 24 Jun 2026
 19:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260508142500.4922-1-syyang@lontium.com>
 <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
 <495f0dc3-b5ee-429e-bc60-78b13bcb42c3@kernel.org>
 <CAFQXuNajWT31q1MccwTDa074_7=6tfaz-FOmP-tx_q83R60QfQ@mail.gmail.com>
In-Reply-To: <CAFQXuNajWT31q1MccwTDa074_7=6tfaz-FOmP-tx_q83R60QfQ@mail.gmail.com>
From: Sunyun Yang <syyang@lontium.com>
Date: Thu, 25 Jun 2026 10:01:33 +0800
X-Gmail-Original-Message-ID: <CAFQXuNbvSQSZayBGcS6L106ic6M9D+xi8CF9=k27fCAn5U8tdg@mail.gmail.com>
X-Gm-Features: AVVi8Cf6lcVS_ZMQoqUlrZQRKTWB8E-LeT1g4fSMafPM6AVXeaL9vSzHlZap9X8
Message-ID: <CAFQXuNbvSQSZayBGcS6L106ic6M9D+xi8CF9=k27fCAn5U8tdg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org, Laurent.pinchart@ideasonboard.com, 
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
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

Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B 08:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=B8=89 22:05=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 11/05/2026 05:28, Sunyun Yang wrote:
> > > <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=888=E6=97=A5=E5=91=
=A8=E4=BA=94 22:25=E5=86=99=E9=81=93=EF=BC=9A
> > >>
> > >> From: Sunyun Yang <syyang@lontium.com>
> > >>
> > >> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual =
port
> > >> mipi dsi and output hdmi, differences in hardware features:
> > >> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> > >> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> > >> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> > >>
> > >> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > >> ---
> > >>  .../bindings/display/bridge/lontium,lt9611.yaml           | 8 +++++=
+--
> > >>  1 file changed, 6 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/display/bridge/lontiu=
m,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt=
9611.yaml
> > >> index 429a06057ae8..e0821a63d9d7 100644
> > >> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt961=
1.yaml
> > >> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt961=
1.yaml
> > >> @@ -4,19 +4,23 @@
> > >>  $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.ya=
ml#
> > >>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>
> > >> -title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
> > >> +title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
> > >>
> > >>  maintainers:
> > >>    - Vinod Koul <vkoul@kernel.org>
> > >>
> > >>  description: |
> > >> -  The LT9611 and LT9611UXC are bridge devices which convert DSI to =
HDMI
> > >> +  The LT9611=E3=80=81LT9611UXC=E3=80=81LT9611C=E3=80=81LT9611EX and=
 LT9611UXD
> > >> +  are bridge devices which convert DSI to HDMI
> > >>
> > >>  properties:
> > >>    compatible:
> > >>      enum:
> > >>        - lontium,lt9611
> > >> +      - lontium,lt9611c
> > >> +      - lontium,lt9611ex
> > >>        - lontium,lt9611uxc
> > >> +      - lontium,lt9611uxd
> > >>
> > >>    reg:
> > >>      maxItems: 1
> > >> --
> > >
> > > Gentle ping.
> > > Thanks.
> >
> > Except mess with threading, your patchset does not build, when applied
> > on next-20260618.
> >
> > What is the base of this?
> >
>
> Thanks for testing my patchset on next-20260618.
>
> The base of this series is v7.0.
>
Krzysztof,   Is Sashiko AI review required before merging a patch now?

> > Best regards,
> > Krzysztof
