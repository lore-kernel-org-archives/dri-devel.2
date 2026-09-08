Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEBAC79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC29C10EA67;
	Tue,  8 Sep 2026 07:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A8Xz7Zdy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HkHa7MD0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA9110EA61
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:11:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LmwX3299433
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q2zFzzLUBztHpAlThCWGXoxQohXTYyYKFSjILxdt7DI=; b=A8Xz7ZdyAkeaAwLJ
 6UJTfNONpzJAFMrh8KS8KVLccPftP/jj9BYeLN6w3C5lLW+yU05kyDq2M+Q2x7HA
 wffZqzsPYWTHg6fBicjTyFwQh8ptakbow0VCAy/m8ElHElu/jX1xtOrqY9Ql2lHn
 DELf51Il/pj2k2HTv9VCHUnK0tpHJ97HLJj36obqum6KySg/QhMyM2S4Vg0isEY3
 whyaf5Q71MJN44Z6U0Hm9LVRk0PLMaGo9oDs0fxiP1v6tsth7TF/jS1jHjkYMNzi
 amB6BKRO5jkeFlr56FacfVCHu4kabvoklPzO0X8HOmICs3iFkmMuiIQkWFjupB0+
 pSFm/A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0p8mwb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:11:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e62e3459fso641366985a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788851463; x=1789456263;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q2zFzzLUBztHpAlThCWGXoxQohXTYyYKFSjILxdt7DI=;
 b=HkHa7MD0vN13HMTVAKLmjLXCG63BxTzqlagbrdoOrpOrdU9as8b9w/Y1KtM33AFkAi
 tF8jSENOMPKL2xmBFYzqbAXXVUhkHqOGTj/OEuQ+SXAuCIktX7lRC79IfHOxYIhrYnLd
 rMMefv036sYNsVNfgVawGHqVaY8jfJJRPdJ4Z8/8VHzVjyVRiE6A7K3hrcQGqndZBs/z
 fKFCBT4vnc7MyUbzHTK4+Uu0feeq9zdMdBiSPkPRR8H8mYk7XhkEQAwTmtT578XFDDf7
 8L4QlN5s0sAARb2DAlJXdD9IY0PPSLQ6QE2u2pSwv1SfejtCAqXOrHkzYEPnKKv55ZIn
 Y61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851463; x=1789456263;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q2zFzzLUBztHpAlThCWGXoxQohXTYyYKFSjILxdt7DI=;
 b=C0zkW3QO1qrli45P4dCUe/OoFWuNvIUzDnT7hzn6QekeuTSSkQZzQiCPuvXy4QLv2B
 Lh6cUy7hhhrpasqurWABDxShUxEVN48L4ZzEqydHd/Uqdukjw8NimCZbos/L0v84Yru5
 SxSzx/NNUyLO0gwqwQO0xFnTEkI1wyqqbFYg5+YlKbYQEaf87NRoOMZMdwsOC+Pyql9k
 e5w7uAGwDRPWwFsrkBhZ5rZKZ4al/Z1lww8C0IMmY+QQUugHkoS+Uris56QEpIHnRlui
 IlXCOFfngFwElnOH2r99suHfhhMq+p/Wvk83eGpxTXN9QCWVVwgHKCvcauVzelP0Vup0
 eiAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQcXeBEHloHE8eP0hEQH4HOifNNcMUQhjo3coV1Ck75/3nDx7L7ZHhP64JajlDn0/jE/uZTBDKXYc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k16kZ/qzOqUZ47fabEV5WZulFSBpg3hsOepWSw2HTMtT2FytTh
 UYMfCXw8Hn9huBXCnFgnC0QD8BuK+lLeVF1asJt4rtcPz7ubTBbggdc1GH6CdMIAhmgKbsraCF5
 BNsZeIiZZrz8enpFR2hqKVX1IXDmsOI97Kl6ISD+d7zq/rznoIVoqI60L3bbDSxX2YlyYAmY=
X-Gm-Gg: AYBFou17xTMSXgMjUzysQTiHmU6fXxJQHh5pNh9IpF2JJ2EGkmwx9+ZjP7LkjtjX5he
 JBtfQ95uuRE1r4Ox1Y15D45KpifQsU5/YI0CXmCnRDyENLyfQ+T7Q4Lz+mpVS5ci0FR0nUrKKju
 cEQGukS5eB4enuxbwe+dyGy1TI9Ya0BFaCUpTkBbb/9P78qj6nMsPEJSspKl52OIKTPeFJJK+1V
 MQaNbPz4Y4GydtF5lOwiOI5fFyZ+tC4v9tYbMuWzTufwhEKsverVWmt8mOxU17QrOXaY7yyNlgt
 a79x3pIR8yd7d6EXUvwIjujf5E9hSAHSzOSFcSeLVfLzNLi7wYrK/RvHV/6FAaAa3j3MBum3j3Q
 KjpOXo5g050E3dyCpc2S7uTY=
X-Received: by 2002:a05:620a:3941:b0:939:c0b3:6d8e with SMTP id
 af79cd13be357-939c0b37c88mr163059785a.30.1788851463492; 
 Tue, 08 Sep 2026 00:11:03 -0700 (PDT)
