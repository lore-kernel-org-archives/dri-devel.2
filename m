Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F924C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BFC610E93A;
	Fri, 11 Sep 2026 10:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6fuVPRI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F1zFtAKN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2299D10E822
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:48 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7lAt73465109
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=wVBzkLR8DNYTE77N979Jlu
 GnvmPbIsiE+d4eF0Xe9is=; b=C6fuVPRIQwJ7RXy64Qbz3pJywNaiz7HZxKO0TE
 YFyXf2T5rX3Y1tAxGi9FbEqr4EEkoNx/W8487Tq0hU/mhwyr8OrS0+bU5B5p/tNV
 xEo1mW8qLIl8bSNJPBHpIkbopa2J8sG5FSAm401YZfjBIo2E/24fao4h/VktC3v6
 xYXFey834gFzrRaIe3YfkLkPQ7vqt9yY6uCCXfpV3wMMT+Jvy+2BFT1W8aoClerb
 pFBV/gOGv1/XwrPuFyIBUojlNI7UO3lu0cyuUD02fkpEzydKabl5t+T4uQ+QDby8
 IaoMdz1dv3hgahkMndMhPAiw13eRrHhVW3ENYzgD+5LFef/w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbdr96af-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93918756165so129858185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789122586; x=1789727386;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wVBzkLR8DNYTE77N979JluGnvmPbIsiE+d4eF0Xe9is=;
 b=F1zFtAKNFDUGtJvLzxzJHi60BXe/RmtN2ICJMFyA/z8eBAls8H3iIYSolfMB06D0TA
 bKJ4zMn9iiMqP3GXDxXnPbaMDTMRf2aYd+yIYrjEVTnE+oKWKnIfp2Tq9zes7JV6G+Lj
 V1nqcEhm5zlM2hmapragMYZWSm/EnOY890CsU6GDfTicRAtW5eOJgJ8nr79vo6Qg3BCi
 D0qdiwMn8Z8SM/bdsHJQi5FA4OcObLu5AwxQESb4wRxtKTZiqS/1DT0Dbu3CKEas7e2F
 6UECia07ie/nUOLLJBQxXC0+z7Yzb3KXf65dJNRl6KO4fr5LPQJcUfpwRPa0MDMifmwl
 6dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789122586; x=1789727386;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wVBzkLR8DNYTE77N979JluGnvmPbIsiE+d4eF0Xe9is=;
 b=RmazMNGM8UbjNDoT5wF/+r4nUbf00AhvF3jioBU99Cjy8jWwS3snPWO27fJiF9uu9i
 72hsMS0m0Ao7ZWvnoANvyW7rZza2HJbkInVR/99jg/yP1YkbMUkCc5H0XSzbjNlJkRpe
 t48MxzE3XyNSGDQyQFW1LJL09yo5meLNlrKfuIexU10CKX3CBtgcMJ0ruySCDEFiaMJ/
 Tox/TZiG7Xl2LQqrbshe2wJM6aKyFpumytyvIIzWiEJ/nT4lsWlO3dUwSrDdOb2BEP6I
 v9FhqDC3V2dAFFEKIf8OSVhnMmIvBcgRQaxS9tlaT6sDLAAf6FQzYNzIgEUbj3M5gFpr
 x1ow==
X-Forwarded-Encrypted: i=1;
 AKwUvByhfgrTRU4kjzESqTFziQ0CXMUOwM+zPmVdbapH4Onoy3CkKxsdlAyEy7Gj46E1OzPZmyZ0VKGbaDA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kwFQSDs9EDQxF5aF5/EhMzBBnbIsIv/k1ilBgpgD+uDV7Hee0J
 ToXE9/VbswI3WX+G5WNsoX23fpNOeUgDUgnW6OoWOukDOTofuLL0P45daHN/3mRH47C31ViVw9q
 wAyXzNAjKh8U4Sgu88kPhuUEfuwD+b2ZWQPQVnObTCblSzi+jJkPJRQiMS4hz3UudHi1ivOM=
X-Gm-Gg: AYBFou1r2laPqLiLk6Cjqo84vQd6OSZY5Yq4OvvXpsKruT0xbOiV2czlAAUyLbHnfnr
 OUwKEZbUCueSRsVbp6MgeqjNiEJqOwIyRkORVYsOyQiXJa7HmYVIl3yEq5pA3nBkmxPDi88886q
 pz+QR+8dKck7FJq9e2w4JGU1QDZiAl36yi+aD3HlW+xXaCgwal8XaDMnk35Tg0qgCx65rqRXZFa
 0zM/mqzbSIHy4DEjIGAeolT04qaho8dZZnNSnShnbm0ceqs6Oq3N1+yibwzQV2QLUd6XlLPWOy1
 21UT6freBrq3/IlG1q1x+P2uz71S2yW8ymjeS7IMA7mBK0b439QupN3saKYxo1AInsa+fPy0i3q
 COnVXJGUvmrVE+KPR3rby3uE=
X-Received: by 2002:a05:620a:371e:b0:939:9eb4:888a with SMTP id
 af79cd13be357-939ea0e3a2dmr446672785a.1.1789122586354; 
 Fri, 11 Sep 2026 03:29:46 -0700 (PDT)
X-Received: by 2002:a05:620a:371e:b0:939:9eb4:888a with SMTP id
 af79cd13be357-939ea0e3a2dmr446668785a.1.1789122585913; 
 Fri, 11 Sep 2026 03:29:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:29:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 0/7] drm/msm/hdmi: Fixes/Cleanups before Eliza
