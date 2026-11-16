Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A3606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=csSPYgpv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SDhGZjN5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C98C610F18D;
	Mon, 16 Nov 2026 13:18:00 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9947710F172
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0qI02212753
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m1nTZ+XmUM2edjkyIuwrtLsiCwHaExrIO3F3ymxsXr4=; b=csSPYgpv+XU+65Vi
 3IwiCvKaI4srMZSOpGLCdepiYGV24awTPbgW8urs9f96NvoL8wnL6bSO1Z+b3yev
 1vWzgxnu2B9usVFO7sguTQnWHV7xkwiUYzwPFHy3MZLc2a3Uu7SKJn45zfNqJyaP
 wKAmAnuTTbLpRFs4aMviuUpdZ+AG38+6EHPBP2y9PmICIZsZhsu6GzowcUUvmH/g
 3oMMrLeslKeULrqxLoAfNYbzf5qrgh/cIyG7p2uizVLnqMplCkalN4/q3TJD3MBV
 vkDkMLC26E5xLVw7cObJz+hqTdMkz5FA17UCZHegzO8G22/bzOXgpiy1eMFZ/xvF
 pyhL2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfgf01-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso694426285a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835068; x=1795439868;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m1nTZ+XmUM2edjkyIuwrtLsiCwHaExrIO3F3ymxsXr4=;
 b=SDhGZjN509DGSZUn5OF3n90f8sjjPeh6re+GzHkqHlrqgQLqLcRAvLHKJfcBM04wsQ
 ASvhXvWHpH9a2VbEiTZP6xlQNOfR3NubaymeojOU43Av0rwvKK26U0h3xbyg8lOcrtId
 +wEIm4WL9HbN58XnV+48mA8E5JNPymzYnxv9WVYiouyslQ/bXpsFuEmpYBG8J8O8fph0
 Ftx5He8AeVqhKJw4y6uLEhA+AOj+XEtZnrPcMQjY2ldcJeshBnigDK9x+hkz/5piIkPB
 mRduqfJf6PGHcZGRM3owQfl6Ovi9Ao4e5Ij4Aw5uqmbMMEwl+TVpmA1DuuhE6elTSMDz
 ZDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835068; x=1795439868;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m1nTZ+XmUM2edjkyIuwrtLsiCwHaExrIO3F3ymxsXr4=;
 b=pITx6lc2obkU2sx8h1NpSU0TNCagL4yjMSEXSy7SF6QM9957Q/lqcOH2kz4yr+awtj
 7dx8UFAYO7lR9+ihw13M1ZvtjFNp327im7iq3ZnySFseC0j8JBxzAx8i23vlq6+ZtZRh
 MRFR90x/w3YVOR/JzwIYsq6Xbsn/rdxiwLaiIrRz8JhVZAQ5s6cQUK6dbysclwzkReMp
 0QlT7mRYxEbQ+aGDxb0+yBDL/s7Ra3e83RcvAwJaTcB0xafWlWQwMc93YPpKkZPnjKfE
 CkAGMxeM/fG24yEqF7cNGZvqDs4W23sYF7pKNV5jkr5noWmKkTGOTHR68G1voCPDBsK7
 fS1A==
X-Forwarded-Encrypted: i=1;
 AL+hErE7O81n4UXLHpFVdYCMhbR1ErHQc7lMn7JvCYB4FDU1G+wPrlBGgBOkrjR638k+/h8dRQokWzItR84=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9dnX3OORVE/8hybma9QeCF2UCe8rdgsoMXPd2iJ9Drc4sBledu
 PB8gnYOV5Y0nnWlq8i7pPBosJtI5vHtTvW8+rMvlFOXlPQmtotacZuHpxIWr1cN+3IKOIGNU8JR
 n/9uRTPe44TMa4jOlhNGsWOavI7CYF/To0iBuL4zZwe3VyaOnfQOTOpz5jh3inoW5GqJUc1k=
