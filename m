Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3867CD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E2610E3FF;
	Thu,  4 Jun 2026 08:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h/+QQX9U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e6LxuoSz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FE310E3FF
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 08:08:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6540toea598074
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 08:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yVbcebMh6Di5VhpLuMDSJYWN/Rb4djQcDc2Pn3rowVE=; b=h/+QQX9UtObTkBIr
 3whzket8t2XN47q8TBQVJ3q3SfySf/dKAH0e2gBBH5KL1b0ej4ToJn2FvN83Jcwd
 OkIf2ypp/3V9Z/nPJc/mwTntsvLh+PZ6kryJqS/GtLIK16oYhZiG8Dwnt1A55MXX
 Asp65VRQFNEqZp5sLl+bJLwt72qBHTfdgYxKZkHjKOqx2EAmHo03+e76eIWTsYuO
 jI/dLWAaG/0Wxei/y5w84fQkbi/g++HQ8hr6CzZodZEP00YX3E/MmFev+tGGs+XU
 D5syeduUiVaecikqEvVo9by03226rqxrK+7sjn9BEAmwWvqoECOqvUmf+jh2j7ET
 dfD+6g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy8m1atv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 08:08:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9158ecbfbc2so7833185a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780560523; x=1781165323;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yVbcebMh6Di5VhpLuMDSJYWN/Rb4djQcDc2Pn3rowVE=;
 b=e6LxuoSzIWSUE017Dm/2Saq1zrbVVh1ExSpqVXP+IJR8vupD1SABZq8slQmrQtp+ur
 /cNtltzOta2Scl/vzpd2EzZaonHcARYLIvlf5K7FlhMkegiaQnDuoTlwBy40ae0V88lu
 o9J16suEh2Wnvl2YtO5ufLQWf6YE7Ve/SM8fHKfpVqOJxfXk8gxD2X83SGyUXufdIC7v
 mblEOj98Q3RQLGHa/oc9F6QPnNlwHmgs6g2cSre8lSoBb1407ZHUvsR7yOs+mIs03+3M
 +awDSUHJeSSAYwgcLwrwFw9Bk+H0Ty7coBDNsV9IrRH4IdItMuqtn8zGZW8Kt8414syt
 6QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780560523; x=1781165323;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yVbcebMh6Di5VhpLuMDSJYWN/Rb4djQcDc2Pn3rowVE=;
 b=Qfn2cUcdZxxK0Qq87Jhgmox8cpWEjDiqeVG4y57G8ef3f1hEM0QXtt74ppVVo6s1CO
 MFN2MhA901Avx5HT66mvj0Z+trcbw5V/xN2ULnmjoPLU/J/SKXNY3fHRxACXRNTwLIIz
 8aRC0OwMmxyWBsPWJoCYjC3RqUJHdVt+bxLSa6KYsyf+mmMz4lmLgPD/+zO+Y+KYmBdI
 Eql6B4V18DKOz85azsdrnU5b2azx49HZlIXHJZg7lyBoqaJCB32vZGtum4CxR29P/gQD
 M7WWjUiCQt5UCQJ53MB3Nkg8ld9bH1w2ItgDgTYZZgx1nguSWWa4AkLPCrW/uWM6ICY8
 zQGw==
X-Gm-Message-State: AOJu0YyfrNs4J4l/mRd7KQYcMZiJ6dUi+l19fqq1Qyzip8CFqLJlg2o8
 9pbeGV9hYzZaiI8DrCc/2wY7D6w2jzyW0CQ+FYvlwoSBuecaAkFxGcuD+rCw/4ZTm47YN+QK288
 folcyrju5lkOIj50CNTi+WFkDUQJoRS/eYDPu9JLmd3O3hOpi4+2Pgo5at4LPMyBQvYTmzRw=
X-Gm-Gg: Acq92OEfdbOWVOiZEohXakB3HuZEdaaKLRrM5CNk/JpFaUcDAACbFGDcGe3iOJk3CHZ
 OE27maqTkBSl2lpVoQ2YnBanELoCZgJEhhiXjebPOT0SdbAg8oG0Ix+mlEZCCeeImZEmkS3VPsp
 kWr6sQoofvF69qKAeIESxFmQ8/u2O9lS4JdNp7oMdtq3KI9WkUl2d7D3How3QQrDilBICSb/tM3
 P7t+3om/Kd4gLOvHI9V5oMJFWyl8bP3IORCDuCH1qpUzIjXTQFYrDNEabPts1wQI81i6H9RfGiP
 MlRb20poez48r0HQZESB0TJIgC4HPGk6fkhsMML1CtQj3D9HyBmufxnp8+AGxCtsnyaZl2RDn1O
 MUNajlwVt0YZYDiR2zL7gwSzkY3kTO9/zCgLlkDrdTGNO07BMuSH3B7gRvdM1sAUBJ1Q3gCYA0f
 SYjlybed9B
