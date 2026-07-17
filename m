Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC40AC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B96910E4F8;
	Fri, 17 Jul 2026 21:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fWXyD/z7";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4231510E4F8
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:32:07 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-51c8e2e39easo76507501cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784323926; cv=none;
 d=google.com; s=arc-20260327;
 b=iZOxC8r6mNAQU0KG9UnI0CLpDaA/2aqql61QFS5Z63M1nVJcWMylxLELUoIO5l0HLm
 eEJEi+/qwAWGDsMGJT+8p1X1mUA6z8ZSwIdHiMXCLfMFUHqut5bgvKyxm1PovrFtTnqR
 yu/rZT7IwH0d4nF2B1ePv405H8OHyN/SgVoUh/9Lk7S949S7qd3UL9gGm/QWb+dhDPIk
 lViDwSMqIkllwpPdRcbqHGITEFEOzqrta1qeIbEvXfSlqZoF1+w7bPIcZSljdHU0d9cB
 TCOXGYSsMK3i8aCkeBK0k7Gi6+IDEu9ToXFG1frpkx6kOl4IYQ9QLH1Ho+xcbMlU372z
 F0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=XHWWsOCo0jsnIc0Xw63Pi9KWoWBdP/h2lvOQrAlxPrk=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=PE8IMVVlUJpUldNB8WvKONglaLVHYEEtu/qq1oduK3ndVqAPrIyRhfZ250eZ7x7VQ2
 FpPvqlgyqDvqMvP9h9Nc7qPEXTAhFYgMDt8r2zVy+/6euVxT1D0obg6G9bgE943DMvjz
 e9PV8Cit+kY2GFxTqOUf8Bvvdf8omMDSq68mxXfwIkvcIjIodOrr2q1Dt5bIprPuWPFm
 PZsaSuS4Qx/Ismm/njwZR23vNF/JIYMJ1WkComR5kOk2d2oHh3mZ8KIV4q5eF1mIieyN
 qT4KbXdqSLYvNsPKvgBm5gs5DAyx6yAK4ew/oBtbqPGkroUa5rKii/MY3G25k3c+aH0o
 ckeg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784323926; x=1784928726; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XHWWsOCo0jsnIc0Xw63Pi9KWoWBdP/h2lvOQrAlxPrk=;
 b=fWXyD/z7Ed1mTBw6reU7O75f3PIED3D/yU31mcur04cXhvJKUtBQvsMF7rKZmhPW3V
 SlyLQYqeH7OBnDERE8qTHgyjGQ8CH/6Edi0LjFPmcj1D6J9kGoJ7HDiKKME/hYLNQwTz
 MF9qF9ws1SpJbXLwl6k7kfOqpeGEcapJduzGAUljHaSHxZnGT8xSo6azKGNZ3j3u41SH
 AyCZn0k/k0j1oC0W0rGz/TLuElQnW5AQ3u1qO07RX8Bw5efO9tnWOxcOG2R7QQvoQbWz
 sI5Z4lom1ZKvX+6Xga+On8R8bhNXy1Wtc746BrkR5bH+UhZzY7eT6b3yzzmc+3dfAmeu
 8CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784323926; x=1784928726;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XHWWsOCo0jsnIc0Xw63Pi9KWoWBdP/h2lvOQrAlxPrk=;
 b=eu38yEGljJPNs49tvRgA98B6m9aQbk2QzMUgVzK6Fmzh1bfwGQPOhls9ntWPcnLGgY
 cXgNhClkfJTMVO6tjQg8vRmDvO2mDLARO7l/mrYFxcs02Ttt7W2FWWsWrspAasg4eSK9
 Oo2aUdhXeDCSb42i97+55tgOnHMCp/QvPruK69AUSyK7ppwUI1NVeyabS4r52ReLTe+e
 wzvoYobbAfq8zN3A+y/KkVQcF3OrZekg0tor+gaDLgsFRea3G5mKPZXd/G9jWUziZ0s6
 x+dCqdd9hF5GNgn4xpWgXLAAElLrvg0d/wmp4MnUXw1kKXIJOQuV0KbXvuKYWG0QGbYS
 zJTw==
X-Gm-Message-State: AOJu0Yx3PcG44oCcd/jomHpv/x3iKQFPJ3xBeGXLsnu/yBBurMog9BG9
 M3GMhhk+oIDk9AnQ+lz8ZhD7+1A1dXQZPK6WJKEyjEREgmel+cxmR0YTWYbx7prLQKNgk38SL00
 OCpWup38k+yDwQRGQajYbKC9Y6AP4Gdw8zXtg7G2hug==
