Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9E8C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF81410E748;
	Thu, 16 Jul 2026 09:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V+6oa4N+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kYJMaVf2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADD210E748
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:02:50 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G7XaQg2176486
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ublGuK2L8LkFww+I8N33BP
 NROB2FHlpEAQq3id5WGFg=; b=V+6oa4N+LgdZwM5OLLMLzcpu+E7cXBM2MjtCEL
 paYclXuXv45UgosyH+b9jNiKowTXide2Ruhznp2OXf7vih/6t8cP9bhAYTrzPSt/
 jwyj/Kl71gtpnD4kZrMhdE08ty+lQDmLltP4kJyeqX/U1d3yIHP+be9yi19Bjbyj
 SH5VGFy1EQnvdryRsoFC4scN7YkeMd7XyOzadCndh4iPReYTiK/1SpI9rejhWLFs
 J889JR4PrWpy90cTbVS6USh7agUADPwTnK6TH/bG9yig6w22YsSkxL9A7Z4ZAD3m
 qqv71vdY/Wi3BhnG0Ug0fBLjBQLCOvcd6SUZuiNjnMDruDiw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu108abn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:02:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cee894b3d8so56392255ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784192568; x=1784797368;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ublGuK2L8LkFww+I8N33BPNROB2FHlpEAQq3id5WGFg=;
 b=kYJMaVf2qm3hQWXkm4xnQGEC7S3upjHQmPAdneLPLnrVOyt1X9+kdXVIYrkIdPHNtp
 cb1MOv+YHbzIUIKgX01JmZUg7PzyV578GSoieEB964euq23UZgA6RoNwUWYecnn7VZvH
 2qAfKfBni/247f+7gTzz/JlrY2ULM3KImN0xOzh96+boEUMHWuKLFxw2E6Tb95NLTqUH
 ojbM0l4flWjNYvfZ8RxcWqoAoAUkKOiRGEAxl/9SXMitNQIf4SMkXyNCeNgRMGvuRiI/
 l40JsfCvqQ6TLjhnMmTfRFuIKnVQLrh82LMtITizggjul3imcVc6kODuLUVgTJ8Bj7QK
 ZSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784192568; x=1784797368;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ublGuK2L8LkFww+I8N33BPNROB2FHlpEAQq3id5WGFg=;
 b=sjx0HQaxUuJIiUdnQoupHe1feaKzdFA4zOSC5U0+2qz1GmeoK82GiUU/xMU1aBKXA+
 SVO8IEsI1g/CLrbWgzuE0zka9pxUEIpSYoLIHgIa+7KQTLfAqYmLixZ1I8NHGFG/0J16
 gOpqjn327ZdsovAsQ0axO0jCii5M0dKAyFfg1y73fnLDWSAWPH9IPFrCTjbLg26rGl5k
 gsPvD6MaQwOPe1AQdClaFsHSYKcCK0wO/oIR7ZrUMHy/k2Pasa3sXXUtdyLIf39gf2Mk
 tQWuOABdRORTntmnYdSXkZCT3C8eBSSInYJgHCrOcw42CutRe0Eq7f51NE/wCLU/9qTR
 cNpA==
X-Gm-Message-State: AOJu0Yx3ZCCm358/qXqnjUSVh3p2E7X4UnNjJRIJKNkCDAHRgxNGJb0C
 FaI4DM4wW5X53FYwPCZKCg7iGdI6thiVDIrIc+IhrPq3GtBQ/UjnD/06Sd4Y3ZqeChq7RyezNBx
 xybvFDAQdjBFJgy2JoHVjLQl9yhM/KecCX4ECwWEjhx58fehT27kljUApFPbJToVgoiSXUJU=
