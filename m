Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D66CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 21:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BE610E155;
	Sat,  3 Oct 2026 21:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="P97MzwFF";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JrKOrzF+";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C27F10E155;
 Sat,  3 Oct 2026 21:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:Subject:To:Date:Message-ID; t=1791062143; bh=FF4oZWwaBDvF6ia2clmt7GG
 vOqNBKfDHEHU8QFdNVec=; b=P97MzwFFtnLgzqwWCxXel/El2WRWnahp0oxDFuEmERR2xcCVsp
 sGGmwEE2OdTOb+rUAZSaF+/rpLoXdDLIlpwhe9KHRTz9vXcOhhm1KXmWgNkHSDDZYLtigjX5csy
 AOt+Nh5aUSkG0lRBDMog9Sar4v0U6w6qT3U+Ul0f7XeJ2W92JfOTIZVliLszJw/4L+uUOirKKAm
 beINKorlbNATYaWUiJz/pD08u3jLbHSjb+2Hnp84FBgajBQ76Nm9ggKLDyg+r+8aXaLKQZRG2qe
 0NY5yyFuVJZBBNY0Bps0aRLE2U9kh8uIXaHh00NugHIQZtZ5CmAZ+BZ8z8WnciR5pEg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:Subject:To:Date:Message-ID; t=1791062143; bh=FF4oZWwaBDvF6ia2clmt7GG
 vOqNBKfDHEHU8QFdNVec=; b=JrKOrzF+QOWi7PyLVamFZCIkXYgfpbxURx0Iy0Jo9CDF1hbype
 1f8YTQ3dKPhuZmxiBxd4Hx/fVmKPZ7kWZYBA==;
Message-ID: <41bbbfda-de3c-4ecd-87f5-cc784fd6483a@mainlining.org>
Date: Sun, 4 Oct 2026 00:15:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dmitry.baryshkov@oss.qualcomm.com
Cc: abhinav.kumar@linux.dev, airlied@gmail.com, akhilpo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 jesszhan0024@gmail.com, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, marijn.suijten@somainline.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch
References: <20260930-adreno-progress-v2-3-3882f0fcd7b4@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] drm/msm/a5xx: Add hangcheck progress detection
Content-Language: ru-RU, en-US
From: Nickolay Goppen <setotau@mainlining.org>
In-Reply-To: <20260930-adreno-progress-v2-3-3882f0fcd7b4@oss.qualcomm.com>
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

Didn't solved hangs on sdm660, but I think that it isn't related to 
this. However I've managed to get a command stream from hang_rd. How can 
I share it?

-- 
Best regards,
Nickolay
