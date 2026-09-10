Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A92C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40AD910F36A;
	Thu, 10 Sep 2026 08:19:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B2910F368;
 Thu, 10 Sep 2026 08:19:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B6CA443B5A;
 Thu, 10 Sep 2026 08:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE1D1F0089A;
 Thu, 10 Sep 2026 08:19:15 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anh Nguyen <anh.nguyen.pv@renesas.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 0/3] power: Add Renesas R-Car V4H and V4M support
Date: Thu, 10 Sep 2026 10:19:08 +0200
Message-ID: <cover.1789028076.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

	Hi all,

This patch series documents support for the Imagination Technologies
GPUs integrated in Renesas R-Car V4H and V4M SoCs, and adds device nodes
for them to the SoC-specific DTS files.

I wrote these patches a while ago, and never submitted them, as these
GPUs do not work due to missing or failing firmware.  However, people
showed interested, so I decided to post them.

Thanks for your comments!

Geert Uytterhoeven (3):
  dt-bindings: gpu: img,powervr-rogue: Document R-Car V4H and V4M
    support
  arm64: dts: renesas: r8a779g0: Add GPU node
  arm64: dts: renesas: r8a779h0: Add GPU node

 .../bindings/gpu/img,powervr-rogue.yaml       | 22 ++++++++++++++++++-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     | 21 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi     | 21 ++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
