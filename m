Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D6606A325
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQebQVXJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D223610E71D;
	Wed, 28 Oct 2026 22:54:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17BB10E71D;
 Wed, 28 Oct 2026 22:54:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0C296021E;
 Wed, 28 Oct 2026 22:54:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793228058;
 b=YC4ocxpXM0ok2A956+OW3sHELt6EyKgyr67lXK6UxLf5KjrMDCKlb5f8jF3BVsa0o8BK
 uT1BlGNsi987zKFSZGbG69Q8/EfJC7PeuvGPDvPXfItzFAIeW72wV4DVGRWJJMzrX8myA
 9GSv5H3YGYMZTZIsZOfhcEYGMstMn3rJRmGptjcBRi6vTV4jljcU25/zpyW3KLmkDRk62
 Ng1lW+oZpP9D0Qcy3Hxg70XEjgLLKIzW0mnChiXZp8pYvpKQYGxfrbtESePXpEbfAPRBq
 H9YFPJsuGP1jf5jXiLjwWgzS76fK1KJWMJFbvDW9cwJJzNMbY4BG7P5o5B6mnCAXblQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793228058;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=/ZALVaMldwQ0X/K5RLZjuplS/iUb0KWyBVqHtiMBqmI=;
 b=ajIXd7KbV2P9fe2sLPNLKxtCzOc2i730scAZI4/rVz2+eEce1NYc2HOepmpqvSjoaFBb
 l8GJKtU5RG1/RTKggg3AziKi6HC0pab1sMcQknkuumnW+Gci1R9jRj9R9IfDiiS1laVAD
 7Id4HoQjaO4YQEmq6B+/NlZ+Ff0aeSLX7m3Q6yn2RV7s5pof4sGGuNo+Ifm3KUdFnIrAQ
 yFPopJzhZ8ocxBiuVWEzI/0JnIH84kZRcrpY5J7Y+8gX4Cc1wxRIv5xyhW8Joj9UfFhEM
 6GYfUgwoB6V+bNsiC6KvBAC9HbsoaFCRiuWe9ycy6XIhHitn7815s7p+Nb4xTUpILnA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1C2661F031EB;
 Wed, 28 Oct 2026 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793228058;
 bh=/ZALVaMldwQ0X/K5RLZjuplS/iUb0KWyBVqHtiMBqmI=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=aQebQVXJ75y4EOlzzhXQ+JAHn3//z1zw685NW0+YfmwTQ+soum1EVSCXDofTMTews
 DV7kGsBuLYXwU7ao7DQqJU74qo9ewx0zAyBC673oHPXlRHfU2fVkfPL5LVaP72GFzZ
 aW/dAukwh26N4xqdPTza6/jmWYNrFIpQ7VtbUlwRE87JVgf0sOxGKBLj3sbo3pgfgs
 QHq2QQFyrMC277DMMqPW6xldi8cHLRzw0qShK5lCXcafPAGB4TUyQEiZ05xgDSWydb
 0mzKn/mIFUEjgc2MxqOHWzeG19E3AKAmGA4epE9nmi77/B0iXYcTYdkFAziyt6Mca4
 bmmL7baPjIHYg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A4BDB455FC;
 Wed, 28 Oct 2026 22:54:15 +0000 (UTC)
From: Davey Hughes via B4 Relay <devnull+davidralphhughes.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] drm/amd/display: Keep FreeSync flip timing across
 plane resets
Date: Wed, 28 Oct 2026 15:54:11 -0700
Message-Id: <20261028-freesync-plane-reset-time-v2-0-545a0f9b17df@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQrCMBSEryJZ+6StVsGV9xAX+Zm0T0wqebG0S
 O9uoxdw+Q0zH/NWgsQQdd68VcLIwkNcodlulO117EDsVlZN1RzrqjmRT4DM0dLzoSMoQZApcwC
 1zhzbE2C8g1r3zwTP09d9vf1YXuYOm4uwNIwWkEk62r5EOjiSrDuOHbkUKGLKpdaz5CHN349jX
 XT/3BlrqsiYw960Ve21P1y6oPmxs0NQt2VZPt9+2WX7AAAA