X-Received: by 2002:a05:620a:1999:b0:915:776d:52e4 with SMTP id
 af79cd13be357-9159e3519c4mr133788385a.8.1780560522606; 
 Thu, 04 Jun 2026 01:08:42 -0700 (PDT)
X-Received: by 2002:a05:620a:1999:b0:915:776d:52e4 with SMTP id
 af79cd13be357-9159e3519c4mr133787085a.8.1780560522124; 
 Thu, 04 Jun 2026 01:08:42 -0700 (PDT)
Received: from KDYBCIO.eu.qualcomm.com (public.toolboxoffice.it.
 [213.215.163.27]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf052097992sm272304366b.26.2026.06.04.01.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 01:08:41 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 10:06:57 +0200
Subject: [PATCH 4/4] firmware: qcom: scm: Allow QSEECOM on Yoga Slim 7x Gen11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-topic-yoga_submission-v1-4-57c70c23d0d6@oss.qualcomm.com>
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
In-Reply-To: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780560429; l=1001;
 i=konrad.dybcio@oss.qualcomm.com; s=20260604; h=from:subject:message-id;
 bh=R6FZOcCMcMQPOEjJuz1wW0gtCOFpXybWrlx8i13dpWI=;
 b=3UzD5s8LpQciKzqLHwUPKSZ/9f5DdpeCV+exqTJNvMDnsE50v8T6bcgPcxVh6OQoh9Aidfxz1
 58XJQLwOJq8A+N8lLyjoUhER2XJxlNJLkB9mAZrzBaSEV8YgtsMBdTD
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=SGRRMmlLTuP/lGKdQ0f4KPvxn8VVsXtXaTpdGc8i82c=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a21328b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=aBIYUfOEhgoR9egqXYNcqA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=cNJI-YeLJ0YrPzV7rEUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA3OCBTYWx0ZWRfX7UwdP6CoZCBU
 mNZ2OpdURfjs9esXbxDTdVpfoiEhWUlyhiV51LOl7ffjXXw2OXByg0vxFiHcNYqkTzxnWPr+YTn
 6nvGm3Mvr7sxxzlJv9rsH7BYsBy7aH09znWoI/9srJBl1Kp8WUX2g+DXpOUHBMlp40GGaqdpKco
 T2jR8w5IQfCp2hENVDY4sH4OKsNB3dIXT1TFf6KzPPxCyBRVJeqR1Ku+TskgCKSdaxToxZy28BM
 90OEkxDQRg1EUYpYO65uq93GqYtTwPi7eJboZ/vxc/9YVsTRMpHRNRWK3fY+Kx/zcQXsIwZTrvw
 pSeGhf8deCL80zpUWz4N0xj21X9tpj5IMxOYXQXcsCuaIrOIVnEolh6iFB9dMzlh6ioGaxKateO
 e/IGPTKTmWzhFg2lkmV1LhYpgQpRcGya6lGvefQ909Oe/ZuX636EGinC4AcjCsfS12FbC42CKQI
 QO57ikZZpn56xJaQZ+w==
X-Proofpoint-GUID: EPle8OIlv4Lhlh8AdLiWeGLtVbPM4THX
X-Proofpoint-ORIG-GUID: EPle8OIlv4Lhlh8AdLiWeGLtVbPM4THX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040078
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

Allow the use of QSEECOM on the Glymur-based Lenovo Yoga Slim 7x Gen11,
as there seem to be no issues with the firmware that would mandate
disabling it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 6b601a4b89dbf04322730aa22fc9590d180a383c..fbcb9dddfec68e32564e3a4209c3b6f471e0fdb5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2304,6 +2304,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "lenovo,thinkpad-t14s" },
 	{ .compatible = "lenovo,thinkpad-x13s", },
 	{ .compatible = "lenovo,yoga-slim7x" },
+	{ .compatible = "lenovo,yoga-slim7x-gen11" },
 	{ .compatible = "medion,sprchrgd14s1" },
 	{ .compatible = "microsoft,arcata", },
 	{ .compatible = "microsoft,surface-pro-12in", },

-- 
2.54.0

