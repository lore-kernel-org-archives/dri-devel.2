Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC6606A336
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pai7rOpH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gW5rm3WB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386DA10EC7E;
	Fri, 13 Nov 2026 18:50:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60E511273C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:50:26 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADGXJuR2808706
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=UOGbIgdMvNNbvF3rlYZmS8C4yu1k+1TFWuu
 8QXx7o+g=; b=Pai7rOpHvCid7pBso1KJQNmUP3ay4+209rkTRCGKrA1soVsInzz
 2+EI/9XiO0RAM/GnD/STisvs4OSF4TmMqSpaYOTZTy4YrfruHtbiexkEV8X+AKhJ
 6HObc71xpqBRTgvwxdC0xYCS8IOuPWw7fCvssyM7FIliP505dAw/b9KSorRfVPSt
 Hs1K6yoPpdFLUGK+7yQVE9fsj5oYSiZgP9Mx0gEp4TlIeIfax6HA+62qfOkZuIA5
 ZsXxXC5DTQR/MQQPUz2nG7Lr+6BZ/wsoDvBGC3M/nm9/vZt3UjBSw5X6aDlmZjaC
 IaQbELHasdMoTMISlwbVrivN0NT59bXZNNA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx662rg1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:50:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so1591811eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794595824; x=1795200624;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UOGbIgdMvNNbvF3rlYZmS8C4yu1k+1TFWuu8QXx7o+g=;
 b=gW5rm3WB/mnv9x9+YXJjgPcS4rhc0UzaEjTh5T03tZvh252gZQjEH1LjgkL/JCn6i/
 nJ5Fh4fLPcLxbKqFz/9Ld5/YRw09AAX0LMOPbWVFqOEnmYo0OYoXoe92U2IezFOK6SL3
 JD5JsfEzOJfyyoLdzav6ng1qOi/qJG4sV/nvnjW6KPUgadP5yxYkwD3PX3FjGQjaOIyV
 JwHvxsfqREw1bXNCdAooD2P5O7H5Sw4gzJ4SywrcUis62grYruPJzgcN+1VC53dQKTAO
 S3HhoKh2hwajD+PakYnlCUb5OASlxS8nXYL6t9Pc9jZd9I0mnQb8Ssx9a1jJ4NyyPvNe
 sXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794595824; x=1795200624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UOGbIgdMvNNbvF3rlYZmS8C4yu1k+1TFWuu8QXx7o+g=;
 b=Eet5Cc93LFry2n2crZi9HFAYlWcTLocKYpb7ngrZGGn2DeyELkk2NzwNwCmv9TPNI1
 chZTh6tPYP4AuWKCBrWFktaFFIEwM0Vq8N+KGmDOw0kBAFcoWzoWXBF0TUGEtXEu5/ra
 XXkhuekl40ItgdCVBIHp+GzMZP3LnUoyCSX4YiFHoxhZrO/hkgD6IFCCdwkJH5NIX/j9
 uwKvUqWGix7gEYuVeow89LQXBgGgGz2t6/wOWPAvSkdLBbHWsQSaFNPIPuNParYbZIjW
 6Oh44s/SsFboSwS3t+N0iMh+YO/aN1Qw1pe2budAsCfI0cQIbcdIiA3INuBZ7V00vwkp
 4TFQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG2bj556x5tQEKRIH5SkMrK/m3n7lDyN9CoIFQE9GEWSmvWnbJrTR3x2mn2nQy3qVhpkAHBwZXx4Eo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9CE56sjwTHDIdzjqTDgeUDKQ9tZbSMwDRDw7AmAGsi62OCA8VW
 W+JxvrkoBTyFXB3cvdedApHzTeL8sIEkSSiFI4j7lkemFGUrSPGZuxQOc+8eP5LKHjSj1AgEsws
 9SIPXhOh/C0t4LThP+owSYSYcEh1HJI20qiSYL8Mj0lhWpwJOou+ytJ4n/LPiqsFLIZRFT/o=
X-Gm-Gg: AYBFou0+0YtGVgM1DXFLGWwRbmM9iTiVhpn6oZ000PdgkkvxbY6ilaHphD0cTNbHtEl
 /YREENJCN4ZMwu7uVNb3+sSnjvmPlavLzNnLLIKBXLCX/vAZ9Sa3ZExB+PcotyrCK0iI8rRPnpt
 FJZ/T6qcaLaeorzRftOMDcwx77tKqmNKDZv5hSCUDH3o2XqCF+FhmUpR80qNCUW5H+p67Ci5/ib
 83Be/tLK71Lk/33YYxtsxi52hE67MsbM7pWbZOVVVCO7M3eh/7d4dJV2TOoBXc7dvpdW3KAK7eP
 9GzLVXFAGtwn6BsI9Iijbzw0x1KPXIBSHe6geCSGLjA/vwyfmsi1MeBWAhRLodDhsBO5w1zLzOk
 M+I1EtaAjUV85R6AawT4BbbjzaQzGgscNWgYdc1zbj0amonkwtsGRFJqriU2MmgKtiH8GR1mDJB
 A=
