Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C54CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E373F10EF61;
	Wed, 20 May 2026 08:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="clv5UKGK";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6894C10EF61;
 Wed, 20 May 2026 08:13:52 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gL47J5KHPz9v1L;
 Wed, 20 May 2026 10:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779264828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQXDOHc4G7dDQ3kQbTmT21spqpc7LlPAUB+S3ExR0h4=;
 b=clv5UKGKubY2vtMtbud3ZYfrqBJNr87Hwa1wylUBd92LNwEvCBU6e1tOetr8sn8iHHgpjP
 0QgpQDMdE+Nbhx7zYTijf3Ayy1/90aJX4Os8kv88Q+/WVPpozCCY2MMPY9BWifiL4/AWgH
 leboD+Zf7QGE4Vf9X9p4gpBTSnQD3CUVPp0TG5SpxFugxWBszWxPYFyG4jOO4VnQVOoI6G
 QZoj/xqBhSVcB53FhMYLEZysfLSRFQd7MwARa7wRiRmcOtV7QqUC+QuuMAZSNr2q+Hdlw7
 wUy5LXQ4bWur8dtC0QeVuLFyRsBcZ230ta29gNIuOJGV9B4zu4UzfpX0pKZuFg==
Message-ID: <385a4d4f-fe22-41a7-8d4b-4dc6bc9930d3@mailbox.org>
Date: Wed, 20 May 2026 10:13:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 00/12] misc/syncobj: add /dev/syncobj device
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xaver Hugl <xaver.hugl@kde.org>
Cc: Julian Orth <ju.orth@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <c6c91de9-a34b-4b50-a3c1-d42bf7631f8e@amd.com>
 <CAHijbEUzWZC4GAMU6YGV42gOYkrQaMZZPiwS4Erb4H1J-fh_8Q@mail.gmail.com>
 <69dcbcc1-da58-4d34-bfb0-5c8d33b75d59@amd.com>
 <CAHijbEWqc2+kSkk3i_LxB2PQ6XwUetw1UkdUdXJfdv3zgKd1kA@mail.gmail.com>
 <38551bfe-75e1-4978-b57d-adc43cebc85e@amd.com>
 <CAHijbEWHp960qvZFoK7+9ppHAqkAR7=UQhtMUccqWzGd_pFPQA@mail.gmail.com>
 <5ee6d5af-ac48-41d7-a19f-e08a3c5b7d19@amd.com>
 <CAFZQkGwmeipZnvmBkcE7KhvUSMkSE=fzLBZtiMyhv3mM04Vudg@mail.gmail.com>
 <dff60378-4e47-4753-8878-feec6e1c2690@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <dff60378-4e47-4753-8878-feec6e1c2690@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jpk3endswr6szttqjbsbpohbo1sccyz9
X-MBO-RS-ID: 17008d7d8dbc6b85f09
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

On 5/19/26 18:00, Christian König wrote:
> On 5/19/26 17:31, Xaver Hugl wrote:
>> Am Di., 19. Mai 2026 um 15:29 Uhr schrieb Christian König
>> <christian.koenig@amd.com>:
>>>> 1. This series makes the ability to manipulate syncobjs available
>>>> independently of attached hardware.
>>>> 2. It makes it available under a consistent path /dev/syncobj.
>>>
>>> Exactly that is a big no-go. This has to be under /dev/dri.
>> FWIW udmabuf is also under /dev directly, but I don't think any
>> compositor developer would complain about a different path.
>> What are the rules for that? Could this simply be put in /dev/dri/syncobj?
> 
> The syncobj are actually the DRM specific way of doing things. The general kernel wide way is to use sync files (see drivers/dma-buf/sync_file.c).
> 
> But there has already been tons of problems with those sync files. E.g. they doesn't support your use case at all since they don't have wait before submit behavior.
> 
> So there are already ways to do this, but the Linux kernel so far told everybody that this is forbidden. The DRM syncobj wait before signal functionality is much better, but then basically the second try to do this.

I'm not quite sure what you're getting at here, just to be clear though:

While the syncobj Wayland protocol extension supports wait-before-submit behaviour at the Wayland protocol level, it doesn't need or cause wait-before-submit behaviour for DMA fences in the kernel. The usual rules apply to fences attached to syncobj timeline points. The wait-before-submit behaviour at the Wayland protocol level comes from allowing submit before a fence is attached to the acquire timeline point.

(It took me a while to realize this distinction, before which I mistakenly thought the kernel's DMA fence rules would prohibit wait-before-submit behaviour at the Wayland protocol level as well)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
