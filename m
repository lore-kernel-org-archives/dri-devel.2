Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0A606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgPE3F7C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB3310E2E9;
	Thu, 12 Nov 2026 02:07:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20EEF10E2E9;
 Thu, 12 Nov 2026 02:07:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3B5843E20;
 Thu, 12 Nov 2026 02:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1821F00A05;
 Thu, 12 Nov 2026 02:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794449227;
 bh=OsjQmj8bEtxT8MV1vFymqTEFM2D9OctuG/QAUyzfaqQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fgPE3F7CwAI2tyWokH7RhOXpx9amTQZZBhyv2tdd2a0LnNADzByYIxnfJToaaug9Q
 0FUl9gmcCqdUKq02EaY/zdED7fxH5fdrBz0XuEv21ga/rkjXikdtdn4sdCjgvbxUqb
 IfktP3eII2RRaRFjquWQthETBDLNkiAyVwTn4rYzj35mdgsIYs3qba32WiOPsAFB8P
 H1zjDXm+LVi9L2R7+NRGaubJYWbsqIuisET45l8L1lN+2s2OsAPdXmZE78flWZqE1r
 StxgK41X1KqpcWFixc6IOgE0aaN0pRkmu2FunQ4M7rO2IGpt6C+lr12fA0FYn77MK+
 Ju9W8vC8weVfw==
Message-ID: <sashiko-outbox-210152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/19] drm/amd/display/amdgpu_dm: Use DC accessors in
 psr/replay/dmub/hdcp/irq paths
To: "Dave Airlie" <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-5-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-5-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:07:07 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amd/display: commit message claims dc_color_caps changes
  from parent commit
--

commit 343696be48b1784f753cb65b6771fbf97af59e1d
Author: Dave Airlie <airlied@redhat.com>

drm/amd/display/amdgpu_dm: Use DC accessors in psr/replay/dmub/hdcp/irq pat=
hs

This commit replaces direct struct dc member accesses with DC accessor
helpers across the psr, replay, dmub, hdcp, and irq paths, adds
dc_get_dce_version(), and splits debug option access into const and
mutable accessors.

> Also constify the dc_color_caps consumers in the color module so
> dc_get_caps() read views can flow through them.

[Severity: Low]
Should this paragraph be dropped from the commit message?  This patch
does not touch any color module files; the dc_color_caps consumers were
already constified in the preceding commit "drm/amd/display/amdgpu_dm: Use
DC accessors in audio/color/backlight paths".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-amdgpu-dc-=
cleanup-v1-0-0fae41718ad2@redhat.com?part=3D5
