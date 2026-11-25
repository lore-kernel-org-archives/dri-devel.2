Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A532A606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MxL8BNSn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4530112137;
	Thu, 26 Nov 2026 08:11:17 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E88E10FE08
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:41:25 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so3510103f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 09:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795628483; x=1796233283;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1nnKgUnH41uFpzvbt0vDxC4+ZynO+VhngeTfrBlQfrc=;
 b=MxL8BNSnBQtlw3GoV9yAKdXt7ZhrGPQ03guXlrBkKqEWEHNFbypktHmO5iTL7EUy9G
 DjgX8rCEa6AoC5/hhAeYi+lKV+e3R0ZjtyQUpI/SZz711jqTJkFP2471orV8fAp2bFJK
 pHT7nsY1sgvG0IoTIcmtV2Tl38GVyxcYXeY2xm8dGdQkOI4yrN+JE4BOi3kMXYfQBGRg
 ufgL00s8pLl5J6j/ArldIybjIEwd19jKYKug74R9do9UXyYRq/na/6XScLbYtFyhvSlS
 LGFp4sjp40UGlXotDDmnBET0BbPjUMqDJlZqWvtdrY15szEowTlI+NZTE23/oa/4RLa5
 /3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795628483; x=1796233283;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1nnKgUnH41uFpzvbt0vDxC4+ZynO+VhngeTfrBlQfrc=;
 b=DPPkijGuURfBjWAyn5TTP9rHN2PHHQHG8ysOcbKjOgahyDss2aUm0bbGMfyv3FA7dC
 0qphj9NpO37o/bO2eng4vccJM4AU+uB8UylUs8/ZZakux6tiZ5JxI6lmLF2i21OgbQfO
 in9FUrArcVNqS7vC1y9jjvZ9+SopWl7JDDSVONXI1mMYF/2DPk1sEU06JDG/ENfSRrjb
 klxhrESYnSDhg1WwRTbuOqdpI7Q9MYXgsEHi775BtqrsTH+58k7erD6CxRBPu9fVv6eN
 VClBrrWi3puX3rqKjhefMHNpVqewYGr1gGD/7+AZaFICByXu3YvlP25qTr5MBjBwGv7Y
 lohA==
X-Forwarded-Encrypted: i=1;
 AL+hErF1hHmqDjVHEoX2yaQ6x8LUKMkOqqPH0D6uDEK593BjjYdsr8Xb/pCbwfPVgUUObM6b/Mhts2m4uj8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+z58YGO5p9e6ikAy9oLTXhDrNXWPZqBDJqPgbQ6c8iaOyWfOIi
 spgCoZ6BJj1NK5UqG3QJEMWTxKjG4Hkcsva0Az/A+E987yQQfJSD0gBunfSIiDABNyk=
X-Gm-Gg: AZFdTZf9dUSOe4Vst9VDXnTXzUuFF2PuwsKE5rLX4eXNHfXmmp1FhWbjQdshqfOP2Fr
 0kyBRoKVr/auKj0iZiGRHGxnLbZz8K2Rn0fQccopO3IRi1f5m/+gPPQ55qTF6GIdd2maNP8gCKE
 VO6Q7Y6YxOHGHZaubQ9B/yrPW5+UWKmhhFXtkPL+mCdOWNR/rBAIhlB/4Ikuh5UUCHXzW0eYpgo
 dbokHo3ZVXQOsSO5NCmVhhGFKQs7B0SzrSePaAJ6uoPG2Ho2Q6ySg2SlIjOZcLENYm2JlwlHAd3
 PeoV5sXq+VsRCietJY3POE+sSmARFJ1A43HqMnSvluNievLsFjQ62zl2VbSNvuBMiCpebETy4sc
 eSwUYbwVQ/WL2TX5Hym1eVt/5QoKfgwpKNDmeHZhz+i5ri+Ko4CE0bG56pYMEwBLFdH6QhGzGT0
 HAw0LaLc+kysP+ghx8I6JstNNnRzkEfACeO/3Zm4VWPN2D1drs7bj1V4ZKpI4HvMm603IO+uRJf
 QlliR0plzAjyoFHpaoGfkK0kjBwG/vUnHGaltom6Uc+xbviSyHGikTlkdCXdLcKRJLyma8T1j9K
 8G9/VKFzbzCc4S88SmSSmXYIxqicryunnOCiM14rz/h3HVJ1OZo=