X-Gm-Gg: AfdE7cmBT4M/F+8i0YsSL8Xf7tiSchY+xsz8UtriBiyMWWv+Br4Whwa5wErNQzb0Bh7
 Hu5hmSUbK8UsCO/8FyfGstFKurW7IIEe7bw9sgoXOzWe+z08unplA0CtNAdtc1L1oZkTqriq+3w
 vA4io+3rjVXPbegORGKevXYdGdzOoUh4j/GMlaZPPLcZkaoFJsLgFpyKSNxG2QssFP0flI/pBLw
 vp5qQBToaVI8aiPjw57r84xQJlnPNmudEyYr6osxTJOcYICWxkSsSys7TVV1YX4KcwT8KXtOPb7
 jdskMIbemBLmJeXtZhrohpUoTZ64GBAN59rq24OiaaGiHiYdcnMBx6Adp6B9SQ2whGovo+VVS7X
 hkzhAlQ2fOjx82jMRDyon
X-Received: by 2002:a17:902:d4c7:b0:2ce:faa6:7cbb with SMTP id
 d9443c01a7336-2cf03bd52fcmr58054565ad.4.1784192568021; 
 Thu, 16 Jul 2026 02:02:48 -0700 (PDT)
X-Received: by 2002:a17:902:d4c7:b0:2ce:faa6:7cbb with SMTP id
 d9443c01a7336-2cf03bd52fcmr58054215ad.4.1784192567515; 
 Thu, 16 Jul 2026 02:02:47 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf106b271asm16592555ad.64.2026.07.16.02.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 02:02:47 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Subject: [PATCH v2 0/8] drm: replace simple display pipe users with atomic
 helpers
Date: Thu, 16 Jul 2026 17:01:52 +0800
Message-Id: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKeWGoC/3WOwQ6CMBBEf4Xs2TVtUYye/A/jodRVq5RitxAM4
 d9t0auXSSaZmTcTMAVLDIdigkCDZevbZNSqAHPX7Y3QXpIHJVQldmKDl+CQresawqdjDOT8oBs
 UUotSmkpLtYdU7gJd7bgMn85fz339IBPz2i8R6NUnYvzGoNZMaLxzNh6KzGlpjJjJKCpUO8hDd
 8vRh/dyeJBL7/dt++/bIFFgvSFptNiWlSqPnnn96nWTYeskcJ7n+QMga11FDAEAAA==
X-Change-ID: 20260704-drm-simple-kms-removal-01a031c6a129
To: Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, xen-devel@lists.xenproject.org,
 Ze Huang <ze.huang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784192559; l=4273;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=LslnXr/GYqt7lILfSX6H30ANs5TVBAPc61jkQsfXePo=;
 b=Qn3SgZ3Jcpq2dbsoxobIntKn1Fa949LtJINyO/lyXEjkZuMSQIFchq6+tnE8WqT7IXdz+1rFS
 ByTjQjwu366A0YatYIUCp3ydGB4Kf09fwhed1OK9kDkxik/D9RYfMki
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-ORIG-GUID: jL_iEZBIYRlbPXb4MWHxh2Mn6mcuEPRF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX2XYYh6+CxRcM
 MZ7egfzn49DKFIV/SzByzQsr6bnM/snZKXLfzDoTGqrIsASr4MUSs3UxP1I4vtX3S+EhOti5jAm
 9NerFxQDZW5KL/YT+z/sWMmij3ubnCgmrCh/0CLzgSCgKJapMwTb2DujUFlvkmcs3ljNgPJQ6JZ
 UdGaYiooTUBTDNrwx+t0VlHD0fk5zJqjIm4KznKldEZI7MVZXl2AgyquFcD8jXs1+4FvQ/vt/UY
 mZmVWnTzgAJMbUMV0qhaZkuMvUo6+yL0Bkp8rMKf4QF6q83HfKN7NXCYs+UgUqCAwyOksSDjDL1
 yjuZozFVvgFFNVSH9m7U+q3ku5Yiz7EI97VlFUC85bCf36uJcunXzzOrBvMd9tjofpL/8U9MUy4
 4QlDZQo8V+1xyHAUzx/44dEAYNPAbxYQGZxmdVZxT+ZMVlK/gCy5ja0XaWvZzlCD7z5pxL9zLC9
 OoWfrdfzLnCpuehZnpg==
X-Proofpoint-GUID: jL_iEZBIYRlbPXb4MWHxh2Mn6mcuEPRF
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a589e39 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=fqn4YNmA52JUfYToRRoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX5O1yUXw2uJNq
 pJiYeTEng/R3rv+WNPQbDew5wIcUezq/9czhK7zLFoSjoYTcjuAmKpOlkrbcezAjkFTKdm30AaV
 CFi5qV5iQXojXkMi1cAOnznQzR8AlHk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160091
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