X-Gm-Gg: AYBFou2a9QSzVHVsUg2LJAmn2K4fgRC+QjMPTf3p0iWWgaElRkD58xTIUZMfn7acKro
 ooizCtqxJtu/yTnEapXqJhDm+drEk/vwl+r1G4Ukf+7KL5441amlKlUzvgsNlw6ZYI+vl0jGvMV
 Ng3lBGZxrfwemajLu9SiiaNmf+NeUoyjuI1fJoC80wOR3hCGh/Z4C18DiME0Ujf2zn6qMr8gIuQ
 BU9L9Q/uMTn4sxMzx/h885cGGpd5j2UdR6LoTsbt1YhOax/WSEWXKtdyukeX5Ae3pKG4wAXJ3In
 /gSxeAPFosgzG2EYTVHVhdFDYh5zdJBKK546tbHen3D+mhJwhu/y7TtjFqSnpSXBNxoWkU57/vn
 Uvt3/ebTDlS6rCwiDaf2LLDrlyqKyR/vVZLHyicnEOG/lh0zmZHhHo07TPjIp689SPjTEWKXhGV
 gR
X-Received: by 2002:a05:620a:4448:b0:93e:c12c:43f9 with SMTP id
 af79cd13be357-9494bc91605mr1621096485a.70.1794835067742; 
 Mon, 16 Nov 2026 05:17:47 -0800 (PST)
X-Received: by 2002:a05:620a:4448:b0:93e:c12c:43f9 with SMTP id
 af79cd13be357-9494bc91605mr1621088985a.70.1794835067193; 
 Mon, 16 Nov 2026 05:17:47 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8e1c94sm843927285a.39.2026.11.16.05.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:17:46 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:46:43 +0530
Subject: [PATCH v3 04/11] dt-bindings: display/msm: qcom,sm8650-dpu: Add
 Qualcomm Nord Soc
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-nord-drv-dt-v3-4-e3d3bf0e2c49@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835013; l=969;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=3jZf2Pti83jqOcW2mSkjBOHEd4vR1NpTAkKkAceccnE=;
 b=JjgDh559AufDCmhLwnJspcdf6rZkZsuIPjkvbejQcaG64aoXPfcwej5CPmjCOrjOYXoKXwFkP
 LswwhwR6HLsDF60zELZb+9MpHsV5oGl+iM1+LaX96Y33/amGM4Ei+JS
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afb027c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=lCWEfuFUYIIHy-HYLagA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfXy5iBYxXbY6Mn
 4WOHDn10JN/86zA/BOeItT/jYep4ut1/chwSpMGbwUaP/vNNr63Yf/8acwSRjtFxOEbGlnAqC0T
 mDzM3VQUUItlO0HF0WjV5TPYS5nvTG4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX64CDY31Gp1zX
 J8ck5Vx4hA27Zi/a9inL52ZbxK1crQailKVPbcxSqrqMw1GjesmN/Hk5e6nj+INdyquJ8bINCy6
 qqrW0sLJjp1Z9X7MlL+DNuBFE63qXU2wfE4YTTVS4KWlwCcdxJfbzZuMILNp2JqqmhYf74kQm8f
 B4ZH+nDGe31aPkU+AVu7xLW7s6VrDOMr6UltJ3EXuf3a2C6ZlQD09e9WI1eIPA+vvIBF9BLh0Gu
 I+rH4b2Htu09wG6CkOFMgdEi0vKzcNdkKQ+7q1DhB/YkH/uQ4L3yaYo4s/wHCGu3USfBxXhz/mk
 enQvtq6SbaGV/74FO3tiNSUuwpnyGczP41LmTBPzDlHKudB5VK6N2bm8AWqkvnZpVifHBb/cVjQ
 Lebc3MlsSDd+K2vzjf37QlJRUQ1IZ5g5WWYTJMF+5BX5C4EoAmx9W3hpmM/0duKBU5OTiY2LASs
 C9q5ISTca3p/QFNUMaw==
X-Proofpoint-ORIG-GUID: W7ODMkeC6wkYA_mA2ln_CmZjpYsxw64w
X-Proofpoint-GUID: W7ODMkeC6wkYA_mA2ln_CmZjpYsxw64w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
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

Add DPU (v12.1) for Qualcomm Nord SoC which has noticeable
differences against SM8750 (v12.0):
 - Added DSPP blocks
 - Added INTF6-INTF10 and removed INTF1,INTF2 and INF5
 - Added one more DP

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index aa0cf0ec5b93..430fa02d18a7 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -19,6 +19,7 @@ properties:
           - qcom,glymur-dpu
           - qcom,kaanapali-dpu
           - qcom,milos-dpu
+          - qcom,nord-dpu
           - qcom,sa8775p-dpu
           - qcom,sm8650-dpu
           - qcom,sm8750-dpu

-- 
2.34.1

