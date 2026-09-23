Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5864EC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF59310F0D9;
	Wed, 23 Sep 2026 14:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X1hU37C1";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9882010F0BB
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 14:27:05 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482e1b55da9so111297f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790173624; x=1790778424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qUZaB+3UwVox3QuJ6fhpHcHgvKk5qs3qiEgpgLo0ESw=;
 b=X1hU37C1YjlHg10EzcP4UEPavHAKi08L6FUw7ty2UPj2+6ASAo4G7xkGQ5G1S8jZQ1
 Z0u+Un6XtVdwEhd+qqNCgg1jdyQjjLfnkxsYF/L7755IwUR2ODOkZqnaWp5ybdt9udHz
 LApzioPLqQHNx0ikaISsrQPCIYpTMoD6m8NJXWAYrYG9k+VXFht2TMW1Hjl6Vp9EaEAt
 SXBJw4XGNA9irpFFQKsiCfbwc66ZzskIaa1+6exJFljwFQHWWkMFq7a1RUXFyClsnxW6
 wLhEiXBliPJsYS5oUr3MmqSk07rP2tN9iWEVY8IkOxe1ZQKXKxUDFLWGdlzaWybYqgL/
 wZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790173624; x=1790778424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qUZaB+3UwVox3QuJ6fhpHcHgvKk5qs3qiEgpgLo0ESw=;
 b=ULvKeN5Dhp9Y++5eg4vVhJfTNNXkLWVa79xsCvj3pIoNQuwT0phsQb2pm30vKZVxiz
 Lgsyr2JtkDFkDAuMLD/1512mc/80MLHjWFAiYPm50S+NtGXpyxK0USBysJC/YUpUNC7W
 hqm+T4nitHC1y3Wq6rhzZGJQMlf8L5xWKq78PzI/5zGCjiDvF7J+FFB8Lk7VJ2T3j95U
 TumBbl5RnIEKaiEYkfU0wF60ANDrKTzh0SlzDA4eql25l24GaNmKsLkmvPCoEKjBjYs7
 KooiMhDFqk4LC7YGDXNQ1C7QTPGH/oidJ1rpr+awjjXUtCQHEKiVIupe4J+t8j6+NOsc
 2qig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc66mgcQmV1xGTr5ByT/ZMYZhlfceuQ8ZyEswVGHkiZjrwg/gQyUZyvtEdO8AOsSmoVorraXb2BGI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lMyp9ze6gg7aaZZiv7TyRHR/DrkaPyOWamP1eyXGp7J4++ybWN
 oBp+gYv4jeOqvmBtA2JNsT8Ca0dhM6AA3E7gOneY4QGvbiltmi9lJjf/
X-Gm-Gg: AYBFou0eJnCDklnwGuehhsVQwiPcJsIh8gpwfCJfL0RSkHEJw7LD+hRljuGB85CTjSU
 hz+2mVjKLgNRgCzb/H6e/SA3h2BkuTG04Kr87hSpGfw/tk57jYV6s6XfcP8te2v2qlKifv3P8sp
 rgjArdsHZQDFC3ICeyiHQ9rMsheLmKM5IbLh3Nu7rCl4ipA31zWxfQ/v4Smz6LlVQd44offF8Bb
 gxI3IB7caWba7EvNeZKMoEXl5KjAiZYX9D+OkYzMP/Bj5wZ+o7fJ14TkOV47lj9ukRFx1c2bVj6
 FPPf7IhFm3YDg0WmEolLR3WBsfIUSD7Yja6I6P+U8q5naugRyFEbh3Tw93BIpdN4wVFpPb418qe
 NoW4Vmz1SaYZkOFbHkUBdEDpknZVMLuZn6DS8xxRTI3e6XmtybvrRvUg7b4GTjyFo8IPci/e4SF
 RgNHxjllX2K+w5c3u3o+BUlZ/b13g7SdPh/U0iABd9erlrnNVvSsnpJE4q/KFV05oNhLfkXroxk
 yA/PJ2eF2aFLEG0Kn4SmOAgaUQ/8pMVIb3Jl38m4DkY/+5DlTVsFBJ/Frp4YmGo+EEjl7COXDoQ
 BrOqFq+OiufaXg==
X-Received: by 2002:a05:6000:481b:b0:487:1251:20fb with SMTP id
 ffacd0b85a97d-48867049f60mr4545566f8f.2.1790173623692; 
 Wed, 23 Sep 2026 07:27:03 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8F45001B67602CEDBE732F.dsl.pool.telekom.hu.
 [2001:4c4e:1b8f:4500:1b67:602c:edbe:732f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c64dsm7388874f8f.21.2026.09.23.07.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:27:03 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] accel/rocket: add devfreq support
Date: Wed, 23 Sep 2026 16:26:24 +0200
Message-ID: <20260923142624.15791-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arPLjz0fP_b5dseJ@rock-5b-plus>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <20260922080114.44662-10-royalnet026@gmail.com>
 <arPLjz0fP_b5dseJ@rock-5b-plus>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Sidong,

On Wed, Sep 23, 2026 at 10:14:51PM +0900, Sidong Yang wrote:
> IMHO, handling rocket_devfreq_init() error as critical error to disable core is
> too much. How about just printing error for user?

Thanks for reading this far into it. Agreed: rocket_devfreq_init() runs
from the probe of the core that binds last, which need not be the core
the devfreq device hangs off, so a failure there takes down one NPU core
while the remaining cores keep running without devfreq anyway. panfrost,
lima and panthor do fail their probe at this point, but there it is the
whole device; msm_devfreq_init() only logs, as you suggest.

v3 will warn and carry on without devfreq. On that path the driver will
hold no OPP table, no OPP configuration and no runtime PM references,
the same as a board that describes no OPP table.

-EPROBE_DEFER stays fatal: npu-supply is first requested there, through
dev_pm_opp_set_config(), and swallowing a deferral would leave the board
without frequency scaling for good.

All of this is from reading the code; nothing was run for this mail.

Igor
