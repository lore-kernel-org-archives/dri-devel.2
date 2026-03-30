Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8ACF3D61E
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 08:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6900B10E584;
	Mon, 30 Mar 2026 08:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="e3HLW1Tt";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82FD510E582
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 08:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774859607; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RtgYMRLC8vilEn14Kodczm/f+tVSjEYcwcCHZ8QALOVSzW0lApGKNgfwnZIPL7RUrWNwuYSxrvUa2yZsdeJ3TNVYQKdxbFs4/TS/5gSHbkLGMUMzFF4s+Khv3QQu6LmKxusXKVPT4wU/kNnnuielT5LiRgJdVZHYbpc2478XVgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774859607;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=27JV4Bk82lj5ezB0hPo7g/R0RowxSUzeNrebss4J0Eo=; 
 b=CAozTmSAH2BbJviP9vj1RlwHj7+A30SAWi0jtv+c3azADNauD8Ab8lNl2COvzIupMic0a2f3Z8dEP83J8vhhWEaDMuoXBgUU1ZYZJNVFyZjqWnJqjGN+S/CcpnkttMGoeE9S7Fznp02h3u9TJupdP61rLnCPRWb4zXNy06A/RE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774859607; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=27JV4Bk82lj5ezB0hPo7g/R0RowxSUzeNrebss4J0Eo=;
 b=e3HLW1TtRjSEfmmtaLzIOYyCWUpY5hDMXtD0pTOa3PLjbF9KHOqFA+CFQ24S8jMO
 G5DZRJ6fuxcEICG1DCReT2BorS4zZZrtkT4/6FiqzXDm/17dY8tc0vlbDYiuWS1hOw8
 HFxIZdZVQesYK5OIrYMiy8aKoq8oNQcOLIxP+/JU=
Received: by mx.zohomail.com with SMTPS id 1774859604662137.03593847194065;
 Mon, 30 Mar 2026 01:33:24 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v6 0/2] Add "link bpc" DRM property
Date: Mon, 30 Mar 2026 10:33:08 +0200
Message-Id: <20260330-link-bpc-v6-0-ff124af93e48@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12PwW7DIBBEf8Xi3HUBg4lz6n9UOawB16i2ccBBq
 SL/e7GTqlFOq9HuvJ25kWiDs5EcixsJNrno/JRF/VYQ3eP0ZcGZrAmnvKYVbWBw0ze0swZDsdN
 CSdSiIfl8DrZz1x31ecq6C36EpQ8W/wCSUc5ZzQ+iKpmSDTAYMbhLLNOA5kP7YcDWByy1Hx/EY
 M+XnGm5Y0mL0ULejm45FiZkvpvfH5NsT3sXFx9+9jpJ7J57csb+kycBFCRTStqmForTl9cbKMl
 n81PtJDdzRWttqEBFD6/mdV1/AcGrexNWAQAA
X-Change-ID: 20260309-link-bpc-d0afc475ac49
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Derek Foreman <derek.foreman@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
X-Mailer: b4 0.15.1
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

This series adds a new "link bpc" DRM property. It reflects the display
link's actual achieved output bits per component, considering any
degradation of the bit depth done by drivers for bandwidth or other
reasons. The property's value is updated during an atomic commit, which
is also when it fires an uevent if it changed to let userspace know.

There's a weston implementation at [1] which makes use of this new
property. It is not representative of the entire use case of the
property, but rather a proof-of-concept.

[1]: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850

---
Changes in v6:
- Drop amdgpu patch to unblock series.
- Reword property documentation to make it more explicit as to what bits
  this counts and why someone would want this.
- Reword first patch message to do the same.
- Link to v5: https://lore.kernel.org/r/20260319-link-bpc-v5-0-5306cd04a708@collabora.com

Changes in v5:
- Split "drm/connector: hdmi: Add a 'link bpc' property" into two
  patches; one adding the property, the other making use for it in the
  HDMI helpers (Maxime)
- Apply Maxime's Ack to the two split patches as per the review
- Link to v4: https://lore.kernel.org/r/20260311-link-bpc-v4-0-51775e964720@collabora.com

Changes in v4:
- Throw out the workqueue and delayed work item
- Remove the drm_connector_update_link_bpc_state function
- Reimplement it by updating the property and firing the uevent in
  commit_tail
- Check that the provided max_bpc value in attach_link_bpc_property is
  within the expected range
- Clamp the connector state's link_bpc value between 8 and max_bpc so
  that no value outside the declared range is ever written to the drm
  property
- Update and reword doc strings
- Add an amdgpu implementation
- Link to v3: https://lore.kernel.org/r/20251022162843.1759-1-marius.vlad@collabora.com/T/

Changes in v3:
- remove VRR mention from commit description (Ville)
- add DRM_MODE_PROP_IMMUTABLE to flags (Ville)
- provide helpers functions for drivers to use (can be used by other
  types of connectors, not just HDMI)
- send uevent informating userspace when 'link bpc' connector state
  changed (Daniel @ https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850)
- added missing doc entry
- Link to v2: https://lore.kernel.org/r/20251006083043.3115-1-marius.vlad@collabora.com/T/

Changes in v2:
- replace return with EBUSY if connector already exists (Dmitry)
- add i-g-t test and an implementation for Weston (Dmitry)
- re-wording patch description (Jani)
- Link to v1: https://lore.kernel.org/r/20250801101750.1726-1-marius.vlad@collabora.com/T/

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

---
Nicolas Frattaroli (2):
      drm/connector: Add a 'link bpc' property
      drm/connector: hdmi: Add support for 'link bpc' property

 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  2 +
 drivers/gpu/drm/drm_atomic_helper.c             |  9 +++
 drivers/gpu/drm/drm_atomic_uapi.c               |  2 +
 drivers/gpu/drm/drm_connector.c                 | 88 +++++++++++++++++++++++++
 include/drm/drm_connector.h                     | 16 +++++
 5 files changed, 117 insertions(+)
---
base-commit: 3a48a999a2e3c3d1988d44370ed8f43ff54700b6
change-id: 20260309-link-bpc-d0afc475ac49

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