X-Gm-Gg: AfdE7clQu4WS6pkUP0EvDJoq/sTDtUxt6A6YD6c+C54nz6GdXV0nCh2UaCVHlu5Ckxo
 fFWTrI4Xw/txjgSUfw/IGPL+iu0+04tMe5JWNXCdBP3Wz7XO2DbyHjMmWIL9WJa5NhC0YnlMx7b
 GoyCO5HoZsxZF/3v3ShlE7M3pQ/QWLizKfoH9DSS1KJRTIV7nfcfp2F0YIv0rYB8ICB9et1j4Da
 tUdKmDVVCjBkztvLACdILPwleyf4cokQ088cKPd2UF8S4jmF9NnTtveMu1iVODi4q015ho/xgnW
 T2uxT32uMtboDrldJBJt0iFiHo6Mkqj6nuyX62zmAXNxMzQ=
X-Received: by 2002:a05:620a:1b97:b0:92e:6cd4:5892 with SMTP id
 af79cd13be357-930b417c645mr520049685a.40.1784323926075; Fri, 17 Jul 2026
 14:32:06 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 18 Jul 2026 07:31:54 +1000
X-Gm-Features: AUfX_mwmruPuXcaVdnOuKR73v8Vop2g036tUwUYheC9DPzDqt9COjpK4FljvrQM
Message-ID: <CAPM=9tw1j=WYsQjs8Empd1G0CorM-YHFDD87coJSBSXfxOOoXA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.2-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Linus,

Weekly drm fixes, this is xe and i915 and then a lot of scattered
fixes, there should be a bunch of amdpgu fixes in here, but there was
some missing Signoffs so I dropped the whole pull request until Alex
fixes it up, so that might arrive later or might not.

Dave.

drm-fixes-2026-07-18:
drm fixes for 7.2-rc4

ttm:
- Handle NULL pages and backup handles in ttm_pool_backup() correctly.

gpusvm:
- Improve unmap and error handling on gpusvm.

udmabuf:
- Always synchronize for CPU in begin_cpu_udmabuf.

xe:
- Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOCK
- Hold a dma-buf reference for imported BOs
- Fix writable override for CRI
- Fix VF CCS attach/detach race with in-flight BO moves
- Fix WOPCM size for LNL+
- Reset current_op in xe_pt_update_ops_init
- Keep scheduler timeline name alive
- Hold device ref until queue teardown completes
- Disable display in admin only PF mode

i915:
- NV12 display fix for bigjoiner
- clear watermark on plane disable
- GT selftest fixes

host1x:
- Fix UAF

amdxdna
- Fix UAF
- Reject more invalid amdxdna command submissions.

ivpu:
- Fix wrong read
- Handle invalid firmware log in ivpu.

panthor:
- Fix error handling

virtio:
- Fix virtio deadlock
- Fix invalid gem detach.
The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-18

for you to fetch changes up to 5554e0599c960a2b320a78ef1429ddb1a1d94aec:

  Merge tag 'drm-intel-fixes-2026-07-17' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
(2026-07-18 07:18:18 +1000)

----------------------------------------------------------------
drm fixes for 7.2-rc4

ttm:
- Handle NULL pages and backup handles in ttm_pool_backup() correctly.

gpusvm:
- Improve unmap and error handling on gpusvm.

udmabuf:
- Always synchronize for CPU in begin_cpu_udmabuf.

xe:
- Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOCK
- Hold a dma-buf reference for imported BOs
- Fix writable override for CRI
- Fix VF CCS attach/detach race with in-flight BO moves
- Fix WOPCM size for LNL+
- Reset current_op in xe_pt_update_ops_init
- Keep scheduler timeline name alive
- Hold device ref until queue teardown completes
- Disable display in admin only PF mode

i915:
- NV12 display fix for bigjoiner
- clear watermark on plane disable
- GT selftest fixes

host1x:
- Fix UAF

amdxdna
- Fix UAF
- Reject more invalid amdxdna command submissions.

ivpu:
- Fix wrong read
- Handle invalid firmware log in ivpu.

panthor:
- Fix error handling

virtio:
- Fix virtio deadlock
- Fix invalid gem detach.

----------------------------------------------------------------
Alexander Usyskin (1):
      drm/xe/nvm: fix writable override for CRI

Arvind Yadav (2):
      drm/xe/guc: Keep scheduler timeline name alive
      drm/xe/guc: Hold device ref until queue teardown completes

Daniele Ceraolo Spurio (1):
      drm/xe/wopcm: fix WOPCM size for LNL+

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2026-07-17' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-07-17' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2026-07-17' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes

Doruk Tan Ozturk (2):
      accel/amdxdna: reject user command submission without a command BO
      accel/amdxdna: reject command submission on devices without a submit op

