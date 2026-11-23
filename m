Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C156606A33F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojhQNmFD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8740010EC36;
	Mon, 23 Nov 2026 16:20:59 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F4910EC36
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:20:53 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso40060345e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795450852; x=1796055652; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t89LhzLisMCNxYeOykwfFUDFLNVUHJz2Tt5nBABIp9s=;
 b=ojhQNmFDDx0Jgtjd58OCAFXBjIhhalIlO+bentJxNHPDBz6MzJe4qzwmm35JF1tVqh
 B9TZDd9/31G580TKW7xE6mGpbhGWQPKEgcR2QsKQxmNwcn2zmbvbCMC/WShzf/bKznfK
 KsCKxtw4E6OcG7j/1fqPQD7v81lV6rPYu5YG+IF4fsduYqbG3vjVpExDZF/JX0igAHIZ
 aFwjR1Hm0R9f/2/AfCGMCNNK6qug29hPMBt0cQpSALHY6SFNH6u8eUD+EvabSHazbk7Y
 /Cw2cljcuIX42eqwvq1DyJKh//Zq6Jmy/DpI1Y1bKm/hMmOikjHcfzRQvQHkWqxXjO2y
 O43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450852; x=1796055652;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t89LhzLisMCNxYeOykwfFUDFLNVUHJz2Tt5nBABIp9s=;
 b=Xt5DHu5orl2tykqPTEa2IXpZAHGNI1MjKOCd6CYxUSvRBSkN6/7r9cSKMbNBcQTxPH
 2UN4AuDOSBVWMXcWP83Jp55XoV6Tsnzj5C5wbdlSSWMmG58PnDxr7rag9zE5QEjwXYwY
 Flbg3JPCclxRC+e716aM9boC1/QanLrYJcCgO7W18MOz+Gelu2AI8d/6xgyWgJNX++DN
 vdK2J3dpATkou3hHVuFhucFlk7Jufh0QfiGhVK33F0SOJiRh5hAopHfzZWHjVak9OdlM
 GZTMUmIY44DxPXTraAEct1vceEC/dGkorkfn8RC8uSCI0S9Aj5hqReXmRt42yhzgFq+v
 zVHA==
X-Gm-Message-State: APuU4Z+61TpsTXnPWFszodWqibqegg2UP43d6w/aPKDnKpSxCCRFWWyN
 BUI9cOUkWSLQAC+Y4u3QClirCu2fz5QoLiszGXtwh3iSf0PP3QH1RylS
X-Gm-Gg: AZFdTZfkGadltbUuFfmHLDS5HMcbgzJ/VmF5npiVDXFsJ3nvGCYb4NszpgljJ0bQNom
 XQlPnxDv8sSKWKSdhFvNfzIUx1C3bu25SLnNtEG5JN5JwIvGjxF/4IvTa+a04GXLrVqHuVmonvO
 hVPH7EdnHpjv9aG6xx5+43GHqPd+97kLAzXed6bVCkPOIhpTVATGOuFV35VpMUYVmYo1lksaYuh
 98shnMHTE0KFKp+5c43hRldCW17DcMNv79xFn1lgolldpwUqP43GAWhdjpiJahpPBvJdoOinYqG
 PUTsaQDJzrrZh41Foyvdhk321jWcrrVQ2owuCoTZTDE9mRk8FyP6Y/etpK0I+RlVgVAXEE7YE3b
 rjJHyMNdWDK7lPKbsO5S7gZsDek9x6XDWd+pS0FMRly226SVphXQyjokyhyDm9P0w77syeITt6I
 gHK/bwPVOYr5tFuY9UW9BWPGCPwkDHYY+MhYdzzCoHoNSatj/n4IiELRGSphj6MLesX8TwColJs
 Ugs+o0iEeguEtbxzqefZZGo5CzjLR9dlBTHeRXiA3Pu5gHNJrilzsEYVoFXghN99CHPXiCala0C
 ELiz4p3iysiUpRBIUlFRB1lgl0IrRjF0Al0XxBRL3vFyT3EKbpqZSvv2SBIWGg==
X-Received: by 2002:a05:600c:848a:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4bb887fb678mr237876905e9.4.1795450851663; 
 Mon, 23 Nov 2026 08:20:51 -0800 (PST)
Received: from [10.56.169.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110ba3sm18863696f8f.35.2026.11.23.08.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:20:51 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Subject: [PATCH RESEND 0/4] drm/vkms: speed up composition with a
 precomputed gamma LUT
Date: Mon, 23 Nov 2026 17:20:25 +0100
Message-Id: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Arthur Grillo <arthurgrillo@riseup.net>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Oarora Etimis <oaroraetimis@gmail.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Four patches: a fix so that a frame takes the gamma LUT from the state it
is built from, a table that turns applying it into a lookup, a test, and
the CI entries that can go once the timeouts are gone.

apply_lut() samples the gamma LUT: every channel of every pixel gets a
fixed-point index and an interpolation between two neighbouring entries.
On a 1024x768 mode that is 2.36 million interpolations per frame, and
kms_plane@pixel-format takes 160.1-167.8 s while
pixel-format-source-clamping takes 78.9-83.8 s, over ten runs each. CI
lists both as Timeout in drivers/gpu/drm/ci/xfails/vkms-none-fails.txt.

A channel value is a u16, so a channel has only 65536 possible outputs.
Patch 2 computes them once per LUT change into three tables (384 KiB) and
applies the LUT by indexing them, which leaves the composed output
bit-identical to the interpolated path. The two subtests take 4.87-4.90 s
and 9.70-9.84 s.

Patch 1 is the fix I posted on 22 October
(<20261022215803.621996-1-oaroraetimis@gmail.com>), and patch 2 builds on
it. Patch 4 removes the two xfail entries and has to be merged with patch
2: on its own the subtests still time out.

The other approach I considered. drm_fixp_msbset() computes fls64() with a
62-step loop; replacing it with fls64() is three lines, needs no memory,
no cache and no lifetime, and returns the same values. In a userspace copy
of the same functions the LUT phase goes from 153.9 ms to 10.5 ms per
frame, ~15x, where the tables give 0.9 ms, ~170x. I have not measured the
subtests with it, so I have no wall clock for it. It is not part of this
series.

---
Oarora Etimis (4):
      drm/vkms: use the gamma LUT of the state being composed
      drm/vkms: precompute the gamma LUT for every channel value
      drm/vkms: add a KUnit test for the precomputed LUT table
      drm/ci: drop the kms_plane pixel-format xfails for vkms

 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt |  2 -
 drivers/gpu/drm/vkms/tests/vkms_color_test.c  | 54 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_composer.c          | 47 ++++++++++++++++++-----
 drivers/gpu/drm/vkms/vkms_composer.h          |  3 ++
 drivers/gpu/drm/vkms/vkms_crtc.c              | 24 ++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.h               |  6 +++
 6 files changed, 125 insertions(+), 11 deletions(-)
---
base-commit: 33ed26235db93162935d1719bc6f538c384a2fd8
change-id: 20261108-lut-4fde3dee44ce

Best regards,
--
Oarora Etimis <oaroraetimis@gmail.com>
-- 
Oarora Etimis <oaroraetimis@gmail.com>

