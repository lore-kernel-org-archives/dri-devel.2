Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2449606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=thelittleman.net header.i=@thelittleman.net header.a=rsa-sha256 header.s=20140415-thelittleman header.b=kXdgrsbh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150D610E3DF;
	Wed,  4 Nov 2026 08:58:02 +0000 (UTC)
Received: from mail.thelittleman.net (mail.thelittleman.net [91.99.148.243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E57388BE3;
 Tue,  3 Nov 2026 20:56:40 +0000 (UTC)
Received: from mail.thelittleman.net (localhost [127.0.0.1])
 by mail.thelittleman.net (Postfix) with ESMTPSA id B10755F92D;
 Tue, 03 Nov 2026 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thelittleman.net;
 s=20140415-thelittleman; t=1793739398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExnzUTE0DG5TrCl1w+XLfuekZrkRHbiJ/wFV76Oir+w=;
 b=kXdgrsbhw6IZn8qhmccYCYjphpymPYJOcr+RIR/2drcT1ks5n9oTt7iVulLu+hS4rl/sRW
 Hwli7fwhQdy38u1obI9j7dQAFs96Mo7EVDywtivrDBu/NlQKOvUNvXnnTZzBg1Vuln5bO7
 dZgDIDnujPlFgluNcy3/U6zccEDAZKE=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 14:56:38 -0600
From: "David R. Hedges" <linuxdev844@thelittleman.net>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, Lyude
 Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 5/5] drm/nouveau: don't let an IRQ_HPD hide a plug or
 unplug event
In-Reply-To: <sashiko-outbox-195933@kernel.org>
References: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
 <20261103-nouveau-dp-fixes-v1-5-892f4bd357cd@thelittleman.net>
 <sashiko-outbox-195933@kernel.org>
Message-ID: <201c6fefc6ddaee3915ba10ccbde80b1@thelittleman.net>
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

On 2026-11-03 13:45 -0600, sashiko-bot@kernel.org wrote:
> Can a separate plug or unplug event still be dropped if it arrives 
> while an
> earlier NVIF_CONN_EVENT_V0_IRQ is already pending for the same 
> connector?

[...]

> Should nv_connector->hpd_pending |= bits be moved outside the
> if (!(drm->hpd_pending & mask)) check in nouveau_connector_hpd()?

Yes. Since 016dacb60e6d ("drm/nouveau/kms: pass event mask to hpd
handler") put the event bits under that check, any event that arrives
between scheduling the HPD worker and the worker clearing
drm->hpd_pending is lost, and the worker can sit in
pm_runtime_get_sync() for some time first. That predates this patch,
but it's the same problem from the other side, so v2 will add a patch
that always records the bits and only schedules the worker under the
check.

> Would it be better to always run nouveau_dp_link_check(nv_connector) 
> when
> NVIF_CONN_EVENT_V0_IRQ is set, and only guard the continue statement 
> with
> !(bits & (NVIF_CONN_EVENT_V0_PLUG | NVIF_CONN_EVENT_V0_UNPLUG))?

I'd rather keep it as it is, but I welcome feedback from the
maintainers. With only this series applied, skipping the link check
loses nothing: nv_connector->dp_encoder is never set on nv50+, so
nouveau_dp_link_check() returns true without looking at the link. The
follow-up series that makes the link check work again [1] also restarts
an active DP link with a full modeset whenever the sink drops or
reasserts HPD, which covers a plug or unplug that comes in with an
IRQ_HPD. Running the link check as well would only add a second
retrain, or AUX reads from a sink that has just gone away.

[1] 
https://lore.kernel.org/r/20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net
