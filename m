Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1671ECA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0813410F35E;
	Wed, 30 Sep 2026 12:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="ddBuN2zg";
	dkim-atps=neutral
Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com
 [74.125.229.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD85110E930
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 01:03:40 +0000 (UTC)
Received: by mail-dy2-f42.google.com with SMTP id
 5a478bee46e88-342773d94a7so2964826eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790730220; x=1791335020;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PFwFCHroA09S10Beb/3mqXg3PAfAFcLcaaVX6WAqpVQ=;
 b=ddBuN2zgwAb3C2/PPsOg9EosO+Pwe2QaQXKAt1r4leL8SnwAXtcv9Mi6AmNltbvZy3
 c30IBxPmPBfh/RyWEH7a3enHs3PXa+lPokmeIvqnVoQAQbi1zzUgi4JxxxiZPIoJU6/z
 kS1mna+9eY5UHie1aAJiC9yWrxbwv8vhn40u28jMB0vNLHg3+GdXcNJD9TpCjpzIa1sM
 PUNJxnkf+0OuK3qLKLt6aW2D0g+PqjbI5j4QMWwBGNrKX0k4gEGU4pgAnEM6AbMDTEMx
 WEGnTXuK9avveUDQJMjlGoSNMeUQnF0JBw4bQKoEOhd98p+cRdwQQifM1vW4pdK71mZ6
 96SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790730220; x=1791335020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PFwFCHroA09S10Beb/3mqXg3PAfAFcLcaaVX6WAqpVQ=;
 b=QRk3mfNmLqwMmh+pAbmIxBtM/OX8L7zlUty1Yg2z3oAIFLSCm5odqtXsjezP+TLS36
 LIa5zWo7KQH8mWbX3aukh2/rBsY3C0pPW/3Goky1lG2MVs3R5rdC8Vk8+rvAtAEEkEd3
 8UeDf9jqqQU5v954lf50V9JL6MHwr5mTGKU1tm48v0XsnUlB09UkKuz28U2yE7sunA9e
 KM0HdPP9uVUjQfzUZQV0mBjVLuirybkAWWYvW9UpWjUMfEslPRUiUgTp0UIzge7647HR
 SD8HoGReKOuv4maNEX/5fUKcOnzdIXFMTnXNLksB7mzhdp4eU7QFlKE8kNh+/uyFJdo1
 K5nQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqy49vNSxUkUfszmgJF4KOK7diC0NpAnlT667sh57J+9ARjWs42mAM0wgA1C18kFSJ6BbN2qD1Kcc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lOKeBlnAUO2XQhuOIPyNAxdrpVv+ADiRMKJNJmun0fSmtYgId4
 KiAfvx8sUw3yX4VoyFetQVPNnHkywu9fSAagEuC1mEd1dVqVXlfRWRN+Ggvu/5NZQFs=
X-Gm-Gg: AYBFou2Zfiphxq8ydM6GBT/WHJczU8jIVXKqrWAvywTwLya+CnBtDFqN/d54k3CpnrS
 Lwmx4ywC7jv3xUtuuz8zDXW4A+cLqEbFC7HAMj4WQXf5Ihs8d6t8lX+0AKdk2ZZxJTOrXMGK+E0
 DKxR9rV5eJFf0zRKRF46qM5kKFRhOnEuCy97A3R15ekVRAPVB9YATx07YNZkSx9hfdEY7Slijpj
 nt8LnROKtQ2Tg2Wa/rZCYmLKlCsNb9XQCFmABkUiZw54xyvCX/cPWlucBkbxlHpuiQ7Tw5f3QlV
 UB0/lsCKvGve1XFTq3vwhe1us2g10GdKqeeD9zj0tA4PMEQCjmM/wg00zyBJvg+B1vwIQNfpXW/
 hxc4g3H+oxMWMGpTNVbXhh6gZCXt0rSgr6WyUOxWao4nlqsJm2b7XAeBSj5sM7S1zhgrv4Ak3nJ
 y03X9erxxMReivjHDoCg+AjGa6+LIePTtJUHL1wUGQcRLe5NIWsyKl6yV8VGVm+n5o/c2LV1REA
 Ipgz3wt+AiKiN9UDvwSxGQ3Mu8RTMaK4gFOrvBUHr9HUzy3Ml+eh66GKHd8ebIb/PDTb+I=
X-Received: by 2002:a05:7301:701:b0:341:b570:8d75 with SMTP id
 5a478bee46e88-34c6605302dmr1125938eec.14.1790730219815; 
 Tue, 29 Sep 2026 18:03:39 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c386c2723sm2179993eec.18.2026.09.29.18.03.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Sep 2026 18:03:38 -0700 (PDT)
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
Subject: [PATCH 6.6.y v2 1/2] drm/i915/hdcp: Add encoder check in
 intel_hdcp_get_capability
Date: Tue, 29 Sep 2026 21:03:20 -0400
Message-ID: <20260930010323.93999-2-artem@trailofbits.com>
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

[ Upstream commit 31b42af516afa1e184d1a9f9dd4096c54044269a ]

Sometimes during hotplug scenario or suspend/resume scenario encoder is
not always initialized when intel_hdcp_get_capability add
a check to avoid kernel null pointer dereference.

[ Backport to 6.6.y: this tree uses the older intel_hdcp_capable()
  helper name. Apply the same guard there; the code change is otherwise
  unchanged. ]

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-2-suraj.kandpal@intel.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
CVE: CVE-2024-53051
Upstream: 31b42af516afa1e184d1a9f9dd4096c54044269a
Code change unchanged from v1; only the retained backport note was added.
v1: https://lore.kernel.org/r/20260929031728.88004-1-artem@trailofbits.com

 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index f377c4484e18..f7987fb90bb1 100644
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
