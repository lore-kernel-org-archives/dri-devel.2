Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9976C606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lB9NZMID
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E4B112012;
	Thu, 19 Nov 2026 07:53:10 +0000 (UTC)
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6F510E5F9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:03:43 +0000 (UTC)
Received: by mail-pj2-f3.google.com with SMTP id
 98e67ed59e1d1-3adc0ac3566so279165a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795035823; x=1795640623; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AOYoHqd+TEhq9YYSZd05JTs9KMcPqQTIbqKvDzsDrNA=;
 b=lB9NZMID1lkmq+BodC2XVzRrClEKsLZhyjvTrwDD0S8IAn+TKmtTZyVdHVcRMsyVnE
 qNiDIvv1yISIPmv/Firo3sLPmnQVm+1KUjr9wMClPgdx8WykMqfarIgkmMJXrxUUIZTa
 nxY75tsle7fh5Tr3NdapF8ZNtLEWegUQJ1A/1XFeBmtv3PkMowQsL7MkDk9ROff8VPs3
 tSiCvZtZBfDohTyzYYVwG1MuMo+CNOG1lBTvUCGCRssgipHEwecL89w07gaF7AWTy5rf
 DJMFWX48vw/D6TpO9QBsJVWPdsoLwzJ2A6lFZFTMxt9BxPm1ATvT7QL12jLjy+pe0ih7
 5M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795035823; x=1795640623;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AOYoHqd+TEhq9YYSZd05JTs9KMcPqQTIbqKvDzsDrNA=;
 b=QRPmeJ78mT5+lFIIaWS7FO881VBdNd+WeCnkgR7yrPE18PMM0E8k5ngptwwTcYbRX2
 u5NTdi4MYAT8xZuROswWuWNr0z7vZe2jL3xUfTMKu3qm3toMYYfX1lCGIHkQjz0i12zs
 idxubhDjB2fyyc2SS0sAdhdHLb0FtEPQ0stScsqv2kV/TQsUeo3vFbJ4xDpb7zrPO1ib
 UsSACdCi4yNpUb4+so41XWs6s4VvbAIDmbac4KwoEmggh1VcrbI7wOQZINY5PAoQ/fdG
 QUWhjKGoZ8/APkNJ8TY+CAaQdW4cxu3of/StXMnBiecaaG79RjED+OUD0zsXv5ZPtfo8
 iEig==
X-Forwarded-Encrypted: i=1;
 AL+hErGNqibPeH5yJW225JUqKrliEfpr+fxtdzNW2xknl1REPwF7rL8uzNq2oAWMkO3M0g1s05amTC3Hvco=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8EVp/Gu/D8xcIMtk1t1QICRAfjo8/czzG5SGX67lll/ygub3bI
 Q3v4PR68r0v37i3uefbjNlgHrEeyuSaao6mW6f8TdjCO2ej93WzT8BELgf0ZKUaXGUVihQ==
X-Gm-Gg: AZFdTZeuguepsZm0TqAxAu04t5r2YsJTiVR3+BfAMF51kwZdCNrtT2HmhMnIGRVhXOv
 EIkkvhGvOjttxRw/qwW1gWmq8eGwmN0mjSlraH7Hcl+PVAzmECdxEDqXxMivFynZMkOrpZEIAE4
 m7Wqwag0AUfYk5+dSGZ+adnLe/E8NGQ9Y1j8MfbXPNC+rGSxSxzXFa6+mINJitb/siGdYaXYsYq
 yPaKSkRcppa6f0kDT9UlFgzdDs7hY3w1ZiCT/+sHODvdzhA1MSr5RpNwsaUPuU7ctL67s6qq3dp
 oqjfvbIToQQvFE50KJ/rpFnyaBCvjDFeMw1gUwz2ebjw29aDiaBDkF3knvhu08NggcO0XDxUCag
 /hvLZ8Dj/mzfL2/VNgHgS069u5Y1ebOcRPV/CqiUYyXVvADn1mH7i7olncQXBshb85d0hrgAjd+
 CJ2tRWEIe9H6mAnp8SKWQPHrbBfPhTS0azz/i001k4VWkSsUhXoIro4dblZ5vVyYb9rLNi0xANu
 R2ov5d1qZdq9ydaiFcyh2GNDchvsO9Tef6DIo4WIvgsqxJB8pg36SSMLb/xnElsRmRz+0XFODPU
 uWw=
X-Received: by 2002:a17:90b:3c81:b0:3ac:80dc:f419 with SMTP id
 98e67ed59e1d1-3b3d07aa355mr3694363a91.25.1795035822845; 
 Wed, 18 Nov 2026 13:03:42 -0800 (PST)
Received: from localhost ([2403:2c80:6::107b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3f7066ef3sm865257a91.11.2026.11.18.13.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:03:42 -0800 (PST)
Date: Thu, 19 Nov 2026 05:03:36 +0800
Message-ID: <5167ad548a578a23ed8d5172196b36f0.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Haylen Chu <heylenay@4d2.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yao Zi <me@ziyao.cc>,
 Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Guodong Xu <docular.xu@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 08/17] drm/spacemit: add Saturn DPU core types, cmdlist
 and display MMU
In-Reply-To: <0dc12950-68e7-4c30-9138-23539e676e1a@suse.de>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-8-327d7910bf71@gmail.com>
 <0dc12950-68e7-4c30-9138-23539e676e1a@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:53:02 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas,

On Mon, 14 Sep 2026 16:10:25 +0200, Thomas Zimmermann wrote:
> Hi
>
> Am 09.08.26 um 15:14 schrieb Cody Kang via B4 Relay:
> > From: Cody Kang <codykang.hk@gmail.com>
> >
> > Register programming of the Saturn DPU is batched: the driver builds
> > per-module register lists in memory and the hardware command-list
> > engine replays them at frame boundaries, while scanout buffers are
> > mapped through the DPU's private address translation unit (DMMU)
> > rather than scanned out by physical address.
>
> I've looked through the code in patch 10. How does a plane interact with 
> the hardware? It apparently has its own command list, but there's mostly 
> code for the CRTC update.

Thanks for the review. A plane programs the hardware through a
command list. Its atomic_update fills the list with the registers of
the plane's read channel, the driver points the command-list engine
at it, and the hardware replays it once the driver raises
config-ready.

In v2 the plane only fills its list; sorting the lists and handing
them to the engine is done in the CRTC update, which is why most of
the code is there. v3 will move that into the plane: each plane
builds and submits its own list in atomic_update, and the CRTC flush
only submits its own list, for the composer, and raises config-ready.

Cody
