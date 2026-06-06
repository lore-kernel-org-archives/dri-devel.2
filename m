Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A752CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 10:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01362112DC1;
	Sat,  6 Jun 2026 10:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I7vpzo+9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D12C2112DC1
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 10:24:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16B10600AE;
 Sat,  6 Jun 2026 10:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D1C1F00893;
 Sat,  6 Jun 2026 10:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780741441;
 bh=MdWHBq2JHR3mwCK+qIDKi5c/3hYFowjr84ESpXb7Tqw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I7vpzo+9kO594JQId4b3fa830oH1eJjY1gm4jZCYWZZRz38Fn96TLcj4MWIMdPbyI
 SOlZy/GaJxOkwUXWLirzm97p2uFHfjY+0DnDpnHY3siauLoA98avn0ZoViANShQ/X2
 rFZfx9pg2qSQPcL1vKpb10PYj8iM3lvPht4hTZ6aj7VcDV16bzTwGuwkjytG3ADj0X
 vAZFO6EjsGlTL/5nP8r1fLfa+mK8GwijGPhCClltN43V1faLDv7r+CM1rdmbptuBQO
 EcZhWnYhISZVtStCCRF3d3mMyC21wxB9PEvIzs6Kjn4doq+TyL4YWK+hjqxhZP9pDq
 7w7p+V0GJIJMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/display: fix of_node refcount leak in
 of_dp_aux_populate_bus()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260606101201.51494-1-vulab@iscas.ac.cn>
References: <20260606101201.51494-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 10:24:01 +0000
Message-Id: <20260606102401.96D1C1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch implem=
ents an incomplete and structurally flawed fix. It fixes an `of_node` refer=
ence leak on the `device_register()` error path by manually adding `of_node=
_put(np)`, but fails to fix the exact same leak on the success path during =
normal device teardown.
--

commit cae4b5af9cb7c08097233a2381f0d6210847f798
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/display: fix of_node refcount leak in of_dp_aux_populate_bus()
   =20
This commit attempts to fix an of_node reference leak on the device_registe=
r()
error path by adding a manual of_node_put() after put_device().

> diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/d=
isplay/drm_dp_aux_bus.c
> index 6e5e3e5422905..9dd64cf25d871 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -305,6 +305,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
>  		 * of kfree() directly for error cases.
>  		 */
>  		put_device(&aux_ep->dev);
> +		of_node_put(np);
> =20
>  		goto err_did_set_populated;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but the fix appears to be
incomplete and could leave the leak unfixed on the success path.

The underlying issue seems to be that the device's .release callback doesn't
drop the dev->of_node reference:

drivers/gpu/drm/display/drm_dp_aux_bus.c:dp_aux_ep_dev_release() {
	...
	kfree(aux_ep_with_data);
	// Missing of_node_put(dev->of_node) here
}

By fixing the leak locally here on the error path in of_dp_aux_populate_bus=
(),
doesn't the success path still leak the second reference when the device is
later unregistered?

drivers/gpu/drm/display/drm_dp_aux_bus.c:of_dp_aux_ep_destroy() {
	...
	of_node_put(np); // Drops the first reference

	device_unregister(dev); // Calls release callback, missing second drop
	...
}

If the missing of_node_put() is instead added to dp_aux_ep_dev_release(),
would it resolve the leak for both the success and error paths?

It looks like the current approach might also create a trap where fixing the
.release callback in the future could trigger a double-free on the error pa=
th
due to this manual of_node_put().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606101201.5149=
4-1-vulab@iscas.ac.cn?part=3D1
