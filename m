Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4C606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHu9LVa4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAFA610E00C;
	Fri, 27 Nov 2026 08:29:14 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED0810E848
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 10:37:15 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3b43d30822fso3675426a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795689434; x=1796294234; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M/yk3Rw+nb4AIlTzNbRnpuuYhSg7gPe5Ia3PULum9P8=;
 b=mHu9LVa40PH8qd1854MGcfNY7mL4nhlAe9qK7iWqZha8AjiiDusTZkXChecg+CNoIV
 Hu2ZaMIYRfUScagqYIPFvjvyN2qMuyLotOqsG0SytZ+pQ4I4ruySv4bnQJAxTZur44Jd
 kEyA0zGWI2jzy5lTSeLwb5Hwuf8slN294I4CZvHh4lOWQA9pfcvBsU19ANxznZEuK8NP
 4VYE5lL8eYM0PBuZ/ZkqweACv9nT+T8p4xHOO6yGJPhfB+MaUfsQSaGDCOczS/sd6hxQ
 Im4CUr0EBO2xoAE/P4X3cuZ86mQZixL88Q3XawkJawMt/UH13XqJvlcNC0LRpa119070
 qPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795689434; x=1796294234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M/yk3Rw+nb4AIlTzNbRnpuuYhSg7gPe5Ia3PULum9P8=;
 b=MHBwueYiD8kSPQouhK9hq9EwWiF+m0LKmnxFJ9dD2Hwcqs9CnW9BEnifAqTU9Ijik8
 2leZoPDPNmkxbRmfjmWHFAPCq70fUq8XiPS8H/K20HMhFC0TJGdha74NLfIj3g9+Emyh
 ag+Mo9x4HBkWe9w9nXCukwmi1M8HaqiNoStV4PiojYn7Ns0Kau0LSNgJcsF9MGBI93LJ
 TccAWSx3yMceIJYiGx11bLn1lLF7U5qnFR29p+D5KDKiyiOYmyf9TIHjq9GpaPRHZ9UI
 7mYn9Jyhyi/m4k3+6kKoKF/i5aRcse+0OnmgoTQalQaklve8CHiQ0oWWzmI2cXzMwFWf
 g5WQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHexAkDWLEOuP08wnIhKpfVPFVu2DNuEC928tFT8SeKuKnytvUYFMp9t5CwBC8wTa0vAoPyKqpWKgw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+JMxWsnt82+MDjOP/PRd25DMA/RzInfdJ+qR4HaMgAudJmcqYq
 cKzarO+T/IIdOONVNZoC/gYaUwk0U4vOGj+htMdc+ficui02CAQQZnxl
X-Gm-Gg: AZFdTZcFqffABYrKD27G508hDDTvMqqiV1AcgLTLMDibdfNH+U7LWJd/81i9yT9gzSX
 5rL2u6FblmA41H6dJEK9hPMQDD6m9jpHgqYQvQbhyNgSdjPJ/CMdM+fg4knViMPoyL/kWKAvfQD
 2ZR1rCLjJTomJd3QrJ8XAxg4ft4cYGcWo3Zn0YpSUh4QUddUXR97p8ATsQmneErzH4PhHFubr//
 GT8dMkFIPP+WE5op3pC9m44z6x5BsyuVPUiaXUIyqhyqMjRt0Pzo//mDPHlN+DzpROGBdIGyW2j
 gH5T68iHKBm21XqoOLYG6Cj4EruBJfNceITeaNleHDq+brr+zQNzHgdYZbCAu8Y5MRm4pLUaPtk
 Hf0ZMVDgQEsgN804RbVWUx5/TSaY3lLY6oXmQnesfQLVEkSfVdLRPxvo5HvFuVvrHpZiqzhK2E1
 hjNboD344ayPFP9IXnpml1tIr4d5a3mcM8oUu/kj+UvnqhOJifpdjSr/KxTDl6RcDT4alMAHbPG
 L4mWlFwgcSPK531gtEc6C+KxBX/+19N2xfhEQmfIk5z0jNhuHaWy+669qsZSovj2TV72X0nBBhf
 YnSu2bwj22Feidf9DsXlxHOjSQOyK7vnUCR75RJoNqnYZXngbTuh6YQOercDPsJaKV5CsrChMpP
 YMKeHKWFarJTaWMWvlmFmWZC4DwtX7dg=
