Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB1606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sxPlidgr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0B810E038;
	Sat, 24 Oct 2026 14:52:38 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E37B10E038
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 14:52:31 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so13844f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792853550; x=1793458350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=57cgpKzuG8iviQVEnNlM9P5mTIL8ivtwm96zaTpUOVU=;
 b=sxPlidgr9CcU5BJ8i0SPg3JNepxaMJDIurFQU4Kvp6tnjyKy8N6SltjCx8p0PnDrfJ
 syd1VyawkcIocPn9bBld9UVwxwTj7l1Xmw4rXcO4ZYnnILO7TnNeNurfcQJi6swI/Wbh
 zrr1zDi9TCQXGRA2cot8udNbN45vdcJClQH0B4wa0Q3gifa1PsWBdvFJ+hQl7/ra28XK
 tivzPLXpbw+IfuX3HepMv7MjYY4npht+QDpH5V8sRJBdqs91Aqo9fzlWeDmOQARjgz3c
 ajAskjq1ke1Zzz/gV/k32aVWmpQgCr6gYvwgI2T52ZvTfI4/KaHAOVufN2HSxS6HCxBd
 uyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792853550; x=1793458350;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=57cgpKzuG8iviQVEnNlM9P5mTIL8ivtwm96zaTpUOVU=;
 b=ACqWYftyMXNbjEYOWSIqJW0FWsWi+fmwZnTA+VBU3l72csZxY2fycL4fINnKwpr87t
 k0Q11AU5O+XU9d9Y3xHKV5cSPzVebaQxQ8Cvxyta87RlDQ1nG42aspGQSPxyGC+O3kU7
 umM9Ta1y200gkkleVFhGvwW3hY10UcT5V2nyCp/nudOrQmgRoX+XJgvMAa/NWjGV2Syi
 eR9CkqsVxrTIPW3dH5dNmVx0IQGQ07g//yf1DGixYtiO1DrRjxLahuborGs3x5OZR6BH
 UiMTsHfz/FLogArX7oM3E9RmXJZIspZPlHqinxoiRBGFo3oz12MkmBsGE7bVkF/qJ7e+
 Pxvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzu4xTWR40dm68GXsPvI6oLDGtECgAbTmOU347ll5y2tb3CS2aMfiPwgIag8PRnove4Tff4NcS5kww=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJorEZYBL8npjcttNAtHff8asj5Fwcz9PvNco4i8bgPYzhnpi37
 b1DXHE8ghF9nXzQIaJCzZ+rhwOq9OwCTNRw5j5jsHPr0lsncacdE1p3r
X-Gm-Gg: AYBFou2XarvoBxT5dv0hyQz+PlgjvrVljsQE/vjZIKRgtfLwdnxq0Ou+TkxmX6QM0DO
 WLwh5Kyv9uuMR1YLgSRRA8svmEsPQRY6S/do/V5Jn71Z0J9SAXNMMPFjBJbDbT2vjnhjWfX1ZPx
 na12IgxBzLDCnGxW832eYHhunHpAceOHQS56onEXkbHV6bVJD6kNY09kOS1PpP8kDpDsk2xaOAo
 1LjOjZKEQqqNp9tHpjT6dd32W6h5mdwedRow7ijEYFYNSLYJVOjjS/cmToq84MyZ2vLESJbYOwW
 sHB/nbfHnCoy9eVALHlbjfQGFV8NwslZeEhvUTRqVXFVCh+/d6G833tHAtRL7mVTyIxQODvX9Sy
 1A/w73WsC0tM//0SToRpbou8wCdaFpzYgF8ZVvB/HXPx5NEOThkJllS75Wl44Pj+VxyxdrBeVqD
 c2+BOkc/i5CRgCEtzNc3sc8aQd6VGQv95pNR0CbdbqpAKrz3BgJdEYO43fwbg4UemYitSWjj50p
 7FNrUP34Ne1gDcU83qrzPbMHInMqB3hhNA+9FlYLmsXm8MyclGuUw==
X-Received: by 2002:a05:6000:41cd:b0:48d:f36e:ccc0 with SMTP id
 ffacd0b85a97d-48e3eab5794mr3799228f8f.0.1792853549728; 
 Sat, 24 Oct 2026 07:52:29 -0700 (PDT)
Received: from localhost ([5.83.201.131]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f248sm4620940f8f.6.2026.10.24.07.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 07:52:29 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sti: hdmi: make char * const array en_di static const
Date: Sat, 24 Oct 2026 15:52:27 +0100
Message-ID: <20261024145227.1193775-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Don't populate the read-only const array en_di on the stack at run
time, instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 7ba9e0b7ba6c..63418732daaa 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -647,10 +647,12 @@ static void hdmi_dbg_sta(struct seq_file *s, int val)
 static void hdmi_dbg_sw_di_cfg(struct seq_file *s, int val)
 {
 	int tmp;
-	char *const en_di[] = {"no transmission",
-			       "single transmission",
-			       "once every field",
-			       "once every frame"};
+	static const char *const en_di[] = {
+		"no transmission",
+		"single transmission",
+		"once every field",
+		"once every frame"
+	};
 
 	seq_putc(s, '\t');
 	tmp = (val & HDMI_IFRAME_CFG_DI_N(HDMI_IFRAME_MASK, 1));
-- 
2.55.0

