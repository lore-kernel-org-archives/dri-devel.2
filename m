Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2240606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aFB/Q1bx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QWiS01ek
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD2410E0B5;
	Thu, 12 Nov 2026 16:07:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7EE10E342
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:07:12 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZVdp1159590
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=NnU6y4luvTuh8U9uo5pDvncjM0V/OsuTGII
 KwgCmHqw=; b=aFB/Q1bxcYpelLMYfZoTooptWvIZo6UX7IIgZnXH6UQ+lcftOEv
 Hi5o7GVWayaQSDX1K5054dKvvTw1/7jsBwf242mKTLPqWcnI/lcsNttovr3lFTBq
 4wOOEHFl0oZ9b7R4MoztOTXG60bNC9N2A8uu4zGk0S6LYDdHUwm0OHMV19HNG0nn
 1RQZPP7aBP8sGBVGBaFjdLxaffQsXZ9rei6L10YuIVmSIKfNIxiuSrxLMtR9XYQl
 XZUDTqM254l78S3lD8DHZGM2KY3vn6AIQro/sczKL6RcaiCv9kZt8WGvmB13xZjU
 OdniTa7pbATRWGd4o8fJI5jiSWyG7hu3dng==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a09tn8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:07:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8bb1a7b0e52so2501677b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794499631; x=1795104431;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NnU6y4luvTuh8U9uo5pDvncjM0V/OsuTGIIKwgCmHqw=;
 b=QWiS01ekbbS0bJHMMzNWf/AeWS514q8Uy+rcZFSjomC6SMpK62t0dfGPZUBkHwZNTO
 CSkrVYPR2KG+M0DnCtuFzGNmizBX2VuLXRRED9q45JZSATON9yzlTRtx4RllCayV9Bap
 i7uwQI+0OuN2w3wZTdlPeR8q+Z67dlKGCPa22RWkyX2i0Vfq7oI3c0bbkcjX4s7x19Vp
 43sVpIWmKp0vBlkuG9nn0h7FzPIi1lCp0E4Uctx5dfmQZTHYZgtklTr2U6c2hfZfhDkI
 3qoSxX8UYZOYUTOqTEKbZpWxktUTgj8hOjdZEuU11n9k2CF8Z6mPBSmwHVYKpV6pp9Wc
 FVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794499631; x=1795104431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NnU6y4luvTuh8U9uo5pDvncjM0V/OsuTGIIKwgCmHqw=;
 b=f8JxXUe+FCdVnuMewpRvNRT4dS0S+0mS4JUNtfv6CDfODNxXYMGg5bWZvhAbNQegCB
 PiL7QCW7p3ABKycYipBEWweNEd1uwAilYl804gEP2MjsKSyjUTx0OCozmL6jPYkp+QHy
 UzYVZctr7sOu8nv27pYmr6p8p6hsTmnkC3xbZ9EwEUlwhq7W1+3LAksAS+rwKWfBytWH
 G9SAsLW2EUPD44irH2WMjwhCSIg7jcWcyZxjVCkzY/kAde2HazgDeMrCIUiRCjM720WO
 b6e6NTMeQnJjBeZhqRq7jDO8iI40FrguQGGmYpl2TDaBFDR6IuL7B0Ccl3QUi4mgBulH
 wrdw==
X-Gm-Message-State: APuU4Z9XtBsXX8a8CiaC8qDjOFIdI5O4gznSQyzF0an9CJ63a1sQA1An
 8IdpC1lS8Y0A7eubKcjCuH+fhjq8l7JIdb39p/jGm2sj/+B0v0G15Jhh2XvX5xfCzl29nGr4Gww
 dXq+aSRdyN9u8RDH5rL1zkVHv3OIL0uYDFi1ptLveM8/+YtXcCDFMTQMupCGnS3zYrkkxi/R9N7
 +RtN3nNA==
