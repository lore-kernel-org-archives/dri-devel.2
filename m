Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D39F506D0
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0677D10E1EC;
	Mon, 16 Mar 2026 13:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o1ZRHkrx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="khS3xJ3E";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3473310E1EC
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 13:46:13 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GBkTYl2129273
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 13:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=BG9HMbl6zyBELeZS1Hs4NCoLJWZuv020DOc
 rjDlWN9s=; b=o1ZRHkrxi5s82PJN7V8duHnQaRhiGRjLmY+EAOFRrIvfQEIREFl
 AqXu8PXs+4fidQ8Xojg03x0GTPa0o90oPaj7q1iEoY92m1r2EJetlXRxtJ3iGQQA
 wObiHqXttcUc+mGITl9wnJBE4z0gFPYYDOISvb+Fdf5oLHew+PRCDcSvGhIEdEkF
 h1wl7bMRkaGxGN4acLlzCM74IwjSrqKRu03DDcvw/WpLR3W37t/RDkjXjJ1Zo98C
 0e5xiymMiSB4fIag6dpo4iwUxgmSVfCueG+BympvGMn37RfjGg59kwiqwGckICAN
 PJHuupslwurNRDhsp5vW3mKI1+sO6FylbQw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00ap4am-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 13:46:12 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-899f1c1e4d6so479699936d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773668772; x=1774273572;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BG9HMbl6zyBELeZS1Hs4NCoLJWZuv020DOcrjDlWN9s=;
 b=khS3xJ3EZoqlmtRnPJszX1mq1o9mok4PiCVHOQAXAkmPEkbz0ptzOI3BckHB+HEIIp
 7/FLRwdYE74/2z0ADnjTHYPcUqY826dEEeIx3J5mMASKGtNSwSHQJOyk3yF7ZEkY46Uv
 1nWfIz5oOh94owV9soIVv2dVHwTHpbKImV7qKpQH5UnySH6Qj8l61AW84wh0ls584oY8
 DGBaT9Eib4gXjP97dDVIO5IeHRskpUDKVUbrjcrDItfkRJ1/kPvc2JkKlsRX56QveYs8
 LxALvajYF8O5tYHa4nL6URICV92+cjuMmW0cBJ32NEfJDqzxgudJY7dzZ0BoihxmjTRW
 IL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773668772; x=1774273572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BG9HMbl6zyBELeZS1Hs4NCoLJWZuv020DOcrjDlWN9s=;
 b=FnwmlYxO8ne72fZL8Nt22didbu5H60xp0ZGjkwCG1XyZmlm2IE6SiwvGhEHfrAqBhr
 W8Q/rfoSRU3OVvL2OHed1l86C4uWJjty3S2Go19dTGThH8/FIimzJjqH9n/lX0JNXd8I
 efOEJA53f1+xtPtSoKzTFPU1JqMiOkhsLgpa/3/nSSpv4mcQvHv2GZjSu6aTofVZgLUD
 Un4GLdCm2EPugcWN9D5IsiFY4UQZQUXuDdAUFDlZsEHhGXLd9zkp1O+VaoBWmrxIv1Qn
 KV6b6GRmbLBNVrrHZymK4btmTEluOkYXwm1+1PeQH6LMWzGmhqQCBJJTlZjAjckKPSUV
 Teaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSizDouO7GAhI0zE8a12rqQsc3n+pV3B7VZKkP4VuYLtb4w9hVlGKaCFJEE+/RWG0LTFzOYEApS08=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBelUA9n+cmIZanunT88M/LxzmT6syA9DkqRPkofnusiRuBGID
 UYYwGGERohXetBwdJvtaVdJV0bGUhultnG1Q/5Gh2J/aY7JPaDnxMg+GW+TW9MAtUkac5S6+bFD
 r+Rkz9ipuRBdJDBh/sVQ88vUieq5H/uDl058zwfyS6lPmEquS+UgbYknOs6a5zHMAHuDOOMs=
X-Gm-Gg: ATEYQzwhcXAXz5ym3K5q7/IutxXzGIFiNSpnx/KkYFnk1u5OLClzzhJ1ChR+cBw8y0D
 8Y8eYIy+x/jV7Sqn065Bqz6M9HCinejANev/G/k1uLR3vzsCZDRANI+M86A6GbR+WD1IVSG1TDV
 gNjJqTAhNgZL3SrjGiZTTZpNT9D0OjHq40M64W4UHK1d+jQMW0Typt8A6z9NmQP4HHFvdOcpiYd
 7nbESo7AzRkH9YfCJpPdUSFDez97rdUaapJOtrdx0DiKEEyvXeGRq6anVGOzj4i11hoFdQi8v/7
 3/mBDVgS+HKGM2llrsOJtIVy6xL9If5F4H7nyStoa446sbn6v9vPRXN5cmfoi+34FCGAvM7bo39
 B4FGRWKwfKwT0aaq6vvIoDtWtTkZfLshc26yW
