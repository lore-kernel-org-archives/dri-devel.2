Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FB41075271
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 07:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFBA10E8C0;
	Thu, 19 Mar 2026 07:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IrPrjkB4";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JDGox7sN";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E823510E8B8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 07:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773904837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=fe51MXVKNtt97IK2v9bXGEUIRb61ACw33tyTc00UOXY=;
 b=IrPrjkB4wA1zP25UL/aFP9/mP5/jjClo2Rqi8ft0MVSwaQol+JcPzn1qWYypnsKTSks1Gc
 KChMYrFB5jEOHRkV7KUfaxzTmvEYmgUOV5KGOi2JmMSjjpJoYOh+HzyaldgfPjfCFa4tVx
 wyn9V4FPA/g6lNOi5mvwpN2gb5Z+mqs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-tANdspHvMEqCpypaNYlHVQ-1; Thu, 19 Mar 2026 03:20:36 -0400
X-MC-Unique: tANdspHvMEqCpypaNYlHVQ-1
X-Mimecast-MFC-AGG-ID: tANdspHvMEqCpypaNYlHVQ_1773904835
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so8303805e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773904834; x=1774509634; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fe51MXVKNtt97IK2v9bXGEUIRb61ACw33tyTc00UOXY=;
 b=JDGox7sN4hj9kSDNSDN96WFZHJ9kNnlKZtpXJIEcmA4AZ9yDcqWVGFkEr9bSF2+Xxh
 Uz82yQIvahS1mcW5fvA/tI6TPMnujITS0s8YokxySxqAqi8PjCL33cSgdkmC7Q+kCUm/
 R1uL/L0SO+aKcY4XIC/CkyCKz9BtSrjlfUK4VQwat+SfRlAp04r0bZk48a8IzYinChfN
 JMNCWowhJOZdYi7qbo7Poqtcb8YwvqgsJy00kU/wedB7s0jKLIkJZV1KS80Jtw4Y9Gse
 hI9hXL1j9kEiad8I+GhAW9DK6kSnJR048I+RUE4LIm6ro5pRuCkGZJCfeGlbt8/oMQEh
 bXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773904834; x=1774509634;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fe51MXVKNtt97IK2v9bXGEUIRb61ACw33tyTc00UOXY=;
 b=JDPsAPJ0I2KYjbmXytcIv+lo4mQ59AKyqccmVN+k+6V7Y9Z0x63lj2MQLKzuso8aSy
 9HkYgyCZB9yb5BMYcdsVzApWT184MrS2g9U3P5Er047xTw+xT71Gtz50vPr9TCkQ1Hlo
 ZuQZadPVP4lDMStzPkSAcL+ruWDGZwHuhR08H/BBMk3UhcnoQEg7ertXwGBCIuX3Iefo
 HeNUkvV9EsOeDZUKXiAJxMSwj+Ce/Oz26CuCXsIsoBNxuK2dlU3CrfMlkK5h4x0XNDhC
 7O76+ZWlUZ7O/bSPUM8xo5wMEbHyecUZRNG/Zv1IwH9r6OY98KTQ0TnOdx/4+5xkZVTP
 Ek3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOFHqxux3c3ReojplcI0lH3uGvfaWmCzu+T0wHcak6LIIm2OrUYF3yuY1j4qo4IqIz1otSGmUrEK8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrGN210LN2B1HbCbCyVZffi98ILpO6eYGiGcO3He9RzYyMrIKd
 DOcN+SLfLMYrgCIQha4rWSVImchatsokKouw/cW+YHj7CRg33V44y0sBjd8Q1+NcvpvubaFwT7G
 RWOTQfjFat5H5bx2phe50B0m//Ztcb3ybEo8DCgq4EpSioyT/Crw5qbYZjPOGbp12kMJhmg==
