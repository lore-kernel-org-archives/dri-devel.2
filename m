Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC78606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hd0zUjHF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PeqaW4CB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8084112D6D;
	Fri, 27 Nov 2026 20:16:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB842112D6D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:49 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAqdx3982217
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0zRhM/O1T4txkzF9sfL+DPW1cvJF0Hj1I6FpvxqvriM=; b=Hd0zUjHFc90UyaV9
 FvI74kpFZEacBrMJduuxJA7JpnJa9Kr1MBfKZFcKjiblzgevThnrz394i/77Dhoo
 KPLDysWGNfbCp9dyB/cJe+acmbagwI1huIQACist6e29hxSyZhbf1LvVkZKpcsHW
 RCi19RuCkIG5FlrwYksumJRabch8akoluNcrkx0/zgFdfDxhi2szZtJd+GGpAS5M
 oiPiM+zmV7bJQPJF5zfSOVd2mjAgNpmPUL73DAXR+5LDTaVEUKtRrdauf3VQoIzP
 E7cCTGlOqOffMRX1Av9HnjySTp+CfWUu2sTRpKI8ZAvYKdYeASmxd2AcLWep4PU4
 aIA/OA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7f6d8828-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:49 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5eabb3a1bd8so6693542e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795810548; x=1796415348;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0zRhM/O1T4txkzF9sfL+DPW1cvJF0Hj1I6FpvxqvriM=;
 b=PeqaW4CBMmPLDTck38vAUH9ZfK9dEgqT6CkYi67/rwivxoRE90994mu0AR+Fi2AdSp
 6/a4xuL6YbdzHpdksZGwdt8Z2AlCz5wm5Hrpz2Ej9uX9hhH9YxpG8JygNQVIFMBTagMG
 lN8lT0hn5I7aO+dELSyQhhVUS4DTF3cOSXZzYNtWrRlAOSG7QZ/AWgQlEo6lSSWAFGb5
 kUoZG49CgrZTpxBRpRBpa4gEhDgBGeSvEHO7nGr83LOjk+pCIqaOfY24wJiTLfsP1N2y
 3M9uuyqh2er1C0U0joeX6fDXlbJuT0p6TNsGabX449KiwWLBTh7CZX/BRnPbL0pqm4Ge
 cNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795810548; x=1796415348;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0zRhM/O1T4txkzF9sfL+DPW1cvJF0Hj1I6FpvxqvriM=;
 b=2uBT271Jr7YN9vxfg+ywr6vPYKg7DPDltkO/fFYJrE7aNZ1JH2vpb62EwYbprsr6L5
 BcEVuHObH2yXt81PWCWXa0fJ+PINzAevSln2S6abn0iYktVFDokVLNbsXu27C+czGPH6
 hQ7g4efaYD0EazOxwfrWQ64t+ii0jNkaka2Eh+bolu3h63NIHqUdzuXjqVPJdXdnEFDe
 KnSb2qqYtLGn+oFMiPsDZOfISA7ZeFcCUu/CQ2cipe3b6ZRK3osvGVvKIOw47bpCu7rc
 vwz1nfxLnoF6IhrHVYM2OJ6TcLURfb8PIN3JqB5rXwjzMeHDevGDC9Oo/ammP1rQw+JI
 yHSA==
X-Forwarded-Encrypted: i=1;
 AL+hErETyZNsai3YxGpW5F8uwndtyrDahI3CufD3qRr8RBN9nkZm7oE+T5rgVjhoKrCmOKcjK56Zv+e6ZYc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9RWW0vgKqPNqPF1GlrwTyz5PnNze/8P2mtp3f7Yyl+ZfiPO/Wh
 7MOXYuZOHGCgg4I3VfNoRD+ijb+3bnRH/BrxzFaLCU2/0ZyYHGiD+wMpzkOMuqYS9i9EMnh4f28
 W1bwuYqNIIl+CjAd/GMj78QPM1llq6Z7IQ3DLbofUN3Xa3SKVlOLhFVa8TZzajJHTtUR6VqQ=
