Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63B606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JmRRneZH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E6710E3FE;
	Sun,  1 Nov 2026 11:58:12 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158B110E208
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:28:15 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-353804b591eso1780746eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793392094; x=1793996894; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mL5Q/qru/61qA3CeBuTxFCjV0LvdujInnspbH7ZeU+E=;
 b=JmRRneZHUtRlQd7i94O9VPzRgRNuTXLKRXw1oxEkIEDR3ppoSeyMGIMp/i9evUvtk/
 EnGsm8KI9C3DPXa2+y+oD6KsShcApn1ojSdFuDOfbdH1hqPuDdD7tQHzI+rkr+WP35+T
 /rpwuySvqCymaUX3XdYgaXroJg2DhcUHfTlZg6Ocv+cOjoXRda+fls/6lI2KWEijsY+3
 kBH6btgNkAUbWtuJ+AuP/qJ3e1TYeeqZbw8GONkMl/Ai0QG6Wpv29yPZyw1oc6S+4d8/
 3jONnUoxnyDTk1O+xTcc5zHvT3xVOBc7A+Ga8sqc0J5BSuGWt57upxiohycaFHxpVXfV
 35aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793392094; x=1793996894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mL5Q/qru/61qA3CeBuTxFCjV0LvdujInnspbH7ZeU+E=;
 b=yR3FrJgllwNOxrgPJZuYHEs/cxxDRZU1PAqlk8txnx3lAWgUbKV03UjPqIrVi6E86a
 xk1Bj6qiT+ZL09fJPvOvqL3kpj+5/CeOWQPK11qv9mkanR+n7EbPF/5xvP2xiKtEqdsX
 I4x6OP4AgiaFhNS+w0xG8VztbwYKjWcy2S/n/kCzrgB0RrBLIYuMXl549pyKYoFnpfXB
 Np0XhmuvZhYOBmnMfeDw/2lI+NtMojtrkdWSZvyYup3V1octVt4QtIdmAIzqaulzPtP4
 YVvzJd8XgTEYh00Hnd4ajO369r6g2Z3uqG+Y38yMYEgnspT0niW2iufVLQR7Xoukikgf
 bkoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFAJiNNDgE1L0wDGn20h9HquRJz5KzlZSqvX8LyXz8/1uzbHESlTn+6KwrMF8g5HPn6mdpHnRXilU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIBA1PegBcnrziuA02Y8o2q+55eGQ1iGWBcc2PNm7eeAJmeHcMP
 RQHwCQBjcBylTye/tC5L+T75v45rgZvQ1iU5UmByfDBsxn1AVg5s8gum
X-Gm-Gg: AYBFou3NE0HAITdv3rl+CyjfBkx70gdNg/7IDTJayOloTBiPU7yx0UOzhrBdDfBBuDu
 1x87D3a+ac1L/IgSCuDTYr0TiHfTGbOCCJBxu68Z2Yqg6Fz1f0z8z/gKLKGyKlp+DCcd4wgiy2b
 Li5nQA8ccHkXqd/9dHxMcZ3gvup7fa2mSN3Brd+LQSh0QF3JGpm2r+A7XKtGWfEjX7pqkW2FUfr
 1GV2R9O3e/1AcJHfMMT0FYFqUgrNRKXJJ92t1SHHz95Nsj1906MIzdn+1qILCD3DFJYQnBcAkyu
 8AMLklK3GUlkUgtwStd0CCjt93p5u7teRdVdk2x4J8nLD7uID3//8tYihaKTuIUucGmBSSmJNZJ
 JJbX9uaVb2E/fsJ42wtBAeoAfeuBSETD8CqGnlc2RQkMt7Q4n+VR0hEEVOQEqm9QqLMtEvidfHm
 pmpOkyRFc/xOoNSAg0tvNMUmek66HJoGEwMF3MijsmBBYkSYDP0zCiUthA52UoszYZiI3i2O2AH
 WU0nmwsQwWWAPXlN7nJ8As5bTD5xfaTPqu9eXgfyU6IPpWQvEYHm5I/a5+eOPvLxFw3wgicmhDz
 i0o4q5oBfDyKqujpk+EZcCa5rngg/m+TOZeYLp8=