X-Gm-Gg: AYBFou2ujr2LeS+2w26MZKLOS+fGuLJu4vDpHWd3n7xoejABgUoZU/SCCCmcnmtvWnL
 4sbbZlzQ4E0ssGIbpRkZ9J1pyDhN7GqV9Ihw/oAhQfwz3YztR7gpN4JLoDv+Es8FkJf6vxc4EnK
 9itus5JP6+6lYxr6veddqTnf0bl0lhqfEvZmN6fr0RUD5SHRCqV+u4s49Tk6tltC4JlgxW07zko
 Ad5JpsbTNS1tcTAc00NeA9KwruVFK7+tZBWZyNtCE1jhgGcnyJPBfxY2DbzGUpy0GiHSsVXA9pE
 Zl54qZJdjr5AbyrT3ds/hGXnA96O6eYM2VmEMMn1r4xHUE0EljuBarHH7KzIv3qDjrqy7TZCmta
 RlJldom6cQMklwI1B0uAMFVCpawODLLX3yefBjolkk1h2KEVWA7iQvuwDCy++qjx4/voTxj3jx3
 Rd8hEZtPEUCWg+7AAnedvgHpLc2htzEIrAB5rOKj++7sffzK823WsqNz5pAjI/
X-Received: by 2002:a05:6a00:189b:b0:89d:ec58:ce47 with SMTP id
 d2e1a72fcca58-8bc1e1d2a29mr6061968b3a.55.1794499630500; 
 Thu, 12 Nov 2026 08:07:10 -0800 (PST)
X-Received: by 2002:a05:6a00:189b:b0:89d:ec58:ce47 with SMTP id
 d2e1a72fcca58-8bc1e1d2a29mr6061911b3a.55.1794499629987; 
 Thu, 12 Nov 2026 08:07:09 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaa1b27e8sm3588199b3a.16.2026.11.12.08.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:07:09 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a8xx: Fixup hw_err_irq messages
Date: Thu, 12 Nov 2026 08:07:06 -0800
Message-ID: <20261112160706.387641-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xbIMhlPCSbwBMX8Cd7eHopqbWHgnF9qJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NCBTYWx0ZWRfX75RYNDZYQ19s
 vrOtEnwaUYV0FQ9lRw9Xk8EwVWBzYMmKa6qw1EzXxpyL8cL5yYEso6mW4aZsEHOYGgvO1+2c/tf
 mzq/s+UoLkjx8gEzUFCfge+WFmIsbTv6ImkJFW+YbvsCP1sGR0kGJGtzB0OVdAAPmWEpakmcCJ3
 mL+ihdenV7c4jeqbZFvcF+zTVGhVOQJuNp/eOUGP0TmrbWuvNysNGnbv4qURVmJFfVRS52kplsH
 3Y8gIdaOAF0xrnJ4///4AwBponXNgqHURTy1cCX89yN3TPyjNJBB3ys14YnO4fxcwwCSoPKdwnE
 0KdQbBnhzvqHRcgfas8Cc7ZbcuPWkOcZPQBjvsQkPOPNZpx4dbh9UWhuM2XKsIAlmiHOMbu9h1z
 4wQhakP34+HXWTT41kCtdM6xEEOY6XP+VSaDtEZ0/rPMYLwyJqOk8rb1n2q7HRGyenM/WC4aL2L
 IqSMUJ/4n0tTrR83CRw==
X-Proofpoint-ORIG-GUID: xbIMhlPCSbwBMX8Cd7eHopqbWHgnF9qJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NCBTYWx0ZWRfX1JmKHDGxQAbF
 H58YXOI/FeNZb7EJHSlCsUYByo+P5jmWGwMN7hrwz4BIIs5P1Nupd4VylRPLNvbqTCPVKpf+d7W
 7afYJ++4Qp2MP00egkM4BQAX8aJXKk8=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af5e42f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=cmur_pPeXtk5nLvMRVkA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120064
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

