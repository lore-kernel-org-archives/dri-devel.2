Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C65C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F9F10E532;
	Fri, 18 Sep 2026 00:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="WtBzbj8r";
	dkim-atps=neutral
X-Greylist: delayed 367 seconds by postgrey-1.36 at gabe;
 Fri, 18 Sep 2026 00:41:11 UTC
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB4010E532
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 00:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Cc: To: From: Subject: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1789692071;
 bh=8QgXkkNdHre4C26c9GV+NpL0QV5WDefYsihE2tDLo6E=;
 b=WtBzbj8r/RUJdlgITKGLJ3i0mWrrdqXQzvoJDf1qDMTZinGg3U1V2YE1tJJ7145ogSvocwIQr
 lioOv6L7uMuJGbvl5oLpfGZ7JqcUa+3rp6KoDsTPI5dqKsIHUBTyZ7JczMi6wGgSrofk6DsOd9I
 bk4zCgS9QpdN3mCLH4wnhW7zcfK4+11Vw7IgX/UO52wYfrbQYcOtQi6jjUrBVcSTDzUYsrCtlIe
 v6UzxYn1C3HJZieVvQEOQygi0SH4Ib2diWhozbiWNTXIqd+BPPTXQbZaQ0Rk25wiWqi8aqcc+Us
 pUTt6EDu8s3TrAnhRMxY8GufW6DUfFTpXh3xwdH3mnYA==
X-Forward-Email-ID: 6aac871042fb3e762f6d18f9
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.14.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Thu, 17 Sep 2026 20:34:18 -0400
Message-Id: <DLI0QTP0NUHS.DAFYGACKWKWO@ubuntu.com>
Subject: Re: [PATCH v4 01/20] dt-bindings: phy: Add
 starfive,jh7110-inno-hdmi-phy
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Neil Armstrong"
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
 <jbrunet+clk@baylibre.com>, <linux-phy@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <mfd@lists.linux.dev>,
 <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Maud Spierings"
 <maud_spierings@murena.io>, "Graham Markall" <hello@big-grey.co.uk>,
 "Icenowy Zheng" <zhengxingda@iscas.ac.cn>, "Chaoyi Chen"
 <chaoyi.chen@rock-chips.com>, "Joshua Peisach" <jpeisach@ubuntu.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153214eucas1p2b548f3236ef98fb0cbf320e397420125@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-1-f0e4fd6f2cc8@samsung.com>
 <20260917-mutant-chamois-of-competence-46ca77@quoll>
In-Reply-To: <20260917-mutant-chamois-of-competence-46ca77@quoll>
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

On Thu Sep 17, 2026 at 2:51 AM EDT, Krzysztof Kozlowski wrote:
> On Tue, Sep 15, 2026 at 05:32:09PM +0200, Michal Wilczynski wrote:
>> Add the dt-binding for the StarFive JH7110 Innosilicon HDMI PHY.
>>=20
>> This device is a child of the starfive,jh7110-hdmi-subsystem node. It
>> functions as both a PHY provider for the controller and as a clock
>> provider for the variable pixel clock (hdmi_pclk), which it generates
>> from its refoclk.
>>=20
>> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
>
> While I appreciate other people looking at this, I don't think review
> here applies. It was a blanket tag, given to the entire series, with
> exception that it is from newbie, thus I want to ask: was this binding
> REALLY reviewed by Joshua?
>
> Are the rest of the patches actually reviewed or just "looks good to
> me"? I see no comments from Joshua on v3, v2 and v1, which is usual sign
> of doing review.
>
>
I commented on v3 saying that I would test if I could. I don't just
throw "Reviewed-by" on everything I look at.

If anything, I've been trying to be more honest in reviews, and only
review ones that I actually care about[1].

If reviewing patches isn't a good way for newbies to start getting
familiar with the kernel code (especially a NEW driver), then I don't
know what is.

And to be clear, I'm not using a LLM to review. I am using actual
intelligence. For the JH7110 PR specifically, I did actually go through
and review each commit, because I wanted to learn what was happening
and why. Actually, that's why I asked where the data sheet was[2].

So if you really want to, drop the Reviewed-by tag. And if it makes
you feel better, I'll leave the series alone.

-Josh

[1] I won't be reviewing PRs around devicetree since I'm not confident
(or frankly, interested) in it at this point. https://lore.kernel.org/all/D=
L94TU52KBMO.2HAKJMJXV2CPE@ubuntu.com/

[2] Michal giving me the hardware info:
https://lore.kernel.org/all/071901ef-57f3-456f-af5b-a8c99a0a7dd3@samsung.co=
m/
