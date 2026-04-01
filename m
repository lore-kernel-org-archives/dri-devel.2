Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FBAD3515E
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D33810E9E3;
	Wed,  1 Apr 2026 08:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="k/7yP6sm";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C6610EA06
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:40:28 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-50335b926c2so54192991cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 01:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775032827; cv=none;
 d=google.com; s=arc-20240605;
 b=bAY3ZUPsKLCq29dFvW6h6e1kSyoSGzBHDIlFkqqh2vanzmBzGeqEM+qgdid7ncO7UN
 Fcd1jZzuxILPfVwoCRLOYF275c05HNK8UZK9ae6sS3tTpV2GZZE+dGW0NTuS2uP+45wa
 chW5dYydS/lEbmio+jPKuem1aBHKBO4PdXZLeWsddtzhuRfNDQQo6f0vXmlIEpY4AvPB
 zWq+Jm1RYmC4UF4h31DDwTzeu/0/f3TIELA6n+eyW77YnYHUoxyKJ3cUrSt3GRPk3diW
 E4k9CFP9taOTFublJgpAcesxvl+LxpujkgJVJZqaDWyhXldWWHV2LFrPsiKAa4I3h2tR
 Ajog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KVkWfYwigbSi5JawcIs2zqvmQDqD12f5F9gL5XSu3Zs=;
 fh=FPbwkQu0wdYJZ8833FhJe7YguUlm5MMH6WzCNGW0LUE=;
 b=P9JXjhUqwLGQncBHAKDJN/tShnu/k4eqY3SCG655hMSpIGT0AE5DEGnGYuEXDI5igQ
 T9CAAWNzJyr68tzIZbSi5pWH6EXxydkcZRkgGXAvT7yDueimjc6FYXHbTywSOIGs1O7B
 oIQg8HjvANXSUFMQsxi14+0QGbOfDIUIRW0fdkrLzLiWl2HAQNIAhIO9P3z5JDhtV2pX
 rcFVlh6Z6ffig2SmrAJuToINK3YV5+8QR06FpShCn9IzhrUxrGCaVaK2TIu8fRNIlEla
 no//OGnPCKY1P21w9qXFIL1uPHBUZLN8xK3ebnqekbqMAm19zYlE5h2EwsE/VpOR28l0
 F5hw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1775032827; x=1775637627;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KVkWfYwigbSi5JawcIs2zqvmQDqD12f5F9gL5XSu3Zs=;
 b=k/7yP6smEJO5CTO8ueC9esUTldgJR8zUQzOuvXveEkcSbhKszTldHTVxczfu6l/ExE
 6B3D31tALOKnbB8DRr0V4O/XxYpP2wS+Kg8V1dZoqsI20BUNsxczSAbE15CupRdZD2Pp
 nr6I8Rg5kOShXRJKR3ZeoQu4PDyHNQlJMvzk3a7abQqJbVEGI4XG2JrYXkEUOaT/bV0x
 DccglVZ21zG/dhV5+34WkmIiGDYsCzSJuC9v1JhyZAc1ql6IKe8uco9JG4YnNSe++LIA
 J5VUF0fcTVrGzDYe0noUxLg9WmDHc/s1HdBcb/ITSoMzWIHsgEKuSF1fU+7Vzg8i0lik
 QhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775032827; x=1775637627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVkWfYwigbSi5JawcIs2zqvmQDqD12f5F9gL5XSu3Zs=;
 b=DNCY5gPCgOq5ybQ7jC5obN5juSi42Ilx4jc4zuCbp04r9/ndrDf4fzfGX+ujWNYcAa
 Ncm/Gd99e3lYc3iSHiD303X7Odfns5vUxJmGptMdHdFPGG9p0ogqx7+d7hMVR2ELkaHJ
 RGx2bBAYZybW8mscaPoQALnJDzhWlG7MOh2HNMCOYhBuLi3gekurDpcnZNE1vGaIb+ut
 v9q6TNlihbjPva2KD7oXpdAwuoRt3F162HvfAWg2ITMvoVpc3rPxQgR0RWLuhj4lzPI7
 X50CzDV+W930UpiB8gSZfZImAU3qRuS/X2+EOeXxWeHefAxXZbdsYgrU1HvDbn+ctcU2
 oDDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaMAnIwesSA8/t5P0RmkkVkH9k6KpwnIFXoMaXBUWVnAk5bmRNToXkXuT0GmkHJK/j3cCmOixdnLg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuAEI7/R3d7Q+RrbSI13y3NJnLjVxDebchbNStatavuVHPNDPk
 3jiWkZsHCW6LINuZ0EwGbN8KkVzJbdYUlaHhf/YABYk/Gvz21Z9FUmob216105qRT+LQgSQO88d
 z/SYQO79zbAGbmcmtCsB4f8RolvBR9L6ptXesY0WjtQ==
