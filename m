Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAD9CCF2D3
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBC810E65A;
	Sun, 18 Oct 2026 14:53:15 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB7F10E1C8
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 14:40:19 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j5nfS5D9TzMlRZ;
 Fri, 16 Oct 2026 16:40:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792161616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dS/+QYyFt7bepYEquW4f2tzbCjSDt1FaV0bMvIj5qK0=;
 b=Qbg0Zs4oWE9kiZywd6BJ3nSkcp+q5c7TCLGc2dKtb4JJiCZPXT0kcQQqpjp4iv4+C5h0oe
 uLtE0miAawW0bDeWe2W5mJ5dbxweBTM1wKDFHTjLiWmXy6ME0TGQB7VZLFRlgGNH3Yrhdy
 rqLR25bxXojfn+Ys5yiWfT0E8j0JWuPpTeWqvKgVQppMVjLQGU3Uzg1+NOuazCG1jXDydp
 Qa2A395Bh2A0CjXbAhNOYoe6I8G9o1MJMiAMtYL0kLMSUVR3bBZU9IZ3AjCZtCx4Gc2R99
 pH4jDaNP5CzKgk2RAsRrsj5HdCXMcMzHXxd2SP2Fg9DeT0lIYjYZRayk9JcyCw==
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
Date: Fri, 16 Oct 2026 15:40:13 +0100
Message-ID: <20261016144013.1014546-1-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atItSgRj26x60ACf@intel.com>
References: <20261015212545.1989962-1-hugo@hsal.es>
 <atIYd0dd6ynXulwQ@intel.com> <20261016131652.483525-1-hugo@hsal.es>
 <atItSgRj26x60ACf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j5nfS5D9TzMlRZ
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

On Fri, Oct 16, 2026 at 04:57:30PM +0300, Ville Syrjälä wrote:
> Connectors aren't probed before something actually probes them.
> Typically that would be fbdev.

I think I may have misspoken before. fbdev's first probe already uses
the device's limits: __drm_fb_helper_initial_config_and_unlock() passes
max_width and max_height. Only drm_fb_helper_hotplug_event() passes the
framebuffer size, so the list starts with every mode and loses the
larger ones on the first hotplug. This series makes the hotplug probe
match the first one

Are you suggesting a different approach?

Hugo
