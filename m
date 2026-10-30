Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60C606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=iUntNFzQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5352C10E44C;
	Fri, 30 Oct 2026 11:21:50 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833F610E44C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:21:43 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so315661b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793359303; cv=none;
 d=google.com; s=arc-20260327;
 b=nj+l4pgG2YU4ulITprkr1pOXpDcP0vS+Nq3Ajgv0eJTjKbQ6K2jQ8itoliGZLRcEzq
 2Tl1jwemPE81Y6G+TfSwORd9HoqN//Y4t6Fm9b46ec6KNv0R7RcRa8hq507byuxF5C82
 /EVSQV+uQLwSA4qKpL9QmmFFBZWzm3+GVsMJJZdQEtOokV7mZZ+S6SSP/Z3jAnMqMjZz
 aeOfGMmFk43SxFGOzBVcr2X8InNKt1u7iFpn4awinmJdJdh0teeo53QNa+i14RK3YHBR
 8DB7NNZvJrTL4+ktRIAzJ8XSxQQOhFikzyZBhodp/RQn6xLPpICD/k3+p3I3XHcnN/Cg
 mMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IhotsZMujGgxWB8wogYX7M/QNYLtJDwXry3FOoC6GuE=;
 fh=4bqYobJYcLCcRw/97uCWIk0vEEHmGRG7WhWycTR3hn4=;
 b=s+GwjjjvJN/oLjA2wFP7h/nICBDNBekdq+1X0YGpNrSlJdsjMjV1FYIUrXiKAzgM62
 QXPHNO1pccrvoXJXYuy3/SOwtkDp2x0W+1N9cMgZD8XJHjjqP9/+dBYO/TOt6DCRrbF8
 dMAshrN1nrv73JfX8PtHnaZ9Y+EixBj52MlmzH4FBJsgfvv+4l7DCZbtfIWM4QdrtxXa
 76SEn9Rbf9bvUuFrGBHpLd2hj1US9dQN2Tuhtp3aq5GPAZ6oMG4smuohD6RUdaHs3idG
 hD3cfOD5YWE5NPVtrQB//zH59FsGz5sQC7YiM0C9MVMrW3O+oOPbVn576uPnDx65j+rG
 Cgpg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793359303; x=1793964103;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IhotsZMujGgxWB8wogYX7M/QNYLtJDwXry3FOoC6GuE=;
 b=iUntNFzQzlw3KzY/Ph9pnUH4uYsTyZ3rySwYeRTOBWIANfzLt/seBpPk0bliEqq7wx
 KPUL+H/kp1gw70CZYqVZQgFo3o4ftjB4NWIOh9Aj5nrq68ljfxct3ItsgVT0E0qCXvfF
 wls5qC+Buipy1qcrrZjYoNkHBJeNzw77wtwQ2yuemTRhWP0Q83B2+hvGbDXXCSxbyzam
 L93jo+d1RV9sXMiPiKJb+oNNsjjy1zQlJYVAWwOooJfsoe/OMknZ187Gn+CpdDdl9lOk
 Nkpz9fc6DgHz6cnAYId3qmd4qobIizr70iGtwFTkBtHFlJLiMxY2x4+VMl2KED8CbdmU
 HfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359303; x=1793964103;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IhotsZMujGgxWB8wogYX7M/QNYLtJDwXry3FOoC6GuE=;
 b=HZovWC3x/NCMh/xadnreZEGlz6jiwjr7/5Ly2aOiep/x0/G7r9AQITxVBjGAdi3zdp
 0RXujd9o6OsXCFv41TXoVxWMGo64m3pFkN3Sqk0KJN4g6yhHD6sAwSkfDuincp8D9B53
 jZ/tWJ8pdH0NiGU0TBLgH/POKLKvoh8f38zMnN3tDU81UgONxDWAH0iQ1Fkunuw4r7qs
 t05lSIyelc8hpGYBZL1QTF+lZL/Wj0zS5edQ5Wv4c+WNfimgr5gGDjZZ2NL7/1NtQg/s
 xW/XhPnCRV+RUVbb7II+rL53+cWLtyzKlyOF4tvQ5+i62JapN2Dj8SGHfA9iytBR0Pds
 LwxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4tSYc/01D+F66P4CBZTw2G4IgdaY/QbfSUtcPsaNoH7JrtqsKEc6kGj4+0qSxFmMdbercRtlcCqg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIfIVbF1UkN5iqaX6q8VgYr+N3trroXxfIX2G6mKC/DtKmatkHF
 M1/mq8rJ1ZYXTNzcDHlfyeP96FHQa36WlG1MxcSGVZPdu2QRSriqQ7vocR5fWFOXbaF3v5blYi4
 0/BLc+zMzXLKsMICVMJDjyCBXyxq/4FgeUEKjnbvQvQ==
