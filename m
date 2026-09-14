Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA32FC88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CF810E034;
	Mon, 14 Sep 2026 02:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMw82zmU";
	dkim-atps=neutral
Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FD310EA71
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:10:06 +0000 (UTC)
Received: by mail-oi2-f4.google.com with SMTP id
 5614622812f47-4b388697b03so377279b6e.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 19:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789351805; x=1789956605; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VyFl8OR0uDUO8uKxg8rNc5Dxixa51YMSLn7xjZ2lM5o=;
 b=TMw82zmUjF11Urumy3ut9YEiMgYi7lrz7zgMJ//jIcMnmTIQ9FFEat6GX5N12rAlVV
 IWPtSnXQNWYxTpwOmdcmzC26JN1ATsjowlpwGCpUpUiw/kf6ZyOB6pAOvSNqi7AZhsdZ
 u1eV8IHcHZS7Tp75XDoSy+0FaMFJ7rOmTSnyF0h4+4q8lfpRKLkTUEBEnj96TmDRQYpZ
 Drj4uhsThIdGvNBi+wCurGbB/vfpg0AckTPFra+qUNiShPNCo7Q02qD9i3Fh4P4rqJ+L
 R18J+ss9FCT+giwZJlv+m+yjuV4b7WGoidNb6w8fWUrEewvLVVwvPs0YQjXqVYbLUomv
 gSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789351805; x=1789956605;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VyFl8OR0uDUO8uKxg8rNc5Dxixa51YMSLn7xjZ2lM5o=;
 b=k6aTWtIHSUzIoncAhqbkoXm0kI/5BjHpf75FNN5GIy9/HaOgUrJhCjUDWfbul2mLoG
 0IVve6eeGjABWnLVagKk5+pyHjBXdPM6enGhmTXhVdiqYAevxVwLwPeHO73m/kLl0mS1
 JTC4P7w2/mUX7fihCylZLbOpuua9V1u/wyNrGVJOrbNA17HFRSQb2o1KP26bTW4bD5pb
 qz41O/GJ0oIUPDTQMlS9BYo6+WzOJ/JuTlwXJh+Bdmqd2YQcUAm45RQVoIfeSmyUo1Oy
 bzObJmqX56BQIK9aMiP2uHvuwLdInsytN3mScA6OKSU9xxkN5J3hJXuYSwuAqWsI8hpL
 3scA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyTPHf0AUdIVW0V2sPIyMveL6vL5x3M7/u9VNFLAvsGXzuaz/YoOYAOdvhUoY2vf6JcIfKHp/xLq0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mFWnpmJm7By7Fvabr2WDrHcTeNuvbOTUYxLBIfRu+WTgZNLktN
 Otik1Gcp69qvKrx2mNnc21w00+w2otSxdQXY0YQZ9YKAxT4mEDqppLLP
X-Gm-Gg: AYBFou2v9TSmXBmGWpjv3+InKIVqN+UEIC7mA8HEWwYpPrxmEDqn8cbF+57GcDZ0Ntk
 fjVV1e+iHKP6GHZre5duCLHjzAx5xGhg6Z9pEoEYVFZ9YY0yA3NgvR7Vg5UUZb7Ur0SrDYC1lU7
 +B+66aNreRispOtVPgKj0F9OlaokrUTRyTXoG38kG2KbiV6Xssr309TFIolXKCV5YYeuOlCTN4k
 wwEKQSzwogQ4ATL6wtyfU+mlLW0ZuCCQ6nV+LA2EGBgU5dTL6k59gtKv5TBRF5/Vz3H2tu9X9ej
 pexhggmwVq+4c60Yi4l7NZoxp7VVhLmXQcX6jED0WtJL/Pv3zD24BF/zlJN37c3BGCSOv9zCbl4
 qej4fDDyow9n3mY/c4kqeyUDRjJZPGLFbyWnRmRWu41pmafsNmSpGeANXIjxoEWSsTrKhwoheUY
 EH8lkBgm8GX9XFDQgde0dmsWgJHGU+TUA0vLfPW7rti79WRGNs0odwilSFDcsF/+pFU1A=
X-Received: by 2002:a05:6830:3692:b0:7fa:ab72:9dff with SMTP id
 46e09a7af769-80899b59dcbmr170262a34.23.1789351805145; 
 Sun, 13 Sep 2026 19:10:05 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f5ffd82bsm9788713a34.11.2026.09.13.19.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 19:10:03 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH v3 0/4] drm/imagination: fix system suspend, and the
 callback design underneath it
Date: Sun, 13 Sep 2026 21:09:51 -0500
Message-Id: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/62OQQ6CMBBFr0K6dkwpCtSV9zAuKAxYA6Xp0EYk3
 N2iG/e6fJOfeW9hhE4jsVOyMIdBkx5NhGyXsPpWmQ5BN5GZ4CLnkktwynkE8vgEb2lyWA3adGC
 Di0eyaBrorAeaacIBqEe0oFolm7YpOC8Ui5+tw1Y/3tbL9cPk1R3raVNti5umaXTzOyuk2+63g
 pBCCu3hWB4KVctjqs7dUOl+X48D2wqC+INDREeeVzIrUQpVFt+OdV1fWAbGk2wBAAA=