X-Gm-Gg: AZFdTZfimF57mQvtG9EIHILNYYtBtEr63RLbudwsgIQ9ZLeoDgGXADTPPSp4OGxYK00
 dv6eFTYp94OOdIFINkZUHdqe6YxuTHazXpH5mngem6ZjVRK6fr1r6LPkKq7IeHmSYnhT+hvJWig
 /Tsa8qRoiMORZZDBh4KQvKgbe8XWiAVlTzwoDYi7B9s0tQV0qi5XqfwswOpqj/MT1EmtlWcb28t
 PrVzwHsEGsntngf3T26DYbl/BkAq8ZQ6fAZoxBECn+yOjQMNZaz9a22l3BBpaTKTgginSuhqHY8
 dpR3joy1uBY+N9kDf/IxApZ7KyUHjEVe0cgT/H7i25ZWJI4ziwrlwuz5UIq66z5Jzue6MQeW33H
 TIzeFl8AJ5CijboPvk+hDafRZdBfFd6IcLJyZogQ/okHGhvzSGpSnAlINFkxwGXhaDao2Yr2vHw
 Xly7QvYsSnhIb6gH0vmkwZMj5xNSSH54QA6OwvNWLVAGPDG3GGEqxB0yWOEmaKfQ==
X-Received: by 2002:a05:6122:209f:b0:5c7:fbb5:6ea0 with SMTP id
 71dfb90a1353d-5ee8af0c762mr16859614e0c.4.1795810548070; 
 Fri, 27 Nov 2026 12:15:48 -0800 (PST)
X-Received: by 2002:a05:6122:209f:b0:5c7:fbb5:6ea0 with SMTP id
 71dfb90a1353d-5ee8af0c762mr16859568e0c.4.1795810547434; 
 Fri, 27 Nov 2026 12:15:47 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8050fddfsm64591511fa.16.2026.11.27.12.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:15:46 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 22:15:25 +0200
Subject: [PATCH v2 1/3] drm/msm/a3xx: report CP protected mode faults
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-a3xx-fix-me-v2-1-839408d293ed@oss.qualcomm.com>
References: <20261127-a3xx-fix-me-v2-0-839408d293ed@oss.qualcomm.com>
In-Reply-To: <20261127-a3xx-fix-me-v2-0-839408d293ed@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+geKBFg39jc42lSGhUHzJ7znn8vxsTpvFubSIenP6p4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCeTotaSyqqXnFqCiPhSQ9CqNVoraO6tLNj98/
 XYAigPtnLqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawnk6AAKCRCLPIo+Aiko
 1d6DB/43fdupC+YfUjJito55k/+MkyO2SkJwWHB09TjFQ3JnVxmLfMPVfyog4cOdh15VPtNDSUD
 3nN99aLXG1XncAxvtWfmyiZ2OFNAuiJLibze25T26yPPLRU7MdW595uy8GjoDlNYxTl9ur8d6Je
 hZRegMbyifgFyeclevAN4r3ZeRmTPqUhZCe2s1R3DH2NDEKfvAStET/kzaaAT4nZ6tWnhw2XdRf
 yDO5YcTS2yhNEnOjuP/c9kpRRhlhA9abpRMUZRWArOipnxjONMMQzwDGSxU0pYbYjw3TeI2Z/YR
 miGVojtzYfJ5HQTt61c0hZUZkquA/zrzgOzbvZ5fkGlxg+3r
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: jf59ejj6xAz4sa7TOB3RvlwcQkR6b8if
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX3f7b0hZSqnZ6
 j8CfY3Ysa1VyTvoWFL0lAiCnnuZJe+yBsyP723/ohRWp7gRP3Y7LlbAZbpu2SJsye3lITStAMHX
 YqC3l4toduj3jBwqJPbBdIvthoAXKV0=
