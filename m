Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FCD606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRdQKmcg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430B910FBAF;
	Wed, 18 Nov 2026 12:11:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9A210FBA3;
 Wed, 18 Nov 2026 12:10:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D354141F32;
 Wed, 18 Nov 2026 12:10:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795003854;
 b=Ltf9D7wMX0GmXwGwQJzm0lEkvrsKveAm0PyHBtkb0lRsBlXwebodJ8qAUiVuSOj9i2Cv
 nIQ0r/tixnXLs4ntf29kSzgxTpovNOqNwsPZY9oyTQQdqX3G45le2hD624BEL9vEq2fGo
 nb/YD72kLEpRPel+J0Rm0iQA6dYpwGCK13PmEhuv0B+TgajJmUIQBbkPBNMyJP934G5Ki
 P1lekPUc8LZdPSWjau8bvg86vRu50mClMzvRZvHDfM1nczBmxDegWM8dXaCZjx7nk5sOW
 nPXsBD8PjPseFzYFnsAII28te+QMzBaaH9qMwdElqPPqfDfb8pSRbCRaQRGdBCqPtYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795003854;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=8n08Dx4tselChpRvrIzHYzudLYuM+5FoAE7kxqyU2XI=;
 b=Hlfc5NmyX/W9/LDQYWBa6gsmBcIGlpjaUg2xUq4+wPPSFgEP5t4+iDaJktIlZba0cs2U
 pKyUsZopCeJkyIQPL865pJowujDC6rpgqSCuDtRfAqg86J+80WKxgC0CjxHnKnj5DtRkM
 pbyJCsv+J4pxxQKOwB/YGRE2Bu1xW0VywaMVlhAnH6ML3cIHvA99HuL+9+0h45sDM7qph
 bLzKXMVCFYy7nRbEGYEjV4kiM6Q2XpilbxLNtHQ7ze39MoEdQ0+uP8DoEnmRovdx7KrI4
 tyy0iLQce8DGV0uFBEsi3PntWOaNYkxQL0/2EWMvdrLPMuFOvll65+zFjuXYNE8Yu1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 461FA1F000C5;
 Wed, 18 Nov 2026 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795003854;
 bh=8n08Dx4tselChpRvrIzHYzudLYuM+5FoAE7kxqyU2XI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=kRdQKmcgQOcLFYXqTvr6hDWWTeNc9mHxvfqaOf2wf1kwllkPIGy0ez16W7yTFZMfu
 UOpHPjQ8R8vegqMX9p1O8ieFSjBWc/RUtIvJwmhmfWDN2zJKtT3snCPxa2ggn+XbLy
 W+0onYCHSbr9n9yl2Dgea4xjUT3PDpaQAt5CRaXdJaswDjuPdcT7UEoAN0r8lRr3AW
 7t+yJSl61LPeCI9n/aCohSMAiaMmKIUB0Ov3eXwsJ6meNFdLet2UGbGgQAweV1FIvW
 vJoZhSgsxCGq+QxxeOFEMyFCTlbRmEIKWl1xd7BiYNV1gpAT5zVqDE4OPnYjGrhHIv
 wf2Z+BwcvzENA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D0B394AD5F;
 Wed, 18 Nov 2026 12:10:53 +0000 (UTC)
From: =?utf-8?q?Eren_=C3=96zen_via_B4_Relay?=
 <devnull+erenozen.protonmail.com@kernel.org>
Date: Wed, 18 Nov 2026 15:10:53 +0300
Subject: [PATCH v2 2/3] drm/amd/display: Don't queue FRL status polling on
 a NULL workqueue
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-frl-polling-wq-teardown-v2-2-957e61c0b698@protonmail.com>
References: <20261118-frl-polling-wq-teardown-v2-0-957e61c0b698@protonmail.com>
In-Reply-To: <20261118-frl-polling-wq-teardown-v2-0-957e61c0b698@protonmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, 
 Alex Hung <alex.hung@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Eren_=C3=96zen?= <erenozen@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795003852; l=1573;
 i=erenozen@protonmail.com; s=20261110; h=from:subject:message-id;
 bh=L6rmCXG8rWbzkEb2UeE14jkkgdwDWWDYe5UpCq0jUx8=;
 b=MHC0w+W4PsQGM/SRCe5A+mV5DkXSpx9/eRclAWzq890I57i8dhx0ONdq+MZhHmbj4sDBGVo+t
 ZaDyR51rlVCAsZDK4e4uoWlOQo2Joehbl2Wg1AE0BQanQ4xfepPqlxk
X-Developer-Key: i=erenozen@protonmail.com; a=ed25519;
 pk=tPAwfVmIbYF3QziJ3LcoTIZDU12BsjVK+EkAB9nN1gA=
X-Endpoint-Received: by B4 Relay for erenozen@protonmail.com/20261110 with
 auth_id=1479
X-Original-From: =?utf-8?q?Eren_=C3=96zen?= <erenozen@protonmail.com>
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
Reply-To: erenozen@protonmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eren Özen <erenozen@protonmail.com>

If create_singlethread_workqueue() fails in amdgpu_dm_init(), the
driver only logs an error and continues with
hdmi_frl_status_polling_wq set to NULL. The next atomic commit whose
state contains an HDMI FRL stream then passes that NULL pointer to
queue_delayed_work(). When the 200ms timer fires,
delayed_work_timer_fn() dereferences it in __queue_work() and the
kernel oopses in softirq context.

Skip the polling when the workqueue is missing, the same way
amdgpu_dm_crtc_set_vblank() only queues vblank control work when
vblank_control_workqueue exists. FRL link status is then not polled,
but the display keeps working.

Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Eren Özen <erenozen@protonmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index af7acfbbf9e0..201aba79e43b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4891,7 +4891,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 		}
 	}
 
-	if (frl_stream_found) {
+	if (frl_stream_found && dm->hdmi_frl_status_polling_wq) {
 		if (queue_delayed_work(dm->hdmi_frl_status_polling_wq,
 				       &dm->hdmi_frl_status_polling_work,
 				       msecs_to_jiffies(dm->hdmi_frl_status_polling_delay_ms)))

-- 
2.56.0


