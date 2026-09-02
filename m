Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999D1C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96CA10F336;
	Wed,  2 Sep 2026 20:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cKzTE0q9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WwgXGor8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01E5010F336
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:17:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHIml2686283
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fJookc6jcAF
 EyWsEkKo0DtGELL3YSCH9IlXzUWBNEdY=; b=cKzTE0q9kggbsu9YuOq1kAkuDdR
 YJhvVN+czMppY1U0nol/0Nu9eJg+w/VFZzYpLp6tDgr08w/mOjZzQMor1M5ZJ43s
 aqFqFF8zPGXQ974shwBrtJIoDDhkVNz9CXms9H9Ur4Nh5EJh3egmeDqIa8aVm3HB
 f7W+dmLT4Bpgj5WrbBijZpdzHBScjhtTOCpC5WtmF8n6Kg8j3e12752VkYVhsUAV
 euJrXiqfaKFvPGVbkivLLcukuLJ4/t0MfC0ImtQmBOwomB4h1Tyd5aDhFDADBn7C
 wt5VIxwjnf6q4IbxY62WHm94TJBj9F6OQtfzZFVnS5QgaNIjYXnDEWEc8lA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv8a84j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:17:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so2640580a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380255; x=1788985055;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJookc6jcAFEyWsEkKo0DtGELL3YSCH9IlXzUWBNEdY=;
 b=WwgXGor83iUg5dnSP/J7t7PBZFnJtIVlAUeJBPob9n377nzJoz/DiSOKqCg+iF5SrB
 qxWcfiqZAtWG/aAz6TfgdzcnpRlgJKAKXNrwIDk6XLnh25R0UiiBf0NifVtPuKgiZbvR
 PYvhnJ1aIoERVU3ZT+8alOsmG05/2IA2LhY1p0+q1ELv0uQaUbrTSMw7gSrP37NscBy9
 oGgMJzFknDBY61Y0ZTkTCEuXFrFeAJgfYvg/qEb11YX+eTikxparIMfXa2CLAamOc8Fs
 PYJ2t/5f07yRyAKAfRu/eeRzCB6akEnSdXDXKyouJgf3HhQDjdeKRcTBW+4unhm8Hfbm
 Inew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380255; x=1788985055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fJookc6jcAFEyWsEkKo0DtGELL3YSCH9IlXzUWBNEdY=;
 b=P3x+xusriSFOeUrRUz4lzRDchII9McbvqLEjzJnjl+PiRiyKop+wkO8lyiOprUGxeJ
 noixP0kqVDosYAssnj+2oMt0NYpvIsLiXjObbjPtgeucK3vyB7Y57A/U6o/9Rf1mLIV5
 OXAYi7osZDaU4wwiT7oW5rp62AQVa21KuAxqefZ+U6oDODkceisCnqPsbwXluVsXoh7o
 AUQuj1oi8+1hqIfnf31QaXyJnevcg9aFgUFsAepQazp3u8D9Dx6S0+cJ6h1eQr9vGyKb
 DbXCXg4HpIbSufu98QaPuf6pXzmH1+/dtqK3Av5KgmUE1t7rl6Y+rnYRYZhmu8DOCRmo
 bBWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHaW42ez/qcShXQdRPkQJVlLJprzkqldMPXZ1Lbcyaef/UfliJqPhjjlqe5d+oiHN3qyidEe4eUmw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lRLGoAaCaBgN4jg7nhgTAgoTZ4Z+Uhj89tE0YjV1vw7uaMadPV
 L1pQHaIvymX1Mtn+RNGQbEk1TSc7JgT9svu22irZTOCl1jEDjKDQRQxya078KqHKv+qjFgeuCtV
 H4r2ZMmLHJwhgmdo5AOROBIPK8sUQCFAs2FckyTONeToQbrSxdoz0vuk6/UHgZq2A/CR3a6s=
