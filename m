Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C8AC54FCD
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 21:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C130B10E25D;
	Wed, 29 Jul 2026 21:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Jnl4GGNf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E700910E25D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 21:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785361531;
 bh=EIIVesPW5eLPqqvNtrrBCSaxlUSbWJ42wtBUHTyUkDE=;
 h=From:To:Cc:Subject:Date:From;
 b=Jnl4GGNfM5gj3Dz6Z/yZENsebz4cl4FCk3e57bumEdXZSAh/+1WCcRY8GWe5ka2jX
 DozG0fm7MNPrswaKeNYuIR2hYfE9OkaFSWEHHREhDJ3223BDlI9/kROKH/EYH6M9Hy
 AtrpWmGgOWcVWnOz0zMrg1+eRK+UEURS1ZisgwmATd/BqIC0ObtVh58Vcx8c4OCR8n
 zn2TC/ejene2SxdRxS3XlKWEXmACvHmS2nmw8svS2Eb9Y9/2OZG0eHDs8jRE64HcJS
 C+7dhJtEet73M2KAqWxp+aqRLACY5CArZEKBFFFeGKvt6Q/9G5hGQmmSO6kX7Jg/pf
 V3JtBawRDLImA==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 511B017E0203;
 Wed, 29 Jul 2026 23:45:25 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, broonie@kernel.org, daniels@collabora.com,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 miguel.ojeda.sandonis@gmail.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch,
 penguin-kernel@I-love.SAKURA.ne.jp, tytso@mit.edu, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
Date: Wed, 29 Jul 2026 18:45:04 -0300
Message-ID: <20260729214505.185776-1-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This replaces a WARN() with drm_warn() in
validate_blend_mode_for_alpha_formats().

The condition is expected to be triggered by existing drivers while they
adapt to the new blend mode requirement, so it should not use the kernel
warning report mechanism. WARN() output can cause fuzzers to stop when
they encounter a "WARNING:" message.

drm_warn() keeps the warning visible to driver developers without
triggering a WARN().

Leandro Ribeiro (1):
  drm: use drm_warn() in validate_blend_mode_for_alpha_formats()

 drivers/gpu/drm/drm_mode_config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.55.0

