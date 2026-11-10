Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B53606A9D0
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAwBvzOh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5C110E905;
	Tue, 10 Nov 2026 04:22:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F9F10E45A;
 Tue, 10 Nov 2026 04:22:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3B1263703;
 Tue, 10 Nov 2026 04:22:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794284545;
 b=SVsumiAxBr7CMW93I5R0hwja85kIgsZT/mbHxdEeLZvvRFMAATZuJxibjA1BVtHCAOEz
 4II1390e0rlSsmkKg86IJLKrBVLGhc6KIOU454VNVGO8nDQIiD162qnS6ZGbENVcnKShT
 xzkYnO1KemsHSXWhbcOu3F9C4mbNrrm5UVFSZaBwOqh7P2SzoX+cZkbMEhywssrjOFsBu
 hLpIVJfWAxfPyemeiEpJdnGxMy2FFEM6s6v4kWVJQX/hm1fmjIN49+espl3oVq8VcWMzm
 Rz9n7Nqf5jq4OPEC+hyd9qZUn4ydyGEEoYN7QRQkFSZxYZvFmnZ8tLvIrBozVXouzsg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794284545;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=jp0ZJsgUnuRxHl8bEw52yuvQWXxPTZTnQu+LDpLRt9c=;
 b=p3Tc0ZpcNC+5KDsQczhdw8vSyVMNVVjwf/YGArSsg+rW76WEkUKd3zC5J/PPytit5PSt
 uC/7Va5UAVR+d8CzfMO4O9ruZnfvAr1HcEuDCrzKBLfKOq0erEfAj8lw49zg10xpTOcx1
 tPcw8R6sGwAoPalIiaIjbhMCuWShNbNvKWryX0boCs5+4UxD9gstr3SbONB9g4MavvMqR
 9g5Ta+07UxSoFsJlG5zWi3SPmLWto7wltCLnAP/I1hlI0Zs5H5KgAhvqgbxk4EMwCKcNX
 tQ3hWThab/MjynYOKx9P5rWUS785vk0YGe9iLNcJufDhMTNKhl7egx4Az3wY4ycUlEA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0C82E1F008A2;
 Tue, 10 Nov 2026 04:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794284545;
 bh=jp0ZJsgUnuRxHl8bEw52yuvQWXxPTZTnQu+LDpLRt9c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=JAwBvzOhBdUj3MqbmPVM/hLA8nF0CetYlew087Eq1Znz9/SVceGdK8bVj7YzaqQpL
 y/iK0RlD8NM/4vFNMN338JDjgzjcc0WytIQDtkVqLb+OVCAr1vgowoEUjh85MRL1PO
 vOUp0anHMcfCxAaVcmdOaUIOB15I9hm7tYTXJDuyX0WoceaTHrix/mzedDoPlWCBUm
 2HWlEDP4Qzd0Ksy0ApjBHPL/NtoAalpKiHtr1kol69h75kBpMAXeEOc92lPjkApN5i
 VFEOfI3pKowQC1oJyQIgzIOhZPByd0emo5NYH2aTyXSRvBwIvNRUvOkH2iQY3uxZQY
 9IRXcaEKpyd5w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 6D8E84883D;
 Tue, 10 Nov 2026 04:22:23 +0000 (UTC)
From: =?utf-8?q?Eren_=C3=96zen_via_B4_Relay?=
 <devnull+erenozen.protonmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:21:56 +0300
Subject: [PATCH 1/3] drm/amd/display: Initialize FRL status polling work
 once at DM init
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-frl-polling-wq-teardown-v1-1-0ff028d5c35b@protonmail.com>
References: <20261110-frl-polling-wq-teardown-v1-0-0ff028d5c35b@protonmail.com>
In-Reply-To: <20261110-frl-polling-wq-teardown-v1-0-0ff028d5c35b@protonmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Eren_=C3=96zen?= <erenozen@protonmail.com>, 
 timur.kristof@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794284542; l=2549;
 i=erenozen@protonmail.com; s=20261110; h=from:subject:message-id;
 bh=4zCR7FWd/Rw2U/71QTZKamg0Naz8wle0ENFip0uSKOY=;
 b=WVNoWmMUWIbkrp0eWabJ8ElOrvblUBCy1lVLDi0tnKc1rpDNNaabvHBdCeJOEzD8zvPY+pgrj
 dJdF8fCvoJ9DGCJVKEb0C6RfMSTvFOYJ8cQ2rN5tkg2vjy3Wly9dzUj
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

hdmi_frl_status_polling_work is a single delayed work item shared by the
whole display manager, but it is initialized from
amdgpu_dm_connector_init_helper(), which runs once for every connector.
That helper is also called at runtime from dm_dp_add_mst_connector()
when a DisplayPort MST branch device is plugged in. If an HDMI FRL
stream is active at that moment, the polling work is queued and
re-arming itself every 200ms, and INIT_DELAYED_WORK() on it
reinitializes the timer and work entry of a pending item, which can
corrupt the timer and workqueue state.

The work item belongs to the display manager, not to a connector, so
initialize it, along with its polling delay, once in amdgpu_dm_init()
next to the workqueue it runs on.

Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Eren Özen <erenozen@protonmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 4 ++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 33c73ca9cf..bf2f74d7d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -774,6 +774,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 		dc_init_callbacks(adev->dm.dc, &init_params);
 	}
+
+	adev->dm.hdmi_frl_status_polling_delay_ms = 200;
+	INIT_DELAYED_WORK(&adev->dm.hdmi_frl_status_polling_work,
+			  hdmi_frl_status_polling_work);
 	if (adev->dm.dc->caps.max_links > 0) {
 		adev->dm.hdmi_frl_status_polling_wq =
 			create_singlethread_workqueue("hdmi_frl_status_polling_wq");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index e8f050feb6..b1bdb94d74 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3327,8 +3327,6 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		aconnector->hdmi_hpd_debounce_delay_ms = 0;
 	}
 
-	dm->hdmi_frl_status_polling_delay_ms = 200;
-	INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
 	/*
 	 * configure support HPD hot plug connector_>polled default value is 0
 	 * which means HPD hot plug not supported

-- 
2.56.0