X-Gm-Gg: AYBFou3Y/rkdvaGmQIBZDe6Obu9etY/LcD8YbrJ1LWhbrVQRumcFAdDIeQmnxbRPiM4
 t7ASrl/CWgmJF4FWjE9TcsKv1Xxn8uA8SuGvlbMDgOzgxkGqjmB8KmSWdEM55s3ZsCBDd5ADZaE
 +77NsOXuVBHWE9WBnO1kc3dMaSOpdZ1N/x1mOWAIBCOXl0bbkkGFl83SwMzEtbYPFhR5QUQDRvQ
 8WdIn3atGcQoQ9/v45+11PygW7pOiHiYQD4cMx/K9+kZMyY0qbkXhNEMIyDTO6ueO3tikfRe6ur
 v2jBgj8tFT8noT2ovM246XrHJ6p+zfpNG+tHUNCk1N1gUkbF2WH5qpV7unFihHAI4mNa1DCFiZQ
 gWE71R4gL0MWoaGl9Na0N/8iY6YmELP4d2GtN
X-Received: by 2002:a05:6a00:12dc:b0:8a0:18bd:ddb0 with SMTP id
 d2e1a72fcca58-8a9bf71b34fmr1264612b3a.26.1793359302995; Fri, 30 Oct 2026
 04:21:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-4-6fab0fe43a9b@collabora.com>
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-4-6fab0fe43a9b@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 30 Oct 2026 11:21:32 +0000
X-Gm-Features: AclHuK_sZpu_OHKEsqb49igvHOjsFenvWY6XU2UJTZwHMq2AAjoVYXumXoLt9p0
Message-ID: <CAPj87rN1rzjDMPvVJytwmvHGipCCuYOyX3abTRqYp4Vq5PyrYQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/15] drm/rockchip: vop2: Send pending event when
 atomic_enable() fails
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com, 
 Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cristian,

On Tue, 13 Oct 2026 at 23:51, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> vop2_crtc_atomic_flush() stashes the CRTC completion event in vp->event
> and relies on the frame start interrupt (VP_INT_FS_FIELD) to deliver it
> later via drm_crtc_send_vblank_event().  Since atomic_enable() runs
> before atomic_flush(), bailing on an error path makes it skip
> drm_crtc_vblank_on() and leave the video port disabled.  atomic_flush()
> still traps the event in vp->event, but since the port never scans out,
> the frame start interrupt does not fire and the event is not delivered.
> Userspace waiting for the flip completion then blocks indefinitely.
>
> Note the event cannot be flushed from atomic_disable(), as userspace
> waits for the completion before committing the next state, so the
> disable does not arrive and draining it there would deadlock.
>
> Use the newly added vp->enabled flag to detect this in atomic_flush()
> and send the event immediately when the port did not come up, rather
> than deferring it to an interrupt that will never occur.  This also
> avoids the spurious drm_crtc_vblank_get() WARN previously hit on the
> failed enable path, where the vblank is not on.

I really don't know how I feel about this one.

atomic_enable() is not supposed to fail at all, hence returning void.
(Obviously, there are scenarios where it will fail, which Sashiko
keeps 'helpfully' pointing out ...)

I don't like how this just papers over the issue. It turns an eventual
WARN on vblank timeout - which surfaces the issue - into a silent
false-success. Userspace just sees commit completion requests arrive
as soon as it's posted the commit, so it keeps on going on and
everyone's happy. Having the flips time out is a messy splat of WARNs,
but at least that messy splat points at the exact issues, rather than
the screen just going black and userspace blithely trying to continue
on.

Cheers,
Daniel
