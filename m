Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDA606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INrXcUPC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19FFD10F828;
	Tue,  3 Nov 2026 20:03:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976E110F807;
 Tue,  3 Nov 2026 20:02:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CA1041349;
 Tue,  3 Nov 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793736174;
 b=dJu6k1c+rvhBUHG0JxI7DZwqF55UQl+Z2mD2YxIkpljWLQ2+shU5/mA2i06K4MfdhjnH
 IcE4l+dZxZvwmpwow9lO7K1WDfj1axQB9WIhEfDzYBJvkYBd3XEkbgJ3imrlqxGkmd4Oy
 GYihfS4c1VonJl771Lmic9JFoZt4U/RbTap7YJFHsGJui6B/rSGVTXJgqIuua0QBBhoSL
 WpYQQxyZeER7gj5ZFDqjRlCpkAREnpwbvqts/XmAlExO0cW0vruTTszHt6QzQ78I4fC3L
 xftso2FotCuivFu34Y3+8fLRJx/YtdwpHBn17jvA6pHVo+kXDfZkU8dSqsm4xDRKu1A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793736174;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=VovlxiaHAGxDQRs3t8ZB0boyoK01Xmz6n1G4/DfvQfQ=;
 b=e0nV98iaCtU3TbbbLIAQa8fHsOcxYC4NqljO7I3/u+9d5wxny7yBo95YFPnvhlspu1mU
 P6pPQpy/VcJqZILM45ZfH3KcWRz3cj7gVPiF7NZFi2UJ7k0pO19vvdBOr8gHd/N2Kmdcl
 qjexqUn+JjNHhFLV9kwdesxmGZW8/H/r+6L1NhUqUashy/FbpuDi2UDWMWc52mHv+CaA9
 5EHG36Z2VLpjAs6v8Sk8aRGM7T64nO+NoUeIAFFlvaorNDoEdnWNEyQ6cQJATSj/uwnof
 x9Ng+cXqfLJKjtQjnbL3P7sqS/j6qEWXOSzHAMzYaUGqlBTfjIrEWdstPssbPOMILtA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A1B0E1F00A17;
 Tue,  3 Nov 2026 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793736174;
 bh=VovlxiaHAGxDQRs3t8ZB0boyoK01Xmz6n1G4/DfvQfQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=INrXcUPCSCDn8r0Dc+ZDKtOy9E/usDx5hmjO6Sv4Hnrj79zgAZ8eHajsfT6CKapLt
 tquya/iCAA47roR6awt0fqdY6g8sXyefy6EPgZh/AWB9kuRh/Bt+ka2JvBpiisQ8W7
 DKIkpPYrxTKI6ZHqL9P8dP0n5PQq0IhY4NKlsDA41pf0zGFZNzpSPBnc/lKtOIQpI3
 BesYsDh4HRA+SFUA+8lxpq/GEk7Hz3x2++7oWEu+2jcJslCwNuOhs55oG/Nj7DFIkK
 LnnKi45IPoa6+ucE34KiGABOPfRKu0Q83X9LI3pzKgcII5ElG9E6z+6Al+EJ8Wrvtt
 0WnchAFg/PmYA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1849346AF1;
 Tue,  3 Nov 2026 20:02:52 +0000 (UTC)
From: "David R. Hedges via B4 Relay"
 <devnull+linuxdev844.thelittleman.net@kernel.org>