X-Gm-Gg: AYBFou05u8eltP4PmSkCaE2Y5mjeiqymattAhlZQpwynvTH60oCfN/5sTaitGyk9rmb
 sxpQUQQlm06h7FWBxKtVeS2xQDJ8ealt1Z/jqKdg2pL3AiI0i3P4WuOiJ39gfeWPtNzB/AmPM2H
 s36Hgtd6K2vcule6PW1hv+fymY6ZFg9mwdibY0aljg8GoI3D3m85xB72modWwedsN/KFR6vBXiF
 iXD6VILbgf2DfKSzBa2t6wpA11XnQ4jUNNs2JpMABwAaxLPY42b6nJjY0YUoyI9SckLiL8ZdeE5
 0sUxKjNxSPad9TC12zKNjxQ0L5BYDMGMomKT/Me0ZvVwpQDdkutmCzxC8m2nf73AiISUfkiZ5eq
 q2xQ7b01gCFGcnAzStmetXyujbJY=
X-Received: by 2002:a17:90b:4b0f:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-39aee238df1mr8817742a91.21.1788380254736; 
 Wed, 02 Sep 2026 13:17:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0f:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-39aee238df1mr8817663a91.21.1788380254041; 
 Wed, 02 Sep 2026 13:17:34 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:17:33 -0700 (PDT)
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
Subject: [PATCH v2 5/11] drm: malidp: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:34 +0530
Message-ID: <20260902201640.2024648-6-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0qqVgYaveBooYhrO_mJdM5o_TCTPXo3S
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a98845f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=JOjAg5lxkONN77W759IA:9 a=iS9zxrgQBfv6-_F4QbHw:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXzNwef8LaavQr
 DF4yY2xO1iUqE429K44obiIng23IDVWtEZWW7YFijzq0sYbXVjIMOM2F7z/kXtrB/qL5hwmmEB2
 ObJiHUrpwfeyuKtuC4Y1wi1kqcrXUUoy+K7aaU45QqCRu2fU35R4lMAGuMM2I5hfyaEqSxt8CeJ
 /LwLlPN1WdNIPsuTVeEya0Fx2TRYyejVT+BjPzBBwT5BeRBz0iJdF/PXsoqo9DYx9a6UEQcsKjW
 NrF/x7AI1s+eVVsV0Qo0EklMRGUUR8sY1MfqtbNeOHnfrLcpX3fAq2wPpd+5fyMS4i51TOwh+HN
 8okYqlu6YLQTOOvfzcEy10B1h5/ZqMJPzbuW8O5f3YvxOetG1MFgjLZ3w4xN9mmdKH6odeaNlJR
 awdAbctTCRXvrEgyXEXt8ion5/IbxP7GaQFsI9UX26Lj31b00Uqz6/Hmyq3QtLGMUlOQfa7L+U+
 A3JvMnAqQjybjeuhuhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXxELChm0wNbzQ
 ASih1WPja3sdDsD7/T33pu8t/+JHvlUP3/d8CaYOmvoUbhF3NDI1GD/rLBcDC2g8xj7gPZUi7MB
 bjWuE00ehOAJUwicx2nunQWwtFLOcNQ=
X-Proofpoint-ORIG-GUID: 0qqVgYaveBooYhrO_mJdM5o_TCTPXo3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
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
 drivers/gpu/drm/arm/malidp_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 23fa942ae4bb..3e17513c3114 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -758,7 +758,7 @@ static int malidp_bind(struct device *dev)
 		return PTR_ERR(hwdev->pxlclk);
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
@@ -887,7 +887,6 @@ static int malidp_bind(struct device *dev)
 	else
 		malidp_runtime_pm_suspend(dev);
 	dev_set_drvdata(dev, NULL);
-	of_reserved_mem_device_release(dev);
 
 	return ret;
 }
@@ -913,7 +912,6 @@ static void malidp_unbind(struct device *dev)
 	else
 		malidp_runtime_pm_suspend(dev);
 	dev_set_drvdata(dev, NULL);
-	of_reserved_mem_device_release(dev);
 }
 
 static const struct component_master_ops malidp_master_ops = {
-- 
2.55.0

