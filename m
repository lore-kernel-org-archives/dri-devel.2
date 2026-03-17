Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547D0FD8775
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B313F10E42E;
	Tue, 17 Mar 2026 13:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="oKrYnzvP";
	dkim-atps=neutral
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755FE10E056;
 Tue, 17 Mar 2026 13:31:28 +0000 (UTC)
Received: from [192.168.0.32] (unknown [85.156.96.35])
 (Authenticated sender: martin.peres@free.fr)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id F19A913F88F;
 Tue, 17 Mar 2026 14:31:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773754286;
 bh=0pLkDuEPyGkbW23Epy9YpMe2BQ53axealeBhtQc1huA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oKrYnzvPEcaY8OmrqJOuaMMzh4EY+K2LMdV3p5egUigKeqArsuc8l6gxUHUZI8r5E
 3H8p1/Xpg1WhX4ljaI+Y3rexbgfcXkKLr+hTfW8mRU/+g+HXTnrkcBv6aoC8Zji4mp
 V8lHd1e7JlnVy2oClEuu+c23fpiPd6SfqtEXR1BxGpc54TGsTf/E4ubhfoO9ZxSyL8
 0gyH8D6ia0HzWAB/wZX3x55Q7gFPSEghvwUC4qgcVzxT4P+RjbnZFmVUIbezH60+eW
 RrzyJvjZ7RunpU8JpA+xXzm28tUkZp0HtV6skt7TpoZLT9h9QlIK09PRSNEKp1oVQz
 tbbUh5PP0cSpw==
Message-ID: <778d1150-e990-44d3-8797-0b38bc5c7c7a@free.fr>
Date: Tue, 17 Mar 2026 15:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] gpu: nova-drm: rename nova to nova-drm
To: Alexandre Courbot <acourbot@nvidia.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: aliceryhl@google.com, chia7712@gmail.com, dakr@kernel.org,
 dri-devel@lists.freedesktop.org, gary@garyguo.net, jserv@ccns.ncku.edu.tw,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, simona@ffwll.ch
References: <e7539fd5-9a0d-4a06-aa02-ec3dcd235926@nvidia.com>
 <20260317092304.424377-1-yphbchou0911@gmail.com>
 <DH536IWQDX23.22R0P6FT091LH@nvidia.com>
Content-Language: en-US
From: Martin Roukala <martin.peres@free.fr>
In-Reply-To: <DH536IWQDX23.22R0P6FT091LH@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 13:49:27 +0000
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

On 3/17/26 15:20, Alexandre Courbot wrote:
> On Tue Mar 17, 2026 at 6:23 PM JST, Cheng-Yang Chou wrote:
>> Rename the nova-drm driver directory from drivers/gpu/drm/nova/ to
>> drivers/gpu/drm/nova-drm/ and the top-level source file from nova.rs
>> to nova_drm.rs (matching the object name nova_drm.o) to follow the
>> kebab-case naming convention already used by the auxiliary device name.
>>
>> Update MAINTAINERS, Kconfig, and Makefile references accordingly.
>> Update the Kconfig help text to reflect the new module name nova-drm.
>>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1228
>> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>> Changes in v3:
>> - Rename subject line (John Hubbard)
>>
>>   MAINTAINERS                                            | 6 +++---
>>   drivers/gpu/drm/Kconfig                                | 2 +-
>>   drivers/gpu/drm/Makefile                               | 2 +-
>>   drivers/gpu/drm/{nova => nova-drm}/Kconfig             | 2 +-
>>   drivers/gpu/drm/nova-drm/Makefile                      | 3 +++
>>   drivers/gpu/drm/{nova => nova-drm}/driver.rs           | 0
>>   drivers/gpu/drm/{nova => nova-drm}/file.rs             | 0
>>   drivers/gpu/drm/{nova => nova-drm}/gem.rs              | 0
> 
> That `drm/nova-drm` reads a bit awkwardly to me and feels unnecessary.
> Even `tegra-drm` is in `drm/tegra`.

Same opinion here.

Cheers,
Martin (an old nouveau dev)
