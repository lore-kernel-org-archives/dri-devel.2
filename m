Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52154C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A636A10F06F;
	Thu, 20 Aug 2026 14:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NefOKIfS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1BB10F071
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787237049;
 bh=r+P77I8193wL11BA4etBba+tHuwbkrJlDBvncLxVpGQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NefOKIfS0kIidLqvfhuoMts5ws8TZGCYbHJqJh4sVaTgdEmAPdB/q3PG1EQE7iO6Q
 cqzxuAlfR/yeZQUEGjPHZEWKmSZgDulSW2iKPRJ+iF9A7+hEBLIEQ+l+8a/siAVHNP
 NIKC/+wYm4AzpxAOVjCaX7gNhl1daeuLJmpKq3v2HKeNeyusj1UH/0IfUENchgCjUV
 Dpx/zSzJyt6pb+0nmJNzi7hlzT6n4dGhSCcCYnqGResiqWiZezuXDzelZ9pRFGV/Uy
 o9DZmjNZ0B0wTETIZmU3mI/Z2smzQ868bW/dgUZU0u0KzCMKzKFwTM34gL5KctSngW
 ikVQS5skLw1+A==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AC31117E0756;
 Thu, 20 Aug 2026 16:44:08 +0200 (CEST)
Message-ID: <774c38bd-6569-4aff-9fbc-a4e017840a55@collabora.com>
Date: Thu, 20 Aug 2026 17:44:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 22/69] drm/display: hdmi-state-helper: Sync SCDC state
 on hotplug
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Algea Cao <algea.cao@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Liu Ying <victor.liu@nxp.com>, Phong LE <ple@baylibre.com>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
 Maud Spierings <maud_spierings@hotmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-22-294364b2cf15@collabora.com>
 <20260820-accomplished-curly-bandicoot-cc36ba@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260820-accomplished-curly-bandicoot-cc36ba@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 8/20/26 11:53 AM, Maxime Ripard wrote:
> On Fri, Jul 31, 2026 at 07:19:29PM +0300, Cristian Ciocaltea wrote:
>> drm_atomic_helper_connector_hdmi_hotplug() does not currently
>> synchronize SCDC status on hotplug events, leaving the scrambler state
>> potentially inconsistent after (re)connect.
>>
>> Hook drm_connector_hdmi_sync_scdc() into both the connect and disconnect
>> paths, replacing the existing TODOs around missing scrambler handling.
>>
>> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
>> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 23 ++++++++++++++---------
>>  1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> index 4a93c279c9a7..3377ea936120 100644
>> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> @@ -1205,13 +1205,16 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
>>  					enum drm_connector_status status)
>>  {
>>  	const struct drm_edid *drm_edid;
>> +	int ret = 0;
>>  
>>  	if (status == connector_status_disconnected) {
>> -		// TODO: also handle scramber, HDMI sink disconnected.
>> -		drm_connector_hdmi_audio_plugged_notify(connector, false);
>> -		drm_edid_connector_update(connector, NULL);
>> -		drm_connector_cec_phys_addr_invalidate(connector);
>> -		return 0;
>> +		ret = drm_connector_hdmi_sync_scdc(connector, false, ctx);
>> +		if (ret != -EDEADLK) {
>> +			drm_connector_hdmi_audio_plugged_notify(connector, false);
>> +			drm_edid_connector_update(connector, NULL);
>> +			drm_connector_cec_phys_addr_invalidate(connector);
>> +		}
> 
> If there's a deadlock, shouldn't we restart the whole sequence there?

In that case we do already propagate -EDEADLK and let the callers
(drm_helper_probe_detect_ctx(), drm_helper_probe_single_connector_modes())
to ensure the sequence is restarted.

> Ie, we should return ret all the time anyway? And if we do that, we
> should return ret for drm_edid_connector_update() too.

Per .detect_ctx() contract, implementations shall return a drm_connector_status
value or -EDEADLK only.  On the other hand, .force_ctx() accepts any error code,
but the probe helpers just log it.  Hence returning anything else wouldn't
really have an impact on the functionality.

Returning errors from drm_edid_connector_update() would potentially override
non-deadlock ones from sync_scdc().  Since both helpers already log their own
failures, I think it isn't worth the trouble.

> Either way, a comment on why we're doing it this way would be nice.

Indeed.  Would the following be too verbose?

/*
 * The SCDC resync may reset the CRTC, which might involve aquiring
 * modeset locks.  If that fails, -EDEADLK is reported and the callers
 * passing a non-NULL @ctx drop the locks and restart the sequence
 * - see drm_helper_probe_detect_ctx() and
 * drm_helper_probe_single_connector_modes().
 *
 * The resync runs first, and the audio and CEC helpers only once the
 * link state has settled: the CRTC reset is a blocking commit, so on
 * success the pipeline is already up again, while on -EDEADLK nothing
 * has been resynced yet and the pending retry redoes everything.  This
 * keeps userspace from acting upon a link that is about to be reset.
 *
 * -EDEADLK is the only status gating the helpers below, as it is the
 * sole one guaranteeing a new run.  The other failures are merely
 * reported: .force_ctx() accepts any error code and the probe helpers
 * just log it, while .detect_ctx() has to swallow it, being only
 * allowed to return a drm_connector_status value or -EDEADLK.
 * Propagating the status of drm_edid_connector_update() on top would
 * therefore only make it compete with an earlier resync failure over a
 * value that triggers no recovery, the more so as both helpers already
 * log their own errors.
 */

Thanks,
Cristian
