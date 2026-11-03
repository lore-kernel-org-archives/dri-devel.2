Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE892606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=NFPIPcJf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572E710E2FF;
	Tue,  3 Nov 2026 01:14:39 +0000 (UTC)
Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0B410E2FF
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 01:14:33 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=PJB7fKF+/loiiW1a3Y/RpW9YC0ahitzGq3HxxmTug7o=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793668471; v=1; x=1794273271;
 b=NFPIPcJfSbRhdYmTOTJQADzw8qsTEKYvtUqhYAD08bbYVF3eeY93ffhSM8mZC+eFozustoNs
 qSv4mkMmszpV0f1BHw7xYHG6QJ3OWr6rkg+APLQoUMD7dtEgQ7g7oW/gTC+pkEVZc/ZBehKVB20
 k/ReX3Zu5ekfY16DXjfzA+BabbAkGHz18FdB2gS9n1SeGrYhqhbUNBlIPA+Do1CEQj8MyZ8a5nZ
 8TbxJEFdHFZUTKCYZWx+/m2Vbh/joTgGXBdrlzSxfUQl2CafK9ARQrQmdrY2RHytmUB7B1YBXCE
 QGhrFVmZqyA/pTB6MB9P72mr/vsRoR8cIYHp4B5KwXriQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 59894c97548e53e0;
 Tue, 03 Nov 2026 01:14:31 +0000
X-Mizu-Trace-ID: 59894c97548e53e0
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>, Maximilian Luz <luzmaximilian@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/msm/a6xx: Fixes for a680 (SC8180X)
Date: Mon,  2 Nov 2026 22:13:49 -0300
Message-ID: <20261103011358.65398-1-val@packett.cool>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series includes:

* the missing gbif_cx sequence patch that's been around in a
  Surface Pro X downstream WIP tree for a while;
* new fresh patch based on a (rather slop-py but valid) comment
  on my report about Vulkan texture corruption:
  https://gitlab.freedesktop.org/mesa/mesa/-/work_items/15349
  GMEM starting at 0 did fix it here;
* an import of the hwcg sequence from downstream (kgsl) which
  is just-in-case more than anything, feel free to skip it if
  it's not actually the right thing to do.

Thanks,
~val

Maximilian Luz (1):
  drm/msm/a6xx: Restore GBIF CX config for A640 family

Val Packett (3):
  drm/msm/a6xx: Fix GMEM range on a680
  drm/msm/a6xx: Add GMU_SP_RF_CONTROL registers
  drm/msm/a6xx: Import a680 hwcg sequence from kgsl

 drivers/gpu/drm/msm/adreno/a6xx_catalog.c     | 58 ++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  7 ++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  3 +-
 .../gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  2 +
 4 files changed, 66 insertions(+), 4 deletions(-)

-- 
2.56.0

