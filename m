Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7226C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5550610E7F6;
	Mon,  7 Sep 2026 13:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oxt0CBN4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DYV9QGk6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C61910E7E8
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:00:31 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AnQme217656
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=mbgqvHTyaHpGvMkymmdVNW
 iCsdeQ9ZFYWr/yEdLCQX0=; b=oxt0CBN4ZdJ5fnFpr/aCb/DkgARIdywr5hcXdg
 QeLRYmLUgdpc02LH5T+pqd96XxO2aDu03PsQOC+cce94V3ESIlmcEZHbw4CSts6G
 nVRvntGN+AVp0FI9c2aXNFM5lHfvu/FUj9maHE1WdW0CYV72k72jHx9PeJRaGGUD
 Px3O3Px04BI2F55pT2sYSvXDuv076mpo6gaoXynP8p70ed3HOX9uV7Tx79OZ32QF
 QQBpbfETEn55tKKU6g3pwdroMY6n82OKG27FYd5BnhO22fDQKAab2JbPQUwI0/59
 GA8uSas4eqRZ31g27rnMzK7JZkQ9p8Rz6L8Rrfk44BZJY5Mw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtdqgvvm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:00:30 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-737d2f02d2fso2761593137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786029; x=1789390829;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mbgqvHTyaHpGvMkymmdVNWiCsdeQ9ZFYWr/yEdLCQX0=;
 b=DYV9QGk63orOJo8UeInE6ee/isMMfLK2SksDAIGyHHXU+yhqJy4lDpCxA1E3/GwFdW
 DmHjpCagz5ysnrwTDrTd52VcBhK3Ebo/eInT8Yigh4YdBneLedqOfszGkhHMpdJW2gWS
 ThE+S7QhKhk42CvDInUQ8G/c8GMWGzQNC+syAaxF9Jwn1hufag1uhrZugRp/+ePe6URk
 /6v4sLdqvRTJNVvhZ1edoLjCAI9EOXZzE23AJcw3TsIB2nOQ9VsneFZRRo1VXEmX8c/w
 7Y5tFelUb27/SqvwmyfwLXttqGtzLLhckZGQf1qNY6INvMRYAV7x2hlGEp9lpEXBbgqS
 UBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786029; x=1789390829;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mbgqvHTyaHpGvMkymmdVNWiCsdeQ9ZFYWr/yEdLCQX0=;
 b=DZFMsPHrYWFRGu0sQRQhE2cZgGTHtnb1cwFCceLJZY+OvC/WBaWB8Zbwyx47AChHuW
 iOhw4DoIVvIpSExTqbI2B73zuWCVUAdRdrWtZMoHEd1qnGDQ63sXn9zL57JmvAiTAzsK
 EGI9bZF1eVBeZiosAY085pw3zs4P4LjTctCUcQ+lAnQzNBfw8WgyE7tPYqWblKfTeBWv
 5wpfOr6/8F5mj3lvIKAb/tn6//Vsn8VCu+lXnQANUEkoGSRRl4WeCQ3D+qupTAXH0WDO
 FEp1EqccLxrbBt4shy2T6LF2wZWX83+oEsIzU6wxPckcA781Qugnzz6dmUUESbkErfHM
 1NTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1M0TYmGYBhg5fet2iwSQRyH6D2UvkJD0VIUCxdKz0Bfl/OYNR3IROjabjAnESLYJvhhZ3LDVl3B0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nFZAi1CcEMl9oekGs6tFoWhT4kyQQ9AS6l5D49duDgvr8OLckW
 +tdDano96gQdIew9GC5TTwJGCt6OeuuTRrv7q8jo1lwbZDX7HQOaE0Z9AwaKK5+AsAgMkdnCgvX
 5XYHSQNiNhDeRoeZws1ajSpiC4UAisk4++qcIzgHiOy+Xwh8trPDFiEmuLMLZaaUdV4bwEsQ=
X-Gm-Gg: AYBFou0HOy0NQz5sqBpc1F2GjE+MT0PE9AS8DqQPtSsy14Tcp1rlbGk9c6dWDqcl4XO
 M3Py8nCiv9RuKdXJfOJeQlTTNCB0Yp0vrzJ6fdeVMwYQhpPWo3JB/H2xK+7Qm70wNjX4dpYlZAW
 cCoc4s4nxdGoiYGJKHwoSPVN9yTaH5ygaSESGdRbx5Q7YbIOXLVKskVpFjSIAqxanGXmZ3W/WbY
 /S52wFELK/xHK3VVYPoBzye4blxNSDRUOSzJ/hNSpoebVKiriI7FD7OChrRNZBvh08TX6qhABOd
 1m+oQwrD1jdNsxTFq4DpY9kA3rQw0UZr8IgwS664gh1J9Q9K7ps3DoGs1LFtBbGBHNDDozo6BJT
 QJXS6KPRbJyX1bOWbPamtGaI=
X-Received: by 2002:a05:6102:509f:b0:785:e444:15e4 with SMTP id
 ada2fe7eead31-78a4a87d391mr9352530137.6.1788786029493; 
 Mon, 07 Sep 2026 06:00:29 -0700 (PDT)
X-Received: by 2002:a05:6102:509f:b0:785:e444:15e4 with SMTP id
 ada2fe7eead31-78a4a87d391mr9352452137.6.1788786028936; 
 Mon, 07 Sep 2026 06:00:28 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:00:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 0/7] drm/msm/hdmi: Fixes/Cleanups before Eliza
