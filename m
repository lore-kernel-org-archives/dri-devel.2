Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79FBC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FA610E1C8;
	Mon, 21 Sep 2026 09:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Evqpc8Dn";
	dkim-atps=neutral
Received: from mail-wr2-f37.google.com (mail-wr2-f37.google.com
 [74.125.225.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A6D10E0CA
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:57:42 +0000 (UTC)
Received: by mail-wr2-f37.google.com with SMTP id
 ffacd0b85a97d-482f6356f6bso2176275f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789984660; x=1790589460; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qLURyJ5usDrCoS6jxkKDSurJA5Rl92FpG16gshoRTV8=;
 b=Evqpc8DnLv7epJ+gviZ4/04P33HEU+Oc732nnVQlLdv3c6mw9S5NJIGFDQ55QJ6FCJ
 +652k6fU0Gt4w5jHv0cltp80QjGjzT+O/pilybOXNv+jdgyOaa3nxippdmzUa8wM4wXN
 zYCrnIQrZGYa7NDbP4CbdJzuVh3IbqXXf87bcEXRhmr5dmG+a/uQ4Xg1vEDRB7P7wQxJ
 zF02596NfLJBsplimJhDSSec2/K1HuVpT+mmUjk/lZNrT/MNAwey6evS/WDWC/s4uEKD
 2PcL1s08Ey3oaRMZG4PEuCBKtF2/paJRVfSxiCqKT0uEZ/ZytjcjWajjaB6NOUkprQcQ
 HfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789984660; x=1790589460;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qLURyJ5usDrCoS6jxkKDSurJA5Rl92FpG16gshoRTV8=;
 b=v2YCe6Lih16BAZ1crQRYk0acUloz0uoFpv1oC5lEMgMyv1RDNb/cs6Oa5j3kjLwOLz
 h6Ju4uuWA4dT0rP2bCqw2asYi2V6xMBR/tm+YqoBFbCA8URX24wQiFF/3VsjilFrE25H
 Ik2jYLOk+4r07mt3C26FoD9TQIiQ8fthOdf9rgDYapd1yskiHBjbGaCYNnZO5dM0wLLo
 IyAQ2w9qAWyTvcir+4MoWlQ2S+OipD3OgDnnGzNxv363bi9wdMgLOJFykj6AVg0mCXQQ
 XBCh6lGSv6S2dt45sZK8Q4Ds9ISBZv8C+GLo38quio5Mo1niDZpUoitz8akxXTM217qw
 acGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxHXmHdX07l6CwwDsAPcgV7tScAwAlaVbSrIpXVeHetrrnfj8y1MI//b8m78S3oHasKpgNwL/UcXE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nquueSX/c3QHe2jnQAto7PjwSEJq/TPr3/8gVc/eWmgK8MCx4I
 TOiRQKe45tz46Evqyq/FdsHGZNMNpFBn7RaY81IxKnsw8dnVazD7t7u+0ahQfLTlopQ=
X-Gm-Gg: AYBFou3akuMFhybTZqeJMyUlZgTeChTvyIaT4S9nMET7nXm3W4UTSHbZWCzolja+Pnt
 xJWYvdERS5vGcJ70/V3dTv00t9zqWhjQ6sWFhw0GCQh/HhEUlast513cDKNVXvXXisCAIT/DBFf
 UcdEPslyauRLlZzDBxVUZ5O2oM7omLtWns6Oc/AM4q35oSV6B1eGMSKCQiK+hINPCpysTxW2qkn
 EQUcTqZZGUGFJ/uQ32BvqLa8BTa2Jj9zB1elSC8ABqLNmC9uf+gImJjm1RUF+58khRrJSrvTuPg
 cx+I3pD3nyQt4gLDWM9MXciBcOki05WCv7fVWgPHPcH3iIfe3ZFXz/wguv7ujWHQbNj8iHtQQlp
 fNDnsaHad9e7K62NSHqnO59JNWw4Rc46kz+2aPKegI4z3ee5Z6joZ1n0/NLIGEoIlDnoV2p2mcp
 KMhZHkbePAKkaZ1e69nYddMeBgIsAYyQjJaNbgKnYirYjZYpqoInyagZe+rA41BkcxeazdEXfWa
 1V2QcN/fWNb6T9QcAGsnOiD2O+RPg==
X-Received: by 2002:a5d:64e6:0:b0:487:27f9:83b with SMTP id
 ffacd0b85a97d-48727f90bbfmr9655713f8f.48.1789984660253; 
 Mon, 21 Sep 2026 02:57:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487243cede9sm23826513f8f.0.2026.09.21.02.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 02:57:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/2] drm/msm/a6xx: use correct timestamp counter on A750 GPU
Date: Mon, 21 Sep 2026 11:57:32 +0200
Message-Id: <20260921-topic-sm8650-gmu-a750-timestamp-reg-v3-0-2b9015106553@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIz/sGoC/5WOzQ6CMBAGX8X07JpS6Z8n38N4QFhxjVDSFqIhv
 LutXvSmt53ky8zOLKAnDGy3mpnHiQK5PsF2vWL1pepbBGoSM8GF4pYbiG6gGkJnlOTQdiNUOh2
 ROgyx6gbw2IJALbVEJbRtWDINHs90f1UOxzeH8XTFOmZ1XlwoROcfrzemIu/+K04FcBCmNIY3C
 pU57W/UV95tnG9ZTk7iU2p/k4ok5bZodGmlsbL4ki7L8gQ9M1SzPgEAAA==
X-Change-ID: 20260908-topic-sm8650-gmu-a750-timestamp-reg-2e7575e6279d
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lJi3ptJcwYb4AYGE3khyoRyB84fxryi+QCmc+xoNuww=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqsP+RPqsxzq9x/h5ZIEEm1w0zfHyzzXjC578AwXsF
 ZOgios2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCarD/kQAKCRB33NvayMhJ0Q0pEA
 CM0SWVIXyBSmbeiGNaf7GTH3LL+vHUgQJxAuvtFlxFDRpeoEwuZfKRJ4h9yrZk+OcfNzuZJuaTRGhs
 4nHLiLfuy0O2dL/L+irQAM9JVwmULu65WicX/JDqq8Uq83HvYC/Auy9GoAkQNjwifnwZhZ6idH+Ck+
 6PcxG8CfsLq48QNgq5+RS9YvscBEOOP7gZQHE1rJLC7aCbAena91LZBP2Ht40utERX6PW0dxG+ddmy
 3JRcU1mJaWQhoVkQmWcXYHn1NzL2J2z4OIvLHbSiXBFfHuo6w7hITZ7J0mDzZX2HxFB7dS2dI98Mnb
 uMkDf9HhOHzLxrLu9/iRp+OEveFJJ0YprbpF9H8Krf5NQ6P4WM9q5BH4xPQyO4QVCqFb9PbWGbnlaY
 llstq4oTu2gE3chWDF5A4SAta3PPlmM63XKSopihp+Z18S0CMhHm/DBVwuICI/jOG+xM7LtyyIUOjn
 k/cHyCg+IAqFVl7D5Qlus7lKW5zZePkMK6YfcSKUo9JnNL/UPeasnVHL3maY6CgCEpIXkH4XnHBhZ3
 gChCALY5IpZezitd/cp8KjWwWM5TsTCKwtcPvwFK6qL9svODWt9gNMcNkjlWRml5pnuBxJp3aeTq7U
 Ph7d96Y157biDmmDH9i3Fc+8xfLDgTNsu+LlsNJgO8/A4Vah7Mtxlgx6kPRA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The A750 uses a different counter register as used on the downstream
driver:

static u64 gen7_9_0_read_alwayson(struct adreno_device *adreno_dev)
{
...
	/* Always use the GMU AO counter when doing a AHB read */
	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_HI, &hi);
	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_LO, &lo);
...
}

gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_LO		0x1f880
gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_HI		0x1f881

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Collected review tags and added Fixes tags
- Link to v2: https://patch.msgid.link/20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org

Changes in v2:
- Fix swapped H/L registers in XML
- Link to v1: https://patch.msgid.link/20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org

---
Neil Armstrong (2):
      drm/msm/a6xx: Add CX AO Counter registers used for a750 GPUs
      drm/msm/a6xx: Use CX AO Counter register for timestamp on a750 GPUs

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 12 +++++++++---
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260908-topic-sm8650-gmu-a750-timestamp-reg-2e7575e6279d

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