X-Received: by 2002:a05:693c:41d4:10b0:35c:99e1:c755 with SMTP id
 5a478bee46e88-36a4242c0e1mr4738625eec.38.1793392094038; 
 Fri, 30 Oct 2026 13:28:14 -0700 (PDT)
Received: from munique-a520 ([2804:3bf0:fe29:ac41:2d94:706:4bfd:852e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a61a0csm10976489eec.22.2026.10.30.13.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 13:28:13 -0700 (PDT)
From: Munique Feitoza <muniquefeitoz4@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Munique Feitoza <muniquefeitoz4@gmail.com>
Subject: [PATCH] drm/nouveau: Fix CE channel creation on pre-Kepler GPUs
Date: Fri, 30 Oct 2026 17:28:09 -0300
Message-ID: <20261030202809.28723-1-muniquefeitoz4@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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

Commit 04e0481526e3 ("nouveau/dmem: Fix privileged error in copy engine
channel") changed nouveau_accel_ce_init() to unconditionally request a
privileged channel (priv = true) when calling nouveau_channel_new().

However, privileged channels (func->ramfc->priv) are only supported on
Kepler (gk104_chan_ramfc) and newer FIFO implementations. On pre-Kepler
GPUs that expose a Copy Engine runlist, func->ramfc->priv is false,
which causes nvkm_chan_new_() to reject the channel creation with
-EINVAL:

  nouveau 0000:01:00.0: DRM: failed to create ce channel, -22

Specifically, this affects:
- Tesla GT215 (NVA3), GT216 (NVA5), GT218 (NVA8), and MCP89 (NVAF)
  using g84_chan_ramfc (GeForce GT 210/220/240, 310/320M/330M, etc.).
- Fermi GF100 (NVC0), GF108 (NVC1), GF106 (NVC3), GF104 (NVC4),
  GF110 (NVC8), GF114 (NVCE), GF116 (NVCF), GF117 (NVD7), and
  GF119 (NVD9) using gf100_chan_ramfc (GeForce GTX 400/500 series and
  Fermi-based GeForce GT 600/700 series such as the GT 730).

As a result, drm->cechan remains NULL on Fermi GPUs and TTM buffer moves
in nouveau_bo_move_init() cannot use the dedicated hardware Copy Engines
(COPY0/COPY1), falling back to M2MF on the main graphics channel.

Only request a privileged CE channel when device->info.family >=
NV_DEVICE_INFO_V0_KEPLER.

Fixes: 04e0481526e3 ("nouveau/dmem: Fix privileged error in copy engine channel")
Signed-off-by: Munique Feitoza <muniquefeitoz4@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5e1336615..0a15f1281 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -337,6 +337,7 @@ static void
 nouveau_accel_ce_init(struct nouveau_drm *drm)
 {
 	struct nvif_device *device = &drm->client.device;
+	bool priv;
 	u64 runm;
 	int ret = 0;
 
@@ -349,7 +350,13 @@ nouveau_accel_ce_init(struct nouveau_drm *drm)
 		return;
 	}
 
-	ret = nouveau_channel_new(&drm->client, true, runm, NvDmaFB, NvDmaTT, &drm->cechan);
+	/* nouveau_dmem copies require a privileged channel, which is only
+	 * supported by Kepler and newer FIFO implementations.
+	 */
+	priv = device->info.family >= NV_DEVICE_INFO_V0_KEPLER;
+
+	ret = nouveau_channel_new(&drm->client, priv, runm, NvDmaFB, NvDmaTT,
+				  &drm->cechan);
 	if (ret)
 		NV_ERROR(drm, "failed to create ce channel, %d\n", ret);
 }
-- 
2.56.0

