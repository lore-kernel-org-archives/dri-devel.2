Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572DA109B460
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B125510EC5F;
	Tue, 31 Mar 2026 12:49:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jNM/Ro2t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B0810EC5F
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 12:49:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 09F8360128;
 Tue, 31 Mar 2026 12:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6203FC19423;
 Tue, 31 Mar 2026 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774961370;
 bh=Coh8LzVa9q3zCzvSOZo/SjOW9x+HwU5WnB9FOx9SW4c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jNM/Ro2tOdktKX64Pu3ng6eyvThkpH7NtheDW+o7yz2NwUogFYXt2HmkazBDgGt8Y
 nRx8LGIZK5+pj0l6kUZ6UwsjPUhN1ubFHe+da5VF7WTjzWIn/xH14ZJSk4xH2VMo6h
 6onjc68c9OQvMORAE/RGZEuNNOQrpplWh7R0F8sigTDTuzmqWjWNf/1p70TtohAM7V
 eC3T++w0LOlnKCB28IC+S7xy7ptJFJWTJRjISDwZjNlK0eHefwU2TNM/YsN0cCjuaZ
 xT2y/m+nn3B8H2do3E2mXOoVJlzsOsZ6zrXry9yHD/eE9c09MTkKRtadYKYL/JEmEM
 sq9PCBYNFfj1A==
Date: Tue, 31 Mar 2026 13:49:24 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Stefan Wahren <wahrenst@gmx.net>,
 Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>,
 Iago Toral Quiroga <itoral@igalia.com>,
 Chema Casanova <jmcasanova@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com
Subject: Re: [PATCH v7 1/5] clk: bcm: rpi: Manage clock rate in
 prepare/unprepare callbacks
Message-ID: <5f0bec08-f458-4fba-8bf3-06817a100c4c@sirena.org.uk>
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
 <20260312-v3d-power-management-v7-1-9f006a1d4c55@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OWkifeB2LU4jLg/s"
Content-Disposition: inline
In-Reply-To: <20260312-v3d-power-management-v7-1-9f006a1d4c55@igalia.com>
X-Cookie: Filmed before a live audience.
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


--OWkifeB2LU4jLg/s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 06:34:23PM -0300, Ma=EDra Canal wrote:

> On current firmware versions, RPI_FIRMWARE_SET_CLOCK_STATE doesn't
> actually power off the clock. To achieve meaningful power savings, the
> clock rate must be set to the minimum before disabling. This might be
> fixed in future firmware releases.

> Rather than pushing rate management to clock consumers, handle it
> directly in the clock framework's prepare/unprepare callbacks. In
> unprepare, set the rate to the minimum before disabling the clock.
> In prepare, for clocks marked with `maximize` (currently v3d),
> restore the rate to the maximum after enabling.

I'm seeing boot regressions in -next with NFS root on Raspberry Pi 3B+
which bisect to this commit.  We get a likely unrelated oops from the
firmware interface and the boot grinds to a halt some time later since
the ethernet never comes up:

[   21.898686] Firmware transaction 0x00030066 timeout
[   21.898769] WARNING: drivers/firmware/raspberrypi.c:128 at rpi_firmware_=
property_list+0x200/0x280, CPU#2: (udev-worker)/115

=2E..

[   22.067074] Call trace:
[   22.069538]  rpi_firmware_property_list+0x200/0x280 (P)
[   22.074824]  rpi_firmware_property+0x70/0xb8
[   22.079140]  vc4_drm_bind+0x12c/0x354 [vc4]
[   22.083368]  try_to_bring_up_aggregate_device+0x16c/0x1e0
[   22.088831]  component_master_add_with_match+0xb0/0xec
[   22.094027]  vc4_platform_drm_probe+0xc0/0xfc [vc4]
[   22.098961]  platform_probe+0x5c/0xa4

