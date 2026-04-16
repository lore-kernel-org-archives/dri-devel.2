Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E74DF8D758
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8693710E250;
	Thu, 16 Apr 2026 15:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M6VOooPf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6D310E250
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 15:26:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A2D2560127;
 Thu, 16 Apr 2026 15:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6933C2BCB3;
 Thu, 16 Apr 2026 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776353177;
 bh=Yrvlbwu3X4ciGbQvlk+Y4EOaweifB5ufEkrLM2asoMA=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
 b=M6VOooPflNCwguMNFh7xJU70TLIHt7S4D8NjkG632qJfZ1pNOypUWxZRKwzh8YsCe
 aEdHjCT7Dk6vcOS5TUzM3Pylf2zqzf4Zgewtnjw2YkYTE3wfCQX9YiwQxDD4HXpXCQ
 PAC8wFqLHxwKZ7hpF5JIqb+UT6hpZP0PRbWankGbJNYqlggiZrW+pk5+FFzyLbXng+
 7J4L0oR+LwPbXE1fVBvcAakrrDeSaKKDted+dRB0nQoq9yjNK51TPIQ3OfQeJD9S+q
 u3fEXeMy0npboA0bo434q81CYLklHkyUrfg4UklBNjrGsL1r6VgfkQY5zivOHW1NIm
 vlGsTgpJsc07g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 17:26:14 +0200
Message-Id: <DHUONALYJRAE.29R3XAXIDG3NQ@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/gpuvm: take refcount on DRM device
Cc: "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
In-Reply-To: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
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

On Thu Apr 16, 2026 at 3:10 PM CEST, Alice Ryhl wrote:
> Currently GPUVM relies on the owner implicitly holding a refcount to the
> drm device, and it does not implicitly take a refcount on the drm
> device. This design is error-prone, so take a refcount on the device.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Fixes: 546ca4d35dcc ("drm/gpuvm: convert WARN() to drm_WARN() variants")
