Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD078606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h9qf2GU1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B25D310EA0E;
	Sun,  1 Nov 2026 12:00:49 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4B510E0A5
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 01:25:31 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-93efc0452b5so124636785a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 18:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793496330; x=1794101130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U5YuqJ1RNYNIpnrJqD32N6NRCNjg2qumNEcRV0y+9+A=;
 b=h9qf2GU1MUqBXQ0oEv95oTNjKEj2wcpL/LC8aGucUBeznIEPh34gU/eWX+PcG1fJVJ
 Jryv3NA6NECFQ0E5Vk+0OVNxiPKwPiP7QgSJQ8DUHW1dchNYUq6OFtkbBouB4+qCxiOn
 KZouIxv7uzP5DpjLtDaVzP2I6uGq/7VF18niDIQxvib0wWKm6bYWXCHLcNv+to327fCY
 p17pDI9GYd0ifs9A1TK/ckBi+2+1cBKRWHBvid2uWSI/cfSC8CYbsxLKw+Vmp1JbJIKI
 i3r/sLKHbJGyy2+oihvs9YSTzASu4O2F0JqvanbJQJOBC4PHxCxNjPD7jaUFbWJKL9rs
 Mh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793496330; x=1794101130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U5YuqJ1RNYNIpnrJqD32N6NRCNjg2qumNEcRV0y+9+A=;
 b=eH3r9Hid1eOq/CrvhXsxHm+/1DWTEHv3qMf9vlP+ShOISVkWtnZlKr48YuVzCrk4v0
 8fxDO+CkrzGMLFWOiaS76cI10OlCPvU7zn5OkcxASuGdCJwbN9U5zm9xoWBCAVQ2Bgho
 zcxgHVrFnZBQnqQlXL3hSvwosr5bQqy1X0Q8a+hic4rDrDiy0zvfxEoODdGvbNWPtEj0
 Bte0yFze8dMRJfIoPchRRTofZmVfx+KA7NWLtkGcCDmZpkD8VfqCUEoo3+APMyD7qJwb
 fe5xwKXPC2prbhOk4o6Ea3f8cTtJa5Qtc2Csa80vSxqHJ0HnDOumfFSuULppNNC1iW9G
 4Vgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJ147R4YJ7+pbX+CGvKb6bpITnYIJ5U8OMKm5zUYZ3H6SXtv2UGIJx+LDbBRfKX//ZIlkurURtP5s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJzNgJyP+/xIWmZaIZbnaFL8li4jnaH7ZvVLauUHgQp5gfVyY7D
 n6Jma9q9NulXkxjxMy/Su6J/hfG5a/lumdps7BVWl/U5ZN8cqD6hdHv2
X-Gm-Gg: AYBFou2tHtIYfjLUZQcaXn+CoKrIHkEmfvYBhQhZbIKe9YtRyV26fAlOBJZXPVgx6Ym
 u3mYGpOXifYSp1T+isKRPhGKuLit5T3aJvK34pJR/D+0VamLIT0sc1irhWZvxQ2sNTHF6xgtZOb
 WzbB4O/UfGQG2v5GkkIBuWK8m+ghB2jas8jTwNm1KWdbhOk0A0WrhuHsdH3VXDDPrkkAWxzp5Rc
 /DdP8JUpg/FX8qIHIaSN8aFDBXXgObUsDIOS0z+BXr+vT0lxVi2MLglZKg6MVamt0YtnIwyqM8h
 w6XBRxnfhyd2x6i+lErLVEpuY4peUT6SGAnLSLkimYLx1lQVYbXXyyaGFHi6yulKNhzg1HF1Os4
 sJbC48AUw/EbYKzWyOGHD4v/c5IDpX23T5iv4WQjFln5HAoi25gfqdutpgwogOAsefG9agZUayv
 IctgeL+SGrCBKRum8dsPU5igR3KwMuu2/1UBtwCQxyG/aaoWCcudvu8QtbS24a5j5zJkN9xAwGt
 aecOWafRxv8nqoqWqvkkX7V2nJUpElZL95GZdIBfUByOgA6fR733rsQCCBynbqx9h1nGuTKQI8x
 9juQUFTsphqter9f0OlMJ7AKjSzzm8RUg0xJgssjnN1JCY+d3gxDFgHinMV7teUnDeeVaXqnv5U
 0M9M7B/cEZX4B1sso68YhIJCsNCegH1O3FrJF
X-Received: by 2002:a05:620a:3188:b0:943:ff70:dc00 with SMTP id
 af79cd13be357-9442174fc9emr1039734385a.56.1793496329626; 
 Sat, 31 Oct 2026 18:25:29 -0700 (PDT)
