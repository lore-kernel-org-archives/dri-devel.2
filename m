Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531DEC5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912EF10E1B1;
	Thu, 20 Aug 2026 11:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qVliiykB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7C710E1B1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:21:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8028412EB;
 Thu, 20 Aug 2026 11:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EF71F000E9;
 Thu, 20 Aug 2026 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787224882;
 bh=pLd7oxsI+MaZ9lV6tn4kVxhQpJwd26RIAhKjs13kCDM=;
 h=Subject:To:Cc:From:Date;
 b=qVliiykB6l8K3PySusWZiEsYQHz6R8xv8ynMUIdinBtNyrJZhhTb/wbB55Wqn41dJ
 RlNPlp/6KbzrSOuCBKci3BSvOS3e6Ez/6HMC5ZVWGkKn/h6WJL5DsK+OVmmM2MoD+S
 ilTtz7SfYOtb4mS9sLCVOwyy6At1CdQ3ge9j/2yQ=
Subject: Patch "drm/connector/hdmi: Fix out of bounds memory read" has been
 added to the 6.18-stable tree
To: John.Harrison@Igalia.com, airlied@gmail.com, daniel@fooishbar.org,
 dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 jani.nikula@intel.com, jose.exposito89@gmail.com,
 laurent.pinchart+renesas@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, nicolas.frattaroli@collabora.com, simona@ffwll.ch,
 tzimmermann@suse.de, ville.syrjala@linux.intel.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:15:27 +0200
Message-ID: <2026082027-hydration-flip-78e3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    drm/connector/hdmi: Fix out of bounds memory read

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-connector-hdmi-fix-out-of-bounds-memory-read.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 9ecf8ba763d0ffe0673538eb4bf7806f20455d19 Mon Sep 17 00:00:00 2001
From: John Harrison <John.Harrison@Igalia.com>
Date: Thu, 23 Jul 2026 15:06:52 -0700
Subject: drm/connector/hdmi: Fix out of bounds memory read
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: John Harrison <John.Harrison@Igalia.com>

commit 9ecf8ba763d0ffe0673538eb4bf7806f20455d19 upstream.

A helper function was copying a given audio infoframe into the
connector's copy but using the size of the destination (a generic
target, sized to accept many different data blocks) not the source (a
very specific type of data block). Thus, it was copying 60 bytes of
data from a 28 byte allocation.

Fix that by using the source size instead, together with a build bug
on the source size actually being smaller than the destination.

I hit this running KUnit tests under KASAN (while debugging something
else entirely). In the real world, it seems unlikely to cause an
actual problem. It is a read not a write so it can't corrupt any
memory. However, it could potentially fall off the end of a page and
cause an accvio bug.

Fixes: f378b77227bc ("drm/connector: hdmi: Add Infoframes generation")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Daniel Stone <daniel@fooishbar.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: José Expósito <jose.exposito89@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org # v6.11+
Signed-off-by: John Harrison <John.Harrison@Igalia.com>
Link: https://patch.msgid.link/20260723220652.533345-1-John.Harrison@Igalia.com
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1072,7 +1072,8 @@ drm_atomic_helper_connector_hdmi_update_
 
 	mutex_lock(&connector->hdmi.infoframes.lock);
 
-	memcpy(&infoframe->data, frame, sizeof(infoframe->data));
+	BUILD_BUG_ON(sizeof(*frame) > sizeof(infoframe->data));
+	memcpy(&infoframe->data, frame, sizeof(*frame));
 	infoframe->set = true;
 
 	ret = write_infoframe(connector, infoframe);


Patches currently in stable-queue which might be from John.Harrison@Igalia.com are

queue-6.18/drm-connector-hdmi-fix-out-of-bounds-memory-read.patch
