Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F505C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9463810EBC7;
	Wed, 29 Jul 2026 12:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="XgIYzdkE";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D8910EBC7;
 Wed, 29 Jul 2026 12:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785327244; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j0EP3ei8CZYYeG9GcBbOuiJIIxwVKNf1Nwa3aQpWHia6tOg9m0vw7TaymoyDjLGd/qgekNIlDSnVCRm9i9ejrRIRUm5N9qRAsuiCjYQwZ9YqaznV3Iw/L2+rKZcPs0qvBrRMgk+98rH9qDV14o0DosAZv5TKXILMLWL0S3COLAg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785327244;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Uk0Y1lYvpdLrTlp+7Fwrig6uPWxfBmX/cy9oqIf2et8=; 
 b=cQtfuTJkiK13Rc5tMy4zUcvgox6EJ8uqMVEG2KXegpncWz6hIJtB/O6TGYT0vUsDeJ5VycM4M/Ie5ePJtqgY/sCBtSRRcLUSnkGM27MhSe8PGdQImFxAp6uBBuaVljgd81ExmksqJOcq4RmP6pEu6wXMd9T/daDWrLitkMsZ1nU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785327244; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=Uk0Y1lYvpdLrTlp+7Fwrig6uPWxfBmX/cy9oqIf2et8=;
 b=XgIYzdkEgb8yL0+PcHpuSoRicxhHelurXmpep/8e7/lpK0ahmoH9TcjomAALZCEZ
 LE55Y4ne6g0+h0PcyrIB9SQMJVapUWJPv1gdONrnrieMKjs2sYRk950bk/OpOipXwGY
 5kAAX7jFKkx+4xy810SPB/zmTxhGXTCx0UptVprY=
Received: by mx.zohomail.com with SMTPS id 1785327241652832.5455216169823;
 Wed, 29 Jul 2026 05:14:01 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 0/2] Add a "min bpc" connector property
Date: Wed, 29 Jul 2026 14:13:26 +0200
Message-Id: <20260729-min-bpc-v2-0-7d0036ef437c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2Oyw6CMBBFf4XM2mpbhBBX/odh0SlFxgDFthAN4
 d8tj7ia3OTeM2cGbxwZD7dkBmcm8mT7GOQpAd2o/mkYVTGD5DLnOc9YRz3DQbMKsU4xVTKTAmJ
 7cKamz0Z6lHv2I76MDuv8aDjzHuOLsNcAlTdM266jcEsq17FAw+W4sEIa8sG672Y3iW2ziwj5F
 5kE4wxRFYWW+lqk+V3btlVonTpHNpTLsvwAnWHWJucAAAA=
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
 Daniel Stone <daniel@fooishbar.org>, 
 Marius Vlad <marius.vlad@collabora.com>
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

There is a draft minimal userspace implementation in weston at [2] which
doesn't do any fancy atomic test commit probing with dynamic
userspace-side fallbacks.

[1]: https://lore.kernel.org/dri-devel/20260330-link-bpc-v6-0-ff124af93e48@collabora.com/T/
[2]: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v2:
- Add link to weston draft MR in cover letter
- Apply trailers
- Link to v1: https://patch.msgid.link/20260612-min-bpc-v1-0-bba88c2c4836@collabora.com

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
base-commit: 5df28e621a86e501b09902fdf816f8c02a162794
change-id: 20260605-min-bpc-dbbf3b3a2521

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

