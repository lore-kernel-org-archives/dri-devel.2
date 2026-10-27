Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBAC606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wbinvd.org header.i=@wbinvd.org header.a=rsa-sha256 header.s=wbinvd header.b=aJSeNNoH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAA310F810;
	Tue, 27 Oct 2026 20:36:26 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DADBD10F810
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 20:36:19 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-35c76e9614aso438796eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wbinvd.org; s=wbinvd; t=1793133379; x=1793738179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n/kXFw9Qj82REiZi7BMptrUs1FkkIpA4DyKMU4QAqcI=;
 b=aJSeNNoHgPvHJeAgr1Yh2wXHu63xx9tUE8l5UCZFGTHncRa7Zy/hnVyJivfoxE0lzg
 bHSIJ1oe4XRPfeNcQgcMrhCRwjO9fA2M1TEa2ruaK6myZ4bAGh4Ag0eLRKVPSjc2kk4Q
 tpn+PgLwep6imW1nN0ca1PzvH2BL+fgjqHQUKKWhpAggi/qn+wzV2SF66biC221nA1CG
 c8iZVtUNAge6N+jX124aL4xmgzhnXwZahG//SXy7LohqXuM0FTDtij/sn/NbLCRFrfxv
 3iVb6mFRBcmLLM6NACApAh7dxLYjoCXMHRd2fESOqzIkHR2cFrDQIdp15zylE/T/0P2X
 Fk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793133379; x=1793738179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n/kXFw9Qj82REiZi7BMptrUs1FkkIpA4DyKMU4QAqcI=;
 b=JaT+3RNzU5T8aCucYxDhf0vGuOjWdI21CGebW2sw5MTZc/NIYL6FCoAIckRIP0YrkW
 z6zLKbeqyDybKWiU1uaV8KhwgYNaFgt6bz7i1jYOoYjz5e1BCoHYlgtkGidma/jvPRMT
 CsMb/4FK0UuSVwfwGbUvGP9po4dCdhQLuFa03HVhb/PhMQmwej+aSlDI26ekC7Zac5nR
 I5ZyobGys8HgjHqRiSa/jtJ9jiytL9YulL40TJjJp2oj/Xmo7p8nPReWu0U8+W4eR07R
 evXL1Cjx5LXs30VuT2RpaV6tT3z9lfvapUNpCc4DzXstH3yZVFJSsOgcnzA8mKoVjX9b
 j6Og==
X-Forwarded-Encrypted: i=1;
 AKwUvByOkIoFfdvYinY6ta8DdNO55s6UM/OWABjMcnIXSQ5VkiorNUfw2f8uTlJq8oEj49UcDQ2rXUuKxnc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLlNBPADgrXc57q6BGxowZ4zYi6XYTEFcISLiPI/4BBsn4dI78I
 U1BEse/7/pOJtrQnpMlmWcVstgO4TcDCH9ZiPdQbR/k6voxmcRDSIuQc6BMTzQzxdjI=
X-Gm-Gg: AYBFou3eEQz62GeXQl0oB1ghWuJx7CTGx+LQGT3dA7jc7dMGI+Fl/JMmHn2qdCn5jav
 8+PtgALiaZzl+EOsm3894DZqh0taA8KYN6BlLQ2JLHYPZWaTpHojrHIHhYTAmQK9s85crmkSZyr
 Gcwq2kjna6+wPuFU8b0jiP4G3J0EOx1OLmBSqavWAdgCp4bcb9EULikpeuwS+X2VF+AVTgNKUqN
 HDYgflmXXwfqP8TSAD9nlAQuJlNBZ7CfBsJmpDQxU+nUX7SL6Q7rzuoonkLr94fRNbs7948Tdwd
 piwrMgaYCN2fSYqJsxAZdvRJv5izJainjXq8SG9a5Jx0aGaLLV1I2ZeqoXDgJ1VWWxMhNEEp7H/
 igTMnyDVMAco9I5faOJKBuH95KjW4IfdQBQyzPngOjIDlfTGTJENJv+KDwHqZAGpoXyy7PLGYLM
 iCrmxOMC3t/jVkiU707NgqnqhEb7LW5wgYb0jHkOWF2IJFJceyn53hG74XzHzA6xUGhdKGf9mHW
 FeNnJpvKHTCO62DIQsq2343QlUWPC2U/Ds/wSWgit2PGQqbKWs3qWpMiD8=
X-Received: by 2002:a05:693c:41d4:10b0:369:f64e:7feb with SMTP id
 5a478bee46e88-36a202d5efcmr770087eec.2.1793133378769; 
 Tue, 27 Oct 2026 13:36:18 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:a9d7:ed20:8d1b:4227])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a14383b02sm9457218eec.14.2026.10.27.13.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 13:36:18 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, George Zhang <george.zhang@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] Revert "drm/amd/display: Allocate DCN32/1 dmub memory to GTT"
