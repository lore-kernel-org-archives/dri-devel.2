Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA695606A88B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p7OfNETp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GoR12PK3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E9810F25C;
	Mon, 16 Nov 2026 16:22:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41B010E1A0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGK5px3692946
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=jOFnPdS9OzKd2pQAuWQI40FvjqklDv0OYhh
 O4gHPm10=; b=p7OfNETpEr68CLI0FHZnru+WSdSkOWcv95PEkSOO17XhebYpD14
 DfEypxXf9qv30Nno20G5GbZdH4vUA3yytNSqTdr3jQyerOMYoNX1kbXLqUeE8Xm3
 z2Amb0sNDDdy1hNjpFWoKsJuhvJIplQtmtAZGdMXE+f5NlINe+yFbbK4RRC5Ytyb
 tAUx0aeQRf8n+viyoAihM06FWVfPSZD9kU71jhEz7na1nkNmtBuqcuBgrY+rrbAR
 ZFAyEDhlZ/4gSypJ2dXu9AQmSvDFrhSrR2tpFFbE04k+Y47f95sguXhUF7fnxqGz
 TLMba/Bnqx6GI/MB5R1SWBV8ytMR4dK7m2A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f8104m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:22:04 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so5163201c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794846124; x=1795450924;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jOFnPdS9OzKd2pQAuWQI40FvjqklDv0OYhhO4gHPm10=;
 b=GoR12PK3O60Q69AsgNokAHGqHMnO7GKYPLcV8di4WmD6GytAfMeuTbBn34sdLUgwDp
 N8Zej80Fu7EGOEF5CaqVau/PsaQTd5JlKyN/8BbZJIIjzLEp7lyUTfkZi2ejRzNUuhTw
 +6xTP4ylkZdEUZoexOiIDoNnaL755yAatYls0F4FDdtNkvOSTRBfOGJddqSBpvJbEizt
 xPmvWZnqZt4u2P4fx6pWEyxUkId/zlqjAI49B+DC9tCzSbqwPue2hwM0n4iHw1ii8gBc
 RlGYX6p5ENPMt2IWRyMxVuN5hEFWDR2GRzE6WBeAalvTKN1ulYSx+idLFD+xUCL7tnSx
 8p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794846124; x=1795450924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jOFnPdS9OzKd2pQAuWQI40FvjqklDv0OYhhO4gHPm10=;
 b=O2t5ync5lD4rntdvZns8hdvmBKrrhVzijyj0gabVyqKZNk1HWPM1WrFDESvLsbzFMr
 FmSRgl7Awvp7AMKSqbNwPfUQ8xZSh9MHH7vk0dUM4Z4IWybdylj7bizk1r9u+prXG1r6
 LUy0OYRQfBSeBO6XclnQ3pipCjJhNQdz/hU39scdW1LEOw+KEFw+70GpAHdNO6lyHmnd
 dbvi/PgRfueEuGpGlmFkl+osqqgdbt2lRUMJkKuYxNcKwAZ8zh/IExl/Vx7rB/UngRIJ
 AWXkgJIS063oJzSVmdq6am+bMPv3x/TUgy/8W3gRzxtOS4ks1BTn0M8aQHGm2nXm6qoQ
 NYBg==
X-Forwarded-Encrypted: i=1;
 AL+hErHtpLPCHFiu48Pj9YS1CFoINnoglLodS/m6t/QxjBu6R9gXOK8BYh3e473DzSKkOGoxqHxb75mAatY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/dbPzWn3eJ2EbWNCnR2vJ41zq/OqXstHJTNdSoP0RklsHORNMH
 HQd30nYEg5GTk3R+UWrkQnUC6Ig9avGFPyfY0a12BTiFapJoFIqxB4AEq+LNTa+pxx7HsEDe4XL
 O0IMblsjZ5P7MwqU4KLRynSQHFiCLSYOzUxOQIUoixDVR7G+ylOvwpRQuGPE/RmHYtiT2TKI=
