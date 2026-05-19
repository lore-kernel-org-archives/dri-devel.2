Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15BECD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468AF10EDB6;
	Tue, 19 May 2026 16:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WwgVVA17";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B557D10EDDB
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:08:45 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso31185515e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779206924; x=1779811724; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+Mm35+gyRUpU/UbhRPzGueGup/98gF+lABSNhHuAq0=;
 b=WwgVVA17YriOiceiogiwGDBbJk/RnQaVnQacTlLwzlmh+yxNHEpCJhEf28UxaFqPOH
 rt3utfIwdvTzBPblxXN843dpR76qPU35RqF6y/TSRPbiqppOXJ1xrnMj4CbEUcjSKn0s
 3uhsfjIjxJJTXBPqEgU558vB45LVkXpHtiCS+5pSCgjszJ8BLNlyZ2RV6HAiXKTodXJI
 tuHZ5OedOoVzaP0ryp560NWPlc0HhbwBJwt/8VI3GPbaA+ryFoJNt4uEaxVLyTqhzOjz
 PZEr1oZtkR4E1xqMuc7AKViy9Nj8ovkBzLvcjaOX9+ZJ4jdeFXQAX+mZXK4+EJIdAOCW
 FJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206924; x=1779811724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9+Mm35+gyRUpU/UbhRPzGueGup/98gF+lABSNhHuAq0=;
 b=oSbGjMUKKkd16EzlaCnRbk7cWH+t6iKvcTd/nJKDy7HqvvrHjwfa1Q26xRt/OzMzY9
 miR0tMOdln4liek0JwwxEJlH1dI+03G7EnGnhWaNnNjvK10Ee6BQkBTUnpdjZAqJkGyi
 dk/DzPeaEUou/FP5pTjDbqserkw3XTQZ2oXXrnIIypBUh0rWden6LOmX6P85n6ryqzeP
 t6NLpVMwX1iTvvSR5SHeob1lGZRUcguMHEs1VFu/vetDRjgWR4X6du1ASQLTQVKMOIi5
 m3+SgrSaUFEIUIoW8Tns4Eb3V6k2shrjRUK6AAqnvSbvBVvhBNhT0Jg8zULePJ9jS8qV
 xQlg==
X-Gm-Message-State: AOJu0YzAYqfSjqO7cgUeNma0s5Lnj9L7M/Pr/eruHZxXA5qULNY4bSns
 WgPTsVO5raYYJclzOAjBNYK93RJH1e7qtUUCw5aKRnrfF8IYDhrPIGOv
X-Gm-Gg: Acq92OHE2nNAaowXFl33VZc9qfvz1XHt87xs/+f4SSRymjjteIuBiM5w86NyRvLVu4P
 GOXOy9sMmNYkUEkZygtpswSC6/aQq63SeVLvJ0uxy0qF1dieUuJ0cpwbdZKu6UUKM38JgyDiulL
 ePQrEoI2m5EHZ7FMPySb/lNeNe5UytUvwwQalyUyPmg34p7N/XrYt5UIuZGP4wxZQPMPtRY9/Xr
 1PD2qf+88QNkjSuUnatUyWoqgN6SzRKpMQ7Hj9RlFg1OBbbXukoPyKV5oYk/Wprt3TBQts70tCo
 L6V/XrhQTkj5sOmzeur5gyLAys4BDjitBr9DvET5+ZsppRlcHbsN7CIMVoIyuIqwGbZLnevztNx
 osVvh+VH7fpopXiBRzplDMYsjOozB9aMxxgHmzphTasOBIMxuZOB7pXKCLF7434pCCdCjV+ks+6
 gWT7ObH3q+UjKkceo0flrYzZWanwzsdthy+k8qzmY4H5Eu61af4sADURnsguhyCfiMoFEPtgbpM
 wecd4iAfyFVNT/4pf5j6FrktQ2svIc2p6D8Cg==
X-Received: by 2002:a05:600c:4e47:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-48fe61ed3b3mr335858345e9.16.1779206923936; 
 Tue, 19 May 2026 09:08:43 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3f5e:825d:a98f:fd29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab527asm372645305e9.11.2026.05.19.09.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:08:43 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 1/5] dt-bindings: display: renesas,
 rzg2l-du: Refuse port@1 for RZ/G2UL
Date: Tue, 19 May 2026 17:08:21 +0100
Message-ID: <20260519160825.4082566-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519160825.4082566-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260519160825.4082566-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

The RZ/G2UL DU supports only a single port@0 DPI. Explicitly refuse
port@1 in the ports node.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- Added Acked-by tag from Rob.

v3:
- Was orignally part of separate series [0]
[0] https://lore.kernel.org/all/d1e0d4e0fe74e60345a3d043fb4f9128c1057638.1778141145.git.tommaso.merciai.xr@bp.renesas.com/
---
 Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 2cc66dcef870..5add3b832eab 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -102,6 +102,7 @@ allOf:
           properties:
             port@0:
               description: DPI
+            port@1: false
 
           required:
             - port@0
-- 
2.54.0

