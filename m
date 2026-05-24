Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2304FCD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 10:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F171A10E115;
	Sun, 24 May 2026 10:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVjcrzGF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gud+rrFG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04F710E103
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:37 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64NNDbH32992681
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+bH+vfyygj4FdgLK39FAGR
 xrgQV4A+boeLgZb6piWGY=; b=YVjcrzGF8MqeEN0e4h87Gm4rKQmAiWB5ONJjW1
 JQkIMdIrDaBTWxiCocH8DWC6+mJ6YZ+Ebh1BX8VnhzwlTab5yFXoXFzSh3pl1cyd
 nJV9wIU0pGPwPTL3Mz9IQOc8UmAMLxZhxX/Af8RWiXwWJWlHZaI8qjYcFbHLA92F
 XsukE97ozxs2wsQEpDVviUkUYBCokibdll8Q5ZdDo1bnMFea8xdBiBFR8GeE3GRz
 QTdxFj7QuGQsd/i2ijhbHBCTjUOLKbn6gQCPcND92VpSRqJqEgXihU3WwQ8Fz3Cn
 ZcxTCHHF9RNfksjeLYh++kP7313G/S+iQNF9X/mkxe+fkNyg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmkc4u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:36 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-56f73835016so6817978e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779618816; x=1780223616;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+bH+vfyygj4FdgLK39FAGRxrgQV4A+boeLgZb6piWGY=;
 b=Gud+rrFGAVxGmKVveup5ACFZoW5AU4zqKJkOSWQgibuOc+fpmrSv30mBTY+SkJtg23
 vkD6hZQzve6dqBKQgL7Qp/MWE97rUVYsHefWpLpXmw4KXq/6TJh7Pd3B9MEteZi5TSG5
 B/07DaxdNZYDAzjhbRCu9J2pjB1Dhi6aAS4rhc8f0WL9vRwMFHopD++7YUyjI8G6q2w8
 gDNfo5wSbNjsSjazMJ7RND/Hxi8p7QAez+AMFOcsKt2Jzi02IPqO9Q4AHmw9Fz5E3+T3
 YCdONTSx0HGbFoHeX0/oTVbkPxhtgMh1EejCDR/f4gCTMCvoOXMusm+zMCTHt9dNLi7c
 jKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779618816; x=1780223616;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bH+vfyygj4FdgLK39FAGRxrgQV4A+boeLgZb6piWGY=;
 b=qa53HmI+PBWzwqC1uxtxynRo8aQg4HlQdCG6qPdlhmA/Swv0kFV63qFEYfQ49PtsZP
 3cnZA6413iQQVJuHeRZCwPDabihnyFEdtpErw4RpHct+49EYLvCDZl/Kpc2Sic46ShT5
 UvUlGkPv/nfKAsSL6kd6qgEOxuFTDVbaAUhpFfOl8Ly0O/FH90t+Vz1jJYFy3Qv4cjhX
 VhS91e38jGKRUoxZNhGTzyeg1XyVacxif2e+Tradqh38BTQpNISr99BfM9F7fsW0k22m
 v0YVpyP7w7cjrsbm+VT2tMBesm7zPtpix93aKjUkGn+tbHATnop7GIsC5dZyJ18Uao18
 OJkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mq2PhsxH5uSFYJw5H1defeKfMroLq7s+Ta27yxB9Xl10+LAj/fm73uRJGWunQt95m2O4lQvrvEJA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkkLlDzxnWfyCLh343yi1pOc2+xTphfZtqOEzymQSrEtitWs8i
 SVN86sY49xov/DCuwJLF9eGqLkwuE6FxdfM0FjUtnkQKv4ivOD21vISkgfPocOxoCAqNY0WWBNA
 zSFT5c/WMmw1+TOfugdrwhg9tQ2NyFRpFP/VzFVI4w+7kqHqS0kqpQtyfK/xfCaZaYPzHKYE=
X-Gm-Gg: Acq92OFcofpjU1F3F4qWxjWSX1BjwJHth6eGoR8dEhyVWNoonwv6Qo5Ilx7dq4eL9OK
 M/2Hya2grkp+w+shhCx8jSb5JunmxgoynmwS1lO6yt+HXjA0/agU49YYtf0cpEamM8kfwQC1oRC
 RLJ1saGTRPXdDHb/h/Nuum5xlsYBL6oDdCKHvm+gsWQeElROXS0ipQsDYdFYD90H2xqEFswewzC
 WrIR0xIndXopLv8XYvMtdeTMN2wtbrIsrGb681XnrQu9cFeGgT7CHjoKXvJg7OcuQXIqxwKFrNa
 lIMrIu37xFYCISj0DaogLILbQ/14IcOrVj449ekTXtiujkGQMjHkpGJxZUaZKEwi6uKV7tV6FmU
 eG3uYWwjud6M/2gZgT2bNIr5qDWSDPKh7mOE98NMRtdjj4D25806Uh5VH8AK/szm27RlCjL5Pp+
 QEYeqhDbmU3PNetaWnD+AD7Aim3b0xQP/sWmI=
