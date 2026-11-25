Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C24606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=namei.org header.i=@namei.org header.a=rsa-sha256 header.s=2 header.b=a3AeraWl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7638210E8A8;
	Wed, 25 Nov 2026 04:01:07 +0000 (UTC)
X-Greylist: delayed 467 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 04:01:00 UTC
Received: from mail.namei.org (namei.org [65.99.196.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCDED10E8A8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.namei.org (Postfix) with ESMTPS id 73F592FA;
 Wed, 25 Nov 2026 03:53:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 73F592FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
 t=1795578791; bh=gpn0UCdoZZeC5B0l3wY/XpSaKvgOSjTK0REYdcoxBF4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=a3AeraWlEkmuoZtzUbJF8G20eVOhm2DteJPZL3L1bOGQ9DO5TMITBMCuGtxv1Lydh
 7M8wg668sKPjnLtzsS9sDVgKfJPY7vUblJ39jCbNs5NCg5opFEvJbLxot19LSeCYqd
 nca+i+o6iWgLl0x5++pzMMPda2h407h2YJEW+gYE=
Date: Tue, 24 Nov 2026 19:53:11 -0800 (PST)
From: James Morris <jmorris@namei.org>
To: codykang.hk@gmail.com
cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Haylen Chu <heylenay@4d2.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, 
 =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Guodong Xu <docular.xu@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Sarah Emery <sarah.emery@canonical.com>, 
 Ze Huang <ze.huang@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Cody Kang <codykang@vsit.ai>, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 00/17] drm/spacemit: add SpacemiT K3 display support
In-Reply-To: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
Message-ID: <87eaeb2-b6e9-9198-b9cf-7e9f96bdcbc@namei.org>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 21 Nov 2026, Cody Kang via B4 Relay wrote:

> This series adds display support for the SpacemiT K3 [2], a RISC-V SoC:
> a new DRM driver, a new PHY driver and three new bindings.


Tested-by: James Morris <jmorris@namei.org> # CoM260-IFX, DisplayPort

Assisted by an LLM.

v3 on v7.4-rc1 works on a SpacemiT K3 CoM260 IFX with an Acer EDB323QU
(2560x1440, 144 Hz) on the DisplayPort connector. The DRM, DP and PHY
drivers were built in, and Linux ran from an initramfs with
clk_ignore_unused.

The board has the vendor U-Boot 2022.10 built on May 21 2026, not the
uboot-for-k3-display-verify branch. That link in the cover letter
returns 404 for me.

What ran, over two boots:

- Probe: the DPU and the DP bridge bound and the fbdev console came up.
  The kernel log has no warning or error.
- Modes, with modetest: 2560x1440 at 60, 120 and 144 Hz, 1920x1080 at
  60 and 120 Hz, 1280x1024, 1280x720, 1024x768 and 640x480. The picture
  was clean in every mode I watched, including 2560x1440 at 60 and
  144 Hz.
- Link training: all 22 logged attempts passed at the first
  configuration tried: 1.62 Gbps x2, 2.7 Gbps x1, x2 and x4, and
  5.4 Gbps x4.
- Page flips, with modetest -v: 60.00 Hz at 1920x1080, and 144.00 Hz
  and 59.95 Hz at 2560x1440. An atomic plane flip held 59.95 Hz for
  80 s.
- DPMS: the fbdev console blanked and returned in eight cycles. I
  watched three; the link retrained and the picture came back each
  time.
- Hot-plug: I unplugged and replugged the cable with 2560x1440 active.
  The connector status followed and the picture came back.

Two observations:

1. The HPD interrupt never fired. /proc/interrupts stayed at 0 for
   cac88000.dp in both boots, also across the unplug and replug, when
   the stream was running. The connector poll caught both.

2. With the monitor asleep, nothing was displayed. It kept HPD high and
   returned a generic 1920x1080 EDID. Link training passed at
   2.7 Gbps x2, but the monitor stayed dark until I woke it by hand
   and a later modeset retrained the link. The kernel got no event
   when the monitor woke. I found no DP_SET_POWER write in the driver;
   could the sink be left in D3?



-- 
James Morris
<jmorris@namei.org>

