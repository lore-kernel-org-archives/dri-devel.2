Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3517CD3444
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 929C410F1A2;
	Thu,  7 May 2026 14:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=symple.nz header.i=@symple.nz header.b="mdbxfa2g";
	dkim-atps=neutral
Received: from SY2PR01CU004.outbound.protection.outlook.com
 (mail-australiaeastazon11021140.outbound.protection.outlook.com
 [40.107.39.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C3410E27C
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 10:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emvVxkmAWOz4W1yszEYQBu0jSF2SEljcLgqtDDPXj6TMUoENhobeRSnGPeo5UW1Q8kO16LWUFHLfW5yPTvyX1Qz3prrTx8W4MIkf0oxP23ZySGjDyvdJovCj/pn4kP1ujDEDvFpKk0LpjM7cnRD3rdvTtK1gnMSesxItsh+a++Iaj74HUOkX8IWBCRS5c9RfwdnoemiTr6QFmNlwFC2h3UZcKVidiFEh11hNhR8boLok0SbMzA+oWVY1GNus0TPdXIAkbXbAm4bdPR/4bVdm92Dv1mPvDjrRCU+P5giZCOh7XQ65WWsVvvMD/hgO+zAMZaUrD6GIn9Ucy1gG+/N60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzw/oYX6EMryXtyvyYjEBJNhdON1rIsp+tRfmxHJJUU=;
 b=GOTELKB1ctFpaV59QcpCoi7njTU3gzOngtEpWsq42WTZu74WAvyGY5L4CVU6PbeVMiTvy67cJNTP+GW5aeXj8pDq9UTUPYrGmmNjxjM2V06XEW34iDfY8tryUaEnyHgS6LBEYRtLiI7259fOhckgfzS+eolCW/rsEpkhKcGCG5Z5VOvrv1ucx7f75QDR3W6CYMMdSl1qi7QGjA6sSMSGb/xV6rgzIeNyn2/E382k3aWj25mW4+baGTP6QfsYK/GBZ8dOrgkELn/JdRJTGjjfeN6Npd8mFXDrcABlbYF6fdmX7/FzazeBK0x40UNFnJZAapqaz+ysGUZrhPwm4GyNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=symple.nz; dmarc=pass action=none header.from=symple.nz;
 dkim=pass header.d=symple.nz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=symple.nz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzw/oYX6EMryXtyvyYjEBJNhdON1rIsp+tRfmxHJJUU=;
 b=mdbxfa2gJVXVemIYeMYjUp2nPzTXq/1IhYftGedHgvHpRaWPLerAexfnXQodiHmSDmUB0n4fE9Ui8NeQUXilMDnlJBPKnTAynHCD/SSTyBQsJeG9Gt+IOuVYaTwz+GR0Aio9ftxWFgthEMQkSN0OtRt/8/MhYJgWIsrNsK+jndzHuj2mqRHGWw45gAHwjm2R8NN7VTrUjfnzq+JiCe6cXSMrooDL/J+iaS+lEQiS5yKl6Wh6OHuJ1VXFU103LyAKJJTq+QhrHbZ8PzN9bmyfBU7zLl0zGrC0P7kwKvyeEImqqoIN+gtaW3DqnOecvC4Ol79iIpeB95OFSaEcWUdBYw==
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b2::11)
 by SY7P282MB4696.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 10:39:31 +0000
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834]) by ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834%5]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 10:39:30 +0000
From: Simon Wright <Simon@symple.nz>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: drm/bridge: dw-hdmi-qp: seamless handoff sets wrong
 tmds_char_rate, breaking audio on strict HDMI 2.1 sinks
Thread-Topic: drm/bridge: dw-hdmi-qp: seamless handoff sets wrong
 tmds_char_rate, breaking audio on strict HDMI 2.1 sinks
