Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9BC606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QnYcNFZ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F243D11244D;
	Thu, 22 Oct 2026 09:41:21 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92A9710E317
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 15:34:09 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-5eae1276409so290770e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792596848; x=1793201648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TyKYR89dztucZkRvKJmuDPmnMeeGrPRrohNUsu403oE=;
 b=QnYcNFZ6SyioVcpkS4/6aJvPLM2F5RkMufKPC1Zs7l1Au9uRyD6RrNjX77C5Sy/ZIJ
 juYLGj8uIEGSu/aGrTg4fa0T4Hjs/Q+7elUlGNT7LnZqUtmBeajaznMUuwDaMByi00A3
 t6LWhzeghZGZl868rdekGmTMcAJQWy6TP7tFGEOV94NSxkFkBBRQklTh0eTQ0zHDl48O
 ZKT7ZxKxSQ+EFZq6WarNxAXD9jFinjJWupkwHgA96to1qL5OlIjk+yKSAToAe+NHkwWi
 nJD3PsAxygFHy/TVYcbk0nN5bEfb+GxlLCX3WAs0DO9OvU/DPHwSixmky59bTm45kK0d
 N4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792596848; x=1793201648;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TyKYR89dztucZkRvKJmuDPmnMeeGrPRrohNUsu403oE=;
 b=xNzihrvwSd2vrCNFzvT0xyaQapXp7dTwrjWGhzPsj+bckTv7sojY70bW0egWi85GHA
 TRTI8Dl7t6dNLYhW0DWD+26e8b+P2P1CDVKMEDs1LxdK3JukY6NjPT6QD/bb44M3AlVb
 Q8ECYkWKR84NOtnpSvzrZdlKAu2/4c+rRElmnyfkx4tQdEPZ4I+czrD2hTxLYD3kdBSm
 sg6q/ZclQy9zukKZAXjbCMzJ+oUI6zFwko22s7wXCm6qWrgEsg8F1mSWdHAsxr9Nh4Cu
 dXbFIQvHaXP2fFwNEsPzENmC7iHYU5yKKjaA5IN5M8tGOY+YV+1yRoulfdtieMwiaBcm
 UcQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJHD+5b9pUa3RGjEhjDpsXup4Vy1E+tIOIIE9Lsd6tC5LM74WDxeHOfOktlB/PuYwFoaadnpkpEEo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKadzivTx7FoXKcvSDwOTVNw1hGcudHNFJSl9QivYjzbTI5m2pE
 2YN8YgVpgi4U9UiXzn/sWMxEqDQk+ZQDli21xEwl2vuMIQVCFbTkDIl6
X-Gm-Gg: AYBFou1KKYWzbvk6ChelVzljf04VWJ5xBCeirnsMeDZSsvJusVWS/FJoLiolOgJxV0P
 bK43F54UY5T2zEANaip8RxBZ6FJhdYYqCrCb1HWyDXL3XoYtyGw2cZnffVA1+zw13kxKZ/JMgMq
 KqN7jQH1nudRUOr9KOHixL8N66IBMyKJ/wm8UtR+7ylbzG6gCJr1majVKPH+S2u5f3w1+Urv0B/
 snaC/E9PciMOzUHJdiiPQ/7Dkyw2vSe+3mgnBxIzt0vU9qN+e0P/D5x8o/c+OAdFl2HI0nZk++7
 CL7lkEOY34OBxkX+z9P2oRlSw/zFjJP+Oxczx5WzcbKc/zvIRFRd93JfLPlx5Z8641kY8EtLmSZ
 Sar1cCB1LpsLf2DsJpvAhqJ5jAd4/5vAxTYf3yXzKGBvrELN5QNteZ5qOK9hMIBt1euG27yH0Bg
 IRdpty53f4NAPQjtWHwc+fJpnruQF4yQtKwJb8G7iGiglQjUOmXoNdZyi6UL/mUvGl9SdSNKJUw
 Bhh+fCXCrM02v092Q124sUCaKYRmQtActu/PTtZGaT7s/CM0dGGon+XE51P8mWVeNSN6iE5aPH6
 eatvzmofFq/yZVRh
X-Received: by 2002:a05:6102:808f:b0:7cc:23e7:e743 with SMTP id
 ada2fe7eead31-7cc9263184dmr918810137.15.1792596848060; 
 Wed, 21 Oct 2026 08:34:08 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cc91f9c7f1sm3056156137.0.2026.10.21.08.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 08:34:07 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/radeon: fix VCE1 encoding on SI by handling the
 VCE interrupt
Date: Wed, 21 Oct 2026 12:33:44 -0300
Message-ID: <20261021153346.124285-1-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8c60afb2-cb0b-4aec-9237-2ea3404d2793@amd.com>
References: <8c60afb2-cb0b-4aec-9237-2ea3404d2793@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 04:10:04PM +0200, Christian König wrote:
> The fence handling on radeon should work completely without interrupts
> since those have been rather flaky on really old HW.
>
> So no idea why that actually crashes for you if the interrupt is not
> enabled, my educated guess is that enabling interrupts actually doesn't
> fix the crash but makes it less likely because of timing change.
>
> Would it be possible to just switch over to amdgpu instead? Or is there
> any support still missing there?

Thanks for taking a look.

On the interrupt: I agree I have not shown why the hang happens, and a
timing change is entirely possible.  What I can say is limited to this:

 - stock radeon: every encode hung within about 100 frames (many runs);
 - with the VCE ring semaphores disabled: no hang, but fences are only
   noticed by the wait timeout, about 4 fps (~256 ms per frame);
 - with the interrupt enabled and handled, semaphores left on: no hang
   in roughly ten minutes of total encode time (up to 1080p, plus
   several minutes of KDE's RDP server).

That is correlation, not a root cause.  If it helps I can test enabling
VCE_SYS_INT_EN without processing the fences from the handler, and run a
long soak test with two concurrent encodes.

One difference that may be relevant: on CIK radeon does enable and
process the VCE interrupt (vce_v2_0_resume() sets VCE_SYS_INT_EN and
cik_irq_process() handles src_id 167).  Only VCE1 (SI and Trinity)
never did.

On amdgpu: it works for me, I found nothing missing for this use.  I
tested it on 7.2.9 and on Debian's 6.12.113 with the amdgpu VCE1 series
backported: h264_vaapi encodes up to 1080p with DPM and runtime PM
enabled, no hangs.

The reason I looked at radeon at all is the distribution situation.
Debian 13 stable ships 6.12, where SI is driven by radeon by default
and amdgpu has no VCE1 support (that needs a newer kernel, which Debian
only offers through backports).  So anyone on the stable kernel who
uses VAAPI encoding on an SI card, here through KDE's RDP server, ends
up with a wedged GPU.

Since you are considering dropping SI/CIK from radeon, I do not want to
push a change you don't want.  If radeon keeps SI for the 6.x kernels,
what would you prefer?

 a) this series;
 b) disable the VCE semaphores like uvd_v1_0 did in 013ead48a843 (works
    here, but slow);
 c) leave radeon alone and just document VCE encoding on SI with radeon
    as a known issue that amdgpu's VCE1 support in newer kernels
    supersedes (even a one-line warning pointing to amdgpu.si_support=1
    would help people on 6.x).

I am fine with any of them, and if it is (c) please feel free to ignore
the series.  A v2 of patch 2 that fixes the CIK register issue found by
the automated review is ready in case you want (a).

Regards,
Matheus
