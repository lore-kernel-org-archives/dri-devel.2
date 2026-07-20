Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C7AC4452F
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A7010E121;
	Mon, 20 Jul 2026 19:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r7Z7Lk52";
	dkim-atps=neutral
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0367E10EA05
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 17:52:35 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-9696369925aso2749128241.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 10:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784569954; x=1785174754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M1GZajhqarMc4GuzpT0mLcFOMeIu7bIO6dEAnU4cRac=;
 b=r7Z7Lk52RhpdQnu3zwjSLyKhbJm5WTKV8uPBNjRBES0WzK5Xj/PmlYwXF++JiJ0bLD
 pgqmXjuNE8afk7tSRorfqgA4PufEZnCzcY2N/LNCsRzxBSSkw9B5F2TO3ZyCq9qZaLoZ
 liS2rxyCpfrShR6wFgWoX2oGa9iBWG2I6p8W1ljgW2lS9isgaa+2ZdvCyXDNvGFWLFHG
 BA8XlYTiyn44yYyUNHkfs7k89GGJCCunDcKXmkQqxMRhua6a84AZgnRkKGE8Y8nYD6xo
 yq2iC9M9greWvsgoWM4DVKc8/RHcHsmY11l0P82lNujCbvCmNODOw5zZKjPhHm5jrg1H
 ETNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569954; x=1785174754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M1GZajhqarMc4GuzpT0mLcFOMeIu7bIO6dEAnU4cRac=;
 b=tL1S/q74YjOFHm2WvzddJK+5RcUneOeXNFWpmP1OdHZe2uyv/cUbjddCv5WavgOhJu
 SI+L7Mw5c/vuqmYZWxl4LgOtwVI+RTsa0GZYa4BQf9uIl35kUO3uKnwuiylH77GGnAvo
 66AvrC7bbMqUeowJjoC24JmSdLM3yKHVbZJiapN7L3yMj/6TWsiPrnOdEEANwz4w5ruY
 TTxh8N47hrpn0mTa1fl0TJGi0RT5cGfn5VAYef3ARUFtkiYbV0HviVFbzGtFATTquvCx
 10kpnORKEi3VYqhHFP5phrcww/VWYfjKSOnk+rplizs7tisaZQI1wUAt4kkxlAot0bna
 Hngg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpN1wYrthH68qxQ+bYxU+cn9QXEb0RZ13vmeJBPmSxiTGbKnZWF2SKhOrUsRFvB9tyMiuzuSeXk28c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBH+pu+1txG6QvQzwHNr0dYw8HWaWVddOZfUaYpUxD0AL1oerL
 y5Z5gMEg+79A2qXKGqfrTZq0IX2zxojzqrThTstRbRBgqr8ziFawV6bt
X-Gm-Gg: AfdE7ckEDod/tXwsfTcV1hVGA/NgmjV8QjVUIyk8csnlloSdFRwQPNeng/acTwV9DMT
 iWnJ75zZqe4Y4cGDSm+WDqYteOHR6/+5YoZaQTryU784kdM/iz1ooisM9Q87EWeMQPXfDTdw16X
 6D9odNpvuPXQ1vJJYTuHy6KSCv4MOBs8wnaEBY7sSyXyre9dtszZmtyMma5hDCsqOccgCdhB34L
 7w/1EX/RK8yPGEK4hBJAtlnIRsmXmYRSdleLV1CH6vQjWqZDJrvvkl4PP/Js/8gQhwDpJMaZ5t2
 UcQFektA4Y3Reb+riQh63RBrD6KZLBennxs3SeVm8LEugJSg2isrS+fEgNuM1+0f0Y6t6m5bJZI
 Lg/HvHc69kPGgVubbRNoQicNzHoejHsLTM8awbQHEz6qaoKEJHp2kIvPU08XudNgBjQX2PNUvWt
 WGr4jOMy2ttQtAxOGtWg==
X-Received: by 2002:a05:6102:6446:b0:739:918a:16c5 with SMTP id
 ada2fe7eead31-747534c3d0fmr3288184137.3.1784569953534; 
 Mon, 20 Jul 2026 10:52:33 -0700 (PDT)
