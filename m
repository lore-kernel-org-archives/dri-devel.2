Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B5606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQucDsST
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC9010E7A8;
	Tue, 24 Nov 2026 20:58:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9643210E7A8;
 Tue, 24 Nov 2026 20:58:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16F9A4358E;
 Tue, 24 Nov 2026 20:58:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795553930;
 b=X+9eV0evgExdJYRiuFSXjIJi6i8T2Xkbli1VpEwJ/zCudG77elDD1Ao6jX1H0YmEtv3o
 OFANXstXYuyxODDHPrbSKHpe5lckfM6EqlntJ3YXEKZ16rkMeEvqun8JUU28Gi/w7UVBD
 f0+tVnKTDeZaA2pMj675TLGB3jvXwWHvKC1/1hrxHB8wGaWOxkYiSBFCrAas0pb3e+fmi
 t1YCzzGUIizgSd7hsLX8igRouKC3U5a7TBTCVwzyRFPiQAOVcTMFnhCEFDDq27KNrFwzH
 /nU0ROtFTqfGL+7rLv3a8sIGzlahOo0bcUVypT8rrRYJuHiuMQ+Fbt/xejTOjOL195A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795553930;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=RUxIdsT2a3GEPLS3xlx8PCm2RFieqaaoaw9EPeeADkM=;
 b=ruVr25W9BM/SMNGzdj3t5nUhebeiQff474y9FtvIlZsWWAcBV+5fojodIUF7vxsR/VAZ
 vnlRupH52K/Xc7Ue2kwvaEkOxjsTXNcY2mcMwcFdXYLRgMVFtNU/UY7yhdMqlT0yOQg91
 Tqsat5/E3kMtM+3QNfd1/4DppG45Ni5dwOU6sMRRvw8AiO9LeLrK7OMRg8psjSELIzJu5
 rW8DHOUzrOWcpVhRyj9WdwwxR4cccoeIpdE7TDY4VOfGCYBUwjpPUFOtsiWKl3bLByAfy
 WDmsXyaG8LG+lpHtMtnTuiFs38TGGQ0c6H67DFC2heFl2uGIEdreZS3OurQ7XmSXCaw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1F9B01F000C6;
 Tue, 24 Nov 2026 20:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795553930;
 bh=RUxIdsT2a3GEPLS3xlx8PCm2RFieqaaoaw9EPeeADkM=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=FQucDsSTJ+ItwyP1Tj789PzZvJIY6XpS9jR87MxZHHXPQ5FuO9gcrO51dKumfgzX3
 8FL199lUz8RG7eSp4Hz7FC/hvSGa3o2fBT57EkF8DPn7GbIYE0rxd4YIgla2q3dspr
 eSvXX8TBiCVQg8l452TIjYTzI/E1F5fv9U3/w2esxaY/3nZw1ebwPKJTQrhfvj/Koy
 sYsMa6lrT3C7pWSXCQx81VX4bB/PikX13L4f8WEAtYRTKNkX06aPLiMJQ41Z2L7iW1
 dBLCH0xZX5pAHzt2lymSIE0Wt/W1o90Pd22hSIsWCvuimq3NrQD+O08zu2CVwBIgbu
 gPMeV+o6hKOCw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A44484CB90;
 Tue, 24 Nov 2026 20:58:44 +0000 (UTC)
From: Mahdi Salimi via B4 Relay
 <devnull+mahdisalimikingmallo.gmail.com@kernel.org>
Date: Wed, 25 Nov 2026 00:28:42 +0330
Subject: [PATCH] drm/nouveau/fb/ramnv50: Fixed DDR2 reclocking on NV50
 architectures
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-ramnv50-ddr2-reclock-v1-1-64f046c1c95d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MUQrCMAwG4KuE/3mBtlLBXkV8qE02g9pJCkMYu
 7vgd4Bvx1A3HSi0w3WzYWtHoTgR2qP2RdkEhZBCOseYMnt99y0HFvHEru21tiffT6HVi2QVFUy
 Ej+ts3397vR3HD1iWqldmAAAA
X-Change-ID: 20261125-ramnv50-ddr2-reclock-b30ca9d5eded
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 Jonathan Fouquart <jfouquart@hotmail.fr>, Karol Herbst <kherbst@redhat.com>, 
 Mahdi Salimi <mahdisalimikingmallo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795553923; l=1573;
 i=mahdisalimikingmallo@gmail.com; s=20261125; h=from:subject:message-id;
 bh=1K/6Wu8e0J2XN3Xm9Hku5Ij7+tN+riEcZySH53+Mfuw=;
 b=CtKj6j0bbn9Ur2HFfZapsXTVU8AiohiH+Ee8Xyg1ckdaHO1RCinKAGomZD2IWX8esLRom+QH7
 NBCX01rpnBcDVPAmsvG9KWRpsmskn1efsZ/Qvx6sjQ1afCF3OtO0WaH
X-Developer-Key: i=mahdisalimikingmallo@gmail.com; a=ed25519;
 pk=kJgQkgLnEIBLRzYOU2pUvQKBck8dX2HvJdCy3M3tDoc=
X-Endpoint-Received: by B4 Relay for
 mahdisalimikingmallo@gmail.com/20261125 with auth_id=1631
X-Original-From: Mahdi Salimi <mahdisalimikingmallo@gmail.com>
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
Reply-To: mahdisalimikingmallo@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jonathan Fouquart <jfouquart@hotmail.fr>

Call nvkm_sddr2_calc when calculating the DDR2 memory clock frequency on
NV50 architectures. With this change, there are no more errors when
reclocking, the DDR2 memory frequency is correctly calculated, and there
are a performance gain of around 30% on glxgears.

Signed-off-by: Jonathan Fouquart <jfouquart@hotmail.fr>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Link: https://gitlab.freedesktop.org/drm/nouveau/-/merge_requests/23
Tested-by: Mahdi Salimi <mahdisalimikingmallo@gmail.com>
Signed-off-by: Mahdi Salimi <mahdisalimikingmallo@gmail.com>
---
Forwarding Jonathan's reviewed patch from GitLab MR !23 as Lyude
requested. Tested on an NVIDIA G96 with DDR2 memory (reclocking works
without errors).
---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c
index be15519d0..d013a2fd2 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c
@@ -288,6 +288,9 @@ nv50_ram_calc(struct nvkm_ram *base, u32 freq)
 	ram->base.mr[2] = ram_rd32(hwsq, mr[2]);
 
 	switch (ram->base.type) {
+	case NVKM_RAM_TYPE_DDR2:
+		ret = nvkm_sddr2_calc(&ram->base);
+		break;
 	case NVKM_RAM_TYPE_GDDR3:
 		ret = nvkm_gddr3_calc(&ram->base);
 		break;

---
base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
change-id: 20261125-ramnv50-ddr2-reclock-b30ca9d5eded

Best regards,
-- 
Mahdi Salimi <mahdisalimikingmallo@gmail.com>


