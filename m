Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBA4CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 23:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B3710EA95;
	Wed, 27 May 2026 23:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AfHRu6LH";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089AC10EA96
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 23:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779923044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tLMejQTeHZr/KJzPXaBPJSEJrKOB4U1yG1HJSxIAxBU=;
 b=AfHRu6LH77wIL+LbyMOu5ZyJbYZUDIja7VRMu49YcqOF1QdEBwICFQvHxIlnMMc7pNlMgw
 sPbF7XJATdXe08IDB2UHokFfDubNtgf7g2y6dvYAfR9/zUJDWggpmm1AeXeWoqOLIDbW6q
 Od6J+i2kYLIAq7e6jpMQ0KKeC+Kphsk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-GU99qgkDPISGQsuTqMqPrw-1; Wed, 27 May 2026 19:04:02 -0400
X-MC-Unique: GU99qgkDPISGQsuTqMqPrw-1
X-Mimecast-MFC-AGG-ID: GU99qgkDPISGQsuTqMqPrw_1779923042
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516da5a1db4so122328251cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 16:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779923042; x=1780527842;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tLMejQTeHZr/KJzPXaBPJSEJrKOB4U1yG1HJSxIAxBU=;
 b=PQQYs5vjTR8qvVpTOiG6QvWEJut6Jjn6Ik5dsMZLmjYdIKtVzywXGY3G/xfphdAi/V
 dRLd6dA2ejYpvBSlxXyMYMa2JxnaiNWHV7syHVH4hidcKqYfNCtrr+CahWrx85396BoW
 t/Ey7kVd7sxrbHSdg+eWJXRgISBV2jtvZy6VVWN6HAZ6mCeBKwLrKzNK78boNv7gPBUL
 3N9SeC3bxyGTrewqruaam+gd7onRM4E3HbYXuBDiPqTXZbpwmm+irGB3Mjhl9Hd6v/es
 z0sdX8d4P5fw3tPxlLri+/2yz/UNVcAHU+Q7QGDKnOQODxh99p13B6Dha7Rgd+/zUSAz
 nAOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rZuKu9eHzrpGah7a5tSl9iqtA52V5Fd6vmv/pil+DYGfDoJTJMP+81g3GV6KE+gdeXoqsolvxX7M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHnLI0NBj6Fa10vEkE8K4Qyq4i56O1WMtVbTdFhYt4tWHovXPK
 bUFKUDrvfk4Wo/ROt1qWApXH6c9bCkLtI1M6fXpLE7Fdxy8ee1jLU3Pi8FuNpAtF+vt/FNRbTvG
 qbVJwjCQ2nLC2a4/UqA6lVU9DpwAtZkeCdx4cbov6MkdGCc+DYj3XoApDdqVP9PMxTR85bA==
X-Gm-Gg: Acq92OGJTdYLtnfAYx3PGLFItSzlTAgz5jZYfgONvkdWmPMVoqrfLX8wuzdntxnS5sG
 jv7ZV1kyFy/igy3sc7ULpdUKqfule4IGSThlmbR9sY/3uJh90NQbMT619MRxVhB7uFuMHil4KCQ
 KO5T0lybOq7IfsAqiES/4UPuqtTJBl2w6iGhCf3hyjpm8RsQ+MdkXsahYfH+3eXcYv+6ZV18z3Y
 3xxJxCz6nN7EhMCMHi8952IU+JuJtkQ3bF/qRYAgnzXXfiOubAVfXjLAVWTLcqfq/tTbsKOnIxh
 TRg22Sws2dAC0aPtmEmK7hmpmGBFo57FhQqmyspufG8mMsId7j1ehJ50Aku+kBWbIi7beJa0bya
 +rc6AKG83oBVMgO93XhPBAeK56oY=
X-Received: by 2002:a05:622a:8d04:b0:516:d4b1:48e4 with SMTP id
 d75a77b69052e-516d4b14caamr303864161cf.4.1779923042138; 
 Wed, 27 May 2026 16:04:02 -0700 (PDT)
X-Received: by 2002:a05:622a:8d04:b0:516:d4b1:48e4 with SMTP id
 d75a77b69052e-516d4b14caamr303863711cf.4.1779923041636; 
 Wed, 27 May 2026 16:04:01 -0700 (PDT)
Received: from redhat.com ([69.43.42.202]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706adc9cfsm53727441cf.19.2026.05.27.16.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 16:04:00 -0700 (PDT)
Date: Wed, 27 May 2026 19:03:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
Message-ID: <ahd4XgTo3KZqGS9M@redhat.com>
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
MIME-Version: 1.0
In-Reply-To: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QZweLXYu62_cObL09kHsYqxTFFi3qiCTyAPmwBb0ml0_1779923042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Hans,

On Wed, May 27, 2026 at 11:48:08AM +0200, Hans de Goede wrote:
> 2) One option considered was detaching the simple-framebuffer driver later,
>    after the real display driver has had a chance to claim the clocks. But
>    this won't work in cases where the real display driver picks different
>    parent clocks then the boot firmware did and needs to reparent clocks.

Why won't that work in the case where different parent clocks are selected?
I'll describe a scenario below.

> 
>    Basically the goal is for things to behave as if the simple-framebuffer
>    driver was not there at all, because that leaves the hw in the state
>    the real display driver expects.

I think the deferred unbinding could have some potential here where
there is some kind of notification mechanism between simple-framebuffer
and the real drm driver. So:

- simple-framebuffer driver takes reference(s) to the clk(s).

- real drm driver eventually loads, takes reference(s) to the necessary
  clk(s).

- real drm driver sends a notification to simple-framebuffer that it's
  done, and has control.

- simple-framebuffer can unbind and release its references to the clks.

No clks will be shutdown prematurely in this scenario.

If the real drm driver needs a different parent, then presumably things
should be setup correctly, and simple-framebuffer can have the clocks
shut down when it calls clk_disable_unprepare(). If the real drm driver
needed those clks, then it should hold a reference to them.

I'm intentionally not going through how to do the notification mechanism
here.

Brian

