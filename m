Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1B606A31E
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=sqQTSvh+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDD610E074;
	Sun, 15 Nov 2026 15:31:54 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B0910E074;
 Sun, 15 Nov 2026 15:31:47 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSFN12TSMzMlwG;
 Sun, 15 Nov 2026 16:31:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1794756705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dz6MG60gYh1oeLl0y4lf8u/H7dQYN/8DWkBKEQ6CwTc=;
 b=sqQTSvh+xAjRqlex0bxOFYXJwzfxtpHvu1ebKWi17PaMpoEKBjksjyUchfyzV2bNTGSpmX
 ccK/Q4vPsK8FzxxB6J0p9fjcfNjrIjLSJtXXhHZSzx/phwuuBEjlCbSKKlahpS2bcdYhtC
 a6qmUWQyJUViEwYnNQD6A2cg51eTLVIp1P3wXna5juITUy2Obq1MJJ1DBJ2ZGKvER8Yq12
 LgZqlMlVaeVMATvil9ZxoND8EXrNMU39vAlXxAiSD5HH0e79PPAF/ECaxQNaCWI4rmGxj+
 WUQhyWdw95eUp+Bz33lMUvQNq5qTVxxSYjXhHLypPi1qvJtyVeo9Oqgsdd8AWA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Sun, 15 Nov 2026 15:31:44 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Message-ID: <159623420.13271.1794756704576@app.mailbox.org>
In-Reply-To: <sashiko-outbox-213691@kernel.org>
References: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
 <20261113-abm-sysfs-commit-v2-2-5808d17a7e89@hsal.es>
 <sashiko-outbox-213691@kernel.org>
Subject: Re: [PATCH v2 2/5] drm/amd/display: Don't force a modeset when the
 ABM level changes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jSFN12TSMzMlwG
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

> On 11/13/2026 9:07 PM WET sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Can a connector-only abm_level commit on a VRR-active CRTC drop active
> overlay planes from DC?

I think his is real. Before this patch, connectors_changed forced 
a modeset, and the modeset added every plane on the CRTC. Without 
it, an ABM-only commit on a CRTC with VRR active carries only the 
primary plane that amdgpu_dm_crtc_helper_atomic_check() pulls in, 
and DC's full update drops an active overlay until the next flip. 
The -EINVAL doesn't happen, since DM's private context still holds 
the overlay

v3 adds the CRTC's planes when the level changes, similar to how
amdgpu_dm_atomic_check() already does for color management and VRR
changes:

		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level) {
			ret = drm_atomic_add_affected_planes(state, new_con_state->crtc);
			if (ret) {
				drm_dbg_atomic(dev,
					       "drm_atomic_add_affected_planes() failed: %pe\n",
					       ERR_PTR(ret));
				goto fail;
			}
		}

I'll wait a bit longer for other feedback on v2 before sending v3

Hugo
