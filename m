Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E7606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QjgWI7YI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kk4NILH8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF14110F183;
	Mon, 16 Nov 2026 13:17:44 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF57610F172
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC12HK1482979
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UjqYFlsGYQ1BQRZcmH5d7N4ve510rUSjekhHGgLagxw=; b=QjgWI7YIpdtgeP0n
 w5Tkt6XKngbzdR+lvg+gkpmH2poPymIDAu/Nxg6f259SLON41kBrIbBRLpC6pqtB
 DkGBx0jdXV7lMP76y2/MF/I/K4HfuhQdzfNGgixDcOV6lSQUX/SniloQgerVi9OR
 OIOqXpzuLI0xKHxyovsPT4Xo6SyzCF2GEQZxm0LfV7+iSs7iBdyc5qsaoB8Ufje7
 cNULvOMVcUPquoVRD0zft+01AhTCpM6Q1M2wf1/k7oLwWEP3F+nk2DG2k5kYPWq9
 C4RSiHSZyZLWaAKY4JQU8S+l3h2IxxtTb+ZVIyjPaX5GPHW+bthV/YCJIsk4Gdw+
 myH4YQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqgnjc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f6f4fe531so610583985a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835047; x=1795439847;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UjqYFlsGYQ1BQRZcmH5d7N4ve510rUSjekhHGgLagxw=;
 b=kk4NILH8nsLRsw5JpUsSEaC8VuWZ8N+ZbezZgyJjY5zomTs5wbtSYZY1G1ylGhqzHC
 tR0xLmSEUSnkZvbIT3KnKd5XD3EOaXBDInkjcrQd38z/8lKDQ/dlXnXGgywnXGnOY17l
 4KB2mV/GB5C1PzECzT5PnR/xtfLjudDdD1wzAd/EognxTjbXMmmBJFxr+zCJr5Trh4tc
 E6k13DNnY8OnVACFf6B3KNfKGrZKXuqffvg4gaHDiOzq2euQF0vWEDBqfJyz5AF9jK2f
 phkUHCkKBQGBdOKgI9/jINN14c0UMhk6bzcZdiPMyxr0UIp5aXQaFs00jOffLqqsbUzG
 7u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835047; x=1795439847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UjqYFlsGYQ1BQRZcmH5d7N4ve510rUSjekhHGgLagxw=;
 b=VX4q5P1/GDOk722R/RQppz2iXSoovn23IoED6zJ7kFn8diASZGK3/j3/p5zJNzisXG
 AM6tlU28FMqeSihLILVAe2RYpulkzaL5UOkleYjj9KKEZSNmzMYwa9RIi0QuUS8hoMwQ
 MZy4ZptVIjGzR2vZePDmiXHhXF6putUhOiv2Ko24NGAu8M6Y60w/fyUV1+QLxbyLSlSu
 IQGLu63eLhAF5n+R+jhzX4TUqwl70DjOUmCic3o9bjb+6a12v8yDRZ0YXOEiVRRIKG1Y
 SUH0OsSeaEzH2BR6smrQnpweEhT0lH6F9vW5U2CPkMk1nUj/eGlChf3LTiFzLCKU44rm
 IEZQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGzNa9VHbX4odXCfsfJIA/eVsQG4fiR7KE5JDNzp24iYIBe0zEAToRsA+xQEvt4PPqqMChEsJu8NKY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9kYIW6D4oKMgnGK7HPTpDGVpQjxGCgMJjLi9txYiFldRC3v59w
 ZHsY42rTPalNdeESDQsW3T75TWeHHM/yCgIGo12Cm+hecBJzq5lsAFKIUOHBCbfa2pYq0mqB5YG
 JeRZPtDrItR3qA/YOXTk9bHuebCyByisl5evYBt7ZDn66jMnlc2IxrC0+gv0BFcvrTTJWOYc=
