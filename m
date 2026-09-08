Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3369C79FAE
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F31810EC93;
	Tue,  8 Sep 2026 15:24:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E705E10E129;
 Tue,  8 Sep 2026 15:23:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A4BA601DB;
 Tue,  8 Sep 2026 15:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885BE1F00A3A;
 Tue,  8 Sep 2026 15:23:57 +0000 (UTC)
Message-ID: <2a3a7a962caadab3399d3e03f5538d90@kernel.org>
Date: Tue, 08 Sep 2026 15:23:54 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 1/7] drm/edid: Include <linux/fb.h>
In-Reply-To: <20260709092215.168172-2-tzimmermann@suse.de>
References: <20260709092215.168172-2-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com, jfalempe@redhat.com,
 joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net,
 "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
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

On Thu, 9 Jul 2026 11:15:57 +0200, Thomas Zimmermann wrote:
> We currently get <linux/fb.h> via <linux/vga_switcheroo.h>. Include it
> explicitly.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
