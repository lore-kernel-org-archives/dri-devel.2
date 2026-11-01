Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051A606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XKPtJDu8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GtwNQBy8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB4E10E35D;
	Sun,  1 Nov 2026 17:47:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8303210E35D
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 17:47:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1HQNOE2465758
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 17:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Mvo7MCBtKan
 n098aYa75VWbgfs1Qzr3HITJBdPK6Xtc=; b=XKPtJDu8wpATNUaHOSrcLWKHRrX
 GG9UFCnkz+yZgT4HBYLpojmQUl3SaVFwbTsH/SXX4W18qi+4YnYgbIIEOlEiLpjU
 LbtwPlkg/etINSgUgklmHMepSBlIlTjyFMADs8NAnSdMkElLcnljWzaBM1xmS4kN
 MF4yY82vsZfAjNXfLlDDIDvjc/OPSF+vtwkVk6IGleDw7bAWwRWc95ckx0hpIzYL
 4R2ZbsB4m4SY1FAY/MvlVXIVvvp2voWMqAere053sIpcwPcpENLZALsQHvCOBPi1
 CiG1mBQrSby6qFREvBJ1bYez0AQGjNAqJ5Xw6TnRRfywxj0DkYmw1VAbnpw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn79rv029-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 17:47:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3adad90c894so2514052a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 09:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793555220; x=1794160020;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mvo7MCBtKann098aYa75VWbgfs1Qzr3HITJBdPK6Xtc=;
 b=GtwNQBy8YN3OYH5m2bcnLWDvebnnLBaEhGbpauHREs9mhS0VWtvnJt+0rEr3MRQS8W
 30H0H6wewk9NpzJjtaUd7KvLm1IpuT2wOBvXYehYHqkFeLHhHkscIbZZYZQnjUlM2K9p
 RY9dN07FS3Cq1N5YaqNsQMloOkBMwGV0kd2uFpujLAAl8T9ZQ9ixASKmN7dmSnWdQYKK
 S5f0VIGwAb8q+HDUx+tBNEGLZ0Ik+3xjtB9CqANig0YLNtrCCo6dddUnhJsPxuYaf2x0
 nQlu/jS6/i17bD4vwPrGOLaMNeSldXSaHAIF1LnDopKVvDR8YtvEgdWC01y22VXJP6B8
 HQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793555220; x=1794160020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mvo7MCBtKann098aYa75VWbgfs1Qzr3HITJBdPK6Xtc=;
 b=O6CFjZ6Ix49z6Nvb2jop6LNXmynH0/KfwtayAUi89VHYZrQxo6drXj1anqqdbD7Qii
 HYCGWL4IOitbh9sfjmka0gzMnUyIE0x41YOyPQDivGD2Ylg8bEHpMzi36Dhta+9jFW9i
 WzZFbxNec84/T6ENOW+UrJY5e7hBmLVoIApTs+34W+TRviF8YoS1WyriQuz4/aucsMcB
 wD0LhdZ5QzlM5LT3vBdTJSbZSZUYKhKz/X1A+PpBlUo9fgJAmvqEnfiRo2WhPLd+gn8F
 LY5VJsGULS9ClHvxMhEQPfTxENT/0q6W3C9Ic8uRKUY6AQfkMoBg7lDxnxPFW8nublb2
 /KAQ==
X-Gm-Message-State: APuU4Z+anSDSEEEQDGatzdZFdsDXoHLr9dppxms7MHOAigPgRRc2esc+
 wr9/WdbwckaVQKWPLz75rto+fOQAgG/W7T+JMhd1k+qhd/55b7gF9ip6yoy+Gw2nnQHg2d+et+g
 S+P9bJM73574iu1lQEHNp0vWRd/o83g9BKp72ASmW4ui1W3kAQqi/wxQhCLfS8sYdtbF/W2emxr
 xpfYKGqg==
