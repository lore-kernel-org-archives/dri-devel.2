Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1300BC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B0510EF3D;
	Wed, 23 Sep 2026 07:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sYJRKOs5";
	dkim-atps=neutral
Received: from mail-pj2-f17.google.com (mail-pj2-f17.google.com
 [74.125.227.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA1510EB3C
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:41:07 +0000 (UTC)
Received: by mail-pj2-f17.google.com with SMTP id
 d9443c01a7336-2db1ca06a25so26929655ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790066467; x=1790671267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5S8QifYjw9f9mPH34m2yhxskNbv7W3w5nVN3WfjvwaU=;
 b=sYJRKOs5jdqWAVDxSix/oQLeHwT2ID98ebZFzMfz5oQy5BlPSwiLyDliyaOWy8qrMT
 3oYzsCmwtO3CC2KDMWHZr7BZ4DPUhiglRgBY1EzTa7YtRUsnu4pu4vzwKvqDRgqmwYys
 W0pSyRKTS+ByAmhB2iDmPZAWgAvwS5LCh1Yn6OaKT1q0cTvJMwvR6xv/Dkult4UL26yi
 0VWCTLRCPi4n7aHJHSfdYYfPI1zfCVtb4yxgS/tG5iac1VaZ0mQotkZ7nvz5i5IkPJjz
 QTzF1cPkcH32Yu5mkYgEX2qNKXePJ7RbK7uLV9SE5JKfpdcymJMtsf5KguSOwkMitA9s
 CHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790066467; x=1790671267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5S8QifYjw9f9mPH34m2yhxskNbv7W3w5nVN3WfjvwaU=;
 b=x3ATMGoLPjGX6S/t3KUgXJgGs6/r6bEgePCwV4RWkGOldhAf//hRd/wMnSlbqgZ+km
 0JCO7FQThQj3g4DLS82dBYG1nzdp5f5rdOaY2/HnLFT+UNqO3b1CdGveyN5cQd13/+Ca
 /VDjoDS7CLnRrd5g8wiNS7Cmsq5gRkU+IBMYydNHJyH/d5V4b1ufsOlTr1AntiBPERaM
 G436AX3RPgYpDd9V/Qd7CbGWMSlOIpgggLlhUNxA7Pjbs06JgDkUqYQ9I57OLRh2Y3uq
 puQ6vmdxw0kWvRoOqb0U7fhBvbPxzEHHbP6BMd5EQmR7UoTdvA3LjioYa/4iJRNrv8LY
 j+5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7ZCHstYM5Cja+1ymXbCGn6y/rEEZcl5my7y/+cIawFAkuxJvkSYqSvg0mttRiLRMcXSQuuqxP2mA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kaif0LLFiq6piGCAatbif2unJZBYlLta1PbCJsoAqGAbkSgafd
 wHjzgXLnQauCqPB9rFCkDqhFHla+Bay3yjWCMyY9pmyqfZG8elzxa4Rh
X-Gm-Gg: AYBFou0czZw8KaU4ns8s2xl9qEAHPBk/ehPeEiHh88hel0csIHFBZ4qarVau0hUVo3e
 aLUwpm6b2fmTbM15SsXWzCbOMRW4zv9Lq8PbOyAGxkPFVauZLPpqE8pOram3FlyV8Sqen6wLCmv
 vKRzqZN/6ZMA1+YW3Q6KXzwS8QWeejgcTrnBmOmFYUIpJYetFG84q3zsp2IAucPM2CRWyyY+zR7
 iptngfLRRrD5CtRCpVYkye3Uc021UJVbvP+Vdeu8H5YGI86zmDpkV40041IuuYjIbJMkoT7IHTB
 IMWEOy8ADZkbxBTPLBqyxed/zqynHJUjTRp4EhtZdkuK8b3/2Muve0xBW1bnA+SHLQd75Ysdz1F
 PZiWFINzYaoln8KmFAGhDAL/J4QmnnfllVfdE/SLj3kDAORdUlUjFqAUE+LxbVIIEKpx4qypcHF
 3tQiw1sbaz9JUCK7zwrlRoxzxQbeHv3M7PsRoC6J8Y5vXz5iMRsqFOeKrIyfnnqGSa/F9Mbw==
X-Received: by 2002:a17:903:3846:b0:2dd:3ddf:b895 with SMTP id
 d9443c01a7336-2df609b1ca2mr4568265ad.3.1790066466503; 
 Tue, 22 Sep 2026 01:41:06 -0700 (PDT)
Received: from fedora ([111.223.30.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d0308f5sm6089835ad.43.2026.09.22.01.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:41:06 -0700 (PDT)
From: Sajal Gupta <sajal2005gupta@gmail.com>
To: rubenru09@aol.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, noralf@tronnes.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sajal Gupta <sajal2005gupta@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/gud: don't keep a connector without a CRTC as
 connector_state
Date: Tue, 22 Sep 2026 14:10:08 +0530
Message-ID: <20260922084026.15481-1-sajal2005gupta@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

If the 'for_each_new_connector_in_state()' loop finishes without
hitting the break, connector_state is left pointing at the last
connector visited, which has no CRTC, instead of
staying NULL.

That skips the "if (!connector_state)" fallback below the loop, which
looks up the active connector when the state contains none. The
function then carries on with a connector that is not driven.

Fix by resetting connector_state to NULL for each connector visited that
has no CRTC, so that it is NULL when none was found and the fallback runs.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260902123254.36987-1-sajal2005gupta@gmail.com?part=1
Signed-off-by: Sajal Gupta <sajal2005gupta@gmail.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index aa7792966287..5aa5ac2f3727 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -507,6 +507,7 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	for_each_new_connector_in_state(state, connector, connector_state, i) {
 		if (connector_state->crtc)
 			break;
+		connector_state = NULL;
 	}

 	/*
--
2.55.0

