Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071CC1099B30
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC4410EB17;
	Fri, 20 Mar 2026 21:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="DG8cPD6U";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569EE10EB17
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 21:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774041304; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RpLUrHXNOaN/bVWAPAlTZNRRsY4x15/3SGQgeYNjehHMhWILyS6BBmrHg01b3GTGzTExdZfLoX1IQiGIY5n/0uWtUKme6+O96z7pZ30j1wBRKN6yHVkXPJhxljp6j0NvYSpYeC0RycwqiawjK2HuFhNt2k51ZS8+aZUyCX0n/ys=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774041304;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=avG9s+VWGe6FnFrQXLvOIIBYcVGJY4tuZn/WwXVVuZw=; 
 b=F0ZCoaPNFDy0u1oTglQzRkTlmBOZpHLxs+G1cchUhSr3aNaIC4dzik4JsOneThht1anfPsqF/2bIJPhwClVg2/bWqBJefcB3MVmcIXK5rXneFeqf1Nk3TuhZoUOSRa/Vt/BVHON3/Z4XAqY8aKDkxRRLGShpFzw2cirr6ybymf4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774041304; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=avG9s+VWGe6FnFrQXLvOIIBYcVGJY4tuZn/WwXVVuZw=;
 b=DG8cPD6Un5JPbI0l4/Jd0amDlahIM5F1dNVmECbYCPKV8YR4OMg/Gn3E2EihYpqZ
 lG1qW4oR+fK9UZucJRK00upEf4X5Zpl8Zgb8+H8J0cHFKXeBY4JgCTme3WRC8uFmsEm
 +3NbJ0ttiDzhDN5+LMcWj+p7MhmrQUAEdsyh68HQ=
Received: by mx.zohomail.com with SMTPS id 1774041302496462.7191544079375;
 Fri, 20 Mar 2026 14:15:02 -0700 (PDT)
Date: Fri, 20 Mar 2026 21:14:57 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Biju <biju.das.au@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Biju Das <biju.das.jz@bp.renesas.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/panfrost: Add GPU_PM_RT support for RZ/G3L SoC
Message-ID: <ab24yfzmP450taKO@sobremesa>
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
 <20260320164158.487406-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320164158.487406-5-biju.das.jz@bp.renesas.com>
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

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 20.03.2026 16:41, Biju wrote:
From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L SoC is embedded with Mali-G31 GPU system. Add GPU_PM_RT support as
it needs to be assert/deassert the reset during suspend/resume.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 711f5101aa04..3d0bdba2a474 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -1156,6 +1156,7 @@ static const struct of_device_id dt_match[] = {
 	  .data = &amlogic_data, },
 	{ .compatible = "amlogic,meson-g12a-mali",
 	  .data = &amlogic_data, },
+	{ .compatible = "renesas,r9a08g046-mali", .data = &default_pm_rt_data },
 	{ .compatible = "renesas,r9a09g047-mali", .data = &default_pm_rt_data },
 	{ .compatible = "arm,mali-t604", .data = &default_data, },
 	{ .compatible = "arm,mali-t624", .data = &default_data, },
--
2.43.0


Adrian Larumbe
