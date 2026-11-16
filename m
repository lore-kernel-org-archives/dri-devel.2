Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB32606A339
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BjGlaflY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0459110E19A;
	Sun, 15 Nov 2026 23:22:11 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2F210E078
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 23:22:04 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so10530275e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 15:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794784923; x=1795389723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zAejWuLH6A6kWbjxkZ2dzmDOuVhvhpj01tnf5xLhIOA=;
 b=BjGlaflYEKfCbzADrGiScwIDvA/R7bJhkh8J4OFfWWzQLBBCPkNKD/2Mn1VyQj0cVW
 MwpG2rEhO4Z/f5VRoKRMs9J3wKeMBlBSkHuTfCBXg0okcAZ5MLI7F6r3OjIdXHrtbzaD
 VNag7wT3/WdtHzP2I8vE7LeFYhdWQYd51uJ4L2yJON2mz0DxEeTCCbQiJwC7DdVUieYW
 pKLBMUkx+6hC09u3dByqz370svaBvDoTlfPL03zzNDwuTvJizcoQ721Ac2rm1U3apx+i
 BVF5q6uV3RauJCteeB5GBv0PIVgEyKpU2jYX0ZOF0xa8cTIPCQY+8JWTV5rytm+SArnD
 9F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794784923; x=1795389723;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zAejWuLH6A6kWbjxkZ2dzmDOuVhvhpj01tnf5xLhIOA=;
 b=CSYM5bgkoutknObJJT0Yk+8Hgl64dKFoUHp32WnDDy9CFDl3YgUQFH1mPwUr91tW4j
 FqGT64NURqQasCoj913YeTVSu9Z0WYR9h6iaOrBEuAHwmFiV2LVyccfOc45xiscMifKe
 TfNjdW4LTVy7HZn0I9lCycYLFt157sEYWYncG/DviS00NVue4i3dYvt5ShGy5sMInqh6
 k85a4VgWP0vkP+6DMfpJ4szzW9s0tGVgF6+3R67R1Awwz31Tge0RLq2E8AbeoMhE972b
 Jug+7nES9V5Q3GczjDaF57FR6/BHOA7R6rOymeGSGVOkS0seNkJ7Ix/BUNyfxAxNbGaI
 Qpsw==
X-Forwarded-Encrypted: i=1;
 AL+hErH2TZDD6pqF435DctKH7DnHwRSrKuZ0y0h505ZnJ0X3tzMZIiqqtDsBAcDlimjElcPSW+Uq1PYvAYs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8BbondPyXVxhuB78UxEvi7mH6qGmZ7bJLd5oZfgBAtFqNDF7Pz
 hdnoT2uGAeUfgM3M9VubgMNxBhniYrBewg16ihRNCeuTsU3Wkpu6fAZZ
X-Gm-Gg: AYBFou2eFvgy/rNI+TEY12iBpq9DWr+bG0CXnRR3eQcFDXn7AeYxpId+ZZkbhDexKc1
 Ne3epRqu5MXlnj0dTa5FtKB2htq4l6vs9nxuTSXrLKfKt+zltyriyHzcJz9jOXv7b1xCCqM9q5f
 1G72C6muH8xfWO1sMxSclR/z4VXUNYpvQ/OndI0s2AQZ2gsTwNM2wozwAToDQWYna1DJyQnPKlN
 VXldsj+yrQrOV60Y4mQEZo1lmGmarMMrq87uP5LFZ9H654eHahqlc8uGD70uaKFw66JyWgt4jOR
 9hFthrLwAfIxM+p+LypGPkfDkxnOWKFKX7SYX6XZudoy9snBXnS6X7VCM6BdTLwi6D66ftZhRbl
 BrjahUgJE4Zxw3NzBvHHx6m8IJQGYsZ+tyw2+DVM7ryyNRRQJ8EDtQQDOnAVHWMPnqw4ziT5Mj7
 zINX6zr4w0Xkux7rsQ91GJKg8HdLmmfJrTxXjmNemoHpmp0I4PK09+p53IkjypD55h/CKLdxUGg
 3iMDujP78aABPENqrTwm1aYWdaWv5PdYEDXkezTYbLS6m9Yj/sYt1gCpwfYDaOyc+B6Ga6uhAX5
 7iL1KyqiUQnoDf41Zo6cJmpY3XWGyvqWRPjBreB1ADSyQiJejFjkH20=
