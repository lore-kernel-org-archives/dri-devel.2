Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1C606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qx/Q7UJo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E120010FBC6;
	Wed, 28 Oct 2026 11:57:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC95310E62C;
 Wed, 28 Oct 2026 11:57:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8EA760202;
 Wed, 28 Oct 2026 11:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2991F01829;
 Wed, 28 Oct 2026 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793188662;
 bh=mN+5qMEhW+DgMKl4989EnlMC/0om5OMtt31qXEFkr5g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Qx/Q7UJoT+fKY/TYcWoed6xCKf6zmi0v1YrFVJafDl52sHNFZFV9ofPrK4kaFcMh/
 DhacaJjNYoMwvgir5Dm0ici3Ii5vt8bhQ5MtniIyvIxr2QQAraQJqj0A2XfhNUpFI3
 PBs/InLn7gq0VMdTAvT7/CjSvfMui0+9LapzIFfLmfsD7KUOzNmp+UJrn5oK2YeLaA
 iHtCyg+Tw8Hwg6XsKSg5k4X+ix/OcrzPNCssWyUJChx6De9t+Vgk08aXjDZIYB22G7
 N8yKwj2YWjRjK+h5v8JikrUnrCD0utrzfEYv0BD5VXHwsC1DR8h5ik37PCSirh1Q6Q
 jLPvlKxq+EDpg==
Date: Wed, 28 Oct 2026 12:57:39 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Jia Yao <jia.yao@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Shuicheng Lin <shuicheng.lin@intel.com>, Matt Roper <matthew.d.roper@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maciej Plewka <maciej.plewka@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v13] drm/i915/dg2: Add per-client control for
 Wa_22013059131
Message-ID: <auHjA2kEBniSCTj3@zenone.zhora.eu>
References: <20261016033102.529239-1-jia.yao@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016033102.529239-1-jia.yao@intel.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jia,

On Fri, Oct 16, 2026 at 03:31:02AM +0000, Jia Yao wrote:
> Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0
> at engine init, but this is known to cause GPU hangs in certain workloads.
> Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
> workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
> kernel know bit 15 programming is not needed. The register is not
> context-saved by hardware, so the value is programmed on context switch
> via the indirect context batchbuffer, and the old unconditional write in
> intel_workarounds.c is removed.

...

> Bspec: 54833
> Link: https://github.com/intel/compute-runtime/pull/919
> Cc: dri-devel@lists.freedesktop.org
> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Maciej Plewka <maciej.plewka@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>

pushed to drm-intel-gt-next.

Thanks,
Andi
