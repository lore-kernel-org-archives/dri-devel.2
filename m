Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCE2CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 19:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CEA10EB32;
	Fri, 12 Jun 2026 19:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hrlfpUg+";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D92710EB32
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 19:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781294073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BgWb+j/19tPK7KGiMKmrUIbFZtPFiPblMcPS633YyJk=;
 b=hrlfpUg+Rs5d8KBcpS+uNtvCH8A/SNqnIJByqhw2WBVOxsG/mRT1fOJql9MjAjrSr7+O7z
 i9nAB0AC2ODTyFOZnY3oxdBxqcCGUeLwwe3NwOJ9G601kM7oBVCEK1eYTdPG5xL7gnFJfb
 foElLby2tpsZhjEzx6NI9FgCq9eZBdo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-bMudi60TNretqW2VK9yoXw-1; Fri, 12 Jun 2026 15:54:31 -0400
X-MC-Unique: bMudi60TNretqW2VK9yoXw-1
X-Mimecast-MFC-AGG-ID: bMudi60TNretqW2VK9yoXw_1781294070
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b3ec3f7fso8163095e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 12:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781294070; x=1781898870;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BgWb+j/19tPK7KGiMKmrUIbFZtPFiPblMcPS633YyJk=;
 b=OCb34mf6b1n0fJlVpHAvvpd5tMG9UNLuKz5pjjmsHU8weJVYGBGy1nwaK2NQClfyqm
 gjmvIvDstNPx72VsAAav5eWgmxuk2pAGRk296796ypwf4O6wUukudjP03bN/3zV/uv7P
 uVUbvWBr8H8FNHHf9SBXBsj5R+6zkd+dLlNnWWLBZA1I3OZjmQPNRR/ksVXv/ruQNytB
 ft3khqgivy7zJ7xcPy8Q+ic2bJQarb4UfSOLWhBUh9YY5ZWGBjwbLJJ+DTounGgiebTf
 kU7Aqe+L5kWM82ZdDUIUILWpnWZTofp5jg1g9kerxFK84kCPLidflflPGPKY+tL3aMuz
 PSzA==
X-Gm-Message-State: AOJu0YxRdRBSdWYt93AuzIAiUqtrCTbZntV+YSrgCyjGfUlAK0/HeNCo
 ELavMR1O0rvYN+QMQ2LlD82lmIsol45QFzI1hhxrp27VzEqcHPQ8/ANNTPGPpLBhSuMgtDwasWy
 2kXa6wR3pFXqGbvh7cAbu3oMPRdYFLzXDwPcL9UMfPzaaqCNrsQTP/t30bvZyr2Dgy78Ytg==
X-Gm-Gg: Acq92OHUPZ4qHrG8A/QSJBnU1FY2pAn674P5Zszm6a1ECZlNdOpOI9ZP/4LDVjuikxy
 6ucBQ+QStk/qsHGJrEwrsV2EiHw5EvgpXSUaP18BdkS1dpzBjYWmreg/8uvT207jG6mfY1LLz0y
 P1jR99KtRyOVKJLgt20OsYEKnt9FYAhh6mx02dlSnsZxeCaiYkjxlRNc6CYTiUCdyvX/2nNsYta
 gQaG2rsFZ8ydKjKrAsIikyRhR9Iac+6ydJtNvfGMQBBwdc8se9OKd3OaGCQXXFGlgMeZTnqsTXs
 v3HuKL2QdGyyatsdoGbZXHwhEU5eBBUaB+NJyEBxNSCUK4jOVqwfz7MRpjHRPIwICNDmedv76Sk
 RMRq6HDuooPwQ8juxV46c54Nv4XZqASiDjJI7csumWBJt0DG6yHAx3UcDyfHrHAqpazhiQFQJWB
 eoX/yh
X-Received: by 2002:a05:600c:3145:b0:490:be44:32ea with SMTP id
 5b1f17b1804b1-490ec4a16b9mr59917385e9.7.1781294070003; 
 Fri, 12 Jun 2026 12:54:30 -0700 (PDT)
X-Received: by 2002:a05:600c:3145:b0:490:be44:32ea with SMTP id
 5b1f17b1804b1-490ec4a16b9mr59917035e9.7.1781294069574; 
 Fri, 12 Jun 2026 12:54:29 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922035b4absm14111425e9.11.2026.06.12.12.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 12:54:28 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Alberto Ruiz via B4 Relay <devnull+aruiz.redhat.com@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Alberto
 Ruiz <aruiz@redhat.com>
Subject: Re: [PATCH 0/4] drm/solomon: batch command sequences for
 SSD130x/132x/133x init
In-Reply-To: <20260612-ssd-batchcmd-v1-0-c61e5f7c24bc@redhat.com>
References: <20260612-ssd-batchcmd-v1-0-c61e5f7c24bc@redhat.com>
Date: Fri, 12 Jun 2026 21:54:27 +0200
Message-ID: <87o6hfzg98.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f2vNlPLn0gg4hyDuBwf-XG_SN5TvXCaVbiRc_wsb4_k_1781294070
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Alberto Ruiz via B4 Relay <devnull+aruiz.redhat.com@kernel.org> writes:

Hello Alberto,

Thanks for the patches. Nice cleanup!

> The ssd130x_init(), ssd132x_init(), and ssd133x_init() functions each
> issue long chains of individual ssd130x_write_cmd() calls, each
> followed by its own error check.  This is verbose and makes the init
> sequences harder to read and maintain.
>
> This series introduces ssd130x_run_cmd_seq(), which interprets a flat
> byte array of length-prefixed command entries terminated by a zero
> byte, and converts the three init functions to use it.  The result is
> a net reduction of ~110 lines, with the hardware programming sequences
> now expressed as compact, declarative tables rather than imperative
> call-and-check chains.
>
> Signed-off-by: Alberto Ruiz <aruiz@redhat.com>
> ---
> Alberto Ruiz (4):
>       drm/solomon: add ssd130x_run_cmd_seq() for batch command execution
>       drm/solomon: use ssd130x_run_cmd_seq() in ssd130x_init()
>       drm/solomon: use ssd130x_run_cmd_seq() in ssd132x_init()
>       drm/solomon: use ssd130x_run_cmd_seq() in ssd133x_init()

For all the patches:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>

I'll wait for a few days to merge them, in case someone else have comments.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

