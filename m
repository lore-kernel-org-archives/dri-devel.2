Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A9606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Uxgz6/6p;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EyyGutlj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6233D1123EE;
	Fri, 27 Nov 2026 07:21:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A396112341
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:21:06 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR7GOOs1779899
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=N3VLZRTg7atUql7jaIGh5aZOxd3g/n+lT3J
 7hkQbOcA=; b=Uxgz6/6pnNeKE67TDKi364JDz/B+3zojGUUYDXMGM2XQxJXf6IU
 CMa/C3fHW4w5Qs6peXQMgZP/CbNKI85e1jnpBwx94OCnOGNigvfs/Cqs+2YRlSgH
 e5KPlbXfI/Qaoohu8nygcMOftwiocECvRhc/Fj9DN1Qz0XBz/CvqPiNLliyRUzDd
 wYKlBSj87DMD0M6Z8biq/f0oXISh/n+T+bTpaP91GyGxvJEv7lwKlwkWln8JNEjl
 YDRJx+8SL1FEEdhotWQOcHMOc40TN3xknZlab0mmPGgU3rRIDRtk+bH+pIqyy0T0
 M3ZDQmxrxaEs2rSqVEa54tkBQUDNzTq5ymw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhgc1p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:21:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8b691cf0eeaso8906986b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 23:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795764065; x=1796368865;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N3VLZRTg7atUql7jaIGh5aZOxd3g/n+lT3J7hkQbOcA=;
 b=EyyGutljY/7WNhhwxVh4OR3nGnkcWGtdi/AtzYmMiFoXXnCFWK3+UDVlG6a1APlwez
 XQBCW60z906QNn9BG4nmH42Yki8dsIls6JdnBK5/s7WbQDwGEgeemvaXgonSBmCUgehz
 28HxuGx8cvvEwQvn4GCtEKi72nPFDOms7f4v/1enej5iBsX7TRXFgfw7nW/utp4c14i8
 p3B88dw3LePjA5X2BOhXJVlcm2Wy7TZ5TRGZupZitiZ6yC91nxlUDaVomE85cf3NS9ch
 pV60MnXnlrbTXJxWjJ7tmdzfUAdLPukN+/C68ipdghSS77o+yVBjxnHy7PCpMTWg6EX4
 QByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795764065; x=1796368865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N3VLZRTg7atUql7jaIGh5aZOxd3g/n+lT3J7hkQbOcA=;
 b=KrWfispXkglfyoHmGtbMrZRKxMJKkLaHGwinILTUpJodBQHlHo4n2Pc6Yr65llpcty
 1zExxbvmIbjfUO6ChDI2YnkpyQey+d6j/GHrdTi80vkq+8mEnMmS19Zed/x8U1kA/4I+
 snh77hOE7uTtyHI+nSAvXqae/6d+vyuCXax80GK7mjxC8cCQz1M/tpd6p+8PL4dejIs1
 NYsZDJo4lIuSGTyiMCexC/AlfHE9r+QpBr5Dqd2bCd5DpRiY13zI+tDVCRqpVZu4XdYg
 U88oSrRXizWC5Ix0k0cmViW+X6WI2ATqkqXmc7CQeVFWmKoRvjRwDISwGr2UE7MmppkU
 Zlgw==
X-Forwarded-Encrypted: i=1;
 AL+hErHexh762wAXguWvfX3p13apMPBr6cnUhCHrJqYohaSkicbcarmgH2WbUEbqMgWN37sJVxUU73rZ7fw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/5CYgm5Dve9YkjXtRWSXOMurBLUBSWHK1+iFRWiuLN6DD6rEa6
 x6AOtQfq4EGmN1+3FMtV/3qMe255KNCQTVASgtmjOo27d5XUmFk7F1IPgzJ3FFpnQ0yk0yIVE7f
 gzH5NpWzr4SMvaNV7KsWrmDXPRQy/IhsNrNqMrMIrl7ncNB0ZLlYTx6+BrSLJOVURE9Kk0qs=