Thread-Index: AQHc3GbSunaFBhX++0C913TIa5mDprX/2wMAgAKGfm4=
Date: Thu, 7 May 2026 10:39:30 +0000
Message-ID: <ME3P282MB2196C1D097CB4A61D2376FAFA83C2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
References: <ME3P282MB21960D9D68BFF520316BDFCEA83E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
 <38b2e226-c8f0-44b4-bf71-66caa0b27d43@collabora.com>
In-Reply-To: <38b2e226-c8f0-44b4-bf71-66caa0b27d43@collabora.com>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=symple.nz;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME3P282MB2196:EE_|SY7P282MB4696:EE_
x-ms-office365-filtering-correlation-id: 628a31db-c381-4f98-d21f-08deac24eba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003|3023799003|7055299006;
x-microsoft-antispam-message-info: IcwqRlg4t/hHhLHBczkTWA9xRW3kjYcwCoxZ2o0fLkrvcyOHLbAJ4ZCbk7xC1hsqr+j1ZXxgCTZGH3z+/9kzJvk0u6W+YsMCGPS8IzM+IDsi7lS4MrnXSuiblzst6A2LgULcu/F9xx7UclfEPXEoP/yHtBktByDS2fz+sG3N7YyVZHGNWlC+TkLRUpSXHF8tPW2LgpfW0bbUFQvedZWyfx4OREVBPlm6NRqZBWVl3BAB3Bj5PHny9o3dCasdn4YMQ+ga7lxjOQDaXdSuxpjJ8c+uy83EIZM0I/VqdfTecrdwxRGQ/rv/RFDTS73ZyZW36jAp3RWZnOZfkFW0E/NsmweTFrQo3QTJ3z57HyeNycgcciVVpQpgwcZTa4Yh6V2xRKd2mMD2BFVno1Hm/LDHSdKsX6xIB3RWPSiKmycU56bRzBa0VcD6FWm5Fi1RCg/AEtUXPCSnyWeGCpxxKmFmOcKR5wTkZgkhhsV2V4pC+pHknjM2/SNlQHL2fqNJwhuFZIR69ImzgzUd2Ki5l0Q8v5UXJt+VEWUIaN9jot3nox/XQP3l2EbQeMrm/QwJ+dFF8WNK/sBphv3Cq8ZHOq+dTutn3EoGCf2KkHRcdLRKbpUN8tO2yH4TUpoXz6qPe5Hr7RMu/0gumRF9lmjmqaaAyS2E227/aUkuZ4XYZJLvkYDg7dncrMnkuwUJkTkXm6hitAodqpUTqsCNTRxeFBj+OAZkL3VawY3ufhLi7yLEKor1kkmPeptfxIVVzfor/SgbuF+eIIHOKxqJa+LEE83fFiG5WF4vMxsW9HB3Lxj2/oQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(3023799003)(7055299006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?XXxldfatYiF8+A6fUE9qKfEC3WMEKJ33TZAkQfz6uxmYxPPSEP+3g7zX?=
 =?Windows-1252?Q?GhV96FGYlHFWKc7hDMTETpj6WWmzRD4zP8MyHgb3Xu8KvJYETfiQ+ejY?=
 =?Windows-1252?Q?7dWazunsdhD6BpBFULrSJla7eLTvp7BJttkqrYnccYDUUXy+coKnd4wY?=
 =?Windows-1252?Q?j5bPoRDLvgl0q9s22ETWI6e7fH1v/e6LG6DYjc+4pkTXUfDTdrQwSU+u?=
 =?Windows-1252?Q?hF7xr0nDMjzk8ZV+DJMeYtmXe5eVbyGPa3nQQ75Fadc0Jn4kxaqSE/NB?=
 =?Windows-1252?Q?uRG53rKVbKLHujKmk79YOpLklhb4zreufOzXzwpQghv2TcIiBNXw3HiZ?=
 =?Windows-1252?Q?cHvAYPFCnvPZD99yqET02n6aV1dh6EevUsimx78Nf6r6R8t7rC9kaApB?=
 =?Windows-1252?Q?3gkgFCY+FaQ6wuPAECTjc5g5o06jvke1/IJsU4eFyHSS/lr1N90TVwR3?=
 =?Windows-1252?Q?QafBq/Bnln1DofRZo/FQP0TqFhSPATUTsDOgrIw8NLfZkEcO5zAdwkyL?=
 =?Windows-1252?Q?+VY9IXKftfiwz4CNzISKTUqCwCpqwJoY7ZpECT0JXsfuqlWxqzRL0uHj?=
 =?Windows-1252?Q?5ask72wYpS8xTT1IhlevzAqN/jS+eHwsHBosstaOD3wtN05WmsIeHqXk?=
 =?Windows-1252?Q?CPPrkLb2hDOESrF6gD6eHh9AgvLRfuJvCDraQwZIoojqTq/Hb4UQ6x5k?=
 =?Windows-1252?Q?1JELHX364R3wp983/9Y475EVMJVAAp1PiMlwl8b3SOdQQI9z83UGHJxD?=
 =?Windows-1252?Q?GxtS1nmEgLmlBHCUc6DEdaPyeGlH9x9qF+rWqJxQ64+7R7KNQZ9UbiSC?=
 =?Windows-1252?Q?niKDls8zMiLbJwLER/UoKxJRaXtU4nTAoRj7eXPvKF4crUOQrNAk6wRZ?=
 =?Windows-1252?Q?tYEt7LoMtdmQO2prahZjriGO5UgdblpVhsK3Tu2ND2nQwrIF7CqMw2AB?=
 =?Windows-1252?Q?UWAh8XcnunYEedveBHHVvZJRinStZ2mmYCO6x8Dmnl4gTqoXcUADjTdZ?=
 =?Windows-1252?Q?2p1EXAWRS5M7U79WDHjmI1uDw9ECo8y6XL3Ly2e7o8gC3scHVS4GcaAE?=
 =?Windows-1252?Q?wnzcRoGtQnSqk0FgnPUxjXYQMIr9HgcWrrm1HcEaZH9L2j4fT0jVBkzb?=
 =?Windows-1252?Q?Kzn4Noqmm1ZViECWXOW+Gqif9qq3euRvZH450jsq7uhbDaTX7OkfD23o?=
 =?Windows-1252?Q?8dpLLeq6EkVgNHgKAWGWaDj6Quf/ufLOS92b/GxNUUM5AcX6sxkU5plD?=
 =?Windows-1252?Q?p2hUDfEfGX0UjiEwfKPLYHutagPP+eY+n1MuvFrGQx9BBkD4gGAwf6y5?=
 =?Windows-1252?Q?/6KeetSdPaNuRObX59oF49zMp5U5r1fjdm1qnLUhx3o1I6MG8ArTLomB?=
 =?Windows-1252?Q?UXY1TJ+qH5WDF7fklF85FYX9S7OFQ2q6V1AujLdypV4sbhfWtcbdCu0v?=
 =?Windows-1252?Q?qFYkny+WP5mrTiS+oYcu4Ob+xHS9MmCK/ZbwoiTy1p90NfnpT9CdjOSP?=
 =?Windows-1252?Q?D01huh3Uhj9Ddt9y055SE0K/6PMs4RAf34kA+kypoteRfroeF8DDPtvC?=
 =?Windows-1252?Q?2kaCaWaVAoc9/LzxIH4hfXUx5U3hKoYyuUHQdEN+W/KGnQiihafN2cGR?=
 =?Windows-1252?Q?b+PMOTlHlvLp+YRBpPl76ZPFHZAso1COfkMh8AphufT5V3TglgCgjCty?=
 =?Windows-1252?Q?3xyC+Iu//HE7Sv2jYw0dzbXi36zvOArZW/Kxj+YA9P2k5iXktQQYrpXM?=
 =?Windows-1252?Q?JV9EEL1CoNfu28rnfnfr8m5TqiJFor6Jidd9g5VDZiHkxnVK1Kdup/Su?=
 =?Windows-1252?Q?jUgaYd1Pl8iDk0I0RvlxfuUSsQLmnI5B4RuGmIEbGh4Y7aFM?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: symple.nz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 628a31db-c381-4f98-d21f-08deac24eba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 10:39:30.4719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9531f271-068a-4210-b471-bd8da91491c5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDUfVXxJJjNKsZ5gLpnaoTbzjYyxOhBoy2+J+qUEMNPEYWAn+Igkh0fdU+vG+IK3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4696
X-Mailman-Approved-At: Thu, 07 May 2026 14:49:02 +0000
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

Hi Cristian,=0A=
=0A=
Thanks for the pointer. Quick test results before writing back.=0A=
=0A=
Test rig: NanoPi R76S (RK3576) on Armbian-edge mainline 7.0.1, LG G3=0A=
OLED sink (the same strict HDMI 2.1 sink that surfaced the original=0A=
audio bug). Stack: hdptx-clk-fixes v1 + frl-enable-gpios v2 patch 3/13=0A=
+ SCDC v5 patch 5 (hand-ported to v7.0; `.detect` kept instead of=0A=
`.detect_ctx` so the OOT module loads against unpatched vmlinux).=0A=
=0A=
Tested-by for hdptx-clk-fixes v1: dmesg shows phy_configure /=0A=
phy_power_on / atomic_enable consistent at rate=3D185625000 bpc=3D10 with=
=0A=
no recalc drift -- exactly what the cover letter promises. Happy to=0A=
add the trailer to the v1 cover and any individual patch.=0A=
=0A=
That said, audio still mutes at high-bpc / high-TMDS rates on the=0A=
LG G3 even with your series applied:=0A=
=0A=
    1080p60  8-bit (148.5  MHz): audio plays  -- already worked=0A=
    1080p60 10-bit (185.625 MHz): muted        -- original bug regime=0A=
    4K@60   8-bit (594.0  MHz):  muted        -- production cast path=0A=
=0A=
The "muted" rates are precisely those not in `common_tmds_cts_table[]`.=0A=
For those, `dw_hdmi_qp_find_cts()` returns 0, the override path is=0A=
skipped, and the QP IP falls back to its auto-CTS measurement -- which=0A=
the LG G3 cross-check rejects. The BSP-derived dw-hdmi-qp.c=0A=
(develop-6.6) carries an in-source comment attributing this to the=0A=
auto-circuit measuring at half the actual TMDS rate; I haven't read=0A=
that register out myself to confirm the specific value, so I can only=0A=
report that empirically the override path with explicit CTS works on=0A=
the LG G3 and the bare auto path doesn't.=0A=
=0A=
The fix is to compute CTS from N when the table misses, and feed it=0A=
through the standard override path. Six lines + comment in=0A=
`dw_hdmi_qp_set_sample_rate()`, between find_cts() and set_cts_n():=0A=
=0A=
    /*=0A=
     * When no CTS table entry exists for the given TMDS rate, compute=0A=
     * CTS from N rather than relying on the IP's auto-measure path,=0A=
     * which mis-measures on this controller at high TMDS rates and=0A=
     * produces incorrect ACR timing on strict HDMI 2.1 sinks.=0A=
     * Computed CTS =3D (TMDS * N) / (128 * Fs) per HDMI spec.=0A=
     */=0A=
    if (!cts && n) {=0A=
        u64 computed =3D (u64)tmds_char_rate * n;=0A=
        do_div(computed, 128ULL * sample_rate);=0A=
        cts =3D (unsigned int)computed;=0A=
    }=0A=
=0A=
With this on top of your series, all three regimes above play audio=0A=
cleanly -- including the 1080p 10-bit case from my original bug=0A=
report and the 4K@60 path on our production cast rig.=0A=
=0A=
That makes my earlier rate-block patch=0A=
(linux-rockchip 2026-May/070673) redundant -- I'm happy to withdraw=0A=
it on its thread once you've decided where the CTS-from-N fix should=0A=
land.=0A=
=0A=
Two questions:=0A=
=0A=
1. Where would you like the CTS-from-N fix? Its own small thread, a=0A=
   trailer on hdptx-clk-fixes, or folded into the SCDC series --=0A=
   whichever fits your workflow.=0A=
=0A=
2. The kernel 7.0 announcement flagged controller-side FRL as "not=0A=
   yet landed". Is that still on Collabora's roadmap, or open for me=0A=
   to send a develop-6.6-derived prototype as RFC once I've ported it=0A=
   to mainline? Happy to wait if you have a series in flight.=0A=
=0A=
Reproducer for the audio fix is the stack above plus a small libdrm=0A=
helper to hold the mode against fbcon (modetest releases DRM master=0A=
on exit). I can share the helper if useful.=0A=
=0A=
Sige5/Sige7 DTS follow-ups to your frl-enable-gpios v2 series are in=0A=
draft against the schematics; both boards are on order so I'll=0A=
validate on my own hardware before sending. I'll start a separate=0A=
thread on the v2 series for those rather than burying them here.=0A=
=0A=
Thanks again -- the pointer saved a lot of parallel debug time, and=0A=
the controller-side gap was small once pinned down.=0A=
=0A=
Regards,=0A=
Simon=0A=
Symple Solutions, Dunedin, New Zealand=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Cristian Ciocaltea <cristian.ciocaltea@collabora.com>=0A=
Sent:=A0Wednesday, 6 May 2026 8:01 am=0A=
To:=A0Simon Wright <Simon@symple.nz>; linux-rockchip@lists.infradead.org <l=
inux-rockchip@lists.infradead.org>=0A=
Cc:=A0dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; ke=
rnel@collabora.com <kernel@collabora.com>=0A=
Subject:=A0Re: drm/bridge: dw-hdmi-qp: seamless handoff sets wrong tmds_cha=
r_rate, breaking audio on strict HDMI 2.1 sinks=0A=
=A0=0A=
Hi Simon,=0A=
=0A=
Thanks for the detailed bug report!=0A=
=0A=
I submitted a while ago a patch series [1] providing clock fixes (among oth=
ers)=0A=
to samsung-hdptx PHY driver, but sadly it hasn't been merged yet.=0A=
=0A=
I think this should also address your audio issue, hence please give it a t=
ry=0A=
and let me know how it goes.=0A=
=0A=
Regards,=0A=
Cristian=0A=
=0A=
[1] https://lore.kernel.org/all/20260227-hdptx-clk-fixes-v1-0-f998f2762d0f@=
collabora.com/=0A=
=0A=
On 5/5/26 11:18 AM, Simon Wright wrote:=0A=
> [Resent in plain text =97 first attempt was rejected by the list's HTML f=
ilter.]=0A=
>=0A=
> Hi,=0A=
>=0A=
> I have tracked down a bug in dw-hdmi-qp that silences audio on strict=0A=
> HDMI 2.1 sinks (tested: LG G3 OLED) when booting with HDMI seamless=0A=
> handoff from U-Boot. HDMI 2.0 sinks are unaffected. The root cause is=0A=
> a mismatch between the AVI InfoFrame colour depth and the ACR embedded=0A=
> CTS value.=0A=
>=0A=
> Hardware tested:=0A=
>=A0=A0 Source:=A0=A0=A0=A0=A0=A0 ArmSoM Sige5 (Rockchip RK3576)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Armbian-edge kernel 7.0.2=
 (Linux mainline v7.0 plus=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Armbian board-enable patc=
hes; not a BSP kernel)=0A=
>=A0=A0 Failing sink: LG G3 OLED 4K (HDMI 2.1, strict embedded-CTS mode)=0A=
>=A0=A0 Passing sink: Various HDMI 2.0 TVs (self-measuring CTS, unaffected)=
=0A=
>=0A=
> The bug is structural and is expected to affect RK3588 under the same=0A=
> boot sequence.=0A=
>=0A=
>=0A=
> Root cause=0A=
> ----------=0A=
>=0A=
> When the system boots with seamless handoff active, U-Boot has configured=
=0A=
> the PHY for 8-bit 1080p60 (TMDS =3D 148,500,000 Hz). The DRM connector=0A=
> state, negotiated from EDID, selects 10-bit deep colour (TMDS =3D=0A=
> 185,625,000 Hz). In dw_hdmi_qp_bridge_atomic_enable():=0A=
>=0A=
>=A0=A0=A0=A0 hdmi->tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;=0A=
>=0A=
> This stores 185,625,000. The PHY ops->init() is called but the PHY is=0A=
> already running at 148,500,000 from U-Boot and is not reconfigured.=0A=
>=0A=
> The result is an inconsistency between what the sink is told over HDMI=0A=
> and what the wire actually carries:=0A=
>=0A=
>=A0=A0 AVI InfoFrame:=A0=A0=A0=A0 declares 10-bit deep colour at the conne=
ctor-state=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TMDS rate =
(185.625 MHz)=0A=
>=A0=A0 ACR embedded CTS:=A0 driver uses hdmi->tmds_char_rate =3D 185,625,0=
00 Hz=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 to compute=
 CTS via dw_hdmi_qp_set_sample_rate(),=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 producing =
CTS =3D 185,625 (internally consistent=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 with the A=
VI declaration)=0A=
>=A0=A0 Wire TMDS clock:=A0=A0 PHY untouched from U-Boot, still running at=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 148,500,00=
0 Hz (8-bit)=0A=
>=0A=
> The dmesg signature (full pr_err output, lower in this report) confirms=
=0A=
> both AVI and ACR are computed from the nominal 185.625 MHz value:=0A=
> "tmds=3D185625000 ... cts=3D185625".=0A=
>=0A=
> A standard HDMI 2.0 sink does not cross-check AVI against the wire TMDS=
=0A=
> in any way that matters for audio, so the mismatch is harmless. A strict=
=0A=
> HDMI 2.1 sink (LG G3) measures the wire TMDS and verifies it matches the=
=0A=
> AVI declaration; with declared 185.625 MHz vs measured 148.5 MHz, the=0A=
> check fails and audio is muted, permanently, until the next mode set.=0A=
>=0A=
> The N/CTS values themselves are correct CEA-861 ratios. At a wire TMDS=0A=
> of 148.5 MHz with N=3D6144, CTS=3D148,500 yields f_audio =3D 48 kHz; at a=
=0A=
> wire TMDS of 185.625 MHz with N=3D6144, CTS=3D185,625 also yields f_audio=
=0A=
> =3D 48 kHz. The driver picks one TMDS, computes a self-consistent N/CTS=
=0A=
> pair, and embeds it. The bug is solely that the TMDS the driver picks=0A=
> (connector-state nominal) differs from the TMDS on the wire (PHY=0A=
> actual).=0A=
>=0A=
>=0A=
> Dmesg diagnostic signature=0A=
> --------------------------=0A=
>=0A=
> Failing (seamless handoff, DRM selects 10-bit 1080p from EDID):=0A=
>=0A=
>=A0=A0=A0=A0 dwhdmiqp-rockchip 27da0000.hdmi: atomic_enable: \=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 tmds_candidate=3D185625000 is_hdmi=3D1=0A=
>=A0=A0=A0=A0 DW_HDMI_QP set_sample_rate: tmds=3D185625000 sr=3D48000 n=3D6=
144 cts=3D185625=0A=
>=A0=A0=A0=A0 [audio silent on LG G3]=0A=
>=0A=
> Working (8-bit mode forced, see workaround below):=0A=
>=0A=
>=A0=A0=A0=A0 dwhdmiqp-rockchip 27da0000.hdmi: atomic_enable: \=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 tmds_candidate=3D148500000 is_hdmi=3D1=0A=
>=A0=A0=A0=A0 DW_HDMI_QP set_sample_rate: tmds=3D148500000 sr=3D48000 n=3D6=
144 cts=3D148500=0A=
>=A0=A0=A0=A0 [audio working on LG G3]=0A=
>=0A=
> The difference is entirely in which tmds_char_rate bridge_atomic_enable()=
=0A=
> receives. If the PHY and DRM state agree (both 148.5 MHz), audio works=0A=
> because what the AVI declares matches what the wire carries. If they=0A=
> disagree (DRM: 185.625 MHz, PHY: 148.5 MHz), the AVI declares 185.625=0A=
> but the wire carries 148.5, and any sink that cross-checks the wire=0A=
> TMDS against the declared rate (e.g. LG G3 OLED) mutes audio.=0A=
>=0A=
>=0A=
> Confirmed workaround=0A=
> --------------------=0A=
>=0A=
> In dw_hdmi_qp_bridge_tmds_char_rate_valid(), reject 185,625,000 Hz:=0A=
>=0A=
>=A0=A0=A0=A0 if (rate =3D=3D 185625000)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 return MODE_CLOCK_HIGH;=0A=
>=0A=
> This forces DRM to select 8-bit mode (148,500,000 Hz). bridge_atomic_enab=
le()=0A=
> then stores the correct tmds_char_rate, the AVI InfoFrame declares 8-bit,=
=0A=
> the ACR CTS is computed correctly, and the LG G3 produces audio.=0A=
>=0A=
> Note: 185,625,000 Hz (1080p@60 10-bit) is only selected via EDID=0A=
> negotiation during seamless handoff. A genuine modeset at that rate would=
=0A=
> correctly reconfigure the PHY and the AVI/ACR inconsistency would not=0A=
> arise. Blocking this rate in tmds_char_rate_valid() therefore has no=0A=
> correct-use-case cost on RK3576 with the current BSP. 4K@60Hz (594 MHz)=
=0A=
> is unaffected and continues to work correctly, including audio.=0A=
>=0A=
>=0A=
> Proposed proper fix=0A=
> -------------------=0A=
>=0A=
> The fundamental issue is that bridge_atomic_enable() accepts=0A=
> conn_state->hdmi.tmds_char_rate without verifying it against the PHY's=0A=
> actual output frequency.=0A=
>=0A=
> Option A (no display disruption):=0A=
>=0A=
>=A0=A0 The HDPTX PHY PLL is already registered as a clock provider. On=0A=
>=A0=A0 RK3576, rk3576.dtsi gives the hdptxphy node #clock-cells =3D <0>;=
=0A=
>=A0=A0 VOP2 consumes it as "pll_hdmiphy0". If the bridge driver adds a=0A=
>=A0=A0 new clk pointer (e.g. hdmi->tmds_clk) populated via=0A=
>=A0=A0 devm_clk_get_optional() at probe and queries clk_get_rate()=0A=
>=A0=A0 in bridge_atomic_enable(), it can detect the seamless-handoff=0A=
>=A0=A0 mismatch and use the actual rate:=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0 /* hdmi->tmds_clk added in struct dw_hdmi_qp; populated=
 at=0A=
>=A0=A0=A0=A0=A0=A0=A0 * probe via devm_clk_get_optional(dev, "tmds") or si=
milar */=0A=
>=A0=A0=A0=A0=A0=A0 actual_rate =3D hdmi->tmds_clk ? clk_get_rate(hdmi->tmd=
s_clk) : 0;=0A=
>=A0=A0=A0=A0=A0=A0 if (actual_rate && actual_rate !=3D conn_state->hdmi.tm=
ds_char_rate) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(hdmi->dev,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "seamless handoff: PHY at %lu H=
z, DRM selected %llu Hz; "=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "using actual PHY rate for audi=
o\n",=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 actual_rate, conn_state->hdmi.t=
mds_char_rate);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hdmi->tmds_char_rate =3D actual_rate;=0A=
>=A0=A0=A0=A0=A0=A0 } else {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hdmi->tmds_char_rate =3D conn_state->hdmi.t=
mds_char_rate;=0A=
>=A0=A0=A0=A0=A0=A0 }=0A=
>=0A=
>=A0=A0 This corrects the ACR CTS and AVI InfoFrame without touching the=0A=
>=A0=A0 PHY configuration or causing a display blank.=0A=
>=0A=
> Option B (correct but causes brief blank):=0A=
>=0A=
>=A0=A0 If the driver detects a mismatch, call phy.ops->init() to bring=0A=
>=A0=A0 the PHY into agreement with the DRM-negotiated state. All=0A=
>=A0=A0 parameters become consistent at the cost of a single mode change=0A=
>=A0=A0 on first enable after seamless handoff. This is arguably the more=
=0A=
>=A0=A0 correct approach if the intent is to honour what the EDID reports.=
=0A=
>=0A=
> Option A is preferred for a seamless user experience. Option B is=0A=
> preferable if the seamless-handoff-inherited U-Boot mode is not=0A=
> otherwise suitable for production use.=0A=
>=0A=
>=0A=
> Relation to Collabora's HDMI 2.0 patch series=0A=
> ----------------------------------------------=0A=
>=0A=
> The "Add HDMI 2.0 support to DW HDMI QP TX" series (v3, January 2026)=0A=
> addresses high-TMDS-clock-ratio and scrambling. It does not appear to=0A=
> address the seamless-handoff tmds_char_rate mismatch described here.=0A=
> If a revision of that series reads PHY state at probe time it may=0A=
> incidentally close this gap, but that is not a stated goal. Reviewers=0A=
> may wish to verify the seamless-handoff path is exercised in testing.=0A=
>=0A=
>=0A=
> Summary=0A=
> -------=0A=
>=0A=
>=A0=A0 Bug:=A0=A0=A0=A0=A0=A0=A0 bridge_atomic_enable() takes EDID-negotia=
ted=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tmds_char_rate (185,625,000) wh=
ile PHY runs at U-Boot=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rate (148,500,000); the AVI Inf=
oFrame and the ACR CTS=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 both reflect the connector-stat=
e nominal value, but=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 the wire TMDS clock disagrees w=
ith what AVI declares=0A=
>=A0=A0 Symptom:=A0=A0=A0 audio silent on any HDMI 2.1 sink that cross-chec=
ks=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wire TMDS against the AVI decla=
ration; HDMI 2.0 sinks=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unaffected (no such cross-check=
)=0A=
>=A0=A0 Scope:=A0=A0=A0=A0=A0 RK3576 confirmed; RK3588 structurally identic=
al=0A=
>=A0=A0 Not a bug:=A0 N/CTS table, IEC60958 channel status, ARC, ALSA path=
=0A=
>=A0=A0 Workaround: reject 185,625,000 Hz in tmds_char_rate_valid() so=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM picks 8-bit 1080p (148,500,=
000 Hz) which matches=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 the actual PHY rate=0A=
>=A0=A0 Fix:=A0=A0=A0=A0=A0=A0=A0 compare conn_state->hdmi.tmds_char_rate a=
gainst actual=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PHY clock at bridge_atomic_enab=
le() and use the=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 measured rate when they disagre=
e (Option A) or=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reconfigure the PHY (Option B)=
=0A=
>=0A=
> I am happy to test patches on Sige5 + LG G3.=0A=
>=0A=
> Regards,=0A=
> Simon=0A=
> Symple Solutions, Dunedin, New Zealand=0A=
