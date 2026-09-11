Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449C4C88E4A
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0EA110ECB2;
	Fri, 11 Sep 2026 10:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CSMZJ8lR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KlihcS1l";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D750610ECB9
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7kb412831841
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FSrRHRs+USEOkCNabKEpUzOvaX+AzMaMbvbk8haZkZI=; b=CSMZJ8lRNYF1d4T7
 b4DjaqBMCmjhAQ37Z4kw9QixzrdDa0KAJ55mssNCmxs7JVhCr9WRHeNvQWGfFQMP
 RXyip6GlhwYIMbE46SvRI7QQoH5VABVivDtq6zNnP4wBVmQKRfyYC9XhiwSGk+QB
 v1p+Q42/u9baFXLSz08tA7zW7ebs3UQaNCKY91HEQMcuqePCEighyX7Qg+zf/DHM
 vqVyImfaOcqbrSoQhuHQNEZwIJIf09Rdj68WdnRTicrbthUNrD7sbddEsvrJviId
 yOPKSIOS03GVGPOV0rIWl5ydPSf+I7wNVe0GidunuC2nn0O8i7h4cJMhRt27+9q4
 cwDw7Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmcgfgws8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939f3426a7cso52582985a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789122595; x=1789727395;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FSrRHRs+USEOkCNabKEpUzOvaX+AzMaMbvbk8haZkZI=;
 b=KlihcS1lJ9lKnHGlR0wu8YjMXoKLT9/ooHGK4hlBfrQj13ZEFDiTEEK6bCKNu0T1fu
 CvZNta4lkQreXlKRZ0ds2uubBxcCxHNpVuol2m2F780fPTG7LCCQSMkplzczYUPRiCAg
 1uWiPZqXaY/xElfxA/8cxGhvatbM528kdD3YiaGCu9yo2krTlWpMzmhu1porkt63Mlf+
 XXFo0jPrHRttQNz+9SV3NL93HTUyXPHNdA0hFLV16ZLHvyrQ8xGQb0MCflTdHkGirCbb
 UDPM2+uyLsoGgvWm/WDvgj+9uMHXp0Lm3zciircMBBg5RVQAgFky4R4RvFKCsa8AfghG
 jdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789122595; x=1789727395;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FSrRHRs+USEOkCNabKEpUzOvaX+AzMaMbvbk8haZkZI=;
 b=B6I4jnlKv7RVa3u3nxczhQdNMPrhWGpIZi9k0t69Y/Wnw+CfR8uvCxcjQdAbeiXTiZ
 2nwdzsrc/kY6GMJL+WXueLpcA4FmX2uTOSopQdAGjjQbcrRLPdvROyZ86RtZXvh1u7Le
 bRTRD9//i44pU1lP3Owear4OyqFOIUHwbULCFvHKFpzUA7NICtI1VvejG7mMyhBDoTcr
 g+zBV6aqAk+snV+WkCLGymVMKKNN+2OAoOy6wynkjSeiGkussyqeuH9tyRqCLbNUagDt
 +JQdws0hHEDzp1qZYdTo5IAIjkelo0zNyYtdRrNWLiZ9uAEVFpDrZi4khrS3yd3CSbBo
 xduQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqf6GJGljQeZW5qrwy7I942J0KRtbsUR38nxhSIaOLAzau8EErfgJhPqpw/D+oW9nNE+Vj7fwL4TU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kmzbbpxQzoswlrEaL2FEdzPn4+Iz+T0zywva2daYuscjMVUHvH
 YrLXMKLtqJsySLnR9+TQKgzamlvG2/COLzLz5jPJ6hNUBnjy8OM/fUC8iGrb/eWX7NGo6aNj4AR
 vd4Nl1hS8/JqjvW7/cKKuxRhhn8Y2veoYsnD2UKgvnOfbPkR2tbxPVqurxf0wPMpW302GiOo=
X-Gm-Gg: AYBFou0frICmJmsL0g9SNintfcbPcx/y6TYHh5t1+UOXfBpA37wJ8+pPNKkrcDwOlqn
 hZ5n/yC+J2wVzMpY3dxRhBCJwPc/Xn5JnciJ2IKev3J1P6j3tGsoYu+voYhfNc/E8yuVdsrqcYB
 AGvmokJ2/MK+WSAqlZss8IDHC1g3GThpJrXyHBNel5xeEhP2bdGBiv1jjvX9M14makycXATFHQa
 tdlCPajm9EN/oV4jaBF4QMBkFTnnNDfF2Zq/5h1WQv5AtKEWk/AUF6rvWehBOZpTb+jC25OhgLV
 GofX83nMDeEkOCMgq4WvJZgST4oNUm2/4gNE9lkkLLfzUN1vsK8mcaIXuTiw1ikv0APZpKcYfXz
 txUaFgXapD2rqQ4x9FKrsAvQ=
