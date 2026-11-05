Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3C606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7a9BnUW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DC4112194;
	Thu,  5 Nov 2026 07:27:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783A2112173
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:27:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F27AC60F00;
 Thu,  5 Nov 2026 07:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850181F0093A;
 Thu,  5 Nov 2026 07:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793863649;
 bh=kadFEy+/72y6ZOpa2TS32E9qFJbHaf1fMrcltpT+OOo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L7a9BnUWQNd0fA+JejPbn25bQN3yxib/ZgpPuJksSsSWLUDpK9mHb4Id9AC8+xF7i
 jtrZ9B/numoi20fKLh/PYl1MIkoIfnkot9n8nB5YgkPpMn42g3taKcU6I1Kw1RwVGa
 1Nj0SV8ZChbWYCHlMLTXHDijnlDJCX72kULRoUs6rva8M/cwHtTuRb3DFdCr2I3z/3
 ODoUl6uNzBAhIiPZCKCBYkAQNfrxUq+SLBBOxWlvycjleRAsTcX6WwHQuNNjNR/Ji6
 8cBJ7KFbtTyIMdBFzkHjyZAX3wGbCL+Q7tEgfAdSFhbsbsaylrGh4voPBbjgVaNOcf
 TfwmLIB/daCwA==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv3 10/13] media: uapi: cec.h: add
 CEC_EVENT_FL_STATE_HPD_PRESENT flag
Date: Thu,  5 Nov 2026 08:22:24 +0100
Message-ID: <81a832c5568748e37f081d217998f80880ab8dc4.1793863347.git.hverkuil+cisco@kernel.org>
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

The CEC_EVENT_FL_STATE_HPD_PRESENT will report whether the HPD is
present or not.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 include/uapi/linux/cec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
index b1b5f4748583..d595ad744431 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -455,6 +455,7 @@ struct cec_connector_info {
 
 #define CEC_EVENT_FL_INITIAL_STATE	(1 << 0)
 #define CEC_EVENT_FL_DROPPED_EVENTS	(1 << 1)
+#define CEC_EVENT_FL_STATE_HPD_PRESENT	(1 << 2)
 
 /**
  * struct cec_event_state_change - used when the CEC adapter changes state.
-- 
2.53.0

