Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED6606A330
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sScwjyR9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A9510E12C;
	Sun,  8 Nov 2026 05:16:49 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF51810E12C
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:16:42 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36a315ed211so236086eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 21:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794115002; x=1794719802; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gT62dXId+eAb8ukDUrV+GLnTEFym+aAlD/IHLPxFdUE=;
 b=sScwjyR9ZwgIge6v/QaMsz9QbmDA22B4uH4+9Cfz9lpaVO0T7OEeogn/EDDutUdPNk
 a5iusj4AH1V8co/cdYVVidsNu8BuowcOaLkKEXJmROl2bkmdyql/3aqXd9Xde5sFx0Jx
 ntVZ5PSRnOmGWCKiQG/oqTrhRsWswgAVv+T5VTLl+ASbXti9n1W6fAd/eposPhAs1JpW
 gBxacjYJzXsPrLZI5AT4d+khtktQjXomdorBA54cQgLTQKR7Hpo0cXURIwm+URqJobz6
 9aMPx483Swhi/3u+LKuxEiIw5/FXlOiFlvplFffgnrbcFQmD3bTkBmcWBFoKWCm2lBTu
 zN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794115002; x=1794719802;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gT62dXId+eAb8ukDUrV+GLnTEFym+aAlD/IHLPxFdUE=;
 b=WxAgxX5lpNMh/tC7zHaoUWaqb8z70mxiD/vVobjanUdIzAFpIVzQ3jvmyJy8ltjMV9
 dBW/oWS7Vo9oyiNeZVRsP3b84mHWnJ9nyWHAR8PKsxD/nUMau5tzr8t/UYe5hVo74m1L
 RwfMXz0RiJqvJtcZilX68Yw3MNZaHc25RVWnWBpwPk6GEUw9N1LXVeUkjel2JqQH3Uyl
 Q14x7A5zOLzDlTJtJCGIpiskfCy1HLDo+AREQVXsvq4SSeIyRvhg6ll8DqAaYkSM5zMR
 D551Wt68ePjYZgrc2gEsRDcbdJ5pBEemkzWWyIR5XiLIH0fDquaO/cabTeR1sOeeLSLV
 qcRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByVDaGq0vfeNMaTDgBBsCdTmNlaJVfVKWOY7GMcxYPWaKC6VCnweJAuWMWdFgbxHpJLU/VV3rtlCME=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+iQvXYcanhzRt3IdDuccPLtf47t6VLJrvngeS8Jz0h88SNWll8
 DJWf68wBJ9pdIjK0JL6Sbll1M3j8f/vgZjVGQHiDzmFJTFKqwFGACe6q
X-Gm-Gg: AYBFou0U/2orrHwU66LzhWS3p2kfK0zrbyCS7sO54RRYsKIVquqDGNVlZudvLjy2ye4
 MAquuJKFUbh5txVOJZW4cDp0X4zFEOqd+STknQEJYJkjbd6fKAlEj3pfd2CYKjYScDRSAdHd+o4
 blKbt40AHqP2E3UA8WIyn1gRnxB3C3XJDMO/G76P8SCB9T3aOvn91Mr+Zrcp89It1gX62jbieUP
 XFtajrqir7j7m6S4Lv/kwftNIrpy4wFKnUNwroRSlNwOSFaGc5op9i0mxMVuYmW6E0ZIw57nxlW
 IdU/R8GZ8vZFhw5HtQNGuRt8DpOAxjqt9aVMD6NV1gwWbJXVRUYfC+Qy1dP8xCXtMLBX2UAedGr
 IcYxKqtCgomfy66rRyqKM3xRQbrGhygqlOHj/jlyY44NAK0Wd22dIw4Cu6vwg/pg1EUGiJWzvi/
 /OOGIcAd1DUENMenCsj1NbCUPYipbP+GWWraCh9N4qnx7T8PFT9RhcnGSzcNAJWrrVPREJV+Qxw
 N0maUQuMHany2qKPvhB71MCP/mnsrgnGKZws07J0uSdBO1KEhygTLKvX+gDc+c+Qg8XpYUV/hX4
 oDp7Sl86YG4SkEWll+lcORg6Yw==
X-Received: by 2002:a05:693c:8819:20b0:36c:dbfc:ee6f with SMTP id
 5a478bee46e88-370f6ec412cmr5291748eec.14.1794115001952; 
 Sat, 07 Nov 2026 21:16:41 -0800 (PST)
