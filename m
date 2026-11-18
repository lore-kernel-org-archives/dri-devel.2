Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE510606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=MDIIWD3t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6B910FBD7;
	Wed, 18 Nov 2026 12:46:35 +0000 (UTC)
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch
 [109.224.244.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1506C10FBD7
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795005987; x=1795265187;
 bh=Sn4cANMWyarnlPlhcBZPq4AKMNRJPm8dufLXYR0px+c=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MDIIWD3tYdAeZiRc7hMp33z7pf5NOfwOjc6a7D3ijVUBP248POhCYDKUU7tDFZY1b
 MbtB/ueoVLqe44G58j3TAck8J11BkxeAqTmrEML72OBu2++puuYV4mNicVQRfzg8zY
 WjJwCOcHMIUxOYPvyEuySlvRGWkjfzxeUYfQZPMJLZz9Q3zzr3ktL//4sE71nOgc8T
 IXk8XcYDnMQ7XkYrY/8enC6IcA8j7myIIU4DAZoea+oaE9nZbvNYQwMDWlR5ZvZe8y
 dPQA6HeDmSYcBkVfmHxCxPkXcBGQ/+76EK/TvGghbtZB1EFz0476AGhkiKZINJDaar
 EdgUb+gZAJ3dQ==
Date: Wed, 18 Nov 2026 12:46:22 +0000
To: Mario Limonciello <superm1@kernel.org>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: simonit.orig@gmail.com, Richard Hughes <richard@hughsie.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
Message-ID: <QU464501lRPW3X8es-jXBFOvvwqS3eKR3HRS33U6x6o5eYC6h5AKV7f3ZXRCaU7-sEcupJMHereqyDUsUSG_fsOMNwvGO_CcZRKsz1AgObk=@protonmail.com>
In-Reply-To: <c6d79680-1fd2-4e71-9d00-616010b7727c@kernel.org>
References: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
 <20261115082042.1902826-1-Wayne.Lin@amd.com>
 <c6d79680-1fd2-4e71-9d00-616010b7727c@kernel.org>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: 39760bd241fcaddbc997a6c33d529836ac9500f3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Wayne, Mario,

48b8c06b05ad ("drm/amd/display: Route connector DDC over AUX for native
DP sinks") in amd-staging-drm-next is v2 of this patch, not v3 [1].

v3 added a NULL check on ddc_service->link. Without it, the existing
KUnit test dm_test_i2c_xfer_no_ddc_pin(), whose ddc_service has no link,
dereferences a NULL link and panics the UML kernel. sashiko-bot pointed
this out on v2 [2]. It reproduces on amd-staging-drm-next 8dd68a79583a:

  RIP: 0033:amdgpu_dm_i2c_xfer+0x52/0x210
  Kernel panic - not syncing: Segfault with no mm
  ...
  dm_test_i2c_xfer_no_ddc_pin+0xaf/0x1e0

Only 670 of the 1931 amdgpu_dm tests get to run.

I don't think picking up v3 instead is the answer, though. From reading
the code, sashiko-bot's DP++ concern on v3 [3] looks right:
link->aux_mode is only written in detect_link_and_local_sink() after
detect_dp(), and nothing clears it on unplug. After a native DP monitor
is swapped for a passive DP++ HDMI adapter, the adapter ID read in
dp_passive_dongle_detection() would go over AUX. v2 doesn't have that
problem, because link_disconnect_sink() clears local_sink before
detect_dp().

In the driver, a non-OEM adapter always has ddc_service->link set
(amdgpu_dm_create_i2c() already dereferences it), so I think only the
test needs fixing. I can send a test-only patch that gives the test a
zeroed dc_link. With it, all three i2c_xfer tests pass and the suite
runs to the end again. Mario, if you'd rather fold it into a driver
follow-up, I'm happy to test that instead.

[1] https://lore.kernel.org/all/20261110-superm1-amdgpu-ddc-v3-1-9436b04d1e=
31@kernel.org/
[2] https://lore.kernel.org/all/sashiko-outbox-195461@kernel.org/
[3] https://lore.kernel.org/all/sashiko-outbox-207767@kernel.org/

Thanks,
Eren
