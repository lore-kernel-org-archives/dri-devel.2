Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C2606A331
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVF4flEQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7CD10E919;
	Tue, 10 Nov 2026 04:35:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C85610E919
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:35:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECE0D6370D;
 Tue, 10 Nov 2026 04:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8942D1F008A4;
 Tue, 10 Nov 2026 04:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794285338;
 bh=kwIgsDAeSidUnYqaWuKemLKIva1PyZqJNLpcmgcyYvQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AVF4flEQxN8xgjEf4t0pA8I8UZE3YPn8NLnDbcAbOy2o6TBzgK0v+zjWAwQk/JwoD
 c7aytxu7VxKiIs+ZpSq35Z/6ZplB3CZRuU1AWrFPzQ+IjSHDCnOVOSGAC/O40+920R
 I34QwaAHhvbinc5heYFUybPx+ywudsGG94g9Q+Dd6RKwQWMzyOJRV0PrQCuD/RaBJA
 eJe6hjHWi+ZHLl4Hgk084u0ok7zWdXQo3+T2IBbAfNGHJvcb3DzvPWCtWhCOM1hrN5
 7W02f6CDq8zHhavnc+++n9ZP28drqGIr2D+XUic3P4qiPJ1ZIMIR/YpcQpPGcptxLN
 Sc3TVkUXNhRyQ==
Message-ID: <sashiko-outbox-206215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/amd/display: Initialize FRL status polling work
 once at DM init
To: =?utf-8?b?RXJlbiDDlnplbg==?= <erenozen@protonmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-frl-polling-wq-teardown-v1-1-0ff028d5c35b@protonmail.com>
References: <20261110-frl-polling-wq-teardown-v1-0-0ff028d5c35b@protonmail.com>
 <20261110-frl-polling-wq-teardown-v1-1-0ff028d5c35b@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:35:38 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amd/display: Fixes trailer cites 5c9b8b27a883 instead of
  0e967e086e75
--

commit 3f93b63ddceded95cea3ea6ed4bbadf253534d70
Author: Eren =C3=96zen <erenozen@protonmail.com>

> drm/amd/display: Initialize FRL status polling work once at DM init
>
> hdmi_frl_status_polling_work is a single delayed work item shared by the
> whole display manager, but it is initialized from
> amdgpu_dm_connector_init_helper(), which runs once for every connector.
> That helper is also called at runtime from dm_dp_add_mst_connector()
> when a DisplayPort MST branch device is plugged in. If an HDMI FRL
> stream is active at that moment, the polling work is queued and
> re-arming itself every 200ms, and INIT_DELAYED_WORK() on it
> reinitializes the timer and work entry of a pending item, which can
> corrupt the timer and workqueue state.
>
> The work item belongs to the display manager, not to a connector, so
> initialize it, along with its polling delay, once in amdgpu_dm_init()
> next to the workqueue it runs on.
>
> Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Eren =C3=96zen <erenozen@protonmail.com>

[Severity: Low]
5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm") originally
initialized hdmi_frl_status_polling_delay_ms and hdmi_frl_status_polling_wo=
rk
once inside amdgpu_dm_init(), and 0e967e086e75 ("drm/amd/display: Extract
connector and encoder code to amdgpu_dm_connector") moved those two lines i=
nto
amdgpu_dm_connector_init_helper().  Should the Fixes: tag reference that
commit instead?

  Fixes: 0e967e086e75 ("drm/amd/display: Extract connector and encoder code=
 to amdgpu_dm_connector")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-frl-pollin=
g-wq-teardown-v1-0-0ff028d5c35b@protonmail.com?part=3D1