X-Received: by 2002:a05:6102:5ccb:b0:650:9173:b131 with SMTP id
 ada2fe7eead31-67c7e121b74mr5024000137.5.1779618815970; 
 Sun, 24 May 2026 03:33:35 -0700 (PDT)
X-Received: by 2002:a05:6102:5ccb:b0:650:9173:b131 with SMTP id
 ada2fe7eead31-67c7e121b74mr5023979137.5.1779618815487; 
 Sun, 24 May 2026 03:33:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cba880sm1816148e87.32.2026.05.24.03.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:33:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v6 00/10] drm/msm/dp: Drop the HPD state machine
Date: Sun, 24 May 2026 13:33:28 +0300
Message-Id: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjTEmoC/3XRyW7DIBAG4FexOJeU3cup71HlgPFQI9VLjGOli
 vzuHdtqk1r1BWlg+ICfO4kwBIikSO5kgCnE0LVYmJeEuNq2H0BDhTURTGimhaR1X9EBvHVjN9B
 UgdCl1kYwS3BLjyvhtnLvZ6zrELHta9UnvsxuUMr5X2jilFEpXWldJqSX6q2L8XS52k/XNc0JB
 7J4k3gYGct2hkAj9Qo4pIpbKw8M+WMYxrneGRINloHwsnSVAHZgqIch2d5Qy1tyl1fcg5eCHxj
 6yeBqZ+jlHi5TmJVMK/NfHvMW+ACXK37buKVOShuBLk1hLJIWbuNrY+MIA3n+0SL5PbbqsbttY
 T12uYNnJgdjSmesLzDw8zx/A+mgO74mAgAA
X-Change-ID: 20250523-hpd-refactor-74e25b55620a
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4773;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=U0XZxC99ewkLvWYK3iy5g6JrTkG0b11dXRZJIWCZ/wE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqEtP8vhw2I3sO+xF+dw2zCgQgGJ/1vHFEF0eJk
 8UF7lNdmj6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahLT/AAKCRCLPIo+Aiko
 1SrxCACfeVlMwFqCZvXlYi2jhZEUrteL+A0ZpJ1iFGNmWw6FPWL/LeMq73invVVmi8Ab7cuK997
 zDK70Oa5NlQHknNHBIx5BbtC38k9uaVUBJjYdgeH1+Y5evOswv2pT0gWpjr6rGvnaYtaXNXB9sL
 esm8z5L6K0kalR53jvAql9PgwO637JnvkxMJKZl8+0SOa3I6EKuPrcw+DfxyWOALwkZz2bWGroc
 2Ecn3AtmqNn6QMvLLLaOnOwlR+iWka88x3j2JkKRT8ZE7aUjtmKTytNX0kE6yV+RDZw3zF0IGNl
 4slLO0sGQxsy94ewYuBJCg94bLF7ONuCF1x6L1dWgurvnHap
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfXwuuIk84Yl4kK
 VecsygSX84NPPEcRCkU4xcLfjRGVtRyPTg2rHEeQ7rJ3YGsfNVy2/soT9hqhVyNzgeRo+7zdwN1
 UogYbmsl0FX2CSP1KhE4SRqtVQUQI4yvaofaZFYLsxCYfQtiLXkyb02ZBtVseePIa3GTDPBYyV/
 AptK/mFRzPysiAsyuAw3/YXbGwlRBQb/yhDYCepo8hnTVCKw07TkkmpH9zDmAUciznd5A5B89LF
 lLVL487GdPtJpraQkIAX8Oe2zB2aelD62eU85JzyI9Z/2jGb3zls4SXVUikeGReQmJ98lj1znUG
 k4X2FSFl1TC1NJH17q0YughKyRmGNfruuTkI8WDvMjrDnK8xgRIGA+5fez9qlve2nd3jtR+Ld3n
 L1W7noJADfIEh138Sd9hY8yw3leyiyQfr92qxhOLv571HtY+niIE5xurshyKEkR4zwcq+Xe7nZp
 iCAvnY88CfnXNwC4MHw==
X-Proofpoint-ORIG-GUID: hfAK2ZJ8nBrt5KhtHUxZXIjXKGgfKOux
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a12d400 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=COk6AnOGAAAA:8 a=AKXKEK5VpfSTwivlQfkA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=Vxmtnl_E_bksehYqCbjh:22 a=-BPWgnxRz2uhmvdm1NTO:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hfAK2ZJ8nBrt5KhtHUxZXIjXKGgfKOux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240107
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

