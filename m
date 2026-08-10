Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8179C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3F810E1C9;
	Mon, 10 Aug 2026 10:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OAXFjQl+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABE410E1C9
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:29:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9688760052;
 Mon, 10 Aug 2026 10:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB121F000E9;
 Mon, 10 Aug 2026 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786357760;
 bh=ZGYZG6uK03QhJLmCfvKV4w7Vwd4H4WQZh1TvT+dbNIE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OAXFjQl+tUBZcHW+2PrgwbhovzhllTVUGIhiNAaUIO0wpDYz0Bv7tolJBz3NhavX6
 wreLKtVjIQJBUheiQNTqYeGo2U4gR1Wf3D/faUiNtW9xRNS3fph5aSKqYUzPVXlhQy
 mX4MF+cC5DEB4VviEeYZI8b9S6lZdTKV3xBN302GPWErseJGMyJvjBsTRhKRUMq6bl
 3plmEg2Xl0NwFIxnSOGQ1mJ1xZ2tBHxo7mSuvY2ZoL35k9IaVdvIaum+cEezlWj9nx
 tR+S2eqyoQO1qIA0fuheMoJChgjJO6rgnDf8yCRpPU/Wel3O/wkv1hrJlivF9zMKke
 FfiFL+oG5MqaQ==
Date: Mon, 10 Aug 2026 11:29:15 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
 stable@vger.kernel.org, Junjie Cao <junjie.cao@linux.dev>
Subject: Re: [PATCH v3 1/3] backlight: aw99706: Fix DT property names to
 match binding
Message-ID: <anmn-xaMAS6ZuT0x@aspen.lan>
References: <20260804030255.1934470-1-junjie.cao@intel.com>
 <20260804030255.1934470-2-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804030255.1934470-2-junjie.cao@intel.com>
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

On Tue, Aug 04, 2026 at 11:02:53AM +0800, Junjie Cao wrote:
> From: Junjie Cao <junjie.cao@linux.dev>
>
> The driver reads four tuning properties without the unit suffixes that
> the binding mandates: "awinic,sw-freq" instead of "awinic,sw-freq-hz",
> "awinic,sw-ilmt" instead of "awinic,sw-ilmt-microamp", "awinic,iled-max"
> instead of "awinic,iled-max-microamp", and "awinic,uvlo-thres" instead
> of "awinic,uvlo-thres-microvolt".
>
> As a result, device_property_read_u32() never finds these properties in
> a binding-conformant device tree and silently falls back to the compiled-in
> defaults for switching frequency, switching current limit, max LED current,
> and UVLO threshold.
>
> Fix by aligning the property name strings in aw99706_dt_props[] with the
> binding. No value/range changes are needed since both sides already use
> the same units and enumerations.
>
> Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

There don't seem to be any usage of these properties in-tree so I think
it is probably OK to change the driver behaviour without fallbacks for
DTs with version skew!

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
