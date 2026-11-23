Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D07606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=dSPa8vZL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89AB710E375;
	Mon, 23 Nov 2026 11:00:58 +0000 (UTC)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2203910E375
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 11:00:52 +0000 (UTC)
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jY2zk3RPcz6Lt7;
 Mon, 23 Nov 2026 12:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1795431650;
 bh=78xWy2HIE+Iru6tO28E4xyJ6Psh1If63NW9ZeTScmpI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dSPa8vZLhnNc7Imu8KpDGV2PwAHxcgCqoziPsQ1TVRfg9hcpKPVS8B7C4d8+DMltO
 57+pbId4lW8J8ePkjRyjQLd9k7++E2mWepeJ3s4dzdBbG23UqpLykF0WfXmpD0ZD8J
 ptNb76MRmogdkJKweaxTPLl+z9EEUdSxQNK6ePaCeoom209UK5G0uH379s17Y/sySL
 Sy1bKSK8j4QxNOvW09klD5sLeVok34o/WrVPbc36vhQKxNKRpuNRLrO6WXQfhiezSM
 YJwDCSdp+oZ4Auw6FU+AQ/jdcvNd4EHSwejvmw5R9iKPOZoVEWLPL18VrL3cWI00UI
 a4zqvsT7r9OlQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jY2zk2dFlz4xfD;
 Mon, 23 Nov 2026 12:00:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Score: -2.901
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jY2zh25VJz8vKV;
 Mon, 23 Nov 2026 12:00:48 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 06CC25FD31;
 Mon, 23 Nov 2026 12:00:34 +0100 (CET)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <0212b0be-857c-475c-98a3-165df9de34c7@leemhuis.info>
Date: Mon, 23 Nov 2026 12:00:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dp: skip the link teardown after a failed enable
To: Burke Cates <burke.cates@gmail.com>, robin.clark@oss.qualcomm.com,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <20261104072048.3486286-1-burke.cates@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20261104072048.3486286-1-burke.cates@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179543163576.1430496.2010400359322779870@mxe9fb.netcup.net>
X-NC-CID: EyCB0RlSoK0xX/w+A8jKs5dfDCgvxUYQl4CIJiwwMoShIsBC9Ko=
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
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 08:20, Burke Cates wrote:
> Commit 1bda647ce61b ("drm/msm/dp: move link-level teardown from
> display_disable to display_unprepare") moved msm_dp_ctrl_off_link() and
> the PHY exit into msm_dp_display_unprepare(). Unlike
> msm_dp_display_disable(), that function does not check power_on.

Was this regression ever resolved through the proposed or another
patch[1]? Looks like it feel through the cracks, but it's easy to miss
something from the outside.

Ciao, Thorsten



> When link training fails, msm_dp_ctrl_on_link() has already turned the
> link clocks and the PHY off, and .atomic_enable() returns with power_on
> still false. The next disable now runs msm_dp_ctrl_off_link() anyway,
> which writes REG_DP_MAINLINK_CTRL and pulses DP_SW_RESET with the link
> clocks off. On an ASUS Zenbook A16 (Glymur, eDP) the SoC then resets.
> 
> Skip the link teardown when power_on is false, as before that commit,
> but still drop the runtime PM reference.
> 
> Tested on the A16 by forcing link training to fail and then blanking
> the display: the SoC reset 2/2 times without this patch and 0/3 with
> it.
> 
> Fixes: 1bda647ce61b ("drm/msm/dp: move link-level teardown from display_disable to display_unprepare")
> Signed-off-by: Burke Cates <burke.cates@gmail.com>
> ---
> 
> Notes:
>     Test base: v7.4-rc1 with out-of-tree Glymur platform, board and eDP
>     PHY patches; drivers/gpu/drm/msm/dp as in v7.4-rc1 plus a local
>     knob that fails every training attempt. The reset is silent (no
>     pstore), so which of the two accesses triggers it is not known.
>     
>     As before 1bda647ce61b, a failure after successful training still
>     leaves the link up. Xilin Wu's hdr10 v2 09/20 handles these paths
>     more generally; this is the minimal fix for -rc. Happy to test his
>     approach instead.
>     https://lore.kernel.org/all/20261009-msm-dp-hdr10-v2-9-1835d4966da3@radxa.com/
>     
>     The bug was found and this patch drafted with an AI coding
>     assistant (Claude Code, Claude Opus 5.5); I reviewed it and ran the
>     tests.
> 
>  drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 9299ce616fdb..76784cc45228 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1528,6 +1528,14 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
>  {
>  	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
> +	/*
> +	 * Failed link training leaves the link clocks off. Avoid accessing
> +	 * link registers after a failed enable, but still release the
> +	 * runtime-PM reference below.
> +	 */
> +	if (!msm_dp_display->power_on)
> +		goto out;
> +
>  	/* dongle is still connected but sinks are disconnected */
>  	if (dp->link->sink_count == 0)
>  		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> @@ -1542,6 +1550,7 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
>  
>  	msm_dp_display->power_on = false;
>  
> +out:
>  	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
>  
>  	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

