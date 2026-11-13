Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80997606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=4+QetiTn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B31A10E328;
	Sat, 14 Nov 2026 16:24:48 +0000 (UTC)
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B0410E176;
 Fri, 13 Nov 2026 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1794590635; x=1794849835;
 bh=NMDZysfT7XZcy4Vr7EExZgccS2DkId56v85Kwhm7tdY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=4+QetiTnG+aX2TZxE6bU9DMiGMtNKo/HdPNtutcXNz4P6tFfGIAyjhy1BB2KUcGc4
 hegf7JEySkjUyXagYmUxQOqjvjKXfaAJFIEjd8iIV75xeeqQT6JzBk5+wEHyTTHA2G
 9J8tNrGtr6Nc+d+CtgWm3aOqHQq6iPIy5AWCZiJGEowxWRoPd5fz7CRuVAQeoPS7dX
 c6d4x6S8v1qokmxvWr/NYloOZwwenDLVzGy52ecaZB5ZYyommQKTvwYeF875ycHTmC
 3MW3BceSK2IgkE5OzRKw/siR6uWEriVNcxJR3vtzmLryDEqdWnieYhQdDiHjQyAvDk
 IEsgfwaVfAm0g==
X-Pm-Submission-Id: 4jR3yJ2ND0z2ScX9
From: Michael McAllister <me@michaelmcallister.org>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v3] drm/msm: release the fbdev IOVA pin on teardown
Date: Fri, 13 Nov 2026 17:23:44 +0000
Message-ID: <179459062437.56042.7618212515796640496.msm-fbdev-pin-leak-v3@michaelmcallister.org>
In-Reply-To: <179425722110.3461.10554987541005946397.msm-fbdev-pin-leak-v2@michaelmcallister.org>
References: <179424371125.96483.2462884435294600442.msm-fbdev-pin-leak@michaelmcallister.org>
 <179425722110.3461.10554987541005946397.msm-fbdev-pin-leak-v2@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The fbdev probe pins its buffer, but normal teardown never drops that
pin. This produces a pin-count warning when the framebuffer is freed.

Keep the setup pin and release it in fb_destroy. Drop the object pin
under its reservation lock, since fbdev destruction can be delayed until
after the KMS VM has been torn down.

Fixes: 7ad0e8cf6317 ("drm/msm: Count how many times iova memory is pinned")
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
Hi Dmitry, thanks for the feedback. This keeps the setup pin and drops
it when fbdev is destroyed.

Changes in v3:
- Release the pin during teardown instead of removing it from probe.
- Unpin under the object lock so delayed destruction does not need the
  KMS VM.
- Keep this patch focused on the pin leak; leave the mapping and probe
  error-path changes for separate follow-ups.

Thanks,
Michael

 drivers/gpu/drm/msm/msm_fbdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index dd6d6c507d..29f5dcabc5 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -47,7 +47,11 @@ static void msm_fbdev_fb_destroy(struct fb_info *info)
 
 	drm_fb_helper_fini(helper);
 
-	msm_gem_put_vaddr(bo);
+	/* fbdev can outlive the KMS VM; release the object pins directly. */
+	msm_gem_lock(bo);
+	msm_gem_put_vaddr_locked(bo);
+	msm_gem_unpin_locked(bo);
+	msm_gem_unlock(bo);
 
 	drm_client_buffer_delete(helper->buffer);
 	drm_client_release(&helper->client);
-- 
2.39.5

