Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E3BCA5FE4
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 22:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2AC10E987;
	Sat,  3 Oct 2026 22:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="Ivhz0IuQ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="sn0dHIzp";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175CC10E987;
 Sat,  3 Oct 2026 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1791066150; bh=4RZK44GDmw2eYm7LjnqS0sK
 5640JPz8sEdBiZ0JUaVk=; b=Ivhz0IuQpZfq5GPRZ6mVZlJrOmjuKi1aF3+8HyG5voymmzr47F
 6cVz/GTZ6KGCTS17LrZMGczKf8QdwVrcDPkck4UuykOdTcWD4IW3sW8LKoWwvdErbWJz12E9Hip
 KoyGQNgOxDEzLouVkI8vyzZ3eQqp2kIUYDwukB92xPKuSbjio5Il5BIBRZA1y5o+gBCMDLz4hgZ
 r8dMSooo1HqBENw0ZYyASgkICZBEkdd39L59lAkCNJ2LJsuKDPpOzCvzaUElg9VCT+2NniVgs1V
 g3PPayNi2FHTiNO3rvgphIIrxxjeNMVUriPiB+CfGrEr94yETEeAS1yxR78X9ITGMLA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1791066150; bh=4RZK44GDmw2eYm7LjnqS0sK
 5640JPz8sEdBiZ0JUaVk=; b=sn0dHIzpl1+93+C9hNoPXhnYjd1HzqfZ9Ffoo2J7Pws2x+qoY3
 hY/KX57fzUNmNv+AzYLfpTC6IYXj2UXwc9AA==;
Message-ID: <a270c442-68ce-44a5-83bf-cd83ee68d138@mainlining.org>
Date: Sun, 4 Oct 2026 01:22:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/msm/a5xx: Add hangcheck progress detection
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com, akhilpo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 jesszhan0024@gmail.com, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, marijn.suijten@somainline.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch
References: <20260930-adreno-progress-v2-3-3882f0fcd7b4@oss.qualcomm.com>
 <41bbbfda-de3c-4ecd-87f5-cc784fd6483a@mainlining.org>
 <ffjwlr4kc4rxb5rktabvuplrz4kh4zrpki7ctz6mrkdtyjvk5f@r4easyboav2s>
Content-Language: ru-RU, en-US
From: Nickolay Goppen <setotau@mainlining.org>
In-Reply-To: <ffjwlr4kc4rxb5rktabvuplrz4kh4zrpki7ctz6mrkdtyjvk5f@r4easyboav2s>
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


04.10.2026 01:20, Dmitry Baryshkov wrote:
> On Sun, Oct 04, 2026 at 12:15:42AM +0300, Nickolay Goppen wrote:
>> Didn't solved hangs on sdm660, but I think that it isn't related to this.
>> However I've managed to get a command stream from hang_rd. How can I share
>> it?
> Open an issue at https://gitlab.freedesktop.org/mesa/mesa, tag robclark
> and lumag. Please note that for sdm660 you really need the patch at [1].

I've applied this patch, but I haven't triggered a fault to test it.

Got it, Will open an issue about it.

> There are also several known issues which affect SDM660, but they are
> mostly on the userspace side. I hope to submit and fix them one by one
> (e.g. on that chip there is an issue with the blitter programming).
>
>
> [1] https://patchwork.freedesktop.org/series/174541/
>
-- 
Best regards,
Nickolay
