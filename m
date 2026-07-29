Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF74C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6154D10E38B;
	Wed, 29 Jul 2026 16:37:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YZ7EU6AT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B401510E38B
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:37:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FBBC43C1E;
 Wed, 29 Jul 2026 16:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4759B1F000E9;
 Wed, 29 Jul 2026 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785343040;
 bh=x+qM/hIMgLxkF6mAMxl6seWBA0JVHXiwZXqAXUyQWKE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YZ7EU6ATfy2BqbjxS6u5tOUeyloBXWO+8zd7HLR+yBYpIG7JAQoVfXkwybBwq+uMI
 DSu3+L9MNqSVSY2x3yndqWAft4qG48pGKuSgNyKdCADZNYa92J2pHdweCz+v43DFAd
 npRZ2uZvKN0lKY8CNsPjH/+eufWB0s+wmIDAd1Iupj88OfZ8MUmLYmM/C5dYPwho6c
 QiA7zqGUuu4Ke5BxDNPulakbp0tarqzJFjGv+gkU3ELR/0RdKT++DanumGxuooQqrC
 E1EUMrkW22OYkkOV0HFyYR7QyO9Cuzz3IOurcqjYHlZNf8n2S2+UCefMkr5tKbgW+5
 BowLTBGiAj6qA==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/dp_mst: Handle torn-down topology gracefully in
 drm_dp_mst_topology_queue_probe()" has been added to the 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026072907-framing-morphine-00a8@gregkh>
References: <2026072907-framing-morphine-00a8@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:37:19 +0000
Message-Id: <20260729163720.4759B1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `mutex_lock()` from within an atomic encoder callback path.
--

--- Patch [1]: Patch "drm/dp_mst: Handle torn-down topology gracefully in d=
rm_dp_mst_topology_queue_probe()" has been added to the 6.12-stable tree ---
commit 746d73e2e2b5ca58eedb8e8371b10fa271386f44
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>

drm/dp_mst: Handle torn-down topology gracefully in drm_dp_mst_topology_que=
ue_probe()

This commit replaces a drm_WARN_ON with an early return in
drm_dp_mst_topology_queue_probe() to handle torn-down topologies gracefully
during concurrent hotplug or link-loss events. This eliminates spurious
kernel warnings and compositor crashes.

Link: https://lore.kernel.org/all/20260503034533.1023686-1-jonas.emilsson@g=
mail.com
Link: https://patch.msgid.link/20260622140532.526722-1-luciano.coelho@intel=
.com

> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index ac90118b9e7a8..97ddd10df0229 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3739,8 +3739,10 @@ void drm_dp_mst_topology_queue_probe(struct drm_dp=
_mst_topology_mgr *mgr)
>  {
>  	mutex_lock(&mgr->lock);

[Severity: High]
This is a pre-existing issue, but won't this mutex lock cause a sleeping
in atomic context warning?

During non-blocking commits, the encoder atomic callback
intel_mst_pre_enable_dp() runs in an atomic context where sleeping is
forbidden. It calls intel_mst_reprobe_topology(), which then calls this
function:

intel_mst_pre_enable_dp() ->
    intel_mst_reprobe_topology() ->
        drm_dp_mst_topology_queue_probe()

Since drm_dp_mst_topology_queue_probe() unconditionally acquires mgr->lock
using mutex_lock(), won't this lead to scheduling while atomic splats or
potential deadlocks during hotplug events and modesets involving MST links?

> -	if (drm_WARN_ON(mgr->dev, !mgr->mst_state || !mgr->mst_primary))
> +	if (!mgr->mst_state || !mgr->mst_primary) {
> +		drm_dbg_kms(mgr->dev, "queue_probe skipped: topology torn down\n");
>  		goto out_unlock;
> +	}
> =20
>  	drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);
>  	drm_dp_mst_queue_probe_work(mgr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026072907-framing-=
morphine-00a8@gregkh?part=3D1
