Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55937606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrAw74ky
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C077610E72A;
	Mon,  2 Nov 2026 23:13:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715A510E72A;
 Mon,  2 Nov 2026 23:13:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D7A94058D;
 Mon,  2 Nov 2026 23:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686091F00A16;
 Mon,  2 Nov 2026 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793661193;
 bh=NPBPU5LdYVMPWjtAsxZva+V6uRvSmgSxT4p0WjPaiCg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GrAw74kyO365Lj29y9D5jygW2kHYe+aLmYiE8a0wGEYsCeTi+Z2RanjZvFUxFQ0R/
 +Cs1ojK33TqDlTMzuU5hMJONd2/3ARrUbIghxgiZ9DrJB0XYPDNQgyiOXw42+/p7ja
 0+9bfcMlxjlVjQOi8+A82E5KHqaiSeCOYrTqspPlTcMoklGcSGf7yrGYfuA3jiT5yJ
 HqY6DQxwB0Y9O0xgneqzlTTNExPMI712qe8BZw/R/bMKHiDbDOsHf5P2gOCst2Aqji
 GY9qEYjRMfXoeP/OZgBGYIz7QgqmPtfLj+3ambJZKkirj3TysJJR4BaLFVZBO2ZkhP
 OwDQ4sy6HnAUw==
Message-ID: <7b87b864-7896-4260-aad6-a78687201c0f@kernel.org>
Date: Mon, 2 Nov 2026 17:13:10 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: panel-backlight-quirks: Add ASUS ROG Flow X13
 3840x2400 panel
Content-Language: en-US
To: Hugo Sales <hugo@hsal.es>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, alexander.deucher@amd.com,
 harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261031134551.2735792-1-hugo@hsal.es>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261031134551.2735792-1-hugo@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/31/26 08:45, Hugo Sales wrote:
> On an ASUS ROG Flow X13 GV301QH (BIOS 418) ATIF
> QUERY_BACKLIGHT_TRANSFER_CHARACTERISTICS answers with a minimum input
> signal of 12 and 49 curve points for the Sharp LQ134R1JW51 panel, and
> amdgpu logs "Using custom brightness curve". With that minimum,
> brightness 0 gives 4.7% duty
> 
> With the quirk, brightness 0 sends PWM 0 (read back from
> amdgpu_current_backlight_pwm in debugfs). The panel stays lit, but much
> dimmer than the old 4.7% floor. Its LED driver has a minimum of its own,
> so 0 does not turn the backlight off
> 
> linux-hardware.org also lists this panel in a GV301QE. Match the ASUS
> vendor and the panel, as the Framework 13 entries do, and let the
> brightness reach the bottom of the PWM range
> 
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> I could only test this on a GV301QH. The entry matches any ASUS laptop
> with this panel, and linux-hardware.org only lists it in ROG Flow X13s,
> one of them a GV301QE. If you'd rather limit it to the GV301QH, I can
> add a DMI_BOARD_NAME match in v2
> 
>   drivers/gpu/drm/drm_panel_backlight_quirks.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> index 2d0238382ebd5..b60333e748741 100644
> --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> @@ -69,6 +69,14 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
>   		.dmi_match_other.value = "Galileo",
>   		.quirk = { .min_brightness = 1, },
>   	},
> +	/* ASUS ROG Flow X13 3840x2400 panel */
> +	{
> +		.dmi_match.field = DMI_SYS_VENDOR,
> +		.dmi_match.value = "ASUSTeK COMPUTER INC.",
> +		.ident.panel_id = drm_edid_encode_panel_id('S', 'H', 'P', 0x151b),
> +		.ident.name = "LQ134R1JW51",
> +		.quirk = { .min_brightness = 1, },
> +	},
>   	/* Have OLED Panels with brightness issue when last byte is 0/1 */
>   	{
>   		.dmi_match.field = DMI_SYS_VENDOR,


Was this from looking at a datasheet or from empirical measurements? 
The reason it was safe to do on the Framework panel was because there 
was a confirmation the datasheet allowed a lower value.

We don't want to be damaging hardware running it outside of spec.
