Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20374CA5FB2
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CFEB10ED87;
	Tue, 29 Sep 2026 08:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="cyuIbM5N";
	dkim-atps=neutral
Received: from mail-dl2-f23.google.com (mail-dl2-f23.google.com
 [74.125.229.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEAC10EC6E
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:17:33 +0000 (UTC)
Received: by mail-dl2-f23.google.com with SMTP id
 a92af1059eb24-144efd1ea76so2133464c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790651853; x=1791256653;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FsP2Z39yDHYgidPq7LJCuoklm/2VErUU9c6HnTD+Pa0=;
 b=cyuIbM5N25lc9nM9XWo+Qir6olmu9J8Kd/pL2X1BOfgpPkX4JguOF5xlXFWRz2mWzs
 U4HfxsG9Nc6BQ1OGyzty0DOnP7o2qha7yxC6z2voepWEHdGXcGj5wq5iwcSHuO+nonk4
 pdKFfMD+4WNgLVPY+GeTKIbDEyHYTxyK8OILFjpE3RY9r995195lPT/mcAqafvffwdOm
 oSTLR5ejfIUoDBnJc4Tzdd1jaUCuWlhBWLQBDwQ3/te0zV0Wpd91+FuiDwKI4AjunXoQ
 Oqjx3cvMGhT+APKkbTAFVOIELB0lOKGOvg16gejUOd6qXQTsTrIF+ecfec2kxqX2hm3P
 ax5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651853; x=1791256653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FsP2Z39yDHYgidPq7LJCuoklm/2VErUU9c6HnTD+Pa0=;
 b=DoHKFdBQQBOXfEGzwcXSbF12jYwNrILZrknJ7rZw9Pgl3RMT5yw6VwjdCNZoyFtcoH
 cdKu6LBvpRaRIaXSnzuYBe1X2+dYpQiRhktdyXjBo75WMzrQyBri5ZPv1lzqTvNs1XMV
 OC/ohBohVbmVbmrNHV9doW8IZ16di+DeRFwVRcwUtAC+3W7meKwY9yqqfaenDugRnIQW
 ydqycCWpUiApvYm8zc13X9fmlSYnXN5URkaHDclVVbn65COz6fOreNPcd6cEcuiGaGwU
 OLqeFzFpEJgsbJ+FSyqmK2IsOO5SCl8qWqv2tZMKZdqGjgP+SDZkPmUeBNhZko7w5epN
 gXxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrR7K00yN3+QZvnFaoIPAeO3unKIB9hp5HQnHJO+iA0jJaauS8YyxkpBKVfW9WWcmNfsiuOR9vPcs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mgolboHgK3IMxyPBgteHPkrB4duTPSACe0wO3nDYM9guDw4MMh
 4nACrtxTUstubIQN/bzpaCsVH6Xl22X1XyEceorMbhgbfkEybcrBWsk4teDDQA6biRE=
X-Gm-Gg: AYBFou1AAmpPedq+xZb9V2nSkw8IGwOSSO0QSRRnMbiUD1nivW9FX4iM7XA+nc67c9X
 z59YMbprHBXp/5DEXcvTRdyr/jUo3ZMOth4qcsfHtiT6B5KxJSqIZB8r/Pl7ePQyK8vXf+3faFC
 tmxquI9oj086xse1kUpoY1c2s1ycTyC98T0BHFFZD14X3F9ro4ey2SQW2ZB9603TNBlhEGNhOPz
 rq1jL2H1GjSzXXIuL3a1ffP1yc0ArMkQ1jMp1ekj8aCor2JQmdCaiZMSpSdfWL9pMn5soMIhYHG
 pL1dj+1qEYoO7b/7phkvRj3so2pc4TwvTYpLUO2RdPO/VPfkaIRVFwtf9FnPa1nJOyK3kcyLmBD
 lFHYALU8faLVyUvcIFpDdivgtX5XopTP7+D5ZaNM2O5yCUKirQZSaWiALoLboTWvSaI8ZLKOPiH
 z/Wk4NH0yFXIcGO0gkIVunhnLmm45PhvRWLyVhyerHeBLiN7GiLbS/cG0qMLvnbZLiGdU6C513X
 H9kr/2Q1AQEV+mgh4eHpso3AvesuW5PfQZKBGj+debnbsrYUVq+2Tbsrqp95ocru7t3fjCVsNL2
 qXfOjg==
X-Received: by 2002:a05:701b:21c7:b0:143:46a6:b01f with SMTP id
 a92af1059eb24-146cfec8e21mr13180519c88.31.1790651852851; 
 Mon, 28 Sep 2026 20:17:32 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ad9e097fsm31321186c88.13.2026.09.28.20.17.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 20:17:32 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Suraj Kandpal <suraj.kandpal@intel.com>,
 Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org
Subject: [PATCH 6.6.y] drm/i915/hdcp: Add encoder check in
 intel_hdcp_get_capability
Date: Mon, 28 Sep 2026 23:17:26 -0400
Message-ID: <20260929031728.88004-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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

From: Suraj Kandpal <suraj.kandpal@intel.com>

[ Upstream commit 31b42af516afa1e184d1a9f9dd4096c54044269a ]

Sometimes during hotplug scenario or suspend/resume scenario encoder is
not always initialized when intel_hdcp_get_capability add
a check to avoid kernel null pointer dereference.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-2-suraj.kandpal@intel.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm i915 maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-53051. It rejects the HDCP capability query
when hotplug or resume left the encoder unset.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The code change is identical to upstream.

Could you please queue it for 6.6.y?

CVE: CVE-2024-53051
Upstream: 31b42af516afa1e184d1a9f9dd4096c54044269a

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index f377c4484e1857..f7987fb90bb1ac 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -142,11 +142,16 @@ int intel_hdcp_read_valid_bksv(struct intel_digital_port *dig_port,
 /* Is HDCP1.4 capable on Platform and Sink */
 bool intel_hdcp_capable(struct intel_connector *connector)
 {
-	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
+	struct intel_digital_port *dig_port;
 	const struct intel_hdcp_shim *shim = connector->hdcp.shim;
 	bool capable = false;
 	u8 bksv[5];
 
+	if (!intel_attached_encoder(connector))
+		return capable;
+
+	dig_port = intel_attached_dig_port(connector);
+
 	if (!shim)
 		return capable;
 
-- 
2.39.5

