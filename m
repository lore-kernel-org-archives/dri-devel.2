Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D248CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 19:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6199910E55D;
	Thu, 14 May 2026 19:49:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z/AT92+f";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4210D10E55D
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 19:49:53 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso6839769f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778788192; x=1779392992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q9/6gW0M6Uv9EyNb5SxqRKZXb6/yE5Hd9XtK9uuQUhM=;
 b=Z/AT92+fBzQ7bYLnS+U8clFmoroop06wJFvN7qRDe5ZtLqnxKqHBpBRI9KnNNCLwJ7
 gG2ohWRJ7WAAtRaKNujUlEA4ctufFcv9aJt37toTQNFvTa4sddQYLBRhK7uMSZsK9s+c
 92zLF9XyrYw7N8ArnRveBI1reDn7dxnyETcFmFolegKjgI+NvUpjaGMNUgX/j+Slb5wn
 4ZMx0akFoOgX+qLA1EosyrjkUSwdjxiXd1JLFLVM4wXUI1uQZ+2or0AueEOPhHaqesVM
 BxaQrf08cb7CoXj+zeoeORmrIi/AYvbn7O5+uUoTGWJ4kQGmKUd98Pznc+iyGTzN4WvI
 yeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788192; x=1779392992;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9/6gW0M6Uv9EyNb5SxqRKZXb6/yE5Hd9XtK9uuQUhM=;
 b=e0kqWABv9c1QRPg7HxbYcOgbs5FQMs2g9/wG7sE8kMZweSpJ8nggpvEuWG6rGskHkJ
 obQfFYB+9UOj08tmCNc9G8HZaOsBocYnBMtw4RSDOsAfs5GGovGCVxBAKkGXefgjRDMA
 Hj+/eUfeYJd3hhQt6+ylBStHM1VXWjZjFlE0ssFknfNwpKAYDIJJawxfHzrel/Tt/Jvv
 yoe/Hv+NVWsmk3Nh2xU7JnDDCa8c6GGatBRAytdmUYVji2CXETGVhwR0rkraSlwcOwat
 1CsEa2xiicUORm3yJ0oxwx42pfUhslhbuRyWWKiJOg9YvcQjwastE6FH6Omn1qBNkSsd
 6xWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jQis+yMqpdJIvJ9R2EQQhOTmx98mU4+sc/CMN+R3yF0Z9woXCm+DnManIlb9pqBaL5fEVbGoKDD0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQphg9t5ni5cVhUTAlH7fvQSySFmtvZ03vQ65bLC6D1bAotCil
 olyGpHraRHnOA8xgsUFlGL4DBzUsIGfnp0bUpmjCjiHEQzUMwend5DTa
X-Gm-Gg: Acq92OFmbg3fkFiDtD4/l2xu8Ft6FGcDVTnJwCraeTJtz+KpA6B6pulY7lh9s00dWy4
 /GS2lZMy2sdg6eEySib//zeNnmXRryk3UcpiIlXrBx8KOhJb9lvBiDz4h4henbAnLHSFm8XypFM
 GCgkArJJSm0NA3nAmzLpp8ah2UqV1uOxbOhYYsTrpS/my0GaAhplYczNVANatV7SGDZjvvCUgMk
 +7AH9qPUn8S80Qfnn9q0K5c0Jc5eej0DrVD2JRvOQvDuf05HqM8EhfunJ86CT5BjpOwrMq9w8QM
 FuiITuUXkYycOb0ZaHqSbQd7xQstt5fwuceJLWKWy38/0qGV+wmHJgFW0DQgNJkOs4xpIxQ9U5X
 rZXyN/D5bfoZYNJOu/XcWs3+2CM8aPoAemHzP8xDLDAOKaf6GUp99hWG8kQne3iSaoQVpCClPmJ
 MHbrxEb4z1KmxCusNroRHx3LeTEVEqy0gZZcrlWoj5iJM+9NnT
X-Received: by 2002:a05:6000:2f8a:b0:43e:a73e:cc98 with SMTP id
 ffacd0b85a97d-45e5c58d529mr698372f8f.23.1778788191454; 
 Thu, 14 May 2026 12:49:51 -0700 (PDT)
