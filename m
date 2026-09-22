Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7280C98306
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0D010EBE5;
	Tue, 22 Sep 2026 08:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m/CY/Q/A";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A7910E7BE
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:37:31 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2db18fe459dso22319395ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 23:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790059051; x=1790663851; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cEZ6qIPBqK0kKyvC4PAdXp1jfvwWUdlhUlYS77zPoh4=;
 b=m/CY/Q/AMad7hUb95myx7wlEa2aqXqoYaweHqtYfOdj1ucmnZyWYBwYykqbqBWWIzR
 VsuTOJQ0ybozlFJHd6Nm9k1WoxV/JmqLxq/zgTSGL3RCj6/YS9hh/XrTN+9nRou03r3I
 tXxPM7q0RI13D/2SJUI9XJmuOy3bw+x1TvzDOU1/8sCpuf8VUIqpiPe7v2Jocfz9kozd
 vKc0b3OpvF+u/WZfID19tBJhnondC7z7CkYxrzToW7qdwt37fh0dQXRo6SDDtFNC14Yv
 zggsSW+ATLlN/MK6TuN5o/06aC88wzR/m8RsbZdp4VKdsWj9RH36EJwaPEtOGSQZJqjf
 Foog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790059051; x=1790663851;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cEZ6qIPBqK0kKyvC4PAdXp1jfvwWUdlhUlYS77zPoh4=;
 b=OVTutsNWxPgU+KTQU5IViQdYysucxOe25NC8LIWCyZU0+BsIAAhXjWf3uuWHbFJxUN
 e4C6V8IWs4p0d82mjpW/5UosZyPbSNyDO3f0kqTduvmyCgsgd18VgXaD97Mp+jcNsJSy
 HwRGuHX8gbuMdjb0ByoG0bwW+bo+Pfsb9oDKL99qIg2zm0iUCp8vWJIIqrwzjqCC/Wlq
 +TsaBkVvGCaydiKmI5upg2QIrV6joRIZUwsYKtgilA0ORnk/uJ/J079HhuHr+rymePYC
 fSww3xr+BeuQbo6ciMot5vxAB5XkFQmGz73/sLeXQgNEq01+vANL2sFZxVXKdlKiss5b
 v8hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWw5LwwMNxEqfKOcrqbVt4okN371INmdmR8lO4i0k8bz5TGzIEW+v1UtyVp/T5U/MsDsM0sWoSN2g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mXsmw1u5iV6QWsEthwY7g5Ij9UU24Ms1F1OGa/AVZrsblvsQlA
 8CJl8QAB+ZtFsvdpLMjBArjVouaHWvdVGue2Wu8zi96xYMqTjWazlMIE
X-Gm-Gg: AYBFou3NjoIOLPCSNUFok+Gw+15sZHbrLTbNKTZkze0iJxfxBK8KXIsPR6cIWsiv6ts
 mRLTB/OVfydE8nwEv8aeyhJQh7IaRfXyrqBqC/JQbILNXIO1Fp7v0bV4baT6a1GR+Z7ilTxWPez
 zMYBlRB5iZE+DnGCAfSmFNGbvP5SIK2iDdZESakvG6vO/egknzyvvkwZpDen7HxKBEYpdkBSxys
 WUK4OQisT9QC38AMFkhjTUP0KlK85jpPINr7/9GV/AgcA0UkYsqfikyoBLBPxrXz/f42txpVV2B
 Hz3FjdMZ9Myh4VxwMRyQdh7XPxtWS3zpPCq9mgbv3uiD2l2OobFFEfhEcbBF0gD0EOmf2j/Sfgm
 0F/MczJH0ocBq5X5DcoK/tuiAxO0eBzbcn34FI1CM3z52k4vRFR9PbA64hNdnUqT9qPMUXdB38K
 DK5bc//oS8Xhkbt3ccxEd/fsttAyKJkFtkhip236Po1glq4Xv7K2DD6RQJakpXq15mDFrU
X-Received: by 2002:a17:903:ad0:b0:2d8:d4d3:3fbb with SMTP id
 d9443c01a7336-2df609d1990mr2155125ad.15.1790059050558; 
 Mon, 21 Sep 2026 23:37:30 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d056911sm4297115ad.70.2026.09.21.23.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 23:37:30 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:36:37 +0800
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
Subject: Re: [RFC PATCH 1/5] phy: core: Use EOPNOTSUPP for disabled blob
 return value
Message-ID: <arIgfDh6ZSHNgbhB@inochi.infowork>
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-2-inochiama@gmail.com>
 <2026092256-shading-gratify-835a@gregkh>
 <arIZX-0aMQiabxJd@inochi.infowork>
 <2026092236-breeze-educator-0f6b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026092236-breeze-educator-0f6b@gregkh>
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

On Tue, Sep 22, 2026 at 08:16:16AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 22, 2026 at 02:10:01PM +0800, Inochi Amaoto wrote:
> > On Tue, Sep 22, 2026 at 07:35:19AM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Sep 22, 2026 at 10:47:16AM +0800, Inochi Amaoto wrote:
> > > > Currently, the phy subsystem uses ENOSYS for dummy blob functions,
> > > > it does not reflect the function state correctly. As kernel already
> > > > has EOPNOTSUPP for disabled blob function, replace ENOSYS with
> > > > EOPNOTSUPP for a clear return value.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > ---
> > > >  include/linux/phy/phy.h | 52 ++++++++++++++++++++---------------------
> > > >  1 file changed, 26 insertions(+), 26 deletions(-)
> > > 
> > > Based on the other patches in this series, this patch now breaks the
> > > users, right?  Shouldn't this all happen at once?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > It will break, and the change should happen at one. But I think
> > the affect should be limited as it only affect a special edge
> > case: build kernel with CONFIG_GENERIC_PHY disabled. So the
> > break should be limited.
> > 
> > IIRC I was told to seperate the patch into small part so each
> > maintainer can take its own. Is it fine to squash these patches
> > into one in this a case?
> 
> You can't break bisection of the tree, so if it all has to happen in one
> commit, that's required.
> 

Good to know, I will squash them.

> But really, why is this needed at all?  Who will benefit from this
> change?
> 

This change make the phy subsystem aligned with other subsystem like 
clk, reset... they both use -EOPNOTSUPP. After checking the comment 
in errno.h. I think this is more clear to provide the information 
about unsupported function.

The related discussion is at 
https://lore.kernel.org/linux-phy/20260907114837.2y55l7dfqqrgcka2@skbuf/
After some discussion, Vladimir think it is possible to go, so I
send this patch as an improvement.

Regards,
Inochi
