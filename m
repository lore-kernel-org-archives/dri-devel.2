Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2310107637D
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0A310EDD3;
	Wed,  1 Apr 2026 14:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="J4Ev+OP0";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A52A10ED7D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 14:18:11 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-6501e465a8eso1504396d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775053090; cv=none;
 d=google.com; s=arc-20240605;
 b=Yw+JcAIu6ZZzO9d9yBWjkNxlDRbSSLK5BV4tFxYQk62H9IK80yPdrvToCHdm+uzsbf
 7cBIGxeXhsSXkMIdvzDmAL0kn7ZDZcktgYf/0Si+Kb6fXk5pf06Zf1X3WxDYiRBcsxX+
 8w7Bl++swtvAC2rc9IZ9vUEEdjFQRKb6Mx5DAm4XQUrcwM99pQh6luagh0bcotM+zifF
 KhJa+J9+EGUoPKn5CC8cal5nXRHwNaQz33cDrDT6Y5+w1daeiG8Zoo+NMQOlZn76K0Gg
 3ncQuCdfATNKpB3KKDT1NZhwWXdZoXZNuSweHQvtPJsLipBAJ5CKzNShfQaB9Rnt20VK
 LUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S8Tzy9p65X+mMpYvFYQPPcRz7RB7Jp7ad2p90YGsMbw=;
 fh=7p9MVdKLBmvX6eraUoUISFlLzs77ObtG5/uxT9VBpT0=;
 b=JkXOUnXc75KGc/x8s/DXTTDLmvyPGKmf7dUl1LU2DdF/STJdqICKWSfqhqAYydC++z
 EUfWA7+vx4QTlAIuNZwPXjp402ALPVnQb8VHNuvHbFORzTNnjbBgK53KDcaaR/GhAVbf
 n0i7f7cO+MCYE5GecabtMTjyglkXoM7bTocZcWYpYJl633IXEh5YerInGKpGG4X6NDG1
 W8TBcZIpxAZjLUycEbkl53rvC6X3mO8wSPfaY9ScQpqD1VGR5uR8YNMAfARCKIcDDR+0
 V5VdMTLUUeUSWYSdAIUmd552nZn3zvw/eUK7F88vK0YtDWFpgKICn5nZesDgUSZ8oz/J
 MKUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1775053090; x=1775657890;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8Tzy9p65X+mMpYvFYQPPcRz7RB7Jp7ad2p90YGsMbw=;
 b=J4Ev+OP0vQD5sQTHTbC7JDxR/qgDIb7I+jHaq42sgAr3GHwwBPzufJM7id8MiNecDi
 61D1/up/BltwTGsvUOUTffRWIhXGWbgaTGkpUS5Fd7cb9ywfTgsVG2WbU1oAVg77zhvJ
 PuRyvyNrrYnYP8W4CR3my9OkrhbuTQ5pS5A5RuoLc9nhMkN/kzCwaXJ71raRAkessgoE
 8YZ1iuqSKjV3dvBY6yUCINX/TjXdKmF24WuBqDBBUvzXGjQIN7aLSEoq5XaQbwZYCCou
 /GDnYNUfFInj2Fdz6wzBzj1i1bIUz93e3hH7Kbhvt8m/QxBNHkKj7O1pol+hd0FfpLiq
 oCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775053090; x=1775657890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S8Tzy9p65X+mMpYvFYQPPcRz7RB7Jp7ad2p90YGsMbw=;
 b=eQlYGcc2LgtiP8WuoWW37Bdzwba5ASAfKVrmhn1/SmQ+PM5ZLSPE/7qimB8oRr2Xec
 pSkP47GwzJgUyKVkwvLs94TxakzOqgccCU1eRC3PKzDJCX8Ui1dM7fDxV2pmG/Zax/NX
 54+vODWDe7gOCNJqddoVme6vr63x02N0hUrA6Kws1dL9CpxMoYPn7o8yZ4EeLj+EU9Jy
 82FrBgN8e0aB8jA5UN2b8i8XNJPDP8nV1DEXJ9jMf0TKOmeDeNjmkEyv1OKK2HO9QAf4
 +XUlUtqr7WzzIlE7WuO+RRvGL7Fbkk0drI4zttGlWi92jq7sFtfnCzjH5X/dWR/ud0wI
 YzNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgM7+hZXUCvPr9RIhD3e1NDi6lVU42a/syE/A4zLTzDh2uJVNqJpMYeuEKWS+QfeqxfRqJoCfOkZk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziaiCiwajRpr6DtO+Hw0ZWVcnBbPoTLDukerevQuGAfujwR5XJ
 crjga6ddcWPDmcruwNzCxxjuuK8LdicbAt7MO/yZ65ghls4gJ1EFNe7hiVVhxOVunQAZYtG29Mf
 lSOg5ZiWtXAI2/KPC5KFmboOsCFDXR4ZUF4+Uh3MFWg==
