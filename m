Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FD2CD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379A810ECB4;
	Thu, 11 Jun 2026 05:36:24 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A12610ECB4
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:36:22 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.167])
 by APP-01 (Coremail) with SMTP id qwCowABX+dFPSSpqsclEAQ--.9323S2;
 Thu, 11 Jun 2026 13:36:15 +0800 (CST)
Message-ID: <2877375c4efee4b4e816b418c965da7bd7d60992.camel@iscas.ac.cn>
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: himax,hx83121a: add
 optional bl supply
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang	
 <jesszhan0024@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jun 2026 13:36:14 +0800
In-Reply-To: <178115560756.199930.11183711627429440356.b4-review@b4>
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
 <178115560756.199930.11183711627429440356.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowABX+dFPSSpqsclEAQ--.9323S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr13Ww15GF47Kr4DJFy5Jwb_yoW8GrWkpr
 WDCasxt3Z3tr1xXay0q3WxWr4rWw4vka17WFn8XFy7KwsFqws5tryakrnYgF4UAF48Cay2
 vFyq9a93JFsFk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IU8fpnPUUUUU==
X-Originating-IP: [112.94.100.167]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

=E5=9C=A8 2026-06-11=E5=9B=9B=E7=9A=84 13:26 +0800=EF=BC=8CPengyu Luo=E5=86=
=99=E9=81=93=EF=BC=9A
> On Tue, 09 Jun 2026 00:26:20 +0800, Icenowy Zheng
> <zhengxingda@iscas.ac.cn> wrote:
> > When the backlight is managed by the panel controller IC, an
> > external
> > power rail might be powering the backlight.
> >=20
> > Add an optional `bl-supply` property to describe such power rail,
> > thus
> > allow disabling the backlight.
> >=20
>=20
> Please add it as a hwen pin, this will simplify your code later.

I am not sure whether this should be a pin or a regulator -- the DT
binding should reflect the HW fact, and LCD panel backlights usually
require a high voltage (or even a current source) that is driven by a
dedicated regulator.

Thanks,
Icenowy

>=20
> >=20
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/display/panel/himax,hx83121a.ya
> > ml
> > b/Documentation/devicetree/bindings/display/panel/himax,hx83121a.ya
> > ml
> > index e067a2f6d0b2..aeca3c9a599c 100644
> > ---
> > a/Documentation/devicetree/bindings/display/panel/himax,hx83121a.ya
> > ml
> > +++
> > b/Documentation/devicetree/bindings/display/panel/himax,hx83121a.ya
> > ml
> > @@ -40,6 +40,9 @@ properties:
> > =C2=A0=C2=A0 vddi-supply:
> > =C2=A0=C2=A0=C2=A0=C2=A0 description: power supply for IC
> > =C2=A0
> > +=C2=A0 bl-supply:
> > +=C2=A0=C2=A0=C2=A0 description: power supply for backlight, in case it=
's managed
> > via DSC
> > +
>=20
> s/DSC/DCS/
>=20
> Best wishes,
> Pengyu

