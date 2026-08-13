Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11E5C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90E4F10F1DC;
	Thu, 13 Aug 2026 08:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="f8zRB0OR";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="N02ZDZSi";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2013310F1DC
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786609877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=mOaM89HDkhz0YSMPBacVagDnalThEgWQpZeX3ZxGlSw=;
 b=f8zRB0ORu+Cj4pc82iLCeQDtQI9lyUz+0gOVlMOB/Nk6U0sXDyBW1jSmvFhy8+IrTJNgPq
 RK5K8wJz1abdRQFspG9D0kTi7QygitgMGOkAESfbvj2kw5o14o0X8cV3NEpZl37/VyJlB6
 wqq/eX7WDg3H+9+C2I/mRmH/vCacCc4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-D3yZ6lifNsyWMeBi_OLU5Q-1; Thu, 13 Aug 2026 04:31:13 -0400
X-MC-Unique: D3yZ6lifNsyWMeBi_OLU5Q-1
X-Mimecast-MFC-AGG-ID: D3yZ6lifNsyWMeBi_OLU5Q_1786609872
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47fecbb7f88so1330385f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786609872; x=1787214672; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mOaM89HDkhz0YSMPBacVagDnalThEgWQpZeX3ZxGlSw=;
 b=N02ZDZSiIcJ5pQYsUUHPmflY3wKl+5yqAYtd6i2uuh1vNYqSE5tHWihY3gIZvvrX+V
 VjzEtN3jkhV/+DgS1Kq98HKbASMuf7kYC2NefEBIUCUSkF371X7WXPP6zD6CDN90rmrK
 4kr4zyIbSE60PIZdCOdDy06hUUcv4bwN6HO+OYtyEMk7ma5lSGHG5bvEk/u5mhWiCrDB
 WcN5nPHYDSyQCTu/E8yCIH7utImGRcoRIi8vDfm4WxRvDnrpn2tzzKvWfoQr/suquXox
 RtyVcqlVI4KdDDKE1zMs8TfJTEGdyYmx+Y+65nhqBthzNmUjo1VAJWZLazf7QFX7hIIU
 9SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786609872; x=1787214672;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mOaM89HDkhz0YSMPBacVagDnalThEgWQpZeX3ZxGlSw=;
 b=Aw7LDNY//XKT8B0sFRz5P9XG5ZCCdm/GccMhEOjgUiL19HZMPdNMNUwXvjTsY5Bt3j
 iNZkSpcWeEC/VsTU964YTJsKR4DD43uqhayT5OgA8gaT285Hykcx8e8AN0UBIP0qeSv9
 FDr6Flg3/HfY5eVaWTjPRE+4wOPWBrP2Y4p5aEqjZbqgIyvA65fcZiB1Y0UmPZho73jH
 a7+v37vHBo+AHTgulwcHnq0IAky4wxztevYM3kYKDCU1v1kIP1hpAkHQXyY8ItAlNtDU
 TKoRKqFSkDzFeN7ZLkR9gHMyyrljn/xc2Bk45KoOSgucNHCQ0UUllqt5uzAVGX5803hU
 EwGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbbkO1e7xAvYZ3ukt9bPyGJtVyNRLTPYquSFH/Frbz6zd5+q7MTAW0fbrsQpBb/TmcHQoP0g/1CHc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz03og1SVKtlZR91zNBSKcnGcDdc4culCIOIJOfHKBH8LjdWOgF
 u9ksGBgqd+xtc2b5CLMnmmZG7vVvKzXREqMABy8nl2ZiST2C15I2pNV+qcDfTz1erZAmbyr01xO
 Vj1rka3hDghZ2RmtlJNGVaKBCsmzbNVxZYcn4L3z93QfP1LLEnSk21bcgt5XkA0sJd1tH1g==
X-Gm-Gg: AR+sD13wAC9havf3/Z4DrLkXqsTL5bt2kJmfMrcQxiz9Opdl3tCecbL9W5B7z5M+zZ/
 8//x2l+SiK/jsCs3PDfPbm/xVe3vKuqWJoFDWsmn/OyZpdMQjVw1t9KgoFrQL0WyQaxc0E7deU3
 mUR2brX47qVFXIZ5qBPJDFDj0YETLJdVdoVRol6LhL/gLtDOULn9o3gb5SWDSwky8XY8rk7ONOd
 NkrrG3bXnM2ApY4tDHLWFudPfoJ24YuWR8JBwxO+Bve5sINg+IhPT2yS8jQykmvFHMJpDmv1igD
 9l2iMliCrFtphFD+POADcVtsfqr2pUCseNvPGn9O4xE9f4RiLUOTtdnwh634RWkpNLuwfRzb
X-Received: by 2002:a5d:5e0f:0:b0:47f:f002:3652 with SMTP id
 ffacd0b85a97d-48159ec134bmr3757724f8f.12.1786609872471; 
 Thu, 13 Aug 2026 01:31:12 -0700 (PDT)
X-Received: by 2002:a5d:5e0f:0:b0:47f:f002:3652 with SMTP id
 ffacd0b85a97d-48159ec134bmr3757608f8f.12.1786609871940; 
 Thu, 13 Aug 2026 01:31:11 -0700 (PDT)
Received: from localhost ([193.32.126.230]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a569c2bsm4834411f8f.12.2026.08.13.01.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 01:31:11 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:31:10 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Dave Airlie <airlied@gmail.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-misc-next-fixes
Message-ID: <20260813-shrewd-ocelot-of-research-aa3caa@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="suhigkbeilmgqoi7"
Content-Disposition: inline
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


--suhigkbeilmgqoi7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [PULL] drm-misc-next-fixes
MIME-Version: 1.0

Hi,

Here's this week drm-misc-next-fixes PR

Maxime

drm-misc-next-fixes-2026-08-13:
A single patch to remove a .orig file introduced by accident.
The following changes since commit bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb:

  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager (2026-08-06 23:38:04 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-fixes-2026-08-13

for you to fetch changes up to 651b0bd0922b265c6c58d9dc84ef3fd00782a0cd:

  drm/panel: remove accidentally committed .orig file (2026-08-11 09:52:43 +0200)

----------------------------------------------------------------
A single patch to remove a .orig file introduced by accident.

----------------------------------------------------------------
Jani Nikula (1):
      drm/panel: remove accidentally committed .orig file

 drivers/gpu/drm/drm_panel.c.orig | 722 ---------------------------------------
 1 file changed, 722 deletions(-)
 delete mode 100644 drivers/gpu/drm/drm_panel.c.orig

--suhigkbeilmgqoi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCan2AzgAKCRAnX84Zoj2+
dia+AYCP0BltvwyQ7/SqoocphlEHhiDyAjvq+dDu9CFmXSdQOB1lRjFEwC47joGA
25uFrlwBgLiZ39Yp78hmd7fnOHuL+iLCnGHba969jDwOPPbYHXPJSaiCOdVOWJS+
NkdPK3EBBQ==
=Y1KQ
-----END PGP SIGNATURE-----

--suhigkbeilmgqoi7--

