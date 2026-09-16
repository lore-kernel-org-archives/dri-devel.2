Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792E1C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A671F10E2B2;
	Wed, 16 Sep 2026 10:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NECwBO9e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1D510E2B2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:24:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA89440194;
 Wed, 16 Sep 2026 10:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633911F000FF;
 Wed, 16 Sep 2026 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789554257;
 bh=MUUSEvC8HwgkkdMSzSbvDCfYVxag3KBNi4U70+ipG0s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NECwBO9eooP+2PKrGlA7aqVNO2ZB9GgHxNoMB7QBQiBcNuxjGc9EIA7RXLhPYi914
 R/De0C/KKyqiuNqEA3aDEZA/6PPKmIIlfyj4XWldp7RhsIRE18V2LrHG77Azxkx6ok
 Rh5IZzSB5cnKpxAcoc8g1fmsQAr6lj02U2z7TGXDJ+on6myMPeSxI8txbrMRrUJc8U
 jkm1bBgwfh3jgAZfJJF0N40nrhI7MQU0Lk9Oshoj2rYtNvoCunW1xWIPjtfiPzmKEp
 etuniInqf2iICz6v4pIXep8Nb/Vbn/XBARz9T3dHiB1V89gqdk5ApbH5Jn9EdNDx5Y
 Ufa6X25P3nzwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: lt8912b: Fix next_bridge reference leak in
 lt8912_parse_dt()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916101401.2017498-1-vulab@iscas.ac.cn>
References: <20260916101401.2017498-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:24:16 +0000
Message-Id: <20260916102417.633911F000FF@smtp.kernel.org>
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
- [High] drm/bridge: double-put of next_bridge on error and teardown
--

commit 836b7cdeed1872c95aba63f08e9bc717bdb9d7d6
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/bridge: lt8912b: Fix next_bridge reference leak in lt8912_parse_dt()

This commit attempts to fix a reference leak by manually calling
drm_bridge_put() on the next bridge during error paths in lt8912_parse_dt()
and during driver teardown in lt8912_put_dt().

> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/b=
ridge/lontium-lt8912b.c
> index e347d04b7b2de..3bd920a43e936 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -748,6 +748,7 @@ static int lt8912_parse_dt(struct lt8912 *lt)
>  	return 0;
> =20
>  err_free_host_node:
> +	drm_bridge_put(lt->bridge.next_bridge);

[Severity: High]
Does this manual put operation leave a dangling pointer that will trigger a
double-put?

The lt struct is allocated via devm_drm_bridge_alloc(), which registers
a devres cleanup action that eventually calls __drm_bridge_free(). That
cleanup natively handles dropping the chained bridge reference by calling
drm_bridge_put(bridge->next_bridge).

Since this pointer isn't cleared here, will devres cleanup attempt to put
this already-freed reference again if an error occurs after
of_drm_find_and_get_bridge() succeeds (for example, if
lt8912_get_regulators() fails)?

>  	of_node_put(port_node);
>  	of_node_put(lt->host_node);
>  	return ret;
> @@ -755,6 +756,7 @@ static int lt8912_parse_dt(struct lt8912 *lt)
> =20
>  static int lt8912_put_dt(struct lt8912 *lt)
>  {
> +	drm_bridge_put(lt->bridge.next_bridge);

[Severity: High]
Similarly, will this cause a double-put during driver unbind?

When the driver is unbound, lt8912_put_dt() manually drops the reference
here. Then the devres cleanup automatically drops it again using the dangli=
ng
pointer, which could lead to a refcount underflow and use-after-free of the
next DRM bridge in the chain.

Could we either rely entirely on the devres cleanup, or use something like
a clear-and-put approach to avoid leaving a dangling pointer?

>  	of_node_put(lt->host_node);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916101401.2017=
498-1-vulab@iscas.ac.cn?part=3D1
