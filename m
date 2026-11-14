Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB65606A88B
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrF83EEd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0030210ED11;
	Sat, 14 Nov 2026 03:04:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B0510EA20;
 Sat, 14 Nov 2026 03:04:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D4BE460E1;
 Sat, 14 Nov 2026 03:04:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794625445;
 b=voUpXNMxXJ8MKiQM29DMr2lZAuahqP0Dl5FdlG4QZ4UeXXCca8dC+hCH6xfR+rCpSglz
 s6mWPkY67U0yh/9f/tK8YN+Zb0TjBUqMPDhy2vVCKwAxlSUC/zsglYjc5gJik2+zBEm/w
 7tDu8+p6y1VQeLy634mbuFGbgBQt+ZojKuQi6zchm5CWaw6HYFwo0ov28uCoPMCt9iqK2
 c/M9bGm+IZlQW28iPogfov+6ASzjhV2nDGzrltpbOO9BrxMKRQjjrwsiYVdIyOiulzazP
 UZbddKjTVsJs8hMpFS4TduGzoB0frGfdyriFz1ukg3wJ1eptEVfNdYk7GtazFkq2MMA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794625445;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=1GlpFML27/pY/JVGDctBaj5mCNNL5LllYLTiuyQTT90=;
 b=0guAVv42sDKVjJU863ZnSHiGWvx1JvNgNGflACbKPflBniutXT+5TEXGAPNmDqt5tw+6
 uLuqOiZD3mO6KNJgvnx88UWaMvQMebHGW5OIsFMTskc47Qf3RHpGfScaS08cC99Njbf12
 jdf6ibOaCulqj/emKf20eSBUaB4SCy8v5C44yplv3i5cF5KvljGLShPLrucwIkHCW6Jc/
 9MHsbzL4RkpxBpxLXwKHie4uiXrktJ7AEzrJnuD9XaJbHFQGMjbNE7l4m8r2LxoRM5lV8
 +H9cT4UPXEpfTzH4CL6mzyVb3rOCzs8ez0JEvVxU1xAU4eXfy9SUMPr8Ydv8R7j47fw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3CCE71F000C5;
 Sat, 14 Nov 2026 03:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794625445;
 bh=1GlpFML27/pY/JVGDctBaj5mCNNL5LllYLTiuyQTT90=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=JrF83EEdL+47n4ZeWFjA9VkL6AzMkoHp2G3nqY0JkuHZVBv/SYgQhjDSWpZ2XvR2f
 ukg6f8X0w3pO1lmadJfN8Uo6vRgQ8pEC08DoH74wtsgeIA7KQ3k0GTFCukyjxWUqe6
 pVIHizXu1g7A+HdCqHzx7+AJceYXEmAGKDZc06r9pLMuOSxP4EMl+0SFbyEVlOKckK
 dmtJLPlttH6qvlWOwDq0ux0daRJ1N+w25FhdE8bRSIVxrj2pIHO8r+5Xr8OuACyoHQ
 cLaR+9GsMj/GZsNwGJP9SbhV0pURo04FuW3+zcnGbeTT/pax0gRocJSbjOXPeQHUpy
 Vx95UdFih961A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8F62F49C51;
 Sat, 14 Nov 2026 03:04:02 +0000 (UTC)
From: Joshua Horne via B4 Relay <devnull+hornejd.etsu.edu@kernel.org>
Subject: [PATCH 0/5] drm/amd/pm: overdrive support for smu8
 (Carrizo/Stoney)
Date: Fri, 13 Nov 2026 22:03:20 -0500
Message-Id: <20261113-smu8-overdrive-v1-0-763f07bdfca9@etsu.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBBA0V+RWWui9YxfEQt0MBKPzNBIxL8rl
 mdx7wWCTChQBhcwOhJaFw8dBtCNzTKgIusNJjKZ1jpWMh+FWh2yZXKoEhMVTZynmU1z8NHG2NP
 5Dav6txzthN3+XuC+H+jsCk5yAAAA
X-Change-ID: 20261113-smu8-overdrive-4208a3756d57
To: Alex Deucher <alexander.deucher@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>
Cc: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Joshua Horne <hornejd@etsu.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794625442; l=5296;
 i=hornejd@etsu.edu; s=20261109; h=from:subject:message-id;
 bh=UmzgubFBLP6539vRVkzEZqGVqJryr/hyW7Lruy4yeJw=;
 b=25jx8jTt8TZh94C7d7nTQp+P8nwK9RKBuh+tnFbae1ksCnYRA3EbatHIKIhNOvNw5o76tHNF+
 9Js24YNygOCDVxC5hxD3N60tx5rFhhALMBKCFIP3NfvYq5ynxM4/6MF
X-Developer-Key: i=hornejd@etsu.edu; a=ed25519;
 pk=HNOtiwerBbrJhfhzLHLxj3GDsUH9udRXflqnaI8sQmQ=
X-Endpoint-Received: by B4 Relay for hornejd@etsu.edu/20261109 with
 auth_id=1469
