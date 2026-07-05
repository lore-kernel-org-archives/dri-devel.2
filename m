Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBCBC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF4810E229;
	Sun,  5 Jul 2026 19:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YyOmZ8UY";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6221B10E229
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:15 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-476a130c138so2348910f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278854; x=1783883654; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rfOoMuZEApI7TKZXEN8dHfuOQq4puRHMEr9ArXWgLU4=;
 b=YyOmZ8UYMN09IlOVnqeBOroS4jVf39/FO9OLlhhzBqWZLcws8wAIcJ4nG0dn94a3eD
 GC4cOH8eXOW15EuolT/jg+3yFdpeYT40BHjPCgG2lzP/miVAATZFUKBmJ7C3J/2OpAqu
 NTEtkFgV54XCQkusrAEu8DJCooaWdlAQLHcBn+myVl6Od6cnqcYmJobuRXaTDpFdv0C7
 TjV8nxOhQeB3XGAtjt1a6UjJWEP8cWAl/pozKsJYfNsFH9nnqrD4l51pctcbfgDT76ft
 MdzBa/H3LHL0LAGlHW0zaLQl5lu9IEFfmPQIYO08Gu2Xii1Q9yMrSiCDYWqfIdyIHP1x
 9CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278854; x=1783883654;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rfOoMuZEApI7TKZXEN8dHfuOQq4puRHMEr9ArXWgLU4=;
 b=NDtWg+1EJ7LrbO8lXTLBcLpOvplNNW5O2cN1UMQX+Pil1JTN1RoW5ROkhj71S7BJhn
 jxcclS/DQKUn8MAnY+5i5nFrqVYG0+qs6B7b5Kt8InnwzJyOuXEt50AmJBjFOj7Lsa34
 TVRpfLK0oeOpjBuAVAbY+OO6Lygv+R+1C9W5KZqbrV+DdKdHdK67I9hiJnJAfktYloxi
 +nepkjg1I64kBw7983ICWkyTGYB+2KVnNKB71oRcp2Jzu9XMmakthVLdCEdEDgW77bRL
 Ei87/vAJgbB3HIkVQ2ad/X9wXsDYD4J0GxbUQB/W6Om9CYGzrjm1fOTgeBlImpQG1wxn
 CPQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0qRSnU+yqniOjY7ewyrFR3ixU4yRJe+lhu7jKCAIl0b6oiz777uaYhLH0tExlV1FlchwG33UaKfk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgQbJiuCeBg/O8BgY/AI8R0hBTSn4JYIhJ5z933PtYc52NFRAv
 A2bkXJlrIGUpuvx4cngllbrUmkFmNSv+PabtjSLR4o7i0H9MRuyadUQ=
X-Gm-Gg: AfdE7cns+RneY9w8un30ttpjFL4Ep55R9/Nr724FHbuejcKKz2v56OzSN+Ec6N1Iq4T
 Bw8E6bntzylakL4k9g6Cqe6MZpesYXApNgfYLMJEAsjzePcL7WZIkPwIol4iGyHZU3jfEyCUsh2
 wAHbNQQSSfmudIf5pv5zDTKhOue8aYCK21WCYK+eWA/QzlCdoxRdPmRDQnXwfKQ9oxj8or57JC4
 Y1T1GmM/LCoSpJR9Z4Ffy/TelFDFOB4hC9G080DnaK93rFKDimxAq1bFdaY/UsRNkcAVmM1LyKA
 8TUOpKk/+gRUS7KfahazDZSfy3+fWrd9tWlVUkrOhRE38dGN+BvpTPCh1rGV+A5KqdMksltTam/
 OgFP1Z9g30ISHW0jtnvjQP907zstLQrSaJ6GH9x6+3ObveAmMfGvYmuZw0P1+y2a447igAMCQh4
 UKtxzkJK0XT30JFro=
X-Received: by 2002:a05:6000:469a:b0:46e:1815:6a83 with SMTP id
 ffacd0b85a97d-47aad6435e9mr5514134f8f.29.1783278853423; 
 Sun, 05 Jul 2026 12:14:13 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:13 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Subject: [RFC PATCH 00/13] Enable LPAC on a7xx series GPUs
Date: Sun, 05 Jul 2026 21:13:34 +0200
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCMAyA4VcZORtIN63gq4iHtosacbUk3RDG3
 t2qx+/y/ysYq7DBqVtBeRGTV25wuw7SPeQbo4zN0FPvydOAI1tSKVUWxhwmxmcJCediVTlMeBw
 oOL+Pjg4RWqQoX+X9G5wvf9scH5zqtwrb9gEd3ZUqggAAAA==
X-Change-ID: 20260603-descriptive-name-lpac-upstream-730a164b105b
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=2538;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=8dMwcHoLl0Z1JzcMDPMcwAdi90HhpnlCPh0AzVY5gFw=;
 b=Q83mQkQCI/ZbHgZyMczAaUD07W0pExCURYUI+AfeuCtFffXnVzp1aiJOAaTDPf13rw1Fzn+7X
 WRuPw2v96y4CWwkfRLibXR6NQ9DulNdUY/gYM6XuxmEibN0Vv7DXr+i
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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

This series enables LPAC on a7xx GPUs

Currently hangcheck and recovery are broken as the patches to make them
work depend on https://lore.kernel.org/linux-arm-msm/20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com/

The series also depends on https://lore.kernel.org/linux-arm-msm/177919116291.814652.1720687887970998122.b4-ty@kernel.org/
to work correctly.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
Anna Maniscalco (13):
      iommu: arm-smmu-qcom: Configure lpac device with split address space
      drm/msm: add support for lpac_domain in msm_mmu
      drm/msm: look for lpac from dts
      arm64: dts: qcom: sm8650: move smmu sid 1 to new lpac device
      firmware: qcom: scm: Configure LPAC aperture
      DEBUGGING: print contextbank and other ttbrs on fault
      iommu: arm-smmu-qcom: Fixed mapping between sid and cb for gpu and lpac
      HACK: use cb1 address in lpac dtb node
      temp: add LPAC regs
      drm/msm: initialize LPAC ring
      drm/msm: Add LPAC submitqueue
      drm/msm: set ctxbank and asid based on ring
      drm/msm: add lpac ring to devcoredump

 arch/arm64/boot/dts/qcom/sm8650.dtsi          |  12 +-
 drivers/firmware/qcom/qcom_scm.c              |  18 +++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 191 +++++++++++++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c    |   6 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  79 +++++++----
 drivers/gpu/drm/msm/msm_gem_submit.c          |   6 +-
 drivers/gpu/drm/msm/msm_gpu.c                 |  29 +++-
 drivers/gpu/drm/msm/msm_gpu.h                 |  17 ++-
 drivers/gpu/drm/msm/msm_iommu.c               | 158 ++++++++++++++++++---
 drivers/gpu/drm/msm/msm_mmu.h                 |   7 +-
 drivers/gpu/drm/msm/msm_submitqueue.c         |  11 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  14 ++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    |  37 ++++-
 include/linux/adreno-smmu-priv.h              |   2 +
 include/linux/firmware/qcom/qcom_scm.h        |   1 +
 include/uapi/drm/msm_drm.h                    |   2 +
 19 files changed, 492 insertions(+), 103 deletions(-)
---
base-commit: 9a967125427e03c7ebc24d7ad26e9307e8403d4e
change-id: 20260603-descriptive-name-lpac-upstream-730a164b105b

Best regards,
--  
Anna Maniscalco <anna.maniscalco2000@gmail.com>

