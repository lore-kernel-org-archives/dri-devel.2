Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F1FC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E1D10E057;
	Sat,  4 Jul 2026 18:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CSEUNTWN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bkqGflzf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9478110E057
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:32:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664G9f9d3429949
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Jul 2026 18:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=MltfzpfpaLuZDnkNZx+Lb6
 VWJ4GPL8eKrD3GSx0ATGM=; b=CSEUNTWN1DlO1mccs9tBOSMPvsm87QKPUuehKQ
 4K6kTjt1FKnv2ec0M8Ysv/X+5cdqXiRHqij/ORCYEDmUr+Lvfqi2Bb10tvUqlWYK
 6bUxEtHDeSVXR1YlKacaMujOYA044wSdNr9b9B9nlb84ycDuDYWoCL+A2qahMRDh
 QaXY3ntdMFBxDIr+RrCRCbj6/BLG0BZQLRU8QJzw6wEZsRPcqLF+9/q4Kr6AjCvh
 6HdIKJwHHUAO8X324yL3sIeCAbzFf/FbdmaEFj/XSnPAux4wnR7Iw7HkLjguUK31
 c2tOSjRDtb3pqINNlxcgrFkpU1+GI/Hxp75MpAT7pOVePlMQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh1f32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 18:32:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8479b45ad08so2700611b3a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783189954; x=1783794754;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MltfzpfpaLuZDnkNZx+Lb6VWJ4GPL8eKrD3GSx0ATGM=;
 b=bkqGflzfDvhoM8r2XLTCFImGRL4bQL5nHDsxwegaxVwUwMFv753KM501f7IaxzzOLR
 SOi+U9PY6QIiIGpELlXD6ie/IOfGmWORtrV7HsGJBce0QWRLnQKQswGJYEPH/wcDhcVS
 XYCZ+iSw1dzbjvd+OimOWoItTaLZ6Q+PDAhlDVLUxcTNXMyPQhwPZUC3NRC6R87QPrRo
 eDZK85yiELZIjZO+Yj8JHaLWYZBfeU9srRFqmM3q68vzpY9GHl9kSlH5yoCOk0judhwV
 udXfZXDM8MP+B1K6M3GWrkp9p/RXFwmEM0k3oLzBlLLja6NTj+d4thjZ3c/W1/xTL844
 uG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783189954; x=1783794754;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MltfzpfpaLuZDnkNZx+Lb6VWJ4GPL8eKrD3GSx0ATGM=;
 b=IuqbVTdwwSA5P31hER39puF29KaEjjlPzH1Jyo5ZXt5TV1+EJNuYj9PC93gVXtKLNu
 B+pHBaSbFGphZLRQuWkO2oLtjvG98qsLDYzJDBdooFaQgaQHuGNvBrhBaVrGp3nyswsv
 J4BWl86rVJIPBqw0uVxCMWw0QRUDG7m2U5GMnYCPJxcJdT9dQ7T1TD4UD0kRogIBP3dL
 O4zwSaDxEChsHGLsjo28tCx+Zizqb7jOU/ah39YkUWdIcwWipUMI5LCLnFG4T3a5+j0d
 IgZx4hoXD6TCbFYFv3oKxh4+ao1nzPnX/9dEkOya6YSEBEn+IGnobWWRDVTZALTZYyEf
 e+QA==
X-Gm-Message-State: AOJu0Ywo00eVfsspFzB+W/V+p/LpJtzPWMFEYmVf3qdMpJWYKNwFhlmZ
 5VomvaPsRLT65VubOnx1um+L2akGA8NcqrzL3M1McuHJKXsg44jDSy9KtjPWYlKvp0X4sgiLLB9
 Ols6ePttT3KaEydGM1POLZPN/XBP/+XTZZi+ZQR1hGLHzbmjNQkesqpcf1wXUOI+mYTLxAaM=
X-Gm-Gg: AfdE7cm/TCAD0ISHkF2EHkuweeYCM0Hf8idCX8v8bxnbU1V87eV4SkbMMs1OPBqS939
 b3zGCuJp4b7AcSIbPBAAPrrc+uw/Cx926YcZukPpKmyjRlrdVcrZC+P0aPbn8QKiQpmWupN9UUD
 ExD4KnmF9LjVqGkdLmfv57c3UnPECjjclubI6wRFkoPbb4TAb0ZFvK5B3ea7WiHUUTT8CzmNZiO
 J0j+Zie8huJG1dLoMger0WyxqGC7HLeN6eQRO3vIfjoBrf9LptCnRJ3fYp/Br+f5vvM//fu0OjG
 abDDNs9skzz8e+0I8WL8IXHrLq/FRvcR/A7NljIBQoTE5lf85noH34vEzv1Z4EvcQIrOjjWSXRo
 zfSFXH4macIMbHJH4os8VTnk=
X-Received: by 2002:a05:6a00:1881:b0:845:ebbf:e7be with SMTP id
 d2e1a72fcca58-847f6dd3dd7mr3575636b3a.23.1783189953613; 
 Sat, 04 Jul 2026 11:32:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:1881:b0:845:ebbf:e7be with SMTP id
 d2e1a72fcca58-847f6dd3dd7mr3575622b3a.23.1783189953074; 
 Sat, 04 Jul 2026 11:32:33 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 11:32:31 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Subject: [PATCH 0/9] drm: replace simple display pipe users with atomic helpers