X-Received: by 2002:a05:6000:26c1:b0:48e:5e20:1371 with SMTP id
 ffacd0b85a97d-4abacfea2c9mr39664160f8f.4.1795628483517; 
 Wed, 25 Nov 2026 09:41:23 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110ba3sm29045574f8f.35.2026.11.25.09.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 09:41:23 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Wed, 25 Nov 2026 18:41:21 +0100
Subject: [PATCH v2] drm/imagination: drop redundant zeroing of new GEM objects
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-pvr-gem-drop-zeroing-v2-1-8453a6e01e81@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMAdB2sC/22NQQ6CMBBFr0K6dkxbUkBX3sOwgDLCGKHNFBuRc
 HcBXbp8yf/vzSIgEwZxTmbBGCmQG1bQh0TYrhpaBGpWFlrqTClpwEeGFnto2Hl4IzsaWshya09
 FWsjKGLFePeONXrv2Wn45POs72nFzbYuOwuh42rtRbbtfQqn/iahAgW5srk1hcmnSS11ND6oZj
 9b1olyW5QP60/C9zQAAAA==
X-Change-ID: 20261105-pvr-gem-drop-zeroing-67cc98380a55
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Gyeyoung Baek <gye976@gmail.com>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795628482; l=4827;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=DuC/rcDE0nO1yX+mV/jpSJ2uisVnTsIi/oVFyc2tvyU=;
 b=2OPnmGyv44yjEbLHE2Ux0WaGPr+//BLm4J7wjSfmmWOqo17l0TXEWztLeG/E5yb7e1O0OEww9
 c3R7pVwRhBSAEXCtQaf4Jmxkp026q3CLRsmsg2A9GqP3f9pt4eRPxFH
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pvr_gem_object_create() clears every new object through a CPU mapping
so that userspace never sees data left by a previous owner of the
pages [1]. Those pages are already zeroed by shmem.

Each object is backed by a new shmem file, for which
__shmem_file_setup() only sets the size, and its pages are allocated
through:

  drm_gem_shmem_get_pages_sgt()
    drm_gem_shmem_get_pages_sgt_locked()
      drm_gem_shmem_get_pages_locked()
        drm_gem_get_pages()
          shmem_read_folio_gfp()
            shmem_get_folio_gfp(..., SGP_CACHE, ...)

A newly allocated folio is not uptodate, so shmem_get_folio_gfp() clears
it with clear_highpage() before marking it uptodate; only SGP_WRITE
skips this, leaving the folio to be filled by the write. panfrost and
panthor already rely on this too and never clear new objects.

The dma_sync_sgtable_for_device() call that follows makes those zeroes
visible to the GPU. The second pass, write-combined on non-coherent
devices, only adds latency.

Link: https://lore.kernel.org/dd2ceacc-f59b-9c3c-e4ce-30b3bbd6939b@mailbox.org [1]
Tested-by: Gyeyoung Baek <gye976@gmail.com>
Reviewed-by: Gyeyoung Baek <gye976@gmail.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
pvr_gem_object_create() clears every new object through a CPU mapping,
on top of the zeroing shmem already does. Dropping that pass speeds up
object creation, most visibly where it goes through a write-combined
mapping on a non-coherent platform.

