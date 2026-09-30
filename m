Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B58CCA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E211110F35C;
	Wed, 30 Sep 2026 12:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="BRvzRBTL";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFB210E9CF
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 01:03:42 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34ca54bfc48so181627eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790730222; x=1791335022;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tqnoWOKNgk3yU/myXUZ7ovtM9FCChQAXvuNXrnvE3KI=;
 b=BRvzRBTLoVmBW9wNjdP67oKkMMNl/8+GJRkcFl/Ho1BUlF2eaiLDS+6qTJ/gbu3U7V
 joDVPqCV4eCsnVrcxBRl0bmo5sqv/ZsRDbGd8NWvrn49Q2/63toYfjN4kh5BjhSkD+RF
 1lf3SfPx6maRY1qL1cv9l97/5GmhPuXaz5hea99w3ct4xa6yohb3nFN8hQHNL/1b+u0+
 g/yNdtlZwQrkQPpwia479OQ1rWrl0ARIXOnPWO9r2aGBGJNedZPOkFtOsq4JmWackysE
 IyPqkJon726MN/vEYbd4vRk7cvG0N//4eeJwO9V0ptf8Ru2/J22O+8rQeJsYfcpd7Gcz
 lPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790730222; x=1791335022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tqnoWOKNgk3yU/myXUZ7ovtM9FCChQAXvuNXrnvE3KI=;
 b=rJJmqpB6PR9l66Cqww1etVsS3i1cLN0XcRK8MGNkz2OItL/ZShD/ivXmMpkDqqLK7V
 2U3skGcOc0Tt9YNXTtqxD5mF4kjqCgPZyJjBc8qeu9T1wAaXlS+x/Xlwi+7JU6IaCdEM
 P46NF47ZA20VxhNhBGKRmu1mbF01OHnC8m7sRd3aUdX9eYzIb3OET7mPev5dtESeX9IK
 WpHi5cUEM8TCkmShQkWwvvC8G4okgNJzTJ/2zKXGH2z+70S8zReEjDEW3lXTjaOHLEfo
 felHtR6ZbL217cIKRZBnxPkJp2CWsRFittOkvqHBF5eeXfTwlmdgh1TEt57HRffZ1UXz
 HZkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCkozqiSOVnUG9g9s0aAjaDVp9T8K4UqJxIjeMsm6v2rnH8GUINknT3xw9WuJiAXizrJh5PL0TY4c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLPN2sK9fPfRYmUJrCyoLeFUqCMDmJ9F5wZmjcDZz8KXx4wZgw4
 KQUEACbmGzNtI858M5eSeeUjcLLfpdEgOtZ8Ep5Pl+DPyr2MtUoUq3cfp0MQSi8AYso=
X-Gm-Gg: AYBFou1h7WdsD3zRIYaxVu6wETa55m03VPj36rGcy2Mb5zW9UgRgNGCV1Fqvj/306dw
 jnUuTI7XLbMBTriQwtc5Akv1iMQYSnZaS6drRtfJftgUHtK+yDHbP48L790GiQDwqmzTCuZi4GJ
 /X8X0FHQqnafNcUDfq3/Z60TGU19uDmtrnyBi3jdvBg9HGtzvbacCZMgSh/PT3byDeh1nMfjhcP
 tfykiDlPuoHO6to68UzUK9FEQAk62W2nNy4W9Q9HQQaDNRGcosJQya8NgJ7xzNcSID/p18Gsu2g
 IjGLhejpVBQBcZH85hDelVm/by1k2+1+VJeH5PiXn8EmB4ydfW5Y0st3UiM3CAsmam/fuon88Gn
 eL9BvNHclpYkannAgM0o7KqSV/2KjIXLg+rgOU/vLeXiwrPCopXLEZEmsQX/YYCP9SUXkx2wxIn
 k0wdoYJD8Y8ecYljVWHNO7nKZknakTjXKpuRPKcOkR5a5MkQtZ7HrUm3w3KOaR7F7xxjOW04SfH
 sryMbwPxF2PAY7B2RQX2yHVM8Ktq1GVD+a7TBsLGJv5bZtTgsWi0MhmzM0//nmYdZ3NfMfFSiSb
 e7K2LA==
X-Received: by 2002:a05:7301:a24:b0:33b:bfb7:31cc with SMTP id
 5a478bee46e88-34c66c0725bmr997520eec.16.1790730221429; 
 Tue, 29 Sep 2026 18:03:41 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c386c2723sm2179993eec.18.2026.09.29.18.03.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Sep 2026 18:03:40 -0700 (PDT)
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
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y v2 2/2] drm/i915/hdcp: Add encoder check in
 hdcp2_get_capability
Date: Tue, 29 Sep 2026 21:03:21 -0400
Message-ID: <20260930010323.93999-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930010323.93999-1-artem@trailofbits.com>
References: <20260930010323.93999-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

[ Upstream commit d34f4f058edf1235c103ca9c921dc54820d14d40 ]

Add encoder check in intel_hdcp2_get_capability to avoid
null pointer error.

[ Backport to 6.6.y: this tree predates the later intel_connector
  conversion, so the unsafe intel_attached_dig_port() call is still in
  intel_hdcp2_capable() rather than the DP and HDMI shims.
  Put the same encoder guard before that common dereference and return
  false through the bool API when no encoder is attached. ]

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-3-suraj.kandpal@intel.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
CVE: CVE-2024-53050
Upstream: d34f4f058edf1235c103ca9c921dc54820d14d40
Backport: guard the common 6.6.y bool helper because the later DP/HDMI
split is not present in this tree.
Review: https://lore.kernel.org/r/2026-09-29-daily-reply-0012-re-i915-hdcp-encoder-check-v2-6-6@kernel.org

 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index f7987fb90bb1..89e378f71d67 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -168,11 +168,16 @@ bool intel_hdcp_capable(struct intel_connector *connector)
 /* Is HDCP2.2 capable on Platform and Sink */
 bool intel_hdcp2_capable(struct intel_connector *connector)
 {
-	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
+	struct intel_digital_port *dig_port;
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 	struct intel_hdcp *hdcp = &connector->hdcp;
 	bool capable = false;
 
+	if (!intel_attached_encoder(connector))
+		return capable;
+
+	dig_port = intel_attached_dig_port(connector);
+
 	/* I915 support for HDCP2.2 */
 	if (!hdcp->hdcp2_supported)
 		return false;
-- 
2.39.5
