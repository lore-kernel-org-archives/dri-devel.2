Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC9EFA1FD6
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E267898A4;
	Wed, 22 Apr 2026 16:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="BUdKMY4U";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3770610EA73
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:29:31 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-50fae4d1f85so36694191cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1776875370; x=1777480170; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h9IY/0ZHCf/patsFxziV9u+pjgUJWDhTV7Q7rdgygPM=;
 b=BUdKMY4UsJZk0si0qL/LC4IXVM1wCEexcXdLeRikQsyy/lqVIkPAUoHs/zMboNzGNq
 Sk768Ct1duSBSsFPZKKq96PshaGHLoGFsyO+jo1Ohw/6m5iAENDFyPneL+o4NKdFWN2I
 jyS0elB86Ra/3VSR4WDLxQAMx6zfbrg+S1E3ERGa/4HMAwzyVbLzwNi1rK1UI+j+LaOf
 LPCx9uDXHUo5ocLsRQ7jSKObKiQWpe/TnafC6pBUR4uDdplzMYDjXg0+BgROOqLLRYIq
 5qJDMNIHjqvOVYj9nAESKmt0cl6wUVEXXGDdXbjzoSwj0Yto1o26Wao4PtU7DJ4V4Ik4
 H9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776875370; x=1777480170;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9IY/0ZHCf/patsFxziV9u+pjgUJWDhTV7Q7rdgygPM=;
 b=rz/x2mrFQg48p0FANzV4HVoY7khg8k2Bqrhvx+ihdFrVrZ1xg2ykUO3nxW+2ebyTM5
 v/5wVvcFHIz3uB1ey0HAVYl9I5VxVojxC+jE0KzyEegqIbnUwkFvdRcMA9MYv/b7Cob3
 WGNazVOei2awnxscRs6n7T0wLqc0WmQFQrE8sUvR5Vxh9jtIS3dGbgG+2CCE1aPQBAQH
 5UbyWFc+NfiLrlXu2ydvgQRPEOA6Ax4nlBXaJjN3lFlhq269ukb9XGxgF9IXo2mSlxN2
 bPxO76qQqKHnSkm+IT4gqwPRfImtqfqQp5dU3GvskZn6o+5UU9D1aVinojCrCHog1Ghf
 k5Cw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RyUkDqHAkRB5fck/ca6D1pxwmk6E84UqzvoDevVF73mmMhvxXn0VQ+gmr75nd6Pb07C/lb5Fhnzo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAA3bRoaasxy4A85Tyil01Sje4j5ywjFiLVdeTnzN2itn5/3RY
 fkR9Ch8eszCfCkv3ONPnaMD8+5SXNaApNmHtmlrTF9LbDEw2onAtpoQxHSxrY15GXWA=
X-Gm-Gg: AeBDieuCQ7qbDtfOEwrlmTXGT65CnWOPb8rBosuQNOsTLAO0bj+cBwQzAOS6AGGwP4b
 Z4KhNyUrpVfq7GC4rl0ms0IG/+t4KU0J+j1i+2YwgUtREiIC6AZpmjTQCjTgBPgvflrG0telhFr
 juSK0yXWiAapxB1fog/y1YlW3EWH5qwfkTWt/27H+MomqS4QcRPOcvQFK4HtlwBPzzbX0tmYAUR
 FwlFeOuF2PAXfYrcDBinQKMOfAP2JwXVh9Xx+bGl0mOOIhTrYI8/F2cmqY/Pp+QL6SoYY6rjfG2
 EMPHYeWG0IBl58bhx2Hbemo9/2jZVGV4EEb9GCWj62ZckmwY24rCKOqZYY82M+po/STxVVOOYEp
 z7H6Fdu04KVN5ONz+5UCQ0dV/LfSoc9g0WyBc4pE8G9mLuFVGmW5H9/Yn179ZQxZ7N2BqrmKzNn
 seQ8qTP5tJ8RbEOMVu3X4MWRy6SbfFVCRrUbLSTKJEoJfev0ewX6PhXevvgvfOi6WUVo0V7sVTJ
 wA0VGSWM6PLurNa
X-Received: by 2002:ac8:58c6:0:b0:50e:635b:5579 with SMTP id
 d75a77b69052e-50e635b57e4mr184629681cf.19.1776875369960; 
 Wed, 22 Apr 2026 09:29:29 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e5d5ecffdsm83483301cf.29.2026.04.22.09.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 09:29:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wFaS8-00000008cG7-3pDK;
 Wed, 22 Apr 2026 13:29:28 -0300
Date: Wed, 22 Apr 2026 13:29:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260422162928.GL3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422092327.3f629ad6@shazbot.org>
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

On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> In general though, I'm really hoping that someone interested in
> enabling TPH as an interface through vfio actually decides to take
> resource targeting and revocation seriously.  There's no validation of
> the steering tag here relative to what the user has access to and no
> mechanism to revoke those tags if access changes.  In fact, there's not
> even a proposed mechanism allowing the user to derive valid steering
> tags.  Does the user implicitly know the value and the kernel just
> allows it because... yolo? 

This is the steering tag that remote devices will send *INTO* the VFIO
device.

IMHO it is entirely appropriate that the driver controlling the device
decide what tags are sent into it and when, so that's the VFIO
userspace.

There is no concept of access here since the entire device is captured
by VFIO.

If the VFIO device catastrophically malfunctions when receiving
certain steering tags then it is incompatible with VFIO and we should
at least block this new API..

The only requirement is that the device limit the TPH to only the
function that is perceiving them. If a device is really broken and
doesn't meet that then it should be blocked off and it is probably not
safe to be used with VMs at all.

Jason
