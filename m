Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFA3CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956F910E401;
	Tue, 13 Oct 2026 19:16:54 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F333F10E401
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 19:16:48 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-6dd7070699eso179788eaf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791919007; x=1792523807;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9LMVzPqyuXj5ApWA2StVi76ci1CLBOXVU23pBi3Y7Tc=;
 b=Tgb+kTD/ezkBdMD/3uGZtzE6KMChAXs1voTL1tsrQJJGaL4AW3KCSM4KejmwNPMbRC
 Oegv19ydkYX+yGswNYvFCKOgGdAm3uhtYjskkql3i6Y+iQaQ7qYpnxazaQrm3BCI8qln
 nJq9YDjWFUzew6zs82gFRNnow6RruSbRfkBSu3Z1uXHRTWtdI6Wqg6gG7s3Hz6gkh6vH
 6y8m6Pu8q91qCbS06q7YYt3AjSEPkrjRiPBQkBoOUIyUiqCQSko1hKvvj1dFXJWgnYgx
 OKA2MUTfC/+ld8kLpV6bRo4CcUkHW8shWgu+Cm9YGO4XtZl8tZqlrmjeDBoX/18Jmp6B
 u33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791919007; x=1792523807;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9LMVzPqyuXj5ApWA2StVi76ci1CLBOXVU23pBi3Y7Tc=;
 b=BTuH4AHRrOMW4WmqqU1tNGIIqJ77wI9Mn3/KM6NGuBeroL88z3UmAmko2ttmDnPm0B
 B3VYI0G8QbxOJqieMumF7Dw5OBs28QnN+uyDLxN0ckd/DNW5iD448BToa6sHTDhSldqx
 88QTOVqOME3e+5WjF0snWkEYQq+FwafIE37ZYTDcHVgDYlVXyFdm31ss9+rafdDh49j0
 wg4qx717fP1QS+um87+C7LebZxVKEh5hxSmlgIB45ZaQmTo6MdgiahJhSUeAWvP1JWDt
 tYYrDw326elG6snUsu+tILS8y07dwA8rT2cEuzl6MQIlWZ1hiAFqLU1/bRMVrQlWhyGz
 +HCA==
X-Forwarded-Encrypted: i=1;
 AKwUvByDfmaeWqmQqnzwQWjBTGSA5/rBMGi5Bah3tLS44KucOu2kszWs7pEVlWSz2ngZVBFHWVvkZjRrhSA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIFfeUdxYxG1+t4yHcOM3fegFmkr6AscgSBy2xfaE1KaAleX9JO
 nN9aaJo9b5Lv/YtWr35LHFW6Xpl46CQaPMvjTRD3pvgtkPnHx/h3oW0QCOzD/ryFENA=
X-Gm-Gg: AYBFou0flp8sBEVrpyS4FtFj2TuQw+Fz8FKcOfzMSvhAPzYy4KI5keKLJVD2YaaYSEy
 d8/UmQhaRHygz6Fb0MxoE5NTjJ5LjIEgukygk+6ofr3hpRcT5uA4FkPFKTkqkSZE/cdpbwc6DKb
 FnrIu58M7ji+mrQj65p2dpzva70iR3Ws0zfvDuxp+hBR3m5IlyF00SG0CNqjAV0iB1L0k6UjmlM
 BblrUWU55WtlVkcB8pf90T+bimh+diPNsb8WatiXIMmGBUu2W/dvw/u7veOc7sV9aF7dlVVDMz8
 Ufc+lfo5bP+E4mql1K2ZW3hFPZdeWAMN0o7r9resAf6hqNsPjkw+D0gmTrnTya7NXRRlt9eXSGA
 cZdpIOsK//rlCgwKu4EV6xpv/yZNq75FuronWWfloArlExdmAHSTQvRHL6xoM/HefqAi0ATolkK
 eX3rN+rFwzRWGIGeLJkrhs3gV/dfUQpjstjJQuq4kmY7GC8ugmfP10RrXUxyk4GxmJjb84gRXX1
 QgVGcs96e5mHcvsOOHOLmr/nskXagjmBYNKQrSgqm2WvYa3FXNfAz/1+g==
X-Received: by 2002:a05:6820:c8f:b0:6e2:2dcf:2cd4 with SMTP id
 006d021491bc7-6ef0eec73fdmr9825677eaf.16.1791919007140; 
 Tue, 13 Oct 2026 12:16:47 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ef023a1c1dsm12597782eaf.10.2026.10.13.12.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 12:16:46 -0700 (PDT)
Message-ID: <baae166a-4464-4065-a642-348034cda28a@kernel.dk>
Date: Tue, 13 Oct 2026 13:16:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>
Cc: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
 <20261013141046.GA12680@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261013141046.GA12680@lst.de>
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

On 10/13/26 8:10 AM, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
>> I've queued this series up for some testing, in a separate branch. JFYI.
> 
> More testing it obviously good.  I've been waiting for addressing
> of the Sashiko comments on the nvme patches before doing more ACKs,
> and while I can't really judge the code those in the dma-buf code
> also look somewhat serious.  So it would be useful to get them addressed
> and the series reposted.  Same for folding in the PI vs dmabuf fix
> from Anuj, although making the combination work would of course be
> even better.

Agree on both of those (sashiko and folding the PI fix), but it's been
forever and let's at least get some testing done. As mentioned, it's in
a separate branch, easy to update. But if we were to have any hope of
making 7.4 and also not missing yet another release, then it would
basically have to happen asap.

-- 
Jens Axboe