X-Received: by 2002:a17:90b:4983:b0:3b4:1357:d529 with SMTP id
 98e67ed59e1d1-3b41c97c444mr20610837a91.51.1795689434219; 
 Thu, 26 Nov 2026 02:37:14 -0800 (PST)
Received: from DESKTOP-TPPBPA1 (36-226-201-204.dynamic-ip.hinet.net.
 [36.226.201.204]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d135e9sm34846229a91.4.2026.11.26.02.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 02:37:13 -0800 (PST)
From: Roy <rongh7426@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Roy <rongh7426@gmail.com>
Subject: [PATCH] drm/vc4: plane: Don't log LBM and UPM allocation failures as
 errors
Date: Thu, 26 Nov 2026 18:37:09 +0800
Message-ID: <20261126103709.655707-1-rongh7426@gmail.com>
X-Mailer: git-send-email 2.51.1.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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

vc4_plane_allocate_lbm() and vc6_plane_allocate_upm() run from the
plane's atomic_check. When the line buffer memory or the BCM2712's
unified pixel memory can't fit a new state, they return -ENOSPC, which
is the expected way to reject a configuration that needs more of a
limited resource than is free. They also print it with drm_err().

That lets the DRM master fill the kernel log with error messages just
by testing configurations with DRM_MODE_ATOMIC_TEST_ONLY, as a
compositor or an igt test probing plane limits does. On a Raspberry
Pi 5, 1000 TEST_ONLY commits of 18 full-screen planes add 1000
"*ERROR* Failed to allocate UPM entry: -28" records, and the same with
the planes upscaled 2x adds 1000 "Failed to allocate LBM entry: -28"
records.

Use drm_dbg_kms() for both, as is already done for running out of UPM
handles in the same function. The messages are still there with
drm.debug=0x04.

Tested on a Raspberry Pi 5 (Raspberry Pi OS kernel 6.18.39, with this
change applied to its vc4 driver), counting /dev/kmsg records around
1000 TEST_ONLY commits that fail with -ENOSPC:
- UPM: 1000 records before, 0 after
- LBM: 1000 records before, 0 after
- with drm.debug=0x04, both messages are printed from
  vc4_plane_atomic_check

This change and its description were written with the help of an AI
coding assistant (Claude); the testing above was done on real
hardware.

Signed-off-by: Roy <rongh7426@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 20c9fc9..81df567 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -958,7 +958,7 @@ static int vc4_plane_allocate_lbm(struct drm_plane_state *state)
 		spin_unlock_irqrestore(&vc4->hvs->mm_lock, irqflags);
 
 		if (ret) {
-			drm_err(drm, "Failed to allocate LBM entry: %d\n", ret);
+			drm_dbg_kms(drm, "Failed to allocate LBM entry: %d\n", ret);
 			return ret;
 		}
 	} else {
@@ -1028,7 +1028,7 @@ static int vc6_plane_allocate_upm(struct drm_plane_state *state)
 							 0, 0);
 			spin_unlock_irqrestore(&hvs->mm_lock, irqflags);
 			if (ret) {
-				drm_err(drm, "Failed to allocate UPM entry: %d\n", ret);
+				drm_dbg_kms(drm, "Failed to allocate UPM entry: %d\n", ret);
 				refcount_set(&refcount->refcount, 0);
 				ida_free(&hvs->upm_handles, upm_handle);
 				vc4_state->upm_handle[i] = 0;
-- 
2.51.1.windows.1

