Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67410606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jz82Vd2h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE66710EC83;
	Mon, 26 Oct 2026 08:37:24 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C0310E3B0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 18:24:25 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-846566246e8so2093055a34.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792952664; x=1793557464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/T7fiSPlKiLhGhZT4rMc/42F0EceA/cMU4biTXFIUI4=;
 b=jz82Vd2hmLJ34Rd2DhLJQtsqpx8Zwd30MzNwIQhf11HOirvPv40QpJ8ODinIMEstHE
 WGDB0tAMNX+vjSslyzbYT8JC28RTjmVyMvqcuxR8v6fXwc7KaO4NwUQaHdUqnLmhnRn3
 kUd+aJ+BBiC51L4zFNRUuwPDA82wFXzdC/ssECyVdoqqzSxkykVsvYkKaJ/ZfR+sj95w
 juulVQFDypBG5mI6o3iHyCsnhZC6tW1jPKVwYsyz3465CrZJp/HVvS0QnDm9xm3be3dG
 f4cKAvcsa4t0Q4tzfkd80Mu8BM0Cm0XweLj6s/Z6h2VRt/TdkGnuGdd/JVIWkB4OZR1I
 mgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792952664; x=1793557464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/T7fiSPlKiLhGhZT4rMc/42F0EceA/cMU4biTXFIUI4=;
 b=XmC8K5wykjbvVa7xXyJIuAFoZA71m5VhAxxCSflik+9Gqz0yiGVmuipAZtiwpxWHfH
 WAXqAP0K0UrK+nTmnSPlioZ6cmk7555+7vjcJfSrU+aHkPXUpVYkDUy251NBNKq21rxF
 0wIPijukYeOXh1/T/E8PMLgq2WyrhqD3rn9Vnh03SnR8EqfLJK3mInqRSS2FU5ahwQZR
 1zgCgzUEUPPD4hB+MDqRRFJ6FhseR/Hu5QdyoB5gLjccQnPXCWTpRknc4sN6lRE8Gww2
 JzYy3HztqviDQL/xudAO2CQ5tz9fFBIVArUIIAhf6Z0dB5ceS4m1HU8lKQDEQdRZLSGM
 oarA==
X-Gm-Message-State: AFq9FYJeM86XwbNQUZgYGkbrE8aV15NcVYJ1W8R6enh59lpxwBycaTG5
 1gt6G0r/2WrnlJkdMusbxZMnzHZhiuQE8MNIdfvOAQ25L1cM4lUU7D4+
X-Gm-Gg: AYBFou2IvlbByrOaFuLZTQRHW5XP3igER+t+6f3IXykvkiAUk1CzeABLAyGl3iUh+9z
 5xGkcRqP/uohivKJKRaWUVM/Ym6lpsYIp4IORcKoHrFM6citCxgXJHmUDEhFLaW0k0/1T8jtpAS
 MCbz8I5d4Cj1HOO9HvfG8vxXa2txGDXJjGjub4cYC5a9d2DrHxoMJSvu1+6Ci8OtPcYV4+euE2S
 xL/fo0Ersif7E3YZ3QntO417v7hTRUMmedGY3my/vEX1R34LgiT1hgj9Evii8K1dHe+gcxMby40
 2GeNLCp6RlnSCYnbplevJiW6CyFpvZzQL6QVwqtZQFEBn2I/o0RjgWs7gRXBlCLZJaz0wCbmDt1
 aJgUYCebMu4C4nK0z1EQxjl+Tyl5ZEGmm6FElDor0+CwP2VsH6efAytOwAAmEVvQObMeEKTdRgA
 zJc6A/6wyT1JmsFoPd0wcX+0UR7qMkY14IJOYsPtUzW2XckWOmr+EAjjtb37IxUm/gYUGZjzEZZ
 zd1g5wEiGIxHWd9zB2IxhJL9bVotoz3CO1hfUdM5FzHFFJWCbWq4FrIIjwmn35Q0OguOgqqlSBX
 wjkQIO95FEgPuej0coa0qXBsFXZIjupBXnby
X-Received: by 2002:a05:6830:2317:b0:843:a64b:6e3b with SMTP id
 46e09a7af769-850ff0a576fmr2804000a34.32.1792952664554; 
 Sun, 25 Oct 2026 11:24:24 -0700 (PDT)
Received: from localhost.localdomain ([72.12.197.23])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fa99bd27sm5396324a34.7.2026.10.25.11.24.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 11:24:23 -0700 (PDT)
From: atipre <tipreaditya@gmail.com>
To: igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	louis.chauvet@bootlin.com
Subject: [PATCH i-g-t] tests/kms_writeback: Check CRC capture survives
 writeback
Date: Sun, 25 Oct 2026 14:24:20 -0400
Message-ID: <20261025182420.52258-1-tipreaditya@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The existing writeback tests validate captured framebuffer contents, but
do not keep pipe CRC capture active across writeback completion. This
misses the VKMS bug where writeback cleanup disables the composer while
CRC capture still needs it, leaving subsequent CRC reads waiting for
samples that never arrive.

Add writeback-preserves-crc. Complete the initial modeset before starting
capture and establish reference CRCs for separate red and blue input
framebuffers. Keep capture open across four alternating writebacks, wait
for each output fence, and compare three fresh CRC samples with the
corresponding reference after each writeback. Use atomic updates without
ALLOW_MODESET once capture starts, and release capture from the final
fixture so a failed subtest also closes it.

