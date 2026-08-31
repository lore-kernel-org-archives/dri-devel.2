Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE25C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DAE710E2BE;
	Mon, 31 Aug 2026 15:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G5rTkYA/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8ED10E2BE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:13:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1156460120
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E8A1F000E9;
 Mon, 31 Aug 2026 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788189210;
 bh=okarqFUbUbiWadm6W5M//SRV2qp4IPk4Rv7GPm/L0dU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G5rTkYA/Ck7ZI2ycbk3o9XC3rXbu4vHUAMhn3U6fxvlBw56PN02NKKg8v86iUDGIq
 2U/SranZTRdwRKBcaho/6uXOkBpccdh77eXHrrHqS20ONTbtP2NyyGRXxZBiiemIjJ
 Is3+VjXh76DbRUa0t6nnqbC/Uc2Y8xv2AeuY/Yz8MuyO3cE98N3qNvi+FZRrtVm8xZ
 kTLdjg+q0gzEWkrCz/DS5Vf74ztqF0zoCCBiJKlhiInOKqz5UxRmHpty7LG9Tic1pL
 NhFXLDgKIdYRPaJXdpzt8Q0FncUmwjl8zAXgrOl0wty40ESgJ3O1ZMhvyvh4Y37b22
 hIdD8Xbu39Dqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.15] host1x: bus: Fix missing ops null
 check in error teardown
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-242-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-242-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:13:30 +0000
Message-Id: <20260831151330.90E8A1F000E9@smtp.kernel.org>
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
- [High] host1x_device_exit() aborts traversal on first error, leaving rema=
ining clients initialized and leaking resources.
--

commit 341e3b2b98688fedc7268fa3fee081e01848b232
Author: shayderrr <darknessshayder@gmail.com>

host1x: bus: Fix missing ops null check in error teardown

In host1x_device_init(), the error teardown paths do not check client->ops
before dereferencing it, which can result in a null pointer dereference.
This patch adds the missing client->ops check in both the teardown and
teardown_late labels.

Link: https://patch.msgid.link/20260517170456.84927-1-darknessshayder@gmail=
.com

> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index 344cc9e741c13..ffbf0ba4d602f 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -221,7 +221,7 @@ int host1x_device_init(struct host1x_device *device)
> =20
>  teardown:
>  	list_for_each_entry_continue_reverse(client, &device->clients, list)
> -		if (client->ops->exit)
> +		if (client->ops && client->ops->exit)
>  			client->ops->exit(client);
> =20
>  	/* reset client to end of list for late teardown */
> @@ -229,7 +229,7 @@ int host1x_device_init(struct host1x_device *device)
> =20
>  teardown_late:
>  	list_for_each_entry_continue_reverse(client, &device->clients, list)
> -		if (client->ops->late_exit)
> +		if (client->ops && client->ops->late_exit)
>  			client->ops->late_exit(client);
> =20
>  	mutex_unlock(&device->clients_lock);

This is a pre-existing issue, but I noticed a potential problem in the clos=
ely
related host1x_device_exit() function while reviewing this patch:

drivers/gpu/host1x/bus.c:host1x_device_exit() {
	...
	list_for_each_entry_reverse(client, &device->clients, list) {
		if (client->ops && client->ops->exit) {
			err =3D client->ops->exit(client);
			if (err < 0) {
				dev_err(&device->dev,
					"failed to cleanup %s: %d\n",
					dev_name(client->dev), err);
				mutex_unlock(&device->clients_lock);
				return err;
			}
		}
	}
	...
}

[Severity: High]
If any client's exit() callback returns an error, this early return inside =
the
loop skips the teardown for all remaining clients. Does this leave hardware
active, leak syncpts, and leave iommu mappings dangling, which could crash =
the
system upon further teardown?

A similar issue exists a few lines lower in the late_exit() loop:

drivers/gpu/host1x/bus.c:host1x_device_exit() {
	...
	list_for_each_entry_reverse(client, &device->clients, list) {
		if (client->ops && client->ops->late_exit) {
			err =3D client->ops->late_exit(client);
			if (err < 0) {
				dev_err(&device->dev, "failed to late cleanup %s: %d\n",
					dev_name(client->dev), err);
				mutex_unlock(&device->clients_lock);
				return err;
			}
		}
	}
	...
}

[Severity: High]
Similarly, does this early return inside the late_exit() loop abort the
traversal and leak resources for remaining clients?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-242-sashal@kernel.org?part=3D1
