Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F771C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC45A10EFFA;
	Thu, 20 Aug 2026 11:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yvv/eGdJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79D110EFFA
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:33:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 600C960A6E;
 Thu, 20 Aug 2026 11:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361FB1F000E9;
 Thu, 20 Aug 2026 11:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787225635;
 bh=r0QdPG3O6G+DAFVbGZT7X3IKt/4oCY6MKr2yFoXjRI4=;
 h=Subject:To:Cc:From:Date;
 b=yvv/eGdJwfqXb8R21vkXbUcrhqK3w1rUL+rpa7ax3oNc4thz9+lvK7w9f+yEBKgdl
 6C/cjkN0KHdaFI++UV886bWD270FqX4mU0LKCrr0iiOkmhFL6IxOTSAtKX/EfBQYDR
 hfH1m8czzgeA/3Qa3F1ErDDq234u8pP/5ygp4t3g=
Subject: Patch "drm/connector/hdmi: Fix out of bounds memory read" has been
 added to the 6.12-stable tree
To: John.Harrison@Igalia.com, airlied@gmail.com, daniel@fooishbar.org,
 dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 jani.nikula@intel.com, jose.exposito89@gmail.com,
 laurent.pinchart+renesas@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, nicolas.frattaroli@collabora.com, simona@ffwll.ch,
 tzimmermann@suse.de, ville.syrjala@linux.intel.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:17:06 +0200
Message-ID: <2026082006-feminine-subwoofer-e2e4@gregkh>
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

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-connector-hdmi-fix-out-of-bounds-memory-read.patch
and it can be found in the queue-6.12 subdirectory.

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
@@ -710,7 +710,8 @@ drm_atomic_helper_connector_hdmi_update_
 
 	mutex_lock(&connector->hdmi.infoframes.lock);
 
-	memcpy(&infoframe->data, frame, sizeof(infoframe->data));
+	BUILD_BUG_ON(sizeof(*frame) > sizeof(infoframe->data));
+	memcpy(&infoframe->data, frame, sizeof(*frame));
 	infoframe->set = true;
 
 	ret = write_infoframe(connector, infoframe);


Patches currently in stable-queue which might be from John.Harrison@Igalia.com are

queue-6.12/drm-connector-hdmi-fix-out-of-bounds-memory-read.patch