X-Received: by 2002:a05:620a:3941:b0:939:c0b3:6d8e with SMTP id
 af79cd13be357-939c0b37c88mr163053785a.30.1788851463045; 
 Tue, 08 Sep 2026 00:11:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm453173805e9.1.2026.09.08.00.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 00:11:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 09:10:43 +0200
Subject: [PATCH v3 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio cleanup
 order in post_disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-3-dcf8956878ca@oss.qualcomm.com>
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
 devicetree@vger.kernel.org, stable@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NIsM6HvCeVJ35nWFFLJNWwCPf0RLm8el3fb5T4Hse0k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqn7T5bK0YomfryI+UZIU9Qa8Ma7aQK72X//AJY
 Ac8FAPhtiCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap+0+QAKCRDBN2bmhouD
 11jbD/oC1+H811NF0TnKCwrr0Pqpxtgsk21hz36/GUYUtCUHvz7fDXG8dmh7218pz2qYSqvoC88
 Fs0i81yoVdKcsd0TNM6v5wPYMk7ec2+scAC7KgIrxiupAFdnOpTHSLaGrg4HdnkHEZSKAkk8uoI
 XptY651pioNBvNz4rmjACNZU2Np44zer8aWXSlGtz5vde/AuYtqDAkHL//3d5Ql3NVjfzWm1rUH
 YIVqzbexMaV/wvamlkAtxr7J+2/el42mgj4PTMLMObB4peGbMpecUXzOtXtadDO8Y/AXMiwiSVX
 Y8nIO/GTvvtkIwc0MJseXE46JbLdt8gQngmADmIABFpJ4JRoa8zZJm+G/1gRVXxauruqgfmyTZh
 gj50iQGe+1Fvl+2vQ6KZ6L9fzJLmoCnrxRu9wAgDAcxeZWrjcW8FiUczqNBffcDrvymBAcjmSe7
 cMXARBgZdeiu36dNcnfIOXDRftZ41cDfZtsgl/UTGDhq7KHPIKytwwthb4GCepicVpY8Dfne6n+
 NoCD9oQCo02I2YO6Cqo6YEdIZIjhhC57rOmqcyuthO41K73DK7R0Oyk66aXdRuRLqSt89i45NUj
 2b9t/EAon0M/ik/1j4fqZBCedG1Y8BVikzqZCjMBLmzrXdGS6V+QegloQXByLPIDHn+P8CIAnxD
 4eAOjPmEhxoWy4g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: Y2IKutjA7J2Vk0oQkXD0IeUykEYN6xsc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX1mwS7rXokF/M
 Tf0IIMED2Tujx2PpmV3YbG8d7RCTITjzvD3JCVqNPm4+oLM0vEV72O8H3QBGy/3E5XeyOl+0ak9
 3j7G3O3XNhAg8PxeKTi9gnRIkQIMNes=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6a9fb508 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=agfB2vzvzBSRJA4gfngA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Y2IKutjA7J2Vk0oQkXD0IeUykEYN6xsc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX1fcEF7Tgni+4
 Ie2M3nAKeG5TuZJVbrlnzdTbG4Tmuns1H/LzMcEgrci0AN3vClh1x2OvArgBp6ULgl9k/nVJCIg
 6+Gw7aHAK6K/97fQdwxNUMqv8HLaqJyOr/O/87qHIRn/aXSHKzbntxmAPw9RUODMPNI21vDVYok
 Wm7r0kfvgTsjd435FG0XknipRNJQDo4N83XCoOpwDAp0AK9+66cTM2o0B7L9z365i69T92sh0at
 lkodafrhkV9tAyNQk22jTnQjHlf9hSuR/vXirWTrP7WJR7AQ8ULl614iOkGH5L4NXB2eGdu2Nim
 IiLVMxHjledjTvh3FE5Y83ZzVRGQVOKucdYpGltRRPebb89FhKJJXJzFMOxfJd5XYn5dqRhtRfp
 XSLjfmz63QMx7mZBEaTeIF3cHjrWc+v2UMRXnx9sM/n0ClQQHrClhQZGi1p+eDAnK7zBKhjywbo
 QhlYzRygzTN0v2wfoeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080072
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

Turning off the power in msm_hdmi_bridge_atomic_post_disable() should
follow reverse order of powering up, not only because it is logical, but
also because msm_hdmi_audio_update() accesses registers thus block
should still be powered on.

Depending on specific timing, existing code could have accesses to MMIO
of powered off block.

Cc: <stable@vger.kernel.org>
Fixes: c0c0d9eeeb8d ("drm/msm: hdmi audio support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index db85400e574e..1860605850c9 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -339,10 +339,10 @@ static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	msm_hdmi_phy_powerdown(phy);
 
 	if (hdmi->power_on) {
-		power_off(bridge);
 		hdmi->power_on = false;
 		if (hdmi->connector->display_info.is_hdmi)
 			msm_hdmi_audio_update(hdmi);
+		power_off(bridge);
 		msm_hdmi_phy_resource_disable(phy);
 	}
 	mutex_unlock(&hdmi->state_mutex);

-- 
2.53.0

