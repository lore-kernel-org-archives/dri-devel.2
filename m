Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05E606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GqWo8qaZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K9CqLRKX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23905112D15;
	Fri, 27 Nov 2026 19:45:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44CF10E816
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:56 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJB0aL3134356
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FGme04KE8YTGTv4q91+XAorU6TR68+yXxNUbdjuMex4=; b=GqWo8qaZYfn4yRQA
 0SGjzcI3zqE5FZRaIi9toF/tPFki3DTmO0n9y2R9mdUJdIN+/DqK/5i+pbC0bpt1
 aiYdJC2pHzgvjLn4Ujt9xWiuf5BFtUy0BwO/J9gLKYG00E8secfmx7qXN2ZnFbPh
 syj1WHCTw7hHlWWAIShpt4X6UmVU09TV6FULTeId8qMzMIG3O0QV8hWJJVcTUzb+
 A/fxKLTeOHxxtA+fGQu9zovUjCTQ/1vZp0asLlamNPMHl/kd5nsjabrdeJ0pUP9c
 dnLRCLQ8p1Smkzl4zDbyK6g6FPJLZRU0yc8MpaKG/76vSjt5lRQnHzwvE7C1Et2D
 e7LllQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gatrsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:55 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9210a12765eso123934576d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808695; x=1796413495;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FGme04KE8YTGTv4q91+XAorU6TR68+yXxNUbdjuMex4=;
 b=K9CqLRKXRuxjOnj1Gww+zAvUDlyR/EoafDLJN4tJOyB9m6QMgC8jylCWi8OvKIVJO1
 VGJqS+vZ4qez1cAnT04f8OcAUhd1sGJfP+tnCWAmObJMgKe272XO5wOy9Dah1ggRC3XP
 DtBl/haaToOlHWys1fSW1tG61KRk/LAAdaldG+fniXHAOtjwxl6Ev4XT2guofDXR3+xp
 bmr0Xf+CrFZozMVJKI3hwehrStbbW3wIZU027rkPA5uw3lzdB9/ZqE11zi//JgjomG03
 WG9z8HQMRaRBk9R0hAndDC9k3gOtd7E8HOhyJjUrDyXECa2BtbP6jTUlYfPCskdhvMuZ
 EAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808695; x=1796413495;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FGme04KE8YTGTv4q91+XAorU6TR68+yXxNUbdjuMex4=;
 b=RwXhN+xonGTmW5ENVI8/Zb42nIPrl4RY15fEPIY70GV5xWOtPdE9VjWdCcYIza03Yu
 SRA27OXX4SR+WZXTMqwuxw3P9rLylDICqxl+DtUv6X1qjwo+cSaamZMkEHm2InthPiwZ
 u6lUoD8K+teZA1/jScajQUKIz7jA9gBzU2TuBepFN075mpUlRX11QPLNAIc4//pIMssT
 lD+NTay8h0rbtCsud+X5uoPiocoS6Gh7VJql2O9LR00huKZQhRvTlyz4asmQ6Bl2An8r
 tNU3e4Zg4w8Jnxi7U7/7u3AuIZweQdYQYhJP8t1hlqwGxJD/G/GMMAJkecw7alWk1S7G
 5wDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGGig5h0dn8JeMzwcpChrIWxXbbcM0T/S+rMgahBWtmDuoKu6rx3T6+vhtm+nXCtgK3r3aYjyCJ25A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Nf9//rAxBChrDPFWHLCGrDXt0XwvIr+T6FcDtBBurV81ZARAe
 1sdYGGiYByhEsh7UOtImhmarzncAFXjOvaYKNyN9lL93EsqBUNPSLdon+frYc9rhMSlbUD2j/dw
 0jubrWy7t2k04a1Kp87EmXY2inOP8ucWnggaBHxD9kJkC9sTcIVKDCltKUtsGxrh0rS9X0Q4=
X-Gm-Gg: AZFdTZfQeLnOFUI4LzNv7pv7uPG7+8HN0VP1Q/a6phQCq2O08Rgk+JzosZY1yeZEsNw
 f60PzBKT1hI4uU84egzfwjXd1vNJ5euqojtF8XaTmokbcy37Qz+XDy0QXL3DwrXZnAHXInlfCXZ
 eFiPB3e6/9KI2+YiR2dsMptDk+io46ghe+kuaW3FvEfhixKrJXG9qpwpQiGbfAQUs/TikJUVvsb
 KI1ovMrxQZ+hc0ojazw5GAFSBUyZ42FKnTa3o4Gwk71KmZwGivjO+/PgVQfrthqyWwU4MhjSK9M
 vW+CYH+EGIVoVacsiN5yA5/s/zaWxpUoLT3OCSQc171qCFVxwDknqUXLs2s28y3e86hCd9HEfLt
 3SPa0w7SIXQ5zZDqO4rYYjH6fE3YkaDBKZOlAuONc/gVlBxNyCOZ5OX3ZF8OL8mEOWQqhtb7Ap+
 hGTrot+rZaqWc0ygqSLTsvl/P+vcUdYpc5RhvokQUp9Kydxz3PDO90H3Za4Wd+ww==
