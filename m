Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CAACD3436
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC8910E105;
	Tue,  5 May 2026 10:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=symple.nz header.i=@symple.nz header.b="Ts+VLIca";
	dkim-atps=neutral
Received: from SY5PR01CU010.outbound.protection.outlook.com
 (mail-australiaeastazon11022085.outbound.protection.outlook.com
 [40.107.40.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905CE10E9C2
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 08:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1Efoh4nw10Js2s8PSViovPi2XGYswRPifDi4hD9HzFYks0R6Unjt+wjlhHRUInHYRkoBGrFyomAtZDzPZCkOmQqxYga81bbmZCS05SPkFDhaaKEQZlUPRKMZI3gHey9hwKPT9yLLjTsWX5kM8ZEUGpMRZnHpvgifb1KgP32Dnp63YfNxxeVuy+i/aXhSoRee/ZRO5sELZBc1pYy3pQzbQLBdFbuwhF9+7i4zVe/e6hMy+D2ho+1G4FNj9V5g6jnzNvokv8ImWmoxLLXre7tkE54ZSOQ59ifqE1cVPUM69f2zzkaJG3UGifoTsnk/XH32+ZnlHOEn0GSlja6yTNsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+54Xmplvyi8sXMaM8Z0nDaaCWiVMysD4DWI8Km/TRcM=;
 b=eMZ3Wr6Vla1Z4l9mMIByN3IJScDjE7NHB8rN5ujACWEA7/KwQLhlNonyGHmiu6ot4Ih+eJWQxID4PCA8ARHu2A4cC3icHghcvsAUa0p6hRaayQwT6QPj/SN6OfRsNHTmSRq90X8eTkcpY1+LMagiaU+OXRaLJw00aWZVTwIITADxrZf7kkh5LoEWJ6oP1LI2WfmezvkJoHctvAnb5lVUoFrs8BDmoYOWgMZgLF/xG5+S/NuCDN8sFXjwCgTVe8Nx9gIKlsHK/N1niZwHbzDJrN9L/hdcRUSJDzIohEto9H9dsQtQdLyCcX6SsTvMNDuk2gj4hvsD4UasDSoG5+rjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=symple.nz; dmarc=pass action=none header.from=symple.nz;
 dkim=pass header.d=symple.nz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=symple.nz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+54Xmplvyi8sXMaM8Z0nDaaCWiVMysD4DWI8Km/TRcM=;
 b=Ts+VLIcajiSTmoN1ngTolpSjHoHhVl4Q9SGmMbmMR++wQMtNcv6DD8IsGFqFewchoYKEppMaEUKntMSrEq7AdTtcGLh4DOdORsrW9hpKmm9b9b0DyVooM/OKpjwI1vuIibYAMQ/nwPuCz+eqU/JcSRu2IJyx83EwHpW71u1wXUbnBWzN/NZCo/5aA7QFBAoivTrn6FrYj9trRs9EQi60pqGcoATJMwIfKWtMg37Y39tSueYTk782v716y83enYvx14+tuAhmLtj7uTAd+15j8SFexzZVRNnVcbLi4r6MciMIv8oxMqwROHygBbec88tpopYpnAJXpxix9fueRFa9PQ==
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b2::11)
 by SY4P282MB3908.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:194::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:07:55 +0000
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834]) by ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:07:52 +0000
From: Simon Wright <Simon@symple.nz>
To: "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, "kernel@collabora.com"
 <kernel@collabora.com>
Subject: drm/bridge: dw-hdmi-qp: seamless handoff sets wrong tmds_char_rate,
 breaking audio on strict HDMI 2.1 sinks
Thread-Topic: drm/bridge: dw-hdmi-qp: seamless handoff sets wrong
 tmds_char_rate, breaking audio on strict HDMI 2.1 sinks
