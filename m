Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B1606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GkJc9mnV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B2B10FE98;
	Thu, 19 Nov 2026 07:53:03 +0000 (UTC)
Received: from mail-oa2-f8.google.com (mail-oa2-f8.google.com [74.125.231.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3839A899C7
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:19:57 +0000 (UTC)
Received: by mail-oa2-f8.google.com with SMTP id
 586e51a60fabf-48f1c6a7779so291817fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795022396; x=1795627196; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O2dV0dR6P4vtfkdK4//qQQNUz+8h8vIYbdZZXYxh3Lc=;
 b=GkJc9mnValMQdNHYMYEEfzE4QbFgiSxzqe3sXf5GCCjBkGTQ7bxGTCG+qjuAufpg2D
 YWttU6i76H5Nw242ucFd6JuhYPO7xJ0QXrbCbtq52yPBVwmGdUBVXK0tpSTKRUnHhrdP
 oSKrgi31zoMebXMVbHp8YEcJeQ/l1jnkSWz8wfbtPJcLn3S/Ik1zLPI+4e8FqlTj0pAs
 3WTBKQGSadaeSoXyjR7qVzZnQ2BQkX/GPT2CGHJwnQc68nC+zZGo3e3wvuqHh6EtFa2q
 3BoMu4DUjpI0gjVnML6b5zBighavgqnCxrbqL55cmxBBsaW78hOW9rqmUF4JvTp/BUWJ
 iU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795022396; x=1795627196;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O2dV0dR6P4vtfkdK4//qQQNUz+8h8vIYbdZZXYxh3Lc=;
 b=1DhZ05uLzyqg9iruuFv5X8QAGdm2jphL1CAkY0n/vpuDym2Q2l0xsjGXhQfz+lxUVq
 2lD3EbYS+qY8HljY9ofYqhtby2Vu6fm+tXYvVGjmSpUX5FRDdIsYu2sxbk6Gf+LZfqPL
 ZFF2hUtJ8YewSfedQ/jXO1ZKgBEHJSExzmiV2PhBAzQBwKTIe17yzkufXrZl9Zf3t4QP
 0cyaBqXMzbjJ7MyK69oz625Ubx+VG6NBvMW8I8G0N2bBTsDOo5Icz6WQHKeyA+0nVNZN
 d2Q0+uyX63JECzsmXUJA/K3jA237bd5nvXJQn/KcDC2cPHjkJhC/nMm8u159Kbpq9zHs
 ZJgA==
X-Forwarded-Encrypted: i=1;
 AL+hErFdAE4gMPfwT7bg422jSyi/ZxlfndMn/L6qZt3tjktLTk3jSD3j1G8FiBqD8RiA3av6RnupRWvGhDI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+hQ6cO9ttOpXmftgwkxZSnfQZTh5oTI/35O2hyk+OdLJrgvN/d
 eg6LAPD2FyQkIn/Y9RDUZVqz7mz2coPga/YqBGwfhf76n0NNZnqG7zRXzHl47ap0eljLcw==
X-Gm-Gg: AYBFou2SmYZBkiMarR+JySQq4zDbJwkSDKYxP5tPhqF63dOKvmLquRzeMS0a+rJBdXW
 jRil2lBF/3kgO8lQS2RLnEZJv+6CpGHW/gBAbkVLM5YRKl+4ubVZqUlecp7YFY3odYQ9AV0+B0Q
 F+DRCeZL0mKx3D1K+tfrtu5hqv4QbEnvblM/mc0lyIel6RhB7Z29BNFpJzJis8576qvMpnGAxP0
 Ky4vjSBl49IBe9QcvyzTzlyOAtSmnhOZLhph9g2b0y41yD5C7duS3lAJ1WcRYb/ZkjSyRl9fG8O
 U4TUyrgAiSJ4EaAKpGIaVzsC7I8YWL7rMuksa4xuiLxJZx3uXCvauysn9Tr82cczIozjGazuMsD
 DXnz5ibOHxvGHlZIQCYRud3Yt21XhaCyewReYac2c5C7oHayO7C8avAgZ7UUKCEQTTpk+Mnu5fh
 E4BPC7dC73ojWhdlzzboCRaieqRgj3p8CmL4o64WHJ6avwr8yhDFwkX+p6ROrYzDShdlkmU1iIX
 0DfMr70aRvafB2soA/bLky1LYqmABtZD4++knCzfiQJ6ddcWutslggIgMto7HAfu/WGw27Lai2w
 Qhw/S4fPBHmqiGnUGxA1e3nKm//ctrXeN7YS0TVW/HKqMlJDylHJosfRrN9LV0FIaNhtwXSN7cK
 0EpN1WpJCuTjHMnsFhPo=
X-Received: by 2002:a05:6808:150e:b0:53b:11c7:2da0 with SMTP id
 5614622812f47-5773c0286e4mr3393933b6e.21.1795022396284; 
 Wed, 18 Nov 2026 09:19:56 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net.
 [64.207.253.118]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b744313514sm3043034fac.9.2026.11.18.09.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:19:55 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 18 Nov 2026 11:19:53 -0600
Subject: [PATCH] drm/imagination: Fix the value of
 ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-rbrue-suez-pvr-compute-overlap-flag-v1-1-ae8b48a17dfb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3NUQrCMAwA0KuEfC9gJxbXq4gfac1mYK4ltUUcu
 7vgu8DbsYqpVAywo0nXqnnDAG4ATE/eFiF9YAAcT6N3zl3JojWh2uRLpRul/CrtLZS72MqF5pU
 XOvvpkoTjxNHjAFhMZv38l9v9OH7K2pv3dQAAAA==
X-Change-ID: 20261118-rbrue-suez-pvr-compute-overlap-flag-3695ceab9ab6
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795022394; l=2266;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=V64Hl84PRxafvZ8Tibe5F2+9arQu5Px78eRgalqp2ow=;
 b=tRr23gjLrKL5ReWDABPeacqi7sRGYJbrixALAGlHLJsMbalFHIhMGNupP1KN5x+OaBez8VOrY
 iNod6/otK5CClbqc2ua3xaUp6R4KxNBuFhu2v592aHm3BkvWMnbBkta
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:53:02 +0000
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

