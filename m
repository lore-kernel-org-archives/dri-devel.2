Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E157606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UvkrjmIo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6280D1129CE;
	Fri, 23 Oct 2026 07:28:19 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A09A5112522
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:48:18 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5eac01ff101so675855e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 04:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792669696; x=1793274496; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BzvnC7BX4lHpgCzhnJO5oI/EjW4Sy80MjAmOtqEc83U=;
 b=UvkrjmIoi8TdGtD9zp35rtjT/Qz4DcSsNBRHaYC2ikaIBpJXrBYSKp0b1GKJIyJXZG
 XNJs1iQA7vO83tdft7HckuPy9WLIsxyk0wMNwMfjuajmWVDxhKjP4Kt/I8I/L89G1DEq
 F4F2X6Z5qqT1bv2Ejk9iwPwiG0En2nvDbuY068VRH0bLBvjT8z+4y7R6DlItn6vaSXLD
 7KltdZIX6Om3xPRjFpxdqly4DDUeByrhsDiuVm0GkfSgG0AXZNZcZZ5sctipeHb2ocA4
 XREtBlNLEkW3GxTI3d6LWpitqsQ2RdVr0RHIgBkb5zIAPycVF6uMnvoqDdiF3/Balh2Q
 yJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792669696; x=1793274496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BzvnC7BX4lHpgCzhnJO5oI/EjW4Sy80MjAmOtqEc83U=;
 b=PQq0F58N9iPP72ZNLM/1YXCxHPoCGSN+qG2ouXm7mH6idwdze85Gk5SWFLTw8FEz/h
 FtvTYuqVylT4RqCzSBqgT1/I41PZEc3bOcdDZsQie91JI3suR+j+YWDHf3J5ODURpGlW
 jN7XgGdF9BqBXTxDQ2jgMbdmfOPtk0ZhIdPVgAc7X1j1u3VvnoSXjKu0L/sIgyZ76eU8
 auArvxlSh2jEcOKhxylcqsacJN9N94b8x94f6H9mzhmLRrV2gKCznrG+bZC6jKEAn+As
 cSFfjDJGW7WtLlRAVl8zxb2xPV78HWaczr5RrBlmFBlBYdkuvsPnB8J+kPOkGCeNQAFx
 L9Xg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoDmILElQHLr2sby2kM9gMET/UFf2NbquZgomDfE/dqshtDspTa4KGVcbxljrA0balbqFyOUXDVAY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKSLldAhX17CsgFsnGN05K04sqRxxL8mmn01w/3PCGIGUIH180E
 FO8eJSVeuBE9uGi8W7UefkHbqCVL70Cv9fc4FMqD4OVEUE5/7LGevx+0
X-Gm-Gg: AYBFou16/zL2+wwJww0yRMdaWSX5c2XoPXqZ/GFzxRN8KU717yhgacEoLLbn1b+l01m
 s/sKrGVUUTsONsesb/1beH7ZuqmIk0x5V1sQQ6LDkuygq5Gj1ayTcXlBHEAy4QX6Qg1y5s0oR0i
 JSpGuQwH/+oTWFozFIjgB477BFizujBFCsV4aZwjfgNXPbWL0gwn307p6LEjMg4DwqIH/3e2e4p
 lSrSLYic+VXFvqATdC5yNr7zlOg8/GfPR+h/x41t2nNYS9R7/4uEnq39qKuHLEhZW69DqNR7ryC
 rS4A+Ko46BHO70FdNjjDaaFWxXUu8/fhGwScOlZ/fIod+E7+Ad4drFa7JfRPwX12g3qXznulwc8
 IGlARAn8UPGaSpQn4TWCIKCIpu7e3+iSOAvrrPjHPkoPG5KDi1HKSHGoDiIGLhIOziuDLzw5PFH
 jyd6A60h+mkrwGSSs2Ctf1GA/TceVjXWEOiwPCwp8uH0L2oTzuF1kUb0sGB9D1rCSsu/Ji9ZoFe
 ou1St6lMQ3kzbDl443GbKol96TPxZ4YHiChwDfBH1WD5Alc0GnpGCWsjZBow2aTfn6Ihic=