X-Gm-Gg: ATEYQzw/edFMTKiv7eeaK5sWVLwMxbx5BQkCOT+EoIdKFYBcybVE3YIF5SW3Z7H78pu
 /2q2fpWM5O+QJK9qA3fSL7/hPMHj1jfyXg6UJMxIwd06d143koXXZ5bG/EgMZU+adBxpk+tzKRB
 OsNEc6GIbOlF2pa9b4kBDyfsyXsr7wOfehpRU+8hDlNyS6ml4cUsVTFNSwEsGRCPbR1ZJP0yxPi
 ldZfhI1gu6ouql3Gb/mROzjksKi6RyOlSmFke7+GkYcUD/2ZSjB99NsDifNa8nx9CD3P8bEyCSX
 56AoDNZxvfxMDebcsxXC8KUNYOKe9tJYrCcFSYgIikcelrlh8LtiEaPpqCrapyHxlFoF2/VdXg=
 =
X-Received: by 2002:a05:600c:1d10:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-486f4422046mr101607195e9.5.1773904834537; 
 Thu, 19 Mar 2026 00:20:34 -0700 (PDT)
X-Received: by 2002:a05:600c:1d10:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-486f4422046mr101606445e9.5.1773904833968; 
 Thu, 19 Mar 2026 00:20:33 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8c4aa85sm37232575e9.12.2026.03.19.00.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 00:20:33 -0700 (PDT)
Date: Thu, 19 Mar 2026 08:20:32 +0100
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
Subject: [PULL] drm-misc-fixes
Message-ID: <20260319-lush-righteous-malamute-e7bb98@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="svf7amwab55hyikj"
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


--svf7amwab55hyikj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [PULL] drm-misc-fixes
MIME-Version: 1.0

Hi,

Here's this week drm-misc-fixes PR

Maxime

drm-misc-fixes-2026-03-19:
A doc warning fix and a memory leak fix for vmwgfx, a deadlock fix and
interrupt handling fixes for imagination, a locking fix for
pagemap_until, a UAF fix for drm_dev_unplug, and a multi-channel audio
handling fix for dw-hdmi-qp.
The following changes since commit 49973e2a4156a88e46ba1c1c484b7c214199a181:

  drm/loongson: Mark driver as orphaned (2026-03-11 10:15:36 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-03-19

for you to fetch changes up to cffcb42c57686e9a801dfcf37a3d0c62e51c1c3e:

  drm/bridge: dw-hdmi-qp: fix multi-channel audio output (2026-03-17 18:15:16 +0100)

----------------------------------------------------------------
A doc warning fix and a memory leak fix for vmwgfx, a deadlock fix and
interrupt handling fixes for imagination, a locking fix for
pagemap_until, a UAF fix for drm_dev_unplug, and a multi-channel audio
handling fix for dw-hdmi-qp.

----------------------------------------------------------------
Alessio Belle (3):
      drm/imagination: Fix deadlock in soft reset sequence
      drm/imagination: Synchronize interrupts before suspending the GPU
      drm/imagination: Disable interrupts before suspending the GPU

Ian Forbes (1):
      drm/vmwgfx: Don't overwrite KMS surface dirty tracker

Jonas Karlman (1):
      drm/bridge: dw-hdmi-qp: fix multi-channel audio output

Jonathan Cavitt (1):
      drm/pagemap_util: Ensure proper cache lock management on free

Maarten Lankhorst (1):
      drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug

Randy Dunlap (1):
      drm/vmwgfx: fix kernel-doc warnings in vmwgfx_drv.h

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c |  2 +-
 drivers/gpu/drm/drm_file.c                   |  5 +-
 drivers/gpu/drm/drm_mode_config.c            |  9 ++-
 drivers/gpu/drm/drm_pagemap_util.c           | 14 ++---
 drivers/gpu/drm/imagination/pvr_device.c     | 17 -----
 drivers/gpu/drm/imagination/pvr_power.c      | 51 +++++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h          | 93 +++++++++++++++++-----------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          |  3 +-
 8 files changed, 114 insertions(+), 80 deletions(-)

--svf7amwab55hyikj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJQEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCabujvwAKCRAnX84Zoj2+
dt5cAXdNUS7Cy30+bodwJCDRPxeogAOQhkcxDIgdpuu4Or3t7kzK9/rIyljyU2vE
fCUqwAF/TqqwgmaI8Fj+kF8N6FhhDute9hnDVR5+4J1oEHEzIK+LFFmNOSVgF/uG
zw/BSthq
=1aoG
-----END PGP SIGNATURE-----

--svf7amwab55hyikj--

