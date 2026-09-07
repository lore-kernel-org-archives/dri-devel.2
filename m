Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F44DC79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7709310E4AE;
	Mon,  7 Sep 2026 15:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V22MOAAf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3691E10E4AE;
 Mon,  7 Sep 2026 15:24:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7F56404C2;
 Mon,  7 Sep 2026 15:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448BD1F00A3A;
 Mon,  7 Sep 2026 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788794667;
 bh=cs18S0yn14DT22ndf3lI2JAvn9FJIqzlDxuCLEPdPnE=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=V22MOAAfQyvY1iD+rFNvwPOhxydC+MqZPySdf/KszacU+qNucovNq/VMau1c46xpE
 ux5vtT/Tg7YTB0gheF+/fE+kTDmtubiO/lYZ/88Ky5zHqldXCyuM5BJXu9Qw7x1ly8
 iCrWfBRVuKHAtbFyOsc/MecX62mUqnqc9QWIRSSH67y+I4Yo/w/dDWcW3nQt+pX63h
 t5dZPyVUzLG8QAZj8ZBiE8V0bayt7uil6WiXlZk/4BbeLzFgNFV2hzmlMf4EzuqPOC
 ONOjqOAiPPlvs+e0MKFeC+zGWaVm+yNwxI5X21+Gf1P5EXUVMiY8UFFrk1Hp2qwVjZ
 h3wv8KwU1mzGw==
Message-ID: <16a57ae9d703e8aee8fbe8a243c7e40f@kernel.org>
Date: Mon, 07 Sep 2026 15:24:23 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Albert Esteve" <aesteve@redhat.com>
Subject: Re: [PATCH 0/3] drm/amd/display: use kunit/visibility.h for test
 helpers
In-Reply-To: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
References: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, "Alex
 Deucher" <alexander.deucher@amd.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "David
 Airlie" <airlied@gmail.com>, "Harry Wentland" <harry.wentland@amd.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Leo Li" <sunpeng.li@amd.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Rodrigo Siqueira" <siqueira@igalia.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Simona Vetter" <simona@ffwll.ch>
Content-Transfer-Encoding: 7bit
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

On Mon, 7 Sep 2026 15:28:55 +0200, Albert Esteve wrote:
> amdgpu_dm grew its own STATIC_IFN_KUNIT / EXPORT_IF_KUNIT /
> INLINE_IFN_KUNIT macros instead of using kunit/visibility.h. This
> series switches the KUnit helpers over to the common API.
> 
> VISIBLE_IF_KUNIT is gated on CONFIG_KUNIT rather than
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
