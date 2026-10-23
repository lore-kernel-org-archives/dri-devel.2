Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0744606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=MBwnqBx1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E61A4112CD3;
	Fri, 23 Oct 2026 18:17:29 +0000 (UTC)
X-Greylist: delayed 407 seconds by postgrey-1.36 at gabe;
 Fri, 23 Oct 2026 14:50:14 UTC
Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net
 [178.154.239.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0469A10E0AA;
 Fri, 23 Oct 2026 14:50:14 +0000 (UTC)
Received: from forward104d.mail.yandex.net (forward104d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d104])
 by forward204d.mail.yandex.net (postfix) with ESMTPS id 9660894A3C;
 Fri, 23 Oct 2026 17:43:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-88.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-88.yp-c.yandex.net)
 by forward104d.mail.yandex.net (postfix) with ESMTPS id E8F9AC00F6;
 Fri, 23 Oct 2026 17:43:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88 with ESMTPSA id
 AheAQZCdmOs0-mjGP4gYK; Fri, 23 Oct 2026 17:43:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1792766601; bh=RwwPunpq+kPgJxZIDu9at6+yilTDRAPfDCSCRn3X7f0=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=MBwnqBx1ODxFZVwPyJuBR1by/itNGTFRjxTEWi08jig63QF+ueGJWDkJTMXW8deNC
 ZqtsafHGYPonyjANWefMw4AckyaY6Lmlg4rZTHS6vnCojwSphtfNyrZ8J2Ak26T+lR
 GLt8bOJCV3mg/BQwj38LB6p2HF+Y7N/tYY2UP3rg=
Authentication-Results: mail-nwsmtp-smtp-production-main-88;
 dkim=pass header.i=@yandex.com
From: Alex <xnderv@yandex.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xnderv@yandex.com
Subject: [PATCH] drm/nouveau: idle the channel before destroying an engine
 object via abi16
Date: Fri, 23 Oct 2026 17:42:19 +0300
Message-ID: <20261023144219.46478-1-xnderv@yandex.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 18:17:02 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org

nouveau_abi16_ioctl_del() destroys an engine object (ENGOBJ) created by
nouveau_abi16_ioctl_new() without waiting for the owning channel to go
idle.  The legacy path, nouveau_abi16_ioctl_gpuobj_free(), does call
nouveau_channel_idle() first ("synchronize with the user channel and
destroy the gpu object"), the new ioctl does not.

Chromium-based applications (Chrome, Yandex Browser, Electron apps)
create and immediately delete probe 3D objects at startup.  If the GPU
is busy with other work at that moment (compositor animation while the
app is launched from the GNOME dash, cursor movement), the engine
context is unbound while the channel still references it, and the GPU
faults:

  nouveau 0000:01:00.0: fifo: fault 00 [VIRT_READ] at 0000000000000000
    engine 00 [GR] client 0f [HUB/CTXCTL] reason 00 [PDE] on channel 5
  nouveau 0000:01:00.0: fifo: ... PAGE_NOT_PRESENT ... channel 5 killed!

after which the desktop freezes.  Observed on GF114 (GeForce GTX 560 Ti)
with Linux 7.0.x, reproducible almost every time by launching a Chromium
app from the dash; not seen in 10 consecutive launches with this patch.

Remember the channel an engine object was created on, drop the reference
when the channel is destroyed first, and idle the channel before
nvif_object_dtor() like the gpuobj_free path does.

Signed-off-by: Alex <xnderv@yandex.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -89,6 +89,7 @@
 		ENGOBJ,
 	} type;
 	u64 object;
+	struct nouveau_abi16_chan *chan;
 
 	struct nvif_object engobj;
 
@@ -173,6 +174,13 @@
 			struct nouveau_abi16_chan *chan)
 {
 	struct nouveau_abi16_ntfy *ntfy, *temp;
+	struct nouveau_abi16_obj *obj;
+
+	/* Forget references to this channel held by engine objects. */
+	list_for_each_entry(obj, &abi16->objects, head) {
+		if (obj->chan == chan)
+			obj->chan = NULL;
+	}
 
 	/* Cancel all jobs from the entity's queue. */
 	if (chan->sched)
@@ -749,8 +757,16 @@
 
 	obj = nouveau_abi16_obj_find(abi16, ioctl->object);
 	if (obj) {
-		if (obj->type == ENGOBJ)
+		if (obj->type == ENGOBJ) {
+			/* Synchronize with the user channel before destroying the
+			 * engine object, as the legacy GPUOBJ_FREE path does.  The
+			 * channel may still have work queued that needs the engine
+			 * context which is about to be unbound.
+			 */
+			if (obj->chan && obj->chan->chan)
+				nouveau_channel_idle(obj->chan->chan);
 			nvif_object_dtor(&obj->engobj);
+		}
 		nouveau_abi16_obj_del(obj);
 	}
 
@@ -791,6 +807,7 @@
 	obj = nouveau_abi16_obj_new(abi16, ENGOBJ, args->object);
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
+	obj->chan = chan;
 
 	ret = nvif_object_ctor(&chan->chan->user, "abi16EngObj", args->handle, args->oclass,
 			       NULL, 0, &obj->engobj);
