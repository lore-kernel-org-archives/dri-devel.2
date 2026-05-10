Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C7ECD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CEFD10E420;
	Sun, 10 May 2026 22:26:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="pmqbZNCz";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="uCY7t++F";
	dkim-atps=neutral
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C541B10E24C
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:26:47 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-g8lr.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778452007; 
 b=DbR7DTs+fgEMOtn0Y8N+D2P3VxsSI0pqL/KwM8icZ/ojOh+ghblkEMX+5rDwMHATLJfjLzuYqx
 dJkJQYpWy1pNb1RNAZl1iHdiuiVr6kqio/Vlk503o2F1GHgA9cF4dHSQc1ABCtQJEHDSqepjVK
 Mh7CK1jAiRsr3nk1f6xQoYxjhqXZ/DpzWmtYek+VVtIgiVCo5fQ7L/ePgbSVSZeH+6v73dBfbX
 cTekmKewYBFhOJbAxuwnu9lAH75JiSHFITMhrTl+Jsb68iK4oaWsvs/LRyQ0LPO+n+M2QxeUSS
 7kmgyoShThhMh1YUIJ2oQuO9ZVcktoXfXCTr8p65HToqZw==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-g8lr.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-g8lr.prod.antispam.mailspamprotection.com;
 s=arckey; t=1778452007; 
 bh=b77YSloUDf1bQe4XnZJQJVHsMv8N/tf5dK9SHW0/Uj0=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=zmROIOPAj7r76ZUPr9SzNzP/ikktV9soRFsETTeQuRIrkJfiglDwyb0dkAXq6RBsHrpwvEz/rH
 4XV22oxlxKS/eGV5DaMA7fZTqi3F+qR67a0z/mQycsjoPYyGg53NsDsvMqFppvlnGWzhcEs3Vi
 Ku9B4BhvB7ORf5gqj/1G2nmLiNpLRCDcbONPbuqKPGrvkw0dL7QCMDpMFTEjTCvds3RGLtYez8
 2rfOK8FoNc6ZdhyydoYDSq2eTdDME70WqfXy0PIoY2iCEks4HV8FjgjUWRrhWmOAnIXkjEjbjx
 vqLR59ULr5mI1zE24B4jEl4tRBA27ijfDhoBpnfR6ofOaw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=cc4l52O81Yr5VXf89Cd/KNg6LHCRrq8/in15WyV/j5M=; b=pmqbZNCzBlybe6g2lM9jy5jFlx
 DwBWnXldT41bp+JHi+syS4d1UorUoPRqMqm5mKNT71YOdaMZa2dmgfXUaI3QuYmROC64KypMYM6gL
 usj90v6PogA6cRgCrBn6MdmY80ocASoy29yr8cPSZYkYKBpdaQvWamGJb3WNzXcHWVG0=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-g8lr.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.1)
 (envelope-from <francesco@valla.it>) id 1wMCbk-000000070Mk-0Vg8
 for dri-devel@lists.freedesktop.org; Sun, 10 May 2026 22:26:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=cc4l52O81Yr5VXf89Cd/KNg6LHCRrq8/in15WyV/j5M=; b=uCY7t++FxBE/xoqffuHU6wNZEL
 ALaf2jpfKwfqVvp/BV/sDiMKoufuPdvBdiWE33X3FM7fCVycYxdThkoUCCksrJTf8NPj/ffStDgLY
 EqMUji2h/ca3FsYjUuqrsisMDUU8Du1O5uuc8Xh23HQ0RvcHxs/EsbfU1yVNhjjuP0hM=;
Received: from [95.232.18.244] (port=61481 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <francesco@valla.it>)
 id 1wMBim-00000000PdN-3Dnf; Sun, 10 May 2026 21:29:56 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 10 May 2026 23:29:39 +0200
Subject: [PATCH RFC v3 2/3] MAINTAINERS: add entry for DRM splash client
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-drm_client_splash-v3-2-a9aee9f0b2fc@valla.it>
References: <20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it>
In-Reply-To: <20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-embedded@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=francesco@valla.it;
 h=from:subject:message-id; bh=b77YSloUDf1bQe4XnZJQJVHsMv8N/tf5dK9SHW0/Uj0=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkMPy4F6Vr+M5wh9Tzj0KpjHussNuYlaO312L34RErTz
 FDjiDcfOkpZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJxF1m+F9opHPWXvVW0WdB
 cQEzvuk2nwUcmF4Wv/ZlDlYpufdvijUjw/rY1JXFNlLbjfJffPr6ZZV2ZnHg3SyhzxqNiXwsX0P
 P8gIA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 95453c979a5e06861adff0971953dfcb
X-AntiAbuse: ID - 95453c979a5e06861adff0971953dfcb
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wMCbk-000000070Mk-0Vg8-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-g8lr.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Add myself as maintainer for the DRM splash client.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2040011a386..6c132139e87c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8933,6 +8933,13 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/drm_privacy_screen*
 F:	include/drm/drm_privacy_screen*
 
+DRM SPLASH
+M:	Francesco Valla <francesco@valla.it>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/clients/drm_splash.c
+
 DRM TTM SUBSYSTEM
 M:	Christian Koenig <christian.koenig@amd.com>
 M:	Huang Rui <ray.huang@amd.com>

-- 
2.54.0

