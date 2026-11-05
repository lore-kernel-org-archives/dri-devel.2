Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B0A606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DehnY+ZS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE8B1112173;
	Thu,  5 Nov 2026 07:27:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7396D11218A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:27:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D0ED44608;
 Thu,  5 Nov 2026 07:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1581F0093A;
 Thu,  5 Nov 2026 07:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793863653;
 bh=yRtHgNG9AeN2I9NPJqnpHD/E0aYFVisIKFUpuKWAl6E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DehnY+ZSE35moNzQT1cOVlSA+Lh9Y8qzikyEMfXEhvNfL3du1MnUuukknApAhw51d
 GsNoeTMHXikVts0vmUPwszYF2o1OPdP5oJ0xFil3Y9HkkrInOpsgWiafoK9Iel2rY+
 5lyQNZXLpWpZQ1C+ZwYrb1WyCzPcbLfj+IEwvCtVqOsin4PUDyL4xhns2TYGReJfR2
 MXBu0sW/0PUjczUZLVbmEky6BvdSDUWLm2hLji9aWPuv36rgVkAVupEolFoEWiwSwp
 qQdr9agBDaSePkw69YFpM9fQd701Gjy589lK4xCaKi6ekNu2iUAvfMRKpLT9IWaHuY
 9Q0yLGFtY53Sw==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv3 12/13] media: cec: core: implement
 CEC_EVENT_FL_STATE_HPD_PRESENT
Date: Thu,  5 Nov 2026 08:22:26 +0100
Message-ID: <b57a1fc1bb55bd53c9cfc938b0129a6b8b832e90.1793863347.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set CEC_EVENT_FL_STATE_HPD_PRESENT if needed when posting the state
change event.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/cec/core/cec-adap.c |  2 ++
 drivers/media/cec/core/cec-api.c  | 10 ++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 55b2e711fe77..fec7a58aff65 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -323,6 +323,8 @@ static void cec_post_state_event(struct cec_adapter *adap)
 	ev.state_change.log_addr_mask = adap->log_addrs.log_addr_mask;
 	ev.state_change.have_conn_info =
 		adap->conn_info.type != CEC_CONNECTOR_TYPE_NO_CONNECTOR;
+	if (adap->log_addrs.flags & CEC_LOG_ADDRS_FL_HPD_PRESENT)
+		ev.flags |= CEC_EVENT_FL_STATE_HPD_PRESENT;
 	cec_queue_event(adap, &ev);
 }
 
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index 1ba080d5a123..4507bf081159 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -560,10 +560,7 @@ static int cec_open(struct inode *inode, struct file *filp)
 	 * Initial events that are automatically sent when the cec device is
 	 * opened.
 	 */
-	struct cec_event ev = {
-		.event = CEC_EVENT_STATE_CHANGE,
-		.flags = CEC_EVENT_FL_INITIAL_STATE,
-	};
+	struct cec_event ev = {};
 	unsigned int i;
 	int err;
 
@@ -589,12 +586,17 @@ static int cec_open(struct inode *inode, struct file *filp)
 	filp->private_data = fh;
 
 	/* Queue up initial state events */
+	ev.event = CEC_EVENT_STATE_CHANGE;
 	ev.state_change.phys_addr = adap->phys_addr;
 	ev.state_change.log_addr_mask = adap->log_addrs.log_addr_mask;
 	ev.state_change.have_conn_info =
 		adap->conn_info.type != CEC_CONNECTOR_TYPE_NO_CONNECTOR;
+	ev.flags = CEC_EVENT_FL_INITIAL_STATE;
+	if (adap->log_addrs.flags & CEC_LOG_ADDRS_FL_HPD_PRESENT)
+		ev.flags |= CEC_EVENT_FL_STATE_HPD_PRESENT;
 	cec_queue_event_fh(fh, &ev, 0);
 #ifdef CONFIG_CEC_PIN
+	ev.flags = CEC_EVENT_FL_INITIAL_STATE;
 	if (adap->pin && adap->pin->ops->read_hpd &&
 	    !adap->devnode.unregistered) {
 		err = adap->pin->ops->read_hpd(adap);
-- 
2.53.0

