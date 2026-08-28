Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AEBC61DD9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8125610F3D7;
	Fri, 28 Aug 2026 14:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gi03dk5S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fSyZyxfi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 953B610F3CC
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:39 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDkci93075349
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5Zxd143ASUomJNNgHPeOAeQIGghuC3wI/sji5Dtl2sM=; b=gi03dk5S8dPzpK6H
 5Jr3NrN5ftZNDTgS+nXu6GOYO8qbA2SxYUJnNMT1MgnexuKo3ydjNxqQXVfaUuxq
 Fnwg57Kh/o46B72HXjMahgg6W71oRhRgEy0lZXZisbfTAIWeYu5ICmXhh54h1k9M
 krGFCXdW5hmYO3PJnIuUsMrea/2XV7oJ+KZ2DiOtaEc4vMaOufBJMvMF5TjYL/7i
 umKLWatKGBvePJPPCnBYKbayOi7RTVJ2Q6VUYKjfRVLutjp75gXvVjkZIKtCdj3E
 90t85bH9oa9zsIkDN+hx/gm/rKBbgZ1ClWRcyVo1OCCorRhHRyE+zI+aVRWzuM/E
 bgXZQA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb1v3ahfn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so8820551cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925938; x=1788530738;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Zxd143ASUomJNNgHPeOAeQIGghuC3wI/sji5Dtl2sM=;
 b=fSyZyxfidEDuzzAwa/qCijukat/J1dXGuOMKXElNZU6aAUy6L2rFfnj7b9TYF5NQdD
 QN2xD4p6aZ5Tz9HOGyXLfSc+tCgv97RnC/kgQBf6oYEr1/gz9PcvjEKntYxSNBfzakbD
 AmH/xia7AxeMbs+pH3cj7xWiCY3q/56kbgA3FzNyJV/FA3vLVmOHs/yt1unaU1+dsWeT
 Sqb0uE3DfdxYoj/fnVt2/qZXS7LTAYvysrCIW8B2ttxPJSpw/iY2CGgQ/J9ysiK7pdBY
 s/sCfl2vG1/dQOOtiVGsE0ChjlDHEHmPD90j8kAd+co1Y+8U45EKBGf4CRmCSTW7kD6L
 /fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925938; x=1788530738;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Zxd143ASUomJNNgHPeOAeQIGghuC3wI/sji5Dtl2sM=;
 b=fP5T3sGMk/9l5JwP2SDqsTasM8uzAEGIrajofr+w5rftX3hqEsl73z6UqY81ZIfKvX
 2BFpibiDoCpNhIAOYb4S8rYeuWrL8kxClSYyeXuuAHhhQp5DUkZYV6ie4NaDYL8r4eQ9
 MKjNaWNIMC6IXbT2soNd4qhIlPYPlWMbjlmOAVKu6AxMhp3uOZ3cXkCsJ5y4jWU93suF
 0gPDcb3mJfnaau1L16Hq9MhzQ6ZEfzOGxxcZ/ZuILThA6GIGaX0K3bc6onXev7zJrnwI
 Ur4UVST/zmbGEW8S0ITj2u8cp9HWmNYAF0WOIOEOJTbTkfxcahTqCues/eleuYPbG/o7
 iaEg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrec8kwQoIk+S7NOTT8Yzs5mCnA/fCRqCD5YZrX0VkZylGrVex1PtXhP9tNIOarr9t5jWvhpBwAZxE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++loOsHyFKm6AOCO4bWG0Y984dP3ZC3gZUjnv7YnmK4SU6n4nZ27
 Zs8AXxArXsTXcm7AeyCuZxdTUSrCihSZl4yzpqZt/iwqYBfGlBlyz8wHWqZxmsKIk00ePBUl730
 9SqeUnwF8N0g5Uj5Ky9JKMRCsYWQx5hSaXyPlILh0knk26Pw2JP1X9Cxb4xbC4zCeOb6l6V0=
X-Gm-Gg: AR+sD105KfPB7NueRrIWdrZrfkcWm7J29CgBrA1f7OHeBmBk9HBWvYaCwurG28ACu6j
 zXH1uIeGtWIhsbq90On17NzHXXzeU9MDqMdRvYJlh5Ipgudm6zLh7Jy6QkaVsphy1F19CXmUe0l
 Yt7atV7LSFZbbRbgTe5ykvEbGW/vPLqeZSeL3oJ2i5A2Mza9K5pOYSz8tVSmaFQkazWyLigE7H+
 yfd5uZOanv52v8DgqNOlfx0FGJQZ46+rxSf/yZjeJGYMPVY2+/UzOfk9H1gulngjhh8Km6gyVo/
 ZDdbX5hYC+ByAF6PxNrnPH0IvYXLSIhZSj/ofxyo+kJa4B2hy1eDRbO80m/Cfq0EMPT54mT4SHM
 KNiiFDU42m//JB9wMG4mRQ4s=
