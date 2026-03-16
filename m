Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A20F53D74
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2822010E26A;
	Mon, 16 Mar 2026 16:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZZIYyiYA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A714910E26A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 16:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773679479; x=1805215479;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=r3k38bwjH0ZuBrxeJO+jvgnNmMlBitH7QWdnFx3etxo=;
 b=ZZIYyiYAIyeDphrK0OlE4qHu0iWOiAZyoJ+k0imay28SKNlG+/Yzt3Jd
 D3I6B9VD/tMAutcTZKSvDIW/wbv2LNcqFZAOpZSL+Q/qYmYn/k6VTwBsX
 Tsjj278rdlH37wQe05fZLcqE3ca5hY4mwZQCsyxBKMz0i9WY0L0uW8MIr
 h9rGDiAQFAxa6i0PGJzGaykplj1oeORzvZRCFzy7Z3I5r2I6xLUkvtFWA
 X7W0ZJM0dH/mZvlMlf5vcQTI7tyc6H4ZFtsYaDdp/sfB++ZfYWV1zA386
 Lurnhak98KvHkMl7lZWZryYi/uBxYckqfLu6UNQ+9mb4lCvjQU9I87QUn w==;
X-CSE-ConnectionGUID: VlVN0pmZRoeYCjWRkceHNQ==
X-CSE-MsgGUID: YSnnN0HrQyuLxjHGUhpo9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78596962"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="78596962"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 09:44:38 -0700
X-CSE-ConnectionGUID: 1c52I7EMQXa0Q4onwQ1fKg==
X-CSE-MsgGUID: 0s2F2lCxSLeAGDs+P2W7XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221920519"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.42])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 09:44:35 -0700
Date: Mon, 16 Mar 2026 18:44:32 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL HARDENING (not covered by other
 areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] drm: dp_tunnel: use kzalloc_flex
Message-ID: <abPd9rQFjsOQheNm@intel.com>
References: <20260308211220.33759-1-rosenp@gmail.com>
 <aa_SahEg_NzB_PJN@intel.com>
 <CAKxU2N8x4z7Lw3mQjsnGAMxYP-K0AxLUtCXJP6btEBuTcxL7fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8x4z7Lw3mQjsnGAMxYP-K0AxLUtCXJP6btEBuTcxL7fA@mail.gmail.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Tue, Mar 10, 2026 at 03:09:31PM -0700, Rosen Penev wrote:
> On Tue, Mar 10, 2026 at 1:12 AM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Sun, Mar 08, 2026 at 02:12:20PM -0700, Rosen Penev wrote:
> > > Simplifies allocation by using a flexible array member to remove a
> > > second kzalloc.
> > >
> > > Added __counted_by for extra runtime analysis.
> > >
> > > Simplify assignment loop. It always returns true. That is,
> > > max_group_count is always equal to group_count.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/gpu/drm/display/drm_dp_tunnel.c | 26 ++++++-------------------
> > >  1 file changed, 6 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
> > > index f442430d8de7..aad1605b956e 100644
> > > --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
> > > +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
> > > @@ -188,13 +188,13 @@ struct drm_dp_tunnel_group {
> > >  struct drm_dp_tunnel_mgr {
> > >       struct drm_device *dev;
> > >
> > > -     int group_count;
> > > -     struct drm_dp_tunnel_group *groups;
> > >       wait_queue_head_t bw_req_queue;
> > >
> > >  #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
> > >       struct ref_tracker_dir ref_tracker;
> > >  #endif
> > > +     int group_count;
> > > +     struct drm_dp_tunnel_group groups[] __counted_by(group_count);
> > >  };
> > >
> > >  /*
> > > @@ -1893,7 +1893,6 @@ static void destroy_mgr(struct drm_dp_tunnel_mgr *mgr)
> > >       ref_tracker_dir_exit(&mgr->ref_tracker);
> > >  #endif
> > >
> > > -     kfree(mgr->groups);
> > >       kfree(mgr);
> > >  }
> > >
> > > @@ -1913,33 +1912,20 @@ drm_dp_tunnel_mgr_create(struct drm_device *dev, int max_group_count)
> > >       struct drm_dp_tunnel_mgr *mgr;
> > >       int i;
> > >
> > > -     mgr = kzalloc_obj(*mgr);
> > > +     mgr = kzalloc_flex(*mgr, groups, max_group_count);
> > >       if (!mgr)
> > >               return ERR_PTR(-ENOMEM);
> > >
> > > +     mgr->group_count = max_group_count;
> > >       mgr->dev = dev;
> > >       init_waitqueue_head(&mgr->bw_req_queue);
> > >
> > > -     mgr->groups = kzalloc_objs(*mgr->groups, max_group_count);
> > > -     if (!mgr->groups) {
> > > -             kfree(mgr);
> > > -
> > > -             return ERR_PTR(-ENOMEM);
> > > -     }
> > > -
> > >  #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
> > >       ref_tracker_dir_init(&mgr->ref_tracker, 16, "drm_dptun");
> > >  #endif
> > >
> > > -     for (i = 0; i < max_group_count; i++) {
> > > -             if (!init_group(mgr, &mgr->groups[i])) {
> > > -                     destroy_mgr(mgr);
> > > -
> > > -                     return ERR_PTR(-ENOMEM);
> > > -             }
> > > -
> > > -             mgr->group_count++;
> > > -     }
> > > +     for (i = 0; i < max_group_count; i++)
> > > +             init_group(mgr, &mgr->groups[i]);
> >
> > This breaks the error handling.
> >
> > Hmm, actually it looks like it already got broken by commit
> > 8e6da25bd60d ("drm/dp_tunnel: Switch private_obj initialization
> > to atomic_create_state")...
> I can't comment on that.
> 
> This patch does not touch that.

You are removing what remains of the error handling, and that part
would have to be undone to fix the earlier breakage.

Maxime, can you fix that up?

> >
> > >
> > >       return mgr;
> > >  }
> > > --
> > > 2.53.0
> >
> > --
> > Ville Syrjälä
> > Intel

-- 
Ville Syrjälä
Intel
