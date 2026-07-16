Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09095C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114BA10E32C;
	Thu, 16 Jul 2026 14:47:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZuALOWyR";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FE210E32C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:47:10 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-92e50979c71so655412085a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1784213230; x=1784818030; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qeHYNuBQJ85xO4pHC/1GrXrbttQdCZhEoDnW/IVqBNU=;
 b=ZuALOWyR7pB593A3v0TpJeokpHEXTslYM13XNVJLJGxPULttujvO66r7IpjVBEXk2w
 BMqLxkUB5zS1DoxcPlQlb9YfFtwdTyA+oBvaQ90k/7trHKl7RegxJtrp7dIJnlbyeCH1
 PfNPuepic+xeGvF7OHN01RmynIkXeAlfVgHIit5im/o6uJiStuIMP84hSGjPcyNEFbak
 ek2Se/lr9P9k3gq/3/wwjLAf0k7wG+2j8d0tFBdr2Ms0c8H6GFjYFqQAcMHliCzAEGJC
 tkQU/wL/WOTkB6P5UlOP+oYHeIX2MLMg+Etyc6CLMmpvogmeaCtA1Lk7KUjRshd6HGj4
 YnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784213230; x=1784818030;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qeHYNuBQJ85xO4pHC/1GrXrbttQdCZhEoDnW/IVqBNU=;
 b=Sx8r43TSapCmFWtO6Bla4/G0XyJLAEgA3elQAELvCmrNJV/+4hi86CCZeUU0q86Svk
 x/3M0QT45XaGBsk/FMaNkHqpQWkmB9eDviVAZ3VsP4InTPWHlNJhfG4doXcQIAJo6neN
 y7jvH8+igH8Q67lW2JcuGg3yYycLkgE3uzey0rOQHT+jY0NYTvdTB75E0OaCKzkvztQr
 VayWdHmMPhRfMyC0mnuZ7LSFyxGMQvOh3XAmvmJctH0KHohtDfhtYpScUFU3f/RBWpj5
 sHaqmITpqzDZG6kAj64EOyu4Emf5ZLkZqVtq2MwJSnOedxaxmQyyypNcv+3qtFEmF22L
 nd0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6+MjKnjQ8PhONdNoByH50QIL3FFMhKZ7hX68OQWgr5EMM7+5clEj5+bQb4epguFIWLCtbFzZG4U8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcVtiWjtRKAMamD4bB7CCSFqCtvAUEW3KdL7cPfiXnDMSkwHAg
 Ba4FHOBeMFsXmyOBIq9W3QlDm5LYeWgngBU/e64gzk0EL6ekraRYlikdTbdC1cPMqEI=
X-Gm-Gg: AfdE7cmoPGvzTxb7X53B4QLyyJSSxXZItNpggNjSitx42X7LhfutbnxozPDCHmAChhU
 0pNPtiykzzmEo9bKOxEzuI0arLKhqwB8d8MOgMZHWPADHkF8tMK2TsI3YEa1TQ5DQdKIMZa9iAT
 CBfFPzvqyqJlgaVS2HU7BSyPzECwAayDep1QUbRV6SSHHEkQUg2P4D6tKvbaUngBAhLGJIFy+Nj
 7HMwU3JPcbhVkau1SYxUgUSvKMlqIVKqQX/Hafvw8nN6qznsj+xeWv7viayCUoKLaxgrhwbvwxr
 bh0yejkdSKItmkQTlERxYqGG6IZa4zHvYcswAdhSLQ6Vx++bLjCTfIDWLo6AyIOp9GoFyEJiPlc
 +i7dA2ty03w4bQgzZaiz6mCkxjJWf8FoJIL0ndDuIPQT5ftn9BMsgdO4fW94n/nzC5d2pF4M=
X-Received: by 2002:a05:620a:3952:b0:92e:ee51:e9d5 with SMTP id
 af79cd13be357-9309627ac1bmr854483285a.43.1784213229539; 
 Thu, 16 Jul 2026 07:47:09 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930ada3a1c3sm36671085a.20.2026.07.16.07.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 07:47:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wkNMi-00000002Yhx-0bks;
 Thu, 16 Jul 2026 11:47:08 -0300
Date: Thu, 16 Jul 2026 11:47:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260716144708.GD210048@ziepe.ca>
References: <20260715204008.3911275-1-zhipingz@meta.com>
 <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
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

On Thu, Jul 16, 2026 at 09:07:35AM +0800, fengchengwen wrote:
> Because cross-Root-Port P2P traffic with ST does not affect the host, but
> merely the completer may experience some performance degradation because
> it lacks the TPH hint. In this case, I suggest adding restrictions in the
> uAPI.

I don't think this is complexity is worth doing for something that has
no functional impact.

There is no difference between supplying the TPH and not supplying it,
so may as well supply it.

Jason