Date: Fri, 11 Sep 2026 12:29:33 +0200
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OywrCMBAF0F+RrJ0S6yOpK/9DXKSTqY2YRjNt8
 UH/3bRuXAi6GbhwOXeegik6YrGdPUWk3rELTQqr+UxgbZojgbMpi1zmG1lIBTZ68Oyhtt5B5W7
 EUFIVIgGd3cMAFiWqhV5bvUKRlEukqZWQ/eGduStPhO3Ijo3acRvifXqhz8fe/2t9DhJKWSisF
 mRQqV1gzq6dOWPwPktHjKP98pPVv9llYi1WulhvtNJovrDDMLwAseCBfD4BAAA=
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zVyV2ilpcMf+nszWhvyCe+gkOWrhd/P6l5OHLlMOlM0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gPcy51GU7bRFE5EToHVzUBxULqGv8kxlubX
 TuDC5JqRfaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYDwAKCRDBN2bmhouD
 15e2EACS16tYVCLZcrSDQ0/SfPgwZwxD38wJiC1ZlZC4/pgoL/e6/XKYqKR27hk8XVRUZF2y+Jk
 /LrvqNTbuha2EKR0kYQ+kE9MfCgCXzufYJkac5Swe+RYh8FCZSuU+8h6UZ9IW6KltlCMC/NIfjG
 kpCAJy4JrSNjdQq3LiBih5ajOeExlSd2M2Vjm2OzlRdN4RQ1X31kNzBTKlWpkAVSmIqPIa+jIEP
 RnSExpzvD4VSrNVzF5k9At7PUUwZ9SI88q+l2DH/fkfQU4qbcMIpzN72s+fY6IJ7y7obpFphSj5
 NrAPpvsuIl/kTCsAa+YmeWAXM64sdj0nWPTyH/RSd9aNeW1Kd2gvXU5X5Zv5INsRMIK4EFR6s8E
 J/2neSTM1fc9om5rCAXOEr6KlewMtRnv9PLN5JF9KHlzCaLnOcvSkgGQB4X5UX9/xzjjhNsuWVm
 jw50/smyM6on6ZXHwi4zVIzGMWaIBYTxvaJ/SFEgy92kqxfUNXLXYRHXotoLTcVaruUyKnYqk49
 1i+jgGcCxXyQO1kSDUn82GT1pw0KG9LH3kH50Iu5+3N3gWXvedpd0k66nj2QbcByP2fQRGEoi5c
 JrKE8+nvupnz6Dl2W+QISW9ausk6P6ZVulScS8UFBg7hzRG14TLckIRjeTzAZU7yPrhlKqxtbXq
 t4QABYmSb1AqLTg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: nb464iyrig7w5fyw0UgxiMvmNzjhSvfl
X-Authority-Analysis: v=2.4 cv=PLmaavqC c=1 sm=1 tr=0 ts=6aa3d81a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=LgtYtgaKtWELOkpzEYEA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: nb464iyrig7w5fyw0UgxiMvmNzjhSvfl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX10iiHCOvAvuk
 QiHSeNyuwCjSY0acmG4HBu68AVOz5mCGIEyvte1MV+trkl/vjokq/+RHoi5tXPcw+gh6AgYfTfU
 YlYoEX0yCJVFDwDjMn1dM/bNQC35a4k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX3m123dFPOgIr
 B2V7ipp0Vkg2EiTJfydxfSXRF3rNhBNnqWYsVqN9NMec34CPpxn/1Hmp4xjs8reKyIkiEZhBKVt
 fO+cjLbrzTC18SmwmlVW82fL51ebfq51PBdmkcmQDDJba5xPr/0MkoK+F2JkRHco2aKiALXvgd0
 fSvV2aU7myPTA606uvVHqluAozGsBcHzudNWVF2UGE5f3o6ElhJNecBOJsIB1CFzB4ZxwAPePyy
 kcYckg3esC4op8+wdu5VWrp6AaISsSMs3HMjdWx8C0KksX9BWX8VAtSimRu1Xu07NHzYlk3xUDh
 FfUHG8tnlzF0hY/eE5gYKcFBJpGz0XRyCrgebVIip+h8HE0jiSI9v7T4pXDfs0Jn8H7czG6/05c
 ZDL+2+Vj+WtxVvPI+SjArD2CGyMMBJO/wCKs0dTypD1dKwvivMQNJz6K5cSaECMVus2RbIfb2cQ
 NK1kLeqBSsnpikQUsxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110146
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

Changes in v4:
- Fix second name in "Properly handle msm_ioremap() without name"
- Tags
- Link to v3: https://patch.msgid.link/20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com

Changes in v3:
- Add missing regulator_bulk_disable() in msm_hdmi_phy_resource_enable()
- Set hdmi->power_off=false before calling msm_hdmi_audio_update()
- Link to v2: https://patch.msgid.link/20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com

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
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             | 34 +++++++++++++++-------
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                | 16 ++++++++--
 drivers/gpu/drm/msm/msm_io_utils.c                 |  6 ++--
 5 files changed, 44 insertions(+), 18 deletions(-)
---
base-commit: 6e95d4043b2c59f1887fd72d1620b7fd3d3138a5
change-id: 20260907-drm-msm-hdmi-fixes-before-eliza-c9bc7185d84c

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

