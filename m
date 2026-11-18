Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205A606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BskGXYpO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB76010FC89;
	Wed, 18 Nov 2026 13:47:08 +0000 (UTC)
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B6710F89F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:59:43 +0000 (UTC)
Received: by mail-dy2-f9.google.com with SMTP id
 5a478bee46e88-377157fde7bso252765eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794995983; x=1795600783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HR+dfaUubpoOruAzxfc7lBsrK7YFb31bfreI3ckdboA=;
 b=BskGXYpO+PcR5s9Top0PqJFctcyTriBtpAF4MbJjNh8yA6Cim+rZ+tp5kT2PWTwCXh
 CowRLZoTT8OD6ZofyaLppqpMDBM07X/5CEn0hlZP+9umU/dHf5VfOrJ6sDB9iEv3+UGL
 t42q811oQanEl11Bqjk2KQ7+TU++UtvoTpWihaFI0W97QYRJRtRPoKzPEiXLimv4jvvF
 EAHg+YeZvrj7Q5Q4VjHIxNacCaTCiMoKwj570obL9M7XyX6UOcyoVih4KSPdD5MPtI7v
 d49DfAHnYVswWfDY5nR8ngboIVV9cEdA4l3IGkp/zdzl2zzO2Y+EzVqSEPG7lX+JfRKD
 alZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794995983; x=1795600783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HR+dfaUubpoOruAzxfc7lBsrK7YFb31bfreI3ckdboA=;
 b=VovTBZ3F+v4lzuvxq81F7AIRUqBTW3nOtq2ISYAj1+K/mlOmaOBwuuz+j87CpDARvi
 JKuuYqY5hj6xaJaVWzv5d7bBZhgRB79YjezY1Ky2XGEz4QaKnqnq72au2J90L+18Q1Ek
 rvhPaKmCNQnbLgbQiuGJkxdUUmqYcthVQDApABS6sIu/dOq4t6NC3LcrqnFgeBVqv+JI
 ZD3/rm1wIh6IbTmm0K+JDgC5W172klsNx6NBkbnaT/WzScATMBioL5uF2oO15Rb71NZr
 EOvRkJrSHAjbeUeexBJu/0122tk5yIA3iFqxsTmmuJP40K/mfTBaQYdJZ4tA2wi4L7nF
 bsEg==
X-Gm-Message-State: APuU4Z+rvU2YP8JCAWG8mqD4zk9hstiLG4CWMkvJxf09yRU8wQt5D0GQ
 VI6b3Y+JQ3IMokpozLxWlNz7W5ItqDaiI+3NpMbuaLrY4NYmu+zBzpcj
X-Gm-Gg: AZFdTZf92nIPPNctUWelcr/sGuDUGhReiq8I02SYnuslgayulA2K+PftqS/k6OPKwVy
 OU7ZhIlxgaH+fCR/YlBorRIUeY29cF+U1xf7/vUTUQzf7Slwn9MrGPqic10/9N4ZyYLPQTcRTjY
 JSmL608L0mGcVp5BzkDUZCLyY38bAOL/2dzlFL8payVoRg/QeP5Q0t/NHkdIFfIOL7ATKhcRrSA
 Pdc08vf6uhs4nprYjjREJwLn5BWLhwR93/aEE4pjh4L48rLfnYyoIjmfLDBdDPKiAaHsrQgp6df
 NAI7g3G5/P0ul4/hAEESnu5jDjeCazTWGl66ySoDTyPNTft4mPPhOiINkBoTMh2LwlXq7MReQ/G
 o+Mf30hIYuqP88BIoshD5oiofo7OQqzqri6m+8LXMCP1mzDzzqceBao2Cra2Xw/2ruB0M0QAeJI
 muvUzMNoGCOuGYBfd0bK0zHqIY44TSPX7odP9sZYdG3786kkoncD8pBJh25rf3q/q7vtT5OixX1
 8qZtDAr5pI/i1hZjASpDk0bSvyb3Kf2/5Upm3XWLmIuBwllNeS8cCBfGtb9ewYul4R8hXXqeJ1I
 GAn+Rj7fdnYaornU36vGVITEE9Zdw3ODBE4=
X-Received: by 2002:a05:7300:6b05:b0:373:d25b:8cf0 with SMTP id
 5a478bee46e88-382816244d8mr2044772eec.29.1794995982709; 
 Wed, 18 Nov 2026 01:59:42 -0800 (PST)
Received: from pjhArchLinux ([199.102.217.182])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a680032dsm5868358eec.10.2026.11.18.01.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 01:59:42 -0800 (PST)
From: pjh456 <pengjunhao409@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: display: panel: ilitek,
 ili9881c: add Industio Purple Pi OH panel
Date: Wed, 18 Nov 2026 17:59:04 +0800
Message-ID: <20261118095905.127658-3-pengjunhao409@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118095905.127658-1-pengjunhao409@gmail.com>
References: <20261118095905.127658-1-pengjunhao409@gmail.com>
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
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Purple Pi OH is shipped with an ILI9881C based 800x1280 MIPI-DSI
panel.  The module is marked ZC-700010BH and has a 94x151 mm active
area; the vendor device tree only describes it as a generic
"simple-panel-dsi", so no panel-vendor compatible is known.  Add a
board-specific compatible with ilitek,ili9881c as the fallback.

Signed-off-by: pjh456 <pengjunhao409@gmail.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index 42e35986fbf6..cafa85aaefbb 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -20,6 +20,7 @@ properties:
           - bananapi,lhr050h41
           - bestar,bsd1218-a101kl68
           - feixin,k101-im2byl02
+          - industio,purple-pi-oh-panel
           - raspberrypi,dsi-5inch
           - raspberrypi,dsi-7inch
           - startek,kd050hdfia020
-- 
2.56.1

