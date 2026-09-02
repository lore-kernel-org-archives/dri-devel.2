Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C66C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7B610F33D;
	Wed,  2 Sep 2026 20:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j1mAbS1W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lss0IYLs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F89110F33D
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:18:10 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHJEm2524076
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1oZVnfNKBlF
 giLoC1iu2FLkuJ+ivoENKb0cGsDY70+s=; b=j1mAbS1WwfUQzBqYP4YaGonJ+T4
 V6thqxNqjhIzlgurylVjTlfyJZSSx1MPoTQW+WhdcuCa671cADb5o4lEppbNkINg
 TtkwmDTl/CqQnuLj5+fhseH5ZAKcISvU19C3g+b+wmJossW1jTj4R/jJUU6LlSpT
 DynUEriHFzK7gm5Zf6v535ockse4QpLNoVFuzoMNfEseuW1jQbYOg4w42n6YtYtI
 qulXr/KcFR0lGSJlAv/bSjvIviKn2nbcjixPH+BTYJIjD2IoDPycDXWUY/bZcJhk
 M4Hdd6KE3FnU45yCKveXXDWsxiO+ZgXjOcw5u2VwllK623xZ0443Sk9K3fA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gepv5s4pk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:18:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d94f086fedso2550515ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380289; x=1788985089;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1oZVnfNKBlFgiLoC1iu2FLkuJ+ivoENKb0cGsDY70+s=;
 b=Lss0IYLszo2FMDN2o4Gimu/sFrWtia6N4keEm2pgeePP0Xoec7wom4NBd1ekazRrTr
 QPCEgGVgeE7d1QL1aJidCYvDx1/vEvDhRAvzCmgz6+pWLneRxE24P/XIOOV0RbZajYfY
 y9X3fbe/+h/ha0XJLtVv2gjc+6O6p3SbDtbkOqacqSyaJ0aF/8Jy3j9Z6kcxBUBtrFYF
 0UjRphSABUeg/0P2cZa1tUiB096/lBhC9Lgvovx6QviQF9e/MRMjYyQ0PQkyUGWGhn5D
 Q7UbWMF1U4r6JbCQ4GJkO9U9SFEfut/u6YQdrzbVRUhYfGSccC3AhE1ljmTqKHAToSth
 4Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380289; x=1788985089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1oZVnfNKBlFgiLoC1iu2FLkuJ+ivoENKb0cGsDY70+s=;
 b=Kegojtb96eA2iZJ3KJu14XNrY5k26XuMwB5MKqbEC+FanHrNENL+v41vYsuQBQrcQl
 zuXXFJlCGPU58zt79qpK/m0eJtNEERtp1nG7yHjKsMBbEgBunl9tUgnpT3bAURHLRAnL
 S6MioiTf2X7RGV+6QHp3jqLnZUr7O6An4mX0HVzNWS/jNSxQjATJd309LZw7+plJ/2vz
 zL0tVVjiwsFew2YUk8Xj/M1detTI5EiaFZ18T1xekO98mb3/qHVoYoTWCEuj7jHaUoWN
 fuVs825wH6tdHL7cyMEED2V5B0pAfy0Qb7Xmj8IBZGQd0/Ju1Khn4rRzEjJkP+OWCAXf
 Lxeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxik7HgBDxwYhf66OESD1ZwtQ2RrFJ34gp0IyCasiBwWvKyiCpwh/JR2drWePTxHEgftk3muY7lanw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l98ghUfRWW8X5QSfwnlJxip2TD4g8ILC5W8N1rXBWLGIxpNs/V
 T6OOmLjFlWlxlzFx8ZgrDo5Ch33Qio3oAdK2jKhKsSfMPEFRQBSmwLnrVXgZgx9kmsWAltSCpJk
 DzXBQdPxecDVCK7TrPpfpzw7qzYUm/A1I5v1I01NHqikGvCKiHTkxN11DyHwVpCgqOQulXKo=
