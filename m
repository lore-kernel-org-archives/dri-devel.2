Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B9606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=empyreal.works header.i=@empyreal.works header.a=rsa-sha256 header.s=protonmail2 header.b=iPQViv3Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572AC10E18B;
	Sat, 24 Oct 2026 22:59:01 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A0F10E17F
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1792805617; x=1793064817;
 bh=SfNKrYDUbhsFpG8WIg+D5PcDIxxVFiyLQ6Sahtn09yA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=iPQViv3Z/WmMNdRwF4v9O7+u4RQHOKmjRDcObENmqcjHBSFnbzvrcxqzm5wjWxLYs
 o3WHTIjc3Z6fPWAHFysuiGk8VCJCPxHQpvPbGLHuWeUHk2AyPbgU3FnSVJAWFwbfxX
 2ifEQDHoXcr0/rtgco13KFCuNvLZX7b813v2wn9mjiI/khOPJbrSM3SKu4BWOoyYRm
 yN5WExltMa6YHyBGtPzDAHrlRUa3WhPUg4eeUIxlBCZGvynrYAqjwExpHKecbWUgdb
 xkv+5BOpBO65jR6kzYVHAIL5xDeL1O8jkvlljzv0nCvOklYijsO1vdk+bye492Kzom
 PJKwGMp9YH2Ug==
Date: Sat, 24 Oct 2026 01:33:30 +0000
To: amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, chen-yu.chen@amd.com, ray.wu@amd.com
Subject: [PATCH v3 0/2] drm/amd/display: keep custom brightness curve in
 userspace domain
Message-ID: <cover.1792805565.git.arc@empyreal.works>
In-Reply-To: <cover.1788388049.git.arc@empyreal.works>
References: <20260902-brightness-cover-abf809f2@empyreal.works>
 <cover.1788388049.git.arc@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: 80549977febd08307ff58ae2b25cb6300093e4c7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:00 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

convert_custom_brightness() adds the firmware minimum before
convert_brightness_from_user() applies it again, so a zero request
through a custom curve never reaches the panel minimum. Patch 1 keeps
the curve output in the userspace domain. Patch 2 adds KUnit coverage
with a non-zero firmware minimum.

Changes in v3:

- rebase onto amd-staging-drm-next (77f548b12);
- drop v2 patches 3 and 4, which changed the PWM path to the power
  module; "drm/amd/display: map PWM brightness through custom backlight
  curve" has since reworked that path;
- describe which panels still reach the helper: AUX panels with a custom
  curve, and PWM panels on stable kernels before the power module.

The amdgpu_dm KUnit suites were run under UML on this base with and
without the series: 1897 and 1906 cases, all passing; the backlight
suite goes from 70 to 79 cases. The rebase and the test runs were
LLM-assisted.

v2: https://lore.kernel.org/r/cover.1788388049.git.arc@empyreal.works

Andrei Rusu de Castro (2):
  drm/amd/display: keep custom brightness curve in userspace domain
  drm/amd/display: test custom brightness with non-zero minimum

 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  13 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   3 +-
 .../tests/amdgpu_dm_backlight_test.c          | 294 +++++++++++++++++-
 3 files changed, 286 insertions(+), 24 deletions(-)


base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
--=20
2.56.0


