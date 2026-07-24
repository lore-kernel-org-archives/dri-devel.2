Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D64FC531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9EAE10E662;
	Fri, 24 Jul 2026 02:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="G1BbkuVy";
	dkim-atps=neutral
X-Greylist: delayed 334 seconds by postgrey-1.36 at gabe;
 Fri, 24 Jul 2026 02:31:30 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5D010E644;
 Fri, 24 Jul 2026 02:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784860289; x=1785465089; i=w_armin@gmx.de;
 bh=2qGkW5IDIDpgVl8My3ODiAecgzop5vUsyHT6AYoXDJk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=G1BbkuVyYLKmHvXFK1rzOoDwJP7dqy2+bcsSM6pYK4KHGcyTfnyTrqmc188Pby7W
 MLqH8OkHLF0rdisTpbr6DoXAH4186xiFtbcIwV6Gokgki039o43U9P4Tob6iui1SR
 OSPNNHPUbsJ5Ce0UlDyrWyG+o3YsMRcBCmr6/VILL/zk1Oh2+rS/V+MqXzCFFlyss
 v/wrowm49h3W5pulPdVJJWo1Mqobm49R2Suc62yJ4O/g9ZggAAXlQ9schhd018C38
 fbP3gav4osP/nvMdy3vQJ10idZKvwCq/lR5rGT6hPd5TbkYfPpemjypul6Hc/Olu3
 dM8TenY7CYAAGreDGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sn1-1x39DE1hcd-01541x; Fri, 24
 Jul 2026 04:25:51 +0200
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
Subject: [PATCH v2 0/3] platform/wmi: Add aarch64 support
Date: Fri, 24 Jul 2026 04:25:23 +0200
Message-Id: <20260724022526.139370-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MLfKRpNO6nS1LngI27vrPWgZMqr/zoES9fILiLM7ihhune/Rl/w
 rLzT8yEaIURU42tHiBT56Lq69UB/u/ciPQQetClZFygcgUBHZhBn79e6SMgIYi5QJLo/XHE
 lIA/fEeY7oCG+ri+TXqXjTv3fd8DmKmqVgkIeVpFET+mPVhSHE+ySBj1AnX9RPzszssSCou
 dbIIJB3gkFzcjzpnHp1wQ==
UI-OutboundReport: notjunk:1;M01:P0:pyeBmqVYPpo=;h8anL59bMJzRRhSZ237LFfuIg7b
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
 drivers/platform/wmi/Kconfig                    | 14 +++++++++++++-
 drivers/platform/wmi/Makefile                   |  4 ++++
 drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} |  0
 drivers/platform/x86/Kconfig                    | 12 ------------
 drivers/platform/x86/Makefile                   |  3 ---
 13 files changed, 23 insertions(+), 37 deletions(-)
 rename drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} (100%)

=2D-=20
2.39.5