X-Gm-Gg: ATEYQzx7QsyjV3s8moRxt0FbpR0JMt3e7IjeB6WlIbOKB+ns+h6ChhW+p+5lh/+5xSB
 I/3lwDKhMwfRjnVZ2bO655LcWIjTJOZGNXhhQlQmvhOLH3iKob1uESw7EnEDDMwbt6S4r/CNLf1
 TQQtFCn53Mdnpmp8sTrH2ssCYFTFwjGDRnKgXlAD/1NoaO415/Rz8AYafGTwqpgIX/v/vECtXM3
 RhDG2rRMG+sFeXD+B0DFCT+HyHOhYBDqkASYByVQVN+iwWaBfA3eLPH5jgtOiTAKIroWV8SZqGr
 mlENgV97bbsJvWs=
X-Received: by 2002:a53:e312:0:b0:64e:ef3b:3bd8 with SMTP id
 956f58d0204a3-65026785cffmr6540304d50.25.1775053090128; Wed, 01 Apr 2026
 07:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <5416161.aeNJFYEL58@workhorse>
 <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
 <9d525fe4-b091-4cd9-b977-de19ffe4b957@amd.com>
 <20260331155028.71246d7a@fluorite>
 <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
 <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
 <ac0kP-SWXrBwrN5C@intel.com>
In-Reply-To: <ac0kP-SWXrBwrN5C@intel.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 1 Apr 2026 15:17:57 +0100
X-Gm-Features: AQROBzD4B_Lr6xyBp4FYMWC4emgyzUnkdo4rM9x9i8ve778cUGxmkNRuKAQF9Bo
Message-ID: <CAPj87rNfJCCUFYqD+p6OM5XDE8CA75anmA7+ezrCTSZXBSDgTQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 1 Apr 2026 at 14:58, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
> I've been musing about userspace being able to provide some kind of
> relative quality weights for each output. The driver could then use
> those to figure out how to balance the final bpc and compression
> between the outputs. Something like this would let userspace express
> its preference while still allowing the driver to decide how to
> actually get there.
>
> Simple 'desired bpc' seem somewhat insufficient because I would
> imagine userspace just sets that to max for everything at the start,
> so the driver might not be able to tell which outputs can be degraded
> harder than others.
>
> I suppose a desired+min bpc might work, but would potentially force
> userspace to tweak the parameters in some semi random fashion and
> try again if the end result isn't appealing. And exactly what to
> tweak is really hard for userspace to figure out since it has no
> idea of the possibly complex internal/tbt/mst topologies, power
> costs, etc.

I agree with everything you've written, apart from 'I would imagine
userspace just sets that to max for everything at the start'.

I've taken it as axiomatic that all of these things should have an
'auto' value, and have it as their default setting. Userspace _may_
know better than the IHV, but it's only going to know on a situational
basis.

Compositors blindly setting random tuneables to MAX_AWESOME_POWER
would be just as stupid as distros shipping ye olde Option
"AGPFastWrite" and Option "AGPMode" "8" by default. I'd expect any
userspace which blindly did that to immediately get as many bug
reports as they have users, and for them to fix it accordingly.

By analogy, we allow userspace to ignore EDID and set whatever cool
awesome mode it wants to. But it doesn't do that unless it has a very
very good reason to override the driver, and 99 times out of 100, that
reason is 'the user has figured out that this is required'.

Does that help?

Cheers,
Daniel
