Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25046C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 03:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4241210E091;
	Mon, 21 Sep 2026 03:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="H0ECfCTQ";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C0D10E138
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 03:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789962072; bh=0ctTpDh6nncQDElIa4hbocs1J5cFYwpao8cQucIrK5M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=H0ECfCTQkQML6l+axoKMv/h/+P7KEPmwqkRYgAzJH/mXZIqAt1wor+xDMMkDyjiJ0gs4/wzNy8Uohgm2IXaL6npbEVeFn8/nTyrCg01Q7JPtldxnKbL1vf34av9nlmWVViuL0/jdtMm0auS8c/NSdEEoajg0gusjYJfVMvOj94IU9rn0BD+e1utrcWFR62+4yVkTImk83awP/ZedSLIyy8Axdr3R0epfUZH6ec9nUWxwg+zmK4txdJ6crAtxyq6LLbngBiW38gMukaX/CAzMzNYSughbHBTRCHHWhIwQeiBSKHdccQt0JohJiGFqDx1Z9XNLnxrPZoY1DEsCTSWT7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789962072; bh=6vOSpQCOIQyeSVx+3YyqV1XhnerZ40bVup5cXIcXlYA=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=kZpJo44YxXjmHVFe8DA40Xb2K9mRVLQJ1+60jAk9ECbrpSaXh6BUAuCz8nYyHnNNqhdKpcxDHU3ZVuSS7+dcZJGqusx3hgfUIeAxzC2opolydlBqsiqV8krRniv5nD/6wkA47JP6e1R9x3R38R8VZPY8JY/srJpx+kqpcnjtR6uUUc1MFJmCQtjuK/MrSEefGQK918St7lRRlBUqJD6aeTvKKDHtmyOEZqUeEkdV5TCzzl+8e4FeHcu/5Jqj/s1UnPPtuHc9681J+Sw5oYMp3ZWpRTnfuLN5RfQgRgM6aPR3hC4rJ6zKL7oEkTp/IzylT4jr2/1VQt1BaTteV3Bp1w==
X-YMail-OSG: iLdJ.Y0VM1kHPbyDvjyeYZ5lEi4zmDt__x4XBG3iKk1AZb_Np3liUuhylSIYkCY
 RncPyJdsUSHvFan2HzLpL0As4HqsB5ijCrhZ_E6iYHgP20pkIhFpok7OVTZStrIH.4FmyWCdDgPZ
 Ua7rybD.OP2_TECSt6RptJSvCQRcSMc8nkXu3SDP8.FnN2qRyVjmu1QxgC9krnE7Sw4e67ujCWL1
 DY3movmt3OHeZY97z5gy0msmWl3rD41vd.HBp.Qd86F0.t1rRxhwKKtQAxY9isZvED6zeEuUCrux
 ku3b7mt3LjB4ECJmJCTGl0skHo_HlCJ2kuJmx7QVZ565ZNmLipxsclUQFiuNCUNEFEvnVSeWKjU3
 VOZE8tXcitpFbMP_ZbjwrgP3_6jmF90w6_nM1_ODSznY7kgZeg5qyEnDMorHIdA.KdJQ998pPnl8
 ikSA6RPXkfANI3Vsgs59xcKUqxgIdAnefyR7SKxr4xUv9EN4qDEhg4lJxs986ArJelsS7EO5f6zR
 ZV7oxdi6m3kg7bqZprnbSvO74R9jX7Ak2oMudeVLDYkxQMNF3qIL1M_GPksBmRPh.JEZrGvoASdO
 Muq.heY0H25LppsSZgqTehxSTwL1T08BanLLJVLQYHZxDZY9LGu6Xwv2rlNpyhJcjP3rMGBFyaOz
 EH6oaK19F6WAoBILv9WwCyNCttyLvUI698L_pgRWmFagXqJel.ugqkIKc9ILfYpKc7uw08u0DeHh
 8TwiDOYRO7DNkwFfglwhffKyGxbcwsbTlVcY8FU5cKFqO0mEaXbqhYjJb4UZWS.XsPBYwrwzWFb6
 v57_NWwuKtV8AveTNyZjNEkLQx9i58UQ8YmbztoYc7GzRDgIcU9C5O17SwvKTHDnzsokfCilugbh
 kYm7OX3Fa3UOo1bFROfv6DQfHi_9NcU6eMenWCqpwz3CYWqweEibtc5QAifGnjzikh5anYLnLJ6Z
 Oj4a3iT0x2kQIiR15phW1tmHIMf_a167dbZykIqGaIbiAaJeNAhH_UBRYUNxJHbxUlk_NpYfNc._
 BeTGA_nuy5aBec4M0e7KqsiscVrDAGoZl_CoVT1ckm8S3WO.5DsjzscnV2KGyJ1U.KPI5Ty5VOum
 XLwmD2d8AT_kzgYM4VVTYwRRmaHAMXL2_9DCDeF8Sj8sJn9KanBs7tJbnogaNJ_V2fIXI5xGNkop
 sxqn7kt_jCpt3wo5pTR6C5CAKZ2YmmqXZt.5rV3Ad.iAv9whxx2bA7P4HQVYABQgkszAS.2dPru7
 IcaJHJWB1aDFjA2n8FJQIZfBX_qolPoKzY9PIBzWTaeYg2pUU8L5Yh4a4DTlx2mQKtpITba8WnjX
 nPLO5F6zC1U6Dbea9n_e7.G_Uj_RkU_sNit2K.r0L1ymb_lZziZiuwaLR1ryUnhH7yBOGoLlQ_C8
 gHFsPWjL5Uru7GPYPtCWScz24s2LDyMQi99ZPQxTnY5ty2YZo497nvbyCbTDyyHIHLJ015iSdW89
 eJaNYPuRYji3CgQ0TNFpR6Bl1ebTZ_m8St7Uxf3xUzbVGJCDiSEHsolOGly6hktRCya_RXxrhMPH
 mXneug5AnGhcS99IFBLQHod3nHaYJi4v8wxRQH995hFEH1SGFuOCfHC1O1ZzY35vCCr05eZMOktT
 sIKsROtka6wVKR29pTXJRzl2anFFNhsGL99No_tq6XpdGszNcgPJjU_Z74HpxQSOzyVOSgvncCK4
 SkAgOmBLTxXiBe9L3oFgZq5c7eBBTyuXyUJQUTAOqZvOCQ3MiZO_aX0Sd9jPegN3GIffFulkQXsu
 MQplqzc9083u2sB4vw9R9fh8H58fX3crpe4z6XUkdJ6IRP5MaLWBPdW72A5yj4OpzTmkKjiR1QOR
 DcejCTB73.o2m_PU3Kbitt_Dz1RryUBMMrbulD8HkQ41m2WOC69OgfCgJz4CGmu2i_wVxWQB.L85
 SCbkamlLny2sLROjbLr7MKdsZh7mK8H_cTHTEaDvqGuldShxFS0Vbvz3twrc8YTSLkDtwRLZUxzg
 z9GYh01qX
