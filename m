Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E4B606CD23
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CjGzuKDS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4277F10E21C;
	Fri, 20 Nov 2026 18:10:30 +0000 (UTC)
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45FB10E21C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:10:24 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id
 5614622812f47-4b28d9537bcso780670b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795198224; x=1795803024; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1U0puyPddAK/k0CBoSD8bUy1ngE3FQLTiHGb9GIY5PM=;
 b=CjGzuKDSQ81zl4eBUhXYwRXgD2XDpzFw7l1WQZf6dgdM5jIzz1EQ/RWUlHSA4/6aje
 RBIlcLiFZ/eY53MiksS6zPAeguku/PSmJdJL4kUiEbVAYV/C85hc0Wl+l5G9Yoz5/2Uf
 gK0z8cNJOp7wpTyNITfvCsEjQRxen/qFsY3vHSat/t7shUMnbiwolNiT32oTGv7XGEZx
 REDU3SOhsbcdS+t00efWyfJ1iV9VctPyYEccDxvxqPZyZlyiYrecyIC7j98tTgID1sHo
 TA3ImBvFUXhMu98RhPgYc2Ll5Ia1idi433gVpDll7Y8KvMz8YwzlGZG6OehECwEVi5AW
 EXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198224; x=1795803024;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1U0puyPddAK/k0CBoSD8bUy1ngE3FQLTiHGb9GIY5PM=;
 b=LhbqlM70c2a2fTik59KzHm5wGwkgEsCNSHLSyFuspHhyI/bEt+xr0AZrijDsp2Ewws
 B9MjsUQrx8fJ+tYiMxuTP2BNQoeHEnZDJhZIbNuCIXPE1hMAwpv+HkdghEHS17m7AXJL
 vweLXZnK/WDnjylJD/1ZXghP8MTa/2mMEiL1pwuBN/uFrXS6UV5Ymsb44OBNXkJYm8m4
 vu0tK7ituicG22G2DUNG9quGJgXvCEY9GVQe2Lb/yoOZ9CyEg64uw6whXkIV8Bgp9YE4
 Lk4vgstFsEaw/EYIdWyaCSRNuz96ie0B2cq01PL/4bYv5eHRgRLgWg19MmBhgyxtJctJ
 TwqQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHHqllxZ54fNamnPIWRzNa09dFojEZgahOCfyAkoeK5LxXucjXiwUG4KUbmqE1rL3ckm+yCjPDsac4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/VFOOdsnIT42kGyBJ6X9BUHD4cuKPonXMUq7eDjpOtO22bRej7
 4AmBJoSuyfs3Zpn9/9R5F94joCX3mcbaRDvFyAEmmwrm+v0qW236hR9u
X-Gm-Gg: AYBFou3FuMQ8AalHROZQ1s0YsNYNh14cTMVEyFjV6O/turdm5pGk0SXL5hP8RDXZS9P
 Ln4UmZCT+OMJQBDmjLurLwNC25jMXnYHGMmhAPd9i4URBFRnBDk0N6Z0iLiKnDENArSBgIjgSbH
 7A6hQXS6iwdENl6b9qcxOPHsDPtrxAglQ5OGHFBd5xpL8RRD/ruZ9SsqnFxyY0s88TPUsydqNMN
 T8FeUIoIBTIqFN2G57OW3PDCvXTkrIVfjYQ95+aMFpO+0NUvnGBCKO964QscSjU3nj7AmV4w3B4
 fKmYJSpo8D8K+0Q5d4xjgkA3SKDwghNOZXmvdtrWLFPqyek/D68qBnU/kYChGFEz1/OGhBB1Ne8
 V3oLTOv5EeGmCWMFG2VXZIe0z18XPk40VfUwqjAbr1ILaTiXf3by2CoztoIHcBQiUBVgGHQF2P8
 jg0yDgPPcP+keJvUjj4clOJuibXx4L++REjMO+ZmHEbVYxyjCmyV2dL/QSpf43HtUoZ9ZAue97U
 qMY8Mp/uSAFjq2Vq7uxi+qKZMt2Q+vuojnQy8zn8mTXU4z/YTMxO/zxw78xmDY+nuY67oi7vYVG
 jsNTp0twUlcXEUOMUskTN18vIAixL9zYvMev6Z6FkIZYxfA2hUFhRwO3n+ED7nQRRYMA3QK/1ZH
 kZtZE6xJSHZKPHtzzdAua/0q4xbaaft8wZ3oWApZB
