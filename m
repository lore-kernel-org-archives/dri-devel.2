Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D7CC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2926F10F333;
	Thu, 10 Sep 2026 07:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="a5yK9BGJ";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="De8+MDnj";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E276710F333
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789025788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=fhiJfocRqbrYnuPz9RkY0OnbkGrAJA6KUWww65lP/c4=;
 b=a5yK9BGJq2+mylhpdIpfUVlZ+/wcQGFDKljm30lOyRkYHk6zCicrC1RIOQUA+GFRbEci40
 pksFx+6vuKEzDW6P4gGZmBralCaZgsxipd8wfWVDugSRxRH+vOs8FRvwfyx/tYZpJj/Rw4
 GQFnRJGMThxcppnMmSzQBimuymvUZpY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Zakv0kdPPCq7ENjIWJG4HQ-1; Thu, 10 Sep 2026 03:36:27 -0400
X-MC-Unique: Zakv0kdPPCq7ENjIWJG4HQ-1
X-Mimecast-MFC-AGG-ID: Zakv0kdPPCq7ENjIWJG4HQ_1789025786
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49554715277so65769985e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789025786; x=1789630586; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fhiJfocRqbrYnuPz9RkY0OnbkGrAJA6KUWww65lP/c4=;
 b=De8+MDnjvnaZLkbT4LMvbKIqt6hOKj28cl0hsbNuLTVEI3tqY5YVKjLZBIKZASstqq
 D9bBsBTHbNnnFvGXo0a0aJBdRKwK9PiIz7C3eO6VTANk0O7DsYhIlPy2CVyEVbB6TMsY
 4hJPBUflXPkNKTTHNF32LrSRAsnlxuLayu4mmOszjpSf8Vfur3G0/djXmsG3/X3NH+D1
 hlDb7zJz4OpKNeHeon8yMT6e55TsvE1jQn7Rs5R5ijVS9iZ5N1qmNHk4oOjVUJ1JaXrD
 IGsbxaqmLnBHcxiiSiFmhueQ0Ganb3EApiyRYiuDWn0SgmCCgDeV0rGfcIeYVRDfn0/k
 WMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789025786; x=1789630586;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fhiJfocRqbrYnuPz9RkY0OnbkGrAJA6KUWww65lP/c4=;
 b=ccfML8N0EGViFOMCZFfY+asmwWFWedjvfdg5k0aOShKYino2MobgttXwF9xqFSgwhs
 0neXqMOpR4oZNvtspQkwc1OPzQiyoyyKgEUcUZvOz1srdRnMsqezzAbj6U61aL6SuCYV
 19cmq0P7F2/V9B29HRmNWYx/Xzx9FWOYiUf7bEyi9R87ErChFdWbfUMGjPizXxwpPOjO
 qiLJjj0/2h3c4L2dQAjfmRD/PbAS5HYWTvrX+q7tRwfDHOGH78BPnY1i8Gez150dbHiE
 EBGAqWDR/nhIjV7sS9i1RsPuIjQSHezfEf/Q4Z2CGtwIcABjFjPqLNrWms5ySnmtwVZk
 Tc1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByrn/OVOLGDARrNUkDhtrrbUeyVh6nEUCykQ1yPnDW+U823XH4hj46gLewLY5cZfqFf3WfwvMFL95I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0qyBesmVuIVjzAFrf0fallxW0nqqVmCnXAaT523uWDnAX1hFs
 mpUm483GGK2wQJwBd3/It6+FD8kiViydw7cDn+7yMAkP8HsEsOBziGg8ItdLOuciTxFbVT5du/z
 oWNVM0UzwL9lnvAHhVTtXmv3LcezeR93mLME1YgHdNhqSCun15jBAWIeSNS8yUFbxexufwA==
X-Gm-Gg: AYBFou33qXZzGikIFAnpJCm5hXOohn8na0/+lYMG7fGocdWBXjxNx/A45f9/9gdikNd
 Rpb93RpcatnPfypeoFq6yTWEPVj3Tt1a6jzz3MWQL12+wnrQ0znmclxLqoJK9PDFLpDMbk4OPJI
 PpDc5NNOdD713ZZQm9UAngJbhCCrU7DjjCWWlfRgkLIMbVkEQR53yGVL1iKe8pXa7ei0Mme7Qw2
 VNs1qvUvxbp+7aoJS/IRdzXTViAW5tok4xe4vqpMJeZbgQhJvgpk/wIgn1WGQ1Nj7MfU40rygkF
 6w+ulj4qqN64b8xt1zJvn2tAPYkHxjlS8ewuA7cKIIxdFqe9vLpfo6ERinL7mlY1b1vtk5sDVA=
 =
X-Received: by 2002:a05:600c:1e24:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-49d259502f1mr106251765e9.16.1789025785821; 
 Thu, 10 Sep 2026 00:36:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1e24:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-49d259502f1mr106250675e9.16.1789025785264; 
 Thu, 10 Sep 2026 00:36:25 -0700 (PDT)
