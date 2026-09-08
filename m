Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7771EC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54CA10E0A1;
	Tue,  8 Sep 2026 07:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GtPmM1f3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h8fu6ZFR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE9510EA71
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:11:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LdSw1477252
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5Zxd143ASUomJNNgHPeOAeQIGghuC3wI/sji5Dtl2sM=; b=GtPmM1f3isY+uh8N
 pdBqgLuXJb7JBeJA2dPIzkM5geLG5/9uRvpMY4lKxfNVf3A023aLEFZBiajDFqLl
 6tiNTA9BqFC7NIKScvsugAmQKsTjBZ972F96fbAR3n5BTtwAHcSHmxIdkK8EFJ7u
 LqNRRc+luSSfnFXauixOh0q8LJu4IWf13TwYiicrPlM9tmc7BjV332qE5DM8UHXk
 4VFPDOMgCvr4NU0DP5A899uOKOjxij1QyoUaE1K8DGhcP87PjMoyUk9s9VHrjP1R
 vxF1ycJBzQ4KE/SsQGxGVPNz6MO6MSP6ppYTFHOjfixcXaIjTp30kla+yfL1oHR7
 6Egv9A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjatjgp5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:11:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93917f4ccb4so509475785a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788851473; x=1789456273;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Zxd143ASUomJNNgHPeOAeQIGghuC3wI/sji5Dtl2sM=;
 b=h8fu6ZFRVcxkmeaJMVa2jq4FOO53i0MoTM9/e+QRU/CZ2NoUvgHddyFpsbJ6EHc7ND
 f80pTjeLoGjfBBdT/TwyRqHugmFk7Cmna3g8JovUWTUKYltVi1LPTo9TQNcjmU8kkOzA
 2dDLszb0UCEU8IZewDGRFnhyBgJZ0+WuF1VuX8vlQ78K/hde/ZaJt2KwSjXoFN7MJmd6
 mJzE0LBI6iwI1fBRe/0zyIHHSttnr/OfgcxolKzc6xMH53nbzu1ILDA+vC2vn5E/LYjB
 6Opa63Pr/WO2vx2892ZF0qBkNFL72McDZ0ghcat5CmSFWgTLSgAJ7YFN5rvqaTPl377J
 2YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851473; x=1789456273;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Zxd143ASUomJNNgHPeOAeQIGghuC3wI/sji5Dtl2sM=;
 b=b7fhbnCeIDcKLSUI0HjZLV0GosCvzhcnufzGm7qF1zFwwZnf9CJvzUQ8UzbkxbrN9x
 35SVbl87oXyVL2bhJdSVVb3hT17KwIcgkxF3a2qxeo+vL3rRujBtdbDotHc9O4Rr7PDc
 5rj2aI5vd+PhRBmFeS/sb5n5gp+j1EMdMk+L5MnDIXs3YtUubfT8vhp78Rt6XS/cAEXF
 zaJW1RQ7G7vSoS0AG2Hvbq0nbs3SmLwVLeyQH3VE3TOVXmlyS4V8DjwmBD71qXEFwIC6
 wf/6xABX+anT0YSL+hLUJCyQ9XCUJShEx0Co7z94Kdf3JDXmvJZ6iD3IJXPh4miywslI
 Uh+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ5L0ibrmZ6NEgsD9JxN5zVDezDjvDSjeBUXHI6F16UQlegxgaM2vlh4NWNMCQTgsDeocNkFykkOk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m/HaTQvJnIy5SfF7jDu/rUOvdMJv85vvFLsjlFxBTin8a+E0MU
 8fIzoPGQfvq8i/0/RUkaQ2AnFaxW3NlIOZTtwgKwtLyRUE2o3+0MiUkI2DFEehSB3ypLsNHY0Uw
 TF9M6mlV9P1xg4tuaP2ehBXNPGQLaCLjr4eF9jlqwz3BRdvlSjbRCH0sGgJXAGh5J07kQEa0=
X-Gm-Gg: AYBFou2KKwrAs+QrP4sKMaNIKuFK5F2RiqmXwvk+H8+g7LPZDdgjaUnEE3eizU+LfRF
 xwxy0sBoSUjL/ZL2wxjV1valo08f+9UN5G852ltHwMMvqxGkQDnbWvoHhEsmEnVcOyOOEeuMJ0F
 hfeNvbv/UyKGa9bSXgy6wKMFqyoR1XnnNqkfjRHThk7kFHn9KPRftwQ//OtVdOVfz8af8MlVAGQ
 XNfv/qg/91ac1zJVqYsSM2/7bMW3aYk+BT3PSsd2lBHIaPb+T2aVyBb0hCjce44hx1TP/sJOiZ5
 mKkHZSgvHxEJQF5QOMl0arVnUH6uyA58vAi77EdIbZIQtEQxfjTIa3Vi+7TTY8J/vg9hHwVvEey
 aS05EhvpnuCUxYifExgIRzsc=
