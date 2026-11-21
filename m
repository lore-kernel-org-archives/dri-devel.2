Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A55960A2601
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=JQ5xsOso
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2E6112DAC;
	Sat, 21 Nov 2026 01:35:53 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D7A110E941;
 Sat, 21 Nov 2026 01:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795224941; bh=MvL3i9Pcc7QeOxJyQrdtBh0s5MkIKId5E2Butgkn1hM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JQ5xsOsoiQzalD2vGgO0CqHFemhbLXQx4nSJ+SdirMW3Bbiy6oUoscf5GPJHjdZEH
 6wPPW9Y8fMz8StXXCuKmdZzqxceX7hsARMYxl2KokizXlLzwt1nooMnefntLCYl53Y
 GxH/IQWwnCHLl+hBpc5wU+/tpfETh3IBdpw4fuwc=
Received: from ThinkPad-T14 ([42.80.74.187])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 8E0AE630; Sat, 21 Nov 2026 09:35:32 +0800
X-QQ-mid: xmsmtpt1795224938t5ks8mmuf
Message-ID: <tencent_4B4D5022969E4FEF24BDDD2C4993D2D39709@qq.com>
X-QQ-XMAILINFO: M4wVjRC01ue0/AHpbyu2eNkFXz8Sx78ACEE1OAaecdwwe48M7ECD/AoI7Ekt0e
 A6hnuskQAup7PTvYIwG0mW7066reCYBgzRmlglfQw0tkCqwUuupEcpjsFJRcO8Q9Hac9RAFfzTx5
 g3KVUN+uEJoi7BX7XngrjdanNTEF/D5iAdFOy3JbLqWfB29I/BLKtB7Ls1gFrWgzJJmFAsj+7e4z
 dKf7/lWgPpylonAo1uS4PIBlPw5EY2XoW7DDH3Yh+MbORw7KGxLHH1gulQjmRB/22cPaYnFNZ2HH
 Tl99g4RO3C1zo/jqnBPLHI0NnOIdEVf+Emk57UM44tDuP7HFKEBowh0dWjQmq5JmjvS8cI92iPs7
 LezquSlqQ8E7qTlV9exlIqRsxMob/f3c1jZ2VjSZsf9V/jMvG1zmHoXZRRnQTomzVhRd7HczqKPe
 eRGWHtJ/OhjZK0nCmdy9eOrf6J6WefIY6VR954yCDZgU4uPk5YmcALqvkS+iyLHQmlF/LI71H+qW
 KCcmqgkJGiwnwx3FTETVrFZw4ZFz5rXGMO/dtKcga9OGSkRK6Y/F2jUY45rUx5QHh9R63Qth2Hqj
 CMOnHZfvzo34HJ/D52XRLCNeEfxVXzEQBuaaCL62rjlAwEJ3mLogYC8J4/X8QtPlN6KopSk6ZbC+
 pskdFCZ29rtAQdzIpOGQlsH/UGnnPYDxVd6GopebU5SBpWFoHUOG42bDPsT/Kve4dOFKFEqwugkJ
 kE6nCMqX5mwYQpj0FS/Mvso+5IU3+B5F1VCrlAY62+hUFemABCCk33ZtH9xOCE8WSdOua9wQogWf
 Jjs95pnAYDFdci9HhyuHS+MJCORLttE1kiGY7IHsJ6+xNj8ygMsgchOZc/9rwcJ/hjdoVJ+rC8DD
 5p95O6bac2GgKHVKX3sM9Xb4rW08iA4bugxMOf9juNxiu3/4FA3OTgdMZ2N4l0eVvLd8z3UfGSm6
 031d8LBwc31+0qI2fTj1JdCAs7Fk6dJFSCByP6jlput1CfPo1Hj0n0LQyCdo4lHxEPn9QUhyxuz0
 DljU4sF6tk6T4VN+RvVOg4S2zJVsgfkz0L/9t2vH1IQ7rd3ITV8Nkn3RPFYp5r3SKj5JO5xWiRCP
 0LE4IAdxXXdwoQxOBv1cnRBlxMeFHwaTRvL+4F
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v4 4/4] drm/i915/dp: Always write the HDR content luminance
Date: Sat, 21 Nov 2026 09:35:32 +0800
X-OQ-MSGID: <20261121013532.21135-5-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121013532.21135-1-fighters390@qq.com>
References: <20261121013532.21135-1-fighters390@qq.com>
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

intel_dp_aux_write_content_luminance() skips the DPCD write when the
encoder cannot send a gamut metadata SDP. That is backwards: the DPCD
register is what the AUX HDR interface uses on those platforms.

Drop the check instead of inverting it. INTEL_EDP_HDR_TCON_SDP_OVERRIDE_AUX
already tells the TCON whether to use the SDP or the DPCD value, so the
write is harmless where the SDP takes precedence.

Signed-off-by: Yitian Shao <fighters390@qq.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 8c7fd99..6b33ba0 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -250,9 +250,6 @@ intel_dp_aux_write_content_luminance(struct intel_connector *connector,
 	int ret;
 	u8 buf[4];
 
-	if (!intel_dp_has_gamut_metadata_dip(connector->encoder))
-		return;
-
 	buf[0] = hdr_metadata->hdmi_metadata_type1.max_cll & 0xFF;
 	buf[1] = (hdr_metadata->hdmi_metadata_type1.max_cll & 0xFF00) >> 8;
 	buf[2] = hdr_metadata->hdmi_metadata_type1.max_fall & 0xFF;
-- 
2.53.0

