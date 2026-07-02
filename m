Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09030C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A23C10E29E;
	Thu,  2 Jul 2026 02:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OFfJ0o1f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="elNml9Uj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D0B10E29E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 02:22:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621Keog3047884
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 02:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=WuJiALMC/BGgUNf5qTrrae
 7IiC6Qqo1y/5Q35LNS3FM=; b=OFfJ0o1fNPdox08dfjsyHo7ZgIA2iIMIX3hTR/
 t1xpdTN8Z0FD3Tm5caJs+CRwmmsgUbuHgecd2WMA4YqAHpLiDsYqqtIBvCUgwmoc
 CByM1he21y8/0IZZ9DhLZjaelZS9TUWkbrViTqKExJ3YuNLOroj/ls2a7DEiGUG8
 S5dVViHPYAjlw7BYuoYJM4U03Njd7w/1ig65s8eYCQlflDGOcUw/j7940sDa17k2
 QXg04zAulHAwn4cR65qYi6d1S9CHyW7uXh0AjFcavGaejGp1jwsjOnUY/8Ei3YUq
 qIqy4ZzK4CjGX5NOOU2KQAr93Lj+DOH3G4iEDHCG9HjNMI8Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50squs8d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:22:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c354050c34so13954165ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 19:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782958942; x=1783563742;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WuJiALMC/BGgUNf5qTrrae7IiC6Qqo1y/5Q35LNS3FM=;
 b=elNml9UjDLYksbBs3GEG0UFq2VHpVnlOjJEmkCxo564ozLRT/aQF0LLsceGEBXQ5st
 NtSsRl9EF0bn0cAWGN9oztTDUZu7vvDNoTigHtap7jXTxYgdpq1YzwIgY4TOjOFCaZZY
 dZu2MzwWkN0uUfc9PmlgICpPBE6I5OvLuPs2i6dqliTIgeZmNlmgtEubOIwFGdne63rM
 eyTugDPRRSuYZ7vH+TctDko0CygRvWIl9YxFG/RncP8EGM93dn4JbjwI9mcdZG8smI4j
 a1b4GSGT+cYy1+sJo+wcvnHLeyKcv8PK1ihqWWMIIRMFP7PQEWJ5a537bMMeWRhemJ3R
 67AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782958942; x=1783563742;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuJiALMC/BGgUNf5qTrrae7IiC6Qqo1y/5Q35LNS3FM=;
 b=qPDUhBYc6BmBvCikFWTEvD+WtpSJRo4z8BZOQADpZG2xjinlqrYQ654yOy1CdFomJB
 oHpq0mQYPXGnaKRCdljpcohXZ1Ky5YWzvBITdmmO09dqs7U4NqMpVy2MYqcqAedI2H+4
 NHasvcfrxvjAcIWg7dSxtjtcPPU9PfhDFFEqxT/nwc904ATwG7MJiKI+1dZbbrLRiiFp
 Y50IIHgN1ufZXBJfKbEiMRyIQf2xbiXZeEj+KCbZagTl6Nks9jGfrY7JeGpz5yTeCscI
 XoQsUneVoJwfNgCS0u2duuabO3JpcvnmHgDPL/Vn0laShmmB9l6p5bFkAz1rzPbFCCpf
 26dQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPql5eHKo5szvLY7tepbKV6hC4NBwZonEe3oEHiztfvYlWc0VOxVPVZmqeq8kKrcDPdcjft31jSgY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzs64FiDmdQmwQpIQN41ZjTSlS8Ed/4k03WDGrnbnMNR8/0DFo7
 T88+QNLdxnQ3TUI1A5bW3dg/h2KCUe88q9WCDEevm4m7lup6tLQNb3Ug4ZydhSZKPGO3y3nXvVf
 S3N6MCIbiJnChRqNxXD1Yh8kUPvIkF2f7iwS/QmCOgXpDdvGzVpcZWHGYyvwGWwFeWvlPuSs=
X-Gm-Gg: AfdE7ck5RelU+QYx6leoa/bG6zaZkopITVaJZi/nv7GGIKZDbhBxMwlrxv89TMmauwE
 Re2qEGQ4n5QpNg8EyOv0vSxGbSwgt16FC3mnxLx0mj5cdjeTCGWGysjzMXttWy+W/zngzB2hv03
 1KQaU2iNjmHqzv2uBK5CfLgDQdJOEr7GbTeJ91JC8ZtqqGllycMPbaACsrkPAdFCEhqyldUD4l3
 T+4Jscrc8UJJYz5qfGCW243LBVhVGc77FLANe5iHUfQTd84Natv0LVP3tCi+4rKsRucY23b9RV7
 nAm98kuS4XzWwXImhoUUVMn1tKn44o0ZBiYtydYhwcxf3wqzfKzOIsHwIEzTt1d4+Bapnz8hNko
 qc2FLd0jDInBZMK7HbqctkJhMoAp6zG+Gs3XpcS78ncFtJEJ/nc56/CNEUAY=
