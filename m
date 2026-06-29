Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274EBC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0F110E775;
	Mon, 29 Jun 2026 08:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Usy8cPf5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B614C10E775
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782723371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oovJIoNGk4eGagKRDaw9pqXMujhus9ut370XvRbtgL4=;
 b=Usy8cPf5mnughhfCezGqQY3Dq9LzsWfMjzdhKlSqyZspYbFYbM4ZZeH7dJLqUY2857WSUo
 vHhuENyJPCPHsLZCSS3XTmcLfhzciMzgZNWxR715VRNUJ4tUw3Pz8WrrBRshklUMi0ljRY
 BRdrtRfokEJXM4yjOH/r0/LoNoaHFME=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-4epiRB7yM3Gk1_Alzawblw-1; Mon, 29 Jun 2026 04:56:09 -0400
X-MC-Unique: 4epiRB7yM3Gk1_Alzawblw-1
X-Mimecast-MFC-AGG-ID: 4epiRB7yM3Gk1_Alzawblw_1782723368
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45f3d008865so2360512f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 01:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782723368; x=1783328168;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oovJIoNGk4eGagKRDaw9pqXMujhus9ut370XvRbtgL4=;
 b=m7MQWVjwbkfJ4pMlf4bH7d08RLrAV64SrQU2Da/bKqwpTNfeEEMPKP/jpGR4rCRjQs
 NCznr5PlU8Z6ix/FdpjSQJrn7uYD96cbHxttAsZVUzbMaASoFp+v7/Ys5Y+wouFOeLIb
 Kaib7+tZXmch+Mtjcg/pQ7QoUG7duO/2jYnLZYF6RPtU8IcvSgLwE/MOtCFJYcx2zSXb
 d3rLsHdjc/rY+COHKvg+911v8NTfQHtT6bUrN3wKwYeMYGnYutqHfgGVVHlFo7qvvIiA
 x8jDKkxtZDrQfqPLMD29Y/Vtc6FG3vjY9cApAdEll0rZ87Sdp2/FnOPBeiQPynhqcHqY
 tWkA==
X-Gm-Message-State: AOJu0YwUr728X57BnC8J+ZlOAKQVWOwXj8KoigtJojtyPSwHJUsAHq8G
 2I3YZH0M5c3cZcgeRZ2Ddy/E7kA8LuGl7REXfgAxSGttUyZKcC68kRcc8zr4sdh9CNhNjFe+TdU
 2iGMwlMQRbuKSWIna4ldQFTm9aQk9l+nd5EujdKcV1Lnp101nqFlb4+TRYfRFFLXWnG059g==
X-Gm-Gg: AfdE7cnzoFyRFjDouWoLpYmNGRjQTdVDiHUSwZA8cSyMuGTdhSh1A2JvRlWidNcWJdh
 Zr0y4vpZryi2MaJR2nb+hD+5yvNU3JumtJWWzudKHJ0GTz8iO+3DgZg4tID1XZh+iON8Fe60nav
 ZjjikA8z+8Cbc4lybAV+TNw7VsfpAKU165etPzkSPUib2NxO0n0q9IIsj/nTlzDhMESprIvm2B0
 4B906ybRPnErm3csBSQR3LzuKaoyTQI4kjcGmdXvO/4khg4y+pb24ZgcKGFeKgzVnlCW5949rP+
 9RFhZN6lt2x1DO/f9/7XWiB3MMt8BFaPA4oftyR+bP0BypX3qNoHFFNo3e+CJDkPw8A5Tias8cf
 m7WFCQiez4hCXXpccL/JGAA7LSLv8gCg9GLf1UQ0LSPiAWI5n1rMjB1AWcUQ5lmTG7F2hfA==
X-Received: by 2002:a05:6000:46c8:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-46a7efb7522mr27270412f8f.12.1782723368319; 
 Mon, 29 Jun 2026 01:56:08 -0700 (PDT)
X-Received: by 2002:a05:6000:46c8:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-46a7efb7522mr27270397f8f.12.1782723367842; 
 Mon, 29 Jun 2026 01:56:07 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4726b76e6f8sm17377098f8f.13.2026.06.29.01.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:56:07 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 1/3] drm/ssd130x: fix column and row end address in
 partial updates for ssd132x
In-Reply-To: <20260629084317.10265-1-amit.barzilai22@gmail.com>
References: <20260629084317.10265-1-amit.barzilai22@gmail.com>
Date: Mon, 29 Jun 2026 10:56:06 +0200
Message-ID: <87mrwdd8t5.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eAE_3Y1YQXAlAS1vPBAcaBf2WRbn2IInYkO9A5Kf-rA_1782723368
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

Thank for your patches.

> On Mon, Jun 22, 2026 at 12:36:30PM +0000, sashiko-bot@kernel.org wrote:
>> Pre-existing issues:
>> - [High] Potential 1-byte out-of-bounds read past the heap buffer in
>>   `ssd132x_update_rect` when device width is configured to an odd value.
>
> As stated in the review, this is a pre-existing issue and is not touched by
> this series, which only corrects the SET_COL_RANGE/SET_ROW_RANGE end
> addresses sent to the controller.
>
> Gentle ping on the series -- it's been about a week with no comments. Is
> there anything you'd like changed for it to be picked up? Happy to spin a
> v2 if needed.
>

Sorry, I was on PTO and couldn't take a look to your series. I plan to do
it this week.

One question, though. How did you find these issues and came up with the
fixes ?

It was just reading the code and the datasheets or were the issues (and
fixes?) identified by an LLM? If the latter, then you need to add an
Assisted-by tag to your pa+tches.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

