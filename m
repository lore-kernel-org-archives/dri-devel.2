Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C704CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C7E112803;
	Fri, 16 Oct 2026 12:55:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114E410E318;
 Fri, 16 Oct 2026 12:55:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 11BCE600D4;
 Fri, 16 Oct 2026 12:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAC79C2BCFA;
 Fri, 16 Oct 2026 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792155303;
 bh=7zRdGEYEh1FKjIMGDP8oZedZK5i0r57nIXjdT2GgaNI=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=TtCyDWvkme7HMSCoJjXiCzhG5hLtibEKocmHwBKu+ODwAiLaKXNyfn/uue5ftBV7/
 JD1EtdTDMdB0C3IkyJezUIfRiuV2s59HMV86xnRsTYKh69p/ZAF8XyjveuBnvEMBnd
 C0K2zNakmaMqlgFMWhzdqNVfhENkQt7BUx45H55u80valf0quyeJ9ceTbqUzQ0p+ig
 hD9OuN5XrvBZ068gTNxngphir/Utc+u9vH8eMva+R0G/A6MpTXBJXxV/GbF2y5dtJg
 rn1lZXr2QR/2fJclzQ0jBOMwYVSq1WCKhwyJgTe914VQZPAY5ZQ588DEBbpQ2HkMuj
 qQQC5hMk7ApWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA3FCC6B38;
 Fri, 16 Oct 2026 12:55:03 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Subject: [PATCH 0/4] drm/msm/adreno: Add Adreno 620
Date: Fri, 16 Oct 2026 18:23:10 +0530
Message-Id: <20261016-adreno-a620-v1-0-4a7ed6210d7d@brar.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBRF0a3IH2vSVtJgK2JQvPINSlpEIvauG
 J7BvRdFBEakOrso4ODIi09QeUb9ZP0IwUMyaamNksoIOwT4RVijpXAWMFXVFaV2lIo1wPH53Zr
 2d9y7Gf32Lui+HweWFClvAAAA
X-Change-ID: 20261016-adreno-a620-faee699b382f
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792155300; l=1895;
 i=patches@brar.si; h=from:subject:message-id;
 bh=7zRdGEYEh1FKjIMGDP8oZedZK5i0r57nIXjdT2GgaNI=;
 b=xsoXU8nt6rPMAkxUpxj135+VGivuWOqEh3SHSNyOwlZeV8TNIlfHByZhWt6DUJMvClCRkHfmn
 XhDdslnT9wFA7jb1Rz6rP31kAzCoiu1YvBe/i2/t5e2O5T9PKYUQHcH
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
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
Reply-To: patches@brar.si
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This adds Adreno 620 GPU found in Qualcomm SM7250 (Snapdragon
765/765G/768G) to msm driver. It is A650 derivative using 
a650 SQE/GMU firmware and a620_zap.mbn. On top of catalog entry it
needs two A620 specific GMU changes:

 - A620 has no PDC setup from AOP, so PDC sequencer is
   programmed from driver (xo/mx/cx addresses from cmd-db). Without
   it RSC never acks second power-up and device hangs.
 - A bandwidth table with BCM addresses of this SoC. The generic
   A630 one does not exist on SM7250, so first GX performance vote
   times out.

Tested on OnePlus Nord (SM7250) running mainline: the GPU, GMU and
Vulkan work. This needs the SM7250 SMMU series [1] as well, otherwise
the device is reset when the first per-process pagetable is created.
The SoC devicetree nodes are not part of this series; they will be sent
separately once the SoC dtsi is accepted.

[1] https://lore.kernel.org/all/20261016-smmu-sm7250-v1-0-e11fc0384cfa@brar.si/

Signed-off-by: Ishu Brar <patches@brar.si>
---
Ishu Brar (4):
      dt-bindings: display: msm: Document Adreno 620 and its GMU
      drm/msm/a6xx: Add a bandwidth table for the Adreno 620 GMU
      drm/msm/a6xx: Program the PDC sequencer on Adreno 620
      drm/msm/adreno: Add Adreno 620

 .../devicetree/bindings/display/msm/gmu.yaml       |  2 ++
 .../devicetree/bindings/display/msm/gpu.yaml       |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 25 ++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 22 +++++++++++----
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              | 33 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  5 ++++
 6 files changed, 82 insertions(+), 6 deletions(-)
---
base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
change-id: 20261016-adreno-a620-faee699b382f

Best regards,
--  
Ishu Brar <patches@brar.si>


