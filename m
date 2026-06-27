Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769A1C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 21:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81F110E18A;
	Sat, 27 Jun 2026 21:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cb5Egtzt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="avMfNKUR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283D510E18A
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:04:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHo2F61737839
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ccglRRuGK/fXO5fOfPSUWh
 iSA9rsqVeFFUvgKlGaRyg=; b=cb5EgtztkFwtswceVpySDKv2YiiNtvJxKTFa95
 SaYIkg9m/dMvq1eQwuQUhc64aywTK121P4UYmL3V3OsNbBlW+/WYKbb2wLgJZB6m
 rvY71m1BsHr0oLYnj86o7RwR8qd8kRZb71a2/zNj8Vvw+UFE8HZDAdTX4eWGPa3n
 uhLJyvhs3/z1MpW/orFtK4v2PpxjGjwi2XtFhvXAY1dMtOV+1WCOllcPm8dsNSBN
 t0i5SQfRgU4uKtvtDd6r60F9lNXzbA+VrwzksFICTDUWpUycRnsVLr8Ojb9fKJ2P
 bhQUeiyyQcVyuQOaxamEFzVs4FccSgWPK0ZQJh11eiwRxlYg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tusp1e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:04:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so3628006eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782594287; x=1783199087;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ccglRRuGK/fXO5fOfPSUWhiSA9rsqVeFFUvgKlGaRyg=;
 b=avMfNKURhQcXcf0vwAccrGZxoVxV/TdVZTpDRZrKnZCYeHZTAey13/cygvU0Z8118X
 Xw8wRRKJJMraikiLLD2VI0QOGQdtBv1ZHAUqP8G+sVYXl+CtqSPhQBiJO+OG/YUFufxc
 zZDTMrDV52G1SyKrdxmJUWQRKQWRffY0Rx6MhFqPa1gilz04o4XHvDlH1qi3nYgMCMD9
 Ol1rq0XbLT5ZGsxqsrdRCyDSC5QUe0Nv2mAgK48tR2hpDQKSkcKbR40FsNH2zfTSUv9a
 +M7mB746Lup5zzvGHbnKRZnA6U3UgodxWtBz7HkOnoJ/aTVzTOJeoCmCQUXwuglUjUYo
 fWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782594287; x=1783199087;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccglRRuGK/fXO5fOfPSUWhiSA9rsqVeFFUvgKlGaRyg=;
 b=DWhOhwI3z1OR41JpZc+3wfFYuCznJDv/OvQEI6zS51YeLcblul3oyipzeXtBKazEHL
 3JSt8OsfjHBdfy5uFoMyD2rvQFbeUrJNV1h2BH1Jv0w60XsWypJu2Q9fezJLxAecpFkP
 RQSSxtT7Ys3x15YbqSgcILZ6JDrhKi2CvO5HfkXG2Fus4qVAozbTTFgyvAezYcr41pFj
 4E0y0wNRuJUsdIdbee7YznlpLVKNa9Uwoa603DOycydlkSJjb097viIM6iQJul2t7uow
 ZRMpN8QccQ9W7Xquln4bArW/LLm2Cs9ML7KcbRxrJsRci291/Zm50M49hAjDirum5O8J
 B/+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6btOELLfd5cYYdt6/QqO86YmGgWjlJKlQGtUXI9eMyt3VrW8C7EjZ4iDeEwpz+MYyLpZOqNXWdqA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywt7UcdTrnuYmyFEFuCokv0tBS4Yp5Qj7VsRrRJt8cn1DoszVVj
 0/D8dZV4wsdI7uFXld533KiWps8UlTvWlNWAcmHk5eNSvDxAQ/6X4JVcuNyQ+AfqNFlTxqS1V7X
 F10ayFljrzVGnBlRecBh0qY22hUM3HXmO4EfmDtVA1OdMMAN3KHWEPlozHpDgMCe528MsoV0=
X-Gm-Gg: AfdE7clUsK0NV/w4Pof/ohqCzC7V61eLLuCRcWARQ4GoAW2Z42Hbbej1/xOk090Vsml
 aCZLFyvQp1lHrGI/aLX0xc4QNnoIaOIXV9GdfKy4mkt31eSV4jzpHnNtHNDSarIsfZqUspifHwK
 fgsTIV5dbskDBkousUp9MeQhSs63bx1sFdfj0U/Bnrqtswn6Sct/q3wrb8+9uijXjRLPCvDSJWr
 LtiD1ytBEl6qU311eeUBIBPtFuW2znfxInFuU1VZWa3O/1YbgFsWqu/Ez7rizwuIy9+iruhxOc2
 EY3Pt3QDtoO/H6moeA9/zi+uDRS5dyqZ0JakgRqkfGQe98Trd4+TKsfzisVcjQN0nn9FuQ+TCWe
 8l75w+vx79BCye0Qjq4Z21QYKaD1XlaG7FNWi
X-Received: by 2002:a05:7300:7fac:b0:304:2176:a871 with SMTP id
 5a478bee46e88-30c84a265a1mr11516584eec.0.1782594286571; 
 Sat, 27 Jun 2026 14:04:46 -0700 (PDT)
