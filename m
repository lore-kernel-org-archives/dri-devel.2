Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A551FC54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9890010EDEF;
	Thu, 30 Jul 2026 07:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="A/Eu0FLn";
	dkim-atps=neutral
X-Greylist: delayed 115969 seconds by postgrey-1.36 at gabe;
 Wed, 29 Jul 2026 09:22:56 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.64.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8D810E641
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 09:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1785316953;
 bh=Z8jgFnSsfsBCNp8MTSDgq+awuLrAuj0O13qIpQRlAas=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=A/Eu0FLnd/l5zV9WJ3K2ZGV+AHKJQYTJMGs5UkVIIxpzfg/ePGrbJJByZjmrS78Bu
 PmGV9TiGKZcNryCuUZDyzLMByKWQT3KUBhlBry2t2gsP8l7Tadf/Bmmu98B0BszGyc
 g1yQw1Gmj3hBDYX44YIZhTdJTq1q3ZejX6/0lypk=
X-QQ-mid: zesmtpgz6t1785316944t7d5426a8
X-QQ-Originating-IP: uiN5hJeyCk8Cgn2Kllv6CP7k2E6uuJH+qdj4J3W2DYo=
Received: from localhost ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Jul 2026 17:22:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3554096686797190771
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 17:22:21 +0800
Message-Id: <DKAY1CLOY1DD.189ONPFZX1G4O@linux.spacemit.com>
Cc: "frank.binns" <frank.binns@imgtec.com>, "robh" <robh@kernel.org>,
 "krzk+dt" <krzk+dt@kernel.org>, "conor+dt" <conor+dt@kernel.org>, "dlan"
 <dlan@kernel.org>, "dri-devel" <dri-devel@lists.freedesktop.org>,
 "devicetree" <devicetree@vger.kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-riscv"
 <linux-riscv@lists.infradead.org>, "spacemit" <spacemit@lists.linux.dev>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpu: img,powervr-rogue: add
 spacemit,k3-gpu
From: "Baihui Liang" <liangbaihui@linux.spacemit.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.17.0
References: <75c9382d2bda766aa459b00321153d715254d1a4.camel@imgtec.com>
 <20260728010513.1627950-1-liangbaihui@linux.spacemit.com>
 <20260728010513.1627950-2-liangbaihui@linux.spacemit.com>
 <20260728-proud-coyote-of-happiness-e99c24@quoll>
In-Reply-To: <20260728-proud-coyote-of-happiness-e99c24@quoll>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NT1GeB58nkv+mzDjZP/id+gTZoP6XTyxXhcCU83WSNEiw5+vi09e/sWr
 zJmBGCiHvwFfUATXeI0QI2yjz353BV9HXLrvndAtMzNczWAuS6oaYTG3RPmKGg3R2pV+qU3
 k32GeRLUrNUzkdwASKFUYLcFKSzTylueffeD62lO7I6WM0Vvp9ExkDHa/HZV48sdtfR26V/
 pkx1BjVE6/u5/CAZU58eLp2NA2d7P9VGR+s134G6lhohcH85uaaAHSFppk/TNNHTrIYKkXb
 qR0NFxM1bh7WaObvWDNSlhLhfU2hv/qzLm8GxI9bOWoIqE+0WcZuLC6U4O9YUk1ln4ceeEY
 svVlekVtd2E6/zcY3G5xauAOwNYUCvNlR0oc8qscR9cri0Q+5kirgjJSdNirbuDsMjXppCt
 HtI1WVxTGN82KPXy9ELJ/M6bjmm8hqZcl7qz9KT9M/5nPOyoQDYXuAnF8qQEhg3vBpCY7bQ
 QFUvLNRnIDABocRVYkGpV1L/HQ3ry2Ez4ifkZ8tKs9m8EclKibb8j382DDlkm9Rwn3VqNgy
 4Ixy2wJe90P/yk7aFcAlOJBDk/TTLZIQmhp9UaJXJ+VW+pHRaaM3tKNh3nTtQNL4MGAHCS6
 baIZCDYpSoVzjFhcNc9LxlZMZvKmGMUCBctfQPGnF881nESu77ZZkY4txcKxyBMdLS7hSPH
 ALtIxbBeCTZVrjcII7onljISfwNRy3rtdsZ81UbVlJQSQlwP/mlPhAHcchDxORSR4XimCkC
 qUEGrIsOROD2ch9WlxUx4pc28aap72OsTue7IyqSy4F2p7KWRBmzO5bUvV+a3q1+BmCfiwN
 eQRVpXO4FLxl6xTBOWgv9JmtQjTn832pCRG/pD0/s9RA7ayhINtdHgMimsacgU6Qrc6dt7G
 e/2+JB0mimd0NGwsMcGzt5ugpR3d56biZKObrPr3IylJSDWXJy9IE/T5bc//5hoEY4LU7qs
 JpBQvGDSuOAMxhRR2LeFrXm1P5dnpHiFLMne/U2mWKBzyt72GMG/wg3CJK5t/3dOOhSGWpz
 Q1KSLU2INxcYQ/FMe6BwGWWbdSa2DDBTPqBzeNqKFWpDmwXONrRACxVw5zIQ4=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:19:55 +0000
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

