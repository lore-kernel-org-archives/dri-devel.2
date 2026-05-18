Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCEACD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E9B10E5DD;
	Mon, 18 May 2026 10:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="heXyafCM";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FAF10E5DD
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:50:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C0E714E42CE2;
 Mon, 18 May 2026 10:50:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 741C95FFA3;
 Mon, 18 May 2026 10:50:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 685B811AF8493; 
 Mon, 18 May 2026 12:50:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779101427; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9/zO0zp2r2FGgOERfPfiqfEES0NFm6hJuu5wdDFRS34=;
 b=heXyafCM/wLX2BEnRUVB6I1LvciXkXkGOp1QVSXzvEVNPgbmW4kOe5GBgki6tpZrpmEpQm
 XYGDYYm87gHlRs/wz1vK2gz227wopf/fMYJaEHGmOWDznkO4nyZAoHhGILrwsTcM5RWIxD
 mbiCD94a95vAXB5AzxHG96indCe5cXxpC0GLXk/mnorsK6skaw8EstUgNekqTXNg9O4qbF
 ae87N/6mNYw99dtmyztg5Krr+bq4yxC9LZ3Nxk9bYxZmzQVZifp8IH5R0aJov160Zs+mtv
 5N04Gbbpo2IUhzf0uzLgITVYZMF3IEv9ClgD7I+6IHOa++cAstqYqOUsnjHzbw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 12:50:18 +0200
Message-Id: <DILQTGH47XGL.1K6I6UI6IXP92@bootlin.com>
To: "Simon Wright" <simon@symple.nz>, "Cristian Ciocaltea"
 <cristian.ciocaltea@collabora.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: compute audio CTS from N when
 not in TMDS table
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Heiko
 Stuebner" <heiko@sntech.de>, "Andy Yan" <andy.yan@rock-chips.com>,
 "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Algea Cao"
 <algea.cao@rock-chips.com>, <dri-devel@lists.freedesktop.org>,
 <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <92aa4191-2a2a-41e3-badb-c0a5b1fbb957@symple.nz>
In-Reply-To: <92aa4191-2a2a-41e3-badb-c0a5b1fbb957@symple.nz>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Simon,

