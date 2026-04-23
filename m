Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D55EF589D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31C910F122;
	Thu, 23 Apr 2026 13:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JQjdEduo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bzFCf1MY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2B810F122
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:44 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8uLXp987834
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=; b=JQjdEduo3jUB4J80
 UxY01Cnk4y+htGI6K4HB4Q9VDGH+RDJj4KsPymFhpf7PdRne3+z38qSjHKKdTCTI
 maE419NrLKzQIFyJf80l3FKqZANQx+9NL7JKfQQHU1+o1rKZxXuy82M4oLkjzL8N
 jN9t1SdVEGYdvdegpuVRKFp6Jx7PbciC3MVFdfDNs1cwXyCDIM0kAOaSON+6dEbg
 5URf07jh1XQ0GReKmv3koAWR9AfJUeoyqq/4F4qrrVz0Tkb1rrJZ4kiXluiwghpb
 Txi5+QjMDdGLFLpydNyXVjC1een+SDhfTCXse8e0xMENr3xxdMdvW3qTppJ6q1gi
 drl6iA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16q45bh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b242b9359aso66356775ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776951043; x=1777555843;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=;
 b=bzFCf1MYPENlIT0JhRg3MxpY4irrBsCtC4Ngdo3ovKrfxtguX05Gp/si5TiHI2dRpo
 jFThzBtYg5Olghmxjls45vkMJVIy4GhOMUFXU8W3mdMziGyUom5nK+GtoU1nCP5y2I1X
 cnKul64CIlL7b20lPNiymtW3E/R2pjAbltYLQiMI/UW7iWG1E4G0lHeUNasuSWdHHS47
 h6LK/kfbL5aSO3WKtCJ6t3Q/HVInD2gQ8TAbjID2SYpFISHoqs10qsPr5X3mCGwlrD1h
 x1M+H6kiApfkr3NQDcYMtzSlErN2j4N/v201mEub6jHwm9xXiyOoF/fTCJQyVUHY8Nuz
 5TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951043; x=1777555843;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yWKLcs6KFXQAtV2FQyw0tlDf/NPaYSspKHLsi0vr58M=;
 b=prrT+qLRgyq8jUSuRxwruihdndH2ylPEFEDI9wOMRcYKJrjrXWnnpna83Ku+ojIhMz
 1wvDNMiPMu4TajKpJYUZU2m2Kfq/sKZpfk38b3dZNGnDxTikETM50mSN+wMpXFaEHNPq
 hBkg7WASdlGMmZ4yhmRjbI2yjjfELxvj3WOmNbb05HaKA5yPVf8qkEJtQ/whuplpjtEs
 X3yweIPLJgt7SxCixTv9XqFqi2jHmai8bxZf6V9GSCvOEliGPPhGzUfR+ZYYhVRnBpgS
 xumj4jASFRHq2z6jNMJa9GVJsugJ4m9aBeVphqAHH+Ta3AucK0wj41A08+xWF2Lasi3J
 H/gQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vpkvC+e49GQCgVZHlGq6NAiZJWpkdh6wUWhFJVTRdThbSnRH+9gEOWD7XZ365ky2kJYroQUUOi5g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz68tV+EPFYchFeAMOG3ZNLe8vsYL0jOYmE16uHgU5BHpB7hNII
 243OyU2Q+9dTPt7yv4/Xd/PwYzvDuLvxjoxlrj3mOp82qgsGPaDcGE1XLuBe9HRLvz3gOaDkRCG
 +NT1OQZtHLsEPwZIJVtIfDwUbtLmseoS7C3VDr1tdA9Rvf7kSmq4Qzb/720p1AzXvHj9FsKo=
X-Gm-Gg: AeBDievfxkIBUnkOWiS4Fkc2yXPUMpyRcwGsuvylKz2VUCCs4D7ugVHgxYrIfkmrmQH
 dxTkyD23KEvumI0tGjzeogUyWnrvBpJd0LkVbgXH8dYsMSaq7ARpyOw36WGbMFKV+ua7fhvtkUv
 lKwOsDVbjzkPqY4gOqaGaiLyC47tiiRrX7ipNHdxVXg08J/Obcjc8XSE/L2jcwvgu/KSdEKIt3i
 OoFdmY6/KNw/gXtCB0uNMsXBMXpeH7aORkGgHGRi64MDDulirk2Cnw/kBP5w86SQ/S+nTbHciXa
 ZvnpD61CYqYRaKH74EqO21YRd4VMDFJxZta440ec3j7GjMfNBbskVtSncxdRq6NZFFhElPdWOaE
 lmydqiR/qc7/6yMGNDbK+It/QuLJj9SquUlEjN8ngfQ41ZxzgGbW8zl6eIT1EN3tWHQ==
X-Received: by 2002:a17:903:246:b0:2b6:309:9f72 with SMTP id
 d9443c01a7336-2b603099feamr251901925ad.21.1776951042369; 
 Thu, 23 Apr 2026 06:30:42 -0700 (PDT)