X-Change-ID: 20261027-freesync-plane-reset-time-5db657eebfde
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Davey Hughes <davidralphhughes@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793228055; l=2607;
 i=davidralphhughes@gmail.com; s=20261027; h=from:subject:message-id;
 bh=uB3zeg6snFrSpyNToh+cKiC4OgQ+D5vVvwK0Qxj7Jc4=;
 b=Hp94BmA/h9H3IVvCisahJrlrYCrKHzdJdDkP7r5umAgla/kMsClkNNArhtAolupdBKBDB2RLg
 eXAtm6Bvnd7DWltsqQImRYeV/HqKtvQleG0Am68OK2VLMLRunTOgkKD
X-Developer-Key: i=davidralphhughes@gmail.com; a=ed25519;
 pk=y45yWVxpjjxFE2cXy96fGlXLfDlt6UKHFHS5szhrFAs=
X-Endpoint-Received: by B4 Relay for davidralphhughes@gmail.com/20261027
 with auth_id=1335
X-Original-From: Davey Hughes <davidralphhughes@gmail.com>
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
Reply-To: davidralphhughes@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a 48-165 Hz FreeSync panel, fullscreen clients under KWin with HDR
enabled and color accuracy set to "Prefer efficiency" run at about 51
fps instead of 60, with flips locked to the 13.45 ms BTR mid-point
grid. That grid drifts upward at the rate expected if FreeSync takes
the 32-bit microsecond timestamp itself as the last render time (3.46
us/s measured, 3.45 predicted).

KWin replaces the CRTC GAMMA_LUT blob on every commit in that mode, so
every flip resets the plane and the new DC plane starts with zeroed
flip timing. Patch 1 carries the timing over from the old DC plane, as
DM already does for flip_addr
(amdgpu_dm_plane_drm_plane_duplicate_state()) and for the BTR state
itself (dm_irq_params.vrr_params). Patch 2 adds KUnit tests, kept
separate so patch 1 backports to stable trees without the KUnit
infrastructure.

Tested with KUnit (UML, all AMD display suites pass; the new timing
tests fail without the fix) and on 7.2.11 with a Navi 31, an AW3423DWF
over DP, KWin 6.8.1 and Mesa 26.2.5: 60 fps content now flips at a
steady 16.65 ms instead of on the 13.45 ms grid, 30 fps content still
gets BTR (30 fps, no 13.45 ms grid), and debugfs shows
color_mgmt_changed=1 on the CRTC in every sampled commit. Not tested:
DCE, overlay planes, other compositors.

I am not sure of the current AI disclosure policy, but I will freely
mention that I used Claude Opus 5.5 to help debug and write this patch +
tests. I have tried to do my best to match existing style/procedures.

---
Changes in v2:
- Copy the flip timing in amdgpu_dm_commit_planes() instead of in
  atomic check, so it can't race with the previous commit still writing
  it (reported by Sashiko AI review)
- Skip the copy when the plane keeps its DC plane
- Add dm_plane_inherit_flip_time() in patch 1; patch 2 only exposes it
  to KUnit
- Check the whole flip timing struct in the KUnit tests
- Link to v1: https://patch.msgid.link/20261027-freesync-plane-reset-time-v1-0-bb43b501faf4@gmail.com

---
Davey Hughes (2):
      drm/amd/display: Keep FreeSync flip timing across plane resets
      drm/amd/display: Test FreeSync flip timing across plane resets

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  23 +++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   3 +
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   | 188 +++++++++++++++++++++
 3 files changed, 214 insertions(+)
---
base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
change-id: 20261027-freesync-plane-reset-time-5db657eebfde

Best regards,
--  
Davey Hughes <davidralphhughes@gmail.com>


