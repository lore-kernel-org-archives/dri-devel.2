Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F92ACDE004
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A182910EDD7;
	Wed, 24 Jun 2026 07:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UCljyDhS";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D9010E36C
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:58:29 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1384eb94d20so542280c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782244709; x=1782849509; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cd2toS9EVtCpFi8pDPSG86Zuz4knsyDYVlmhOocX+b4=;
 b=UCljyDhSh+vkVctQUfZah4nMitm/cxnyiFMfbtXKrM4vVuYl/5rcRr4a+mvbRIkKTL
 5IfbZVsxbGuWltEBDRpj9ZF8s0ysn1/a2AyB5+gwT37t1tbxyqdbRZrnWiU7hGnUHROg
 3u4ae06Z6zmby9uEAKfFL0RHdE5+vKqwMOpNL1G3682kDeDlR3tXpJJBM6jtTUOkoCuH
 jRYBS2fw8Z/7xM7rb/02ks+hR5nsnnCOEFyWZ76FyP8xVDQFoSH+vl+yeriFsukkB8CH
 WdP+OVKYMj2iP5qljos8RrV8gd/M31cauA5Qh2G0CyjW8SXIvdicdfq17vwj7rKv85x/
 iCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782244709; x=1782849509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cd2toS9EVtCpFi8pDPSG86Zuz4knsyDYVlmhOocX+b4=;
 b=sVxmpuJYZbMd0CN05EG0rgLCrob11GAK020swxRKxVSQD5OX2Ins+18fpk8DYfTJyA
 yI1oXnDdXqpQlO2m0OyLFMSdmdDWYZK01m3PN2fpHvoS3LdPbTuYrQUcIT7ovCycvfqU
 jGF6gnlhSArbv5aXYyNl6X/7/4AxRa8KmDveq6EX6I7LIKpb2oAVjuU6D+zakPz3L0rA
 SYji8zHMhZTJ/L4St2deTsGMRHzWct6MBrZljQPgDOSvRnkO8jGGef6ZeRjuzfgMptIi
 MVluLwEIi23ve6/WfglEU/r3L6bG8Hz6h09FtH3/dfQEUAj8YNraMeArO2sziwe14yfG
 2/MQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ89DsOSJUX4ad+ZJeHRnymsAOG6MpUtT95ySJY1xdQThQO89DWWi3R1bswLiAUahbIvEHFFqTCdwHw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2ypnnG7Yrg3r/5F02mMCAF+PrEvkUKWwICyvB6LzYXBromFZJ
 TOn6yMR/ZTrNoOuq+GjP3qCNha3wQYZFjIcwS4bg5J5qQShEtpbJaPOs
X-Gm-Gg: AfdE7ck9Qr/BPECJNgnkVdQ6/QE2O0dKPzzURV9ecU/emSUIhwWvWgT4isKVoipW4Gh
 p77t/q+jw+M/rHyn+6PF/FwTp1r3+UTTPsiZaJOF1Ktd4rVZnIQD7yJkPXuMZFIKYmTi8AtDbS3
 TaG1TyMzPMuzM398543+0K6UZlwbRcqsHXx7g1bLSdnf80o3ejEQW1jgl1YxcvKGU4+Y7h64ih8
 ED5sHG1HDCfBHonP4UE+yP5749y9tF1R9+HQzFbq2PGNP1rjF9UfUgWwi2qnhDYRJmDeYFaa82N
 u9CaiyIP9ynY6/+w0VZzcRhf7FQaa/Y5l8GP7E8f2VFca6ux/xyUvvVwJFY6h2Wdq4lwshGFdVQ
 qymH9CCXOKFC+xd7MqOYGNGFlAosAp7/Iis3I0qA3DYixAxT3GXYWXdEjUDMfHAk//a2kDRMwFR
 1g2wFW2vgZGgP5xcTWB97U7uahXbJkOPizp1QSXnSb09zmO3TDE9/2IuLVWxiibXvWZBVBwUgkm
 zqcquFstrd8wVUe3RPv5YyqJdGCutM1ZPirGNIz8W8=
X-Received: by 2002:a05:7022:69a4:b0:138:49ea:f487 with SMTP id
 a92af1059eb24-139d0c040f2mr216795c88.6.1782244708943; 
 Tue, 23 Jun 2026 12:58:28 -0700 (PDT)
Received: from leonardoc-nb (201-68-197-145.dsl.telesp.net.br.
 [201.68.197.145]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add85c40sm15730896c88.15.2026.06.23.12.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 12:58:28 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: laurent.pinchart@ideasonboard.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, thierry.reding@gmail.com,
 sam@ravnborg.org
Cc: leonardo.costa@toradex.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] dt-bindings: display: panel-lvds: Add compatible for Opto
 Logic SCX1001511GGC49
Date: Tue, 23 Jun 2026 16:57:38 -0300
Message-ID: <20260623195741.495734-3-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623195741.495734-1-leoreis.costa@gmail.com>
References: <20260623195741.495734-1-leoreis.costa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Leonardo Costa <leonardo.costa@toradex.com>

The Opto Logic SCX1001511GGC49 is a 10.1" WXGA (1280x800) TFT LCD LVDS
panel.

Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index b89f86bc06837..8382d4920bfd6 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -58,6 +58,8 @@ properties:
           - hydis,hv070wx2-1e0
           # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - jenson,bl-jt60050-01a
+          # Opto Logic SCX1001511GGC49 10.1" WXGA (1280x800) TFT LCD LVDS panel
+          - optologic,scx1001511ggc49
           # Riverdi RVT101HVLNWC00 10.1" WXGA (1280x800) TFT LCD LVDS panel
           - riverdi,rvt101hvlnwc00
           # Riverdi RVT70HSLNWCA0 7.0" WSVGA (1024x600) TFT LCD LVDS panel