X-Received: by 2002:a05:600c:83c5:b0:4a7:7d22:c50c with SMTP id
 5b1f17b1804b1-4bb55a23b36mr182171115e9.2.1794784922517; 
 Sun, 15 Nov 2026 15:22:02 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm127920955e9.3.2026.11.15.15.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 15:22:01 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] Add splash DRM client
Date: Mon, 16 Nov 2026 01:21:50 +0100
Message-Id: <20261116002156.1027726-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is the seventh version of the splash client, which I took over from
Francesco with v4. As Thomas suggested [1], it holds only the part that
can go in now: patches 1 to 6 and 8 of v6, with the MAINTAINERS entry
squashed into the patch that adds drm_splash.c. The device tree source
and its binding, the placement and rotation, and the connector
orientation will follow as a separate series on top of this one.

The client draws a splash on every output, including those plugged in
later, until userspace takes over. The image comes from the EFI BGRT or,
failing that, from a BMP loaded as firmware, named at build time
("drm_splash.bmp" by default); with neither, only the background is
drawn, in a colour set at build time. A BGRT image is drawn at the table
offsets, a BMP loaded as firmware is centred. A BGRT whose ACPI 6.2
orientation bits are set is skipped for now; turning it comes with the
rotation in the later series.

Changes since v6
----------------

From the reviews of v6 [1]-[6]:

  - MAINTAINERS: I am listed as M: and Francesco as R:, in patch 4
    (Thomas [2], Francesco [3]).
  - The firmware source is DRM_SPLASH_SRC_FW, and its Kconfig options
    DRM_CLIENT_SPLASH_SRC_FW and DRM_CLIENT_SPLASH_FW_NAME, since the
    BGRT is a BMP too (Thomas [4]).
  - The drm_splash_fw_load() stub returns 0 (Thomas [5]), and
    drm_splash_image_load() does not call it when the firmware source is
    disabled.
  - Thomas, I have kept your Reviewed-by on patch 4, as you said [6].

From sashiko's review of v6 [7], and further review:

  - Patch 4: restore leaves the commit to the work, which draws whatever
    is missing first, so a restore that comes while the device is
    suspended is no longer lost [7]; a forced restore stays forced across
    suspend, and the work commits even when no scanout is left.
  - Patch 4: a hotplug while userspace has the display waits for the
    next restore, as fbdev does; only a lack of memory makes the image be
    drawn again; unregister cancels the work before it looks for a
    firmware request, which the work can now make too; the tile group id
    is read under mode_config.mutex, which an EDID update holds while it
    changes or frees the group.
  - Patch 2: the image address and size are 0 when efi_bgrt_has_image()
    says there is no image, so that they never disagree on kernels with
    32-bit physical addresses.
  - Patch 3: the comment on the DIB header says that a negative width is
    invalid.

Testing
-------

  - QEMU versatilepb (pl111, 16 bpp): no image, and the BMP loaded as
    firmware, compared pixel by pixel.
  - x86-64 with OVMF: the BGRT through the new accessors; with
    CONFIG_DRM_CLIENT_SPLASH_SRC_FW=n, with and without a BGRT
    (bgrt_disable), the background alone and no error.
  - i386 without PAE on 32-bit OVMF, with the BGRT replaced from the
    initrd so that it points above 4 GiB: the background alone.
  - QEMU virt arm64 (virtio-gpu, 32 bpp) with KASAN and kmemleak: the
    driver bound and unbound repeatedly, a crafted bitmap offset, and
    the firmware arriving only after the unbind; no reports. With
    lockdep too, over several outputs, tiled displays and the bind
    cycles: no reports.
  - Several outputs, one of them off, and tiled displays from 2x1 up to
    3x3, 4x2 and 2x4 tiles, in several CRTC orders, simulated with
    DisplayID tiled topology EDIDs on virtio-gpu heads. The layouts with
    more than one row and column need a fix to the client modeset code
    that is not part of this series.
  - The error paths, with a debug patch forcing them: buffers and formats
    that fail on one output, work queued while suspended, a restore
    during suspend or with a master, a hotplug with a master, a fill that
    fails, a firmware request made by the work and raced against the
    unbind; no WARN or KASAN report in any of them.
  - An AM335x board (tilcdc, 16 bpp), booting over TFTP and NFS, with
    the BMP built in and from an initramfs, an 8 bpp BMP that is
    rejected, and 5 unbind and bind cycles of tilcdc, checked by reading
    the scanout buffer back.
  - W=1 and sparse clean; every patch builds on its own on arm and
    x86-64; checkpatch --strict clean apart from a quoted modpost line in
    patch 2 and the MAINTAINERS reminder on patch 3, whose new header
    FRAMEBUFFER LAYER already covers.

