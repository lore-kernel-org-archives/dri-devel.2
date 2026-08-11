Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65F6C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F48110E29F;
	Tue, 11 Aug 2026 07:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VY2YBGhI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AC910E29F
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:54:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F12CB600AF;
 Tue, 11 Aug 2026 07:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F0E1F000E9;
 Tue, 11 Aug 2026 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786434858;
 bh=vNn4N61X5h4i8q/qeKcqZMXb8zMuPTcsONaagSygukQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VY2YBGhIIBULdfbRGcwxo/i8/rQHP6FGVqtUwDE8Rf0lQdEHvk7oJS/8kCykVQfsb
 R4TYsMYRDXs8YpEQ1Ap8G5XmtDQGH39LcOx8Nmw9R2oblXAgy1AgulWUSO4vNCf3Td
 GI8ob+jwnFEq6i2+SBmJe3GkP5R3GAAVYr/X3oerliSMBuW0C6sHs0HYuAnMy32lrk
 FpaQa6KPQdflHjkMgR89cQJAY088T/ZbCcOjvpCeYoWhLd0rHB0rGzZeKEVZpOqCnT
 Pr+vLcbICMnbvw21TPX8yUtNQem4h8B8bWlCWvGHcW2f6thG/3w5PWtYDDh2rb1xrn
 bZpER2NMhKnXw==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Cc: Maxime Ripard <mripard@kernel.org>, Mark Brown <broonie@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: remove accidentally committed .orig file
Date: Tue, 11 Aug 2026 09:54:13 +0200
Message-ID: <178643485116.204852.837435722994824936.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810125204.3258447-1-jani.nikula@intel.com>
References: <20260810125204.3258447-1-jani.nikula@intel.com>
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

On Mon, 10 Aug 2026 15:52:04 +0300, Jani Nikula wrote:
> Apparently an extra file drivers/gpu/drm/drm_panel.c.orig was
> accidentally added and committed while committing ac3baea883da
> ("drm/panel: find_panel_by_fwnode() return a counted reference"). Remove
> it.
> 
> 

Applied to misc/kernel.git (drm-misc-next-fixes).

Thanks!
Maxime
