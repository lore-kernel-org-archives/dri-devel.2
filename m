Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9903DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14D210EA48;
	Mon, 29 Jun 2026 20:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="dIzvNFaX";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DC410EA4F
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 20:41:50 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so1807865a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782765710; cv=none;
 d=google.com; s=arc-20260327;
 b=XE0WnmEPrfaxsddNsIdUC2nZVxwacyXqqX5eEExLxK7UVDltDQ35ycEl9Mi9RD/RJ1
 7CJWG+idg01PzWBe/LHoUZ6c19X+BvU12kGqVEclZroaEDGx1dbIS03BwT85AP0IJKB+
 WDSbM7dwS537SGdIVsXWO586i8SQu0juD2ANr2ZYtIXM7d37bM6qiiuGkn1Rf5N1fsUo
 rjJuZ/WshvyEUjE5s9Fj1N1NePV05iMdGwOZEdSM0PVMlGFm5905ag5ydqjhP1uNgbW9
 4QDAtyQwY7z1EopL1h/CyNCV7ADZtWTp7IZM9LsbI8d0+Lf8J6DxkI7K9Hq90Bb33wp2
 kcCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7GVQjDd7YJmxSLwubbfLzA52YfUMIS8+9D2tWPQ7ZXA=;
 fh=r4dbGM0NNaIKYBI4Uina3Riihab+HlueguJndXx31vQ=;
 b=djYC/aM8bvQwhZ1eLsNrvCNPasuU5/omTv5rRHMGmrA0U0+IBCP8vTbEFGdF9B5Lq7
 jwT9INqEth2AmqVyMkSetxjd+lxmEtlcKsI2Bpg5q35ZYUxvHatXBJP2jvNC+Xq33W30
 F7qNq3/BkZVp3f9xyTktG3YNFsiTWgIDub1yPtLXX5B1GC1OsVK+thtW/TbBuQLKCVMe
 CID2bFLbGh8laF8xdUIEcDMZfsZ925nrQ4ZJ/XNE2cyk5RS2ZOnp4nOdONHKIweScsTX
 YuM/MZl16sU2YF7PPJUqhZ26m+HDzZ2yEFY0DFmTWdyL2+cJ4OGbKcIZ6gZwtiBROYE8
 hbBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1782765710; x=1783370510;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7GVQjDd7YJmxSLwubbfLzA52YfUMIS8+9D2tWPQ7ZXA=;
 b=dIzvNFaXYNcuP1H66j3SE5M8i4yvngZUAJ/XQiaNya3s86Eg15RJcg1/bLxt1Zz1T5
 S6Trdr2jCvTw6ECTdIwK+hrVHamUiGGqJVCRYaB1IUt3nIrvpXVPb6/RxifYzQ/5Nn1w
 tPxRdHGG42WZVS/XJHmbE3+LDeQRfMxY+wtn3S+yrJsWsIGQXB6HMQGgTmecPrm96DYc
 MolF0hjnTEKUApXyuQLR0Ll3vgbB/IIK7XeDzTbpY0KlJ+7HD/Hw6Mtf50WsLsojT2jm
 k30X9bUFnuP2LzKrSGVWejaJ39bVh0xSz7rBCNkSHNw1wEgV3CoNsQTtg1Gevcy/Uf+E
 1+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782765710; x=1783370510;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7GVQjDd7YJmxSLwubbfLzA52YfUMIS8+9D2tWPQ7ZXA=;
 b=bJuFwoxLUnGZAYMxAYsqAyL6jFTnf++mNH86Uzpsggb0/5QhtiIo4908gNn0VOj10K
 k/mZVrDnJWWEJ9OGc+ldsvvbemObuWr7qUMI+aE+cq14GwT+TDtuI1sVtUNvFst1ecAr
 Ruww3kDSh4LNFOyRo+C3sNIcfQn0TD3xjL288Hi5LNKteDgchFtfxw3k16GNK8MV5Bmh
 ad9EGBQUMHC7jk5du+ZlblQv4pxfnsaxk4ksRU1kXUn2Tgqer046X8rD43W5T2XX2XcY
 2SinuqxEz4uTpDRtcoKqoRz+fDmyhsmJ1GXt7zsJCINVTtVeQIE5PJ2i1d5LwX7uaMch
 KaAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8k9Sr2kX6JP/neUfirD+QsKiGOHPHITmCMzHKGwj9W0BDRKMj+oquTuqKOzXGVmPR3juKzXNYMSQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7YuVgxis/I+s1wM62dYnVkiC6zeALuqemjeC8DrH1hIN0U6ia
 DxE5T8Kq6tG2Cg78HQNMH75kpCk13A2HtyrZLdKNyx6jwVlLBdjdk1+nDWCnF65LbuKs592W8NJ
 a/lOFb+JhD4NMH10geCAQpiQnAoP6WL4T/POlfBAXSQ==