[0;1;31mTimed out while waiting for udev queue to empty.[0m
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/nfs-top ... do=
ne.
Begin: Running /scripts/nfs-premount ... Waiting up to 60 secs for any ethe=
rnet to become available

Full log:
   https://lava.sirena.org.uk/scheduler/job/2617478#L1124

bisect log:

# bad: [cf7c3c02fdd0dfccf4d6611714273dcb538af2cb] Add linux-next specific f=
iles for 20260330
# good: [a010730e610019b6d010ec43ce737cb59a37809d] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [3398da5432899c09712f30c92a154f3bf760a3e7] Merge branch 'clk-renesa=
s' into clk-next
# good: [777bc3284f0360c66ac75a44f35fc96053536ca4] Merge branch 'clk-cleanu=
p' into clk-next
# good: [f520a492e07bc6718e26cfb7543ab4cadd8bb0e2] clk: xgene: Fix mapping =
leak in xgene_pllclk_init()
# good: [aeb078cebc40d421f61a8f07b0e7919aeb44d751] arm64: dts: broadcom: bc=
m2712-d-rpi-5-b: add fixes for pinctrl/pinctrl_aon
# good: [9be71d462c33b1a00acfa4ab8f0f5332ed592817] firmware: cs_dsp: Simpli=
fy suppressing log messages during KUnit testing
# good: [7b3f8db159f710d432c4edc024fcefa9e62e8b4b] ASoC: fsl_xcvr: add bitc=
ount and timestamp controls
# good: [8fc5c7895185d1119ae76b509892a1d14e0bd483] ASoC: wm_adsp: Combine s=
ome similar code in firmware file search
# good: [981b080a79724738882b0af1c5bb7ade30d94f24] spi: fsl-qspi: Use reini=
t_completion() for repeated operations
# good: [ed0313223ce6514dbd39c049e25f702980d7e3cc] ASoC: codecs: wcd9335: R=
emove potential undefined behavior in wcd9335_slimbus_irq()
# good: [97af961568c8682c44506c9ad4b26c8a5455ec1d] ASoC: cs35l56: Put OTP r=
egister defines in correct address order
# good: [0a208adefecb287d22321054470d4619cb303839] ASoC: cs42l43: Add suppo=
rt for the B variant
# good: [a8075ada4a341ce58ebf8bef0188cefe6c2f6487] ASoC: ti: davinci-mcasp:=
 improve aux_div selection for mid-range dividers
# good: [82169065ffb07577075a5088b313d78673ded331] memory: tegra: Add MC er=
ror logging support for Tegra264
# good: [aa3d0c93a333182e887426366a4f3e5f06ee0d83] regulator: max20411: sho=
w failure on register
# good: [ef0b4783afc211a4b120e72b5a57f3d0340a9981] ASoC: cs35l56: KUnit tes=
ts for reading speaker ID from host GPIOs
# good: [e7662bced2e98ffa2c572126677deb9cf55d43b3] regcache: Move HW readba=
ck after cache initialisation
# good: [b1ef855c62601ed4de2c4b0ff75a075877e3dac8] regmap: Simplify devres =
handling
# good: [96f06d055ca03d1dfb5830fd07ff6eadbd66264c] spi: dt-bindings: mpfs-s=
pi: remove clock-names
# good: [2adac914c72b6cb5aba2612f49050c82aecd498e] ASoC: cs35l56-test: Add =
test cases without onchip pulls defined
# good: [f48e7a246a567e3764112e2463274c479d95cd96] ASoC: soc-core: Use guar=
d()/scoped_guard() for mutex lock
# good: [9891b52ba12e9d5fed5901b6b5f6e0cdcd424390] regcache: Factor out reg=
cache_hw_exit() helper
# good: [e84141846decb77d2826e553318a608b256804e5] regulator: pf9453: Allow=
 shared IRQ
# good: [9ab637ac5d3826606947f4e861107da958eda324] regcache: Amend printf()=
 specifiers when printing registers
# good: [34b4fc44e4f904fbb81335d53163ffdcb0180000] ASoC: soc_sdw_utils: rem=
ove index from sdca codec name
# good: [1696fad8b259a2d46e51cd6e17e4bcdbe02279fa] ASoC: sti: use managed r=
egmap_field allocations
# good: [d3b693a13b39bce16e284e1c737874966b3a96de] spi: spi-mem: clean up k=
ernel-doc in spi-mem.h
# good: [06dba254de95b16e7793224d29daa5195de2e581] ASoC: dt-bindings: nvidi=
a,tegra-audio-max9808x: document additional board pins
# good: [17c6bf433742e0c1ff5ce175145877c0194e4a7a] ASoC: cs35l45: Hibernate=
 wm_adsp on runtime suspend
# good: [da37bfe76b5b4ccc01ed8132215098e20d78e5f3] ASoC: cs42xx8: add error=
 checks for constraints in TDM mode
# good: [501efdcb3b3ab099fc0ce2f6e668b1c4095dd476] ASoC: SDCA: Pull the Q7.=
8 volume helpers out of soc-ops
# good: [2974aa42e6696a1d95b727d677dc01a71af5b998] ASoC: remove snd_soc_pcm=
_subclass
# good: [d90c0f78379454d51a428e312ac6db573060185c] regulator: cpcap-regulat=
or: add support for Mot regulators
# good: [5c74a008ffc62fc57a041602b4517519c8bf9436] firmware: cs_dsp: Mark K=
Unit test suites KUNIT_SPEED_SLOW
# good: [260c3fff1fefc570d8f23e87953e181d7d248861] ASoC: cs-amp-lib-test: S=
top including platform_device.h
# good: [7c12f6ead4672cb08b74e6f6115eb04dca8ccfa4] spi: tegra210-quad: Add =
runtime autosuspend support
# good: [37983fad7f3ef296fa0504c8e945987459dc5487] regmap: define cleanup h=
elper for regmap_field
# good: [ada32396f90951e12465224c04742607ca56a982] ASoC: SDCA: Add CS47L47 =
to class driver
# good: [e02902dd493bf9c9b05353c761737ac514ad7a5c] spi: add devm_spi_new_an=
cillary_device()
# good: [507a071d9868cb60e4e76f8a06fc8eb014f59ae4] spi: pxa2xx: use min() i=
nstead of min_t()
# good: [fed6e5084894373d76270cad4a32eb6479ad8247] spi: atcspi200: Remove r=
edundant assignment to .owner
# good: [5ebc20921b7fff9feb44de465448e17a382c9965] ASoC: tas2552: Allow aud=
io enable GPIO to sleep
# good: [171b3663f33e1efdc97f5112f49be10b47b20fa8] ASoC: codecs: aw88261: A=
dd firmware-name support
# good: [c2bcf62ca75c541ec4297e6ff02a68ddc2e02029] regcache: Split regcache=
_count_cacheable_registers() helper
# good: [0556bb42a84ee391a2145ddba86756f9747bc27f] regulator: pf0900: Make =
regu_irqs variable static const
# good: [d075cef4af6327a5de4bee7bf77591e3201e54f4] ASoC: simple-card-utils:=
 add sysclk ordering support
# good: [78dfbd4ad0be9f51de7b9a19388809254aeccd26] ASoC: Add quirk for Leco=
o Bellator N176
# good: [bf122191473e26a8f195308b1ba924c98424c8e1] ASoC: rt5677-spi: Add SP=
I device ID matching table
# good: [fbb4c52ccdcb4a612d2b7f800aa57090eeee16d7] regulator: spacemit-p1: =
Update supply names
git bisect start 'cf7c3c02fdd0dfccf4d6611714273dcb538af2cb' 'a010730e610019=
b6d010ec43ce737cb59a37809d' '3398da5432899c09712f30c92a154f3bf760a3e7' '777=
bc3284f0360c66ac75a44f35fc96053536ca4' 'f520a492e07bc6718e26cfb7543ab4cadd8=
bb0e2' 'aeb078cebc40d421f61a8f07b0e7919aeb44d751' '9be71d462c33b1a00acfa4ab=
8f0f5332ed592817' '7b3f8db159f710d432c4edc024fcefa9e62e8b4b' '8fc5c7895185d=
1119ae76b509892a1d14e0bd483' '981b080a79724738882b0af1c5bb7ade30d94f24' 'ed=
0313223ce6514dbd39c049e25f702980d7e3cc' '97af961568c8682c44506c9ad4b26c8a54=
55ec1d' '0a208adefecb287d22321054470d4619cb303839' 'a8075ada4a341ce58ebf8be=
f0188cefe6c2f6487' '82169065ffb07577075a5088b313d78673ded331' 'aa3d0c93a333=
182e887426366a4f3e5f06ee0d83' 'ef0b4783afc211a4b120e72b5a57f3d0340a9981' 'e=
7662bced2e98ffa2c572126677deb9cf55d43b3' 'b1ef855c62601ed4de2c4b0ff75a07587=
7e3dac8' '96f06d055ca03d1dfb5830fd07ff6eadbd66264c' '2adac914c72b6cb5aba261=
2f49050c82aecd498e' 'f48e7a246a567e3764112e2463274c479d95cd96' '9891b52ba12=
e9d5fed5901b6b5f6e0cdcd424390' 'e84141846decb77d2826e553318a608b256804e5' '=
9ab637ac5d3826606947f4e861107da958eda324' '34b4fc44e4f904fbb81335d53163ffdc=
b0180000' '1696fad8b259a2d46e51cd6e17e4bcdbe02279fa' 'd3b693a13b39bce16e284=
e1c737874966b3a96de' '06dba254de95b16e7793224d29daa5195de2e581' '17c6bf4337=
42e0c1ff5ce175145877c0194e4a7a' 'da37bfe76b5b4ccc01ed8132215098e20d78e5f3' =
'501efdcb3b3ab099fc0ce2f6e668b1c4095dd476' '2974aa42e6696a1d95b727d677dc01a=
71af5b998' 'd90c0f78379454d51a428e312ac6db573060185c' '5c74a008ffc62fc57a04=
1602b4517519c8bf9436' '260c3fff1fefc570d8f23e87953e181d7d248861' '7c12f6ead=
4672cb08b74e6f6115eb04dca8ccfa4' '37983fad7f3ef296fa0504c8e945987459dc5487'=
 'ada32396f90951e12465224c04742607ca56a982' 'e02902dd493bf9c9b05353c761737a=
c514ad7a5c' '507a071d9868cb60e4e76f8a06fc8eb014f59ae4' 'fed6e5084894373d762=
70cad4a32eb6479ad8247' '5ebc20921b7fff9feb44de465448e17a382c9965' '171b3663=
f33e1efdc97f5112f49be10b47b20fa8' 'c2bcf62ca75c541ec4297e6ff02a68ddc2e02029=
' '0556bb42a84ee391a2145ddba86756f9747bc27f' 'd075cef4af6327a5de4bee7bf7759=
1e3201e54f4' '78dfbd4ad0be9f51de7b9a19388809254aeccd26' 'bf122191473e26a8f1=
95308b1ba924c98424c8e1' 'fbb4c52ccdcb4a612d2b7f800aa57090eeee16d7'
# test job: [3398da5432899c09712f30c92a154f3bf760a3e7] https://lava.sirena.=
org.uk/scheduler/job/2608225
# test job: [777bc3284f0360c66ac75a44f35fc96053536ca4] https://lava.sirena.=
org.uk/scheduler/job/2608418
# test job: [f520a492e07bc6718e26cfb7543ab4cadd8bb0e2] https://lava.sirena.=
org.uk/scheduler/job/2608110
# test job: [aeb078cebc40d421f61a8f07b0e7919aeb44d751] https://lava.sirena.=
org.uk/scheduler/job/2579214
# test job: [9be71d462c33b1a00acfa4ab8f0f5332ed592817] https://lava.sirena.=
org.uk/scheduler/job/2548706
# test job: [7b3f8db159f710d432c4edc024fcefa9e62e8b4b] https://lava.sirena.=
org.uk/scheduler/job/2548248
# test job: [8fc5c7895185d1119ae76b509892a1d14e0bd483] https://lava.sirena.=
org.uk/scheduler/job/2548893
# test job: [981b080a79724738882b0af1c5bb7ade30d94f24] https://lava.sirena.=
org.uk/scheduler/job/2545092
# test job: [ed0313223ce6514dbd39c049e25f702980d7e3cc] https://lava.sirena.=
org.uk/scheduler/job/2544887
# test job: [97af961568c8682c44506c9ad4b26c8a5455ec1d] https://lava.sirena.=
org.uk/scheduler/job/2543911
# test job: [0a208adefecb287d22321054470d4619cb303839] https://lava.sirena.=
org.uk/scheduler/job/2542875
# test job: [a8075ada4a341ce58ebf8bef0188cefe6c2f6487] https://lava.sirena.=
org.uk/scheduler/job/2540933
# test job: [82169065ffb07577075a5088b313d78673ded331] https://lava.sirena.=
org.uk/scheduler/job/2582197
# test job: [aa3d0c93a333182e887426366a4f3e5f06ee0d83] https://lava.sirena.=
org.uk/scheduler/job/2531504
# test job: [ef0b4783afc211a4b120e72b5a57f3d0340a9981] https://lava.sirena.=
org.uk/scheduler/job/2530821
# test job: [e7662bced2e98ffa2c572126677deb9cf55d43b3] https://lava.sirena.=
org.uk/scheduler/job/2530804
# test job: [b1ef855c62601ed4de2c4b0ff75a075877e3dac8] https://lava.sirena.=
org.uk/scheduler/job/2531890
# test job: [96f06d055ca03d1dfb5830fd07ff6eadbd66264c] https://lava.sirena.=
org.uk/scheduler/job/2523404
# test job: [2adac914c72b6cb5aba2612f49050c82aecd498e] https://lava.sirena.=
org.uk/scheduler/job/2523920
# test job: [f48e7a246a567e3764112e2463274c479d95cd96] https://lava.sirena.=
org.uk/scheduler/job/2522185
# test job: [9891b52ba12e9d5fed5901b6b5f6e0cdcd424390] https://lava.sirena.=
org.uk/scheduler/job/2522240
# test job: [e84141846decb77d2826e553318a608b256804e5] https://lava.sirena.=
org.uk/scheduler/job/2516913
# test job: [9ab637ac5d3826606947f4e861107da958eda324] https://lava.sirena.=
org.uk/scheduler/job/2516426
# test job: [34b4fc44e4f904fbb81335d53163ffdcb0180000] https://lava.sirena.=
org.uk/scheduler/job/2513607
# test job: [1696fad8b259a2d46e51cd6e17e4bcdbe02279fa] https://lava.sirena.=
org.uk/scheduler/job/2514118
# test job: [d3b693a13b39bce16e284e1c737874966b3a96de] https://lava.sirena.=
org.uk/scheduler/job/2511841
# test job: [06dba254de95b16e7793224d29daa5195de2e581] https://lava.sirena.=
org.uk/scheduler/job/2513766
# test job: [17c6bf433742e0c1ff5ce175145877c0194e4a7a] https://lava.sirena.=
org.uk/scheduler/job/2513835
# test job: [da37bfe76b5b4ccc01ed8132215098e20d78e5f3] https://lava.sirena.=
org.uk/scheduler/job/2511899
# test job: [501efdcb3b3ab099fc0ce2f6e668b1c4095dd476] https://lava.sirena.=
org.uk/scheduler/job/2500586
# test job: [2974aa42e6696a1d95b727d677dc01a71af5b998] https://lava.sirena.=
org.uk/scheduler/job/2502174
# test job: [d90c0f78379454d51a428e312ac6db573060185c] https://lava.sirena.=
org.uk/scheduler/job/2500322
# test job: [5c74a008ffc62fc57a041602b4517519c8bf9436] https://lava.sirena.=
org.uk/scheduler/job/2496391
# test job: [260c3fff1fefc570d8f23e87953e181d7d248861] https://lava.sirena.=
org.uk/scheduler/job/2494171
# test job: [7c12f6ead4672cb08b74e6f6115eb04dca8ccfa4] https://lava.sirena.=
org.uk/scheduler/job/2488528
# test job: [37983fad7f3ef296fa0504c8e945987459dc5487] https://lava.sirena.=
org.uk/scheduler/job/2489154
# test job: [ada32396f90951e12465224c04742607ca56a982] https://lava.sirena.=
org.uk/scheduler/job/2489236
# test job: [e02902dd493bf9c9b05353c761737ac514ad7a5c] https://lava.sirena.=
org.uk/scheduler/job/2489718
# test job: [507a071d9868cb60e4e76f8a06fc8eb014f59ae4] https://lava.sirena.=
org.uk/scheduler/job/2486375
# test job: [fed6e5084894373d76270cad4a32eb6479ad8247] https://lava.sirena.=
org.uk/scheduler/job/2484717
# test job: [5ebc20921b7fff9feb44de465448e17a382c9965] https://lava.sirena.=
org.uk/scheduler/job/2485130
# test job: [171b3663f33e1efdc97f5112f49be10b47b20fa8] https://lava.sirena.=
org.uk/scheduler/job/2482581
# test job: [c2bcf62ca75c541ec4297e6ff02a68ddc2e02029] https://lava.sirena.=
org.uk/scheduler/job/2483282
# test job: [0556bb42a84ee391a2145ddba86756f9747bc27f] https://lava.sirena.=
org.uk/scheduler/job/2483207
# test job: [d075cef4af6327a5de4bee7bf77591e3201e54f4] https://lava.sirena.=
org.uk/scheduler/job/2483468
# test job: [78dfbd4ad0be9f51de7b9a19388809254aeccd26] https://lava.sirena.=
org.uk/scheduler/job/2483108
# test job: [bf122191473e26a8f195308b1ba924c98424c8e1] https://lava.sirena.=
org.uk/scheduler/job/2482758
# test job: [fbb4c52ccdcb4a612d2b7f800aa57090eeee16d7] https://lava.sirena.=
org.uk/scheduler/job/2482462
# test job: [cf7c3c02fdd0dfccf4d6611714273dcb538af2cb] https://lava.sirena.=
org.uk/scheduler/job/2617478
# bad: [cf7c3c02fdd0dfccf4d6611714273dcb538af2cb] Add linux-next specific f=
iles for 20260330
git bisect bad cf7c3c02fdd0dfccf4d6611714273dcb538af2cb
# test job: [c99ea8b71328bb73baf24b2fb1591e076f1617a1] https://lava.sirena.=
org.uk/scheduler/job/2608073
# bad: [c99ea8b71328bb73baf24b2fb1591e076f1617a1] Merge branch 'clk-rpi' in=
to clk-next
git bisect bad c99ea8b71328bb73baf24b2fb1591e076f1617a1
# test job: [672299736af6c398e867782708b7400957e62c76] https://lava.sirena.=
org.uk/scheduler/job/2608599
# bad: [672299736af6c398e867782708b7400957e62c76] clk: bcm: rpi: Manage clo=
ck rate in prepare/unprepare callbacks
git bisect bad 672299736af6c398e867782708b7400957e62c76
# first bad commit: [672299736af6c398e867782708b7400957e62c76] clk: bcm: rp=
i: Manage clock rate in prepare/unprepare callbacks
# test job: [672299736af6c398e867782708b7400957e62c76] https://lava.sirena.=
org.uk/scheduler/job/2608599
# bad: [672299736af6c398e867782708b7400957e62c76] clk: bcm: rpi: Manage clo=
ck rate in prepare/unprepare callbacks
git bisect bad 672299736af6c398e867782708b7400957e62c76
# first bad commit: [672299736af6c398e867782708b7400957e62c76] clk: bcm: rp=
i: Manage clock rate in prepare/unprepare callbacks

--OWkifeB2LU4jLg/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnLwtMACgkQJNaLcl1U
h9BJxgf/T0I9RCwzdF9RU0lB7BTwecfv31gB3N8KWs5AItPM90caF5KECh1txPBO
nNZANlFFqEuBQwm14e0ld9ySySY7Tk35/0fx+PefGJMHk//JEB+MKHBNsy/xo8u2
djQyJF3ZOs6+HYU0YecolEY5ZJHV9SaHTx7WjEP0G23GxLqy+wSd9Tc9XwU1VWtl
TM62RnDzFTP/TAvAoU6ALs80vuQa499X0TC70PMBU1R5VdCWg/zDylePvJh9PQzq
Pwb9T5s3kPIjHlOBIrTN3ipKTl85SnH3W9wamfOGkRQs1alnIBKiu6Sj5sflttC2
SJMTecpd4svfkM49bfcaD/zOgDfnmg==
=uzPe
-----END PGP SIGNATURE-----

--OWkifeB2LU4jLg/s--
