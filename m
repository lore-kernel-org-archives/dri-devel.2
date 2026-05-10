Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFA9CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 21:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2DF10E24E;
	Sun, 10 May 2026 21:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="UDtko6Om";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="ZPLL9TB+";
	dkim-atps=neutral
X-Greylist: delayed 619 seconds by postgrey-1.36 at gabe;
 Sun, 10 May 2026 21:40:51 UTC
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A6810E24E
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 21:40:51 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-kz0n.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778449251; 
 b=yGEo3qad7xU6jELHKjCx87UUScBJmtu4NtOEDN+PkMI7dKjImVdPfnYByHJZmVIdaq81fVeRtF
 f8CRlcW5btOV7Dd05UZDbd8fRRC34VSftx7Vi5WHfD8NWVJ/jvDkPUnvaFLqnK8HC3LibVRR/x
 LAESMYGDThe6aUY/7qxCNQLgpVkEt40sRvvXWp1kpfZ/2y83efQy0jlHX6dhOxI39OSVMbjx92
 FKBUBlg5iYeKZT8Tk0l/8tmInuKTsoE0IrMeSXnZRRr559doU2KQ3CMpghQI8jzGMHsFR514gG
 C0MLu8uWuZgOVd/lmFN21gnnM/HZirgkTrR0fOqBsJnEzA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-kz0n.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-kz0n.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778449251; 
 bh=tIxfZpWNGOuzJwgTKm5cW5kf4HZX6TEm5aiLFJMofUc=;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:From:DKIM-Signature:DKIM-Signature;
 b=hS4BnsAixKgCDIFb6qsyul/aR3qjhda9jT+gXXADsOV95H/TTFVR14MJq7AE0+hSwbjDkirX82
 d8nPJMULS1lmZca98m7hB4Akz0zCLKAuEFg4+9cU4YYhu6eCLi1bjV1DncY400to8Z5Ia7pXF8
 mVhgi5bLHWWzuQEN63t/YG3nn0HgSMXteFrhb1lVPzSSiH3w/SIhBRimedlaRzkK7SMokGxwfl
 GInmed2jE6P27mh9W6B8rVnxG70MBbqz+Kq6tQiqRruEjBjwY0xihNUL0vt2xI1d2XLuxZBmWX
 nr0gPNPvRQwrKvSR26e+LVEUHiB6htXK3WsWF4DtvOR4bQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:From:Reply-To:List-Unsubscribe;
 bh=/vPpY1OpToTP1NIiMD/OIBw5dqDYUYDnHC/WuuJj9D8=; b=UDtko6OmtXmlGlctb4oL1KY6qQ
 cHSvp6fA3sFLtTrBvWPzwSs1CQxw/XdUqlZoqgX58E9uhgGOjRz2WVaaLRDYLcpe6XBY0r4XKIxFq
 foE0Q7VNa8YcbX7rrCrHLadMB+A0cDSiE2DmkIxbsGOJMlMnh74fXPykaYzSU36dbAuU=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-kz0n.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wMBjH-00000002wc9-1p63
 for dri-devel@lists.freedesktop.org; Sun, 10 May 2026 21:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=/vPpY1OpToTP1NIiMD/OIBw5dqDYUYDnHC/WuuJj9D8=; b=ZPLL9TB+ImLeDPJDFqZW0WZGSE
 N1i7ZJ6BVmqldLIH/MBOngGWHGufg5m+lvcOOXtXf/cTBjThiiThXGrZvNKRqEcjqOWuW4VFCKI1n
 Z2Y46Q1O1wpWiEky3UMViiHrKppzarIkfuy1ktjgVKfmWHLhzYXUQHMuLBG0S0OZm+Bg=;
Received: from [95.232.18.244] (port=61481 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wMBil-00000000PdN-1rms; Sun, 10 May 2026 21:29:55 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH RFC v3 0/3] Add splash DRM client
Date: Sun, 10 May 2026 23:29:37 +0200
Message-Id: <20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OTQrCMBAF4KtI1kby0yatK0HwAG5FStpM7UBsS
 1KCUnp3Q1Fw0eWb4X0zMwngEQI57mbiIWLAoU9B7nek6Uz/AIo2ZSKYyDkTilr/rBqH0E9VGJ0
 JHQXOrLZKSdAtSb3RQ4uv1byR6+VM7mnYYZgG/17vRL6uvqTeICOnjDKmyqKUspaZOUXjnDngt
 GJR/ADFONv6KYoEKCiU0ZnM6rz8A5Zl+QCScqg+9wAAAA==
