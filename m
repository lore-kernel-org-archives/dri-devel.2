Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A2606A33B
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkG45L2L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A61E10E7EF;
	Wed, 18 Nov 2026 14:26:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1AB10E7EF;
 Wed, 18 Nov 2026 14:26:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C45D44DEC;
 Wed, 18 Nov 2026 14:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6210A1F000C5;
 Wed, 18 Nov 2026 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795012010;
 bh=paST2r9B7lYr/U+Ug8HSKC2nKjDGI2/u6pguTLjby80=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YkG45L2LBlsNeuUcP7X8Vj3f7ISeqpEVXBovAD42O5TVWsKiThIxEXr5/a7LC4v+t
 jhmF929/DNRZsqxm8bMf2fRrlA/F5T7R6HomOKtOrONUZbvu3Hl5zgUJ2DUSRYPQoY
 dHQYFxrWj/zluZQKk6JUDVTxnbpeou072MKgTwRy+EMPYDbEFsNqFP3Gf/3nNLaThf
 P31YsHXPsHP4uS77QJzTcqTQny1F6XffPPPyPMieQr9A2ogjWcpB6SCVRwVt3Q3BmO
 X0oHr1/ynt+4JYoLpMq9v9WekQUB1RYU1y7La3MBtKQVeNnYTZVqGjtBKEFoOAHyBG
 JnCGarKCiQgVQ==
Message-ID: <5386db0f-e9b3-4c62-bb2b-392cca4d761a@kernel.org>
Date: Wed, 18 Nov 2026 08:26:48 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
Content-Language: en-US
To: =?UTF-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: simonit.orig@gmail.com, Richard Hughes <richard@hughsie.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
 <20261115082042.1902826-1-Wayne.Lin@amd.com>
 <c6d79680-1fd2-4e71-9d00-616010b7727c@kernel.org>
 <QU464501lRPW3X8es-jXBFOvvwqS3eKR3HRS33U6x6o5eYC6h5AKV7f3ZXRCaU7-sEcupJMHereqyDUsUSG_fsOMNwvGO_CcZRKsz1AgObk=@protonmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <QU464501lRPW3X8es-jXBFOvvwqS3eKR3HRS33U6x6o5eYC6h5AKV7f3ZXRCaU7-sEcupJMHereqyDUsUSG_fsOMNwvGO_CcZRKsz1AgObk=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 06:46, Eren Özen wrote:
> Hi Wayne, Mario,
> 
> 48b8c06b05ad ("drm/amd/display: Route connector DDC over AUX for native
> DP sinks") in amd-staging-drm-next is v2 of this patch, not v3 [1].
> 
> v3 added a NULL check on ddc_service->link. Without it, the existing
> KUnit test dm_test_i2c_xfer_no_ddc_pin(), whose ddc_service has no link,
> dereferences a NULL link and panics the UML kernel. sashiko-bot pointed
> this out on v2 [2]. It reproduces on amd-staging-drm-next 8dd68a79583a:
> 
>    RIP: 0033:amdgpu_dm_i2c_xfer+0x52/0x210
>    Kernel panic - not syncing: Segfault with no mm
>    ...
>    dm_test_i2c_xfer_no_ddc_pin+0xaf/0x1e0
> 
> Only 670 of the 1931 amdgpu_dm tests get to run.
> 
> I don't think picking up v3 instead is the answer, though. From reading
> the code, sashiko-bot's DP++ concern on v3 [3] looks right:
> link->aux_mode is only written in detect_link_and_local_sink() after
> detect_dp(), and nothing clears it on unplug. After a native DP monitor
> is swapped for a passive DP++ HDMI adapter, the adapter ID read in
> dp_passive_dongle_detection() would go over AUX. v2 doesn't have that
> problem, because link_disconnect_sink() clears local_sink before
> detect_dp().
> 
> In the driver, a non-OEM adapter always has ddc_service->link set
> (amdgpu_dm_create_i2c() already dereferences it), so I think only the
> test needs fixing. I can send a test-only patch that gives the test a
> zeroed dc_link. With it, all three i2c_xfer tests pass and the suite
> runs to the end again. Mario, if you'd rather fold it into a driver
> follow-up, I'm happy to test that instead.
> 
> [1] https://lore.kernel.org/all/20261110-superm1-amdgpu-ddc-v3-1-9436b04d1e31@kernel.org/
> [2] https://lore.kernel.org/all/sashiko-outbox-195461@kernel.org/
> [3] https://lore.kernel.org/all/sashiko-outbox-207767@kernel.org/
> 
> Thanks,
> Eren

Eren,

Really appreciate the feedback.  If you want to share your test patch 
I'll fold it into what's currently v3 and give you a C-d-b tag for v4.

Simon,

But I still need testing this actually works for the issue originally 
raised on real hardware.

These unit test issues are just noise "for that purpose".
