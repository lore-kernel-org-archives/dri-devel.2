Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE8BCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDFF10E090;
	Thu, 15 Oct 2026 12:11:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0143610E12A;
 Thu, 15 Oct 2026 12:11:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B26CE43A38;
 Thu, 15 Oct 2026 12:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131511F000C4;
 Thu, 15 Oct 2026 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792066291;
 bh=c6YnxnG+gJbch+R5VS3vE5pnef9Y+ENKkjRrOC1AvnE=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=m/Q7753DNhXKEODgQGQdxWcbrMpjx1MzEMR7nI3q8i13U46QsL98/SDWtVjpraAtq
 gypNBCcMRkHTE93IervYneCQI7U2jIEAFHvLvskPHo8VY9tMCrk7So5mbtzTFEJIdn
 EiYPuRSHEPJtRAlPvZ8eC7rFQvQUEFEb9xWo3xDK3Hx/lWF4uTpfyCN7xqBO2KyLsR
 lHOWBtBr9srEbnksFyYU3MItPH4GmPbQoCF4Rux1liPgn3zBaqnVi959Bm4vY3Kc4S
 GFxTzVT5y9vQoM/vgZFV/vOla4FhxBNOVLd3wqZkw9XWAjqeIxuSPL/Z0wIfsiG1Yq
 5Kf3rmItiOMxw==
Message-ID: <b9c2f013a83257e2416ece9183d7efda@kernel.org>
Date: Thu, 15 Oct 2026 12:11:27 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Albert Esteve" <aesteve@redhat.com>
Subject: Re: [PATCH v2 0/3] drm/amd/display: use kunit/visibility.h for test
 helpers
In-Reply-To: <20261013-visibility-unification-v2-0-3ce8d458bddf@redhat.com>
References: <20261013-visibility-unification-v2-0-3ce8d458bddf@redhat.com>
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

On Tue, 13 Oct 2026 13:58:12 +0200, Albert Esteve wrote:
> amdgpu_dm grew its own STATIC_IFN_KUNIT / EXPORT_IF_KUNIT /
> INLINE_IFN_KUNIT macros instead of using kunit/visibility.h. This
> series switches the KUnit helpers over to the common API.
> 
> VISIBLE_IF_KUNIT is gated on CONFIG_KUNIT rather than
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
