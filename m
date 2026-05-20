Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB03CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA9110EFCB;
	Wed, 20 May 2026 09:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uw4VFx5I";
	dkim-atps=neutral
X-Greylist: delayed 65952 seconds by postgrey-1.36 at gabe;
 Wed, 20 May 2026 09:38:24 UTC
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBBA610E0CF
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779269904;
 bh=j4o1v6ER7nCE4/2KsRiGeQnk/i44U1HKfe8zXxUu+Hs=;
 b=uw4VFx5IyAv73sWspQ3BB/K6TNpqwq4pjC+orP9391LEvixTHk70PwRLyrFmoyzQRys044PIR
 F/5aa8ZwxkQxAfcgdURzQNlVvgDYESjUA2gN5CH9S0NjAMF4hiFRfEEZpzlNS41zhblYVCPgAI+
 f7CTvnJ1KxmrlgQRSc4A0vbetJapFabSuvc4jGbY5SsGvk+ZEIsH+r9R5hiRIKC5X53vGNbRikt
 j9+gCAmHneIHeK4qSq4dclyrVnw2oXiLxMcPs1BmbjJ+8g3o3iT4QEGaefgkGKhY5DGxM4Zv/eD
 54SB0kFqboSRR+3ZCOQKYzR876MYMMKp8T2iUapTIuWg==
X-Forward-Email-ID: 6a0d810b40ac652fcd447b18
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <81944af1-c9e3-4a45-ad42-3426dcab0777@kwiboo.se>
Date: Wed, 20 May 2026 11:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: compute audio CTS from N when
 not in TMDS table
To: Simon Wright <simon@symple.nz>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Algea Cao <algea.cao@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <00a34a82-213b-4b03-801c-3c10b163d643@symple.nz>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <00a34a82-213b-4b03-801c-3c10b163d643@symple.nz>
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

Hi Simon,

