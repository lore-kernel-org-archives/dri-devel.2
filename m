Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A9DCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6AE10E558;
	Fri, 12 Jun 2026 15:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YlPeCQRM";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FB710E558;
 Fri, 12 Jun 2026 15:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781278470; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kLzPmBojgbZ89L7mItxlMRXaGm/sP2L5lbzOADmpl3rgiGocJBB7mO+L/AGWLONgOFh8tPxJVCqI+mSEkAyJfAEFbpEk5Mt3IlQzpNQ/srYqTxONayC9nOflTWNB6yeXYo+Tw21a62V5KgMJnXZGY5lWLzJaJu7cKWOTUy96HqA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781278470;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JvW5RBKZmjkVrwbWVi7jTvtQpJXzpc7vzunZ6bs2MO0=; 
 b=dymCwxceYixe2u2v+5oXx4+G0qRtCZZtRf/kYG9EUQfDh7bQQn5vV2/ZrJBoTmrQL68TUzS7zOF68LKbI/n+9LawMel0ezAf7YkoEDK6RrWEzoQKTuQgV54vLsUZLiZegYKLSG9vUy3eNcMWTzyn2HtbluyvDsgV5vPB9P67+zc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781278470; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=JvW5RBKZmjkVrwbWVi7jTvtQpJXzpc7vzunZ6bs2MO0=;
 b=YlPeCQRMuMUHnVLlzXjjaXhTWlvzpAEdRM7P9bdy5cY6y3yaYoQ7WpQKpB3AZ0Aw
 CDbSSHH68npVNAcRsv12fTYUki2grkE7+GB4ZpLxUnaToqYv9EcOtRKpcTkNJcSYGSC
 r/VvJmXeICjlThj+qr3vkwzgv6eEjNfICTZMgtvk=
Received: by mx.zohomail.com with SMTPS id 1781278467260367.5835464573727;
 Fri, 12 Jun 2026 08:34:27 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/2] Add a "min bpc" connector property
Date: Fri, 12 Jun 2026 17:34:11 +0200
Message-Id: <20260612-min-bpc-v1-0-bba88c2c4836@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQqDMBBEfyXsuUtjRA/+SvGQTdZ2C4k2iaUg/
 nvT6ml48GZmg8xJOMOgNkj8lixzrNBcFLiHjXdG8ZXBaNPrXncYJCItDj3R1FJrTWcaqPaSeJL
 Pf+k2HpxXerIrv/ppJH6t9aIcGpDNjG4OQcqgfApYZLmeCeO+fwH72x9tngAAAA==
X-Change-ID: 20260605-min-bpc-dbbf3b3a2521
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Xaver Hugl <xaver.hugl@kde.org>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Mario Kleiner <mario.kleiner.de@gmail.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

This series is an alternative to the link-bpc[1] series, which
implemented an immutable property to determine the output's bit depth.
The link bpc property wasn't very liked as it'd only be updated after an
atomic commit went through. For a userspace that's trying to evaluate
all available bit depths at a certain configuration, this was untenable.

After some discussion at Display Next Hackfest 2026, the general
consensus seemed to be that a "min bpc" property would be a better way
forward. By setting it and "max bpc" to the same value, userspace can
probe for supported BPCs of a configuration with repeated atomic test
commits, without actually doing a modeset.

At the same time, it satisfies a common userspace use case: often times,
userspace just wants to ensure that its deep color plane it's submitting
is not being degraded by the driver to 8bpc for bandwidth reasons. By
setting "min bpc" accordingly, userspace will get definitive feedback
(an atomic commit failure) and can then make content-specific trade-off
decisions that the kernel wouldn't be able to do, such as by lowering
the framerate, or once "color format" is in, by subsampling the chroma.
Alternatively, userspace can of course also accept that there's really
nothing better it can do, and lower "min bpc" to accept the degradation.

This series adds the property (including documentation) and implements
it in the common HDMI state helpers (including new KUnit tests). Drivers
that don't use the common HDMI state helpers will need to register the
property and implement the (fairly simple) logic themselves.

There is no draft userspace implementation this time around. Something
that would adequately make the case for all the uses of "min bpc" would
take a lot of effort to add to weston, and anything less than a full
implementation will then be used as ammo to argue against the property.

[1]: https://lore.kernel.org/dri-devel/20260330-link-bpc-v6-0-ff124af93e48@collabora.com/T/

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (2):
      drm/connector: Introduce "min bpc" connector property
      drm/connector: hdmi: Implement "min bpc" property

 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  10 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   4 +
 drivers/gpu/drm/drm_atomic_uapi.c                  |   4 +
 drivers/gpu/drm/drm_connector.c                    |  81 ++++++++++++
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 146 +++++++++++++++++++++
 include/drm/drm_connector.h                        |  13 ++
 6 files changed, 254 insertions(+), 4 deletions(-)
---
base-commit: 8372c3177e62bca48fdca142601d3d3804ff3129
change-id: 20260605-min-bpc-dbbf3b3a2521

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

