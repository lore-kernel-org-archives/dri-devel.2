Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7F606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=zohomail.in header.i=@zohomail.in header.a=rsa-sha256 header.s=zoho header.b=HwbSgQT5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6452E10E077;
	Tue, 17 Nov 2026 11:45:59 +0000 (UTC)
Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0A510E53E;
 Tue, 17 Nov 2026 08:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794902425; cv=none; d=zohomail.in; s=zohoarc; 
 b=AgsbymWTlSHa8QCVJ9C4dlFXwNfBr00OTo6cjb7oWbohYX1PZsfAIkC4E2tytbiI0cNicbtKShhYr2l0l86qdeGk6pbrh719H9b+bYX1utoqUQdHNV5Wig6a7yNzJpNSQSUBGzcw729wwJqOxRDQ2YjghyMK2u+lX7pQLxlJ4hc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in;
 s=zohoarc; t=1794902425;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7URRG9JImOynmwbw8ccE41h3MMYLK0ullK2SAwBmlS4=; 
 b=Pi8v7ynYHEnK2vG9/MjIwgpor6WT9R5hVdxqCisaOb6HrWOGCHkSGJ3lp900hE+meoYyeUhpam8Zxy14ibe0ghECX53eY/bMfSFVtZEs5Ptyouupp8nRsCMlwuPgu0uIHEEs64fOOXacYSWnIykYG2Kly8eEWb1YcxRVuK6kKw0=
ARC-Authentication-Results: i=1; mx.zohomail.in;
 dkim=pass  header.i=zohomail.in;
 spf=pass  smtp.mailfrom=shivamkalra98@zohomail.in;
 dmarc=pass header.from=<shivamkalra98@zohomail.in>
DKIM-Signature: a=rsa-sha256;
 b=HwbSgQT50o7AhF9B8QFV8DLt4v6+QRQxC+Pz1ndpJUSvO/0D4BqjG3wL13AJ0YDZ5Mn0qomaKErUE45tZFHHT88IA92myqaR+caban3GbzzbU5G+uSImdY4O7XNcf140YZtPhsLCp90/dt38dWx8kjPc8PR+Fj9kmG61UrZdIN8=;
 c=relaxed/relaxed; s=zoho; d=zohomail.in; v=1;
 bh=7URRG9JImOynmwbw8ccE41h3MMYLK0ullK2SAwBmlS4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.in with SMTPS id 17949024245771010.9301360744533;
 Tue, 17 Nov 2026 13:30:24 +0530 (IST)
Message-ID: <be487787-e342-418e-a5a3-5770ee816e7c@zohomail.in>
Date: Tue, 17 Nov 2026 13:30:22 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] drm/amd/display: Commit panel_power_savings writes
 from the kernel
