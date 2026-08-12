Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B30C5DF60
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDA310EF9F;
	Wed, 12 Aug 2026 12:28:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=deq.rocks header.i=@deq.rocks header.b="DVupFUoD";
	dkim-atps=neutral
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de
 [91.216.248.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01D110EF9D
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:28:07 +0000 (UTC)
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: ade6385e-3cd9-465b-bd4f-1f889225e633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1786537330;
 bh=cdtxM7f+HSBtEgs646+l5dVOT460jHtMauo0VN3EQJ0=;
 h=From:To:Cc:Subject:Date:From;
 b=DVupFUoDl+KkFMjTbrH5s/WPmyKX+wF1Gk4nSo1p1wmsPDpZo0Y3XphXoVSbB6BXx
 BeZYX0iyN2J5xqWFByTeF/uY2pueQY1GaFWGGCTZwFEIZs2G42fJ8wLIiFooc9twVM
 oRmYGzK2w95t/g9gJwG05sKFpqPxzuDcrQdR7Qs2exi3/FPMn9LLI6cuwZ0kPFavO4
 XbcieEYvpoVhoqz2MZEooCGVmSfgk9beLsLIwuvYBpiNSGiJI4pGc2P2EjiKx622v2
 chf+k/qJiUj0Ys8N8+npdtpVAzz6q7JWgok6CiCFeIm0MGDYYUIc1SxGGW3NtSQt5x
 MpE8nO2ZHal8Q==
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-sound@vger.kernel.org
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Apple GMUX hybrid graphics support for MacBookPro15,1
Date: Wed, 12 Aug 2026 14:22:03 +0200
Message-ID: <20260812122206.193680-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
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

This series will enable hybrid graphics on MacBookPro15,1.

The MacBookPro15,1 normally starts Linux with the discrete GPU as primary.
On the machines tested here that results in roughly 24 W idle power draw,
about 12 W of which is attributable to the otherwise unused discrete GPU.
Selecting the integrated GPU at boot avoids that cost, but the discrete GPU
cannot currently return after GMUX powers it down, so usable hybrid graphics
and suspend are not available.

This series provides the missing power lifecycle across apple-gmux, amdgpu
and the HDA controller. With the integrated GPU as primary, the discrete GPU
then transitions between DynOff and DynPwr and offloading to the dGPU
through DRI_PRIME is working as well as external monitor support.

The result has been tested for three weeks on both the 2018 and 2019
MacBookPro15,1 revisions. Runtime suspend and resume, system suspend and
resume, repeated GPU wakeups and also a variety of external Thunderbolt
and USB-C monitors were tested successfully.
It is a huge step forward in terms of usability, convenience and battery life
for everyone who tested.

So I have this one question regarding Apple's gpu-power-prefs EFI variable.
The firmware defaults to the discrete GPU, while selecting the integrated GPU
is required before this hybrid configuration can take effect. Would setting
that preference from the kernel be appropriate on a known-good model, or
should it remain a userspace policy decision? Some discoverable way to select
the power-efficient configuration would seem preferable to requiring users to
know about a vendor-specific NVRAM variable before Linux behaves like a hybrid
graphics laptop.

Thank you for your time and consideration.

Andre
