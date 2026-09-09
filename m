Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86845C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C655410E1D9;
	Wed,  9 Sep 2026 15:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="31sVd3lT";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736DB10E1C8;
 Wed,  9 Sep 2026 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=4jGEiWuc3LNhn0aOVdAeuDAY3lihVYe3loGnLwhG5ig=; b=31sVd3lTXwmDP95C/LYFKf+7tj
 NoGRXuYEaeQCfG2DjsdWcv1/bc/Rxt1IKSMZg4cGFbTfUjLkI89TCkq2acz0oe310Zx0n9GOmyDC5
 IE9fq8qTbUNoZpIBpcHA6vNJX4X9nk7/kS6f8Oxw6rQVGqJswkHxwwsC3r+HMVGKi0qQ3TcXk71rn
 gv417w+Ue5sCPiGxo9qylUkqB4+Ni7Ip3Di4xynh9bl+BoPHl/QE97rn2LIH3geyzwGG4/2PCjGjR
 Dt6k3e8eBQAlxGqhFT1ENF4P86rly7jJNEYkDr3VREuh6V6n3EiqbnX9osqA7KvP3zlhjS0VBLduG
 Je3u5++A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x4KQN-0000000CCjG-11zN; Wed, 09 Sep 2026 15:41:23 +0000
Message-ID: <84851571-6fdb-4a23-9ff7-8e36de16a435@infradead.org>
Date: Wed, 9 Sep 2026 08:41:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation nova: Fix bracket
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260909135319.1364776-3-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260909135319.1364776-3-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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



On 9/9/26 6:53 AM, Manuel Ebner wrote:
> Add missing ')'.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.
 
> ---
>  Documentation/gpu/nova/core/todo.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
> index d5130b2b0..a01c362b1 100644
> --- a/Documentation/gpu/nova/core/todo.rst
> +++ b/Documentation/gpu/nova/core/todo.rst
> @@ -33,7 +33,7 @@ A good example from nova-core would be the ``Chipset`` enum type, which defines
>  the value ``AD102``. When probing the GPU the value ``0x192`` can be read from a
>  certain register indication the chipset AD102. Hence, the enum value ``AD102``
>  should be derived from the number ``0x192``. Currently, nova-core uses a custom
> -implementation (``Chipset::from_u32`` for this.
> +implementation (``Chipset::from_u32``) for this.
>  
>  Instead, it would be desirable to have something like the ``FromPrimitive``
>  trait [1] from the num crate.

-- 
~Randy
