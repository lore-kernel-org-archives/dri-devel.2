Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCA1CD5BC9
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 00:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA80E10EAEB;
	Thu, 28 May 2026 00:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qhXAyl5L";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30F710EAEB
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 00:14:53 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8b6ea7716bfso141096906d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 17:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779927293; cv=none;
 d=google.com; s=arc-20240605;
 b=jbfPP0vv80bH8uGC4HSQ/f0rkiYeUCTKAWi4QGw/vO752J6/EcZwGbZ2d5JLVXgN85
 jmUDYoUrAgrNzquS1/Lpza8UMfRTnPQ1LZl7N/vGrsdQJqZgIJSuVsmFP1Ht4iuxRxpx
 cOJtQQZPFaoAuAfprxuMUPcRGlIC++ybubCmEy4pDq4Gd9/8+1XGBE+HzbOMDb0KmrgF
 NJ3LpBp3La3aJVWHM3lLvzdWhp3zV6mEAXq4gumf0KfjO61usZO6YgQUPDfr6FvgT6AY
 28yZPozRV/qoZnFRAc5j3OLyPPOhxmKjMsx8Fc7quYPsIBAG23YWHLaaieR8yAj1ZUss
 vT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=YkAOyvRcCZrD3CFNxtgiJ2Kh+LuBHct+Djf8lzySZrc=;
 fh=vjEaXlvmSpoTiXVcUyrMooVXrhx4wr+FUsROyT9pr+k=;
 b=BryyvBEKRlNp+DgxYF4zTtx4vb3ny4Omj6RlUhCTd6+2PqJo2RZVXPFWc3Gl4WtqjQ
 pgHD97SvfbFP45UmzIcIYSczlsMwiIzn12r00P1CTcL3UJoZUTiGzH5385NoToth3gGM
 gA3rhSz8rZ8YJJfK5JbClXOBlp+xdpB8JssHNS2O9hYG8rfkE0EukkRZOsjSYvN1KG+S
 IHoXEq5QEaZgu/QI4tDDsyDWjE278NIqxBXs5Jsv9lAGQez6+aNq6Ko602lhqB9aZQ8v
 mRXlu22qmOOdzqM3P7b7mfN9VywA6h+XrgXqCkZDvE90lc7+YvzdFeWRAp1kaNVLriDQ
 vjzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779927293; x=1780532093; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YkAOyvRcCZrD3CFNxtgiJ2Kh+LuBHct+Djf8lzySZrc=;
 b=qhXAyl5LsGV2p5gDlcoiiftllu5s7ToGFKixLM1wvqNPm6PpXScaadXBn/c+SPRnNJ
 UKdNNRaOI7Ryu9DudOeDDea26NiQZnmNfmfxpaQTeJXA5HafVfllDNCA4xZXEvWXlrWD
 MB8w09RqvGlTAQAT1EuloZMLBu1H9lBfEWGegA7yDikqjtIkOYyxDyaOxmHiskXYagGA
 zMHgWsveGxXE8TFcHoyMaSRvGgNOJJk7215K9X0vX1dDbpZStvvsW8iQLxxQGP06Lpcy
 /Xja44ousmGNGU4fn817W2jiGiXOFO7H76gKZbxLQsQbl5PO+7CKO8X6Ou+pz4LF0ynm
 GXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779927293; x=1780532093;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YkAOyvRcCZrD3CFNxtgiJ2Kh+LuBHct+Djf8lzySZrc=;
 b=T6IOUZKeZH/Cx09qAbPiawS1m5SpPtz3ZdZoZJJ+OYOHxwE/o+ywKOo2EFE8ll+oge
 kuvVq8qEk2RgRBrmesYkNgHBGma01DtuHY8WeD3wIy+XSUDaJxvZNTJI2NsUKJR15KC/
 FqcQgZFknKkTcj+roOz2uuNIoLLE3riQ4Dc5S5evvTm5C5K9W9U3fZDl7/auDNUPBH4f
 XorZmzM3FARO9G4hl6CI2K+9xFi5qh/sfpGe6vBJM0QdcEUndP2hJGvsWaImhynJne85
 x7qezktdfnBhHeZnCHiOge9dtRLrMFRiXPxAmNSH/F/FQSUCxTB8iQvYrKVqY+uP7Vgm
 Ee2w==
X-Gm-Message-State: AOJu0YziqUSRI6ktXngTnrNHQbr+o2b8JhhdlOKMXh1DHUVT5pwY0H2k
 0UzKt6kuxrIHFyR9Ic5uLupEqxiTWwm1JF5ma/y+5lQpEREeZ2w/GyI8AYApatxuQUM480nWSkN
 1gMBl+7rfNDwWafZRRKFRKv5Vd/jek+/RS24x2hw=
X-Gm-Gg: Acq92OEeefnWQqNVdzf91UEay+mtXN2RvQaAumgGaoiwtXvxumQ9Jei7ZXYAjgOi6YN
 C2eOA6cQvNm+YngfOPqf/5P3oF50y4ZOtwjzgcdCyJeBIZcYPW2H7841Ni7u8XceA/tfntrX69N
 JH1P5Y/qHZd4P62ZqVfCdnET8CND7IxPe79uZ55OS4uUoOwevCFVgyXYBen673EVm/3gHBcjphB
 tX0Iae8wvJaZ2faCozmNDUPFeFRKX4uQJ5tSxelE4GVGiOm45b47z205HiuzkVKx/pNork5Vcgg
 GJYG5xJKavYVFhuK0yupS1THTl78d1vow87VqVV0akaJRJFC1Hz4qpYuoqCxZ4d3DEl8OsZlsaI
 eig==
X-Received: by 2002:a05:6214:c21:b0:8b2:8b6:4bcf with SMTP id
 6a1803df08f44-8cc7b56e9f3mr419582576d6.0.1779927292594; Wed, 27 May 2026
 17:14:52 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 28 May 2026 10:14:41 +1000
X-Gm-Features: AVHnY4K6z7osgdIqYc9Bv8ilBWhwZWsA4-VyvDp9QuRXta5p-tt5gNZDfewq07M
Message-ID: <CAPM=9tyvm1jAX5udJ8OU+39XzwZRATjjhHAWDn7kJug+NZKBuA@mail.gmail.com>
Subject: turning on sashiko.dev for dri-devel
To: dri-devel <dri-devel@lists.freedesktop.org>,
 Simona Vetter <simona@ffwll.ch>, Roman Gushchin <roman.gushchin@linux.dev>
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

Hey,

Just want to give a heads-up that I intend to ask Roman to enable
sashiko.dev AI patch review to be enabled for dri-devel in a week.
Will request it replies to the list at for a trial period I think it
balances time wasted best, but also allows people won't don't want to
see the AI reviews to just bin it on their end in their mail filters.

I also encourage the development of drm subsystem rules either via
documentation updates or review prompts,
https://github.com/masoncl/review-prompts

There has been some recent discussion
https://lwn.net/Articles/1073583/ about merging the review prompts to
the kernel or providing them as documentation.

Dave.
