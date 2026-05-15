Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D1FCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A43410E0E1;
	Fri, 15 May 2026 09:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="G9l0ffmv";
	dkim-atps=neutral
X-Greylist: delayed 504 seconds by postgrey-1.36 at gabe;
 Fri, 15 May 2026 09:35:48 UTC
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA14E10E0E1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:35:48 +0000 (UTC)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
 s=key1; t=1778837242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wkqU5nqKWTIVrSrlwa2ijV+50Ew3qQdlXh1W5GNiI6Y=;
 b=G9l0ffmvrtA4Zf8COr+my1FshdP4by8FSoXyG9uvoR95floWSI8b3I+KOL7hURxeOdY+YM
 EccYaBB/Ua0rTM7umnPs/m1RfZFFvXSw5OfzoAva8eojD4GA1BAV1SPwbp2tjf/BEohmXL
 QhC2guUC8OUsXYGwbnxOIzPqpqU0XZQeJxhLgxQnN2AAN6uWPInB5MpdY5VVBmd/SkJGBJ
 MCJMJLZ1q48jpk1Ng2wyMxBEzJSOLcxO5Pv5ftEsZdkyzRsW/4B+zcWKIh6xznsC/5nb2X
 qVNmFSumPprmAZ9Pa4aUYhrpvdOwBHvhJ5kmzPwkwfc/5FmWTZz+mstYCnvCJA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 May 2026 11:27:01 +0200
Message-Id: <DIJ5622KU06C.2KOK2EVAMP0NX@cknow-tech.com>
Cc: "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Liu Ying" <victor.liu@nxp.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Sandy Huang"
 <hjc@rock-chips.com>, "Andy Yan" <andy.yan@rock-chips.com>, "Chen-Yu Tsai"
 <wens@kernel.org>, "Christian Hewitt" <christianshewitt@gmail.com>,
 "Diederik de Haas" <diederik@cknow-tech.com>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <imx@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/21] drm: bridge: dw_hdmi: Misc enable/disable, CEC
 and EDID cleanup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Jonas Karlman" <jonas@kwiboo.se>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>
References: <20260510124111.1226584-1-jonas@kwiboo.se>
In-Reply-To: <20260510124111.1226584-1-jonas@kwiboo.se>
X-Migadu-Flow: FLOW_OUT
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

Hi Jonas,

On Sun May 10, 2026 at 2:42 PM CEST, Jonas Karlman wrote:
> This is a revival of an old dw-hdmi series and is the first series part
> of a new effort to upstream old LibreELEC HDMI 2.0 patches for Rockchip
> RK33xx devices.
>
> This series ensure poweron/poweroff and CEC phys addr invalidation is
> happening under drm mode_config mutex lock, and also ensure EDID is
> updated after a HPD low voltage pulse by changing to debounce hotplug
> processing.
>
> These changes have mainly been tested on Rockchip RK3328, RK3399 and
> RK3568 devices using both the dw-hdmi connector and also using a basic
> convert to use a bridge connector.

Yesterday I made a test run and the TL;DR is this:

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock64, RockPro64,=
 Quartz64-B

The longer version ...

Test setup:
I have a 1080p monitor capable of HDMI 1.4 (I think) and a 4K TV capable of
HDMI 2.0 (but not 2.1). I'm running Debian Testing/Sid on them with Sway
1.12-rc3-1 (from Experimental) and see if that works (at all) and then I tr=
y to
play one or more of my 'test' videos with mpv and using v4l2request HW acce=
l.
I used 2 kernels: 7.1-rc3 and 7.1-rc3 with this patch set.

One of the possible issues that may have been fixed with this patch set is
doing hotplugging of the HDMI connection, especially going from 4K to 1080p=
.
So when testing I unplugged my 4K cable and plugged in the 1080p cable and
looked if it has adjusted things properly. I also checked dmesg to see if
there were interesting msgs.

> Testing with a Rock Pi 4 (RK3399) using a Raspberry Pi Monitor with
> Linux kms client console using drm.debug=3D0xe should log something like
> following:
>
>  Power cycle monitor using the power button:
>   [CONNECTOR:68:HDMI-A-1] CEA VCDB 0x4a
>   [CONNECTOR:68:HDMI-A-1] HDMI: DVI dual 0, max TMDS clock 0 kHz
>   [CONNECTOR:68:HDMI-A-1] ELD monitor RPI MON156
>   [CONNECTOR:68:HDMI-A-1] HDMI: latency present 0 0, video latency 0 0, a=
udio latency 0 0
>   [CONNECTOR:68:HDMI-A-1] ELD size 36, SAD count 1
>   [CONNECTOR:68:HDMI-A-1] Same epoch counter 10
> =20
>  Cable unplugged:
>   [CONNECTOR:68:HDMI-A-1] EDID changed, epoch counter 11
>   [CONNECTOR:68:HDMI-A-1] status updated from connected to disconnected
>   [CONNECTOR:68:HDMI-A-1] Changed epoch counter 10 =3D> 12
>   [CONNECTOR:68:HDMI-A-1] generating connector hotplug event
>   [CONNECTOR:68:HDMI-A-1] Sent hotplug event

