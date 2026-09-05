Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178DBC79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D45010E39F;
	Sat,  5 Sep 2026 18:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MIptMPBk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CFD10E39F
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:27:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6D5D43200;
 Sat,  5 Sep 2026 18:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920821F00A3A;
 Sat,  5 Sep 2026 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788632825;
 bh=sNAQArPK/b0xD8FVI/8U2AULUNqLjnY1C+G0uHb8F30=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MIptMPBkRjSf4QCLSMgdsWoQxfA7IGvF3cjMB+ExZLVcdBlv5hIp+TICfqqc02AQl
 T1Q1AwriGKgAPkAKivXeQQm67l/WxrMWtfNoDqdXvJRPgdi9SkuKiN7SAtqXFGyQZ4
 5ZjgAEMxjy79yDsnPZjjRUiMK9rDQiysTTE3bMJTp/0Wri28GBoQzAQhCW2ZzP1uNx
 XPZG/U+cNDcevxnylhS6gqRNvE/ltLFxMRJNLLZF1J3bR6eTf5/NqL0QdL5UTkDwwV
 6IpPnApvWNtvlrE6EdGiT0sUkvkzhjvHSDdz0H52qxQi7ewft+lU4H3lTQnxxSQTGx
 QTJ1sFwrSe23g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 30/43] dyndbg: check
 DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-30-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-30-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:27:05 +0000
Message-Id: <20260905182705.920821F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compile-time check incorrectly rejects valid class ID 62 due to an =
off-by-one error in the upper bound assertion.
--

commit eff2fbed05187c69eca3bc170f67e07db2c41b8d
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: check DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time

This commit adds the __DYNAMIC_DEBUG_CLASSMAP_CHECK macro to implement
compile-time argument checks for dynamic debug classmaps. These assertions
validate bounds for the base offset, class names length, and map types to
prevent simple misuses.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 17fc3a29d97b8..471b9891bd83b 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -197,6 +197,19 @@ struct ddebug_class_param {
>   * __pr_debug_cls(22, "no such class"); compiles but is not reachable
>   */
> =20
> +#define __DYNAMIC_DEBUG_CLASSMAP_CHECK(_clnames, _base, _mapty)		\
> +	static_assert(((_base) >=3D 0 && (_base) < _DPRINTK_CLASS_DFLT),	\
> +		      "_base must be in 0..62");			\
> +	static_assert(__DDEBUG_ARRAY_SIZE(_clnames) > 0,				\
> +		      "classnames array size must be > 0");		\
> +	static_assert(__DDEBUG_ARRAY_SIZE(_clnames) <=3D 32,			\
> +		      "classnames array size must be <=3D 32");		\
> +	static_assert((__DDEBUG_ARRAY_SIZE(_clnames) + (_base)) < _DPRINTK_CLAS=
S_DFLT, \
> +		      "_base + classnames.length must be <=3D 62");	\

[Severity: Low]
Does this logic introduce an off-by-one error that inadvertently rejects
valid class maps?

The first static assertion correctly allows a base up to 62 by verifying
it is less than _DPRINTK_CLASS_DFLT.=20

However, if a class map is defined with a single class at a base of 62, the
sum of the base and array size evaluates to 63. Since this check strictly
enforces that the sum must be less than _DPRINTK_CLASS_DFLT (meaning <=3D 6=
2),=20
it would fail compilation.

Should this assertion allow the sum to be equal to _DPRINTK_CLASS_DFLT=20
to permit a single class definition at the highest allowed base?

> +	static_assert(((_mapty) >=3D DD_CLASS_TYPE_DISJOINT_BITS) &&	\
> +		      ((_mapty) <=3D DD_CLASS_TYPE_LEVEL_NUM),		\
> +		      "unknown class_map_type")
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D30