X-Change-ID: 20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-bfb9dfd7007b
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789351801; l=4695;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=r9Aq0smRbtGVXoOkB0wcDk///UPxMJx1xjzV3KGy6PI=;
 b=CiWuBsJLTwBQZxeWjo/KaH9V7N9Md5YIjsdxwa8si31Q7IRnNpuHYvMmQd6nQ2z/6NpWjR99J
 CfH6p3TTFkADDVel90drI3YbtOSjnZ6Gipp8L5HH14UG1wEiUFt/Ais
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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

The GPU has no system-sleep callbacks, only runtime PM ones. If it is
runtime-active when the system suspends, genpd drops the power domain
behind the driver's back and the first firmware operation after resume
wedges its caller in an unkillable D state. Patch 4 is that fix, and is
what went out as v1 and v2.

The v2 review showed that wiring the force helpers in raw was not safe
as the driver stood. The cause is one design fault: the runtime PM
callbacks use drm_dev_enter() as a "device lost" test and hold the SRCU
section while waiting for the watchdog worker. That makes a lost device
fail every later suspend and makes pm_runtime_force_suspend() deadlock
against a worker that loses the device. Patch 1 fixes the callbacks,
which lets patch 2 unplug first in pvr_remove() and lets patch 4 go
back to v1's one-liner. Patch 3 fixes a watchdog-vs-teardown race found
on the way.

On the v2 review's remaining finding, that pvr_power_fw_disable() can
return without re-arming the watchdog: after a failed runtime suspend
the device is in runtime_error with a zero usage count, and the
worker's pm_runtime_get_if_in_use() returns 0 in that state, so a
re-armed watchdog could not act. No change made for it.

All four were measured on mt8173 (Rogue GX6250), both arms from one
build switched at runtime; the details are in the individual messages.
Lockdep cannot report the patch 1 deadlock: cancel_delayed_work_sync()
only touches the work's lockdep map when a worker is executing, so the
srcu -> work edge is never recorded unless the cancel races a running
worker.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Changes in v3:
- Restructured as a four-patch series. Instead of wrapping the force
  helpers to work around the runtime PM callbacks, 1/4 fixes the
  callbacks: they test pvr_dev->lost rather than drm_dev_enter(), and
  hold no SRCU section while waiting for the watchdog worker. That
  removes the [Critical] AB-BA deadlock and the [High] TOCTOU at their
  source, and 4/4 returns to v1's raw pm_runtime_force_suspend()/resume().
- 2/4 fixes the pre-existing remove() ordering the review reported, and
  can now put drm_dev_unplug() first.
- 3/4 fixes a pre-existing watchdog-vs-teardown race found while
  reviewing the above.
- The review's "watchdog not re-armed" finding is answered in the cover
  letter rather than patched; see above for why.
- Added hardware evidence for both arms of every patch; v2 asserted the
  failure without showing it.
- Link to v2: https://patch.msgid.link/20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v2-1-66a938e92b87@gmail.com

Changes in v2:
- Don't wire pm_runtime_force_suspend/resume in directly. Once the GPU
  has been lost, drm_dev_enter() fails, pvr_power_device_suspend() returns
  -EIO, and the force helper hands that to the PM core, which aborts the
  system suspend -- permanently, since a lost device never becomes
  suspendable again. v1 would have traded a GPU that dies on suspend for a
  machine that cannot suspend at all. v2 wraps the helpers and skips the
  transition when the device is already unplugged. Caught by the Sashiko
  AI review bot.
- Commit message: say why the wrappers exist, and note that
  pvr_power_fw_disable() leaves the watchdog cancelled on its error path
  -- pre-existing, but system sleep is a new way to reach it.
- Cc'd Chen-Yu Tsai, Icenowy Zheng and YoungJoon Lee, who are testing this
  same GPU in the MT8173 powervr thread [1] and are the people best placed
  to say whether this reproduces on a Chromebook. That thread doesn't
  mention suspend at all.
- Dropped sarah.walker@imgtec.com and donald.robson@imgtec.com, both of
  which bounced on v1.
[1] https://lore.kernel.org/all/20260728091804.382753-1-wenst@chromium.org/

- Link to v1: https://patch.msgid.link/20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v1-1-f45847bc951b@gmail.com

---
Ryan Brue (4):
      drm/imagination: don't gate the runtime PM callbacks on drm_dev_enter()
      drm/imagination: unplug the device before tearing it down in pvr_remove()
      drm/imagination: stop the watchdog before tearing the device down
      drm/imagination: suspend the GPU for system sleep, not just runtime PM

 drivers/gpu/drm/imagination/pvr_drv.c   | 17 ++++++++++---
 drivers/gpu/drm/imagination/pvr_power.c | 44 +++++++++++++--------------------
 2 files changed, 31 insertions(+), 30 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-bfb9dfd7007b

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

