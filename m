Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C9606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=aKmJIWCR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7581120EC;
	Thu, 26 Nov 2026 08:09:07 +0000 (UTC)
Received: from forwardcorp2e.mail.yandex.net (forwardcorp2e.mail.yandex.net
 [93.77.172.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4683410FDCD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:11:02 +0000 (UTC)
Received: from mail-nwsmtp-smtp-corp-main-80
 (mail-nwsmtp-smtp-corp-main-80.yp-c.yandex.net)
 by forwardcorp2e.mail.yandex.net (postfix) with ESMTPS id BDD10C02AF;
 Wed, 25 Nov 2026 20:03:39 +0300 (MSK)
Received: from [127.0.1.1]
 by mail-nwsmtp-smtp-corp-main-80 with ESMTPSA id a3lrP22Zo8c0-42NguKdy;
 Wed, 25 Nov 2026 20:03:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1795626219;
 bh=5fyibea5xsAv0DxgVuzf78dNLQbsIr/IVZ3YzJ6A8X0=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=aKmJIWCRFpLJGwyIXhwL4qDqJkPOWvlFxpoxvA7QEnoOKlkJVev9qiCttoz75Zteg
 +d4EUsuZmhd0Rg/y1xuane2A+gLvyZrCJ4Czbd3aYSSnxNj6WrIdb6g6m/lJ+cmn1n
 GOAGkFjoRZTu+pswm7r6h5p2Yf8m1pwa2WbgZ+oY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80;
 dkim=pass header.i=@yandex-team.ru
From: Mikhail Rudenko <xyzzy@yandex-team.ru>
Subject: [PATCH 0/3] Implement handoff for EFI earlycon
Date: Wed, 25 Nov 2026 20:03:24 +0300
Message-Id: <20261125-efi-earlycon-v1-0-49ac2c0a430b@yandex-team.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNT3dS0TN3UxKKcyuT8PF1Tw+QUk6RUk1SLFGMloJaCIqB0Bdi46Fg
 Iv7g0KSs1uQRkhlJtLQCwffS9cAAAAA==
X-Change-ID: 20261125-efi-earlycon-51cd4be4e8d3
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Peter Jones <pjones@redhat.com>, 
 Helge Deller <deller@gmx.de>, Hans de Goede <hansg@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Mikhail Rudenko <xyzzy@yandex-team.ru>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This small series aims at making EFI earlycon a better debugging
tool. Currently, when earlycon=efifb us requested, there are two
options. (1) By default, earlycon is unregistered as soon as real
console comes up, before devices init. Sometimes, "real" device is VT
with dummycon, resulting in no console output untile framebuffer/drm
console takes over. (2) When keep_bootcon option is used, earlycon
never unregisters. This solves the issue of (1), but results in
display corruption when both EFI earlycon and framebuffer/drm drivers
write to the same aperture.

The approach here is to take the best from (1) and (2): EFI earlycon
unregisters exactly when the frambuffer/drm driver claims
aperture. This new behavior is gated with 'earlycon=efifb,handoff'
option, so the default case does not change.

Patch 1 aligns EFI earlycon framebuffer unmapping time with actual
console unregistration.

Patch 2 moves aperture ackquisition in efifb and simplefb before
mapping the framebuffer. Also it moves resource size checks before
aperture ackquisition in simpledrm.

Finally, patch 3 implements "handoff" option for efifb, and wires
conditional EFI earlycon unregistration to
devm_aperture_acquire_for_platform_device(),
aperture_remove_conflicting_devices() and
aperture_remove_conflicting_pci_devices().

Signed-off-by: Mikhail Rudenko <xyzzy@yandex-team.ru>
---
Mikhail Rudenko (3):
      efi: earlycon: unmap framebuffer when the console is unregistered
      video: acquire firmware framebuffer apertures before mapping
      video: aperture: hand off EFI earlycon on aperture ackquisition

 Documentation/admin-guide/kernel-parameters.txt |  5 ++-
 drivers/firmware/efi/earlycon.c                 | 49 ++++++++++++++++++++++---
 drivers/gpu/drm/sysfb/simpledrm.c               | 28 +++++++-------
 drivers/video/aperture.c                        | 13 ++++++-
 drivers/video/fbdev/efifb.c                     | 12 +++---
 drivers/video/fbdev/simplefb.c                  | 11 +++---
 include/linux/efi.h                             |  7 ++++
 7 files changed, 93 insertions(+), 32 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261125-efi-earlycon-51cd4be4e8d3

Best regards,
--  
Mikhail Rudenko <xyzzy@yandex-team.ru>

