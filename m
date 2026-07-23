Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB24AC44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1785210EF53;
	Thu, 23 Jul 2026 01:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UW2jIQvf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E7810EF53
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:51:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2B38403B3;
 Thu, 23 Jul 2026 01:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707461F00A3A;
 Thu, 23 Jul 2026 01:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771466;
 bh=U8EJs3KLA2K0Qb19JTSw7449bA8ULFvhVZH18fTC7Nc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UW2jIQvfrGOKinfikUzdFeFFSOtcVrGwJn4rmjh5NjhTe+opgmj7kOjSFgxFfcvpP
 ZOdY1PcubCTYmqozS5N5XmQPQu3YnoutCTl3LJbGbNeGkIvaS5tNVoMSSsSwaDVwtx
 DIAG61mSEJ9hKJz88kGhNGjqh7HkzHtZ7amPEBzridtBSOIrW0eCdmJbUrasvnHnLL
 apXVtRNUkmA4S3BQdhk8c21mc1ShQd4Ni3HbgmCuspk0MocqELy2yyQJ3VZZSRLt/5
 Lghk0UnXTEUE/Pwk+9ISwJZFfudKNXtHJyXuaBoKF403HxeKjIpSf/QgKs0As7DAtL
 cQn7jbfVFwT7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/61] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-5-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-5-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:51:06 +0000
Message-Id: <20260723015106.707461F00A3A@smtp.kernel.org>
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
- [High] The HDMI SCDC delayed work is cancelled in `drm_connector_cleanup(=
)`, which executes at `drm_dev_release()` time for connectors initialized w=
ith `drmm_connector_init()` or `drmm_connector_hdmi_init()`. Since `drm_dev=
_release()` can be indefinitely delayed by userspace holding open file desc=
riptors, the cancellation happens after the driver's `remove()`/`unbind()` =
function has completed and devres-managed resources (like I2C adapters or M=
MIO mappings) have been destroyed. If the delayed work fires during this wi=
ndow, it will attempt to access freed hardware resources, leading to a kern=
el panic or use-after-free. The cancellation must be performed synchronousl=
y during driver unbind, such as in `drm_connector_unregister()`, to guarant=
ee the work does not outlive the hardware.
--

--- Patch [5]: [PATCH v9 05/61] drm/connector: Add HDMI 2.0 scrambler infra=
structure ---
commit eea776d2943670e22f8c3877d36bf6a592c40119
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: drm/connector: Add HDMI 2.0 scrambler infrastructure

This commit adds connector-level infrastructure to support HDMI 2.0
scrambling. It introduces new callbacks, state flags, and a delayed work
item (scdc_work) to monitor and retry sink-side scrambling setup.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 72b6304348028..96cca0ca64bd9 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
[ ... ]
> @@ -914,6 +932,9 @@ void drm_connector_cleanup(struct drm_connector *conn=
ector)
>  		    DRM_CONNECTOR_REGISTERED))
>  		drm_connector_unregister(connector);
> =20
> +	if (connector->hdmi.scdc_work_initialized)
> +		cancel_delayed_work_sync(&connector->hdmi.scdc_work);

[Severity: High]
Since drmm_connector_hdmi_init() uses drmm, drm_connector_cleanup() will
execute at drm_dev_release() time. If userspace holds an open file
descriptor, drm_dev_release() can be indefinitely delayed after the
driver's remove() or unbind() function has completed.

If the device is unbound (e.g., via sysfs or physical hot-unplug) and
devres-managed resources like I2C adapters or MMIO mappings are destroyed,
could scdc_work fire during this window and attempt to access freed
hardware resources, leading to a use-after-free or kernel panic?

Should this cancellation be performed synchronously during driver unbind,
such as in drm_connector_unregister(), to guarantee the work does not
outlive the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D5
