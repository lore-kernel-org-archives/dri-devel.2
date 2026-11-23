Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A1606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wDi55APP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F9F710F00F;
	Mon, 23 Nov 2026 16:21:33 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145E110EFB4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:21:27 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso2650677f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795450885; x=1796055685; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CROCkTNrvr9SVl0fcyGZz0CF6h4ZrCTd+OGObZ46h0I=;
 b=wDi55APPFYQechVwDVcKsyXB/1nsBWPAfzJ4EH4SWFaWCKW+GfDS0t6JIG5LoxtShe
 tXQ7d64fOCYOsLt7YAGINS3N5JufEmj6lOe1bmXqT6HBXcUFtQ9xv4y/5hkhs9uacAFR
 3yfOApiN2/cccppS0iZY/VUHTlBE4ymlxWgEaH3UsY0CHg+FEhcQfzvob8q5Q+BdZTGj
 sDDFfAb9wHwpAJ6qkEQW3z+1apWr9993BZdN02Go1cqxbcEwbYnyelzoOi+d2uh5O0+N
 804+ZOuC8/oufkVnUn/bwS8F4mJmH1RmdKqvjCnMm5UNYR/rQOkAnfCD1VcaZ028Bh5N
 QlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450885; x=1796055685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CROCkTNrvr9SVl0fcyGZz0CF6h4ZrCTd+OGObZ46h0I=;
 b=thvXhQbBMd2TrExsw5qUV85xKKU/P91PpISPD2/ify63JBnPVW8K0Fw0CKJuYNReQu
 1aco39YgRZGJt9NW+b69MBqxoQuKky8mlBES+49ZjbgycVu/YcZvTNKvL83+Wk2HKyBl
 ucPEiq0ByOvZWXpFwGjAZGfwpy9UlZMoepOUbXZQ1RFLfFpsOcnLgfHvR5v/mze+GAYU
 X1In++OZnZ0BXhEVplxYdz54isL1c4Rb9gxxqqoVuxW6O0DR7F4+KbuxBhYmCY8fQvv8
 ev6wpS7Ve7tIW96lHeJuZ/nNYex4EyiaOf7mSpm3ryIZ9qdKp5abrbW3NgE7Y9R/dqmG
 QroA==
X-Gm-Message-State: APuU4Z8kSvj1Ffg09s0MXtJh6uJc1fvRjF7Wh4Sr/2SpGA98FZBbTlx7
 qmScL/tqmlcKwBru4S5awwllsK9rp517paptjC/dn3t/QyNOwW84eCeW
X-Gm-Gg: AZFdTZcZsvMcOJikpLtq/qO1F14krF0ShMz56H//Pm6FPtNyCIkSL0kgHPZm2YsE4BJ
 LO7skErl5CN+D4tRo0OR72SG0lYX8aX04ZVPfT/ZdgFyHvnJreTdOPjn1thGB4FupsrQ4Qp5uc1
 1GwVNc6KBpxNjNtbDu8ljHRmxLlU0iJa1HKObS26QyGPjYHk6g3Tn9e0zJG6+UvQglZHbSnHM81
 ynQ7ewti5o+XvJ0zxTq5HKOE4ZAtYiBXd7INrEhDAjLhERMoMh9w38uVG/XY60okB1MzPCAvDeH
 F6vt/DV55U+OoAhtyVf6kgBAc5UbwAot4DbuyGSQ3cIi4VIK3Lfj1aQSDUVASCRHB550FSaDvVi
 GWrJoy/ijE3h7voG9D4+OkI3Nu0xxqzQPcFPiqqrD6Yh+hjwuMoIqeac1gL2cyEls5ma1/nCT5h
 OzazvPmT3XsjscRp9Vuc7f1LhtIR+MZtKU7cVWjJJ1RQUAjB3wK3SgVXe4y8Sp/EPM6oCpb0RJW
 iOtLVNqw6km10a4Dr/F3eP5H4soss5X2UkF3Q16tDpkqJmCIfgp9gQUX262bxw1UGd6Od+4TBxI
 DtrE3ELb3mFidZDHBtOAiK6qLGsxvb+bNNFwTr4E
X-Received: by 2002:adf:e19b:0:b0:49e:f905:4698 with SMTP id
 ffacd0b85a97d-4abab6de682mr23267543f8f.2.1795450885341; 
 Mon, 23 Nov 2026 08:21:25 -0800 (PST)
Received: from [10.56.169.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110ba3sm18863696f8f.35.2026.11.23.08.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:21:24 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Mon, 23 Nov 2026 17:20:29 +0100
Subject: [PATCH RESEND 4/4] drm/ci: drop the kms_plane pixel-format xfails
 for vkms
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-lut-v1-4-5556c89a2ebd@gmail.com>
References: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
In-Reply-To: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Arthur Grillo <arthurgrillo@riseup.net>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Oarora Etimis <oaroraetimis@gmail.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kms_plane@pixel-format and pixel-format-source-clamping are listed as
Timeout in vkms-none-fails.txt. With the per-pixel interpolation they take
160.1-167.8 s and 78.9-83.8 s locally; with the precomputed LUT tables
they take 9.70-9.84 s and 4.87-4.90 s, so the entries no longer describe
the driver.

This patch depends on patch 2: removing the entries only helps once the
subtests stop timing out, so a job that takes this patch without patch 2
fails.

Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt b/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
index 029bd4956e85..6ebcc7d89fbd 100644
--- a/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
@@ -16,8 +16,6 @@ kms_flip@flip-vs-panning-vs-hang,Fail
 kms_flip@flip-vs-suspend,Fail
 kms_flip@flip-vs-suspend-interruptible,Fail
 kms_lease@lease-uevent,Fail
-kms_plane@pixel-format-source-clamping,Timeout
-kms_plane@pixel-format,Timeout
 kms_writeback@writeback-check-output,Fail
 kms_writeback@writeback-check-output-XRGB2101010,Fail
 kms_writeback@writeback-fb-id,Fail

-- 
2.56.1

