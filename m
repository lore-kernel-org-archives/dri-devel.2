Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9820606D836
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=W4XoIwFe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C43710E278;
	Wed,  4 Nov 2026 20:13:25 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BE910E278
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793823198;
 bh=VkmYakpqpnhkFxx0QURjLD3tnwFfJeC8t9xnwmwTycw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W4XoIwFepNaamhG5xYF0/u5N0OJgK0G+K/mAqwutqLaqz31z66kfhH5OujEswMwHh
 ynluuDIORHxCS86AXtgBwaoGfEoggXDdSwCt8G8Tr7lfUYhHgAnzEuBu31HCU5fkYe
 kW5ci2WohN3UZc4c2y2+ZRrKj0aynczuqEk0vkQ7Ugpbi0rWVVgt4xvy7zS9RwO9RX
 Aj0eQi5qzyZMvkyeX85Kdfq1QIEf/ISVrQl3fScd9/Uru7pighLN8AFdDqBqTgYdQY
 FydSS+GSvof9VqvZ6LHhGiyTPMXxpK6ABv2+87tWJek9PMzDOrXOKELMrm5aRBihSM
 GtTIquTMYWyew==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 169C017E0564;
 Wed, 04 Nov 2026 21:13:17 +0100 (CET)
Message-ID: <cd6321bf-9737-4949-9906-c0206e54bab6@collabora.com>
Date: Wed, 4 Nov 2026 22:13:16 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/15] drm/rockchip: vop2: Send pending event when
 atomic_enable() fails
To: Daniel Stone <daniel@fooishbar.org>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Daniel Stone <daniels@collabora.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com,
 Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-4-6fab0fe43a9b@collabora.com>
 <CAPj87rN1rzjDMPvVJytwmvHGipCCuYOyX3abTRqYp4Vq5PyrYQ@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAPj87rN1rzjDMPvVJytwmvHGipCCuYOyX3abTRqYp4Vq5PyrYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

Thanks for reviewing the series!

On 10/30/26 1:21 PM, Daniel Stone wrote:
> Hi Cristian,
> 
> On Tue, 13 Oct 2026 at 23:51, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>> vop2_crtc_atomic_flush() stashes the CRTC completion event in vp->event
>> and relies on the frame start interrupt (VP_INT_FS_FIELD) to deliver it
>> later via drm_crtc_send_vblank_event().  Since atomic_enable() runs
>> before atomic_flush(), bailing on an error path makes it skip
>> drm_crtc_vblank_on() and leave the video port disabled.  atomic_flush()
>> still traps the event in vp->event, but since the port never scans out,
>> the frame start interrupt does not fire and the event is not delivered.
>> Userspace waiting for the flip completion then blocks indefinitely.
>>
>> Note the event cannot be flushed from atomic_disable(), as userspace
>> waits for the completion before committing the next state, so the
>> disable does not arrive and draining it there would deadlock.
>>
>> Use the newly added vp->enabled flag to detect this in atomic_flush()
>> and send the event immediately when the port did not come up, rather
>> than deferring it to an interrupt that will never occur.  This also
>> avoids the spurious drm_crtc_vblank_get() WARN previously hit on the
>> failed enable path, where the vblank is not on.
> 
> I really don't know how I feel about this one.
> 
> atomic_enable() is not supposed to fail at all, hence returning void.
> (Obviously, there are scenarios where it will fail, which Sashiko
> keeps 'helpfully' pointing out ...)
> 
> I don't like how this just papers over the issue. It turns an eventual
> WARN on vblank timeout - which surfaces the issue - into a silent
> false-success. Userspace just sees commit completion requests arrive
> as soon as it's posted the commit, so it keeps on going on and
> everyone's happy. Having the flips time out is a messy splat of WARNs,
> but at least that messy splat points at the exact issues, rather than
> the screen just going black and userspace blithely trying to continue
> on.

Ack. Let's drop the patch.

Cristian
