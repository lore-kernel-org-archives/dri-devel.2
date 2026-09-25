Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C078BC98325
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372A410E2A5;
	Fri, 25 Sep 2026 15:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oC07C3/h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fawYCPws";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417A810E2A5
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:53 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PDYhN51056551
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Re9X7fDOvky
 ZZ3WP/+UOZyExDqbDkyq0JV0CPbSwk4Q=; b=oC07C3/hiKVobgyyQIg7t959R6f
 YHcd6DGucgx6/9UpFntG6CVahsQTYbX9NStEygY0rqWNqzM9lktgwqw6h7BiZ5WQ
 4E23Qs7gfOsO/Blg36FLPBkfrqHgb0O7qKomekwLlF23B+f/HBi/lF4wBzIKRKd3
 zkRdSw+dIv0NIChmVGxtD8pShQR4kpxErNLGo/Yzu3JQjCIivC+kORcWIuUlKeZj
 Zg7jSRwWX79atchpE8gm896O7EmQMftWdmNGVG2xRGo7OQQ9rG7xY86AE0fO1oKW
 JaoK4iObBAaPykeRkFwndawxq6BxjfqRfn/ZQRDWFzAdwgyl4WhFm65/j1Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7b5w5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:58:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc4c1fc9ceaso626096a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790351932; x=1790956732;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Re9X7fDOvkyZZ3WP/+UOZyExDqbDkyq0JV0CPbSwk4Q=;
 b=fawYCPwsjC4k0pLEVZc/3ewnDNGc4Jo9KTedX/zcTNbLCJ77GfjfvVnjIz0cRKGZ3K
 GRd+Ynx6bPVnt9bFV6aFgw4wS2woxFvi16M6KdVX5+Pv7ict3raVnHEeGBM1c4UPXIE9
 64M/7BLIjEZGZ+geCYMpV7GaPFybuXmHqX4mDznNFm7bdLyJUsM6HG0kfg4wRCdhEl70
 wvBUnTJ2F80mZ9nU5OurG3xT4sUe+vdgQRwDaBe7YKSfrWWAGDYNZoP8fFsHOAol+vDA
 JeNRymGT7oWJNWRcgEAY9/jAJTrrwa2rP02fKfKe9uuRN4MmP3dBnalJJodvdEJh+m8E
 Iqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351932; x=1790956732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Re9X7fDOvkyZZ3WP/+UOZyExDqbDkyq0JV0CPbSwk4Q=;
 b=Ix2/7dZ419DNH8lJ0ENsPuO3JK68PJF5j6W4MdBeiIGPb/do3UxgTttMknXKtD3TdU
 w4ypq4X4tzkGcde1lzoQVdJUV+rAaaYjIpKpwA+2vUQN3gCEj7cTandKmsjFtzAWnhGn
 rN2jFJGpY2RBB2rZfAawpGzlz0TGXEJ7PT1KiVow7yRM1bJbdZ0WJ+kxSyJ81M+S2Pgb
 eNO7hgd6mrXmK9xeSeL0Lofw0Eamk/UCY7Wx3jh5WVQdUDwwiydeJHW7OhzqQJ42FBp2
 mw/hYBlvjnHfHemyUSjc5DQKqk6BHf/QfvqTCbXMITjsUQ0GXUzrXTf/o91vhgXh5Qtx
 WgSg==
X-Forwarded-Encrypted: i=1;
 AKwUvByKACZsGnwoIJWqTWMA+Ropdyj20HhfOVCy5Rt4SkK9QqyqZ15QKBDZCW6yZW8IbfIJvRLgNjs5Q2Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kfzzC1dVWrureu5b1l7LXu/kIEYXf/+V6/jR1l3xgaUvlgQz87
 nbzNg71jQs8bHC2cMS22LmFZ00mF2bfGL+wzTi3/AI1+xxGLJyiMKnRJNVrwZ9TwqMXIWJumPda
 9mpxVsLF0z4eenJ+URLEiHeiGMiWABE3fGoRz90tBX4xIhg6+yzGhDVzIth2178gny7oqABs=
X-Gm-Gg: AYBFou1m2DwlbVRcDBwgSDuY7CP1qjhiB5xeUnMHNDqIlyDeH+0s7BDHoYmYygmJPwH
 K2c5CUkYCjMWHEilWuEBUyw16t1hiYLvL1V4eH1kiYF4biH7a0hGZGd5K2iQ7ysfFVn0PpeKn+A
 vjrtiu73JtTZpNuzg7Jtdx8r0U7lV6nT98fzAw2cRPTxmxEt4j3aJwnH1KtGE1q3MgJc0YK7dBT
 Er/tjIj7bDvtBP0ONYAXfLcO78xfb2asJj8YoURZNsrsPfmlL3HjWcF6DFYdP+whICJ2rk+vVPo
 MqOF6dptak29DGaBHgY3TiARxJv658LYUqcygdbdBc49Djg0Kh908yzrOkg8En7aLrIjdpri6bb
 v2rCyVZh5DPNmEXljydvv4Rrb8lw=