Date: Sun, 05 Jul 2026 02:31:09 +0800
Message-Id: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CMBBFr0Jm7SRtNRC5imFRyqijFLBTCAnh7
 rbi8iX/v7eBUGASqIsNAi0sPA4J9KkA97TDg5C7xGCUKVWlLtgFj8J+6gnfXjCQHxfbo9JWnbU
 rrTZXSOcp0J3Xn/jWHCxz+yIXs+2/CPSZUzEeM2itELrRe451kTsDrRFzGVWJpoJm37+GdJ5Cs
 QAAAA==
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=3497;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=a3oJlDmIy4JLxHP8+Zy827sxSxkG1qtSrEiIUv8u7fM=;
 b=oTFO2p3qM2CB2fGh5FbCqHWfsLjAUpA01rJUrP5DdH2raMv7Em7rY0rPoVQz7ExoGxuGHOYTD
 NpzXPoGsHqtBE5XHc7JyEmeSHN8I2421kM7XwjgHHvZaekp39t8rsAh
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4951c2 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=mcgfQexBA9BlAWrkqKUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfXxQJXtwm+9wSy
 XK0kJBL+UwIyPjtMN/IU1TZFno7Z3cDMPvHb8ay90PJanyT9y0ueNR567TimEbPpXc8xoKACrHX
 1OXeqAh/Zf+e2jCAw4EzeuhsC6HrclChA0EqLjTU2cinDM7XPH8zNXG8k0hX65g7zVeErOZCr/v
 4I51PNmgQbfgqkvnWlYjVwsWHoSyEFdrJCUPSrp0ZXJsMXmhvnW92fvHY7Bz2g1A7aHy+/ykpBp
 Z0to9oliUGNkIoKRs4GJzmF+fhuk6UstgL9YRNlsnzAfoOcoOREpIt5OpGtdfzzxLFVDKM3YQsE
 0a8wAE7BqywsO/IBGHTkGYNk9DGILETrUQUJmcIYYazXCR/DwVLoTSm9lUnDRy1QQTefBvgPjep
 4I91xcQPwLVekYaL0UJytw/jvWeURd87fYcrw7ZVXp8vqCgBn/06gV/QcmUd7tbeZmH8UNUsKeI
 9dqvfB43DIC0wiLB+yA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX7xGIcoVkKT32
 Stj7YmePYf/jiwFy8VLZvRdFeLy2bDKydxXqwccGxypP8CmDnSerXNeL4JyvDPl0eN4g4QQWOXe
 205SvT1u02yAL16Gs+VZ6FsYkN3AEAA=
X-Proofpoint-ORIG-GUID: J3j9FJLP6HYag2JLAgfehZXHOfEV0UHG
X-Proofpoint-GUID: J3j9FJLP6HYag2JLAgfehZXHOfEV0UHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040192
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
  - imx lcdc
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

These changes are build-tested only. No hardware testing has been
performed on the affected devices.

This series is based on drm-next-2026-06-27.

Thanks,
Ze Huang

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
Ze Huang (9):
      drm/arcpgu: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/aspeed: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/imx: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/mcde: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/pl111: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/gm12u320: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/repaper: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/tve200: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/xen: replace struct drm_simple_display_pipe with regular atomic helpers

 drivers/gpu/drm/aspeed/aspeed_gfx.h      |   5 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 156 ++++++++++++++++------
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  |   3 +-
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c      | 178 ++++++++++++++++++-------
 drivers/gpu/drm/mcde/mcde_display.c      | 162 ++++++++++++++++------
 drivers/gpu/drm/mcde/mcde_drm.h          |   6 +-
 drivers/gpu/drm/mcde/mcde_drv.c          |   3 +-
 drivers/gpu/drm/pl111/pl111_display.c    | 174 ++++++++++++++++++------
 drivers/gpu/drm/pl111/pl111_drm.h        |   5 +-
 drivers/gpu/drm/pl111/pl111_drv.c        |   3 +-
 drivers/gpu/drm/tiny/arcpgu.c            | 165 ++++++++++++++++++-----
 drivers/gpu/drm/tiny/gm12u320.c          | 128 ++++++++++++++----
 drivers/gpu/drm/tiny/repaper.c           | 130 ++++++++++++++----
 drivers/gpu/drm/tve200/tve200_display.c  | 221 +++++++++++++++++++++----------
 drivers/gpu/drm/tve200/tve200_drm.h      |   6 +-
 drivers/gpu/drm/tve200/tve200_drv.c      |  17 ++-
 drivers/gpu/drm/xen/xen_drm_front.h      |   6 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c  | 177 +++++++++++++++++++------
 18 files changed, 1164 insertions(+), 381 deletions(-)
---
base-commit: 3696d07837d1df13a5603d77f667685e7dfb3c53
change-id: 20260704-drm-simple-kms-removal-01a031c6a129

Best regards,
--  
Ze Huang <ze.huang@oss.qualcomm.com>

