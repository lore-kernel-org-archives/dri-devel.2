Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A83606CEC1
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BRLe1t/L;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d5BRbtCC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BEB010F0C7;
	Mon,  2 Nov 2026 17:20:22 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D779C10F0C9
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 17:20:08 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2GZRcn2822937
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 17:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MvyBPhX3FXr
 O0Az/fY17mKualm8a8erVyVPUaeQCugU=; b=BRLe1t/LFtTQtlIXteozw6MOBCN
 REU68L19mcByERTTW0XagIqobsC6PEkD6XtgRfY3sNFXdz0Dm7i5iKhfgPmthsHO
 hHZtau5AlhCG9arqdDRVjz9b04g6LZF/uBPjscLb3hNMQWaON3ZJ6tL/ZgToVdN9
 VU68ggxsZLmOOmKFp7Refl1mNTSDLxxwN99FQApWx1UH1z/jo8kdyH/KdGRGEalP
 VLc3IEI8CEMgI/bN4Xh0hTVerdHiZgMn0608mt5wmJBenxyXWABs3Oout5SVGXZL
 TyzvndfeUJKrdNw0TZOeF9tOdstvjY9f+Gzy8gt5aiNWnZDXkb+iCrUJ+3g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4jx80-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 17:20:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso4703363a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793640008; x=1794244808;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MvyBPhX3FXrO0Az/fY17mKualm8a8erVyVPUaeQCugU=;
 b=d5BRbtCC3y57T+XAQ4tzyfPl3WnPBxozSCncYpJFcPT+2N/JYjfFgXV8oFnlOiJtMS
 7TDmQLfq9njlfGaQFHF8sgywCUJJm/gELmza8KtgZygRvPKDYdlNGWVSQ2cnLvc/IkSF
 Ic8Q44imDveUy5SmOgXR+C5Huzngf50F1V4UJjlTn2uWwFeNsllMHFMUvtcU6gHeretD
 eBZXnMmE5i/dCUZsrz/uvhsVU9jWVF8s7ONlv9GkGD+tL0POf27hFUpuhphKcuTNC0ND
 iZ04yblg5RZQKTKUOV0rpzM32EFpeD1qv3LC/fBYtv3u5OrjngT4/CZ1gLyp6/BREh7M
 CgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793640008; x=1794244808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MvyBPhX3FXrO0Az/fY17mKualm8a8erVyVPUaeQCugU=;
 b=HYPmxJa+byrK1g8hVJvTgZceFYSsnvg3QHB4QJnfkGg7+FgBz1WgokUb5PRSnb5Rno
 Fm8WaRL/d4ZRVu+pbB3XrIKHT7sSVExPzlR+Nd8IsOefC9fWEIWvmX/ZpwQFrP2Fcayg
 63LR0QipIcScVWvSEM/DjlFdQNDY4+VxnriGzI6KpSAwRzHqvTiKwVMVwP7PuKRnlGsa
 5YmH6z7lf2IaEBZUxXpy45MqPDiBXUucKxaCJStYa6A5EgG0IakMiadHV71CWz73wVUA
 0iv1Wv+bipA+K7KzBei4Jzz52I6f1h1/AEVTg4XRsl7wnXqvc6pSDJim6rjPeTDooXwj
 YreQ==
X-Gm-Message-State: APuU4Z8NiAbJjSgejyUlNJIBnC8lSXCQQUl2/DkiI3HI4COWCRs8Xuny
 Q9KtkZe0DNX1mKq59vgeuH2lkZq34Z85oY4vEuMeeHhgYf3H0ce5140aYQyk5SbRAhw/s6ann4e
 cMZLTiAClS11B36g1LNgS7s/yXHGu5X5HFyMD51swryTXgzyBN/xE+IqpTDvuk/OhNlITd/yRhK
 qzfyljQQ==
X-Gm-Gg: AYBFou3JNjaq8thhNFFA0IeLN7oru9tpjnmyCJcR50UE8C/ht1huVa3YWY+X9bqdOMc
 kPKWKo2dliObTT4kqJ4k+Hy0zOWOb7QDj1VHLYZ81Sf8rmRxE5Dgcivx3gPVtARsyKMZ4eDd3Cm
 JRC9TfNFPf1YL4JOljjo2FpjWJjnTDpgGmnBWQVn/pcrKZz74Qr4q80iJo1ZiwY8fwAbrH+10oz
 82oazpNEYRrcBUTfJYLY0AwhWg45HxU/s4CN0FMuqcqXBQfL8Q4jv4j7jmnFYWZRpo5bMCTTOQn
 wYcBT3qNxgjJjvtmucNERIQzSvIakNSCAJeyrFe6qkaSfeB+v8y1UIgwZF3X/cFG6uSi9VVjcPf
 8oJ/Qh0oWwcate/969IPXxdx1Rc+vDW1iexQauEUkfWN6iUhDXyKk05ieeX8uQ0x1F4a3ZzxRki
 GS/qLYFUKELShiaxV8FBXM+w==
