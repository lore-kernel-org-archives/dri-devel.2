Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69785FF492D
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 02:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DB310E18F;
	Mon, 30 Mar 2026 02:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YvPd6svd";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A245E10E190
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 02:45:34 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-35c1a131946so2321884a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 19:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774838734; x=1775443534;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HTRJOtJ1gG9zCwdZmXKBoohjNlbRVVuD9cptQY2hS7A=;
 b=YvPd6svdWiVNHjhFSRbPnLWY5mrKqt6J0Lu+kYrfCdpYSmrYEuFW/IGF+/IbEZkdWU
 OzBJGQ2TXfd449pk2qGiir6foUrBv6BONeRHvbjIs0Zfv0Tt95JT3MaitzMWS6dIFzok
 QSq74b8TLAvMW4cQXOlw/+S2qclwv9kNEp92A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774838734; x=1775443534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTRJOtJ1gG9zCwdZmXKBoohjNlbRVVuD9cptQY2hS7A=;
 b=mAZT2QrAY24YhRfcde6zmGat+yTaOzTTy5TZSaDyerP1sp9Ae8l9+N8arBdi/ob/N8
 oaeKComItX0kPFV9kcEPu1cJYKXjT4aSG9YbUptJCKISwkt2drgE627IEP/ZdOLjCkn8
 aXMDOYz/cpaUHM0Y7nuNWee5sT6Ih0ga/59GF40HmGE9YrCo6n9nWuE4zNKtgfIU9qFZ
 c14mNnJM/qEFu89LeyBG8+X7SDzyq1KWVkrAtsSZU+vaoikCGJdVyTiT3ZFOdChVrOr0
 iimVjy32uzp93bnJLMXEkUnmbLnj8lJf5JsVYXAlYQN9vr5HXDUDjDrTGvhNJclaNTGq
 +eiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0NS/S2gAq4HQn5s271xPB6BSRP5QEWL4FAK3n/2Qd7TCgUBXu6czBk/sZNRF7/D1/xNXwLZsRjZM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeOLdQJ45yhyyCyUK1qiFG6Lsrl1ifVIwlJ5ONiHtNBbAmCyNc
 lhV5U96HHwtOQtIqT4kXlfBSALtFJ7y9E418HHHKkIofCiH6BhLB/N1o8IYNdiCGPw==
X-Gm-Gg: ATEYQzwOKfafbNUn1pRPO+fKDBa20TzpCZknVRSVkWduN4lVRwlbzmU143jac2xiJf4
 98XichwdTT3rVsDap1ReTRLY6fJW0EQgqf+WxeFY3FdQxere+K1qf0vMi15nMZnMRcpXjDDLIYs
 4MCJ9Rs8bpTYmTH9Rkt2eR9CIlCg26i901ubKbFzaRrYM1Tk59LciXnWEPyklJ4u2NQPcW2y7eW
 8dUzJw6bRddIOTU+XEVLbrFY3XDsLt+/MNmBABV0EVhNrwFjg5HcoZQ9prVNRFlquJys4qtM3/j
 mOfvEDDGaKfrQWIklz92G5RdLIGTms8SofmV7D+hTR8hwDKcHOQ5CKLVHJUTqxL7hbnkwDbmE9I
 +MPT0TMYaSOUxvKEVhSY5WLBq3per6a6F3F4R96T4I/zyNcvSKZAJf44NPHIxLZZ//U6cllK+zc
 lsgrwQTYEP11GN8ERe3pn/hmGXFcYWC++jiYdhlHJaiI8vRGO97FY7Mt4x/lq23a8=
X-Received: by 2002:a17:903:8c5:b0:2b2:5070:8b with SMTP id
 d9443c01a7336-2b250700333mr22961915ad.1.1774838734076; 
 Sun, 29 Mar 2026 19:45:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:2f8f:d84f:5e73:9f26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242642b43sm77400775ad.9.2026.03.29.19.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 19:45:33 -0700 (PDT)
Date: Mon, 30 Mar 2026 11:45:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [RFC PATCH] drm: gpu: msm: forbid mem reclaim from reset
Message-ID: <acnjoXzAOZrU72Zq@google.com>
References: <20260127073341.2862078-1-senozhatsky@chromium.org>
 <acSRDNA8fCP7qAFJ@google.com>
 <fe3177bd-a3d2-4c0a-ab6f-9752eaf32fc4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe3177bd-a3d2-4c0a-ab6f-9752eaf32fc4@oss.qualcomm.com>
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

On (26/03/27 05:47), Akhil P Oommen wrote:
> On 3/26/2026 7:24 AM, Sergey Senozhatsky wrote:
> > On (26/01/27 16:33), Sergey Senozhatsky wrote:
> >> We sometimes get into a situtation where GPU hangcheck fails to
> >> recover GPU:
> >>
> >> [..]
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): hangcheck detected gpu lockup rb 0!
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): completed fence: 7840161
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): submitted fence: 7840162
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): hangcheck detected gpu lockup rb 0!
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): completed fence: 7840162
> >> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): submitted fence: 7840163
> >> [..]
> >>
> >> The problem is that msm_job worker is blocked on gpu->lock
> >>
> >> INFO: task ring0:155 blocked for more than 122 seconds.
> >> Not tainted 6.6.99-08727-gaac38b365d2c #1
> >> task:ring0 state:D stack:0 pid:155 ppid:2 flags:0x00000008
> >> Call trace:
> >> __switch_to+0x108/0x208
> >> schedule+0x544/0x11f0
> >> schedule_preempt_disabled+0x30/0x50
> >> __mutex_lock_common+0x410/0x850
> >> __mutex_lock_slowpath+0x28/0x40
> >> mutex_lock+0x5c/0x90
> >> msm_job_run+0x9c/0x140
> >> drm_sched_main+0x514/0x938
> >> kthread+0x114/0x138
> >> ret_from_fork+0x10/0x20
> >>
> >> which is owned by recover worker, which is waiting for DMA fences
> >> from a memory reclaim path, under the very same gpu->lock
> 
> I am still thinking if there is a better way to handle this. Btw, Rob
> had a few fixes related to this area recently. Do you think those would
> help in this scenario?

If you can point me to those fixes then I can take a look.