X-Received: by 2002:a05:620a:4386:b0:939:ab43:77a1 with SMTP id
 af79cd13be357-939ab437868mr1036813985a.6.1788851473070; 
 Tue, 08 Sep 2026 00:11:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4386:b0:939:ab43:77a1 with SMTP id
 af79cd13be357-939ab437868mr1036808385a.6.1788851472658; 
 Tue, 08 Sep 2026 00:11:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm453173805e9.1.2026.09.08.00.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 00:11:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 09:10:47 +0200
Subject: [PATCH v3 7/7] dt-bindings: display/msm: hdmi: Correct name of
 disallowed supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-7-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=dxt0nRLMlCSOHXCt5GgWA+SbZAKlsIeSxAesz/KABiI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqn7T9MnI6ATGiwoaT3dl5k4X9A1cAjL6JxfQxT
 tHgqDDpmN+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap+0/QAKCRDBN2bmhouD
 1159D/wJEN5EBolsu3UWPjUjuiwXYqvL7bczKzQULBtpg205n35tDaTi75OTlxy1e9JEgIRrQam
 /+VQ4dojOQuXB7Rm5XKKYkAM96q+S4z7JWRi8GD4roaJbPWlxLAOkFjsLfQR7okQW0L6Jae5b56
 qg5t4gmct2lyrOVYZ4n3m4EGz1vjf+AttIjwKxdaXOFFBVfDsz8X9n/ZwoyhwhhvlfpuRa0yqzZ
 /GQiVg3TlnQIGlHh+MGoN57q6aDjdD2pDf9gtS8uBlSCIJOWsN/REIMM9ydibPl81DivKDnFPkw
 11nuWJDSKkdiJFXMoqKW9IPeDJ9RtCnpJzqkj5Xuq7W/kb+jQXHZDkn+wuK5U35YU59B6TGicQJ
 gOh0HlYFeIww10cex+Ag2zFis1gMzJL+8n4CVL2CbCyn0EAQ/Z/6+876Tbs3p5ZZqeVSztP5Afl
 QbRkVOQdrawJGCrQMi4atnXequexJkSOi8Wl/F6Z1ttC+aQGxJAGz+59+ef81QiH8jrlgZC1ile
 U7g/lj2XMEvhTUtvHDK0aAqIMGBffTNeOiRe84i2z2twEuM+KUBSCMPOEEHJw222BiltuPKGtgT
 RVJlLPUj+P3zm0XsUhuesMJeHN8lesO1hrMGrDWW3GYMWwML2nuqLSVXcM4B4SBtLjFXqkKiWbr
 FzBPqMDD17Y6ZYw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX7TgGxSgsRrlw
 YEy4/fewihi7MCEiq1Ow23m02VYfbRRLIw4m5SQom9pVJwSolaLzLrv9zHTAjewzMU02J5m9ISU
 KK612x2NDuBUoNalHL+fqMw7VLd7OR0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX9fO07dh44TZZ
 NfE7Yhs933FF7ou6H4kn/ESLyEKYSCupnJLQf+6Fn8GpwrOYQMsbQx/oYP3/g/sZGvPEhX8xFW9
 OtpFkp7yKH/0srbVPtkl8Wa63fQFTzm1zknAzqWxIUbI/rZPWl8xAaUQaOhZrgzN/29TgQUJfKm
 V1IEYAuHuW5DjwTPbfybbyfL/vVvJQyloG8RZkK11HNICDAf0+p+rzpuh389fDm7Psf9MsWqAB1
 UMpFgoWM6myL0Z9KlEt/68vAYeEO2i6NFRlu9E0K5xAAZGOGpw8qNXKvsvpL20KxYQ+BqLamdKs
 6wbJrQsbWp8h9CIEcKl5A49+wlw1wiKZm9fJjsY70O4Gd09NmPuMvbPq2FKATN0qkdO8XQa9siR
 l2kCuV3m5tf2halBESsaI+cSY9TrydueFloyJ5+290+Azm5gQWeOsw+Nb8kbeedL/0qBnpix4OR
 ahEkIcKNQVVRi0iS+sg==
X-Proofpoint-ORIG-GUID: V9d-w9SjLls3Dl9DGOsyblqt0X8cSHj4
X-Authority-Analysis: v=2.4 cv=QrduG1yd c=1 sm=1 tr=0 ts=6a9fb511 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=LSMMCDwwRte7x3nqQVUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: V9d-w9SjLls3Dl9DGOsyblqt0X8cSHj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080072
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

There are no properties in DTS or Linux drivers called
"core-vcc-supplies" or "hdmi-mux-supplies", so the binding probably
wanted "-supply" properties instead.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/hdmi.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/hdmi.yaml b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
index dfec6c3480f3..02d27ccad024 100644
--- a/Documentation/devicetree/bindings/display/msm/hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
@@ -113,7 +113,7 @@ allOf:
             - const: core
             - const: master_iface
             - const: slave_iface
-        core-vcc-supplies: false
+        core-vcc-supply: false
 
   - if:
       properties:
@@ -136,7 +136,7 @@ allOf:
             - const: core
             - const: alt_iface
             - const: extp
-        hdmi-mux-supplies: false
+        hdmi-mux-supply: false
 
   - if:
       properties:

-- 
2.53.0

