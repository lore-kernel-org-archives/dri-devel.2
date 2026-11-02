Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F860A5BCA
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNOs8tDS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CACB10E5E2;
	Mon,  2 Nov 2026 10:19:03 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B137210ECCA
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:18:57 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so21933885e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 02:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793614736; x=1794219536; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8OBOniiOD3/1mcF69iMSsD8cgqxrlh2JCSuj6D5fJsM=;
 b=gNOs8tDSkVYQgol+slDCXVv6kxadW777Y3rfLDjyryFCndYOx9MuelBmzj8NhUD7Ul
 bpOgqUPMoIGE1GUcJMC1pw0KSyKo6olowysDe/vWt2UfzPvsSgjn+JHZh6kmlEZPCjv8
 GR9HJHsnmGikZlU4CPvyhuIHYOwmTaKmCqmiu/NWRuLTxi/dPFrM3wTNgkVSDk2dvFnL
 k2kaiZwJwagXtik7GCRt4IzHJezl0E3oJOZ0Dfc53reqNP/llJpz2TpbuimXlBXkXASm
 Ny24+ca5u2LmLp83BpGRAstaHveR1cVNFoamCWRK8hJrhcHHd6DKpJFuNQUgfBipM4fj
 z5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793614736; x=1794219536;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8OBOniiOD3/1mcF69iMSsD8cgqxrlh2JCSuj6D5fJsM=;
 b=2U6/CzifMhSrck0MSsYB5THnJQMvSxGi2LGQsjY9wFN/Os0Vvchjwo/c3xn7s9Algo
 +aDV2vUVY4ixfx6Pjf+m0gSsNpXTW2dz0LBmpQX8TLLF+6o9VjZ7skFgcHN2nARGGtmb
 yfdYDWDfz+h7X1hO6UjhBWMFB31Bw2afRyXwBmAmv6qUQp8O++SrEYSMdU4UMe6sPjtl
 oFGCH0zGwYQ22BGJxuwQwWRYbHa2V+8JiKGIQwEKxw8jE3fG8KuxT8jRRP2gFF4ImYCq
 FFlKnWc41g8qmm0ATBGnMOr7h1nAqpEUpEi9ro279Auw3cDf+atCh1Inxdr2UGxQHlz6
 tPPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBySBNYSLn9QAJlWN3yIVi8E/nzpUsi7TCPCHZYU9aevGXb1hnGUvv/AmM2kO5E7SvQeZY8pIxr3c2g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK32XW+g3VX6bAhxcdRfaeX6bCD/7ACRXT+S3lGz1Tk1FJWQljU
 B0SLN0eJcQWgi+PTP62+Tk3f/sznqoscV9L1emBU1RkstLjAbFF5vZwaevsmlaQO
X-Gm-Gg: AYBFou10NB9GSVuYPh0+vDXBJuncJr7LvocnPjL7oFdEd//i2BTDsDnhnoohomVEhx7
 RKMK/8sF26N8y6jnHrLF4YDVqNs8EJ3REUfTfQVZjugxTRlgWswaGGKA+4T/VE9BgtI+KwN8Ps8
 LBhvBkWxhalA9puKhQ3uvzFVIHHC1EBTonNFMDwfq2q+vr/RrZCs9Hb9UNLTgwH78C8ySJDCmgD
 l0GXycS0WG04aGCQUHdFR0aEN+RlarNhzTY61wn7TJXmZ2PcBfPwxc5OM4ssRY4ExOdfDG84dsi
 PNB5TsbbnbZY1Ee0LUQSUbspFJwtUQdaVEJ043H9uG0zUjR0m9ZK3uhgSK11kxaV+F6sJGQ+s+X
 vYi4uv7Bwvxd0D33SDbmlZPVPPNyZhXEViOTqdeAuHpbB5e8uB1ryd5PuQQK7kpqOfOVhZbkLqi
 xivtkLbxLOk7lZCDzNjCj1xdEu1TVNq2jtfRJfqbsOy4M1nDAcNLJ1e51BmY+38WR3BhydhU0wo
 /GK+lR5YrGLuYgWct+YB1cJ4KNnCokZuFBzxCLsXcWsrta2OUpPrHB4rW5eyAX4K0kotUvdM8E7
 NUCpou7uGGc7NNMgPdQhXK8K83kWpcBksjXc7Jmn2iJ4nQZF9CoCpZ6IWnbqa3F+42mZnxAcarI
 OpPS3ldR+g2boDQtD0D8XkFrTSCeQOAj/MJ8lvIO7r8cdX3lT+OS/6+bx8OLHjIg8cKzg/4N4
X-Received: by 2002:a05:600c:350b:b0:4a3:2f35:38aa with SMTP id
 5b1f17b1804b1-4ac1932bac0mr190329705e9.29.1793614735583; 
 Mon, 02 Nov 2026 02:18:55 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f322c46sm321930265e9.2.2026.11.02.02.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:18:54 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 02 Nov 2026 11:18:53 +0100
Subject: [PATCH] drm/etnaviv: Flush the tile status cache through both the
 PE and BLT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-etna-pe-ts-flush-v1-1-e4454ed86f85@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0auUrA30A6JeRVxUTTUgVZoqgnh3i
 8u3mHlAKDEJdOqBRBcL77HAVAqm1ceFkOdisNrWxmiLlKPHgzALhu2UFUPw2rjajW0zQcmORIH
 vf9kP7/sBFDvhz2IAAAA=