X-Received: by 2002:a05:622a:14e:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52fb940f94emr74674391cf.9.1787925937905; 
 Fri, 28 Aug 2026 07:05:37 -0700 (PDT)
X-Received: by 2002:a05:622a:14e:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52fb940f94emr74672371cf.9.1787925937232; 
 Fri, 28 Aug 2026 07:05:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:05:02 +0200
Subject: [PATCH RFC/DO NOT MERGE 04/12] dt-bindings: display/msm: hdmi:
 Correct name of disallowed supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-4-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=dxt0nRLMlCSOHXCt5GgWA+SbZAKlsIeSxAesz/KABiI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWbJu9iixJwm9XNddPSZcVmCxWgF0WLJqc2x
 esPt9B+9uWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVmwAKCRDBN2bmhouD
 19VjD/4v1r5Juz7BMmixRhI1GYLMqcc3Wnor8vlc0z4pT+CFHeP9LTVl0BDJqVlC0jFUzbtFRNR
 JbL7AEEgjUy6LnwG4HmNYOplyQR8aUDIbCyFw4lwud14ssL/67IQzlID3OnW305TgvYYe/myfcK
 4lgXwmAr/5OM42lY/tCkbvG63YwRSPx3SnzFyrLVExL4+02BvNK60ahBF5TmZU1uNUf4i+/6AzJ
 1jUlscemAPuFpOdM5jI77M6mkvL9eOcKIEqW+Uvk/0+BgNw6d0L8N0cJySUpT15iyVb7V3jJfge
 o9PuvzxTcoT/xaAAAwVsPfZ0Y01pI7yJ87DNHeu8W6vF/nJk9o0pBHsFqHSN12AdkLsTiTnpmF9
 HaQIiTX/LGfW5V6vhZjAwpfb84vxs3p5jB6VdYpc0H+y+Q3T8DX5z58LBrJWtyw50zyCgWwTsll
 +np7qWem/Zt+cmRDtB6fH0eZQHq+PbT37zduRfnvS5GVFGQxZ7SgXwqUg/OATHtHjU+Ng8ADkaP
 9FBGkPnrPWucubtx3c9U9LGfgcCSX6KwJAGpARyfuSeZd5BG5cHXYo7kFRn3lpkH08T5yqKtaOM
 st688zOzCrg9xdtvZrXgZsb7wS5FTmd7MD62+3alvLvG1oQ/bdPw7iLZJj22Wj6FY4FFTuvaLoV
 Ua1sGS095TT4eAw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfXxdNrv8eWkc09
 cHSftt/RvDfcL1ROaueKuHo3royaSeztKhWvNQDbbhIe4yqgfQNK/ClHdgSwRi5NUwMKJpxeC2y
 S6XNtYbaNjWA2TQU8AbWBeg/xxdgj4swAd2sJzhT5uGj3blV0iZggsp+vG5heyJhGGzaBhZ04Vm
 17XXXeybzfmhGh/pW2LmtrewG8GOtHRpVaV5G4fgR4Wvgfzb8vjK3mpDu1p5hoc1kOjrXErcAKj
 cf6Fcya+9K6skoomC7TB1+8tJrw8fU1Se8VuspIaNxxWP+mav2WoHm6S4JSYw5t50Vr518k6vuQ
 4+03YGM2ScnSbCkTGrKJ+XV5jB+4YkYCHizBF7YPbCXyy7za3oIdcXCcMO5waFB0hpKvCgZiHwN
 WS+trYOwPV/RJNV/BtjKeCdNLovvDIjs23Ndmb4Uu4RmkIpVyNODZ5i/IpxZ/O8nzRPxaJ6aCl5
 fzjjTnJr1Ew4MjvT8EQ==
X-Proofpoint-ORIG-GUID: gdXRfUbJatrf7G7yIRlZef4eppDmsg0Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX83MiFk6qJgMo
 j8GItf+M6rg1qD69ZTh1OZciYF2ENZxE/SReEHKhY3QHnzy/5yUdc1u1fE5k64Mm9i3pEX2n5d9
 UvX8+93rqcmqYLLSy+HWQ6jp2PyW57E=
X-Authority-Analysis: v=2.4 cv=faedDUQF c=1 sm=1 tr=0 ts=6a9195b2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=LSMMCDwwRte7x3nqQVUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: gdXRfUbJatrf7G7yIRlZef4eppDmsg0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280122
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