When I was preparing my testing session the 'Sent hotplug event' caught my =
eye
as it seemed like a clear differentiator between the kernel with and withou=
t
this patch set.
Unfortunately during my 'real' testing session I did not see that message .=
..

>  Cable connected:
>   [CONNECTOR:68:HDMI-A-1] CEA VCDB 0x4a
>   [CONNECTOR:68:HDMI-A-1] HDMI: DVI dual 0, max TMDS clock 0 kHz
>   [CONNECTOR:68:HDMI-A-1] ELD monitor RPI MON156
>   [CONNECTOR:68:HDMI-A-1] HDMI: latency present 0 0, video latency 0 0, a=
udio latency 0 0
>   [CONNECTOR:68:HDMI-A-1] ELD size 36, SAD count 1
>   [CONNECTOR:68:HDMI-A-1] status updated from disconnected to connected
>   [CONNECTOR:68:HDMI-A-1] Changed epoch counter 12 =3D> 13
>   [CONNECTOR:68:HDMI-A-1] generating connector hotplug event
>   [CONNECTOR:68:HDMI-A-1] Sent hotplug event

... but I did see all the others. With my 4K TV I got
``max TMDS clock 300000 kHz``
but on my 1080p monitor I got 0 kHz just like quoted above.

I also checked CEC and EDID with the following commands:
- ``cat /sys/kernel/debug/cec/cec0/status``
- ``di-edid-decode /sys/devices/platform/display-subsystem/drm/card0/card0-=
HDMI-A-1/edid``

And in all cases they produced identical outputs.

Rock64 testing:

On the Rock64 I got a stack trace:

```sh
root@rock64-test:~# dmesg --level 4
[    2.302852] dw-apb-uart ff130000.serial: forbid DMA for kernel console
[    5.068434] dw_wdt ff1a0000.watchdog: No valid TOPs array specified
[    5.841772] dwc2 ff580000.usb: supply vusb_d not found, using dummy regu=
lator
[    5.842752] dwc2 ff580000.usb: supply vusb_a not found, using dummy regu=
lator
[    7.392797] ------------[ cut here ]------------
[    7.393236] WARNING: drivers/media/cec/core/cec-adap.c:1116 at cec_recei=
ved_msg_ts+0x530/0xc10 [cec], CPU#0: irq/50-dw-hdmi-/186
[    7.394811] Modules linked in: dw_hdmi_cec(+) hid_generic usbhid rockchi=
pdrm hid dw_hdmi_qp dw_mipi_dsi realtek dw_hdmi phy_package analogix_dp drm=
_dp_aux_bus dwmac_rk drm_display_helper stmmac_platform xhci_plat_hcd stmma=
c cec rc_core xhci_hcd pcs_xpcs drm_client_lib phylink rtc_rk808 drm_dma_he=
lper ohci_platform rk808_regulator mdio_devres dwc2 of_mdio drm_kms_helper =
ehci_platform dwc3 ehci_hcd fixed_phy udc_core ohci_hcd drm fwnode_mdio usb=
core libphy syscon_reboot_mode ulpi gpio_rockchip phy_rockchip_inno_usb2 dw=
_mmc_rockchip reboot_mode io_domain gpio_syscon mdio_bus dw_mmc_pltfm fixed=
 usb_common dw_wdt dw_mmc phy_rockchip_inno_hdmi spi_rockchip nvmem_rockchi=
p_efuse i2c_rk3x pl330
[    7.404613] CPU: 0 UID: 0 PID: 186 Comm: irq/50-dw-hdmi- Not tainted 7.1=
-rc3+unreleased-arm64-cknow #1 PREEMPTLAZY  Debian 7.1~rc3-2
[    7.406138] Hardware name: Pine64 Rock64 (DT)
[    7.406725] pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    7.407634] pc : cec_received_msg_ts+0x530/0xc10 [cec]
[    7.408344] lr : dw_hdmi_cec_thread+0x98/0xb8 [dw_hdmi_cec]
[    7.409095] sp : ffff8000809e3cc0
[    7.409552] x29: ffff8000809e3d30 x28: 0000000000000000 x27: 00000000000=
00000
[    7.410500] x26: ffff0000faae44ac x25: ffffa02b5edaf370 x24: ffff00000bd=
9f6a0
[    7.411447] x23: ffffa02b60e3e000 x22: ffff0000faae4400 x21: 00000000000=
00001
[    7.412392] x20: ffff0000faae4400 x19: ffff00000a887800 x18: ffff5fd59d9=
c7000
[    7.413333] x17: 0000000061dcb992 x16: ffffa02b5edf4d88 x15: ffffa02b60e=
421d0
[    7.414256] x14: ffffa02b60d5a100 x13: 00000000000000c0 x12: ffff0000fe7=
21100
[    7.415175] x11: 00000000000000c0 x10: 0000000000000db0 x9 : ffffa02af03=
675c8
[    7.416095] x8 : ffff0000fa3f0e10 x7 : 0000000000000000 x6 : 00000000000=
00010
[    7.417011] x5 : ffff5fd59d9c7000 x4 : ffff000000c7ccc0 x3 : ffff00000bd=
9f680
[    7.417927] x2 : 00000001b8300c79 x1 : 00000000ffffffff x0 : 00000000000=
00000
[    7.418845] Call trace:
[    7.419174]  cec_received_msg_ts+0x530/0xc10 [cec] (P)
[    7.419855]  dw_hdmi_cec_thread+0x98/0xb8 [dw_hdmi_cec]
[    7.420536]  irq_thread_fn+0x30/0xc0
[    7.421021]  irq_thread+0x19c/0x3e8
[    7.421491]  kthread+0x134/0x150
[    7.421925]  ret_from_fork+0x10/0x20
[    7.422405] ---[ end trace 0000000000000000 ]---
[   23.252709] rockchip-i2s ff000000.i2s: using zero-initialized flat cache=
, this may cause unexpected behavior
```

