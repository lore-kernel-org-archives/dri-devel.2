Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D9606A8A5
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ey29Xf6J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84BD10F211;
	Mon, 16 Nov 2026 14:01:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104BF10F1F8;
 Mon, 16 Nov 2026 14:01:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C026840593;
 Mon, 16 Nov 2026 14:01:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794837665;
 b=cxt0vokZIJV4iLuPIHUR+VJ3CEdW8Ii5idcs0cf/4iBRIq36ydOl1kBwCU7gCJXPMRUA
 nMUGDz+SlQdvcjwSY+viQnyZFk9Nuru/YHkeHMHBJz1ATcdMwnUtkE9fYqtVcfpmPQQYH
 eWiGxfB5Z7U4Jvg4JEMhFkSRXl1t1V95UBjjlsPUpRc3a0zxKLRxIbJO8mw5VEGJCDUCq
 5YqmfWLH6SNGHi19mW//PctK9F1HjJ0pryIET0NfqiuuWpz++/twa3Z/ltw5PNdykhLPp
 ZKJ8wOfSA2H5DBIpy8kRp9xYnW0t4hSB+zkivNPdTr01oFAbgw6P6QVCeEcfi1Y9X3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794837665;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=TlcNcFV/e6ku1Q/CV6lyI3bgB/SHhlBbcUeMj52adDI=;
 b=1Pm//x55opp/ieEqJvvwfTjQ9Hs/5KQbRhvFMHDzPdF8XUb7GNV1KWMiNsafgdi50D0R
 SMpXHosxJi2if6q/eERla3G/hX5Hx0j4THqmNiPouK2a3A0fUuvmWME3dR37IqvDUiiV6
 aVG6bfLzEK/4MQRyrRk+46M2whRuOd95iN/oQdiRVR5QZ+DGdvJnk1ZTnLF/NAf9dSS9s
 +lntrXkVWiB5G0JaFHF66WQywNbvMRGn0XVvSvVUdOxJMCLivYMRGyTNuCU3RHbJhx9L5
 h58y9MGBiQveSjhPFcvYL9lhsUvLGq0W8iwEKrTNNdE3LWcPZKCffA3mR341sPGabIA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0B03C1F000C9;
 Mon, 16 Nov 2026 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794837665;
 bh=TlcNcFV/e6ku1Q/CV6lyI3bgB/SHhlBbcUeMj52adDI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Ey29Xf6JyFJfpHI71UBshi9RsQA901NIwWdnTM2fMzynsr1vQVWsEjsYP0tsf5eun
 iyP7OwLxs/d/SLygG8ElkXIeuLqNVZmowjo/0FpGROimtjdfBum8a+7K9015kcM8s3
 3LzLa732mmQjR5p44NyUUoFakzM2iy1v6HK2ibU+yHa63rgsuijTGqPeTvRCNtXJ7E
 OV0ahGjVm0S0hjpfQLYrLknlxj+PpZRrqqEAL8GaabXW3+jqOxpDeOZ2jnePRyn5NY
 zsnViM3tJIAXpJpgT1SWCmcW2IlMQX7s+jYUKzc/i0GMZHhD1amtsaZ0FYV2CDS53C
 tl7p7Tk7VnuXA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 847074A4AB;
 Mon, 16 Nov 2026 14:01:04 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Mon, 16 Nov 2026 14:01:03 +0000
Subject: [PATCH v3 1/6] drm/amd/display: Render the panel power savings
 kernel-doc
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-abm-sysfs-commit-v3-1-7a3d84a5328e@hsal.es>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=FVHKsTcB+kzVbQ+9zevb2MG6df7WbrsHz6OXzX6yqvM=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn7zzGdpqd6kKRUbEfRwLk8ZC0f8l2DxucdPWyQcL
 w3OtG69xNtRysIgxsUgK6bIonvDk4Fl4uSZOUXPl8DMYWUCGcLAxSkAE8lJZPgfkvfy3CKbJtZ3
 Dw0D5yWVVd+wNfn9997sl/vLWc45M98TZfif9GdGXfVTky+7z7+R/Ob15TTzVgXWg/E3JQ4FVAR
 d/tzKCQCkuUxx
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hugo Sales <hugo@hsal.es>

The DOC section for the panel_power_savings sysfs file is not included
in any rst file, so it never shows up in the built documentation. Add it
to the Display Properties section next to the 'adaptive backlight
modulation' property it interacts with

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 Documentation/gpu/amdgpu/display/display-manager.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst b/Documentation/gpu/amdgpu/display/display-manager.rst
index f6de9e7779e29..ca4a956d2aa17 100644
--- a/Documentation/gpu/amdgpu/display/display-manager.rst
+++ b/Documentation/gpu/amdgpu/display/display-manager.rst
@@ -187,3 +187,6 @@ Display Properties
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
    :doc: property for adaptive backlight modulation
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+   :doc: panel power savings

-- 
2.56.0