Open questions
--------------

  - Unbinding waits for a pending firmware request, as it cannot be
    cancelled and its callback uses the splash, and it waits under the
    device's clientlist_mutex. Normally the request is long over; with
    the sysfs fallback it can take up to the loading timeout. Not
    waiting would mean giving the callback its own refcounted object;
    I can do that as a follow-up.
  - The BGRT offsets are for the mode the firmware drew in. When KMS
    picks another one, the x86 check taken from efifb leaves the screen
    without a logo, and elsewhere the logo lands off centre. The offsets
    could be used only when the scanout matches the firmware's
    framebuffer, and the image centred otherwise.
  - The splash is a DRM client, so a device using it has no fbdev
    emulation and no /dev/fb0.

Based on drm-misc-next-2026-10-23 (cf5d8e390e2a).

[1] https://lore.kernel.org/all/066197a1-aa2b-455b-84d8-4e2215fad764@suse.de/
[2] https://lore.kernel.org/all/ed28619d-6ca7-46aa-82c0-c83f30a836e3@suse.de/
[3] https://lore.kernel.org/all/avTjrfIEPgyvPDti@bywater/
[4] https://lore.kernel.org/all/8eaf9955-485f-4908-bb65-1e0c3184fb36@suse.de/
[5] https://lore.kernel.org/all/c2cbc13a-a58d-4c0b-87ac-62daa6de6fba@suse.de/
[6] https://lore.kernel.org/all/4762a951-5b37-4e7a-8569-f55a4683c912@suse.de/
[7] https://lore.kernel.org/all/sashiko-outbox-186719@kernel.org/

v6: https://lore.kernel.org/r/20261027135342.2003632-1-maximpedraza@gmail.com
v5: https://lore.kernel.org/r/20261013093243.505776-1-maximpedraza@gmail.com
v4: https://lore.kernel.org/r/20261001195847.141192-1-maximpedraza@gmail.com
v3: https://lore.kernel.org/r/20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it
v2: https://lore.kernel.org/r/20260106-drm_client_splash-v2-0-6e86a7434b59@valla.it
v1: https://lore.kernel.org/r/20251027-drm_client_splash-v1-0-00698933b34a@valla.it

Màxim

Francesco Valla (2):
  drm: client: add splash client
  drm: docs: remove bootsplash from TODO

Màxim Pedraza Padilla (4):
  drm/clients: Kconfig: indent DRM_CLIENT_DEFAULT with tabs
  efi: bgrt: add accessors for the boot graphics
  fbdev: efifb: move the BMP headers to <video/bmp.h>
  drm/client: splash: pick the image source in one place

 Documentation/gpu/todo.rst                    |   17 -
 MAINTAINERS                                   |    8 +
 drivers/firmware/efi/efi-bgrt.c               |   76 +-
 drivers/gpu/drm/clients/Kconfig               |   80 +-
 drivers/gpu/drm/clients/Makefile              |    1 +
 drivers/gpu/drm/clients/drm_client_internal.h |    9 +
 drivers/gpu/drm/clients/drm_client_setup.c    |    8 +
 drivers/gpu/drm/clients/drm_splash.c          | 1060 +++++++++++++++++
 drivers/video/fbdev/efifb.c                   |   49 +-
 include/linux/efi-bgrt.h                      |   39 +-
 include/video/bmp.h                           |   40 +
 11 files changed, 1330 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpu/drm/clients/drm_splash.c
 create mode 100644 include/video/bmp.h


base-commit: cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f
-- 
2.39.5

