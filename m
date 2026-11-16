Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250B606A8A5
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUzfT6kR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3059D10F20A;
	Mon, 16 Nov 2026 14:01:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B313910F205;
 Mon, 16 Nov 2026 14:01:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DDC146501;
 Mon, 16 Nov 2026 14:01:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794837668;
 b=hdlrar287MS4t4r1LjKTeL8McvZ/Fp5lS+J0JN7GhpCUwvyQZqOwMUGE3O/6akwwb3fj
 YyK+6yf0gIxIOJ2Ld464nWyvv8sF4SZy0RMYoUOYiyaohQqlBn6ahRTsB8oj4pEijM0v4
 74DvRH3GdqyJzUbnve4I69X+DZvDwUiYczWWjNc4NElHTkqwQd3utgXJJlSH2a+AxUAc8
 dRU9VJoLVUbcZAOvByI6Y/iPZIL5BYK3P6qMIH4HExi3d4I+nWk1975DGAGudLbjZq9d8
 GdcypXKrkhXBmyK/TckHOuBgo9t7XeKAeAMlFRkqoEb7dTpy1UjlGveEUMDAPRV4nPQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794837668;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=8UBujBnVXI6o6jlvZslDznmNtQX3JL0l1TsE7k+wIo0=;
 b=nfqdxIoC01tWx+hFqfMiemh/d7nDQI0T2FpF2fCgYLQ0lNi5d3J7o1sB3c/cOXVz2S4l
 xsF8FHwiyjjFGfmSxJ34LyNSS0HZzdVqpsv3/OUDFk/gNWG0LdR7ZL6vHlTEqWpW2ShnK
 gULcPbysC8LUIpflCu/eDucnjNLns+GYKUdgqc3X7/qPCHLe6sKp4aOdz6y64lMyG8XHr
 pIS/qkGipxdmKDcCYgIGIjJ1PMReT8vCCc9G8nv3jdrWzNumeA/+LRbZlF1P/l1zgcQwS
 HC3E3jk+xljaL9DZ65FsngMmzUQJ8X21W4BTLQ/sMKMjbuv2F4euKvSh+y174KuGgeg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 374301F000CF;
 Mon, 16 Nov 2026 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794837668;
 bh=8UBujBnVXI6o6jlvZslDznmNtQX3JL0l1TsE7k+wIo0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=EUzfT6kR02RIeKFHnBRuMsFGjHCeZO8F8k9UFj6zva+EMj0X+hFYYk1ELd8RSo/WF
 hwaVL+3xIZYAaBYRj3TSSSudY3QRLNeWfOp/DpoQVLhWMBL0YQQIhyabAEoeha+wcK
 2k4OctnQxqGa8TgTMSpDKcGu+PI8LUX9Dit6M4frYjd6yCdMMyuVoPuiIWny9o4eI3
 9R+k9Y9LjMmaNAQb5IKpcGv9fpW+OvYPojidiy10a3xC2dTXDsLVupaXdBzgh3pVrh
 IfaJ/7D5Iww6xB+a7zBjVYKaejIG1R5jWOI3/pu6/eEe4x8IzDPDptTplRLiWn2YFv
 TZlvxbEH9WDKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B26A04A4B8;
 Mon, 16 Nov 2026 14:01:04 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Mon, 16 Nov 2026 14:01:05 +0000
Subject: [PATCH v3 3/6] drm/amd/display: Don't force a modeset when the ABM
 level changes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-abm-sysfs-commit-v3-3-7a3d84a5328e@hsal.es>
References: <20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es>
In-Reply-To: <20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Alex Hung <alex.hung@amd.com>, 
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 David Weber <weber.aulendorf@gmail.com>, 
 Shivam Kalra <shivamkalra98@zohomail.in>, 
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4516; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=nTN2YLHV+ve8v1xZQdklVKDNGY+K7ZshEneUQgf4siY=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn7zzPdo0k5N1XwUv1ok9yFv37XpfzImXd/yWvvE6
 rd5U08zeE7pKGVhEONikBVTZNG94cnAMnHyzJyi50tg5rAygQxh4OIUgIncT2b4X3Sl2bP4oEDa
 jpybF+3aX300OWbos2zFbv0Eh+rLE+YvFmNk+KTUP3m3z/yimNP39GKXqei8DiidcGWKz0Xn/KP
 vdab4sAEAYsZNtg==
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Endpoint-Received: by B4 Relay for hugo@hsal.es/default with auth_id=1417
X-Original-From: Hugo Sales <hugo@hsal.es>
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
Reply-To: hugo@hsal.es
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hugo Sales <hugo@hsal.es>

