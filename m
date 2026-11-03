Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816E606A328
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbYxzT7I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1167C10F60E;
	Tue,  3 Nov 2026 14:36:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8B910F60E
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:36:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 362EB40432
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77DA1F000C1;
 Tue,  3 Nov 2026 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793716571;
 bh=0iTIWBEMQgksMieXN6pTSQST6DaCbaC3RUzlsJhmak0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KbYxzT7Iw/Eu2v3Htlz2gMwVCb0u4EbDBvqsFQI6Kmb0a/lA0qyaDIoYOt1cc8lex
 PgpmhxL90Jv/W9zkjRqnHSU+1hbWfxkiCKmhKxyZhJIhxuJA33v2ZrrQ5czpp+ZLAu
 hI56DvRBTwwRld9COyzNozpQt5gJbFAFFQxiu9SZVqgey//W1nUkfBsq7TTZGEO584
 TuhUIjVU+QEf9bitMHPBGiEBvlS0DzwKXt12NVlkbtaeeTlcqDmMaetXFZBuszzY/1
 l91QhLs4FWweoFeyN2HocvGAvWYlUqIbkHjA9WIvvhiQT8jUf+cD9A/Q6A0NS60yBP
 l2X1x7pdtualg==
Message-ID: <sashiko-outbox-195461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
To: "Mario Limonciello" <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
References: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:36:10 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] drm/amd/display: UAF race on link->local_sink in amdgpu_dm_i2c=
_xfer()
- [High] drm/amd/display: NULL link dereference in amdgpu_dm_i2c_xfer()
- [Medium] drm/amd/display: amdgpu_dm_i2c_xfer() misses MST and force_to_us=
e_aux links
--

commit 7a7dcab86c8948b21ebe53eebc9df866754fd915
Author: Mario Limonciello <superm1@kernel.org>

drm/amd/display: Route connector DDC over AUX for native DP sinks

This commit updates amdgpu_dm_i2c_xfer() to route I2C transfers over the
DisplayPort AUX DDC adapter when a native DisplayPort, eDP, or MST sink is
detected on the link, while keeping the hardware I2C engine for DVI/HDMI
sinks.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index b498fc5fbb140..678caffa3d120 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3373,6 +3373,22 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c=
_adapter *i2c_adap,
>  	int i;
>  	int result =3D -EIO;
> =20
> +	if (!i2c->oem) {
> +		struct dc_link *link =3D ddc_service->link;
> +		struct amdgpu_dm_connector *aconnector =3D link->priv;

[Severity: High]
Can ddc_service->link be NULL here?

Previously, amdgpu_dm_i2c_xfer() checked ddc_service->ddc_pin before
dereferencing ddc_service->link. Moving this block ahead of the
ddc_service->ddc_pin check without verifying that link is non-NULL causes a
NULL pointer dereference in the existing KUnit test
dm_test_i2c_xfer_no_ddc_pin():

drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c:dm_t=
est_i2c_xfer_no_ddc_pin() {
	...
	i2c->ddc_service =3D ddc;
	i2c_set_adapdata(&i2c->base, i2c);

	/* ddc->ddc_pin is NULL -> transfer is rejected with -EIO. */
	KUNIT_EXPECT_EQ(test, amdgpu_dm_i2c_xfer(&i2c->base, NULL, 0), -EIO);
}

In that test, i2c->oem is false and ddc->link is NULL, so evaluating
link->priv crashes immediately.

> +
> +		/*
> +		 * DDC to a native DisplayPort sink is tunneled over the AUX
> +		 * channel; the physical i2c pins only reach DVI/HDMI sinks
> +		 * (e.g. DP++ with a passive adapter).  Route accordingly so
> +		 * the connector's single "ddc" bus works for either sink.
> +		 */
> +		if (aconnector && link->local_sink &&
> +		    dc_is_dp_signal(link->local_sink->sink_signal) &&

[Severity: Critical]
What protects link->local_sink against concurrent hotplug or link detection
while amdgpu_dm_i2c_xfer() reads and dereferences it?

Userspace I2C transfers on /dev/i2c-N invoke amdgpu_dm_i2c_xfer() holding
only i2c_adap->bus_lock, without acquiring aconnector->hpd_lock or
adev->dm.dc_lock and without taking a sink reference via dc_sink_retain().

Concurrently, link detection and disconnect paths release and free
link->local_sink before clearing or updating the pointer:

drivers/gpu/drm/amd/display/dc/link/link_detection.c:link_disconnect_sink()=
 {
	if (link->local_sink) {
		dc_sink_release(link->local_sink);
		link->local_sink =3D NULL;
	}
	...
}

drivers/gpu/drm/amd/display/dc/link/link_detection.c:link_disconnect_remap(=
) {
	dc_sink_release(link->local_sink);
	link->local_sink =3D prev_sink;
}

Similar unserialized releases happen in amdgpu_dm_connector_poll(),
amdgpu_dm_emulated_link_detect(), and detect_link_and_local_sink() (for
example when a temporary local_sink with refcount 1 is released on EDID
read failure, same_edid remap, or MST topology discovery). Could a
concurrent I2C transfer observe a non-NULL link->local_sink and suffer a
use-after-free or NULL pointer dereference when reading
link->local_sink->sink_signal?

> +		    aconnector->dm_dp_aux.aux.ddc.algo)
> +			return i2c_transfer(&aconnector->dm_dp_aux.aux.ddc, msgs, num);
> +	}

[Severity: Medium]
Will checking link->local_sink and dc_is_dp_signal() work for DP MST links
or links with force_to_use_aux set?

When an MST topology is started in discover_dp_mst_topology(),
link_disconnect_sink() is called immediately:

drivers/gpu/drm/amd/display/dc/link/link_detection.c:discover_dp_mst_topolo=
gy() {
	...
	if (dm_helpers_dp_mst_start_top_mgr(link->ctx,
			link, (reason =3D=3D DETECT_REASON_BOOT || reason =3D=3D DETECT_REASON_R=
ESUMEFROMS3S4))) {
		link_disconnect_sink(link);
	} else {
	...
}

This sets link->local_sink to NULL while downstream sinks are stored in
link->remote_sinks[], so link->local_sink is NULL on active MST links and
transfers will not be routed to the AUX adapter as described in the commit
message.

Additionally, on connectors with link->force_to_use_aux set (such as ASICs
with no_ddc_pin where ddc_service->ddc_pin is NULL), detect_dp() sets the
transaction type to DDC_TRANSACTION_TYPE_I2C_OVER_AUX (setting
link->aux_mode =3D true) while dp_passive_dongle_detection() sets
sink_caps->signal to HDMI or DVI:

drivers/gpu/drm/amd/display/dc/link/link_detection.c:detect_dp() {
	...
		if (!detect_dp_sink_caps(link)) {
			if (link->force_to_use_aux) {
				sink_caps->signal =3D dp_passive_dongle_detection(link->ddc, sink_caps,=
 audio_support);
	...
}

In that case dc_is_dp_signal(link->local_sink->sink_signal) is false and
the transfer falls through to the hardware I2C path (or fails with -EIO
when ddc_pin is NULL). Would checking link->aux_mode (similar to other DDC
selection paths in amdgpu_dm) handle native DP, MST, and force_to_use_aux
links without dereferencing link->local_sink?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-superm1-am=
dgpu-ddc-v2-1-7bde6d004382@kernel.org?part=3D1
