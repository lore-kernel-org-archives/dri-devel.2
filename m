Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164BBC5B574
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4ADE10E29E;
	Tue, 11 Aug 2026 07:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="DPICmu4A";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1C610E298
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:46:58 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so20875945e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 00:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1786434417; x=1787039217; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lb5ET+WzzMHF6IHDftmOMyIKThUmSRKYzy1eFtIR7Vs=;
 b=DPICmu4Anwh0SrG9mJrecG3zSf39NbDORse8jN2cfVPMpzL2XkrUvhP0IdoKAJkgo/
 hnu8D/Cqf+B+v4ilPNFdCm9S2qQ1A+Cap19vke3t/rO9SxlxflgU/xX6mJbVKW/5+Lc5
 ea8fWEj5fb8i4QH6VealWLzHl6XTj4pFVB/dsiC/lrm5MwVD4qHENG4zp7FConEBV4NQ
 QAkvoMWLBCfWEETX3vNwD5bLQgdCOmn/UlS8QLYcGYQc2xTtwkiQ8ekdCyEn+PDskJGi
 u7sNQViCPzfpdtRzIndRI5tacKbpj6QFpiy4z1w+flJSc2nm0nV889nDyb2DHb/yvWiI
 m0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786434417; x=1787039217;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lb5ET+WzzMHF6IHDftmOMyIKThUmSRKYzy1eFtIR7Vs=;
 b=gEqW6bLL/4XSwM8JJPxUsVYoeCstDD1dGu9q3hHG9pGD4NJVD5c6W7F8eMvwX0MO+7
 FTPRfhLDheE/FmqY3dwSq52SmZlAok4ybuzpXcVLiu0NP5Kaq2l9ylWNbX+ez7ZxVwy3
 hmlGxgfmiClWAm3Veij+PrzZBz+74l0w2NqIKIPUP0HR+fbPFvd9wI5O9Ah7T61IFuC3
 dn7AfrAJD0cXGva4qt019RzgK/7/QcqdG792gpSpdWVoQj0S7luxIqlSrUNpJ1G2iTyH
 2aFavGgNHCD31A4jqv6RyDE+6qOMCq4On9mWGiJD6gjbLe0ANEs8YMp8RZtklm85d3EB
 GuFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnujtlBKrPUMyhPWn2xl2UPD4SlHeVoXn9B7HYVy1OwagIH/T9p9gsaJm/oewDw2wFHnx6be/0Hy4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQh1F+YMT+ZaNh+jgP/rB/z3Boe0VayMTNnZrH4uZsmIH4R+7f
 3CFul4dQYnOcv3V6yXCPMY4rLVHEySjDIBcK9ZncQELFRjvsQnLFG5xGI4TTeMLiaC8=
X-Gm-Gg: AR+sD11VXgFv05ffOyLmBvkLI78xHnc1INItswFsth/qTvhNPsvozYxHzIsVlyRCche
 zEYoPk98dM+rdsxhL7XO3dm0uem5zV0IB/J1YxR7RkrHDBZDT3Z3JNOiD3LNUoJeA7Cwm/ZOhEl
 zc/HXPzde7xq5D2ltE51ScQ9/E8QpBWaVsjJtQ3+yhNaqqp+UWWKbQFL27ZtpSvWdpGqkIQdmbO
 zLaV2UAaFdqreeQWzJZDx2ddxn9bOVzNAHlRa/HQsuJTk+ONFaAfHl5Jj0L460Bw5c0EApzfM8W
 6t8URNsD8gJ8raymHZnuDOZKdU8plB7CC2kO7JidWCpYnWSkQBf5PczAP5z0qQYhWjIYSfAtv7t
 q2DH4a+CHBi9+iQFJzuBxKWefgn3VGhL8guOFN6Y826XhFe4eSCHyKHdAPdJuDs+gYqPUcFeM3b
 r8ETgcDohklgUVp6sSC8nMUJqELtpJOKO3AG/L9GSrDJ0Yj+0/nFcpRtQOZo4TVx09uL6MFHsiQ
 7TXUecEaA==
X-Received: by 2002:a05:600c:3114:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-4997844f628mr20367895e9.12.1786434416734; 
 Tue, 11 Aug 2026 00:46:56 -0700 (PDT)
