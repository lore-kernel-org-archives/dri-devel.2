Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BDFC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 21:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F97410E088;
	Thu, 13 Aug 2026 21:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jQIPZ+hm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A5B10E513
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 21:36:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1646600C3;
 Thu, 13 Aug 2026 21:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176D81F000E9;
 Thu, 13 Aug 2026 21:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786656971;
 bh=p9f51wPt4Me2mLXjwn+nYgzJniqhQG1acKdKdYdH70c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jQIPZ+hmvxFBuLhDkPmCx7P6LrbuvVKn0cNRFJyqBO7VX/oLiC/z2qcRg5/Bt3HQt
 hVr7b+kIPkk+gCp3zRhYB3Gh8j6r2eoWb1HzmZ8n8+ci9Ia1y5Jx8v9GKqDz73RRda
 +kylS6Yhpy+8BKm5wjqBK0vPIK1EPdyNx7BreUJOWH7O1Z5qHcsmrGhrC2SP5OtJml
 Q5NpngvJNJBucvm4oAEj8HbUMwuKSIhTL9xX5P7HhzIAy6PQX1N17+NEWEHAnK3cOL
 sS0sxXzciRywW6ywlE91DLCo38POwg9hKegIJ7umE8poNijCb+oiSv6cbbvzRK6fst
 cwI67C9wzeo+Q==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfauth.phl.internal (Postfix) with ESMTP id 49114F40067;
 Thu, 13 Aug 2026 17:36:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 17:36:10 -0400
X-ME-Sender: <xms:yjh-am3lm8BdOKF3S3cHS1g5VFPmw2kfsztM2D8tLAHVNcJzWfzNrA>
 <xme:yjh-aur8r8xQSpji5PmTo_N9TQ5VCMeaVRUNN3iezH9KA5EUUsDpVXfnSaxadN632
 IIDkDbrw3sNaSYN2aS1ks2QYn7ocRkEzchIri7pXG53E6HADMrG6vM>
X-ME-Received: <xmr:yjh-aodzMmzK9cRoXCI7eru-AOSTl76Bu7VuUkHsH7LFynaS_HZCKKZSpSX4K0LesHWsziUTU9hxSIbe9beTQJwA0TPPw9Fu>
X-ME-Proxy-Cause: dmFkZTFFk3kTpZ2SFvlqu/9NZoiEZe5tJqWtrVRy19Y8SztAWXFfhy/49Dkn8QCnOPK2+5
 AogX8kvYOK34JJ7nqRZYM515r4tYKFep0ch8rpdETStvosQB8Lv9DKOjDF+jWme2+C48aq
 tDZ5Cu8cR+nP44tCYWphM1ScDJWKjd/9+x1yBekjqAYWHTj5FP+RJyW4ZhW0zewY51QP/9
 9qP8GHzYdzv1w1GSaw7C27ELYUcPcV2bijCnHcsNoASmdNrOEZsVJDEdzYZnYTIstP8xq2
 x/Nq2kNPuLOnPtzX9LBBWo0uhHpJAcP0wulimVm/zVnIpJajaE7ZUCmC4kf7NmFI2VTAPQ
 rzZ1mihRcK8Nd2qPTzFLpyfWRFoVCav5asz5EX6+oaJfpNST8T9oTkb8wrLsYUnPYseE9G
 KvO2gqxHhNeFN87lPEYat54EgKGM7CN3A9D4Kt+yGsNQLPkFwtDpf8+OGscPLg8lkJyGxx
 9+DpF18SkYOXvo51SMkSJ87TQ32AdrocX+DDJ/Zl1ueJKugpFfeOccwjwl59Da5BomlJtv
 Indi661HVGvok/39k56FfTpsEPQ+QFsKw86B7cgbR6Ar7c9yrsi6ofinymRVXd5Dls7N3F
 xeFtiM4MXiyOVQhzljuCYehZq49xf3Zr2N9SVJbYaSIVsSvr9N3WQOmJBvDA
X-ME-Proxy: <xmx:yjh-aou4QNcgxyRFsdXgDtFIhbqV5nVhwqSjNik8EZXKl5j2-gzqhA>
 <xmx:yjh-agWRe-wL_vAxkOsJtzL-uedi6sgOR1KM_G87u_X6gv8Tnjw4ig>
 <xmx:yjh-at-I6Ywfsj0FHQxpaFIW0I_FSxZGHqA8eHWurGOHOsdVQgO8xg>
 <xmx:yjh-as7e-i-KnBOtVr_5ed2UBwiY86dJq380p62ja_S_-SPKzWRYsw>
 <xmx:yjh-au1vHhiy6jXMqFBfal2MoIUiUsh8XScjdfBKm4RYmJ53cMekqe2z>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 17:36:09 -0400 (EDT)
Date: Thu, 13 Aug 2026 14:36:08 -0700
From: Boqun Feng <boqun@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mark Janes <mjanes@netflix.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>,
 Priya Hosur <Priya.Hosur@amd.com>, mythilam <mythilam@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: Fix incorrect avg vcn utilization in
 gpu_metrics
Message-ID: <an44yIv7WG7vqTqQ@tardis.local>
References: <20260805140227.44868-1-boqun@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805140227.44868-1-boqun@kernel.org>
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

On Wed, Aug 05, 2026 at 07:02:21AM -0700, Boqun Feng wrote:
> In a Strix Halo system, a >100 average_vcn_activity in gpu_metrics can
> be observed by running the following command:
> 
>     ffmpeg -hwaccel vappi -vappi_device /dev/dri/renderD128 -i \
>     ~/sample-10s.mp4 -vf hwupload,scale_vappi=format=nv12 -c:v \
>     h264_vappi /tmp/output.mp4
> 
> This is incorrect because the value is supposed to be in [0-100] range.
> 
> The cause of the issue is that the metrics.VcnActivity reported by
> smu_cmn_get_metrics_table() is a permyriad value instead of a percentage
> value (e.g. smu_v14_0_0_get_smu_metrics_data() has a division by 100 to
> report the vcn_busy_percent). Therefore fix this by applying the same
> division in smu_v14_0_0_get_gpu_metrics().
> 
> Reported-by: Mark Janes <mjanes@netflix.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>

Ping?

Regards,
Boqun

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 568665265a13..1058338344b0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -566,7 +566,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
>  	gpu_metrics->temperature_skin = metrics.SkinTemp;
>  
>  	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
> -	gpu_metrics->average_vcn_activity = metrics.VcnActivity;
> +	/* metrics.VcnActivity is permyriad, convert it to percentage. */
> +	gpu_metrics->average_vcn_activity = metrics.VcnActivity / 100;
>  	memcpy(&gpu_metrics->average_ipu_activity[0],
>  		&metrics.IpuBusy[0],
>  		sizeof(uint16_t) * 8);
> -- 
> 2.50.1 (Apple Git-155)
> 