This was with the kernel *with* this patch set (and connected to 4K TV; no
idea if that's relevant though).
But I did not see any adverse affects from it and when I tried again today,
I did NOT get a/that stack trace.

The Rock64 was the device which showed most clearly the difference between
having this patch set applied or not.
As always, I started with the kernel without this patch set and booted it u=
p
connected to my 4K TV. Then I logged into a Sway session via greetd (thus ~
also Sway) and everything looked fine*.
I then tried hotplugging the HDMI from my 4K TV to my 1080p monitor ... and=
 I
did NOT get any output on my monitor. I didn't even see any message in dmes=
g
that it noticed that first a cable got unplugged and later another cable go=
t
plugged. My monitor itself did notice when I then unplugged the cable again=
.
When I then plugged the 4K cable back in, my TV showed Sway like before and
AFAICT everything was working again.

When I booted into the kernel WITH this patch set, hotplugging back and for=
th
worked absolutely fine :-D The screen resolution got adjusted to the new on=
e
and dmesg noticed the unplugging and plugging actions and it showed similar
messages as Jonas showed in his cover page (and quoted above).
With the exception of 'Sent hotplug event' as mentioned above.

*) There are pretty substantial artifacts which are AFAIUI due to the
not-exactly-fast GPU and memory, but that's unrelated to this patch set.
Playing a HW accelerated video full-screen often works pretty decently.

RockPro64 testing:

I can be much shorter about the RockPro64.
Everything seemed to work just fine with and without this patch set applied=
. So
no improvement, but also no regressions.

Quartz64-B testing:

Same story as with RockPro64: no improvements, but also no regressions.
I did notice that ``drm.debug=3D0xe`` was *quite* verbose on this device.
On Rock64 and RockPro64 I saw various drm related msgs in dmesg _when I
actually did something_ but on Q64-B I got several ~ identical lines per
second, whether I did sth or not. But that was with and without this patch
set, so I guess that's a general RK356X 'issue' (if at all an issue).

Cheers,
  Diederik

> Jonas Karlman (21):
>   drm: bridge: dw_hdmi: Disable scrambler feature when not supported
>   drm: bridge: dw_hdmi: Only notify connected status on HPD interrupt
>   drm: bridge: dw_hdmi: Call poweron/poweroff from atomic enable/disable
>   drm: bridge: dw_hdmi: Use passed mode instead of stored previous_mode
>   drm: bridge: dw_hdmi: Fold poweron and setup functions
>   drm: bridge: dw_hdmi: Remove previous_mode and mode_set
>   drm: bridge: dw_hdmi: Hold bridge ref until connector cleanup
>   drm: bridge: dw_hdmi: Unregister CEC notifier during connector cleanup
>   drm: bridge: dw_hdmi: Invalidate CEC phys addr from connector detect
>   drm: bridge: dw_hdmi: Remove cec_notifier_mutex
>   drm: bridge: dw_hdmi: Extract dw_hdmi_connector_status_update()
>   drm: bridge: dw_hdmi: Use dw_hdmi_connector_status_update()
>   drm: bridge: dw_hdmi: Use display_info is_hdmi and has_audio
>   drm: bridge: dw_hdmi: Use generic CEC notifier helpers
>   drm: bridge: dw_hdmi: Add common suspend helper
>   drm: bridge: dw_hdmi: Use delayed_work to debounce hotplug event
>   drm: bridge: dw_hdmi: Rework HDP and RXSENSE interrupt handling
>   drm: bridge: dw_hdmi: Remove the empty dw_hdmi_setup_rx_sense()
>   drm: bridge: dw_hdmi: Remove the empty dw_hdmi_phy_update_hpd()
>   drm: bridge: dw_hdmi: Merge top and bottom half IRQ handlers
>   drm: bridge: dw_hdmi: Drop call to drm_bridge_hpd_notify()
>
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c |   5 +-
>  drivers/gpu/drm/bridge/synopsys/Kconfig     |   1 +
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 483 +++++++-------------
>  drivers/gpu/drm/meson/meson_dw_hdmi.c       |   5 +-
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |  13 +-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c      |   2 -
>  include/drm/bridge/dw_hdmi.h                |   7 +-
>  7 files changed, 194 insertions(+), 322 deletions(-)

