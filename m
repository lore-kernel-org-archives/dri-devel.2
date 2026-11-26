Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B5606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8Y7d5Sv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E896411237F;
	Thu, 26 Nov 2026 11:48:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1FA410E99D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:48:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9F23405DA;
 Thu, 26 Nov 2026 11:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5CA1F000C6;
 Thu, 26 Nov 2026 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693722;
 bh=Xt+QBISogWc4SXeONJi003qwXErMsE2lgxaTJT5Fs4o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n8Y7d5Sv//R3PyY3ltEc5FgH/wVFAdbNFthhQSgtUIZf8WVC6a0P5cnE/SR+sXXkg
 ktETlBFpbA+AuQIuADS7AXQhOgSm4zKq/5492X2UlNH3ayHVmchXDa+0mQtSjELA2C
 JAV0av9JMPYlW6MfFtAJS8KwOJkPyTLabeIUr2+jFk4mi963ITosxjaRwr6hH82WGA
 KFz7KD/TiMpW1rAUnBrdYDBQcFBbnnqsIi7R2AYTFTCxepqxyzriuNiE3Xjog10oV5
 ON0DfVef8N66trDQc63t+U9c+mMIcbrV3PEzaiprr5nfov/r93jIw7zZ5WrF6sHDrv
 Ct0/x8ttuystQ==
Message-ID: <sashiko-outbox-235420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/43] drm/vkms: Reset config->dev when the device
 creation fails
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-10-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-10-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:48:41 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/vkms: missing Fixes trailer for vkms_create() dangling
  config->dev fix
--

commit 83801dc57b80afdf7dea1ce28f5739fe30a5a8da
Author: Louis Chauvet <louis.chauvet@bootlin.com>

> drm/vkms: Reset config->dev when the device creation fails
>
> vkms_create() stores the vkms_device in config->dev, but the error paths
> after that point free the device (through devres_release_group()) without
> clearing the pointer. The configuration then keeps a dangling pointer,
> which can be dereferenced later (for example by vkms_destroy() or by the
> configfs disable path) once the device is already gone.
>
> Clear config->dev in the out_devres error path so the configuration stays
> consistent when the device creation fails.
>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

[Severity: Low]
This fixes a bug introduced when vkms_create() began storing vkms_device
in config->dev without clearing it on the out_devres failure path.
Should this include:

  Fixes: 2df7af93fdad ("drm/vkms: Add vkms_config type")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D10
