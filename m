Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849B606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VLf3APqW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9854D10F32A;
	Tue, 27 Oct 2026 09:32:01 +0000 (UTC)
Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEBF110E167
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 22:46:40 +0000 (UTC)
Received: by mail-wm2-f2.google.com with SMTP id
 5b1f17b1804b1-4a210b0d5c3so12639095e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793054799; x=1793659599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uLTFgSWVH5PgtNiCYE4Ye5g7oFVHKv8jMWdCl4mPxv0=;
 b=VLf3APqW55gkOsYU6DorkLmOhaAU2l4BUTtp9u5cgHC/vlraFP6iGLcnL07W9o01yG
 ovUN3rozWTL+JmST6of9dAxLIu2EM2NLn86IebKMHiZuw0bbNHcWQpE0uINUyIMiL+xQ
 arQCMgrijcBCzc8JA8x6opbQuBjQx1OKZHNeWQZoA3KoktxrQVQ6p2pdrJDKl50CQ9ex
 ZAwivUApm9GxJw4dsMr07eU4zFt3DelH6hq52jXZiJerxSLkZFMlCe+o9G0fATWcrnPH
 +vIerM+ZUtjNA39NbKrDxwXYV9EMj3shbXl9nnRo5Cu8gCMCsjXY/5mj+/6MbpeBuVO/
 JBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793054799; x=1793659599;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uLTFgSWVH5PgtNiCYE4Ye5g7oFVHKv8jMWdCl4mPxv0=;
 b=hxY+HEQffainhS6sLBpB1XxtMgYdcAg5U1HopJ4D8KseQ4ohXloK7QdFzfXoauBhXw
 57VFzWDUZaTqhYq9oJiDcEZIPhrP4FaGFOnxfxOxO7/FOTtVWrlslxhlLFbl9I7W0LrZ
 P4tcmf/E074LVK7g3SrZ9WL7FUHJAfIZ7Au3xSJw+3IDWDHx6MFms4aQlff+nqDfV+hw
 z0HR67EcRurvPR/TuJ3FEi9NXgSqrQBQoAVWsf5O5Z5hqCGETvlE5YXk06DMpfLFFAuP
 vfZwMuPtkomd36tMt8qFwPRH73vsREzDVQP8oSiSeKfI9V+ELWHNbvPQWB4dtMnVIWAr
 WN5A==
X-Forwarded-Encrypted: i=1;
 AKwUvByhhXZJJCskdPl/SpHZml2p7wYZWu/yS0OqRw7z4Yq8Sf0SLVLR+WLfVlkysjs7flNJOQNHC7DMPk0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJewYdWBz5gNBQbcB6W57aJ2asCxrQOAOhFEzQGiv8mx1ODT9Ne
 gzhsOO2kDIMQH4dhroOKxREQmLtsBxHqISzQtR5hIzatKaB/sOtjOxeA
X-Gm-Gg: AYBFou3sFvamfiwjnQmhOEd/adZgpBxifb2VBTrg+vY6FTB0hsPdZVsLzTK5Uwg0qdh
 /zojHfpxBt/lbVSSoDXlixPwyVyqZZ1J3m9qIRUZm6iUg+fWWExtOznYZoGShNARJYw6rKmf+Q5
 ZDtt6UbLunEPb1IUSsAh1Vat7mPa6iDR7usPfO4xBkMFLMWAK734FQbZcrpBz9nLhZbMl9/ORZD
 aBNJzJ9NZR8XQU2Hnn+JGZHCRLvQi7TNZ7aG9FPZZvpBEbI/Z/ZIZBUoIbbpjlQNH+p086mubNm
 KvcMTrjc5KDh3xVm4vFx8nbmKvdorlTneAkGC4DqpKkMLN+2GETdefmtn87zkfXFxhtQ4/RVHQg
 OwHWqwf45xXzXlOp7X9CGKnY3e1jQdx3qfcNsTF8GNLn6ocCoBE2B28sJ0COaJxZ2Bfsg8d/qmK
 sTLk7ZbJiHyKwJzsgAeNZi52I7IRJOfEfWkxOoGfgSy9GpbCZAjDTO/fJ+zYRPKaclW9Ml3+SjA
 VZh0xPegtVGNlz463EByft0GE44aS8hoMhMCUTGqH4S4OYLNCE4zzAae8pRoNvgnyryNAw=
X-Received: by 2002:a05:600c:524c:b0:4a2:105f:ab88 with SMTP id
 5b1f17b1804b1-4a35ac963f8mr148226215e9.18.1793054799133; 
 Mon, 26 Oct 2026 15:46:39 -0700 (PDT)
Received: from [192.168.1.12] ([31.94.68.191])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f3e00asm390740105e9.0.2026.10.26.15.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 15:46:38 -0700 (PDT)
Message-ID: <a826b32d-597a-4c01-8b30-218cbca8627a@gmail.com>
Date: Mon, 26 Oct 2026 22:46:37 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Richard Lane <richardlanedev@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH 1/3] drm/amdgpu: reserve 64M stolen memory for Apple 5K iMac
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apple 27" 5K iMacs report a single 2560x2880 tile (28.125 MiB) in
VIEWPORT_SIZE while scanning out up to 64 MiB across the relocated EFI
framebuffer.

Override the stolen VGA memory allocation size to 64 MiB when matching
PCI_VENDOR_ID_APPLE with a 2560x2880x4 viewport size to prevent
framebuffer corruption during boot handover.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4204c3c750a8..8b196fbfa724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1232,7 +1232,15 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev)
 	} else {
 		size = amdgpu_gmc_get_vbios_fb_size(adev);
 
-		if (adev->mman.keep_stolen_vga_memory)
+		/*
+		 * Apple 5K iMacs report one 2560x2880 tile in VIEWPORT_SIZE
+		 * while scanning out up to 64M across the relocated EFI
+		 * framebuffer.
+		 */
+		if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+		    size == (2560 * 2880 * 4))
+			size = 64U * 1024 * 1024;
+		else if (adev->mman.keep_stolen_vga_memory)
 			size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
 	}
 
-- 
2.55.0