On 5/20/2026 11:10 AM, Simon Wright wrote:
> dw_hdmi_qp_find_cts() returns 0 for any TMDS character rate not
> present in common_tmds_cts_table[], which terminates at 148.5 MHz.
> In that case dw_hdmi_qp_set_sample_rate() calls dw_hdmi_qp_set_cts_n()
> with cts == 0, which leaves AUDPKT_ACR_CTS_OVR_EN clear and falls
> back to the controller's internal CTS auto-measurement.
> 
> On at least the RK3576 hdptx integration, the auto-measure path
> produces incorrect ACR timing on the wire at TMDS rates above the
> table's coverage.  Strict HDMI sinks that cross-check the ACR CTS
> against the AVI/GCP and the actual TMDS clock then mute audio.
> 
> The issue is reproducible at any rate not present in the table, and
> is not specific to HDMI 2.x: 1920x1080@60 with 10-bit deep colour
> (185.625 MHz, HDMI 1.4) is affected, as is 3840x2160@60 8-bit
> (594 MHz, HDMI 2.0).
> 
> The driver already has the symmetric machinery for the N-table-miss
> case: dw_hdmi_qp_compute_n() falls back to a dynamic search via
> dw_hdmi_qp_audio_math_diff() ((pixel_clk * n) / (128 * freq)) when
> no table entry matches.  The CTS path lacks the equivalent fallback.
> 
> Compute CTS inline in dw_hdmi_qp_set_sample_rate() from N per the
> HDMI spec (CTS = TMDS * N / (128 * Fs)) when find_cts() returns 0.
> The standard override path then supplies the correct value on the
> wire instead of falling through to auto-measure.
> 
> The legacy DesignWare HDMI driver (drivers/gpu/drm/bridge/synopsys/
> dw-hdmi.c, hdmi_set_clk_regenerator()) computes CTS from N via the
> same formula when AHB or GP audio is active, so the pattern is
> already established within the family.
> 
> Tested on R76S (RK3576) on Armbian-edge mainline 7.0.1 with Cristian
> Ciocaltea's hdptx-clk-fixes v1 series applied, against four sinks
> at four TMDS rates spanning HDMI 1.4 and HDMI 2.0:
> 
>   TMDS         Mode                In table?  G3     C4     TCL    Kogan
>   148.5 MHz    1080p60  8-bit      yes        audio  audio  audio  audio
>   185.625 MHz  1080p60 10-bit      no         audio  audio  audio  audio
>   297 MHz      3840p30  8-bit      no         audio  audio  audio  audio
>   594 MHz      3840p60  8-bit      no         audio  N/A    audio  audio
> 
> Without this fix, all four sinks mute audio at the rates marked "no"
> above.  With the fix, audio plays cleanly.  The 148.5 MHz row is a
> regression check confirming the in-table path is unchanged.
> 
> The LG C4 OLED's CTA-861 SVDs do not advertise 3840x2160@60 over
> TMDS (it is signalled FRL-only in this model's EDID), so that
> specific case is untestable on the C4 over the TMDS path.  The
> same audio-path code is exercised on the C4 at 297 MHz and behaves
> identically to the G3.
> 
> More-permissive sinks (older HDMI 2.0 TVs tested informally) play
> audio at all rates with or without the fix because they do not
> strictly cross-check ACR CTS against the TMDS clock.
> 
> Reported-by: Simon Wright <simon@symple.nz>
> Closes: https://lore.kernel.org/linux-rockchip/ME3P282MB21960D9D68BFF520316BDFCEA83E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM/
> Suggested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Tested-by: Simon Wright <simon@symple.nz>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Simon Wright <simon@symple.nz>
> ---
> Changes in v2:
>   - Resend after v1 was mailer-mangled and unapplyable (reported by
>     Luca Ceresoli).
>   - Body split into shorter paragraphs for readability per Luca's
>     review.
>   - Original LG G3 report (linux-rockchip 070633) moved from inline
>     prose to a Closes: trailer paired with Reported-by:, per
>     Documentation/process/submitting-patches.rst.
>   - Add Assisted-by: trailer per
>     Documentation/process/coding-assistants.rst.
>   - No code or test-result changes.
> 
> v1: https://lore.kernel.org/linux-rockchip/92aa4191-2a2a-41e3-badb-c0a5b1fbb957@symple.nz/
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index 0dbb1274360..b7203787057 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -461,6 +461,23 @@ static void dw_hdmi_qp_set_sample_rate(struct dw_hdmi_qp *hdmi, unsigned long lo
>  	n = dw_hdmi_qp_find_n(hdmi, tmds_char_rate, sample_rate);
>  	cts = dw_hdmi_qp_find_cts(hdmi, tmds_char_rate, sample_rate);
>  
> +	/*
> +	 * When no CTS table entry exists for the given TMDS rate, compute
> +	 * CTS from N rather than letting the hardware auto-measure.  The
> +	 * auto-CTS circuit produces incorrect audio timing at out-of-table
> +	 * rates (e.g. 185.625 MHz, 297 MHz, 594 MHz), causing strict HDMI
> +	 * sinks to mute audio.  Computed CTS = (TMDS * N) / (128 * Fs) per
> +	 * HDMI spec; the standard override path then supplies it on the
> +	 * wire.  Mirrors hdmi_set_clk_regenerator() in the legacy dw-hdmi
> +	 * driver.
> +	 */
> +	if (!cts && n) {
> +		u64 computed = (u64)tmds_char_rate * n;
> +
> +		do_div(computed, 128ULL * sample_rate);
> +		cts = (unsigned int)computed;
> +	}

Could this function instead be converted to use the helper
drm_hdmi_acr_get_n_cts() to lookup/calculate the n and cts value?

At first glance it looks to produce same/similar values as this driver
tries to do open-coded.

Regards,
Jonas

> +
>  	dw_hdmi_qp_set_cts_n(hdmi, cts, n);
>  }
>  
> 
> base-commit: c1079aebb4de218caa86c44f9a53700d1a582683