X-Authority-Analysis: v=2.4 cv=IKqXmQvG c=1 sm=1 tr=0 ts=6b09e4f5 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=mspBB8xj_tKF7Wn_8mAA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: jf59ejj6xAz4sa7TOB3RvlwcQkR6b8if
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX8shp+leuPt3g
 /PZAAWPiixn7dI4S5QvyvZGisvdYLhPPnxKFjU/TY6uld52ou1YqNVSFNe03tD26k8akPeVaZWO
 5h5u15OmNyA0lYKHvCTKr8A0wNuStfpIjskkR1XJvY3dtLmoaXtz/KuSu8jc5dPS4l09YprQaXF
 JO7pqyrjSWf4U96OciPZl/bKV4NVjnTqgiXGIIy+NWxOycT8BF6ZFA4tgkcbYpw73lnT5iekafZ
 3KGQr7yc4V85XlniU9ZovZZHp0myjNHReqy8oud4Njdp3fIwv2E5+vcxMqrEL2t2yQxrR/xOPMK
 u4k4e6tgc8/BAEO2LXScbs9QDl8Bd9BTbEG4MuMg/O8PuAzDCsrMMG82LFpFSk+jlLpP9vrlNkY
 cyH4uSeEsR673j+68hwk08wqpvswujo0wSTB0TnenPNyh8/eq0pF4F4vnp2dCQlBrJKYQALunQq
 Aag31j+mDry6rAcKu6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270080
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

a3xx_irq() acks every interrupt without looking at it, so a write to a
protected register shows up only as a hangcheck timeout with no hint of
which register was hit. Print the faulting address the way a4xx and a5xx
already do.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c         | 9 ++++++++-
 drivers/gpu/drm/msm/registers/adreno/a3xx.xml | 5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 160d302e16a3..bd4b3ef7bc12 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -419,7 +419,14 @@ static irqreturn_t a3xx_irq(struct msm_gpu *gpu)
 	status = gpu_read(gpu, REG_A3XX_RBBM_INT_0_STATUS);
 	DBG("%s: %08x", gpu->name, status);
 
-	// TODO
+	if (status & A3XX_INT0_CP_REG_PROTECT_FAULT) {
+		u32 val = gpu_read(gpu, REG_A3XX_CP_PROTECT_STATUS);
+
+		dev_err_ratelimited(gpu->dev->dev,
+			"CP | protected mode error | %s | addr=0x%8.8X | status=0x%8.8X\n",
+			val & A3XX_CP_PROTECT_STATUS_WRITE ? "WRITE" : "READ",
+			FIELD(val, A3XX_CP_PROTECT_STATUS_ADDR), val);
+	}
 
 	gpu_write(gpu, REG_A3XX_RBBM_INT_CLEAR_CMD, status);
 
diff --git a/drivers/gpu/drm/msm/registers/adreno/a3xx.xml b/drivers/gpu/drm/msm/registers/adreno/a3xx.xml
index 21b00a17ef3e..fd2faf134e5a 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a3xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a3xx.xml
@@ -758,7 +758,10 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x0445" name="CP_PERFCOUNTER_SELECT" type="a3xx_cp_perfcounter_select"/>
 	<reg32 offset="0x045c" name="CP_HW_FAULT"/>
 	<reg32 offset="0x045e" name="CP_PROTECT_CTRL"/>
-	<reg32 offset="0x045f" name="CP_PROTECT_STATUS"/>
+	<reg32 offset="0x045f" name="CP_PROTECT_STATUS">
+		<bitfield name="ADDR" low="2" high="19"/>
+		<bitfield name="WRITE" pos="24" type="boolean"/>
+	</reg32>
 	<array offset="0x0460" name="CP_PROTECT" stride="1" length="16">
 		<reg32 offset="0x0" name="REG"/>
 	</array>

-- 
2.47.3

