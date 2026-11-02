Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7486081CCF
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iQAra2AI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZPPwBkNW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C688610F07B;
	Mon,  2 Nov 2026 16:10:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39DF10F04E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:10:07 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2Dp9xA894137
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 16:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=j6Jl9fkeKPAkBraVEg5312er2XpFL9q4OtT
 0Sa3z2xY=; b=iQAra2AIbNq7/30+mFcpeYfq9txDZiWaxZX56k+zgD4aaH3QmtG
 sSyfI9l/UKfP5b35RjEIjVJ31+mbbmtOt0O0Sl83IjDK3H0w/QeIbzqouR+OoC/z
 K9SZ6MhYI2PStZ48RHqM5QXaAtb/a1BLlmnCsYbaQZJJkXOaZfbDPEKrX00mM9OM
 9MaTABy81tXnFraL7zYFxpZhPzJEYBURF/Ywzl7Y6GN2G10yNDzHPe6zeErdw4rk
 xucPoSWltAoPDtIGoF0J3v0fLJkHCoRBN6z/1By1R2nLpqqWmAmWz9b2U9SpGxSj
 t18APwdWBp6wxUQoKRglKZfxxdBys4HJ+Sw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvsrw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 16:10:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e987ec84afso27286745ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793635807; x=1794240607;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j6Jl9fkeKPAkBraVEg5312er2XpFL9q4OtT0Sa3z2xY=;
 b=ZPPwBkNWXNV1vLQhGXVlSwLOIJ6q4SO3LF3iiPgUSTfGN3c3OxNkuvo2insJklCeNl
 Eh7UlKzMyZSgkCMixWhvPk1et34PBW1N2ku3c8di0nECzQEzPnd+haF6XMo3433+QSaV
 EzIZNQInscqcXgT4RFdb+S6UcoIuQr3RKMbwq33hL9y8ty9ZuRg0Pfs1MpWWET+f31v3
 gb2qFB5rT9qR5uqcOLWzgFzD02+scqUrVTGOf5aZoFBXAudbDTPBVUYWT6Hscn07SlHL
 hXzZhkDrVkNI0O3nf2POkT8mCJQU6RoQSDmm8DGuny37DoEAYCdNBz3D/iWdjjH8BdZu
 OaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635807; x=1794240607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j6Jl9fkeKPAkBraVEg5312er2XpFL9q4OtT0Sa3z2xY=;
 b=q/hIfwBPBEfxhwXWysG4YCIzBYydZIGMpVHkZ8vlFj+1qJy8GsTyYAl7bR//WUFDxJ
 Hi5+hLBUebA86hOCULp65LQANDjTjlZBoewhkz3dk9w5FiHL34MByoe/ZajRjiBDKOqM
 ERfGhIFrnByG1joBwN7Cr1d0SEUHnv4FxLGbdss16Hz6SQ9/qwQ2Y5lviCL+/ItLCCHo
 MDw3uvWFcwGfkXG/URzZ2CRNCmpb99G+nezFm1bRKoLXo5PnOGFw7Zyt6YJ8vcgPTQ/y
 7lCyT+9cNyMYcX6DZEAlQZ8fKL7cVhcxuDahCzon3oicgquyH0XBl5A3QP/ADIuwowhJ
 0QqA==
X-Gm-Message-State: APuU4Z8m8BbECC6ExBHQFkL+UAxB7lfJs8dNzSMDqbX3GBLdhhkCdbO3
 AcoAJbHxgbCRq9DoyeXbGpBucvBn/u0WgBbxI5W4H9jtpz9sV67h9TLNxqc3T1kPSwKxOksDgt4
 fJS12DJfFvkyJ1J7dtGxknyzaqnhoN2+HCPlxjxDPTsXiOqq+i7ismZQHNGnCs4ucqij3oruvUz
 56LJPsMQ==
