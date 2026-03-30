Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D6FFF4934
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 02:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BF410E189;
	Mon, 30 Mar 2026 02:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HV0dtJby";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747BC10E189
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 02:46:29 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2addb31945aso31258645ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 19:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774838789; x=1775443589;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zQbvZ0Ccf315kC/dpSUC5Pun7z9eS6NwI/AtAL6u82A=;
 b=HV0dtJby53kTmHCYtT/1+HaDgpB8ZWvB3cWCA62OIjj8IW931rxbQMSD8xZCkC9SWG
 a9V8lyWu5JNYi2Q5nKa7rsOdMEKhHH2TIHO9vD9hdTZLhYtPFbHxTyK1mPhWK0EBZRWP
 Ahz6o1QHKBUhcn0bRON+DYOVEBsSYQsY6tfYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774838789; x=1775443589;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zQbvZ0Ccf315kC/dpSUC5Pun7z9eS6NwI/AtAL6u82A=;
 b=MeaznbM2iN/ltQR3XrUdEYd2PXtaNrVnSbsnwkTtMAP6GYuVCM6iav1cEcloaZkFka
 nCxCHrg6Ha16LgBA74dllhFHBczdnj51a6vf+UUkdGbbQzHFvarpkhZ9Ysx5sPQzgbv+
 wLT8qHFmq0fapkmylqp3BLHEFI7zH9qYJRLS0IeMT403Kh8PAuB2aPMzrKCqjdimQiIu
 SNXasBHq3zAng4zPkxnwq1xrmP1y5fc2rw2D8KhEkTuWROWQCfuMskxTof6mBJPCHa3f
 vVcbO6A11UOblxbBJxBwXVwWjfFjBp8XhqBYaxkQEakbJbFYmzxfV9AcN64G1/Pcc9Qc
 Blsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3zmrSYUB/I1z5qYz0mg28zfmjr7xuRxwSaqO/L34990cmXVITtvB8VK/iMDckjUbkCy7eCDY0SRQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyN1KCcbDJTtB9atrZ1+g1laWhV3u5zs07iSfz8tDF2hTtkf3lv
 OopHXOq4qSTxL8wxwvvq0ydrtYR5VzrYNokRdcI5nRa1ddSzP1zVlFAgyt98jUfN2A==
X-Gm-Gg: ATEYQzxkmIlKa4AUdgLA9f4JI9zI1NJRvHY+fhx2tpbDBCtTVgiUVF3jUl6T2f9C9GF
 MBba5MODZov+Yj42XSdpZZI6V8fWYnwJKiGafWIp4Z2dKj5TwLGQSyTb9Be5Fao/NWHqYMy3KLX
 v5aRT5ngwEve+02CDCrGlfUJ27NOB0DREVjAs9r1shP89Azl6tdzeigKhalj8h4s2HLRM/Skw7j
 o8IeE8ahj3OWHarbjoZXZjnsiEpZ5sBrxgEQmPp5hb9x/izUk/Dg7D3BEi30VItRSjx1mBNLIdU
 8t9my54aJHfg20B9NeXBdyc8tvTLbllL2ALDHyV6J1cYhtOgC0es80EWS0efZJMCTQKD8rraqok
 BQewBsHkHqeye58ZZhzZx02NP3H5nbSIrXOIhz2z4NZYNs+l2HMLxsF76cATMWdv16mJemf/0ds
 4NzSdTJw+3dESvVUG6Iah3WVk4eUEFAQdA+svjqJmdTjGbpuftMRtBwtM45K9jmG4=
X-Received: by 2002:a17:903:3d0f:b0:2b0:cb96:9840 with SMTP id
 d9443c01a7336-2b0cdcde903mr111910065ad.40.1774838789014; 
 Sun, 29 Mar 2026 19:46:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:2f8f:d84f:5e73:9f26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242683064sm61021995ad.33.2026.03.29.19.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 19:46:28 -0700 (PDT)
Date: Mon, 30 Mar 2026 11:46:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [RFC PATCH] drm: gpu: msm: forbid mem reclaim from reset
Message-ID: <acnj2pIv_6H56GDT@google.com>
References: <20260127073341.2862078-1-senozhatsky@chromium.org>
 <acSRDNA8fCP7qAFJ@google.com>
 <fe3177bd-a3d2-4c0a-ab6f-9752eaf32fc4@oss.qualcomm.com>
 <CACSVV00MFgsn8_XjXZxubJibLFE9ULrFqiEW9dQAyU404SLj1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV00MFgsn8_XjXZxubJibLFE9ULrFqiEW9dQAyU404SLj1g@mail.gmail.com>
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

On (26/03/27 09:08), Rob Clark wrote:
> On Thu, Mar 26, 2026 at 5:18 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
> >
> > On 3/26/2026 7:24 AM, Sergey Senozhatsky wrote:
> > > On (26/01/27 16:33), Sergey Senozhatsky wrote:
> > >> We sometimes get into a situtation where GPU hangcheck fails to
> > >> recover GPU:
> > >>
> > >> [..]
> > >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): hangcheck detected gpu lockup rb 0!
> > >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): completed fence: 7840161
> > >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): submitted fence: 7840162
> > >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): hangcheck detected gpu lockup rb 0!
> > >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): completed fence: 7840162
> > >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): submitted fence: 7840163
> > >> [..]
> > >>
> > >> The problem is that msm_job worker is blocked on gpu->lock
> > >>
> > >> INFO: task ring0:155 blocked for more than 122 seconds.
> > >> Not tainted 6.6.99-08727-gaac38b365d2c #1
> > >> task:ring0 state:D stack:0 pid:155 ppid:2 flags:0x00000008
> > >> Call trace:
> > >> __switch_to+0x108/0x208
> > >> schedule+0x544/0x11f0
> > >> schedule_preempt_disabled+0x30/0x50
> > >> __mutex_lock_common+0x410/0x850
> > >> __mutex_lock_slowpath+0x28/0x40
> > >> mutex_lock+0x5c/0x90
> > >> msm_job_run+0x9c/0x140
> > >> drm_sched_main+0x514/0x938
> > >> kthread+0x114/0x138
> > >> ret_from_fork+0x10/0x20
> > >>
> > >> which is owned by recover worker, which is waiting for DMA fences
> > >> from a memory reclaim path, under the very same gpu->lock
> >
> > I am still thinking if there is a better way to handle this. Btw, Rob
> > had a few fixes related to this area recently. Do you think those would
> > help in this scenario?
> 
> For some reason I was thinking we used GFP_ATOMIC or similar in the
> gpu snapshot path.. but we don't :-(
> 
> It does look like we handle allocation failures.  So this is probably
> a better option than fixing up GFP flags everywhere.
> 
> Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

Thanks!

> 
> (and apologies for overlooking this patch earlier)

No worries.
