Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3898C982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 15:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D7110E1AA;
	Sat, 19 Sep 2026 15:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7ZY0YhU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Buj11gbv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1E510E1AA
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:02:10 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68JDJYi7198939
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1hfwXULKbsk4d4JT441CnqKGFUUFVn3mbcsujz6vsww=; b=f7ZY0YhUSOf0HpjX
 ctTCgwiYIP7vPW0r+GlufaGoFYZ+HV/3MvVfAGAdURU77H52IW909HGdolkoRK3q
 K1uXFKJA89mO6aghfcXYO4FkgWwjGTn8ISPsBIOZqrzdgASwLHKECgr/Uh7w1iCv
 d0sUMJWZGpwXPlwaiSoSn6sHKcoKovL8Vr2UeXApyJfryd70gFW4E2tohizGuNd1
 wtAOmPl7tRCSJVvrOBSGy5BlOJ7RXsXPk8tcqbqifVts6/p+tNhjeswj+3U3JYAr
 MTB55XZE0FNwyjj4Iw2e1UqZQH1/Nmun2WUm44HYuQIdcCThNZ3y6DGWcWEYnbDY
 CijVJw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshyxs6dr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:02:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-396901263b6so3193464a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789830129; x=1790434929;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1hfwXULKbsk4d4JT441CnqKGFUUFVn3mbcsujz6vsww=;
 b=Buj11gbvj87uHKt8K9xhjD+IimNvZ9psvHeLtYWJpFNBqM/6PdksaJRFcAmEUI1R5R
 dil0RjcBnftcFmu8QEezba0hLj3xdrC/mkdD+lBI238c74Z2g8BKKVSCvqb9l2mde2Vj
 73x1tYqUa4zF2XFOyWxgLg3ycwL1NOgfXpDN8H2u10Hc9K8AGTKy9uXsS6eURp197Q+4
 VCvWLbCpQ1covKjAWBkMparF5YcANqJyNUaIoG2KDS+8kQ5kJdZOXWT2pwqzCcrY5VCY
 cTy1eUU4BbZ1s9aSq/i1KbP4Hs/P7ZhOqdlzRdh1AwKxVAwPnFvbaChUShQTCjiyhyUG
 E7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789830129; x=1790434929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1hfwXULKbsk4d4JT441CnqKGFUUFVn3mbcsujz6vsww=;
 b=QvJLJ4qQuuKcf6ohjUYNItZBRAhYWu/pEIRMNtGmRi0woe6AdUicJM3MC03T+ihPcg
 XUZ2KHcdvwq9L2ZAGvNWl5pzlXXjrGWdS+N57O34q7lZC+rXodNRNvTymltJ5rPLcPtd
 lyQwmagIThpEnwSt6ocWSQkaTGb+1F+I0/r5ftidWIC7JwnGcVnTIYks5/fN9GRhCUUB
 FF+i4RpHIBh+ucVnqQNw2fZD9tBje6LwX4mL9z66CMkbzFu929mCbzEIF0q4k5fMewmj
 mn/2Gg4CLOIfZ7dfs2PWdq3HejraU4q1/rNugUfVsJ+bBP/CNcbch04C48BWSGVl0Zpg
 et3w==
X-Forwarded-Encrypted: i=1;
 AKwUvByCyEuBMZWO6EJPRNRtV4pqnA669M2YwJnf5XlEBFv3Yd/57lJomv5NuCgFOmOSM3+Rt9SncZxfD2c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1/kx0fR2L80QROW4NyjZ/rc/cVOaCnGovZPAmIrvpUd+x5dwO
 IWThmZbx1G2wCJKNfHYUjl4/voNeHp5JDSsd/k2cmULV+f8amB8YUSuMUFmS5uN0M7gMQmSJnxQ
 h7OK8nSfpiKB5c9ksuk5uDTWzS6DIBBahU0Sz3LrvHe209MLld0uvUwQKq5slHoAwlhjVzgc=
X-Gm-Gg: AYBFou1XLuV5XGWkE71DlZQk9W+LQFmbc6NWY2bJ0XSrA6tWnSurQOaUOA0k4W3cyct
 v4/YXARo1SOMxRApdM0FBiB93Pmx1ZstVeeIvyQXLrkzX8hQ5TEwDsKunUTgnY0YdcLQOGZLhfx
 j+/DEN+ShFmGiOLFazaX2vD3kmqzyyJrUBoMG/UQX7bXjBpN2hyDts5YBaU9v8gG9FLWb01M6Hb
 oKwgM9rB+2gIOTbgSBkZxc5lYT3RSEp8u+0fSGoo7b8XVj6AeVTJXp+kuhZmzJlZK0iBxxYVzTm
 KIWa/ZNtKfQgxV2zFbJ9Fd8eDymE1Vx2beZHdygDeqOVyB+qdTX4j5SzbYPIZLY7S8s3OyHpbXH
 klSyCITbkPAOF
