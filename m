Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B597CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6C010FE2E;
	Fri,  9 Oct 2026 03:18:21 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BD410FE2A;
 Fri,  9 Oct 2026 03:18:20 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515838t472c8b42
X-QQ-Originating-IP: MKR7kzW7HAK+NrS0wgFqsGbBRp/tfPe9KB5QgOo6rjo=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16529762743812786716
EX-QQ-RecipientCnt: 30
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:15:56 +0800
Subject: [PATCH v2 04/20] drm/msm/dp: Accept a const SDP header when
 packing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-4-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=sophon@radxa.com;
 h=from:subject:message-id; bh=w0FWwQh+BArzLEg40xbIVHgfENw/S8iO3UHo5I+Bfm4=;
 b=kA0DAAoWMsMVZ62eMk4ByyZiAGrIXKijETSs3rt6JIAJ8bXCJKivjITsO1dXNj8lydUN4XW4T
 Yh1BAAWCgAdFiEEIF8AnQd5bdblFnUuMsMVZ62eMk4FAmrIXKgACgkQMsMVZ62eMk5+NQEAnfcl
 sZ3qoQ57XjQN4azidHE4kJrQ/Mmm0rbt37WuTOAA/jg8pZJgWaNaE/wWRj5tblS+RXKhQ34hIsp
 H125BnrYA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NafziRg7Bx69Tosy8Qw5AZhRSV5l2WXXBXBd468c3xzmREkMNaILwNy1
 8Lbj+JE0lSp3yGFXXbeWO29CHmJRgRPOgmpXrk1MLWONEZATED3wkM/+hLcg3p/IHH9ekO+
 TNH9DOZQjJyZhtLuzJVx9zROLVZbWyJEgIXWYvkStFnKK5e4klf8yY/Ft0tsaqzTi7nQj0K
 /gleuYSPhTjtX547IoUo5QPXA8P5eMOsxOE1Ly+qbWGVp3Jxh9c2RjzWUAqVwFhI7gYJoTp
 zFHawiasLXplVEiThSqrfSkiFGNujY6Vm/tTsQqM8MAlV4yiib5UuPe4Fob+A0G3xoYYWPa
 el8JH5vNvejk4mjrQbiH1wW2zdLYJQz6cQJRlwLlGmHvi/di4tFrIsJOzjo00IS1O+J44Xn
 VzTamTH2/Gi9wflCY9lkHHgYyJdP7tVvuys3j5TTyGR+i4Y0mXejcBwq7fD8pWNXDxl5Ygd
 4rZ84ufD5GudJ9/UCQlIwYJ3K9myZI9V3XTUxvefo+acZ7V5MM0y/fqGM9uHjU0NdAyGL1K
 6yOy9O9RTZP178Zp7+SWLk0yVTG/urVbShohmvaBrMuGtpnoT6+iUroPF1PCbSzNqYTJWYj
 5MvzXpMgR24x6pFqGPy5IAlaXIdT37haAMhO1Kr1HlWaoOOMOtuvZsJfdX32YZwWIwj2i75
 PPySImsXRkHmSWmBwP6sz5B0QRDIZphnGQBhMF2SXMJmR9PqjlJ2BSKO4caFAz2hPaOPCtl
 rtQs8Fyt3Ky2naz1u2B9JAcRwhhsS1VOMaC0D6UqQpJ0qp+F5VdE+ka/IBiCN11wU3jPrz9
 HRKO/Br8iIJWAX3AfrJDZtnP5R02iW9fUiYWY+JC4Qu0kTHrlW9qAQHOTek/1h0xDCp2iCU
 +2cBPB1WBzgDDLMEQq7mfeZwoYGu6sAyssJhZZtq+GfQkSdh5WqGe3Sue1e9pXqQXNdnyq6
 vIHQgfAM86/MucGyftILuiGU1leoxMGezFyKJRhADDTVY1oV0xjtaE1t/M3yoX33MO/nvRY
 rL6IxlsTblSYeZAhJ2Fi6blg8C8+fisC4VaGSb0dhCNZ2ydxFZvqMfcU2Vr2g=
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

The SDP header packing helper only reads the header. Mark its input const
so callers can pack headers from read-only SDP packets without discarding
the qualifier. This prepares for the generic SDP writer accepting const
packets without changing the packed header bytes.

Assisted-by: LLM
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_utils.c | 3 ++-
 drivers/gpu/drm/msm/dp/dp_utils.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/dp_utils.c
index 4a5ebb0c33b8..226b370ce8fe 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.c
+++ b/drivers/gpu/drm/msm/dp/dp_utils.c
@@ -74,7 +74,8 @@ u8 msm_dp_utils_calculate_parity(u32 data)
 	return parity_byte;
 }
 
-void msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 header_buff[2])
+void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
+				  u32 header_buff[2])
 {
 	header_buff[0] = FIELD_PREP(HEADER_0_MASK, sdp_header->HB0) |
 		FIELD_PREP(PARITY_0_MASK, msm_dp_utils_calculate_parity(sdp_header->HB0)) |
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.h b/drivers/gpu/drm/msm/dp/dp_utils.h
index 2e4f98a863c4..2fdb89efc57c 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.h
+++ b/drivers/gpu/drm/msm/dp/dp_utils.h
@@ -31,6 +31,7 @@
 u8 msm_dp_utils_get_g0_value(u8 data);
 u8 msm_dp_utils_get_g1_value(u8 data);
 u8 msm_dp_utils_calculate_parity(u32 data);
-void msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 header_buff[2]);
+void msm_dp_utils_pack_sdp_header(const struct dp_sdp_header *sdp_header,
+				  u32 header_buff[2]);
 
 #endif /* _DP_UTILS_H_ */

-- 
2.56.0

