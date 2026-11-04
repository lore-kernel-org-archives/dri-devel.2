Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C4D606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ShPH+nR+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VWKODDAO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB9B10E799;
	Wed,  4 Nov 2026 16:36:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC9D10FD25
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:36:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fir0G1292298
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 16:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9Q97qnHrubmaTZHUF0bE0e
 dWN/XleOsKgIjXjH28YHU=; b=ShPH+nR++KomY5SgjajC/D5f0fxgie58a2bOjo
 6pmVBhKn4bC2VH5fuEZEfXJk08YRoO9VjBVceiXeaq97T977R5fBWqw8naocWcoG
 sJdwpdN5yFmHlJgvDnJoP/OyCcQsPyqUp95vkboN7jK7M/8EijXCt8PBSwVjpsZl
 8zbjodETeI2Y9FNHcs22jgvLOhF2+BN4F2gUmimH3yRaNRZmzcbGnIntrTibI/OK
 qr/Ky7dGBjp8RbU8deOUb78Ia5wg6q1L3kZqmCLefhe0J/8Mt7lMsw9qqmriv8so
 AfIX4aV3CVlebJKHjJ5jYzqsuEHg2y3bFfiud5v9oSLrysYw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163hxax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 16:36:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f32050e72so283795285a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810189; x=1794414989;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9Q97qnHrubmaTZHUF0bE0edWN/XleOsKgIjXjH28YHU=;
 b=VWKODDAOMRpYSKyrEVr9rnPGgLsgT9eNZZqNtvZgZYsqLTWn9tuAGDyUq0ceAQ2pDT
 oGHeLrDiPGyig9iFVeLny6T49Pigp4Dd9bj6L08rSr5ozeggivTFcHkz90KulZ1RET4k
 diOTM1klwN03OAHuxzEl8tJoV+HcQZDkDLK/6dD286WsRSfOEUm10/KK33I1qRmBetSb
 UcUteu20lSP5ug5tH+qdSvMwjt9xYm6BlXHvWy3IIRcopaM84bF/fl+RIKFi4qSIFPEw
 Ayq5wMRzWwsk07ATYqtQ3nE5JOyH3F2IGY9S4ILph1TsNJvJ9adof4t8QOYdpKFrQNjn
 OFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810189; x=1794414989;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9Q97qnHrubmaTZHUF0bE0edWN/XleOsKgIjXjH28YHU=;
 b=XFG9cJSBqadky8fu5sv+ChY7muQon3AwJIu6rEdwgYrxOhLhzQI30HfsYe6VTXbL4H
 qdSaYKKqQgFqG0d+dcAOcOBQNtje/2IdO14yytVjSJ02zeyqLch6EUdqLHc8def5lzJC
 oh9O/dZmU8pRZGOlmAHYJgK26xRSkdTCZoAkfPokAy0GfUBlrTr/mveaM/1bp9gDpXTN
 XQycX0/QSkbeTG2NUo84ChXdsCxxHRngp20DaqAOvKNCRjTZjRVJbv5mg7z9vq9vqOWK
 oUSN+K39KUiPj2OBMtASbsI99fG02nsndPUz44kUwWC5rDsxyxss0YbdrdQ2czUYShOJ
 36AQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByyCuMzYwPOQOcv0CKqSvs5CRgVBYq51M2dgaHWCBa6gi+aYL2cFpKXSG4gIwpVURp3cmFhsA9mKLY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+//Ch+NiJdzlBe24zrM4EmSU1R7SgiJlbSRDKMkuJAwO/5dM4X
 KW8w6M2QUT/wetczhslxt9hFX9NEE+NZt9KED9BhCOJ1vZdViWhaS3HKyBeFQZ2QC4bsHRJ8vg7
 MCvPIX9VOjTmwZnmOJ+p5jz6N1WtmjcmYmsZJW6mBwGGkYnikqjBVNSEC7k7KdR9cJvFshdU=
