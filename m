Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF6BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F4210E58C;
	Mon, 13 Jul 2026 07:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="OhVv1/p5";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="/Y3INTFq";
	dkim-atps=neutral
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [81.169.146.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DA110E58C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783928749; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=CKyYwBRh27G1FfyXksiMI5izks3ghlwMeXYXAGlUBBuhg59SevbUqrlZxde8aqEoko
 4OPI5xqpvGd3pGRJdZ6lfnY7/4BYjQ8NFA8cFHSk/e7XMAmo26jsQODVvMXCDJpaWwFf
 jO6QpTXZqxzUuCetRsViP5EzzItMCwrngzCt9SSQFl5DSXtOXt8Q+GmY3nJ3wOs3dFOY
 HxSvnG/pkKMH52UJy1axfQ2yCPytTSUwkWbLY7xFDcVZaPj5l6aqv27vz6fVXAaQnbY2
 hzeBgJ9HQG8NlBHwF2QSbl7rkjhYjvjc5Kq5SKl5vvnH+siYA0KJ8TXInL2mYdQYSX4/
 dWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783928749;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=sijEzrb1feGm2F1vOJLhOdU/owoLS412woncOn4m3gk=;
 b=tXgQ+dcgIxNae91SG1hXJxSOHEXe2iB5PpHiPOCcxaKvW37zA7HMpoDFoFSSddIvnB
 9R38um/bVPOh2pTG1GvBuS+kQoeIhcWtbcy7uHaM9WcOyUKFhmI2FG+wBcxmmSb5H6N9
 rtzWbxFZcJirbNBRny+jETBxAtVE4SPbPKMtP1XeBPaCS6suw1y9/BpJrHFMcmISNIxo
 gzDtLAvNV0rL3r2IQbkIE74sWMs2JOIeBx7iDN0lvrqBlvYP8zCD8y9ndUPLhg1HiFhK
 c3CQGQ2OcEsgTjBXg2AzXZ7NicHS90kFjArpcVUtzbGT3KI8t8jVhrBfYB+YlMqj3owP
 H2uQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783928749;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=sijEzrb1feGm2F1vOJLhOdU/owoLS412woncOn4m3gk=;
 b=OhVv1/p5eIN0iQG04Ox3+GhpRm/mjnP24sAy5UIn3Rfbfi5y80BPODauC7sogyu2zU
 gvd4d4elOLkckSVQgh7Xz6DYSUUBXllzTxGJaZEzS8mqhB0XAdKK6MC8E+OuIMCmD8I8
 ZeJmD7vuxC7CqdJfwHT7NMKf3EcPrfh29Q/i/Plt3x5tPfsu2VHljz32xnL54tJi8OLf
 MPKI8z8U3U9zih3tKwmubFyboOXtnDRt+ypqi/EYnB9BVEz9pmG/mBFX0m0IVBh2raWD
 h0beUQ3A3eZ6B44m7PhriuSQO9fnECeQIxhAvgzwS4KPFnFyy5rEQbYxW2lgmoI0ckEk
 ByzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783928749;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=sijEzrb1feGm2F1vOJLhOdU/owoLS412woncOn4m3gk=;
 b=/Y3INTFqfXFt7MiSQ95cknOis1XhKgw+zOZpM+j2mLtYvgnWf4e5Qw+fWcPs8cfBln
 eOr/XaNZ2lbUKfKB2tCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQi5pZlciNgDl2kEp5oHJ2/c57N2Mc49IfXTKd"
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.5.6 AUTH)
 with ESMTPSA id Q4b76426D7jlMef
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Mon, 13 Jul 2026 09:45:47 +0200 (CEST)
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_DFB1B951-B548-42D7-A684-5497EC1819D3"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [Letux-kernel] [PATCH 07/16] ASoC: dt-bindings: add TI PCM1773
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260713-abiding-jumping-ape-7ce8ff@quoll>
Date: Mon, 13 Jul 2026 09:45:36 +0200
Cc: linux-fbdev@vger.kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org,
 Liam Girdwood <lgirdwood@gmail.com>, Niranjan H Y <niranjan.hy@ti.com>,
 Sen Wang <sen@ti.com>, Rob Herring <robh@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>,
 Helge Deller <deller@gmx.de>, Lee Jones <lee@kernel.org>,
 Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org,
 Daniel Thompson <danielt@kernel.org>,
 Grazvydas Ignotas <notasas@gmail.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 mfd@lists.linux.dev, linux-sound@vger.kernel.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 kernel@pyra-handheld.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>