Received: from [192.168.0.116] ([90.249.211.112])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e647acsm21670595e9.3.2026.08.11.00.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 00:46:55 -0700 (PDT)
Message-ID: <938ef65f-231f-40e9-a9b1-327d5d91e53a@ursulin.net>
Date: Tue, 11 Aug 2026 08:46:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
To: Luke.Wildhardt@proton.me,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "dakr@kernel.org" <dakr@kernel.org>, "phasta@kernel.org"
 <phasta@kernel.org>,
 "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On 09/08/2026 00:33, Luke.Wildhardt@proton.me wrote:
> Since the DRM scheduler default policy was switched to FAIR in 7.2, sustained 100% GPU load in-game on my RX 9070 XT causes severe performance degradation. In the example title running through Proton, Project Silverfish, the foreground application degrades to roughly 10 fps or freezes outright while audio continues, and the KDE Plasma Wayland session can lock up entirely, requiring a reboot or killing the compositor to recover. The problem is not limited to games. Running the game in the background + alt tabbing, then playing a YouTube video can also cause the entire desktop to freeze.

Was there anything interesting in dmesg then the total UI lockup happened?

> 
> Then, if the game starts to stutter, either alt-tabbing, or opening up a menu in game (which reduced the load on the GPU) immediately stops the stuttering.
> 
> The issue is reliably reproducible under sustained GPU saturation, although the time-to-failure varies. Increasing shadow load (which decreases in-game frame rate) substantially shortens the time-to-failure.
> 
> In game, MangoHud does not reveal any frametime discrepancy.

What exactly did you mean by not revealing discrepancy? Game is at 10fps 
and HUD shows 10fps? Or game appears to stutter but HUD shows "normal" fps?

> Bisection / test matrix
> 
> Reproducer: Project Silverfish (Proton) at settings that saturate the GPU, with a second GPU client active (browser video). Other titles show the same symptom under sustained load; I have not yet re-tested those specific titles against the fix.

Could you list the other titles which showed the issue?

Regards,

Tvrtko

> 
> Kernel	Result
> torvalds/master stock	FAIR (default)	FAIL
> same as above + reverts below	gpu_sched.sched_policy=2 (FAIR)	FAIL
> same as above + reverts below	gpu_sched.sched_policy=1 (FIFO)	PASS
> 7.1.5 release	PASS
> drm-next	FAIR (default)	FAIL
> 
> Reverted Commits:
> 
> d09339388b77 drm/sched: Remove drm_sched_init_args->num_rqs
> 2833a0512b4c drm/sched: Remove drm_sched_init_args->num_rqs usage
> 16e7698bc04d drm/sched: Embed run queue singleton into the scheduler
> 77a6809f1dc3 drm/sched: Remove FIFO and RR and simplify to a single run queue
> 45c211ddf92a drm/sched: Switch default policy to fair
> 2462a0ce23b0 drm/amdgpu: Remove drm_sched_init_args->num_rqs usage
> 
> 
> 
> Kernel (failing):  7.2.0-rc6 (stock), also current drm-next
> Kernel (working):  7.2.0-rc6-default-revert-00006-g7e5de9b07e3d with sched_policy=1
>                     7.1 release
> Distro:            Arch Linux
> Session:           KDE Plasma 6.7.4 / Wayland (KWin), Qt 6.11.1, KF 6.28.0
> CPU:               AMD Ryzen 9 9950X3D
> RAM:               64 GiB
> GPU:               Sapphire Pulse Radeon RX 9070 XT
>                     03:00.0 [1002:7550] rev c0, subsys Sapphire 1478
> Motherboard:       ASUS (AM5 / 800-series chipset)
> Mesa:              26.1.6-arch1.1 (RADV, driverVersion 26.1.6)
> Vulkan:            instance 1.4.357 / device 1.4.354
> 
> 
> 
> 
> On the same reverted kernel build, changing only gpu_sched.sched_policy from 2 (FAIR) to 1 (FIFO) changes the result from reliably failing to passing extended stress testing.
> 
> 
> 
> Possible mitigation options
> 
> Given that 7.2 is late in the release cycle and 77a6809f1dc3 removes FIFO/RR as selectable policies, there is currently no runtime workaround for affected systems.
> 
> 
> Revert 45c211ddf92a so FIFO remains the default while FAIR remains available for further testing.
> 
> If necessary, also revert 77a6809f1dc3 and dependent changes to restore runtime policy selection.
> 
> Alternatively, fix the underlying FAIR regression if a suitable fix can be identified in time for 7.2.
> 
> 
> I mention the revert options because the justification for removing FIFO/RR included the absence of known regressions relative to those policies. This report appears to provide at least one counterexample.
> 
> 
> I am willing to test patches responsively and collect data if necessary.
> 