X-Received: by 2002:a05:7301:90b:b0:34d:755b:d60b with SMTP id
 5a478bee46e88-37968b8a031mr2753159eec.34.1794595824132; 
 Fri, 13 Nov 2026 10:50:24 -0800 (PST)
X-Received: by 2002:a05:7301:90b:b0:34d:755b:d60b with SMTP id
 5a478bee46e88-37968b8a031mr2753127eec.34.1794595823416; 
 Fri, 13 Nov 2026 10:50:23 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm15547667eec.21.2026.11.13.10.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 10:50:22 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 0/9] Migrate PAS clients to qcom_mdt_pas_load() and
 qcom_pas_prepare_and_auth_reset()
Date: Sat, 14 Nov 2026 00:20:00 +0530
Message-ID: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y3kIaCZyaHH0nnBu4MSQvEJsJpWStX34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX/qHOVvfKHg2y
 vPeUCxpokwZ6NOHzNUBqAvT98+KbR9s5rAUnRsoccvkgHkgzhRt6TiTs7XOcWV8GU4BY1BYbhai
 0A639o+KMab0cygFsjTgYYPHWJh2IbQ2bhvEfOTcCDfmaTt/J0V7TMBViMZEvezd4FeFWhzjUJc
 JlNYk650Rwsb3q17WCeEdc9AYxK+v/kmUQv7xN9a0PHNfBQRZ9uDZYsxVUzrBA297X8QgjaM3Vg
 XVGQQ51jiFFg7mq4CL/tNs8CJydtwAPKf9kGMDdQwo8DCaFbcOZ40SdfKygqwyAP2P3H1HJOMjK
 cj9SsPtnnro7Jnm1GHLM4iXzvDbpTjZlfwlcd3SdVtivE8KaaMPEuWvDBwlD+UOaPBhwzk0XCIm
 QJUXy6bv0PsX3zc9PGKQyrq7O4VVW1vQnmia42w97Gg96LkpY7QtRKXLnEyQPrZtpQk5SsLQ+RG
 KRKkQ+47a2YMVm6ceZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfXzxAn/2xxndr6
 g6toNmkSWJFU5D0phTXr9lUWMVhp2KrcVsu+LB/weiTUs/TiTvtIVvlNoDlprzPcx5KI2gqSiMU
 CYuVs6g+ezea7Y+oJiemNAAHBss3wKE=
X-Proofpoint-GUID: Y3kIaCZyaHH0nnBu4MSQvEJsJpWStX34
X-Authority-Analysis: v=2.4 cv=M/nYuCws c=1 sm=1 tr=0 ts=6af75bf1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=zG7KPAmT95cOeVn0dqYA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075
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

In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
public function, migrate every user to the new PAS context-aware API
qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().

This series migrates every remaining caller of the deprecated APIs
(qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.

Requesting the Ack from subsystem owners to get this merge
through Bjorn's tree.

Changes in v2:
 - Addressed Sasiko comments.
 - Addressed Alex comment and added 1/9 as new patch in this
   series and use the  API to other patches.
 - Commit description change.
 - Link to v1: https://lore.kernel.org/lkml/20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com/


Mukesh Ojha (9):
  firmware: qcom: pas: add qcom_pas_context_init() for pre-allocated
    context
  remoteproc: qcom_wcnss: migrate to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  drm/msm/adreno: migrate zap shader loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  media: iris: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  media: venus: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  net: ipa: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  wifi: ath12k: migrate firmware loading to qcom_mdt_pas_load() and
    qcom_pas_prepare_and_auth_reset()
  soc: qcom: mdt_loader: remove qcom_mdt_load()
  firmware: qcom: pas: remove qcom_pas_auth_and_reset()

 drivers/firmware/qcom/qcom_pas.c              | 42 +++++++------
 drivers/firmware/qcom/qcom_pas.h              |  3 -
 drivers/firmware/qcom/qcom_pas_tee.c          |  6 --
 drivers/firmware/qcom/qcom_scm.c              |  7 +--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       | 22 ++-----
 drivers/media/platform/qcom/iris/iris_core.h  |  2 +
 .../media/platform/qcom/iris/iris_firmware.c  | 27 ++++----
 drivers/media/platform/qcom/venus/core.h      |  2 +
 drivers/media/platform/qcom/venus/firmware.c  | 29 ++++-----
 drivers/net/ipa/ipa_main.c                    | 23 +++----
 drivers/net/wireless/ath/ath12k/ahb.c         | 23 ++++---
 drivers/remoteproc/qcom_wcnss.c               | 12 ++--
 drivers/soc/qcom/mdt_loader.c                 | 63 +++++++------------
 include/linux/firmware/qcom/qcom_pas.h        |  3 +-
 include/linux/soc/qcom/mdt_loader.h           | 12 ----
 15 files changed, 116 insertions(+), 160 deletions(-)

-- 
2.55.0

