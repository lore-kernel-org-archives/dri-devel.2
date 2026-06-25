Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C7ECDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B772910F2BB;
	Thu, 25 Jun 2026 13:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="NgtoIeMW";
	dkim-atps=neutral
Received: from out28-89.mail.aliyun.com (out28-89.mail.aliyun.com
 [115.124.28.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DB610F2BB
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782393682; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=wK/ZKOardcwv/Aodd8pEJaJbQNMwYl1VUq+9vFFehTc=;
 b=NgtoIeMWBkHk7xjbnFfp5da6y3wbORpXRwu5ap93SeCBVXSv3YOFcPnIuEhzxFb4/fZbOozQYTPdTUIOFz2TfTifGB2QPVVwsZ/EfHdco2qlrzv+Z5EAIKoC9/FB3a/kp92DKPnCHdVB4KlE6rLleNRtXH0KAA/uTEaNs0EiZsC8Zyw/h0eEzYRi7cako8k39/Gm47Z97xWiAygY0c5OFJ3yvtjvgNspvw0icnFBQKZKvBwJRuhPUfcyhV7L8V9VQLQvS6V9XTAWTSa39vZvNKhxButXDyTXu9KOmMyTJGrJYxloB4oyELj1Yvxls9fvWAJeaBTTGVjqtzZ++kWY1g==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09206045|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_regular_dialog|0.0384528-0.0220204-0.939527;
 FP=18248887180456620888|8|1|5|0|-1|-1|-1;
 HT=maildocker-contentspam033068016216; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i5LQL5x_1782393679; 
Received: from mail-ot1-f52.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i5LQL5x_1782393679 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 25 Jun 2026 21:21:20 +0800
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7e93b04a142so808046a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 06:21:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/P0eC6RJ7QBIEwIHf3F+tsl4XO/joyfNm8hOpUQTOZzjjYeC7kZ3eKpOYLdig8n2DQy8I/LICr+10=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLmeRdESqDHVTDg20ugMVPSx7uIir4fQ4MBIFmywtbRnhRLjI3
 //kc5OZRak6ssIw2RjuuZXrmwW62cNh45ZH1fEcUGThWxUDfZESD/z1Bsln744DoQLETkHskpys
 vwNbduR79Tvob9KNF89vuNM+0wGABGv4=
X-Received: by 2002:a05:6808:508b:b0:48c:6ab8:b22f with SMTP id
 5614622812f47-49218410421mr2874082b6e.33.1782393678366; Thu, 25 Jun 2026
 06:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260508142500.4922-1-syyang@lontium.com>
 <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
 <495f0dc3-b5ee-429e-bc60-78b13bcb42c3@kernel.org>
 <CAFQXuNajWT31q1MccwTDa074_7=6tfaz-FOmP-tx_q83R60QfQ@mail.gmail.com>
 <CAFQXuNbvSQSZayBGcS6L106ic6M9D+xi8CF9=k27fCAn5U8tdg@mail.gmail.com>
 <206f2e80-132a-4586-bd27-5983783f97ce@kernel.org>
In-Reply-To: <206f2e80-132a-4586-bd27-5983783f97ce@kernel.org>
From: Sunyun Yang <syyang@lontium.com>
Date: Thu, 25 Jun 2026 21:21:06 +0800
X-Gmail-Original-Message-ID: <CAFQXuNZMwwNrUft=w9o_dB96cOchKoh07jnk3Z2CioJoqhYybw@mail.gmail.com>
X-Gm-Features: AVVi8CcRLVVCVFUu6dNTXTPJQjRM91gouORofLQ5rIVxZgeiGY6BSZ5XTAxS8O0
Message-ID: <CAFQXuNZMwwNrUft=w9o_dB96cOchKoh07jnk3Z2CioJoqhYybw@mail.gmail.com>
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

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=9B=9B 20:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On 25/06/2026 04:01, Sunyun Yang wrote:
> > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=9B=9B 08:52=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=88=
24=E6=97=A5=E5=91=A8=E4=B8=89 22:05=E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>> On 11/05/2026 05:28, Sunyun Yang wrote:
> >>>> <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=888=E6=97=A5=E5=
=91=A8=E4=BA=94 22:25=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>
> >>>>> From: Sunyun Yang <syyang@lontium.com>
> >>>>>
> >>>>> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual=
 port
> >>>>> mipi dsi and output hdmi, differences in hardware features:
> >>>>> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> >>>>> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> >>>>> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> >>>>>
> >>>>> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> >>>>> ---
> >>>>>  .../bindings/display/bridge/lontium,lt9611.yaml           | 8 ++++=
++--
> >>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/display/bridge/lonti=
um,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,l=
t9611.yaml
> >>>>> index 429a06057ae8..e0821a63d9d7 100644
> >>>>> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt96=
11.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt96=
11.yaml
> >>>>> @@ -4,19 +4,23 @@
> >>>>>  $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.y=
aml#
> >>>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>>
> >>>>> -title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
> >>>>> +title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
> >>>>>
> >>>>>  maintainers:
> >>>>>    - Vinod Koul <vkoul@kernel.org>
> >>>>>
> >>>>>  description: |
> >>>>> -  The LT9611 and LT9611UXC are bridge devices which convert DSI to=
 HDMI
> >>>>> +  The LT9611=E3=80=81LT9611UXC=E3=80=81LT9611C=E3=80=81LT9611EX an=
d LT9611UXD
> >>>>> +  are bridge devices which convert DSI to HDMI
> >>>>>
> >>>>>  properties:
> >>>>>    compatible:
> >>>>>      enum:
> >>>>>        - lontium,lt9611
> >>>>> +      - lontium,lt9611c
> >>>>> +      - lontium,lt9611ex
> >>>>>        - lontium,lt9611uxc
> >>>>> +      - lontium,lt9611uxd
> >>>>>
> >>>>>    reg:
> >>>>>      maxItems: 1
> >>>>> --
> >>>>
> >>>> Gentle ping.
> >>>> Thanks.
> >>>
> >>> Except mess with threading, your patchset does not build, when applie=
d
> >>> on next-20260618.
> >>>
> >>> What is the base of this?
> >>>
> >>
> >> Thanks for testing my patchset on next-20260618.
> >>
> >> The base of this series is v7.0.
> >>
> > Krzysztof,   Is Sashiko AI review required before merging a patch now?
>
> Fixing obvious bugs in your code is required before merging.
>
> But even without bugs, this cannot be merged - does not apply. And you
> sending the same three different times does not help, because now there
> is complete mess in reviews.
>
We will modify the driver and the device tree, and test it on next-20260623=
.
Additionally, we would like to ask you a question regarding Sashiko
AI: Is Sashiko AI review required before merging a patch now?

> Best regards,
> Krzysztof
