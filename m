Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCD4C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA61010E960;
	Sun, 13 Sep 2026 20:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m91w9Nph";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCQ08F6L";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373DA10E17F
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK0YI33041226
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LNaJ6hYn/3P
 1WJfHMhnLB63NIsjWFWZxk8ABxRe5jpw=; b=m91w9Nphu6CWLLEqAiNoxLRVtrB
 sxVozXqqT0M7UeyyO2naBT7sqD537Fm44KYZ6emfOpMDkheushHlq0IbVRwjuhn5
 /8Xf8nerCamb9Z1yCHUpr8J9fAiuPWN1E5vO/wWh6VZVP/XZwDTWbYjEcgDrg+4C
 54HflQmoperShDR5sLnr0+Dqia3Z2/fhfZSzQSXDJh1Ou2igFOTlhZJsxI9n2sF9
 MuQ4hw7mn9WcpT75OG2q0/O5xJRCR2465rFFYGBhT7Ctm9fp5I+0BLSjNgx8uzI5
 acMKO1bwdP+3n6RaBzcQxqHnJs3P01nI4BDGLo61h8ENxwQrGL4kG9PzTzg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dm3y7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9399b66e0e7so633975485a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789330733; x=1789935533;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LNaJ6hYn/3P1WJfHMhnLB63NIsjWFWZxk8ABxRe5jpw=;
 b=ZCQ08F6LbKEDn4sjSCUW1y0rbS05Nr6A81TlNFNUVwUsJm3eG536YLhYVSS1NP5XOL
 0ZA5kS0qAoajglIgqrCYATVfktKv12Gj8L9CkejGuHbGklkxHNRNgtwKR03uOlsKOW6b
 k0FXq9t3QiUZOvk9Ct5OMsjZAnQx1orTLiv7U+9T48Vl8iAH0NkgvYoOKqfWWWzIneF3
 4ohSS4KvgHlRvxSPr0nSqM8b8r+dK6KmOn0afjYWvplrm7jtnFYU3Ri/XWGjoyX8Ibr8
 ClHmGSVjXqJ61XPvfpCP9NXZmGtvFNns7iEPReZ81pFnrWtN9zouZEfMfWpa9E2ps8Lb
 oyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789330733; x=1789935533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LNaJ6hYn/3P1WJfHMhnLB63NIsjWFWZxk8ABxRe5jpw=;
 b=KB+G8KI5yXg1sdt8yte59cWqrMOuBIbh3CcR2W3eNpQ5QA1kbBMo74FXUTArA9OZI2
 UhYq+Cd3hEyVA6GS5G8V1MPJpkdgCfnoJGoTwRp0QrmdZVhrrzWCKupxxyHvM7JFI+8w
 HQwzA169oOty/opUP7gSQLd0JGlPU1YK+0Z6W3xqPiXXXChTXhH+I0LZKsJz2RsjGkzl
 fKV1qQi3+hYYQTjuIC9HkEMLBVPAHkjQD5W6PLRdDgifO9JBaNyFuoGiGBvLcyywzeNJ
 +97XjImaoNe5RN6PyHOZkKgOpdrOajF9B/A1hsJPrDFqLSSqKxw/jA/bR2nzM2d3B3mO
 2VYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEPjuKjYXRrrR2jlWkIJFpNT7NJzaOg1bEehpCv1r1zB5zgDCfGt5nmBlb3V9/InS4HL86b1av4bk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kssBiLBtuAIgyyulNA71++aWjEHPt9k/dJjvYnAOCGHuIyhlGs
 NOvIjb/eT2cCKGfpgOp+0MBilGPIye/+YMpjBHgrl0etFoCfNwrwKg5fxII0lNbLq+MzQUmuO7N
 u9pwbkf3NACFgJ5rOGGyONzLFBx2wU4A6o24jWXBMiPKlbLt6WPp6+JvwAMkpUknzW0dQfDk=