Thread-Index: AQHc3GO60gg0VILbqUOIaNFDVsDQBw==
Date: Tue, 5 May 2026 08:07:52 +0000
Message-ID: <ME3P282MB2196D46DBA2EF44DE53F4FC4A83E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=symple.nz;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME3P282MB2196:EE_|SY4P282MB3908:EE_
x-ms-office365-filtering-correlation-id: d1d32b54-6787-4882-b1aa-08deaa7d6812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7055299006|18002099003|8096899003|56012099003;
x-microsoft-antispam-message-info: 8Na6/35Xhg2c5bN/IxTBvDw4D4lkKnwIoPi63Ivaw+h8IC/gUP7pRCwOsAZwaYIib+eHKC+/MLGZMuSkmcXoroY8s+3gsIeiPyl1FA/YVpgTO9M0i6a4c9XU7nYyttUap4cQJJE1bOG+p9L99vopaiGBrnNMEF9GY/4DsOLiO+OSDEmsMEqcbquPziFCkjfftvfLSZU+UzfC8KNvZeF3B+jmNQCOA8fqSRQ4heSS2EQOubUr3IAOs7L5z7vFp8vMJ7ovLFrcYGXoIjg+KPuecZEMwD7SHi2FlDJ4s1fTjtUc5um2l8bY8pZpj1ShNkcLnNFNFsFcNlSjwoUYAqj5+3jl7sh0Vo5rJqiBeHGXekFD5XqdDDBSK3iKwtr1Jv7/OyYwIiZ8nc4HFji7wgyWqFalftwNiy9zgZttFqNFAXoLmSiW5LAUNtINnW7zh9TdJnCb5ToqPtOATQ3xmxi5YAyLBJ9ir7uuV2Z00ih01DDy1AKqCiuRTGbX2G/f2OGanCN1U52LTjhHb7I6PTmOYYYkJfQpb5pZ8dGZe44Rn7LJoa2JehdhhwXfSpZPaNFbf6crfyS6oraVtSvmLT7+rK0OiY4MJgB3BicQs8mMVotS9BJgfaPYR6sKdF6cEJwB5d3249Jo+WwOT2ShPWPRV6U66fQB5sth8gCM4sr1OPS5LEuTtyI5osL+vJbUjtWvqKZahvvr9EDrRKbAw0ElSiGiHaLgA7NxmpTKADegyE6hREIef9RN8p+KwNbQ2+4j39vtdSpJ6hdg7XCuz6mh4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7055299006)(18002099003)(8096899003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P66kSlQpGq5kkvsJKxu66p4mdggNfUbf4CXo9X7WEyDqoFMIgx+kfumCQw?=
 =?iso-8859-1?Q?GAAd87aeo4VtR5QJPPahLSquDazGHSZnFPOo8+3rwQCYy5e/b288zGyVle?=
 =?iso-8859-1?Q?u0M4vLp8/WJ7jFSNb5mKn3J73jiOcDNRSO4ykvchsn0uQIs8Z32x11ukSL?=
 =?iso-8859-1?Q?PrVE3IBJVLfH3V6szTbjcV0zrorEgGnWUQgajJqF3REx6vxfRRMw/k9p2i?=
 =?iso-8859-1?Q?9qCTMTGDO6uunZUGZD7MSJ5aVpqURoS+6M1YoE1g2dvLiyrfmOxOGNSrmK?=
 =?iso-8859-1?Q?91T6HxmhnEIjAlH0xsFQvcHkIASJWfbrqfZmr8LH7Nqp+LgyZNlJfjRgjG?=
 =?iso-8859-1?Q?l+BlNrJmOqCPtNbw1Ltkp8qojDoPpIq5qgAmIs5a9LCuKYre8wzIF9UIek?=
 =?iso-8859-1?Q?SlA3/6VuiCQgTwTWgjf4OnnDxzeXcKXKpHjnNa3G7K9ppg1rCwSJ1aNkfN?=
 =?iso-8859-1?Q?n9nrHt42Id32Exl9Zn3MNNvcLWd31TzsMLQu9AbPsYPcyCPz1gTM7OUNyd?=
 =?iso-8859-1?Q?oM2t2z46yrX3qXkAfpmE4tIZrOf1oekLs/Sx4Uw9Y4ZzaHaYxX8jZ39eS4?=
 =?iso-8859-1?Q?VsWouPQKzR8vooTiI+fmcpS13++NWt3z6+fpR8PVcO7NotLSRndkJ9j87G?=
 =?iso-8859-1?Q?fo1y0nei/asDAdPYRXBq8Bf3C89dUydodsM/5gPQxZYE2kYHrwlf09kWaV?=
 =?iso-8859-1?Q?NPUkv1x4cGzap8jH8nVvlaecpAAaFvVrQolfGP8YqGOd8sAuIFR8GaN200?=
 =?iso-8859-1?Q?DRpuYNY1WQTweo/RsLfzqsJM236ZjluRnoo9DIxHN4UOO6bha/2223nDHA?=
 =?iso-8859-1?Q?BzbBOgcioCqZtU+1gWTQJnRSLvP/wAHD+6QrxnEk8+WJvmND4nUdAQZ7qp?=
 =?iso-8859-1?Q?BbudjKqkppo1ISk1awma/S6FoC8ehD0aF1CGCtkB7Rrgb53/cjqNLEM3wv?=
 =?iso-8859-1?Q?aKCYeM7q7eTP4fVVkMWZyetD22X3AM1AWxDSvJKk7YlxsEvNcGgUNghm+f?=
 =?iso-8859-1?Q?32duNJJZ1MRNXO8O432knpYwK09S9oewSFF1FErUJDtnbApINSi81O0Qg6?=
 =?iso-8859-1?Q?hRLpe+O99kkRuGluNj1Gnlja6ct15/2FDOdv7YVs3I2+fso8z9JuUoseG7?=
 =?iso-8859-1?Q?gGSTz8Z53RDytMWUSSnKhN1BlrkQzlmtCFpE/eJ8SB4Xto5oL4QXUYvJes?=
 =?iso-8859-1?Q?ynC/ZBP9Z6MvMz6wdgzL0UC7OQOqwGIM2ejew0clSJ8ukMHf8xuQ8HBXiE?=
 =?iso-8859-1?Q?uAUulFsjkVBAXV/w1phhNZFuapo1aadOzI+1R8X0D1djHuiGgP6dDhD96A?=
 =?iso-8859-1?Q?u9YNpV8C2dMngOxfdgMs6eMP8FiKgQ0v7dQlkDRtGYoFd1Uqj6flljicYv?=
 =?iso-8859-1?Q?ksQmyc0+j4ZJilpiExdfYYU+JxUP8a/joC2J4+beZ7UInNuw5mEIfdDDoW?=
 =?iso-8859-1?Q?AQSqVRYbh6PVpHrfRzZ3FaEAROij+DOSQbeILil+UNxvufOSOPD0Wx5slI?=
 =?iso-8859-1?Q?9nXbrGg3CE/zIh1Um9uZV3Nt3Y4iq7ko/54jHLTFZPBLWORlLnmsPFltJ1?=
 =?iso-8859-1?Q?BBumhazzuSH4DtrDzqTthaxtDVqf+7U5b0q0VOt7d6mlqJbuuecSg4gotB?=
 =?iso-8859-1?Q?KSgF1O5eKMY2oxYyy9rtoUJTrQXULy5vMsO+kzhrtd5qpP+bevDLdq11+w?=
 =?iso-8859-1?Q?txF7zHHYs1IqVIDlSXKP4uSaYqKZ75WECLmZMKogXc4cJ+/FZ9TXMkYLTo?=
 =?iso-8859-1?Q?np5NveGzSURDcbP4wvi5feE7bXpEMcsneDB82o0Jkszv+F?=
Content-Type: multipart/alternative;
 boundary="_000_ME3P282MB2196D46DBA2EF44DE53F4FC4A83E2ME3P282MB2196AUSP_"
MIME-Version: 1.0
X-OriginatorOrg: symple.nz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d32b54-6787-4882-b1aa-08deaa7d6812
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:07:52.6619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9531f271-068a-4210-b471-bd8da91491c5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02y8+io+lbznku+4aOYVSoej+C2uotMMKEnxOjWUfii8OBgdK0YFXt53VPccwMCm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3908
X-Mailman-Approved-At: Tue, 05 May 2026 10:14:41 +0000
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

--_000_ME3P282MB2196D46DBA2EF44DE53F4FC4A83E2ME3P282MB2196AUSP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I have tracked down a bug in dw-hdmi-qp that silences audio on strict
HDMI 2.1 sinks (tested: LG G3 OLED) when booting with HDMI seamless
handoff from U-Boot. HDMI 2.0 sinks are unaffected. The root cause is
a mismatch between the AVI InfoFrame colour depth and the ACR embedded
CTS value.

Hardware tested:
  Source:       ArmSoM Sige5 (Rockchip RK3576)
                Armbian-edge kernel 7.0.2 (Linux mainline v7.0 plus
                Armbian board-enable patches; not a BSP kernel)
  Failing sink: LG G3 OLED 4K (HDMI 2.1, strict embedded-CTS mode)
  Passing sink: Various HDMI 2.0 TVs (self-measuring CTS, unaffected)

The bug is structural and is expected to affect RK3588 under the same
boot sequence.


Root cause
----------

When the system boots with seamless handoff active, U-Boot has configured
the PHY for 8-bit 1080p60 (TMDS =3D 148,500,000 Hz). The DRM connector
state, negotiated from EDID, selects 10-bit deep colour (TMDS =3D
185,625,000 Hz). In dw_hdmi_qp_bridge_atomic_enable():

    hdmi->tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;

This stores 185,625,000. The PHY ops->init() is called but the PHY is
already running at 148,500,000 from U-Boot and is not reconfigured.

The result is an inconsistency between what the sink is told over HDMI
and what the wire actually carries:

  AVI InfoFrame:     declares 10-bit deep colour at the connector-state
                     TMDS rate (185.625 MHz)
  ACR embedded CTS:  driver uses hdmi->tmds_char_rate =3D 185,625,000 Hz
                     to compute CTS via dw_hdmi_qp_set_sample_rate(),
                     producing CTS =3D 185,625 (internally consistent
                     with the AVI declaration)
  Wire TMDS clock:   PHY untouched from U-Boot, still running at
                     148,500,000 Hz (8-bit)

The dmesg signature (full pr_err output, lower in this report) confirms
both AVI and ACR are computed from the nominal 185.625 MHz value:
"tmds=3D185625000 ... cts=3D185625".

A standard HDMI 2.0 sink does not cross-check AVI against the wire TMDS
in any way that matters for audio, so the mismatch is harmless. A strict
HDMI 2.1 sink (LG G3) measures the wire TMDS and verifies it matches the
AVI declaration; with declared 185.625 MHz vs measured 148.5 MHz, the
check fails and audio is muted, permanently, until the next mode set.

The N/CTS values themselves are correct CEA-861 ratios. At a wire TMDS
of 148.5 MHz with N=3D6144, CTS=3D148,500 yields f_audio =3D 48 kHz; at a
wire TMDS of 185.625 MHz with N=3D6144, CTS=3D185,625 also yields f_audio
=3D 48 kHz. The driver picks one TMDS, computes a self-consistent N/CTS
pair, and embeds it. The bug is solely that the TMDS the driver picks
(connector-state nominal) differs from the TMDS on the wire (PHY
actual).


Dmesg diagnostic signature
--------------------------

Failing (seamless handoff, DRM selects 10-bit 1080p from EDID):

    dwhdmiqp-rockchip 27da0000.hdmi: atomic_enable: \
        tmds_candidate=3D185625000 is_hdmi=3D1
    DW_HDMI_QP set_sample_rate: tmds=3D185625000 sr=3D48000 n=3D6144 cts=3D=
185625
    [audio silent on LG G3]

Working (8-bit mode forced, see workaround below):

    dwhdmiqp-rockchip 27da0000.hdmi: atomic_enable: \
        tmds_candidate=3D148500000 is_hdmi=3D1
    DW_HDMI_QP set_sample_rate: tmds=3D148500000 sr=3D48000 n=3D6144 cts=3D=
148500
    [audio working on LG G3]

The difference is entirely in which tmds_char_rate bridge_atomic_enable()
receives. If the PHY and DRM state agree (both 148.5 MHz), audio works
because what the AVI declares matches what the wire carries. If they
disagree (DRM: 185.625 MHz, PHY: 148.5 MHz), the AVI declares 185.625
but the wire carries 148.5, and any sink that cross-checks the wire
TMDS against the declared rate (e.g. LG G3 OLED) mutes audio.


Confirmed workaround
--------------------

In dw_hdmi_qp_bridge_tmds_char_rate_valid(), reject 185,625,000 Hz:

    if (rate =3D=3D 185625000)
        return MODE_CLOCK_HIGH;

This forces DRM to select 8-bit mode (148,500,000 Hz). bridge_atomic_enable=
()
then stores the correct tmds_char_rate, the AVI InfoFrame declares 8-bit,
the ACR CTS is computed correctly, and the LG G3 produces audio.

Note: 185,625,000 Hz (1080p@60 10-bit) is only selected via EDID
negotiation during seamless handoff. A genuine modeset at that rate would
correctly reconfigure the PHY and the AVI/ACR inconsistency would not
arise. Blocking this rate in tmds_char_rate_valid() therefore has no
correct-use-case cost on RK3576 with the current BSP. 4K@60Hz (594 MHz)
is unaffected and continues to work correctly, including audio.


Proposed proper fix
-------------------

The fundamental issue is that bridge_atomic_enable() accepts
conn_state->hdmi.tmds_char_rate without verifying it against the PHY's
actual output frequency.

Option A (no display disruption):

  The HDPTX PHY PLL is already registered as a clock provider. On
  RK3576, rk3576.dtsi gives the hdptxphy node #clock-cells =3D <0>;
  VOP2 consumes it as "pll_hdmiphy0". If the bridge driver adds a
  new clk pointer (e.g. hdmi->tmds_clk) populated via
  devm_clk_get_optional() at probe and queries clk_get_rate()
  in bridge_atomic_enable(), it can detect the seamless-handoff
  mismatch and use the actual rate:

      /* hdmi->tmds_clk added in struct dw_hdmi_qp; populated at
       * probe via devm_clk_get_optional(dev, "tmds") or similar */
      actual_rate =3D hdmi->tmds_clk ? clk_get_rate(hdmi->tmds_clk) : 0;
      if (actual_rate && actual_rate !=3D conn_state->hdmi.tmds_char_rate) =
{
          dev_warn(hdmi->dev,
              "seamless handoff: PHY at %lu Hz, DRM selected %llu Hz; "
              "using actual PHY rate for audio\n",
              actual_rate, conn_state->hdmi.tmds_char_rate);
          hdmi->tmds_char_rate =3D actual_rate;
      } else {
          hdmi->tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;
      }

  This corrects the ACR CTS and AVI InfoFrame without touching the
  PHY configuration or causing a display blank.

Option B (correct but causes brief blank):

  If the driver detects a mismatch, call phy.ops->init() to bring
  the PHY into agreement with the DRM-negotiated state. All
  parameters become consistent at the cost of a single mode change
  on first enable after seamless handoff. This is arguably the more
  correct approach if the intent is to honour what the EDID reports.

Option A is preferred for a seamless user experience. Option B is
preferable if the seamless-handoff-inherited U-Boot mode is not
otherwise suitable for production use.


Relation to Collabora's HDMI 2.0 patch series
----------------------------------------------

The "Add HDMI 2.0 support to DW HDMI QP TX" series (v3, January 2026)
addresses high-TMDS-clock-ratio and scrambling. It does not appear to
address the seamless-handoff tmds_char_rate mismatch described here.
If a revision of that series reads PHY state at probe time it may
incidentally close this gap, but that is not a stated goal. Reviewers
may wish to verify the seamless-handoff path is exercised in testing.


Summary
-------

  Bug:        bridge_atomic_enable() takes EDID-negotiated
              tmds_char_rate (185,625,000) while PHY runs at U-Boot
              rate (148,500,000); the AVI InfoFrame and the ACR CTS
              both reflect the connector-state nominal value, but
              the wire TMDS clock disagrees with what AVI declares
  Symptom:    audio silent on any HDMI 2.1 sink that cross-checks
              wire TMDS against the AVI declaration; HDMI 2.0 sinks
              unaffected (no such cross-check)
  Scope:      RK3576 confirmed; RK3588 structurally identical
  Not a bug:  N/CTS table, IEC60958 channel status, ARC, ALSA path
  Workaround: reject 185,625,000 Hz in tmds_char_rate_valid() so
              DRM picks 8-bit 1080p (148,500,000 Hz) which matches
              the actual PHY rate
  Fix:        compare conn_state->hdmi.tmds_char_rate against actual
              PHY clock at bridge_atomic_enable() and use the
              measured rate when they disagree (Option A) or
              reconfigure the PHY (Option B)

I am happy to test patches on Sige5 + LG G3.

Regards,
Simon
Symple Solutions, Dunedin, New Zealand

--_000_ME3P282MB2196D46DBA2EF44DE53F4FC4A83E2ME3P282MB2196AUSP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I have tracked down a bug in dw-hdmi-qp that silences audio on strict</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
HDMI 2.1 sinks (tested: LG G3 OLED) when booting with HDMI seamless</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
handoff from U-Boot. HDMI 2.0 sinks are unaffected. The root cause is</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
a mismatch between the AVI InfoFrame colour depth and the ACR embedded</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
CTS value.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hardware tested:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Source: &nbsp; &nbsp; &nbsp; ArmSoM Sige5 (Rockchip RK3576)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Armbian-edge kernel=
 7.0.2 (Linux mainline v7.0 plus</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Armbian board-enabl=
e patches; not a BSP kernel)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Failing sink: LG G3 OLED 4K (HDMI 2.1, strict embedded-CTS mode)</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Passing sink: Various HDMI 2.0 TVs (self-measuring CTS, unaffected)<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The bug is structural and is expected to affect RK3588 under the same</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
boot sequence.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Root cause</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
----------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
When the system boots with seamless handoff active, U-Boot has configured</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
the PHY for 8-bit 1080p60 (TMDS =3D 148,500,000 Hz). The DRM connector</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
state, negotiated from EDID, selects 10-bit deep colour (TMDS =3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
185,625,000 Hz). In dw_hdmi_qp_bridge_atomic_enable():</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; hdmi-&gt;tmds_char_rate =3D conn_state-&gt;hdmi.tmds_char_rat=
e;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This stores 185,625,000. The PHY ops-&gt;init() is called but the PHY is</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
already running at 148,500,000 from U-Boot and is not reconfigured.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The result is an inconsistency between what the sink is told over HDMI</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
and what the wire actually carries:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; AVI InfoFrame: &nbsp; &nbsp; declares 10-bit deep colour at the conn=
ector-state</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;TMDS rate (185.625 MHz)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; ACR embedded CTS: &nbsp;driver uses hdmi-&gt;tmds_char_rate =3D 185,=
625,000 Hz</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;to compute CTS via dw_hdmi_qp_set_sample_rate(),</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;producing CTS =3D 185,625 (internally consistent</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;with the AVI declaration)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Wire TMDS clock: &nbsp; PHY untouched from U-Boot, still running at<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;148,500,000 Hz (8-bit)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The dmesg signature (full pr_err output, lower in this report) confirms</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
both AVI and ACR are computed from the nominal 185.625 MHz value:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&quot;tmds=3D185625000 ... cts=3D185625&quot;.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
A standard HDMI 2.0 sink does not cross-check AVI against the wire TMDS</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
in any way that matters for audio, so the mismatch is harmless. A strict</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
HDMI 2.1 sink (LG G3) measures the wire TMDS and verifies it matches the</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
AVI declaration; with declared 185.625 MHz vs measured 148.5 MHz, the</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
check fails and audio is muted, permanently, until the next mode set.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The N/CTS values themselves are correct CEA-861 ratios. At a wire TMDS</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
of 148.5 MHz with N=3D6144, CTS=3D148,500 yields f_audio =3D 48 kHz; at a</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
wire TMDS of 185.625 MHz with N=3D6144, CTS=3D185,625 also yields f_audio</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
=3D 48 kHz. The driver picks one TMDS, computes a self-consistent N/CTS</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
pair, and embeds it. The bug is solely that the TMDS the driver picks</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
(connector-state nominal) differs from the TMDS on the wire (PHY</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
actual).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Dmesg diagnostic signature</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
--------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Failing (seamless handoff, DRM selects 10-bit 1080p from EDID):</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; dwhdmiqp-rockchip 27da0000.hdmi: atomic_enable: \</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; tmds_candidate=3D185625000 is_hdmi=3D1</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; DW_HDMI_QP set_sample_rate: tmds=3D185625000 sr=3D48000 n=3D6=
144 cts=3D185625</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; [audio silent on LG G3]</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Working (8-bit mode forced, see workaround below):</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; dwhdmiqp-rockchip 27da0000.hdmi: atomic_enable: \</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; tmds_candidate=3D148500000 is_hdmi=3D1</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; DW_HDMI_QP set_sample_rate: tmds=3D148500000 sr=3D48000 n=3D6=
144 cts=3D148500</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; [audio working on LG G3]</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The difference is entirely in which tmds_char_rate bridge_atomic_enable()</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
receives. If the PHY and DRM state agree (both 148.5 MHz), audio works</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
because what the AVI declares matches what the wire carries. If they</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
disagree (DRM: 185.625 MHz, PHY: 148.5 MHz), the AVI declares 185.625</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
but the wire carries 148.5, and any sink that cross-checks the wire</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
TMDS against the declared rate (e.g. LG G3 OLED) mutes audio.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Confirmed workaround</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
--------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
In dw_hdmi_qp_bridge_tmds_char_rate_valid(), reject 185,625,000 Hz:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; if (rate =3D=3D 185625000)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; return MODE_CLOCK_HIGH;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This forces DRM to select 8-bit mode (148,500,000 Hz). bridge_atomic_enable=
()</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
then stores the correct tmds_char_rate, the AVI InfoFrame declares 8-bit,</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
the ACR CTS is computed correctly, and the LG G3 produces audio.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Note: 185,625,000 Hz (1080p@60 10-bit) is only selected via EDID</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
negotiation during seamless handoff. A genuine modeset at that rate would</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
correctly reconfigure the PHY and the AVI/ACR inconsistency would not</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
arise. Blocking this rate in tmds_char_rate_valid() therefore has no</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
correct-use-case cost on RK3576 with the current BSP. 4K@60Hz (594 MHz)</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
is unaffected and continues to work correctly, including audio.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Proposed proper fix</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
-------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The fundamental issue is that bridge_atomic_enable() accepts</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
conn_state-&gt;hdmi.tmds_char_rate without verifying it against the PHY's</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
actual output frequency.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Option A (no display disruption):</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; The HDPTX PHY PLL is already registered as a clock provider. On</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; RK3576, rk3576.dtsi gives the hdptxphy node #clock-cells =3D &lt;0&g=
t;;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; VOP2 consumes it as &quot;pll_hdmiphy0&quot;. If the bridge driver a=
dds a</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; new clk pointer (e.g. hdmi-&gt;tmds_clk) populated via</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; devm_clk_get_optional() at probe and queries clk_get_rate()</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; in bridge_atomic_enable(), it can detect the seamless-handoff</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; mismatch and use the actual rate:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; /* hdmi-&gt;tmds_clk added in struct dw_hdmi_qp; popul=
ated at</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp;* probe via devm_clk_get_optional(dev, &quot;tmd=
s&quot;) or similar */</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; actual_rate =3D hdmi-&gt;tmds_clk ? clk_get_rate(hdmi-=
&gt;tmds_clk) : 0;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; if (actual_rate &amp;&amp; actual_rate !=3D conn_state=
-&gt;hdmi.tmds_char_rate) {</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_warn(hdmi-&gt;dev,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;seamless handoff: PH=
Y at %lu Hz, DRM selected %llu Hz; &quot;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;using actual PHY rat=
e for audio\n&quot;,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; actual_rate, conn_state-&g=
t;hdmi.tmds_char_rate);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; hdmi-&gt;tmds_char_rate =3D actual_rate;=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; } else {</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; hdmi-&gt;tmds_char_rate =3D conn_state-&=
gt;hdmi.tmds_char_rate;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; }</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; This corrects the ACR CTS and AVI InfoFrame without touching the</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; PHY configuration or causing a display blank.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Option B (correct but causes brief blank):</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; If the driver detects a mismatch, call phy.ops-&gt;init() to bring</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; the PHY into agreement with the DRM-negotiated state. All</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; parameters become consistent at the cost of a single mode change</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; on first enable after seamless handoff. This is arguably the more</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; correct approach if the intent is to honour what the EDID reports.</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Option A is preferred for a seamless user experience. Option B is</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
preferable if the seamless-handoff-inherited U-Boot mode is not</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
otherwise suitable for production use.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Relation to Collabora's HDMI 2.0 patch series</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
----------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The &quot;Add HDMI 2.0 support to DW HDMI QP TX&quot; series (v3, January 2=
026)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
addresses high-TMDS-clock-ratio and scrambling. It does not appear to</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
address the seamless-handoff tmds_char_rate mismatch described here.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
If a revision of that series reads PHY state at probe time it may</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
incidentally close this gap, but that is not a stated goal. Reviewers</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
may wish to verify the seamless-handoff path is exercised in testing.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Summary</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
-------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Bug: &nbsp; &nbsp; &nbsp; &nbsp;bridge_atomic_enable() takes EDID-ne=
gotiated</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tmds_char_rate (185,625,00=
0) while PHY runs at U-Boot</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rate (148,500,000); the AV=
I InfoFrame and the ACR CTS</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; both reflect the connector=
-state nominal value, but</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; the wire TMDS clock disagr=
ees with what AVI declares</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Symptom: &nbsp; &nbsp;audio silent on any HDMI 2.1 sink that cross-c=
hecks</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; wire TMDS against the AVI =
declaration; HDMI 2.0 sinks</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unaffected (no such cross-=
check)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Scope: &nbsp; &nbsp; &nbsp;RK3576 confirmed; RK3588 structurally ide=
ntical</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Not a bug: &nbsp;N/CTS table, IEC60958 channel status, ARC, ALSA pat=
h</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Workaround: reject 185,625,000 Hz in tmds_char_rate_valid() so</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; DRM picks 8-bit 1080p (148=
,500,000 Hz) which matches</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; the actual PHY rate</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Fix: &nbsp; &nbsp; &nbsp; &nbsp;compare conn_state-&gt;hdmi.tmds_cha=
r_rate against actual</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PHY clock at bridge_atomic=
_enable() and use the</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; measured rate when they di=
sagree (Option A) or</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reconfigure the PHY (Optio=
n B)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I am happy to test patches on Sige5 + LG G3.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Simon</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Symple Solutions, Dunedin, New Zealand</div>
</body>
</html>

--_000_ME3P282MB2196D46DBA2EF44DE53F4FC4A83E2ME3P282MB2196AUSP_--
