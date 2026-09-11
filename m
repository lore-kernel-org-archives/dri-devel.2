Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDABC88E4A
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A59A310E9C3;
	Fri, 11 Sep 2026 10:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I/DZKTDj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ghiG8VDX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99FF910E9C3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:50 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B9mZ1V3292338
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=; b=I/DZKTDjmhSTvIGb
 QsmmmXilwWEUyUu6wBHwE/SOfshnkJ36+XtfmYcYVHn7UgJvhotzwLZD5ECiKj2l
 58m+EmCH06BJoRrdoKkfxH3p5CkpPu+t1sunbS5YbsWbskh9tr/q53JXe60+jHDo
 YsObcHE8lhTniLTbYWm5493BlwYvXVvtwHgq2WLq+7s8rdIbvFPhI6Q+HAzDPADh
 UL1FvarMYGQLUdU8hAtZHZ7Y0AspUrRsr1ygS/zBArOaIJDFZ7mynW2x7fGwLd4P
 JlZXfMyPfJohbxq++WQ70Z9j6fzELh5TOCCbIen/N/0ZyFgeljEbrFM12o2PopGk
 X244Nw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmfbbg509-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9382f9430deso132881085a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789122589; x=1789727389;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=;
 b=ghiG8VDXNEFIOfei6SvQpOo4N3pL/SDzyhQWSkUoqF6MWwnoLxDgje/KNUCIIDR+Dc
 xql+e9C739sErrTRVRicyj7vGydC71P/2iDLoQavO49vrCdRvDeeOcsPVzXgNKhr3X9R
 6DV2G6BgJOS9vgo+iYILIl5Mzg6XzTnr/saynDskUE73FI1AAd3T0iN02DaXSZKyd2qK
 Q+8JwQmJzKUVwXBOVBGSkxcRsiG6lr00Y8N+rkOQh3hxdzA4B88as7L2RrM75IG0wRAg
 IN0teGMdb7WlhbHweUXjWuqZS+Eu/4m+o95J21TPky76P30EUfGkJ5QBkeMpvuZh0WH0
 k95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789122589; x=1789727389;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=;
 b=De2DOlGxfVwzI63kp7ppdPp4yvZBR1vuWNAvuefPaSvAc9AURHnWRWsdUavUAjYNV1
 vrjkTyoTUYuIXtIxku5VlYSdXqAgE+VuCjzeExHMinNzW2UT3m1Y/dYSX67rrmzbhCie
 0iFLr410i8ONBa0Ibnlashz28juTgefW4nQ1TUW/NbTI4fWxFw49scNtWrGiG/zc/pq2
 nUsR/gc+NCpJTAzaAscu9wSa28hud9ERsFIFVmQfOHt3quGzlZ7sqj8aov2kc2XlpEE6
 XwfVm32koHWimul5KE4Kud/KmXog7XbGoxUCfasaEa/EOsj41086hg1tefb0u5g9wH8E
 wLgg==
X-Forwarded-Encrypted: i=1;
 AKwUvByG3H1leE2wwxtsLWMXYC87HbLbQK3hsUzraMezEWWlo31c19zFrGpw6zuEvRSwJ8uDPpLqm6CL3do=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nGU/WGPGPhrwXfqm93rIXSA1EcIJtcr9bLbQrQYFoVkvACFa0d
 vxUvVsOIO5KJBztKum0o4CRZjlsMo4qfQyoeIsVvozJA6EnB/utcFDtDOyG3D2KEAOVqWfSGQVr
 PCtcCazebi65zDrL0Khhy0jou5mbOqNo31XWg21EbKLsf15vpnslowrFyCVYACOrwphGmQbCNvN
 TzV/o=
X-Gm-Gg: AYBFou3JBsdg45WFq5Kbf7+6zYjfE5u+mFJvgaPDYWaL8QRy/WvG7+l29K9dTNwmoIJ
 +AMDyQ/jLnvyBH4zbA1muDu6mv6MX41cY6Tl5Eje2OHaRMIy/VIweFVwHW40qQ9w0ewH1HLsQJQ
 BqKo9RSvFgNCqjRQThkPKQDJ+wt/aG812DHeejCCAh06HI57Np7dNbLPTtt4ONvs3EjXEfyXj1X
 6ixG6e824ICpt1TCI70xWSKANoGJk9PbxLXto+ciL4dqoqcHKwsH59OA2wnHg82rkPqjnsVOeAv
 DGolHYv1N7NKOWyyqT7BgqX4AK7fmkSvHsK7kS8cZYsjhYbuGIdbzg3Dnc3K6TOlWtjbyT5w4w7
 XmkTeRQL7+6QDIFyB7fn394Q=
X-Received: by 2002:a05:620a:2a05:b0:939:72ae:e536 with SMTP id
 af79cd13be357-939ea08d7f4mr427004085a.13.1789122588919; 
 Fri, 11 Sep 2026 03:29:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2a05:b0:939:72ae:e536 with SMTP id
 af79cd13be357-939ea08d7f4mr427000585a.13.1789122588563; 
 Fri, 11 Sep 2026 03:29:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:29:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:34 +0200