Received: from olive.mynetworksettings.com
 ([2600:4040:b076:8700:60ba:f09c:358e:e7a7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425ac5322sm493379285a.39.2026.10.31.18.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 18:25:29 -0700 (PDT)
From: Matthew Krebs <matthewkrebs8@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Matthew Krebs <matthewkrebs8@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Only take the VRAM path for KFD device pages in
 svm_range_dma_map_dev
Date: Sat, 31 Oct 2026 21:25:00 -0400
Message-ID: <20261101012500.7048-1-matthewkrebs8@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

svm_range_dma_map_dev() treats every ZONE_DEVICE page returned by
hmm_range_fault() as VRAM of the range's SVM BO. KFD's own VRAM pages
are MEMORY_DEVICE_PRIVATE or MEMORY_DEVICE_COHERENT, but fsdax
(MEMORY_DEVICE_FS_DAX) and device-dax (MEMORY_DEVICE_GENERIC) pages are
ZONE_DEVICE too. They are system memory.

When a process maps a file on a filesystem mounted with -o dax and lets
the GPU access it (for example hipMemcpy() from the mapping, which
registers the range through the SVM ioctl), the range is in system
memory and prange->svm_bo is NULL, so the VRAM branch dereferences it:

  BUG: kernel NULL pointer dereference, address: 0000000000000078
  RIP: 0010:svm_range_dma_map_dev+0x13b/0x300 [amdgpu]
  Call Trace:
   svm_range_validate_and_map+0x600/0xa70 [amdgpu]
   svm_range_set_attr+0x450/0x8c0 [amdgpu]
   svm_ioctl+0x62/0x80 [amdgpu]
   kfd_ioctl_svm+0x5e/0xe0 [amdgpu]
   kfd_ioctl+0x532/0x680 [amdgpu]

The process is then left unkillable and later KFD calls in other
processes can block, until a reboot.

Even with an SVM BO the computed address would be wrong for such a
page. Take the VRAM path only for device private and device coherent
pages and DMA map every other page, as for normal system memory.

Fixes: 1d5dbfe6c06a ("drm/amdkfd: classify and map mixed svm range pages in GPU")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matthew Krebs <matthewkrebs8@gmail.com>
---

Notes:
    Reproducer (needs a filesystem mounted with -o dax; an emulated pmem
    from memmap=4G!12G and "ndctl create-namespace -m fsdax" works too):
    
      fd = open("/mnt/pmem/file", O_RDONLY);          /* >= 64 MiB, on DAX */
      src = mmap(NULL, 64 << 20, PROT_READ, MAP_SHARED, fd, 0);
      hipMalloc(&dst, 64 << 20);
      hipMemcpy(dst, src, 64 << 20, hipMemcpyHostToDevice);
    
    An application doing this (hipMemcpy from an mmap of a file on the DAX
    mount) oopsed as in the commit message. The minimal program above was
    written afterwards and has only been run on the patched kernel.
    
    Tested on Ubuntu 7.0.0-38-generic (based on v7.0.14) with this patch
    applied to that tree (it applies cleanly), 2x Radeon Pro V620 (Navi 21,
    gfx1030), ROCm 7.14, Intel Optane in fsdax mode, XFS mounted dax=always:
    
    - Before: the application oopsed in svm_range_dma_map_dev on every
      start (3 of 3, on GPU 0 and on GPU 1); the task was left unkillable
      and a later hipHostRegister in another process blocked in
      __synchronize_srcu until a reboot.
    - After: hipMemcpy and hipHostRegister + copy from the DAX mapping,
      64 MiB and 1 GiB, on both GPUs, data read back equal; the same on a
      non-DAX file; the application (an LLM server mapping a 111 GB model
      file from the DAX mount) starts and answers requests. No oops.
    - With dynamic debug on svm_range_dma_map_dev, the pages DMA mapped
      during the copy have pfns inside the pmem region, and KFD's own VRAM
      pages in the same call still take the VRAM branch.
    
    Not tested: MEMORY_DEVICE_COHERENT systems (the GPU memory registered
    as coherent), device-dax (/dev/daxX.Y) mappings, other ASICs.
    
    A stricter test would be "the page belongs to a KFD pgmap", e.g.
    page_pgmap(page)->ops == &svm_migrate_pgmap_ops, which also rules out
    another driver's device-coherent pages. I used the type test because it
    needs no new helper; happy to switch if you prefer that.

 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed5e33188..354184829 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -180,7 +180,12 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
-		if (is_zone_device_page(page)) {
+		/*
+		 * Only KFD's own VRAM pages (device private or device coherent)
+		 * take the VRAM path. Other ZONE_DEVICE pages, such as fsdax or
+		 * device-dax memory, are system memory and are DMA mapped below.
+		 */
+		if (is_device_private_page(page) || is_device_coherent_page(page)) {
 			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
 
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
-- 
2.43.0

