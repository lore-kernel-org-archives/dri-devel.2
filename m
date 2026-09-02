Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17541C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5AA10E4B9;
	Wed,  2 Sep 2026 20:17:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EZxmMMjj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K67LJloL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7DE10E4B9
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:17:53 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHCsd2796910
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8JDjRVYqzUw
 0COQ4lE1cK71GEKSAg7BunK0EkaeA4ZQ=; b=EZxmMMjjSUe4iDpYendft8KMQIW
 QkTF2YwCjO/T+sAA0lM05BjucwS8gz5p8R9Y3XJ8dt3UKkChO5FXcmzEgXUYh5LV
 0eUM6KrEuBBs5kxP0uzF9gj5GfWUkp6aC6hqAqGb4Rt++R/dXixxZqPa/dj3gjgG
 VIondF8saW5VVamYQkiL3C+emxDxq886FpIUTmNoJIWi8eb7UMiAGOZ2JQ+QMhfO
 /oD7yrZ9fucXcKp59nfpx2XTZ4N06MhaW5AEiuqcHir5eQFTJnqvpTT9lAiTGR8C
 8XHq+Nb3SFVzm1xP/WolzePIlW8KkPNlVss4gLm+VQ3dA98z+xxFZHo6Lww==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh9qd0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:17:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1eb205d31so2123479a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380271; x=1788985071;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8JDjRVYqzUw0COQ4lE1cK71GEKSAg7BunK0EkaeA4ZQ=;
 b=K67LJloLahXHA60ZVCxSUPS/0NcV89P4vcgCvZ4RL9sBEoIlhueS6m2+vixrVmZKZf
 Z36bCZVqKYY2DYMuQ8W6VSTgV6A7Zc2JDmSNGotnuIhTRZKAmQulftFX2yioaynDl1fp
 hu8o6BPA90mo0dgyWLP2YLq+IEhxT/VQK8OT47t05pOKehHOg8xISjmp00v+qccna1IM
 D5GnKCwDd6DR72hPHc4U8MwSiYLT9VoRQEzzXJmyqShQNa0YidzepSrmwp6l9WKvpmDj
 1BsvU3j3vokrsavsZP6gqNkPexJ2NYtm0/NQHRrSdiVQMlUChRrzOtqrm1vTiwIdf/PS
 2IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380271; x=1788985071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8JDjRVYqzUw0COQ4lE1cK71GEKSAg7BunK0EkaeA4ZQ=;
 b=RPXAQ8TBcyYJc+oCDGDbvIdD6TDWjYM16AE2uR7wqfVE0lYdCW9tfxrWepS3dmn1wv
 JIrXAniCJbAW3cbkVJxV2wvzijJJfw8zv+840PPGcP0uoCvqzNC8oOGUwc6xqArF9R1V
 nI9xsY9zdLuLHTn9KWRTg6eKA+uaxlfE/b1WCvzxLORJV3fV68rnukf3Jp0dhOd4lZwA
 aBMRADIgFe5BtSvjHUos6qjnsM86B+0aBk5iRLecShnvV6lVUfCi9ET8Fk48Cs8p5CbW
 vJICHcGvVP5hwWWP/jDNUsq5/7wFqrTo5gedNLaaVzCNmTEwqf8JJ2/IRPyNIokjmX/d
 Nn2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJaqnO+UzdlBJtOH+QQE2EFfx0bUfA644iTk9yDuXmvuXvI6RMa5bOetu/wF4cxUMh8tJ9AIOVvK0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mEvQ9byS9iDBk4WGSpSWMpdXMdugaH0mo20Kd6vSleXMDKQeSO
 8Ghi8mz9hP+/TmzyquYdZfiY3LBj3u9sPbE/gKxj5wGKK2UnZ2L9BNbCTMmJjqRMw1GF2p+lJnF
 A5aGOT5ShFTIPC8OeuDgm3/XHQGhYdma1OY9uyxQgB+mVGqnwivvbcX6CjjURpuFLCjn7o9mrq+
 qvw9s=