X-Received: by 2002:a05:6102:4498:b0:7cc:2712:cafb with SMTP id
 ada2fe7eead31-7cc926ac31fmr1668407137.15.1792669696418; 
 Thu, 22 Oct 2026 04:48:16 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.104])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d117c005sm6177793241.9.2026.10.22.04.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 04:48:16 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and Trinity
Date: Thu, 22 Oct 2026 08:47:46 -0300
Message-ID: <20261022114754.865669-2-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022114754.865669-1-mptagliari@gmail.com>
References: <20261022114754.865669-1-mptagliari@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:28:18 +0000
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

radeon_vce_fence_emit() ends every VCE fence with VCE_CMD_TRAP, which
raises the VCE trap interrupt (IH src_id 167).  cik_irq_process()
handles it by calling radeon_fence_process() for the matching VCE ring,
but si_irq_process() and evergreen_irq_process(), which serve the other
ASICs with VCE1 (SI and Trinity/Richland), have no case for it.

Add the same handling.  The trap interrupt is not enabled on these
ASICs yet, so this does not change behaviour on its own; the next patch
enables it.

The SI part was tested together with the next patch.  The Trinity part
mirrors the CIK and SI code and has not been tested on Trinity/Richland
hardware.

Fixes: a918efab631a ("drm/radeon: add VCE 1.0 support v4")
Cc: stable@vger.kernel.org
Signed-off-by: Matheus Tagliari <mptagliari@gmail.com>
---
 drivers/gpu/drm/radeon/evergreen.c | 14 ++++++++++++++
 drivers/gpu/drm/radeon/si.c        | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 3cbc6eedb..eb94916c8 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -4847,6 +4847,20 @@ int evergreen_irq_process(struct radeon_device *rdev)
 			drm_dbg(ddev, "IH: UVD int: 0x%08x\n", src_data);
 			radeon_fence_process(rdev, R600_RING_TYPE_UVD_INDEX);
 			break;
+		case 167: /* VCE */
+			drm_dbg(ddev, "IH: VCE int: 0x%08x\n", src_data);
+			switch (src_data) {
+			case 0:
+				radeon_fence_process(rdev, TN_RING_TYPE_VCE1_INDEX);
+				break;
+			case 1:
+				radeon_fence_process(rdev, TN_RING_TYPE_VCE2_INDEX);
+				break;
+			default:
+				drm_err(ddev, "Unhandled interrupt: %d %d\n", src_id, src_data);
+				break;
+			}
+			break;
 		case 146:
 		case 147:
 			addr = RREG32(VM_CONTEXT1_PROTECTION_FAULT_ADDR);
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 4681ff286..af3c4026d 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -6347,6 +6347,20 @@ int si_irq_process(struct radeon_device *rdev)
 			DRM_DEBUG("IH: UVD int: 0x%08x\n", src_data);
 			radeon_fence_process(rdev, R600_RING_TYPE_UVD_INDEX);
 			break;
+		case 167: /* VCE */
+			DRM_DEBUG("IH: VCE int: 0x%08x\n", src_data);
+			switch (src_data) {
+			case 0:
+				radeon_fence_process(rdev, TN_RING_TYPE_VCE1_INDEX);
+				break;
+			case 1:
+				radeon_fence_process(rdev, TN_RING_TYPE_VCE2_INDEX);
+				break;
+			default:
+				DRM_ERROR("Unhandled interrupt: %d %d\n", src_id, src_data);
+				break;
+			}
+			break;
 		case 146:
 		case 147:
 			addr = RREG32(VM_CONTEXT1_PROTECTION_FAULT_ADDR);
-- 
2.47.3

