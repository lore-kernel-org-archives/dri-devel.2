Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89312606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WlaZpbf6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KCeb07P2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D2210E3F0;
	Sun,  1 Nov 2026 17:49:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D1010E179
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 17:49:20 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1HQ7Mh2420994
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 17:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=eRBBLyXgoGNjOAAFhgT9ln3GRWnTRQ+4p63
 Ap4PYjlo=; b=WlaZpbf6sr3Qw7oY+kmmDcq4qX9PRr85c2F3YM1ihxFYiqvnNgE
 vS9x9eIeOogeRzMeuAIXCTJppwmxoGPrtmPsWITWiz9U8GY7JiPsJAVN4S0/bo45
 ZwugHRhdaR+fLT1wW40qR0Nz65W+E7riGeuGqG+uPDrwBtLPRzRlYK4IUVVau0OP
 IKfjWM9ot9vCGvyPMSno7GC+Qv475egI5DJM5/YwUnTrlGvPrPEV7+Wms0lhqchK
 NaDq9aEd2mgIGYvXOrG/YIWAzzA8lT2oSO4kSIKhjagvtuLgIhu55bPy1xa9q2iZ
 VTsybV5vOoTMx4fe0IPCiQs3XNmNMmAH5mQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn61fv65b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 17:49:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cdaf2a74482so1195567a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 09:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793555359; x=1794160159;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eRBBLyXgoGNjOAAFhgT9ln3GRWnTRQ+4p63Ap4PYjlo=;
 b=KCeb07P2TL8VNkyEhDgt+LAzoEem2QJ9nh6+GAxVYA9bugiZ7tEjwrPcqMnG8hVGAo
 43am+DmVq6H+QU+XW9gzYpDeZjYxBvqiLq4dCH1BdwNsAJUNI8h6M4O/TgC6kdftVMwZ
 +7Q/QQcQ62VAqTgrBsE8+O49Gv2B14CFtMWTnS879oQsPhhCv1Xe5HNEmasFb9C5TbAH
 bFNYZgQqJ9qTMu2KNEUqpU6dh0z5pgyzTOJkmHE7LuhtZWgFEBHr0/bZpiMBk+X14FEg
 YYDc2pXwSZ8QHaXypt/5wHDcWmgniqrl8CAjgZMr6oJWOJXbD5d1l4n/oOwv5cOApbbm
 eitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793555359; x=1794160159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eRBBLyXgoGNjOAAFhgT9ln3GRWnTRQ+4p63Ap4PYjlo=;
 b=k4MkwMP6Hkgz+MoJrxW53Aef6iFVqLcsZrr3swTNI/LMjOdwjuOmaaB1hlr99De1GS
 +n18UO8kr+AlM8Mfl+c7DCnGaJNgPBoztEF4XFSfUivAvd/qqc8RsPxqDGOm+U2wfDnN
 oLwFoE8YBK3q1OnrJocTKgvjGa5lFUIWap3uJ/+my1p3Sn+PtgMU7BuUq0BXEGtJrzTf
 seAzGNETz6BeJtGJGJVGYJ56WnhXbCc8+j4B7sqU4KJYayxv2viyHRO+WFOEyr+L/Nus
 wFqRJomZGRLy9UU6wFBP08dPTQJvzv1BBOcWqpgMUNhRwMdAMD8jGhrFMsycBu6JycIr
 +0og==
X-Gm-Message-State: APuU4Z+kJPSO5NCUDsJTDwc7sDgGmOAJgtNCNfWhA1/SrfhJkIGQYmM8
 yVszwv5g27TNUO5FM+jNmf6lj0ykvdeeHVLQtQ0HNoy/Vy1vcElFvFD4j4qHnDA5zqZKea8rkj0
 r1oCzwzo3Wb9FANq+vWzZGTvYMQhWDcFH4ygCstBh2GFWrGaSWJY1AUbAdUm4ZVXahEIpGlD7XW
 Fg93zOvg==
