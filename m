Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A20C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 00:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D26C310E181;
	Wed, 22 Jul 2026 00:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FxeRpgXw";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F30710E181
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:22:12 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc8so12113440b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784679732; x=1785284532; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6RV+pWPuLrWtGLHPRoHO6UZjcCN7SkNDZVxGG/ZxlKo=;
 b=FxeRpgXwqaXj4qUeixZOHI1+BBmgf27t21vYNe9OCpAEHICu+NH6drLkX+ijKMTU73
 jVHfBx+NbjNzpQdPVc4KtVN6DLnDq6K4Dh2wi2WC7xWnuF2KdyeT+I9+CYk3tlBYmpXb
 PLJfHaYQIP8Lh3Y85MZBjHJxMAKj2l0QAErKimMvzTspekr34XmKlWI65vxOLU1psdNe
 ePf9HGaSmnjLZ6ZgyCMlRlAaG1fNJS9L+2W0ys4xZar5UqgXOC+I7clOQo4xc9L96CjN
 j86BKr9MWZ/jw6paIpnfgxl87T2LkhvvqucOLOlgBzt/6BJneItuLNWQLfS9pgLUogNE
 57hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784679732; x=1785284532;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6RV+pWPuLrWtGLHPRoHO6UZjcCN7SkNDZVxGG/ZxlKo=;
 b=lPdldNImNF7IscSEbtJs2RfFTGwoGkqWqaD0A+DRP6RyIFiMmOLQnfItyiITP1TPg8
 l02MNm4pb8Qac4skW2kTkUMKMjOvBLd9Wh1QwxeKypjSQRCNgdAqJmjZNAGKjNIySazO
 REnTyDObKPyd7kcKuaeHHPeFlSqTqpD5Vb97lbtBs+vxMhece8+JzPss+98Y8wYQ35wQ
 O74SBgk9qt1mXQTPdx+38VCUvwoKQdORBCJbcMBGwMrnd4bgkkIRtUmxy4lNYX0IqcWw
 BaoegJqOx1ONtahoeXLT8E42Hq6SRugPUx9JrfZXmCeW4VUoTtVG8a2C2gAEm1H8Eyci
 hEZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpggRxkYtF/l7v5nPbvbZ4abFLJGw8SyUuRrOKUyZ6lmJ5EiQqzIbWPpa4lS7YzE7anH4YWFbaxJT4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypFYe0VlXpmZOy8xjb+Eha1Z0kX3UcS+pV+iuSz574cbXI8WA2
 O5MvYnkhSLuarfk1k8GQBbaStv4P+VvBCUjYKvsfBF0RKjwCfmI6pnkI
X-Gm-Gg: AR+sD13Le0PcXmTRs+p1pgkiZ1wPo65i84Oq9za3dECNZVyQWIRcT1SNa2TR5FPw3yZ
 TqW+HYG+tUpb3uC2z4j5CJxiCvO+1qjL8mXfaFFUNL31N14Fpvq2XVHnan636lZQYs54A3bkxTc
 QJlNh7XEFEIy8tUA7jFY/BaTggjQIHlxvGqzawtj6EIqkzr7u8EecrYaqdplJ4eScIag7u6r1W1
 Ub7XZ0Yn8wukTxM510bAGgAqOIyAtNRYWw3wlCK5coilOyWl7ENIdg7IqdmMAyuboBg35bt49r2
 avNmo+iVk5pZwoNHQoQSvfvfTA6PG/e3cZCPwgZl3ZYc8F3K8Em9sidYtibKx0q61F7l7eWN5TR
 f5nGIwp8qtguPYWVyWrnD5XG78BhQL8dL838LAYrcH8ynfWO+XJ+EGTypd9LgZihzJd5JcqUt4F
 63yxYTEFPDFTMztY6ZvWCOng==
X-Received: by 2002:a05:6a00:a1b:b0:848:19f4:3b52 with SMTP id
 d2e1a72fcca58-84c294d431cmr20914841b3a.38.1784679731792; 
 Tue, 21 Jul 2026 17:22:11 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:2::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e175b26bbsm406610b3a.46.2026.07.21.17.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 17:22:11 -0700 (PDT)
Date: Tue, 21 Jul 2026 17:22:08 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me,
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
 Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amANME8AVF7GN/ye@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260721110903.34840531@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721110903.34840531@kernel.org>
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

On Tue, Jul 21, 2026 at 11:09:03AM -0700, Jakub Kicinski wrote:
> On Wed, 08 Jul 2026 15:55:06 -0700 Bobby Eshleman wrote:
> > +@ksft_disruptive
> > +def check_rx_large_niov(cfg) -> None:
> > +    """Run the devmem RX test with rx-buf-size = 16 KiB."""
> > +    run_rx_large_niov(cfg)
> 
> Any idea why the devmem tests sprinkle disruptive everywhere?
> Disruptive means we take the link down, I don't think this test 
> does that.
> 

Not sure... I don't think the link is ever taken down. If the worry is
ssh, I think one non-devmem queue is always spared anyway, so ssh should
stay up too, but I haven't tried this out.

I always forget to remove these decorators.

Best,
Bobby
