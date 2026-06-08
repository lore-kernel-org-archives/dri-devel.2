Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECAFCD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370E010F204;
	Mon,  8 Jun 2026 11:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="dG/Nf8DA";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D88610F204
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 11:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780917564; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SxhJTpgpZcTVr+jbFDgHa1rcndzwec1/U+Q8LVcq9hn3c7GQJR6d0NXhhF5yXX3Meo+S3lUEtBvyxtXb2nIbnr7bK3pYSOfwRLSgcF5phirwNJFTpSIQkN8F4HAPTQGdSAukt3pvr414MZavRTbShu+NPHNAxFyL6KFJvwBuShA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780917564;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=w95v8rmypZzUecGHeRmBiKIIuhZ1fsqWje5Fpue/L1M=; 
 b=QofVtK8uINWdohXqpSVnAu6oN0FXSYmQQZ54yws4OKB7RRPfgQxxyV9kS/mkvSz1Hv/ulf2x8f9AbWvUCjWA2NIp6m05AjY2WmZ0u0N9npFF6hoV0omL/waj29cpIQDhFvLQeoxtwIjIdZCXuv9jnEJpnOCSHmMAHm5+d1/6bwI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780917564; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=w95v8rmypZzUecGHeRmBiKIIuhZ1fsqWje5Fpue/L1M=;
 b=dG/Nf8DAIw4v4qK1H4AX6CUqLurxf5MLESWaQ8CyFb2et6bceSOfRqrIVBsnMj5O
 iQ433VlDXXE/AJK1/nd/17Cc30SNqcU6U9CwNLtLxmiEnbkZ+YvKss+N1DnRB2c42RM
 abG/q559wUnGXpVfG/yCJBupAUkb4bBwZbzvTjUM=
Received: by mx.zohomail.com with SMTPS id 1780917562612833.0652412976524;
 Mon, 8 Jun 2026 04:19:22 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/2] Make HDMI state helpers handle odd max bpc requests
Date: Mon, 08 Jun 2026 13:19:06 +0200
Message-Id: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NTQ6CMBCFr9LM2omFGkCuYljQdpQxKZS2GBLC3
 a3C6uV7eT8bRApMEVqxQaAPR57GDMVFgBn68UXINjOUsqxkJRscrGN0/YraG3zyirVUsrjXlWr
 UDXLNB8r2f/LRHRwX/SaTfjtnItC85K90xED3kdBMznFqhQ0OE/vrqdDt+xe5A4orpwAAAA==
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
Nicolas Frattaroli (2):
      drm/display: hdmi: Only allow BPC values of 8, 10, 12 and 16
      drm/display: hdmi: Round odd max_bpc down to even numbers

 drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 12 +++-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 71 ++++++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)
---
base-commit: be3e81d74654555fff2779d78848267bd50dcf51
change-id: 20260608-hdmi-max-bpc-fix-703019763834

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