Date: Mon, 07 Sep 2026 15:00:14 +0200
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTsQg9rWq0gXTfLXjphWZlTE0
 rsbdfnB4y1kUIHRsVpI8RSTeSrwm4ri2E9nsKRi8s4fXOtqTpo5W+YxZeFBXjAOGGYF4yrvnmM
 bYr1t9qnZRSqXm+JXlcmp+9se4YJ4/25pXT84UbbLgwAAAA==
X-Change-ID: 20260907-drm-msm-hdmi-fixes-before-eliza-c9bc7185d84c
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=R1heoqafdwqzfSRjHxzsYA5WusvEWpky2358S6ReQdE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVgvrThFbbkovfh6cZdBXUsee9/xtJ+Onlei
 4EMFYCmFb+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61YAAKCRDBN2bmhouD
 103PD/sH/PGcJ8BqD0NEQzgF9UlC1sIfzFQ7EdPuYBXVAsrkN0m8vlTsaAZzy7Dq9dAItUvy7vB
 4fnH+3WOZAHyhWPl4x/APMty6S+vRF85VkcIn5KnhrKa5vxziTLTm/RH8n1/4Sw8Z5A847QM4TC
 R15b7xwRXnPfPkfR+LD9jyUZGqDqxNScd4nFSkj9wtkRaHBGXLNJurFpbY+z2FYn6WigE0PCgkv
 fYpE30RywfqJ1Dpqku2f3umvp2R+Tvh2xkN95cFHKcjy3KpDMZuYbKapA4y9FcFR/IOfrep5B2q
 LcTAPfYMhDI+/UeyQdKg1deD7sSY52Z+cDF9HUeNls8P/L+MpV5kCsAhHvh7fEsu1Aji3kyS43d
 6TN35XMDZ+2t7WSc3OCI2jxILkLDKGMhfWbZ9MJoPV98rdWrNrI5cZZGmzpqICL0jpWWC3p2FQs
 zP9XCEGFQv2PeXuqe44uqG83Mgo3JpN2bpDBvoOHKMVELMyoNS/ae9XP5Hg9zitUgQaN6thAkkN
 nnBRABELem9F+bnSjzvEAiE1/KFhT65f92erZBDy5N36bgTQiaP1sjcT9pDDduutWHUvc/GLXPm
 NPQSTJGYo4ZZRCnMDd/0jXBhmi45KJEkAKxVY5x3R0Tniy67dp48UvQPGpzBRY7mhnWvFL45w1v
 OFXv2FZD0gtQhAA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfXzXf3W3vpOgNz
 2cXCs3G3ZTjVgcmEGZ1xXg7NY9tgeGbVlg2It/JaKDhMfcLw4dtucwOLV/nEdo02uMmf0cpyET8
 gtMkuEVcg+iSIx05WGHpK1qdJktoeUYbRSOf1jD9sxSk/TvNFZcz8m7BFdkTGZ7l6qih0E3JNle
 TMIMaP3bvYmt4rMWQUYM6RtgfFT+Ex1geJfONKyYBDzK/ck8X5IIenfMzrysieigC1B6maq+NbM
 AVvdI1pSbasx7/hK1amFm6sfwC5j4IXVaVf+xhWOfB86Ffk9RMzdFL6JCeCuM+oL6TjaqILrgw0
 Q0mP8+4gBCrRMea7LZirvIATLXwtOdMotg9UEPWsiOO0TbF7J7jX9sL0f+ZUR2QxO9GJtg6/4dn
 4ghL8fySnVu3JNK0VTEERfThnZhxs1GJeEsLBMbDSbBRkvau71zUcOr+hNxDYMz7gd2SDeW6Ysi
 nC8X1RKJWRoAnnEG5ZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX2PBQFrWbCdbp
 eWwgfiQbWdlpsuHRPSfSIQX11Ccj5AY2HB1yj8uHC+jp7aLLMA7/+etxBZjTaZZqSuiyHQ8uZVc
 L7+AW9gbB55xTZlP70ojIbTR7NKc9Ok=
X-Proofpoint-ORIG-GUID: OMyLK6Q1itak9fZe50XS_c1PRFAfd1yc
X-Authority-Analysis: v=2.4 cv=U6aiy+ru c=1 sm=1 tr=0 ts=6a9eb56e cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3rGLuoqwPg9cSPe0pR8A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: OMyLK6Q1itak9fZe50XS_c1PRFAfd1yc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070143
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

Split from Eliza patchset, thus `b4 diff` won't exactly work.
v1:
https://lore.kernel.org/all/20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com/

Changes since v1:
1. New patches:
   drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
   drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
   drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable

2. Patch #5: use simpler ?:

3. Add tags.

---
Krzysztof Kozlowski (7):
      drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
      drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable
      drm/msm/hdmi_bridge: Drop redundant initialization in msm_hdmi_bridge_init()
      drm/msm: Properly handle msm_ioremap() without name
      drm/msm/dsi: Fix indentation of if block in dsi_mgr_bridge_mode_valid()
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies

 .../devicetree/bindings/display/msm/hdmi.yaml      |  4 +--
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             | 36 ++++++++++++++--------
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                | 14 +++++++--
 drivers/gpu/drm/msm/msm_io_utils.c                 |  6 ++--
 5 files changed, 43 insertions(+), 19 deletions(-)
---
base-commit: 6e95d4043b2c59f1887fd72d1620b7fd3d3138a5
change-id: 20260907-drm-msm-hdmi-fixes-before-eliza-c9bc7185d84c

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

