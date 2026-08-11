Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BEDC5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B313910EBDD;
	Tue, 11 Aug 2026 13:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EtUJbmNN";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="IDex7T4a";
	dkim-atps=neutral
X-Greylist: delayed 400 seconds by postgrey-1.36 at gabe;
 Tue, 11 Aug 2026 13:54:43 UTC
Received: from a7-42.smtp-out.eu-west-1.amazonses.com
 (a7-42.smtp-out.eu-west-1.amazonses.com [54.240.7.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F406010E08E;
 Tue, 11 Aug 2026 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=5uqmrq7mz5dkaze44elodgxarejai7vg; d=collabora.com; t=1786456081;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=OfOjGRuzTQxuJ8OQ+ZgH5WIjQ2E/IwjUl0ROop2g5as=;
 b=EtUJbmNNZ7tAidlch5F3cFp0ELI2QJdNojCi/zAepX4e3aZLGyCtCzyw10hmDTW8
 qVEBdLgu2vMYrDCPwuP8oN02FGiOdk1bUY2be/PGEE9n7Ic/k4fHF9/H069FwC3oimz
 K+QYOVT5wWAM5wTsmqOEFz6Eb42kmAG1JhntDzE1ayxR22ll1OklvBavMG/m379Hk62
 5kOyP+YJUMd7SuAz3LCIE33AdSIjWJZmtP8Lkg3INjlh1xtyRh+sVOo0ZJrsbRRKEFe
 nw5K5FZR1gXUUlzUvQffCxf3A3yFxCnuHxJ/NuKC2/x25681mbfEhOsXHqF1t8sOvWA
 AFcNTxGgwA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1786456081;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=OfOjGRuzTQxuJ8OQ+ZgH5WIjQ2E/IwjUl0ROop2g5as=;
 b=IDex7T4aqgfu70iIulgeQUIkalVIu1TicrKj0fjW7NMaTgA2+7eLYEgWykY8M8lH
 PWWDGTCEOa1uuYF3DAJijKmmYe79LXlEvAd/eCw48YncYS44CALoLCkS5k2kSYW8SBi
 EpRPTALvonyNAvw+ae32Gs2s2bafzUBUwI3UfhrM=
Message-ID: <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
Date: Tue, 11 Aug 2026 13:48:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
Content-Language: en-CA
From: Derek Foreman <derek.foreman@collabora.com>
In-Reply-To: <20260811003921.1398292-5-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2026.08.11-54.240.7.42
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

On 8/10/26 7:39 PM, Fangzhi Zuo wrote:
> why:
> HDMI 2.1 Auto Low-Latency Mode (ALLM) lets a Source request the Sink's
> low-latency mode through the HF-VSIF. amdgpu never set ALLM_Mode in the
> HF-VSIF, so ALLM was never signalled to the sink.
>
> how:
> - In create_stream_for_sink(), build the HF-VSIF with ALLM_Mode set when
>    the sink advertises ALLM (connector->display_info.hdmi.allm, parsed by
>    DRM core from the HF-VSDB) and the content type is Game (content-type =
>    Game is how userspace requests low-latency mode, HDMI GCTS HF1-56).
> - In update_freesync_state_on_stream(), also set ALLM_Mode when
>    Gaming-VRR is active (VRR_EN=1, HDMI GCTS HF1-58 step 8.3.1), and push
>    the updated HF-VSIF (vsp_infopacket) as a stream update.
>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++-
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   | 18 +++++++++--
>   .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 31 +++++++++++++++++++
>   3 files changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 567bf04979ee..ff0db0cb9880 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4029,9 +4029,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>   		}
>   
>   		if (acrtc_state->stream) {
> -			if (acrtc_state->freesync_vrr_info_changed)
> +			if (acrtc_state->freesync_vrr_info_changed) {
>   				bundle->stream_update.vrr_infopacket =
>   					&acrtc_state->stream->vrr_infopacket;
> +				bundle->stream_update.vsp_infopacket =
> +					&acrtc_state->stream->vsp_infopacket;
> +			}
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 2fe7bfb1e88f..953b2a470734 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1572,8 +1572,22 @@ create_stream_for_sink(struct drm_connector *connector,
>   	update_stream_signal(stream, sink);
>   
>   	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
> -	    stream->signal == SIGNAL_TYPE_HDMI_FRL)
> -		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, false);
> +	    stream->signal == SIGNAL_TYPE_HDMI_FRL) {
> +		/*
> +		 * Enable HDMI ALLM (Auto Low-Latency Mode) when the sink
> +		 * advertises ALLM in the SCDS and the content type is Game.
> +		 * Setting content-type = Game is how userspace requests the
> +		 * Sink's low-latency mode (HDMI GCTS HF1-56).
> +		 */
> +		bool allm = connector->display_info.hdmi.allm &&
> +			stream->content_type == DISPLAY_CONTENT_TYPE_GAME;
> +
> +		drm_dbg_driver(dev,
> +			       "ALLM: set mode: sink_allm=%d content_type=%d -> ALLM_Mode=%d\n",
> +			    connector->display_info.hdmi.allm, stream->content_type, allm);
> +
> +		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, allm, allm);
> +	}
>   
>   	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
>   	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index 382c339b67b1..0fa72c77415e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -252,6 +252,37 @@ void amdgpu_dm_update_freesync_state_on_stream(
>   	new_stream->vrr_infopacket = vrr_infopacket;
>   	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
>   
> +	/*
> +	 * HDMI ALLM: transmit the HF-VSIF with ALLM_Mode=1 when the sink
> +	 * advertises ALLM in the SCDS and either the content type is Game
> +	 * (HF1-56) or Gaming-VRR is active (VRR_EN=1, HF1-58 step 8.3.1).
> +	 * HDMI 2.1 7.6.6.
> +	 */

Tying this to Gaming-VRR seems potentially surprising. Gaming-VRR 
doesn't mean we're playing a game. We might be using it to play back 
judder free video (where we'd like ALLM off to preserve the sink's image 
enhancement), or we might be at the desktop.

I'd imagine some users would still want their sink to use all the image 
enhancements they saw in the showroom even when playing a game, so I'm 
not sure any kind of "auto" decision making in the kernel makes sense at 
all, even based on content type. It's a very subjective trade-off.

To me, this seems like something a compositor would want control of with 
a simple boolean property.

Thanks,
Derek

> +	if (new_stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
> +	    new_stream->signal == SIGNAL_TYPE_HDMI_FRL) {
> +		struct dc_info_packet vsp_infopacket = {0};
> +		bool sink_allm = aconn && aconn->base.display_info.hdmi.allm;
> +		bool allm = sink_allm &&
> +			(new_stream->content_type == DISPLAY_CONTENT_TYPE_GAME ||
> +			 vrr_params.state == VRR_STATE_ACTIVE_VARIABLE ||
> +			 vrr_params.state == VRR_STATE_ACTIVE_FIXED);
> +		bool allm_changed;
> +
> +		mod_build_hf_vsif_infopacket(new_stream, &vsp_infopacket, allm, allm);
> +
> +		allm_changed = memcmp(&new_stream->vsp_infopacket, &vsp_infopacket,
> +				      sizeof(vsp_infopacket)) != 0;
> +		new_crtc_state->freesync_vrr_info_changed |= allm_changed;
> +		new_stream->vsp_infopacket = vsp_infopacket;
> +
> +		if (allm_changed)
> +			drm_dbg_driver(adev_to_drm(adev),
> +				       "ALLM: flip on crtc=%u: sink_allm=%d content_type=%d vrr_state=%d -> ALLM_Mode=%d\n",
> +				    new_crtc_state->base.crtc->base.id,
> +				    sink_allm,
> +				    new_stream->content_type, vrr_params.state, allm);
> +	}
> +
>   	if (new_crtc_state->freesync_vrr_info_changed)
>   		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=%u enabled=%d state=%d",
>   			      new_crtc_state->base.crtc->base.id,
