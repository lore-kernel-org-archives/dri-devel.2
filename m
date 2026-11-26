Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BB6606A32F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rAz/z0j8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63AA112741;
	Thu, 26 Nov 2026 21:44:53 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BAB7112737
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:48 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4a34ffd3e39so4103154f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729487; x=1796334287; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5TOaY7Fgq8X9NRdZ+s6yjIa1AaIRWGcVdRqEFaeVeKY=;
 b=rAz/z0j8ORMRIcM/h5kWxIEOBl58yNneFCcZo15qRiFwqFr1Xb1wZ9mznjtQj3dMkR
 leaC5/KSwU7HA0H+DlqZmFHRILsQHf8WuJlGXGgoqILE9AGYHCpiSD0iQhRH+0zvgyZh
 gcE8XQPkGbvR44pCSAbiPjplcpAsfc3uRM0NDYiT2my/woq8nturoIT2PJhDIGrQjBw1
 Y42QvpbF73AsGXI/U+4gdgK+xgV58a7fYfQ+LHtH7e7zt+jUVu+bZrIWk+uhCPIPFll3
 ZLXX9ELxSSj6flMAiPz0VTEYVbXsROKf1SiPLl3RFiUHY/xnuU4LPswd2K0KZS5UCcgo
 LEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729487; x=1796334287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5TOaY7Fgq8X9NRdZ+s6yjIa1AaIRWGcVdRqEFaeVeKY=;
 b=lfn18/HdHew8+ZSJCinMpnt0u1OzbtMb4qjJOghFu9xrQL/r8cTAwX947o1xeqiN0A
 EZgQ/VUdRqq20DImDo7LljyXjfrydzA86GHYOoQwOTxsrFU1+dsnE0wFkBi1slCSEAy+
 Bz81PC7XhWJJ7wQ9zD2/z0P6uWWFhynmG5ayAOhVK+2inlDQDCXhhj4w4hkx7Fjl/mrG
 ydx6dg/g+w5JBrF974BiLPBbospIONEYumnI4ezrS4hF6oc6cnfCBmDYKNZDjA5H27Ug
 0s7R2AHX7l1oKC1LseDuITzQTF3qBqRzM6Fv/WkAf42p8mZrnpAbOJAdom3x4BTkbqjy
 8rhg==
X-Forwarded-Encrypted: i=1;
 AL+hErGvgN3SW7neOOpDgLZ0xX3NumVtOoxpS8b0dvMA6lEe0NKuir6QhT9kFO0n8TMNaogZgzFNaPa4KxE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8+3OxqF4QlI1DcF0TNy702FKhc/RPUyibQ7IUqUbahYpsLsbHq
 Qbc/zqEolhV9Toa38HHwc+fN/2PSoqKLU72etqKIfqZPzFupcLOxk6hM
X-Gm-Gg: AZFdTZfIZJOnUSeVgFe7/7nC7Px3ry9cV9I8uIk3kYzAqMmI8n3RbVsHzUc5YdoBET6
 50M3UrAlIfFNb8nfLG+89BPe8gG+HdR35BeRzfosZZJs2sRvXP79wbohqpj/DZm18EdADYXodcG
 CdNnAUfyjj0b5IVAVEXGOGQBKHKzZ3+BT4AUdRav3+Ue1yeeocuW3KQDqn8ZMc2DIDoeN8Gpvux
 xMWfrZTRbNJhVwUQhsWXkQrrXuqqOjmsj9UgdfknM7QJ250I/xXIag0X3TYDW3HvltBhLCRbLf8
 4pKekgddWJh5GVcx41GBADngoldGF77CFWOv6QzcCPq3NYQx2wCM2KFpwmUStNmAeg95QnmU4Hy
 dc1xj06nncfYFtVXs0KDhEqdTdi/HxWv3mcE765JvAlZr8DhYLM0GB+I3WWIYMCqS85Wg8XimhQ
 OkY2ppw6V+llDoO+ziq2+emFlvSbnR6wDH4Mb/J5OfVRNMwhEwh4/3UC3jZZR2m13G9Ma0eBnnt
 IGXIeIvhmEtTKk4oytcmp0k8qgA+nZCEln9in8ZOqExPkB2v4e6BoneCMPIdMvZS/gp9Bz1iBMR
 OcTzZmajIBnZ0aMExqpk5U8c4LAsa58bSQOYCqq4vM5B7Q82z42mfDli0XMuioxTQkmbbJYBiXR
 e/Zk6qCjvQ3wM33opfDnxV2Hy7nSWnT3H6E4PRBFPgxLd7jrWFybvYHNij5QB/qBYsTkBNWN+6k
 H43axmQ7iEDsxDnoZf0ob0upTFmSRO/F+4FGKxByrjEE1FvqxDjUSaOSxYQPC/F80W6CGEYed4Y
 ETSlv1nDiGrnPyK2okK1BAwLuLzU4AT5DCTdCJjVg==
X-Received: by 2002:adf:e189:0:b0:4b7:6a63:89b2 with SMTP id
 ffacd0b85a97d-4b76a638a20mr20363316f8f.20.1795729486620; 
 Thu, 26 Nov 2026 13:44:46 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:46 -0800 (PST)
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
Subject: [PATCH 05/11] drm/sun4i: tcon-top: Route LCD TCONs to the LCD pins
Date: Thu, 26 Nov 2026 22:44:27 +0100
Message-ID: <20261126214433.3562326-6-jernej.skrabec@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TCON TOP selects whether the LCD pins are driven by TCON LCD or TCON TV.
The driver never programs that and relies on the reset value, which
selects TCON LCD. Since the reset is only deasserted, a different value
set by the bootloader would survive and LCD output wouldn't reach the
pins.

Select TCON LCD explicitly, like the vendor driver does. Nothing in the
driver uses TCON TV for the LCD pins.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 5ea55a2844a7..c7d03c37fd6e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -226,6 +226,8 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 		goto err_assert_reset;
 	}
 
+	/* Route LCD TCONs, not TV TCONs, to the LCD pins */
+	writel(0, regs + TCON_TOP_TCON_TV_SETUP_REG);
 	writel(0, regs + TCON_TOP_PORT_SEL_REG);
 	writel(0, regs + TCON_TOP_GATE_SRC_REG);
 
-- 
2.43.0