Currently, all HPD interrupt handling must go through the HPD state
machine.

This has caused many issues where the DRM framework assumes that DP is
in one state while the state machine is stuck in another state.

As discussed here [1], this series:

- Removes the state machine
- Moves link training to atomic_enable()
- Changes the detect() behavior to return true if a display is physically
  plugged in (as opposed to if the DP link is ready).
- Remove event queue and move internal HPD handling to hpd_notify()

To correctly detect the displays which are plugged on boot on the boards
which use dp-connector devices, this series depends on [2]. USB-C and
eDP panels are handled natively.

[1] https://patchwork.freedesktop.org/patch/656312/?series=142010&rev=2#comment_1201738
[2] https://lore.kernel.org/all/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com/

---
Changes in v6:
- Corrected mismatch between Jessica's From and SoB emails
- Corrected documentation and fixed style comments for
  msm_dp_bridge_detect() (Bjorn, Konrad)
- Changed msm_dp_bridge_atomic_enable() to bail out earlier in case of
  link training failure (Konrad)
- Corrected commit message for the link training commit to stop
  mentioning event-related changes (Konrad)
- Added kerneldoc to msm_dp_display_host_phy_init(), describing return
  value (Konrad)
- Switched to guard() instead of raw mutex_lock() (Konrad)
- Link to v5: https://lore.kernel.org/r/20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com

Changes in v5:
- Fixed the EDID clearing on display unplug
- Fixed the initial HPD issue via the external series
- Tested on eDP devices
- Link to v4: https://lore.kernel.org/r/20260305-hpd-refactor-v4-0-39c9d1fef321@oss.qualcomm.com

Changes in v4:
- Fixed PM runtime handling
- Fixed several cases where the HPD machine would loose its state
- Fixed the case where detection was ignoring the plugging in display.
- Link to v3: https://lore.kernel.org/r/20260115-hpd-refactor-v3-0-08e2f3bcd2e0@oss.qualcomm.com

Changes in v3:
- Take over the series (thanks, Jessica, for the previous work!)
- Major rework of the series, squashed the set of patches touching the
  HPD states and handling, it is easier to do it this way rather than
  pulling the strings one by one.
- Link to v2: https://lore.kernel.org/r/20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com

Changes in v2:
- Dropped event queue (Dmitry)
- Moved internal HPD handling to use hpd_notify() (Dmitry)
- Reworked bridge detect() to read DPCP and sink count (Dmitry)
- Moved setting of link_trained to plug/unplugged handling
- Dropped msm_dp::connected (Dmitry)
- Squashed all hpd state related patches (Dmitry)
- Link to v1: https://lore.kernel.org/r/20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Dmitry Baryshkov (3):
      drm/msm/dp: drop event data
      drm/msm/dp: turn link_ready into plugged
      drm/msm/dp: clear EDID on display unplug

Jessica Zhang (7):
      drm/msm/dp: fix HPD state status bit shift value
      drm/msm/dp: Fix the ISR_* enum values
      drm/msm/dp: Read DPCD and sink count in bridge detect()
      drm/msm/dp: Move link training to atomic_enable()
      drm/msm/dp: Drop EV_USER_NOTIFICATION
      drm/msm/dp: rework HPD handling
      drm/msm/dp: Add sink_count to debug logs

 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  16 -
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   1 -
 drivers/gpu/drm/msm/dp/dp_display.c | 722 ++++++++++++------------------------
 drivers/gpu/drm/msm/dp/dp_display.h |   3 +-
 drivers/gpu/drm/msm/dp/dp_drm.c     |  63 +---
 drivers/gpu/drm/msm/dp/dp_drm.h     |   2 +
 drivers/gpu/drm/msm/dp/dp_panel.c   |   8 +
 drivers/gpu/drm/msm/dp/dp_panel.h   |   2 +
 drivers/gpu/drm/msm/dp/dp_reg.h     |   4 +-
 9 files changed, 255 insertions(+), 566 deletions(-)
---
base-commit: 687da68900cd1a46549f7d9430c7d40346cb86a0
change-id: 20250523-hpd-refactor-74e25b55620a
prerequisite-change-id: 20260314-dp-connector-hpd-f069e66bc6af:v2
prerequisite-patch-id: 90db75e3fb8bc9c81c67547db7bbd4eefd5d6c40
prerequisite-patch-id: 1c4d030b93a8cc6c98b3447a8685da24eb1f24d5

Best regards,
--  
With best wishes
Dmitry