X-Gm-Gg: AYBFou3XKeWqUAbipKAhqPUYv2XsGJIrKJLYTItebyTmeEWDlZR0p8VtCqGCAs2618/
 oaYxyqqCLI0ztaILqod+hN9Kh5ipsZ/eEpgpP8S1G91HYCd3CKhyH2EsSd9m8KBgLbHbzmWxHx/
 XnrICTLA/vyYJoBtVr1Q3oQgsqRhnnPaM2bstv164y5KKIWth4uGso7G67X9wZnUTTYmQ7oj3HQ
 5WYlqlMYPhUKGDEWqJ2O1izosXqyUyh/vM1ivUofXoBR9G5JxmmR2iNDsch2GDrBpcJtEQB2plS
 FG/GnijsiAE6ysHhucWjrg4yUyZCy6Uf4BAQ4vhGRpBHfj4qW1lgNC0yJxbHyUWij6biz6zEwVB
 9uMH39EYDbnWQjsINLhkMh+4pa8vYCYhjCOZSH5ElqL4ktMIexg3C+KIxSZQT54k7mTmJCtSse7
 ed
X-Received: by 2002:a05:701b:42c6:10b0:1b3:ba92:145a with SMTP id
 a92af1059eb24-1b503171008mr11928402c88.19.1794846123206; 
 Mon, 16 Nov 2026 08:22:03 -0800 (PST)
X-Received: by 2002:a05:701b:42c6:10b0:1b3:ba92:145a with SMTP id
 a92af1059eb24-1b503171008mr11928366c88.19.1794846122515; 
 Mon, 16 Nov 2026 08:22:02 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031468b7sm38623826c88.5.2026.11.16.08.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 08:22:01 -0800 (PST)
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
Subject: [PATCH v3 0/9] Migrate PAS clients to qcom_mdt_pas_load() and
 qcom_pas_prepare_and_auth_reset()
Date: Mon, 16 Nov 2026 21:51:39 +0530
Message-ID: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX+KaVbSTxzyEI
 P/mx2dtjmm2G+rvJC5p0GlXib4fSOxb7N6v4dX/7n+dpDZH8iYC4YG2Or8rSeyuIlIonHgdZwY7
 u0axLYijYm2L3wefpzYVDYhWCw8pymcgDjFq3+wUyFx4vkhLjQw8WhWYRfoY/gmthax7TK6+ayU
 BM/EYkFETdNIt7D3CTtqveg+RMnlQWaF+6pV5ZMwXx1vJQyzmQZ3BZeqq7uB27K1E7F12qJmuyc
 63cuq/mMRvAbPi0vlcW+mKzqXuCM0gyCQpmRO3T8pZq8bCYoGvmQlC53VSz59HG0sPiIEMDHnGy
 PzC+nR36GEQQRv66pq5EycAmUmyK/G3vx3HsPWEHNHTovAHNQlPKzSXw+JmWq+5YCMnF2km45hT
 y5MJqRCC2HJo/aLbhCOY8TsbPdSP3jba8gATQ3ZHn6ewG+I/noSgkyQ7VY2Bf5K26jxTCWy23nW
 6mNd179O3kJlDpbtjzA==
X-Proofpoint-GUID: cdh2SeYwQ919b2Nf_TtnR2yGl7GDwYwZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX04arRfaq0uXU
 AZB/ZI+cCasG0e/Tsug51eMzrL1cVs8QBWxeGyuXkzHf8F4MHp0yp4YtVPLoFGT4rJJTiFkFROY
 oXvYCp03dRSJaWtyb6Yboshf5OVqWqI=
X-Proofpoint-ORIG-GUID: cdh2SeYwQ919b2Nf_TtnR2yGl7GDwYwZ
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb2dac cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=HLFs0uR_R7ZgEvxmAyIA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160064
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

Requesting the Ack from subsystem owners to get this series merge
through Bjorn's tree.

Changes in v3:
 - Added Acked by tag.
 - Fixed build warning.
 - Link to v2: https://lore.kernel.org/lkml/20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com/

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

