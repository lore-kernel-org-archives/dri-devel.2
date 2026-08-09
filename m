Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B76C5B56E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2309310E646;
	Mon, 10 Aug 2026 06:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L86lUoTb";
	dkim-atps=neutral
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D0710E03E
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 01:01:35 +0000 (UTC)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-c9fcd903839so467999a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786237295; x=1786842095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bTU4eIZnw4U9ZhD6oNkBxDN+wvA8F1rOyrlQvDjEprA=;
 b=L86lUoTbsCwyLbzOiPLiQIhBnLvpLxDRfGrs5iBWAjpZxJZuwUzHME/zPgidOb/E0z
 lZC8qV8STFB+N3KylBTlbudTHrYmFqhbzu6DzHGM8mz1BHom3EsHGm7Ygs8VxqFrx9eK
 XyADMhqxwLgntqBUm9Ypl2/UHXWMSgfdv01n++GukBiDsa8O/3+Xj3aGTQtdMKUqc0l9
 24vqqjoN9x1XKOtvPoJ+IRnpF7pCCJTQWqJloMOiua5/HoNkgb5/gXu/k6fhBsFyK2Ei
 cKlWqkAKIDgcz1CKhn5xaJgrU/b+99elnPSm1Lwf9vhwBE7VNVt3YGMrxI7p9osUZgv6
 5PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786237295; x=1786842095;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bTU4eIZnw4U9ZhD6oNkBxDN+wvA8F1rOyrlQvDjEprA=;
 b=f9TBKidovIO4pJEZJRgoNbcPeoUW1ZPXJc6ert8a0ZP7KLPOqsVs6sdtQJxphXyugi
 MLRN0AuPUX7wOx3CNrr0AenHJHaBqH+Ic3r1mk15YeA3HIGR4qHLIjIYp1+qaGVBmZPK
 KUvYRNHFW8YNbZKF2oFkSL4N2C04J+66yd+/LrILQ/jxYwaL1M5ddNBg84aYGluXV/x9
 SeiDarZTzn/t2Ym1JLXcn2MeKqPpu8Z29F7MjX1umaLxYAs7sXdZveQPzNznCUkHc+Eo
 ye5Pn2xRi0bqU0s/KJ4OCdAe0ynUXlsgA144ik+OjuOf0oSsTiwkbW7oBYx5B0Mldfcz
 yqzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFb6jP63yQsXKNl0NPyQ0DWxwf+rcWDRwEpUgwMFP1QQh4n8kt9Dp8/nDexfM2cwXJTM14a4EEDB0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxX3QLMctx6P2A1BuI74eEZkAozjrPoAxjouRhJgC+42qoVZWKs
 nlZORmYb5c7tem0rCKHmC19Fk5OXOn4/QTxaSeVOCvPO8LF6qNXdreCg
X-Gm-Gg: AR+sD102VaUyss2oQRkLOYGQ+zELoMQ2YkNQt1yLqFaWstmES/bgInvODyzC70RYy0R
 /Zrdh28pkf/iU3Yd4AyG1J+65YfHWl5rVF2zemxaH/OQNtlwEEn/g5jjkHfntMFDWKRSMtfYA7D
 w9UXhmmuok56Pj2EWV9wQHoYrE3f7uKaJfspFhxv33Dce5BL9XX2bMy01SoN836RaDrXGR/I8Ar
 CUaOpwm3SJ24Voh9FCF2Tvel+HF/wAQOZlAs5AnAJaSFQsiCYMgQ/msIemVtzXIBrvemh/gEN6x
 r+gH8XNtUKbLyCDDeqEObwhIBov1TpltpGO+W4YnQym/aEm/kZuH99qj2fLc4JWatbbTWYt0FwB
 53hjBL/1aoKC81Dp1xRsVOQe5ojTL4o7snrl77t0yYi4zFurMbOpmoZHXDFdte9qEMy6QRVrglI
 GSOhkC1l0sChMFV6UvrVks9QSZaS+eUXyJDLJ+cWc=
X-Received: by 2002:a05:6a00:2a0e:b0:848:6c37:cd74 with SMTP id
 d2e1a72fcca58-84f696a0369mr12238522b3a.22.1786237295147; 
 Sat, 08 Aug 2026 18:01:35 -0700 (PDT)