Handle all the pipes, and don't clobber 'status'.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 58 ++++++++++++++++++---------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index bbf5ca4fb6fc..a1747990e10e 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -1048,24 +1048,37 @@ int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *data)
 
 static void a8xx_cp_hw_err_irq(struct msm_gpu *gpu)
 {
-	u32 status = gpu_read(gpu, REG_A8XX_CP_INTERRUPT_STATUS_GLOBAL);
-	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
-	u32 slice = a8xx_get_first_slice(a6xx_gpu);
-	u32 hw_fault_mask = GENMASK(6, 0);
-	u32 sw_fault_mask = GENMASK(22, 16);
+	const u32 status = gpu_read(gpu, REG_A8XX_CP_INTERRUPT_STATUS_GLOBAL);
+	const u32 slice = a8xx_get_first_slice(to_a6xx_gpu(to_adreno_gpu(gpu)));
+	const u32 hw_fault_mask = GENMASK(6, 0);
+	const u32 sw_fault_mask = GENMASK(22, 16);
 	u32 pipe = 0;
 
 	dev_err_ratelimited(&gpu->pdev->dev, "CP Fault Global INT status: 0x%x\n", status);
 
-	if (status & (A8XX_CP_GLOBAL_INT_MASK_HWFAULTBR |
-		      A8XX_CP_GLOBAL_INT_MASK_SWFAULTBR))
+#define FAULT_MASK(_pipe) (A8XX_CP_GLOBAL_INT_MASK_HWFAULT ## _pipe | A8XX_CP_GLOBAL_INT_MASK_SWFAULT ## _pipe)
+	if (status & FAULT_MASK(BR))
 		pipe |= BIT(PIPE_BR);
 
-	if (status & (A8XX_CP_GLOBAL_INT_MASK_HWFAULTBV |
-		      A8XX_CP_GLOBAL_INT_MASK_SWFAULTBV))
+	if (status & FAULT_MASK(BV))
 		pipe |= BIT(PIPE_BV);
 
+	if (status & FAULT_MASK(LPAC))
+		pipe |= BIT(PIPE_LPAC);
+
+	if (status & FAULT_MASK(AQE0))
+		pipe |= BIT(PIPE_AQE0);
+
+	if (status & FAULT_MASK(AQE1))
+		pipe |= BIT(PIPE_AQE1);
+
+	if (status & FAULT_MASK(DDEBR))
+		pipe |= BIT(PIPE_DDE_BR);
+
+	if (status & FAULT_MASK(DDEBV))
+		pipe |= BIT(PIPE_DDE_BV);
+#undef FAULT_MASK
+
 	if (!pipe) {
 		dev_err_ratelimited(&gpu->pdev->dev, "CP Fault Unknown pipe\n");
 		goto out;
@@ -1076,31 +1089,36 @@ static void a8xx_cp_hw_err_irq(struct msm_gpu *gpu)
 			continue;
 
 		if (hw_fault_mask & status) {
-			status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
+			u32 hw_status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
 					REG_A8XX_CP_HW_FAULT_STATUS_PIPE);
 			dev_err_ratelimited(&gpu->pdev->dev,
-					"CP HW FAULT pipe: %u status: 0x%x\n", pipe_id, status);
+					"CP HW FAULT pipe: %u status: 0x%x\n", pipe_id, hw_status);
 		}
 
 		if (sw_fault_mask & status) {
-			status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
+			u32 sw_status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
 					REG_A8XX_CP_INTERRUPT_STATUS_PIPE);
 			dev_err_ratelimited(&gpu->pdev->dev,
-					"CP SW FAULT pipe: %u status: 0x%x\n", pipe_id, status);
+					"CP SW FAULT pipe: %u status: 0x%x\n", pipe_id, sw_status);
 
-			if (status & BIT(8)) {
+			if (sw_status & A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_OPCODEERROR) {
 				a8xx_write_pipe(gpu, pipe_id, REG_A8XX_CP_SQE_STAT_ADDR_PIPE, 1);
-				status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
+				u32 opcode = a8xx_read_pipe_slice(gpu, pipe_id, slice,
 						REG_A8XX_CP_SQE_STAT_DATA_PIPE);
 				dev_err_ratelimited(&gpu->pdev->dev,
-						"CP Opcode error, opcode=0x%x\n", status);
+						"CP Opcode error, opcode=0x%x\n", opcode);
 			}
 
-			if (status & BIT(10)) {
-				status = a8xx_read_pipe_slice(gpu, pipe_id, slice,
+			if (sw_status & A8XX_CP_INTERRUPT_STATUS_MASK_PIPE_REGISTERPROTECTIONERROR) {
+				u32 prot = a8xx_read_pipe_slice(gpu, pipe_id, slice,
 						REG_A8XX_CP_PROTECT_STATUS_PIPE);
+				u32 addr = FIELD(prot, A8XX_CP_PROTECT_STATUS_PIPE_ADDR);
+				const char *mode = (prot & A8XX_CP_PROTECT_STATUS_PIPE_READ) ?
+					"read" : "write";
+
 				dev_err_ratelimited(&gpu->pdev->dev,
-						"CP REG PROTECT error, status=0x%x\n", status);
+						"CP REG PROTECT error, %s addr=0x%05x, status=0x%x\n",
+						mode, addr, prot);
 			}
 		}
 	}
-- 
2.56.0

