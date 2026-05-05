Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA05CD3436
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 00:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D73010E087;
	Tue,  5 May 2026 00:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fjvPE7hn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IudMoqlM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1EE810E087
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 00:25:08 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644Lu2WZ1960443
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 00:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7QLod9dRReugtdmt8pQOfg
 aPMeJva4633ho398t5P0U=; b=fjvPE7hnM88jQx30FVC2ZWXIf7TWjGN3eYN63h
 Ue571PL1sq94DOGQ/hNxaOgRi9+dU3csOkwJyqFcxBF533sMQMW4FAE6r2LAiXsY
 6Ml9hkYOpYnhamv8OgGXa70y8ygkyPhvR5zoSKZ2KVyB+mVNmNZgEgiWz87aL0vD
 u8PSYdhEl6Tp1krK5PFbfmy3M7IA3owYqXO/yfXArBBc2zjcMp4QfOOEdnfbwLTV
 9K6KX+RFqZhLp2N/mN+bRVxGzzz/jgkGZzY8phKOs+6WzF0oVLH7LlPCKqjvpWNR
 7Q4+ekzx0uBChicnA/9htOSTwyoxl1XtuVlJmDR1sK/eOEmg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5dt13a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:25:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e67a4f642so118148161cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940707; x=1778545507;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7QLod9dRReugtdmt8pQOfgaPMeJva4633ho398t5P0U=;
 b=IudMoqlMrhFyDDb8pD/MR6yU+cMH7xU4+BS44ECdkryrpBAi3uOmX1j/J2HsiaLd4I
 A3E9Bmz7YDnrWTKS7O2nts+7d+5SJPG4QaQGl7+1N1JNc0X/KGxIFqPywfhrwAAr8k89
 4ND4TZFsyTnX4v1QfTgzriAxtIa9ibQV1gcoIu0g4+Snn5Bv78lGP9CD+WmvGkvYlJ5k
 Wz7thc4cvS3TvLbls2fUZHrjfq7LwTLV4JpVOb7F22Qz377snr3cU0hJk7BFq5skvIBc
 CsvP6VdXPjawg5uZ6eqsqT3ajJHCeaj+wrTK3BwxnAfvCL3iOGaifjq+/rDo75YYv/FY
 QFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940707; x=1778545507;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QLod9dRReugtdmt8pQOfgaPMeJva4633ho398t5P0U=;
 b=odl59EjSrj4ysk7DEA/RWqfrgqqbxNXz7Fk8iVR2l7zAgyeKGCA3KY2cEH4631H44m
 nvXpNetQ08t41w41wrmKzc6uAscwHLDStB1BkSbX26+WRIiuzxrIn4Xh2UVhUPEM3w/Y
 xUap9iLf6SDs5NVxXBokS0qEKJXIxS9BPKMggQtc5J0fdc1ea7WKfc+Vh8gH1pKi+zoa
 /FGrobVk06JF8aWXHeMokHFuRCFJRhWrFHo/CJZdNGqCrKP4JCqC1OIA6L2mZrBtoP+M
 ZebeUL3iCNmyBUlpjhtKfxYHbB7yHC7ScOKbo6SQAVI8awRlwDvlAwvs5P5VguqJYdlk
 q3Cg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wxLNQLAYuTptWrMVPFgl7JtzKfvHxqT+IJ9r+EFuc888LxU9CZqbI/HQuYDh9wGXvpbuOOrp4yYY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwR0KPIk16bg+1ekKAqtU5+zEoa5jadCJH3jujmcce8R8vBxM3J
 q68ivTEikTRSfRT5t319ON7Y4nTe29aqm+/cNXrXM/uPMb+KaPPELIVstFRhRDdC68qWVZgNh3Q
 8DyqLyXlCqQmnrbncC0d7jLTx+LWDBQoyoZQK3IOFHJf7PhCp+D9STb086eCU8F7+TXq4goE=