X-Gm-Gg: AYBFou2OMsK7eAITehffcfrdfXfDc82VWwhSERGLf3TFqfzNibxCYGbE08hS0sdw/aE
 GtqWH1PNUBYR3MVg9iQfsFJVt1pdNPgcKk3CbWknP+dvQFYj036YWe8DhXxWVcBSRqDcDDXEydR
 7fOL/7tTwXZd/JNrLVKSM5iIms9jjvd6qdxvdQrLaQ6ivYAFjTX7j+7gzhtD6o4G4jOCgbE3kSz
 s8IkXa2rrSIQdVfxoe5DX6xoedmM7aVUM1RXZ/0TZPFIdKgWAtk2baHdKD+Qfk1pTEz07RvK7wQ
 LFFTGDaFBPrVnppmANegYzCTootLqmWw14d2mFFKMMfQosZMdEp8SXbPs/BJ7up1uB5eeI/XXAD
 gRaXyLN8ij2ZphQxFwdtj9ZNuKEQoWIjFw+0LykpP1LrOFoMYrRdKok5UBefsPqDKcDuOl1GLtC
 D9BLlwzwsIuDxm8ZcVBMoCbmI=
X-Received: by 2002:a17:90a:fc4b:b0:3ab:b64:5893 with SMTP id
 98e67ed59e1d1-3ae8981bf35mr5877686a91.53.1793555359296; 
 Sun, 01 Nov 2026 09:49:19 -0800 (PST)
X-Received: by 2002:a17:90a:fc4b:b0:3ab:b64:5893 with SMTP id
 98e67ed59e1d1-3ae8981bf35mr5877667a91.53.1793555358863; 
 Sun, 01 Nov 2026 09:49:18 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e7d5b8csm15640105a91.1.2026.11.01.09.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 09:49:18 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/2] drm/msm/gem: A couple VM_BIND fixes
Date: Sun,  1 Nov 2026 09:49:08 -0800
Message-ID: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX6V2FQGgq6aJr
 Q1YRjTW7Jv6DE3UVGBoyuccASk5OMuvssutXJm1q9DKcKpxnjBIZljmgeGj+FvVEmafRw/TCRgE
 kDg/UopZAZhpZmxvRooFEyak4TgqJLc=
X-Authority-Analysis: v=2.4 cv=V/LoQuni c=1 sm=1 tr=0 ts=6ae77ba0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=Q19NxXnSNVhgB1yMlDAA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: FVBhKYZyZ5HloDVf3EdX1mBtnwJPCXjm
X-Proofpoint-ORIG-GUID: FVBhKYZyZ5HloDVf3EdX1mBtnwJPCXjm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX06BxlubdFL8U
 sK3NLkxwaIkEWas4KyKtNybLdC8786inS4Gna32gbalgzI0UEMpQ5Gf84oDdQaRFprhUsV/1eSX
 ZQn2UFg33XluAKjh+JJOiZxQiuEaeCRJuWK7Xferx4mOW0rTaq5rp+11qXWX6oswmmeplbJpmOk
 iGusdJczR0htbn/lJrKkNQ5rtZZLGtcfxyGW3xbMSA1GtAy1mCVvp1TQJx0nZz/S4rxryuUg6QW
 5DVJZzgNB+xFJnlxUzpXWAwqxDi75HVHrrRWBHBXRycdczmRZo8w6ecGqXN+ZEH4B3d1202wE2X
 53zmLw0jxYn7gG5Q1DR9a4n1R63VXUr8KLsLEiU52GezDpTVxXbAxhzZg4Xe9KfRa0Vu6J1pQvR
 Df8YzAuLnGmwDOB+IJYQKCUTUTbtzLq256SLwc6Q/M3jQQpwJWlp06zCeAQKXK509VG+DFTNerX
 8cFUvO7u+ZZq3WmzXng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix possible overflow in range check, and disallow passing BOs table to
GEM_SUBMIT for VM_BIND contexts.

Rob Clark (2):
  drm/msm/gem: Fix VM_BIND range check
  drm/msm/gem: Disallow nr_bos for VM_BIND contexts

 drivers/gpu/drm/msm/msm_gem_submit.c | 5 ++++-
 drivers/gpu/drm/msm/msm_gem_vma.c    | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.56.0

