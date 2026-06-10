Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB13CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C03B10E6E6;
	Wed, 10 Jun 2026 21:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EkaUc6xB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gj2yl4Mo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E79110E6E6
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJYfn52516568
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=aH6bsVIeV+YDj6V8Pt6RtV
 7WwW8GwBlSVsbE7KsyT08=; b=EkaUc6xBbL9xjFaDfQkn/FApDMYu5L5aqcwM8C
 EQCF6v0BDmh6tO6Wg3qMRpi88PMc1bG3ZZ14kv1vodqn5RMeoMYXxbDIrZOEil/H
 DhJXpGNZUpx9ULZWEO2SYtEh5RR6kjd+KhtidMFFiwY9n5hXpIHTY0FKTVBNz+im
 YBUh3Edip2X/rZx74Nvot0k/Cj3yoEReNa5pQgk5ADh9v6Eb52WxVFRrlzIyXxbo
 okYFFETgImIbBI87cpLaTARv5F1nERwdOyvTGDLmOB7veBSUnGo7yBBRBGJorVUS
 MbGriPxeY/Hp1xJ05oOdgeiL1WScMPpDcjSQQoqcDmNj73UQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sgeua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36d98b828c8so9709147a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781126107; x=1781730907;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aH6bsVIeV+YDj6V8Pt6RtV7WwW8GwBlSVsbE7KsyT08=;
 b=gj2yl4MozMGeFwWlcUHH6ALiGkmllNJVXTuoAlYVoH66EuE9tD8N0O14b90u1FUkch
 zxUSBkEwUhERPi3BLbpiwAMqgsg61p85rCG05gueNCDH0Xp2obW6VvP2SRjx8GWzvQ76
 tdk9y00fVL+4NxSRc45QTQY/0I+rtScOmbxifQghoZB4cEKpoOmgVtfhcrSdFedI6u8r
 0Kt+7nH8njnp3mlc7kb07E6NY+AiTZvIfgc7j7suUfujYVFC6Cgbw+3l8UUaNGuHIV3t
 5wdXI+3oOeA/Ay1zLHI3kYQgXohJMIXukzQPnC9gD7ifwDiIQ7c8+hBB8uWwvrMfxwFL
 rlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781126107; x=1781730907;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aH6bsVIeV+YDj6V8Pt6RtV7WwW8GwBlSVsbE7KsyT08=;
 b=Ig+VE5KsYESxaIM1/I/0V+h54aY3x/Q3oQ2H52u3hwOKc3JRxEgkjrVwb/ic13XQMe
 pAo/Fhm6AWn9mzLdQHfK6amzQoRnKNpT6+iWZN2+k6vHiKs5akP6dJpc2IgzC1C0Q3bV
 obLMt8WbIkryif7qqW13/sMLLfDzy0zQoZEk8uFpaCy4xP7I4HBu7XlzZh6vU+TNjtfd
 QwuElfEnTiH8pQWJDbrkwxey5eM5zxv5cjZEjQQcoOj1MSs9/XfO4ScyHX8QoA89yHSj
 9/1HFP6b4LQ71UnFI1yy/pFtTQj/Dff4CxypeCSmNvNSvuYXI3gsYfxqqpNupKy/p7UK
 FCfw==
X-Gm-Message-State: AOJu0YzPePO13vLk/UcbwCk/17mSgK4IE20m2N5c2s+0RTRoid0CcMTo
 egOcsmiqMW8/3KdocgZhFDx6UvnM8AXGHgORgDhs23jdpgWtntRVmmwQUPXckPwexbfsIK98fWr
 7tdBotnZ1Lit7a8jQMo2eZU5a86nDkXCMsZhHids/RvvsE3/ilxtdTbqwWAoYsMgXNqijIhw=
X-Gm-Gg: Acq92OFFC74Y5HEOPX566LMFk+i3ASVjZJ5Dpse+OFwwRMAWFp/s7GtiFSuDPOIC/ZC
 QMaqks9xiqldyhUbJrO2aTjgBz0l1zXqq2iw7Aw2i0e7Mgn17EM71R2it9Ja5Om0ca1aNZrRHZ+
 tDeoeafB6tlvGdjh+6+L1loLnrXkbs6IG/0KUegvci623no4/kiabBtqiJ9PaQ6KDnJ3AfUgeVM
 wjTfn/RQYsvd6UohFAf3UndjWW6yQZd7iBWZeAbMUOXYNSouXxOw/OSQELFeXST9zsdOjmvz1vd
 agOXUdqBSsD0yiwZ7gblnRnC9FJcxScZVjY+ArmOfmvZS+gnGZT9xuj1V5eEwjdQMUE4Mx+EzKG
 KNQW6mYItcgCdXO7zrkbL2rMqZpnA7ToaynWPw2tcbUVLD5C4oaIBCazbfQ==
X-Received: by 2002:a17:90b:5827:b0:36b:a0fa:ff96 with SMTP id
 98e67ed59e1d1-370ef1f2cdemr28232055a91.12.1781126107002; 
 Wed, 10 Jun 2026 14:15:07 -0700 (PDT)