Subject: [PATCH v4 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZG093MO2ef10q/LWPvFaNq71LX74/rGkq31nYz5GUvY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gQpFoZjDhMzPsUy+LdmdzrFOl71cZhEMXi1
 mgUxSmEFceJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYEAAKCRDBN2bmhouD
 15LsD/4/L0NDXHF/U4+guLhfAlcFLxQHsCCkbhDa9SOS7C/sitVrIcbNTbKbx2SaBDKTzOIw2Vt
 7fBhdDez23YI8P6u/LyNQl5OOzReoKr4QHgoiJznFhA7kDD5g7uivqKOQk5gLtoUzdC2v4LhDvN
 bc0kf+BHkLPNrtZjXxnHrbai3byrm3eG0S2uSximL2J2iBxbw20Yq/Al/jaFyzp/RoTBBfqcpRp
 G2lRAzNdW6oTkplvqMfsArEIpSBhxhUefh9HTMwcQ6GXzuMpJTZt2xhF9lzWMIevTQ89wn/p/px
 lOGDeaCXHXkVVdyoGglrP1wZFoiPDRfXqtP84gsD97V1+InM8iel/9wAyhFzq+DoSxs4YoagUbE
 UVKdtRU8cyWu94bEJVIUq+PqsIm/j2xtl68qOyLls03WVMFf7fhz3yx9kxzytJJGymPrb6p3w+z
 qkgL4q007YVdg9DnaEjPnogP59GM6b8ftIaUTEDU2lb9rhv447d2EyqHriIqarFmqWJOPqbjikr
 Sc2Ich4Mekhl6pe0ih/foIR/m5gAB/D5s4W+gFOe2wRxaEso3MyWe+Nglgdgg4zcNX1g1v3JRsN
 PHpj53uzFB3laL/R+BBF8EtRVZANl365wFnxP31ti6FZhX8VMSzrLPLxhD6R7eMzuIbQJJYKx+T
 yaZAFMi7MQwvBZw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 9yjqQ0rwK2PDIn7GGwmC6SmP5cQzLGcW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfXwz/RPyki1EaH
 GT1LqSh6QFwl0xoBtkBXyUVqHpcM3q85TuBDFq1Q2BGWNc+HZR8m9ZMBlRaHNNir8NBl/XwD75Q
 6nV9/XZ/e15rhhBTT4JhZieMXkHULU4eyUWmA2ggqod2sc3hmhKEznrc4mHWK6Bf/RU4eoAEI5j
 uC/5u0wSgbDxrdWyxXRDOWekKA4q+6cm2dnMH+BbeO4t+xzY4Rngep4GKJoeTY9WUbqpl2d9a9/
 Lmpn1F3x1CzjhZB7xioL7kgdMqykKIbAls5+Q7SJwHe0svxyugbYSerqH8xR5gArqUQU7comObA
 KCRv7KBJhYr81rlYyjQUpgDI4EAUuTadD34+7waDt+jYvSAwEbqRzf6BfV5UVg0j5bjlD6B3VpE
 XLaSpblY7mbBXmEn946A7kKPFrfqjypw+FcKNEQTUVZfeWrpkBe+MvB2scQMkDpfMW4E0cO+AoG
 lo2z288pnTi7AxPJQKQ==
X-Authority-Analysis: v=2.4 cv=X6jHu2Te c=1 sm=1 tr=0 ts=6aa3d81e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bp1g5Iz1D7c7guLF1_8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX1RbOcGLVbDWU
 XPqPuYEjGVs+W7dxr6a9lF5VZToM8KJKqvg74pqYpRXS69tbJwvMIUWr65qZxa6tUUXPK0Wf6Wj
 QnFhF8aTV0U/Vkxhe/dcl2iu559oc0Y=
X-Proofpoint-ORIG-GUID: 9yjqQ0rwK2PDIn7GGwmC6SmP5cQzLGcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
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

If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
it should reverse the state of things already changed.
msm_hdmi_phy_resource_enable() is used also in probe path, thus such
failure, which could be simple deferred probe, would leave these
resources permanently enabled for the rest of the runtime.

Cc: <stable@vger.kernel.org>
Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index eb1088755cb3..15e37596bdb1 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -67,16 +67,28 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
 	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
-		return ret;
+		goto err_pm_put;
 	}
 
 	for (i = 0; i < cfg->num_clks; i++) {
 		ret = clk_prepare_enable(phy->clks[i]);
-		if (ret)
+		if (ret) {
 			DRM_DEV_ERROR(dev, "failed to enable clock: %s (%d)\n",
 				cfg->clk_names[i], ret);
+			goto err_clk_unprepare;
+		}
 	}
 
+	return 0;
+
+err_clk_unprepare:
+	for (; i > 0; i--)
+		clk_disable_unprepare(phy->clks[i - 1]);
+	regulator_bulk_disable(cfg->num_regs, phy->regs);
+
+err_pm_put:
+	pm_runtime_put_sync(dev);
+
 	return ret;
 }
 

-- 
2.53.0