X-Received: by 2002:a05:6214:b61:b0:921:84c5:8faf with SMTP id
 6a1803df08f44-92184c59c32mr147407066d6.12.1795808695148; 
 Fri, 27 Nov 2026 11:44:55 -0800 (PST)
X-Received: by 2002:a05:6214:b61:b0:921:84c5:8faf with SMTP id
 6a1803df08f44-92184c59c32mr147406666d6.12.1795808694624; 
 Fri, 27 Nov 2026 11:44:54 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:44:52 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:15 +0200
Subject: [PATCH v4 02/14] drm/msm/mdp5: forget the hardware blocks of a
 previous bind
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-2-242b0a3f8e47@oss.qualcomm.com>
References: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
In-Reply-To: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=zt/mVP+EEls9bu9ax6mLMV+QrjhwVDSTay40Fi0xlRU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2Y+qlOF2bzSiezhCw069vw/eQH7bU0nBtXb
 AWxGWeVFz+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndmAAKCRCLPIo+Aiko
 1b9UCACQSy/DTtE548PmRXUW+SXe3vPi2keoae+ZS4SBpoX0+8poK9Clb28LyQzXIJar2a4B3uH
 82h77UBdOwSvfxROtGqpfdknQ7K9OrpIE4lbaucTHfViwQiUbw3IrYHADdWN/OLxGyYLK4GwjgB
 VylpcyrCWHJ059utiHpLgwPbIeH4SC/KDqCZKiw5yiC7rzXFNFcrEP2XcuhLQt5RJO6M7aTp/0z
 JCcLIXc1Wb20zcSUaQ9OmI7192M9HvcsbuVTVixd9RBSTEbEd/K72ASYbYpezLtEGuoX+AL2g3K
 D53zUDWmXrrMulkvfkV7u6/WQPggz75QGa3c/rOvyD9DmkQC
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: CksDFpE8T_gyG7i0uycGfW-mONGWaPFn
X-Proofpoint-GUID: CksDFpE8T_gyG7i0uycGfW-mONGWaPFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX84KbUmt0PCRV
 VMWYYIwakTstg2u2GeF/RdkOKOa2cIQHrKt6XqvnBeP92m/3EFwB3gqB7HLi6zYhD1x7R+fKKBP
 2f642roASeC0TvCZxCDVDfukWNvbUuLTSSLRDFfOoVtrd8k+GXOXhTt+YSuMhAjJuzCTvWGWUa3
 VcFarjcqGkPAx0if+l2LOeBf41WfIM21OoZ40lhOeTkCTR5UFNl4mKP66Nmr9mJqHuK37A3crmt
 qvN29b5BTz1eA3e4ya2iNNfc4QnIZ/GYeBxbrtsee5PCJNaa8dTIOwLzx81xOZVBFvoC5NrehQ0
 Rgr0KQ4bGsw7y46V5jIDmtmvRy+/hDi6xJi05OFTqggBTjz34ufxg26hyKcydVYjLp2H5+N+lTA
 Pp78NAYCd5QzAuATp2KFO2894KkRELA2bWYHyKJVIb9foz1+qsm1o4qxY5I+LoE6Ogb0WalcxQD
 LMeF+W9Nnp9FIOfWLKQ==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b09ddb7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=X8-H6Saci9yJdrauny8A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX/vyjAt+8wA3L
 ZWYHMUeRti5PzuGlwNHRbDvKh0butbrPXrJJE8mEwomJEaHi9mABP8vpLqgHNV5OAdMjpxbAjBn
 cHdk84z0KMntw7GiDSR1mlMos/uJedo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270078
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

Binding the MDP5 driver again, after an unbind or after a failed bind,
corrupts struct mdp5_kms. On DB820c, binding it after a failed bind
oopses in hwmixer_init():

  Unable to handle kernel paging request at virtual address ffff0004d411f9d8
  pc : mdp5_kms_init+0x264/0x7f8

Since mdp5_kms is allocated in mdp5_dev_probe(), it outlives the bind,
but hwpipe_init(), hwmixer_init() and interface_init() still run on
each bind and append to the hwpipes[], hwmixers[] and intfs[] arrays
without resetting their counts. The second bind writes past the end of
hwpipes[] into the fields which follow it.

Reset the counts when the hardware blocks are torn down. The blocks
themselves are devm-allocated on the MDP5 device on each bind and are
only freed when it is unbound; that leak is left for a separate change.

Fixes: 1f50db2f3e1e ("drm/msm/mdp5: move resource allocation to the _probe function")
Assisted-by: LLM
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 3934cd060b27..085c23820f46 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -570,6 +570,10 @@ static void mdp5_destroy(struct mdp5_kms *mdp5_kms)
 		pm_runtime_disable(&mdp5_kms->pdev->dev);
 
 	drm_atomic_private_obj_fini(&mdp5_kms->glob_state);
+
+	mdp5_kms->num_hwpipes = 0;
+	mdp5_kms->num_hwmixers = 0;
+	mdp5_kms->num_intfs = 0;
 }
 
 static int construct_pipes(struct mdp5_kms *mdp5_kms, int cnt,

-- 
2.47.3

