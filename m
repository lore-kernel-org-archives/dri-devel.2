Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6C9C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F5910F19B;
	Fri, 18 Sep 2026 06:22:04 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B983D10F19B
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:22:02 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.103.44])
 by APP-01 (Coremail) with SMTP id qwCowADnuu5y2KxqkbJICA--.14966S2;
 Fri, 18 Sep 2026 14:21:41 +0800 (CST)
Message-ID: <b8efa0db854929a353c430f78fffd907bd7ccb65.camel@iscas.ac.cn>
Subject: Re: [PATCH v4 01/20] dt-bindings: phy: Add
 starfive,jh7110-inno-hdmi-phy
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Krzysztof Kozlowski <krzk@kernel.org>, Joshua Peisach <jpeisach@ubuntu.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Vinod Koul
 <vkoul@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Andrzej Hajda	 <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart	
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>, Philipp Zabel	 <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng	
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi	 <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet	 <jbrunet+clk@baylibre.com>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, 	linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Chaoyi
 Chen	 <chaoyi.chen@rock-chips.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <u.kleine-koenig@baylibre.com>
Date: Fri, 18 Sep 2026 14:21:37 +0800
In-Reply-To: <20260918-futuristic-mindful-waxbill-21fa2d@quoll>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-1-f0e4fd6f2cc8@samsung.com>
 <20260917-mutant-chamois-of-competence-46ca77@quoll>
 <DLI0QTP0NUHS.DAFYGACKWKWO@ubuntu.com>
 <20260918-futuristic-mindful-waxbill-21fa2d@quoll>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowADnuu5y2KxqkbJICA--.14966S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4xKF13WFyUCw1UKF1rWFg_yoW5Jr18pF
 WDK3ZIkr4DJr1xAwn293WjgryF9w47A34Yqry5Wryjvr98tF1rtr4xGr45u3WDKr4fWr42
 vF1jk34fu3sYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
 73UjIFyTuYvjxU9PfHDUUUU
X-Originating-IP: [112.94.103.44]
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

=E5=9C=A8 2026-09-18=E4=BA=94=E7=9A=84 08:16 +0200=EF=BC=8CKrzysztof Kozlow=
ski=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Sep 17, 2026 at 08:34:18PM -0400, Joshua Peisach wrote:
> > On Thu Sep 17, 2026 at 2:51 AM EDT, Krzysztof Kozlowski wrote:
> > > On Tue, Sep 15, 2026 at 05:32:09PM +0200, Michal Wilczynski
> > > wrote:
> > > > Add the dt-binding for the StarFive JH7110 Innosilicon HDMI
> > > > PHY.
> > > >=20
> > > > This device is a child of the starfive,jh7110-hdmi-subsystem
> > > > node. It
> > > > functions as both a PHY provider for the controller and as a
> > > > clock
> > > > provider for the variable pixel clock (hdmi_pclk), which it
> > > > generates
> > > > from its refoclk.
> > > >=20
> > > > Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> > >=20
> > > While I appreciate other people looking at this, I don't think
> > > review
> > > here applies. It was a blanket tag, given to the entire series,
> > > with
> > > exception that it is from newbie, thus I want to ask: was this
> > > binding
> > > REALLY reviewed by Joshua?
> > >=20
> > > Are the rest of the patches actually reviewed or just "looks good
> > > to
> > > me"? I see no comments from Joshua on v3, v2 and v1, which is
> > > usual sign
> > > of doing review.
> > >=20
> > >=20
> > I commented on v3 saying that I would test if I could. I don't just
>=20
> Testing has nothing to do with reviewing.
>=20
> > throw "Reviewed-by" on everything I look at.
> >=20
> > If anything, I've been trying to be more honest in reviews, and
> > only
> > review ones that I actually care about[1].
>=20
> You gave blanket tag for entire series, so I do not get this
> argument.
>=20
> >=20
> > If reviewing patches isn't a good way for newbies to start getting
> > familiar with the kernel code (especially a NEW driver), then I
> > don't
> > know what is.
>=20
> Writing code and receiving review is something for newbies to start
> with. If you do not know kernel code or bindings, why do you think
> your review is applicable? If I try to review design of a post-
> tension
> concrete bridge, I would probably learn something. Would my
> review apply? No.

My personal thoughts: everyone should be able to send R-b, but the
effect of the R-b depends on who sent it.

In this case, I am okay about adding Joshua's R-b, but I don't
necessarily think the patchset is reviewed enough because of this R-b.

Thanks,
Icenowy

>=20
> Best regards,
> Krzysztof
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