X-Gm-Gg: AYBFou1XjydpDFPpiE2yL15P9lPnMj9+RT8fLu6KdyhiyGuANEjiq4mymhW4+iVcicG
 YVjiZsdk1Vne00+NZ1rNfoL4tNxkEPpUDmlGH7/fOkWkjZ9YfhxFIUCIcL1STEaC4fMsxdKjnNB
 xubQPvqgcmSzmwD9LS2zqRgnmDqFUQGdnEvbl6TNg9S2NRtbb4/i9QTn0c/SyFd4S4rtwDrJra6
 CUxSoC0ToHZBTvxWsmoj6UNbx076mrZxdIX5yyOaCWXUuIPlHR0t/zTKVcrw/2OdlMGCMwl7ZE9
 Nv1EECwG6/GqHTAruR4l+UqvPwrmeRYl51PAmjzLIucT9etJ2rKIvRNWeibHlJPILt2QzbvhwWl
 k56GcKIjcT+mNjxbU3cWnjxAYQPs=
X-Received: by 2002:a17:903:9cc:b0:2da:ef81:37e7 with SMTP id
 d9443c01a7336-2daef813b09mr84024975ad.21.1788380288455; 
 Wed, 02 Sep 2026 13:18:08 -0700 (PDT)
X-Received: by 2002:a17:903:9cc:b0:2da:ef81:37e7 with SMTP id
 d9443c01a7336-2daef813b09mr84024465ad.21.1788380287974; 
 Wed, 02 Sep 2026 13:18:07 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:18:07 -0700 (PDT)
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
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v2 9/11] drm: xlnx: zynqmp_dpsub: Use
 devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:38 +0530
Message-ID: <20260902201640.2024648-10-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T8y8ifKQ c=1 sm=1 tr=0 ts=6a988481 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=zd2uoN0lAAAA:8
 a=EUspDBNiAAAA:8 a=QbF1duAvIEq2M5YqX_oA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: cPi341ruN9XNNI2H7yvEmfvU82ZjJEwd
X-Proofpoint-ORIG-GUID: cPi341ruN9XNNI2H7yvEmfvU82ZjJEwd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXw/n89DpJ2gII
 m2mOsma2Pwdwtz7I1qHoUGZtyL/aV3/ElCu9UrI9gdqQbX4eS4Vss/sS6YL2com3zyEwujdeYDK
 P03tHoca3bQHZBDyivBCKXfLhLu7BD00KJlBmsXA9r2TaIykoN5JFyeBMK1bEgBZwjD9Fsx3aew
 VX+qq2soonsr5eJDvH5Q97JKeUCKAYYXmCVsueiB0bF1+rRcQLS5RUf1hyeyybgoPf9q9ZBVAgo
 Qlh0xmn4j436LaE762ErKZPxwziZvkVfz/C/isoZbt73fMBO9jXmWKXGUiH74kINpLLGQougBk/
 qT/oHT/tMB4bmHN6HVTOfsabVrI4CTZYpIc29QpkbGn3lRGNNTfN8Upw34MCY+qhWAgc8jbEGh7
 of5e59DlXIZAm7QDXMIDuuWqahhlETw32WH3Lmai9HPHmFhgp3PAe42m1BSUi/p0cHrR0JTfeUJ
 oGEvSa/yUs9cnfcrOtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX5bsidzMaHbIu
 n38/WYGdZpXgazAnK+c0sSZCUgDE/zrtIE6grx3rF81xpOZiJUqq7y3SfKUpGtNv1EnMFwxkR2J
 P9WE2MgkNWvkT6DCfM61dE17FrXpHuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index 53ab1a2a5aaf..e93a7a299b52 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -203,7 +203,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 
 	/* Try the reserved memory. Proceed if there's none. */
-	of_reserved_mem_device_init(&pdev->dev);
+	devm_of_reserved_mem_device_init(&pdev->dev);
 
 	ret = zynqmp_dpsub_init_clocks(dpsub);
 	if (ret < 0)
@@ -255,7 +255,6 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dpsub->apb_clk);
 err_mem:
-	of_reserved_mem_device_release(&pdev->dev);
 	if (!dpsub->drm)
 		zynqmp_dpsub_release(dpsub);
 	return ret;
@@ -276,7 +275,6 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dpsub->apb_clk);
-	of_reserved_mem_device_release(&pdev->dev);
 
 	if (!dpsub->drm)
 		zynqmp_dpsub_release(dpsub);
-- 
2.55.0

