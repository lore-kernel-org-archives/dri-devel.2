Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F03ECCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B9C10E06F;
	Thu, 30 Apr 2026 00:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dZrRX3aK";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7685A10E05C
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 00:12:04 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8c70b5594f4so39756985a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777507923; cv=none;
 d=google.com; s=arc-20240605;
 b=S425o9Rl2cBBhMHUqVy67lIUjestFtqkM60BuiDoy82BCgTR1PXDughV+KwfFGyZqz
 jc/4CyKS7D5Ug2Sxzte0r4YcOynONMCvv+fr4gpQQ5zZbxsySA43NnTcvC3C8Ew7IiAR
 3EooCXB0CO6yqqp2taCzcsLOnBIU5bemjCrG0AIlsBUHjIvUK6W2j5qK94vYd2kopg/2
 Nu+oJFn391xvxgJCfqWJ17MXNKud2hjfDqLzpmR1cioUR7ip9eeclkfpQo4UDrovmogg
 RnOFSBlEaLETHeYiEtIZVrTj152D7bXcVmGtYIQHLSLQa9FsW08AgthloLMUu+LWsH2P
 +hAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3nEd8GhcPX0qnwWzFGTR107MFZJdj0/mrhBb3kZrZ6o=;
 fh=mWteUFSrlVxSzltiuZCbK6UGhcUsUmTQbcYSgfxpPNU=;
 b=jhW/KrfDbMqNTLYMojUczN6WSFHF9HJV3GiQpv/tQ1eAmHFxLd0GJ5dY42gv01bJjb
 22jeAUxp7sVzdKjwVswiW3w27epKsGHLCvHzjF419rrwLYoghwQ1SgU4TbOhWgca5NZj
 EiwP7RxeoPA+eO3Pl9+q6jjP7CueEZKGFSQFXaSXeR90UA84D1NjWJUAiIygHU+rN2g7
 uoX8zOAIf5G2xQRbP4deXYSOWUEYsrUD7fnwAwz+kUy44uFooK3Pj+NkjDd2JbaOaF6d
 OYTBnIPTPa7sVhhJeFNGdKGRvltprhNdtqrxz7L0eHggt1XHxXVvwu2SRUrOMKSKPoeO
 671A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777507923; x=1778112723; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3nEd8GhcPX0qnwWzFGTR107MFZJdj0/mrhBb3kZrZ6o=;
 b=dZrRX3aKGFkQvQSXfDwv1hvSx3I26wan+UsYB8T5pXBJ6ZsrrPTGfKUHdWrllA9pfB
 gkIl8sPpKGOwpwrFdPPmAcgo+m1f06TSHUdbzevbgYxeZ7mzuzogTGJc2Tqa5hRG2f1g
 DJLbiZ1DU4Ppv9wflBdcQeGtjS8J7Rb6DWUEWxk7EJqJ78cdOSvgoboDoOlvY4k8DclI
 lXp+2cNp8lA8qD8P/fodQBsphxt5kojGODV7HeKiPxNn7uMmnBEV1Y29FiQG9ipJUWEe
 ABeJCEZ/qpRqd3KBBDwHYGahe1mYMyYypd6/dbgBGUqwLH14sFSm9NYZPS+bgf1nCw0Q
 P+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507923; x=1778112723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3nEd8GhcPX0qnwWzFGTR107MFZJdj0/mrhBb3kZrZ6o=;
 b=rGJYahtGw2WQwLeJq/LgH0OY4xKIsxI1yZBPuWuNgj91d6LcMjSVTbtstZG8YcfKY8
 mQpND8xgGpsjXo0/plQbRL/HoYCbNe0qahpsBKj/myBnNSWEt0x87du6+ggRRO5dSkhH
 wMsUeC8VKNHRfjL/67g1X2eclo/w409rO7uyQEZbWVzeVplvk6NRS2Jq/GGKawIjURdZ
 MGF9Y0M2ZzJHchZV8g8ABvYRJ13BI00Lt3U9QzIZn8If7JkeWOv2ouluz5D++e840UVp
 QNHbmy5zM31GXnl7B8fR0zlpCb2LIJZcN0t1depq/+NZTRaxglswJNcmlkWCdPShsNtH
 xiAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KTukFS8BYBBi+cGBsOOpGjGKMjoRioAq9q3CIHz6alatqXrTKseJH27m08C3rSVYPZVj08lD8ZXw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyGn2BBQwLYn6L7z8kMgmtGuNkYH51npUFn4E3Mf/PlJsmmf9S
 hmjlYZYKoHSRd7kQ7x51LVBaiJ4uS2gO+TRJmtcYmWcH5deXrzzkSg+0WiEQoY2tq784xpGHHhT
 xtI63MFFsyHYgbWkXVl3ogQ5ppe3W5XU=
X-Gm-Gg: AeBDieu8+7Zc+Mf0wtwYE1f2/84j69balsSFIzHpol0OWSb+ExX/wfowRoGsjjB/j3+
 JjoMVigfNu16YatIzHC0OsH8Yj8LQTPqQ7ojnLfm0vRI04NGZEZajlaauaLhMdpjq8lVY21kA4u
 9QrWJCRTFXwgNuVpAgr/YMm6Z035eIRxIHbMvJsJ+SPaw2QgN0jaUg4KFZFPmrZpLJBy4RW5PzU
 ZN4yqrkMshYm+7d5z6NimlAX4G4RmKiGqfqSbLwiEFSkAMk4YdcOSSvETlHpU0MrbML2q6+66Ql
 WsJDzvV6Xq9zgn7BrKxF4cHAOsapzK4/vTvnuigevrjMRnq14fch622obnjzvg+bcdpTYrX+VvM
 T/lVYMRa5XQPC
X-Received: by 2002:a05:620a:4095:b0:8cf:cc59:c0a0 with SMTP id
 af79cd13be357-8fabaa2bf74mr36635085a.27.1777507923443; Wed, 29 Apr 2026
 17:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
 <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
 <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
 <5bd5ed0a-fef2-4bd4-b7a0-d263bcfb1c7f@ursulin.net> <87se8didkt.fsf@dancol.org>
In-Reply-To: <87se8didkt.fsf@dancol.org>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 30 Apr 2026 10:11:52 +1000
X-Gm-Features: AVHnY4Lx4MSky0CoYbtwC3YofIJZy4_67QHDp4CUlg5yy6McmmIsN_5LFWDlkIQ
Message-ID: <CAPM=9txEMjXVvxAOxx7GND5tQLO2sA7K49piXN=PBchNG11H7g@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
To: Daniel Colascione <dancol@dancol.org>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Carlos Santa <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
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

>
> Probably stupid question: for systems like my Lunar Lake Xe2, which has
> unified memory and (IIUC) no special cache-type or write-mode
> constraints for GPU mappings, would it be possible to use regular
> system-provided pages (e.g. from shmem) instead of going through the TTM
> pool and allow mTHP to provide the aligned and contiguous backing
> storage that the GPU wants? Something like GEM has, but maybe inside the
> TTM API?

TTM pool doesn't get used for system memory allocations in that case,
if you are asking for cached memory.

Dave.
