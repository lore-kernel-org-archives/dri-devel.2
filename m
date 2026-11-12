Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A286606B72B
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dESwQ7ZW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D7410EB5D;
	Thu, 12 Nov 2026 08:48:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241FA10FD73
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:48:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 072F545B9A;
 Thu, 12 Nov 2026 08:48:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794473317;
 b=Ie1i6daQNT8U7GlcXarBapHDQqv+hpcRdfDCgg+Q6mPJNRX48NksYJ10nA/roqo+SgLT
 FQiWUaoF8f32N3MOY7D9RZQJgnePcR4QVILwvgkj4JErkT8EQhWd9d3c9g8Giy8ie8AU4
 4ci6upg1ZEYJic1M1kYBweYNXfm+uAKJP733fvhZ9Gn1nlFmkUkyfgZPKUqxPFqY194kn
 KtpEmlalKN3VFht+hChOALARyuTrvBgImaNFL0Ka6rQWB6ZgBf9JWsgHPLneTnfhToMRA
 3AymvyJMvnAuElzKv7Z6DvoH67yD3EcAxVCvA9gXXTgWPGbsC4zoTYSFUIAXuTsnRNA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794473317;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=JX4KLPeSr9n/x8BEsMT3Zrn3E7Hx1G4KWDFMA6/eIjs=;
 b=Vsd3Rv0hybPlDMlPhc6xOI4PDoa8zlF2MHa71lBM0wy7b4qXMcGE0tnlTGwaMpsKlBfd
 evDHG5D1oFA6RTUc/2u/4i6YKv7a7V72CXe2q1p9C1Iz1eav1srRjNRgfWabeOVqFDCOM
 w4Ipkz4yU/YQfxwIKgGPwpmIZdkKs2emJ2m2td/QNrgI+gKxp8j7tbeiPYi78ARxKV/5S
 4T3IHa6xy9czUHHn0+tL4Z6j7wcBBypxf99x+Z5ll33DRb3q4RfyuFzDj6Ifk07h0ZFDn
 x0GywvRGGusC2vIGHN7Fpi6iwzj0PZ1UTbb7AX571bpGKve8wPgPAw+Btw8PFUxQlAg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C47701F00A09;
 Thu, 12 Nov 2026 08:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794473317;
 bh=JX4KLPeSr9n/x8BEsMT3Zrn3E7Hx1G4KWDFMA6/eIjs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=dESwQ7ZWNwUyWyIUegubdsnazris1gjKLGwQMjvlXgts4LpiBGxWldgfm5citYyTz
 7TqaoYO6fHN4BvhUdB8E+FOvRaHgVPPM5cLx8khesCZSicsnf3esf/0AausPJSvKno
 ZqyobXgJOcsHdM15qbTvUuM1eZiDg+meT/QKgEA3zw+kzcP8861B8NdEn2JfItNKHE
 k5Qx11GtESiJtPmk9Q0Vn8pRY1lKNB6kFjShy9srr8HgnzW74QVO47aV8B6eo3NDE8
 o/dGo0u1iNeookK/Bf8Hkhc+oojaDBuDv+h2YWxktvRDrW96K3IhyHI8msDXSOxPCD
 OFOYyGfl801Lg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 532A6493E9;
 Thu, 12 Nov 2026 08:48:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:48:37 +0000
Subject: [PATCH v2 04/11] drm/panfrost: Don't WARN when a GEM mapping
 cannot get its pages
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-panfrost-long-jobs-v2-4-a06830da3d99@gmail.com>
References: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
In-Reply-To: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794473314; l=1604;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=zrP1tS5NT5+cDSeYI5XUvjSLeC58wAvwjUaRiUsqgLA=;
 b=4ybjvrDmdRHMugxl1r5Rh61Ogh91dSN/LMcS2BCoGQvy00af0ST/5486xFwsmzrsElqilb7o7
 J1VoVulXAQzBnByjAFgeUqeVYzMpR35JvEr58iCCyaKT6VM41u8qe/5
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

panfrost_mmu_map() gets the pages of a BO with
drm_gem_shmem_get_pages_sgt(), which fails with -ENOMEM when shmem
cannot allocate them, for instance when the caller's memory cgroup is at
its limit, or with -EINTR when the caller is being killed. Those are
ordinary failures that reach userspace as an error (Mesa reports
"DRM_IOCTL_PANFROST_CREATE_BO failed (err=12)"), not driver bugs, but
the WARN_ON() turns each of them into a kernel warning with a backtrace:

  WARNING: drivers/gpu/drm/panfrost/panfrost_mmu.c:478 at panfrost_mmu_map+0xcc

dEQP-GLES31.functional.draw_indirect.compute_interop.large.* run in a
600 MB memory cgroup on a 1 GB Mali-G31 board prints it five times.

Return the error without the warning. No pages are held at this point,
so there is nothing to undo.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index eaf94d47d..971552c42 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -480,7 +480,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 		prot |= IOMMU_NOEXEC;
 
 	sgt = drm_gem_shmem_get_pages_sgt(shmem);
-	if (WARN_ON(IS_ERR(sgt)))
+	if (IS_ERR(sgt))
 		return PTR_ERR(sgt);
 
 	ret = mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,

-- 
2.55.0