X-Received: by 2002:a05:6a00:ab86:b0:874:708d:b633 with SMTP id
 d2e1a72fcca58-87e9d8da7a5mr5033704b3a.31.1790351931521; 
 Fri, 25 Sep 2026 08:58:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:ab86:b0:874:708d:b633 with SMTP id
 d2e1a72fcca58-87e9d8da7a5mr5033680b3a.31.1790351930939; 
 Fri, 25 Sep 2026 08:58:50 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87ff354d854sm1361299b3a.2.2026.09.25.08.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:58:50 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 5/8] net: ipa: migrate firmware loading to qcom_mdt_pas_load()
 and qcom_pas_prepare_and_auth_reset()
Date: Fri, 25 Sep 2026 21:27:34 +0530
Message-ID: <20260925155737.4161358-6-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xMLZlqzuDLJ2HQ0KADpBM7lJvrYuBNvV
X-Proofpoint-ORIG-GUID: xMLZlqzuDLJ2HQ0KADpBM7lJvrYuBNvV
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab69a3c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=P8P2WCEqvqb6tQ3B-mUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX9yLFs3fyBb64
 GRSukuvUpF3i1pj1brUL1s5hHLwiZfxYgQc+CoHRRqvuUIcOtTnhzO/IRvVLoYLXH/3lA0Sfzt8
 rCTzWd3kP5Rkz1stPopS+yTitdxyn7rVFvmyOvFCDu7IUza+mXl2K9iAjf3EaC4aypSLc4SN3fs
 6EFi44qpnrILQ122YYktOZ9J6P5jTnUfzcl7o+oSn5Q4uEb0riS9xD28S2of2G1+zLRespIN3+3
 mXrMEk+5z/P9nlm9fYgosu+iIkRe7L2it7gIwDh6P3Bm8cblYK3gRWA1x+8HSG308AgKmte2teS
 3sHOCxlszvjekUB8xLUOj74ML6jblxKxgPAOVhhxoS68kzmBqQ5KQJBFeezjy88TTxDn4bKkjxg
 MhGtiRRsx1QV1IfY96+UszNE2GWPE/E5AfO6dLxZIpcDvFs9+ByFYxDpn4i6iFpTq4UcURnIL8s
 1I3/A575hwinl+wjmHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX4pY+H0x4ajEM
 Blaws5pOUEUjKL13zUgbjj3dm4+yDL8y/ohJvsaYtv9agOXsb56Mw/fLz/VmaQaJ/Tb/55Dsira
 P6l5RwQ/oXXGvXYBe7tNNaflx2KQHqs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250063
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

ipa_firmware_load() calls qcom_mdt_load() which bundles metadata init,
memory setup, and segment loading with no PAS context, then calls
qcom_pas_auth_and_reset() which skips the shmbridge prepare step required
before TrustZone authentication.

Replace the open-coded memremap()/qcom_mdt_load()/memunmap() sequence
with devm_qcom_pas_context_alloc() and qcom_mdt_pas_load(), then pass
the same context to qcom_pas_prepare_and_auth_reset().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/net/ipa/ipa_main.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 14ac2d2faf7c..6964395caedd 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -585,12 +585,11 @@ static void ipa_deconfig(struct ipa *ipa)
 
 static int ipa_firmware_load(struct device *dev)
 {
+	struct qcom_pas_context *ctx;
 	const struct firmware *fw;
 	struct resource res;
 	phys_addr_t phys;
 	const char *path;
-	ssize_t size;
-	void *virt;
 	int ret;
 
 	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
@@ -615,24 +614,23 @@ static int ipa_firmware_load(struct device *dev)
 	}
 
 	phys = res.start;
-	size = (size_t)resource_size(&res);
-	virt = memremap(phys, size, MEMREMAP_WC);
-	if (!virt) {
-		dev_err(dev, "unable to remap firmware memory\n");
-		ret = -ENOMEM;
+	ctx = devm_qcom_pas_context_alloc(dev, IPA_PAS_ID, phys,
+					  resource_size(&res));
+	if (IS_ERR(ctx)) {
+		ret = PTR_ERR(ctx);
 		goto out_release_firmware;
 	}
 
-	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
+	ret = qcom_mdt_pas_load(ctx, fw, path, NULL);
 	if (ret) {
 		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
-	} else {
-		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
-		if (ret)
-			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
+		goto out_release_firmware;
 	}
 
-	memunmap(virt);
+	ret = qcom_pas_prepare_and_auth_reset(ctx);
+	if (ret)
+		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
+
 out_release_firmware:
 	release_firmware(fw);
 
-- 
2.55.0

