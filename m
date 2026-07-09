Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7447CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D26B210E074;
	Thu,  9 Jul 2026 15:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YLb+c+Ul";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD48C10E074
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 15:21:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FD1042ADF;
 Thu,  9 Jul 2026 15:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B5F1F000E9;
 Thu,  9 Jul 2026 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783610514;
 bh=/LjIwe0ZhWzp3ntvW1UMokl0Go/bHge2xDdNAgktuzI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YLb+c+Ul7nsrP/sI+AxsR1/a24gNvTbQm4aRJumFhDquer67OGhp4ZX4HmLbW6eLi
 bzRL3DygRmEJflbX4JEAEj77GTgKOZBVPkK/rbgUWDl+bpfVu6GNAQXAy3fw4cZqG/
 8Kmc8UO2yYv62H9mvvo/kmUyTYkuTspsmeUSspxdcnr7ddTLoRtm5WNpihq/BpCeDb
 SZVZiaGCh3kOgiSvbDRlcnDfFLHtSjPFAgymsOGtCr7tJWk0dMrpYyMmvZ5dVJYX+Y
 HsSyHbK33hvvSGXfHgjd8RizhAQBTyR7FGSWz2LWE1tcyE8tjYGggi3eF3AJ5swTEp
 fXpsMQHVPssOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vkms: Fix UAF between connector configfs rmdir and
 .detect
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709150637.45052-1-security@auditcode.ai>
References: <20260709150637.45052-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:21:53 +0000
Message-Id: <20260709152154.22B5F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] RCU-001 violation: `xa_destroy` is called on `possible_encoders`=
 before the object is unlinked from the RCU list.

Pre-existing issues:
- [High] The debugfs helper `vkms_config_show` is vulnerable to a Use-After=
-Free because it traverses configuration lists without locks or RCU protect=
ion.
--

--- Patch [1]: [PATCH] drm/vkms: Fix UAF between connector configfs rmdir a=
nd .detect ---
commit 7286ff600c4e0777d618b609fd944dc368ecbf69
Author: Ibrahim Hashimov <security@auditcode.ai>

drm/vkms: Fix UAF between connector configfs rmdir and .detect

This commit addresses a race condition between concurrent configfs directory
removal and drm connector detection in the vkms driver. It introduces RCU
protection for the connector configuration list to decouple the free side
from the read side, avoiding a lock-ordering deadlock.

> No other vkms_config_for_each_connector() call site (vkms_output.c,
> vkms_config.c is_valid()/debugfs helpers) races a concurrent free:
> they all run either at device-build time (single-threaded) or already
> under connector->dev->lock, so they are left untouched to keep the fix
> minimal and scoped to the reported sink.

[Severity: High]
This is a pre-existing issue, but is this statement about debugfs helpers
accurate?

Looking at vkms_config_show() in drivers/gpu/drm/vkms/vkms_config.c, it is
invoked by the VFS seq_read and iterates over the device's planes, CRTCs,
encoders, and connectors locklessly. It does not appear to acquire the
configfs device mutex dev->lock.

Since configfs permits users to rmdir configuration directories at any time,
a concurrent rmdir triggers the configfs release callbacks like
plane_release() and connector_release(). For planes, CRTCs, and encoders,
these callbacks synchronously kfree() the objects.

Could a concurrent rmdir executed during a debugfs read cause
vkms_config_show() to traverse into freed memory?

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index 5a654d6dead84..fc402cf487753 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -608,8 +615,19 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
>  void vkms_config_destroy_connector(struct vkms_config_connector *connect=
or_cfg)
>  {
>  	xa_destroy(&connector_cfg->possible_encoders);

[Severity: Medium]
Does this code fully unlink the object from the RCU-protected list before
destroying its components?

In vkms_config_destroy_connector(), xa_destroy() is called on
connector_cfg->possible_encoders before list_del_rcu() removes the object
from the list. This leaves the object partially destructed while it is still
globally visible to concurrent RCU readers traversing the config->connectors
list.

Even if the current RCU reader does not access this field, should the object
be unlinked via list_del_rcu() before calling xa_destroy() to ensure safe
remove-before-reclaim ordering?

> -	list_del(&connector_cfg->link);
> -	kfree(connector_cfg);
> +
> +	/*
> +	 * connector_release() (vkms_configfs.c) can free a connector while
> +	 * vkms_connector_detect() is concurrently walking the connectors list
> +	 * under its own RCU read-side critical section (it cannot take the
> +	 * configfs device lock: it already runs under
> +	 * drm_device.mode_config.mutex, and vkms_destroy() takes the two
> +	 * locks in the opposite order, so plain locking here would deadlock).
> +	 * Unlink with the RCU-safe primitive and defer the free to after a
> +	 * grace period so concurrent readers never dereference freed memory.
> +	 */
> +	list_del_rcu(&connector_cfg->link);
> +	kfree_rcu(connector_cfg, rcu);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709150637.4505=
2-1-security@auditcode.ai?part=3D1
