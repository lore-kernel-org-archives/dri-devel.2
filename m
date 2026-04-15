Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5389AF43853
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA9910E0BB;
	Wed, 15 Apr 2026 15:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Pakgb2Fh";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9761C10E0BB
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776268636; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dzoxuTON9g0T5v2VW4RIJSwOzmosZ/19+p4KWdsex6D/83FL21+k2FZxt2s1hHNuvE7kHty44ft9urmtwTCmLu64cPut2/90DGWgkXTBieJsNVkzq6lfYlr3MpcBzUelsNWx5JhE5LeM+Rg1ZqnSwpbsXtPlJe1fGqj/iDlZlQE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776268636;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tcWc/YGZhuBbUG2ZzxFM4v6CdUOrEnfjslywxPvcmNY=; 
 b=RDuGYOcAD17avP0O3tcVTKBnag24ClX2zCbs9H5oIqnR+yQtNTFAxf1W/lrnizzb0YDLwCU1HOPSDllho1opNMaROrxz7sVU44Z5/LFzOeVqvCityAEkissr/yGpOAcyq3y6FJEMeNYvnS0RbUlu5asEceUt62IIAueSkN4L1Jc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776268636; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=tcWc/YGZhuBbUG2ZzxFM4v6CdUOrEnfjslywxPvcmNY=;
 b=Pakgb2FhXRG4nc4XA2gx/ni5cGsYttQq6ZZdEr9s+f0o4s82Xky5FSUAvqZuIivn
 KhSMg+PfihDMHopZOld14ofsALbSNV+COAU71R31QJvJ2avQDtCo0h8WpeQzi1Gi26C
 1RCjZslc9JTLTt1mCsIEfgEFke87A8OF3wNul7ds=
Received: by mx.zohomail.com with SMTPS id 17762686337951.9665345468235955;
 Wed, 15 Apr 2026 08:57:13 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/2] Add SCDC information to connector debugfs
Date: Wed, 15 Apr 2026 17:56:41 +0200
Message-Id: <20260415-scdc-link-health-v1-0-8e731e88eaf0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NTQ6CMBCFr0Jm7URKDRGuYliUdrSjtEBbjAnh7
 lZh9fLl/a0QKTBFaIsVAr058ugziFMB2ir/IGSTGaqyqsuLkBi10Tiwf6ElNSSL10ZmS0jT1Bp
 ybQp0589/8tbtHJf+STr9do5EoHnJX2mPQa8ioR6d49QWJjhMPJ0PhW7bvt90xPKnAAAA
X-Change-ID: 20260413-scdc-link-health-89326013d96c
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
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

HDMI uses the DDC I2C bus for communicating various bits of link status
out of band with the actual HDMI video signal. This information can be
useful for debugging issues like questionable cables sabotaged by feline
teeth, Enthusiast Grade cables made of cow fencing wire, and other such
problems that ruin one's media viewing plans.

Consequently, this series exposes various bits of pertinent information
from the SCDC protocol in an HDMI connector's debugfs. To continually
poll the link status, userspace can poll the debugfs file.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (2):
      drm/scdc-helper: Add scdc_status debugfs entry
      drm/display: bridge_connector: init scdc debugfs for HDMI

 drivers/gpu/drm/display/drm_bridge_connector.c |   4 +
 drivers/gpu/drm/display/drm_scdc_helper.c      | 229 +++++++++++++++++++++++++
 include/drm/display/drm_scdc_helper.h          |  56 ++++++
 3 files changed, 289 insertions(+)
---
base-commit: 4c59525db84aca677fd9f052e662912ad9d88448
change-id: 20260413-scdc-link-health-89326013d96c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