Check output fence status in the shared wait helper so a signalled error
fence cannot be treated as a successful writeback.

On ARM64 QEMU with one and two CPUs, the new subtest fails on unmodified
mainline and passes with the local VKMS composer-user lifetime
fix. Four existing applicable writeback subtests pass on both kernels;
the two XRGB2101010 subtests skip because the format probe rejects them.

Signed-off-by: atipre <tipreaditya@gmail.com>
---
 tests/kms_writeback.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/kms_writeback.c b/tests/kms_writeback.c
index 7c30e8e..71317cf 100644
--- a/tests/kms_writeback.c
+++ b/tests/kms_writeback.c
@@ -64,6 +64,10 @@
  *
  * SUBTEST: writeback-pixel-formats
  * Description: Check the writeback format
+ *
+ * SUBTEST: writeback-preserves-crc
+ * Description: CRC capture remains active across completed writebacks
+ * Driver requirement: i915, xe, vkms
  */
 
 IGT_TEST_DESCRIPTION(
@@ -317,6 +321,7 @@ static void get_and_wait_out_fence(igt_output_t *output)
 
 	ret = sync_fence_wait(output->writeback_out_fence_fd, 1000);
 	igt_assert_f(ret == 0, "sync_fence_wait failed: %s\n", strerror(-ret));
+	igt_assert_eq(sync_fence_status(output->writeback_out_fence_fd), 1);
 	close(output->writeback_out_fence_fd);
 	output->writeback_out_fence_fd = -1;
 }
@@ -537,6 +542,7 @@ int igt_main_args("b:c:f:dl", long_options, help_str, opt_handler, NULL)
 	igt_output_t *output;
 	igt_plane_t *plane;
 	igt_fb_t input_fb, input_fb_10bit;
+	static igt_pipe_crc_t *pipe_crc;
 	drmModeModeInfo mode;
 	unsigned int fb_id;
 	int ret;
@@ -709,7 +715,63 @@ int igt_main_args("b:c:f:dl", long_options, help_str, opt_handler, NULL)
 		igt_remove_fb(display.drm_fd, &output_fb);
 	}
 
+	igt_describe("CRC capture remains active across completed writebacks");
+	igt_subtest("writeback-preserves-crc") {
+		igt_fb_t blue_fb, output_fb;
+		igt_fb_t *colors[] = { &input_fb, &blue_fb };
+		igt_crc_t reference[2], crc;
+		int i, j;
+
+		igt_skip_on(data.dump_check || data.list_modes);
+		igt_require(data.supported_colors & XRGB8888);
+		igt_require_pipe_crc(display.drm_fd);
+
+		igt_create_color_fb(display.drm_fd, mode.hdisplay, mode.vdisplay,
+				    DRM_FORMAT_XRGB8888, DRM_FORMAT_MOD_LINEAR,
+				    0.0, 0.0, 1.0, &blue_fb);
+		igt_create_fb(display.drm_fd, mode.hdisplay, mode.vdisplay,
+			      DRM_FORMAT_XRGB8888, DRM_FORMAT_MOD_LINEAR,
+			      &output_fb);
+		fill_fb(&input_fb, 0x00ff0000);
+		igt_plane_set_fb(plane, &input_fb);
+		igt_output_set_writeback_fb(output, NULL);
+		igt_display_commit_atomic(&display, DRM_MODE_ATOMIC_ALLOW_MODESET, NULL);
+
+		/* Finish the modeset before starting continuous CRC capture. */
+		pipe_crc = igt_pipe_crc_new(display.drm_fd, output->config.crtc_index,
+					    IGT_PIPE_CRC_SOURCE_AUTO);
+		igt_pipe_crc_start(pipe_crc);
+
+		/* Establish both references before writeback can affect capture. */
+		for (i = 0; i < ARRAY_SIZE(colors); i++) {
+			igt_plane_set_fb(plane, colors[i]);
+			igt_display_commit_atomic(&display, 0, NULL);
+			igt_pipe_crc_get_current(display.drm_fd, pipe_crc, &reference[i]);
+		}
+
+		for (i = 0; i < 4; i++) {
+			int color = i % ARRAY_SIZE(colors);
+
+			igt_plane_set_fb(plane, colors[color]);
+			igt_output_set_writeback_fb(output, &output_fb);
+			igt_display_commit_atomic(&display, 0, NULL);
+			get_and_wait_out_fence(output);
+
+			/* Require fresh frames without stopping or restarting capture. */
+			for (j = 0; j < 3; j++) {
+				igt_pipe_crc_get_current(display.drm_fd, pipe_crc, &crc);
+				igt_assert_crc_equal(&reference[color], &crc);
+			}
+		}
+
+		igt_plane_set_fb(plane, &input_fb);
+		igt_display_commit_atomic(&display, 0, NULL);
+		igt_remove_fb(display.drm_fd, &blue_fb);
+		igt_remove_fb(display.drm_fd, &output_fb);
+	}
+
 	igt_fixture() {
+		igt_pipe_crc_free(pipe_crc);
 		cleanup_writeback(&display, output);
 		igt_remove_fb(display.drm_fd, &input_fb);
 

base-commit: bb76404eac7032ba85c53eac15b76e4fadaff0de
-- 
2.50.1 (Apple Git-155)