Date: Tue, 03 Nov 2026 14:02:51 -0600
Subject: [PATCH 5/5] drm/nouveau/dp: restart an active link when the sink
 reasserts HPD
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nouveau-dp-relink-v1-5-7ee88c7f1e8a@thelittleman.net>
References: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
In-Reply-To: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@intel.com>, Ben Skeggs <bskeggs@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Danilo Krummrich <me@dakr.org>, 
 "David R. Hedges" <linuxdev844@thelittleman.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793736171; l=6803;
 i=linuxdev844@thelittleman.net; s=20261103; h=from:subject:message-id;
 bh=Wj9O+KZXb+AJG+c61p+ihLDpQLh/2BrNWBgFuU7RiIg=;
 b=XggoV3AxSDbv4q/H13nQdZIi21yV13MlmFAf25rnbaz3E5DM7QnaYtAjDbOVbW/Nx8rvIhgaD
 ifxS9iWRdhDBfdSykeRCEZmGIbWvpLxwmYfs53IoHzQfJCd93s6bRTP
X-Developer-Key: i=linuxdev844@thelittleman.net; a=ed25519;
 pk=Cynzuei/w0GLdh3LuNJdvH7aaszLrHSxY5UyujS7l+g=
X-Endpoint-Received: by B4 Relay for linuxdev844@thelittleman.net/20261103
 with auth_id=1397
X-Original-From: "David R. Hedges" <linuxdev844@thelittleman.net>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: linuxdev844@thelittleman.net
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "David R. Hedges" <linuxdev844@thelittleman.net>

When a DP sink drops HPD for longer than an IRQ_HPD pulse, it may have
reset its end of the link.  nouveau handles the unplug and plug by
re-running connector detection and sending hotplug events, but if the
same display comes back, userspace sees nothing that needs a modeset
and leaves the CRTC as it was.  Nothing trains the link again, and the
sink is left without a picture.

That's what happens with an IGM L28TN4K on a GA102 (GSP-RM 570.144)
after waking it from DPMS off.  If the link is trained before the
monitor has finished waking up, training succeeds at 4 x HBR2, but
about two seconds later the monitor raises IRQ_HPD and shows "No input
signal", and two seconds after that it drops HPD briefly and reasserts
it.  The link status read on the IRQ_HPD is 77 77 01 03 (DPCD
0x202-0x205: all lanes locked, interlane-aligned, sink in sync), and
DP_SET_POWER still reads D0 once HPD is back, so there's nothing to
check that would show the problem.  Whenever the IRQ_HPD came before
link training instead, the picture came up normally.  The same happens
after replugging the cable and after resuming from S3, and the screen
stays dark until the cable is replugged, often several times.

When a plug or unplug event leaves a DP connector connected while it
still drives an active CRTC, restart the link with a modeset, using
the restart added for lost links on GSP-RM, on any GPU.  NVIDIA's own
DisplayPort library does the equivalent:
ConnectorImpl::notifyLongPulseInternal() calls assessLink(), which
retrains the link, for an SST sink that's still connected.  i915, by
contrast, only retrains on hotplug if the link status says the link is
bad.  With this applied, the monitor above comes back four to five
seconds after being woken, replugged or resumed.  On resume,
nouveau_display_hpd_resume() schedules the HPD worker without any
events, so this doesn't add a restart to the resume modeset.

Switched on with its power button, which it reports only as a plug
event, the same monitor first advertises DPCD 1.1 and HBR, which can't
carry the 3840x2160@60 mode its CRTC still has.  The restart then fails
atomic check, link-status is set to BAD, and userspace, which gets a
hotplug event, picks a mode that fits.  About a second later the
monitor drops and reasserts HPD with its full capabilities, and
userspace goes back to 3840x2160@60.

A sink that dropped HPD every time its link was trained would have the
link restarted for ever, so stop after five restarts that each came
within ten seconds of the one before, until ten seconds have passed
without one.  If userspace has already responded to a hotplug event
with a modeset of its own by the time the HPD worker runs, the link is
restarted a second time, which costs another brief blank but is
otherwise harmless.

