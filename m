Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80C6082BE3
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBNyqRFU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4C210EC63;
	Mon,  9 Nov 2026 09:31:34 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A26310E189
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 18:59:59 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8b600fae14dso68741b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794164398; x=1794769198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:from:content-language
 :subject:cc:to:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UQnzYFxAOJKkpWtTfKgcH4cjgDxirCXKastrMn3uBO8=;
 b=sBNyqRFUeBR2WOUbsPnLlvByYCZ4FJFz8sh0dB0yn9SQ+5o900qEWrkmAuFxQLJHb3
 noDUtqtYzmtFSlHkqT2Y3GzwYC5GhQvrZNQR0utRtJnCJJ4LNCtOgjFWITCtZ19JS02X
 msetf8H3zYwX3zlYKcr4SpqnRAZHlA8rD2hPQMMAjRlxEzTFxgwQqbQkosAX2E16wZRU
 CgyEOpuLI3oPkR+qmhleocN3eJzdnuikX2XLlI7uTKsACwut7WgCuXGaNs40CWPtH06u
 UK5DjUFHQ0kR6rkxifdcnQWmedUK5IKaSocxZXVc37HxZuVgdymtI+OOFelAedoYvlsn
 uRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794164398; x=1794769198;
 h=content-transfer-encoding:content-type:from:content-language
 :subject:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UQnzYFxAOJKkpWtTfKgcH4cjgDxirCXKastrMn3uBO8=;
 b=nm4N4tpBZ0A8UdoLVwMnACxXZB4OANmwvS2OLaZe4C0a8R6Gu19QD9OTj3uNQHfEID
 0RhCQExPUxkKaaEO210615cimz0UxX01G4BflKpy7UIlYt9kRMhYh+G4LYjy1EDg6EpO
 5iy7Mp3oMyZPV8MzEVCO1SJEtEHhJmSamG6iwkkW9jtkORjoaQMKHxMAb82iE4cd2Vau
 llN4TDBmQASH4mtY8xJsKP1Y7PElVEzrrrDfnEdPyAYqUCMRX+PZi9C+A8UgVWlIt7tw
 qXciQrTzDRvRhQBw+dXNGN2od6t5UCqPVTG5/h0oCqSbQ3kKe2+rNRASG7NRA1fqcGdu
 Zokw==
X-Forwarded-Encrypted: i=1;
 AL+hErE1OxGDah7qyZ2IUpgc9A8l0Vm0EEfJkXQ4+NA7qe97jJgfaOYolXgg14qrTV5jv+b5hRSsuwEUr5I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2dm23yB/EJLGJQNygbkBwhzhgU0zeWWGNvfiE+CdgPRsbT6zN
 8Gmaag+Iu/F9jL71I3DYpBBP6IQwSz3Nvgx9q+3fqTlnS3Y+TOhMluVC
X-Gm-Gg: AYBFou2Pt5cE6r7gaTkSm/wYrikdwDB+JDGXXsa9zZsJkeFlt9pQ/oc7KYy7Eepkwqp
 t8dPYoi2SwABhAtPRBzSRanaEXJmBuJNpPzyDrgMgGT3BsqZqcgV8t5cB96YIa6J2NQyw58/sO1
 xe52Z4ESYvN30Fxb0LF1SgLYkWQ8zNxo5voZlIg45mCc3uooLt/oNDd8FLeJPDGT3Y4IUDaTpx3
 1Xjw8lpSx22LkK556XDhohx7f5hKIkAPbjrxf2riFNuGbLpGwVpbPyAWxWGYgibEHCkpBNhvc8o
 MuMvmEfiA3F8htz8+qT8V051UGajjrTJhHMgPhcgZcc1ZjRHQwIqgA429PRzBYdtRuO5uReyO2n
 3mtMRLWF1FfU1YDTEdtau+yAy4gBi1+qsCe+DL17MGo+zVsQzuhpR4C8IUBMv69lnwUOM/jnU3q
 h9MnyrPyLGW8MYLI86L0d3GNOg5pOQ4qKZ5u87EWZyBSiujWVtNEMO27LhHUL2wIOyA/xmeipu6
 EIKYUNeuOjw+jT89xcUkqeASw0bP+CRbCF/PUYaR6auJVzfzS2xZIEOcWz8ZI4Mga9pdxzO0Zc0
 wk7Nlov1GLLoXIJwF68vSHFV1FPfdHWsyJP/Wdq1nIC/wCgwR6veRcm5qnT0DaYfsJeid4M+mUd
 luRVFkOR9Ipt2WlqU9JXFkq0Q5Ts=
X-Received: by 2002:a05:6a21:387:b0:3de:b95:d50f with SMTP id
 adf61e73a8af0-3eed3325c6dmr1872479637.24.1794164398328; 
 Sun, 08 Nov 2026 10:59:58 -0800 (PST)
Received: from ?IPV6:2001:569:7d38:200:979:7485:a7c:55d1?
 ([2001:569:7d38:200:979:7485:a7c:55d1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b646bd4430sm621609b3a.5.2026.11.08.10.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 10:59:57 -0800 (PST)
Message-ID: <e1823bda-ff83-4e9e-8e81-b2d0ea5c05ac@gmail.com>
Date: Sun, 8 Nov 2026 11:59:56 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915/fbdev: Preserve visible size when reusing BIOS fb
Content-Language: en-US
From: Zheyu Shen <arsdragonfly@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When reusing the BIOS framebuffer, intel_fbdev_driver_fbdev_probe()
overwrites sizes->fb_width and sizes->fb_height with the framebuffer's
dimensions. These become the visible fbdev resolution.

If the BIOS framebuffer is larger than the mode selected by the fbdev
client, fbcon consequently uses more rows and columns than are visible,
leaving console output outside the scanned-out area.

This occurs on a Broxton ZimaBlade 7700 with an MPI5001 panel connected
through DP-2 via PCON. The firmware provides a 1280x1024 framebuffer,
while i915 selects the panel's preferred 800x480 mode.

Keep the visible size requested by the fb helper. The larger BIOS
framebuffer is still reused, with its dimensions exposed through
xres_virtual and yres_virtual. This matches the fresh-allocation path,
which also preserves the requested visible size.

Boot-tested on the affected hardware: console output now displays
correctly while the virtual framebuffer remains 1280x1024.

Claude (claude-opus-5-5) assisted with patch preparation. Copilot assisted
with commit-message preparation, building, deployment, and validation.

Fixes: d978ef14456a ("drm/i915: Wrap the preallocated BIOS framebuffer and preserve for KMS fbcon v12")
Cc: stable@vger.kernel.org

Signed-off-by: Zheyu Shen <arsdragonfly@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_fbdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index 219ee17de3f6..5c043172a35c 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -324,8 +324,6 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	} else {
 		drm_dbg_kms(display->drm, "re-using BIOS fb\n");
 		prealloc = true;
-		sizes->fb_width = fb->base.width;
-		sizes->fb_height = fb->base.height;
 	}
 
 	obj = intel_fb_bo(&fb->base);
-- 
2.56.0

