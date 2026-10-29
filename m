Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66C60A2600
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pVgcKbks
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649D310E11C;
	Thu, 29 Oct 2026 13:53:07 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7494F10E15F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:01 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1780384f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281980; x=1793886780; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tQ4bsfIGp4xsebuBqH7Tc36g3dw1OgT8NV+OEdsp1MI=;
 b=pVgcKbks+Aop7CFjfxbE5goQvQlZ+QLwEVoFK27fIziB/rNK1rwsePXPsR0Q1mZLqP
 HW54sAXIFfB8eLjoiWxesRwzYoTGFYtY3qC3l1YBrdBdZDQkXQGWxdhupP3kN5qUyLZL
 3yN7Er5O+NZce4+zaJwQYLiVdhkm1NpdcC5M2AlCWmV9HPHcp5hR5nTyEQMWwmLuGDEH
 GnIDPHiynYMxssOHDjcpradHz4SlICZ07X9Irb7FCrjqyzhpJg3mrMowjyrJOMbi1I06
 aU15c0LBqCi8CZ+dUHY3Hu1bYdIlRsRlwHOWE1MRqDe9CqF93okb7GLB1H90PKzR1jEx
 HtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281980; x=1793886780;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tQ4bsfIGp4xsebuBqH7Tc36g3dw1OgT8NV+OEdsp1MI=;
 b=Ye6RKKh6g6mKXdNjlowU+XhzktU4Wl1Pk+idSqOIVLJIsb9wiGaew02dOBalNHMX8x
 HkL+s2ESER0auBuOiC/Pe5DjK3GjpJigvvpew4dL0sy7Ob8ekjhPvPi1BD5hNlzhTzEA
 VYWFa8kn9luFbglZOj3O6Z8qzoO/JWirvlNt1bGttYB6x1mFfXxa9zIN9t8W3Y3/MXoT
 vw/0BApKn5pZdgWlAcoG4AcgpmYUD1nYyGSFuquBtEJuWzadPq32YoJk/IYEknta0Xii
 sdtRCN9R4j+ha639FwWXCYkkh54SEg0THTHhLXs99AtoUmYHu+o06DWlf22bKMnt9XT2
 5Ysw==
X-Forwarded-Encrypted: i=1;
 AKwUvBybjWtlzUIT5AGD2M/rOpeCp+YP2hSEB6UCCWvqkO/25I8UExdOKRfQxRFEKZBos++cUtnFnIAh4Nw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJqLJwiiEurUYaW8DPLuSegWal6COvf1DphP7UVxoOScbwLvL/d
 OVJZx6vgD37tIu1A8l0CXf4vXX5boJvwCUvac4hLURA4/XUliLgVjsk=
X-Gm-Gg: AYBFou1VJFXNE/lfaowivQHapxiRGgPgf1AZ0m/Uh1gv8RZJlu4rSzcqC1TEN5pgL6I
 m4iTJ1ttQAGE+/pCk0XysMPKvV4VdxyJBIT1rNE+lESSfoZ+HZHSm460zUCyPnD6YRkV7OPo9Ik
 ORBmE/m4wEH5MpZY/FdZpfY9bzOO+amwt/P58q4cpW+XIsuaTJycqILTu37dgioXVgLI9RIJOh0
 vDG5kLKfWeyIghrr6B4WKiH+i/d7Xtfwoqd9NYOmCgLRoVKmkLddv41BeBhkH0VyxPXzMaX2XZ3
 gHXyRc+t9GJ7M5lB+A5HRuY6pa2Zu6gPm9sYx/r1XHbGFpAWxkYid1TY7E/Q/Dya7/sVwftNGNT
 zindkPx5BCn0yMmxFTmnAgiyHV2P4INmYgk54u4njAYTi9/jqk4l6GDEfJysVUfBFKvLIzs34qx
 hQur6mK3I5Fq0ebfv2qRCKajx8AI3gF9Aq0JuUpb21x2p+/HEz8llgQNozeLx3GNHPGVJPrW0W7
 ICBiSdLBNe/2ha/5UKPZ6Ny93DgirWUIIuG7iPMSdHLAJzpepHN9cUn5+gSxRjNW3ybrk+Deecd
 Q04a6jk5EfHFMTtWFE1vChv1mWl3peVcLptt4fyVRD3l+Q==