X-Received: by 2002:a05:620a:4005:b0:8b2:f269:f899 with SMTP id
 af79cd13be357-8cdb5b926e6mr1696837585a.56.1773668771540; 
 Mon, 16 Mar 2026 06:46:11 -0700 (PDT)
X-Received: by 2002:a05:620a:4005:b0:8b2:f269:f899 with SMTP id
 af79cd13be357-8cdb5b926e6mr1696830785a.56.1773668770998; 
 Mon, 16 Mar 2026 06:46:10 -0700 (PDT)
Received: from quoll ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c7220dsm91275765e9.30.2026.03.16.06.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 06:46:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Adrien Grassein <adrien.grassein@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: display: lt8912b: Drop redundant endpoint
 properties
Date: Mon, 16 Mar 2026 14:46:07 +0100
Message-ID: <20260316134606.57070-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=vh24VE2sjnYMckBTgg0yZ+Aajseuy5CqDMz0MME1XnQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpuAmeLqie4LbWOSHF6SgOlyPUeRL0QXDl/hOu/
 0yotx7r12mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCabgJngAKCRDBN2bmhouD
 18avD/9XP30qQcyYT8f7RDKU3pQbvzDa1pi3rW+eDY3T8v8/Ie3/2PdLXfACru3r7y4HxuMYLf5
 hxWw2xF39pVD5kWl9Pqm0BrU8KMMG3igjfMved3fdMCxVXxl/fgBC+UMfsThmSLGqRGP1ct4mDX
 wbwgkM1fS28/eH6JO+b4FrKgLfhej/z5OUfW5OSZjgT0DHqsRdtQHFhcTTRPgt4hfQd+ksAadPK
 qMx9GCNyUO7UP1RQlE8fd44IBuK1SItuPDBjeEifsjvmA20uZc+G4sej42TqfYDXUUJqSpSE+Xo
 sF3UK4aPSgDp9DuXiotTtSrK9VpsvFhXtNyAm9MLdT35Cq4xts4r9AedE4/AKzwBTpFVUJZ4630
 UxZPpDF6GbB8N31gN7UUclZC8i18ESQWOc1FoAoMeB7LS0FS4imJQKsQFBpVdneMpCYfIGHpC8b
 4I1fPXgNMLgXIjSZ9SgkHceD/0UNYVwMExOIHtqjfrQvyhCgKU5F6/2o796DZyFFlIeC83gDlMz
 pUHrnhfktCTySseEG00AeyywI7JHQy6JfP/fALwmzGNovW7kH8KHpBzOJEzCpjHg0wbZLepecIB
 B/ZksvuNgWIZ/TOcgo+u63WeMi/zihRKLkk+/e4149VIr2Xe9ijGh2FlUNcrSEChJ+4oqZ9F0wL
 xBm/JUPba3C+Xxg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Kjro6k--M50HxAWKSKwze4wgN7FwPICJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwNCBTYWx0ZWRfX1WpWrhIQUAWo
 QIP1PlEBlKRj9oTKXplO0ghzxmJpbFFp1MPrdassx4p0k2KBcWkzAsHrJ3XQb3VjYArtRaRsANF
 uT6VqMmfL+6VCPOYf/QQNf+k1jrmmyKL8x20QQBPXRufQI9muR4cMfrUDCuV2/sbU6aCWDZ3bD0
 4l5qkaDVcc5CugxGxYq9by6tmPH7IOcoxJVy7P7QtrsjjHiOAnAqhfSjjkuMh7bueYrDHPc6oRf
 dH01FZiA4Wo7auXvJqZ9CHVveNrl6IsxURUDO7rzuKjBcP8kFjg/GFHrMIa5FfhOoQnP6mc39ae
 Qb7k6GT7B0VZSdN1QeV9Y5Bxg7L03tkv9ZKbxEVFIiDCJ1NJsvGAJr7dnILnMCVkO3s8elQs/LA
 7GmaHFAXkdsqzBa4USEWAq6+io+tEKZNhaL+cRedhWkdg1WO3cStTX1LczIB/U/Yx9RdxrK1al4
 CtBXUtEau/OhmSrKowQ==
X-Proofpoint-ORIG-GUID: Kjro6k--M50HxAWKSKwze4wgN7FwPICJ
X-Authority-Analysis: v=2.4 cv=ebIwvrEH c=1 sm=1 tr=0 ts=69b809a4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=X6E4nzaopIIGKyYGNtcA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160104
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

The "endpoint" node references video-interfaces.yaml schema with
"unevaluatedProperties: false" which means that all properties from
referenced schema apply.  Listing some of them with ": true" is simply
redundant and does not make this code easier to read.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/display/bridge/lontium,lt8912b.yaml    | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
index 63f000ebc9c5..988351f3cd01 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
@@ -39,9 +39,6 @@ properties:
             $ref: /schemas/media/video-interfaces.yaml#
             unevaluatedProperties: false
 
-            properties:
-              data-lanes: true
-
             required:
               - data-lanes
 
-- 
2.51.0