X-Received: by 2002:a05:6808:e85:b0:4dd:f8bb:e1bd with SMTP id
 5614622812f47-5797bb9f526mr4100230b6e.13.1795198223670; 
 Fri, 20 Nov 2026 10:10:23 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net.
 [64.207.253.118]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc6108104esm3310383fac.14.2026.11.20.10.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:10:23 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Fri, 20 Nov 2026 12:10:21 -0600
Subject: [PATCH v2] drm/imagination: Fix the value of
 ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-rbrue-suez-pvr-compute-overlap-flag-v2-1-ca2b0d3adb4e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/5XNQQ6CMBBA0as0s2aMRUVg5T0Mi2kZoAnQZgqNS
 ri7kRu4/Yv/NogsjiPUagPh5KLzM9QqzxTYgeae0bVQK8jPeaG1LlGMrIxx5Q+GJGj9FNaF0Se
 WkQJ2I/V4KaqbZTIVmQIyBUG4c69DeTaZgsHFxcv7QJP+1f/+SaNG4tJcS9L3tjOPfiI3nqyfo
 Nn3/Qt2kCcm1gAAAA==
X-Change-ID: 20261118-rbrue-suez-pvr-compute-overlap-flag-3695ceab9ab6
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Brajesh Gupta <brajesh.gupta@imgtec.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795198222; l=2520;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=hzVweLQWGGnWgZbDJhzZq3hPf28CyuB7MpyqTw8FFOg=;
 b=0o+bvH90wEF2XntpIVzQMXCFEt6HJ+4fJF6Ul3mujWKykchEVKx1X1zs7uHyExO8r+821BE2Z
 RFvPMyQygIKBfuQBY6OLYOPkMuwCJmkXWEPYn76OFTtv4nUtE7S/NLq
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The firmware takes "prevent all overlap" from bit 1 of a compute
command's flags; bit 2 is FORCE_TPU_CLK. The kernel has used bit 2 since
the FWIF headers were added, so the firmware has never seen
DRM_PVR_SUBMIT_JOB_COMPUTE_CMD_PREVENT_ALL_OVERLAP.

On a GX6250 (MT8173), a compute job overlapping fragment work from
another context hangs both data masters. With every compute job
submitted with bit 1 set, a test that hit the hang on every run no longer
does; with bit 2 set instead it still hangs.

Fixes: a26f067feac1 ("drm/imagination: Add FWIF headers")
Cc: stable@vger.kernel.org
Reviewed-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Found while chasing GPU hangs on an MT8173 tablet (GX6250, BVNC
4.40.2.51) under Mesa's PowerVR Vulkan driver: a compute job running
next to fragment work from another context hangs the GPU, and Mesa's
request to serialise compute never reached the firmware.

The value comes from Imagination's firmware interface as carried in
Mesa (src/imagination/vulkan/winsys/pvrsrvkm/fw-api/pvr_rogue_fwif.h:
PREVENT_ALL_OVERLAP 0x2, FORCE_TPU_CLK 0x4), and the board confirms it:
forcing bit 1 into every compute command stops the hangs, forcing bit 2
does not. The other compute, fragment and transfer flag values in
pvr_rogue_fwif_client.h match that header.

This patch was developed with the help of an LLM.
---
Changes in v2:
- Add r-b, and Cc stable (Brajesh)
- Link to v1: https://lore.kernel.org/r/20261118-rbrue-suez-pvr-compute-overlap-flag-v1-1-ae8b48a17dfb@gmail.com
---
 drivers/gpu/drm/imagination/pvr_rogue_fwif_client.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif_client.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif_client.h
index 6e224400083a..967e903bdca6 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif_client.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif_client.h
@@ -74,7 +74,7 @@
  * Flags supported by the compute DM command i.e. &struct rogue_fwif_cmd_compute.
  */
 
-#define ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP BIT_MASK(2)
+#define ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP BIT_MASK(1)
 /*!< Use single core in a multi core setup. */
 #define ROGUE_COMPUTE_FLAG_SINGLE_CORE BIT_MASK(5)
 

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261118-rbrue-suez-pvr-compute-overlap-flag-3695ceab9ab6

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