X-Original-From: Joshua Horne <hornejd@etsu.edu>
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
Reply-To: hornejd@etsu.edu
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series implements pp_od_clk_voltage for the smu8 backend, so the
graphics DPM levels of Carrizo and Stoney can be underclocked and
undervolted, or overclocked where the VBIOS declares an overdrive
limit. It uses the smu7 format and stays behind PP_OVERDRIVE_MASK.

Patch 1 fixes a stock bug I ran into along the way and does not depend
on the rest: the boot clock is below the lowest graphics level on this
VBIOS, so SetSclkSoftMax is sent 0xffffffff each time DPM is started,
which includes every driver load. It can be applied on its own.

A few things the diff does not show:

- The voltage is GfxVid, which drives the separate VDDGFX rail (SVI1 in
  the BKDGs for family 15h models 60h-6Fh and 70h-7Fh). GnbVid is not
  touched, so the NB rail and the memory controller are unaffected. The
  allowed range is the GfxVid range the VBIOS uses for the enabled
  levels, so nothing can go above the highest stock graphics voltage,
  and the hardware MinVid/MaxVid filter still applies.

- The new table is sent with ClkTableXferToSmu while DPM is running.
  The SMU firmware accepts it, but the level it is in keeps its old
  values until the SMU next enters that level. With the level forced,
  the VDDGFX sensor still read the old voltage a second after the
  commit, and the new one after a switch to another level and back
  (the clock itself cannot be read back). In auto mode the switch
  comes with the next level change; the driver does not force one.
  smu7 sends SCLKDPM_FreezeLevel/UnfreezeLevel around its upload, but
  those only keep the SMC from changing level while the driver
  rewrites the table in SMC RAM. smu8 has no such messages, and its
  table is transferred from a DRAM copy by a single message. Patch 5
  documents this in the pp_od_clk_voltage kernel-doc section in
  amdgpu_pm.c.

Known limitations:

- DCE 11 reads the sclk levels only once, in
  bw_calcs_data_update_from_pplib() when the resource pool is created,
  so after a large underclock its bandwidth calculations still assume
  the VBIOS clocks. smu7 and vega10 overdrive behave the same way on
  DCE 11.2 and DCE 12. A fix belongs in DC rather than in the
  powerplay backends, so it is not part of this series.

- Stoney is untested. It shares the code path and, per its BKDG, the
  rail layout, but whether the clock table is accepted at runtime is up
  to the SMU firmware, which ships with the system BIOS. Tested-by from
  Stoney owners would be welcome.

Testing was done on an A10-8700P (ASUS X555DA, VBIOS 113-C75100-028,
SMU firmware 18.60.00), on 7.3.1 with amdgpu built from that tree plus
these patches and "drm/amd/pm: send smu8 sclk level indices, not the
level mask" (already applied). The series was then rebased onto
amd-staging-drm-next without changes to the code and was not run again
there. This VBIOS has no overdrive limit, so only underclocking and
undervolting could be tested.

- Voltage changes were checked with the VDDGFX current-VID sensor:
  level 0 raised from 787 to 800 mV and level 7 lowered from 1187 mV
  (1163 mV requested, rounded up to the next VID, 1168 mV), each
  committed while the SMU sat on that level. The new value appeared on
  the next entry into the level and not before.

- A clock above the range, a voltage above the range and a table with
  non-increasing clocks were rejected with -EINVAL, and "r" restored
  the VBIOS levels.

- S3 with level 0 committed at 300 MHz / 800 mV: right after resume,
  before any level change, OD_SCLK still showed 800 mV and the VDDGFX
  sensor read 800 mV.

- On amd-staging-drm-next, each patch builds with clang W=1 without
  new warnings, and the series adds no sparse or smatch warnings.
  checkpatch --strict only reports the uint32_t and CamelCase
  checks that follow the existing powerplay code.

Two choices are left to whoever applies this:

- Earlier APU overdrive support (Raven, Renoir, VanGogh) is
  clock-only. The voltage control here stays within the GfxVid range
  of the VBIOS levels; a clock-only version can be sent instead if
  that is preferred.

- Stoney is enabled without having been tested. Limiting the series to
  CHIP_CARRIZO until someone tests it is a one-line change.

I used an AI coding assistant (Claude Code) for this series. It wrote
the code, the changelogs and a draft of this letter, and wrote and ran
the build checks and test scripts. I reviewed the series, ran the tests
on my hardware, and I am responsible for it.

---
Joshua Horne (5):
      drm/amd/pm: keep smu8 sclk level lookups within the table
      drm/amd/pm: move smu8_populate_umdpstate_clocks() up
      drm/amd/pm: show the smu8 overdrive sclk table
      drm/amd/pm: allow editing the smu8 overdrive sclk table
      drm/amd/pm: stop disabling overdrive on Carrizo and Stoney

 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   6 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |   1 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    | 319 ++++++++++++++++++++-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h    |   8 +
 4 files changed, 319 insertions(+), 15 deletions(-)
---
base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
change-id: 20261113-smu8-overdrive-4208a3756d57