X-Received: by 2002:a17:903:246:b0:2b6:309:9f72 with SMTP id
 d9443c01a7336-2b603099feamr251901185ad.21.1776951041662; 
 Thu, 23 Apr 2026 06:30:41 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:30:41 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:34 +0530
Subject: [PATCH v2 05/13] media: iris: Add context bank hooks for platform
 specific initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-5-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=3016;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=HB+2dN7dauUgdrMwzh7J5kQuRahuzqqEHBqE2I7xdDA=;
 b=gOrXRuyYOx63Ro+9sR82pXcBF5nq7YQVv4DGUiouKMpmgBheyBYqtRlAtDz0YtwxU4xK4b9hl
 ZU9S3UONyzDCyAMpp7MxY5zrCrXMGnz4RUuNOm3Zcit7fSDGObuuaq4
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=KPNqylFo c=1 sm=1 tr=0 ts=69ea1f03 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=hn6c7xJugPWrWid5T_cA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: P0Mjfoce9aRYLEA5rAQ8dZ2Dew_z2_CR
X-Proofpoint-ORIG-GUID: P0Mjfoce9aRYLEA5rAQ8dZ2Dew_z2_CR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX80TeIxXalRUP
 PO5O2UPfXQz4BDvoDwSaaAWoxPfCbcGp0uD1V/GQQ0r1ugn6zykh7xswOYwnK6vnyYWqOW+EjWD
 P+DbvvLvehfNCfn8WuyFVBThDzscVdsLuWPUYSsrTJ8JI/K7ntua99/WnJaIkKjxAgai19Fy+eK
 YyjtUJoho5G/UYdqKYq4j1WDtee8tueu7gtw9i+dYcyeKd+ky/SQdBbR2SSbbhGpZFw3N9/pFKO
 PC9ZtNKWdXsaP5imnBuJ3GjHw3R9my21muCFJDAIf0H7GM6AAlhoaKsw0xsmnkOGfTADKsaR1O/
 amKeojEEao9OSDPeww8IZqr0ARz/dixZPn5e16101MM1usdKsTMWRF4iXh/jCklRCJdiUGGqoyH
 QW1nWnOOBtl2gUciVFzfypjYUkLRLQz++yMbqQ2Qx/8dLspdZWz2ifnRiZsSwwie3MEQykSsayo
 W3axLe7mdCaXFJ74U7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230134
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

The Glymur platform requires a dedicated firmware context bank device
which is mapped to the firmware stream ID to load the firmware.

Add init and deinit hooks in the platform data for context bank setup.
These hooks allow platform specific code to initialize and tear down
context banks.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      |  2 ++
 drivers/media/platform/qcom/iris/iris_probe.c      | 23 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 5a489917580e..55ff6137d9a9 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -219,6 +219,8 @@ struct iris_platform_data {
 	u32 (*get_vpu_buffer_size)(struct iris_inst *inst, enum iris_buffer_type buffer_type);
 	const struct vpu_ops *vpu_ops;
 	void (*set_preset_registers)(struct iris_core *core);
+	int (*init_cb_devs)(struct iris_core *core);
+	void (*deinit_cb_devs)(struct iris_core *core);
 	const struct icc_info *icc_tbl;
 	unsigned int icc_tbl_size;
 	const struct bw_info *bw_tbl_dec;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index ddaacda523ec..34751912f871 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -142,6 +142,20 @@ static int iris_init_resources(struct iris_core *core)
 	return iris_init_resets(core);
 }
 
+static int iris_init_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->init_cb_devs)
+		return core->iris_platform_data->init_cb_devs(core);
+
+	return 0;
+}
+
+static void iris_deinit_cb_devs(struct iris_core *core)
+{
+	if (core->iris_platform_data->deinit_cb_devs)
+		core->iris_platform_data->deinit_cb_devs(core);
+}
+
 static int iris_register_video_device(struct iris_core *core, enum domain_type type)
 {
 	struct video_device *vdev;
@@ -193,6 +207,7 @@ static void iris_remove(struct platform_device *pdev)
 		return;
 
 	iris_core_deinit(core);
+	iris_deinit_cb_devs(core);
 
 	video_unregister_device(core->vdev_dec);
 	video_unregister_device(core->vdev_enc);
@@ -259,11 +274,15 @@ static int iris_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = iris_init_cb_devs(core);
+	if (ret)
+		return ret;
+
 	iris_session_init_caps(core);
 
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
-		return ret;
+		goto err_deinit_cb;
 
 	ret = iris_register_video_device(core, DECODER);
 	if (ret)
@@ -298,6 +317,8 @@ static int iris_probe(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
+err_deinit_cb:
+	iris_deinit_cb_devs(core);
 
 	return ret;
 }

-- 
2.34.1

