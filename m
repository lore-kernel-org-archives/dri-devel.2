Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A2C108B8FF
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 05:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077A610E1F8;
	Sat, 21 Mar 2026 05:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mEfd9g2B";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88AB10E2CE
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 05:45:12 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-829781b2b01so1531847b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 22:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774071912; x=1774676712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=21zbRPn53NtO4HKBeb/Qwdup+vsCpA2EHYoiuByr0qI=;
 b=mEfd9g2BJ7O8WbPjePKhjKQKdz94JjWk/5AOvdGSUCzdO2YR1xm2AboZilJQTApq/y
 1iUyzINb4ZTAcXh/+nj4dfxc+BgvHZoxd2IQaLgoLGunmsAcJakeQgb4ms8h1NigHZvz
 S9voeBgcH1Jrlh2cUtYq7aoa0T0rDrMchg4FdoeI9SyB+mNuP6yeIdBnFbcatRfDA4FI
 6K8qNl5z4Q7Xtc+P6LhCf0ddrjzOWC9s7AQv4c8uEXhqlZfHdN+lLe9kw9KZfMoadjtq
 DWQekVqeLNCNDW7XNIz1K5/JU2KHTw5Rt+t6D6B9gVEHJ8l/EhfC5ctBq+g/TCOGbIGP
 fz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774071912; x=1774676712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21zbRPn53NtO4HKBeb/Qwdup+vsCpA2EHYoiuByr0qI=;
 b=j1MwwzMNheT3sJGZcNQ0gkPz1wX7jQGkRJPukshRBT9P+YV/FI2O5PuWbpRTTZUhhM
 Al3W9v6AKK19uKSOVcdoUxor1Gjic5WukDApl4oSjDNVH+TWIbjv2eRXU5k6gHtR7IR0
 aA8nQ1xDLbzS3gzcv5/3CXeA/3nSi3wl1q/RsDgE5yUKreoiUaGEO5nIpOvDxVSNlIzw
 uYO2R+ScvUQapyQm4SFGm0gwpQx47quXgieZTai4HxRzlUGHCfVxcj01+GrQ7NL1Gae9
 /hCK2PlAbDn6L3SrhpJBPO9dno98GLzWsjvXlm82uw3XVGHhIYv60jfCo8OgZQh2U7Kh
 EPAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPInc3cevD2Da8IL2KbKjohgBPyB+ti2nQmAga9h2a+pxMexyZSEHcDAeqktPR6t6TlrGOxz8WXk4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMfGLw193E4JMY8ic6TKj7Vh9Wj9jUwHC80gXYyfbBHlfgR6Mo
 MsWXSGTd/JBCPLkvetOaezcFIb8/2VzxmEQuM4wC9mqylDGX4MD0yyGC
X-Gm-Gg: ATEYQzzKOLjyt9TEh8ZAon6yfB9hx5Fz3Oz+eQ5TmGfRK5wbDXYAEB7tj35tfJCPNWR
 c1VY3XR4nDFxAGQSi0djW1ziPTEOXuIvyRRPe3eozTXe62GCY15IXhC7v/zFXzSr/uyky9VhBkR
 ljD9EJzrO0nM11iIVYpgOr8InehG3RBsK3FfdmHJs14SJwTp4BgdSjjJvSIH/IFO8Cq8andE425
 WjtavJ6ofXRP53ZWAawx/FbRLbmsCi5lVyzNPJzNWnxpdlUdMz4OPWDpu1UwUXymY9DNHvdQOW6
 0td+5vA8X0e9gtga3ZmGev10URN4Zb1HteTRZlNRq/Pj7JXF5ZmTUJpaMajsEkXkpoczz/cOdRu
 5I1cMGrwWQrtOYIeSTQ6GDQ9LBA6Uovatklw5RKtkvO5Q5lhbRQJfTaEig7WWbTIQHiO5w5Zwj6
 KNhBpoimSMBtNGw2KxYSG0CzsEGw7ZhDLHSCqXehNirQtFGYo0u0HQwHY=
X-Received: by 2002:a05:6300:83cf:10b0:398:7949:38fd with SMTP id
 adf61e73a8af0-39bcecb0ba5mr3559729637.57.1774071912212; 
 Fri, 20 Mar 2026 22:45:12 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409c681sm4338783b3a.37.2026.03.20.22.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 22:45:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sasha Levin <sashal@kernel.org>, Rosen Penev <rosenp@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Zhigang Luo <Zhigang.Luo@amd.com>, Bert Karwatzki <spasswolf@web.de>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Roman Li <Roman.Li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>, decce6 <decce6@proton.me>,
 Wentao Liang <vulab@iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 for 6.1 0/4] amdgpu: fix panic on old GPUs
Date: Fri, 20 Mar 2026 22:44:49 -0700
Message-ID: <20260321054453.19683-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Because of incomplete backports to stable kernels, DC ended up breaking
on older GCN 1 GPUs. This patchset adds the missing upstream commits to
at least fix the panic/black screen on boot.

They are applicable to 6.12, 6.6, and 6.1 as those are the currently
supported kernels that 7009e3af0474aca5f64262b3c72fb6e23b232f9b got
backported to.

6.1 needs two extra backports for these two commits to be cherry-picked
cleanly. Those are

96ce96f8773da4814622fd97e5226915a2c30706
d09ef243035b75a6d403ebfeb7e87fa20d7e25c6

v3: Add those commits to this series and sign them off.
v2: Add Signed-off-by.

Alex Deucher (2):
  drm/amdgpu: use proper DC check in amdgpu_display_supported_domains()
  drm/amdgpu: clarify DC checks

Timur Kristóf (2):
  drm/amd/display: Add pixel_clock to amd_pp_display_configuration
  drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 32 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  1 +
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  2 +-
 .../drm/amd/display/dc/dm_services_types.h    |  2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 ++++++------------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 13 +---
 17 files changed, 126 insertions(+), 81 deletions(-)

--
2.53.0

