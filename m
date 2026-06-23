Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82A5CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353A710E99A;
	Tue, 23 Jun 2026 07:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="KDOJkSpg";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="edfLp8It";
	dkim-atps=neutral
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EC210E99A
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 07:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782199312; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=QQUMVuCmprsUvLufs6tSB1+WCSRww7E5jXwHru1wWN6WGT60qx6ApOko56Re24OmZX
 gxxPdoAIDil79DIbOWj4zi3DjyyW0G0Q9oY4shzPzumqJ8hwwNCPutTX70REwD3XafsN
 jwIq8/OlXploq38nY+K4qOBNff8aP14sCLyFMtT62QbZHMSc69+IQnUy8qJelTB8JJiX
 6x+2RA/YiuYsBaPu2QMgHs8YpPrxbn34R3xYxZWq5kpOllItWWYh4NzqKzJMMpHaW4iO
 UGPLWr2pMpbpFT3EdNLM6hOq5oNWUPEQanaKm3PPIHPbtoM0b0hFvzesnnN1djU4yJ4f
 dQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1782199312;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=b5lbrRDDpOLTgaaqCGWGQ6PZSP/UkHzAx3d74e6/hKQ=;
 b=BmSbN4q+MXNa8s0tbgYXMZY3EFgaRHu1UIVRH5w+u1z5OnGR2sy1ZdWDyQ8TTySj82
 TntJWea1JslzfhTI6j7LPodX4QzVif25gbeOfiD2PBcJvMAxP6iWTeKWxm1yli+GisAj
 FeiIHldv5RLHhgInscfip5rzNUed0vHE/0KxbaxOytl+jxF7hyhEIVCftrNOxskzX0eW
 hKqranVjeuDd0jbg0W/pRDm098Q5FazQjf6a9yc5BXI/h7EEdqHZcvEMh8wxcJJ3TFqp
 OTorcBOaybEZNP+kcs0CcWUeTSHiuWY6OuZcodR5cnm5JE2c3UN/d6PtZs/FV3RU4gMl
 Zv2g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782199312;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=b5lbrRDDpOLTgaaqCGWGQ6PZSP/UkHzAx3d74e6/hKQ=;
 b=KDOJkSpg3ZlNiM/ooWFuVDG7uNoemazibKaoslnSUGbPz4+auV3VCQcIL1fZlCCFMO
 cJY6f5YvA9jgu9RXPW0DQjb03IW4wyytc3GPh5z1tQfqonqMTxeTkMutJAi2Ap2JfnpB
 TXM3gMUi6epptSy1FWo8EPHct6HMV7quIqCm3g1fv3uiosKA3eKupBaefWalfw2jY/3D
 LeR6JQRxxoP1lUzEx0buSAnzaZCC+gbgN2TA9AYYd2FlQ1c/+l+2Ir8wmrrpQwYTyqoE
 Sfq5EFMbjN4/PWDnLlue6IZfg6zwVVKDaR8o41UVFmVBGKbWSOEPO7yWX2oGfUPZq59W
 YwIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782199312;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=b5lbrRDDpOLTgaaqCGWGQ6PZSP/UkHzAx3d74e6/hKQ=;
 b=edfLp8ItoZ1Khs6OdvwxSWaqW9/gFmtxH3JJzPKZgO7kS7Ye33yc5uo3p5ZmvcZQF6
 NrIDsyPMlrCU3F1sTGBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT3ppdzsiNsOz5aTA7oOYU7otmLOEb1cQTmFAp"
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.0.1 AUTH)
 with ESMTPSA id Qcf97c25N7LovdO
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Tue, 23 Jun 2026 09:21:50 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] drm/fb_helper: Determine proper crtc_index within
 drm_fb_helper_fb_dirty
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <fb12d338-b895-40e4-9a3e-791b8ecb3af4@suse.de>
Date: Tue, 23 Jun 2026 09:21:39 +0200
Cc: sashiko-reviews@lists.linux.dev, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, Andreas Kemnade <akemnade@kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A439B33-EB85-49AB-8BD1-C62121380D4A@goldelico.com>
References: <5118b37e579cec220f2d2b6ab0bb1ecfb67f0d5c.1781803617.git.hns@goldelico.com>
 <20260618174310.70DB11F000E9@smtp.kernel.org>
 <50FDBC3B-BFC2-4BC6-B216-78C2C24D9E30@goldelico.com>
 <1c9e0e24-9c4a-4259-8700-cf9e5fd60ca3@suse.de>
 <D08962D1-4D1D-49C5-A60F-89CB7F7E0378@goldelico.com>
 <fb12d338-b895-40e4-9a3e-791b8ecb3af4@suse.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
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

Hi Thomas,

> Am 22.06.2026 um 07:58 schrieb Thomas Zimmermann =
<tzimmermann@suse.de>:
>=20
> Hi
>=20
> Am 19.06.26 um 19:17 schrieb H. Nikolaus Schaller:
>> Hi Thomas,
>>=20
>>=20
>>> Am 19.06.2026 um 10:50 schrieb Thomas Zimmermann =
<tzimmermann@suse.de>:
>>>=20
>>> (cc Icenowy)
>>>=20
>>> Hi,
>>>=20
>>> there are a number of similar reports. Does the attached patch fix =
the problem. It picks up what you do, but in a more correct way.
>> Yes, reverting my version makes the issue come back and after =
applying yours it is again gone. At least in the scenarios I have tested =
for the PandaBoard-ES (boot/reboot, unplug/replug, second display or =
not).
>>=20
>> Should I take your corrections and resubmit or how to proceed?
>=20
> Several people have reported the problem and asked for a fix. I'll =
send the patch out for review. I'll add you as Co-developed-by, if you =
like.

Yes, that is fine.

I have successfully tested v2 and will reply there.

Thanks and BR,
Nikolaus=