X-Gm-Gg: AYBFou22RYaeTOWPy3GqFunV01UDz43M3iWXfB9ymtfq05C6uFhwvsUfH1m1RJP9MKz
 A41eteBAYG45+OkuXQm4pzzYPhnQBIiJ+ss6WjGaq9QsjnMVce6QCUQLUEGOFHVHK02l/gYDi0o
 ZmGuMgzr8Nlj8Hf17E7Xskugd7X2EEfo/a7n8KGkKTmiAJ4Z1Tshb33ZOSkRin6Uf3r0ElW+qe8
 pzGPgQkghv7tTmMjBp1kh8byxNwavCaqsLqbB5KRWDSoIQOHIcYDF9fBpK4V6tuiq9sd6RUhxcF
 aalncZwUU8BX8SDG1xxKCwRiOYUb7MFwvMZ+lCD/XO0zOU3ENzJCmcEG/gdyWK8vcy+zhDJudbN
 RjBMEd5aI54Wc8I3ZMHYsHvBUtyYLb3hXZVveOO20jGyPPtN1mPwrRAeouPYP+YYLvB8ud/duhD
 PgDDFdSTAz2O6pS0Bu54n0pA==
X-Received: by 2002:a17:90b:55c5:b0:3a4:ad5c:d48a with SMTP id
 98e67ed59e1d1-3ae8987e75dmr7095221a91.67.1793555220370; 
 Sun, 01 Nov 2026 09:47:00 -0800 (PST)
X-Received: by 2002:a17:90b:55c5:b0:3a4:ad5c:d48a with SMTP id
 98e67ed59e1d1-3ae8987e75dmr7095205a91.67.1793555219884; 
 Sun, 01 Nov 2026 09:46:59 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae8441a5ecsm10839408a91.2.2026.11.01.09.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 09:46:59 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] drm/msm: Inhibit IFPC for state snapshot
Date: Sun,  1 Nov 2026 09:46:28 -0800
Message-ID: <20261101174631.23637-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
References: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vC6YmQ-E0Pd9PwJO-DmeFRhWs3wqRuwp
X-Authority-Analysis: v=2.4 cv=Wtq+otfv c=1 sm=1 tr=0 ts=6ae77b14 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=jgQnFmZX3A3noQDnNKkA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX2iCgbcgtNZ+t
 S25sEcJNSQhC6Cm7bBZxpqlbEcbwr3OPbcjLN2kVrDsoLzO/7R4ce8YB2nvnTmtzaN0Ko6u03zl
 VzF7lS9hcNqHgmpCiPoIeVQigKeXkJQ=
X-Proofpoint-GUID: vC6YmQ-E0Pd9PwJO-DmeFRhWs3wqRuwp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfXy1tAVA5HsPQ8
 QeBCZSQdMi/dYXBtNEb3keliXnDJL66nFfeTp8nGG+3KdjQzBAX+vKxBaSoqbjnAgVIZ2gimFQN
 k0sYA4J83q5LJJwqEcLxSAgNce6EF+4RzQXLDMKQ38lCMlxecohL1lN3Ubg0rN0mCH6a3ozx9jn
 DOpU6hy1EOog79vZgD3Th1tzlbKR4nbJobUYBNI1ncN+cpqU2NveMOeS1Xxt0jUf8E10IXSnzYr
 TApanonPGB+4aXvDeKiHIkbFFRmHralAQ7X61HV7h3EJuwJtFoiRCOIXfmeuZ0VPgDj2NcNcE3y
 AzUVS5DMsfda2wSOU1hVFnOT5VTGfrE6wrGP4D8KsmmnV8wFMeiYp1hbSFYOayyHd7HHOBGWmfA
 76m2laIT9Dz4JBTpmWJxNkBok2agFPciVLr+UKevDcJSsvoTpBrmatt3xJWzNev383/3sMUWOtY
 XolyQuNN18f2xWtE9HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010070
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
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index b0ddc02f67b5..224401b4ab12 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -81,6 +81,8 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
+		guard(ifpc_disable)(gpu);
+
 		scoped_cond_guard (mutex_intr, return PTR_ERR(scope.lock), &gpu->lock) {
 			msm_gpu_hw_init(gpu);
 			show_priv->state = gpu->funcs->gpu_state_get(gpu);
-- 
2.56.0

