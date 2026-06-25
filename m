Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81357CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 00:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E11F10E14B;
	Thu, 25 Jun 2026 00:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="e3nYSeyf";
	dkim-atps=neutral
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com
 [115.124.28.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B6F10E14B
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 00:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782348743; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=TZqNTnIu549tTIomgYazqeUAShfsBdkEd7y+/MMJhI0=;
 b=e3nYSeyfK+jV4s7hjBfx2iY00KyfehK9z8HWV+XOSNmElYIPOAt0gdmIJdMoJ+l8w7SXILnA72gJOUKnmZZD7t06/0bmeOgHQdNyE5mbdo0Gw2/ty9vc/r6dq/TzjPSJ3evaL/feEum+DGW6VOJ7MMe2ckb4V9AcmGwOWr0J1nKD1jJ37YRDxnuuLE//V+1UtsXpj0oc6l+qt1D+pyo3X0K0gUi31gTSF2a74fe0ExgMNbcKxky0l3MWLiXqvxfRz2QzNh9C2m5U+HeeOlw8JM0/bDxu0fOujJOQYi3GQAGK9x0n/YeLBLB/i6nbadANtvoCATEdnzvoNO7O4SjK3Q==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.255127|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0610697-0.0193207-0.91961;
 FP=13348953743449387992|13|1|9|0|-1|-1|-1;
 HT=maildocker-contentspam011083013073; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i4n8h59_1782348739; 
Received: from mail-ot1-f52.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i4n8h59_1782348739 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 25 Jun 2026 08:52:20 +0800
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7e6d37b7098so1636224a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:52:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/yYKK9Xniy1yZnogEPH8RwT2nMniieOtqrDkavPCBad4lvN6XeHZZFn68Bi1fkugamm8xFkJHafyE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywPyRwjGzS72lDDYk7IXQsjaV60EQu64FaL7eWjvWfRoTTr9xP
 hb0zpdullS4qmQZ/uNJMRYp96UMdGtKlVW+diYnElWhiAqAsxAjWTW/rMZ0xtxdzeeHnqzmZoHY
 V1vTfaYFsZMBzKkIiguzL4cHIcRIeK5w=
X-Received: by 2002:a05:6808:c3cb:b0:48a:a718:1f56 with SMTP id
 5614622812f47-4921595161cmr484323b6e.9.1782348738618; Wed, 24 Jun 2026
 17:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260508142500.4922-1-syyang@lontium.com>
 <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
 <495f0dc3-b5ee-429e-bc60-78b13bcb42c3@kernel.org>
In-Reply-To: <495f0dc3-b5ee-429e-bc60-78b13bcb42c3@kernel.org>
From: Sunyun Yang <syyang@lontium.com>
Date: Thu, 25 Jun 2026 08:52:05 +0800
X-Gmail-Original-Message-ID: <CAFQXuNajWT31q1MccwTDa074_7=6tfaz-FOmP-tx_q83R60QfQ@mail.gmail.com>
X-Gm-Features: AVVi8CfE-A5p_Q7IR6jyWv_M8aKD8qGz_1Y5TCkwp3XWzUgtW9ua0QWOzc8_JDM
Message-ID: <CAFQXuNajWT31q1MccwTDa074_7=6tfaz-FOmP-tx_q83R60QfQ@mail.gmail.com>
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

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=B8=89 22:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On 11/05/2026 05:28, Sunyun Yang wrote:
> > <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=888=E6=97=A5=E5=91=
=A8=E4=BA=94 22:25=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> From: Sunyun Yang <syyang@lontium.com>
> >>
> >> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual po=
rt
> >> mipi dsi and output hdmi, differences in hardware features:
> >> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> >> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> >> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> >>
> >> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> >> ---
> >>  .../bindings/display/bridge/lontium,lt9611.yaml           | 8 ++++++-=
-
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,=
lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt96=
11.yaml
> >> index 429a06057ae8..e0821a63d9d7 100644
> >> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.=
yaml
> >> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.=
yaml
> >> @@ -4,19 +4,23 @@
> >>  $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml=
#
> >>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>
> >> -title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
> >> +title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
> >>
> >>  maintainers:
> >>    - Vinod Koul <vkoul@kernel.org>
> >>
> >>  description: |
> >> -  The LT9611 and LT9611UXC are bridge devices which convert DSI to HD=
MI
> >> +  The LT9611=E3=80=81LT9611UXC=E3=80=81LT9611C=E3=80=81LT9611EX and L=
T9611UXD
> >> +  are bridge devices which convert DSI to HDMI
> >>
> >>  properties:
> >>    compatible:
> >>      enum:
> >>        - lontium,lt9611
> >> +      - lontium,lt9611c
> >> +      - lontium,lt9611ex
> >>        - lontium,lt9611uxc
> >> +      - lontium,lt9611uxd
> >>
> >>    reg:
> >>      maxItems: 1
> >> --
> >
> > Gentle ping.
> > Thanks.
>
> Except mess with threading, your patchset does not build, when applied
> on next-20260618.
>
> What is the base of this?
>

Thanks for testing my patchset on next-20260618.

The base of this series is v7.0.

> Best regards,
> Krzysztof
