Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCE6C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94EC910ECB9;
	Fri, 11 Sep 2026 10:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QpcMViXt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PTqQ5lsQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C347A10F00C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7kfbP3366283
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vizWdKJGFAB1HJu6hwMtO5oQyxT7j0M+cp6kkFJFsqU=; b=QpcMViXtCHLe9wrc
 kDrACOjs2+E0IpvU20o4U4GUtWh9ZQv4PMkD3P1LO0sG1MW/n+FZhat0dqNFNw+G
 gFlE2g2zyPvb1deu/k4a6MG6GKnDkopWlfedJrKOvO2AWNmsnFZ54+Uiv4wH5/bl
 8fGXfMKhWxJKQEiItMfa8xZojy1/3Rb4AoFrRujmvW2Jmqow06K5ZYldVWJ4HLZo
 FfeBbD95EPVDlBQUw7vqX3wSaUes+A6bQvTcKXP6oWvairkRVEBMN/IyAduD/8++
 GIgQi9kYcwDfpa0vvG4lA4AfwN7eAves4zyRaU22IzN0gdVVHmmDc0WtFIP01kpZ
 yJegSA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm1k2bcgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53088a3939aso18585821cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789122603; x=1789727403;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vizWdKJGFAB1HJu6hwMtO5oQyxT7j0M+cp6kkFJFsqU=;
 b=PTqQ5lsQv1YbruEAfiPCKUxm23JXdb/rWzjdb+Jy9UBtouw61FTReHZcNtdKCWZMlC
 GHkNTlHsm0yUvUNXw5ku/RLywIXZQ8yMHIhUBFAfKHdXGjRY0FzHyD3GkUJ3EAHQTXb8
 1EI3BVnJxA8LDby69eta/srifmtOGNL4m2lxmkT72Un9YLTcG+8lUXjw/OZ4fmurTIa4
 Ly7xZ0leSy8TC9oMautNZP755o6UjSGav/tO4SDOsXF0O9WjavUY60kexZJKD3dOr8TD
 TXoZERfqbu+u3Got5jSXDurm5Gygd8iPrWL8kRNvTY6Xv74WjCA68GnzUh299JXqfaWu
 cyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789122603; x=1789727403;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vizWdKJGFAB1HJu6hwMtO5oQyxT7j0M+cp6kkFJFsqU=;
 b=Y9NBusEs4AiJtmhpk5mu0cpJT65W9dUE01SuYM3/7geg1q9CXdXNUCFDW2WUIWaWws
 a13XxhWp8rlMtVMvtirmOm49s+RgyzS4NBbJzA0yyylPWclxDZLWv2QSL7dHpTIP3/Zg
 qJAJWUwDRYv7dbm6Nx+de/Ox/fX1Zt7hlVNP7h/ucngfNwDKbFicg6qDMT1W6FUMN880
 SoZXPjJYrawIR9SJ8VvDf7cp3MdI8UKzSE976ib9JDfg5UT0geMqwCdfIBZl/RamK8S/
 NV320lJrIQ6RpoFwfwAOZk3CFC06gXp2gGC76PdurGpc/EJJZAdJRZgP1DZcKMmfNF/6
 BrZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBztjouajkWEAkhBm+e1HLhD+Ests4MUvgILc/iEDtSELDjS5br8vBTemgoYwyT9UITmXwiCPEU9um4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8h7VnQa2LHpHf1TJ3BEbl6eK7R2UuDA6rL2ZzP+3Xg4CFrfuN
 SGyJQks3/5/VnQT6dAfhJ/NeRvyNmu4/pSWVBMUjdYw5RBONLmuzV2JQHaMF5M3sQyaqoh4EGQB
 PxFBveUN7riK2bmFqVVogbE12KckZxb76J7+VdPDqW8bCnsQtLr3qvLi+rLihp+Y8/82zGlo=
X-Gm-Gg: AYBFou1k2JIdsAhdkd11CYm5PlYHOcfixbSjN8BtlB9/G/Ub01nt6vp6zj9PRgRLk11
 +nnedGUCUEyxLZSPSSgMNMCXeIyleqBCHHq4XY1RpH36yW5kYA07xKbutfz41EAYfG2pTj+ovkT
 cuhxEsEWf9CK0zn+8QwBe0jz+tbuHufs6cPnn/L5977LFABks3PyTOKVHDgrDjrrdgbHAawbYaw
 Ooxy1sjuIHjIsJDmF2XzabbNy/NPWmG8VHZszCGzJO9+oHHcAaeX1hveupk8kkJb4mWBGleU7vW
 Kjs/KXJAoBwhK4B07aibMUdYB471Ea1l9LxsHs2JdYHl7NYyusumpkhPpIDt32XNt0bk+KMu/LC
 VrXTzB/3+lc+i+TrIzzklSl0=
