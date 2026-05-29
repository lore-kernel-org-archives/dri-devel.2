Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65533CD6E4C
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 10:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B70D110FC5A;
	Fri, 29 May 2026 10:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jzdsUzu7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B96C10FC5A
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:01:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7390E6056E;
 Fri, 29 May 2026 10:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112B61F00893;
 Fri, 29 May 2026 10:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780048891;
 bh=mkftG1497aD4Pdh1IFIy0l2/xnbdOjhiCCxVTjY6l8c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jzdsUzu7sixsZCw9+4zNQNrHc328nlcGG5lKjCztOrywKABZ/1bRkh6Uy+2JgJFzZ
 EgynfvCBGtzZqrfBr68ocw7QVwZsEw4iJL/zvw/qWHkxl3+ffONuMsjwcPECfKdUvk
 TubwT2Iw+eTWcM6XViSglwm8AoFvqR2Qa4wSQtYUT2xCs8L59qvVBPyfABujcsWyXs
 h7ZpvjVoFFjz9lmdPCQHoHf4uZ69KqL0aEvym9N6wFb53Jy1SrozOFMYmlflpCw/sR
 akSAUjYGka0Eo2XmnXptUkA6ttOVoVNg6M5F3Oec4Eq9Qw5AYI+VTbKtqjxeoAsrLT
 UxywWndFFItPQ==
Date: Fri, 29 May 2026 11:01:26 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Helge Deller <deller@gmx.de>, Junjie Cao <caojunjie650@gmail.com>,
 Jianhua Lu <lujianhua000@gmail.com>,
 Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: Use named initializers for arrays of
 i2c_device_data
Message-ID: <ahlj9ttqaFwuSADJ@aspen.lan>
References: <20260518111203.639603-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518111203.639603-2-u.kleine-koenig@baylibre.com>
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

On Mon, May 18, 2026 at 01:12:03PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>
> While touching all these arrays, unify usage of whitespace in the list
> terminator.
>
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
