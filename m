Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3432C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D00710F5F1;
	Fri, 11 Sep 2026 13:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SN9g5fmF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A947D10F5F1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:27:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91EB34373D;
 Fri, 11 Sep 2026 13:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17211F000FF;
 Fri, 11 Sep 2026 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789133237;
 bh=yydFd4PxC6CTpgwU6zo56XL2ozb1aEzdrei6ipT4o7k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SN9g5fmFonZPAS+WJr7n5lMHR3PMuOcURsQD7K7pjfRc1AOJ2y1P2zbDsgKN9Ui6v
 fhSjRz+NJXw2gNyxHAx1S1ZDvEvFCS5y39PgircgjBvFkOgSam2bseZ9XAHgyQIq0S
 W8gBBfV720hyCpMnvQESSVxOk8fl020L5GZtiolzLd8b14PMX30JEgRJR/Mkp9LtOW
 23bwlkcV9mjElSsS6ZLQpzvxS6nHMADAwGFzX5t6SdnZ7fWyra2sMHyaatAIfmbte0
 TFAIaYLxZtxA5gsAGExGIWIZVHo7a6hN3E4QrblOoNAPYOrCo+cBoDFXUmHENo4deS
 iwlrj03DHQQ+A==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: Daniel Stone <daniels@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 =?UTF-8?q?Jonas=20=C3=85dahl?= <jadahl@redhat.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Simon Ser <contact@emersion.fr>,
 Victoria Brekenfeld <victoria@system76.com>,
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 01/11] drm/atomic: colorop: Rename state to
 state_to_destroy
Date: Fri, 11 Sep 2026 15:27:11 +0200
Message-ID: <178913320918.645786.2219525906683909165.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908-drm-reset-state-flag-v3-1-905570f387a4@kernel.org>
References: <20260908-drm-reset-state-flag-v3-0-905570f387a4@kernel.org>
 <20260908-drm-reset-state-flag-v3-1-905570f387a4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Tue, 08 Sep 2026 16:35:02 +0200, Maxime Ripard wrote:
> The atomic state tracking structures used to have a generic state
> field to track the state to free when tearing down the
> drm_atomic_commit. It has since been renamed to state_to_destroy in
> __drm_planes_state, __drm_crtcs_state, __drm_connnectors_state, and
> __drm_private_objs_state to better describe its purpose.
> 
> The colorop support has been added after that rename, but
> __drm_colorops_state still uses the old state name. Rename it to
> state_to_destroy for consistency, and add the matching kerneldoc.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[01/11] drm/atomic: colorop: Rename state to state_to_destroy
        commit: 38d8b5a35367246dee147d48ea6d5cd6644de5d5

Thanks!
Maxime
