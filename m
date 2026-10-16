Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D244CCCF2D3
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3C310E6A7;
	Sun, 18 Oct 2026 14:54:37 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F677112816
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:16:58 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j5lpH1wq9zKmT6;
 Fri, 16 Oct 2026 15:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792156615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADFLpxJTy6WuqekBYcH8+chW3TrBLyByLSZYI4f+yyQ=;
 b=m1mbA0Jyczbb4IFU891R/y3QKmCITbeDLYUk9RwKS0JyYHyNzKR4hsHVnlnOIz4KhxURip
 ZIB1xuqrao8Y+WsFBZcgC+Oaa7tF9crSy9WtM2SO02w7NGXh/SczGlfckyP/zxRdOhLJoj
 33yO9y34MnB47Mx8pjN/p0s7N5yKwjiVbvBtOMXlnDS9rhWrX6yIhNH82IQ5l9XAyd0vDI
 wi/Xo/1FO6qEwUATjXmazi8Gtm82FyvgvntAOsTBuCdacjrTZuOrXyE0cK0/5lcotrZE6r
 FbG6chdTV41+fUXckIQHoVqp6o3/s2ZkBYrK+XNIpDiZGqz8jAOG5r/dJIo+YQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jfalempe@redhat.com, javierm@redhat.com
Subject: Re: [PATCH 0/2] drm/client: Keep larger modes in connector->modes on
 fbdev hotplug
Date: Fri, 16 Oct 2026 14:16:52 +0100
Message-ID: <20261016131652.483525-1-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atIYd0dd6ynXulwQ@intel.com>
References: <20261015212545.1989962-1-hugo@hsal.es>
 <atIYd0dd6ynXulwQ@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j5lpH1wq9zKmT6
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

On Fri, Oct 16, 2026 at 03:28:39PM +0300, Ville Syrjälä wrote:
> On Thu, Oct 15, 2026 at 10:25:43PM +0100, Hugo Sales wrote:
> > On an ASUS ROG Flow X13 with a 3840x2400 eDP panel, booted with
> > video=eDP-1:1920x1200@60, an HDMI hotplug makes fbdev reprobe every
> > connector with its 1920x1200 framebuffer as the limit. connector->modes
> > loses the panel's 3840x2400 mode, and after suspend/resume amdgpu drives
> > the panel with the 1920x1200 timing. The image ends up squeezed into the
> > top-left corner. Details are in
> > https://gitlab.freedesktop.org/drm/amd/-/issues/5983
>
> Sounds like an amdgpu bug.

Agreed, the resume bug is in amdgpu. It looks up the eDP native mode in
connector->modes, which fbdev's hotplug probe can trim. This series
fixes it there:
https://lore.kernel.org/r/20261014223041.171317-1-hugo@hsal.es

I sent this one for the shared list itself because after a hotplug,
connector->modes depends on fbdev's framebuffer size, while initial
setup, drm_log and GETCONNECTOR probe with the device's limits. Until
something reprobes, the sysfs modes file and any driver that reads the
list see the trimmed version

amdgpu isn't the only driver that reads it. stm/lvds and
shmob_drm_encoder_mode_fixup() take the first entry of connector->modes
as the panel mode, so they may hit the same thing with a video= mode
smaller than the panel. I haven't tested those, because I don't have
the hardware. Fixing it in the core covers them without each driver
keeping its own copy of the native mode

Hugo
