Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SeM/e3zk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F54F10E78B;
	Mon, 23 Nov 2026 14:16:41 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA79410EDA3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:22:30 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-38699cf08dfso2947313eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 04:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795436550; x=1796041350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fHN89iqHMglA6tA6YLX3To+FpptgLkpu1uDNq5dshLU=;
 b=SeM/e3zk2tN/ixTNyBt/TwMePH9Xeth8Y2T52yYDBv33VE5fcY573wa4vbvUPbofv1
 KMdi9FvbfKz/O1sL8XYKNdOSq72bPyavDxDE8YiY2V4URTr7ckla0/w7Ecad8+x+4X8z
 Og931/CkkH3pEdauoNOPlo7qL4HNgExXipxPjBlrQfexZn+4JQlZuTq7J5dkc9Yfjk/q
 HQTQDdR5UP35WZ0THh1SkcFE+biNXsvExhkGFenlT2+bcr2lopfiWtiYmff0cdyqdJMR
 1fri3garxr3ir5NyHqGs95sc3suE6Xx0G4yavBG7sSu4i8RLqyzTT0WLcg5T36/EQbPD
 MZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795436550; x=1796041350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fHN89iqHMglA6tA6YLX3To+FpptgLkpu1uDNq5dshLU=;
 b=Yj1PjtVigdstUhQs2ieFt8Xw5TsYFuTfpJcHV79SY5mw15LDuvzf6iKnGUXbcJtZVL
 X2EG7nXye0rfANqUgWBvtRhhMj0UufCNUbeRbuWTIMYQoa/xOWVifkTq76cO5Z6NH+U4
 Y2p+lJX4ng6FnQW0oPw3aC61UF8PbQRtbc9ZaJqa+gV/yIyx5d3Am5OjxaUSmAaOo2B/
 cDGRJeiRroWj5S0WbA3VyTyLPdS6YeX3Wrksu1XP06YuQua97wrRng5wwkXMxRX4j3Oc
 esEKPrGssvtVwjEOP4f55DLup/LhsZ5ChAt1DpIl18uTHkIOUb85vK267dIqPp/3IAB/
 peyA==
X-Forwarded-Encrypted: i=1;
 AL+hErFBLQeztT+OkQ+7dIMKyME+Lf4Y7V6L2BL+So7o5XO7DSulMms2S0R+u//E0s/fmuCB3cJfiwk3kec=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8shHhIsRyeGx5BwCbM30nX+7yJ1V4c7F33ABKX/mBuW6oQfcwe
 Z0Qg5W2T5HFGmwWHt1JN57wkgCkawbcnJkeSZriec+6+8/4aowkBJZrv
X-Gm-Gg: AZFdTZeGFckIiaZ43IzSDuEhteoKsfLVhWOIG08PczGw0TfvoEdip8FOeqYJG4EL1FS
 QGoFvT6rgue2Nx2RaVv9/i2JI3NPGp6ucmbfmg0kks1qTiZsO9MOG1AP5LNM8osAKsdGDzeE5ju
 OSI9o+kocBjSoh6g8FafxyGSjNO35jFPYOKVc707DRr8tPT6nl4nh9zL2EpAw4JZRU4gPLtn7+P
 om1DxNpPCd8zqYEu6PFz8CcJUreQPfld21CQsyhlOpOVqAUxvjVCy9C7IzXHd20k+d2h49MfQPm
 lUGz3K2MTWQRwzo6aisyX2nV84ZV03KyejJHV6h3XPob4TciDFCqCnXhomjekiHNaKwRevXbXV8
 MvVlOuBJFImfqahH0edyanw/sd8ylYfXQtRWQzQHS4vYzJWnrb3JJd22DZLQ2i5nRbVQiOcZfxR
 Y04noTjCd8wJc6pyh5BDTTotT0juWGxNH5o/C/SH3wCvLUedPVrwHTeuh17OmsoI0Mc5y9VTT+c
 a/Izvl/Z6ZRjodF1YQpXaD5qAx7kWY406ae64dCGBLzyx+xYZtoJPHCGXf/tZYcgfHmO6hvgaOU
 xEvXd0C0UYI2Yr0/tU/V
X-Received: by 2002:a05:7300:8807:b0:369:5583:bf4c with SMTP id
 5a478bee46e88-3856ff5bb62mr12060416eec.28.1795436549928; 
 Mon, 23 Nov 2026 04:22:29 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386992b404bsm25173398eec.1.2026.11.23.04.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:22:29 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, Weijie Yuan <wy@wyuan.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 0/2] drm/amd/display: document two members of dc.h
Date: Mon, 23 Nov 2026 12:22:24 +0000
Message-ID: <20261123122226.4101191-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two undocumented members in dc.h, both reported by kernel-doc: the union in
dc_probe_status has no description of its own, and the comment of
mpc_color_caps does not mention max_gamut_remap_coeff.  Both patches only
add comment text, so no build was run.

The diff is unchanged from the previous posting.  As Weijie Yuan suggested,
the AI disclosure moved out of the commit message: it is now below the ---
in each patch, and it is also in this cover letter.

v1:
https://lore.kernel.org/all/20261121041427.1743954-1-takano32@gmail.com/

The changes and the changelog text were produced with an AI coding
assistant (Hermes Agent, model deepseek-v4.1-flash) working from the tree
and the git history.  I reviewed the diff and ran kernel-doc on dc.h before
and after the change.

TAKANO Mitsuhiro (2):
  drm/amd/display: Document the union in dc_probe_status
  drm/amd/display: Document max_gamut_remap_coeff

 drivers/gpu/drm/amd/display/dc/dc.h | 2 ++
 1 file changed, 2 insertions(+)


base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
-- 
2.53.0

