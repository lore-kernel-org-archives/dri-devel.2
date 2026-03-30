Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EF0FF60D8
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6680A10E892;
	Tue, 31 Mar 2026 07:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gLMNZx5s";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2023710E7D8
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 21:14:05 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so22622375ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774905245; x=1775510045;
 darn=lists.freedesktop.org; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=itki3S53hN5ghJ+TbLPQdNLhKu/I8y2gwGAHgQqiXFA=;
 b=gLMNZx5shd8k/duNah1l9YsI4/PWueDqPfMxXuEaz49ObDvh0hfg9aXpx1AG29xnq2
 qpjHw2aFgsizUSWyf299rQZJbjVr2QTzm79tXtpvenz8FfpjctEZvDGjrPk2PtH4yBDV
 HW/nU2btCGdvftCBJhOQZQ1HvMITPuctjaAa7aeQILIvh7RFTsgNnaOz6kcPGfQsMKAZ
 ziJq3GEK7c/2kTz9KBRXmdgAwU3N+CvYm1BuueIjVZB9cW4KOrjCp1eWhtBYnniSZ9XG
 pZLd0aSQmKVJzWdBJTVNiJTOZjNmW3n/eqkzZBqb3o0qcaNArXJLetK3S3BjmqeFXXhi
 UbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774905245; x=1775510045;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itki3S53hN5ghJ+TbLPQdNLhKu/I8y2gwGAHgQqiXFA=;
 b=H62xlXXHxg1/7lsgrix3sHdEln3yactIbdHkPqf8efIH2UE6Zk8ODlajqyMo1Bw29I
 0tErDgcmLFcr9iudirZqon/wnXu2ZNHy9yIGA6SycvZJKC0tSOCyeiVqLsinveAb+Fh9
 i1xpnwLaq7j0uVREGDUx91LTEHEdQhzEYE6EvhDt/3a8LHNFuGKmmx6sUfVdiWvK2Dig
 xz39dkYSPlrKLH+rhn0ZSaTq4O+2Ngo2kgg97HLnysBg1ioREx9rqzMgeVYq2mZLgXga
 OgV20ipExmMKJlx/9AmlfTsVDBpv7UvGDcDTD2D6dwrHJZP0+KrlbeaQzIwvDETZt3hu
 8RXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNjWwFJ1SRNRSYS7oAGLvBWF9GwY7kWdeIZG0TEKG1EXbDoSAFkVzzgh3mMEKQ/9wZW2RTWNCM1Ag=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/1MRuL8qms0oY3Js/RnQzTcU3YTHQsTEmDLJaVdIHDJhwMQjM
 Pq8lfOPya3IAE30x2qEy6gddS+yVACc4wIOLOY6DizCqJn3LnKdSHif0vzstZ045xsc=
X-Gm-Gg: ATEYQzwn1D3J7RK8u9AcsKqV81uGgtm3rpVI2TbtHRduNdbMJTAoi2n2Qg5XSTFCKQr
 9zqE8aYJciMKCfIQnkpOzuQoTnBAjsEDRrWRnPJT91HArbtbEnI/aGVWkqF5ApulxzztOVwE+9X
 O0EmPM3NmnWPSQNSuaZtSs0zhKzL7KJSPvST1HnntBboQPgvFOPcrrnSuB3AF950lOtSU9dOAnB
 CCg8OxoLRjB/HTfpuZ9HnvCqXqXloB1BlbUE5iujqYtiy8sIcZ/uwVLCH/vvppE3L8AENb+N6le
 RK4vmleXamLoNK1kF2l5VmbeL0DDhxyEEe8RpIuapbIEapcNMKFHQ5/hE8hI0sU0Um/zJ3Ye3DV
 /93ntQyJ4p/qOUNTtqgs2g1YM1X71q4KJaXdoI+3s7HESsxvxHUDUoM9Rc+8gfOoezaCMSorxrH
 53ALdv8rLln9TNN0WbeII=
X-Received: by 2002:a17:902:d541:b0:2ae:c981:2a29 with SMTP id
 d9443c01a7336-2b0cdbf7bddmr141880015ad.2.1774905245314; 
 Mon, 30 Mar 2026 14:14:05 -0700 (PDT)
Received: from localhost ([97.126.187.42]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242676e13sm93479195ad.28.2026.03.30.14.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 14:14:04 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Bajjuri Praneeth <praneeth@ti.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Louis
 Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: ti: Enable overlays for am335x
 BeagleBoard devicetrees
In-Reply-To: <20260324103934.7d259008@kmaincent-XPS-13-7390>
References: <20260216-feature_bbge-v2-1-22805cfdbf62@bootlin.com>
 <177275924369.1445909.1029086854461649971.b4-ty@baylibre.com>
 <20260324103934.7d259008@kmaincent-XPS-13-7390>
Date: Mon, 30 Mar 2026 14:14:04 -0700
Message-ID: <7h341hvx43.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 31 Mar 2026 07:23:33 +0000
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

Kory Maincent <kory.maincent@bootlin.com> writes:

> Hello Kevin,
>
> On Thu, 05 Mar 2026 17:07:23 -0800
> Kevin Hilman <khilman@baylibre.com> wrote:
>
>> On Mon, 16 Feb 2026 17:55:52 +0100, Kory Maincent (TI) wrote:
>> > Allow overlays to be applied to am335x BeagleBoard boards. This adds
>> > around ~40% to the total size of the DTB files on average.
>> > 
>> >   
>> 
>> Applied, thanks!
>> 
>> [1/3] ARM: dts: ti: Enable overlays for am335x BeagleBoard devicetrees
>>       commit: 18161bb01ede109fed41c66efa2624a4c27377f7
>> 
>> Best regards,
>
> Thanks for merging it.
> I see that you have merged patch 1 and 2 in your for-next branch.
> Is there a reason to not merge the patch 3? Are you waiting for a dts
> maintainer ack?
>
> Maybe I can resend only the 3rd patch to ping the dts maintainers.

Not necessary.  I'm not sure how/why I missed patch 3.  It's now queued
in my tree.

Thanks for letting me know,

Kevin