X-Gm-Gg: AeBDieuxVWYBI56jRW3fXeSA8mV5Q9kWi7DAI6aPUY14wiQGaDKLRQDLVID1jQwPSkk
 GA6f5XLnAvcnbyVw1Q4EughoGC1M/y0nzNnfFFpaNcFCZI8IZ5eC3yKQaMRvQtxym/LP8+ZEkXr
 4Mw24debNxgO39iD6tJerwf8rJFHQ7IiOn7otmO7GQufz8pdYogfKYg5F3AlpoXjY1bgiuDAnH1
 1g6G2ZeoMsY5HgpKRoIYfqhM7P9AW68nEPlZ7UDACTqlr7BKO/fg0se9dxY9gaBoavXYzA8mSy4
 KSEP/TW84zMcO3rN+COte+tSvskEmoLkpRuDHhTXgdUfyi/TuFhVOCu6f1nz5JplYVzVqfA1scy
 IEIg3NHbPgHcNz0D0DmHu8RK66uk+tEVoE9B+GJi2FZnkqx8Nye/QLj9nUy3ZDAEgvKo4y18nqm
 dhrIk0cEEvP5NT8WX41ePoFa7V3tPZ2fyhcBfWF03CBmIB7g==
X-Received: by 2002:a05:622a:5908:b0:50f:b974:7ef5 with SMTP id
 d75a77b69052e-51306a7acc5mr16373851cf.32.1777940707066; 
 Mon, 04 May 2026 17:25:07 -0700 (PDT)
X-Received: by 2002:a05:622a:5908:b0:50f:b974:7ef5 with SMTP id
 d75a77b69052e-51306a7acc5mr16373321cf.32.1777940706560; 
 Mon, 04 May 2026 17:25:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 0/8] drm: writeback: clean up writeback connector
 initialization
Date: Tue, 05 May 2026 03:24:57 +0300
Message-Id: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANo4+WkC/3XRS27DIBAG4KtYrEsKGDBklXtUWfAYGqTaJOC4i
 aLcvThRq0iuN2h+NPMhDTdUIEcoaNvcUIYplpiGGsRbg9zBDJ+Ao68ZMcIEUYTib4t9TkcMg0s
 eMtadIa4T1gvfoTp1zBDi5SF+7Gs+xDKmfH08MNH5dt2aKCZYMS65JJyFzu9SKZvT2Xy51Pebe
 qCZnNgLQ+WSYZUJWlAPhAce9ArTvjJ6ybSVsVwZaUKnSWtXGP7HUMbUkuGVEcozBVIqTeg/zP2
 5uAync/2B8bk9ZE0BPDfFcdv43OM+Fvf+W+ABLmMdvf8AiACrSMQBAAA=
X-Change-ID: 20250801-wb-drop-encoder-97a0c75bd5d7
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3303;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5yJfYD9nv3EttqjPI1vJyzwvXDJhLx4j8rBATQoCCEs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp+Tjbf13SW5UIUohb/OBxNm4E3L6S3xwe0xiFX
 czRU0ec5PeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafk42wAKCRCLPIo+Aiko
 1Zt2B/4lVv+bnZzJL4SjTwu9r864h29OcYwW9NO1sE5jzL++++8t0xfzq7FVGRpBoPg1namlp5s
 WlNEasWgUsZ4o4vi+k9m56KWbTrT6B8wDgElLrG+DhyTOmGgWTKplqjlmrfCgj1qS1XGXavhbNv
 gynPNIVrFyGnJh+DCdih5/F0aY8BcGsr0DMKHR3QOlQR6uTW3hwPLm+Z+AwbEjeXlNiU/C+zSK5
 eUiCXhl5JGm+QdFKw+9bJauuLz5Bgi02RcYLx6xXMsHOU7t2qgZnnuCc+aoXgVK7VSqOt76PGJ3
 u3wUBo6qBsD+7vJAJYNGmzyEbUXgrBVGLgLnlbYcxw4unxIp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMSBTYWx0ZWRfX9edsTwLafbvz
 6C9r6SdlzWoXssOS1N+IkSnrCdp5CSg5r3iqCgHuiUF2H1vVz93jVdv1aLm6RRBNEdlT/nRIkAP
 LQvl0zGwL2T0ndv8wd1P3ijchJ87GZa0XM6DPl5JkMgfDRMIKnZes5l72+32RWwuLXMliYn9Yxq
 oZjsP9gfx+CAIRxQhigsSCnIsOp4lVwolIb3+MLWDO4/EePM2N3XXEZ9Dum1KykmIj1BccAJATm
 Y5ruDx6kbZIw2CCCOruhTFr/F/ZDagcOS1DKKf5IZCzgQ34fN7zIPXxKcR2Y62vtfxK+yJHMuB8
 rjqqypfYn7lauePSbpCT9p3LUL9JNaImfYAUE6NpCHIEJi32AqhFHtZWruWb7RyxEGJe8l7Yhoj
 yA2rY+FOgTfs6v47RaXWTt5p4e3Aj0+BBP45T5aZ76lEVdjnuy4gEvPxi05CfsIATcTPxtZx056
 r1f62oxZHOCVChUhYXw==