X-Gm-Gg: AYBFou0xDM89sy+5YesX5XX+ELHvs7UtYx+vZv8dcMso9cqepLxn6XNY6GrBwyy9oxP
 XYe4KJm1GX6Y7nf3G2PC3AiLfNSyGrdscalN07fC4YCckgRj/0PpcsXSlJSCEidv8wIQtpHN5hr
 Tt+bO5LMiWdeXpqBeNVem2ZLZrfmpJ11O3SfDUMfTVqLHD0ZioApeSDbZpBx6yN6rPq83oEzfQN
 ncHqM7m5/ihEneJxll1O+MVlw5edp16HpiQhYjgBJk5SaGHiGt12Hw9J1kwmNon7bS4sKvxy4pY
 2/lGmlBiHR8bDyQ7GSLoqazXYcfopp5TI+xZXZmgWcRuzzu8u8aCT9bnTQtIKJ/GjuEzub2AGTK
 Yk1tUTwOtMgyCCwOE3bYkrqTUqU1PDRm3ei6mUlp2Tq1/rUxDCqfjwm4Qv0awGR4fTpxHEqS9Zc
 /tTtA5oRvn9dMjvaA8t3EZIV/elcRx0IvAcMspwHwympetULIO3kTFmUccYopqyQ==
X-Received: by 2002:a05:620a:4043:b0:93f:31f0:6a7f with SMTP id
 af79cd13be357-9442172a5c1mr3042993485a.69.1793810188400; 
 Wed, 04 Nov 2026 08:36:28 -0800 (PST)
X-Received: by 2002:a05:620a:4043:b0:93f:31f0:6a7f with SMTP id
 af79cd13be357-9442172a5c1mr3042988285a.69.1793810187938; 
 Wed, 04 Nov 2026 08:36:27 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acdc6bed64sm5267191fa.7.2026.11.04.08.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:36:26 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/7] drm/msm, media: define the UBWC buffer layout
Date: Wed, 04 Nov 2026 18:36:04 +0200
Message-Id: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPRe62oC/yXMTQqEMAxA4atI1hNog1icq8gstEaNoJXGPxDvb
 mdm+S3eu0A5Ciu8swsi76IS5gT7ysAP9dwzSpsMZKiwhhxuzeGxC3GqV2yDV3RlTsaVbHNHkLI
 lcifnb1l9/tatGdmv3w/c9wNdQwP8dAAAAA==
X-Change-ID: 20261027-ubwc-format-docs-7942079e1472
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2859;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4SH0JW1dB6WJf33quabAd7eWZqAqkw4IMlKiqa5Y7Dg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq6173l4RVxdwRlHhknfY4lR4Zsy3zNSfsaf1M2
 G+W9EjzeIyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaute9wAKCRCLPIo+Aiko
 1QfaB/kBUdmO9yyqMW6ounuavi0h7rwPMCooaVSZ1lAWrvU3DhazqXlPzOzE007FWwQ36OjMeTU
 WcVph6vBSUSFtxdEz4ikzgDuN+b9NUPDF0AkhMR/ch3YJ6sZ46UJM4DHKy+KRo3pnsP6XJ91UuL
 /UZw363rTFmiI/Az5TBj2mEzq5mhxRutwCoAjWwqhWqxShKc2+o5UHkY+COMcEfe7TP52YFeWoH
 6xUxbFwtPr7EwPuF4ZZBvqQJ0mchfsPR1YWPMEJAo20H7+AmM4I5Nkn7shnMLz35G78lhhTs8kF
 iQwL8udwqPdjUA8GBrxiKHy/MGK7TWD28DmoyHeV98WXTV7A
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: fJZRBzG1RMwsD7qpTt0CRNSjLBDE5G68
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX0q67zMh2tU5i
 gRhQ0x4qKaQjxhkKHMy90KGYAbk97/2w6P9p85Mxc2P9j/dErvmCKtB23TOgEGpcwp5kSUTTzkF
 uyKZ9/u7z9jjxxkl2UP/B1peWqxGNDc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX8IkWc8vXp90g
 4ppI9Tzebi9NuyxNVDtPr4vnaWMi4X3UyVZDn5OYJFrfxaB2LzbmJTtuPVnwNarGs9sQQ4+SJE+
 M55kcS3+1PSw/zcboBwNagFP2YpcXagPQHlG7bjPMKZTWONK1yX+6fDNizJxlE+LFbn+c4KDCJL
 QQOhc+AgWd3M3xrnD9Y9KGwERMofDvcbsHHIEbS0KMuYZOzUlmLge7X38Q7Tu9SDJ57mQmptdKF
 hLLYAOC1F4/l8xGFjXqeZakZXTQiGOzcXK80DP1lWV7jnn/qBlhH3/RVLfpr3SzUZKh0l5p1p20
 PAvTxTMFSdEezgHm6usaMkTP0ZBY+r+Jb0YtvvRsWolBd5E6FOthkOZnc4L3c9AK6NDb1jy6Hps
 IkMfjeOAKYA9KOsYSQ+hVHidNQqv+gR/Dijzet2UsqZhA418KSybwJpEpOgfBr7dXN2F4dxwfsv
 lhAEtmH1PvorNOf/pbQ==
