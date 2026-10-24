Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EC606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=empyreal.works header.i=@empyreal.works header.a=rsa-sha256 header.s=protonmail2 header.b=rYBo8cla
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F86310E45E;
	Sat, 24 Oct 2026 22:59:02 +0000 (UTC)
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B7EF10E11F
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 01:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1792805632; x=1793064832;
 bh=c5DHhzFtVYI0VDNuw0PcYgMp0bx+/sbaWrxAWif8Ntg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=rYBo8claf2lmAiAOKKYb3wwrphQAj21ecsxqNsFw8hDZiCJbEUTaxQzmG+o/Q2od6
 lEG1RcXdjAyXYcrni9I+9PjpWz3qqKqfXo+ydM7hIaIvm6VqjxrP42m4BhW7oppv9i
 ogrfpUvkW8TensYGHheGwAh8zcCcTXyDqF+Ve/1aBjx39NvsltI4w6oZysdc7LYUQ1
 3RK1w3RyoAsSbR4/T+ae68Rm2naHqrFflW4mEWdJGQketGW1hST/h2MLBcQzAGBsrL
 mZO0rzObO8/O1uMQhdTG1DW0VU42El4KBmLcdNFiSWgFEEjcZTtUe7m7wYO0pQBoXe
 WAROg+8syCl7Q==
Date: Sat, 24 Oct 2026 01:33:49 +0000
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 chen-yu.chen@amd.com, ray.wu@amd.com
Subject: Re: [PATCH v2 1/4] drm/amd/display: keep custom brightness curve in
 userspace domain
Message-ID: <179280560760.1179989.11396695208074498725@empyreal.works>
In-Reply-To: <797bb933-adf3-41c6-8421-ffc3bd6948f9@amd.com>
References: <20260902-brightness-cover-abf809f2@empyreal.works>
 <cover.1788388049.git.arc@empyreal.works>
 <8ec5dc8922407924f771d353cb7f2dd1846553ae.1788388049.git.arc@empyreal.works>
 <797bb933-adf3-41c6-8421-ffc3bd6948f9@amd.com>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: 127baa2e3b59a63e08b1254d5c5e4b051f4d8519
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/12/26 22:06, Mario Limonciello wrote:
> There has already been some competing changes for how the power module
> integration handling works in amd-staging-drm-next.
>
> I wanted to see how your series was on top of it, but it doesn't apply
> anymore. [1]  Can you please rebase your series and re-evaluate?
>
> If it still makes sense (in your view); please send out a v3.

Thanks for trying it. I rebased onto amd-staging-drm-next (77f548b12).

Patch 1 is still needed: convert_custom_brightness() still adds the
firmware minimum before convert_brightness_from_user() adds it again.
Since Ray's "drm/amd/display: map PWM brightness through custom
backlight curve" that only reaches AUX panels with a custom curve on
staging, plus PWM panels on stable kernels before the power module.
v3 has patches 1 and 2 only:
https://lore.kernel.org/r/cover.1792805565.git.arc@empyreal.works

Patches 3 and 4 overlap with Ray's change, so I'm dropping them. Two
things in the new PWM path look unintended, though. Numbers below are
from a ROG Flow Z13 (GZ302EA, Strix Halo) on 7.3.0, writing amdgpu_bl1
and reading amdgpu_target_backlight_pwm. ATIF reports min 12, max 255
and a 49-point curve (50% luminance at signal 98, 62% at 129).

- convert_brightness_to_millipercent() clamps the request to
  [min..max] before scaling it as [0..max]. Every request from 0 to
  3598, the bottom 5.5% of the range, gives PWM 3598, and the panel
  minimum of 3084 is never used.

- The request is mapped through the ATIF curve to a luminance
  percentage, and the power module maps that back to PWM through its
  LUT, built from the same points. The two steps cancel, so PWM follows
  the request one to one: 25% gives 16576, 50% gives 33153, 80% gives
  52428. By the panel's own curve that is 35%, 62% and 86% luminance.
  Passing the request straight through as millipercent would give 25%,
  50% and 80%. If sysfs values are meant to stay signal levels this is
  fine, but then the custom curve no longer shapes the response on
  these panels.

On AUX, brightness_mask is still ORed into the millinit value before
mod_power_set_backlight_nits(), which is an intermediate unit (the
Sashiko finding from v2).

If these aren't intended I can send a follow-up on top of Ray's patch,
or leave it to him if he prefers.

Thanks,
Andrei

