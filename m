Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E771606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=thelittleman.net header.i=@thelittleman.net header.a=rsa-sha256 header.s=20140415-thelittleman header.b=EdtQ8LPB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B18010E731;
	Wed,  4 Nov 2026 08:58:35 +0000 (UTC)
Received: from mail.thelittleman.net (mail.thelittleman.net [91.99.148.243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DAFD10E9CF;
 Tue,  3 Nov 2026 22:40:48 +0000 (UTC)
Received: from mail.thelittleman.net (localhost [127.0.0.1])
 by mail.thelittleman.net (Postfix) with ESMTPSA id 965185F92D;
 Tue, 03 Nov 2026 22:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thelittleman.net;
 s=20140415-thelittleman; t=1793745646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhwGwRx+CAJ8oe3CYy7JIhyCQbyPSgmwBR/yiullML4=;
 b=EdtQ8LPBmpcBxkAw/HqnPHzzZzav7GoCitR3Zq/w+1xhAitre6TGAZShUJ1HT4dasZGwyl
 OEaa/jJj3jkVvZWixPre9L+TqTOgKf4MjowTxXz6wofgWkoRgi7peGp1/QapzwBTWZhfKn
 zAtYrUmv9WbMBKUScUc1j36Jv/skVak=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 16:40:46 -0600
From: "David R. Hedges" <linuxdev844@thelittleman.net>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, Lyude
 Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 5/5] drm/nouveau/dp: restart an active link when the sink
 reasserts HPD
In-Reply-To: <sashiko-outbox-195994@kernel.org>
References: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
 <20261103-nouveau-dp-relink-v1-5-7ee88c7f1e8a@thelittleman.net>
 <sashiko-outbox-195994@kernel.org>
Message-ID: <5dd1ec13ff850f2c37c880f9cee381a5@thelittleman.net>
X-Sender: linuxdev844@thelittleman.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-03 14:36 -0600, sashiko-bot@kernel.org wrote:

> Could a successful link restart in nouveau_display_relink() leave
> connector->state->link_status stuck at DRM_MODE_LINK_STATUS_BAD when
> userspace processes the hotplug event?

It could, and I've left that as-is. The link-status documentation has
userspace set it back to GOOD, with the legacy SETCRTC path doing it
for non-atomic userspace, and no driver sets it to GOOD itself, i915
included. Userspace that reads link-status does one more modeset than
it needs to; nouveau doesn't act on the property. The v2 cover letter
I'm drafting mentions it. v2 will cancel a pending link_bad_work when
a later enable, such as the restart, trains the link.

> Would it avoid this race to update connector->state->link_status 
> directly
> while nouveau_display_relink() already holds 
> dev->mode_config.connection_mutex
> in ctx?

Yes, v2 will do that, and send the hotplug event from
nouveau_display_relink() once the locks are dropped. The work item is
only used from nv50_sor_atomic_enable() now, which can't take the
connection mutex, and a later enable that trains the link cancels it.

> Should nouveau_display_hpd_work() and nouveau_display_relink() verify 
> that
> both nv_connector->detected_encoder and connector->state->best_encoder 
> match
> nv_connector->dp_encoder before restarting the link?

Yes. v2 checks detected_encoder in the HPD worker and best_encoder in
nouveau_display_relink(), and leaves the other cases to userspace and
the hotplug event.

> Without setting nv_connector->dp_encoder = nv_encoder in 
> nv50_pior_create(),
> won't nv_connector->dp_encoder remain NULL on PIOR DP connectors, 
> causing
> both nouveau_dp_link_check() and this new HPD relink check in
> nouveau_display_hpd_work() to be skipped?

I'm not familiar with PIOR beyond some poking in the code--which
I now know is the external ANX9805 transmitter some NV50-family
boards use--and I have no such board to test it on, but I believe
the answer is yes. Before 633716501c94, the link check looked up any
DP encoder, including one on a PIOR, so my v2 draft sets dp_encoder
in nv50_pior_create() as well. nouveau doesn't get IRQ_HPD from that
chip, so what this enables there is the restart on HPD reassert.

> Should nouveau_display_fini() cancel conn->irq_work before
> cancel_work_sync(&drm->hpd_work) and cancel conn->link_bad_work after 
> it?

Yes for both. The irq_work part predates this series, so I'll add a
separate patch for it in v2, fixing 773eb04d14a1 ("drm/nouveau/disp:
expose conn event class"). f60849975a88 cancels it in
nouveau_connector_destroy(), but that's after drm_mode_config_cleanup()
has freed the encoders. link_bad_work is cancelled in the same loop,
since in v2 hpd_work no longer schedules it, and only on system
suspend and unload: its hotplug event can probe the connector, which
waits for runtime PM, and that's also why hpd_work isn't cancelled
on runtime suspend.

> Unlike nv50_msto_atomic_check(), which guards its check with
> !state->duplicated, won't nv50_outp_atomic_check() return -EINVAL here 
> and
> cause drm_atomic_helper_resume() to fail the entire multi-CRTC resume 
> commit?

Yes; good catch: drm_mode_config_reset() makes the restore a modeset,
and failing it leaves every output dark after resume. My draft for v2
doesn't fail a duplicated state, as nv50_msto_atomic_check() does, and
leaves a link that can't carry the mode to the enable path, as for a
DPMS on.

> doesn't this call nv50_audio_enable() (invoking nvif_outp_hda_eld() and
> notifying the ALSA audio component) on an untrained, detached SOR 
> whenever
> the connector's cached display_info.has_audio is true?

Yes, the same as in your review of patch 2, and I'm fixing in v2 the
same way.
