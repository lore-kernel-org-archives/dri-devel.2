Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06009606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBAEV328
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2171410F3F7;
	Tue,  3 Nov 2026 07:40:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60DA510F3F3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:40:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48FFF43F64;
 Tue,  3 Nov 2026 07:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130571F00919;
 Tue,  3 Nov 2026 07:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793691638;
 bh=Rabuf4op/XN5NP6YCfyGe/a7zJ5w3jeN4Y6eXAm5e00=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VBAEV3282+sZdY2DagnFYdB0oW4fOavxYu5Ke68Lc+DqHiPFhZkcAwAcm7M6zQxcB
 CS+pn8paSOakv3GMSxphVlvKEgxJM6ApSNu/w8fWtsBbgYSBVcxnC/pAioUumwaJsV
 OyPkADf/yU4QXsgaKo6/Xmc1cG+oqKw36xXSJUqG0/d9pqFRkJDb3yAAQRl/ZlkpRz
 wBBciqGmnksAFd4bMfMEJgBIwy+2cBm2encUeIeo/8M8waVyLeYrO528Sh+k4aJjlt
 2tNWP+GQAwcAA/j8U9bvmnAjpJhEpFuMx8FLIqvCGT9QnpPFi1/MUsoSezX4/xCyzy
 xLz9Ric/He58w==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv2 10/13] media: uapi: cec.h: add
 CEC_EVENT_FL_STATE_EDID_PRESENT flag
Date: Tue,  3 Nov 2026 08:32:01 +0100
Message-ID: <215493fe7ce132b19dc109f0fa83d3bd2c081d2b.1793691124.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
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

The CEC_EVENT_FL_STATE_EDID_PRESENT will report whether the EDID is
present or not.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 include/uapi/linux/cec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
index 8f7c7a4cb505..8324d208c1d5 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -455,6 +455,7 @@ struct cec_connector_info {
 
 #define CEC_EVENT_FL_INITIAL_STATE	(1 << 0)
 #define CEC_EVENT_FL_DROPPED_EVENTS	(1 << 1)
+#define CEC_EVENT_FL_STATE_EDID_PRESENT	(1 << 2)
 
 /**
  * struct cec_event_state_change - used when the CEC adapter changes state.
-- 
2.53.0

