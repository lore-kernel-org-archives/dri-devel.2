Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93796CA5FBE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C282010F3A7;
	Wed, 30 Sep 2026 12:44:36 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D1010F385;
 Wed, 30 Sep 2026 12:44:31 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772137t8b4fd8d6
X-QQ-Originating-IP: fnE+b+i/ohPAIiUkRgiQdMNu/77rhCqcRG5r0WQ/Qj4=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14742789130746556607
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH 00/13] drm/msm/dp: Add static HDR support for DP and eDP
Date: Wed, 30 Sep 2026 20:41:44 +0800
Message-Id: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS2MD3dziXN2UAt2MlCJDA90UC5NUQ0MjCyNjQ0sloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAaLeMbnAAAAA=
X-Change-ID: 20260930-msm-dp-hdr10-d84e11282319
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3484; i=sophon@radxa.com;
 h=from:subject:message-id; bh=B+91dZfpNQgBpc8obPUqZz2vS/XeV4198Uu6VYr4rlc=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mRfkqJ/eZdqRefLh82MztReE/mYXUzWK5RDcsTH47
 e+8p5zBHaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACaywYXhfz6bxykmu/V6mtd1
 3K5ODLD/abbl9rN85W3iKX0OG0w2FjP803A6JZUpe3U102+rH7NkqrasrW7wyjbeYVqd1Z965Cs
 HEwA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NbLMjDNEDlGtKmPY65M7t3Fl4jh27QtstDR8Qyi888qhGuC+jxatiSGy
 hO56JMIn4Horakfl8sAmJBb2zb/KPNTFUTYDP2o44vVCI+KoVkTS4YkwP64Pkg6jsQfpEL6
 xNxiQdSSz7BOkPbw1Lk5Tmb2tRkq7e5PlsDnu87vqTKYXEe7wCVjKoFyrtMU8ST+tcvlpdS
 WuS2Z12uB6qQV6vsmUtKPKcemlovbuEzhcE7PQQjo10SgLTgoU9wBWKqwY62GY9LAcur+Az
 njplyfy5w8RHuQFmq91kY4rLSqNSGv3jSwRKFGn8p1Eg1/wgGnp/BOSYd2EJg11aww1DQ7I
 KE/cpv1MYeqiBxnbzcHm2O1FJwqMEy3yZkO7TWW0H7JtZ/7QZll+HrWku52reSaKpL4h9ku
 okE4qUJ5DFSrBdlgM1ZcmBVmg/+FlK7FmsG9DKD5WWkQjn7HG2KWYLLymnW4lbDCiFS+CFL
 7O88xOCLWvAI74M3aMAhkVuzQcZSlXms4vcSt6REMI/SAleUC2E1kEf5hG1xSTQM0bKs431
 0aTJr9p2hcAPyNZat4BiBZlyjErKCijXpWa8OwicI8tUsdIvzoeCZtrfZxQJLw/9VcEzTa7
 b+LYZbFLkiE8RkaeoqvRNSKP9ZoWGDdYHHY7zEAODGPhehk1Rh6byBCENuy5TEWEdlsLTeS
 Pa3YibXkKJnVyO/0T/bVzPlTKbkYe7nVGkD2RR924I1KseZiDR2iQfbk5WcZISw7A4IZkLb
 zw7NaKaQ590n++e9oheksnRoziu2y28MihCtKg0f18SmDn/kQJXFWjWMmFQW7Lh1J8q2DGb
 gCneyehx0CNN6ebSSbX5i0E5LsdWX7StnWbDEtFMGcQhJAz7/Zua4Z/E2uN/Yn3JaD/b9EO
 2X5fvFg8GD7oZTfYBFSsUgHSa+vBDemm1RZv8dLj6cVMx9dT0neccvba2ELJiAAbqgooIze
 eRYaZksFc21nXnPRjXNWiWYFqfqpu1Ko+MQ9HSgJ3+zMuGWr8PxZFlFS27NZ27cscsoCWBg
 j1dWHyS4mH+qjEL4cUgKVQkXxK4i8=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

Patch 1 allows max bpc registration before connector state allocation and
initializes the corresponding state defaults. Patch 2 prepares generic
SDP slots. Patches 3-5 establish PHY power ownership, serialize HPD state
updates and add complete stream enable rollback, including AUX recovery
for a connected external peer. New error returns are introduced together
with their cleanup paths.

Patches 6-8 add deferred link-status notification, capability cache
validity and stream reconstruction for modesets leaving eDP self refresh.
Patches 9-10 add atomic output depth selection and BT.2020 RGB signalling.
The BT.2020 patch includes its own PSR disable/restore handling.

Patch 11 independently fixes the uninitialized debugfs connector pointer.
Patch 12 serializes SDR video-test state changes with mode programming.
Patch 13 adds complete static HDR support: metadata validation and packing,
10 bpc enforcement, Generic2 programming and teardown, stream restoration,
PSR exclusion and arbitration with video-pattern tests. A test request
arriving after atomic check cannot replace the checked HDR output depth.

This series is tested on a Lenovo Yoga Slim 7x using x1e80100.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Xilin Wu (13):
      drm/atomic: Handle max bpc properties before connector state allocation
      drm/msm/dp: Support multiple generic SDP slots
      drm/msm/dp: Track PHY power ownership
      drm/msm/dp: Serialize HPD state updates
      drm/msm/dp: Unwind resources when enabling a stream fails
      drm/msm/dp: Report stream enable failures through link status
      drm/msm/dp: Track validity of cached sink link capabilities
      drm/msm/dp: Rebuild the eDP stream on modesets leaving self refresh
      drm/msm/dp: Track output bit depth in bridge atomic state
      drm/msm/dp: Signal BT.2020 RGB on DP and eDP
      drm/msm/dp: Initialize the debugfs connector pointer
      drm/msm/dp: Serialize video test state changes
      drm/msm/dp: Add static HDR metadata support for DP and eDP

 drivers/gpu/drm/drm_atomic_state_helper.c |   5 +
 drivers/gpu/drm/drm_connector.c           |   6 +-
 drivers/gpu/drm/msm/Kconfig               |   1 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c          | 127 +++++++++---
 drivers/gpu/drm/msm/dp/dp_ctrl.h          |   4 +-
 drivers/gpu/drm/msm/dp/dp_debug.c         |  26 +--
 drivers/gpu/drm/msm/dp/dp_debug.h         |   8 +-
 drivers/gpu/drm/msm/dp/dp_display.c       | 319 ++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_display.h       |   8 +-
 drivers/gpu/drm/msm/dp/dp_drm.c           | 118 ++++++++++-
 drivers/gpu/drm/msm/dp/dp_drm.h           |  12 ++
 drivers/gpu/drm/msm/dp/dp_panel.c         | 103 +++++-----
 drivers/gpu/drm/msm/dp/dp_panel.h         |   8 +
 drivers/gpu/drm/msm/dp/dp_reg.h           |   4 +
 drivers/gpu/drm/msm/dp/dp_utils.c         | 121 +++++++++++-
 drivers/gpu/drm/msm/dp/dp_utils.h         |  21 +-
 16 files changed, 738 insertions(+), 153 deletions(-)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260930-msm-dp-hdr10-d84e11282319

Best regards,
--  
Xilin Wu <sophon@radxa.com>

