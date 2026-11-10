Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84873606A9D0
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ciCJG/zS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B1F10E56A;
	Tue, 10 Nov 2026 04:22:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADAD10E1FA;
 Tue, 10 Nov 2026 04:22:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9ACF6370A;
 Tue, 10 Nov 2026 04:22:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794284544;
 b=YCINeEQs5fOyLn3cZTgliV2w8nEtO4WBgND8xGoRinvNRw48vep1Uk47ekofpowOrwny
 52y3yQW81FbQaikQ2O3S+eFIXaZ2u4bxqhdOKS43Dl/5xO2S6LqmAW2kmfXW6gQsustf+
 hy0EOl6a+lYzQpfdnVw0qcJ4zMPXQsdiZzoPe9cCWc7Zkn2Z2cCQ/JZBNiN+Bi5WP1V2N
 NWnpi/ZGiWX7Y4E+xZTc4ymuWc733+3cB9UA1t82X1qoCCPfAjLOfqOg1ZVtEFIg6QYK4
 LE9IwqgGum3UBZBqTY+Wgh1PClJoa9vk0L93ZejL+Otd1EHOFglrcC9bLKGGfyJrEtg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794284544;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=DgqZH68HFileY12mcpXRt1W/ZDEA7UTxqRY9j1XhLgM=;
 b=RHl8T/pjyJ1gKWdJJpSqm+LsMUTYJo/cqpZ2k1Y2DzJUfMNxZIS+smUwa/1dfrg+CPJR
 3Z2OSAea/A6Sy/ivnbSz+OMt5uaQ0SOIYA1Ad8ZV9ZtB1jSe9SIcx7LBoAkcmqpuc9nqp
 kY5qW5lVZirAZrEb79vS0DNXAD4B5gvYtsVwlT0ah8nXMAb4h3nutfcBw4akc60rZhJ+j
 MXc1xhMooETnXxuVdv5OvuOvP/7fNAWM8wcDF7lF4mHUVbnAaQ7GBCiOd7zkEkdNNEmLE
 WW11EVuwK0zFFPL7XAWvJEUB7/7Jj+7MfmP5NoegwSkbShOMnallcg0YZ1bzS8DzlJQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0ED091F008A3;
 Tue, 10 Nov 2026 04:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794284544;
 bh=DgqZH68HFileY12mcpXRt1W/ZDEA7UTxqRY9j1XhLgM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ciCJG/zSX9b2XJwai/o/oAfFnOllkeLHMaSOjff16g0o+dkPDRngS52huZ9yHJAF7
 WeyPqvmrBb/qTHJdDtt7YurgX5v+thZn4sHc284iTVqKBhIMsCFXgZLVVaa/CV1EVF
 FnKXUcgN2hLZsIc7yi2x4gO36JZgxyQCh/tVaJh3V1hYx3Iiosv6Ml9MI4LGTES7p9
 ZSpAZ6Yk40/NwvFJQzu38L4OD/oMp2ZJ+sy/xOZg6Z394eXLQm1oSNOrSYFaDKhAxs
 je047+rDotUg90KqrhlhVGvRpsn5a04Kxq+uvkubGjkuSuurNnfGm1tr5ImrFqjiOS
 J68yT1E+T8pBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7E29548843;
 Tue, 10 Nov 2026 04:22:23 +0000 (UTC)
From: =?utf-8?q?Eren_=C3=96zen_via_B4_Relay?=
 <devnull+erenozen.protonmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:21:57 +0300
Subject: [PATCH 2/3] drm/amd/display: Destroy FRL status polling workqueue
 in amdgpu_dm_fini()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-frl-polling-wq-teardown-v1-2-0ff028d5c35b@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794284542; l=2076;
 i=erenozen@protonmail.com; s=20261110; h=from:subject:message-id;
 bh=nSnFtyY4RWcYmXN82YzydEazOQbnaksZ2tg8UGonC7Y=;
 b=p7xud7+AnHh1+yaI6BBSJlf/a4bYAOe0Mq5UUG/cdz7J/gotbKLmFTjh1JmU3VsGLnkUK8vA1
 yIYVBdeOqnbDLT2P8jn50l7815mOZEWoW8gAAJnj4GWTvxn6Z+0Cf4w
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

amdgpu_dm_init() allocates hdmi_frl_status_polling_wq on every device
with at least one display link, but amdgpu_dm_fini() never destroys it,
unlike the other display manager workqueues. Every unbind or unload of
amdgpu leaks the workqueue and its rescuer thread, and each rebind adds
another one, visible as an extra kworker/R-hdmi_frl_status_polling_wq
thread.

The polling work also re-queues itself every 200ms while an HDMI FRL
stream is active and dereferences dm->dc under dm->dc_lock. Nothing on
the teardown path cancels it, so if it is still pending when
amdgpu_dm_fini() runs, it can run after dc_destroy() and
mutex_destroy(&dm->dc_lock).

Cancel the polling work and destroy its workqueue at the start of
amdgpu_dm_fini(), next to the vblank control workqueue. With the
previous patch, the work item is initialized before the workqueue is
allocated, so checking the workqueue pointer is enough to know that
both are valid, including on the amdgpu_dm_init() error path. This
patch depends on that ordering.

Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Eren Özen <erenozen@protonmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bf2f74d7d9..fed1893d2f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -889,6 +889,12 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.vblank_control_workqueue = NULL;
 	}
 
+	if (adev->dm.hdmi_frl_status_polling_wq) {
+		cancel_delayed_work_sync(&adev->dm.hdmi_frl_status_polling_work);
+		destroy_workqueue(adev->dm.hdmi_frl_status_polling_wq);
+		adev->dm.hdmi_frl_status_polling_wq = NULL;
+	}
+
 	if (adev->dm.idle_workqueue) {
 		if (adev->dm.idle_workqueue->running) {
 			adev->dm.idle_workqueue->enable = false;

-- 
2.56.0


