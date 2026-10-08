Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89A0CA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0007810FCCD;
	Thu,  8 Oct 2026 07:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bY+B2ZZB";
	dkim-atps=neutral
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D98710E739
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 05:17:21 +0000 (UTC)
Received: by mail-pj2-f2.google.com with SMTP id
 d9443c01a7336-2e651c30dcbso2499675ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 22:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791436641; cv=none;
 d=google.com; s=arc-20260327;
 b=UQkynkpQ35FkSMDy1lkKLqEeXS6tm/0ptCEtfp35z3jPBUieXqkMewDAzLWha0xh8Q
 IdwR/YC/3chW83l5bLQnFiThGaG/JdJr1mGSUhIoUhAaZ5o2uMqAyyBTK9QcQHalL1ix
 MFO2WADSP2l+ZPSJQpZTW5lbairQ9/w85GRcaK6j6goaHbMDD01v6eNTxneeiyW7inSr
 0S6pYHOGZVND0sroxh3zgVEfacmlpyWJizyz+BvS8FOLNFDYS7o9OsHE1LJCicqlbtmh
 0cirmdy4/T9KBujA7kEFsppyy3vb/iFSfh86H4o3L2FlSa3GM9Af/GBHwoLxew4/u9So
 7X3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=nZxCaIo9txwzpM9hHuP2f8v3rOWm8pOzF15AOYuWLXs=;
 fh=cO2gIgt+coaF4GUhGwGDpOmFTCXZHTpgVprWxdbV1fw=;
 b=eywJ6mk/mkwgwGXlpLGmzGVnm4T3Dj8m77u3/GTLrpxZQ01yjlEfixq4pUJBCRLzmT
 WqTYZHHB4kE9GXj71daWkQBrlpHQnSwxVhcWyeNM2daKEMK/V+etrlDKS+GNAI/PIIgL
 antWJ2k3PkWdz3CLtlQVA26IYlQK0l6tS7vz5sRDiGdmT5CG86MlVI+QFGh06Kzl3Bst
 zxSk2GrUE845qYjuloAwGfkIMo0lx5Lru66+Sia1+Cgqn9i/pFzOCLc/ZzOxV3okZwSC
 kUPCHfesQxD6MKjKVWUv/fuwgfjvm8Ogos9miT/BYJyljh4H+HfOGTaquItZdYIuCf3S
 X3JA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791436641; x=1792041441; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nZxCaIo9txwzpM9hHuP2f8v3rOWm8pOzF15AOYuWLXs=;
 b=bY+B2ZZB1AsZ9adHZDFZM+Lb52/Nj3lgmITK//H82A32Eq7qAExJNNDJtkP2cW4ULB
 2/TnTviUJ7nbQ4WlUMjookMhAFD8zMS0Mx8V+p5oc8sHeBFti6ehl2I7y7nMfTJ1SHC6
 bR8TwHEL+kg56j/YekO21lROdA6Pq9xVy8/uaR6m6I6I71aQnjwNiUn6SNkI8ZMol9Bb
 ABCm1LB+B5cm8noJJvr94VOQoA7w9lnq1g6Xq3H2tJ0IqL4BV2AyymuXohV1LrYJGFy2
 5nn8sb7wXLuSzQWNw4XXOOIUeHysKiP+3Nl538OrnFG09pHrkQ1EIMhRRoVO5kOfJoyj
 k7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791436641; x=1792041441;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nZxCaIo9txwzpM9hHuP2f8v3rOWm8pOzF15AOYuWLXs=;
 b=oO4JbSSnfYAbM2Y5aAE42AAMB7PqOlZituw66ON+8sJm/KBCDaNtHWiPU85vSZb/Vb
 fmJlXXQiwJm9winI8pQmyDX0opQsNono0QrH2H8KoHva1LARTYu0nl8sTP5+RHoGmapG
 QTV6qKvcgPclGjf6f8CYlkH2L9H8n9Hkn0D4vpqmg1qE+j2hQPsESp4u+NXYSuy83zyR
 WZjJxgSZyI8ohuijUFWctbF9LN9Ee2spFT5krnTwlT9DKQtVLbtFF/i4oKPG2Phy7od7
 yxuDFMbb9YBo1xpmGrPZHat+jLcpCAOzYbD42gkEGkZ61attXUv7DO0hfXgUbAps03Ga
 iRZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZa3kT/RV0CT229h4ClAYbU+qX+pxY60TZTrJGOEpz5MhFWxuWepKowx2re2MeCdKoIifClnor9kY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nh+jMogwA48RY7pf87rdiRWyKxW2CiE8leRp4mHt8gzejql0Sx
 SSpvaIFV7Hv+3xOu1J52gS5sYcJmeLIkZCrAlPFxiyb9STgutzlBn1NPZzOLKeNwE4TXWafmgH8
 bRgrCYD4+UH6xO2hhMVwa5+vB02+YX+c=
