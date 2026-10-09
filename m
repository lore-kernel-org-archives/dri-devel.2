Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DC8CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE98610FE3B;
	Fri,  9 Oct 2026 03:19:47 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE9010FE33;
 Fri,  9 Oct 2026 03:19:45 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515822t7f4751d9
X-QQ-Originating-IP: 7Pk+11nntTD5E8b/1b413pLXlghYhtX9yXW0rSJDyLc=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:16:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 559857501391731083
EX-QQ-RecipientCnt: 30
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH v2 00/20] drm/msm/dp: Add static HDR support for DP and eDP
Date: Fri, 09 Oct 2026 11:15:52 +0800
Message-Id: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOwW7DIBBEf8XiXCp2jYH41P+ocmAXqKnk2AEnS
 hXl34sTqbceR5p58+6ixpJjFWN3FyVec83LqQV86wRP/vQVZQ4tC1Ro1KFXcq6zDKucQgElg9M
 RAB32cBBtspaY8u2J+zy+cr3Qd+RtZ+yNKddtKT/PvyvsvX/QV5CNT5QcIWkk/ig+3Pw7L7M4P
 l7sEs+XZry9DsXqN56a79h51L3RNuKBDQaTErALiYjdEIwK1viBNA366fy30uA1kYGBrWMAGlo
 PtPPJWGeS8s6bnsHiviJfo2wuc97GzmLoEyenkHWTe/wCyUOxCFYBAAA=
X-Change-ID: 20260930-msm-dp-hdr10-d84e11282319
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7844; i=sophon@radxa.com;
 h=from:subject:message-id; bh=146l0DN3W/8cc56zI/r+4Ok/KX8Zd6nBks+pkZ7RVLg=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYpYwyB1U2DhxqtNLvw0eEyze1M6YvEVOpKrtcsXb5
 qoDqWrrOkpZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWwIF6cATCRpBsM/W44Jc5fLv/MPfvWI
 t7DaO27ilVNHJoV6xv+bt2LFsu9Mcxn+u03q9JH/ulz0mpPWqTczGtOPiDG86tGbWlmc+Kxw5aq
 TTAA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NRfl6k/eYe7AKfDcDCTDplaPW9bQEDrZMjX5Fj4FCNMrBW+MwnL+wTtJ
 XVzDGbDlKxH5JZHrkImMuu6exSAQEPytpReoc3FIyWttWP/i6KQWetwhi6wUGM198BhMyEs
 T3C5a6WIQPltBDpltYTmNqzRejYQJJvjZ2QBnIK1+kwaQkvCRNEe5ptCWSAAN/Gl2Fo+kLQ
 ad5Eev0mN6epo7h0GKHdx0NC5KUVmYtcsz0V+RSh1+UEUL+D9pvObNrTvlaL0ucIcrKA8GS
 b05sya230Vy2ELbvYrwZcyu/yrIN+a1uWxxUhUjOiLhXAkZYsxDnsb5VU/DPewCl+kRXf/h
 R6CQA4GA2YAdmDeCNLs8KBvVI4MoVOgW0Clbz6jx+enmQLwpt1pE3LSpvkhTJ0SWC2exIoh
 hTwmFoY3V0ZJnO7+HzmKulxXw0PgnWTUjK52ZOS/eDQp/OdOMaIxd6+jzF7GGhEroGdLkOI
 a1cEfBnS4qJrIIQaHwXsxgxn0KFt85J0Sy815RrMFRRYeax629/PwqKXT9batjM0X2F0mrt
 VA5//6bCvsN7z2KPYIdfW1c5fmhHfNpZp9GS1U9awflQOQSKKHty8m6cpJVAuojUbAcMW/N
 5kb/+HNpGIoJa8aMKdzfEJuDhGi01fHC8G50eFJW+tlU60fMCbYZ2Gw0P9Rh61BsDzrbWOD
 n9EkwG3ofoL30IjIN+pxl9V+eCy2rBKAbJE5mCeL7hr+a4ZbtwrFMLYdGPFxxshQGIs5qYh
 2ptr9+db1r5nrgWtCVqRHw0yGFudYpTZOtogLAYI6kjhemMP7dOnV5eBl1nPRJKpNu3jok5
 kDJ6Q7kx1+g8UPjJAf/sAyLH/7W5RbvdXU81XCCKpSxIx4p4XxrHPEVVqV9qy49cyRpTrlm
 j4ZY5Nidlrt/h8127nLimU6meKMXn7XHtRpYZAU0KohVE/1m8sdpVNIXg4BthyGn4tHf/q5
 IxkeFGBRrBz7A87I/ys/AaWD4R8fQIF+Ztu6vYIhWInNVDdvnQfVnYPGApfb1HsZFSOJEVE
 TCu8hQg8tr84Ge3BXtFDF1cdVArn6GCsxPtGK09g==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
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

This series adds standard KMS static HDR metadata and BT.2020 RGB
signalling to MSM DP and eDP, with HDR10 as the intended use case. It uses
HDR_OUTPUT_METADATA, Colorspace and max bpc. Userspace supplies the HDR
pixel content; DSC, dynamic HDR and tone mapping are outside this series.

Patches 1-3 allow max bpc registration before connector state allocation,
restore the attached property default, remove the early state allocation
workarounds and register max bpc centrally for non-HDMI bridge connectors.

Patch 4 makes the SDP header packing input const. Patch 5 prepares generic
SDP slots. The HPD state serialization and debugfs connector pointer fixes
are already in linux-next and are not included in this revision. On the
current v7.3-rc5 base, both fixes are applied as prerequisites.