X-Gm-Gg: AYBFou0Wlz53iewWhjMXybGkEmmN9fH7qniKTOKzUDIBd0yjdtO0CdE7nbpS1VQTXAl
 EfjynyTho5FHZe+Ha0fZ5UUUtbh0Z258X9xdKGh2kBDImfJAW3B90mucqVA0ZFsL1LzLtl9p7kH
 2Xc79Uou+gi53xDKW3i7Z1DmorGxSZ1EBDBnPe1WbMOlDggj2h1I3I8QGArk9HTFjegrZfLpr79
 oUrGJlSC3P9ZWiIJ1ltd0AF9Oxte41oeSeJhtFMpsINQdqKURrEK74iucynqb4pJeWX3BQfiFD6
 IfUiWxiKEdU/Fmg/IYsyA32Roa9VaUclHHQMRUbEcFQjR/et3p2M8A9uGd0+jEWP7/EsxlF7NRj
 9nSlBNMnbTtuPbA==
X-Received: by 2002:a05:620a:444c:b0:939:d913:9a74 with SMTP id
 af79cd13be357-93a03939ffbmr1125867085a.46.1789330733355; 
 Sun, 13 Sep 2026 13:18:53 -0700 (PDT)
X-Received: by 2002:a05:620a:444c:b0:939:d913:9a74 with SMTP id
 af79cd13be357-93a03939ffbmr1125862285a.46.1789330732863; 
 Sun, 13 Sep 2026 13:18:52 -0700 (PDT)
Received: from debian ([5.133.47.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm20143821f8f.10.2026.09.13.13.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:18:52 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca, abel.vesa@oss.qualcomm.com,
 sibi.sankar@oss.qualcomm.com,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 4/4] firmware: qcom: scm: Allow QSEECOM on ThinkPad T14s Gen 7
Date: Sun, 13 Sep 2026 21:18:35 +0100
Message-ID: <20260913201835.250085-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI4OCBTYWx0ZWRfXxft1S+TqKMAb
 QCWTB8G/23FqzJOOC04/JV9wLWjVVC0VytZX6n1XE7b85zo6ow42HXJ3AzL2W9DaplqO9ZN3/AQ
 eL+PXj3o0pVpqkHIi5gAXtWZSJq5R6sdctHKD1udTuUG8grlCp0lPCsnKPm/xUYrHI2hGLy11x8
 8bF2nPEQeZwKtP8zfyTZpRIkT/kIWCSpxRsLnxBNBIg+Twu2N0Booqc2IYqxoTQ0R4T51+czn38
 rjFYIXJmqEaNHeATrt74HtW96fifl88FPWAptnRpFV5C9Rh6VE+70GYu3k137gnQ57ySx6Lc6/9
 oUb0NZlmB+dxMxlZ+IwvAXHmgipzmvaNAlTzdb8BhM4+9AW/lZ8V/tnBwhlVIyOA5DgPz48zyX5
 kYaL5vZaXdHVYSYV+ZEP1raIgu6hxJSYgYDCYMDiBupKJqVfjZoJCraKSBe3RS4cnaIKp335LL1
 RFSLb/BJdG/qIpeCcTQ==
X-Proofpoint-ORIG-GUID: EI4DmLqCsPqgDR1kgHy2EEBjwx6sbNr8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI4OCBTYWx0ZWRfX5/9k22CHI3X8
 j/liB41s1GM0Q1Mu3DHplvLgIAqxuD18qWhxZh+Ze/0ZznLZgpGtzG1/Rp4Q/Erzew1cNb53kHq
 F8ikuoLpuuhQivvJ9I2JJEtrQkZTHDU=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa7052d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=qIna1hWlAHbsUj6keHIA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: EI4DmLqCsPqgDR1kgHy2EEBjwx6sbNr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130288
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

Allow the use of QSEECOM on the Mahua-based Lenovo ThinkPad T14s Gen 7,
matching the pattern established for the Yoga Slim 7x Gen 11.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 882d1865f3a4..aecb22bb9662 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2233,6 +2233,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "lenovo,ideacentre-mini-01q8x10" },
 	{ .compatible = "lenovo,thinkbook-16" },
 	{ .compatible = "lenovo,thinkpad-t14s" },
+	{ .compatible = "lenovo,thinkpad-t14s-gen7" },
 	{ .compatible = "lenovo,thinkpad-x13s", },
 	{ .compatible = "lenovo,yoga-slim7x" },
 	{ .compatible = "medion,sprchrgd14s1" },
-- 
2.53.0

