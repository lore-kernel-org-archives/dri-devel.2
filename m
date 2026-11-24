Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA88606A68F
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iykW2gMe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF1510F434;
	Tue, 24 Nov 2026 10:14:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EE810F434
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:14:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09C7B43797;
 Tue, 24 Nov 2026 10:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B0B1F000D0;
 Tue, 24 Nov 2026 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795515272;
 bh=eKZ7jyphtX0mQj7Pbb2ngLG3znDev/bGLd8HYbXqCvQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iykW2gMehqUhEPKVWIlQ4k6H/a2VVbhsWUP0HWvkSV7M9gBZjJDbjz8UcuFzmsehe
 aJ4I4nqwDMzwc6CbgBsF5iSYcANpxP4XjbcitU3JU99jEgpL+Z9mCAH92TYGuLEU5h
 RYvFh1l0J2ctrq+Ms6iITWq66X/n2NjnAZhYTdoI/CdC5bNfrRko7nfFoPDc5RyhWo
 wFX07FNnoZj7f3lFp7BssJSmM+Nx3rDl9oCXp/LhqHpbw8dryCs7B6ZMkK8F/tetPk
 mlw68W6TJB6tBskU7CsSX2JC1HVDg+9wB8ZummACZ9HRRzP9XfdQusNvIewqN7VO7j
 6jFx0Ec2s2/pQ==
Message-ID: <sashiko-outbox-230947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/13] drm/bridge: tc358762: Fix sync polarities
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261124-tc358762-fixes-v6-9-bd38fed6460f@ideasonboard.com>
References: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
 <20261124-tc358762-fixes-v6-9-bd38fed6460f@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 10:14:32 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/bridge: tc358762: missing Fixes: trailer for sync polarity
  fix
--

commit ef22970b42687aca940244b42fc9f71d73d186ea
Author: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

> drm/bridge: tc358762: Fix sync polarities
>
> Setting LCDCTRL_HSYNC_POL and LCDCTRL_VSYNC_POL will make the respective
> sync signal active high. The driver does this in inverse. Fix it.
>
> Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[Severity: Low]
Should this include a Fixes tag for the commit that introduced the inverted
polarity check:

  Fixes: 7f4e171f9d05 ("drm/bridge: tc358762: Handle HS/VS polarity")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-tc358762-f=
ixes-v6-0-bd38fed6460f@ideasonboard.com?part=3D9
