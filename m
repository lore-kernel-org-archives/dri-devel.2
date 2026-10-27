Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EE606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=Bhx+Es3h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB87F10E306;
	Tue, 27 Oct 2026 10:18:37 +0000 (UTC)
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch
 [109.224.244.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5A910E306
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1793096309; x=1793355509;
 bh=SC1BsGXyB6CzybWZf1MnM1dhxpFm3P6mATHYwTP3CFU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Bhx+Es3hhN7lDEmYmva6k8/HHO59r77Xy4tNTZCU7FgqkL6ux34D11fZcaZ+YKyms
 irRN9iaUzTM45GXmzd5rY3ftUHRpGCM0ZaouV9RGV1n87wxUI5Nm0j0JEl373UgVLv
 NOqW2bIcHs1YYfstogSjqxhXtmaAoD9ijiIQvyEhr60woYCTNOuykIKkjCiqMHo1Az
 OFb7EQIiTqRlmR07eUEVourplHBNKJqeFKTzMNEQIy0jtMK+U6q+S3o0oQg/UESs2r
 AG0TzAJvPq5ob1Ve0K3HDmizR2Lswewf/PTHg2Ovg6sNYdjxP00l0dQ3pxyGYV7YGn
 aVYpi6bskS1sw==
X-Pm-Submission-Id: 4jDRKF0pKhz1DF7H
From: Esben Haabendal <esben@geanix.com>
To: "Liu Ying" <victor.liu@nxp.com>
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>,  "Neil Armstrong"
 <neil.armstrong@linaro.org>,  "Robert Foss" <rfoss@kernel.org>,  "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>,  "Jonas Karlman"
 <jonas@kwiboo.se>,  "Jernej Skrabec" <jernej.skrabec@gmail.com>,  "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>,  "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,  Guido
 =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,  "Fabio Estevam"
 <festevam@gmail.com>,  "Robert
 Chiras" <robert.chiras@nxp.com>,  "Sam Ravnborg" <sam@ravnborg.org>,
 <dri-devel@lists.freedesktop.org>,  <linux-kernel@vger.kernel.org>,
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>
Subject: Re: [PATCH RESEND v4 4/4] drm/bridge: nwl-dsi: Correct MIPI DSI
 horizontal sync timing
In-Reply-To: <atH4i_KcmccKb8Ge@raspi>
References: <20261014-nwl-dsi-fixes-v4-0-b9138ea5e12c@geanix.com>
 <20261014-nwl-dsi-fixes-v4-4-b9138ea5e12c@geanix.com>
 <JYYZZ_8h4tOKBjhbfQG_VuFESQDdQRt7TE7Ef0eJ9F0gQgyRrEJ5LIi6scY_48ggvsikFa5QZB3uEHaRUDdosQ==@protonmail.internalid>
 <atH4i_KcmccKb8Ge@raspi>
Date: Tue, 27 Oct 2026 11:18:24 +0100
Message-ID: <87qzhbbg5r.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sorry for the premature send of the previous reply.


"Liu Ying" <victor.liu@nxp.com> writes:

>>
>> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
>> index f3f4334136c0..eb604733eea0 100644
>> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
>> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/reset.h>
>>  #include <linux/sys_soc.h>
>>  #include <linux/time64.h>
>> +#include <linux/math64.h>
>
> Sort the header files alphabetically.

Will do.

>> +	hfp = roundup(hfp, 2);
>> +	hbp = roundup(hbp, 2);
>> +	hsa = roundup(hsa, 2);
>> +
>> +	/*
>> +	 * We need to subtract the packet header length: 32
>> +	 * In order to make sure we don't get negative values,
>> +	 * subtract a proportional value to the total length of the
>> +	 * horizontal blanking duration.
>> +	 */
>> +	h_blank = hfp + hbp + hsa;
>> +
>> +	if (h_blank) {
>> +		pkt_len = min(hfp, roundup(((hfp * 100 / h_blank) * 32) / 100, 2));
>> +		pkt_hdr_len = pkt_len;
>> +		hfp -= pkt_len;
>> +
>> +		pkt_len = min(hbp, roundup(((hbp * 100 / h_blank) * 32) / 100, 2));
>> +		pkt_hdr_len += pkt_len;
>> +		hbp -= pkt_len;
>> +
>> +		pkt_len = min(hsa, 32 - pkt_hdr_len);
>> +		pkt_hdr_len += pkt_len;
>> +		hsa -= pkt_len;
>> +		if (pkt_hdr_len != 32)
>> +			dev_warn(dsi->dev,
>> +				 "Unable to subtract packet header length fully: %d left\n",
>> +				 32 - pkt_hdr_len);
>> +	}
>> +
>> +	DRM_DEV_DEBUG_DRIVER(dsi->dev, "Register values: hfp=%d hbp=%d hsa=%d\n", hfp, hbp, hsa);
>> +
>> +	nwl_dsi_write(dsi, NWL_DSI_HFP, hfp);
>> +	nwl_dsi_write(dsi, NWL_DSI_HBP, hbp);
>> +	nwl_dsi_write(dsi, NWL_DSI_HSA, hsa);
>>
>>  	nwl_dsi_write(dsi, NWL_DSI_ENABLE_MULT_PKTS, 0x0);
>>  	nwl_dsi_write(dsi, NWL_DSI_BLLP_MODE, 0x1);
>>
>> --
>> 2.56.0
>>
>
> Not sure if the fix is 100% correct, but it is a correct direction to
> change the blanking packet payload size from in pixel clocks to in bytes,
> so better than no fix:
> Acked-by: Liu Ying <victor.liu@nxp.com>

Thanks. With the information available to me, this is the best I can do.

/Esben
