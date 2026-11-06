Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E2606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PkEhJckr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC77112D69;
	Fri,  6 Nov 2026 13:33:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C8D6112D69
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:32:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA327605EB
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C5F1F008A5;
 Fri,  6 Nov 2026 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971975;
 bh=laylJPCMynshSK98f91Zvy82RDmIpYel/WAUUUDe9OM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PkEhJckrDBykQsP/Hf9hiejV4LC9EHg56o2gxprntiIk8Zu8O3uzTB6ogFuTRVwq0
 ut0rjKXvHqdLlHF19b6k7xakTtx2j6WyV4jhI2ZJSkYGzuetDb5PZrdYSxj7iogpnS
 dRWzvvjtffwJLLqI9E0RZuYfvKyEL1zuoB8eQeqCp0sLRo72a41XtEnUfuw00I/SfG
 SVWSbDtBsiky03JWxYWU1FcsOjTV4G6mTsIFFv3KO7Ls082uF24O2TzGYQY97tl7Co
 Lo/ils+OJpgzNJJJjuVTOYV8UXFoPKHFuhlryHz9kgX070kJS0GT6hieaPzh7aZaTi
 /MSRW0xiSPglA==
Message-ID: <sashiko-outbox-201470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/39] drm/tests: hdmi-state-helper: Handle EDEADLK
 in the color format test
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-4-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-4-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:32:55 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/tests: commit message inaccurately claims semicolon removal
  in 420-only test
--

commit ac8d010a94febdc01497daf4383ddc8df4f79781
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: hdmi-state-helper: Handle EDEADLK in the color format test

This commit adds the modeset lock backoff and retry pattern to
drm_test_check_hdmi_color_format() when atomic state helpers return
-EDEADLK.

> Add the usual backoff and restart pattern, and remove a stray
> semicolon at the end of drm_test_check_hdmi_color_format_420_only().

[Severity: Low]
This isn't a bug, but this commit only modifies
drm_test_check_hdmi_color_format().  The stray semicolon at the end of
drm_test_check_hdmi_color_format_420_only() was already removed in the
earlier commit "drm/tests: hdmi-state-helper: Handle EDEADLK in the
420-only test".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D4
