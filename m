Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE16074A55
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S0PoMoIk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CjXlThhV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514CE10FDC1;
	Wed,  4 Nov 2026 18:00:16 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D56110FDBD
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:59:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj2kE1899319
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 17:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bJZszEO0ARO
 xRXFKvPGmV2rnbIDeStcxgukOo5uOajw=; b=S0PoMoIkilIeLfefd8qwuh3k1dD
 TNW2Y+o+/AKAvHfEvrBNHghpc+VvuhpwVpcu8D4c82kDQBFsRhYIAmaeZlAAcIDK
 uLzoDSCKDGnlHOX0nueZqJquKdaQVIP0XKejnJnbnRfMFWQur8g0Cl68atp8IpXN
 43cTAEI46Fg82Y4EaKU/Rnm42v0T8Epkhs1JkdHT/0/Q+CFeQt3XOWfECW4m4IqR
 8kiZAmBUcQOWxjzmPpL32SUIU9jnlDnN/Md01o1jbvbJKvKEXXN9CuDTbAhygNr8
 1bjoZFAc6mrtvkm2VmN9OXWt0K5OUaeKdZg8cxnSCwXDUFKL2xwaibDFasg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqvsgbf8p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 17:59:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b08364cdc7so977628a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 09:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793815185; x=1794419985;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bJZszEO0AROxRXFKvPGmV2rnbIDeStcxgukOo5uOajw=;
 b=CjXlThhVaRzaZ4LYyDRvCEjExYp6KRYNwhdgtkRk6bferj8qV99X+CsnGJLb8v27t3
 nZzMcEA7OLkjWxy7WI5a0ZK0tJpYGPgTa32Cgs9iwsx3hxW9BooSGI92Pxhgxp6HWOff
 3SI281gYCxnH7aCi8NdD2btsjY19DYElyNrlVRrgzll/06jkmfdBMi2wKQhHaTJPMUhW
 yN9iCODEGd+NkbEwUm3VPsFbqlqJp0S1U+21/aafrwz+N1Ow17o24ByllkteqBiwqs0V
 umTYyWBq/mjLWDOOT2RaozlOWE0qmmPJWEoaXmenLukCPh17ts6quYv2S8co6lN74Apu
 BUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793815185; x=1794419985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bJZszEO0AROxRXFKvPGmV2rnbIDeStcxgukOo5uOajw=;
 b=svwXumqTeWThuc5344OKb/lloO/g9mlHrISOADq05vTj8FBYJBoa/Hs/vLd1xafMwd
 3wVB/Ng5QEwEm1xtrwBX0ztrk9KGER9gVRDnmi6WreFV3xcIaedNDSKAE+Cd/zxE07Hh
 GObbS+m8yWsZ0P4VSVQXO/zIl8WpeEu3bESaPvSLAa9PrMB0yACg/WXjhnJbOebSk+pO
 JPIIjoVupBFKC4eAuu3fNLcMDKhgBXOPmQ3c9QuAl7JfDQojviirB/z7TnPn+do9zoln
 PVQKEFVT2f8MqzVCnoWKhA0UV60tOi/J10HdGMd4ltddhpbkU8jpwQ9tJYFiv6FqeNgs
 XpCg==
X-Gm-Message-State: APuU4Z87mGdsqOZWHunD3RYEPX5hZXmavW2q/yxwJiZrPNynl8PeBbzF
 wYBfqi3IxnYm0tkvPnaDAeesVNGkP/YkCLnWXOtHN1VB5PnG3WAtMb0V2zArS/FFqaMrt2POuCg
 5rXrw9vzALpgaiTFunMbv1K9RZA7ZA5A1rqUIEmLvmdkIwwmVSwTh8qmtHxqSdYv7A/vl0Oq3v8
 Stvc07Ew==