X-Gm-Gg: AYBFou33gFFPmSK+pSnWiyPRNRrlNyQSg8A8vCNrz0V5Dh0UIueSKyPyhaJXV7Cy43O
 CU1wbhHkuRVQY02DOBIaDiZQdVssGKIktP1jtmE/JnXdfMIiNfNiqm4xRB86yvUMBvGX6oeL8C/
 garEGwpPz54Uy6Yl7yXyV6rwoombk79YpxmfDAKQlFOfsNtRXM57HozwOxae+egTpf4w4ROQMAw
 B6/qdGJ1AoiJGY4dnRD0ShbyLawJSj7T3dqHWUX1/HUu5QGjFS5e+T0RJTSzr98/sPJoivHvDoC
 XDbW477wtjNwD7aqU49BE3KtrSHCv3Wx+Bu4asouRtvO97UPjHg7DSFFjfcvG+tpiBdYQ8yBG4G
 QiRZVKUwOB62gnJ0Kt7kgyS03iaY=
X-Received: by 2002:a05:6a20:1611:b0:3cc:f008:8125 with SMTP id
 adf61e73a8af0-3d9ad9a7feamr11025917637.1.1788380271454; 
 Wed, 02 Sep 2026 13:17:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:1611:b0:3cc:f008:8125 with SMTP id
 adf61e73a8af0-3d9ad9a7feamr11025843637.1.1788380270956; 
 Wed, 02 Sep 2026 13:17:50 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:17:50 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 7/11] drm: kmb: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:36 +0530
Message-ID: <20260902201640.2024648-8-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5wk8Ec96hq2f40R5JmedrDyBMPagLwgr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX78coTTMpbLCp
 MRAipG2T6t31C/dsmMhwt36Q43x6i449BDutKVixdoQwqz9lRgCm7IDO7v0E3QY8mWA9s7vMokX
 8IaMnBIXij6pTfVwpO6x/7CH0NTm/rEPECXUSO2uxLmvbpwVolTg174VitqwF3JyAztHHoHXDAa
 OvhaXtUFdbf83jMGjbAZxwAsK9ZFToVF9x2Z4k2qpJfG5WJH5k9ZkVhnPYyPxHc0cOosn/t16Oh
 Czse30GIc2PR4Qol4WHrMDqvIju618oIWvk3Ae7zNQNXCxKbq64sqywWcob1zlM6AEoV8ithIAI
 mIv+T8bYFuHLUhMe+5dKOMAq/Azf5HsgEy0B5P098+GwQO1e8Jn91UazLhuxU0EaU+1SrO2V7k/
 0afs2hCSkYlD6XK4g5ozLH+9AMKAkJzkE0aZn7YSYSrUWevwIEiWery42uwidZY2mPi/augYozr
 4lEFLtWTyq/mGyMNPSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX84C198p6JAS7
 RIhWjQ1Ql9FtFL9B/T9AZVU3xdnJ0+D8H8n4Et9NkziWJS1aPxT83I8kddi3uO5j3irNhZYLuEF
 9m8Mim1XE4H2Wj4XxHsnILsC7crE9v4=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a988470 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=WgoW8aVLYYFOpEymBdMA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 5wk8Ec96hq2f40R5JmedrDyBMPagLwgr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179
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

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.
Also simplify the IRQ error path since the release before init was a no-op.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..88fe377940f3 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -140,13 +140,12 @@ static int kmb_hw_init(struct drm_device *drm, unsigned long flags)
 	/* Allocate LCD interrupt resources */
 	irq_lcd = platform_get_irq(pdev, 0);
 	if (irq_lcd < 0) {
-		ret = irq_lcd;
 		drm_err(&kmb->drm, "irq_lcd not found");
-		goto setup_fail;
+		return irq_lcd;
 	}
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
@@ -155,11 +154,6 @@ static int kmb_hw_init(struct drm_device *drm, unsigned long flags)
 	kmb->irq_lcd = irq_lcd;
 
 	return 0;
-
- setup_fail:
-	of_reserved_mem_device_release(drm->dev);
-
-	return ret;
 }
 
 static const struct drm_mode_config_funcs kmb_mode_config_funcs = {
@@ -465,8 +459,6 @@ static void kmb_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(drm->dev);
 	pm_runtime_disable(drm->dev);
 
-	of_reserved_mem_device_release(drm->dev);
-
 	/* Release clks */
 	kmb_display_clk_disable(kmb);
 
-- 
2.55.0