Received: from localhost ([2a01:e0a:a99:9822:ca7f:54ff:fe01:374c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859207c28fsm44595353f8f.5.2026.09.10.00.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 00:36:24 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:36:22 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Dave Airlie <airlied@gmail.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-misc-fixes
Message-ID: <aqJd5TPXpwqwsM0F@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="3xkcu43eemue6yqx"
Content-Disposition: inline
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


--3xkcu43eemue6yqx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [PULL] drm-misc-fixes
MIME-Version: 1.0

Hi Sima, Dave,

Here's this week drm-misc-fixes PR

Maxime

drm-misc-fixes-2026-09-10:
A fair amount of fixes this week as well:

- create blend mode property for more driver planes
- Kconfig cleanups across the board
- sched: null pointer dereference fix in kunit tests
- ethosu misc fixes about error handling and corner cases handling
- ivpu fixes about buffer and metadata validation
- rockchip: fixes around buffer overflow and kconfig
- tc358768: fix bus flags and error handling
The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-09-10

for you to fetch changes up to 4600b4d1a9ee730d03ddac5ce409cd2730ce8c0c:

  drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work() (2026-09-09 17:07:54 +0200)

----------------------------------------------------------------
A fair amount of fixes this week as well:

- create blend mode property for more driver planes
- Kconfig cleanups across the board
- sched: null pointer dereference fix in kunit tests
- ethosu misc fixes about error handling and corner cases handling
- ivpu fixes about buffer and metadata validation
- rockchip: fixes around buffer overflow and kconfig
- tc358768: fix bus flags and error handling

----------------------------------------------------------------
Dawid Osuchowski (1):
      accel/ivpu: Limit firmware log name prints to field size

Esben Haabendal (1):
      drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()

Igor Paunovic (2):
      drm/rockchip: dw_dp: Select DRM_BRIDGE_CONNECTOR
      drm/rockchip: rk3066_hdmi: Add missing Kconfig selects

Karl Mehltretter (2):
      drm/adp: Drop the select of the nonexistent CONFIG_DRM_KMS_DMA_HELPER
      drm/logicvc: Drop the select of the nonexistent CONFIG_DRM_KMS_DMA_HELPER

Leonardo Costa (1):
      drm/bridge: tc358768: Enforce input bus flags via atomic_check

Magdalena Schulfer (2):
      accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
      accel/ivpu: Validate firmware log buffer metadata

Qinyun Tan (4):
      drm/ast: create blend mode property on cursor plane
      drm/qxl: create blend mode property on primary and cursor planes
      drm/virtio: create blend mode property on cursor plane
      drm/vboxvideo: create blend mode property on planes

Rob Herring (Arm) (5):
      accel: ethosu: Fix ethosu_job_open() return value
      accel: ethosu: Drop IRQF_SHARED flag
      accel: ethosu: Ensure cmd stream ends with a stop op
      accel: ethosu: Ensure SRAM size is 0 on mapping failure
      accel: ethosu: Ensure SRAM region size matches job

Shixiong Ou (1):
      drm/sched: Create a fake device for KUnit tests

Sunil Khatri (1):
      drm/drm_exec: fix up contended obj when num_objects is 0

Thomas Zimmermann (1):
      Merge drm/drm-fixes into drm-misc-fixes

Yudi Yang (1):
      drm/rockchip: analogix_dp: fix unchecked bound endpoint name length

 drivers/accel/ethosu/ethosu_device.h             |  1 +
 drivers/accel/ethosu/ethosu_drv.c                |  3 +-
 drivers/accel/ethosu/ethosu_gem.c                |  9 +++
 drivers/accel/ethosu/ethosu_job.c                | 16 ++---
 drivers/accel/ivpu/ivpu_fw_log.c                 | 87 ++++++++++++++----------
 drivers/accel/ivpu/ivpu_gem.h                    | 14 +++-
 drivers/accel/ivpu/ivpu_ipc.c                    |  7 +-
 drivers/gpu/drm/adp/Kconfig                      |  1 -
 drivers/gpu/drm/ast/ast_cursor.c                 |  3 +
 drivers/gpu/drm/bridge/tc358768.c                | 15 ++--
 drivers/gpu/drm/bridge/ti-sn65dsi83.c            |  6 +-
 drivers/gpu/drm/drm_exec.c                       | 13 ++++
 drivers/gpu/drm/logicvc/Kconfig                  |  1 -
 drivers/gpu/drm/qxl/qxl_display.c                |  4 ++
 drivers/gpu/drm/rockchip/Kconfig                 |  3 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c  |  7 +-
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c | 11 +++
 drivers/gpu/drm/vboxvideo/vbox_mode.c            |  4 ++
 drivers/gpu/drm/virtio/virtgpu_plane.c           |  4 ++
 19 files changed, 145 insertions(+), 64 deletions(-)

--3xkcu43eemue6yqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqJd9gAKCRAnX84Zoj2+
doTKAX9M8i+ZyZFOPtMLBgbELSG2rIaEAmdtCE/krakwFppuut0Hqoyg4a8WnkXI
1qh5brYBgO4onsdHI70y/5RvZVnesb1kkhlCokyMk11buYl5AC0DNsAjIGNdqTfL
VjSGS/PzSA==
=P2bZ
-----END PGP SIGNATURE-----

--3xkcu43eemue6yqx--

