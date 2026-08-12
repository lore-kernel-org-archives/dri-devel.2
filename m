Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC339C5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 317D610F040;
	Wed, 12 Aug 2026 14:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=deq.rocks header.i=@deq.rocks header.b="i2Omdrhi";
	dkim-atps=neutral
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de
 [91.216.248.212])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6629210F040;
 Wed, 12 Aug 2026 14:47:58 +0000 (UTC)
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1786546076;
 bh=/AzW61RZwMFL9q+25Sft4GfDjCYLKAei5DaSN4AkE50=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i2OmdrhifVVVfuh+Um1vxgSGff3UzTtt4R5m/ZeSw2EGCYKI7v6OQTTW9SVTLOdBB
 E0IApi6IZBGKXx86PSxXzMpsl75xRuyM4YiQycgVHXMxGpftR1PeEdRGdmRHDBMoxo
 31yQT1hZf2oRP4JNeVWyNG4zcIcihP3sd/UwqUlJ6g21kVs86W/sSgT25WBWiW6uQT
 ZKvEPrtiCq1TKGfh5xtRF6o2cnp0kUaZInMJFDRhxiZxa/y94qJkLnyzO/JYHY6sLz
 1FNBqiJuOpuI35h3S9j/fUbiAMW/DpRPJjE6LiQ3Fixp3fsgB7HMr7iYZOEpTFEeuo
 l7jW6kPEU/7zg==
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-sound@vger.kernel.org
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH v3 0/3] Apple GMUX hybrid graphics support for MacBookPro15,1
Date: Wed, 12 Aug 2026 16:47:47 +0200
Message-ID: <20260812144750.36797-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812144221.35877-1-dev@deq.rocks>
References: <20260812144221.35877-1-dev@deq.rocks>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello everyone,

This series enables hybrid graphics on the MacBookPro15,1.

The MacBookPro15,1 normally starts Linux with the discrete GPU as primary.
On the machines tested here that results in roughly 24 W idle power draw,
about 12 W of which is attributable to the otherwise unused discrete GPU.
Selecting the integrated GPU at boot avoids that cost, but the discrete GPU
cannot currently return after GMUX powers it down, so usable hybrid graphics
and suspend are not available.

This series provides the missing power lifecycle across apple-gmux, amdgpu
and the HDA controller. With the integrated GPU as primary, the discrete GPU
transitions between DynOff and DynPwr. Offloading through DRI_PRIME and
external monitor support both work across these transitions.

The result has been tested for three weeks on both the 2018 and 2019
MacBookPro15,1 revisions. Runtime suspend and resume, system suspend and
resume, repeated GPU wakeups, and a variety of external Thunderbolt and
USB-C monitors were tested successfully.

One question remains regarding Apple's gpu-power-prefs EFI variable. The
firmware defaults to the discrete GPU, while selecting the integrated GPU
is required before this hybrid configuration can take effect. Would setting
that preference from the kernel be appropriate on a known-good model, or
should it remain a userspace policy decision? Some discoverable way to
select the power-efficient configuration would seem preferable to requiring
users to know about a vendor-specific NVRAM variable.

Changes in v3:
- Restore integer result validation for PWG1 and PWG3. The MacBookPro15,1
  AML returns Zero on success and One on failure from both methods. The v2
  conversion to acpi_evaluate_object() incorrectly discarded that status.

Changes in v2:
- Refresh the individual patch descriptions.
- Refresh the cached discrete PCI device when a client is re-registered.
- Keep the HDA switcheroo implementation in the existing switcheroo section.
- Document the positive azx_prepare() return and add Takashi's Reviewed-by.

v2: https://lore.kernel.org/all/20260812144221.35877-1-dev@deq.rocks/
v1: https://lore.kernel.org/all/20260812122206.193680-1-dev@deq.rocks/

Thank you for your time and consideration.

Andre Eikmeyer (2):
  drm/amdgpu: add Apple GMUX runtime PM support
  ALSA: hda: allow direct complete with a powered-off GPU

Atharva Tiwari (1):
  platform/x86: apple-gmux: add MacBookPro15,1 dGPU power sequence

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 30 +++++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  1 +
 drivers/platform/x86/apple-gmux.c          | 86 ++++++++++++++++++++--
 sound/hda/controllers/intel.c              | 24 ++++++
 6 files changed, 153 insertions(+), 23 deletions(-)

-- 
2.55.0