Received: from localhost ([2403:2c80:17:1e::20db])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a55f304sm2378524b3a.49.2026.08.08.18.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 18:01:33 -0700 (PDT)
Date: Sun, 09 Aug 2026 09:01:28 +0800
Message-ID: <4da43aa690649fda8565941ee576338b.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com,
 linux-phy@lists.infradead.org, neil.armstrong@linaro.org,
 devicetree@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH 11/17] drm/spacemit: add Saturn DPU DRM device driver
In-Reply-To: <20260725051713.B60E61F000E9@smtp.kernel.org>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
 <20260724-k3-display-v1-11-f22a10a52867@gmail.com>
 <20260725051713.B60E61F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

On Sat, 25 Jul 2026 05:17:13 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Missing IS_ERR() check for 'match' causes an ERR_PTR dereference inside component_master_add_with_match().
> - [Medium] The atomic commit tail stalls the commit pipeline by waiting for flip completion before signaling hardware done.
> --
>
> --- Patch [11]: [PATCH 11/17] drm/spacemit: add Saturn DPU DRM device driver ---
> commit e12174b9614adeccb5a06f03b5944837004e96f4
> Author: Cody Kang <codykang.hk@gmail.com>
>
> drm/spacemit: add Saturn DPU DRM device driver
>
> This commit adds the DRM device for the SpacemiT K3 Saturn display processing
> unit. The SoC has two DPU instances, each driving one CRTC that scans out a
> single primary plane in linear RGB, feeding a downstream DP/eDP controller
> over an OF-graph endpoint.
>
> > diff --git a/drivers/gpu/drm/spacemit/spacemit_drm.c b/drivers/gpu/drm/spacemit/spacemit_drm.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/drivers/gpu/drm/spacemit/spacemit_drm.c
> > @@ -0,0 +1,132 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
> > + *
> > + */
>
> [ ... ]
>
> > +static void spacemit_drm_atomic_commit_tail(struct drm_atomic_commit *old_state)
> > +{
> > +	struct drm_device *dev = old_state->dev;
> > +
> > +	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> > +
> > +	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> > +
> > +	drm_atomic_helper_commit_planes(dev, old_state,
> > +					DRM_PLANE_COMMIT_ACTIVE_ONLY);
> > +
> > +	drm_atomic_helper_wait_for_flip_done(dev, old_state);
> > +
> > +	drm_atomic_helper_commit_hw_done(old_state);
>
> [Severity: Medium]
> Does calling drm_atomic_helper_wait_for_flip_done() before
> drm_atomic_helper_commit_hw_done() stall the commit pipeline?

Deliberate: the cmdlist engine reads the old state's DMA buffers
until the frame boundary, so the next commit must not start
programming (nor the old buffers be freed) before the flip
completes. Will add a comment in v2 saying so.

> By waiting for the flip completion before signaling hardware done, the CPU work
> for the next frame (such as state preparation and buffer pinning) is blocked
> until the hardware flip completes.
>
> Should commit_hw_done() be called before wait_for_flip_done() to avoid
> degrading atomic commit performance?
>
> > +
> > +	drm_atomic_helper_cleanup_planes(dev, old_state);
> > +}
>
> [ ... ]
>
> > +int spacemit_drm_of_component_probe(struct device *dev)
> > +{
> > +	struct device_node *ports, *port, *ep;
> > +	struct device_node *remote;
> > +	struct component_match *match = NULL;
>
> [ ... ]
>
> > +	for_each_child_of_node(ports, port) {
> > +		if (!of_node_name_eq(port, "port"))
> > +			continue;
> > +		for_each_child_of_node(port, ep) {
> > +			if (!of_node_name_eq(ep, "endpoint"))
> > +				continue;
> > +			remote = of_graph_get_remote_port_parent(ep);
> > +			if (!remote)
> > +				continue;
> > +			if (of_device_is_available(remote))
> > +				drm_of_component_match_add(dev, &match,
> > +							   compare_of, remote);
> > +			of_node_put(remote);
> > +		}
> > +	}
> > +	of_node_put(ports);
> > +
> > +	if (!match) {
> > +		dev_err(dev, "no downstream component available\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	return component_master_add_with_match(dev, &spacemit_drm_master_ops,
> > +					       match);
>
> [Severity: High]
> Can match be an ERR_PTR here instead of just NULL?

Real; will add the IS_ERR() check in v2.

Cody