X-Proofpoint-GUID: fJZRBzG1RMwsD7qpTt0CRNSjLBDE5G68
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aeb5f0d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=D__o4bQJyZzLvQ_PEqcA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040066
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The layout of UBWC buffers (DRM_FORMAT_MOD_QCOM_COMPRESSED, V4L2 QC08C
and QC10C) has never been written down. The V4L2 formats are documented
as opaque with four or eight planes, the DRM modifier as "macrotiles".
In practice the video decoders, the GPU and the display controller
exchange these buffers, so each side has to reverse-engineer the layout
from the other drivers. Nicolas Dufresne asked for a contract to know
what the V4L2 plugins have to compute when passing decoded frames to
DRM.

Writing it down showed that the display driver never validated it:
msm_framebuffer_init() checks UBWC framebuffers as linear ones, so short
buffers are accepted and the DPU reads past their end. Patch 1 fixes a
misleading comment in that code, patch 2 moves the layout calculation
out of DPU, patch 3 checks framebuffers against it.

Patches 4-5 document the layout for DRM and V4L2: metadata followed by
data in each plane, strides, line counts, tile sizes and alignment,
with the chroma size rounded up as DPU and the vendor headers do. For
NV12 the CbCr plane follows the Y plane in the first buffer: DPU has
always fetched it from there, ignoring offsets[1] and pitches[1], and
turnip reports offset 0 for both planes, so this is what existing
userspace relies on.

Patches 6-7 bring Venus and Iris in line with the documented QC10C
layout: Venus reported a wrong bytesperline, Iris called the format P010.

Mesa 26.3-rc rounds the NV12 chroma size down for odd sizes; that is
being fixed on the Mesa side, before the layout reaches a release.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (7):
      drm/msm/dpu: fix the comment on the RGB UBWC plane count
      drm/msm: move the UBWC plane size calculation out of DPU
      drm/msm: check UBWC framebuffers against their layout
      drm/fourcc: describe the Qualcomm UBWC layout
      media: docs: pixfmt-reserved: describe the QC08C and QC10C layout
      media: venus: report the QC10C data stride
      media: qcom: iris: describe QC10C as TP10

 .../userspace-api/media/v4l/pixfmt-reserved.rst    |  63 +++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |  84 +----------------
 drivers/gpu/drm/msm/disp/mdp_format.c              | 100 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h                      |   3 +
 drivers/gpu/drm/msm/msm_fb.c                       |  39 ++++++--
 drivers/media/platform/qcom/iris/iris_buffer.c     |   2 +-
 drivers/media/platform/qcom/venus/vdec.c           |   5 +-
 include/uapi/drm/drm_fourcc.h                      |  54 +++++++++--
 8 files changed, 247 insertions(+), 103 deletions(-)
---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
change-id: 20261027-ubwc-format-docs-7942079e1472

Best regards,
--  
With best wishes
Dmitry