Received: from [127.0.1.1] ([121.125.115.175])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372667d60absm2750989eec.26.2026.11.07.21.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 21:16:41 -0800 (PST)
From: Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH v2 0/6] drm/imagination: Add async VM_BIND with sparse mappings
Date: Sun, 08 Nov 2026 14:16:22 +0900
Message-Id: <20261108-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKgF8GoC/22QzU5DIRBGX6VhLYbhAheaxvgeposBhpbk/gntj
 abpu0uvGjcuz2JOzjc3Vqlkqmy/u7FCa655nhrIpx0LZ5xOxHNszKSQRljo+bIWvo7c5ylyCKS
 ScAh9r1i7WAql/LHZ3o6NPVbivuAUzpsjCNkRhdQpFY2K2AdrhfYGlZagQ0gyUhL6R1Xo/dp6L
 t8+NlKtuPXsd4dHDgjQW851GnHhOAx8mOeFr8CBaxVMb6ICadzracQ8PId5fGG/VQ3GfGlDo0b
 bQRddSM46b5PuUBvr0BmyDnxyLnkZ2GPPOdfLXD63Z62wVf37l1YguECRJHjqY2f/Ctjxfr9/A
 Wnul1h2AQAA
X-Change-ID: 20260817-pvr-vm-bind-1ce4f09a1774
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>, 
 Matt Coster <opensource@mtcoster.net>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
 Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Userspace MR:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43794

This series is for Vulkan sparse binding.

- Patches 1-2 switch the GPUVM to immediate mode.
- Patch 3 moves the existing map and unmap paths onto a single bind
  entry point.
- Patch 4 adds the VM_BIND ioctl.
- Patch 5 adds asynchronous requests.
- Patch 6 adds sparse mappings.

Patches 1-2 were sent separately [1]. They conflict with drm-misc-next,
so they are rebased and included here.

Testing:
Tested on BeagleY-AI.
- The existing IGT pvr_vm_map passes without regressions.
- dEQP-VK.sparse_resources passes for the sparse features the Mesa MR
  above exposes.

[1] https://lore.kernel.org/r/20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Changes in v2:
- New patch 3, "Route map and unmap through pvr_vm_bind()".
- Split v1 3/4 into the ioctl (4) and the asynchronous mode (5).
- Bump the driver interface version to 1.2, as 1.1 is already taken by
  another patch.
- Link to v1: https://lore.kernel.org/r/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com

---
Gyeyoung Baek (6):
      drm/imagination: Switch the GPUVM to immediate mode
      drm/imagination: Stop locking reservations around map and unmap
      drm/imagination: Route map and unmap through pvr_vm_bind()
      drm/imagination: Add VM_BIND ioctl
      drm/imagination: Add asynchronous VM_BIND
      drm/imagination: Add MAP_SPARSE to VM_BIND

 Documentation/gpu/imagination/uapi.rst     |  15 +
 drivers/gpu/drm/imagination/pvr_device.h   |  10 +
 drivers/gpu/drm/imagination/pvr_drv.c      | 331 ++++++++++++
 drivers/gpu/drm/imagination/pvr_drv.h      |   4 +-
 drivers/gpu/drm/imagination/pvr_fw_meta.c  |   6 +-
 drivers/gpu/drm/imagination/pvr_fw_riscv.c |   6 +-
 drivers/gpu/drm/imagination/pvr_job.c      |   6 +
 drivers/gpu/drm/imagination/pvr_mmu.c      |   2 +-
 drivers/gpu/drm/imagination/pvr_mmu.h      |   1 +
 drivers/gpu/drm/imagination/pvr_queue.c    |   3 +
 drivers/gpu/drm/imagination/pvr_sync.c     | 146 +++++-
 drivers/gpu/drm/imagination/pvr_sync.h     |  13 +
 drivers/gpu/drm/imagination/pvr_vm.c       | 781 ++++++++++++++++++++++-------
 drivers/gpu/drm/imagination/pvr_vm.h       |  63 ++-
 include/uapi/drm/pvr_drm.h                 | 129 +++++
 15 files changed, 1303 insertions(+), 213 deletions(-)
---
base-commit: 2d5a8313d9cf989b8f53a5689a96e891bf99fb2c
change-id: 20260817-pvr-vm-bind-1ce4f09a1774
prerequisite-message-id: <20261015-pvr-unmap-all-loop-v1-1-54c676d41269@gmail.com>
prerequisite-patch-id: 5188d944e90112e4cf2678e75255c7a91434ad09

Best regards,
--  
Gyeyoung Baek <gye976@gmail.com>

