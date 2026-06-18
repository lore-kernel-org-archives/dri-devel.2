Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54A3CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A104010F3B5;
	Thu, 18 Jun 2026 17:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="kJ1iCQTS";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="qPcunTjt";
	dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5D710F39A
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 17:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781805371; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=biIWkRYcrCn1wzCiW5vgV3hnFpUomIyR6Vch0iCp8TJA0LTrJqXES6LawadArqtntX
 5I3Ak+DzwZzooNg//zVgzkP2UbHzPbI/QCC0XJW70Z5d92eeCGI/frJXimZKVFiYk71O
 w5qGlE9Trv0gEGNn014ovQldFLRGeGV937t9fjGnQJIMhPS/XUeht0RT9C2dUfiKvrx+
 PW4KiopE4G8opIZippFiCI49c3hESLDwD9JUQih9T1KQOsBZjY6ivNePNh2EVOuJDZNf
 fTBico1ZrMRntPcuxqsl1OUOsruhp018Yoff8aMwfTlRVoSs8tfwQGrTspgsOvowvtks
 8HaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781805371;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=zsVPEWZ+mX351yEn9Wdd5+9zEGjn0ObEo6N4OFCKFe4=;
 b=cApQwGWcLQy2VNingyuSiac0uR/JzKo/aFX7emoy186bidMa9jxzdU3zrSJ8wPeUhF
 FveIWir1bIRb+PGAaYJt8GZliRlAZbapkMSgY/BmoXpm96UymdT6vVbSA9bZyl5YYWbp
 Pv/Q4gIOziQN2kJdn+Rlm8wSj8AblvJahXSIajkp8q8+ArJL4BqeC6CanhgHP6P4n66r
 S6NOJmr8YMYoEjPaXqpQRTD0/pB2TDNgUyyaLOIKYwF/deEeo77eLYXkCZUXzLJ2a/Ie
 ETIH6Z9fnmUQh5hKgL7MvCNB4m3uSgUdhrjputG+0kkv+FqstGUN2CNKitiSuKprlpdM
 3ARg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781805371;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=zsVPEWZ+mX351yEn9Wdd5+9zEGjn0ObEo6N4OFCKFe4=;
 b=kJ1iCQTS/qe6kuYIvSD8esu+D4kTx7Ioy4Qo4yn7MiLJpf1CloZXtDVJVALW0r8i/z
 Sr2M2jBFrmX7sWsJ6ARkL2WFmEsk7f3fsOc+RROLpxl4K7b9ipU4pCH6H6kCLRxcY5qa
 13Dj8cd6YnW+2g8As95iEDRma2Xr5odFYNLgStfvy3hHKY63ghB58ythfipd4NaidP2z
 0tRcmaMzMA9CU1JUSWT+Q+DdpqBS2bf8MvryNbSABTQH5uXc1sSE7tIP1K9cSOfRGVP5
 VWYLC1l9ZhQbMMDoG0++kTV7WmOjCzLHOIHUyyqVDk3mxD/MnHdTMkvxZwrURKRLjfnA
 /IeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781805371;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=zsVPEWZ+mX351yEn9Wdd5+9zEGjn0ObEo6N4OFCKFe4=;
 b=qPcunTjtGsq5YMj4R2rLk6U5TdNUR6khGjwBnfooOOAE0vwIsPHeQP8t5HNVxXzSC5
 qAnxnJn89YccuatXctCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT0ZoOnciNQh0E54wP3opQ+1mzcazh2bvtQoZf"
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.0.1 AUTH)
 with ESMTPSA id Qcf97c25IHuBfsN
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Thu, 18 Jun 2026 19:56:11 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.6\))
Subject: Re: [PATCH] drm/fb_helper: Determine proper crtc_index within
 drm_fb_helper_fb_dirty
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260618174310.70DB11F000E9@smtp.kernel.org>
Date: Thu, 18 Jun 2026 19:56:00 +0200
Cc: dri-devel@lists.freedesktop.org,
 Andreas Kemnade <akemnade@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50FDBC3B-BFC2-4BC6-B216-78C2C24D9E30@goldelico.com>