struct drm_simple_display_pipe was meant to simplify simple DRM
drivers, but instead adds an extra wrapper around normal DRM atomic
helper setup. As noted in Documentation/gpu/todo.rst, remaining users
should be converted to regular atomic helpers and stop depending on the
simple-KMS interfaces.

This series converts the following drivers:

  - arcpgu
  - aspeed
  - mcde
  - pl111
  - gm12u320
  - repaper
  - tve200
  - xen frontend

Each patch replaces drm_simple_display_pipe_init() with explicit
primary plane, CRTC and encoder setup, and moves the old simple-pipe
callbacks into regular plane and CRTC helper callbacks named according
to local driver conventions.

The conversions preserve helper behavior that used to be implicit in
drm_simple_kms_helper.c, including plane-state validation, CRTC
primary-plane checks, affected-plane propagation, framebuffer prepare
handling, and existing event/vblank flow where applicable.

Result is less helper indirection and more explicit driver-side atomic
wiring, with no remaining simple-KMS dependency in these drivers.

Except for gm12u320, no hardware testing was performed.

This series is based on drm-next-2026-06-27.

AI usage disclosure:
- I wrote the first two commits myself. The remaining patches were completed
  with assistance from AI tools.
- AI tools were also used to review the code and suggest code changes for
  the DRM atomic conversion.

Thanks,
Ze Huang

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
Changes in v2:
- common changes:
- create upcast helpers
- use 'commit' as name of struct drm_atomic_commit in atomic helpers
- improve control flow in *_crtc_helper_atomic_check() and
  *_plane_helper_atomic_check()
- Moved page-flip/vblank event handling out of plane update paths and into
  CRTC atomic_flush(), using atomic_flush and disable paths for mcde,
  pl111 and tve200
- arcpgu:
    - remove reduntant mod_supported helper
    - change obsolete mode field to crtc->state->mode
- mcde:
    - drop attach of unused encoder
- tve200:
    - reorder connector/bridge attach
- xen:
    - change possible_crtcs mask to 0
- Link to v1: https://patch.msgid.link/20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com

---
Ze Huang (8):
      drm/arcpgu: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/aspeed: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/mcde: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/pl111: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/gm12u320: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/repaper: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/tve200: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/xen: replace struct drm_simple_display_pipe with regular atomic helpers

 drivers/gpu/drm/aspeed/aspeed_gfx.h      |  11 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 187 ++++++++++++++++-------
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  |   3 +-
 drivers/gpu/drm/mcde/mcde_display.c      | 251 ++++++++++++++++++++-----------
 drivers/gpu/drm/mcde/mcde_drm.h          |   8 +-
 drivers/gpu/drm/mcde/mcde_drv.c          |   8 +-
 drivers/gpu/drm/pl111/pl111_display.c    | 202 ++++++++++++++++++-------
 drivers/gpu/drm/pl111/pl111_drm.h        |   5 +-
 drivers/gpu/drm/pl111/pl111_drv.c        |   3 +-
 drivers/gpu/drm/tiny/arcpgu.c            | 179 ++++++++++++++++------
 drivers/gpu/drm/tiny/gm12u320.c          | 132 +++++++++++++---
 drivers/gpu/drm/tiny/repaper.c           | 132 ++++++++++++----
 drivers/gpu/drm/tve200/tve200_display.c  | 217 +++++++++++++++++---------
 drivers/gpu/drm/tve200/tve200_drm.h      |   6 +-
 drivers/gpu/drm/tve200/tve200_drv.c      |  12 +-
 drivers/gpu/drm/xen/xen_drm_front.h      |   6 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c  | 175 +++++++++++++++------
 17 files changed, 1107 insertions(+), 430 deletions(-)
---
base-commit: 3696d07837d1df13a5603d77f667685e7dfb3c53
change-id: 20260704-drm-simple-kms-removal-01a031c6a129

Best regards,
-- 
Ze Huang <ze.huang@oss.qualcomm.com>