On Tue Jul 28, 2026 at 4:07 PM CST, Krzysztof Kozlowski wrote:
> On Tue, Jul 28, 2026 at 09:05:12AM +0800, Sterling-Ash wrote:
> > Add a compatible string for the IMG BXM-4-64 GPU integrated into the
> > SpacemiT K3 SoC. It shares the same core as thead,th1520-gpu but is
> > kept as a separate compatible entry, since the K3 integration differs
> > from TH1520 in its clock and power-domain requirements: K3 has a
> > single "core" clock rather than three, and its GPU power domain is
> > enabled by the bootloader before Linux boots rather than being
> > modelled and switched by Linux, so no power-domains property is
> > required for this platform (unlike the other img,img-bxm-4-64 user).
> >=20
> > spacemit,k3-gpu is added to the existing ti,am62-gpu/ti,am62p-gpu/
> > ti,j721s2-gpu "if" block that restricts clocks to a single entry,
> > since K3 has the same single-clock requirement. It does not match any
> > "if" block that constrains power-domains, so that property falls back
>
> I don't get this explanation. Are you explaining what the patch is doing
> or explaining WHY you did this that way?

That paragraph was describing schema mechanics, which does not belong in
a commit message. v4 will drop it and state only the hardware facts: the
K3 integration of the BXM-4-64 has a single "core" clock, and it has no
software-controllable GPU power domain.

> > to this schema's general constraints, where it is optional. This
> > leaves room for a power-domains provider to be added later without a
> > further binding change, should one ever be modelled in Linux for this
> > SoC.
>
> No, you need to provide constraints now. Please read carefully
> writing-bindings.

Understood. spacemit,k3-gpu currently matches no power-domains "if"
block, so it falls back to the top-level 1-2 domains with
power-domain-names "a"/"b". That would let a K3 DT with two power
domains pass validation, which does not describe this hardware. v4 will
add an explicit "if" block:

    - if:
        properties:
          compatible:
            contains:
              const: spacemit,k3-gpu
      then:
        properties:
          power-domains: false
          power-domain-names: false

The K3 integration of the BXM-4-64 has no software-controllable GPU
power domain, so both properties are disallowed rather than constrained.
This is the one place K3 differs from the other bxm-4-64 user: on
TH1520 the GPU sits in a single unified domain, and that block stays as
it is.

> >=20
> > Signed-off-by: Sterling-Ash <liangbaihui@linux.spacemit.com>
> > ---
>
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets. See also:
> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/s=
ubmitting-patches.rst#L830

Sorry about that -- v2 and v3 were both sent in reply to the v1 review
thread. v4 will be sent as its own top-level thread.

> > v3: also add spacemit,k3-gpu to the existing ti,am62-gpu/ti,am62p-gpu/
> >     ti,j721s2-gpu "if" block restricting clocks to a single entry --
> >     previously it fell back to this schema's general clocks constraint
> >     (1-3 items), which would have let an invalid DT with 2 or 3 clocks
> >     pass validation (found by automated review on v2).
> >=20
> >  .../devicetree/bindings/gpu/img,powervr-rogue.yaml          | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.ya=
ml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > index a1f54dbae3f3..d29f0d163b91 100644
> > --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > @@ -38,6 +38,11 @@ properties:
> >                - thead,th1520-gpu
> >            - const: img,img-bxm-4-64
> >            - const: img,img-rogue
> > +      - items:
> > +          - enum:
> > +              - spacemit,k3-gpu
>
> Why isn't this part of other enum (and remember about the alphabetical
> order of entries)?

No reason -- it was simply wrong. That block is identical to the
thead,th1520-gpu one apart from the SoC compatible, and the differing
clock/power-domain constraints live in "allOf", not here. v4 will fold
it in, in alphabetical order:

      - items:
          - enum:
              - spacemit,k3-gpu
              - thead,th1520-gpu
          - const: img,img-bxm-4-64
          - const: img,img-rogue

The DTS user, and the drm/imagination change it depends on, will be sent
separately once a boot issue on the K3 board is resolved.

> Best regards,
> Krzysztof

Best regards,
Baihui Liang