Patches 6-9 move runtime PM calls outside the connection lock, serialize
stream operations with HPD, establish PHY power ownership and add stream
enable rollback, including AUX recovery for a connected external peer.
New error returns are introduced together with their cleanup paths.

Patches 10-12 add deferred link-status notification, persistent eDP link
capability caching and stream reconstruction for modesets leaving eDP self
refresh.
Patch 13 adds atomic output depth selection. Patches 14-17 clear stale MSA
colorimetry, flush VSC removal, exclude YUV420 streams from PSR and move
VSC packets into bridge atomic state. Patch 18 adds BT.2020 RGB signalling.

Patch 19 serializes SDR video-test state changes with mode programming.
Patch 20 adds complete static HDR support: metadata validation and packing,
10 bpc enforcement, Generic2 programming and teardown, stream restoration,
PSR exclusion and arbitration with video-pattern tests. A test request
arriving after atomic check cannot replace the checked HDR output depth.

This series is tested on a Lenovo Yoga Slim 7x using x1e80100.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Changes in v2:
- Drop the HPD state serialization and debugfs connector pointer fixes,
  which are already in linux-next.
- Restore max bpc from the property default and remove early connector
  state allocation workarounds, with regression coverage. (Maxime)
- Register non-HDMI max bpc in the bridge connector helper and advertise
  the MSM DP/eDP limit through bridge->max_bpc. (Dmitry)
- Split the const SDP header change into a separate patch. (Dmitry)
- Serialize stream operations and rollback with HPD before tracking PHY
  ownership; keep runtime PM calls outside the connection lock. (Sashiko)
- Clear the sink training pattern before returning a retraining error. (Sashiko)
- Use the link-status property helper and move TODO removal into the
  failure notification patch. (Dmitry)
- Cache eDP link capabilities after the first successful discovery and
  retain them across power transitions. (Dmitry)
- Discover eDP bandwidth limits before atomic check and reject unknown
  limits instead of deferring validation to enable. (Sashiko)
- Keep the checked depth during training fallback and only accept links
  that can carry the unchanged stream. (Dmitry)
- Derive PSR eligibility from the checked VSC state, including YUV420
  modes with default colorimetry. (Sashiko)
- Program the checked VSC packet unchanged for normal streams; rebuild
  it only for video compliance tests. (Dmitry)
- Split MSA cleanup, VSC updates, PSR exclusion and atomic VSC state
  from BT.2020 RGB support. (Dmitry)
- Validate HDR controller support during atomic check. (Sashiko)
- Pass checked VSC/HDR state through stream programming instead of
  copying the configuration into the panel. (Dmitry)
- Link to v1: https://patch.msgid.link/20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org

---
Xilin Wu (20):
      drm/atomic: Handle max bpc properties before connector state allocation
      drm/connector: Drop early state allocation for max bpc registration
      drm/bridge-connector: Attach max bpc for non-HDMI bridges
      drm/msm/dp: Accept a const SDP header when packing
      drm/msm/dp: Support multiple generic SDP slots
      drm/msm/dp: Keep runtime PM calls outside the connection lock
      drm/msm/dp: Serialize stream operations with HPD processing
      drm/msm/dp: Track PHY power ownership
      drm/msm/dp: Unwind resources when enabling a stream fails
      drm/msm/dp: Report stream enable failures through link status
      drm/msm/dp: Cache eDP link capabilities after successful discovery
      drm/msm/dp: Rebuild the eDP stream on modesets leaving self refresh
      drm/msm/dp: Track output bit depth in bridge atomic state
      drm/msm/dp: Clear stale MSA colorimetry bits
      drm/msm/dp: Flush VSC updates when leaving YUV420
      drm/msm/dp: Disable PSR for YUV420 streams
      drm/msm/dp: Track VSC packets in bridge atomic state
      drm/msm/dp: Signal BT.2020 RGB on DP and eDP
      drm/msm/dp: Serialize video test state changes
      drm/msm/dp: Add static HDR metadata support for DP and eDP

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c      |   6 -
 drivers/gpu/drm/display/drm_bridge_connector.c |  18 +
 drivers/gpu/drm/drm_atomic_state_helper.c      |   8 +
 drivers/gpu/drm/drm_connector.c                |  22 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c     |   6 -
 drivers/gpu/drm/msm/Kconfig                    |   1 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c               | 263 ++++++++++----
 drivers/gpu/drm/msm/dp/dp_ctrl.h               |   9 +-
 drivers/gpu/drm/msm/dp/dp_debug.c              |  27 +-
 drivers/gpu/drm/msm/dp/dp_debug.h              |   8 +-
 drivers/gpu/drm/msm/dp/dp_display.c            | 483 +++++++++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_display.h            |   8 +-
 drivers/gpu/drm/msm/dp/dp_drm.c                | 133 ++++++-
 drivers/gpu/drm/msm/dp/dp_drm.h                |  14 +
 drivers/gpu/drm/msm/dp/dp_panel.c              | 176 +++++----
 drivers/gpu/drm/msm/dp/dp_panel.h              |   9 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                |   4 +
 drivers/gpu/drm/msm/dp/dp_utils.c              | 134 ++++++-
 drivers/gpu/drm/msm/dp/dp_utils.h              |  23 +-
 drivers/gpu/drm/tests/drm_connector_test.c     |  62 ++++
 include/drm/drm_bridge.h                       |  11 +-
 21 files changed, 1128 insertions(+), 297 deletions(-)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260930-msm-dp-hdr10-d84e11282319
prerequisite-patch-id: a243647e29c62d6ff1c8dfbbc85d60d76a5b4b54
prerequisite-patch-id: 41a4bb615c78c11b576a148af6786f0a8a63c172

Best regards,
--  
Xilin Wu <sophon@radxa.com>