X-Received: by 2002:a17:90b:5827:b0:36b:a0fa:ff96 with SMTP id
 98e67ed59e1d1-370ef1f2cdemr28232019a91.12.1781126106417; 
 Wed, 10 Jun 2026 14:15:06 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37753d01cc6sm309490a91.11.2026.06.10.14.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:15:05 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Subject: [PATCH 0/4] (no cover subject)
Date: Thu, 11 Jun 2026 02:44:55 +0530
Message-Id: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANDTKWoC/y2P0W7DIAxFfyXieVSYEjOiatp/TH0AbDamJtkCm
 VZV/feRdE/Wka7vsW+i8JK5iKG7iYV/csnz1ACeOhE//PTOMlNjoZVGhQDyUt02gpGFJ5KYgI4
 uakKyoi19LZzy7174dn5wWcMnx7q1/CcW/l6bqT5iYuRS/G4autMuMlo1GRpzAN2DskqCLNdru
 +f1Mk81r+MhzuPLVhd8YdlgzHXobECI/bMihyYZ59KRfXJI2FvnLWhL5NsbQZzv9z+CGvs++wA
 AAA==
X-Change-ID: 20260611-lt9611-b4-send-6f1d39c2d6d7
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 boss@oss.qualcomm.com, qc-display-maintainer@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a29d3dc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=xVA8p-6yhMX1th-SxBQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: atgClFvq_VmgQSee07JveGJU0rju4PnK
X-Proofpoint-GUID: atgClFvq_VmgQSee07JveGJU0rju4PnK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfX2SqF0Gm/qDvw
 dI7RBiKHjbgC5tueY3ImF+bhYDIw1I9zd9nY8o+AXoFPdGK9co1Gp9uDXG3QjMn6T1pJRex6qby
 1IM/ZRTwMXz5ouZnCC5jXleTFon3v6xc7owjA58y42tiI6X9eLSQOG+rJDUP7/d1efar1m26V0B
 VkOTnaGv0OZQr+6VLh8jdhXIZ3DDnfm1NTtmE4mlmKSOAVxk85IvsVJFoYsUF9JLiOTgpRXIiVp
 AW/0Z1gPMQ30RAdGQSDm6H0ohfL9S9vt7xUEqJmXUJNSXQke85emASD+5iQcutDdgjY9c1spWjC
 nZpZ+7BnLIZaJ3fcncn9RncmliPQ3xDzkzXuNiQzugVAcnvMPekyVQdGxXH+nB5GGrzTx3r2C6z
 /AMb5D21++TmVQNkcGLdWoICLoT0XZ1l/dX3D7nZWFD/9dRVs8MRf+Bb5J4s9N+W3bG5wvo61zx
 +VNVOU9pnLy1HHskt8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfX1OnRuA+Dbh4v
 gmElHkQbsJBSgG71Rsed7+qaDpYwyPZt9q6LD+kUStC1Kthvha+FJqyKjY1WdprECD5RazzZcDZ
 7Cn3pvVQ/QjRp+iM7dNdNisF/499ovA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606100204
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

From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Subject: [PATCH 0/4] LT9611C improvements and fixes updates

Hi,

This series contains improvements and fixes for the Lontium LT9611C
MIPI DSI to HDMI bridge driver, along with DT binding updates.

The key addition is support for selecting the DSI input port using
a new device tree property, which is required for configurations
using port B or dual-port (A+B) operation.

Summary of changes:
- Add DSI port selection support via DT property
- Fixes and improvements
- Increase MCU polling timeout for stability

- Add dt-binding for port configuration

Patches:

1. dt-bindings: bridge: lt9611c: add port-select property for LT9611C
2. drm/bridge: lontium-lt9611c: Increase MCU poll timeout to 200ms
3. drm-bridge: lontium lt9611c: fixes and improvements
4. drm/bridge: lontium-lt9611c: Add DSI port selection via DT property

This has been tested on LT9611C-based platforms.
Please review.

Thanks,
Mohit

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
Mohit Dsor (4):
      dt-bindings: brige: lt9611c: add port-select property for LT9611C
      drm/bridge: lontium-lt9611c: Increase MCU poll timeout to 200ms
      drm-bridge: lontium lt9611c: fixes and improvements
      drm/bridge: lontium-lt9611c: Add DSI port selection via DT property

 .../bindings/display/bridge/lontium,lt9611.yaml    | 13 ++++
 drivers/gpu/drm/bridge/lontium-lt9611c.c           | 79 ++++++++++++++++++++--
 2 files changed, 85 insertions(+), 7 deletions(-)
---
base-commit: 7b61c580d964f499f3eaf96d6579a7127dda606b
change-id: 20260611-lt9611-b4-send-6f1d39c2d6d7
prerequisite-message-id: <20260420061644.1251070-1-syyang@lontium.com>
prerequisite-patch-id: 5e0ea8907c87174a28fac5456fc51183d8e8b36f
prerequisite-patch-id: 6fd8685174c2c83b8871d9e6419c6f3bd29ccc1a

Best regards,
--  
Mohit Dsor <mohit.dsor@oss.qualcomm.com>

