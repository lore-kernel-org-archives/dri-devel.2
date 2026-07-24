Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97259C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E436410F27C;
	Fri, 24 Jul 2026 03:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="lV6NMqN3";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1FA10F27C;
 Fri, 24 Jul 2026 03:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784862008; x=1785466808; i=w_armin@gmx.de;
 bh=QyWsP7Sqq/f321MW0zLkWTJO8RVqlTuampchfIxiXqE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lV6NMqN3XOQUWkCQBYa546XTWa8x8XCWzztfZyH3iwFFwFk8BtRDETG7O5tZRfvP
 aJ3eUJz1MQPLpWYQUxXHv8W78l55BVZfc6gbj0xeMT+8fSE375xPDbrNnP0Ir7BKJ
 XDnyivR6T+taosMEgMNBg4n2bm0S5J87asXTOSHC1fy+Lg4D1kPqJh6nqE4XYW9N7
 Az5o3Epxjq0tCavYT8LMpSIuO86eh/Fwp+v9Ma2DZNb56aIItkqwRMsl9WApSn7d4
 KbDMkeHv/YCIoyMhmck5Qib4RxVjzbnYFga5Q3UxE93ZDJ0A6dkf4Ld69DD7pIR9N
 26tl7Q6QE9W0AKW49Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1wsqlW2yoP-008ovN; Fri, 24
 Jul 2026 05:00:08 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@weissschuh.net, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, intel-gfx@lists.freedesktop.org,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 intel-xe@lists.freedesktop.org
Subject: [PATCH v3 0/3] platform/wmi: Add aarch64 support
Date: Fri, 24 Jul 2026 04:59:56 +0200
Message-Id: <20260724025959.142826-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v0vGyOFR/LNhXqmzPmSmbfTpyh8udB6Vccc5cR4hyg1ygBoCzA7
 ms67npm2ala0zpowQfPHnL1u9wuv2lR3aI3rxpIgnX50r4TcA6Vz+uWEIu9RvKzDlwwILPe
 OjAZ/eltLxgPeSOYMQc55xQ24g/QR8KmH9hYbzK5SmJqJsCLgV1pK76rJ4eUGz58Gvc88sY
 Vad84EnEwsX7pmIvlt+5g==
UI-OutboundReport: notjunk:1;M01:P0:FyrCzEHmtTk=;/tKGSc1qtiU9Lvg78bY9/w9McK2
 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
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

The aarch64-laptops project found out that some Windows-on-Arm
notebooks contain WMI-ACPI mapping devices (PNP0C14) that work
exactly like on x86. Those devices however are currently not
supported by the WMI driver core due to only supporting x86.

The first patch removes this restriction and allows the WMI
driver core to run on all architectures that support ACPI.
The second patch updates the acpi-video driver to take advantage
of the improved support for architectures other than x86, and
the last patch enables the generic WMI BMOF driver to support
aarch64 as well.

All patches have been tested on a ACPI-based aarch64 VM and
work just fine.

Changes since v2:
- fix Kconfig issue for the loongson-laptop driver

Changes  since v1:
- add additional tags

Armin Wolf (3):
  platform/wmi: Remove dependency on CONFIG_X86
  ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()
  platform/x86: wmi-bmof: Move to generic WMI code

 MAINTAINERS                                     |  2 +-
 drivers/acpi/Kconfig                            |  2 +-
 drivers/acpi/video_detect.c                     |  8 --------
 drivers/gpu/drm/amd/amdgpu/Kconfig              |  4 +---
 drivers/gpu/drm/gma500/Kconfig                  |  1 -
 drivers/gpu/drm/i915/Kconfig                    |  1 -
 drivers/gpu/drm/radeon/Kconfig                  |  4 +---
 drivers/gpu/drm/xe/Kconfig                      |  5 ++---
 drivers/platform/loongarch/Kconfig              |  1 +
 drivers/platform/wmi/Kconfig                    | 14 +++++++++++++-
 drivers/platform/wmi/Makefile                   |  4 ++++
 drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} |  0
 drivers/platform/x86/Kconfig                    | 12 ------------
 drivers/platform/x86/Makefile                   |  3 ---
 14 files changed, 24 insertions(+), 37 deletions(-)
 rename drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} (100%)

=2D-=20
2.39.5