To: hugo@hsal.es, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Alex Hung <alex.hung@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>, David Weber <weber.aulendorf@gmail.com>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es>
Content-Language: en-US
From: Shivam Kalra <shivamkalra98@zohomail.in>
In-Reply-To: <20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 17 Nov 2026 11:45:58 +0000
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/11/26 19:31, Hugo Sales via B4 Relay wrote:
> A write to panel_power_savings stores the ABM level and sends a hotplug
> uevent, but the level reaches the hardware only on the next atomic commit
> that includes the eDP connector. Hyprland adds the connector to a commit
> only on a modeset or when a connector property it sets changes, so on my
> laptop the file read back the new level and the backlight never changed.
> power-profiles-daemon writes this file on every profile, AC and battery
> change, so none of its ABM changes applied
> 
> This shouldn't need a fix in every compositor. The file is for writers
> that aren't the DRM master, like power-profiles-daemon, and they can't
> commit anything themselves. Today they depend on the master taking a
> generic hotplug uevent as a cue to commit the connector again. Nothing
> documents that, and a compositor has no reason to read a hotplug event as
> "a property you never touched has changed". A compositor that wants to own
> ABM sets the 'adaptive backlight modulation' property, and from then on
> the file returns -EBUSY. The file has to work without the master's help.
> The backlight device already does: a brightness write goes straight to DC,
> with no commit at all
> 
> This series makes the write commit the level itself:
> 
>    1. Render the existing kernel-doc, which no rst file included
>    2. Add the CRTC's planes to a commit that changes the ABM level, which
>       the forced modeset used to do. With VRR active, such a commit would
>       otherwise carry only the primary plane
>    3. Stop forcing a modeset when the connector's ABM level changes. DM
>       already sends a new level as a stream update, and the commit that
>       added the modeset flag also added the CRTC, which is all that update
>       needs
>    4. Move the store tests onto a full pipe the store can commit to
>    5. Commit the level from the store through a duplicated connector
>       state. The write returns the commit's error and no longer sends a
>       uevent
>    6. KUnit cases for a connector with the CRTC on, off and failing
>       atomic check
> 
> Patch 3 also asks, below its cut, whether scaling can leave the same
> check
> 
>  From my reading, other commits that add the CRTC but no planes, like a
> change of the HDR metadata, can drop an overlay the same way while VRR is
> active. That needs a fix in the CRTC check that pulls in only the primary
> plane, which I'll send as a separate series
> 
> Hamza's v1 of the 2024 patch that added this file had no flush [1], and
> Mario found that the level only took effect on the next modeset [2].
> That patch's v2 changelog says "force an atomic commit" [3], but what
> was merged, commit 63d0b87213a0 ("drm/amd/display: add
> panel_power_savings sysfs entry to eDP connectors"), sends a hotplug
> event instead
> 
> Commit 8d20a066fa9b ("drm/amd/display: change the panel power savings
> level without a modeset") later applied the level outside atomic. It
> broke igt abm_gradual, and commit 95aaa207e9ef ("Revert "drm/amd/display:
> change the panel power savings level without a modeset"") reverted it.
> The objections back then were to sysfs overriding the DRM master at all
> [4], which the property above now covers. I didn't find any discussion
> that rejects an internal atomic commit
> 
> A write now returns the commit's error instead of storing a level the
> hardware may never get. power-profiles-daemon logs the error and tries
> again on its next profile, AC or battery change. Nothing I found reads
> the uevent for more than a cue to commit the connector, which the kernel
> now does itself
> 
> The commit is blocking, so a write can hold the CRTC locks for up to a
> frame while a compositor commit waits
> 
> Tested on my laptop (ASUS ROG Flow X13 GV301QH, DCN 2.1) with v3 on
> 7.3.4, under Hyprland with no modeset during the run:
> 
>    - 25 writes cycling levels 0 to 4 all succeeded and read back, with
>      nothing in the kernel log. A write sends no uevent
>    - I wrote 4, 0, 4, 0, 2 and 0 six seconds apart and read
>      amdgpu_current_backlight_pwm and amdgpu_target_backlight_pwm every
>      half second. After each 0, the backlight was back at full PWM by the
>      next sample. After each 4 or 2, the target dropped, to 25% of full at
>      4 and 52% at 2, and the backlight ramped down to it
>    - This series on top of "drm/amd/display: Leave self-refresh before an
>      ABM level update", with the panel in self-refresh before each write:
>      all five writes that changed the level took the panel out of
>      self-refresh for the update
>    - Writes of the current level return without a commit, so they leave
>      the panel in self-refresh
> 
> On a text console, igt amd_abm passed all five subtests. I also ran an
> IGT test that puts an overlay plane over the primary plane and turns VRR
> on, so the CRTC idles at the panel's 40 Hz minimum. On v2, a write took
> the overlay off the screen until the next flip. With v3, the overlay
> stayed. With VRR off, it stayed on both
> 
> [1] https://lore.kernel.org/amd-gfx/20240126222300.119292-1-hamza.mahfooz@amd.com/
> [2] https://lore.kernel.org/amd-gfx/1162e59e-3f53-4c84-b186-bb2f4642216b@amd.com/
> [3] https://lore.kernel.org/amd-gfx/20240202152837.7388-1-hamza.mahfooz@amd.com/
> [4] https://lore.kernel.org/amd-gfx/b117ccc0-6569-4753-9cb9-c304f9e50d30@amd.com/
> 
> Changes in v3:
> - New patch 2: add the CRTC's planes to a commit that changes the
>    level. Without the modeset, such a commit with VRR active carried only
>    the primary plane, and DC dropped an active overlay until the next
>    flip. Sashiko's finding, reproduced on v2
> - Patch 3: credit David Weber, who sent the same condition change in
>    August (Chenyu)
> - Patch 5: say that a compositor commit waits for the write instead of
>    failing with -EBUSY, in the kernel-doc and below the cut (Chenyu)
> - Link to v2: https://lore.kernel.org/r/20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es
> 
> Changes in v2:
> - Patch 3 (v2's 2): name commit b05e2c5e81f9 ("drm/amd/display: Update
>    ABM crtc state on non-modeset") as the one that lets the non-modeset
>    path carry the level, say the KMS property loses its modeset too, and
>    say "drm/amd/display: Leave self-refresh before an ABM level update"
>    has to go first
> - Patch 4 (v2's 3): set level 2 before the test that writes 0, so the
>    write changes the level
> - Patch 5 (v2's 4): return without a commit when the level doesn't
>    change (Harry). A write that changes nothing, or that the DRM master
>    forbids, no longer wakes the GPU. A write that a signal interrupts
>    restarts instead of failing with -EINTR
> - Patch 6 (v2's 5): test a write of the current level, check that it and
>    a forbidden write leave a runtime-suspended GPU suspended, and fold
>    the CRTC on and off cases into one parameterised test
> - Link to v1: https://lore.kernel.org/r/20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es
> 
> ---
> Hugo Sales (6):
>        drm/amd/display: Render the panel power savings kernel-doc
>        drm/amd/display: Add the CRTC's planes when the ABM level changes
>        drm/amd/display: Don't force a modeset when the ABM level changes
>        drm/amd/display: Give the panel_power_savings store tests a full pipe
>        drm/amd/display: Commit panel_power_savings writes from the kernel
>        drm/amd/display: Test panel_power_savings commits
> 
>   .../gpu/amdgpu/display/display-manager.rst         |   3 +
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  17 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 118 ++++++++-
>   .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 271 ++++++++++++++++++++-
>   4 files changed, 390 insertions(+), 19 deletions(-)
> ---
> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
> change-id: 20261101-abm-sysfs-commit-96a38de1ac66
> prerequisite-change-id: 20261113-amdgpu-psr-abm-update-next-de20bc23b12c:v2
> prerequisite-patch-id: c6cbeb4671914753ab7526369c2612039ae16504
> prerequisite-patch-id: efc64b5a0a1bc2d46494d4797b0d25447b174076
> prerequisite-patch-id: 496307c9687a947cfbfdcf1b6d0ad6ba1b6d4089
> 
> Best regards,
> --
> Hugo Sales <hugo@hsal.es>
> 
> 
Hi Hugo,

Tested this v3 series on top of your self-refresh v2 series on Rembrandt
(DCN 3.1.2), running 7.1.0-hugo-abm. All five amd_abm subtests, including
abm_gradual, passed on A/C.

My panel reports Sink support: no and Driver support: no [0xffffffff],
so I couldn't exercise the PSR-active case Chenyu requested.

Tested-by: Shivam Kalra <shivamkalra98@zohomail.in>
