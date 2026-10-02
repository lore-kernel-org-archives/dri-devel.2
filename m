Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E724CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFE610EB0A;
	Sun,  4 Oct 2026 17:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="GUSPIceb";
	dkim-atps=neutral
Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com
 [74.125.229.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8A810E6A2
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 19:40:37 +0000 (UTC)
Received: by mail-dl2-f42.google.com with SMTP id
 a92af1059eb24-144f47a9b57so7822135c88.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790970036; x=1791574836;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gsIJDrrqVrbyQzUJcQTVkyHK/0UNIS8D9cN3PD9t/4o=;
 b=GUSPIcebH4KQM7BQYohWJ7O3GivQZlkayO0xM8PlIGE7n6aDEgnnSR95W5y3x3lQ42
 sR6PIvXQUeNZJDpy2WHBaxIec77Kd/e6JqB7n5tV3UtUksZh0m4t/hkwiJ4SAZM6WVKg
 NmWpkyXNEL3e4Gbmrqg1i+QmM6r6UMK/tf/D597kQ5L9LvNUg60g+fCHVnbxjlK2iLX4
 90U+NlPoQ47sd9S+v5jm1oQzEmUeHiPCY8dtp1kTqBhdFrbv/YGwqvRTnxTPJQUB1M1c
 wR6mvPNbP4Mg5W+3S8bkqegRtKx8AOsMcioVsXze/dZre0T90lRbY8EDcsh4Qd6//Q1X
 /ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790970036; x=1791574836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gsIJDrrqVrbyQzUJcQTVkyHK/0UNIS8D9cN3PD9t/4o=;
 b=Yl4Gb8ouzCgEs4zJ6y/rlvA5mkUxoH62fx2BNg1SugVROWbadDfVgkMKrfbq/JO/wv
 NC3px0P57eaU3kSV7/w432T6j8laDNBL3Bmf+NBBbML8czo1syRJPoiAldQzT/7zXhMe
 JtX9QEsIUWMOBoOqXEig0Rxn44CkxSkWsKX7n+5ueLklwak0qIgUurJWbXK9f34M3lAx
 0O6vb4wYdBQUJczuqhSK4yrvxTMCgQU9Kl18vCY8LQLF/phI5qdhxF6si/wZBCf8Gato
 72jOTlCr4WlRIll0eY++1RBEDrgH7tx0f7kXuCgA2/BbSCBPvnd852ckODLAsELj3xMw
 fQZw==
X-Forwarded-Encrypted: i=1;
 AKwUvByZv83DbxOWmYCyEkFox/kcwROvtQV/oFhv+1FM4BucpuL9zsHGNexc2SDUVrDfuqE29BxNzROxdhM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kZ6+HLuzL+f4H/hJpsZVZIjNyo20o0OtOSd3katuTLzhUv/j4j
 SZkOqC0vroBBgX83wl/froH12UVEFabJZMPG4E063r9pxUz3kYWbM9wHE+Kc+u33xxQ=
X-Gm-Gg: AYBFou2sTfekEJJlNbGzbg8HTOCp4+4AOd4bLyYBBHVmSe00VJ2mCPtUitv1ZdSinlw
 HtwaDzrucB5b5nZinKZXJ2HZ6A1esZYyAvy3LvHsBY3rFxlyxcaCLL8tyXTMNCNyJLxOjwta4u+
 T24j84wknV1xSplVsWalJw2mn2nsmDzwReih1p7B/jt6xq1Zr4j+XF1yztZWmjAgAwMP5b0Eyr+
 w9Y1EajWzNdx8ZG4/JZwRv7v7Vkdlo+KLoRrtjFfCRP2he5Bl0ewfPMJ5W+YOfZmlIKJgRnLgza
 e67YblBBT2Qm5hAdpNzZn8Y1sdhL3NDE/UXVd6SzB2iCFS3NhuoQH5WUdjgWoyQcttQY046p3Uf
 aC35XiW0lh9UfvG7mXkqRundXnMKgrzlBogWQt1KZ0FVZOxJtv6hSS0IayMUsYqHgV7lQYaMQj/
 Jv54neK8e9GNjIZmz4LtsCgRZ+iq0YRZDx1u/I4UVte3foGCHew27dDSm14SfM2OBhcOQ4LTxZT
 xg0wOh/yzj88xuXr06LYk9QTDBcqISu87NS3s+/eYIbtEISlFP1iJB6yo+15Ea4iCJgIkk=
X-Received: by 2002:a05:701b:241c:b0:14f:99a2:1715 with SMTP id
 a92af1059eb24-14f99a217ebmr3412492c88.39.1790970036327; 
 Fri, 02 Oct 2026 12:40:36 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f47a57592sm7450113c88.17.2026.10.02.12.40.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Oct 2026 12:40:35 -0700 (PDT)
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
Subject: [PATCH 6.1.y 1/2] drm/i915/hdcp: Add encoder check in
 intel_hdcp_get_capability
Date: Fri,  2 Oct 2026 15:40:26 -0400
Message-ID: <20261002194030.20489-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002194030.20489-1-artem@trailofbits.com>
References: <20261002194030.20489-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

[ Backport to 6.1.y: this tree uses the older intel_hdcp_capable()
  helper name. Apply the same guard there; the code change is otherwise
  unchanged. ]

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-2-suraj.kandpal@intel.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm i915 maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-53051. It rejects the HDCP capability query
when hotplug or resume left the encoder unset.

The 6.6.y backport went out as the same 2-patch series and has been
picked up for 6.6.y. The fix is already present in 6.12.y, 6.18.y, and
7.2.y, but not in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-53051
Upstream: 31b42af516afa1e184d1a9f9dd4096c54044269a

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index cb7f86de967a88..507721c94f2fdd 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -182,11 +182,16 @@ int intel_hdcp_read_valid_bksv(struct intel_digital_port *dig_port,
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

