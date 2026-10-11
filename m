Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5141DCA9ECC
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 20:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6824410E09A;
	Sun, 11 Oct 2026 20:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=packett.cool header.i=@packett.cool header.b="F/+0Zmhj";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC7210E09A
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 20:43:24 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=rqaA0XuWiDskP9yuqwcegfvbvYXBfuaFoAbZjxFS4is=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791751403; v=1; x=1792356203;
 b=F/+0Zmhj1z1Nxe891pHNxIFQxl6ZLKuxQjJ/S1GeoYNI04cReDkv29E2IZhawz95sRDUsrWY
 ji1Cw/u6zD969atYB+7KQHu24XEUuITa6E48MXGEsKFMyp6kiSrinZisukW2wyMDZ6BtlY3Xjs+
 zfAcBfHTGvTHo5JRHAr2kk0pbg9v3sb5J6+uODWdQq27JmJj1pczZCgcLPn7aNrTbKiWiOy71zi
 S6qg5un16aS1Qku6Lwsny8svrporRTgB6NYZukWFv4J9UfjYv+ySOgrlEXGg8pkbP5HFQ6ON9oR
 1mGCw1q4Mhrb5eMifNlNnrx+qOd8k5Yl2Dyzz9LxU6wBg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id e9d61ac877c13462;
 Sun, 11 Oct 2026 20:43:22 +0000
X-Mizu-Trace-ID: e9d61ac877c13462
X-Migadu-Flow: FLOW_OUT
Message-ID: <c5051b9d-2657-4852-809e-37ce2839e728@packett.cool>
Date: Sun, 11 Oct 2026 17:43:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/9] drm/panel: add atomic state
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
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


On 10/8/26 10:14 AM, Dmitry Baryshkov wrote:
> Panel drivers don't have an atomic state and so they can't handle
> additional data to be stored at the atomic_check time or to be retrieved
> at the enable/disable time. For example, it prevents panel drivers from
> supporting multiple display modes or making DSC being optional in a
> clean way. Drivers like panel-novatek-nt35950, save the connector
> pointer in get_modes() and later dereference
> connector->state->crtc->state from prepare() without holding any locks.
> The panels also have no way to reject the configuration they cann't
> handle, as it doesn't take part in the atomic check.
>
> The panel already embeds a drm_bridge, and the bridge has an atomic
> state which is property handled. Subclass it to provide atomic state for
> the panels. The callbacks can find the state of the other related
> objects (e.g. CRTC state to get the display mode).
>
> The atomic state is opt-in. A panel that doesn't implement the state
> callbacks keeps working exactly as before, with the plain bridge state,
> so there is no need to touch the existing drivers. The panels which do
> implement them can only be driven through the embedded bridge, since
> there is no commit to hand over when the host calls drm_panel_prepare()
> and friends directly. Those entry points warn and refuse to handle such
> panels. There are still a dozen of display drivers calling these
> functions, and the panels used with them can not be converted until the
> hosts are switched to the panel bridge.
>
> The previous attempt by Val Packett <val@packett.cool> ([1]), but it had
> issues with the API design, passing NULL for the state. This approach
> follows closer the path that was chosen for drm_bridge conversion.
>
> The series is marked as RFC as it is only compiled-tested only.
>
> [1] https://lore.kernel.org/r/20260425001130.233935-1-val@packett.cool/

Tested-by: Val Packett <val@packett.cool>

Converted my nt37701 WIP to this, temporarily at:

https://github.com/valpackett/linux-qclaptops/commit/a0a3a25e1ce484ffe072e4399014ced605c78852

Everything works as it did with my initial hacky attempt. :)

~val

