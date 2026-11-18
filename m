Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2554606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8BA910FC68;
	Wed, 18 Nov 2026 13:47:08 +0000 (UTC)
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A4410F77B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:47:49 +0000 (UTC)
Received: by mail-dy2-f4.google.com with SMTP id
 5a478bee46e88-36f2f262b19so270498eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794995268; x=1795600068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KM7bxNDm4tFHwlDQNyh8RZa9Lttc4laoB3Fany5rano=;
 b=tnSpkTvHJZqr7N9n/gYQkXqIOBTGAwdIOXpsgMFlFPY/9yT0stkOKvn8SRB6ePPlSf
 y8iDmS5KXOYSFwbeDpGvhTNIZcxeMt1SgC9J0+YiAfitkq8hKdL3DqiyzbXuwNA+ZDrf
 EWvXYbtNa72+IZFj9V4SFoL9t+hpXM7GeBaAPYUJOOAFaI7A9ZQ2aoDuFF99dpR17L5i
 plEfyZ34CAwwN15vGkqja0OZwq0s3BI4NC6QaK7XRi5IQBiyKBiFdgiXCm3+GyBTofNW
 T3OHqY6U/Y7dzZCxVZfsOyq36PxnqGmm4WzIbtGxfdXYYI/e8jFhK50190BZMKKgAfNA
 StWg==
X-Gm-Message-State: APuU4Z8fzCLSemQ1EaDsI8aNBwFzHsmeFtkNi8zts6C30ImTxvq6RJvY
 2L6yWi2cPueIOe2ZO2ctemP2eLjmaXwo05UumvLTYVrMOd+/KHmuvp0w
X-Gm-Gg: AYBFou1HpDCoJfPHD+chAj8ouMxGlDwR4dGUpLa+A142scy3KD219toIoC1EwLNjSvY
 VQeyPN/Y9XH+6YhwECGrfjIi0OTvZCYaIXWzHznJKCwBusXNTa3Z0oc3Jj/hK6dlfQfJZBM8Jog
 5yp0V0fFY51XKaHQ4LHmPkb1UbjxH68t1S+FEgKE5n1WTYcv87HwXcluZeyUvJKwlphU0JXYR+m
 lRZM7dBBugzxcEV0tx+7P+Q2wR2tRLMOd4F2BVkAo8hP9HcbhPl6CdohHjKZRUFrzpTRKN7qTOH
 l/rqLey1tkLWCHUN2uaoO8W79orPECAp7guv239Z2YuaxwKv07GTcotycnRyRNho+COAUgLbEBk
 55cwhXLFUpAmneIxtm8/qa00FLO5OqvGrYhinV4HJrt28Yio9yODGHVHILV/juicb+NMEqS2NAb
 KAPqhdMJNxtsGe69CO4rI5GMYnM1O6d28MoJLqxDJitkK8j+qvRiKnauYHK3tN/vayArhn3be0E
 z40EKpgDMTQaov1FULafXNQ3VE6BBasBoKbNUNrFxw3hgzZFkZ9B/CHEZy4RMjqTXqaPRjgpuY/
 lRt1fmAiz0H2Xqor6VrKBXZV2BTIkWepvx2n0Ai6kwD549s=
X-Received: by 2002:a05:701b:21d3:10b0:1b4:fa58:9d3 with SMTP id
 a92af1059eb24-1b543cebc62mr2083348c88.24.1794995268266; 
 Wed, 18 Nov 2026 01:47:48 -0800 (PST)
Received: from pjhArchLinux ([199.102.217.182])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784017sm5326510c88.4.2026.11.18.01.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 01:47:47 -0800 (PST)
From: pjh456 <147148383@qq.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 3/3] drm/panel: ilitek-ili9881c: add Industio Purple Pi OH
 panel
