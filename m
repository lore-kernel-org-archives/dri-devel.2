Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAB606BFFF
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YvX39h4p;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V2ohhKRF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E684110F6AD;
	Tue, 10 Nov 2026 13:03:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC9F10F6AD
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:03:07 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAB9vpB3195924
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=OALV8vUNInuby80JCyIJlfai0hgF0F+FwNb
 ODqepVpc=; b=YvX39h4pORto6tcpRFvnzK5hYYt3WBlKs/UU8rpssKijGYuCc0j
 lrpk+ZcOd3zDJrWTm9zAUHkYArNm24IEABX4HFVQ4eWNj4cFFPMexV2lYJYboioj
 EwJnRxIe7h4ru2S6gEwgRSR3Eshjo+cc+lNVzVyT4Vnt2rMA49rxUqLBhXx+oXnb
 jHyj9oG3VePfLUjdM4PxF7aL996dQChZNfTViT5xqVfWqKK1dqEvhBHzrGKCHTeR
 5pVGf48m1BOjBZufKnMAzhF5Bo1rGHu95gGO+3X0TO7ZYayHSxcL+/5cdMBFEC/u
 eMGGvXlfIvGGeLbH8q5QHspKsPSuxM65LsQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv03crug1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:03:06 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5eacd2f2229so2337138e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794315783; x=1794920583;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OALV8vUNInuby80JCyIJlfai0hgF0F+FwNbODqepVpc=;
 b=V2ohhKRFg4BhbxH5nqE8Jg9AyPTM2rQOw27nLe6pfms9/Hog/wkVBEVpSfQM7J7WwL
 ZWn83tclfZB78ODI62lJOOKGYGRbu1Zdt1QPT2k8tzrz5kmOL+bECBz7+q3l8PZv4KXz
 lE1qGvU0K0ibznnUTFNFza7Y7Sp13gnsgPHQO0WhBIEB4F6XxEVXrXTBUxf1EBS9Lg6G
 NQEDb0jr3yQ9s/okF1HnHtEXKOql+C5gPsgxqHFYwEhkEHqPbJywiqgJrDZmbDE31DAh
 dCgz2QGRfxoSKAafv6joAIhj1R39nrC19G0MT2EaPS2/sDf1+imj0QY/ikQDMaHDFL7r
 YgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315783; x=1794920583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OALV8vUNInuby80JCyIJlfai0hgF0F+FwNbODqepVpc=;
 b=rSbNRQIeLHE6861Ww2xq5UBsKD60gNrBxNGiKaFdcBW3I6M9B6AP4gL8rwKxemyeSJ
 RK9Jwo+ucZxpOkjpyvYA6FbcxX4dck3YuC62mMoL8LqtE+X1hlmOMalmOMOd1ykzW59a
 d3EXJXab381afJiiCM/a4iwAPOiFVSA0zQbaQKJQkGfj4pa0gwKfbsjSKQvq6Kc9zIfl
 xwfgkp9fB9W9AHfGlnVC9DVjM3h5qMWsDV5LJjNS2wIJz17ARqI1gjinRfslV4cO6O6i
 gq/jZS4SIj5Gfr2ZYOp8PhopiKyqUXB8rCaxg++Yk+zXtfwWzEpg35ObEgdlbf4Eb3fM
 +iAw==
X-Forwarded-Encrypted: i=1;
 AL+hErEaMloCT34AM7ySJ7+Q4LF5f5G3WGHrhEqSJiN/vy3PzIztwofv6gV2nmsqxHFaXtcpa5F+hDOhrQs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Dqz5G3oULJjNfm5GXOKfTxSU8KlCSG0o5Qo9gFCi66xEQZqc/
 QhtbPvwc0NgPf2+ZQs1zYq/w6Wpt4Qr0ZaQr39sz/A7FlsKm8+Y7lq4TIcnNXOJ9alSqiktsDh6
 jHLTSbkbDNLJ/DZmmnny9JIqkWvVn4Azmw4t5IDmlcHtWZIWslBZCY9hi7phznXm+Md2jhNo=
X-Gm-Gg: AYBFou3Ew7Sd4oO2cw9HNFyoQQ15qKwteQ8IjBYfBuj3kuUus0t77iC+uGUfnZMO9WZ
 9x9OtnOETtTXttgGuaNGws15elxq/XkmvvQSjIPtkgnC0v0vQ3d3f+I1yekip2AjpfrTDJXWLVM
 /KnbEB7CpyG124BT0YYtgA/OSUYDX2rCDF+Mrzx20p9FePf7o5DlC8EarvJnfHOK+GSt5gybJWJ
 7q+e2pDTzUCQrdNhgo4sNnlfRmJPBfWq5lDdZZc8h+W+4L7nSNSBkGV/4npE/T4b4jtSPEbb0f6
 rcRa9zR++cDzjR/SXIyWw7WKXGaJRQUVmJci7fmzJfJ0vFPrbWt1gFzpsVW8hui+to8Icflp0X0
 vc4my43FkpdkQiUrYaF25SToGb08s/v5STiDaKaISUFN5nuB+aZ8SjDMxCZFHtw==
