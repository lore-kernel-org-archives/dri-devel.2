Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94957606A327
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=SVUNOzRF;
	dkim=fail reason="signature verification failed" header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=r3IRyTcq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F8C10E021;
	Sun, 15 Nov 2026 18:32:56 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F1010E021
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 18:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794767549; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=kbkjIUZr0p02Kw510PGUuCSAA2KFN2kj5Ds5F0PDRpWtSKub2v2Enl2c++fEFmyev6
 TEIrp20ZfiR1/rfJ9g2PkHidEo5ctmezszKkY7rVnvB/xZhu6TgQC/Vt1x3IUOUVTQxa
 VdcHxxDVDfONXf7vIv7h3cm6Z+kXVzisYhcCNsS38jNWKvyammCVji3LnU6NKlTaasbA
 D7Fm4i/AO8VBu3VU63vwMXDzwTizLkskXx3qajq67o4hQOQf7m0eQDxLArmldeP6+Yu8
 tYflbnn18Iwfs2RGlPyhYuDdusNW71vFGKk1svyQebJcdU6ty0LESxcjGVrtub//oaLq
 MKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794767549;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=dBqqKd5Img5iswSEbhlhsq7DQ0waM+7PPpIeG36Uhb0=;
 b=DUPEyoTDN+L701L3m/X9xrmEqMLdKDouShuC/7doj1OalcToETQgcS4lHbCGN0Se2R
 8sfn+9RMWX6wuliw76D5/NYDn20U8OsZdxuVREz1Fgyg8iYlPQgQabNLYmfEdT5njb3U
 pcs4KF5BXxuMg+C9pGYxKecLh5YTNW+D+TkA+K90iIQTUEumOwO6titAkO0V8XF/vChZ
 GRwh5YeTgPLDm7tG7RIZrSXBw+J8V7r9cyAEro5omA46KcL1xnonMrDq4oCWDud/7Uh9
 Pfz/DQxfj7Gmu/xBBf5wfQXO8+3DBG6Z+l5myMKidpJUjoBExudBBX6rSjnZHwGohCNY
 b58A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794767549;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=dBqqKd5Img5iswSEbhlhsq7DQ0waM+7PPpIeG36Uhb0=;
 b=SVUNOzRF4i1zFX6JNjunY7KqpTA9NU4xeOZ9qVntiHZ9DAYr97NDmcvTlFWJuS4cUn
 ZiUQmhgZ83PHXdtqx3coJTCE3tOegFEF4BwH83yyNOtAg0bRs8XiY8x03uNmXMXvUcYZ
 fADS2pAD3dgwt+1p88cNM6MhZC6Ult85W/XMAJDfjCftbQ25ix49bGk1f9Z4HfQlZr2N
 30uDyLYO2Ry1XilA216LXzuQ2kjYEGwhSYnEyQKYC5eOdScW66nIQoqA2Y/TYkX9bmtE
 s1pwvUOBdgxjJHvJWWEl0lyMn3RSjFoJA+FXQgUZFxNPLvJnPWC5ksrisHEfzu+insNq
 AxfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794767549;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=dBqqKd5Img5iswSEbhlhsq7DQ0waM+7PPpIeG36Uhb0=;
 b=r3IRyTcqJ5c6I67PMQjh31lXgas72kWnxQoXHu2b5zWp9DTikzutZsGyLXZ4xPIFm7
 5x2rzDRdmWDi56DgJYBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT3poPl82Eh4JLZFkZC9pEY+0JabQtk7Q/"
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.6.3 AUTH)
 with ESMTPSA id Qb56a22AFIWSNdV
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Sun, 15 Nov 2026 19:32:28 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH v4 0/5] drm/ingenic: Add the X1600 display controller and
 the HiBy R1 panel
From: H. Nikolaus Schaller <hns@goldelico.com>
In-Reply-To: <20261109174640.96951-1-olivier@mgcrea.io>
Date: Sun, 15 Nov 2026 19:31:57 +0100
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC36FB08-EF5D-43F2-B143-CD1612505232@goldelico.com>
References: <20261109174640.96951-1-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Olivier,

