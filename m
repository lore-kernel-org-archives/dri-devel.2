Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3529C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8FD10EBF0;
	Tue, 22 Sep 2026 08:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MuhqCC1X";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4BC310EB82
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:11:59 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-8631d0023daso2774440b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 23:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790057519; x=1790662319; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KARpXPYlM2wZhUyrKSogeHTLUD5EXLXuvN4rvW+uIK8=;
 b=MuhqCC1Xou350Ei4ThXxoY8vvhl0ZtTG6+vmEa+Yo/SL4WNgVrYadrOLzPUH/ATDum
 fXjqWDp+GGxfQhErM/mcgOuhowB4IqNiq/lsp9f79SBPs8z5zQ5BFyHrFKj2+cYIYMp/
 ZsuWW49e+s/Pf8okoijRb3caM+INhIZyMcmafeYBjrwDhq+wPPTjuOcyuftNE39/bsE+
 APXEgkwAU/2siSrf5nqG3ZAwsmJeCj3ixA/e7zszRePa8SurS4cTwZayPRECbM2tnjax
 VeK+QpPWdFcld8eWzlwq0J1RYVpPsGdkhtTjSAnpUEUuDlMN4Q3lSYbNBn/yl4wyyAFs
 xhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790057519; x=1790662319;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KARpXPYlM2wZhUyrKSogeHTLUD5EXLXuvN4rvW+uIK8=;
 b=cju64Jdz4mv2F9oGFB86OzZBZ/iYHDuwwOtUg2RhlehPA/8g/CDbVV8EwfAJqPpGw5
 jedSvbE25aTFssMzxP+yp8MGEJKMf+kiN3fMvuXkoG6+HJCDwhnMDJDwWIPX7xD908WO
 waPGxrQ3jxs/gZ991w1Ir9vFGVsNfToKuOGDL9NZDYmwxAOZ9vwqXMNEvbflOH50OWgh
 7R4u0noa9ZL0ck+sSB8T97Lc0XmuYmEDax86KHaA8NXLf10VLd/LHlU7vjfyb2ibD4t6
 BV94DSmvr2m3qy0N1yzGElwnfP2/ZDvovO6BdW33Y0zquABkC2kyfYQPc4cZUJyJZuhP
 CpbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2+R0a/zdeX1Arynr/xuyWtDeGCG86xgmEaY275nXm6XlfGM9aQ5Fntev7+bPteYfa3o2JVK1mx1I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQdyVmtxZJqPpGae69/4RdW6CMDxUuRxnJlfrBFF/ztQ1s8QrS
 SXqBTsnZjw2Xy4pCKqOPjSFXQNaoEzRg9MdDpMQgOnI4ELfzHhwglQvQ
X-Gm-Gg: AYBFou2DpLTDTY91lFuMz+AkmCUu8gBGTG4Fvk9nT61Bs4jcKe4NZ9T6XS25xXUB5Me
 QfOflktoScMHCaRsLbHMUeCCEg3mxDoFO6mJ1IFDshQNluXrGfnN0eWKfyssPf9su8fOOygFD5+
 Qd2uhvemTPPzWkFGEFotwm87ARcyz5dldqBnaPSrLXfJGYjY44HNlXXeQsDAArjsb+1VvtSICY/
 T1mDnDGA3otWazapootCsIFgheBtjf+L6Rr9YIjkjxe1+exQYGsQLClNyGt0fqLM+b/G7wSoSA+
 JnaVnDAtQsx84tFW67b2X3L25jzddXZqrFqP56I31GNM7F9rcgF1p2v4kXC4Wn1JDV87n2w/ccP
 f82d2QlSpVc0Ee8tqV+mOedg0qrzDGMJvzvS/PPXTVHAiSddmf9DDk1XrbbPDWOX4aU2AqE50sa
 xQWNvce9aoX6wU+ja/Ln2XKw56gS5X/VrWHir1NNxK5I3pe0+XjiZANK+zEy820rK1Snul
X-Received: by 2002:a05:6a00:844:b0:879:1046:f4a2 with SMTP id
 d2e1a72fcca58-87c83c49a03mr112992b3a.33.1790057519137; 
 Mon, 21 Sep 2026 23:11:59 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87c31ee8a96sm317135b3a.20.2026.09.21.23.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 23:11:58 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:11:06 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Minas Harutyunyan <hminas@synopsys.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
Subject: Re: [RFC PATCH 4/5] usb: dwc3: core: Adapt the return value changed
 for disabled blob
Message-ID: <arIb22v8tjUBpGEn@inochi.infowork>
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-5-inochiama@gmail.com>
 <2026092202-armband-avatar-0dd7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026092202-armband-avatar-0dd7@gregkh>
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

On Tue, Sep 22, 2026 at 07:34:31AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 22, 2026 at 10:47:19AM +0800, Inochi Amaoto wrote:
> > Check EOPNOTSUPP for disabled helper function as the change in phy core.
> 
> That says what, but not why.  And what "as the change" specifically?  Be
> verbose please.
> 
> thanks,
> 
> greg k-h

Thanks for this reminder, I will express this verbosely in the
next version.

Regards,
Inochi