X-Received: by 2002:a05:6122:8c8c:b0:5ec:5f1b:f725 with SMTP id
 71dfb90a1353d-5ee0d1eac60mr842157e0c.23.1794315782439; 
 Tue, 10 Nov 2026 05:03:02 -0800 (PST)
X-Received: by 2002:a05:6122:8c8c:b0:5ec:5f1b:f725 with SMTP id
 71dfb90a1353d-5ee0d1eac60mr842031e0c.23.1794315781206; 
 Tue, 10 Nov 2026 05:03:01 -0800 (PST)
Received: from quoll ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0236f03esm49121585e9.3.2026.11.10.05.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:03:00 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: display/msm: qcom,
 sa8775p-mdss: Remove bouncing Mahadevan
Date: Tue, 10 Nov 2026 14:02:56 +0100
Message-ID: <20261110130255.134252-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=gnpSXTmvxtdhncMRhWieLAr3GFCRnWpMUR0hNvdBVWI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq8xX/gD2I5kvb1YaQbaK1Hj8UhSJ7L7MJAvGQJ
 7k1aiqFbcyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavMV/wAKCRDBN2bmhouD
 17/CD/sGFI/+wjlERaJ3BaT8xEiNlo4WsdazaWIt+yqGEwwmOGNnspemY6phkyMur0Ch/yEal3a
 a0tuhSFEl1ZsKnrVf5TyrKwbM0tO1fwW9H4NX6Zk5TFnC7IQGqlgM4UFFMgnD5TxKhZqiNQiHF+
 mW7ybexMFHJ2x5JAdfazGmya8YfXbrwUxGTFTVaEWdYhsocu4dHR3dcHaoKaUcr6Cjq5W4y7IW/
 ipdwwqFuB1NzhcwepfHTokkewlD7NKUmng7EmN7H2/d+Q3fsHye8RHRec2VJU5JfE4C94KLkNON
 zFaFlTJPRVevVce7u4pAmKFQTZoAbB0H5EoGP8Gkl4AE6yJ4+YGzKVetP69EHmnWx/NYl8rnwvf
 j51L3lxJ+U9QaPmTSITfdaTWdBqW8xSFHMyu70gYKdTTqQqqRo8l522iB3DQIaJEVyFdPhSBQnm
 9TwE6DQVBakI2u7Wq6BdWA4zuiXfLZbTRD48o07rnK12NIQbIDI2HBFj7uJ4/Jdkje3tQ2bGu/c
 f1F1d20nWvI1MipHiWB/kSDBH4TeA01f60/GpPIpHnxIKBD24cYH65wtnF8Dd1sHIeqxinWT4Ua
 iaMIHCTyW3T8+7TGz0Viyro2IOAlOrBa34uluDdzL1rrzjccOzXbGRhRZzaPv7Y+uoBcGUC0TqR
 /VlewK6oh8hBQFA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sx11hYptPkUKUiBFdpn5civc6aQXqIxt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1MSBTYWx0ZWRfX5C2g/tNqN/aK
 FhR5MyKKK/OE/cpyo/ByM18hhImy+x0VYL4bwVbCPB+y7MHIL7VInuyDWXUcySfLpmaN0YtAEOq
 CQmMMBrmJHSGmVQaBD8SQzey4P56sDA=
X-Authority-Analysis: v=2.4 cv=FuiQbGrq c=1 sm=1 tr=0 ts=6af3160a cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=pRY3rvhn6SD9K9aC0tYA:9
 a=hhpmQAJR8DioWGSBphRh:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sx11hYptPkUKUiBFdpn5civc6aQXqIxt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1MSBTYWx0ZWRfX1YeRUy0Mfur+
 eSGzll9Cjkaw+8Qp9cRoDUfyFVFE9DlD09RVP+v3sWZaEKVE/myh3r7DrijXIdN3S2kAMwILZ1c
 fHMdgKZBpXznh8XfxgYAOUyG2yJU4Qg1kc0q485uyL3Q31s+kR584+YBBjikFqmdppV+xs9NLTU
 aaYjkICVeBUYwFrjOqva46U0Wqj+UlFvYMQP8Zh+KSX40XljvSiwSh/iYsnv2amvNZVc4sc1A+A
 vd/RyQYxhCYfEqc8lHwB+jz81Qyo9kEDOK+YJgjKw98EY/QOki2uuYy33XXPHartdaedd7ha8kQ
 bt6JwCzZcemkr/Kgj5KDMEhGBeVJE8NyBCLKXbKSu1iAHMPpqLLX8vKy570C1+AF7tnpT4zP6zH
 Slc8xZuy0DxMEZdReN2IBhc8kEVFRke3Fr4WX42m1hRfK7GRCd9wU8Frvaaghj0OB2SI/x2mNIb
 X7NQdGma7+0wnYDsN/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100051
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Emails to Mahadevan bounce permanently (error 550), so change the
maintainer to DRM MSM maintainers (Dmitry Baryshkov and Rob Clark).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
index 4dc0055cd841..48dd897d5d5b 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. SA87755P Display MDSS
 
 maintainers:
-  - Mahadevan <quic_mahap@quicinc.com>
+  - Dmitry Baryshkov <lumag@kernel.org>
+  - Rob Clark <robin.clark@oss.qualcomm.com>
 
 description:
   SA8775P MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
-- 
2.53.0