X-Gm-Gg: AYBFou0PLyM4Qtp2vf1bKZtT3ECRT9duFFRD1RtWTLneHSu6wO64hspS1vDzD0G+F7i
 O0e8QNZUwPsDmuA4myXR6U7pUg7Z7dIdaojtJTRjqgYpBja78Sv8ijcBcC+XEVcHAStni19TB4g
 R4qhMxaXRCxbRQu97VNEwi76/6XEVwKfrKTc1X5PqIvK9DmekMUpWT3BrUzP/IHpkk4q3CIcxSh
 AlvIkHJDm8uD7fv3b3moz8/vaONssdn2kP76j6gAkBbBsPoTxnJpz9tM7OwyteKDUV3EL+5ohR3
 OYucSvEcHxLHcM7XgTZ1dGlg4W36IM96dr7Xru2BZqUobMJQ4+7T8mXkXZWOkHnuKOgoaDi28fk
 kYqJtAa3H0bTFHEdVPeZnbqNzi0WglpuenB4eRRJZ7vzDSOyiAfRpMhtDSk+zjCJETryXVn736D
 2t1mQOJo9n40grGh9rM+1TGQ==
X-Received: by 2002:a17:903:3bc8:b0:2dd:c100:4248 with SMTP id
 d9443c01a7336-2eb3647079emr103787465ad.44.1793635806585; 
 Mon, 02 Nov 2026 08:10:06 -0800 (PST)
X-Received: by 2002:a17:903:3bc8:b0:2dd:c100:4248 with SMTP id
 d9443c01a7336-2eb3647079emr103787015ad.44.1793635805968; 
 Mon, 02 Nov 2026 08:10:05 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3928d821sm29672765ad.56.2026.11.02.08.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:10:05 -0800 (PST)
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
Subject: [PATCH v2 0/3] drm/msm/gem: A couple VM_BIND fixes
Date: Mon,  2 Nov 2026 08:09:58 -0800
Message-ID: <20261102161002.497152-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae8b5df cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ygTbR3Ydg0thdFsOExEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: QAokoAirOxiGCJLXvASFCS8C11C1u4q8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX+st6dNcTiSSR
 ouZkViMzR9WLiX6skRn3XI0WimZ4VXCM97kz4CffJBd0D613TN3p610S8A+2gADseLj7zNxI4UD
 FbEOp2S0yKp4VT62DOEC9MU0hSsPS64=
X-Proofpoint-ORIG-GUID: QAokoAirOxiGCJLXvASFCS8C11C1u4q8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX0jpvUGqXCfdo
 6RV7wyf77gaZa3RDZJO8ODAiCXUteKT6pVtgl8QIjYXTChx0hGN01QxV/wluQpT161TFDetPhZm
 JMNDAfzf6MKEyop2FB7lpHOFMI1Ba53oeoYGpa2wYh+AiiNqGDMsj6t/wYweEIUYrDprAHz/R/k
 9oufQ0hrbPy2IBYcFEF8Qu4zYCE+TRtOl0gMWRmZZPfJMkGDJ+3QEU8domDkk6wmhwqX5r6DcGL
 s7G34zzptKDvoGJbTm2fCNzPlu2tVRaH/xXSOZGLat3afcx+bgreVbFVK+u3rcITQYS7nPonVyc
 ZZ9tQfwAyHmsWFTUH1C/9sAXkoAtAaszQdhqxFmyaeFMsyMPRIhHmRXt4ijuG+SDXs9Pkp+DAzR
 fnDP0OPD1C8ssDinO3LbISPsRq5HirEcw3ai9ELuBEhToHd/vaq88k0WHu/gu2WcdvtYTb0UD2J
 Al9JFQcMyejy7YJfQNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020064
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

v2:
- Also check that range/obj_offset are not greater than SIZE_MAX.  It
  doesn't matter currently, but would if an armv7 system ever added
  support for per-process pgtables and VM_BIND.
- Add patch to fix handle-dereference in idr_find() error path
- Link to v1: https://lore.kernel.org/all/20261101174911.25184-1-robin.clark@oss.qualcomm.com/

Rob Clark (3):
  drm/msm/gem: Fix VM_BIND range check
  drm/msm/gem: Disallow nr_bos for VM_BIND contexts
  drm/msm/gem: Decrement loop idx if handle lookup fails

 drivers/gpu/drm/msm/msm_gem_submit.c | 5 ++++-
 drivers/gpu/drm/msm/msm_gem_vma.c    | 7 ++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.56.0

