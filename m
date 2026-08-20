Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B58C5DF89
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8E510E1F4;
	Thu, 20 Aug 2026 14:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="XwUsXtpN";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8852510E1F4
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787234696; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PtfGi+S2AXiL22uGLafr/gyawaykrZyQDM37D3oyYzfPHenAUdNw2aSj3Hhw79EybxK9RLgZ87yJ1a0q5qSy103Mqaesp5wDXjJQuSrwrFDE8zxf/Ubf9PdFUNKw+xJC2D3Gado02urrJKhv0FN18O7W/KYReVsSU8Tp63RjSrA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787234696;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ycJ9EcKlHV84HNC+4szxJbtyx+Na6G7NV55qfrHPR3o=; 
 b=i3WoA/OmNCHt12KmfAcZDp8bHXlIhqxDiekBFws2FM7gOPb6P4IxDiN8y8YtDrrO5uKRG//x8N+CoyhyTiKX8S8onB7sT/+lI/1eJLxktoHilTqXE1FGiVR+HW2Ter+Omym6rRR6OixUSHlWmRpsBM2KFqO1u7zFVwIYdcL/K7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787234695; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=ycJ9EcKlHV84HNC+4szxJbtyx+Na6G7NV55qfrHPR3o=;
 b=XwUsXtpNHbfv1MsFzFeA4Yi8Hv1YurLvy2n5v0+hwCksE4YcP69LlzQcVJ2tlx6p
 oY0rlL661S2a2ul3F9jGRvoECsIX4FeHVTDM/QnrfXf8msLP63xe7NO2PPT37dnW1XW
 o1p2jIkw7MZOi4KmDPedyMYUTKnRlv9bMP4A4WEE=
Received: by mx.zohomail.com with SMTPS id 1787234692984964.9407036847201;
 Thu, 20 Aug 2026 07:04:52 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH 0/3] Collection of small fixes for Panfrost
Date: Thu, 20 Aug 2026 15:04:46 +0100
Message-Id: <20260820-b4-panfrost-fixes-v1-0-1b2c2376f4bc@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAyF4atI1gZqLaV6FXFhnVTjokqjIoh3t
 zOz/Hj87wahxCTQFjckOll4jRlVWcA4D3Ei5E82aKWtclqhN7gNMaRVdgx8kaD1pgkuGFu5GnK
 3JfoNOev6v+XwC4379wie5wWBt505dQAAAA==
X-Change-ID: 20260820-b4-panfrost-fixes-6b49f8f46183
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, Eric Anholt <eric@anholt.net>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=7pw+YuolOJTV3Ofl8CwZT1r7HjAZ4/BcMldobr45prE=;
 b=owEB7AET/pANAwAKAQ4mfkzuU0M9AcsmYgBqhwl/dD0XFmeitxHEfT5oFFvM86gJ3c+7+Sfd0
 MDySHjnvXSJAbIEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaocJfwAKCRAOJn5M7lND
 PUavC/itMKWgLlPq7Ui8/AdELeM2m8/QonkfRq37NlBFbaCGd35A35bNbGrRYkSR+thjSZySgCe
 d6E3dd7R3FMd3zyCJttWvrPUjX08TPu32InFatzOI+3VbEBQYNa9II1hKK4hLQjqgtIsD1MglGK
 u4GyDBtnZT02skT+blwuQAodS9gQvAoxuxUl4rr+g7UxnMzdprnDcwuMZEDdwuevsJF3WRUOy4n
 t9BPGi1zUPD0B/MAO9i26IxfaLirXMY6BL3p/QTJPKwX1AC4ZYHwRCDDKXf8Wa4T+eXVsNNQ7wY
 XQzPz6q0RoIeMBqe1AX9OzEbpIYhlU00KDPy85Hp0cK477WozhAYEPKYrNyBlUn6AM9EMkASJm4
 zIhyENpPPqJ45fsyAOuMuBS6VBGktQWbHqP0tms/9fbhUqfABtZs4QE5JK0gWY1cLTouQl1UpWH
 SYAu8K5T1nBbQlurD4z8XJP/DxldgtcAQmu3AGcFRCAEURYOBytcKEUzr/aC713Cu1+Q==
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

These fixes were originally part of a wider series, but since it seemed
to grow indefinitely as new issues were found, I decided to split them
into smaller more managable series. This one includes some minor fixes,
both manually found or else pointed to by an LLM.

The last pre-existing revision they were grafted from can be found at:
https://lore.kernel.org/all/20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com/

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
Adrián Larumbe (3):
      drm/panfrost: Check another bo field for cache option query
      drm/panfrost: Prevent division by 0
      drm/panfrost: Remove unnecessary header file include

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 2 +-
 drivers/gpu/drm/panfrost/panfrost_device.c  | 1 -
 drivers/gpu/drm/panfrost/panfrost_drv.c     | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
---
base-commit: 063019ac51afffda4ab3d658701b086caa0c8e9e
change-id: 20260820-b4-panfrost-fixes-6b49f8f46183

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

