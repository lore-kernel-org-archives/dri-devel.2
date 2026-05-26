Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD74ACD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 12:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B05810E19E;
	Tue, 26 May 2026 12:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ZyBu5cKQ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C6D10E19E;
 Tue, 26 May 2026 12:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779799176; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FHMDrAhdEs0OrFFvCIQssOcWE8Pxb8+OI7y+nOAM+9lu0A67IsdbLWc0Oie2WHnRZpV8oPnBO6Qxyxq5s7aE2irDoRyxJH4XpCVIJ5wXGSF2+NQAbcMgzT1t48diCo0lsbX0Wkj9ngYCIJCyENFueeMIj3hfmhnGDpSeCAcKdtI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779799176;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=M7jf9r6LDYgBpIN5YiPz8eq0+AfigdsEo6SHVXUQO3M=; 
 b=JT0FD+cIoYXISzFdRoKzNrTtSeVY5NEqVL5DDRmK0ndgwJOBOD5qJwpZAV86xZHxf3SJ3GN6Kgq+6CXw2ePOlhOvSIB4UsTs6yXYvkCWPxw2E+vQyAzbhryQfWD+94gCHolaZPNuyBGNbx8PLqSijmyQ/0r6fIGKcihY1Sh7m8Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779799176; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=M7jf9r6LDYgBpIN5YiPz8eq0+AfigdsEo6SHVXUQO3M=;
 b=ZyBu5cKQy4SA9KWBZqOAjtEO9Rx7UVF969T8UrYyCsrvEf2mrKnTbhOOZpTaCtVQ
 lJQ/8P1s4xYp1o9kNJimqKkfXlaC1gWfBm2JZqe2CLDRWOJtrhQPFLvEU943bZTQ1OA
 jbt0oZyCMAPk48AS6GWcJ8umS3hvr+AtEVIvlTL0=
Received: by mx.zohomail.com with SMTPS id 1779799175325815.603801727844;
 Tue, 26 May 2026 05:39:35 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v10 0/2] Pass down hot-plug CONNECTOR ID to user-space
Date: Tue, 26 May 2026 14:39:09 +0200
Message-Id: <20260526-hot-plug-passup-v10-0-f62351a9ea3e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WQQW6DMBBFrxJ5XaeMwcZk1XtUXYxhHCxBTG1Ar
 SLuXkNTRQqR6o01M/7vz/eVRQqOIjsdrizQ7KLzl1RA9nJgdYuXM3HXpAYTmVAZCOCtH/nQTWc
 +YIzTwK2mJsttWacXLKmGQNZ9bcj3j1Tb4Hs+toHwjyNhPUrkuT6ChAI48B6Dm+Jx7rB5q33Xo
 fEBj7Xvb8hAn1NabvzlMoOReJr2bjwdmpAM3PB6u9nq2ro4+vC95ZrVprklyHcJZsUzjohWQVO
 pzJiHDVbeXN4ZAso9o0wMq4UAIxCNhH2KTVuAfK6tUJRkJYlC6Gf++u5fCLFn6MSQtUVSBguA6
 hmj+odRrf9AVqeplJVWj4xlWX4AdwdZhjECAAA=
X-Change-ID: 20260121-hot-plug-passup-f8ed03f7c202
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniels@collabora.com>, 
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
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

This series addresses a shortcoming whereby a hot plug event is sent
without it being passed the actual connector that caused it. This takes
into consideration both the polling path and the HPD (Hot Plug Detect)
path.

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

By sending connector specific hotplug events, this ambiguity is resolved
without any change to the user-space API. Future work should however
make the kernel explicitly request a modeset from userspace through a
more robust path, either by using link-status (nb. the userspace side
may not handle it properly at present) or by exposing the epoch counter
through the uAPI such that fragile state comparison code is no longer
needed.

This change results in potentially more hotplug events being sent than
previously, as n changed connectors at a time result in n hotplug
events, rather than just a single one.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v10:
- Fix delayed_event processing in !drm_kms_helper_poll path. This
  necessitates taking the lock in that path for reading delayed_event as
  well. I chose not to transition delayed_event to an atomic_t yet, as I
  don't want to rock the boat too much in this series.
- Move delayed_event read/clear inside of the mode_config.mutex locked
  section.
- Link to v9: https://patch.msgid.link/20260422-hot-plug-passup-v9-0-aef804255986@collabora.com

Changes in v9:
- Get rid of the kmalloc_array by splitting the hotplug event into its
  two constituent parts to avoid the deadlock.
- Link to v8: https://patch.msgid.link/20260422-hot-plug-passup-v8-0-5cfae6ba4119@collabora.com

Changes in v8:
- Drop pending_hp patch
- Add patch correcting epoch_counter documentation
- Rework implementation such that hotplug events are still sent outside
  the mode_config mutex, but don't iterate through the connector list
  without the lock.
- Link to v7: https://patch.msgid.link/20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com

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
Nicolas Frattaroli (2):
      drm/connector: Fix epoch_counter docs to reflect reality
      drm: Send per-connector hotplug events

 drivers/gpu/drm/drm_probe_helper.c | 53 ++++++++++++++++++++------------------
 include/drm/drm_connector.h        |  5 +++-
 2 files changed, 32 insertions(+), 26 deletions(-)
---
base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
change-id: 20260121-hot-plug-passup-f8ed03f7c202

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

