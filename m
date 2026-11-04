Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DD606A33C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VCI4+e4M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2290210ECA8;
	Wed,  4 Nov 2026 08:58:05 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC4610E837
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:21:23 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2e95bd1c14cso2843555ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793776883; x=1794381683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DWUgScfm6w4+IrfkuhBQdFNaFEhNCbHPUn0mlOI8xXo=;
 b=VCI4+e4MZIuQCFTvvSE8FfNYQy7sN9MR4cDlyvPEc9mXz5PscxL7RrzijcgZcKWRAu
 6YGUcu1qIUnfXa64uZ0VUqe1EFLB/qeUw1i28MBm7DIJ6FgvZA1kjpOg5o6Lu3NVdygU
 NVHdOWlLGbPwxyChhzZgZ/ztAFZ62Mn1eltHFaqnYVMh4/QSV0RYoqJPEbQREOn1naCx
 OwppammvQcnL53/EKt9WXR2VEnHZAiCaOPDhNkVMVgH8+lzPDUXcUxiw0OT+CwnBs4g2
 veURZN+W9ChVpib0w9GHHOBY/h/2PgJBumHT6rV9AhYAkOazJD546xEp3QZc5fD2u6tx
 O0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776883; x=1794381683;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DWUgScfm6w4+IrfkuhBQdFNaFEhNCbHPUn0mlOI8xXo=;
 b=Li5jrJZUxet9SffkL4Y4WE/SJeM72BBUSKoG+2uzxKwJJWQawj3kGksdjJUosh75Kl
 TbFkPa/tmX7M6isl4WcYIUrLvoUwga6F37Cr6KIBPvl6Gi5W2Hgk9ByEMektF2J4nYWV
 V1iQ0oxR3AFiyAhf8OBxfO6ykg/Gf6Wy9nWKxzJnEA4PkemAHTAmZCQN94wcJbVC+xyB
 90VN1eFBpVvCW/POfQWS2W3nNEN0XwV7L+1UVd91cnxxzpjvI+WU7lCNbU5OFTSWNTzE
 bxdfWAe3hZK+GTv5MtM3qZ9S6KPn6oHX8/fHYQSUItyUB1hLEGO/pQ9QNv+IZ9bu2hnt
 BV1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhiUsR1ows/TbhXPPKoXOKxMWoeGPyaGmIPlln5QHvlFrKTxB9N9iwVqUCBWf+jBSpoD6iOyn3mVk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/LJVxUVlKrGtiSx7+Be0a6XiL20YwK6wQaSk7opacr1QbdAaOz
 b/0oH02sCCNt8z23u2fGv8eY/wmyEp5luyKeeqYq7VEJGrtJUx9SmJ0=
X-Gm-Gg: AYBFou1kz6gN/bBiHP9bKVumiH/7zEu1uKYzl2PdtGam7q2R6iNfVvjH1VSRpy3q31g
 1eluDbjfuEReck68kdVKo0EghuPgQM5aS8guk1ytVygAwVv7IMYBmZxezpI7YS5aoRua1TKKGLs
 bacZqno34lNmck48C2b3xrEH7adwsbMvpMZzQ86Gs6oTJc+zmq0mf4fgjkTPG96el0UxFWUIIvn
 KiHjxys6VVePQ/TwcKbBP40pSKOfLXX+aRtWPfM6VN4X7TRmNVgxYQekULE9r8gusK2m8f1J4+C
 Jf2C3P1m/dOb6IgPjiqorERC2q8v+ybHiEKEjvtG6fnogdM4X+rc+PrK4NEIrhIxq6etsy5xI7o
 H1UudfnvByLYvxDQ91CuDHN+6bw3IUX5387//jLu2BhtwZrOThcUZddMXmvXb7bgJEwY5J6rL01
 ZnZR5jaYO92/6TiVskPCSziMO3qJt1wDqtii7SjDPYYiSqTUW+GxOpVD3qhTaI+XwNTP3Krur5F
 h71r1vEjNkwnaewch+1UZR/63lGp0rkYskgx/Rz/VascG8fyfwabcv35NjnC2yEhV3awnBSUHbJ
 J1JEAgf+SBjI7EgRM1XNmnB4uq4HgGK7jxbYlPpeYWzt/b2aX0al/0Z3GWmuPXLqVoJd
X-Received: by 2002:a17:902:d2cd:b0:2e9:5b4e:b8a7 with SMTP id
 d9443c01a7336-2eb364f8fe2mr149925825ad.51.1793776882756; 
 Tue, 03 Nov 2026 23:21:22 -0800 (PST)
Received: from freddie-kane.lan ([71.212.222.246])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed0906c514sm3950345ad.29.2026.11.03.23.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:21:22 -0800 (PST)
From: Burke Cates <burke.cates@gmail.com>
To: robin.clark@oss.qualcomm.com,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [PATCH] drm/msm/dp: skip the link teardown after a failed enable
Date: Tue,  3 Nov 2026 23:20:48 -0800
Message-ID: <20261104072048.3486286-1-burke.cates@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 1bda647ce61b ("drm/msm/dp: move link-level teardown from
display_disable to display_unprepare") moved msm_dp_ctrl_off_link() and
the PHY exit into msm_dp_display_unprepare(). Unlike
msm_dp_display_disable(), that function does not check power_on.

When link training fails, msm_dp_ctrl_on_link() has already turned the
link clocks and the PHY off, and .atomic_enable() returns with power_on
still false. The next disable now runs msm_dp_ctrl_off_link() anyway,
which writes REG_DP_MAINLINK_CTRL and pulses DP_SW_RESET with the link
clocks off. On an ASUS Zenbook A16 (Glymur, eDP) the SoC then resets.

Skip the link teardown when power_on is false, as before that commit,
but still drop the runtime PM reference.

Tested on the A16 by forcing link training to fail and then blanking
the display: the SoC reset 2/2 times without this patch and 0/3 with
it.

Fixes: 1bda647ce61b ("drm/msm/dp: move link-level teardown from display_disable to display_unprepare")
Signed-off-by: Burke Cates <burke.cates@gmail.com>
---

Notes:
    Test base: v7.4-rc1 with out-of-tree Glymur platform, board and eDP
    PHY patches; drivers/gpu/drm/msm/dp as in v7.4-rc1 plus a local
    knob that fails every training attempt. The reset is silent (no
    pstore), so which of the two accesses triggers it is not known.
    
    As before 1bda647ce61b, a failure after successful training still
    leaves the link up. Xilin Wu's hdr10 v2 09/20 handles these paths
    more generally; this is the minimal fix for -rc. Happy to test his
    approach instead.
    https://lore.kernel.org/all/20261009-msm-dp-hdr10-v2-9-1835d4966da3@radxa.com/
    
    The bug was found and this patch drafted with an AI coding
    assistant (Claude Code, Claude Opus 5.5); I reviewed it and ran the
    tests.

 drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9299ce616fdb..76784cc45228 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1528,6 +1528,14 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
+	/*
+	 * Failed link training leaves the link clocks off. Avoid accessing
+	 * link registers after a failed enable, but still release the
+	 * runtime-PM reference below.
+	 */
+	if (!msm_dp_display->power_on)
+		goto out;
+
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
@@ -1542,6 +1550,7 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 
 	msm_dp_display->power_on = false;
 
+out:
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.54.0