References: <5118b37e579cec220f2d2b6ab0bb1ecfb67f0d5c.1781803617.git.hns@goldelico.com>
 <20260618174310.70DB11F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3826.700.81.1.6)
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



> Am 18.06.2026 um 19:43 schrieb sashiko-bot@kernel.org:
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
> - [High] Lockless access to `crtc->state` and `crtc->primary->state` =
can lead to a Use-After-Free due to concurrent atomic commits.
> - [High] The patch breaks vblank synchronization for legacy =
(non-atomic) DRM drivers.
> - [Medium] The logic selects the first matching CRTC instead of the =
last active one, contradicting the commit message.
> --
>=20
> commit 0337b26b606b4d905d72ea2be31bcb984fe62c6e
> Author: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> drm/fb_helper: Determine proper crtc_index within =
drm_fb_helper_fb_dirty
>=20
> This commit updates the dirty framebuffer worker to search for a =
matching
> active CRTC instead of hardcoding the wait for vblank to CRTC index 0. =
It
> aims to avoid vblank timeouts when CRTC 0 is inactive.
>=20
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c =
b/drivers/gpu/drm/drm_fb_helper.c
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
> [ ... ]
>> @@ -232,9 +232,23 @@ static void drm_fb_helper_fb_dirty(struct =
drm_fb_helper *helper)
>> struct drm_clip_rect clip_copy;
>> unsigned long flags;
>> int ret;
>> + unsigned int crtc_index =3D 0;
>> + struct drm_crtc *crtc;
>>=20
>> mutex_lock(&helper->lock);
>> - drm_client_modeset_wait_for_vblank(&helper->client, 0);
>> +
>> + drm_for_each_crtc(crtc, dev) {
>> + if (crtc->primary && crtc->primary->state &&
>> +    crtc->primary->state->fb =3D=3D helper->fb &&
>> +    crtc->state && crtc->state->active) {
>=20
> [Severity: High]
> Can this lockless access to crtc->state and crtc->primary->state =
result in a
> use-after-free?

No idea...

>=20
> The drm_fb_helper_fb_dirty() function holds helper->lock, but does not =
hold
> the DRM modeset locks required to protect these state pointers. During =
a

Which locks are exactly recommended to add? What is their name/pointer?

> concurrent atomic modeset commit, the DRM core allocates new state =
objects,
> swaps them into place, and frees the old objects via kfree().
>=20
> If this code reads an old state pointer and gets preempted, could it =
then
> dereference the pointer after it has been freed by the concurrent =
commit?
>=20
> [Severity: High]
> Does this break vblank synchronization for legacy non-atomic DRM =
drivers?

>=20
> Legacy drivers do not use the atomic modesetting infrastructure, so =
their
> crtc->state and crtc->primary->state pointers remain NULL. Since the =
condition
> above requires these pointers to be non-NULL, the loop will skip the =
vblank
> wait entirely for legacy drivers. This skips the intended =
rate-limiting
> behavior and could lead to unbounded damage worker execution.

What is the solution? And is this important.

Before d8c4bddcd8bcb ("drm/fb-helper: Synchronize dirty worker with =
vblank")

there was also no rate-limiting behavior.

>=20
>> + crtc_index =3D drm_crtc_index(crtc) + 1;
>> + break;
>=20
> [Severity: Medium]
> The commit message states "If multiple CRTCs match, the last active =
one is
> selected." Does the break statement here cause the first active CRTC =
to be
> selected instead, bypassing the remaining matches in the list?

Yes, that is correct. The description is indeed wrong.

>=20
>> + }
>> + }
>> +
>> + if (crtc_index > 0)
>> + drm_client_modeset_wait_for_vblank(&helper->client, crtc_index - =
1);
>> +
>> mutex_unlock(&helper->lock);
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/5118b37e579cec220f2d2b6ab0bb1ecfb67f0d5c.17=
81803617.git.hns@goldelico.com?part=3D1

