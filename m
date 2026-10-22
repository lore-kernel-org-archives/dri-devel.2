Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB28606A337
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KCfclWSX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF78A10E197;
	Thu, 22 Oct 2026 03:22:10 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157E710E197
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 03:22:05 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so11047075e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792639323; x=1793244123; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iY1/g9P0L4rhvgCO8gfRef6JrnvEPdwuVRox6+EysUI=;
 b=KCfclWSXW9IHNJmaZyTn3ywFCFGGOJgLpyEBXzQsOCsZ9TtrT/BoWOM9iXMcFuHLeu
 wlyTkKOB+4jowrgS35mvUPHKaZcDRTljXbNjqm8GNc8DNvi4O5xPcyKqN6+FLH/9Qca3
 tzMZxp5PXBQMHwNC6rzsuYnYF6qur8DIg7FSceGJ05hzNUKkmxCdrcM0pbSRtrJI+7n6
 XcldnxMPqxok2fulIjJzP+weCyUi2+p3CgRfN4E7bbAJPA2nQ8iI7IUEWxvAy9N2WoZR
 eshuMl8nChIUdwfNv3FyGznRewdrSaV9/Og2cw4t5Na3cu+NWdm4BBpqLDU2FPpOCCpg
 srXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792639323; x=1793244123;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iY1/g9P0L4rhvgCO8gfRef6JrnvEPdwuVRox6+EysUI=;
 b=MpUTd6DgGV0YlOKzed6f86Jad5VyTtWB6JWCAtYMT3PX2Lz3YgjtRrdfzzn9dH48do
 jQk8F/yHm2F9rdFqyg+xgHJl5hm6uFabQpBdg3eWgwmpq5TaCET2iLfBT6uGnlagz0lT
 h6KblQo3W62rc3JZpOv2YgQq7bciScvLsLvREdL3FAOxj4ETGIk9srPigNvCsjFmTJkn
 HtvpxZiSJz1a/eQQl/uEFUis32uU1pP0leE+DoFBwNI56hwYc6AjmPWEayoKTO1w8dRS
 uH3iFBSaZumttvae4nGTazGNm2twd0IsgW10cfPV3rYcw+mU9j93X9iyEgOL2FkNXcO3
 KjiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzif2T6NX+GbSz6MGMiHQEQofG58cAxmxEYLJf9n6LHub9vHXWE1Wwl/od4WJDQ/iVHN68Mi9L9/3U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI6VbOzJAZLdYZdun43SSSmgQOG3M/fn2luNQVM7HWTGEJ0/N9u
 Ka8W2F+/l8Fn6RsLkitazYdMI+kVjXmDSR9VF7efWl34vtzIRnLeXM10
X-Gm-Gg: AYBFou1bXMzdFxGTZr6s+tffUTz6OIDVPnx8DmTGhufWL9ncZDZMH5xLY0meMC7laj+
 aiwvoD625Diy9d7suELCBtXCpveyddPu94UNddptNTxXufV7Vw6Bc3MTLptWWH45xTHdQpLmhng
 JsfOeWIWe3yT0f/KVenT6CDn8Wtkj6zBeg3BanEW445AfaNG3ZfXAk3Rm2ajWwNyI4Dn87+adwZ
 lMCnH8Y/mIsg3CqPXRE34yD/SJJUA+iGofi3PVvWMDeT0ufZ+VbhmnDG5/k+w2EgDfDIqbipRgO
 6JGVyE/pIYX4ss8mQuR576Jx5CF0PnUGMXdCesJSf98pAlRYw0UUk7TTbHFHYXMtU8aawVJ/oRq
 9p/NlOqoDlpmCkEjyMymBmsaRC3BVNiXCbOeFwvShAop/EYVIc1C7uUrhz1nhJ+StDCTS1SCjB+
 Btl/4DZuSq5jfUC54Dh9f3WNqv4dEi28dDvLJ0jeAwTxRTQrvC4jv6LC6CUOFVP/jxrf73eQiGY
 pzFci+PYiQpxoJ3PyDSNniY5UAQ1rJFOjkMrv1HnXZlvd+fTmqMBa5GuX5fQA9NT34js7t6/8ht
 jnBSAWiBeY2MrWk2iyjx5V7JsbzejSW94l6I6Q7fAPsZcEq7V5t6gXSyFMw2Ds933r8rGOr+PT+
 KylMv/WQ9L0wkjsbyEnkMGS1ru8x5A5sET2SDZ8nTYcikvZgXEdw0SxVO
X-Received: by 2002:a05:600c:628d:b0:4a1:f377:5c6e with SMTP id
 5b1f17b1804b1-4a1fdd20a24mr80516715e9.7.1792639320880; 
 Wed, 21 Oct 2026 20:22:00 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de.
 [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcdd3856sm23089115e9.1.2026.10.21.20.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 20:21:59 -0700 (PDT)
Date: Thu, 22 Oct 2026 05:21:54 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-media@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] media: videobuf2: finish prepared buffers in
 VIDIOC_REMOVE_BUFS
Message-ID: <atl_rOMxqyHbD64q@gmail.com>
References: <cover.1792392288.git.kmehltretter@gmail.com>
 <f2258d73562e0ebf2efd793b646706ba0dacb2c7.1792392288.git.kmehltretter@gmail.com>
 <CAAFQd5CDPG4RxUwPDbPUJSCxVZE1cEeYEZvQ25Sy4CuJR861Yg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5CDPG4RxUwPDbPUJSCxVZE1cEeYEZvQ25Sy4CuJR861Yg@mail.gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Tomasz,

On Thu, Oct 22, 2026 at 01:00:19AM +0100, Tomasz Figa wrote:
> > +               __vb2_buf_mem_finish(vb);
> > +               call_void_vb_qop(vb, buf_finish, vb);
> > +               vb->prepared = 0;
> > +       }
> > +
> 
> __vb2_queue_cancel() does much more than that, especially all the
> media request handling. In addition, this open coded handling just
> causes code duplication.
> 
> Would it make more sense to refactor the relevant part of the buffer
> cancelation loop from __vb2_queue_cancel() into a helper function and
> call it here instead?
> 

Yes that makes sense. The complete per-buffer cancellation tail can be
moved into a shared helper, while keeping the REMOVE_BUFS range check
before any buffer is changed.

I can then send patch 1 separately from the DMA-BUF access work.

Thanks,
Karl

