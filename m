Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449E0C5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248FA10EAA3;
	Tue, 11 Aug 2026 07:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pzEc9r3I";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38CBD10E257
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 20:38:45 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so2710388b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786394325; x=1786999125; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V4aYm6FYSeErtwvuAXuGnJHyrhkVQge6WQL6UnOG+zg=;
 b=pzEc9r3INJ519nFeC5w1EmC2LC1PN8GOyBlvTLV0Dug2fP+Fa1yIH/7pgG6/ihveYn
 9qmy75FEmNT7nj8llUwlFFrNzuwpyepf6SvoeZqzFYQzeEQFOfejxBZ6NTDcPNIcBBRs
 AN6lELQ4I8r11YcjNkrmsU20E1vHZh8sYIdif23zJy8UaL//klkrAkbUEhp4rjZgD6SW
 J9YzMCNSpWxgVttc/IiNQ0ZT3N/fZDwx7qZO44ne+6v4NSwi3ibHk/BrZzpeYNn4Mwrb
 LfwjZQw+OTV/p3dU9Uai5gm/s3PBzJwRp2eMx5Xea78+D5kWFc9rj/esi9U0009LI8dN
 NK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786394325; x=1786999125;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=V4aYm6FYSeErtwvuAXuGnJHyrhkVQge6WQL6UnOG+zg=;
 b=YaGS2u1UA2fU1zTCXHGn9K5f08uELv5KXzm+yH8P73BEviMgi1eHtA8MBoVBWCJx9y
 eAZUoARtwlQ5ib0ltOrL9fSAJnW+maIx4iWYI6X9baaOsMAJIZTvksSpwS3KDgmOV12O
 hiODLodbydj4PJJbjlpt38xHsaOKU1Lo9UEnbU2XhYCfU43MW+bkEhYEsL/0I9u9Zn5o
 zVPfYiMUXCBTmVocL79dgwu9wDZZD9AuNr/6ALEPR2Uuoa8WxBnCalNG/Rg44Kebzg9e
 HV4ujVEVsDATRdirmyh8WMxEDkLe9ILfcLwe7Ij52uc9TKukns4qCtuowqkuODPzmyTd
 VQHw==
X-Gm-Message-State: AOJu0YyLrUgdFLfXPq1eY/hT9NHs4PPrXCC8i9XGQjDawvkL+s2IO2VM
 ycWcm9DNxI/0L1IWUG8k0QtIJ3km/yfIOB1+A7nom9pSOkUkjTdUK5lz
X-Gm-Gg: AR+sD11SB+05SVO0AThRAVA0smmwkkE/fTNjblIDBteefgE+vi53XhDeJRCmLYmcfha
 LwJ8WUbEcue8OGRONrYmsABszleU6kWTsAcbFhgoZ0sxhm7ONmurycYTpdyUu3AnCh1Vmf2bjCJ
 KzcyNrL6FZ6qQ+RpbONW8SPR/AwrwwXXblaWQiG39Ink+jfs8RSsSfhtrDp47W19xzI4+svlarZ
 eSj5CImaDld5blwHI+eRLbyyFw91HLLOqkpyqJ5svYKkrbYSAWa8DO8zKC316NsF4YQd+uP+CIk
 ygNFW2DzHH/LA9TpJljSqPQHKRfaPuuEqQCr5XvIOFeix5eWEDRoxam6Srj50uMuEBsHvdGfQ3Q
 q/qrGH7wg9ePK6b7utSJnMSlA7mE9UfbM7tkHZmkM2VPdFXAr6mH8u329yBtw/NqI4LfdFy9rb4
 zX/zqzgPlxzb5YzsHemJV3C0t9c4Y0ZMcI/U/WG1XsdJbKX1j/vXtFOiUkbng=
X-Received: by 2002:a05:6a00:1883:b0:84e:b7ed:7d50 with SMTP id
 d2e1a72fcca58-84f9c8bf09fmr4538374b3a.16.1786394324672; 
 Mon, 10 Aug 2026 13:38:44 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a553071sm4324001b3a.43.2026.08.10.13.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:38:43 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH 0/3] drm/nouveau/uvmm: fix VM_BIND submit/unwind error-path
 bugs
Date: Tue, 11 Aug 2026 04:38:18 +0800
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALo2emoC/yXMywrCMBCF4Vcps3agiVisryIucpnUKSSVTBOE0
 nc3tsuPw382EMpMAo9ug0yVhZfUoC4duLdJEyH7ZtC9Hvq7UpiWUskULDVGrNFy8hj4S4JO+2D
 s9Tb6oKH1n0zH0PLn67QUO5Nb/4ew7z+EJKiefQAAAA==
X-Change-ID: 20260811-nouveau-uvmm-vmbind-fixes-c2dfab359df2
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786394315; l=1170;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=jqjdQ4ytk0+wTeBw8PTbYYR3zs6526Vfg9ko20PQNAY=;
 b=Gm20mEIHRxSyNqIwseVbLPncJya+jfBeFQW1zRIDALtssFI5jN1ElKIgYE7rkA2kCvoqn4Kde
 ehO8EMs8rL4A5Em4KpyLCtT019GMGdAlef3kWJE23++u3iVAGXDWvTI
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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

Three bugs on the nouveau VM_BIND submit/unwind/cleanup error path, all
introduced by the original VM_BIND uAPI (Fixes: b88baab82871) and all
reachable by an unprivileged render-node client:

  1/3 NULL deref when the unwind loop frees a never-populated
      OP_MAP_SPARSE op's ops list.
  2/3 premature free of a region on a failed OP_UNMAP_SPARSE, because
      op->reg is left set on the failure paths.
  3/3 a sparse region left permanently marked dirty after unwind,
      wedging later binds over that range.

Each fix is minimal and self-contained; all are Cc: stable.

Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Zhenhao Wan (3):
      drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op
      drm/nouveau/uvmm: fix premature region free on failed OP_UNMAP_SPARSE
      drm/nouveau/uvmm: clear the dirty flag when unwinding an OP_UNMAP_SPARSE

 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20260811-nouveau-uvmm-vmbind-fixes-c2dfab359df2

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