X-Received: by 2002:a17:90b:33c1:b0:3a8:59d3:5317 with SMTP id
 98e67ed59e1d1-3ae89751035mr9022457a91.32.1793640007629; 
 Mon, 02 Nov 2026 09:20:07 -0800 (PST)
X-Received: by 2002:a17:90b:33c1:b0:3a8:59d3:5317 with SMTP id
 98e67ed59e1d1-3ae89751035mr9022428a91.32.1793640007103; 
 Mon, 02 Nov 2026 09:20:07 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c666cdcsm89644a91.11.2026.11.02.09.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:20:06 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/4] drm/msm/gem: Fix VM_BIND range check
Date: Mon,  2 Nov 2026 09:19:57 -0800
Message-ID: <20261102172001.508440-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
References: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DfUGifU2bqeyVfdfUHaTlgqzwYgRobGV
X-Proofpoint-GUID: DfUGifU2bqeyVfdfUHaTlgqzwYgRobGV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2OSBTYWx0ZWRfXxP7fTnfPAaJw
 47c0TUZA06KUfQHCOTvdN2kpnwVAlNNOoSIIeXX+dKu6TbpkRVacFVDJXEfuVq0HF3H2iFfXbHQ
 JZDSbFMAxN4ULEMeVkS4LAV7XCaQca0=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae8c648 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=BFYDg4fWK-pXFiMG0zkA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2OSBTYWx0ZWRfX4Z+kf2CtGAGN
 ksCcIGfY7jQvznZVZtw1pkMPavdgGv8YtY1e2dphQ9kCny5T7Qu2lias+D46rRTyLcxmcw50HTX
 eXrG/K8PkDpS8fYZWM+Hf8z+ODLk2ZOCLZsGfuVRIFj+tD6+j2OKE+XF/ihmPNvnZhIJ209JN6t
 QBMxJItJcM3v8Ba6wz9BvQ3NK9B4zZS+mnu7w9wj9R25l7wjbpZK4tBYKUM7jm5amFPdRazSR2R
 qPFW1F9d8TOXkuCM7UVCad0Vc9SxvSt/rYw8r0Fmv2r5daQL9xqQEdtaLIQubEFtbs8SPT8yIW0
 EK5QkDsib6t+zWJAeEHqR/TrrYTTNW4aOCY48gZGANO3LJxPU6fn94sidMIykv9KtQkZPB27FbP
 CIlzOHgpX1I7Kf/pv4NKIwz2eA1OCSotH2b8Pj2f8K7Li91jh/DMJHwaJvTAMXwQO51PYoUmonr
 Lm2m4UQ8zjNIGmcOolA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020069
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

Use size_add() to guard against overflow.

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 3a3bef68a6c1 ("drm/msm: Fix missing VM_BIND offset/range validation")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index f687a629629d..bd1c3ceeea51 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1012,10 +1012,10 @@ lookup_op(struct msm_vm_bind_job *job, const struct drm_msm_vm_bind_op *op)
 	if (invalid_alignment(op->iova))
 		ret = UERR(EINVAL, dev, "invalid address: %016llx\n", op->iova);
 
-	if (invalid_alignment(op->obj_offset))
+	if (invalid_alignment(op->obj_offset) || (op->obj_offset > SIZE_MAX))
 		ret = UERR(EINVAL, dev, "invalid bo_offset: %016llx\n", op->obj_offset);
 
-	if (invalid_alignment(op->range))
+	if (invalid_alignment(op->range) || (op->range > SIZE_MAX) || !op->range)
 		ret = UERR(EINVAL, dev, "invalid range: %016llx\n", op->range);
 
 	if (!drm_gpuvm_range_valid(job->vm, op->iova, op->range))
@@ -1118,7 +1118,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 		op->obj = obj;
 		cnt++;
 
-		if ((op->range + op->obj_offset) > obj->size) {
+		if (size_add(op->range, op->obj_offset) > obj->size) {
 			ret = UERR(EINVAL, dev, "invalid range: %016llx + %016llx > %016zx\n",
 				   op->range, op->obj_offset, obj->size);
 			goto out_unlock;
-- 
2.56.0