X-Received: by 2002:a05:620a:43a9:b0:936:623e:2603 with SMTP id
 af79cd13be357-939ea06ff04mr392336085a.17.1789122595399; 
 Fri, 11 Sep 2026 03:29:55 -0700 (PDT)
X-Received: by 2002:a05:620a:43a9:b0:936:623e:2603 with SMTP id
 af79cd13be357-939ea06ff04mr392331985a.17.1789122594922; 
 Fri, 11 Sep 2026 03:29:54 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:29:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:36 +0200
Subject: [PATCH v4 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio cleanup
 order in post_disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-3-87bdb9f1987f@oss.qualcomm.com>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=XH66GnTgugpnLWEqmx30iK26F7dqgoZ1zE1rBdQ5ZS8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gSmcfSFcKQbToEryQ/sbRBEp0E85MoJSCa4
 eGEScNxwYqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYEgAKCRDBN2bmhouD
 1+/fEACYbLTLMYCCYNYY614e8AJPNlr2hZiZ+bCfgxFKdd4RaDfhX3BZU4AyRXmWsUbgLyMc199
 YEZu93YLjrjLP+s2RRQetCGPScFAsNe5liReqEQMD5wQB9Y/S7AkXJ5NSXskXwpwJWUoPV8eJ1t
 EXrvUmEoUr6GlfLVLyqxr7VuueWQX5p3wE2TXNbTzSCrPf6slIkNquInZlIa/Ei5xDKY6Ok8GiP
 uhsSUBD+7DkLwjU2uolYhzVnHg/0DCK+dQ+yhZAldBd49oSkk4e7GNl+OrOadDo6jTGZYlr0Drb
 gbBRxb6f8RxFYN3t4xxz6P+Hn4mIrzZy2xEoSaLiHtLAQRFbwCgdQzNd4uSsmyi8vFdstIgdYB4
 WIvryUZPl7VyvvnzIhu2EOCyQpM5ZVZt7kF3D69V3emkTnZN31XcMOu7XAbUuAYTVxNQmdMTFcw
 +uvxffFBiZ+3d5hTfIPxB8RzNz3B0FQ7a7ZQLOr7Y6iPzRDVV8sAcJQH2q5tWPmU/p2lCwwitj9
 UZQnZujaPPMiJe9XRh9l88XeD8GYqWa+HMAaIaFd88gaHJEGvaGJ4r5Cb8Y9oauHlHOoylYrhpA
 pavfPZH1l157iRjmQ3O25w7B3niQcMBrR4/Ras1j4zfmebz2jN1GmSTfQTuQ/oVwP5v9ZFTqbz7
 agmupQwlLYWueAA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfXxA0EtZAypxZy
 FeJfo95iD8H5QcoQLfvkKWHIncIDDoOjBqzHqY1mpda8quNURlD281iU6stSWZ+DwwLkG/bHMI9
 MDiM3vfyY+NLImNq2flR0hnQN5TvQRGGrN/JYedxzM8KXYv0yvXc35yuhjLRzGnIgIIH3UevYAV
 hRdNMUj9gRluxBeYP2Bxa9oSeH3I6VtQ5AvIUjxR87O5ElbjBa9+Us2PtmhvcUIx7Z7IuWjZ/dT
 TndyX74iTmaq8KN0cdUB60JONKQeaRbXZg6LvfDc5a6g+KGdGJnQEvIOE+iedg/QL9vo1sT1VVt
 IaIZw3oFu2YKlxqMvrJdA2iivUq5AFTyjgDATJiOstnV9Us7YleISthcM51TIlwotJcgef/9z4p
 bk49phCseY3CAcve0aLV/ZqOq1RWR5cIB77HG7bz9kfESpisg62ek55mkKUyWlNIYdv1P51DRpF
 h88lFlrb14m7lditWJw==
X-Proofpoint-GUID: xE_4ycX5bXkZRPYbIramhRKiXBYEeW0o
X-Proofpoint-ORIG-GUID: xE_4ycX5bXkZRPYbIramhRKiXBYEeW0o
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX//FysXjmDydB
 zw0w7Qd6ZNKKIjFOBlFNJ1ebdJ6Vac8JFiGQRGXttPYqevs2pX0PrrNg3/Y4wfLPWqDUfwG8qJh
 aLG9M4MVb6s8QaV5WFU0vrrT3YhE6gU=
X-Authority-Analysis: v=2.4 cv=ULtIjyfy c=1 sm=1 tr=0 ts=6aa3d823 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=agfB2vzvzBSRJA4gfngA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110146
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

Cc: stable@vger.kernel.org
Fixes: c0c0d9eeeb8d ("drm/msm: hdmi audio support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

