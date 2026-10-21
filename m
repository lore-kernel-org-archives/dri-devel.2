Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592CD606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=q9j61bVH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F27510E235;
	Wed, 21 Oct 2026 14:56:08 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF7E10E10E
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=L2jkLKX29D9HTlBME3XwjX2JkpE1vgCtp8KhdQ6X/CM=; b=q9j61bVHluqfr9GsaMeAiRquz5
 B/uDy8RFi+daIYj1sZlqYtJXOv/DF+5bgmicRBIuAE+nOSt5o+ZMneLbK1HBl8zAiCQQ2aFFaKPC4
 qpWJksQA2uIfol0QVhpeSntLLra6YxL0FsYvuRwKr1gvHiVWUpzfIj6orMHv1XRmsUxsiQt3n5pnw
 MpfrdZevHyr3T57Eq5hcwhCveg8w3CR7F6Y4CHdLT0ferUn/H5n/7tHGZ9VeW384yPFzleB2tJL2Y
 eptCPobnM+OLUDvHhss1zr5g9LNtFaCvsK6p3QKzWXSuZptdAzyvge2ZWTF/uLQhenmpkz/IVCfxl
 MBfyLvWQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJXjT-005jXv-Em; Wed, 21 Oct 2026 16:55:59 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/3] drm/v3d: Add TFU constant colour support for V3D 7.x
Date: Wed, 21 Oct 2026 11:55:29 -0300
Message-Id: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0NT3TLjFN2StFLd5OT8HF1DixRLM2Mjc1PDpBQloJaCotS0zAqwcdG
 xtbUAgFYdx14AAAA=
X-Change-ID: 20261015-v3d-tfu-ccol-18d9632751bd
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=YsKEy/ISPeUBI/tWqW8xXCkXZsvhGF7O6SpErdAVZAc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq2NJlN+s0PWHsCsJhGOkkjTacvigj5DHAWv5Fz
 9orfOr41IiJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCatjSZQAKCRA/8w6Kdoj6
 qtXJB/9oU0i/A5EivrngrCKPkNV1YT/OJnn9vk9Mwhm2TQdKyrGGoXvKKWAU0Fc1jMKP2kJHCOV
 eTyiKg1c2MGgZULxK7POqAS4o82WowSV0jwbJCJCS1gTKww9ozjPwm6akz/48rC60TEbU0P4Qts
 vMpy0J57xKu9DwSRaFGQ5p6Pj7rzSHSitRO9LcLnZCnYuc2AKB9Dm/p3wns7B0e+WOkd2xn+RFJ
 l0DZzV3d8SeLCP45qXS+/ljnCVU5P9bOxCY51mIqyQ/YVHdmmgIam453m6l+oV5Fc/fyyAxG48e
 ioix2FYP2nkx6eZgg5uTzM9YEOqIxGVauB/DnzWJPhsLPTBS
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The V3D 7.x TFU can fill its output with a constant colour, which lets
userspace offload buffer fills to the TFU. However, so far, the kernel
didn't expose this hardware capability.

Expand the UAPI to obtain constant colour data from the userspace and
configure the CCOL0-3 registers.

The series contains three patches: 

  1. Patch 1 implements validation of the v71 fields of the TFU submit
     ioctl.

  2. Patch 2 only writes the TFU coefficient registers on V3D 7.x when
     ICFG.YVCS_RGBP selects user-provided coefficients. This avoids
     writing to COEF0-3 when it's not needed.

  3. Patch 3 adds the CCOL0-3 registers and ccol[4] to drm_v3d_submit_tfu.
     It also adds DRM_V3D_PARAM_SUPPORTS_TFU_CCOL for userspace to detect
     support.

The Mesa counterpart of this feature is available in [1].

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/45487

Best regards,
- Maíra

---
Maíra Canal (3):
      drm/v3d: Validate the v71 fields of the TFU submit ioctl
      drm/v3d: Only program TFU coefficients when used on V3D 7.x
      drm/v3d: Add TFU constant colour support for V3D 7.x

 drivers/gpu/drm/v3d/v3d_drv.c    |  3 +++
 drivers/gpu/drm/v3d/v3d_regs.h   | 19 ++++++++++++++++++-
 drivers/gpu/drm/v3d/v3d_sched.c  | 30 +++++++++++++++++++++++-------
 drivers/gpu/drm/v3d/v3d_submit.c |  9 +++++++++
 include/uapi/drm/v3d_drm.h       |  5 +++++
 5 files changed, 58 insertions(+), 8 deletions(-)
---
base-commit: b3de601e57d983e4a42e27d499516041c11c2bde
change-id: 20261015-v3d-tfu-ccol-18d9632751bd

