Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83469CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 17:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E462F10E550;
	Fri,  1 May 2026 17:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETLFdJ6f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eQ8nNUxn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C8D610E550
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 17:11:03 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641GLOTu3938337
 for <dri-devel@lists.freedesktop.org>; Fri, 1 May 2026 17:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RmchRiC83pBOcYN2TSRxwkiX9+k/o1bOWXi13viKPWQ=; b=ETLFdJ6fP1Hefpbl
 Jdq7AqRBBX/W763Nu5RWMHzpoWdOWnwhh4XRbyUlPxa9HuwzdEHm7uGDI1YA2JqV
 FVM7t73Z7rbSXP2LwP5invX82BRi7M7s0/w3zMicNHkiMFN9bY6SG0sH0uKF9He9
 c/inB5EsRjEgN6E91CcA6aDnWQIep3s5uivovA2bH3rxu1NAsuWZTDQEwjIcW6jH
 gpfN3cYSEkeTvTJeH4Xe7sJ99CAoKw4W5Vjt62JmXTpaEmUFzjdJGoYF3nOx4xfP
 XPwkGIt1Rw1JEzY74FCt+Qencw/iqsQbGJQsE/ltiUD/7C++38EFjBWCpFxmMsSH
 BwI+4A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvtrn1391-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 17:11:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82f0e12d375so1239293b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777655462; x=1778260262;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RmchRiC83pBOcYN2TSRxwkiX9+k/o1bOWXi13viKPWQ=;
 b=eQ8nNUxn/8MB51aFu/6a4II8mprXZdGdj7KHvrEuiV7Vj1q/ERF3mWLljPnMZF0z9F
 8y8MgS9NW7IyWP2gXYuY4BS/t1jrG+h4ucPNgdsweEQooJIQ9NvzdIdv7z/Fi1zai00r
 DGc/Tfd9xfGdikHRKEtUwV13O4MBH9csUNF9NjaofzRK+LTetnrBG8aQgmV03o6byxr6
 xzxulfiH0rXgh1bDMQk+J26WVCMsx3kn6deZ7mjn9EeWzGWCF3ZuCtp//BhhX7jaIBVR
 fUv+zdKrxQHPrNGi1UaiWaar+npkG88vzh2a4pw17vU8V2K9SvViAAny/3rFdwfwuTYu
 Xwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777655462; x=1778260262;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RmchRiC83pBOcYN2TSRxwkiX9+k/o1bOWXi13viKPWQ=;
 b=p/Z3HIx1JsAvYp4uCbdG8gr0eJyWgc+1i7q4KqArLk+aYBGz8Nqe9vH94oZWerGqOx
 lg4Z6LnT8iYNkpeE/uj95OgKc1N5jqhpsrg48HP08IktmYuAXOMc0Cn5tH6sGfldxHrC
 EoHDQifcY+FYmC37Z9bNVdYXTrvRjQiWqGh1PdfoqHxXE3vNZiS7Dzqo/uUQk+gNQNOQ
 z+6646taKBXS+bZXdejg4d/QpJoH5yPHwFm0k5YgQo6izVwEYavVJUWpwSlpvOqeNUfw
 CQh4/hh6SSzWE7MvzQy3ydy77VWiiYa2vdFFmtMk24JNfRvMhtUFEVdDsV0WRpsRTuk/
 LZyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IDorZyRWR00sfmI532yieSXOfsai+5OACoDluU7ndo3k+sjEB+eYH2pcOai9mvDcgdpLKpgQR2y0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzw6HXd70tv4Ko0GSUY8jIGHp6OR+A8hhh+h1m9IqCIWbyMgWX3
 IwiaUohrzmdeR1BxvafXSwqzLb/RAYq0lsct6x3slcRYpwcrPbQtt8IpAjkyYbIZ1xFdVYjp7G6
 DkbQrx7G+ABB+9sKOZnz1DheP4SVz7Xus352Gk74S2b3fpUKkkcwRARX32HnURmUf6I+vcX4=
