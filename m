Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80823606A329
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOrLe2A1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4C510E4C2;
	Sun,  1 Nov 2026 22:39:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C98310E4C2
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:39:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 309FF605CB;
 Sun,  1 Nov 2026 22:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30051F000C1;
 Sun,  1 Nov 2026 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793572758;
 bh=hf3qEG9NmJxzw7DT6BIkRMug1Ad628c5lLT2IyGQPg4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SOrLe2A1GKPvAT9csvu+/MiHijFnKR9unJKelnL7qynJX3Hh+w2hllDFyTalbshGB
 jFh8MiHSWJ34U8iX7/XjIu1I0CBVbPydpXLv7EKLiZkXn+NT9JuGopSNrXfw1ouKE4
 N5P1FfAwv2QlxjnYNpecw5GJeSRAzPuVqgXwuf8KOBY4ud8Yoico8k4P8Cvwo2xUSu
 YiwzDVl7lUsFXixEJHBgtse4tvTrw5wabpqBhJTUvZIuvPfVX1pWJ0nzXhcpO0vKOV
 QQMzLxhIDvkoRJI9eQyuRdlEyVok27vnKc5ZU0anA8qxFJQpwgnLz7lZsoRApeyhZy
 qMIVlsmQ6qYsw==
Message-ID: <sashiko-outbox-192720@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/25] accel/qda: Add initial QDA DRM accelerator driver
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-2-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-2-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:39:18 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] accel/qda: !DRM_ACCEL_QDA in Kconfig allows building both driver=
s as modules
--

commit 546c9c847d7dbca90dfe6d1ba0861765d71753de
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add initial QDA DRM accelerator driver

This commit adds the initial DRM compute accelerator skeleton driver for
Qualcomm Hexagon DSPs (qda), binding to the same RPMsg device tree
compatibles as the legacy fastrpc driver. It also adds a Kconfig dependency
on QCOM_FASTRPC intended to make the two drivers mutually exclusive.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index c40e89cc57243..14b7bbaadcaa0 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -269,6 +269,7 @@ config QCOM_FASTRPC
>  	tristate "Qualcomm FastRPC"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on RPMSG
> +	depends on !DRM_ACCEL_QDA

[Severity: Medium]
As reported by Sashiko on v1 [1], since DRM_ACCEL_QDA in
drivers/accel/qda/Kconfig and QCOM_FASTRPC in drivers/misc/Kconfig are both
tristate symbols, does "depends on !DRM_ACCEL_QDA" still allow both drivers
to be built together as modules?

In Kconfig tristate logic (EXPR_NOT in scripts/kconfig/expr.h), when
DRM_ACCEL_QDA=3Dm, !DRM_ACCEL_QDA evaluates to m rather than n. That only
prevents QCOM_FASTRPC=3Dy when DRM_ACCEL_QDA=3Dm, while still allowing
QCOM_FASTRPC=3Dm and DRM_ACCEL_QDA=3Dm at the same time. Both modules then
export the same OF device table entries in qda_rpmsg_of_match and race to
bind to the same RPMsg devices.

Should this dependency instead be written as:

	depends on DRM_ACCEL_QDA=3Dn

so that QCOM_FASTRPC is disabled whenever DRM_ACCEL_QDA is enabled as either
built-in or a module?

[1] https://lore.kernel.org/r/20260519-qda-series-v1-3-b2d984c297f8@oss.qua=
lcomm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D2
