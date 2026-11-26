Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F5606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VpSviocF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42F3112752;
	Thu, 26 Nov 2026 21:45:35 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95616112737
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:53 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so4677473f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729492; x=1796334292; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mLBiJ3Y98YIzDtQw/fAmF2XOq735TmDEhRo28kTS8fQ=;
 b=VpSviocFIXauwzwSBiUKqqFtrseMEvIQ6wN9F0wLZLr5rVAg3YqPG3H/FmtL3XL4kY
 5+PwACZJKWDK6ouNmZAt+WoKhKvVBg/5VKT4I630MNb8Y6L0RUov9JiMqxTQ1Rl7YpeM
 /TUlqynBRcyX07FlO74NK+Wb53VJUUDBlMKdWcTEucrPbPh7wdIrOQjEWBdcrzpHiZJY
 SDxYYK9AyDVHWPDgDqgled4xFzipbe2/3uYcN0SpdkiqT990qTOZ0pgxzcuhMSGH3CPY
 3V+gzfzCNCfKwX83RhWePNgrI58T3yNJlJiPZ02C3VwRiDysoyetTzrL7CyWJMtcDrq6
 uFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729492; x=1796334292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mLBiJ3Y98YIzDtQw/fAmF2XOq735TmDEhRo28kTS8fQ=;
 b=JPUjKZ6yJPwD7FrvwfOoyYD/ZZf+qIZg1LpRD1ETIvrOtv9DskgvMAAdKVPnDROuW7
 GwL5O6zi65I0JSkPwYmg3XEdkx/vc+iLEzj7FqVhub3ZuXTAV3+cLYe7A9RfM+ufV9vD
 KMCrZAzesCElYbo9sy+JtWFpXktI6VGZXLl40SQmS3ejbfQXwsw0VArCCFPFOha5qIUR
 hq7df0AnYg6OAYnIHLm/RIx5qOlWXIHy/5Eyn/8vgNz/8c1u+UUYfJGVt2gOhqzHmFAQ
 a2j1gP0lqriKQ7Rpecn0xUgNIJh227bKNFkRz3dlMnSNyn5br2XO1Zqm6RtUwbRAMot+
 Drhg==
X-Forwarded-Encrypted: i=1;
 AL+hErEH671uxwUJYG9akTgmrOo7mn3xZVmLImoUQ8Tf/AeM1dWjdI/O2bWpXr4IW56ssfI2Sz/iPX74bHU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/BlXG2n/Hh4joG5wDYAHoOY2968Z1ZbroBHI0g9Fa78NtU+OTT
 f1YjyucoB6WifZ9eYnfAJo5nVyqsK7IheD98jlHW+pfmWXCnQKtSCLOdLo69tw==
X-Gm-Gg: AZFdTZerTiqPaSvXmNbzLzsxBqm4TSRpPpZKdwtLeviqKB7CglEMHpPWtCd3GY4fYur
 AMZGnu45jWzr6gIb02g9smHfjmTV2kBw11xy2khCmRFaUOveV82lwLDsXrfVXuGGCIgji4PY9PD
 tCPqbczCYuEtJDUkWA+u7d99G84gJX4P6wvJJEC4Tqgnf5jztM6kx6BVxAXWFo2dEVrYHg0cMwp
 dRoNx0dSxqMgWXdnO+d2njGs35nc+WG24Rcqd/1Y/a3IJsgBIzzQUL51g6gQBQCignSYbqvJVpe
 v0joxCssKrEThWLQ48AHFp90ZHByvIS4AcgX6qzX65booJDJ8RnsQ49+M0Ww0LpC6uCT8+lZAEE
 EkrpZT7ryGyPnSIQPA2Who4TBSU/7S0wjz95acTjN4KqbX9tYaZlOMG1T7Ke8Hx716LQRVXfbyp
 Ngqlah5CJvJtVvsOJ/3mlI349PL3KTffX3dUxGOGus6a03YIYd7+/hax1P1MeXuLc8ngn68iXWq
 HDvCVzLBvmzSAszWDQcm2DF29PdqK7AQOOXknzerWEHXA36gyZ2E0PvAQhr4ryKlF1eRHpZS3mp
 QnAKKkCvuPj+8G+I5UrtYPnzV49Jg528lWaf6Ktb0d4nK9+TFWKRHhBBZsejGjTySD4aClB/CWS
 rZdKcJQ1bcD5+mhHfPIaPBwrj3/8DowV00kVRn5s5rBuSMb0sVAWBWhkA5Lg3PU8cALBg1Qmpnb
 2yuCFlDHIQ+bgJFUImnSEo7xhBJYt+ZZNOsFwwXSOBFzoL4RSVYvYS7ZCKw0oBDzIAuMQyct6MZ
 K4Ik9U+iCJ+6zF4664jVddp8elxixKcwJNV1TjAq5cDuOo4hCvgAUOINI9axx7p
X-Received: by 2002:a05:6000:2c05:b0:4a7:ed95:7c9f with SMTP id
 ffacd0b85a97d-4abb19c16a4mr44426780f8f.22.1795729491930; 
 Thu, 26 Nov 2026 13:44:51 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:51 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 jernej.skrabec@gmail.com, p.zabel@pengutronix.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] drm/sun4i: Add compatible for H616 display engine
Date: Thu, 26 Nov 2026 22:44:31 +0100
Message-ID: <20261126214433.3562326-10-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
References: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable H616 display engine pipeline by adding respective compatible.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 248be5ff4f36..18cd9a993348 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -442,6 +442,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun20i-d1-display-engine" },
 	{ .compatible = "allwinner,sun50i-a64-display-engine" },
 	{ .compatible = "allwinner,sun50i-h6-display-engine" },
+	{ .compatible = "allwinner,sun50i-h616-display-engine" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
-- 
2.43.0

