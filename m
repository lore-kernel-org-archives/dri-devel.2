Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD15606A335
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOUavIkb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED37311260E;
	Thu, 26 Nov 2026 17:05:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBDA11260E;
 Thu, 26 Nov 2026 17:05:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D6DB60CC9;
 Thu, 26 Nov 2026 17:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96461F000C6;
 Thu, 26 Nov 2026 17:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795712744;
 bh=9APBW+dUs9GpdJy5y/xbzdZ0LWmjpaCtZZOTbtr7bAc=;
 h=From:To:Cc:Subject:Date;
 b=SOUavIkbPGn8sk8JueP/0P4u6P4LteQbEbD89wo7ljIXrwQ6baPnRY7jf36irw6dT
 gVSysa6Knk3cSSpWCQVoTJ4MtoafYY/LymXf3f3WwS9Co9Mivi0xDBW7Z/ANVytodG
 vi1mD3Zb29uafIqxVT9+Rxc22gNqZ4h+M963f/NCL9Zs4okfIxbLtJfHvvjkTO4p8s
 9k7ZcgfupsGErZKzCGAbHwSoXC5VuA0olTXHfYK1s7XUgMtlBU8foUjQimQ6e75rd9
 FoO/tdEE/GTlU3Ii8rJl7Q8eH7vaHH1XucVa8Sw3thVCPyBSa0cysfd3FF/cqW8ft/
 2E0muor1ZToZg==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: [PATCH 0/2] drm/msm: fbdev: Fix the framebuffer pin leak on destroy
Date: Thu, 26 Nov 2026 19:05:33 +0200
Message-ID: <20261126170535.361985-1-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The fbdev emulation pins the framebuffer buffer object in the KMS address
space on probe, but never unpins it, and the buffer object is freed while
still pinned, which triggers a pin_count warning on unbind of the MSM DRM
device, for instance on removal of a DSI panel driver module.

Vladimir Zapolskiy (2):
  drm/msm: fbdev: Unpin the framebuffer buffer object on destroy
  drm/msm: fbdev: Add the missing VMA reference of the framebuffer

 drivers/gpu/drm/msm/msm_fbdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.51.0

