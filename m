Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD273C98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6850710EBDE;
	Tue, 22 Sep 2026 08:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WE8+jNFk";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A79A10E73F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:10:55 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so3276589a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 23:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790057455; x=1790662255; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=918Ed3YoBXTCboO/8XC40Sz5nROxBXuKCN2wfNcGPBs=;
 b=WE8+jNFkx+vL2sawebIFdvUEAKPykwkJOH0A0TyICR3BlryE04nVdJ5h2vBtOeq6jK
 rqoDz6SErUCi+cDdB130DCcLGc3ZFZ/HaXSoDG59JKy5cTYRzgk8LB4NW22PPY0URb9N
 cG0x1Smmykp/Mxh6N/E89WezFYk28Q17sfBEy8lIJ7tUb+QtQrW88/nE7e7/KzzcOXrO
 rSTE2EFipu11NtASJDfgMDU3aIVuLfFD4EcklII3xpq6wmX7Wy0rS0d72aW1qurCys3y
 hz7PuUAnZRT6DW2FCpGFGEhce/eeZSoDUQSO5l4MWEGgnIYzeIUQEOCqnpbV6l6x1I5s
 LTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790057455; x=1790662255;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=918Ed3YoBXTCboO/8XC40Sz5nROxBXuKCN2wfNcGPBs=;
 b=rhnzuH8PWU+rkUvjVRSkEghlrfWEmdU8md+dH86LeUknJgOks177AaIInvHJA/GG2v
 noxDifLO9cirnD6VEI29Nwdeu3ubVgntZaXA4APWu6H/J5v1TB7rVOaRq3f16Jxg7kwJ
 Ai2LHcG4AuJ/9CNFo1dCuwhbkGiMAAy5dSdtmUDkON4Wn6H75cAuz/+dRq6Oxphn6b1O
 r9NBV5VT7cX0S2eIYu7MeKZD0fpcwm7Q2D+bQpSN5+qzpufU6j0Vw5v+haxzuSqUYbuX
 UMACx4BqCm1v7PMRcxh66Ezq8EiM061iSg4ubIp0R3rvRYBvwzx4H1yQXcDk1iOfVMYV
 QkfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaeHnq7SXvPQ472q4PvSSAUgCyFhGpSYtjtYsTtlv33Vslcj6SVeFeBvc2ukLboFiOb79ulWTg6qk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ktu5uB5NTx1sEIMe2Nm/lamK/ejKxQE6apZe/VZ55iPIFQtrnK
 mber+CY1cJHuJYqOVWf6d/kJoK5wg0YL337XGD6ddxYaeekbqlykBWaz
X-Gm-Gg: AYBFou38+8DEqxo/4W/pFYdLjmo5GymBWERtTKbM07KTOPk50OzWcI/wdik2UU3SkzV
 ESQSN3lvGzUb8RAK0Wd+K5xUYiU+zIio83h5eD24kN9E68gFYPYe+HKXNry2od26zVoSnZI09JU
 ktu1Z7BpFFjHocblLkIWz47i/6pZskWEgZh7r4mKBK164bh8/Crt6yezlMjvfJ514AXVg9aWu4/
 VDviMIBa2oYZVJ1/gfYlYaa3q+NHc3mpg5zRdjuZouiRgRirjDRs8XFUrbxWWOinoTj6SKJYlyF
 6fJNG9ggUUhLNZOasMNwRA3/gRtgiSOlAcAnmUv7StJxMbAYsfzSdYshuA8XKpUejjdq3yHo5ux
 3/nJW3fKz4/3Uonwu+kc50L5SHUFvvM6Lerfp0eVm0PhEJ3kyaGXPK1rTDOrzIZKiH/79nzlB27
 c1Dnu6n80+Im+H0jN/vo3xj9jh5Fw5Z9CXmXDlJvKSSv+nrbPnvt9l5lRDcPp09efvfIXFcsY=
X-Received: by 2002:a17:90b:5105:b0:39d:f731:e5f3 with SMTP id
 98e67ed59e1d1-3a073116712mr140073a91.24.1790057454636; 
 Mon, 21 Sep 2026 23:10:54 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a06e5a5eb4sm1489775a91.14.2026.09.21.23.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 23:10:54 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:10:01 +0800
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
Message-ID: <arIZX-0aMQiabxJd@inochi.infowork>
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-2-inochiama@gmail.com>
 <2026092256-shading-gratify-835a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026092256-shading-gratify-835a@gregkh>
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

On Tue, Sep 22, 2026 at 07:35:19AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 22, 2026 at 10:47:16AM +0800, Inochi Amaoto wrote:
> > Currently, the phy subsystem uses ENOSYS for dummy blob functions,
> > it does not reflect the function state correctly. As kernel already
> > has EOPNOTSUPP for disabled blob function, replace ENOSYS with
> > EOPNOTSUPP for a clear return value.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  include/linux/phy/phy.h | 52 ++++++++++++++++++++---------------------
> >  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> Based on the other patches in this series, this patch now breaks the
> users, right?  Shouldn't this all happen at once?
> 
> thanks,
> 
> greg k-h

It will break, and the change should happen at one. But I think
the affect should be limited as it only affect a special edge
case: build kernel with CONFIG_GENERIC_PHY disabled. So the
break should be limited.

IIRC I was told to seperate the patch into small part so each
maintainer can take its own. Is it fine to squash these patches
into one in this a case?

Regards,
Inochi



