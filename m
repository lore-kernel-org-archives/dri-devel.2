Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C319606A337
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhllXZo0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8811122D9;
	Fri, 13 Nov 2026 09:03:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C691121C8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:02:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 921B46262D;
 Fri, 13 Nov 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794560578;
 b=RzaicLOYZUxxhG1+Md5E/DlIhg6H1ZY35QF0ujnd9tgpNSyLBYuG/C3amHtvOqbAjxjF
 /kkc+nsr+OKoKwuIs4d+/jtl7k8/jY3eVGZH3BYrtydk/+vV2mz0zoFf6hapTOCVL04YP
 ShdnXMxjaiWedZih7Mq+9wTo3dbQ0lr58p3KxqriQexA+dKQrZq/SZdYyrCFZcaj7ThWw
 nBCO9c961L+SARrzwMtH16eu+Uqdtg9FqMUElmE2lR9MCe+e4ryUP1qKrBMLVtTRw4kyr
 jV+vwLb4aTzfskoi31XyKYgmRk385a9xM7MbsQBx0afuPgC1DJXsj1Ee6fNO3F6kn2g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794560578;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=eYLzKLCBTLiYDook5p4RJ/AJRhAzIQ0VIozKujGazzs=;
 b=A6ph3Nw055az4Z2Oy45bxmBAsCt22KwyRB6tBNiLMc39YtEWzbmipN8lKXDNQoQ02IP9
 QJ1kIItNQmuNIife2xDv2O0758VG6vygb7gLFPmgoUVYzuEL70VlDvVqa7OuL4QLtrY5E
 DVOi13xS8ZZ8gwxWIk+ofz6GfA/vyrq2+EwF/Aba3p0yRA4Ao09B0uo9pfAndLiBIHP2b
 HVOkhfRjQRY6xQNuc83SWTgnzW0+CDMrBePPsoiYtij7xTQjyNofgy2B5dzXRUCeMyig3
 z4F/Xlr6c9scWAWXFT/NxTsYEVauOZP0ju4bB4997kzH0052nnec6aHt8qhpbdVGkMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 2836E1F0089E;
 Fri, 13 Nov 2026 09:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560578;
 bh=eYLzKLCBTLiYDook5p4RJ/AJRhAzIQ0VIozKujGazzs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=fhllXZo0rFD8rrw2Lo+cCBivIaYJdh3Oarx845IiaWDY/3qkgYGzcoDmyva4EIsa7
 uTTENNNyDZOYuSv4Lz304lOkRjfBFCs2bv4bR/F0BZhYomrsUu13QkyLypy45lymoV
 yFJwfyjzfjYf8z4i8kprNgjJp/ldn5Fjo7Y7oCal+Tnz+uR2OVhNTn6m7/qTYaU2VQ
 SpA/p3cpZFSZqzdlgH/trKSVqUnZM/nhPPer9YxsIKZbzKb75e3+hJkq5mnxN861ha
 j8q9K1LwuPrQYI3bMfc2ojIy+hH+gfMLFjNIuE873L+n661NJbrCu1cX/GHlOZuP0q
 iwo9AsX+kkAaQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 67665476F2;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 09:03:00 +0000
Subject: [PATCH v3 08/14] drm/panfrost: Don't signal a job cancelled from
 _NEXT at a reset as done
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-panfrost-long-jobs-v3-8-80ae78d38f6e@gmail.com>
References: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
In-Reply-To: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794560572; l=3231;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=4JeGZ1WkTboDgfEiNJi6mgsaNNVt//564xP/a5auNoc=;
 b=3DLQrx+fTgWlRhjKMCPj2AwDbaXXZlGSSgesP3YXinrMeUDBSr2cHE4X9R03lk5QTilNHk5XC
 q8kPohAvDV6DEiXw5GF4c0rvfB0ZM/07bTaaSxgn7rySH31nYxc7ZP9
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

panfrost_reset() cancels the job in each slot's _NEXT registers with
JS_COMMAND_NOP and soft-stops the running one. If the running job
completes instead of stopping, panfrost_jm_handle_irq() dequeues it,
finds both subslots inactive and takes the cancelled job, now at the
head of the slot, for done as well. The cancelled job gets its jc
cleared and its done fence signalled: drm_sched_resubmit_jobs() does not
run it again, and it completes with -ECANCELED without having run.

The Arm driver reads JS_HEAD_NEXT after the NOP: if it still holds the
job, the job has not started and is evicted. Do the same: take an
evicted job off the slot while the remaining interrupts are handled and
put it back afterwards, so that it is restarted with the others.

Found by code review (Sashiko) of "Soft-stop and resume a job that
outlives the timeout", which widens the window. Not reproduced.

Fixes: 030761e097b4 ("drm/panfrost: Queue jobs on the hardware")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206581@kernel.org/
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7319511db..1bb70b07d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -659,6 +659,7 @@ static void
 panfrost_reset(struct panfrost_device *pfdev,
 	       struct drm_sched_job *bad)
 {
+	struct panfrost_job *evicted[NUM_JOB_SLOTS] = {};
 	u32 js_state, js_state_mask = 0xffffffff;
 	unsigned int i, j;
 	bool cookie;
@@ -694,11 +695,25 @@ panfrost_reset(struct panfrost_device *pfdev,
 	job_write(pfdev, JOB_INT_MASK, 0);
 	synchronize_irq(pfdev->js->irq);
 
+	spin_lock(&pfdev->js->job_lock);
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		/* Cancel the next job and soft-stop the running job. */
 		job_write(pfdev, JS_COMMAND_NEXT(i), JS_COMMAND_NOP);
+
+		/* A job still in _NEXT after the NOP never started. Take it
+		 * off the slot, or panfrost_jm_handle_irq() takes it for done
+		 * if the running job completes instead of stopping.
+		 */
+		if (pfdev->jobs[i][1] &&
+		    (job_read(pfdev, JS_HEAD_NEXT_LO(i)) ||
+		     job_read(pfdev, JS_HEAD_NEXT_HI(i)))) {
+			evicted[i] = pfdev->jobs[i][1];
+			pfdev->jobs[i][1] = NULL;
+		}
+
 		job_write(pfdev, JS_COMMAND(i), JS_COMMAND_SOFT_STOP);
 	}
+	spin_unlock(&pfdev->js->job_lock);
 
 	/* Wait at most 10ms for soft-stops to complete */
 	ret = readl_poll_timeout(pfdev->iomem + JOB_INT_JS_STATE, js_state,
@@ -720,6 +735,10 @@ panfrost_reset(struct panfrost_device *pfdev,
 	 */
 	spin_lock(&pfdev->js->job_lock);
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
+		/* Put the evicted job back, to be restarted. */
+		if (evicted[i])
+			pfdev->jobs[i][pfdev->jobs[i][0] ? 1 : 0] = evicted[i];
+
 		for (j = 0; j < ARRAY_SIZE(pfdev->jobs[0]) && pfdev->jobs[i][j]; j++) {
 			if (pfdev->jobs[i][j]->requirements & PANFROST_JD_REQ_CYCLE_COUNT ||
 			    pfdev->jobs[i][j]->is_profiled)

-- 
2.55.0


