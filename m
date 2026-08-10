Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7AAC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41BFA10E1CF;
	Mon, 10 Aug 2026 10:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KwKMO36K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5E510E1CF
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:32:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79300439EE;
 Mon, 10 Aug 2026 10:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F341F000E9;
 Mon, 10 Aug 2026 10:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786357930;
 bh=WrRJUK9pSo1FHli+5/hD0ukGvlWes/MfgeuFvY35wI0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KwKMO36KrAdAkcBdOtCdtshwrkLhIYglkYRcVbZ8DxeYlsxVIHCod4Go7PZJA0DBP
 Qncj/GT5J1yiB4gmip7siP93DGwY2kVpYzZd0mkoyoxslETLkAd7Xa2ZtVJfbDSCyR
 FCnJxERkDEBmFKi1HdyGzKIDJKumB0E5kGhMMc/4uA/3ovxnr4cYSh2dfdJMJ9FzuQ
 QlO6D/LEHPPDXPQ9qUhVC879WJxs7ip9ATN0QlKGthTNsr3GESBB/bkfH8aqcSynbE
 cQ+zVKInebcN/wbb9kaVsQ2TSl4v++V1TvuCcvYxsXAlIWx7bAjGdnEZMbSuJLXrX2
 zcgQLZ7adrHvA==
Date: Mon, 10 Aug 2026 11:32:05 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
 Junjie Cao <junjie.cao@linux.dev>
Subject: Re: [PATCH v3 2/3] backlight: aw99706: Validate all DT property
 values consistently
Message-ID: <anmopWozGMDKXAyq@aspen.lan>
References: <20260804030255.1934470-1-junjie.cao@intel.com>
 <20260804030255.1934470-3-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804030255.1934470-3-junjie.cao@intel.com>
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

On Tue, Aug 04, 2026 at 11:02:54AM +0800, Junjie Cao wrote:
> From: Junjie Cao <junjie.cao@linux.dev>
>
> The lookup helpers for dim-mode and ramp-ctl take a shortcut when
> lookup_tbl is NULL: they accept any u32 value without range-checking
> and return success unconditionally. Out-of-range values get silently
> truncated by regmap_update_bits instead of triggering the dev_warn +
> default-fallback path that the other properties use.
>
> Add a field-width check for the NULL-table case so that values
> exceeding the register field maximum are rejected the same way a
> table-lookup miss is.
>
> The switching frequency table has a second hole: reserved slots use 0
> as their marker, so "awinic,sw-freq-hz = <0>" matches slot 0 and
> programs a reserved encoding. Make the reserved marker U32_MAX and
> skip such slots during lookup.
>
> While here, also switch the error returns to -EINVAL for consistency.
>
> Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
