Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F46606A331
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJ0+vbMX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBBE810F436;
	Tue,  3 Nov 2026 08:21:47 +0000 (UTC)
Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3778F10E676
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:48:11 +0000 (UTC)
Received: by mail-oo2-f6.google.com with SMTP id
 46e09a7af769-8217177c5daso694828a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793638090; x=1794242890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z7VS6al0JzZMFGXrqJsbyoWOE59PZK4uhHY6gGIKbAw=;
 b=PJ0+vbMXlCdsTjOI+6JZTm5ehOzwrG6Zx2FpjeqvdWQtS0Wzrpxrie32jlq+7u+8Lc
 SFvQNIhjClPldQW2reZKP2us2HuVSFi3tEOVGnhVMeOD+FE9F3HgvN/4UE+Ud1J90GaX
 EAC+56occn4J0X2ujkpLISY7peY1u7fbK6/RMphgH6GyI78wVjIMn2vwv7pdaWrEEhR0
 aTUI+fY4R1nTt7I4VV+6p/9y0f8Cbado7QZoiNGWKJlMWKbFVW8fP/pFj1ZuStb9VlI3
 CapsrCjnLAyDnbDBDQxt5yOpKYmnNccuHuINfFTC1mEwqh+Cbgn2p95UV+8dmul5H14K
 h0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793638090; x=1794242890;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z7VS6al0JzZMFGXrqJsbyoWOE59PZK4uhHY6gGIKbAw=;
 b=OrfAq3Gfl8GPX6QRdrXJK38hEblXZwwkzRZzHF1PGExMnOHWD1koBiu4y5CwqQfiUh
 GkoZn6AkNeq5PA0VkZ3Go77rVFfNTKN5JeWr7cS9b1ZdGqkPqOfhOBg0A8HXPUxm3Dsn
 r1GV1JUNlLrXw+p2s1qqC46mwDB2cAEHYSBTCvCEBjcQ2h5Uge86i8Ijt+ocTlrB848l
 GrS73BuXgdBNY3My5XZWJ+9ENehcOKZQn91oltPiLRsSQn/bP0HKXJPejsBJKqPUY6Yo
 oWpXZ7EiB2sDNQjny2KQ0Qsa68k5sOLRQMgWFqfLHzj6iL2pZ7o2ko0/+6Xlyzu1dJ+G
 KeeA==
X-Forwarded-Encrypted: i=1;
 AKwUvByx82rpmVqEpz2N/prsOR0BZI0htyyKHn0iCLbPHmFaoM5vw0PsgprtpfXzNle1CwlOrUcTVREVw1E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKfHTs4BpZvRtpVLqnERYkYVQKWP7nlyG1GFprOsHALqPrgebTe
 7WnI8QZlDcbcTs8h3bNiX+Jh5cOYlM4cc2WES6/uNiJOwlbjPhGh3ts9
X-Gm-Gg: AYBFou386jjgasa80f9EnCoAQvQ0rDwXNCnEhcUymIuRput/LI2ZP563GXxRc52kd9B
 jiy3y9meVy0UPg82Sw1kJHe7nWZIGUZEibCRuBOw4F+VMag1i6hw+7O511GSWjDS9dsPP9qO6Lm
 me7LAJkeE4HZWiCcQ97wqoN/8Ny34GO32cg2q8rjpPGKNXuNniep4TyN6sj2treUNQNYorpwlav
 LgvLVEuso/MzX4veozBJd5k2WicZbI+QZZv7NKatySduxBl8Xjnji8YRZY5Y5aYOA6B/g1S2Hrc
 Nx4XfuxhH4X7kW0k3GuDGVDjauUBzN/HumGWWPeq3X1e/RbnY6UFgJ9VL9eUIkF2O70WmeYejkC
 m5BjRfA4sr7iXFEecBS57QnKxoO4VM9jrMclUbkhjTdL0abj7vfC2FliXS2gmu/o0yHKtRSU3Ng
 Vk6W0zMqzKV5uAhniGdpOVuPSkgD0hyR8KBhmQ4Vq3GoWLIceAxkkWe+95KzYH5GFWAKIbxrFfo
 3Oa9HU7HMP9F7bAa1NiTqh1VdQBGA8/jUOj81z0A4/rnIU3b2BwErVGctv1AJOaqMS2LPJYWEdY
 kqD6j9UdOfGZei9tUZoz+9vV/ZM3Nr1quToQ45V8vkva2XbIjh0mH4Uon8gf2DhqxyyH8h7Yyd2
 qNL/hmR2akDURoGPHbuzN
X-Received: by 2002:a05:6808:c232:b0:4cb:ae51:5971 with SMTP id
 5614622812f47-5640ddade81mr7293574b6e.32.1793638090243; 
 Mon, 02 Nov 2026 08:48:10 -0800 (PST)
Received: from [10.10.121.179] (wsip-64-207-253-118.tu.ok.cox.net.
 [64.207.253.118]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a92167b03csm6972479fac.2.2026.11.02.08.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 08:48:09 -0800 (PST)
Message-ID: <74880003-29c9-4f8e-a7b8-b5ecce9d4230@gmail.com>
Date: Mon, 2 Nov 2026 10:48:08 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/imagination: don't gate the runtime PM
 callbacks on drm_dev_enter()
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
 <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-1-674b907d0652@gmail.com>
 <CAKbEznugM-HxPxHwZ7RxC2iLC0TDH0qi9649hWATiPYXF+urfw@mail.gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <CAKbEznugM-HxPxHwZ7RxC2iLC0TDH0qi9649hWATiPYXF+urfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 08:21:46 +0000
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Gyeyoung,

On 10/12/26 10:43 PM, Gyeyoung Baek wrote:
> 'lost' looks protected by reset_sem, but it's read here without the
> lock. Shouldn't this at least be READ_ONCE()?
Thanks for looking, you're right. Lost isn't fully covered by reset_sem 
anyway, as pvr_mmu_flush_exec() marks the device lost without it, and 
the watchdog worker already reads it unlocked. I'll make it a 
READ_ONCE(), with a matching WRITE_ONCE() in pvr_device_lost() in the 
next revision.

Thanks again,
Ryan Brue