X-Gm-Gg: AfdE7cm6it2tKVLLB8w1amSa/oIXta86PdvTR7YtmEIFf1vbqO91KFaDHvmig4jzFCW
 Zo2vvy8HdZ6/qioOPeRwFFBUBwvd6aEFayND9fmo0yalO6yKc1kMJONj60HR3vNLmecwfQhTJcs
 OTbweTWCkap9GZQaFeG3f0pvrA8MkIP5PKI4sYKLr1bZvt21RRaeePHKvX4GMfsI0MNS+Rgf/U1
 2p9bgeJKAO9N43hPF1YYIzrU6Nb8wUB4S/N6Irnfe3MaWD7dRmOQzv++xct62u/uyCo4UsD
X-Received: by 2002:a17:90b:5185:b0:36b:79aa:cda4 with SMTP id
 98e67ed59e1d1-38052538afbmr565926a91.8.1782765710037; Mon, 29 Jun 2026
 13:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-hot-plug-passup-v10-0-f62351a9ea3e@collabora.com>
In-Reply-To: <20260526-hot-plug-passup-v10-0-f62351a9ea3e@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 29 Jun 2026 21:41:39 +0100
X-Gm-Features: AVVi8Cc9yvqQrV56HBtjBRrEeKxj0HDoGTRX-_O4gvPndP8JvzUoQ7BrOqS-z68
Message-ID: <CAPj87rN=M6TYd89h6VdPo=3-ksmmVLZ879jMBUzDYfUyOXunxw@mail.gmail.com>
Subject: Re: [PATCH v10 0/2] Pass down hot-plug CONNECTOR ID to user-space
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniels@collabora.com>, 
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel@collabora.com, 
 wayland-devel@lists.freedesktop.org, Marius Vlad <marius.vlad@collabora.com>
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

Hi Nicolas,

On Tue, 26 May 2026 at 13:39, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> This series addresses a shortcoming whereby a hot plug event is sent
> without it being passed the actual connector that caused it. This takes
> into consideration both the polling path and the HPD (Hot Plug Detect)
> path.
>
> The motivation is that user-space applications such as Weston would
> previously receive non-connector-specific hotplug events, and then have
> to figure out themselves which connector needs to have a modeset
> executed on. This notably did not work when the hotplug events came in
> too fast, resulting in Weston missing an on-off-on transition of a
> connector, seeing that its state was unchanged from "on" so can't be the
> one that was hotplugged, and skipping reinitialising it as it looks
> through the other connectors that could've caused it.
>
> The real world implication is that on setups with slightly sketchy HDMI
> connections, a brief flicker in the HPD signal could result in video
> output bidding farewell entirely until a manual proper re-plug was
> performed.
>
> By sending connector specific hotplug events, this ambiguity is resolved
> without any change to the user-space API. Future work should however
> make the kernel explicitly request a modeset from userspace through a
> more robust path, either by using link-status (nb. the userspace side
> may not handle it properly at present) or by exposing the epoch counter
> through the uAPI such that fragile state comparison code is no longer
> needed.
>
> This change results in potentially more hotplug events being sent than
> previously, as n changed connectors at a time result in n hotplug
> events, rather than just a single one.

Series is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

I'm not sure if Ville is still planning to look at it or not, but I'm
happy to push it if it's all good.

Thanks a lot for working on this!

Cheers,
Daniel
