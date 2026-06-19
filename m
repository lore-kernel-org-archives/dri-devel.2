Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A9ACD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0989210F635;
	Fri, 19 Jun 2026 14:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="QtvHlDZ0";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4095010F635
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 14:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781879869; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OUtwSNEJFuvmSfrwkWjNYckDjst0V7QawAm8jjQlT6py+5BGIRLgFmq6nX5uIaGExMMXcHkDYJBbqAWALOBYGiJnzjr3SLAUcY01vXTHCDJ32MKCN5j/5HgfF6cfPhPXwebCmvgjRMmgYCR4MV1/2zkQSzFJXrXoeE8ipkTifNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781879869;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HPAcmv5SV6s4wALviuzPUJ+LE7njy+FJJeynX4WM3LE=; 
 b=gIYve93jWicei8/r3ehU92QJHncq+8RIvDkMEXPdUkJsVgaXpAMj3Qyb3PweIiLw3/+USpsu7XZb3+v8RvSdthgBd5Qy/WG+0mp0OTBpWE3pUXDFsW1LiMYO6MCXXpBrkLl22zDUBZ8iC0Ms1yU4hgMHxeoeFi5IK4Eel71heU0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781879869; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=HPAcmv5SV6s4wALviuzPUJ+LE7njy+FJJeynX4WM3LE=;
 b=QtvHlDZ0h88sqWkUUKnyLRzKS2UXmmGh6KthK0Q/eVpV2VpcVqDQ84KI+Vt8GsWI
 P5vzqCByqsF6pbuDy3es6327uyKLYXVc6K1z/hbq/p9P8U0XOnBFZO7FaywWv79PELN
 xUqJIUAoeaCsWR0ruwJFGdO2yt7lkIDwZsJWhF2Y=
Received: by mx.zohomail.com with SMTPS id 1781879868420866.2259164179989;
 Fri, 19 Jun 2026 07:37:48 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v3 0/2] Make HDMI state helpers handle odd max bpc requests
Date: Fri, 19 Jun 2026 16:37:30 +0200
Message-Id: <20260619-hdmi-max-bpc-fix-v3-0-ba83e5361eb0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOwW7CMBBEfyXyuds6TmQHTv2PioO9WchWGAfbR
 CCUf68JHBCip9WsZt7MVSSKTEmsq6uINHHicCii+agEDvawI+C+aKGk0lLLDobeM3h7BjcibPk
 MRjayXhnddE0rSmyMVN4L8mdz1+nkfgnzjfNwRDqeSle+24SziQCD95zXVR89ZB6/HlfcIAOnH
 OJlmTnVS+b/RVMNEjR1PZJDo0z7jWG/ty5E+1lKFuCkniD1O4gqEOO02bbdyknEV8g8z3/Konk
 0PgEAAA==
X-Change-ID: 20260608-hdmi-max-bpc-fix-703019763834
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

With the "max bpc" KMS connector property, userspace can arbitrarily
restrict the upper end of the bits-per-component range. This is fine and
good, except the HDMI state helpers never considered that max_bpc could
be influenced by a userspace setting, so assumed it'll always be an even
value from the HDMI standards.

This, unfortunately, is not the world we live in anymore. Patch 1
corrects sink_supports_format_bpc to return false on BPCs outside of
what HDMI allows. Patch 2 then corrects handling of odd-numbered max
bpcs by rounding the loop start value down to an even number instead. It
also adds a KUnit test to make sure nobody breaks this again in the
future.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v3:
- Move bpc check before vic check, and show debug message on failure
- Link to v2: https://patch.msgid.link/20260618-hdmi-max-bpc-fix-v2-0-7b67f489b0cc@collabora.com

Changes in v2:
- Use rounddown() from linux/math.h instead of the bespoke rounding. No
  functional changes.
- Note: switch statement in patch 1 kept as-is, as 14bpc is not allowed
  by HDMI it seems.
- Link to v1: https://patch.msgid.link/20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com

---
Nicolas Frattaroli (2):
      drm/display: hdmi: Only allow BPC values of 8, 10, 12 and 16
      drm/display: hdmi: Round odd max_bpc down to even numbers

 drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 13 +++-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 71 ++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
---
base-commit: 24209d838338d162bb25aadfd637b11747a357ca
change-id: 20260608-hdmi-max-bpc-fix-703019763834

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

