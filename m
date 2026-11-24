Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88A606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=mieulab.com header.i=@mieulab.com header.a=rsa-sha256 header.s=key1 header.b=GbATP9hD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249A410E488;
	Wed, 25 Nov 2026 08:41:21 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Tue, 24 Nov 2026 14:25:49 UTC
Received: from mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF8910F6C8
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:25:49 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=at2l4hyefMFBjvEBt+mjQCsOg/L6cPmcUTA7lPCIczs=; 
 c=simple/simple; d=mieulab.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795530348; v=1; x=1796135148;
 b=GbATP9hD0INAgx/vMaNAyOQrmRLRqwy8xq0HAMNVqnFtbsceyIYlO95Krpuf3oogEt3Y/DkZ
 jmdjJobwNNeW27JLC5d/29jCt4h36SCPn+GNTLZTehyVsq9uxCk1pyOBHiGIJ0Wf5k6FlJhbLWf
 X6dQbO8KKeF2bnD2ivqypZsiDcZrz4JusNniYycjC8GkPJ+4c9CQkB+44rI1ykmeOFxfWIarZje
 e+thpLwDn2xHbhVULvKOrG7xl4uUm7ztakyY08c9JuUovvTJUlEZYI+2gTb/SEhCR3Tl3ZyGWSK
 BpfSqvqA8mQBc2ZxmESDfEV3x084nYNb+z4F9BFOAuMoA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id b49e7fe12a7443e9;
 Tue, 24 Nov 2026 14:19:39 +0000
X-Mizu-Trace-ID: b49e7fe12a7443e9
X-Migadu-Flow: FLOW_OUT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 14:19:39 +0000
Content-Type: multipart/alternative;
 boundary="62441641-b8b8-4003-bafb-fc34d2d4a03d-1"
From: zinan@mieulab.com
Message-ID: <ac5ef957c03ab3bf3fdb464680f3b024a883aefa@mieulab.com>
TLS-Required: No
Subject: Re: [RFC PATCH 0/2] drm/meson: add HDMI support for GXLX2
To: "Neil Armstrong" <neil.armstrong@linaro.org>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Kevin
 Hilman" <khilman@baylibre.com>, "Jerome Brunet" <jbrunet@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260718111527.119231-1-zinan@mieulab.com>
References: <20260718111527.119231-1-zinan@mieulab.com>
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--62441641-b8b8-4003-bafb-fc34d2d4a03d-1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil and all,

Following up on this GXLX2 HDMI RFC from July. Since then, users have rep=
orted working HDMI output on several
S905L3-family boxes with a downstream implementation, including a P291 bo=
ard. Their reports are here:

https://github.com/ophub/amlogic-s9xxx-armbian/issues/3604

Before I refresh the series, would you recommend keeping the proposed aml=
ogic,meson-gxlx2-dw-hdmi compatible and a
single MMIO resource for DWC and TOP, or describing the two windows as se=
parate named resources?

Thanks,
Zinan


July 18, 2026 at 8:15 PM, "Zinan Zhou" <zinan@mieulab.com mailto:zinan@mi=
eulab.com?to=3D%22Zinan%20Zhou%22%20%3Czinan%40mieulab.com%3E > wrote:


>=20
>=20This RFC adds HDMI transmitter support for the Amlogic GXLX2 family,
> observed as an S905L3 (CPU major ID 0x2a) in a FiberHome HG680-LC set-t=
op
> box.
>=20
>=20GXLX2 is unusual in that the display pipeline, clocks and HDMI PHY fo=
llow
> the older GXL path, while the HDMI controller register interface is
> directly mapped: DWC registers are byte-addressed from 0xda800000 and T=
OP
> registers are 32-bit registers at 0xda808000 + index * 4. The existing
> G12A access callbacks implement this layout, but using all G12A match d=
ata
> would select the wrong PHY initialization for GXLX2.
>=20
>=20Patch 1 proposes a dedicated amlogic,meson-gxlx2-dw-hdmi compatible
> without a meson-gx-dw-hdmi fallback. Patch 2 adds dedicated match data
> combining direct register callbacks with GXL PHY behavior. It also hand=
les
> the GXLX2 value for the 297 MHz PHY bucket and adds the compatible to t=
he
> Meson DRM component match list.
>=20
>=20This RFC depends on the separately posted common Meson DW-HDMI regmap=
 fix:
>=20
>=20 drm/meson: constrain the DW-HDMI regmap range
>  https://lore.kernel.org/all/20260718090710.70534-1-zinan@mieulab.com/
>=20
>=20That formal bug-fix patch bounds register iteration below the directl=
y
> mapped TOP block and prevents the legacy 16-bit indirect interface from
> wrapping. It is intentionally not part of this RFC so it can be reviewe=
d
> and merged without waiting for agreement on the GXLX2 DT ABI.
>=20
>=20I would particularly appreciate feedback on two DT ABI questions:
>=20
>=201. Is amlogic,meson-gxlx2-dw-hdmi the appropriate block compatible na=
me?
> 2. Should the DWC and TOP windows be represented as one contiguous MMIO
>  resource, as in this RFC, or as two named resources?
>=20
>=20Evidence and disclosure:
>=20
>=20- The GXLX2 addresses and 297 MHz value are factual results of analys=
is of
>  the HG680-LC vendor kernel. Firmware SHA-256 and focused behavioral
>  evidence can be supplied if useful, but no firmware, kallsyms dump or
>  disassembly is part of this submission.
> - Public Amlogic-derived GPL source documents the ordinary GXL 2.97 Gbp=
s
>  values and public GPL-2.0+/MIT source documents the same direct DWC/TO=
P
>  access mechanism used on later SoCs. The implementation here does not
>  copy a vendor function body.
>=20
>=20Testing:
>=20
>=20- An equivalent Linux 6.6.18 implementation boots from eMMC on the
>  HG680-LC.
> - 1920x1080 HDMI video was physically verified on an LG 27GL850.
> - Two-channel HDMI LPCM through the display and analog stereo audio wer=
e
>  physically verified.
> - The downstream 6.12 port boots from eMMC with working Ethernet/SSH an=
d
>  has physically verified 1920x1080@60 video and HDMI LPCM.
> - With the generic Meson non-CEA mode-range change already present in
>  current mainline, 2560x1440@59.95 video and HDMI LPCM were physically
>  verified on the display's native timing.
> - The RFC port builds on arm64 and its binding passes dt_binding_check.
> - 3840x2160 at 30 Hz has not yet been physically tested. That test is
>  required before a non-RFC PATCH v1 because it exercises the
>  GXLX2-specific 297 MHz branch. It is not a blocker for the verified
>  1080p/1440p use case.
> - No other GXLX2 board has been tested yet.
>=20
>=20The initial RFC intentionally contains no board DTS. A downstream-onl=
y
> HG680-LC DTS is being kept as DO NOT MERGE until the compatible and res=
ource
> model have received initial feedback.
>=20
>=20Assisted-by: Codex:gpt-5.6-sol
>=20
>=20Zinan Zhou (2):
>  dt-bindings: display: meson-dw-hdmi: add GXLX2 compatible
>  drm/meson: add GXLX2 HDMI register support
>=20
>=20 .../display/amlogic,meson-dw-hdmi.yaml | 7 ++--
>  drivers/gpu/drm/meson/meson_drv.c | 1 +
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 33 ++++++++++++++++---
>  3 files changed, 34 insertions(+), 7 deletions(-)
>=20
>=20base-commit: b0a652436b892eb9a036a031b33099dca036faaa
> prerequisite-patch-id: 0a689485bbc3c1d77d52aeee0b81e4943d1e904a
> --=20
>=202.43.0
>
--62441641-b8b8-4003-bafb-fc34d2d4a03d-1
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><meta http-equiv=3D"Content-Type" content=3D"t=
ext/html; charset=3Dutf-8"></head><body><div>Hi Neil and all,
</div><div><br></div><div>Following up on this GXLX2 HDMI RFC from July. =
Since then, users have reported working HDMI output on several
</div><div>S905L3-family boxes with a downstream implementation, includin=
g a P291 board. Their reports are here:
</div><div>
</div><div><a href=3D"https://github.com/ophub/amlogic-s9xxx-armbian/issu=
es/3604">https://github.com/ophub/amlogic-s9xxx-armbian/issues/3604</a>
</div><div>
</div><div>Before I refresh the series, would you recommend keeping the p=
roposed amlogic,meson-gxlx2-dw-hdmi compatible and a
</div><div>single MMIO resource for DWC and TOP, or describing the two wi=
ndows as separate named resources?</div><div><br></div><div>
</div><div>
</div><div>Thanks,
</div><div>Zinan<br></div><p>July 18, 2026 at 8:15 PM, "Zinan Zhou" &lt;<=
a href=3D"mailto:zinan@mieulab.com?to=3D%22Zinan%20Zhou%22%20%3Czinan%40m=
ieulab.com%3E" tabindex=3D"-1" target=3D"_blank">zinan@mieulab.com</a>&gt=
; wrote:</p><blockquote>This RFC adds HDMI transmitter support for the Am=
logic GXLX2 family,<br>observed as an S905L3 (CPU major ID 0x2a) in a Fib=
erHome HG680-LC set-top<br>box.<br><br>GXLX2 is unusual in that the displ=
ay pipeline, clocks and HDMI PHY follow<br>the older GXL path, while the =
HDMI controller register interface is<br>directly mapped: DWC registers a=
re byte-addressed from 0xda800000 and TOP<br>registers are 32-bit registe=
rs at 0xda808000 + index * 4. The existing<br>G12A access callbacks imple=
ment this layout, but using all G12A match data<br>would select the wrong=
 PHY initialization for GXLX2.<br><br>Patch 1 proposes a dedicated amlogi=