Date: Tue, 27 Oct 2026 13:35:26 -0700
Message-ID: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After commit a637a140ab860310 ("drm/amd/display: Allocate DCN32/1 dmub
memory to GTT"), a machine with a Radeon RX 7900 shows random garbage on
the screen. It reproduces sporadically, but at times it is so bad the
machine is more or less unusable.

The garbage is always horizontal bars extending across the entire
screen, always approximately 200 pixels tall on a 3840x2160 screen,
for what looks like a single frame. The bars are mostly black, but will
sometimes exhibit striping and periodic artifacts which smell like
non-framebuffer data is being rendered to the screen.

It took some patience on the "good" side, but I was able to nail it down
to commit a637a140ab860310818a14fb4d37e39e51a06be4 with this bisect:

  bad: [cee9395acd8043be0644b25c34bfa86623f2b935] Linux 7.3-rc1
  good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
  good: [55ab7e14222e5f0b0fd9f7711ca391d2924b35e3] Merge tag 'for-7.3/block-20260819' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
  bad: [df51bdc5e80dae43cab81f6cc641e98638303c88] Merge tag 'mtd/for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
  bad: [29daacacf4cd84e6917f09de6a99fb170071c14c] Merge tag 'drm-rust-next-2026-08-08' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-next
  good: [fff648aec5e2790d117a0ec5c849a284d9d33d70] drm/amdgpu: include amdgpu_video_codecs.h only where needed
  bad: [336e0cd576817ac64a4b394ca2b3680029f3e37f] Revert "drm/amdgpu: fix aperture mapping leak"
  bad: [789f7486a384ca58b9d7a76abba5efa0e80e8dab] drm/amd/display: Test plane colorop helper walkers
  good: [e0e426f10ad653c5e9dd33fb4a76d55f06101992] drm/amd/display: Test helper_check_state rejects
  bad: [982b2a43682b55e7d9800000f2592832ff2865ba] drm/amdgpu: Fix IP block NULL check during soft reset
  bad: [9102b39fa924dcc3dc75a3137bfa9633c40b88c0] drm/amdgpu/userq: fix indefinite fence wait during GPU reset
  bad: [b23470a026afe64de5c1df4ad181587b49c22923] drm/amd/display: Exit LS for ISHARP before coefficient write
  bad: [f02b2e47355e9d381a7f34acc997e1c47879ca21] drm/amd/display: Add KUnit test for wb jobs
  bad: [c6a13d145cc811b19c8a0620f25868cf7d5700c0] drm/amd/display: remove unused dcn42 socbb values
  good: [1d8327353de6f1f34063840f362c208c84064f54] drm/amd/display: Fix VABC Init and OLED Support
  bad: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Allocate DCN32/1 dmub memory to GTT
  first 'bad' commit: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Allocate DCN32/1 dmub memory to GTT

Sure enough, reverting a637a140ab860310818a14fb4d37e39e51a06be4 on top
of v7.3 completely and totally eliminates the problem for me.

Mikhail has separately reported this regression:

  https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/

...but it seems to be much more consistent for me than for Mikhail, it's
never taken more than 30 minutes even when the machine is completely
idle. I've also never been able to reproduce any artifact one single
time without commit a637a140, despite a lot of effort.

I'm not sure reverting this is the right way forward, since presumably
this would re-regress the timing issue Fangzhi alluded to in the
original commit. But nobody has proposed anything concrete yet... so
let's start the discussion here.

I'm happy to help test other better ideas as well :)

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 9ff25bc8ee5ae..870534b7cf46d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -511,7 +511,6 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		DMUB_WINDOW_MEMORY_TYPE_FB,		/* DMUB_WINDOW_CURSOR_OFFLOAD */
 	};
 	int r;
-	int mem_domain = AMDGPU_GEM_DOMAIN_GTT;
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(2, 1, 0):
@@ -648,19 +647,13 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	/* Limit to allocate dmub to GTT on DCN32/1
-	 * TODO: Other asics with GDDR7 may have worse latency
-	 */
-	if (dmub_asic != DMUB_ASIC_DCN32 &&
-	    dmub_asic != DMUB_ASIC_DCN321)
-		mem_domain |= AMDGPU_GEM_DOMAIN_VRAM;
-
 	/*
 	 * Allocate a framebuffer based on the total size of all the regions.
 	 * TODO: Move this into GART.
 	 */
 	r = amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
-				    mem_domain,
+				    AMDGPU_GEM_DOMAIN_VRAM |
+				    AMDGPU_GEM_DOMAIN_GTT,
 				    &adev->dm.dmub_bo,
 				    &adev->dm.dmub_bo_gpu_addr,
 				    &adev->dm.dmub_bo_cpu_addr);
-- 
2.47.3

