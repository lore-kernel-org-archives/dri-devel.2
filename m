Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B3606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wwPozzAU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C4E10E085;
	Mon, 23 Nov 2026 14:16:47 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E40810EDAD
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:22:35 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-38190551625so6695426eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 04:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795436555; x=1796041355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AX461gI0Jcb9WgcGuMUkXzkqs9S5oOCBlxxBvQFHCBk=;
 b=wwPozzAU1hfJGKueN04ou1m/cmbjSbPiey2MFuXTaXmiBYxYrDnZTLk/245AZomISZ
 VxKbmNUiXPxVIDHsXBjYsQu70zc5UchIkMlaelPkzmycW7OVxePRlLGpWe4CRyqypGVu
 RQ5B5nqDtrw8OJJ0Y4ps2OVF2wnRZfUQJRH7OGuPX6ZqZjoUq6jWoR9melM1hPxOQEwx
 WpUZdrdkgX6G++u0/jI02tPNBbr2625xWDCAJQluZZDD6FJ/vGw8wsC55eCMEYILhLa1
 AH0nOa9gjg8QJA6Z0AMbgFLPsTkc0X0Emor93f/GqDLAkIycjG4vv/4I1mn9qQRVAfJs
 DfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795436555; x=1796041355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AX461gI0Jcb9WgcGuMUkXzkqs9S5oOCBlxxBvQFHCBk=;
 b=fAmB30gRqSq1r7ciTzGZhGLfFEfmed3V5hX2YqMTyTwNj30bQGbIFqdaEYpFGjFHLk
 ct+zT4QnjA2ILFvBO/2Q0SYjPuSf1KJSNKIAT3UvGno2rd5HGB0OqamI1C93nCr0eHJZ
 JOcpdUhY8ZSXqMmNKIweTEduV3Ljk3nxH+4CT+K3TtoDFByFNeI+IxITdnhe10vSSvJy
 8jGD8AkfMHFdVLuokdUZnVx5EFtIVPA35rRyVBUHnVgf0h/H9dZ+V3tZINUo4n7KK45J
 b5PV/5fCMxbdAhTmQiQ4zE9pL8uIDpndkXJydtr4k/9NG8yrIAry8ZieT9WSFhoz1jS3
 /4cg==
X-Forwarded-Encrypted: i=1;
 AL+hErGaxrMHDNX7Xe10hMeWQyNVRb5a5BpU/V2y9z3gOHJa4CEUZTOgfiyEB6vjVIZiycbuxDi6kMQ5hIM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9SUjQRNds7jN9e7aYPBGa3/8djX79ZOEolPxHn0JSfau9OzGkR
 4tg1MqRKIUa1VHamQWiW0jenr99ntzn9ABGLMft6QXeT9GQltAWYCxAX
X-Gm-Gg: AZFdTZcmcKOljB6GOV/joY0C6YRC8qvU9enQP4UlX7dyKBLx6db23Hz+aUybc8aPFzO
 u/T2D9L2P+hSYwetXnrmZtlm2kqj5/9h6+KTo3VtYuL1u2Cl2jVpdqO38xEwCGtdEAFJfSW2LbN
 LSGKcWeggPYvDUWjTk6znkjFV0eu8wrT9upXfXB0Va9SfrrNkhnDE3rxnM7pXjiAI4WBw36QYTY
 lGYP0OGG9FIv+smSlx3XlktXMQMqT/WGyvnrQXJ8xK+FqU3P/9sWGwBTo3cCfAVDKe0G6hgfvtm
 8llQVOYSBQ9k8oFefIvprt1Ik6y+cRDoVWQd81K84cx28pTt/oJ996tvUWdXYXuiaMpFsm41qsV
 cB9csie8wOqHDtzx14Emf5aDpsllT0mMNsg9w2hmmMBGUGNkzvbaVJVKZBHbnF/upWlBlnDmPW9
 wjoY3BygSXWd7UhZGlNSjXdzR4PsA+VrHQKNptgatoHW8rfxAip0klI0erp+xG9diegSHtbFoFn
 THXWs8cM0PdePr0fZIvVIL0APjcqoVXa8oHS6q4ixwMWt03P2ZuziyEkSRe2WPozDzbClIqEoAq
 OIGDJ2gkNJeSy1pSTscB
X-Received: by 2002:a05:693c:42cb:b0:386:b621:d8ec with SMTP id
 5a478bee46e88-386b621dc16mr1579202eec.19.1795436554617; 
 Mon, 23 Nov 2026 04:22:34 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386992b404bsm25173398eec.1.2026.11.23.04.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:22:34 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, Weijie Yuan <wy@wyuan.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 2/2] drm/amd/display: Document max_gamut_remap_coeff
Date: Mon, 23 Nov 2026 12:22:26 +0000
Message-ID: <20261123122226.4101191-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123122226.4101191-1-takano32@gmail.com>
References: <20261123122226.4101191-1-takano32@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kernel-doc reports:

  dc.h:329 struct member 'max_gamut_remap_coeff' not described in
  'mpc_color_caps'

The 17 resource files that set dc->caps.color.mpc.gamut_remap to 1 also
set the member to dc_fixpt_from_fraction(S3D12_MAX, DIVIDER); the other
ten leave it at zero, and the comment of mpc_color_caps does not mention
it.  Describe it.

Fixes: 1c5e6cd8291f ("drm/amd/display: adjust floating point format for gamut remap when needed")
Link: https://lore.kernel.org/all/ec4d7cff-d23a-46d1-b245-921f442b9a7b@redhat.com/
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: the AI disclosure moved out of the commit message, as Weijie Yuan
suggested; no change to the diff.

Written with Hermes Agent, an LLM assistant; I reviewed it and ran kernel-doc
on the file before and after the change.

 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index debdd69bbe4e..32bf87fed40d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -314,6 +314,7 @@ struct lut3d_caps {
  * @mcm_3d_lut_caps: HW support cap for MCM LUT memory
  * @rmcm_3d_lut_caps: HW support cap for RMCM LUT memory
  * @preblend: whether color manager supports preblend with MPC
+ * @max_gamut_remap_coeff: largest gamut remap coefficient the MPC supports
  */
 struct mpc_color_caps {
 	uint16_t gamut_remap : 1;
-- 
2.53.0