> Am 09.11.2026 um 18:46 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> The display controller of the Ingenic X1600 is not the one ingenic-drm
> drives: it fetches frames through descriptors and keeps its interface =
and
> timings in register blocks of their own. It is the X2000's DPU without
> the composer. This series adds a binding and a driver for it, then the
> panel of the HiBy R1, an X1600 audio player: 480x800 parallel RGB, set =
up
> over a 3-wire SPI bus.
>=20
> The driver covers what the R1 uses and what could be tested: parallel =
RGB
> panels on a 24-bit bus and one full-screen RGB565 plane. The composer,
> smart panels and other pixel formats are left out.
>=20
> Two things come from the vendor kernel rather than the manual. A flip
> also writes SRD_CHAIN_START, which the manual doesn't describe for a
> running controller; flips without it were not tried. The panel's =
set-up
> sequence is the vendor's too: HiBy calls the panel LG35583, its maker =
and
> controller are unknown, hence the hiby prefix.
>=20
> Changes in v4:
> - 3/5: the clock runs from probe to unbind (devm_clk_get_enabled()), =
as
>  in ingenic-drm, instead of being gated with the CRTC (Paul). The
>  controller only takes register writes while clocked, so the timings
>  and the output format can now be set in the encoder's
>  atomic_mode_set(), and the bus_flags and color_order fields go. The
>  burst length is set once in probe, and atomic_disable() no longer has
>  a failed clock start to handle.
> - 3/5: probe brings the clock down to at most a 720p pixel clock right
>  after enabling it. After a reset it runs at its parent's rate, 1.4 =
GHz
>  on the R1, and kept that fast until the first modeset the controller
>  hung the R1 at every cold start.
> - 3/5: atomic_enable() takes the mode from the new CRTC state, there =
is
>  no writel(readl()) nesting, and =
drm_mode_config_create_initial_state()
>  replaces drm_mode_config_reset() (Paul).
> - 3/5: mode_valid() still checks the pixel count against 1280x720 =
rather
>  than 720 per side, which would refuse the R1's 480x800 panel (Paul
>  agreed).
> - 3/5: the file is ingenic-dpu-x1600.c, and the module and driver are
>  ingenic-dpu-x1600 (Nikolaus).
> - 5/5: unprepare() turns vcc off before vccio, the reverse of =
prepare()
>  (Sashiko).
> - Rebased on drm-misc-next.
>=20
> Changes in v3:
> - The compatible is ingenic,x1600-dpu, and the binding and the driver =
say
>  "display controller" rather than "LCD controller" (Nikolaus). The =
X2000
>  and X2600 manuals call this block the DPU, and the X1600 manual does =
too
>  in its register and clock names. There is no generic ingenic,dpu
>  fallback, as writing-bindings.rst asks for SoC compatibles: an X2000
>  binding can fall back to the X1600's. The driver keeps its file name;
>  splitting it for the X2000's composer and interfaces belongs with
>  X2000 support.
> - 2/5: no $nodename and no clock-names; the driver takes its one clock
>  unnamed (Krzysztof). The example's node is display-controller@.
> - 2/5: there is no IPU in front of this controller (Krzysztof asked on =
v2,
>  Paul answered): it fetches its own frames, so the output port is its
>  only link.
> - 4/5: reset-gpios, backlight and port dropped, panel-common has them
>  (Krzysztof). The example's endpoint points at the controller's new
>  label.
> - Krzysztof's Acked-by on 1/5 and Reviewed-by on 4/5.
> - Rebased on drm-misc-next after -rc1.
>=20
> Changes in v2, all in 3/5 and all found by the Sashiko review of v1:
> - Commits wait for flip_done instead of a vblank before the planes are
>  cleaned up. A flip's event waits until the controller reports reading
>  the new descriptor, which can be a frame after the vblank that v1's
>  default commit_tail waited for, so the old framebuffer could be freed
>  while still scanned out.
> - A CRTC being enabled sends its event from atomic_enable(), once the
>  controller runs; v1 sent it from atomic_flush(), which runs first.
> - A plane that is not visible is rejected: the controller always scans
>  out a whole frame, so v1 would have read past the end of a small
>  framebuffer placed off-screen.
> - atomic_disable() returns early when atomic_enable() failed to start
>  the pixel clock, instead of touching an unclocked controller.
>=20
> Tested on a HiBy R1: the fbdev console and a player drawing through
> fbdev, blanking and unblanking, 60 page flips in 0.97 s at about 61 =
Hz,
> and the colour order (RGB order swaps red and blue on this panel). For
> v2 also: 120 fbdev pans in 1.95 s (one flip per frame, none timing =
out),
> three blank/unblank cycles, and a 64x64 framebuffer set on the primary
> plane just past the right edge through SETPLANE, which v1 accepted and
> v2 refuses with -EINVAL, while a full-screen one is still accepted. v3
> was run on the R1 with its node changed to match: the driver binds to
> ingenic,x1600-dpu with its clock unnamed, and the player draws. For =
v4:
> four blank/unblank cycles with the clock left running and the timing
> registers kept, 60 pans in 0.98 s and 120 in 1.97 s with none failing,
> an unbind and bind of the driver, which turns the clock off and then
> writes the timings again from atomic_mode_set() on the first modeset,
> and five cold starts with the kernel loaded into RAM through the boot
> ROM's USB mode and started as the boot loader does.
>=20
> The X1600 has no device tree upstream yet; its support is being posted
> one subsystem at a time. The R1's backlight uses the X1600 PWM driver
> posted separately, now at v3:
> https://lore.kernel.org/r/20261102201325.29507-1-olivier@mgcrea.io
>=20
> v3: https://lore.kernel.org/r/20261106112000.1612-1-olivier@mgcrea.io
> v2: https://lore.kernel.org/r/20261025191640.13592-1-olivier@mgcrea.io
> v1: https://lore.kernel.org/r/20261025085816.60405-1-olivier@mgcrea.io
>=20
> Olivier Louvignes (5):
>  dt-bindings: vendor-prefixes: Add HiBy
>  dt-bindings: display: Add the Ingenic X1600 display controller
>  drm/ingenic: Add a driver for the X1600 display controller
>  dt-bindings: display: panel: Add the HiBy LG35583
>  drm/panel: Add the HiBy LG35583
>=20
> .../bindings/display/ingenic,x1600-dpu.yaml   |  61 ++
> .../bindings/display/panel/hiby,lg35583.yaml  |  67 ++
> .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> MAINTAINERS                                   |  12 +
> drivers/gpu/drm/Makefile                      |   1 +
> drivers/gpu/drm/ingenic/Kconfig               |  22 +
> drivers/gpu/drm/ingenic/Makefile              |   1 +
> drivers/gpu/drm/ingenic/ingenic-dpu-x1600.c   | 739 ++++++++++++++++++
> drivers/gpu/drm/panel/Kconfig                 |  10 +
> drivers/gpu/drm/panel/Makefile                |   1 +
> drivers/gpu/drm/panel/panel-hiby-lg35583.c    | 342 ++++++++
> 11 files changed, 1258 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml
> create mode 100644 =
Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
> create mode 100644 drivers/gpu/drm/ingenic/ingenic-dpu-x1600.c
> create mode 100644 drivers/gpu/drm/panel/panel-hiby-lg35583.c
>=20
>=20
> base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
> --=20
> 2.39.5

Finally I could set up a demo with the sharp,lq070y3dg3b panel-simple
which would be a 33 MHz pixel clock 480x800 panel.

Since we have no connector and just test points I could only verify that
there is a pixel clock signal, sync and if I write random data to =
/dev/fb0
there are varying signals on the RGB pads.

BR and thanks,
Nikolaus

