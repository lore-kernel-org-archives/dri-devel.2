Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2596FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD0710E104;
	Tue, 28 Apr 2026 13:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I4mJqBhT";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6176110E104
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:18:27 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c795f096fa5so4477252a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 06:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777382307; cv=none;
 d=google.com; s=arc-20240605;
 b=CwoFvrwblOV3gwMUbzOeGYH120gAz/nPmaN+btKuf5lxBeTfQHie4joP7FDlglwT5B
 46C7zQ1tx81yFR6JVs0aoHqHh8pNqKYlAgCtwWN238c2IPgF9s3EuiXpee2KzOdsRbvy
 A2RsZjlZq5xuQbHNDwG4nhJSVGZGGOXVm5KPE6w+gyMeytivW09+n884INXwKz1b0aQY
 8IhdxDgtrj1l0s4DAzVUbsQNbPZ2cZjYYqn09GoUgz+JRslvjd5trGNt8FGpk9YqOwnW
 3OdA3iAGGgrU5X7XqdqEikJ4ZHTNSLjqaqhB4G42GKroOPQ5yHl4MzGYZa2Hgaf2sWpE
 OvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0JylD0eUAei9HWh+O1vGMAbkkUnXs7zMRuNaLki22TM=;
 fh=HvS6KCxBIU8WTyuR2waq3TQkUh1fYk1jHzdxUiVk9gE=;
 b=kF4wh587lvyb7UA+1dCZJGE+KTb8od8OL8ASdKaBdIRMFNdLvSeYTVggt1e8MqM01T
 Jr/n+wJaEpg6ZH3RCbdpuj0Vc70fa5iVy24A9KLJjY3clklmdH7eI3EPX94FFPS9BX+1
 aKmVyT0fIuhK3JDMWNN7zu4nSshpKl7VULi9CWBkJSNRUU2DFJhkOKLbXnBQWXbty6Mw
 lNmqj3Rkpq9nA/n04hI9W1VybHdBJVjcjk935kdNq5K2PdumfFt4SMBIBbFvngL6D2Ps
 boseE/XH09kH6bn0ySK0vM5psIhaK35EDb66bSQ+kKdZpZlTrHygENuajiv082ByOKJy
 LwRA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777382307; x=1777987107; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0JylD0eUAei9HWh+O1vGMAbkkUnXs7zMRuNaLki22TM=;
 b=I4mJqBhT46DUahlC6bvWkVQq1DZYK1pq64f+J57p+vIobKo93yq0a3GHAZuNor9iun
 RyUl3KLTPTAdI459eFW0OJNVBxxHTIvmiRccXYzcXqyO56gu41MVtg/fIIxdeBAv1+pw
 4IcZ40fAmnbckm7huYGNljzN80WYpGAr6Uj2PsFP/s/9ECX4+8YpKdhBq8FDD4nK694g
 6aL++9TuJ6DsmrnOzaNLITE4SsOhwSMODjK8lrQhAfaTFGXM9XqqbLG1QRAXUi1SjQvu
 qy4ittTH1q15xn4j2cpglR/R2EFO4nf5ZbuQUR/HhFuM3EsSefCrjd4n/zPK/Nx43Yxk
 qVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777382307; x=1777987107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JylD0eUAei9HWh+O1vGMAbkkUnXs7zMRuNaLki22TM=;
 b=Hgm6GeDTJXEXsEd+D0DtBql8VXygUlUq2saBfVs0O/vfgPsMZr/5Ue+gVuuwrkH+1M
 MTMpAGBph3fZ2fEaQ+MhXnFWHQzZULwAas7crYr7G6RSMTYOWlyoUAkz65/vYxjtz54E
 k1DzfV36KaB5CqqRdQPBYmi7MoNjJ6v0P48/bUC/7umdfe5kRCaqO6V+OX1FF+opl3Lf
 oHpE0tN/ePuT/qOaofr+ogSfm4sY+fWGriYIUBH43Bk+NUvsJbgX6bD7mSbASR3Y1CsV
 PQJTbs9oxyVuR1SAjIBghqcOHLANua2DNdUWMgakBKXzki0sLcz55VTvZv5zZmhK6vG9
 WgyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ97aEae4OuXs7yOfpgCVCzw4MYEo/tWD2hxuABvYGhfYTPlMNRZHxwjylKp5ox/XPnBEygeCGhtnxA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywnbl9D6A1nfZzyUVNYKuPzidLaIxm0p4r8YmVy6xe+iTagC5uz
 6/Fr/dLMKhe7p3H0897C1Oc7tKE4ok7dZvE/sXuCJpMFdwOfCL0U7nl42JfQuwogA2Bzmv2IlfK
 K7R472bJIOzTNy/0YSD9sy1jCxxMGWmM=
X-Gm-Gg: AeBDiet3mqNFZcaMY+QeVaafBhCbvyMsKq6lF7JT+Pe6rITOrkbHVJpqX+YX8i2zPwB
 2Pc5cEb/NFdKUkAieRflYEslLvKWNGApyLJAUfgW73j5/Mpi2aMUjXFP6jLASZhqtz30/y3yMZQ
 hZUY7ytl5GcfvX8o/sBiNIRgocG8IRuUVhyxNTmZnK6NTxdkB3fO7yNtyf/4ZVClOridhBqwUn4
 X3NQhKbQuEG7mQiVuqBb6ZkdKtBpQ1uwyasWJbCaUtHbD496EGFmq2M9dxnB1csmFpuEbOIfG4z
 A9titoYQYUtg+QUYPx/+gIcDGzWzr9q+gD6XCE9AtnatWyMdXhneSHkt2EhGVg==
X-Received: by 2002:a17:903:2c8:b0:2b4:5b82:a8e3 with SMTP id
 d9443c01a7336-2b97c460ff4mr29301325ad.24.1777382306648; Tue, 28 Apr 2026
 06:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-7-4300744a1c47@bootlin.com>
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-7-4300744a1c47@bootlin.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Tue, 28 Apr 2026 22:18:14 +0900
X-Gm-Features: AVHnY4KhpSU0AnRDYEBltd_yLgO1x75YnlNnv3pVSwzFIbBw0RqhN0C4ay4P_HY
Message-ID: <CAKbEznt-PUvg48tegibw+0xYCCvK+1jwESnuHx9+MG0p3MD5gA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] drm/bridge: lt9611: switch to
 of_drm_get_bridge_by_endpoint()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Tian Tao <tiantao6@hisilicon.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
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

>
> @@ -1058,7 +1057,11 @@ static int lt9611_parse_dt(struct device *dev,
>
>         lt9611->ac_mode = of_property_read_bool(dev->of_node, "lt,ac-mode");
>
> -       return drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611->next_bridge);
> +       lt9611->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 2, -1);
> +       if (IS_ERR(lt9611->bridge.next_bridge))
> +               return PTR_ERR(lt9611->bridge.next_bridge);
> +
> +       return 0;
>  }

Hello Luca,
Could you take a look at this alternative?
------
struct drm_bridge *next_bridge =
    of_drm_get_bridge_by_endpoint(dev->of_node, 2, -1);

if (IS_ERR(next_bridge))
    return PTR_ERR(next_bridge);

lt9611->bridge.next_bridge = next_bridge;
return 0;
------

 I think it reads a bit cleaner and avoids holding the ERR_PTR in the struct.

-- 
Thanks,
Gyeyoung
