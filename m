Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2ACC5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 20:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4632F10E090;
	Sat,  8 Aug 2026 20:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqwEmQlz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="inQOijfF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D314E10E09C
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 20:24:00 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678Jw6ED682674
 for <dri-devel@lists.freedesktop.org>; Sat, 8 Aug 2026 20:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qktM3bg+Fo2jfrum7AtMzh0cJBEyxVwuka/AHP45cFY=; b=WqwEmQlzgosdyzvA
 Q4hn5jBBp+0bxIn9pARgWUskvzgddlN7UkjQ6RhU5836HaLsbcmJpUbDHAoSOJ6z
 irsOB28GPyVZwEh3kaZEM+K1UUswgCQ9YUZM7l2fve6H0dxUfWJ52Gpf48WA8YMs
 WQ6SJXFl4tNc3oNTSC3qmxN9J0eS4NfMIMpKbx9vWyJd6Q01PCmdi2iaTYS8PFg+
 ZLP8b1niHFCiI4PQiMKPm2CHnzr5EG+PH55zQ/9lKtK8/XWX0Y6LFD6xyWlYrOhV
 Hkl9I0z2IZ0gcLtyo4SoViDTbzDpo3ANeeUnBECjy71Mnl0w9GMdvXL9tHFTKAyu
 Ean+GQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwush1qys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 20:23:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb6dd278512so464159a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786220639; x=1786825439;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qktM3bg+Fo2jfrum7AtMzh0cJBEyxVwuka/AHP45cFY=;
 b=inQOijfFrkjn+9LRgdVTtykrSykI4k3YpxOBtZ+VvzKrK7El019WGyYPOTMc1LSKEX
 tZ2jzcN/zJRaf3if8qGYkRmTXamDSebywTaGK958x90xbEo9GitMAwxym2G/dqyR05gW
 u5T12lXeb8Ra/blhsJNbQts58AXDUPDfVSrpITnARNG1q9V/zN6/U/2HhXgiHGGu7R18
 0DzwKMJ5XRgZkS4EhaXdQbWRJ8CC8FJZm5SmjZVr8njNgDlvPCE27Z5AX2PgFmZNk/aP
 4ZLOQMF54SKBLdP4q6Pt2iS39bK/2Us8F03Ht8YODJtAPLqjjQeusDNh8Y2IzDFe26VE
 solA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786220639; x=1786825439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qktM3bg+Fo2jfrum7AtMzh0cJBEyxVwuka/AHP45cFY=;
 b=Zu/OXWcvwb3l1DTk6/y4HcIqbQ2lIcX+stgLPFs04ZDQuITWk2ZNmzeMpS3hLges9p
 VwHpUmbf23M7URkIWmKZDbYUC8XwYf+wFeRTDeaOLOQgdKphUiUd3ZJb0gCQnU60Unau
 nIKb6NAEJAeeT+lUeTS1/pGTqpCoODPNXvbKxle0jdFxeE0HvmnnxntGHPiCG0LajsaW
 2g6KRkzXKBu2uBGiUSv0QGs5POuJ1BlPweFlWy4dzxwLpBkNDD7ysOSKWi9LHcLD6SC7
 urTFJbXiswIMbwgeb1kEB38Ipv5ofPlp9nKNZZH8BTFP5WhCQOFzDj8lVGVpegY97fY4
 C+6g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro26YuZ1uNI4MOMecL94CRs2zneILmoo3wApkBkjWsSbhz4KyoY2LRVRhpRFmHwZ/YMBeIFXwy6Y6Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxB5JO7qyfaTR5UjUbQ1mfR/oYgvT1n2raczmwqV7I/BsVjrDAV
 5k1Jyi5inG4AgyRx4DwAU1R42/h9EIzgGj5NvEjMfHQ2KNN8fp6zdFiJJ1vejTJZ0VLcXdQfo8s
 lEUEsfUM7W+UORdjSfMr0IGUrWa3PL/Am+3RGdGTMLWKs12nCb0yp71Ugp5ZByvXOAFUxNsE=