Received: from fedora ([67.230.148.25]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-74757c8048csm8999667137.0.2026.07.20.10.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:52:33 -0700 (PDT)
From: Thierry Cantin-Demers <thierrycantindemers@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Mika Kahola <mika.kahola@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Thierry Cantin-Demers <thierrycantindemers@gmail.com>
Subject: [PATCH v2] drm/i915/psr: Disable eDP Panel Replay on XPS 16 DA16260
 (LG 0x07C5)
Date: Mon, 20 Jul 2026 13:52:29 -0400
Message-ID: <20260720175229.11341-1-thierrycantindemers@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a036e63561333e3f36896ac0919feab509553bdc.camel@intel.com>
References: <a036e63561333e3f36896ac0919feab509553bdc.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 19:03:49 +0000
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

The Dell XPS 16 DA16260 ships in more than one panel variant. The existing
quirk that disables Panel Replay on this laptop (added to fix the low
refresh rate / stutter in issue #7682) only matches the LG Display panel
with DPCD sink OUI 00:22:b9.

Another unit of the same laptop (subsystem 1028:0dba) uses an LG Display
0x07C5 panel with sink OUI 00:aa:01. It shows the identical symptom: the
internal eDP panel updates at only ~5 fps while external displays stay
smooth, with Panel Replay Selective Update stuck (i915_psr_status cycling
SLEEP/SU_STANDBY, no error). Because the OUI differs the existing quirk
does not match and Panel Replay stays enabled.

Add a quirk entry for OUI 00:aa:01 so this variant also gets eDP Panel
Replay disabled. Confirmed xe.enable_panel_replay=0 and a kernel with
this quirk both resolve the stutter.

Fixes: cb8d155b0806 ("drm/i915/psr: Disable Panel Replay on Dell XPS 16 DA16260 as a quirk")
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7682
Signed-off-by: Thierry Cantin-Demers <thierrycantindemers@gmail.com>
Tested-by: Thierry Cantin-Demers <thierrycantindemers@gmail.com>
---
Hi Jouni,

Thanks for looking. After capturing full drm.debug=0xe logs I should
correct my original description: this does not appear to be a Link CRC
error. That was a one-off reading I have not been able to reproduce.

With Panel Replay enabled and the panel stuck at ~5 fps, i915_psr_status
just cycles SLEEP / SU_STANDBY with no error, and a full drm.debug dmesg
shows nothing. It really seems to be the same low refresh rate / stutter
you already handled in issue #7682:

  https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7682

My machine is the same laptop (XPS 16 DA16260, subsystem 1028:0dba) and
seems to reproduce in the same way, including with no external display
attached: applying a gamma LUT via wlr-gamma-control (I use gammad) early
in the session is enough to leave the panel stuck. The main difference
from #7682 is the panel: mine is an LG Display 0x07C5 with DPCD sink OUI
00:aa:01, so the quirk from cb8d155b0806 (which matches 00:22:b9) does not
cover it and Panel Replay stays enabled.

xe.enable_panel_replay=0 resolves it, and a kernel with the quirk
extended to 00:aa:01 does too. This v2 drops the CRC wording and
references #7682. Happy to test any alternative you prefer.

Rather than open a new ticket right away, I went back and captured proper
logs, and once the CRC description turned out to be wrong it looked like
the same problem as #7682 rather than a new one, so a one-line quirk
extension seemed like the least noisy way to handle it. If after this you
still think it is something different, just let me know and I will gladly
file a fresh gitlab ticket with the full logs.

Thanks a lot for your time,
Thierry

v1 -> v2:
 - Reword: describe as the #7682 low-refresh-rate stutter, not a CRC error
 - Add Link: to issue #7682

 drivers/gpu/drm/i915/display/intel_quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 33245f44c0d5..e452235832fe 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -286,6 +286,14 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
 		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
 		.hook = quirk_disable_edp_panel_replay,
 	},
+	/* Dell XPS 16 DA16260 (LG Display 0x07C5, OUI 00:aa:01) */
+	{
+		.device = DEVICE_ID_ANY,
+		.subsystem_vendor = 0x1028,
+		.subsystem_device = 0x0dba,
+		.sink_oui = SINK_OUI(0x00, 0xaa, 0x01),
+		.hook = quirk_disable_edp_panel_replay,
+	},
 };
 
 void intel_init_quirks(struct intel_display *display)
-- 
2.55.0