X-Gm-Gg: AYBFou2JftkT6Al6gr07J6IuB3spXrm7CrlBW+iMvj5AzpDoiTgpUYbuwvhFZ+AJII3
 bAZsg89cjdmmxjt0+8rRLvKBaae13wU/J708kpk2BrOMY8RD4PIxD/LKvFuehSEFAddwe2R6ZMM
 Hn3kZjve5YOUESmBI0K4M8a1RiLHbnU075GS+5tIZMfM6DS6on+44xIQFrdriul7Cv0vjWLLcnL
 e+PfB+ExqnFii9kv2RBphD9Gfg0+A6hsYgvqD9fCOK0IAdNhuOiGY7hNok6wo8uAw+cYF//Ta+F
 H3CLEkQS41CNLf+1RxiGhBnM2XlnTXT8+Aghz49ldZvzNrK0QNP+WznEMzQHZB/WlgDtLqo02+l
 ky2i0VZjECmY6bjy2clGwIe8weWv9m2x6uu+7Za3VfY4OaG6Znk5yQS0d4+QtQLP05Eoc5tVWwG
 aX
X-Received: by 2002:a05:620a:3915:b0:949:7572:e76f with SMTP id
 af79cd13be357-9497572eb07mr622419285a.46.1794835047019; 
 Mon, 16 Nov 2026 05:17:27 -0800 (PST)
X-Received: by 2002:a05:620a:3915:b0:949:7572:e76f with SMTP id
 af79cd13be357-9497572eb07mr622412185a.46.1794835046441; 
 Mon, 16 Nov 2026 05:17:26 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8e1c94sm843927285a.39.2026.11.16.05.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:17:26 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:46:41 +0530
Subject: [PATCH v3 02/11] dt-bindings: display: msm: dp-controller:
 Document Nord DisplayPort Controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-nord-drv-dt-v3-2-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
In-Reply-To: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835013; l=910;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=nRlWeo6qwZpE3h30qNK372PqbYIGf1MFndG0VIRsKqc=;
 b=i6ITwZfY21YuZyrTMvYWrpTI+9AHfbQ5K3aBNJlABaLA9eT/NNIL0fXWuALzmd8XnCtpQd0ZR
 F2hraEx6/IlBVnXX/+Dn0+ng9V4wOg1HwNGpnrt86PAM/eN7YQy/6/E
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afb0268 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=lCWEfuFUYIIHy-HYLagA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Y-_TnWYAuc7J2zHRjLkG85OIzodvZZcE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX2qkDn0KY7Y0X
 ImzCj1RsM8XFhA3g1Vu7+rHjezSqj+TYQuSHzOPymRDjFgME1NERz+fwAbw+LStLBZwvZ9eKj2m
 +MpGwAvCgJKLDfXNJudl6WXpnpXu3gEpWEbPMyiRwFuUqsHL/hV3f8Ivsy+VEFG75MAjhRqa5v7
 T2l7LLgdKHAK97zonu622Ioszy3g8mwTgrEmjXAe7/X5RCHDlv3azgnDnoTmPbQebz7rerKQEAB
 RVg0atULVgW3XTz3TG/D94ecpInHt4YKmdQGB9JJrb1Sd3QAArkCQEp/Z2YGBmxMoWVcF9GjXqP
 H7b7BteflogI1qEPs36/HgY+r2Cfd7Px8krKfYNN3kAoc598WX2KAHvRzvVoP5S60vNAmCd878P
 Xdee43mbQoNnHxqGY9kEdz9kl41ypMKXB04rdg3NXrNOrBVGagwv6o3tclESkCJDI2FS4v9dU6d
 qvJfcunLOSsKQw0RsCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX23KJ4JjyVr+k
 FTsZLaQT6wdXBJ1QqHkzaE1dB7TJOcF6IIDLROJEhlI+Wz1bv/M9A5tdi/zyS25P8YvWcS5zeU7
 yqyUQv2ifhUTREAYBRp6IXV/YHz+hzI=
X-Proofpoint-GUID: Y-_TnWYAuc7J2zHRjLkG85OIzodvZZcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160052
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Nord's DP controller is compatible with SA8775P in terms of register
layout and clocks. Add qcom,nord-dp to the sa8775p-dp fallback group.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 094a6383bb77..9be0288261e7 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -35,6 +35,7 @@ properties:
       - items:
           - enum:
               - qcom,qcs8300-dp
+              - qcom,nord-dp
           - const: qcom,sa8775p-dp
 
       - items:

-- 
2.34.1