X-Received: by 2002:a05:7300:7fac:b0:304:2176:a871 with SMTP id
 5a478bee46e88-30c84a265a1mr11516564eec.0.1782594286043; 
 Sat, 27 Jun 2026 14:04:46 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c664sm34561999eec.8.2026.06.27.14.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 14:04:45 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Subject: [PATCH 0/5] Subject: [PATCH 0/5] drm/bridge: lt9611c: improve HPD
 handling and driver robustness
Date: Sun, 28 Jun 2026 02:34:36 +0530
Message-Id: <20260628-hpd_stable-v1-0-13d8b732c4c6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOU6QGoC/2WO2QrCMBBFf6Xk2SlJupCKiP8hIllGjXTRTipK6
 b+btr75NBy499wZGWHvkdg2GVmPL0++ayOITcLsTbdXBO8iM8llyUup4PZwZwra1AilRcxEVSm
 jHIuFR48X/15kx9PKNJg72jAbfoken0NcCWuMNUikl5VtsltGCq5ElnNepXmhJAigzyc+cqi7N
 vihSW3X7GfXf7MUAupQzcfkQNg6eAngkEttjHWZMQIPHVH6HHQdNT/XaZq+ZCYJAQcBAAA=
X-Change-ID: 20260628-hpd_stable-6cee31998b8d
To: kernel@oss.qualcomm.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Mohit Dsor <mohit.dsor@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfXy3TYRH6YkhXv
 MKEO9tmH7axcSSc+lBfSkQLwq7xicIkFVeoYa0uUPIwbK2pMyrFIvmyUo0c2z7VRSlr8aBhabSs
 DV5uF6+aBdcSlE74IzUQXgsAN8Ys4g4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfX0D2Fk+Kscwwv
 QXRNJlj9iXhcuHAIx0JVXGgwG154mYYEp6RIQKM8S4fD3k0+RLD8evR0MkebT8Y4s3gCEBAUFg2
 J8aswo4gv0voBFusze56Fh29uPhMVKWwe9g8Eiuz4lkF6OaezKIPfVoamkAkfI202S55+tqqfjh
 P9lQM9WOvvfCYmEAcxu6g1u8C4+Z7vTu05W1PWpiGNAjXcLQ4dapYVlkBhu1tqlE3RJPhjWIq4y
 U0vROBBxY4TrDn8WSw4HclPlBTHn1gacAGZTcLRKjIqB/odugqFpTKJcxLkYxK6rlwbXJP8EF3k
 fb2ZsYx5nhRQXLO0e2xbWErQ41+1L2kZB2fhKvqqctoApos1TO1l8cTS7WbeHZ8/9pP8vk7PZpf
 CWMiD3aaW32NiAfJiUnJAf2X6Y+Zg9g74N0yh4dn5UR2BbWyb2lUz/BkajSkVoentMKfWewX2gz
 3m69XcGlPNSwppZde4g==
X-Proofpoint-GUID: mt9_t2M2DWbJjHf8Nds0mJaVuUtuFvl-
X-Proofpoint-ORIG-GUID: mt9_t2M2DWbJjHf8Nds0mJaVuUtuFvl-
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a403aef cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
 a=Kz8-B0t5AAAA:8 a=QVg56k9-0GPyMsqHAqoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=D0XLA9XvdZm18NrgonBM:22 a=Vxmtnl_E_bksehYqCbjh:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270187
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

This series improves HPD handling and overall robustness of the
lt9611c bridge driver.

The HPD status read from the internal MCU may fail when the device
is not fully initialized, leading to spurious disconnect events.
This series mitigates such issues by falling back to a cached HPD
state and adds support for explicit HPD enable handling.

Additionally, it fixes DT parsing and bridge refcount handling,
corrects chip type initialization, and cleans up probe and remove
paths to avoid redundant or unsafe resource handling.

The changes have been validated on LT9611UXD-based platforms.

Changes in this series:
- Fallback to cached HPD status on read failures
- Add hpd_enable callback implementation
- Fix DT parsing and bridge reference counting
- Correct chip_type initialization
- Clean up probe/remove error paths

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20260513-lt9611uxd-main-v1-1-49e4ee4eafcf@oss.qualcomm.com

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Mohit Dsor (5):
      drm/bridge: lt9611c: fallback to cached HPD status on read failure
      drm/bridge: lt9611c: implement hpd_enable callback
      drm/bridge: lt9611c: fix DT parsing and bridge refcount
      drm/bridge: lt9611c: fix chip type initialization
      drm/bridge: lt9611c: clean up probe error and remove paths

 drivers/gpu/drm/bridge/lontium-lt9611c.c | 39 ++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)
---
base-commit: 04c2c33c284caa521524328939d67d78d581ebaf
change-id: 20260628-hpd_stable-6cee31998b8d
prerequisite-message-id: <20260508134009.4582-1-syyang@lontium.com>
prerequisite-patch-id: e9ce15b4a5842cfde130a813afecf136798179f4
prerequisite-patch-id: 569618a60e8c3615e7347c79b48c4756b7bf85d0
prerequisite-message-id: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
prerequisite-patch-id: b73480be758c902f497733155b478248a507931c
prerequisite-patch-id: c6eb91e2966154892770cd77785eb140fa0dba5e
prerequisite-patch-id: 536e974105afdf99db85a6d117b69206fe7c50ae
prerequisite-patch-id: da212266879bd72ab2848551a5e2dda4a1ae5c90

Best regards,
--  
Mohit Dsor <mohit.dsor@oss.qualcomm.com>