c,meson-gxlx2-dw-hdmi compatible<br>without a meson-gx-dw-hdmi fallback. =
Patch 2 adds dedicated match data<br>combining direct register callbacks =
with GXL PHY behavior. It also handles<br>the GXLX2 value for the 297 MHz=
 PHY bucket and adds the compatible to the<br>Meson DRM component match l=
ist.<br><br>This RFC depends on the separately posted common Meson DW-HDM=
I regmap fix:<br><br>  drm/meson: constrain the DW-HDMI regmap range<br> =
 <a href=3D"https://lore.kernel.org/all/20260718090710.70534-1-zinan@mieu=
lab.com/" tabindex=3D"-1" target=3D"_blank">https://lore.kernel.org/all/2=
0260718090710.70534-1-zinan@mieulab.com/</a><br><br>That formal bug-fix p=
atch bounds register iteration below the directly<br>mapped TOP block and=
 prevents the legacy 16-bit indirect interface from<br>wrapping. It is in=
tentionally not part of this RFC so it can be reviewed<br>and merged with=
out waiting for agreement on the GXLX2 DT ABI.<br><br>I would particularl=
y appreciate feedback on two DT ABI questions:<br><br>1. Is amlogic,meson=
-gxlx2-dw-hdmi the appropriate block compatible name?<br>2. Should the DW=
C and TOP windows be represented as one contiguous MMIO<br>   resource, a=
s in this RFC, or as two named resources?<br><br>Evidence and disclosure:=
<br><br>- The GXLX2 addresses and 297 MHz value are factual results of an=
alysis of<br>  the HG680-LC vendor kernel. Firmware SHA-256 and focused b=
ehavioral<br>  evidence can be supplied if useful, but no firmware, kalls=
yms dump or<br>  disassembly is part of this submission.<br>- Public Amlo=
gic-derived GPL source documents the ordinary GXL 2.97 Gbps<br>  values a=
nd public GPL-2.0+/MIT source documents the same direct DWC/TOP<br>  acce=
ss mechanism used on later SoCs. The implementation here does not<br>  co=
py a vendor function body.<br><br>Testing:<br><br>- An equivalent Linux 6=
.6.18 implementation boots from eMMC on the<br>  HG680-LC.<br>- 1920x1080=
 HDMI video was physically verified on an LG 27GL850.<br>- Two-channel HD=
MI LPCM through the display and analog stereo audio were<br>  physically =
verified.<br>- The downstream 6.12 port boots from eMMC with working Ethe=
rnet/SSH and<br>  has physically verified 1920x1080@60 video and HDMI LPC=
M.<br>- With the generic Meson non-CEA mode-range change already present =
in<br>  current mainline, 2560x1440@59.95 video and HDMI LPCM were physic=
ally<br>  verified on the display's native timing.<br>- The RFC port buil=
ds on arm64 and its binding passes dt_binding_check.<br>- 3840x2160 at 30=
 Hz has not yet been physically tested. That test is<br>  required before=
 a non-RFC PATCH v1 because it exercises the<br>  GXLX2-specific 297 MHz =
branch. It is not a blocker for the verified<br>  1080p/1440p use case.<b=
r>- No other GXLX2 board has been tested yet.<br><br>The initial RFC inte=
ntionally contains no board DTS. A downstream-only<br>HG680-LC DTS is bei=
ng kept as DO NOT MERGE until the compatible and resource<br>model have r=
eceived initial feedback.<br><br>Assisted-by: Codex:gpt-5.6-sol<br><br>Zi=
nan Zhou (2):<br>  dt-bindings: display: meson-dw-hdmi: add GXLX2 compati=
ble<br>  drm/meson: add GXLX2 HDMI register support<br><br> .../display/a=
mlogic,meson-dw-hdmi.yaml        |  7 ++--<br> drivers/gpu/drm/meson/meso=
n_drv.c             |  1 +<br> drivers/gpu/drm/meson/meson_dw_hdmi.c     =
    | 33 ++++++++++++++++---<br> 3 files changed, 34 insertions(+), 7 del=
etions(-)<br><br><br>base-commit: b0a652436b892eb9a036a031b33099dca036faa=
a<br>prerequisite-patch-id: 0a689485bbc3c1d77d52aeee0b81e4943d1e904a<br>-=
- <br>2.43.0</blockquote><div><br></div></body></html>
--62441641-b8b8-4003-bafb-fc34d2d4a03d-1--
