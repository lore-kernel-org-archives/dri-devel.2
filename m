Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1904C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4CFD10E228;
	Wed,  5 Aug 2026 19:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="eoc0RY7k";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="bEx1R8/L";
	dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C457E10E228
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 19:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785959490; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=jDk97eSIsj/FiOtF2VuZy3gNOOh0Rn82bAdFnpsmWtUQIgVOPk8t78YSp1kMPOoXym
 KZBqzHXzxZQqdp5mS0iAaOlhim1PzogqBnP2Xg/QvIYqkjM+qMmwyJIcI1PZNCPO272q
 gwARq2aR4omZf5iJfsMtacVpOQoTb4T3BnStLyNFH3fPkW4O7xWkQ/BOfsqW/28kPQ7F
 p4PQgnnkkSKovorigmtzWI/qQ7dF9gi949TB7+OkGR+4LJsfdmjtUskyYAbCAthBwdfn
 mgmgmp+vinfIIloyPw73hVkijUxK76nFSJ3s9gRUOTaFkrplOZ+lPBXqWmIadmVuyeui
 Kg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785959490;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=gRQMXLrE1Pl/0HI0hxEuEIxv7cmhYpzIf3AFh6qVGiE=;
 b=ZUMZFYGdlec+MAHagXaG9dnU3aUpwA2ylsrUDgzFddr89wa4ci0s3nFnKKD/jxGfMt
 PehyOorE/0aAKE/FHMF17exyDCOC8YVwLNR+wsao3xSnq5AA4hHlQQaxh1JH4j/O8x2I
 ntdNCiffKWhdH/We8ZFGE+0lM2EQoUM4z0w/Sm6UpqxDJBgUsE0vbkHy/c68gkUOmMBF
 HZqVoqBkbLgaOAArlK46CNLmrCowMEvjTcwNz6EAOtiH45P7hBjjcNuNPwaLliUJyqs2
 yLUSTuIjsPFxwlcPfTHT1/RVXoS0oxYr8+C6ian5+ERj8pCE0OPVK1nC8nfpWVr2TFy6
 kvuA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785959490;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=gRQMXLrE1Pl/0HI0hxEuEIxv7cmhYpzIf3AFh6qVGiE=;
 b=eoc0RY7kIC+ZjYsmwQy3lawDSKKOxyaWcl4e65LUi02NC3q9mhWAwl+ygYUmxNanxI
 OeGmLSdIVGciX1OuqQ/2aTASY1WwnVzSglt3UcLzClsLjjWvzqolZ4Uc89Qgf4HnNP+J
 IaeTFsO6/YdzGhsQGtDErSDsBy5fhJVNWG1nwIu/hQgkExECq6zbczc6Ie25LsFdc8tA
 qeZsuyAOWLTRl0j8d/CZkKF5mau7BWzVyaDSf/D6ND8D3h7SunnfJDpRueJIeYcTdROO
 QXm3eNzctyNBEq5bi2qsjuXXksDRIQb2/IuK0HVQTaHSTVaYcrGmD8sIc8OCuoFLkRk7
 G2Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785959490;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=gRQMXLrE1Pl/0HI0hxEuEIxv7cmhYpzIf3AFh6qVGiE=;
 b=bEx1R8/Lbylcfw7kTb7XimPQBZrsvfDFbWXprthHS2QG4gwxE+sWyDBTcbwd297hjr
 FbF76HR6ZyK6Va8lsmBA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ25oGlciNdEAAfky2+DDg1anEjIRYC+O6IISs"
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.5.6 AUTH)
 with ESMTPSA id Q58eac275JpSRFY
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Wed, 5 Aug 2026 21:51:28 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] drm/omap: Report HDMI hotplug events to the ASoC HDMI
 codec
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260805152057.1291659-1-ivo.g.dimitrov.75@gmail.com>
Date: Wed, 5 Aug 2026 21:51:17 +0200
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C85854EB-E77B-4113-9E81-594EEBE936A3@goldelico.com>
References: <20260805152057.1291659-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
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

Hi Ivaylo,

> Am 05.08.2026 um 17:20 schrieb Ivaylo Dimitrov =
<ivo.g.dimitrov.75@gmail.com>:
>=20
> The OMAP HDMI audio driver currently has no way of reporting HDMI =
cable
> hotplug events to ASoC. As a result, user space cannot detect HDMI =
audio
> availability through the standard jack mechanism and audio policy =
managers
> cannot automatically route audio to or from the HDMI output.
>=20
> Add an optional HPD callback to `omap_hdmi_audio_pdata` and invoke it =
from
> the DRM HDMI bridge whenever the connector status changes. The HDMI =
audio
> driver registers an ASoC jack and reports `SND_JACK_AVOUT` state =
changes in
> response to these notifications.

Some quick test:

I have tested on PandaES and could see 'amixer -c 1 events' and check =
the on/off
status though 'amixer -c 1 cget numid=3D1' on the HDMI port (no sound =
for DVI port
of course).

BR,
Nikolaus