Testing: drm-misc-next (41ecf852c073) with a Debian rootfs, on a TI
J722S EVM (BXS-4-64, arm64) and a SpacemiT K3 Pico-ITX (BXM-4-64,
riscv64). The K3 also needs local patches that are not upstream yet:
its GPU DT node, an RPMI power domain fix for its firmware and BVNC
36.56.104.183. Each board ran two small test programs, once without and
once with the patch:

- The first one only uses the powervr DRM ioctls. It fills 250 objects
  with a pattern through their CPU mapping, frees them, creates new
  objects of the same size and checks they read back as zero. It also
  times DRM_IOCTL_PVR_CREATE_BO. Result, without -> with the patch:
    J722S: 0 -> 0 non-zero bytes, 16 MiB object in 20.6 -> 17.4 ms
    K3:    0 -> 0 non-zero bytes, 16 MiB object in 41.6 ->  9.2 ms

- The second one does the same check through Mesa's Vulkan driver,
  and also reads the new memory from the GPU: the GPU copies it into a
  buffer that the CPU then checks. 80 allocations, on the J722S only, as
  Mesa is not built on the K3 yet. Result: 0 non-zero bytes without and
  with the patch.

The test programs were written and run with the help of an LLM.
---
Changes in v2:
- Commit message: show the call chain through which shmem zeroes the
  pages and explain why this can be relied on (Gyeyoung Baek).
- Add Tested-by and Reviewed-by from Gyeyoung Baek.
- No code change.
- Link to v1: https://patch.msgid.link/20261111-pvr-gem-drop-zeroing-v1-1-2dc725857053@baylibre.com
---
 drivers/gpu/drm/imagination/pvr_gem.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_gem.c b/drivers/gpu/drm/imagination/pvr_gem.c
index d8660d6a8e01..01b8e08d12f0 100644
--- a/drivers/gpu/drm/imagination/pvr_gem.c
+++ b/drivers/gpu/drm/imagination/pvr_gem.c
@@ -275,34 +275,6 @@ pvr_gem_object_vunmap(struct pvr_gem_object *pvr_obj)
 	dma_resv_unlock(obj->resv);
 }
 
-/**
- * pvr_gem_object_zero() - Zeroes the physical memory behind an object.
- * @pvr_obj: Target PowerVR GEM object.
- *
- * Return:
- *  * 0 on success, or
- *  * Any error encountered while attempting to map @pvr_obj to the CPU (see
- *    pvr_gem_object_vmap()).
- */
-static int
-pvr_gem_object_zero(struct pvr_gem_object *pvr_obj)
-{
-	void *cpu_ptr;
-
-	cpu_ptr = pvr_gem_object_vmap(pvr_obj);
-	if (IS_ERR(cpu_ptr))
-		return PTR_ERR(cpu_ptr);
-
-	memset(cpu_ptr, 0, pvr_gem_object_size(pvr_obj));
-
-	/* Make sure the zero-ing is done before vumap-ing the object. */
-	wmb();
-
-	pvr_gem_object_vunmap(pvr_obj);
-
-	return 0;
-}
-
 /**
  * pvr_gem_create_object() - Allocate and pre-initializes a pvr_gem_object
  * @drm_dev: DRM device creating this object.
@@ -378,12 +350,6 @@ pvr_gem_object_create(struct pvr_device *pvr_dev, size_t size, u64 flags)
 
 	dma_sync_sgtable_for_device(drm_dev->dev, sgt, DMA_BIDIRECTIONAL);
 
-	/*
-	 * Do this last because pvr_gem_object_zero() requires a fully
-	 * configured instance of struct pvr_gem_object.
-	 */
-	pvr_gem_object_zero(pvr_obj);
-
 	return pvr_obj;
 
 err_shmem_object_free:

---
base-commit: 41b5458595c60143d0ebaa1e032c9cda5d764dff
change-id: 20261105-pvr-gem-drop-zeroing-67cc98380a55

Best regards,
--  
Guillaume La Roque <glaroque@baylibre.com>

