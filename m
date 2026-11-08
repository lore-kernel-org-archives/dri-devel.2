Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DAF606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DX8bUOQK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 643DF10E775;
	Sun,  8 Nov 2026 19:33:24 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF7810E775
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 19:33:18 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so2198975e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794166397; x=1794771197; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RN6tgwL6B1vPW3b9gCBznsfhVUtrE6LF+pImFI4kNIg=;
 b=DX8bUOQKyU+LIKY2uk4xUahlL1qtFDnY3o+4BgkEXvhtkF1IIYc4HCMRWvzoDb36ad
 st6P2eQlnoRweilzw6u6AgtANRr/6XgR5k0yxzSYLJkB1f4iQltDM78nU3kLb/gim8K/
 unGdD97gdlrnBeoUNLfI+0v1sNChrZFSpmYK44A47v+sihq6NkGQ8KR9rhw85nrp+FmF
 wASnyKsPDuO7/JGonXznZdZPQw9YVgBiRpAVtW6hp1qkj4yUdryhRtlCXjxDhFkay4vY
 dbMSLtOyDAw2EMcH/6n5UoDeQvHJJUUpIhSshTKPFXoG+xQrgKyqMy7HHRJxoZhW4niH
 PKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794166397; x=1794771197;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RN6tgwL6B1vPW3b9gCBznsfhVUtrE6LF+pImFI4kNIg=;
 b=b5fv3XKxOQVRYT+tJNkXzZS09V3VbYHVOJcPMviG7e2ISlHJCa7/fAWx6/MHRLlTIn
 Od1BU1jm0CwYmbP9Gw87H5Fp3wqvDV/ibvrFk8uJ69UkDzPSnI+apj/HpuZGinY1FSCK
 QPYKQy7Di31wLfrwQD9JLqKo5BJ6OYe5frjn52sS2eoMm0xiLyeZsI02/4J6PvzplOr2
 Bt6lKVa+/giS9GQQ3+bQDZ+ooV5KemgEIrP1KcJQ7Wk7t4BKJVw8c5XjoBCrnbc8IzhY
 ZfD+ffgmvyP5FnNFP+u9o21hyb2SLTGQBG98v7zyIJ0BMm8c4cXCJT0RY+8iQP5b+bWp
 vNnA==
X-Gm-Message-State: APuU4Z/4ftApoHoiT8UXMhVsi+6/EfaarLGp753jvE5C4CD3vOAeOWhv
 As9CwfhzPwQjFFodLx1/JnrW5rHoRkPytpGJoNvM0xQcLVcb1Hc+O2Vm
X-Gm-Gg: AYBFou14xyCb3L5EMa4BuVZSSw2ij20TLEGWuvxdnD2fMyiKe23X+/dUp2y+rsXt+iX
 e6DIawPYj+6W4dUurbClZwVKSz1pi9U6P48t2bn+92V/PJn2hxu8xFBH1TTiux7UzNAwF7ZP9cQ
 gnru0LBMeNgFy+i0e5EQtUb5MnLpwcNQ5cDA5YWFyU9fXK/v1thnhOVZKfB+nhONbDLTu2ottdj
 fwWZYp5FT/zlFYiHflb0Ph4xLdOWwxNCSwmbnxQ6aO5JS1qUOxVxicqUrfIfgl3y5WBl0grwYgW
 ucrRf3CgltCW+deKGQbdUzJN7pymOKDt31NRWnHpx97G1E/ShxTIGLyzFuCwFspdKTbtlX1cOkF
 IXBfa81G4XLUcW3mPni37aDdIMBegaH+TsoYdUxQVVsflcrGHUQwS4HLImVVZ1c6y11XHoGJKZP
 KHK/VyR5BZ35r1t+SwkBxCShzUzLgnkFlsATUKOXr7kYlLFbxevDQTWMqIiFmYh+48SyjLpwRue
 QogJAF4c4ZwnXkBamKCJqP1go+je3MUWgcV9tkEVVF+1+WxijIJDrWVHDi9rrFySM8VxV2A+VU5
 B0aCqP6+8uYD5p/0NUgN9frDdpNBKCDh2gB7SrH6Kwv719KE9X3sPsf9+wRgoB8=
X-Received: by 2002:a05:600c:3b8f:b0:4a6:42cc:bf65 with SMTP id
 5b1f17b1804b1-4b963c6674fmr45033395e9.17.1794166396932; 
 Sun, 08 Nov 2026 11:33:16 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbfa121sm105422115e9.1.2026.11.08.11.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:33:16 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Subject: [PATCH 0/4] drm/vkms: speed up composition with a precomputed
 gamma LUT
Date: Sun, 08 Nov 2026 19:33:08 +0000
Message-Id: <20261108-lut-v1-0-f762d70ae4cd@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBjF8VfRd221sSSvIhdsB5+ENqSWdzdc/
 up/TiAPx/BUJYEcTva8LhEqTciM7TJAsI2mTGaFUrIU87EL3VvkFtDagGK5OfR8fS9189sf3QS
 zv1O67we9oNo7ZwAAAA==
X-Change-ID: 20261108-lut-4fde3dee44ce
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

