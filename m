Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C21DC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 10:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ECE610E499;
	Sat, 27 Jun 2026 10:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.b="Td/Em6wY";
	dkim-atps=neutral
X-Greylist: delayed 525 seconds by postgrey-1.36 at gabe;
 Sat, 27 Jun 2026 10:38:23 UTC
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0358310E499;
 Sat, 27 Jun 2026 10:38:23 +0000 (UTC)
Received: from localhost (unknown [10.10.165.10])
 by mail.ispras.ru (Postfix) with ESMTPSA id 60E1D40F9A49;
 Sat, 27 Jun 2026 10:29:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 60E1D40F9A49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1782556174;
 bh=HefoXOaX7iDWeVdJoA+Z44Cqogqv/SbYCDDilQ/lrZc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Td/Em6wYzVFSgEpJlmiCF/PlqhNZH96DvffaHrobgmo5aEnGrHjXeb/Lu7trF+LZE
 cejW6hLiRlcFB0/xqxg0WQ5O21pR+tNCxBcZUj4CDkyYwxB/QHfVwVG33reJ16I5M9
 Lp206/2msW9GRs8eaNr/Acgj6p2b/MhStzCLRR6E=
Date: Sat, 27 Jun 2026 13:29:34 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lvc-project@linuxtesting.org,
 superm1@kernel.org, 
 dri-devel@lists.freedesktop.org, mario.limonciello@amd.com, airlied@gmail.com,
 simona@ffwll.ch, 
 ray.wu@amd.com, amd-gfx@lists.freedesktop.org, chen-yu.chen@amd.com, 
 aurabindo.pillai@amd.com, Alvin.Lee2@amd.com, kenneth.feng@amd.com,
 ekurzinger@gmail.com, 
 siqueira@igalia.com, HaoPing.Liu@amd.com, pierre-eric.pelloux-prayer@amd.com, 
 srinivasan.shanmugam@amd.com, sunpeng.li@amd.com, mripard@kernel.org,
 mwen@igalia.com, 
 Dillon.Varone@amd.com, chaitanya.kumar.borah@intel.com, ivan.lipski@amd.com, 
 Tony.Cheng@amd.com, dmitry.baryshkov@oss.qualcomm.com, chiahsuan.chung@amd.com,
 timur.kristof@gmail.com, harry.wentland@amd.com, linux-kernel@vger.kernel.org, 
 alex.hung@amd.com, tzimmermann@suse.de, alexander.deucher@amd.com, 
 christian.koenig@amd.com
Subject: Re: [PATCH v3] drm/amd/display: Fix dangling pointers in state reset
 functions on allocation failure
Message-ID: <20260627131809-033f104c2b15b742e1ba441e-pchelkin@ispras>
References: <20260626191314.29933-1-evg28bur@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626191314.29933-1-evg28bur@yandex.ru>
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

On Fri, 26. Jun 22:13, Evgenii Burenchev wrote:
> Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
> Fixes: 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC")
> Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>

Having three different Fixes tags implies the big patch could be split up
into three separate patches which do one thing at a time.  They can be
combined in a series for ease of handling.

> @@ -8151,33 +8151,41 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>  
>  void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>  {
> -	struct dm_connector_state *state =
> +	/* Remember the old state */
> +	struct dm_connector_state *old_state =
>  		to_dm_connector_state(connector->state);
>  
> +	struct dm_connector_state *state;

No empty lines inside local variable declaration block, please.

> +
> +	/* Allocate new state */

Well, all the comments added with the patch - IMO they duplicate what the
code is doing - that doesn't add any real value and just bloats the
codebase.

> +	state = kzalloc_obj(*state);
> +	if (WARN_ON(!state))
> +		return;

It's not common to WARN on memory allocation errors.  If this code is ever
fuzzed with fault-injections enabled, that'd be one of the first issues to
pop up.

I think if the system is in a state when it can't allocate a bunch of
GFP_KERNEL memory, there'd definitely be some noticeable activity in
dmesg.  Some (random) assertion triggered inside amdgpu won't help much -
that will only halt those machines booted with panic_on_warn=1.