X-Gm-Gg: AR+sD11UC8g7AtlBxAN7c6R5WYS3oBIhTyavluVk2FKDkVRJM4gU2IB5m8wb2BOSk9h
 rz1XHU3lx3/ZC0+5DYIorKXH+jRO5zg/5Xhg2kwEzivNZsQGjRtl6lsZ/wU7rB9pRkrox2m8lZx
 3LFCkpB5emblEzEypy4d99SVWbsVWg96GXGNNSrLzCvj5oA5T135lz4mmoZlV/BsIvbRpS15/0u
 /HguSGQ5DcsLZIYL4toViC0w6ydyzx3SBK0tLvP++yXuBWnVE1KQNdgL0twEAsKFkAbsQYig0D9
 PclV4GpWvU3Hksj6mC9YK8DmhPweZ6q5QdDXeD7ASFlbxteTuSLk7IT+6rIEwNbJekzJOyalXIi
 QidBhQYna+vMJoiif3mQvMOgK
X-Received: by 2002:a17:90a:d444:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-3909d79f918mr19339658a91.2.1786220638975; 
 Sat, 08 Aug 2026 13:23:58 -0700 (PDT)
X-Received: by 2002:a17:90a:d444:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-3909d79f918mr19339634a91.2.1786220638575; 
 Sat, 08 Aug 2026 13:23:58 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86e917sm26357417eec.5.2026.08.08.13.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 13:23:58 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 01:53:12 +0530
Subject: [PATCH 5/6] arm64: dts: qcom: sm8750-mtp: Enable Adreno 830 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-pakala-gpu-v1-5-207ad1fac1c7@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786220595; l=733;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=OK0v79oZSQHdaHg/pOomVxs9pgnobkHsr+WBjfo/kZM=;
 b=RjaCXcVM3ar/WnN6FGWeHvktn/E16JNiRWlh9YiXqyKUmSFUXvz/gDUwVD79g8/ThXAqCMbc1
 jR2Bc9hpXDrBu7wn8CbD8DULmGK9qloyCUbIktuOL4wu48LVJQDCD+7
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 0Vklu-48TM_bnMgz_4MsdlZQlNcrXcku
X-Authority-Analysis: v=2.4 cv=GvpyPE1C c=1 sm=1 tr=0 ts=6a77905f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 0Vklu-48TM_bnMgz_4MsdlZQlNcrXcku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX4oW/D0mtP6Zv
 ZOPSfZNQ4cQKrshKCXhV1SxnKwgWC9xohczblmjwUR3OIzChABQejQ9kO6ymby48fVvX1R+EJY6
 +ghWfh6cR4Kjy26Xo1af2w3hMNAjbZkoqw3DqAsWj9atMujD9sBaHfMshY3hgm964oLCHcZ7pMr
 XzIn3Jd2cHioJ98fsISBoiJXBvJex8S5qIsRClFQOxaZPTwdOOMtUmA9aR/rwrZV0bb71KgEs42
 5FNrQKJi9Hqn0HbSOawQVsbtG+oemdnAm40M9F6rrQySBEXbX+j3PJTc3pjA+NNsqVOx2OhoSO7
 0cLTtiSr8tnMrBY9Y6UC1hNBs5ok/7HmnW/Oy3P8bt7PW7Jx3H18YRlIRfcPiolH4G5yz7Xq6DY
 0WT5wKJgVwFYztcDiv2KfuMFtwQDmI+xJ2Rk9RpmY6v5ppMAU/hUL2zH7artUzBzS8LUF9zmyOk
 Zl0YymmuZ+MsYybNb8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfXxTz7WoExmLKO
 ovQxiU3ncfzhOPdUNO3YnA0Xsm6UVYdZmDP8rd64coJJFK2jkHqTpvL4fGqTqXmqYWGNvk17u0n
 6znodS/toS9slK/MHrY25FRWHR4iQcQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080176
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Enable GPU for sm8750-mtp platform and provide path for zap
shader.

Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 9b5fbc004df4..b665d7a3af42 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -935,6 +935,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sm8750/gen80000_zap.mbn";
+};
+
 &i2c3 {
 	status = "okay";
 

-- 
2.54.0