X-Received: by 2002:a05:622a:4184:b0:530:b2e1:2f3f with SMTP id
 d75a77b69052e-530c8775a20mr54661371cf.54.1789122603006; 
 Fri, 11 Sep 2026 03:30:03 -0700 (PDT)
X-Received: by 2002:a05:622a:4184:b0:530:b2e1:2f3f with SMTP id
 d75a77b69052e-530c8775a20mr54660751cf.54.1789122602244; 
 Fri, 11 Sep 2026 03:30:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:30:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:39 +0200
Subject: [PATCH v4 6/7] drm/msm/dsi: Fix indentation of if block in
 dsi_mgr_bridge_mode_valid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-6-87bdb9f1987f@oss.qualcomm.com>
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
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=859;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/YVh+L5neHC3SlylyZSkY52kedS/7Okrqq86t4o1xdw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gUEvxbxfeqW8YDt9/GLaS5x5T5jcZJa3s+8
 kkxvK6JiJWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYFAAKCRDBN2bmhouD
 12WpEACOzE9Xk7yADRzq2MiKw2PpOehQm/+4vq79EC+vwMlvAPXnG1cHwOpJjW4JG/MW7wcka9U
 ZIWaWV/x2hlkOWfBoSfGck+VdKhdu9ZHotftqhFQhA4TbtXAF+FAF51H/EXSOrXGJqncVGozcqI
 a0d2yls1JYtHMLKtrHyjkm4wfWUBEHOfTd1umg9NknYdN4AJdce5Wh1ZXEt6QE8ZCr+FSgY/yJc
 G+1LwWO86s4vHH79ekMlHSHoPh73u/826IVeoL66rnYXSaWCmE1/Kid7HX7yYofPACoXzdWsxMB
 E44pnSCuE7u04vdOkLLWlB5lA/yu70vHKoIGgr7sQ4CleVkk5ShUmTLOBm66kSOKGJZbpd4JRED
 D2VswGZIbyGDtDG42Ucz6pj7E0+r6b+FTwSw8840tqy/dTcMqGN9BqQ0oTxL86XT/GlfXFmGgnw
 Q5n5AnVZ7ZLVaCT33OS5A6ttBx89BC0KL+NrZDzOIdzaS5lAet+ZMg1B0MeBggIBB7Vk5xTfi7h
 pjs99o+Uh4q95rm2e/NC0dJ0RiyJYqv1oTY4SjbfOAuTspTR8Bgmf6m75jvgrd+TEmEchHNMTew
 +spZLfv36eHkYxcJbMibKGE09WVIHoeA6NN3FYmj+akkkeoAYbSynF6fd31mkuQ9PAzpjxcPS26
 E+Qt1a/qixu5ETA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=cM11IVeN c=1 sm=1 tr=0 ts=6aa3d82b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=mamL7KDpJlut8y4y1IgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 6gp27E_ZC6L-b1MwE-glgIs91fx2AZKc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfXym/oXukfIj+D
 GShw/04MokuJp5fr7wcWBFnUPOq0UYF0uCRVeZXcUpJyWYNM9l/8JOhm8lKzPMiL/eIV9aAT07A
 4rOC3ZcRyeGvCf3RTDjBHgDAPX2qunc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX5lBh/WQSPy0w
 0HSGNaXFdRFNum/Yzn3YGnDAQjUc75up6Njvqt53t92i6+eYKiKUCFR701mHYTbeEfbrqf2GX9b
 q24qZF19BfaX7ij5br/poGd6oh/NuYcBP9mMoeWMSpu+sOJPlRXSFZ7gLcoB/UmZW5u2t6RBmZv
 LkcU+YkFHPGYgVLv7s1NKZ+gbCWGGhPfolPEHPEuB2qIxwuzinRpDjHccSbE1/2rh7p/vRDSNkX
 PTc83wCqxepuQTj5NaaqW90NTkRHNNx3nD2ehr5jCFoAYmzUihegc3u2T4JdLm/dp7Rdv2aLhcD
 o8wFQIYlMWmaE+a33L0vwQ3ugYuoiXFqB2mVD2Zf4NoTddPsIg5siYamWS/s/hhN43h+DEPFjkk
 JR7kmWKJHc9nRnPBDASIETuxQfCBJwUkwp/2lLcrrII8+Qn6aduFjoVHuS1t+HgQYNnQGNQlmVa
 KnwZVE8YCpKcznSHfWw==
X-Proofpoint-ORIG-GUID: 6gp27E_ZC6L-b1MwE-glgIs91fx2AZKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
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

Correct confusing indentation within else {} block in
dsi_mgr_bridge_mode_valid().

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 959daa88b1d0..531d4ff78f56 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -429,7 +429,7 @@ static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
 		if (dev_pm_opp_get_opp_count(&pdev->dev) != 0)
 			return MODE_CLOCK_RANGE;
 	} else {
-			return MODE_ERROR;
+		return MODE_ERROR;
 	}
 
 	return msm_dsi_host_check_dsc(host, mode);

-- 
2.53.0

