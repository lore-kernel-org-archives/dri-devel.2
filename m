Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9866C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D3110E17B;
	Sun, 13 Sep 2026 20:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrABeSY1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ij5TCEIn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8928610E17B
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DJxxLZ2850486
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nXH3YsdC31I
 SX+t8/e3TLXrJZQ/UV2nsXGmqyk9K/i0=; b=BrABeSY1C9r+nKwVLDLszP3sWBn
 j0SmcgK7rOQ9fKgW/6WM73ZM0it4m0psUVTbep0O0cQbSjx9aptQh5+CcWs1qH9+
 MmMnvyPhS+4tdBb9Wwe+KAA6a3inVIWS1oSXopAxKGTryaMG+3oCGUjoCROqNRCb
 eQr+M0zWE4k5CqagC5S5GN6L0ydKW7J2nkL403GvVRoPRFPH0vrRZDDPfJTrSavW
 LTkmDiVt35MsTaDfMU/gXfdjrF9wcqbOi+M1R254WD7+zK2ATmttqjX6m+66avTF
 lpELG9F67QhIZrXHCtypyOCqDQ91115BYOew4860OSLuxbCp8nlvn7STtCg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cc1v8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a1bffc2eeso149729685a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789330728; x=1789935528;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nXH3YsdC31ISX+t8/e3TLXrJZQ/UV2nsXGmqyk9K/i0=;
 b=ij5TCEIn5gsGca4VOCXf0wmpMhdcPz/4Tf8e9zoF57jajhlpW7mM2z6zluPUOd7P5A
 sdj8UW0jq9NuSn/R0g78p+4TyAYbK5JwE9dbRCxbmWzHloztR5lAKzFiLNz8/64UnNi7
 6B/WWAmRyc5LAIQkC8LhS631JWOcOj9pSYuHId0LyyeUoIAORJbvjYuzpqMKfbunHjQg
 TBiCJm/voHnf9EfR04r7rgtQSGHvdTp56fQAIM489IgXIldKT/tQNhVDOIdRGWNdzq6r
 fl/ZbZvfn4+fGhsPoO+8PI9syMu5HyW8m89HHGwJTSJANz6dlQZ9IEHxL9NC2lZtJBLc
 qXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789330728; x=1789935528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nXH3YsdC31ISX+t8/e3TLXrJZQ/UV2nsXGmqyk9K/i0=;
 b=MA4eOSPTeP4zCwFKo8u8uCLTb1N/97D3BGmE3Dp7sJOg+lMG5A44IHCg/nmgyNEg21
 wDz4EZVhg7n6G5EMMEDXfnNsOmzPSNb9AR1Ina0eDqTpbMeaVJfMizDvi5ZctDfXwwBZ
 iG2OQkGslm8QWGkBRYrwVp8oGjvEF5KwTkHWNDVJ+BJ0mkCklu88ZlyGEo6daaIq6Hmr
 yAc3SpX4/6pkIY4vWvYtaQvFSSsnhKZNLrzAAAJiUtg/iI1TFHxfTRuF7qGdamuRhgty
 6J/6FjBtbaPRwJ1MNhOUSRBst9xWqz38XPFrRmeea5QEMBdE789aAodRyPxLJ1fGFePS
 +bIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdjIEG5ptrUs02pWoLK9QXd9xlfXcSdS84SihXATrNnVnjm9wfxzs11rSCQtMZ/kVhmkVWexdn3II=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nrMnvKJ8HPkU6QnyDQIPepwDprVAwThBYCwzvHDiwMBCusqX6+
 Um8IsDtGpq1QWLkWpoIV39v/VqVDitdNTT+Gjcr61RPcOZMHLaLULwNYUF8uNC18rZsLHVsV08s
 PouNcF9GbEeNw8ZVS+7NRMgro9P8kgJ1ph+MXpUCy+rhPydXxzTaOJNX1UczQ52bOyvOF6kI=