X-Proofpoint-GUID: v_16h8YNudrlvM8PJ6nzdjrHTVVUcG7w
X-Proofpoint-ORIG-GUID: v_16h8YNudrlvM8PJ6nzdjrHTVVUcG7w
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f938e4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_H8M4-vQE-x6SST4HBsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050001
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

Drivers using drm_writeback_connector_init() / _with_encoder() don't
perform cleanup in a manner similar to drmm_writeback_connector_init()
(see drm_writeback_connector_cleanup()). Migrate all existing drivers
to use drmm_writeback_connector_init(), drop
drm_writeback_connector_init() and drm_writeback_connector::encoder
(it's unused afterwards).

This series leaves former drm_writeback_connector_init_with_encoder()
(renamed to drm_writeback_connector_init as a non-managed counterpart
for drmm_writeback_connector_init()). It is supposed to be used by
drivers which can not use drmm functions (like Intel). However I think
it would be better to drop it completely.

Note: Christophe pointed out that AMDGPU driver leaks connector memory.
As it's not related to this series (and as I don't have enough
proficiency in the driver) I'm not going to fix those in this series.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v5:
- Rebased on top of drm-misc-next
- Expanded commit message for msm patch, describing devm vs drmm issues (Laurent)
- Expanded commit messages, describing why the drivers are converted to
  drmm_writeback_connector_init() (Laurent)
- Link to v4: https://lore.kernel.org/r/20251228-wb-drop-encoder-v4-0-58d28e668901@oss.qualcomm.com

Changes in v4:
- Rebase on top of drm-misc-next, dropping applied patch.
- Added a note regarding memory leak in the AMDGPU driver.
- Fixed a devm vs drmm issue in the msm/dpu driver.
- Link to v3: https://lore.kernel.org/r/20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com

Changes in v3:
- Fixed subject prefix for the rcar-du patch (Jessica Zhang)
- Link to v2: https://lore.kernel.org/r/20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com

Changes in v2:
- Switched to drm_crtc_mask() where applicable (Louis Chauvet)
- Link to v1: https://lore.kernel.org/r/20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com

---
Dmitry Baryshkov (8):
      drm/msm/dpu: don't mix devm and drmm functions
      drm/amd/display: use drmm_writeback_connector_init()
      drm/komeda: use drmm_writeback_connector_init()
      drm/mali: use drmm_writeback_connector_init()
      drm: renesas: rcar-du: use drmm_writeback_connector_init()
      drm/vc4: use drmm_writeback_connector_init()
      drm: writeback: drop excess connector initialization functions
      drm: writeback: rename drm_writeback_connector_init_with_encoder()

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 18 ++++--
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++----
 drivers/gpu/drm/arm/malidp_mw.c                    | 25 ++++----
 drivers/gpu/drm/drm_writeback.c                    | 69 +++-------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |  3 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 22 ++++---
 drivers/gpu/drm/vc4/vc4_txp.c                      |  9 ++-
 include/drm/drm_writeback.h                        | 22 +------
 9 files changed, 75 insertions(+), 125 deletions(-)
---
base-commit: d4c14903bf5e28e740516c4fbb7db01e0dedf3af
change-id: 20250801-wb-drop-encoder-97a0c75bd5d7

Best regards,
--  
With best wishes
Dmitry

