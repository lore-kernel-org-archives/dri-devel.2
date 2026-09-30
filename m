Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20659CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DB610F36D;
	Wed, 30 Sep 2026 12:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WSCweCiP";
	dkim-atps=neutral
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD88210F1DE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:59:18 +0000 (UTC)
Received: by mail-pj2-f38.google.com with SMTP id
 d9443c01a7336-2e2da4743b0so2504665ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 23:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751558; x=1791356358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MxNiWg+dHE1TqlcRBrYL3310bHI3Y0J25afbuRgW4f0=;
 b=WSCweCiPU/f91Cda4Z8mNbULwogP+sgN027pg9/ajuGDWK5ESIRk4qo8AC1W+9+cFN
 GUWxaw6KDbUtELMUlDkB3XK8zWSg1YMBBgQvht5k/IrNTQwbBKATHD8G4N8fRgBY9nix
 IPwk2PiIV8lNBbJ9pKGoH3bsHrIg8ZO5B6aUGIbVI5Lkev+xbtIujAEOywLRe0sY7dwA
 S697G1RMx1EUifzuFJXIguGhdTtuGONwQ4XTCo+N3SsRmo7Y/OHEQ06FjQRVkJAye8lA
 qH2BfyROoKdGHUwxKiGTPPTHzdH4z+1P8bVKxy7WBO2rPZnnUxGBX/al/NoJryMN5+py
 DduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751558; x=1791356358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MxNiWg+dHE1TqlcRBrYL3310bHI3Y0J25afbuRgW4f0=;
 b=Oj7hJBTyfRBWmmFm5CtnI232JcVUANw6t9vo4L4DbjhDdE4F7+RBfpXJqF5sA8DkFP
 qOIEvq+0GfXaZltebKh50eLNwZX/OFDmzNm1vj5PfNwnZrGwf2xVtbQehbPAhHc4O6OK
 zclI5kygop1YRrQAg6L93PsXAOYlKTXAn7DT0HKUe0IU+JIzI7FTK6VU/poobdb9UQp3
 nwpS/x9V2VPFpJw0/cCc3pvaImE7g/YPO73tQBWohM88bFyxej1oFAZW3Yk4hwV9xqz7
 kkVyWDjLp1/DCnKnsc//lljo3gEJkVycl5XqV0tKZ05ClAiy2kk2s1XrzL8SyniX7DZY
 +Idg==
X-Gm-Message-State: AFq9FYIK8uCx55uLnG5R35FsgRZ8Uz1q2HRNvT3EePL1Z9+fI2J/k1pB
 TMzUuDQkX+FbscAUOLWP8R2TkVTYYTKYTISjRecJFqbn8CrcUvytVAWq
X-Gm-Gg: AYBFou00nO95uy3rrokd9bVseAUz0IOips9FFgAIvoQ0C6WjuIhl2dFfimUg63q2bmK
 V96Swp/pNsk68+HDIe6dDNYKWSNg2MYYlTACi++qU1Fk2NHTes2uU4cj6TBsee54IwGtKz0iDhr
 pfMbA8ohfevQQYvou/QCv3/Re1a9Ok2PpxRxmaPxs19kQ+dKoKk9wXXwbXLAZvY2wCuFr2quXbL
 kXzkk1bZ1i9vp/uLRo/eJd0O2S74HTsz022T5mqf9QTPKLNA0pp4HDq+IvkUUj3WFOgnXDJbTcm
 sHYRwnSg625bUipK4tngmINpiaB/Q/jMAAHGAynkTAdSRIfyvnwcMcw40YAjgCpeIFjOn9dd18W
 Zhb/Ct7FGaG42TFEUVpcP5uiVTFOw9XFX/8m4QXrt/zgDEOGEuqPz9bzCGBfSPsrs7pr3YA/1Kn
 z8z5bpyWQ3DrGxaiVSr98o8eT11Ufj+OVGzraxJtkh0rio4e7lop/llB1Nf/o4N9GgyjbHa1hwi
 aXTtMJcQNQQGFPbSEGmSyFzr4vWqaW06ifX+CKePWuCBk7USwyaFFwKWmyqJp7CuFe5mAosZn+Z
 rOLSFKzUpQ==
X-Received: by 2002:a17:90b:1811:b0:3a2:bb9f:f87d with SMTP id
 98e67ed59e1d1-3a4d2803bdcmr293672a91.21.1790751558335; 
 Tue, 29 Sep 2026 23:59:18 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4cae9ffaesm2010442a91.16.2026.09.29.23.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:59:17 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 2/5] drm/gud: Align both x1 and x2 to block_width in
 gud_flush_damage()
Date: Wed, 30 Sep 2026 06:59:11 +0000
Message-ID: <20260930065914.393939-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930065914.393939-1-benquike@gmail.com>
References: <20260930065914.393939-1-benquike@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

In gud_flush_damage(), applying ALIGN_DOWN to damage->x1 without adjusting
damage->x2 causes the rectangle width (x2 - x1) to become unaligned when
block_width > 1, breaking rendering on block-compressed display formats.

Align damage->x1 with ALIGN_DOWN and damage->x2 with ALIGN to ensure the
resulting rectangle width remains an exact multiple of block_width.

Tested in QEMU against Linux 7.3.0-rc3 with R1 (monochrome)
block-compressed format damage updates: on the unfixed kernel damage->x1
alignment alone produced unaligned rectangle width (x2 - x1) causing
corrupted block flushes; whereas with this fix applied, both x1 and x2 are
aligned to block_width, maintaining exact block-aligned damage bounds.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index aa7792966287..f8726e3d849f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -327,7 +327,7 @@ static void gud_flush_damage(struct gud_device *gdrm, struct drm_framebuffer *fb
 {
 	struct drm_format_conv_state fmtcnv_state = DRM_FORMAT_CONV_STATE_INIT;
 	const struct drm_format_info *format;
-	unsigned int i, lines;
+	unsigned int i, lines, block_width;
 	size_t pitch;
 	int ret;

@@ -335,6 +335,13 @@ static void gud_flush_damage(struct gud_device *gdrm, struct drm_framebuffer *fb
 	if (format->format == DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_format)
 		format = gdrm->xrgb8888_emulation_format;

+	block_width = drm_format_info_block_width(format, 0);
+	if (block_width > 1) {
+		damage->x1 = ALIGN_DOWN(damage->x1, block_width);
+		damage->x2 = ALIGN(damage->x2, block_width);
+	}
+
 	/* Split update if it's too big */
 	pitch = drm_format_info_min_pitch(format, 0, drm_rect_width(damage));
 	lines = drm_rect_height(damage);