An upcoming patch commits panel_power_savings writes from the kernel
without a modeset. amdgpu_dm_atomic_check() sets connectors_changed on the
CRTC when the connector's ABM level changes, so that commit would fail
with -EINVAL

The flag came in with commit c5892a102182 ("drm/amd/display: Fix dmesg
warning from setting abm level"), which also added the CRTC to the commit.
Setting the level alone left the CRTC out, so no stream update reached DC.
Adding the CRTC is enough for that. Since commit b05e2c5e81f9
("drm/amd/display: Update ABM crtc state on non-modeset"),
dm_update_crtc_state() copies the level from the connector to the CRTC
state on the non-modeset path, and the commit tail sends a changed level
as stream_update.abm_level. Sending the level doesn't need the planes in
the commit. The commit tail walks the connectors and takes the surfaces
from the stream status in DC

The modeset also put every plane on the CRTC in the commit, which kept DC
from dropping an overlay when VRR is active. "drm/amd/display: Add the
CRTC's planes when the ABM level changes" keeps them there

This applies to every commit that changes the level. A compositor that
sets the "adaptive backlight modulation" KMS property no longer gets a
modeset either

The forced modeset also took the panel out of PSR or Panel Replay before
the level reached DC. The non-modeset path relies on "drm/amd/display:
Leave self-refresh before an ABM level update" for that, so it has to be
applied first

Keep the flag for scaling changes, which move the stream's source and
destination rectangles

David Weber <weber.aulendorf@gmail.com> sent the same change to the
condition in August

Link: https://lore.kernel.org/amd-gfx/20260813112634.11455-3-weber.aulendorf@gmail.com/
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
This needs "drm/amd/display: Leave self-refresh before an ABM level
update" [1] applied first. Without it, a level change on the
non-modeset path reaches DC while PSR or Panel Replay is active

[1] https://lore.kernel.org/r/20261113-amdgpu-psr-abm-update-next-v2-0-27ce790856ea@hsal.es

Upstream, a level already reaches DC this way when a compositor commits
the connector after a panel_power_savings write. The store has already
written the level into the current connector state, so the old and new
connector states match and atomic check doesn't ask for a modeset. Only
the CRTC state, which still holds the old level, sees the change. With
this series, the hardware tests in the cover letter apply every level this
way

When a commit changes the level and also has planes on that CRTC, for
example a compositor that sets the property and flips in the same
commit, upstream sends the level to DC twice: from the connector loop in
the commit tail and from amdgpu_dm_commit_planes(). The same already
happens upstream after a panel_power_savings write, when the
compositor's next commit has both the connector and planes. [1] sends it
from the connector loop only

If a level change through the KMS property should still force a modeset,
the store could flag its own commits instead. It would set a flag in
dm_connector_state that atomic check reads to skip connectors_changed.
duplicate_state wouldn't copy the flag, so it only lasts for that one
commit. I think it's simpler to treat the change the same way whoever made
it, but I can send that version

Scaling has been in the same check since commit 3c6d1aeb4342
("drm/amd/display: Fix set scaling doesn's work"). From my reading the
non-modeset path handles it too, as a src/dst stream update, but it
changes the scaler ratio and I can't tell whether DC needs the full
validation for that. Could it go as well?
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cf75450066451..caef3857eec18 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6304,8 +6304,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		}
 
-		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level ||
-		    dm_old_con_state->scaling != dm_new_con_state->scaling)
+		if (dm_old_con_state->scaling != dm_new_con_state->scaling)
 			new_crtc_state->connectors_changed = true;
 
 		/*

-- 
2.56.0


