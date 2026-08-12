Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DFFC5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B2A10E402;
	Wed, 12 Aug 2026 12:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OMH5SxDP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E27510EF78
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:15:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 312F860A84;
 Wed, 12 Aug 2026 12:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B651F00A3A;
 Wed, 12 Aug 2026 12:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786536909;
 bh=7Z+XzXDfYwobWJxYpx8R2juvCXyCYa2UzJFRERKyDxA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=OMH5SxDPZnlWw+o96gNmfx+bFpk5Q6i3bpnpv/MigtRYzSpTFekAXyDRXH5R/cUev
 9HKmFlw1NIXl37AGD93E/NKzElwkslxfP+7luOyANSMZ2Pt592nPH77mVD2mQoGpRx
 7+BP3X3/w9mhcMACZ8+m1zCKmNJLalIZl78aw9c8zbjCFGPMWfv+zq3BreAi4ikl0f
 pLgiOyarMTKiWOAo2UIaOAAMSiykwvnRuYPiXnrHprxldfag+T6FqaOeZ4V7jcVrOZ
 S8vuMJz+jlfrFyPrfMjIGWHZLG5YqwMkHR9ZO60lQZLxGidn+wMh7dm1wsW7Af2RTR
 HVGLMpgGGtR9Q==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Junjie Cao <junjie.cao@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
In-Reply-To: <20260804030255.1934470-1-junjie.cao@intel.com>
References: <20260804030255.1934470-1-junjie.cao@intel.com>
Subject: Re: [PATCH v3 0/3] backlight: aw99706: DT parsing and blank state
 fixes
Message-Id: <178653690808.1388789.8898275020570409827.b4-ty@b4>
Date: Wed, 12 Aug 2026 13:15:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Tue, 04 Aug 2026 11:02:52 +0800, Junjie Cao wrote:
> The driver reads its tuning properties under names the binding does not
> define (patch 1), the validation paths accept values the binding forbids
> (patch 2), and update_status() ignores the blank state, leaving bl_power
> inoperative (patch 3).
> 
> v3:
> - patch 2: reject 0 for awinic,sw-freq-hz (reserved-slot marker
>   collided with it); add Fixes tag
> - patch 3: add stable tag
> v2: only patch 1/3 reached the lists (outbound mail failure):
>     https://lore.kernel.org/all/20260803141310.1379194-2-junjie.cao@linux.dev/
> v1: https://lore.kernel.org/all/20260701133918.33487-1-junjie.cao@linux.dev/
> 
> [...]

Applied, thanks!

[1/3] backlight: aw99706: Fix DT property names to match binding
      commit: daf120e464386f750b3870dc04d5bc6a786f0000
[2/3] backlight: aw99706: Validate all DT property values consistently
      commit: 3d142b19b09ea62d6e9a33d46d1b858b3ad05707
[3/3] backlight: aw99706: Honor the core blank state in update_status()
      commit: fbf8b5d251e8b4e1b01c591be313c63cb9e1526a

--
Lee Jones [李琼斯]