X-Sonic-MF: <capitain_jack@yahoo.com>
X-Sonic-ID: 438b5e4a-0fd5-4f06-a5e6-068f31fad115
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Mon, 21 Sep 2026 03:41:12 +0000
Received: from dip36.lsn.bf1.yahoo.com ([67.195.177.45])
 by hello (SMTP) with SMTP ID 020c9b03da3867fb74b31d320d5549f2;
 Mon, 21 Sep 2026 03:41:08 +0000 (UTC)
From: Daniel Ramos <capitain_jack@yahoo.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Daniel Ramos <capitain_jack@yahoo.com>
Subject: Re: [PATCH v3 0/3] drm/amd/display: HDMI 1.4 3D output (frame packing,
 top-and-bottom, side-by-side)
Date: Mon, 21 Sep 2026 00:41:04 -0300
Message-ID: <20260921034104.1021664-1-capitain_jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907125015.69811-1-adrian.betschart@cinemaone.ch>
References: <20260907125015.69811-1-adrian.betschart@cinemaone.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Hi Adrian, Harry, Alex, others,

A word of introduction, since this is my first mail to this list: I am Dani=
el Ramos, and I come from the consumer side of this hardware rather than fr=
om driver development. I keep a pair of Sony BRAVIA 3D televisions from 201=
1/2012 fully alive (KDL-46EX725 and KDL-46HX855, the sony-bravia-linux proj=
ect, https://github.com/danielcamposramos/sony-bravia-linux), including the=
 3D panels Sony no longer ships software for, and that generation's end-of-=
service is documented for the right-to-repair movement on its own consumer-=
rights wiki page (https://consumerrights.wiki/w/Sony_BRAVIA_pre-Android_Lin=
ux_TVs_(2011-2012)). That work goes upstream first: frame-packing SEI suppo=
rt I pushed is merged in HandBrake (#8100, https://github.com/HandBrake/Han=
dBrake/pull/8100), my stereo serving profiles are merged in Universal Media=
 Server (#6330, https://github.com/UniversalMediaServer/UniversalMediaServe=
r/pull/6330), and open threads are running at FFmpeg (https://code.ffmpeg.o=
rg/FFmpeg/FFmpeg/issues/24530), mpv (https://github.com/mpv-player/mpv/issu=
es/18489) and MKVToolNix (https://codeberg.org/mbunkus/mkvtoolnix/issues/63=
09). I also maintain the CC0 awesome-stereoscopy index (https://github.com/=
danielcamposramos/awesome-stereoscopy), created because the field had no cu=
rated list.

On the gap this series closes: the DRM core has carried HDMI 1.4 stereo mod=
es and the vendor-infoframe helpers for years, i915, vc4 and nouveau all al=
low stereo (nouveau wired frame packing in 2017), and amdgpu DC has been th=
e one major driver refusing it ever since DC landed, with nobody closing it=
 in nearly a decade. It still justifies closing. The televisions these mode=
s exist for were sold by the millions between 2010 and 2016, they are the s=
ame hardware class Adrian tests against (his JVC is a 3D projector where mi=
ne are 3D TVs), and every one of them works today as a full 3D monitor the =
moment it receives the standard signal, as the runs below show. With Valve'=
s upcoming Steam Frame (https://store.steampowered.com/hardware/steamframe)=
 putting stereo displays back into a mainstream gaming stack, wiring a mode=
rn open driver to the HDMI 1.4 3D signal is as much a longevity fix for tha=
t installed base as a new feature.

Independent confirmation of this approach on older DCN hardware and a consu=
mer-TV sink, plus a boundary record that matches your patch 3's diagnosis.

Hardware here is a Renoir APU (0000:0b:00.0, DCN 2.1, Display Core 3.2.369,=
 Debian 7.0 kernel) driving a Sony KDL-46HX855 from 2012, whose HDMI 1.4b-c=
lass EDID advertises side-by-side half and top-and-bottom over a 7-VIC mask=
 and frame packing on five VICs. The coverage is complementary to yours: yo=
urs runs DCN 3.2.1 into a JVC projector behind an HDFury, mine runs DCN 2.1=
 straight into a living-room television.

With the equivalent wiring here (stereo_allowed allowed on HDMI connectors,=
 the vendor infoframe attached to the stream's hfvsif packet when the mode =
carries DRM_MODE_FLAG_3D_*, timing_3d_format deliberately left at NONE), si=
de-by-side half 1920x1080@60 makes the set switch itself into 3D with no re=
mote input, and a software-rendered disparity pattern reads in depth throug=
h the TV's own glasses. The mode probe goes from 22 modes with zero stereo =
to 51 modes with 29 stereo-flagged.

Frame packing shows the boundary your patch 3 fixes, observed independently=
: without the CRTC_STEREO_DOUBLE expansion the sink entered 3D on a valid F=
P VSIF while DC scanned the un-doubled 1080-line 74.25 MHz timing against t=
he 2205-line plane, which is signal pass and picture black. With the stream=
 mode expanded (1920/2750 horizontal active and total, 2205/2250 vertical, =
148.5 MHz for 1080p24 FP) the same television both switched itself into 3D =
and displayed the full two-eye picture through the AMD link.

A cross-vendor control on the same sink: stock nouveau on a GA106 drives th=
is television into 3D in the same 1920x1080@24 frame-packing mode, so the E=
DID and the sink behavior are proven independently of the AMD path.

On your DCC note: our test buffers are dumb buffers without DCC, so I canno=
t speak to that wedge; every flip with a plain buffer completed, which is a=
t least consistent with the failure being DCC-specific.

Logs, the DRM test tool, and the two reference deltas (built for the 7.0 tr=
ee, kept as a DCN 2.1 port in case an older-generation follow-up is wanted)=
 are public at https://github.com/danielcamposramos/sony-bravia-linux: run =
records and verdicts are in tools/stereo-modeset/ and the patches are in do=
cs/upstream/.

Happy to run anything specific on this APU and television combination if it=
 helps the review.

Tested-by: Daniel Ramos <capitain_jack@yahoo.com>

Disclosure per Documentation/process/coding-assistants.html (https://docs.k=
ernel.org/process/coding-assistants.html): prepared with AI assistance, dir=
ected and hardware-verified by me end to end; the assisting models were LLM=
 Kimi K3 (Codex CLI), LLM GPT 5.6 Sol (Codex CLI) and LLM Claude Opus 5 (Cl=
aude Code CLI).