X-Gm-Gg: AYBFou2yeMHDlobUQWEmbONVeKBGOHbEdrB+vZ6b3d9XciO4hXL5fGycErLizj5ufrG
 QAml68KcDiuBtYWlrExZD9jPDFg7J3u3Yl8A14MDd+CrIwALfMY/pVQiEngYNd/iHLyOy/veL18
 h9dkjawj6G4XLSjFOYbLPTLSc6OMVjDP3ofAb/LuJTzqgECDc8Sma/0ETSTr92c1EVq/2MwTJ2C
 lgLjZmPhof8T2XpkdD1bx3vuU7+ihRBWrMwUGUqyTEg3lw/XIYYl8CT98/1ZUpTjRcCTEHPRCvJ
 XwD2s8w+gNrDgC29KOInxU9wxmH3vMyyfXjeQuTOnRfr6NUQbSTgghdw9jirf/PYuX7QyTaXM5n
 1JcpwT6+1yQP1Ug==
X-Received: by 2002:a05:620a:44c7:b0:92e:8310:7369 with SMTP id
 af79cd13be357-93a0386b492mr1280753585a.37.1789330728574; 
 Sun, 13 Sep 2026 13:18:48 -0700 (PDT)
X-Received: by 2002:a05:620a:44c7:b0:92e:8310:7369 with SMTP id
 af79cd13be357-93a0386b492mr1280747585a.37.1789330728166; 
 Sun, 13 Sep 2026 13:18:48 -0700 (PDT)
Received: from debian ([5.133.47.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm20143821f8f.10.2026.09.13.13.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:18:47 -0700 (PDT)
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
Subject: [PATCH 1/4] dt-bindings: arm: qcom: add Lenovo ThinkPad T14s Gen 7
 (Mahua)
Date: Sun, 13 Sep 2026 21:18:32 +0100
Message-ID: <20260913201835.250085-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e+mT2qp/ c=1 sm=1 tr=0 ts=6aa70529 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=8N0tIHAAogdkaPae8N0A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI4OCBTYWx0ZWRfX6PzlyR4LBCVQ
 eYSOb/TBI6doo3ywPpLWy3rIjvG+ILx/uUpoz4M30ykkBBS5fD0eCz/knjGP92hJMHSCaqNot9U
 g9LC4cEh4unR/ZsKrQIzhjjPcyzZuTA=
X-Proofpoint-ORIG-GUID: _XOsZOgQuHoLswePWI5o47AB9C6qrSz2
X-Proofpoint-GUID: _XOsZOgQuHoLswePWI5o47AB9C6qrSz2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI4OCBTYWx0ZWRfXxrFzLP7E6KAE
 0OyZNT+n1nyMfItUqcJTySRUHy4yKmi7HnLKLLF6Y2s1AEC1g/6HcDDSi22CbN2BFlf+JeM+4ED
 BYF+wHbt+tp/kpyqdRas0d9vd83VJ7AaXQ1ODJA1YD1TsV32vzpI2v5+VDYGZZuM5kWznyAippX
 fe+iMlsBSH1M2QlN8qj2MLOYilMttCqOoliHzFOeA6JoCK2XHrnZyOfoW9tBF6LQmFcsH6p0UU9
 lRP9OA7iWeRnHuEJd8tB6fAX67c5BbNJk/XULdWdXvGl0pbiZ/sa7D5kGjkflHvLctT8E7l9bq0
 f8K3i1u9RNwa3OAKyK0tErvNoH1Yhd/VjCP9bEeSPHsTAvNQqF0j0NENQcuqU/+fCoMpnV7UlNJ
 nY/sLXRG35Gul2wbRUtqG+/jNkm/gHHH1cJaMZ6gwOLFyj9jfss8IqM/aIIHRjJFmzIF+FvSOwF
 2Wa2C6pjo22zdrCVh8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
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

Add lenovo,thinkpad-t14s-gen7 as a board compatible under qcom,mahua.
The T14s Gen 7 uses the Mahua SoC (a 12-core variant of Glymur with
cluster2 / cpu12-cpu17 fused off) rather than Glymur proper, matching
what the platform's ACPI MADT dump reports (12 enabled + 6 disabled
processors).

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5ccb571520d1..52b9163be357 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -178,6 +178,7 @@ properties:
 
       - items:
           - enum:
+              - lenovo,thinkpad-t14s-gen7
               - qcom,mahua-crd
           - const: qcom,mahua
 
-- 
2.53.0

