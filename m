Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F27CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0CF910ECD7;
	Tue, 19 May 2026 16:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XaO/NlCv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A2B10ECD7;
 Tue, 19 May 2026 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hp7+EIkRbnyy03IIX7pmZkir0cv4vk2JcR+C9KZzo2Q=; b=XaO/NlCv59zOW942ddRcqWltw6
 Kp9raJ4qx1l76AkXpNrPB3FMtwqtye/6Vg39R2y/ZewG/S06ujHhWp9mTTwedRA3AGVn5ib4x9HNc
 YMdpYh4HTMRe5cNDIoBMFWA1z+E1ZYtTLG/h6pviiB7HSFcedSA1JyPu8o45lfCiWIy8jkTSp8d3+
 HrRJL9/iNzOXGyaDJjiIRpmdoKjq9SzvkgyBioHy7VFxnQ3WdVSBAFai7mR5zemH59dlXNUamRb2o
 Su0PClXWN4TdJum1K1aayDz9ifRzqb1Wx3zEK7NB5ODJNmCQZsAEctzvZihvpEO7fsFaE5dRZnLcW
 xB8FGZGg==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wPNmi-003Hri-6j; Tue, 19 May 2026 18:59:12 +0200
Message-ID: <8fc45730-b2e3-4ba8-b80a-9b30557e810b@Igalia.com>
Date: Tue, 19 May 2026 09:59:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] drm: writeback: clean up writeback connector
 initialization
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <177894506978.2448625.17152574519326512949.b4-ty@b4>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <177894506978.2448625.17152574519326512949.b4-ty@b4>
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

On 5/16/26 08:25, Dmitry Baryshkov wrote:
> On Tue, 05 May 2026 03:24:57 +0300, Dmitry Baryshkov wrote:
>> Drivers using drm_writeback_connector_init() / _with_encoder() don't
>> perform cleanup in a manner similar to drmm_writeback_connector_init()
>> (see drm_writeback_connector_cleanup()). Migrate all existing drivers
>> to use drmm_writeback_connector_init(), drop
>> drm_writeback_connector_init() and drm_writeback_connector::encoder
>> (it's unused afterwards).
>>
>> [...]
> Applied to msm-fixes, thanks!
>
> [1/8] drm/msm/dpu: don't mix devm and drmm functions
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/c0c70a11365c
>
> Best regards,
That is only the first patch of the series, yes?

What is happening with the rest? Can they all be merged to drm-next now? 
As I understand it, only the first patch was still being discussed, the 
others have all been reviewed some time ago.

Thanks,
John.