X-Gm-Gg: AYBFou3FT1ixZ3eMRRUTAqPC8djAr23YL5HPDZjewmZPos0rnIp9OPSrXYt3sEOq0Bn
 JaKDsm6tsow4x4tDWJhg07wPCy11CwRtyiFg0OieHAHGgb4BxAi6lDWNtjhpbsXUZf+bVL9XImx
 ZUVWzPq2spnA/etvgXWm2PBj/++RJSpFh/FVfVSCjrM2ykm19ROiEjNB3/Wd76arTrjYw2DD35M
 lf/kccgrVL7O0KK9xIPdb5RzliswTrTKm8DjosF7nHJdFXvDAGGD4qfiaBYHpgRKeK6J8dcnKuc
 3QGRWvfBvAatm+PGLNZxLnKG8ACy5J2YcmhlnFob5j8f+uZ7jeWCRPwHHYT4pfb2/Nucx3PIq0F
 4eaS9RJ0lhiAGql/sUKVvDpIOspv0a2/ZH4MW9D9OEsxurEXY6A0e6qEWOsY5d4KFzx6/EHYvPx
 +OebMG7JrGOXzr2aNoid9nggI8m0bDBNBeC6BFRql9GxDfm4e+saJ34aJHSTs=
X-Received: by 2002:a17:90b:52c6:b0:3ab:be66:ddc7 with SMTP id
 98e67ed59e1d1-3ae897ccab8mr16723791a91.10.1793815184918; 
 Wed, 04 Nov 2026 09:59:44 -0800 (PST)
X-Received: by 2002:a17:90b:52c6:b0:3ab:be66:ddc7 with SMTP id
 98e67ed59e1d1-3ae897ccab8mr16723775a91.10.1793815184450; 
 Wed, 04 Nov 2026 09:59:44 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b319f2c9sm41733a91.10.2026.11.04.09.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:59:44 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 6/6] drm/msm: Inhibit IFPC for state snapshot
Date: Wed,  4 Nov 2026 09:59:26 -0800
Message-ID: <20261104175931.28475-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
References: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GtnXaU1C c=1 sm=1 tr=0 ts=6aeb7292 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=eWlSUfSnBrBg5eVjM6UA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 5NamkCvmhHYWvAM9NnGT7AtURnLkTHvo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfX0Att+bKfcazR
 md06LPGPliLwaDulMBd1Lecak+58dvtyT5MzNzBkFRCXoLuLmwn+2+wiB3x/2BTcVVhUEs3tWmS
 cLJkUwS0m86Z35jRC8dQnO7/IrxNwyJBM8k6Wf9JIEk7y5rcxZ6xQfbtgnJf5Qai6+jZb+wcNtz
 BzGUKmLIbTJDkNF2pNcxrBkSLcBmYRR+Hm+BWIfq/Nj8Ri5wJJGTtdloC5UpYPdcYftrrjtIjOr
 F3rQjjH3TMRidUvuyhELMNGr1lj80m7HO0OuTKE3JrUorupCgbXQsFHv09xrXmZzmtGwChCNrUD
 VE7iaGSzj/pZf6yXfZMQnkk/t9fNy/skpSNPisR5vE/4gMWrSOSZLzkhlJjlBBD5VmsIBhsksR8
 TG9myzPJA/cQmDOT7Q0J7UQ7ahFXSLKr/23+grvg2en2nabnn38ro4Z//3C+Qxc1zakapB70k4c
 KpGT/ms7QoeBkhmLx+A==
X-Proofpoint-GUID: 5NamkCvmhHYWvAM9NnGT7AtURnLkTHvo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfX0qT3xH/fMNXh
 MiDrRXgj+Ij5gp5YcsJFNpo5hEEmoG5w2Hsjqw0HK4u4ABSs/+u5d4ghzk16qHCPFOV/nTMk/fW
 9ts01RUTovjaupM0zLDPSyhIP1IjA9A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040071
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

We need the GPU to stay awake for this.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index 136029025b80..b993a556a816 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -83,6 +83,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 	scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
 		scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
 			msm_gpu_hw_init(gpu);
+			guard(ifpc_disable)(gpu);
 			show_priv->state = gpu->funcs->gpu_state_get(gpu);
 		}
 	}
-- 
2.56.0

