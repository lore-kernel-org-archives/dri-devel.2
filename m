Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EBB606A332
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guCjsCR1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1CD10E634;
	Sun, 22 Nov 2026 17:14:32 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0306910E212
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 09:09:54 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5bcdae234ecso2085262e87.3
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 01:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795252193; x=1795856993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lcNychyJRn+TkNQvLalB8mPDA3D518aYH3ytDiQAN8Y=;
 b=guCjsCR1p8t+wG6HlGy56TeX39t5Rht2yqKWacx10KXimAyZqSTERJ+7aQN098fFfs
 N0oy1E7u/XcawYJ6WprjdKEO4iY3PHa5fBEbK2TXpKS4sScc5VgtOHvu1IqDTnMk0vHh
 rpTtyood0Mou5tux4H2a44pSDaAr4jTLTpJRhQZsyXDtq6e01mFNqpRH8sPKgUKJa+RJ
 gyhKPoD3zWSo+UunPV75wXj6NTMVEJsVWTgSu0nDIt6w3+B6QpEWFNaw3dHXoYEABvi5
 RJBGiy16E7Bk51h5DGnf/GHNjYkCyz+AEAsZpvTSDt3yzNVWLYs9SR6aq1UCjdnSUI9o
 uSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795252193; x=1795856993;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lcNychyJRn+TkNQvLalB8mPDA3D518aYH3ytDiQAN8Y=;
 b=oNNcFsZtDjDnTvdWrYYoP9DnYh7wwrc5KZX07vrfH5EZpr40GXJg1SP3SxFmk+7kik
 DVUASA83PVpL5dRQgv19WkFTfYSh3kUl/uqkAUktYU51Ll+VVqJTGPJq9qynczOrQFB2
 HLmLzhacH9k096qgh7vYMxZicQoDo6KTnbk+KM/2zK3hf5grfv2+nwO/E4dYkjT7DeoE
 QCNj0r2v/PSAh+JKq+zSCE/8788YOdOUx2t+b74y3euaSqdHS0NFcuS7j7Re7koYAbeA
 KNgFJE/mAcEAJTypvFFhHB1oAKYDy44XK2tUzvIQBd2Vb0CmPpGzoR/hAbCkD3gJwwc5
 hcYw==
X-Gm-Message-State: APuU4Z/B2jTZg4ZA9AWmTkM3/tf5pWns9bFmD+O5juy1Dy39ozRhcGSw
 holwmu6bXXoIEGlfQGlEFzAnRyiBmeZqFlpg48pIFBWMju8F/EfOKHOkFex3IE/4PSY=
X-Gm-Gg: AZFdTZehcE4U8LiBTNfBMCThZZsIdLYPCvgQYspyeOZ/536jvAWw+6AB07iX7wjzrTW
 g6wThIS6ulRDVhpHS6WIkqPzqK5qF5n6M9WTrCbsWZ5kMHbKD8iyBYwS+WkkWyWNheIyGrYjocM
 9zf4Qkwdcl33DkbXz0C1r6J+YFIONdqTPhI1QxJZr8H54bWFwVuNCoizi8Wu+aoBJ4T4aUDFH0U
 Q3uo9NrhJy0ujcLSH1CgiPXaQhx3uiShR4bf7Bqbw1fNpEvLyP/6PIzHzUX3C4wtq+6Paq/adcN
 ihufaZWlf+3q86kBm/EZmEYCvRJ9vjM26jyjmaUC0aJj9djyeGUwJr6MqbE1XHObRCV+XcJZCwB
 /YxXcBNmRQXgEsAbapq9aN+nx1oAth4oAWf+dFydriXUzvC1oxFAOvbT9qHZY0N6SZcpKjhQf6M
 NLCDtvMAsDtTPtOkmb71pCehJBpsgfMYF+7lmRmvNzqaMqjfVtkTmmmlWWBNO8FVddQ16vLGdNV
 p/wNOs8gyKlbLCQAWPN///AOTGVtN2IlLnjrhq1AeIsgJ6LOQGkmYlYrRQzt3VWuXgwgMmqFsJ3
 UyOnIyaB9+Yk41E0x4QE2AAQ8AiT
X-Received: by 2002:a05:6512:23a9:b0:5c0:c5e:3cf with SMTP id
 2adb3069b0e04-5c1bc7d072bmr1515520e87.25.1795252192669; 
 Sat, 21 Nov 2026 01:09:52 -0800 (PST)
Received: from localhost ([2a01:799:ca8:9900:6399:b7a1:82e6:2b58])
 by smtp.gmail.com with UTF8SMTPSA id
 2adb3069b0e04-5c1bd041813sm1230381e87.53.2026.11.21.01.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Nov 2026 01:09:52 -0800 (PST)
From: =?UTF-8?q?Petter=20Skjelsb=C3=A6k?= <skjelsbaek@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: ankit.k.nautiyal@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, skjelsbaek@gmail.com
Subject: [RFC PATCH] drm/dp: allow dual-link clock for 30-inch Apple Cinema HD
Date: Sat, 21 Nov 2026 10:09:49 +0100
Message-ID: <20261121090949.12290-1-skjelsbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 30-inch Apple Cinema HD Display (APP 0x9221) advertises its
native 2560x1600 mode at 59.86 Hz with a 268 MHz pixel clock.
Its EDID also identifies the digital interface as DVI Dual Link
High Resolution.

When connected using Apple's active Mini DisplayPort to Dual-Link
DVI adapter, the adapter is detected as a DisplayPort branch with
a DVI downstream port. It does not provide detailed downstream
capability information, so drm_dp_downstream_max_tmds_clock()
falls back to 165 MHz.

This causes the native 268 MHz mode to be rejected, leaving only
1280x800 at 71 MHz available.

Allow a 300 MHz TMDS clock for this display so that its native
2560x1600 mode is exposed.

An earlier version of this workaround was tested successfully
with an Intel Arc B580 using the xe driver and Apple's active
Mini DisplayPort to Dual-Link DVI adapter on Linux 7.0.11 and
7.2.6. The revised capability check has not yet been runtime-tested.

This is intended as an RFC since the underlying limitation is the
active dual-link DVI adapter, while this workaround identifies
the attached display by EDID. A more generic way of identifying
dual-link capable downstream DVI adapters may be preferable.

Signed-off-by: Petter Skjelsbæk <skjelsbaek@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e623ccb4c1d8..ec36fa88b0ca 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1388,8 +1388,15 @@ int drm_dp_downstream_max_tmds_clock(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 			return 300000;
 		return port_cap[1] * 2500;
 	case DP_DS_PORT_TYPE_DVI:
-		if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE) == 0)
+		if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] &
+		     DP_DETAILED_CAP_INFO_AVAILABLE) == 0) {
+			if (drm_edid &&
+			    drm_edid_get_panel_id(drm_edid) ==
+			    drm_edid_encode_panel_id('A', 'P', 'P', 0x9221))
+				return 300000;
 			return 165000;
+		}
+
 		/* FIXME what to do about DVI dual link? */
 		return port_cap[1] * 2500;
 	default:
-- 
2.43.0