X-Change-ID: 20251026-drm_client_splash-e10d7d663e7f
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-embedded@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3256; i=francesco@valla.it;
 h=from:subject:message-id; bh=tIxfZpWNGOuzJwgTKm5cW5kf4HZX6TEm5aiLFJMofUc=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkMP874rGqcvvmCTGKDerZSfJLsnPQP4ot10ufnrGA8s
 7Q778TzjlIWBjEuBlkxRZaQdTfu7Zlr/i1tA+MjmDmsTCBDGLg4BWAiOmcZ/nu9Xv76ac+1a5ty
 2pQKwx9b3pv2cMf9X1sulTsu/HPX9kAzI8NGi6edNtNqhHfPct9qZbuy7UTPO/tz9QJ6sqnLPxe
 oTGcEAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 9b9ac02ff3f8ac734ffcd6767df68145
X-AntiAbuse: ID - 9b9ac02ff3f8ac734ffcd6767df68145
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wMBjH-00000002wc9-1p63-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-kz0n.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hello,

this is the third (and hopefully last) RFC version for the DRM-based
splash screen.

Motivation behind the work can be found in v1 [0]; in a nutshell, the
splash DRM client can draw a splashscreen using:

  - the BMP image supplied by the EFI BGRT;
  - a BMP image loaded as firmware (either built-in or loaded from the
    filesystem);
  - a colored background.

This revision greatly simplifies the image seletion logic; now the EFI
BGRT is always used as first source if enabled, with a fallback to BMP
image loaded as firmware and then to a plain color.

Sanity checks on the EFI BGRT image have been borrowed from the efifb
driver. More complete splash providers (e.g.: Plymouth) have an
extensive management of platform-specific quirks, but I don't think it
would be reasonable to introduce such complexity here.

Additional notes:
  - Rotation is still not managed (and probably won't?).
  - Support for tiled screens is untested.
  - Plain color and BMP sources were tested on QEMU, Beagleplay and
    i.MX93 FRDM.
  - EFI BGRT support was tested using QEMU+OVMF.

Thank you in advance for any feedback.

Best regards,
Francesco

[0] https://lore.kernel.org/all/20251027-drm_client_splash-v1-0-00698933b34a@valla.it

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Changes in v3:
  - Simplified the image selection and management logic, with direct
    fallback from EFI BGRT to MP as firmware
  - Used new drm_draw_can_convert_from_xrgb8888() API
  - Added proper get_unaligned_ calls for EFI BGRT access
  - Fixed Kconfig dependencies
  - Link to v2: https://lore.kernel.org/r/20260106-drm_client_splash-v2-0-6e86a7434b59@valla.it

Changes in v2:
  - Moved from raw dump to BMP format for static image source
  - Removed support for configurable message
  - Removed support for progress bar
  - Added EFI BGRT as image source
Link to v1: https://lore.kernel.org/r/20251027-drm_client_splash-v1-0-00698933b34a@valla.it

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Francesco Valla <francesco@valla.it>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-doc@vger.kernel.org

---
Francesco Valla (3):
      drm: client: add splash client
      MAINTAINERS: add entry for DRM splash client
      drm: docs: remove bootsplash from TODO

 Documentation/gpu/todo.rst                    |  17 -
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/clients/Kconfig               |  63 +-
 drivers/gpu/drm/clients/Makefile              |   1 +
 drivers/gpu/drm/clients/drm_client_internal.h |   9 +
 drivers/gpu/drm/clients/drm_client_setup.c    |   8 +
 drivers/gpu/drm/clients/drm_splash.c          | 932 ++++++++++++++++++++++++++
 7 files changed, 1019 insertions(+), 18 deletions(-)
---
base-commit: afaa0a477099cb7256e26fe11289c753a225ac97
change-id: 20251026-drm_client_splash-e10d7d663e7f

Best regards,
--  
Francesco Valla <francesco@valla.it>

