Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3EC606A332
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bAivDR2C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2965C10E7BD;
	Thu, 26 Nov 2026 16:24:40 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893B710E7BD
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:24:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 422994E4179A;
 Thu, 26 Nov 2026 16:24:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EA25860558;
 Thu, 26 Nov 2026 16:24:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B33F111E6914A; Thu, 26 Nov 2026 17:24:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795710264; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Mp9D7pFPwCc0xm6C56ewwnHz36Xm2c9SF3YyvxKT0jc=;
 b=bAivDR2C35PhwnrRDbM0ubJtlM8WREdKoDtv8oyGFcLEbdkTrz41SLrg//H1eEUqhCzFlJ
 lzuFHTRbfcWExSuvEE9gNsYQb4b1644KMpczPnQVW3dK6wmMubxf3e/h+WOm9/GI3wYPt5
 6Vhj6/ihGRqvUv/ieBsQE8bp3ELAtBxFtdWj/htVxu5K9LON5kvq/IYvgWVKAJc48nGOQn
 j8ITNyt1NNe//9eE6bFqxqQnWcotDBl1xgwZjV41q0K7GWuwAckrnF+Qa6/5TCbSExclVV
 hA8sGg2w597segnATDIotV4Awrtdx4o40lkojytTIBzXrZrrqowzfZUAkBvpFw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 17:24:03 +0100
Message-Id: <DN5A5LAYR6AW.X45Z2L7J1T4H@bootlin.com>
Cc: "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Yixun Lan" <dlan@kernel.org>, "Troy
 Mitchell" <troy.mitchell@linux.spacemit.com>, "Vinod Koul"
 <vkoul@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Haylen Chu" <heylenay@4d2.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Brian Masney" <bmasney+clk@redhat.com>, "Philipp
 Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Yao Zi" <me@ziyao.cc>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Icenowy
 Zheng" <uwu@icenowy.me>, "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Sarah
 Emery" <sarah.emery@canonical.com>, "Ze Huang" <ze.huang@oss.qualcomm.com>,
 "Dmitry Baryshkov" <lumag@kernel.org>, "Cody Kang" <codykang@vsit.ai>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
 <linux-clk@vger.kernel.org>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Guodong Xu" <docular.xu@gmail.com>, "Cody Kang" <codykang.hk@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 12/17] drm/spacemit: add Innosilicon DP/eDP
 controller bridge driver
X-Mailer: aerc 0.22.0
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
 <20261121-k3-display-v3-12-ec419e8e96b8@gmail.com>
 <9ec2f818084f2e723e8b82218a302258.docular.xu@gmail.com>
In-Reply-To: <9ec2f818084f2e723e8b82218a302258.docular.xu@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 26, 2026 at 2:16 AM CET, Guodong Xu wrote:
...
> Luca (added to Cc), is module unload something your bridge hotplug
> series [1] is meant to cover?

No, I'm afraid it does nothing related to modules.

It's complicated enough without! :-)

> [1] https://lore.kernel.org/r/20261118-drm-bridge-hotplug-v3-0-44bb3b4a82=
8f@bootlin.com

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