X-Gm-Gg: AYBFou3j5ToDP+OatVBLfpaZpNIJfyWN1yKlh45x5lXLTwtkqoWzFI9PRRN2lO3XVmK
 nc+84SfNiC+3DLpk0yXxYefD+fecCoNibbTu0VHiPQdJFI0uQ2OtzEdvpI973+lM5pdMiePtTIe
 bAusjBEk4x8NBGKpwad+bFuLdUl7eoAV7eHyxrkmlrcizzg5PpWVoVXx3wQmaexeO6M1uOWLkwd
 Jcb+Kaw837JFeTGkJ7E4L6adRGwH1Sa1wOv972bxqr24l3wYBzqpexqEcmtOAVCbqrJSOVAlRhx
 tfX94X5Hb4LUIYM1fpcmfZhCn51ZBRA/iG29QPSm6RQKMsT2KsYKuw==
X-Received: by 2002:a05:6a20:ecc7:20b0:3e1:4541:899b with SMTP id
 adf61e73a8af0-3e145418a8fmr1385001637.41.1791436641046; Wed, 07 Oct 2026
 22:17:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 7 Oct 2026 22:17:20 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 7 Oct 2026 22:17:20 -0700
MIME-Version: 1.0
From: Yibiao Li <biaobiao2233@gmail.com>
Date: Wed, 7 Oct 2026 22:17:20 -0700
X-Gm-Features: AclHuK9UcY5R91xpt04gOFDaB136BcNqqe9341-E5szYJoMqgQSodHyBmZUxnAI
Message-ID: <CAG1agfwtnjmb8RVLmZvY9W-zrR1onhK6urJA3Lqai82tAXn2Cg@mail.gmail.com>
Subject: [PATCH] drm/amd/display: Use separate iterator for preferred mode
 lookup
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:42:48 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Yibiao Li <biaobiao2233@gmail.com>

create_stream_for_sink() uses preferred_mode both as the list iterator
and as the selected mode. This triggers a false positive from
scripts/coccinelle/iterators/use_after_iter.cocci: native_mode_found
already ensures that an exhausted iterator is replaced before use.

Use a separate iterator and assign preferred_mode only when a preferred
entry is found. This keeps the selected mode separate from the iterator
state and makes native_mode_found unnecessary. Preserve the fallback to
the first entry, or NULL when the list is empty.

No functional change intended.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202609190901.yKTzhsGz-lkp@intel.com/
Assisted-by: LLM coccinelle
Signed-off-by: Yibiao Li <biaobiao2233@gmail.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index d386bb1475..ceea8fe481 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1453,12 +1453,12 @@ create_stream_for_sink(struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct drm_display_mode *preferred_mode = NULL;
+	struct drm_display_mode *connector_mode;
 	const struct drm_connector_state *con_state = &dm_state->base;
 	struct dc_stream_state *stream = NULL;
 	struct drm_display_mode mode;
 	struct drm_display_mode saved_mode;
 	struct drm_display_mode *freesync_mode = NULL;
-	bool native_mode_found = false;
 	bool recalculate_timing = false;
 	bool scale = dm_state->scaling != RMX_OFF;
 	int mode_refresh;
@@ -1509,14 +1509,14 @@ create_stream_for_sink(struct drm_connector *connector,
 	stream->timing.flags.LTE_340MCSC_SCRAMBLE =
 		connector->display_info.hdmi.scdc.scrambling.low_rates;

-	list_for_each_entry(preferred_mode, &connector->modes, head) {
+	list_for_each_entry(connector_mode, &connector->modes, head) {
 		/* Search for preferred mode */
-		if (preferred_mode->type & DRM_MODE_TYPE_PREFERRED) {
-			native_mode_found = true;
+		if (connector_mode->type & DRM_MODE_TYPE_PREFERRED) {
+			preferred_mode = connector_mode;
 			break;
 		}
 	}
-	if (!native_mode_found)
+	if (!preferred_mode)
 		preferred_mode = list_first_entry_or_null(
 				&connector->modes,
 				struct drm_display_mode,
-- 
2.43.0
