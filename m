Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FCCC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 21:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F5A10E51F;
	Thu, 13 Aug 2026 21:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="RO1ovZhq";
	dkim-atps=neutral
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863F010E51F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 21:12:57 +0000 (UTC)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so333734a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786655577; x=1787260377;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BmQIbOMpbDixM2LUoZ8EAUt/Js63kIkQtWinusc+PO0=;
 b=bvS9z1RMdumSVgefboZzopST6hEtBSdc5/oE2kwdquWrdgtHfX53+y/TiRWzpuUUHY
 6y0L0yH/xTsUNEiS8V3TfL1t/ZzsSpSUiML2ulQk8m4nojZvDvomGct4JG/1cHPRh+UN
 cyG8W/I93zn2/pCSDBgfOyov6YYgZdVEFDOyTaWBXY816dg3O2b0WijfT0a8PE1AMHig
 Uy3lxUQpwvlLUzd/zmwSMuiK2aRfWRUj3vXuUsy5cjbv5QYve7+RKIDXrK6BAcrNNc5J
 jV4lIidbhxbfH3Dd20hT/Su0vstlD+LijSqX1rzaVcsKm+hBfTFXiO26DgBnFwFSr0I5
 IF3Q==
X-Gm-Message-State: AOJu0Yyr+irRZXh1nIyR8dew/uKr5r2LyMInKG5WE3snBYwVcsUcngG5
 mAw1Hruf8Hh2vKi1w642yJorAC+zsWWSFnxm8mHP0qEC26s2VkTGHUloiJA1tVVTtGAutT93FTX
 kdeClKyt2V4F4QVNWCS8NenWOSfa45z6tf0qoFj0m3ViBy4pTRS27m0UJ4L8wApqaoWaxIUEp/G
 SgkhYPEi8q+bwJKdCMVmDapwbNPfyT5IlEJcwTdG9xMx6IwB71dlDkNcMyZ1DEayrBR8m/qZN+4
 gHW9f2GiJrdmxidCgcQnIXPhXe0
X-Gm-Gg: AR+sD10TPRj63cix7xB22MFZ9jm4AXKRILwmF/RhM/VwX6G0M7ac3rnvDXIxsYFtv8W
 zx1/+pMvaq03p2d5vlxVYLhR2JuOaIQhJmrSeguH0RKDnh+OYHv07ZjTvjUTllcf135AtNa2pNA
 SUP6ZE4rIpDv+7GW7rnqZkulXwHLC/MWM73mZiOdlxTbTaR3QoU5gmahrdfg1bEf4FqsxhrgXnW
 LtyJSjKZpVHb2SB5tSAWkt/6qrEe14lSz/tQEKoKvi4H+xWm84RZUPttUWyrXAc/4irqUNElTfm
 Ax8CEhBS2C+k37BwxUFox7IoNji7VlBkjpYeHUMHzeFCADKY2BXYHhMSewwha2rH+fSUH+vK2ty
 otP9Wo7farqT76AsYKGvZjrdQ8xG4sqw3w7pRlKXm7FqmzdiYz2gbLsdNdJhJkB5uw1XITdWdnc
 Nnhjhof/7K0HRfBtkjW03K9LL/Z5/QCgRSflFOkg==
X-Received: by 2002:a17:90b:53d0:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3933bcec7edmr801981a91.17.1786655576881; 
 Thu, 13 Aug 2026 14:12:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 a92af1059eb24-14138832c8fsm63378c88.6.2026.08.13.14.12.56
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Aug 2026 14:12:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e4f946461so31408785a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1786655575; x=1787260375;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BmQIbOMpbDixM2LUoZ8EAUt/Js63kIkQtWinusc+PO0=;
 b=RO1ovZhqUPRdU8HzSpO1SIJLfTbEt1n+hFknxqZ5eD1hqhSHP8VBvWrVaS+UzHcI/g
 ykswGwJEK3fTpCBWxpjJmOvBAbxewYpzLqO5UbhFlSz9jdipfAy3/cR9aLQgCe1pvdcf
 MjjIUpMLrK54/raSCggCHsRT8Q4yfTjNF15sE=
X-Received: by 2002:a05:620a:4e5:b0:934:9524:2e89 with SMTP id
 af79cd13be357-936d229216fmr61562985a.13.1786655575273; 
 Thu, 13 Aug 2026 14:12:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4e5:b0:934:9524:2e89 with SMTP id
 af79cd13be357-936d229216fmr61557885a.13.1786655574799; 
 Thu, 13 Aug 2026 14:12:54 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce21cb5bsm77064685a.36.2026.08.13.14.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 14:12:54 -0700 (PDT)
Message-ID: <9ad23800-db89-48f2-a960-6c2fa11ee6d5@broadcom.com>
Date: Thu, 13 Aug 2026 14:12:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/vmwgfx: graphics memory not returned,after all GEM objects
 are released
To: Jellis Onsea | AccessWeb <jellis@accessweb.be>, zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
References: <66c0b5db-bea1-4608-be8f-bae437760d97@accessweb.be>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <66c0b5db-bea1-4608-be8f-bae437760d97@accessweb.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

That is good to know. Do you still see a memory leak with 3D off?

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