X-Received: by 2002:a17:903:3883:b0:2c9:97a7:b1ec with SMTP id
 d9443c01a7336-2ca7e9348f2mr45316005ad.43.1782958942324; 
 Wed, 01 Jul 2026 19:22:22 -0700 (PDT)
X-Received: by 2002:a17:903:3883:b0:2c9:97a7:b1ec with SMTP id
 d9443c01a7336-2ca7e9348f2mr45315615ad.43.1782958941741; 
 Wed, 01 Jul 2026 19:22:21 -0700 (PDT)
Received: from hu-yutlin-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa65asm3279918c88.6.2026.07.01.19.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 19:22:20 -0700 (PDT)
From: Eddie Lin <eddie.lin@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 19:21:59 -0700
Subject: [PATCH v3] misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEbLRWoC/4WNQQ6CMBBFr0K6tqRTCaAr72FclGGQGqTYFoIh3
 N0WNy40biZ5yZ/3FubIanLsmCzM0qSdNn2A/S5h2Kr+SlzXgZkUMhc5AG+U83ZAjuhnjh2pfhx
 41dRSKFVUpRIsvA6WGj1v2vPlzW6sboQ+uuKi1c4b+9y6E8Tdn8QEHLgsxaHIsgwgx5NxLn2Mq
 kNzv6fhsFia5Ker+OGSwVVRWaCQAJCpL651XV+IpGprHQEAAA==
X-Change-ID: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Eddie Lin <eddie.lin@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: P2UH4k5aYwuGKRpW7VJG6CWudc9u01PH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyMSBTYWx0ZWRfX9zJcyeGwiKv3
 KMjlkJo93OpxuL5DE19rQwGZ5xNvE6NnZX6Wr3UolWQQNfECu51mZCY8FaJrrXwGLdY0aALcSZ2
 qC/MF/qh8rEhzOjxFpmAPYMJ+cbPCUM=
X-Proofpoint-ORIG-GUID: P2UH4k5aYwuGKRpW7VJG6CWudc9u01PH
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a45cb5f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Rsn1OCey0fvCUy5VNe4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyMSBTYWx0ZWRfX7onJ/TXDiYTb
 Z0ZG2kRwLU9t0I76s4tlZjPnPvjMIqG0FzJsSfv/jMCKvA0LBq9SK517kT8XLBMLgzb5/vRlLCR
 5DgMrIxgVEIB0k+QR76Bg8SECdBrpRfUkAcBhrxixXkLRPxT9exQroge5N6ly8kWJn8fHA8RuYK
 VwSuXdAbB4Euh7hBSrq0V66xqe0mTCcMbK+GbLPJjaoyzOIvs2wWbJI7EJ5D2OsqnAYsQh/Hpek
 18d1YgO7rtFBzMeqVF5m2ivraqq38unjquKDKJeNtNnqQYbeEG03AGvp/HkyKSryqhUxytIiqQJ
 u8S9T+APfuWOmONnaaJI5WFw+nWoRbNXdNZNnTUfABfeYd8bt1Nl30ScgNeuj07D1GqMxBrz/Kb
 7VN8udSK4OY66mJSTgLeFxyTJc/yRHHtT6JLFbYwSvaCBRp9O00/Lb/nANUT7ABJbzpGgkRtHII
 F7Kd1RKo9Yhws4DQGBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020021
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The 'ctx_idr' is initialized but never destroyed when
the channel context is freed, leading to a memory leak.
Add idr_destroy() to properly clean up the IDR resources.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
---
Changes in v3:
- Remove duplicate description from cover letter.
- Link to v2: https://patch.msgid.link/20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com

Changes in v2:
- Added Fixes tag.
- Added Cc: stable@vger.kernel.org.
- Removed duplicate description from cover letter.
- Link to v1: https://patch.msgid.link/20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a9b2ae44c06f..7727850e9240 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
 
 	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
 
+	idr_destroy(&cctx->ctx_idr);
 	kfree(cctx);
 }
 

---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0

Best regards,
--  
Eddie Lin <eddie.lin@oss.qualcomm.com>

