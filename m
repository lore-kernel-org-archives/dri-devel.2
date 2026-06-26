Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD7BC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 19:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698DB10F704;
	Fri, 26 Jun 2026 19:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FstiwF0N";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 687DF10F704;
 Fri, 26 Jun 2026 19:02:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91BB5600C8;
 Fri, 26 Jun 2026 19:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02B91F000E9;
 Fri, 26 Jun 2026 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782500539;
 bh=UUIgku0dEeTkAIbEWbmP2c4kgTyRAbCcRnpJ75y3OUk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FstiwF0N2TKXY0zUW6qxHZC2DhJ7UIsuxklD9FRC7G5Ub6nedrarR5rIBl62qwf81
 DAzynZykkyWrvW5K7JOzHlBQLiTqUUaBhY17H9d5DsRO1PjBifTpMzGM0OxuLlJ/FG
 3m7PYebotrPF7kBpbtauyfrSxcbJ3FLCxiB1bQQPoe14IHV5tbizpn8RPexr6OImz8
 CN4L3Ve3hxRFNYHDsWNoi9XykmXOopwmIhQU/q6KoqMQUrVX9f6gYm4CAE2dzcM/7g
 bzb00ieDYhxGq1puMyvJkrkAwRWfMqRR2GTqqKQUJwv/IOMJ0MGU9ZTxFoS4+sQtHg
 mOku3Cru3MR1w==
Message-ID: <9b3b135c-0e9d-4439-bbe7-877ac9824249@kernel.org>
Date: Fri, 26 Jun 2026 14:02:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: drm/amd/display: detect_link_and_local_sink: DP alt
 mode timeout path leaks prev_sink reference
Content-Language: en-US
To: WenTao Liang <vulab@iscas.ac.cn>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: siqueira@igalia.com, alex.hung@amd.com, timur.kristof@gmail.com,
 wenjing.liu@amd.com, Relja.Vojvodic@amd.com, Derek.Lai@amd.com,
 srinivasan.shanmugam@amd.com, clayking@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260626124555.36910-1-vulab@iscas.ac.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260626124555.36910-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/26/26 07:45, WenTao Liang wrote:
> prev_sink is unconditionally retained via dc_sink_retain at function
>    entry, but the DP alt mode timeout path inside SIGNAL_TYPE_DISPLAY_PORT
>    returns false without releasing prev_sink. All other return paths in the
>    function correctly call dc_sink_release(prev_sink), making this the only
>    missing cleanup.
> 
> Cc: stable@vger.kernel.org
> Fixes: 54618888d1ea ("drm/amd/display: break down dc_link.c")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Applied, thanks.

> ---
>   drivers/gpu/drm/amd/display/dc/link/link_detection.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 794dd6a95918..03bb210ebab8 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1069,8 +1069,11 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>   			    link->link_enc->features.flags.bits.DP_IS_USB_C == 1) {
>   
>   				/* if alt mode times out, return false */
> -				if (!wait_for_entering_dp_alt_mode(link))
> +				if (!wait_for_entering_dp_alt_mode(link)) {
> +					if (prev_sink)
> +						dc_sink_release(prev_sink);
>   					return false;
> +				}
>   			}
>   
>   			if (!detect_dp(link, &sink_caps, reason)) {

