Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F9CC5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4ED510F2CC;
	Fri, 31 Jul 2026 15:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="N5qRx006";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED9A10F2CC
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785512575;
 bh=QqxBKkFf5nuOtvmCot5FMaazYAhjGlI+mkGqVM+6pO4=;
 h=From:To:Cc:Subject:Date:From;
 b=N5qRx006QtdlzoPK4xQ+5NLfs9sK3r/wPjeW9ErO/yb2YxQnw3q2RQm5aKzwD5nDB
 rgTFueGt7ZpYKbpa6NlBMf8bTHzGdTmoKsFLCU1P7X55w3AvOpujnWgIix1aIr418l
 BAjj/ujMYHtpLuiY1Z6txA0ugDytcSOIfdQC1FnpX36DaRgimjERvNdxiGLQgMnEMe
 I+k0yElCVwM1WsxiXC0dCmc3or9FVrhh/uXEpTdCZrmbJAG8HfWAXVCSI+Oj1t+2dR
 omgf/l+H30+Lfr8rNIpT/hqxQg23oV3U+TAIwfkqrCcIj9iVWlbCn8hmZPcyxQDOFi
 QhWKKdB1W7/HQ==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7628E17E06D8;
 Fri, 31 Jul 2026 17:42:50 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, broonie@kernel.org, daniels@collabora.com,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 miguel.ojeda.sandonis@gmail.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch,
 penguin-kernel@I-love.SAKURA.ne.jp, tytso@mit.edu, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
Date: Fri, 31 Jul 2026 12:42:31 -0300
Message-ID: <20260731154232.37020-1-leandro.ribeiro@collabora.com>
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

Changes in v2:
- Make the warning message more explicit
- Add a "Fixes" tag to commit

Leandro Ribeiro (1):
  drm: use drm_warn() in validate_blend_mode_for_alpha_formats()

 drivers/gpu/drm/drm_mode_config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.55.0