X-Change-ID: 20261102-etna-pe-ts-flush-ffa01363b98c
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
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

From: Christian Gmeiner <cgmeiner@igalia.com>

Since commit f232d9ec029c ("drm/etnaviv: fix TS cache flushing on GPUs
with BLT engine"), jobs on GPUs with a BLT engine use a BLT command to
flush the tile status cache instead of TS_FLUSH_CACHE, which is broken
on most of these GPUs.

GC7000 r6008/r6009 and GC8200 r6401 are the other way around:
TS_FLUSH_CACHE works, but the BLT command does not flush the cache.
The vendor driver handles these GPUs using TS_FLUSH_CACHE, but the
etnaviv kernel driver has no way to identify them.

As a result, dirty tile status cache lines survive the end of a job.
They are written back by the next cache flush, using the page table of
the job issuing it. If that job belongs to another process, the write
goes to the wrong address space.

On GC7000 r6009 this causes MMU faults and GPU recoveries blamed on an
innocent process. I see around 1100 per run of a multisample
depth/stencil test running alongside two other GPU clients.

Emit both flushes at the end of every job on GPUs with a BLT engine.
Whichever does not work on a given GPU is a no-op. Since dirty lines
are only written back once, this costs one additional state load per
job.

Fixes: f232d9ec029c ("drm/etnaviv: fix TS cache flushing on GPUs with BLT engine")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c | 40 ++++++++++++++------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
index 03b2576af67f..99c91a9eecf1 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
@@ -168,6 +168,17 @@ u16 etnaviv_buffer_config_pta(struct etnaviv_gpu *gpu, unsigned short id)
 	return buffer->user_size / 8;
 }
 
+static void etnaviv_cmd_flush_ts(struct etnaviv_cmdbuf *buffer, bool has_blt)
+{
+	CMD_LOAD_STATE(buffer, VIVS_TS_FLUSH_CACHE, VIVS_TS_FLUSH_CACHE_FLUSH);
+
+	if (has_blt) {
+		CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x1);
+		CMD_LOAD_STATE(buffer, VIVS_BLT_SET_COMMAND, 0x1);
+		CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
+	}
+}
+
 void etnaviv_buffer_end(struct etnaviv_gpu *gpu)
 {
 	struct etnaviv_cmdbuf *buffer = &gpu->buffer;
@@ -191,7 +202,7 @@ void etnaviv_buffer_end(struct etnaviv_gpu *gpu)
 		unsigned int dwords = 7;
 
 		if (has_blt)
-			dwords += 10;
+			dwords += 11;
 
 		link_target = etnaviv_buffer_reserve(gpu, buffer, dwords);
 
@@ -204,16 +215,8 @@ void etnaviv_buffer_end(struct etnaviv_gpu *gpu)
 			CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
 		}
 		CMD_LOAD_STATE(buffer, VIVS_GL_FLUSH_CACHE, flush);
-		if (gpu->exec_state == ETNA_PIPE_3D) {
-			if (has_blt) {
-				CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x1);
-				CMD_LOAD_STATE(buffer, VIVS_BLT_SET_COMMAND, 0x1);
-				CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
-			} else {
-				CMD_LOAD_STATE(buffer, VIVS_TS_FLUSH_CACHE,
-					       VIVS_TS_FLUSH_CACHE_FLUSH);
-			}
-		}
+		if (gpu->exec_state == ETNA_PIPE_3D)
+			etnaviv_cmd_flush_ts(buffer, has_blt);
 		CMD_SEM(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
 		CMD_STALL(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
 		if (has_blt) {
@@ -400,12 +403,12 @@ void etnaviv_buffer_queue(struct etnaviv_gpu *gpu, u32 exec_state,
 	return_dwords = 7;
 
 	/*
-	 * When the BLT engine is present we need 6 more dwords in the return
+	 * When the BLT engine is present we need 7 more dwords in the return
 	 * target: 3 enable/flush/disable + 4 enable/semaphore stall/disable,
-	 * but we don't need the normal TS flush state.
+	 * on top of the normal TS flush state.
 	 */
 	if (has_blt)
-		return_dwords += 6;
+		return_dwords += 7;
 
 	return_target = etnaviv_buffer_reserve(gpu, buffer, return_dwords);
 	CMD_LINK(cmdbuf, return_dwords, return_target);
@@ -422,14 +425,7 @@ void etnaviv_buffer_queue(struct etnaviv_gpu *gpu, u32 exec_state,
 				       VIVS_GL_FLUSH_CACHE_DEPTH |
 				       VIVS_GL_FLUSH_CACHE_COLOR |
 				       VIVS_GL_FLUSH_CACHE_SHADER_L1);
-		if (has_blt) {
-			CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x1);
-			CMD_LOAD_STATE(buffer, VIVS_BLT_SET_COMMAND, 0x1);
-			CMD_LOAD_STATE(buffer, VIVS_BLT_ENABLE, 0x0);
-		} else {
-			CMD_LOAD_STATE(buffer, VIVS_TS_FLUSH_CACHE,
-					       VIVS_TS_FLUSH_CACHE_FLUSH);
-		}
+		etnaviv_cmd_flush_ts(buffer, has_blt);
 	}
 	CMD_SEM(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);
 	CMD_STALL(buffer, SYNC_RECIPIENT_FE, SYNC_RECIPIENT_PE);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-etna-pe-ts-flush-ffa01363b98c

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

