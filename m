Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62238606D813
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dxqyh/3l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MjRfz1OH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE7410F276;
	Mon,  2 Nov 2026 22:05:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8EDB10E415
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:04:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K6C7m166078
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KTqlhnQMr2N
 CQesTIo4IGBobCa+G+VXCAaqS3tav790=; b=Dxqyh/3l7LZuJED5FqhN1rlwzRI
 LV8tS+19UiXQK4HGEkDEvQskHuQgeXqFWk3O9Rr02nAYWMRLgcnVz9e5n59cCEj0
 A+Tv+9u8eZoz4ak/0GOb9G2MeyfLv5ZRv5y48817eRd5fZpG6G4DzAwxr3csVVqE
 +lDB1PaoTI8LUWdQLDSmPO8spJVKiDxeAvuykFv2B9DhTKWTyNFA406J/R1Bdcza
 eftG/WJSIE2xRJ+8eqYXIU8h1oCePK12OadW36kIG6MW+yeWXv9kJ64+G3K6N844
 NRVXvZ+P/gZvYwnZJIqv78Zi9XBbt5ouXMqslPITMeVEk4K13hxGoz33dqg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrk4hy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:04:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-89ff475a0deso3160925b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657079; x=1794261879;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KTqlhnQMr2NCQesTIo4IGBobCa+G+VXCAaqS3tav790=;
 b=MjRfz1OHwSZQOXvFdroE/atrOP/Fz+OYYZNf8vlC3B0tVOmzVKM/ySgHHo+AHCbWE1
 HOe9aSuiejHMfM/AD4DkI5/ZAmX9B+R0y3DxDVrlEcGnKgvDHqBkWFhlRphhcQN46SbM
 ccl2FY4r2D4sb/B/iKB8K0VdJXgH4GfOvTxtEIfWjaGe2i+25cu4AgpezfG+Zb0IxQMa
 gmNvnRatVQFVqPvoQLz23zihLUwa+Jb6Zzxd8iO0ky1WrUWpIn56PNmwslPxeP0UCV3G
 1vUFaXBaq5wRtwbvKL++1xB44QtHVpGB6kutzZUnDe04DbZoX+iH6P01iw8HfJlt/LBf
 fy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657079; x=1794261879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KTqlhnQMr2NCQesTIo4IGBobCa+G+VXCAaqS3tav790=;
 b=qqGRnGsXTzZC0+jZbMBoRTOOCOba1bPbZU1PfN8Iv9bEtw0abihrhitsp9RPzXOizQ
 v9THzVTKLqkskEO7QCIlowwQYgqjG2FAVkZxl0UaXAnYXWMUG2xq7pn7uV2+MTX0Sbnt
 J0MtJl9K+sN9jujsJit/F1cOsXj/kyJ3/FQ3lqcJJY+YaSKx1j/sPaMyra9yqj/O3q36
 c+GkbM0uHC21xso22CLaL3vi8XpESufVDO3C5/DrT0udfd/hBFEy7HNf/I2Gtua3XZGL
 MndiXDap4u2yLU9MnrfwvKHcuNcUvNTGYGSo9ZBGWqfMc+JZrojArveRuSb1TOBXTgJZ
 //Ww==
X-Gm-Message-State: AFq9FYKi4y3ir25UG70mpaTVOtftjLTgCmWuN+XoHr8n9EkndQHGhDQL
 9XVyKhVicvecpF2fel/jb5SppXI1EnoqyZy/v2E02RTK59vA7hvEkQ8lTYugsb7L8S0pBP6BDN1
 sWWePYYXqKTjw6TAz05H5bcBpCEcSGj8N/68mgvfsgZewZHmFDOQyLrzEgVuF+OBP3YI6que96g
 chqd6zTA==
X-Gm-Gg: AYBFou34fwb8sTzSHh0G9tkybUOWG+fCMY5ev/Uo4lFBBtoviaspEex+o1T6rvNiT1p
 QjkLn9ErUgSAmJGp0zAq7eoqQqYW+qFPjYOBFZOXEyvYrCZK75rwoL0/dxewYhxNNajgtQd620D
 VQo5rgMclIsILwCb0IUDrJs9ZcPh9OEPyf92YW32Odt3efV+oirj8A7UQjUHMsOzWNIjttRbv+M
 qdRm7YkEDnfzNT6PnXtlaw+XgS/LJFequRGtkAg0arYzBMNNkuCcy8B6BpHXnW4HTfQucq5roOr
 hhWz3Il1XKLu5l+bQjvtyqy6YHuW/tFlcOloUa73dOckXzn6ou9m8Cd/jYnn2NfMJEKPSkRyXhS
 jHkxhs3j4Z5gwsG9u96rpfVaMUbbFUAe4zd+uOWlQaLthPaU8fVxUqRbYZiSJwQ2L2/5M4FEZQd
 HYYIhr4lTAz0YZmh6YKwigHA==
X-Received: by 2002:a05:6a20:e212:b0:3dd:85a8:4c57 with SMTP id
 adf61e73a8af0-3e928d43f88mr9437916637.30.1793657078552; 
 Mon, 02 Nov 2026 14:04:38 -0800 (PST)
X-Received: by 2002:a05:6a20:e212:b0:3dd:85a8:4c57 with SMTP id
 adf61e73a8af0-3e928d43f88mr9437894637.30.1793657078108; 
 Mon, 02 Nov 2026 14:04:38 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb36488892sm380786a12.19.2026.11.02.14.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:04:36 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 09/15] drm/msm/adreno: add temporary __maybe_unused
Date: Mon,  2 Nov 2026 14:02:53 -0800
Message-ID: <20261102220405.30730-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae908f7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: S16QS8hTdI_MGEuozWMzC66-RUskCGo_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfXxtJTSfdkXv8v
 QFb3+5W7yxNFaTqYGW0pB6AbNGC5jnnBijXPX/6UqlSO74FCljETiFAnIYv4QzccS9WmoG4IM0v
 RNcbaQOmJVZyhik/6JxyMXjcoDvlPVo=
X-Proofpoint-ORIG-GUID: S16QS8hTdI_MGEuozWMzC66-RUskCGo_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfXwjsKU+nJgVEs
 iaJg3thHnOjWK/37vroJTI/sEpqNpwopMml1rowBn0F9B+aJU6W8U8KQPUXb1vVXOvgVeX0iZ3p
 sKDDUsJgWgE7ZBpCS4zyS0DXPfZ4CzY3dF3wMv6nriYQQ0n5yFAPdTPmSkgUUypIw0/2dWz3g10
 jxBOX5tQQFmWbiMy54/Uta6R4ZeygbJ8JPQIuLqBVkVEVMsQwdNJZLmdOVvkv0etNwKFuxB86ZL
 HstXfK+41EGkfMPjKX/obNMxSwm7sOtZfSGyTiyUK7LUxsTqesYX5wPbRSJV4ugHsQvMfi9YaMp
 Pk5v9VTHHnrqBfXAxVMM0ut0N0bUumOviz0AsWxeUIn9U7I8vq+XaQaxWP1sDIJPMxVfi3IFTCU
 iFJKGSk5fv8IkA5VDm/y58dJ5/LGUfByAOo75ANxFTPkzr22NL3nMzFStY47UlBRNCHnp3lFUWz
 Yu8Hq41bEzqiCSEFC3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020087
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

To keep this series bisectable.  This will be removed once there maybe-
unused protect tables are gone.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 6d6e4c7cf919..c43efb85fde7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -168,7 +168,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name = {		\
+static const struct adreno_protect name __maybe_unused = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