X-Received: by 2002:a05:6000:2c09:b0:48d:db77:d124 with SMTP id
 ffacd0b85a97d-48e5d288b00mr13734288f8f.6.1793281979476; 
 Thu, 29 Oct 2026 06:52:59 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:52:59 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Subject: [RFC PATCH v2 00/14] Enable LPAC on a7xx series GPUs
Date: Thu, 29 Oct 2026 14:52:37 +0100
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOTQ6CMBBGr0K6dswUBIIr72FYlDLCGApNWxoN4
 e7ycwCXL3n53rcIT47Ji3uyCEeRPU/jBuklEbpXY0fA7cYixbTAAjNoyWvHNnAkGJUhGKzSMFs
 fHCkDZYZKFrdGYt6IbcQ6evHnCDzrk/3cvEmHfXU3evZhct/jQZS7d8ZKzP/FogQElG2OOiPUV
 fXojOLhqicj6nVdf8W7Nf/eAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=4469;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=p6wqA/jwxyIqcSTHnApGsgfvU2BLpE1567g9tFtfsQQ=;
 b=feq6ZOfAR+NU3cENzB30VH3PhCH4eAA7DfIpVH/eWChVnne9uIyAN6JEvD07bFsgYP9cOKFAZ
 rU7bVnDf59TAXD5riamSTbzdqszxnBeimsLpJilDn62PRDbkRrODEfs
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series enables LPAC (Low Priority Async Compute) on a7xx GPUs.

This allows to expose a separate queue to userspace that only supports
compute operations, in turn this can be exposed as a vulakn compute
queue by turnip https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/39889

Currently hangcheck and recovery are broken as the patches to make them
work depend on https://lore.kernel.org/linux-arm-msm/20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com/

The series also depends on https://lore.kernel.org/linux-arm-msm/177919116291.814652.1720687887970998122.b4-ty@kernel.org/
to work correctly.

It is still an RFC as something needs to be done about hang detection
with multiple rings first.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
Changes in v2:
- Made LPAC register writes conditional on lpac being supported and
  enabled
- Made LPAC a child node in dts
- Added a quirk to flag GPUs that have LPAC
- Hide LPAC behind modparam
- Several bug fixes (including addressing sashiko's reports)
- Link to v1: https://patch.msgid.link/20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Joerg Roedel <joro@8bytes.org>
To: Sean Paul <sean@poorly.run>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: devicetree@vger.kernel.org

---
Anna Maniscalco (14):
      iommu: arm-smmu-qcom: Configure lpac device with split address space
      drm/msm: add support for lpac_domain in msm_mmu
      drm/msm: look for lpac from dts
      arm64: dts: qcom: sm8650: move smmu sid 1 to new lpac device
      firmware: qcom: scm: Configure LPAC aperture
      DEBUGGING: print contextbank and other ttbrs on fault
      iommu: arm-smmu-qcom: Fixed mapping between sid and cb for gpu and lpac
      temp: add LPAC regs
      drm/msm: initialize LPAC ring
      drm/msm: Add LPAC submitqueue
      drm/msm: set ctxbank and asid based on ring
      drm/msm: add lpac ring to devcoredump
      drm/msm: gate lpac behind modparam
      drm/msm: enable LPAC on gen70900

 arch/arm64/boot/dts/qcom/sm8650.dtsi          |   9 +-
 drivers/firmware/qcom/qcom_scm.c              |  18 +++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 200 +++++++++++++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c    |  20 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  99 +++++++++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |   1 +
 drivers/gpu/drm/msm/msm_gem_submit.c          |   6 +-
 drivers/gpu/drm/msm/msm_gpu.c                 |  62 ++++++--
 drivers/gpu/drm/msm/msm_gpu.h                 |  18 ++-
 drivers/gpu/drm/msm/msm_iommu.c               | 170 +++++++++++++++++++---
 drivers/gpu/drm/msm/msm_mmu.h                 |   7 +-
 drivers/gpu/drm/msm/msm_submitqueue.c         |  14 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  14 ++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    |  38 ++++-
 include/linux/adreno-smmu-priv.h              |   2 +
 include/linux/firmware/qcom/qcom_scm.h        |   1 +
 include/uapi/drm/msm_drm.h                    |   2 +
 20 files changed, 575 insertions(+), 114 deletions(-)
---
base-commit: 9a967125427e03c7ebc24d7ad26e9307e8403d4e
change-id: 20260603-descriptive-name-lpac-upstream-730a164b105b

Best regards,
--  
Anna Maniscalco <anna.maniscalco2000@gmail.com>

