Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA58606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgUAK6c3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC38510E884;
	Sat, 14 Nov 2026 15:09:22 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9707910E884
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 15:09:16 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-36e99cf7bb3so2587681eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 07:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794668956; x=1795273756; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LIozortPxX9/yGgYF5RVAdU5h+CP6K/5KZOyPsSClnQ=;
 b=wgUAK6c35ob08k0ay/e5ftzgDX1CUi+S8MQUIKiYxo307JsihWkEO1q35IbSAtpuGu
 lgGwL7Lq+fKU4IDC1op65olF+exTYOnOUlMl5qkHjaYQ6mJFn1nf+YD6hpsyiFkUbt9T
 OdwnlFK/DglAthiVOvSBi/InWfoA2gwi9NVa7Bckwi+AC0PcyIQ32wnFhgzylJaowedJ
 6wVTULZ1kL7l0oL9wjgILek3KNsjLA6rAMe3KriUsv9QtI/AWFkgyPmQPa+pRKTItKBF
 kSmEVkSHrApk5qq1kfsNGkoDRZEjpLlci2OOYVx8zs3JyN7UDFuyvp/d9TuRALtjGqWk
 xBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794668956; x=1795273756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LIozortPxX9/yGgYF5RVAdU5h+CP6K/5KZOyPsSClnQ=;
 b=J7ZAuYwCQwsIkg+oJvhKtMkBo/TG0LPYbehpUbZxbRK45R3oEUS9b8razvwsO+ptzi
 FDxtSClmI0uZbeSsmlxsB7jWcTmD42xwcW1djN2kAA477yCjjwzXWUdBq1euDi/0tpVJ
 Yqc7UEINGt1GNFn7J4ps5CJQKIXHKNNoRlMthWJhBnIy34rOaMxAfmuQrRPdO+F4tEzB
 n3jCXt40s50WzWHFhUOqLE8ge+qVqdwBiVskgmShMSDJGXlozRxaGLyt8pO0wYOG/Tu1
 DSaU2OUheGxFfPbiL/Ov8a/FWlA9InEUkHObxnaAom4uAqlUoCtRkuYQ9b+69ZJ4Jcgh
 0Wkg==
X-Forwarded-Encrypted: i=1;
 AL+hErG9QRQJmgcKJwaR8IJS/bNLYMW1oRx9dVjYzIkBNFERw6+K+4eZJIrK/AkkmVi0ZPZJ9Hb8heauJPw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+UV4srvjE/o1/MVEY5ND0HTPM6qRy4vZ4y0ZPYdjYBHNlHPuqw
 Sf5OPG/00uVanZusZrTROvEzgqNl9SXlAauWZ0cci296RoDRvOJ4fbs5
X-Gm-Gg: AYBFou2NYxer5bepdoxLdaL+p0piceSD5dXS8AwoDpQ46zeYexsDPd+GW9wCwEeRVrE
 AWg22Yg57n5E7TMMillgl05Dh31zr6gNWJtr5gsICRL4K6bYREhQvgKmKpOas3d6UjmnalzdQN6
 NammKctZ73dCyvW6o5ctJkL/VaMy0VBMkN1cUl3kpsNVk5jm33z935LRthcOHqtGqJT+GK+MrZ1
 Ef00CbRt1dqYEcM7ukL+4ZsIq/gGVb4NpmpFdIjWuYeD8+D7YyPyjvEjd79q6m9JQbZi+oD5rK1
 xY4K4HfBbWKU0ExtMwRwcOg/QT73DhPErnOLImj+1LVYNO/4flof507zgGlHc4JWQuvfY/lg6wo
 hmD3vHvrQpjDIthXc12Up8NtRqZJpUOeVZuNjO0r9diIXUjX8Mjdr9k8qNjQe8pCk5jjpL8lpjd
 Cp08SwbLFp82FbsTfM2XnfGvLl4oiuugtJFAtlkccWX5i4iM0RL2VVlPw7yldWTcj69AHMvP3zT
 oaZu3KBk9p+S0BfaRCGtyqPGb58OnY/why7hYINnEtpBeV/l/Wfiw6dWvaLAnLUcuNYh08uG620
 jv+VPPHxdAjACRSTOQO9z4xjVg==
X-Received: by 2002:a05:7300:cc9c:b0:371:5cb0:4929 with SMTP id
 5a478bee46e88-37967dd4c20mr5561636eec.25.1794668955716; 
 Sat, 14 Nov 2026 07:09:15 -0800 (PST)
Received: from arch.localdomain ([2409:8a2b:a08:f11::1003])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm30427886eec.21.2026.11.14.07.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 07:09:15 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: luca.ceresoli@bootlin.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, damon.ding@rock-chips.com,
 dri-devel@lists.freedesktop.org, heiko@sntech.de, jernej.skrabec@gmail.com,
 jerrysteve1101@gmail.com, jonas@kwiboo.se,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v3] drm/bridge: analogix_dp: use devm_phy_optional_get()
 for the DP PHY
Date: Sat, 14 Nov 2026 23:09:07 +0800
Message-ID: <20261114150907.305160-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <DMU749TMB523.3OCGPYVI4NZDU@bootlin.com>
References: <DMU749TMB523.3OCGPYVI4NZDU@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Luca,

> Hello,
> 
> On Fri Nov 13, 2026 at 2:12 PM CET, Jun Yan wrote:
> > Hi Damon,
> >
> >> You are right, this is really a valid concern.
> >>
> >> If CONFIG_GENERIC_PHY is disabled, the old code could still proceed and
> >> keep the driver probing, while the new version would return an error
> >> directly.
> >
> > -ENOSYS can only come from the !CONFIG_GENERIC_PHY stubs in
> > include/linux/phy/phy.h; the real implementation in drivers/phy/phy-core.=
> c
> > never returns it. And the stub for the optional variant returns NULL, not
> > -ENOSYS:
> >
> >     static inline struct phy *devm_phy_optional_get(struct device *dev,
> >                                                     const char *string)
> >     {
> >             return NULL;
> >     }
> >
> > So with CONFIG_GENERIC_PHY disabled the PHY is still treated as absent
> > (NULL), exactly as the old -ENOSYS branch did. With CONFIG_GENERIC_PHY
> > enabled, -ENOSYS cannot occur, devm_phy_optional_get() turns -ENODEV into
> > NULL, and any other error is still propagated - same as the open-coded
> > check.
> >
> >> It should be better to keep the -ENOSYS handling to preserve the
> >> original behavior.
> >
> > Overall the behaviour is unchanged in both configurations, so no separate
> > handling is needed.
> 
> Thanks for the analysis! Cna you send a v4 with that explained in the
> commit message, possibly in a more concise way, maybe with bullets for the
> various CONFIG_GENERIC_PHY on/off cases or so, for readability?
> 

Yes, I'll send a v4.

> Reading it now, this v3 commit message kind of said the same things. but it
> misled both me and Damon, so it's worth a clear explanation.
> 
> Thanks!
> 
> Luca

Thanks,
Jun

