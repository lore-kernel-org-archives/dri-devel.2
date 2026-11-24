Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67064606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=n2QBylsX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C565B10F599;
	Tue, 24 Nov 2026 13:05:26 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2FE10F596;
 Tue, 24 Nov 2026 13:05:20 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jYjhq1yTgz8vZ9;
 Tue, 24 Nov 2026 14:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795525515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJMJNU3sAuG+Bc7xlPKNCuWjit5pvGYpvKy6R3HAxwY=;
 b=n2QBylsX9AgBpth6aF9KL7/8f10rvUagABO/0XN/CxDh4pYKwYxCI174ZXayobZNvDq9SY
 9sIC+BSfIaPDa/s+gegF7nn55WUuL24EnheE64CRh+dY3SLfGHgFzvjLkkmjn+nMHTRdYW
 JP9l4Fw9+55LHY+aZDbXqk4DX5/V7HBTEDzD2e7WDxw5ifh68EGx1kh5+ECJ3J9oJAkLB2
 WdU6lX5xo28/XRJNuVxxr08bm65rajY+XyIWBzEjXFHpbMvhxXuucy3t0AWiIXuqa2VqA/
 vUC01EXsHi34V6MJb948d+u59WHp2g3PqCtaHNdlC0m+ZbOHPGxzkdiObsQHLg==
Message-ID: <47ee6326-08ca-4dcd-866b-3a543cb15665@mailbox.org>
Date: Tue, 24 Nov 2026 14:05:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amd/display: Skip flip_done wait for
 non-modeset TEST_ONLY checks
To: =?UTF-8?Q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 amd-gfx@lists.freedesktop.org
References: <20261123220913.937402-1-jakub@okonski.org>
 <20261123220913.937402-3-jakub@okonski.org>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20261123220913.937402-3-jakub@okonski.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c1016891d93790a5233
X-MBO-RS-META: 5b1z3dykqdbxsbpfrqbp8d48a4b7b7d7
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 23:09, Jakub Okoński wrote:
> needs_dc_state_realloc makes amdgpu_dm_atomic_check() call
> do_aquire_global_lock(), which waits for hw_done and flip_done of each
> CRTC's newest commit. A TEST_ONLY check issued while a nonblocking
> commit is pending therefore blocks for up to one refresh (6.9 ms seen
> on DCN 3.0 at 120 Hz) for about 0.1 ms of validation.
> 
> A TEST_ONLY transaction publishes no state and does not reconfigure
> IRQs through the commit path, so a non-modeset test has nothing to
> order against the pending flip. Skip only its flip_done wait.
> 
> Kept: the modeset and private object locks, the hw_done wait (DC
> validation reads the programmed topology in dc->current_state), the
> same validation, and the full drain for modeset tests and real
> commits.
> 
> Signed-off-by: Jakub Okoński <jakub@okonski.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3d2201285888..25dcbee0c7df 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5594,8 +5594,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
>  }
>  
>  /*
> - * Grabs all modesetting locks to serialize against any blocking commits,
> - * Waits for completion of all non blocking commits.
> + * Grabs all modesetting locks to serialize against blocking commits, and
> + * waits for pending programming and, where needed, flip completion.
>   */
>  STATIC_IFN_KUNIT int do_aquire_global_lock(struct drm_device *dev,
>  					   struct drm_atomic_commit *state)
> @@ -5624,13 +5624,14 @@ STATIC_IFN_KUNIT int do_aquire_global_lock(struct drm_device *dev,
>  		if (!commit)
>  			continue;
>  
> -		/*
> -		 * Make sure all pending HW programming completed and
> -		 * page flips done
> -		 */
> +		/* DC validation can inspect the programmed pipe topology. */
>  		ret = wait_for_completion_interruptible_timeout(&commit->hw_done, 10*HZ);
>  
> -		if (ret > 0)
> +		/*
> +		 * Tests don't publish state or reconfigure interrupts. Limit
> +		 * overlap with pending flips to tests that disallow modesets.
> +		 */
> +		if (ret > 0 && (!state->test_only || state->allow_modeset))
>  			ret = wait_for_completion_interruptible_timeout(
>  					&commit->flip_done, 10*HZ);
>  

Does a commit with both DRM_MODE_ATOMIC_ALLOW_MODESET & DRM_MODE_ATOMIC_TEST_ONLY set really need to wait for pending flips to complete? Why?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