X-Gm-Gg: AeBDietZ+YV5HbFhrtBBhwRTFFuPDEPPn/YWIMjNNg5qLe1TAJ7epxHQkCA5GlZDYKT
 YA2Z510ZbQpYLwD5qVFg5fMS2sMDxdedjdTVOUgog0VZBydT+dHiVe32ammwSGuxjCfZ/S0B5mS
 kRv/pEJmEt789lyF3flUYHrYBcrprEhlIsPCT+/HEAgZv6wSBk91G+cdm4einmbnfhgrKriUETO
 gGKln34014CsfWSjmE7MTciNJB7/AWqmYzT7/scAUTfdwyf6xqw4MPU9LCs+Gu+6YmpIJFvj/xZ
 0A0oxRPMmQloWo+Ao1pQadXgPuOOaM/Gju86+MPMdb/ijjKqAK0/wszebzwAUAII+FxLB4eoi+f
 sa1oo8J7h0KarTVMcgylEchgV4tT/hHWOYwzhbqKhMFW57iqCf4vTdbYr
X-Received: by 2002:a05:6a00:bd0e:b0:82c:733a:697a with SMTP id
 d2e1a72fcca58-8352d1a699cmr95814b3a.17.1777655461739; 
 Fri, 01 May 2026 10:11:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd0e:b0:82c:733a:697a with SMTP id
 d2e1a72fcca58-8352d1a699cmr95754b3a.17.1777655461232; 
 Fri, 01 May 2026 10:11:01 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8351587db67sm3099323b3a.13.2026.05.01.10.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 10:11:00 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 01 May 2026 22:40:37 +0530
Subject: [PATCH v2 1/4] dt-bindings: display/msm: gpu: Document Adreno X2-185
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-glymur-gpu-dt-v2-1-2f128b5596bb@oss.qualcomm.com>
References: <20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com>
In-Reply-To: <20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777655447; l=1187;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=RMmUS7P/YYJG0642552czUXuROi5QP98DTBmTl6xcyg=;
 b=e9oW0jAXsu6wgIxSd+1FdZ3vabLA2IjxuqyO67ysdxQlJ6Ged4eWhCTqoiWteZWe0Sfb9EqXk
 ccJtt4/KtffAFXlb96jPtT6hCjWi2jfud8USwjIqwKd5SWwWBC/wynu
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: c4lkp38IYPkfkuAQeWiO4MY3ETm21aWu
X-Proofpoint-GUID: c4lkp38IYPkfkuAQeWiO4MY3ETm21aWu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE2OSBTYWx0ZWRfX+97ozWEw4HdL
 50EMv1e5yyvDo1oQOpuS1vA2zCZms7W3lg4TVlFnSGqrIyb7VD5wE4B6ePJBnbueANZaDEEZtNR
 7qBelFaWRWF8NDwWynTPQttgV4wbHBdhnsgpismkMCRKiwLMna+EOdkb2YGQHxo17qGn3d+cE46
 RWzfqxtAMOH9JKE1tXgV+kG4mOCToQuy+qVIka6Wk9kCZBhDHrTm4BiElsPkYdppdEbt6EcaKN6
 +VG+wwqTRafR+sfmU6XHQbYKflgmRgFn0SigQtXWlzV+mTAosxgLBJzZyeb0nQTPD2THfktDQrl
 QlYu5q+c/8zGCnWBprIdySVNdXZ3UPnc0ABjP3E6aNYin4Fy+UGdcGpJeQZgO7DMVGEkA7Mue49
 VZIk5B1uOMk2wUJrYbXy5UG0uUkNwzU0Atdinb0HtgG2llzIdeEAHIIIllw51uM0+R+NyPaiqUK
 SMZZoXcjfeulNX3wJHw==
X-Authority-Analysis: v=2.4 cv=KrZ9H2WN c=1 sm=1 tr=0 ts=69f4dea6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=aapufVXKjK5bSyzaIfAA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010169
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

Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
It features a new slice architecture with 4 slices, significantly higher
bandwidth throughput compared to mobile counterparts, raytracing support,
and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
other improvements. Update the dt bindings documentation to describe this
GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 04b2328903ca19d35096f79f3aa958371d46182c..bdc8e6fa53596269854540b30d7540a21e7dcce3 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -434,6 +434,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node
       properties:

-- 
2.51.0

