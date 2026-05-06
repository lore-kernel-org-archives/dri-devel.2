Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1506BCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 10:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E1410ED47;
	Wed,  6 May 2026 10:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="gdiLGp9e";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C2410ED47
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 10:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778064381; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dpvv8pdSOOd1BjbNj8a4iqQWdomPGUC4xTqFODGC2E7FGH8MRh7hSdQS5INXbg2+O1UTOOmmqLXVL0t8JG0p28bCMqcvspm8AEQaS5JDFFEaK/pNClkj3+0fWBMwGS2rCKUWN1sCN44hQKNzctjcL+UmAPw1Sf8IM4L7EZpG5aQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778064381;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Qn58wMHVc3ob5XjE31HftB0EDXlEBgCVeJ0UOumM8HU=; 
 b=n7QPLgsn2WeCRCkVXyrlhhLZhZp8mM/5z1PxsF/KEZEzytmQ89csPEdoLg1k8h1ISeY5m6k2+XEaMoSqGmwzYIaYVI1Pkk0UU+SHQ0Nvj820d6OtGU3GMJosVenAkbDD3PnCQszzyUYeWdIumGAk3a5fYaMIZocSvPOxSkaMqtY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778064381; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Qn58wMHVc3ob5XjE31HftB0EDXlEBgCVeJ0UOumM8HU=;
 b=gdiLGp9eCzBgfAbWVMNpFc4oxolD/ywraicOuolhFGvm0QcC+HCV0HEFIoe+ls87
 /beKPkLAb+hhUBmeC0x+P98guSH/cyFhd4VW+NECVer32x2jwxr4KPMUO+UnHcS+myG
 pUs+Kc+yA2qZGVvIGHSD2UYnnsMnCKUuaE5TCWAo=
Received: by mx.zohomail.com with SMTPS id 1778064380452287.4553281654578;
 Wed, 6 May 2026 03:46:20 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 06 May 2026 12:45:57 +0200
Subject: [PATCH 2/4] MAINTAINERS: Add sysfs ABI docs to list of panthor files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-panthor-explicit-reclaim-v1-2-44f82ac147ce@collabora.com>
References: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
In-Reply-To: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

While the ABI documentation in Documentation/ABI/ does include a contact
person for each bit of ABI, this contact is not necessarily the same as
the maintainers for the driver it touches.

Add panthor-specific sysfs ABI as tracked files to MAINTAINERS for
panthor, to ensure that any changes to these files also go through the
panthor maintainers.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b897e9f4c73..f006ea21d99c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2205,6 +2205,7 @@ M:	Liviu Dudau <liviu.dudau@arm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/ABI/*/sysfs-driver-panthor-*
 F:	Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
 F:	drivers/gpu/drm/ci/xfails/panthor*
 F:	drivers/gpu/drm/panthor/

-- 
2.54.0

