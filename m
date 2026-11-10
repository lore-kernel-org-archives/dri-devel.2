Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73E606A33E
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=ApIoaniH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55DB410F94B;
	Wed, 11 Nov 2026 08:22:48 +0000 (UTC)
X-Greylist: delayed 474 seconds by postgrey-1.36 at gabe;
 Tue, 10 Nov 2026 14:03:52 UTC
Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch
 [109.224.244.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5DC10E07A
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1794318838; x=1794578038;
 bh=kfFJbXidv7eWx9tBxtx/Gz4OMHlW9XqVfa9vdnbCIz0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ApIoaniHSGKqyXM9rRTWU+i5Wjf0L5u1lAJljHe3tRLr/ZxX8Mv2nGqwd9aB5HThz
 tccnSn/HED7Xd9OIEh6Y2uRo97oQ1AjbGsyee/qxHMEtxjYrUU2qp9NSoUwAOqRwAQ
 HQTlFGv/w3T+fWr/gahxa1rmfFrGnBhEDl4p+WMrUnw2KEX+pFyLGP90Ff4taW1Ufv
 JF0Hj4Ipz7R8xyeVAY0hcC7ioaxpOvKepYvviBBCMGreg4kwlZL3Oyam/T2wLWuj7a
 NE6h3HN32+sS8zFFZrZ+iBggjAm+iMyraZVPeQPFYKE2BbdP9XG1ZtF1mhz29FBmi3
 dcdVMXffrJhyA==
Date: Tue, 10 Nov 2026 13:53:50 +0000
To: sashiko-reviews@lists.linux.dev
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] drm/amd/display: Initialize FRL status polling work
 once at DM init
Message-ID: <TZOFbwLq3A3VPag4HNQdStqYx0Am2XREwC5jsvikME_tKyWM7-I9y9MhWDjHxD4c6sSE2tCcjX8EZnlj7k9lc_iwId8NliFF5-hJYpKUpAs=@protonmail.com>
In-Reply-To: <sashiko-outbox-206215@kernel.org>
References: <20261110-frl-polling-wq-teardown-v1-0-0ff028d5c35b@protonmail.com>
 <20261110-frl-polling-wq-teardown-v1-1-0ff028d5c35b@protonmail.com>
 <sashiko-outbox-206215@kernel.org>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: 7dc270164d3ddcc60347a8ca0b3f0162782453dc
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 04:35:38 +0000, sashiko-bot@kernel.org wrote:
> 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm") original=
ly
> initialized hdmi_frl_status_polling_delay_ms and hdmi_frl_status_polling_=
work
> once inside amdgpu_dm_init(), and 0e967e086e75 ("drm/amd/display: Extract
> connector and encoder code to amdgpu_dm_connector") moved those two lines=
 into
> amdgpu_dm_connector_init_helper().  Should the Fixes: tag reference that
> commit instead?

Yes, thanks. 5c9b8b27a883 initialized the work once in amdgpu_dm_init(),
and the per-connector initialization came in with 0e967e086e75. I'll
change patch 1 to

Fixes: 0e967e086e75 ("drm/amd/display: Extract connector and encoder code t=
o amdgpu_dm_connector")

in v2. Patches 2 and 3 keep 5c9b8b27a883, since the missing teardown
and the unchecked workqueue pointer date back to that commit.

Eren =C3=96zen

