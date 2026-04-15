Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AA2F42100
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3022210E72D;
	Wed, 15 Apr 2026 18:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YHraJPej";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B466110E72D;
 Wed, 15 Apr 2026 18:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776276002; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OVgF3oSsAiTbvrUy0d3FB0nZKpQZKCHX9JxU7kQFu7vYaMD7oh4IJuotwjonIcoV/dT32gTAXLqJfrxeseMBbYj4bG/VSWh95j/RTCuk9SPk/IqzXIKj1x6sKhaKyVv5zcepIYkKUyHBY2P0dzWRlS4L8CoVXtepwZeB6ekiS9Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776276002;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EFjnF2pZQwVYEOCVs0ISWnxSMPCPrvYaRY1yQjJho+4=; 
 b=TaHN1rB5s3zirO/MBz3sFSCbtutTSnL8G4bshYH0sxFp53TpH3W7QLg4yckxnG9CnXtJ95/26OFC1e5BAxmU/uCgc8l/YcC+en056NDZZWCzZl4x1LtFdzRD5HMbS3uK2SmkSAAdbHXMnTMiZYobbYdc5UobFPc4YHpJ47WMS9c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776276002; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=EFjnF2pZQwVYEOCVs0ISWnxSMPCPrvYaRY1yQjJho+4=;
 b=YHraJPejK22gHhcVX4j+witVX8pQUjlqZHgKzUWwcpFS72VbkTnUe7+/JKVgTsxd
 nxObggfgv8rl+v3s7gCpL7tyV77Tm4YRkEn9e3y/IzsDUa2BYp/igxBiXbt1JOoAbvH
 6F193sP6obzjYbRUpFWYk6jWeZ37QryYpP4qv184=
Received: by mx.zohomail.com with SMTPS id 1776276000256955.2500159038105;
 Wed, 15 Apr 2026 11:00:00 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
Date: Wed, 15 Apr 2026 19:59:38 +0200
Message-Id: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WPPW+DMBCG/wry3KOcKTbJ1KFZM7Rj1eEMdrAEs
 WMDahXx3+sgqkrJLaf7et57ryzqYHVk++zKgp5ttO6cCvmUsaaj80mDbVPNeMFFgRyhcyP4fjq
 BpxgnD6bWbVEa2aQNlq580MZ+r8RP9n74OBzf2Ffqm+AGGLug6Y9X4S0EL8s6xwpfEBAGCnaK+
 dxT+9q4viflAuWNGzZ00Jcp/ThufEVRQ5oOdtxnbUgC1j9veVXtbBxd+FntzWK92ZyUD05mAQU
 QkRHY7kSh1N0HN94s/xkc5SNDJoapOUfFiVSF94xlWX4BOSeVXnQBAAA=
X-Change-ID: 20260121-hot-plug-passup-f8ed03f7c202
To: =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Daniel Stone <daniel.stone@collabora.com>, 
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
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

I will be taking over this series from Marius Vlad. 

This series addresses a shortcoming whereby a hot plug event is sent
without it being passed the actual connector that caused it. This takes
into consideration both the polling path and the HPD (Hot Plug Detect)
path. It also adds support for the vkms driver (using ConfigFS) for
propagating the connector ID when changing the connector's status.

The motivation is that user-space applications such as Weston would
previously receive non-connector-specific hotplug events, and then have
to figure out themselves which connector needs to have a modeset
executed on. This notably did not work when the hotplug events came in
too fast, resulting in Weston missing an on-off-on transition of a
connector, seeing that its state was unchanged from "on" so can't be the
one that was hotplugged, and skipping reinitialising it as it looks
through the other connectors that could've caused it.

The real world implication is that on setups with slightly sketchy HDMI
connections, a brief flicker in the HPD signal could result in video
output bidding farewell entirely until a manual proper re-plug was
performed.

By sending connector specific hotplug events, this ambiguity is
resolved without any change to the user-space API.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v7 RESEND:
- None, other than removing the leftover diffstat from the cover letter
- Link to v7: https://lore.kernel.org/r/20260217-hot-plug-passup-v7-0-f8221b2aab51@collabora.com

Changes in v7:
- Drop the two vkms patches, as I don't want them to be blocked on
  review. I still think they're correct, but they're not essential and
  don't need to block this series.
- Link to v6: https://lore.kernel.org/r/20260123-hot-plug-passup-v6-0-aaaf61d960bb@collabora.com

Changes in v6:
- Rewrote cover letter to explain the motivation for this series more
  plainly
- Rename "status_changed" to "pending_hp"
- Set "pending_hp" in the existing path that would also affect
  epoch_counter
- No longer set the boolean in drm_helper_probe_single_connector_modes,
  as it does not appear to be necessary
- Reword commits to better justify the changes
- Link to v5: https://lore.kernel.org/r/20251111162338.15141-1-marius.vlad@collabora.com/

Changes in v5:
- vkms: add support for sending the CONNECTOR ID when hot-plugging through
  ConfigFS - as reported by Louis, vkms can now make use of ConfigFS to
  simulate connector status.
- vkms: add a small change to ignore previous/old drm connector status
  when sending out hot-plug uevent.
- Link to v4: https://lore.kernel.org/r/20251103174558.7709-1-marius.vlad@collabora.com/

Changes in v4:
- removed the "This patch" bit - Dmitry
- added a short note when the flag is set and cleared - Dmitry
- address double dead-locking detected - kbot: https://lore.kernel.org/dri-devel/202509251410.fdfbcac3-lkp@intel.com/
- virtual connectors do not seem have any kind of hotplug - added
  polling in vkms - as noted by Ian
- Link to v3: https://lore.kernel.org/r/20250923083636.4749-1-marius.vlad@collabora.com/

Changes in v3:
- Address comments from Dmitry:
  - guard connector status write with mode_config.mutex
  - avoid setting up the connector status and immediately unset it. Do the
    unset in drm_kms_helper_hotplug_event/drm_kms_helper_connector_hotplug_event
- Link to v2: https://lore.kernel.org/r/20250729165708.9947-1-marius.vlad@collabora.com/

Changes in v2:
- Address comments from Daniel:
  - split patch into 2, one that introduces a bool to track connector
    connection status change and a patch that uses that to be able to send
    hot plug events with the proper CONNECTOR ID to udev and further pass
    that down to user-space
  - nuke out mutex when iterating connector list
  - fix typo
- Link to v1: https://lore.kernel.org/r/20250627131751.2004-1-marius.vlad@collabora.com/

---
Marius Vlad (2):
      drm: Introduce pending_hp to drm_connector
      drm: Send per-connector hotplug events

 drivers/gpu/drm/drm_connector.c    |  1 +
 drivers/gpu/drm/drm_probe_helper.c | 39 +++++++++++++++++++++++++++++++++-----
 drivers/gpu/drm/drm_sysfs.c        |  2 ++
 include/drm/drm_connector.h        |  3 +++
 4 files changed, 40 insertions(+), 5 deletions(-)
---
base-commit: 4c59525db84aca677fd9f052e662912ad9d88448
change-id: 20260121-hot-plug-passup-f8ed03f7c202

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

