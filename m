Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD395606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sgBJYGsV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43D710F301;
	Tue, 20 Oct 2026 07:36:37 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D23710E6CD
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:42:19 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cd623dfe420so1700710a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792424539; x=1793029339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iMgrhjGDM6hEQh8Aw9yzZbHzALMwxiGfaVEBL4NiDa0=;
 b=sgBJYGsV/JnjveaYYQX6Ir7AadWcY+RWGHJ1uHoizhC0W4BeWnqeAURKDmDZTxUs8j
 GLhVLovoU0rZDqQK0k/in6F38+gTiv237yyl5MG3/NVD4kkPdtswH5mX01LFyKFV3CaV
 YGhroGYzu+9/pQ+JgGWN+S0drdlQrCWNnpx9cluoFJ1ozjdTM6QpgXkWza8hL/mmTFye
 nsw1do875iKTAr7sIFFGpWxHdsakd0zUxmbEuA1t5zOxugexmnrTFLG9Zm91PMV5PgJ1
 EBkLJX0X1kZyEeZGH+lSLROA0dLDZxzMm+JAZeA68F88szzZeUVaTbRaIEMSG0OYJ1lE
 aAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424539; x=1793029339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iMgrhjGDM6hEQh8Aw9yzZbHzALMwxiGfaVEBL4NiDa0=;
 b=DnnPWQzPnN5Ajewvss/r1+hJ4d1lo30xHRcPC2HkD1QyHnGDcL09fnnp4rV0Qn9rgN
 oEfgNS3M1ikDLDV7QtvOjmFuj2FP5RTcrJwRsgaZwKuOd+485Yxz+TRJVm0CjSZyRBUK
 2A3lyETbGtviv+azrfVaj/bc1dPx8Gd+J5xPRQy/Y7QIZR4yt3nv2CE+F+EhJPO/tchu
 qUgIAvu16+gmwHUqqvWlyT8jxQ1q2ObHGKvCBCm3K4imME3BFzLr3QGItBp/vfjjsKH2
 IQcSbvK3hHMqQG6EC+OraxInb7iRvhMWdPl6F+3M68pRe0BVy90KCFXi1fR4MQketIb7
 dx9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeGX29K43lGOTLmXCwgGiA6B9KTSLgsqyy1v1foM9bm58rcHudS4lxiQ9/MTQERsGu8HVfTtS1ERM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJnOJfenuB2NdQnp9sC+1Y1W5keK2zYkFipBA2gR/WhanddQ7MT
 n6IYO/RKarOpDYy+LlVF6vKSU2NXr6u8lkaOyeLboXP9vdg3KN1RsQTz
X-Gm-Gg: AYBFou1FYXS7JP6d8KApaH4VKbjySFGsHEiiNUNOEZOV9CtrfDs77sznUDtlrf1nufz
 4owVNUGSIdO2ioWpeXtAB/T74nzXol7ECRgjk004aAa8J65d8cWgtty8RqHPPvD6I2+l1tMOcZU
 TAvdeNNe6JHGxsllNTQ8nKSq1unmdsptAfnd+MSpg0UoDrEXlB8b/SVbJquDFLvu6qZd33mgZZ+
 5DVT9gPxiJg0iMGItRo9xqFryaEMIIikq9+JwuKgIKIcym60tZpEnVzUS4vnMSSxvzIawtcq5/4
 sCRDDSpZQcDskl/251VT3KWyoAZkWxSOYfshRp1EQqTA522NRwf9O5LHsVLl5rVbikolkhhQ4qY
 wV/HXoAiOw5H9y9p1hPkCsJiFW4I35HCLKTxE1Uq0OUWuANgYfJwV1YuQSMDIH32eYreLsNdjHB
 noJYP/0YB2uniR9A9bwKj2FjxDLzOKEotIB7ofHahvvS+i7k68BtmCgOu5NMGFMBRY0hkZ
X-Received: by 2002:a17:90b:3d4e:b0:3ab:2c2b:1026 with SMTP id
 98e67ed59e1d1-3acef0c8911mr6398917a91.34.1792424538542; 
 Mon, 19 Oct 2026 08:42:18 -0700 (PDT)
Received: from hachimi ([101.5.170.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549ee946sm3926364a12.20.2026.10.19.08.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:42:18 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: tzimmermann@suse.de
Cc: airlied@gmail.com, decui@microsoft.com, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 longli@microsoft.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, regressions@lists.linux.dev, simona@ffwll.ch,
 ssengar@linux.microsoft.com, stable@vger.kernel.org,
 xlfylawarthur@gmail.com
Subject: Re: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank
 timer
Date: Mon, 19 Oct 2026 23:40:43 +0800
Message-ID: <20261019154121.6257-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c238f4ff-d5d8-4a9a-8773-793bd9056c9b@suse.de>
References: <c238f4ff-d5d8-4a9a-8773-793bd9056c9b@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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

Hi Thomas, 

> Yeah, what's the cause of it? Switching off features does not fix any
> bugs or improve the status quo.

You are right that the module parameter is only a workaround for users
affected; it does not fix the underlying scheduling problem.

The cause is that the synthetic vblank timer is used to pace completion
of atomic updates triggered by dirtyfb, in addition to providing
synthetic vblank events. In Xorg's software-cursor path, pointer motion
damages the primary framebuffer and the damage is instantly submitted
via DRM_IOCTL_MODE_DIRTYFB. The Hyper-V dirtyfb path performs a
synchronous atomic commit, and with the vblank timer enabled that commit
can wait for the next simulated vblank. Under continuous pointer motion,
these commits dominate the update path and delay normal client updates,
resulting in sever frame-rate drops. 

This particular regression results from the combination of the blocking
dirtyfb path, synthetic vblank pacing, and the absence of a Linux DRM
cursor plane in Hyper-V. While the Hyper-V video protocol does have a
hardware-cursor command path, the upstream hyperv_drm driver currently
exposes only a primary plane. Cursor plane support was deferred during
the initial upstreaming [1]. Without a cursor plane, Xorg has to fall
back to software cursor-rendering path and it competes with periodic
graphical updates on the primary plane.

So the proper long-term fix could be adding cursor plane support in the
Hyper-V DRM driver, which may take some time. Providing that the stated
purpose of the offending commit is to rate-limit display updates, while
its current implementation regresses the existing software-cursor path,
I think adding a switch or reverting the commit until the requested
features in the driver is ready, is a reasonable short-term fix. 

> We had another fix for a problem with vblank timers:
>
> https://lore.kernel.org/dri-devel/20260914110004.211027-1-tzimmermann@suse.de/
>
> Did you validate that this fix is unrelated?

Yes I tested that fix and confirmed that it is irrelevant. It solves
issues with excessively long frame durations, however this problem is
found in normal frame updates (in my case 60Hz / 16.7 ms per frame, way
below INT_MAX).

Best regards,

Lanfeng Wei

[1] https://lore.kernel.org/dri-devel/20200622110623.113546-1-drawat.floss@gmail.com/ 
