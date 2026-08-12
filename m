Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233ECC5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A33310E426;
	Wed, 12 Aug 2026 14:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=deq.rocks header.i=@deq.rocks header.b="hUkUTUQb";
	dkim-atps=neutral
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de
 [91.216.248.212])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C6B10E426;
 Wed, 12 Aug 2026 14:42:28 +0000 (UTC)
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1786545746;
 bh=BwotxlEtPq994nsVoeymRzR3rcs0fcURPURwHTMYp/Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hUkUTUQbYiWm3Kib3a1/3kxoAJaIKpUoSXaeR0/ON/LcZxW14QeTr9CgUC66Ha1fo
 9FseJRc5U7SQV3kKVrUZHkMy4yUPJ+AwP2DzNWkhFK9fJDnw2XR9QrSFIKH7cuYjyc
 c7tgravmbDo+nki7FV7Bd+1VzXYLa+JWtv5xRaSH+h696oG2i+sNFezRJ1qjbftxIZ
 zBDSJPyAAs3bxK/3KCKD/6AB33jBkjbXVPvu/0KBc1pMUQnddUcbmdRv395Ou4KfaF
 JJPHh2/Eun9zG6OdZtFQ8JdCjm87A4LU8JGDsQSC/BT9y1SgkNH2jonbnh55cyucuV
 mc4yhakWcpTAg==
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
Subject: [PATCH v2 0/3] Apple GMUX hybrid graphics support for MacBookPro15,1
Date: Wed, 12 Aug 2026 16:42:18 +0200
Message-ID: <20260812144221.35877-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812122206.193680-1-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
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

Changes in v2:
- Refresh the individual patch descriptions.
- Evaluate PWG methods without expecting an integer return object.
- Refresh the cached discrete PCI device when a client is re-registered.
- Keep the HDA switcheroo implementation in the existing switcheroo section.
- Document the positive azx_prepare() return and add Takashi's Reviewed-by.

The HDA follow-up review crossed with the standalone v2 and v3 revisions of
patch 3/3. This full-series v2 contains the reviewed v3 implementation.

v1: https://lore.kernel.org/all/20260812122206.193680-1-dev@deq.rocks/

Thank you for your time and consideration.

Andre Eikmeyer (2):
  drm/amdgpu: add Apple GMUX runtime PM support
  ALSA: hda: allow direct complete with a powered-off GPU

Atharva Tiwari (1):
  platform/x86: apple-gmux: add MacBookPro15,1 dGPU power sequence

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 30 ++++++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  1 +
 drivers/platform/x86/apple-gmux.c          | 78 ++++++++++++++++++++--
 sound/hda/controllers/intel.c              | 24 +++++++
 6 files changed, 145 insertions(+), 23 deletions(-)

-- 
2.55.0
