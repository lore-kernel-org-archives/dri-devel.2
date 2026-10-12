Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5D0CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D76DC10E69B;
	Mon, 12 Oct 2026 21:25:31 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A7110E6A1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791840319; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cAkwpIhof9YBtpTSTat40E7pmaDUjnNQ5W4vMPysJ5tldb5VP5AKMAnVJUOOBoaqIC5Xp/eTgunwMCyT+4dleA88wZgGH+5pUPGO7/dQJLPxLDhPmbAH7/SLsWHAQ/2IMrs1SzYpXpJb3wQzKrnrR0CiGwOckfksQHBPz6NuXBU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791840319;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=G5rmMzKZ20hIT58eLKccNnNAABFsYOIG72MswwWPfiM=; 
 b=kS3NA99uv/gss+ZpwcGHS8BZFv7zgZlxUuTtDLkmjy7O8cz5Liz23axOKi4z9S3QOKvyvWyZMgnQkARfDSkW+81InMYK9tRlIf/7k0AHW0CtCJCB0BDmdDHdVa//b0rPyQRpH+6LiQTPKdGGMKPGDRH8tv3g1RNVYkJmbRxt6yA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791840319; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=G5rmMzKZ20hIT58eLKccNnNAABFsYOIG72MswwWPfiM=;
 b=L2Y0zHbHoIvsT0xzhbTIIAq7VSP+SvVzv6nk1R6xOstk8hS6Q4xHMFWVY0vMqbGq
 OpTqmIguuiQcarMw+tUUYWzHyz0jlHviQAugkxZjxUtTI2jWQju6zJO32T6nm9H2c3a
 2lMHaS76RjTGDjO4Gg2rfk/D1juPU26/n5Ob3SHw=
Received: by smtp.zohomail.com with SMTPS id 1791840318080973.7325583031546;
 Mon, 12 Oct 2026 14:25:18 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drm/panfrost: reset the Amlogic GXM GPU on runtime resume
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <daniel@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260930125629.2691968-1-christianshewitt@gmail.com>
References: <20260930125629.2691968-1-christianshewitt@gmail.com>
Date: Mon, 12 Oct 2026 22:25:11 +0100
Message-Id: <179184031154.1056803.12154076398577087527.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=zvJO1I+hs2PvsLlXorWzm77MtxLIOgqxx0KEmeZz0WE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqzVA5PW/YISZhc5Q1F+GiMB36imxss0bllquzq
 llFPUTCUE6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCas1QOQAKCRAOJn5M7lND
 PQszC/9DW7oPdNiU6t7uAoiym7cMDjQbQE8Yb6I7z3AlNhE59r6pn9jLY3huOsRxF8b6alUo1xe
 99GDr40Qs5EMcnCrAwGC9wnXldXhcq2iHsb5GXjDjXSeTJajwtjK5W+/8rHDWzbyQloa1h3KxVP
 waQOLgyGALSw2MKvrDgSP8A3PtfUDDn6Z4Cn5YlXbGDvNL6WUQ8G/VV/HOkvt0uKgApEGUQvlYz
 UYGoAckvLcTb4nG5GcEO2AqsI8VBShAo3NTNeBrzROvwVbUu7sbNxLrWzlrX8gz18/gekIgUCM4
 pgX3R42UYtDFsWrd9eZ5NuPYt0L8pL8/gjyz5er9kEP8Yr1NMpkRzRHNbyl3oFmuiN08evdFnUo
 e27QMA2gxZHgatg1ucL4XOALVvZI1glTI9RqLpYfTVQVPZUoMxg15IaYOuO+FfJtR9D1SywyceS
 Uc4/HphSauAnyj1pEROgOhL0lVLBsPzgpPJTIwyP34NIyicw6jyTEZZnW2upin1cNhJk0=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On Wed, 30 Sep 2026 12:56:29 +0000, Christian Hewitt <christianshewitt@gmail.com> wrote:
> After its first runtime suspend, every power-off of the Mali-T820 in
> Amlogic GXM SoCs times out and floods the log with shader, tiler and L2
> power transition timeouts. Following a soft reset the cores report not
> ready but PWRTRANS never clears, however long the driver waits.

Would you mind building the driver from the latest drm-misc-next and testing
whether this is still the case? Today I merged a patch series with a fix
for a long-standing bug that prevented the device from going into suspension
because of mismanagement of the PM refcount. It might be that what you report
as an issue triggered by power transitions is something altogether different.

> 
> The transitions complete normally when the GPU comes out of a hardware
> reset, as it does at probe. Use runtime PM with reset and clock control

panfrost_device_reset() is always called as part of the PM runtime resume
operation, so I'm assuming what you mean here is that reset control is
deasserted at runtime resume when the SoC supports it

-- 
Adrián Larumbe <adrian.larumbe@collabora.com>