Date: Wed, 18 Nov 2026 17:47:20 +0800
Message-ID: <20261118094720.110127-4-147148383@qq.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118094720.110127-1-147148383@qq.com>
References: <20261118094720.110127-1-147148383@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the 7-inch 800x1280 MIPI-DSI panel found on the Industio
Purple Pi OH (RK3566).  It is a 4-lane ILI9881C panel whose
initialisation sequence was taken from the vendor device tree.  The
module is marked ZC-700010BH and the vendor DTB only describes it as a
generic "simple-panel-dsi", so the init sequence is its only
provenance.

The existing am8001280g entry (another 7-inch 800x1280 ILI9881C panel)
was tested on this hardware and only lights the backlight without a
picture, so a dedicated entry with the vendor sequence is required.

The panel is reset through GPIO0_D6 and its backlight is driven by
PWM4.

Signed-off-by: pjh456 <147148383@qq.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 222 ++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 7bf38e96678a..5f1270d78082 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -1424,6 +1424,201 @@ static const struct ili9881c_instr am8001280g_init[] = {
 	ILI9881C_COMMAND_INSTR(MIPI_DCS_WRITE_POWER_SAVE, 0x00),
 };
 
+static const struct ili9881c_instr ppoh_init[] = {
+	ILI9881C_SWITCH_PAGE_INSTR(0x03),
+	ILI9881C_COMMAND_INSTR(0x01, 0x00),
+	ILI9881C_COMMAND_INSTR(0x02, 0x00),
+	ILI9881C_COMMAND_INSTR(0x03, 0x73),
+	ILI9881C_COMMAND_INSTR(0x04, 0x13),
+	ILI9881C_COMMAND_INSTR(0x05, 0x00),
+	ILI9881C_COMMAND_INSTR(0x06, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x07, 0x05),
+	ILI9881C_COMMAND_INSTR(0x08, 0x00),
+	ILI9881C_COMMAND_INSTR(0x09, 0x28),
+	ILI9881C_COMMAND_INSTR(0x0a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0d, 0x28),
+	ILI9881C_COMMAND_INSTR(0x0e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0f, 0x28),
+	ILI9881C_COMMAND_INSTR(0x10, 0x28),
+	ILI9881C_COMMAND_INSTR(0x11, 0x00),
+	ILI9881C_COMMAND_INSTR(0x12, 0x00),
+	ILI9881C_COMMAND_INSTR(0x13, 0x00),
+	ILI9881C_COMMAND_INSTR(0x14, 0x00),
+	ILI9881C_COMMAND_INSTR(0x15, 0x00),
+	ILI9881C_COMMAND_INSTR(0x16, 0x00),
+	ILI9881C_COMMAND_INSTR(0x17, 0x00),
+	ILI9881C_COMMAND_INSTR(0x18, 0x00),
+	ILI9881C_COMMAND_INSTR(0x19, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1e, 0x40),
+	ILI9881C_COMMAND_INSTR(0x1f, 0x80),
+	ILI9881C_COMMAND_INSTR(0x20, 0x06),
+	ILI9881C_COMMAND_INSTR(0x21, 0x01),
+	ILI9881C_COMMAND_INSTR(0x22, 0x00),
+	ILI9881C_COMMAND_INSTR(0x23, 0x00),
+	ILI9881C_COMMAND_INSTR(0x24, 0x00),
+	ILI9881C_COMMAND_INSTR(0x25, 0x00),
+	ILI9881C_COMMAND_INSTR(0x26, 0x00),
+	ILI9881C_COMMAND_INSTR(0x27, 0x00),
+	ILI9881C_COMMAND_INSTR(0x28, 0x33),
+	ILI9881C_COMMAND_INSTR(0x29, 0x33),
+	ILI9881C_COMMAND_INSTR(0x2a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2c, 0x04),
+	ILI9881C_COMMAND_INSTR(0x2d, 0x04),
+	ILI9881C_COMMAND_INSTR(0x2e, 0x05),
+	ILI9881C_COMMAND_INSTR(0x2f, 0x05),
+	ILI9881C_COMMAND_INSTR(0x30, 0x00),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x32, 0x31),
+	ILI9881C_COMMAND_INSTR(0x33, 0x00),
+	ILI9881C_COMMAND_INSTR(0x34, 0x00),
+	ILI9881C_COMMAND_INSTR(0x35, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x36, 0x00),
+	ILI9881C_COMMAND_INSTR(0x37, 0x08),
+	ILI9881C_COMMAND_INSTR(0x38, 0x00),
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x40, 0x00),
+	ILI9881C_COMMAND_INSTR(0x41, 0x00),
+	ILI9881C_COMMAND_INSTR(0x42, 0x00),
+	ILI9881C_COMMAND_INSTR(0x43, 0x08),
+	ILI9881C_COMMAND_INSTR(0x44, 0x00),
+	ILI9881C_COMMAND_INSTR(0x50, 0x01),
+	ILI9881C_COMMAND_INSTR(0x51, 0x23),
+	ILI9881C_COMMAND_INSTR(0x52, 0x44),
+	ILI9881C_COMMAND_INSTR(0x53, 0x67),
+	ILI9881C_COMMAND_INSTR(0x54, 0x89),
+	ILI9881C_COMMAND_INSTR(0x55, 0xab),
+	ILI9881C_COMMAND_INSTR(0x56, 0x01),
+	ILI9881C_COMMAND_INSTR(0x57, 0x23),
+	ILI9881C_COMMAND_INSTR(0x58, 0x45),
+	ILI9881C_COMMAND_INSTR(0x59, 0x67),
+	ILI9881C_COMMAND_INSTR(0x5a, 0x89),
+	ILI9881C_COMMAND_INSTR(0x5b, 0xab),
+	ILI9881C_COMMAND_INSTR(0x5c, 0xcd),
+	ILI9881C_COMMAND_INSTR(0x5d, 0xef),
+	ILI9881C_COMMAND_INSTR(0x5e, 0x11),
+	ILI9881C_COMMAND_INSTR(0x5f, 0x02),
+	ILI9881C_COMMAND_INSTR(0x60, 0x08),
+	ILI9881C_COMMAND_INSTR(0x61, 0x0e),
+	ILI9881C_COMMAND_INSTR(0x62, 0x0f),
+	ILI9881C_COMMAND_INSTR(0x63, 0x0c),
+	ILI9881C_COMMAND_INSTR(0x64, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x65, 0x17),
+	ILI9881C_COMMAND_INSTR(0x66, 0x01),
+	ILI9881C_COMMAND_INSTR(0x67, 0x01),
+	ILI9881C_COMMAND_INSTR(0x68, 0x02),
+	ILI9881C_COMMAND_INSTR(0x69, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x6b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x6c, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6d, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6e, 0x16),
+	ILI9881C_COMMAND_INSTR(0x6f, 0x16),
+	ILI9881C_COMMAND_INSTR(0x70, 0x06),
+	ILI9881C_COMMAND_INSTR(0x71, 0x06),
+	ILI9881C_COMMAND_INSTR(0x72, 0x07),
+	ILI9881C_COMMAND_INSTR(0x73, 0x07),
+	ILI9881C_COMMAND_INSTR(0x74, 0x02),
+	ILI9881C_COMMAND_INSTR(0x75, 0x02),
+	ILI9881C_COMMAND_INSTR(0x76, 0x08),
+	ILI9881C_COMMAND_INSTR(0x77, 0x0e),
+	ILI9881C_COMMAND_INSTR(0x78, 0x0f),
+	ILI9881C_COMMAND_INSTR(0x79, 0x0c),
+	ILI9881C_COMMAND_INSTR(0x7a, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x7b, 0x17),
+	ILI9881C_COMMAND_INSTR(0x7c, 0x01),
+	ILI9881C_COMMAND_INSTR(0x7d, 0x01),
+	ILI9881C_COMMAND_INSTR(0x7e, 0x02),
+	ILI9881C_COMMAND_INSTR(0x7f, 0x02),
+	ILI9881C_COMMAND_INSTR(0x80, 0x00),
+	ILI9881C_COMMAND_INSTR(0x81, 0x00),
+	ILI9881C_COMMAND_INSTR(0x82, 0x02),
+	ILI9881C_COMMAND_INSTR(0x83, 0x02),
+	ILI9881C_COMMAND_INSTR(0x84, 0x16),
+	ILI9881C_COMMAND_INSTR(0x85, 0x16),
+	ILI9881C_COMMAND_INSTR(0x86, 0x06),
+	ILI9881C_COMMAND_INSTR(0x87, 0x06),
+	ILI9881C_COMMAND_INSTR(0x88, 0x07),
+	ILI9881C_COMMAND_INSTR(0x89, 0x07),
+	ILI9881C_COMMAND_INSTR(0x8a, 0x02),
+	ILI9881C_SWITCH_PAGE_INSTR(0x04),
+	ILI9881C_COMMAND_INSTR(0x6e, 0x1a),
+	ILI9881C_COMMAND_INSTR(0x6f, 0x37),
+	ILI9881C_COMMAND_INSTR(0x3a, 0xa4),
+	ILI9881C_COMMAND_INSTR(0x8d, 0x1f),
+	ILI9881C_COMMAND_INSTR(0x87, 0xba),
+	ILI9881C_COMMAND_INSTR(0xb2, 0xd1),
+	ILI9881C_COMMAND_INSTR(0x88, 0x0b),
+	ILI9881C_COMMAND_INSTR(0x38, 0x01),
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+	ILI9881C_COMMAND_INSTR(0xb5, 0x02),
+	ILI9881C_COMMAND_INSTR(0x31, 0x25),
+	ILI9881C_COMMAND_INSTR(0x3b, 0x98),
+	ILI9881C_SWITCH_PAGE_INSTR(0x01),
+	ILI9881C_COMMAND_INSTR(0x22, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x53, 0x5a),
+	ILI9881C_COMMAND_INSTR(0x55, 0x3d),
+	ILI9881C_COMMAND_INSTR(0x50, 0x9e),
+	ILI9881C_COMMAND_INSTR(0x51, 0x99),
+	ILI9881C_COMMAND_INSTR(0x60, 0x06),
+	ILI9881C_COMMAND_INSTR(0x62, 0x20),
+	ILI9881C_COMMAND_INSTR(0xa0, 0x00),
+	ILI9881C_COMMAND_INSTR(0xa1, 0x17),
+	ILI9881C_COMMAND_INSTR(0xa2, 0x26),
+	ILI9881C_COMMAND_INSTR(0xa3, 0x13),
+	ILI9881C_COMMAND_INSTR(0xa4, 0x16),
+	ILI9881C_COMMAND_INSTR(0xa5, 0x29),
+	ILI9881C_COMMAND_INSTR(0xa6, 0x1e),
+	ILI9881C_COMMAND_INSTR(0xa7, 0x1f),
+	ILI9881C_COMMAND_INSTR(0xa8, 0x8b),
+	ILI9881C_COMMAND_INSTR(0xa9, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xaa, 0x2a),
+	ILI9881C_COMMAND_INSTR(0xab, 0x7b),
+	ILI9881C_COMMAND_INSTR(0xac, 0x1a),
+	ILI9881C_COMMAND_INSTR(0xad, 0x19),
+	ILI9881C_COMMAND_INSTR(0xae, 0x4e),
+	ILI9881C_COMMAND_INSTR(0xaf, 0x24),
+	ILI9881C_COMMAND_INSTR(0xb0, 0x29),
+	ILI9881C_COMMAND_INSTR(0xb1, 0x4f),
+	ILI9881C_COMMAND_INSTR(0xb2, 0x5c),
+	ILI9881C_COMMAND_INSTR(0xb3, 0x23),
+	ILI9881C_COMMAND_INSTR(0xc0, 0x00),
+	ILI9881C_COMMAND_INSTR(0xc1, 0x17),
+	ILI9881C_COMMAND_INSTR(0xc2, 0x26),
+	ILI9881C_COMMAND_INSTR(0xc3, 0x13),
+	ILI9881C_COMMAND_INSTR(0xc4, 0x16),
+	ILI9881C_COMMAND_INSTR(0xc5, 0x29),
+	ILI9881C_COMMAND_INSTR(0xc6, 0x1e),
+	ILI9881C_COMMAND_INSTR(0xc7, 0x1f),
+	ILI9881C_COMMAND_INSTR(0xc8, 0x8b),
+	ILI9881C_COMMAND_INSTR(0xc9, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xca, 0x2a),
+	ILI9881C_COMMAND_INSTR(0xcb, 0x7b),
+	ILI9881C_COMMAND_INSTR(0xcc, 0x1a),
+	ILI9881C_COMMAND_INSTR(0xcd, 0x19),
+	ILI9881C_COMMAND_INSTR(0xce, 0x4e),
+	ILI9881C_COMMAND_INSTR(0xcf, 0x24),
+	ILI9881C_COMMAND_INSTR(0xd0, 0x29),
+	ILI9881C_COMMAND_INSTR(0xd1, 0x4f),
+	ILI9881C_COMMAND_INSTR(0xd2, 0x5c),
+	ILI9881C_COMMAND_INSTR(0xd3, 0x23),
+	ILI9881C_SWITCH_PAGE_INSTR(0x00),
+	ILI9881C_COMMAND_INSTR(0x35, 0x00),
+};
+
 static const struct ili9881c_instr rpi_5inch_init[] = {
 	ILI9881C_SWITCH_PAGE_INSTR(3),
 	ILI9881C_COMMAND_INSTR(0x01, 0x00),
@@ -2425,6 +2620,23 @@ static const struct drm_display_mode am8001280g_default_mode = {
 	.height_mm	= 151,
 };
 
+static const struct drm_display_mode ppoh_default_mode = {
+	.clock		= 73400,
+
+	.hdisplay	= 800,
+	.hsync_start	= 800 + 52,
+	.hsync_end	= 800 + 52 + 4,
+	.htotal		= 800 + 52 + 4 + 12,
+
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 60,
+	.vsync_end	= 1280 + 60 + 18,
+	.vtotal		= 1280 + 60 + 18 + 50,
+
+	.width_mm	= 94,
+	.height_mm	= 151,
+};
+
 static const struct drm_display_mode rpi_5inch_default_mode = {
 	.clock		= 83333,
 
@@ -2664,6 +2876,15 @@ static const struct ili9881c_desc am8001280g_desc = {
 		      MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
 };
 
+static const struct ili9881c_desc ppoh_desc = {
+	.init = ppoh_init,
+	.init_length = ARRAY_SIZE(ppoh_init),
+	.mode = &ppoh_default_mode,
+	.lanes = 4,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		      MIPI_DSI_MODE_NO_EOT_PACKET | MIPI_DSI_MODE_LPM,
+};
+
 static const struct ili9881c_desc rpi_5inch_desc = {
 	.init = rpi_5inch_init,
 	.init_length = ARRAY_SIZE(rpi_5inch_init),
@@ -2708,6 +2929,7 @@ static const struct of_device_id ili9881c_of_match[] = {
 	{ .compatible = "wanchanglong,w552946aba", .data = &w552946aba_desc },
 	{ .compatible = "waveshare,7.0-dsi-touch-a", .data = &waveshare_7inch_a_desc },
 	{ .compatible = "ampire,am8001280g", .data = &am8001280g_desc },
+	{ .compatible = "industio,purple-pi-oh-panel", .data = &ppoh_desc },
 	{ .compatible = "raspberrypi,dsi-5inch", &rpi_5inch_desc },
 	{ .compatible = "raspberrypi,dsi-7inch", &rpi_7inch_desc },
 	{ }
-- 
2.56.1

