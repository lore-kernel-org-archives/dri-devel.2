Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D38AC982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7A610E103;
	Fri, 18 Sep 2026 15:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="QICGZhpV";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C8510E103
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1789745680;
 bh=WtQrZyaQlO+mtHmYw2SBSJxPWTjmzlVgI7Rp9b5tPg4=;
 b=QICGZhpVhGfn242M4BastA0e4nZXOWrawL+uWSmXUdoBDXAGU0VPD1WbQ3zZM43HuzNjHX/wV
 H2KmESOY17fPH2rKt4VJDO/TkEv0y7AveXgmCcJ5f0ECtTG5Fh49vtE2rFFyGelDbwi1F0uJjxY
 Ps5PZEC2ZcBu8i6xyyLCiZAt5ruTyviReK24dR9NehWZS5wdDLzl7rC/k5zAwoKiLkoi0KpIJeS
 WnNPD+NHBdXTv7kGDD77tYl9FSsozYCcSeGa7wt/eqgLmNGCBqnGWsJgd3oLKPP4rwwNp+NAsJj
 Q+WKxmWdk2udjkSUGisCcBDieb7dUzoID827EJpzNAkw==
X-Forward-Email-ID: 6aad59a12df78bc22ddeff38
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.14.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Fri, 18 Sep 2026 11:32:45 -0400
Message-Id: <DLIJUQCKB76W.3RHK9KPO5JSOZ@ubuntu.com>
Cc: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <mfd@lists.linux.dev>, <linux-clk@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Maud Spierings"
 <maud_spierings@murena.io>, "Graham Markall" <hello@big-grey.co.uk>,
 "Icenowy Zheng" <zhengxingda@iscas.ac.cn>, "Chaoyi Chen"
 <chaoyi.chen@rock-chips.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 00/20] drm: starfive: jh7110: Enable display subsystem
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Michal Wilczynski" <m.wilczynski@samsung.com>, "Joshua Peisach"
 <jpeisach@ubuntu.com>, "Vinod Koul" <vkoul@kernel.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Lee
 Jones" <lee@kernel.org>, "Andy Yan" <andy.yan@rock-chips.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>, "Emil Renner Berthing" <kernel@esmil.dk>,
 "Hal Feng" <hal.feng@starfivetech.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Dominique Belhachemi" <db@domibel.de>,
 "Brian Masney" <bmasney+clk@redhat.com>, "Jerome Brunet"
 <jbrunet+clk@baylibre.com>
X-Mailer: aerc 0.21.0
References: <CGME20260915153213eucas1p148f013af239a334fc78cdc249c0f8a61@eucas1p1.samsung.com>
 <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <DLGBPXP4F8E0.9X0QMZ9GFQVF@ubuntu.com>
 <136d6789-2f0c-4a91-ab2d-de3a3f119d5d@samsung.com>
In-Reply-To: <136d6789-2f0c-4a91-ab2d-de3a3f119d5d@samsung.com>
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

On Thu Sep 17, 2026 at 1:22 PM EDT, Michal Wilczynski wrote:
>
>
> On 9/16/26 02:45, Joshua Peisach wrote:
>> On Tue Sep 15, 2026 at 11:32 AM EDT, Michal Wilczynski wrote:
>>>
>>> Testing
>>> =3D=3D=3D=3D=3D=3D=3D
>>>
>>> Tested on a VisionFive 2 v1.3B using modetest.
>>=20
>> I.. got nothing. I did have to manually modprobe the modules, but
>> unless I am doing something wrong.. I didn't get anything and modetest
>> just gave -2.
>
> Hmm have you also changed the DTB not just the kernel and the modules
> (you can also built in everything).
>
Yes (I didn't built-in everything, but I did make sure the DTB was
copied and flash-kernel was run)

> Also note modetest needs -M verisilicon.
>

"failed to open device 'versilicon' with busid '(null)': No such file
or directory"


> If that is not it, could you send "dmesg | grep -iE
> 'verisilicon|inno|hdmi|vout'" and "ls /sys/class/drm/"?
>
the dmesg output:

[    0.090950] /soc/display-subsystem@29400000/hdmi@29590000/controller: Fi=
xed dependency cycle(s) with /soc/display-subsystem@29400000/display@294000=
00
[    0.091029] /soc/display-subsystem@29400000/display@29400000: Fixed depe=
ndency cycle(s) with /soc/display-subsystem@29400000/hdmi@29590000/controll=
er
[    0.104227] /hdmi-connector: Fixed dependency cycle(s) with /soc/display=
-subsystem@29400000/hdmi@29590000/controller
[    0.104272] /soc/display-subsystem@29400000/hdmi@29590000/controller: Fi=
xed dependency cycle(s) with /hdmi-connector


/sys/class/drm only contains the file "version"

-Josh

