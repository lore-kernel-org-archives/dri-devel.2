Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D87606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nI0vOd4g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CC010F3EF;
	Tue,  3 Nov 2026 07:40:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52DDD10F3E9
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:40:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75A3260142;
 Tue,  3 Nov 2026 07:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDCD1F00A22;
 Tue,  3 Nov 2026 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793691621;
 bh=LFRizgghWpVbrpp1XA3xuLFnkzTMHAaRfeE9VfHacuc=;
 h=From:To:Cc:Subject:Date;
 b=nI0vOd4gAJ+jhDfLnY1EujaCDDLDfyuNmuCsLz9/WhO0gnpy5FX5A7qUSAWydeeWC
 1wdHNwBcde1khL+PeVpUUj9LmkOhQUoSmQC/ODJOVerXPurGhUWezH04sGbqLvJ+Jd
 vJtwB4tMt7B/5pNTb0OsbnqMUCOwfAZWTrDDMxHbHKshXuT8LYjEj72tX96QcQN18h
 eNUbgknYaWNM5ZPhoN+gKZagc7CVTjTfhcU0c2Eq75mbXrdA8RXa4bz/qaNWs8kczn
 EshNvzle6w26cz3eCEMCF6sbozsAnuF//hRbZqVnZacAtTHwXiSe+rYoVD+LH1gzWo
 m82zOUAxTRJpQ==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCHv2 00/13] media/drm: cec: add EDID_PRESENT
Date: Tue,  3 Nov 2026 08:31:51 +0100
Message-ID: <cover.1793691124.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Using the media CEC framework the application receives events when the
Physical and/or Logical Addresses change. However, if the Physical Address
changes to f.f.f.f (Invalid), it does not know whether that is because the
HDMI link is disconnected, or because the EDID does not provide a valid
Physical Address. That can happen because the display does not support CEC,
as is the case for DisplayPort inputs or PC monitors.

This is important information to have but this is currently missing.

This series adds support for that.

Currently drivers set the physical address either with cec_s_phys_addr() or
with cec_phys_addr_invalidate(), where the second is just a helper
function that calls cec_s_phys_addr with CEC_PHYS_ADDR_INVALID. There
are also cec_notifier_ counterparts.

Change the behavior so that cec_s_phys_addr() is called whenever there
is an EDID. In that case CEC_PHYS_ADDR_INVALID means that the EDID is
present but does not contain a valid PA. And cec_phys_addr_invalidate()
is only called when the video link is disconnected.

Most CEC drivers already did that, except for the few that are fixed in the
first 6 patches.

The remaining patches implement the new functionality where the CEC
framework actually reports whether or not the EDID was present, based
on whether cec_s_phys_addr or cec_phys_addr_invalidate was called.

The drm patches can either be queued up in the drm subsystem independently
of the remaining patches, or I can take them through the media subsytem
as part of the series, but then I need an Acked/Reviewed-by.

Regards,

	Hans

Changes in v2 (based on sashiko reviews):

- missed one incorrect cec_notifier_set_phys_addr call in sti_hdmi.c
- cec_notifier_cec_adap_register didn't call cec_phys_addr_invalidate
  if an earlier cec_notifier_phys_addr_invalidate call indicated that
  there is no EDID.
- sending the initial state change event didn't set the
  CEC_EVENT_FL_STATE_EDID_PRESENT flag if needed.

Hans Verkuil (13):
  gpu: drm: sti: call cec_notifier_phys_addr_invalidate if no EDID
  gpu: drm: exynos: call cec_notifier_phys_addr_invalidate if no EDID
  gpu: drm: omapdrm: call cec_s_phys_addr only if EDID is present
  media: i2c: adv7511-v4l2: call cec_s_phys_addr only if EDID is present
  media: cec: extron-da-hd-4k-plus: call cec_s_phys_addr only if EDID is
    present
  media: cec: core: improve cec_notifier_phys_addr_invalidate
  media: uapi: cec.h: add
    CEC_CAP_HAS_EDID_PRESENT/CEC_LOG_ADDRS_FL_EDID_PRESENT
  Documentation: media: document EDID_PRESENT cap and flag.
  media: cec: core: add support for EDID_PRESENT
  media: uapi: cec.h: add CEC_EVENT_FL_STATE_EDID_PRESENT flag
  Documentation: media: cec-ioc-dqevent.rst: document STATE_EDID_PRESENT
    flag
  media: cec: core: implement CEC_EVENT_FL_STATE_EDID_PRESENT
  Documentation: media: document cec_phys_addr_invalidate

 Documentation/driver-api/media/cec-core.rst   | 10 +++-
 .../media/cec/cec-ioc-adap-g-caps.rst         | 10 ++++
 .../media/cec/cec-ioc-adap-g-log-addrs.rst    |  9 ++++
 .../media/cec/cec-ioc-dqevent.rst             | 10 ++++
 drivers/gpu/drm/exynos/exynos_hdmi.c          |  2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c           |  7 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c       |  5 ++
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.h       |  5 ++
 drivers/gpu/drm/sti/sti_hdmi.c                |  4 +-
 drivers/media/cec/core/cec-adap.c             | 51 ++++++++++++++++---
 drivers/media/cec/core/cec-api.c              | 13 +++--
 drivers/media/cec/core/cec-core.c             |  4 +-
 drivers/media/cec/core/cec-notifier.c         | 26 +++++++++-
 drivers/media/cec/core/cec-priv.h             |  3 +-
 .../extron-da-hd-4k-plus.c                    |  8 ++-
 drivers/media/i2c/adv7511-v4l2.c              |  2 +-
 include/media/cec-notifier.h                  | 33 +++++++-----
 include/media/cec.h                           | 27 +++++-----
 include/uapi/linux/cec.h                      | 29 ++++++-----
 19 files changed, 191 insertions(+), 67 deletions(-)

-- 
2.53.0