Message-Id: <2D7D677E-CAE8-4FA2-9541-0B46E174018E@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <a02383ea5907a677f4c61066d423efde2b9de48b.1783749722.git.hns@goldelico.com>
 <20260713-abiding-jumping-ape-7ce8ff@quoll>
To: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Content-Transfer-Encoding: 7bit
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


--Apple-Mail=_DFB1B951-B548-42D7-A684-5497EC1819D3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Am 13.07.2026 um 09:38 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>=20
> On Sat, Jul 11, 2026 at 08:01:54AM +0200, H. Nikolaus Schaller wrote:
>> PCM1771/3 is a simple audio codec that can be enabled through an
>> enable-gpio.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../devicetree/bindings/sound/pcm1773.yaml    | 32 =
+++++++++++++++++++
>> 1 file changed, 32 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/sound/pcm1773.yaml
>>=20
>> diff --git a/Documentation/devicetree/bindings/sound/pcm1773.yaml =
b/Documentation/devicetree/bindings/sound/pcm1773.yaml
>> new file mode 100644
>> index 0000000000000..f3e640705bf70
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/pcm1773.yaml
>> @@ -0,0 +1,32 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/bindings/sound/pcm1773.yaml#
>=20
> You need to use latest existing bindings as starting point and test =
your
> code.

The bindings were forgotten since they do not influence code for testing =
and running code doing what is expected is the ultimate test.

Anyways, sorry.

BTW: the sashiko bot also reported a lot of things and a v2 is being =
worked on.

BR,
Nikolaus=

--Apple-Mail=_DFB1B951-B548-42D7-A684-5497EC1819D3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>Am 13.07.2026 um 09:38 schrieb Krzysztof Kozlowski =
&lt;krzk@kernel.org&gt;:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">On Sat, Jul 11, 2026 at =
08:01:54AM +0200, H. Nikolaus Schaller wrote:</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">PCM1771/3 is a simple audio codec that can be =
enabled through an<br>enable-gpio.<br><br>Signed-off-by: H. Nikolaus =
Schaller =
&lt;hns@goldelico.com&gt;<br>---<br>.../devicetree/bindings/sound/pcm1773.=
yaml &nbsp;&nbsp;&nbsp;| 32 +++++++++++++++++++<br>1 file changed, 32 =
insertions(+)<br>create mode 100644 =
Documentation/devicetree/bindings/sound/pcm1773.yaml<br><br>diff --git =
a/Documentation/devicetree/bindings/sound/pcm1773.yaml =
b/Documentation/devicetree/bindings/sound/pcm1773.yaml<br>new file mode =
100644<br>index 0000000000000..f3e640705bf70<br>--- /dev/null<br>+++ =
b/Documentation/devicetree/bindings/sound/pcm1773.yaml<br>@@ -0,0 +1,32 =
@@<br>+# SPDX-License-Identifier: (GPL-2.0-only OR =
BSD-2-Clause)<br>+%YAML 1.2<br>+---<br>+$id: =
http://devicetree.org/schemas/bindings/sound/pcm1773.yaml#<br></blockquote=
><br style=3D"caret-color: rgb(0, 0, 0); font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">You need to use latest =
existing bindings as starting point and test your</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">code.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Menlo-Regular; =
font-size: 11px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote><div><br></div></div><div>The bindings were =
forgotten since they do not influence code for testing and running code =
doing what is expected is the ultimate =
test.</div><div><br></div><div>Anyways, =
sorry.</div><div><br></div><div>BTW: the sashiko bot also reported a lot =
of things and a v2 is being worked =
on.</div><div><br></div><div>BR,</div><div>Nikolaus</div></body></html>=

--Apple-Mail=_DFB1B951-B548-42D7-A684-5497EC1819D3--
