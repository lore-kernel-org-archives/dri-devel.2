Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D263CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 12:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA5010E1A9;
	Tue, 26 May 2026 12:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="keKLpKNH";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E95D10E1A9
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 12:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779798349; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OZmC5GAqsPiVRRotyr1OCzK3xX5MeOidug1v7JsT80jbBIcu1H0YeWVJV5qksQchE0TZv1wS0sHaS90s733Vv+LXNYmA18GVkqXIWFjwaXDkrmEhVCjVXmhOu1HDwbDheW7n7ui08IhiV2WBEarmHApy746ctN/T6w6vck160DY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779798349;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DwZzq7c2/hWkcle3BnoXPhm6lB6x0fhIx1McF4Mkag0=; 
 b=Ckj4aHPUAgMxq/M117UddSQyYshwuMlJn0yND2ocs3JrBNPQh+JDdifP1fZkNZrDPTnCeAsg6hZo2I5UCsSvtJLnKy8Xxepp1OTBSwY3nGu/G2TIowy+KzsBQoAYq/4xDD8dKY8Po0S/mOmUVAGhFlqYPCmA1UgPjkZwSmgN7E8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779798349; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=DwZzq7c2/hWkcle3BnoXPhm6lB6x0fhIx1McF4Mkag0=;
 b=keKLpKNH972bGyGeA470MBBrfWUgKBlxoh5rbiHuM8d67wsxonWvJJEIgzEpmoz5
 sl4T5e6LqqQ2rdwE8PdQpDG7dDlP+PgNur5KlBrDnIyMEZJSCoglEFxg65n7t0nmKq1
 O9uldsTVKotorjZX6TCxNIWRuuO+uJW0xyUgZsq8=
Received: by mx.zohomail.com with SMTPS id 1779798347020690.6624180678479;
 Tue, 26 May 2026 05:25:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v3 4/4] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
Date: Tue, 26 May 2026 14:25:39 +0200
Message-ID: <DXw5qfHzRwWls-U9c30neg@collabora.com>
In-Reply-To: <a14c938ec67d501967873622e5d2c3c40765cc1d@intel.com>
References: <20260526-scdc-link-health-v3-0-59e4a4aaead1@collabora.com>
 <20260526-scdc-link-health-v3-4-59e4a4aaead1@collabora.com>
 <a14c938ec67d501967873622e5d2c3c40765cc1d@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Tuesday, 26 May 2026 12:52:31 Central European Summer Time Jani Nikula wrote:
> On Tue, 26 May 2026, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> > HDMI 2.1 redefines previously reserved fields in SCDC for various new
> > uses. No version check needs to be performed, as an HDMI 2.0 sink's
> > reserved SCDC fields are well-defined to be 0, and any zero-ness of
> > these fields for an HDMI 2.0 sink is not a surprise for SCDC parsers for
> > HDMI 2.1.
> >
> > Implement reading and outputting these fields over debugfs.
> >
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/display/drm_scdc_helper.c | 154 ++++++++++++++++++++++++++----
> >  include/drm/display/drm_scdc.h            |   9 ++
> >  include/drm/display/drm_scdc_helper.h     |  85 ++++++++++++++---
> >  3 files changed, 218 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
> > index 75a59c6fc7a5..b5a866372b0f 100644
> > --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> > +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
> > @@ -21,6 +21,7 @@
> >   * DEALINGS IN THE SOFTWARE.
> >   */
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/export.h>
> >  #include <linux/i2c.h>
> >  #include <linux/slab.h>
> > @@ -63,6 +64,38 @@ struct scdc_debugfs_priv {
> >  	struct drm_scdc_state state;
> >  };
> >  
> > +static __pure const char *drm_scdc_frl_rate_str(enum drm_scdc_frl_rate rate)
> 
> There are a total of only 71 __pure usages in the kernel. Is this
> helpful for a static function where the compiler can figure it out by
> itself?

For the compiler, no. For the programmer, maybe. It's basically
documentation that foo(x) remains the same for a specific x, so
that having 3 calls with the same parameter in some scope is not
actually 3 separate function calls, but just retrieving a value
without manually saving it into a stack variable. A compiler can
infer that in this case, but a programmer that has their LSP show
them the function signature on hover will immediately know what's
going on without having to look at the implementation.

I have a habit of slapping it onto any function that is pure just
because, but if you'd rather have me drop it then I can do that.
I'm aware that slapping attributes onto function signatures can
make them a bit noisy to read.

> Here too, bitfield bit order is implementation defined. See my other
> reply in the thread.

Ugh, I was hoping that with just 1-byte bitfields, this would not be
a problem. If that's not the case, then I guess Bug Endian ruins
another handy shortcut. :^( Oh well.

Thanks for the reviews, will send a new revision with the comments
addressed within the week probably.

Kind regards,
Nicolas Frattaroli



