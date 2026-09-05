Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1A2C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979BF10E20A;
	Sat,  5 Sep 2026 15:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E7rMJbVs";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFCA10E20A
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 15:28:26 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d086fe9c7so30225e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788622105; x=1789226905; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bby5XNssOK47IVbU90Y61XfgVLTccI/hRlNdabb9YVk=;
 b=E7rMJbVsyukP7z8SjlK1AQaIW8vnnq+I2LPlcJyUGsFsm1UpZjic+Sl5+B53XShQKn
 GFIrGUZb45Kjgvje6lWY0gpu7jL4BOlCOtFPPCZNweDSvjZeVKuHnO/uLDuDlH2pVX9t
 pZKCJcxftT7aWSSAZGSZYgOygBiA/fXPV/feLV4uvzES29RRHyMmMlg/OKMgnW/U9tE0
 TrWzSHGc6Bn4tmWP2/vlO0B/L+MChtVlMIlVrdIyNPwRVWZ6Vi5EsTIYd/QSb4KNkUX0
 PWOAnF9lL4gISgmEc+z5dZ6dtvgEGtgG5cK6A1U7oMItOZw+fLgyYP8222gc9jvoPNLv
 0C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788622105; x=1789226905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bby5XNssOK47IVbU90Y61XfgVLTccI/hRlNdabb9YVk=;
 b=NiBLX2EU4IL8FXrHk4hgb/2o393Y+G9WYlZwaRsk4qycAjatcZmv4uYjC9a+Of3kf3
 3tQ7ssf5blwYIoYPCndEMOTGDpR5eAfiyGOhHMzzEpTJW/oZcRUd/f3qVkq8VxB9ltyI
 l2222CiTfOHmJ3j8bTX0PzxskwnGbtGwswzVBvjtUBqzWMM/Xcg+hanEAFbbHc83p6Vw
 h8OaoJ4ZUxxsHLtsSUAbYKikQpteBbYv0KGWKMORRnYMz6py0yqD3OrmE2XP2+Xf3j2p
 VFj/Ed7Poco8NOAr2MNuyfKFH+atZ8ExQv8IS6/v29cuAYO4bDfupYA3jySpuidg3Dy1
 OSVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfrq234QyI8YQWX0g2Vd+zJHOG2P/XPh1kNfc3+tgHvr67pN+LYHvk7YY4OqhnGpjmwT1qaH1a1yg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kJCbXt9Vv+G6OTAvQ6ith6KGYNbn7WnABhSO3pxVhBPyYFhJGK
 y5TPQE1adN36XXxI/OrAwD1MTfL+edGPSzfAzevdEPnMZemCAimtN4UC
X-Gm-Gg: AYBFou0/A0BwUehEUSnOE6ER4g0Em5M39uO6a9AxtxLXxwddtSljO44Qmj88Uopuoea
 N6jE14hjV9HeeXy6N5zDTuBQ5RhOhDh3YDrusimOJXiiA3d8UEXc74lj/8imnXYuu4YRrUkTPsT
 H8TyhQLpBz6iMYcIhR+Qur15Otl4cbL1J1i/Fwvm4CY6j7P9Gjh9iaJ9xHDqX7SaswGd0N4ItDY
 wlTxDrHzFHS9J0QmoaD3nsnBBNpk5cdPz7I1c2gdw3/rRsN1o0l92rTg00bDIzE8vaB51KoypDM
 9eYVNEpOgFkMQbja/G2i3z16JbvK4LWY+jULIB4IUC6Dn10QSKzpLKsOIAOE9gRxGaRoNvKxbh4
 5tNGsTfFVkNCD5zGc7R1UxM3Dk/AVXwTv16mIg84bAhA/i79k665muLcw/uRdWgRuHQioh5TBH+
 LnQlX18CbMP+40j2yq5dpMyYR2nzQzVCBhnsxeYVMkoj7gm96LDEDpvD7SXssOQxJjyM+84EveN
 8kWp2LlaxjhZDQRIWMcIhshi+07N4MkX1LUfQjsYtdFDjFTtD63+BkNyw0PRZG71A==
X-Received: by 2002:a05:600c:3b25:b0:49b:910c:76fb with SMTP id
 5b1f17b1804b1-49d01dd415bmr45799875e9.2.1788622104748; 
 Sat, 05 Sep 2026 08:28:24 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B950E0061C002CD703C2CBB.dsl.pool.telekom.hu.
 [2001:4c4e:1b95:e00:61c0:2cd:703c:2cbb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce831af89sm178425195e9.1.2026.09.05.08.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 08:28:24 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: sashiko-bot@kernel.org
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Sidong Yang <sidong.yang@furiosa.ai>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: search every core slot when looking up a
 scheduler
Date: Sat,  5 Sep 2026 17:27:59 +0200
Message-ID: <20260905152804.9822-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905151815.3BE7F1F00A3A@smtp.kernel.org>
References: <20260905150432.7477-1-royalnet026@gmail.com>
 <20260905151815.3BE7F1F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> - [Critical] The patch introduces a compilation failure by referencing an
>   undefined struct member `max_cores` in `struct rocket_device`.

Correct on its own, and my fault for leaving it to a trailer.

max_cores is added by "accel/rocket: search every core slot when a core is
removed", still on the list:

  https://lore.kernel.org/dri-devel/20260904125936.26234-1-royalnet026@gmail.com/

This patch declares that dependency as prerequisite-patch-id, and the id in
it matches git patch-id of that patch exactly. On top of it the build is
clean with W=1. On its own it does not build, as you say - it should have
said so in plain text below the --- as well, not only in the trailer. I
will do that on any patch of mine that depends on a pending one.

The pre-existing issues are useful, and two of them are already in hand: the
global rdev left holding an ERR_PTR, and the devm allocations on drm_dev->dev
that are never freed. The reset work cancelled after drm_sched_fini, and the
iommu_group reference taken in the IRQ handler, I had not seen. I will not
send patches for them until I have reproduced them on hardware - the two bugs
I did send this week both looked different once a KASAN kernel had printed
the trace.

Igor