On Sat May 9, 2026 at 9:09 AM CEST, Simon Wright wrote:
> dw_hdmi_qp_find_cts() returns 0 for any TMDS character rate not
> present in common_tmds_cts_table[] (which terminates at 148.5 MHz).
> In that case dw_hdmi_qp_set_sample_rate() calls dw_hdmi_qp_set_cts_n()
> with cts =3D=3D 0, which leaves AUDPKT_ACR_CTS_OVR_EN clear and falls
> back to the controller's internal CTS auto-measurement.
> On at least the RK3576 hdptx integration, strict HDMI sinks mute
> audio in this configuration. =C2=A0The behaviour reproduces at any rate
> not present in the table -- it is not specific to HDMI 2.x:
> 1920x1080@60 with 10-bit deep colour (185.625 MHz, HDMI 1.4) is
> affected, as is 3840x2160@60 8-bit (594 MHz, HDMI 2.0). =C2=A0Supplying
> explicit CTS via the standard set_cts_n() override path resolves
> the mute.
> The driver already has the symmetric machinery for the N-table-miss
> case: dw_hdmi_qp_compute_n() falls back to a dynamic search using
> dw_hdmi_qp_audio_math_diff() ((pixel_clk * n) / (128 * freq)) when
> no table entry matches. =C2=A0The CTS path lacks the equivalent fallback.
> Compute CTS inline in dw_hdmi_qp_set_sample_rate() from N per the
> HDMI spec (CTS =3D TMDS * N / (128 * Fs)) when find_cts() returns 0.
> The same formula appears in the legacy DesignWare HDMI driver
> (drivers/gpu/drm/bridge/synopsys/dw-hdmi.c, hdmi_set_clk_regenerator())
> under its AHB / GP audio paths.
> Tested on R76S (RK3576) on Armbian-edge mainline 7.0.1 with Cristian
> Ciocaltea's hdptx-clk-fixes v1 series applied:
>  =C2=A0 TMDS =C2=A0 =C2=A0 =C2=A0 =C2=A0 Mode =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 In table? =C2=A0Audio with fix
>  =C2=A0 148.5 MHz =C2=A0 =C2=A01080p60 =C2=A08-bit =C2=A0 yes =C2=A0 =C2=
=A0 =C2=A0 =C2=A0plays (regression check)
>  =C2=A0 185.625 MHz =C2=A01080p60 10-bit =C2=A0 no =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 plays
>  =C2=A0 297 MHz =C2=A0 =C2=A0 =C2=A03840p30 =C2=A08-bit =C2=A0 no =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 plays
>  =C2=A0 594 MHz =C2=A0 =C2=A0 =C2=A03840p60 =C2=A08-bit =C2=A0 no =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 plays
> Sinks tested: LG G3 OLED, LG C4 OLED, TCL 75P7K QLED, Kogan
> KALED43XU9210STA (Changhong-OEM 4K LED). =C2=A0Without the fix, the LG
> G3 mutes audio -- this is the originally reported bug
> (linux-rockchip 070633). =C2=A0The LG C4 was verified during this cycle
> to mute at 185.625 MHz (1080p60 10-bit) with the unpatched module.
> The Kogan TV plays audio with or without the fix; it is a
> permissive HDMI 2.0 implementation that does not strictly cross-
> check ACR timing. =C2=A0The TCL 75P7K was tested with the fix loaded
> only.
> Audio plays at every supported sample rate (32 / 44.1 / 48 / 96 /
> 192 kHz) verified on the TCL at the 185.625 MHz out-of-table TMDS
> rate -- the fallback's CTS =3D (TMDS * N) / (128 * Fs) computation is
> independent of sample rate, as expected.
> The LG C4's CTA-861 SVDs do not advertise 3840x2160@60 over TMDS
> (it is signalled FRL-only on that model), so that one row is N/A
> on the C4. =C2=A0The same audio-path code is exercised at 297 MHz on
> that sink and behaves identically to the G3.
> Reported-by: Simon Wright <simon@symple.nz>
> Closes:
> https://lists.infradead.org/pipermail/linux-rockchip/2026-May/070633.html
> Suggested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Tested-by: Simon Wright <simon@symple.nz>
> Signed-off-by: Simon Wright <simon@symple.nz>
> ---
>  =C2=A0drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 15 +++++++++++++++
>  =C2=A01 file changed, 15 insertions(+)
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index 0dbb1274360..25ac8d3cfc8 100644
> ---a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@-461,6 +461,21 @@static void dw_hdmi_qp_set_sample_rate(struct
> dw_hdmi_qp *hdmi, unsigned long lo
>  =C2=A0 n =3D dw_hdmi_qp_find_n(hdmi, tmds_char_rate, sample_rate);
>  =C2=A0 cts =3D dw_hdmi_qp_find_cts(hdmi, tmds_char_rate, sample_rate);
> + /*
> + =C2=A0* dw_hdmi_qp_find_cts() returns 0 for any TMDS rate not in
> + =C2=A0* common_tmds_cts_table[]. =C2=A0Falling through to the controlle=
r's
> + =C2=A0* auto-measure path mutes audio on strict HDMI sinks at out-of-
> + =C2=A0* table rates (e.g. 185.625 MHz, 297 MHz, 594 MHz). =C2=A0Compute=
 CTS
> + =C2=A0* from N per HDMI spec instead, so the standard override path
> + =C2=A0* supplies it on the wire.
> + =C2=A0*/
> + if (!cts && n) {
> + =C2=A0 u64 computed =3D (u64)tmds_char_rate * n;
> +
> + =C2=A0 do_div(computed, 128ULL * sample_rate);
> + =C2=A0 cts =3D (unsigned int)computed;
> + }
> +
>  =C2=A0 dw_hdmi_qp_set_cts_n(hdmi, cts, n);
>  =C2=A0}

Thanks for your patch. I cannot comment on the content but I can point for
formal issues with your submission.

Your patch got mangled by your mailer and cannot be applied. Please don't
try to convince your mailer to send patches the right way: save your time
and use "git-format patch + git send-email", or even better use b4.

Also your commit message is very detailed, and think it would be more
readable if split in paragraphs. You can have a look at various commits in
the kernel log for inspiration.

There's plenty of suggestions on how to send patches in [0], ensure you
read them all.

[0] https://docs.kernel.org/process/submitting-patches.html

Thanks!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
