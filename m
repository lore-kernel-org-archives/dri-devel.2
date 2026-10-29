Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CB606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=DNRMNkyk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2AF1121BE;
	Thu, 29 Oct 2026 10:19:28 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2F41121A5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:19:14 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC243C22;
 Thu, 29 Oct 2026 11:16:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793269019;
 bh=KBtlOAOFYJM1PRfZCgbJiAuSbTP1DfY5ZemL9rRN+5M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DNRMNkykF6fjjsLioGOMEwAdBA3gHRimDByzK+7TB6t4Ndd7ORUkNrMSV0Jh6V4AP
 KiYUj08X2fb0up55sxL49AKY/40loj9ZohhluLHDTadYnUysCDGTwzbzpxbmFz++FW
 v88AM7W6XNvcYN8OOUDVje7+woUWoVg6p2jQlofs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 29 Oct 2026 12:18:50 +0200
Subject: [PATCH v4 04/14] drm/tidss: Drop the tied off video port check
 from mode validation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-beagley-ai-display-v4-4-dc7f2b532478@ideasonboard.com>
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
In-Reply-To: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=KBtlOAOFYJM1PRfZCgbJiAuSbTP1DfY5ZemL9rRN+5M=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq4x2WJ3f5PtYgPGQjINcFNhfcLRDv9Y9wkNfDk
 raEBSXv3oiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCauMdlgAKCRD6PaqMvJYe
 9XBkD/9HAxVjBiLH8Gn7K5nseLyKL+qMTPW5zFvL0i+XUNwXCm2GiHrrx0Qg1IVlGVZwVbN+Tx8
 E9t73PbHlp2DZP2XRgR0/q7cSjqBFuGFF//1SoaGENwUKnJbm0pt7YUvmnOYwnPRupxAa6lnxGd
 o7s/nXR28apu4HRhWHFy22KwJCAIcpz2QoWuOSvBobfl5RKpG+frRNhNEiH6oDxJHArLEGlatgI
 KhZdUFj1TZtphmTQorPXsdH3mXwimABLeg24pP/P8zjkdBlHHdY4pm6xovfIFs6jHqtGD909kfb
 gsBDsnp+sS64g2oy3E38/+7VvCeATJwYiZYG8cO+3k9VeOI+gT4MYEf75A8PoSCsYF8GvaedR34
 mBBJosZccbb1SIVZd8OESVmOuRBOyfUKVDaxLRTq1H9aBMYxUm8q5mfMd6yQpQND1dRcX1Fh54p
 gbBc4eAzFuxif8W8PxyV9pAz9BRA18itb3x+SOVLBThEhHF2cFyI3G2QlZ7n0Ey4vV04yrAR68r
 X5EWdku/7xj/qvZaYdbz9k7KXAy+p+7nn076I5K6b11h/IvG1S6cL65S7Y3oCLXVxO0u+LTuXWE
 CNLxru/rPwgpZ4RmuOZmU7EeZ0dNaGvkCE3Trz+HFrvWNLefi0ibHuFwN6LLkiFtWAPtJje32+f
 rK9ACKQ3yM6PFKg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

dispc_vp_mode_valid() WARNs and rejects every mode on a video port that
is marked as DISPC_VP_TIED_OFF in the 'vp_bus_type' feat.

The check is redundant, as nothing in the DT will be connected to the
tied off VP, and thus the driver can never do a mode_valid call for it.

Remove the check, and rely on the DT to be correct.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index efdabf046d64..8c537280faf5 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1342,12 +1342,6 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 					 const struct drm_display_mode *mode)
 {
 	u32 hsw, hfp, hbp, vsw, vfp, vbp;
-	enum dispc_vp_bus_type bus_type;
-
-	bus_type = dispc->feat->vp_bus_type[hw_videoport];
-
-	if (WARN_ON(bus_type == DISPC_VP_TIED_OFF))
-		return MODE_BAD;
 
 	if (mode->hdisplay > 4096)
 		return MODE_BAD;

-- 
2.43.0

