Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492B3CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF2310FE89;
	Fri,  9 Oct 2026 06:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CaHTWuxt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D8E10FE89
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:10:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D7BE60DBD;
 Fri,  9 Oct 2026 06:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307571F00899;
 Fri,  9 Oct 2026 06:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791526221;
 bh=vkRBDNZq5OcYWLk9onSjYu3HsrthG0aePTr6yUQXG68=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CaHTWuxt6IErPXeOQk2i7VyB//76jOLgZC55XNz6M7Va8w85X90cBpaReuPraD8Jt
 D3eCfCMvJvis7nV43ULVSTIGjKL+cVDVdYjEg/SVVI2hMHIgDM1N9s+osh+NdgOsiV
 7aFikB1fq8N8QOwpAqFo9C1C9oiUqtm+dpZd4ouUPOaDqXmj2d7zgrWaIs2kQqW34m
 Jkmp6QAYrcyM8YFAmDpIPJNRLcJPVmsaTiZZYpN/+ZVdc76hAY4VcfIFHWOcuH4Ev0
 sTZXiPaaqkzZBcmby6/A+MpHHELBYcgttz81MBdzysKAaKAtm/tn66ov9gFTEUg76m
 vfChNrRFsgUyg==
Date: Fri, 9 Oct 2026 08:10:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Linus Walleij <linusw@kernel.org>, David Airlie <airlied@gmail.com>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/kmb: fix bridge reference leak on probe error and
 remove
Message-ID: <20261009-adventurous-aboriginal-degu-21ed2e@quoll>
References: <20261009033537.3065836-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009033537.3065836-1-vulab@iscas.ac.cn>
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


On Fri, 09 Oct 2026 11:35:37 +0800, Haotian Zhang wrote:
> kmb_dsi_host_bridge_init() looks up the ADV7535 bridge with
> of_drm_find_and_get_bridge(), which takes a reference on the bridge, and
> stores it in the global adv_bridge. That reference is never released, so
> unbinding the driver leaves the bridge refcount permanently elevated and
> prevents the bridge driver from ever being removed. The same happens
> when probe fails after the bridge has been found.
> 
> Release the reference in kmb_dsi_host_unregister(), which is called both
> from the probe error path and from kmb_remove().
> 
> Fixes: abbe7f8144d5 ("drm/kmb/dsi: convert to of_drm_find_and_get_bridge()")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/kmb/kmb_dsi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 



Multiple things here:
1. Your team ignored completely previous feedback.

2. You use multiple identities with this email, thus I actually doubt we speak
   with actual person.

3. Finally, same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document usage of LLM and how what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




