Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01122606A337
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBVUxWN3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C89A10E1A2;
	Tue,  3 Nov 2026 19:28:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE0A10E5F9;
 Tue,  3 Nov 2026 19:28:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F3A4641F9A;
 Tue,  3 Nov 2026 19:28:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793734093;
 b=Gb2oamLBYfrlM8NqY55IEAFDveCQOVqFg8qurwJnrATudyqxZCINtIMKjYA8ZzGGOJAJ
 A1XuzXHdPx0tKWC8A3P0VNy4f+gVEG+UKZ5ehQk05uTZPm3SQoqvwh3lCr7Rb13Bq4cyq
 qEA0Fvxq+qv0J34bEUCL4Vk3XQDScZe2O8WrpttK2YVuyQAzjjCy5BdR6ycDR8u7mFhX5
 /JJ9i2LfWaAl+6vEmvFDQo8ubnfdStJAj4xmT8Jpt/Upxfd/ufXPX08KQ7FRafuWkCg0X
 UlLP5g3kyTVt9ycXioZFTqkIjcj+iULHwsPdoT7YhR3D7EeqVA7918rZe8jc1LRmT1w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793734093;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=+K7XmP528TsFnUG/JVxK/UW4I1FIZw6fbeiM5ne0aYo=;
 b=Ma+5m8AWHtc1Au7ATR6uYQxy+jdyKWvz647W3WI3XhhT/D5iXzqKPnsgkV5+LMQXq6qM
 WjuSdIPtlcivTzRPttShtWLI0b2gmJvlVP8NsVnynbHc+XGfkBJnImqawigi/2IwLb1DI
 FS4gjYh/Zt4iVbHxHi9Dyc2r4YoTE/qmtnR/5jSo8F9bXe+47vqiA1JCCC5M4KfwUVLVP
 Ix0tqNsI4JH/3sLElH7cHI5bDJ+Jp9rpUKr6H+BIcTVTwJ2GMGJNRWNFTKuCTt11kvaLt
 8BfC434w57fFpbVksoxTsnV5GxEnGIfaNNT7EP5QOiwy5x8ikOxUSAVYhiri3a+VT/Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5999B1F00919;
 Tue,  3 Nov 2026 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793734093;
 bh=+K7XmP528TsFnUG/JVxK/UW4I1FIZw6fbeiM5ne0aYo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=fBVUxWN3U7v0AxMCKv9afY3n4/scG0NCPWU5UmJrxNCJoNqGpHKxVriydzlpcMAVc
 ge2SI4vzZdkiot1cQIxC/yTt10NWexjKVsKp+DilevXCSy2/AloF3hqbL2SWYSBULn
 NMBclLvcpOwD8NYGa6ARrALjcj2vNnnQH6JTMI7/SmKcdAb59wmBIeVGSK/HPCx+Q+
 p2DrgC8Ut0cnd5vRW/Z3j0T0ON4i8k/lYZU8SJdMnHHIcy2sSjQL4G7DMFmParjbpP
 6bCxbtTBLNUrBUpfrxUXIycWEWUDhjDScdSC/BwBb4t+jvbobQat2czWhWkvzJa9Fi
 6fZyDWhmypVCg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D4B5F46AC3;
 Tue,  3 Nov 2026 19:28:12 +0000 (UTC)
From: "David R. Hedges via B4 Relay"
 <devnull+linuxdev844.thelittleman.net@kernel.org>
Date: Tue, 03 Nov 2026 13:28:01 -0600
Subject: [PATCH 1/5] drm/nouveau/gsp: fail control calls whose reply went
 missing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nouveau-dp-fixes-v1-1-892f4bd357cd@thelittleman.net>
References: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
In-Reply-To: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 "David R. Hedges" <linuxdev844@thelittleman.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793734092; l=1563;
 i=linuxdev844@thelittleman.net; s=20261103; h=from:subject:message-id;
 bh=hRrbjbCV1yWJ+Tf4TceO0O/RoGm+JN9bs3miAwLKNC0=;
 b=6s12OYfwt2UO14gX7497JNyOhA9zhT4/8AHID6LT0VcGuyiRRNzPWfVfvBvnfpxe4/vknFRFo
 z48TbizjuXvCS3Cgmaa503BHH9hYz5crRbWHqwooqyH4QUz/6Bmj1ws
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

r535_gsp_rpc_rm_ctrl_push() sets *params to NULL and returns
PTR_ERR(rpc) when nvkm_gsp_rpc_push() returns an error or NULL.  NULL
is the normal result when no reply was asked for (repc == 0), but
r535_gsp_msgq_recv() also returns NULL, after a WARN, when the message
at the head of the queue claims to be longer than a message can be.
PTR_ERR(NULL) is 0, so the caller sees success with a NULL reply:
nvkm_gsp_rm_ctrl_rd() hands the NULL back as if it were valid, and
r535_dp_aux_xfer() and r535_dp_train_target() go on to read their
reply fields.

Return -EIO when a reply was expected and none came back.

Fixes: 4ae3a20102b2 ("nouveau/gsp: don't free ctrl messages on errors")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: David R. Hedges <linuxdev844@thelittleman.net>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c
index 70b9ee911c5e..ea925a9d0531 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c
@@ -44,6 +44,9 @@ r535_gsp_rpc_rm_ctrl_push(struct nvkm_gsp_object *object, void **params, u32 rep
 	rpc = nvkm_gsp_rpc_push(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV, repc);
 	if (IS_ERR_OR_NULL(rpc)) {
 		*params = NULL;
+		/* NULL is only a successful reply if none was asked for. */
+		if (!rpc && repc)
+			return -EIO;
 		return PTR_ERR(rpc);
 	}
 

-- 
2.55.0