X-Gm-Gg: ATEYQzy+Iw3bJw0++zvChW44TqMuMwYkYVbrSW2eAHj8dH0ANtWx+la74MCh30XylHu
 ZAD8Kh9WdMY6a36nJRM2mMvMSnw4UNtT1w28q/9Vt5f2VbEuLR2tXxavDnP+gxjkvf8atBDyTgi
 kUMLgfOJFI3s6xTKAUxjbI8sY6uE3Wdu32M5ggB0yz4OHTh2TjueGLYEGr0iBSF+1O28Chx7SZq
 5eLJFcC+w7/DZwyC+suX64BP2/vw7pUA2KenyBSqTM+mhSitr9XWiA5g5MiXyVBBzMrVEaj5ewo
 QZkdv/hJUCPk7ekyR0vWlkIEbAzkkHuv/AlEKuIsAQ==
X-Received: by 2002:a05:622a:1f0b:b0:50b:444c:e268 with SMTP id
 d75a77b69052e-50d3bc0fdc0mr37850221cf.19.1775032827063; Wed, 01 Apr 2026
 01:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <5416161.aeNJFYEL58@workhorse>
 <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
 <9d525fe4-b091-4cd9-b977-de19ffe4b957@amd.com>
 <20260331155028.71246d7a@fluorite>
 <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
In-Reply-To: <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 1 Apr 2026 09:40:15 +0100
X-Gm-Features: AQROBzB1PHiXawIDg-k-EvjY_Ig5CvrhgA9fAjKFUy7Kp_xFd8_Bve5qhcz-7W4
Message-ID: <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Harry Wentland <harry.wentland@amd.com>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Harry,

On Tue, 31 Mar 2026 at 18:47, Harry Wentland <harry.wentland@amd.com> wrote:
> On 2026-03-31 08:50, Pekka Paalanen wrote:
> > People who care about the picture quality down to these levels will
> > likely want to know and learn about these techniques. They may also
> > want to explicitly control them.
> >
> > In time, when these have been used enough in the wild, compositor
> > developers will learn what makes a difference and what does not, so
> > they will adjust their reporting to end users. The most important thing
> > for the kernel is it offer an unambiguous and stable UAPI for these.
> >
> > Policy belongs in userspace.
>
> I don't like this as a blanket statement. There is a lot of policy that
> intersects with HW nuances, whether it comes to power or otherwise.
> Taking away driver vendor's abilities to optimize will hurt the Linux
> ecosystem in the long run.
>
> IMO this needs to be evaluated on a case by case basis. There are
> many places where it does make sense to give userspace a greater
> say on policy, but we don't want to push driver (HW specific) logic
> up into userspace.

It's not something that's _just_ specific to a particular
display-controller manufacturer or a particular IP generation though.
It very much depends on the usecase.

If you have a laptop and you're trying to give a presentation,
applying dithering and/or DSC makes a lot of sense: you don't want
your battery to die, and the projector's probably going to obliterate
half the colour anyway, so might as well as go for the most efficient
thing.

If your laptop is plugged into your big display at home to write code,
applying DSC to cram the highest possible resolution + refresh in
would make sense. But if dithering only results in a marginal power
saving, and your laptop is charging anyway - why bother degrading
visual acuity?

If you're a media player, then you're in a good position to know what
would be good to go over the wire, because you know (& are possibly in
control of) the format over what comes in in the first place.

But everyone's tradeoffs are different, which is why sometimes the
best choice is to ultimately leave it up to the user. If you dig into
any media playback device (STBs running Android TV, Apple TV, Fire TV,
et al), you'll see that all of them ultimately allow overrides for bpc
/ colour model / subsampling / etc. Those aren't just there for fun,
but because they are usable to real people, and it's not possible for
Amlogic or MediaTek or Rockchip or whoever to statically decide that a
certain configuration is going to be best everywhere.

Right now we have drivers making magic per-vendor/SKU decisions,
without even so much as a feedback mechanism to userspace (unless you
count debugfs, maybe) so it can even figure out what's going on, let
alone control it. To properly support some of those usecases,
userspace needs to be able to control what goes out on the wire, but
as a first step, it just wants to be informed of what the driver even
did with the properties we gave it.

The end game of this isn't Weston logging something to stdout, it's to
surface things to userspace so it can guide the kernel into making a
good decision for usecases that may not be ones the silicon vendor
decided was 'probably the best thing' however many years ago.

Cheers,
Daniel