Emre Cecanpunar (1):
      drm/i915/selftests: Fix GT PM sort comparators

Himal Prasad Ghimiray (1):
      drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC

Honglei Huang (3):
      drm/gpusvm: free the whole IOVA reservation on unmap
      drm/gpusvm: do not route system pages to device_unmap() on IOVA unmap
      drm/gpusvm: publish dpagemap early to avoid device mapping leak on error

Jason Macnak (1):
      drm/virtio: Don't detach GEM from a non-created context

Jhonraushan (1):
      accel/ivpu: Reject firmware log with size smaller than header

Karol Wachowski (1):
      accel/ivpu: Fix wrong register read in LNL failure diagnostics

Linmao Li (1):
      drm/panthor: Check debugfs GEM lock initialization

Lizhi Hou (1):
      accel/amdxdna: Fix use-after-free of mm_struct in job scheduler

Maarten Lankhorst (1):
      Merge v7.2-rc3 into drm-misc-fixes

Matthew Brost (2):
      drm/ttm: Account for NULL and handle pages in ttm_pool_backup
      drm/xe/vf: Fix VF CCS attach/detach race with in-flight BO moves

Mikko Perttunen (1):
      gpu: host1x: Fix use-after-free in host1x_bo_clear_cached_mappings

Nitin Gote (1):
      drm/xe: Hold a dma-buf reference for imported BOs

Osama Abdelkader (1):
      drm/panthor: return error on truncated firmware

Pengpeng Hou (1):
      drm/i915/gt: use correct selftest config symbol

Robert Mader (1):
      udmabuf: Ensure to perform cache synchronisation in begin_cpu_udmabuf()

Ryosuke Yasuoka (1):
      drm/virtio: fix deadlock in display_info_cb by removing hotplug
from dequeue worker

Satyanarayana K V P (1):
      drm/xe/pf: Disable display in admin only PF mode

Vidya Srinivas (1):
      drm/i915/display: Fix NV12 ceiling division for bigjoiner case

Vinod Govindapillai (1):
      drm/i915/wm: clear the plane ddb_y entries on plane disable

Zongyao Bai (1):
      drm/xe/pt: Reset current_op in xe_pt_update_ops_init()

 drivers/accel/amdxdna/amdxdna_ctx.c                | 18 ++++++
 drivers/accel/ivpu/ivpu_fw_log.c                   |  4 ++
 drivers/accel/ivpu/ivpu_hw_btrs.c                  |  2 +-
 drivers/dma-buf/udmabuf.c                          |  9 +--
 drivers/gpu/drm/drm_gpusvm.c                       | 53 +++++++++++-----
 drivers/gpu/drm/i915/display/skl_universal_plane.c | 33 ++++------
 drivers/gpu/drm/i915/display/skl_watermark.c       |  2 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |  2 +-
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |  8 +--
 drivers/gpu/drm/panthor/panthor_device.c           |  5 +-
 drivers/gpu/drm/panthor/panthor_fw.c               |  1 +
 drivers/gpu/drm/ttm/ttm_pool.c                     | 34 +++++++++--
 drivers/gpu/drm/virtio/virtgpu_gem.c               | 14 +++--
 drivers/gpu/drm/virtio/virtgpu_kms.c               |  5 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |  3 -
 drivers/gpu/drm/xe/xe_bo.c                         | 58 +++++++++++++-----
 drivers/gpu/drm/xe/xe_bo.h                         |  3 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |  2 +
 drivers/gpu/drm/xe/xe_device.c                     |  4 +-
 drivers/gpu/drm/xe/xe_device_types.h               |  2 +-
 drivers/gpu/drm/xe/xe_dma_buf.c                    |  2 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |  5 ++
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 70 +++++++++++++---------
 drivers/gpu/drm/xe/xe_guc_types.h                  |  2 -
 drivers/gpu/drm/xe/xe_migrate.c                    |  5 +-
 drivers/gpu/drm/xe/xe_migrate.h                    |  1 +
 drivers/gpu/drm/xe/xe_module.c                     | 49 +++++++++++++++
 drivers/gpu/drm/xe/xe_module.h                     |  5 ++
 drivers/gpu/drm/xe/xe_nvm.c                        |  9 ++-
 drivers/gpu/drm/xe/xe_pci.c                        |  9 ++-
 drivers/gpu/drm/xe/xe_pt.c                         |  3 +
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c               | 20 ++++++-
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.h               |  3 +-
 drivers/gpu/drm/xe/xe_vm.c                         | 25 ++++++--
 drivers/gpu/drm/xe/xe_wopcm.c                      | 15 +++--
 drivers/gpu/host1x/bus.c                           |  4 +-
 36 files changed, 356 insertions(+), 133 deletions(-)
