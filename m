Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B53606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=IngimSJw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5777B112CA9;
	Fri, 23 Oct 2026 18:17:14 +0000 (UTC)
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net
 [51.250.60.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9678110E044;
 Fri, 23 Oct 2026 15:24:30 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-12.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-12.yp-c.yandex.net)
 by forward102d.mail.yandex.net (postfix) with ESMTPS id 28A12C017E;
 Fri, 23 Oct 2026 18:24:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-12 with ESMTPSA id
 GOf0WQDdMGk0-4OD3IW0V; Fri, 23 Oct 2026 18:24:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1792769067; bh=LbacRowWzwVnlWbExXUMiESmxUlI+FAcFK05tc4OaJ0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IngimSJw6n+DSn0/XNAB70exzvTkwmDZrUAthuRcBs2fspHRAX02TMVxXsjm/111U
 gP+AsKpm4qtjC8XTSFHs4qiroQnQT1oMDgvxMi5ueMjB4wmSzkSZpLBlEb5EUUyfXm
 2oLBGTy5Lx8lAu3j8VpBsvYksZ5vlnbPJxDojeUw=
Authentication-Results: mail-nwsmtp-smtp-production-main-12;
 dkim=pass header.i=@yandex.com
From: Alex <xnderv@yandex.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xnderv@yandex.com
Subject: [PATCH v2] drm/nouveau: idle the channel before destroying an engine
 object via abi16
Date: Fri, 23 Oct 2026 18:23:32 +0300
Message-ID: <20261023152332.9420-2-xnderv@yandex.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023152332.9420-1-xnderv@yandex.com>
References: <20261023144219.46478-1-xnderv@yandex.com>
 <20261023152332.9420-1-xnderv@yandex.com>
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
v2: wait for the channel's scheduler to drain before idling the channel
    when VM_BIND is in use.  Legacy PUSHBUF submissions are serialized
    with the ioctl by cli->mutex, but EXEC jobs are pushed to the channel
    asynchronously from the scheduler workqueue, so emitting a fence from
    nouveau_abi16_ioctl_del() could race with nouveau_exec_job_run(), and
    jobs still queued in the entity would not have been covered by the
    fence at all.  Reuse the existing job-list wait from
    nouveau_sched_fini() through a small helper, nouveau_sched_wait_idle().
    (Race pointed out by the Sashiko AI review of v1.)

drivers/gpu/drm/nouveau/nouveau_abi16.c | 27 +++++++++++++++++++++++-
drivers/gpu/drm/nouveau/nouveau_sched.c |  9 +++++++-
drivers/gpu/drm/nouveau/nouveau_sched.h |  1 +
3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index b776030..d979cd8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -89,6 +89,7 @@ struct nouveau_abi16_obj {
 		ENGOBJ,
 	} type;
 	u64 object;
+	struct nouveau_abi16_chan *chan;
 
 	struct nvif_object engobj;
 
@@ -173,6 +174,13 @@ nouveau_abi16_chan_fini(struct nouveau_abi16 *abi16,
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
@@ -784,8 +792,24 @@ nouveau_abi16_ioctl_del(struct nouveau_abi16 *abi16, struct nvif_ioctl_v0 *ioctl
 
 	obj = nouveau_abi16_obj_find(abi16, ioctl->object);
 	if (obj) {
-		if (obj->type == ENGOBJ)
+		if (obj->type == ENGOBJ) {
+			/* Synchronize with the user channel before destroying the
+			 * engine object, as the legacy GPUOBJ_FREE path does.  The
+			 * channel may still have work queued that needs the engine
+			 * context which is about to be unbound.
+			 *
+			 * Legacy PUSHBUF submissions are serialized with this ioctl
+			 * by cli->mutex.  With VM_BIND, EXEC jobs are pushed to the
+			 * channel asynchronously by the scheduler, so wait for every
+			 * submitted job to finish before touching the channel.
+			 */
+			if (obj->chan && obj->chan->chan) {
+				if (obj->chan->sched)
+					nouveau_sched_wait_idle(obj->chan->sched);
+				nouveau_channel_idle(obj->chan->chan);
+			}
 			nvif_object_dtor(&obj->engobj);
+		}
 		nouveau_abi16_obj_del(obj);
 	}
 
@@ -826,6 +850,7 @@ nouveau_abi16_ioctl_new(struct nouveau_abi16 *abi16, struct nvif_ioctl_v0 *ioctl
 	obj = nouveau_abi16_obj_new(abi16, ENGOBJ, args->object);
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
+	obj->chan = chan;
 
 	ret = nvif_object_ctor(&chan->chan->user, "abi16EngObj", args->handle, args->oclass,
 			       NULL, 0, &obj->engobj);
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index b3f02c4..956ca73 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -493,13 +493,20 @@ nouveau_sched_job_list_empty(struct nouveau_sched *sched)
 	return empty;
 }
 
+/* Wait until every job submitted to the scheduler has finished. */
+void
+nouveau_sched_wait_idle(struct nouveau_sched *sched)
+{
+	wait_event(sched->job.wq, nouveau_sched_job_list_empty(sched));
+}
+
 static void
 nouveau_sched_fini(struct nouveau_sched *sched)
 {
 	struct drm_gpu_scheduler *drm_sched = &sched->base;
 	struct drm_sched_entity *entity = &sched->entity;
 
-	wait_event(sched->job.wq, nouveau_sched_job_list_empty(sched));
+	nouveau_sched_wait_idle(sched);
 
 	drm_sched_entity_fini(entity);
 	drm_sched_fini(drm_sched);
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
index 51ce8dc..0562af6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.h
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
@@ -115,5 +115,6 @@ struct nouveau_sched {
 int nouveau_sched_create(struct nouveau_sched **psched, struct nouveau_drm *drm,
 			 struct workqueue_struct *wq, u32 credit_limit);
 void nouveau_sched_destroy(struct nouveau_sched **psched);
+void nouveau_sched_wait_idle(struct nouveau_sched *sched);
 
 #endif