X-Gm-Gg: AZFdTZek5V4SszFCvDXEOWPH5l7gJK1vT8hzRYf+ak740YDgvEPhnDVCodyNbUloor3
 grU8Ab2xJXGG7GN7KxFS+mrAGDEDMo3aaSrmyIImG0+Lmp7cZqkGUok05wkhm4oIavuOmIRNTNJ
 FqRX08wCrgmLqSrutOH6UKwxBxh2LmivdH54P8g0EHa2qtr+S9WPT+8lmvSS8JIR3rYCN+7aJfP
 +GfFAXKMUac5nvYtAkw9ryv3bqZGPiE1A9mJj367RXocqfCtVQ+WVmlRc2v5WgdM81X57avjxE3
 4Rn/XpFB63QVa3nVC/3pMgXuHAf3ahbuVZyVJ6UNbWm2aAFWLS5L23KkotBKHzmPfs6Sy1mVnvX
 yjUGrM1DRetm9O6BHgnR/9+TUvzdGaDXedVFfUnH6VLAg6/F1l7TNrXad7oUCBQRGEaVjHcg0rQ
 ==
X-Received: by 2002:a05:6a00:39a6:b0:89e:f8e9:205f with SMTP id
 d2e1a72fcca58-8c87c76a3d2mr22911775b3a.32.1795764065168; 
 Thu, 26 Nov 2026 23:21:05 -0800 (PST)
X-Received: by 2002:a05:6a00:39a6:b0:89e:f8e9:205f with SMTP id
 d2e1a72fcca58-8c87c76a3d2mr22911748b3a.32.1795764064687; 
 Thu, 26 Nov 2026 23:21:04 -0800 (PST)
Received: from hu-vnama-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87343f83dsm12028947b3a.39.2026.11.26.23.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 23:21:04 -0800 (PST)
From: naidu nama <naidu.nama@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: naidu nama <naidu.nama@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, quic_riteshk@quicinc.com,
 quic_vproddut@quicinc.com, quic_mkuntuma@quicinc.com,
 mahadevan.p@oss.qualcomm.com, saurabh.anand@oss.qualcomm.com,
 yongxing.mou@oss.qualcomm.com
Subject: [PATCH] drm/msm/dp: Skip IRQ_HPD handling when PHY is off
Date: Fri, 27 Nov 2026 12:50:52 +0530
Message-ID: <20261127072055.2144407-1-naidu.nama@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAyOSBTYWx0ZWRfX9y3sfZ05RCvd
 5UQpb5b+pNm/rrI3OtyiY02J0jLhNSg9GPHnZjW8CJ1Yrl4itss/kCw50cuf/vcBopUbeQHc584
 YnGhwRn7zBvFxwgjuN+niWeKFeXUFBM=
X-Proofpoint-ORIG-GUID: f_UnWuP1j0TJf1Y88-G1MQKECgdfgllw
X-Proofpoint-GUID: f_UnWuP1j0TJf1Y88-G1MQKECgdfgllw
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b092f61 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=oFY2QqT7UXJjKgy5amEA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAyOSBTYWx0ZWRfX0G9jw27OY1oF
 RnmzUtiJrhrETDZeJwC/Ac5vnGa7M+BTXw2c+UoJluW4cAIah9K2hJM/YMb3DQ5jYQkiUaajdQn
 gbFY1BTli7LdOQrMuYfWzLGFJTlX/BwtiLZyeW6Zx1Rcuqrt498gKfnCJcnEWycWW/3oa/9vmyq
 AzJey0cwdvJAf764I6J89BhOfMs4bhE3XgnA7q899FWqvN3BLq1wugQnRoBa1DMMsM+/wjmvPre
 DEhiDOh1i/m9gQEaF5EFJRnzhwk8TcWxv0aLr4CQ+dFe9vAR1scfNfYQ+o2rcDGUlYwg0ViGeyc
 68BeZWfJXtNeeIRdGD8wD8HhRoZRl9pysisfWTLzflcs1zxvqbPKYWsieTRWte8KPberS2zWymu
 4iEKj6bP3EFlEcvhwp6e30mnLpiy37J1TFEnTtPkfeRSaeBaZynJ4IF/V41b1k60oLC9Cg2w2VI
 3Vnoi1ZrLB9jueVx0mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270029
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

When DP is plugged, IRQ_HPD is delivered when PHY is in uninitialized
state, In this case avoid runtime-resuming the controller and
attempting AUX access for an already-plugged, while the
PHY is uninitialized state.

Signed-off-by: naidu nama <naidu.nama@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c0c150e2c575..79169c1f95a5 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1607,6 +1607,11 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 	struct msm_dp_display_private *dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 	u32 hpd_link_status = 0;
 
+	if (dp->plugged && !dp->phy_initialized) {
+		drm_dbg_dp(dp->drm_dev, "skipping IRQ_HPD in an inactive state\n");
+		return;
+	}
+
 	if (pm_runtime_resume_and_get(&msm_dp_display->pdev->dev)) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
 		return;
-- 
2.43.0