Closes: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/515
Signed-off-by: David R. Hedges <linuxdev844@thelittleman.net>
---
 drivers/gpu/drm/nouveau/nouveau_connector.h |  5 +++
 drivers/gpu/drm/nouveau/nouveau_display.c   | 51 ++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index 3109278d36ea..914e86ad2df2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -135,6 +135,11 @@ struct nouveau_connector {
 	struct nvif_event irq;
 	struct work_struct irq_work;
 	struct work_struct link_bad_work;
+	/* Recent link restarts, see nouveau_display_relink() */
+	struct {
+		unsigned long last;
+		unsigned int count;
+	} relink;
 
 	struct drm_dp_aux aux;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index c5e914602baf..a52db6129962 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -418,6 +418,33 @@ nouveau_display_hpd_resume(struct nouveau_drm *drm)
 	schedule_work(&drm->hpd_work);
 }
 
+/* A sink that responds to link training by dropping HPD would otherwise have
+ * its link restarted for ever.  Stop after a few restarts that each came soon
+ * after the one before, until things have been quiet for a while.
+ */
+#define NOUVEAU_RELINK_MAX	5
+#define NOUVEAU_RELINK_QUIET	(10 * HZ)
+
+static bool
+nouveau_display_relink_allowed(struct drm_connector *connector)
+{
+	struct nouveau_connector *nv_connector = nouveau_connector(connector);
+	unsigned long now = jiffies;
+
+	if (time_after(now, nv_connector->relink.last + NOUVEAU_RELINK_QUIET))
+		nv_connector->relink.count = 0;
+	nv_connector->relink.last = now;
+
+	if (nv_connector->relink.count++ < NOUVEAU_RELINK_MAX)
+		return true;
+
+	if (nv_connector->relink.count == NOUVEAU_RELINK_MAX + 1)
+		NV_WARN(nouveau_drm(connector->dev),
+			"%s: link restarted %d times in quick succession, giving up\n",
+			connector->name, NOUVEAU_RELINK_MAX);
+	return false;
+}
+
 /* Restart the pipe driving @connector with a full modeset, so that its link is
  * trained again along with everything else.
  */
@@ -427,6 +454,7 @@ nouveau_display_relink(struct drm_connector *connector)
 	struct drm_device *dev = connector->dev;
 	struct drm_modeset_acquire_ctx ctx;
 	struct drm_crtc *crtc;
+	bool counted = false;
 	int ret;
 
 	drm_modeset_acquire_init(&ctx, 0);
@@ -443,11 +471,18 @@ nouveau_display_relink(struct drm_connector *connector)
 	if (ret)
 		goto out;
 
-	if (crtc->state->active) {
-		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] restarting link\n",
-			    connector->base.id, connector->name);
-		ret = drm_atomic_helper_reset_crtc(crtc, &ctx);
+	if (!crtc->state->active)
+		goto out;
+
+	if (!counted) {
+		if (!nouveau_display_relink_allowed(connector))
+			goto out;
+		counted = true;
 	}
+
+	drm_dbg_kms(dev, "[CONNECTOR:%d:%s] restarting link\n",
+		    connector->base.id, connector->name);
+	ret = drm_atomic_helper_reset_crtc(crtc, &ctx);
 out:
 	if (ret == -EDEADLK) {
 		drm_modeset_backoff(&ctx);
@@ -510,6 +545,14 @@ nouveau_display_hpd_work(struct work_struct *work)
 			    !!(bits & NVIF_CONN_EVENT_V0_UNPLUG),
 			    !!(bits & NVIF_CONN_EVENT_V0_IRQ));
 
+		/* If a DP sink dropped HPD while we were driving it, it may have
+		 * reset its end of the link whatever its link status says, and
+		 * userspace won't modeset again if nothing else has changed.
+		 */
+		if (nv_connector->dp_encoder &&
+		    (bits & (NVIF_CONN_EVENT_V0_PLUG | NVIF_CONN_EVENT_V0_UNPLUG)))
+			modeset = true;
+
 		/* A plug or unplug event pending alongside the IRQ, such as a
 		 * sink count change reported by nouveau_dp_irq(), still needs
 		 * connector detection.

-- 
2.55.0