Received: from fedora.taile3bb89.ts.net ([151.245.116.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm9135127f8f.8.2026.05.14.12.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:49:51 -0700 (PDT)
From: Ahmed Elmetwally <en22ue@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ahmed Elmetwally <en22ue@gmail.com>
Subject: [PATCH] drm/amdgpu: clamp user gartsize against device capacity
Date: Thu, 14 May 2026 20:49:37 +0100
Message-ID: <20260514194937.35649-1-en22ue@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When the user-supplied amdgpu.gartsize= module parameter requests a GART
aperture so large that the resulting page-table BO cannot be allocated
from VRAM, gmc_v11_0_sw_init() aborts with -ENOMEM during the kernel BO
pin in amdgpu_gart_table_vram_alloc(), which fails amdgpu probe entirely
and leaves the device without a /dev/dri node.

The GART page table is 8 bytes per AMDGPU_GPU_PAGE_SIZE-sized page,
i.e. table_size = gart_size / 512. The table BO is allocated from real
VRAM. On small-VRAM SoCs (APUs with stolen VRAM -- Strix Halo at ~1 GiB
is the case at hand) a user-supplied gartsize that produces a table BO
larger than what can be pinned in VRAM is silently accepted today and
only fails far downstream.

Reproducer on Strix Halo (gfx1151, 1 GiB stolen VRAM):

  /etc/modprobe.d/amdgpu-tuning.conf:
    options amdgpu gartsize=262144     # 256 GiB -> 512 MiB page table

  dmesg:
    amdgpu: [gmc_v11_0]*ERROR* GART aperture is needed by the driver but
            no memory has been pinned for it ...
    amdgpu 0000:c6:00.0: amdgpu: SW IP initialize failed
    amdgpu 0000:c6:00.0: amdgpu: sw_init of IP block <gmc_v11_0> failed -12

Recovery requires booting with amdgpu.gartsize=N on the kernel command
line -- i.e. the user must already know the cause, from rescue media,
with the GPU offline.

The user-supplied gartsize is a tuning hint, not a correctness
requirement. Compute the maximum sensible value such that the page-table
BO fits within real_vram_size / 8 (leaves 7/8 of VRAM for everything
else), and if the user value exceeds it, log a warning and fall back to
the per-IP auto default. With this patch the same modprobe.d entry
above produces:

  amdgpu 0000:c6:00.0: amdgpu: amdgpu.gartsize=262144 MiB exceeds device
    capacity (real_vram=1024 MiB, max sensible=65536 MiB); clamping to
    default 512 MiB

and the device probes normally.

The helper lives in amdgpu_gmc.c so the other gmc_v*_0 backends can
adopt it in follow-up patches; this patch only wires gmc_v11_0 because
that is where the failure was observed.

Signed-off-by: Ahmed Elmetwally <en22ue@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 47 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  6 +---
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -330,6 +330,53 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
 	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
 			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
 }
+
+/**
+ * amdgpu_gmc_validate_gart_size - clamp amdgpu.gartsize against VRAM capacity
+ *
+ * @adev:        amdgpu device (real_vram_size must already be populated)
+ * @user_mb:     value of the amdgpu_gart_size module parameter (MiB),
+ *               or -1 for auto
+ * @default_mb:  per-IP auto default in MiB
+ *
+ * The GART page table is allocated from VRAM and sized as
+ * gart_size / AMDGPU_GPU_PAGE_SIZE * sizeof(u64). A typoed or mis-pasted
+ * amdgpu.gartsize value (e.g. 262144 MiB on a 1 GiB-VRAM APU) produces a
+ * page-table BO that cannot be pinned, aborting GPU probe. Cap the page
+ * table at 1/8 of real VRAM, warn, and fall back to the auto default.
+ * Returns gart_size in bytes.
+ */
+u64 amdgpu_gmc_validate_gart_size(struct amdgpu_device *adev,
+				  int user_mb, u32 default_mb)
+{
+	u64 want_bytes, max_bytes;
+
+	if (user_mb == -1)
+		return (u64)default_mb << 20;
+
+	want_bytes = (u64)user_mb << 20;
+
+	/*
+	 * page-table BO bytes = gart_bytes / AMDGPU_GPU_PAGE_SIZE * 8
+	 * Constraint: page-table BO <= real_vram_size / 8
+	 *   gart_bytes <= (real_vram_size / 8) * (AMDGPU_GPU_PAGE_SIZE / 8)
+	 */
+	max_bytes = (adev->gmc.real_vram_size / 8) *
+		    (AMDGPU_GPU_PAGE_SIZE / 8);
+
+	if (want_bytes > max_bytes) {
+		dev_warn(adev->dev,
+			 "amdgpu.gartsize=%u MiB exceeds device capacity "
+			 "(real_vram=%llu MiB, max sensible=%llu MiB); "
+			 "clamping to default %u MiB\n",
+			 user_mb,
+			 adev->gmc.real_vram_size >> 20,
+			 max_bytes >> 20,
+			 default_mb);
+		return (u64)default_mb << 20;
+	}
+
+	return want_bytes;
+}

 /**
  * amdgpu_gmc_agp_location - try to find AGP location
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -416,6 +416,8 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
 			      struct amdgpu_gmc *mc,
 			      enum amdgpu_gart_placement gart_placement);
+u64 amdgpu_gmc_validate_gart_size(struct amdgpu_device *adev,
+				  int user_mb, u32 default_mb);
 void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
 			     struct amdgpu_gmc *mc);
 void amdgpu_gmc_set_agp_default(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -708,11 +708,7 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;

-	/* set the gart size */
-	if (amdgpu_gart_size == -1)
-		adev->gmc.gart_size = 512ULL << 20;
-	else
-		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+	adev->gmc.gart_size = amdgpu_gmc_validate_gart_size(adev,
+				amdgpu_gart_size, 512);

 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);

--
2.45.0
