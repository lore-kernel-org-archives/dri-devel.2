Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BE9C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B49F10E64D;
	Wed,  2 Sep 2026 20:17:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cHASjO9n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cn71xjSC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B067F10E64D
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:17:28 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHCWd1962712
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+W6tpccLyWv
 9ClYrckcY6BlDCEvf2HSTQJWRxk+QBXg=; b=cHASjO9nJpDVndRqPqR+0ZBZe5y
 S5gqMEV2gnPj4s3n6BEV7NXgRHhdxo2t0J8shBsPe84l25uRRQorpCDeYPC6YnSC
 OKft0Zbq2yoHiHs58iPdkdcmhbsRlnMhwhCK6oxRoW38JR/QJC+pBGyumeR96CuL
 eKNmh88z2yaKScZqwLyJ4LQFBMLCggSJLOZjPef0vdX5LM0qiJrez8p52ZABeQ4m
 fH9g0Es37j/K5/wBfk5+csMuAx+ftxFpWvhK3647Iizdm4lZLTNWKEtdJr3OxbGA
 ohXjXcbEau00q26eI9i2SFV5O3n3QlU5c+RrvTAgZrmy0HdwOiQpjGX4dmg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4srqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:17:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so2119850a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380246; x=1788985046;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+W6tpccLyWv9ClYrckcY6BlDCEvf2HSTQJWRxk+QBXg=;
 b=Cn71xjSCTLk8zE9J/b/DQ3Ealjono/cJv9ak5X88QxlAk+S9BMygiCRHHSZcu0zfBL
 E2YizSjzfrramO9ZSqnD3fsg/Riz17DHedTkSv/SZCN5qU1/mK+gD3ytIdhSFr/fJqDl
 3VPwLR0wTvc8aHEmK/sT3SV5EB+J7keZAbQ1rFPwsqRMj7EZru6BNQiFkU8ZIoJQy1ML
 Eon8wGy7ENC5v5gW0t0RfrVFmgxIXIdDSoAiz2PU07mR5L1pTIhdfWw1UeAT1xjV+2Zh
 GqF/IzORRBO0Kl8ceYNe1iocO9Gi5rejloiDkTbQK/fyyIsBpQbfFtLIU24BDB3wg22P
 w/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380246; x=1788985046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+W6tpccLyWv9ClYrckcY6BlDCEvf2HSTQJWRxk+QBXg=;
 b=Xn0S3x69fs1ukjuCvTY62sTRcYHlk0YDLe0RzU3fwhXOlLNPEZQeX3Lw68xWp0npgP
 AP/IpK2QwIqPWpAvgxmFFw8S99YA+KYHEJk0PQn7DZ7bb4gevaJtotvTayl/wQ/+LwCP
 Y98vDO5wDJfBYETOsz4VQA58JPLrpurB6sBBOePG/oDYGi8ue4pnYTbmo0U7Nxz+37fj
 2S/slpEm1wbanPFxruCNhG+c7p+73iVXOXMH+kj8ujK4rqOiXXamDDBEJutQuQ1qkAnZ
 RTk9+eJWaUjvlE90jXLak8PQ/cuOWCqxJzfdF7yE3dJb8bt/a+8iiUie55QkJW21+43M
 Ji6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdqOMJ8nuC5mcpwsGXTux1n/ENufiK2OXUi04yK5R4jqjsp0J5Ngw0zjS7LQ6O8cionpgmznX8Gx8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kI4LxVXoVtGUDnoYtwehlIlalpO2LdkQRxuYPEIXtW8igOyPgU
 iRJk7XW6RWh36hcerryhDxAExzwLXjuaAUMfAUotqzMrebqqe8XMGKL4BIo82WKIe6gcPfndzY0
 pCiFlc0BoqTjF/r2bpSDbrooLzhBVJKS7WwEKa+d4h6ju1xyeiNSII68OFuG0KDnCwJc5GzQ=
X-Gm-Gg: AYBFou2mXWduLTrVTovA6jJEQoqN2MddczBadgf2bzeAnmppDVAy4jzDD5hs7o+sbi2
 Iv6iZ+KdP3nS+x7Hi2PWe/deuiYHoRW4wz9NdV++OghbP6/jioOol/BgCx9KMxWgq8uNhfS+uYq
 HupwV+XWsuHKxzZPUoULazZaUkaDwhuqWfpPBtGXrwFCKBOJlEQsU5HOK+HjgsSAH2vivWJnW2O
 lETMAh1mSZKphGfvHuyaa20tkzre27L9t5JM1W+PoHALoOqscOcJLtzJb33IU+htik5dJesMlkH
 +y5vnkbutvpDWZljaCGR9Sc7cqTC5+apsvcYEbfxErpXdyboThMuQqBl/T3I35PhDTqB3o9h10s
 g54T1X0yJEf2aZEyH8A0H0OY2jPk=
X-Received: by 2002:a17:90b:4e8b:b0:399:1f8b:d255 with SMTP id
 98e67ed59e1d1-39aedec54d0mr11465786a91.5.1788380246173; 
 Wed, 02 Sep 2026 13:17:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4e8b:b0:399:1f8b:d255 with SMTP id
 98e67ed59e1d1-39aedec54d0mr11465704a91.5.1788380245604; 
 Wed, 02 Sep 2026 13:17:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:17:25 -0700 (PDT)
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
Subject: [PATCH v2 4/11] drm: komeda: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:33 +0530
Message-ID: <20260902201640.2024648-5-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXwBYslVhTFm9a
 RBPQVQPQqQOOb3x3M/YsWwUS8FYZIX2gEpuXfIvwSSi8bcYZhE3y5f8bvvrC8WQhn2A3ef8W6Uk
 QI8Nw+XOfZysdWlFF2Tki8ESMQheIEZIQoQVM4gw1aGclylQl0SqJ4/p4h+yy3Ewk6mxmIRi6Gl
 0aYHaBhfUDUA5+NCmxJnT674QV7F99lebzplscsub3fidgE3wVUcIdXjmYOMr7wJ4hf9vG4z+bP
 FIlVl9/+AAqoQhlbVr9If0zKJQWjazLv1PhsFSJYroreDKJtL18MWFRUeitqbCqeAr3EP+G3H9h
 Q43liHj0C9v7yUlMIFItCvNJznlYwzzKBYVuSU0n/D82zrT0wAu/xM2ANR8LFjJZwZ2hwqw/GI7
 7zyDZI77prFJo+UKl7VNLtA30XFHi3geD9Pk02BJDC0Sck9+boZOzITYs4yTf0ULw8kQSSEcHoI
 c7gdpdpcU/DAfVuElUA==
X-Proofpoint-ORIG-GUID: mOBuM6oFtg6ge4K5ZGX0Er_ZbSyaURID
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a988457 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=8sfNmL5Et35J21XlSqYA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: mOBuM6oFtg6ge4K5ZGX0Er_ZbSyaURID
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX9qmUa8ACyA9a
 LEnaX5FOlmWoQY/3jxEd3DB4bCA4f1AncOwx8aclLZ6wPGzWF/S2kqdkKpqLyWWc6b44nbt5OTR
 GOcJjEagPB+JSot3G8TJOCzKnNKNjqI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index 9aad1d1d28ec..8016f5a68cba 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -145,7 +145,7 @@ static int komeda_parse_dt(struct device *dev, struct komeda_dev *mdev)
 	}
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
@@ -292,8 +292,6 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 
 	mdev->n_pipelines = 0;
 
-	of_reserved_mem_device_release(dev);
-
 	if (funcs && funcs->cleanup)
 		funcs->cleanup(mdev);
 
-- 
2.55.0