>>=20
>>> ---
>>> Michal Wilczynski (20):
>>>       dt-bindings: phy: Add starfive,jh7110-inno-hdmi-phy
>>>       dt-bindings: display: bridge: Add starfive,jh7110-inno-hdmi-contr=
oller
>>>       dt-bindings: mfd: Add starfive,jh7110-hdmi-subsystem
>>>       dt-bindings: soc: starfive: Add starfive,jh7110-vout-syscon
>>>       dt-bindings: display: verisilicon: Add starfive,jh7110-dc8200
>>>       dt-bindings: soc: starfive: Add starfive,jh7110-vout-subsystem
>>>       drm/bridge: inno-hdmi: Split probe out of bind
>>>       drm/bridge: inno-hdmi: Allow the register map to come from a pare=
nt
>>>       drm/bridge: inno-hdmi: Add .disable platform operation
>>>       drm/bridge: inno-hdmi: Add .mode_valid platform operation
>>>       drm/bridge: inno-hdmi: Make the PHY configuration table optional
>>>       soc: starfive: Add jh7110-hdmi-subsystem driver
>>>       soc: starfive: Add jh7110-vout-subsystem driver
>>>       clk: starfive: jh7110-vout: Allow pixel clock rate propagation
>>>       drm/bridge: starfive: Add JH7110 HDMI controller driver
>>>       phy: Add common Innosilicon HDMI PHY helpers
>>>       phy: rockchip: inno-hdmi: Use the common Innosilicon PHY helpers
>>>       phy: starfive: Add jh7110-inno-hdmi-phy driver
>>>       riscv: dts: starfive: jh7110: Update DT for display subsystem
>>>       MAINTAINERS: Add StarFive JH7110 display subsystem entry
>>>
>>>  .../starfive,jh7110-inno-hdmi-controller.yaml      | 121 +++++
>>>  .../bindings/display/verisilicon,dc.yaml           |   1 +
>>>  .../mfd/starfive,jh7110-hdmi-subsystem.yaml        |  95 ++++
>>>  .../phy/starfive,jh7110-inno-hdmi-phy.yaml         |  49 ++
>>>  .../soc/starfive/starfive,jh7110-syscon.yaml       |   1 +
>>>  .../starfive/starfive,jh7110-vout-subsystem.yaml   | 218 ++++++++
>>>  MAINTAINERS                                        |  13 +
>>>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi    | 121 ++++-
>>>  arch/riscv/boot/dts/starfive/jh7110.dtsi           | 105 +++-
>>>  drivers/clk/starfive/clk-starfive-jh7110-vout.c    |   6 +-
>>>  drivers/gpu/drm/bridge/Kconfig                     |  11 +
>>>  drivers/gpu/drm/bridge/Makefile                    |   1 +
>>>  drivers/gpu/drm/bridge/inno-hdmi.c                 | 112 +++-
>>>  drivers/gpu/drm/bridge/jh7110-inno-hdmi.c          | 297 +++++++++++
>>>  drivers/phy/Kconfig                                |   8 +
>>>  drivers/phy/Makefile                               |   1 +
>>>  drivers/phy/phy-inno-hdmi.c                        | 298 +++++++++++
>>>  drivers/phy/rockchip/Kconfig                       |   1 +
>>>  drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      | 168 +-----
>>>  drivers/phy/starfive/Kconfig                       |  20 +
>>>  drivers/phy/starfive/Makefile                      |   1 +
>>>  drivers/phy/starfive/phy-jh7110-inno-hdmi.c        | 579 +++++++++++++=
++++++++
>>>  drivers/soc/Kconfig                                |   1 +
>>>  drivers/soc/Makefile                               |   1 +
>>>  drivers/soc/starfive/Kconfig                       |  43 ++
>>>  drivers/soc/starfive/Makefile                      |   3 +
>>>  drivers/soc/starfive/jh7110-hdmi-subsystem.c       |  73 +++
>>>  drivers/soc/starfive/jh7110-vout-subsystem.c       |  82 +++
>>>  include/drm/bridge/inno_hdmi.h                     |  10 +-
>>>  include/linux/phy/inno-hdmi-phy.h                  |  85 +++
>>>  30 files changed, 2337 insertions(+), 188 deletions(-)
>>> ---
>>> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
>>> change-id: 20251031-jh7110-clean-send-7d2242118026
>>>
>>> Best regards,
>>=20
>> By the way, something weird happenined while I applied the patches
>> using git am. Somehow, some were out of order. The 10th patch
>> adding .mode_valid tried to be applied before .disable even though
>> in the series, the order is correctly set? git would obviously
>> fail because the .disable entry did not exist in the header, so I had
>> to manually put those in.
>>=20
>> I guess it's possible that something went wrong here? I personally
>> pulled the mailbox from the lore.kernel.org mbox.gz file.
>
> I would recommend using b4 shazam instead
>
>>=20
>
> Best regards,

