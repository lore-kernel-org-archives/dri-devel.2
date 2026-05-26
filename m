Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A571CD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B376410E522;
	Tue, 26 May 2026 07:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="giYXEpKn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E383310E522
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779781448; x=1811317448;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=jcwJ1CG/xrquDqSSa9RCxZJ0J0+4Fi444QZTJMpHhBg=;
 b=giYXEpKnI6ozYzmnJ0s3cBDPAffLVwdmAh++Dfq8FfxM78VIUic7wvYN
 jTz2AV33yvsL/Am7HS8oJyhtzHm37QWMAvjIQKOZ715nq8YPXM+f2X8qn
 TSKe4lUzUjMJmw1JDaWTFrVD6MieYzHlqFakrCJqSjkuNX2vz8QycN//b
 6VKuT4z0rejxqs7ilzifZDokowlywscbiVavnaQwn23lFdEfiMcpNQr2q
 AjSpuOE1M8yXGtB9YH2oSjhHE7Lqs3fPkb355XfGYAOqnh+/ZFAtIBAwn
 Oz4QCVeJW3Q48GlqeTjeptaHc4+A3Oc8hsdJUHFYjUz/uapygo6qkpbKQ Q==;
X-CSE-ConnectionGUID: R1l+JHKFQ1Ka4qCFP9wJYg==
X-CSE-MsgGUID: I34JdpG5R7e7l53gIYKW4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84214259"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="84214259"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 00:44:08 -0700
X-CSE-ConnectionGUID: Y7K08/xqQFCZo+Qvi2PM+Q==
X-CSE-MsgGUID: Df5DZKybS/6b5kLLE+pzdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="246799294"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost)
 ([10.245.244.104])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 00:44:04 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Icenowy
 Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH drm-misc-next] drm: verisilicon: fix build failure of
 cursor plane code
In-Reply-To: <20260525153618.1336239-1-zhengxingda@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260525153618.1336239-1-zhengxingda@iscas.ac.cn>
Date: Tue, 26 May 2026 10:44:01 +0300
Message-ID: <5c768f5d867d7cba875e0d06678f57594a022ddf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, 25 May 2026, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
> The cursor plane patch was stalled for a too long time that the
> struct drm_atomic_state parameter of atomic modeset hooks has been
> changed to struct drm_atomic_commit.

Yeah, but that was merged in the same branch three weeks ago. Did you
not build the changes before pushing?

BR,
Jani.

> Fix this by replacing the parameter's type. All helpers that retrieve
> information from this struct are also changed so simply replacing the
> type works.
>
> Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor planes")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>  drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> index acb9854fa67ed..fa4f601dd0c87 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> @@ -40,7 +40,7 @@ static bool vs_cursor_plane_check_coord(int32_t coord)
>  }
>  
>  static int vs_cursor_plane_atomic_check(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>  {
>  	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>  										 plane);
> @@ -98,7 +98,7 @@ static void vs_cursor_plane_commit(struct vs_dc *dc, unsigned int output)
>  }
>  
>  static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
> -					   struct drm_atomic_state *atomic_state)
> +					   struct drm_atomic_commit *atomic_state)
>  {
>  	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
>  								       plane);
> @@ -115,7 +115,7 @@ static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
>  }
>  
>  static void vs_cursor_plane_atomic_disable(struct drm_plane *plane,
> -					    struct drm_atomic_state *atomic_state)
> +					    struct drm_atomic_commit *atomic_state)
>  {
>  	struct drm_plane_state *state = drm_atomic_get_old_plane_state(atomic_state,
>  								       plane);
> @@ -132,7 +132,7 @@ static void vs_cursor_plane_atomic_disable(struct drm_plane *plane,
>  }
>  
>  static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
> -					   struct drm_atomic_state *atomic_state)
> +					   struct drm_atomic_commit *atomic_state)
>  {
>  	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
>  								       plane);

-- 
Jani Nikula, Intel
