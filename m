Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA4606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sq48EFl1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B31112743;
	Thu, 26 Nov 2026 21:45:29 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15648112736
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:47 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4a34ffd3e39so4103140f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729485; x=1796334285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=StNF/DBdYuXhvQKxZ0p2je0tZDOMLysv6mcYjNTNzho=;
 b=sq48EFl1xj0/XbKZEzolnvalW91QzHy7MO7oQ4aLjImkeY8+7YKTNwj7465vx9bNs9
 YWZ+9jQm6Sz0b2oyHlp66AGIAsb2Iz8OI4ZedbmEOodkDPonz7+FYh3uWaKXFLaqwSi7
 RT3bUQEpUGv6aY/7h6K9wEfI6mRAG6AuAwETYYeIe+SHuqEhJj16CFZIM306XJO0BLqv
 WOUHpuvUgrCJgeh318PZo9rX4vx54pN+uYaON1aRS66T2EGhwKo/egiNCIqGARffjV6f
 pFtZ8D1LxJtBsrmlzKEoYIzRl/i2YzjQyN0E4BamfjL6S/3pUB8qLrLampIfnZIDRUnj
 Z76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729485; x=1796334285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=StNF/DBdYuXhvQKxZ0p2je0tZDOMLysv6mcYjNTNzho=;
 b=iwasb83nl2IsM5nQIPzR7fM7ywf4Ra/1BdJJ9TTKPFP+rU88VSsM8zrdJsVpVc8FMm
 STID62nm59/HPwjU/jlAB0bWMiytv4q6wz++/jyGyyWmjVcZedU16kB9fNKEWBwGfQfV
 6LdNezurD11pRpDZIyqoT+Pg+4qa6RLMURqxW7EWxwpWhbCCNDn0CX3cGAlIre+qqnKj
 eHKTda8GODRen3jdhRZdzryDg7Xje/EIlWaIkKVwuqMEe5+HLDy2GKR4HW33MbNrMiaM
 6PLbZ7WIdteLlpEibilIGZtnoUitSb19x7aCSUCk5vSZrhghYQ6RjJVVlz67AzMM2L4Z
 3HXw==
X-Forwarded-Encrypted: i=1;
 AL+hErEkMxWL7YFBi/AbqTBoE4q9nz93w0bO4oJRohdRBZuQM+pbOukUebWTcvzdnG6+Qsilc/t7Zf/thHM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/QZ72jdhEGZgU222kvDhsWbEQ6bdfRa+Wv78jjzcgNxRX4UdVf
 9ActmgGrQZAxhR2GwVAWeSh0WU6WvjSGYKchA6J7wB1JuIYSAFDR0+ML
X-Gm-Gg: AZFdTZehRsmCm/LFiRtm92PBB//wbQsW3kurkDuXMDEFJYPHQNRojRsvyBskJjAnxo8
 MfDmmZcbqMBoA4o4IYk2iwwN2SnCnB1lsnC1GvmDyvPJciPEo1wQCN7Vsb66JGqKwfSwm30V0pK
 QfJMSXewpRnlnOAOqC3BtA2VA/UXXhn8LQnTCt2R3mWaNQXlXsxS7ZnfvvoqGAOnDsXociVnwzQ
 7F9vIlRQehkgcPwGDr2kpxF7KXQU7gTCTkWGdr+npqLOSqDM/ULTAyJ9thE1vctgCnKr9pHqH7Q
 9M1s13Ernae5CoCaosI04u2S5JWu8RppcjXWeVnc7s2kd1Cy8Q/MmgoTnuOaSpp6tKKbM6D+614
 VW8SmAF45cqW3o8reWiXw7K7mWGoMNkFlcWVogDD0rDcalsmk++UsshOStBImccV5NFhDGGXNGK
 kMvWIBYSNoylycmd4tE8AslBuq8Jq3tYZtP7mj99V14aj1YdZvSZodQLrVDtBvJB++S64mzXEyu
 4XKqY+bgkABOPUwL7HOJnFqwytTiXkJPgGR8BWVr6/oYKgArdGKj2PIEOgVGmMzO2edSqKaSsPe
 putBBiHpID/qUfd0qgAWvezGRZ9e799ST/vJA5GJkrxvRdaB1JBBpwzcfC6D3BLE3u5bwi9eJu2
 2uT2mlOQ4slFF8xNSBlAZnPBayoedwuNGR3grOgIk3YXC5KAWoh/iPQ4ctgLmo8+Xof7Kzf+4ZQ
 MOZ+fZEdoaiP/Ca/bEVGeYv2nwExkhKKq8DaHkaSSzUMNvjsMZkCBy+A6cS8sLcSlQMZijjIwnO
 NhSX0aLvA9ES+9IT5UAgFp2CL1/uWUN7sXPSTwpXw==
X-Received: by 2002:a05:6000:2b8e:b0:4a4:7dd0:2177 with SMTP id
 ffacd0b85a97d-4abb55185b5mr27115538f8f.49.1795729485342; 
 Thu, 26 Nov 2026 13:44:45 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:45 -0800 (PST)
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
Subject: [PATCH 04/11] drm/sun4i: tcon: Request LVDS reset as shared
Date: Thu, 26 Nov 2026 22:44:26 +0100
Message-ID: <20261126214433.3562326-5-jernej.skrabec@gmail.com>
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

H616, and other SoCs with the same die like T507, have one LVDS reset
line for both TCON LCDs. The TCON driver requests it exclusively, so the
second TCON LCD fails to get it with -EBUSY and the display pipeline
doesn't come up when both TCON LCDs are enabled.

Request the LVDS reset as shared. The driver only pulses it once in bind
with reset_control_reset(), which is fine for shared resets, since the
reset core triggers it only once.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 20740fa10ce8..77b6026bc895 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1170,8 +1170,11 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		 *
 		 * If the property is missing, just disable LVDS, and
 		 * print a warning.
+		 *
+		 * The reset is shared, since some SoCs have one LVDS reset
+		 * line for multiple TCONs.
 		 */
-		tcon->lvds_rst = devm_reset_control_get_optional(dev, "lvds");
+		tcon->lvds_rst = devm_reset_control_get_optional_shared(dev, "lvds");
 		if (IS_ERR(tcon->lvds_rst)) {
 			dev_err(dev, "Couldn't get our reset line\n");
 			return PTR_ERR(tcon->lvds_rst);
-- 
2.43.0