X-Received: by 2002:a17:90b:380b:b0:39e:4fec:d6e5 with SMTP id
 98e67ed59e1d1-39e550707e6mr12911312a91.16.1789830128702; 
 Sat, 19 Sep 2026 08:02:08 -0700 (PDT)
X-Received: by 2002:a17:90b:380b:b0:39e:4fec:d6e5 with SMTP id
 98e67ed59e1d1-39e550707e6mr12911270a91.16.1789830127971; 
 Sat, 19 Sep 2026 08:02:07 -0700 (PDT)
Received: from [192.168.19.100] ([155.117.96.35])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6cb400c3sm5045206a91.17.2026.09.19.08.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 08:02:07 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sat, 19 Sep 2026 22:59:35 +0800
Subject: [PATCH v4 1/2] drm/imx/lcdc: avoid duplicate clk_per enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-b4-imx-simple-kms-v4-v4-1-53b1fdf4589e@oss.qualcomm.com>
References: <20260919-b4-imx-simple-kms-v4-v4-0-53b1fdf4589e@oss.qualcomm.com>
In-Reply-To: <20260919-b4-imx-simple-kms-v4-v4-0-53b1fdf4589e@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Marian Cichy <m.cichy@pengutronix.de>
Cc: Ze Huang <ze.huang@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789830097; l=1626;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=Iq5wCYI4y0W4CO8EIKI1BJMBBMwBjbLDSVf3wHXjWNQ=;
 b=tmqa4fZQfIDCN/GOTkNIfTyEWA8UTbv055ypJ64BGtdU8/5Urz4AvTiLV2g1hJeags1QTwq3Q
 58mlELqcocmBR6MCKokP5AWbZEcfz6PmdURks+gKVIxWlxkwIohtakU
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Authority-Analysis: v=2.4 cv=PaRqFShd c=1 sm=1 tr=0 ts=6aaea3f1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ilsi1XWDFcrB9FjxRIUvHg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=xnl2VaEmiNnR3tlLptkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDIxOCBTYWx0ZWRfX/Ifmcvd0fLv4
 bM2vkj/VE3jlOpJf8bQq4V1+KqKm929x0cN/nIfn2mCgWW4yJLjhv3xEul0KcKlwABef2/8SY71
 YZPrtJFfY4rPZuUpocBUHPdK+z4OJGY=
X-Proofpoint-GUID: 0VVegMPvBL3Psh_wAvxrraSESD-2HhH-
X-Proofpoint-ORIG-GUID: 0VVegMPvBL3Psh_wAvxrraSESD-2HhH-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDIxOCBTYWx0ZWRfX96Yt5flezGFy
 S/c7EI/RoC/DJGqAMYi3to3Zmj5bDUCRfnGuGzyBu0jvL0MHSFTSbdDaHgE7+KRnfyUdBzAJwtk
 /jLro7eW88c9FBbOTznmVmUWbaqvBda/93vAygEOWxgEsgRTdwdTXpvHbYimqjku/6RQ8u2Squl
 P6WHA2Xok38CrN32AQkX/PIPcZAwbMQYY4AAqeBakXbPCljzE5FkPvUeoJ+Rm5CYsnGf6Ee+GBX
 xqzJAkZlHo7ipqfok8j3vJFr8FrIYY8tq+M6bw+AnsyJZBw9cxk5AkiTOOEMmrxkNHfPWBkAaIG
 NCK0yrwCW41yoh5Yr2nAuwm9w3+ZXFBiKe2KAp6Yu0/Qr5Jo1ngxf84nFt0/24TEZXjW2KDzu+t
 RmLQrViMZ+se5PgkWGKi0acaFeviEhFRIJDvKocg4s4E5gqvdV749d27baP/lN0ZW8ovy5HcH43
 XHdZga8i4wZaKR2Z5Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190218
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

The simple-KMS helper calls the pipe update after enabling the CRTC.
On an enable commit, imx_lcdc_pipe_enable() already programs the
mode and enables clk_per. The following pipe update sees the plane move
from no CRTC to the active CRTC, treats it as a mode update, and calls
imx_lcdc_update_hw_registers() again.

That second call has no old CRTC state to disable clk_per first, but it
enables clk_per again at the end. The disable path only drops one
reference, leaving clk_per enabled after each on/off cycle.

Skip the register update from the pipe update path when the CRTC already
needs a modeset. The enable path has already programmed the hardware for
that commit; keep the event handling in pipe update unchanged.

Fixes: c87e859cdeb5 ("drm/imx/lcdc: Implement DRM driver for imx25")
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
index c67fe80b8115..e00e52c1c46e 100644
--- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
+++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
@@ -310,7 +310,8 @@ static void imx_lcdc_pipe_update(struct drm_simple_display_pipe *pipe,
 	else if (old_crtc != crtc)
 		mode_changed = true;
 
-	imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
+	if (!drm_atomic_crtc_needs_modeset(crtc->state))
+		imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
 
 	if (event) {
 		crtc->state->event = NULL;

-- 
2.55.0

