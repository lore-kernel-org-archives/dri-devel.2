Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90730C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0358D10E4FC;
	Thu,  2 Jul 2026 15:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T5FHpraJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7752D10E4FC
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:04:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2C1C601C6;
 Thu,  2 Jul 2026 15:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDC21F000E9;
 Thu,  2 Jul 2026 15:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783004698;
 bh=cv08kpPt1pCrTQ1M73v25Po8qupacCu7hEvsEuI/iYk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T5FHpraJnBgLblrcnytqUir4S7J/pNWxX4VRtiOwXmoVnLdoOvOH3U5XN2Ilv2QBv
 m8Q5nlz/PCFeiWBlFZKlif1DI1LcNgupZpsLSgZ+dyquucRa6lF8xZdNT05aptATcz
 KSfugymL15qZJ5LlY2jO02Z3hlIB+3zwRi3PlbuVDGNjNqvAXZlu6zHzOTnn+t/JCu
 tzrQXhiOG83t5LcwseYbURMmIIZNgPNNtrfn1VpE6rv4lgywKFY6UaUjV2l7APHrls
 8/08+YuMc12LFiAqYO6UZ30cA0+b2DiA3kWDBl4DPDyKfQTCVEemyR2EFccEEhvZU+
 /vmZJCMI0zaGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/39] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-4-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-4-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:04:57 +0000
Message-Id: <20260702150458.6BDC21F000E9@smtp.kernel.org>
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
- [High] Missing delayed work cancellation causes use-after-free and memory=
 corruption on hot-unplug
--

commit 4ff004f5a0501b0ac5dedcf3dbce4ba7bc01c710
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/connector: Add HDMI 2.0 scrambler infrastructure

This commit introduces connector-level infrastructure to support HDMI 2.0
scrambling. It includes various capability flags and a new delayed work item
(scdc_work) to monitor sink-side scrambling status.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index c7ce6b7bd8b0e..deecfc582f093 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
[ ... ]
> @@ -285,6 +298,7 @@ static int drm_connector_init_only(struct drm_device =
*dev,
>  	mutex_init(&connector->edid_override_mutex);
>  	mutex_init(&connector->hdmi.infoframes.lock);
>  	mutex_init(&connector->hdmi_audio.lock);
> +	INIT_DELAYED_WORK(&connector->hdmi.scdc_work, drm_connector_hdmi_scdc_w=
ork);
>  	connector->edid_blob_ptr =3D NULL;
>  	connector->epoch_counter =3D 0;
>  	connector->tile_blob_ptr =3D NULL;

[Severity: High]
Does this delayed work need to be explicitly cancelled during connector
teardown?

If a device is hot-unplugged or the driver is unbound while the display is
active and scrambling is enabled, the driver's atomic disable hooks might
skip calling drm_connector_hdmi_disable_scrambling() (e.g., if
drm_dev_enter() returns false on a disconnected device).=20

If the connector is then torn down while scdc_work is still queued,
drm_connector_cleanup() will eventually be called, which zeros out the
connector structure:

drm_connector_cleanup()
    ...
    memset(connector, 0, sizeof(*connector));

Overwriting an actively queued delayed_work (and its internal timer_list)
with zeroes can corrupt the kernel's timer wheel and workqueue lists, leadi=
ng
to a use-after-free or kernel panic when the timer fires.

Should there be a cancel_delayed_work_sync(&connector->hdmi.scdc_work) added
to drm_connector_cleanup() to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D4
