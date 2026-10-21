Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96D606A329
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XYgbU6hD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F9A10F8E4;
	Wed, 21 Oct 2026 05:16:29 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EAD10E08B;
 Wed, 21 Oct 2026 05:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792559782;
 bh=vH/deR0JSzYFm4T2YD9XaVz6Lo2iuDgXVRLekxxaOkA=;
 h=From:To:Cc:Subject:Date:From;
 b=XYgbU6hD6to6lDq8iRczJ+b0yYEjo6AU1UrzXFAOH3Lh7pDKfbHFxGNFZgtQ6yC0X
 WJDYoXShjE7N/RBzMRh8PlL/QtvbtV0CxMpeKcYhJ4lHk88eX5zsMM2Awtled27+wR
 QRvhYfPW/vl1AB/UyWKrJGZEsdNF52wmU7j7M4PS8TptsElIuS8xZFV3kD9a9hUFSH
 IP3BSaQbG8mv2cSXJ6B4mR1Dkc/5MHo5HkinjQMxeCNSlJjVJ1dejYr7npya3aNUkq
 94bL6vvRTWSndCN4Hb4S7vkKzR6ajSIfSXoVO6uOmtCalv0FBNfeECmQ8o9souQr1i
 5e5ED474ORkAQ==
Received: from vignesh-thinkpad.. (unknown [100.64.0.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C0E0717E05F3;
 Wed, 21 Oct 2026 07:16:19 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.fornazier@gmail.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] drm/ci: add wormdingler-rev1-boe
Date: Wed, 21 Oct 2026 10:46:05 +0530
Message-ID: <20261021051611.3328351-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series updates CI coverage for trogdor-based sc7180 devices by,

- Share skips between sc7180 trogdor devices
- Update xfails for sc7180 trogdor devices
- Adding a new sc7180-trogdor-wormdingler-rev1-boe job.

MR: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/252
Pipeline: https://gitlab.freedesktop.org/vigneshraman/msm/-/pipelines/1771349

Vignesh Raman (3):
  drm/ci: share skips between sc7180 trogdor devices
  drm/ci: update xfails for sc7180 trogdor devices
  drm/ci: add sc7180-trogdor-wormdingler-rev1-boe

 drivers/gpu/drm/ci/arm64.config               |  4 ++++
 drivers/gpu/drm/ci/build.sh                   |  1 +
 drivers/gpu/drm/ci/igt_runner.sh              |  6 +++--
 drivers/gpu/drm/ci/test.yml                   | 13 +++++++++++
 ...goftown-skips.txt => msm-sc7180-skips.txt} | 12 ----------
 .../msm-sc7180-trogdor-kingoftown-fails.txt   |  2 ++
 ...180-trogdor-wormdingler-rev1-boe-fails.txt | 23 +++++++++++++++++++
 7 files changed, 47 insertions(+), 14 deletions(-)
 rename drivers/gpu/drm/ci/xfails/{msm-sc7180-trogdor-kingoftown-skips.txt => msm-sc7180-skips.txt} (72%)
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt

-- 
2.47.3

