Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495A606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tagirov.ch header.i=@tagirov.ch header.a=rsa-sha1 header.s=feb22 header.b=WMiXMh80
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82EF10FD1C;
	Thu, 19 Nov 2026 07:48:58 +0000 (UTC)
X-Greylist: delayed 398 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 18:54:27 UTC
Received: from tagirov.ch
 (207.201.164.109.static.wline.lns.sme.cust.swisscom.ch [109.164.201.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306AE10FF72;
 Wed, 18 Nov 2026 18:54:27 +0000 (UTC)
Received: from mail.tagirov.ch (localhost [127.0.0.1])
 by mail.tagirov.ch (OpenSMTPD) with ESMTP id fd25c820;
 Wed, 18 Nov 2026 19:48:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tagirov.ch; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; s=feb22; bh=1p
 3rdD8qGIQmUkKZDc2yUhLaQV0=; b=WMiXMh80w6UlRDloDoMbWDpn35j+d6qZCT
 CgT+i79JnN+bQN3dVt916syT5YSxCZY0naG4nhh69mbu7h66McFKJWozuM6Nj7a8
 o7jiSbcFWJlqq1Mg7+9O1hRVCc9X6VpRuidVKs3n3yB9YYcHM4BiCUR1kOZdO4K5
 dVX9/jB6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tagirov.ch; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=feb22; b=
 E6Q7wTxLdntM8VE8Rzz/aKmbg+pBYkmcOH6WqxelCUb6iJEx1c1B4nUSne+616YD
 lu7wulQHD6Uf1dRviSx/l8b4LuunlKx9KJjgJKAP3oZ3CGpzK/x1f26G6g4LR+6g
 sXG6JrH4ses1jBDVBsL52eqqrWMn97YbTHj8HsHcXCk=
Received: from localhost (109-203-63-142.dhcp.voenergies.net [109.203.63.142])
 by tagirov.ch (OpenSMTPD) with ESMTPSA id 7d3e5ec1
 (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256:NO); 
 Wed, 18 Nov 2026 19:48:07 +0100 (CET)
Date: Wed, 18 Nov 2026 21:47:42 +0100
From: Erik Tagirov <erik@tagirov.ch>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, 
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run, 
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC] drm/msm/dpu: set possible_crtcs on cursor planes
Message-ID: <av4OfY5sML97l2F_@oasis>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I am using a lesser known wayland compositor that uses the possible_crtcs field of a plane to detect
which one to use for the cursor. On the Lenovo T14s two cursor planes are created, each with possible_crtcs set
to 0xff. Which from my understanding means that they can be used with any crtc.

However, the compositor picks the wrong cursor plane which results in a lag of ~17ms
on each DRM_IOCTL_MODE_SETPLANE call. Making the cursor movements sluggish.

After some investigation, I found out that this is due to the legacy_cursor_update flag not being set
in drm_atomic_helper_update_plane() which has an impact in msm_atomic_commit_tail() where the fallback branch
is taken.

The lag is solved with the patch below.

Best regards
- Erik Tagirov

The cursor plane must be used with the correct crtc to ensure an
asynchronous commit
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..4e0e9c2d8062 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -877,6 +877,9 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
 			ret = PTR_ERR(crtc);
 			return ret;
 		}
+		/* Ensure that cursor planes are commited asynchronously */
+		if (cursor_planes[i])
+			cursor_planes[i]->possible_crtcs = drm_crtc_mask(crtc);
 	}
 
 	/* All CRTCs are compatible with all encoders */
-- 
2.49.0

