Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E08C79F8B
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 03:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8219110E277;
	Sun,  6 Sep 2026 03:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P2/tdRj+";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE4710E277
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 03:52:47 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6a6868f18aeso3422419a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 20:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1788666765; x=1789271565;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fSerb53rcqZbsooBPLkO5s2hB/Spl+K+lkIDPV42RAs=;
 b=P2/tdRj+XRqlfZM86jZhKyNO+SXC4bgTWZGNrYB74VFOsqxCRYozaV2IAODUFd85ye
 KnVU4V1nYGTmlifiAfIKJNeTLGCnq6q+yaUZY+MM231hZbquYDdXpl3qamHq9l7BL1aZ
 X2+aFmdShhjq31G95VyrgkSSI4o0XKhARGClM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788666765; x=1789271565;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fSerb53rcqZbsooBPLkO5s2hB/Spl+K+lkIDPV42RAs=;
 b=rj5bND7NygVlBrkldYtAYCR5btgy0wSbL4487dHGURWdcj4+fWxD2H+SYODef9UQdS
 484fSgDySENrLO/e9//0n86fbfLWUAynoUPxcRF53PMhNYxkwH3qw67GsYjRWQtMMWdV
 PCIx3L86ZOK7S1rHarJhEGNrVsdyNRNQKmr2Gj998j6/hziUSztSdlgNVq4pMMpFeGGL
 1JXKCZT+cJ7dL00bchQakf3PiSQ4SWpUvZgNy0BTR4IZjYFL2IXJWO0petdnZWXjXnOr
 Cp1E2gsuy2CPAm0RMhjY+upP7JpfHRK1a7wePLVDNgAFTylEc7nk6Md6rfWiDk+sTqjC
 qGgA==
X-Forwarded-Encrypted: i=1;
 AKwUvByJaiZ3dFcURu3aamos1RLXgXk6bkOrZn88VYq3CBt0uqQ3kHiYv/tDjcgFg8KlRjWuWqRXCYvfhMw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m0+xr5u5d6O8we7kqte5wC32+FZxwZTYZskkgeeqbXTd4xxXSK
 ecNuec1XNpb9AzuQE2NNUq+EEbFtO1U14QlLkM3FX3R6oGnVPs1i+jUgFXlqje9rKwqBh1N8Qw1
 vN4DR4sA=
X-Gm-Gg: AYBFou2IkKPv5m0cT1RaCGNZVLfwZRnp9UvAKYr/chFZv4uoXeO9p15FmGJHrsr81YO
 l2ZvqN2nrDH0BXOhZsSHiU8VQ054oXra5tyUT+Twm7OkouSxZzCntARuSUBSgL0CmOpffVt079N
 z5trK8MmtEXZ4YAsVUBQYHh3EO3x5r2oNQdojaquvxuz8dNuQWBuJBBAy/05zUdCc3jyfYaZqey
 m5aGJtcrBe//KcINhkXpaNVWY6UC8Elh5Q0ByXGKgHhMZKWvIFeXU7xHFiISmK5UVhbz0u+k8XC
 Ec64qe/NRXjTwWoySmPejyR17wyVuEV87s+T0kNW3GS9XEbQNSUV9U0FD/TWGZU9Egn1kC9KGeP
 Q2cA6mfxvpHoTjJU60oqBz1jInHNR7jhi9gUrwh3v8smleVrL0TK0H827mOxYvgRfgTHrnU5NRJ
 aFzqjhxBWO5z/vPKUShqexPa7DLg/eX97K+7nrwQFy2rxBMGNWJOW0vtjpcdAO7hsnCby90LXK9
 jzdhhrc9aGOfCHoFSMYiyWX5JDGXefLnJ8EIsAreyhP4c5E
X-Received: by 2002:a05:6402:3552:b0:6a7:ee55:dcd6 with SMTP id
 4fb4d7f45d1cf-6a7ee55dd7emr4314796a12.37.1788666765386; 
 Sat, 05 Sep 2026 20:52:45 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com.
 [209.85.218.45]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a7e68e8f2fsm3267736a12.19.2026.09.05.20.52.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2026 20:52:45 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so386485866b.2
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 20:52:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBx95cy1sCTAVJqu3OdJtcEd6YNUC9uxDHijgawyykDvQXAJwOvK3r7sgXDWRqMq8MongXNwhuHKKZA=@lists.freedesktop.org
X-Received: by 2002:a17:907:6092:b0:c25:64ea:4d70 with SMTP id
 a640c23a62f3a-c260c65c251mr611771966b.1.1788666764559; Sat, 05 Sep 2026
 20:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <202609042302.CE61BD262@keescook>
In-Reply-To: <202609042302.CE61BD262@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Sep 2026 20:52:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2B4maExxSmm6eO1aw9VGyK=Twswwb63Fdm6=KiOZbTw@mail.gmail.com>
X-Gm-Features: AcwNN1Vk3nfrsHDG-4r0mHaxhZr_TrvzmLKY7OvoNGt6cIy4utAnm2ONKUn-ouA
Message-ID: <CAHk-=wg2B4maExxSmm6eO1aw9VGyK=Twswwb63Fdm6=KiOZbTw@mail.gmail.com>
Subject: Re: [GIT PULL] kmalloc_obj() conversions for v7.3-rc2
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Kees Cook <kees+treewide@kernel.org>, Manuel Ebner <manuelebnerli@mailbox.org>
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

On Fri, 4 Sept 2026 at 23:13, Kees Cook <kees@kernel.org> wrote:
>
> If this is too late in the cycle, no worries, I'll wait and do it in the
> second week of the v7.4 merge window for its -rc1.

Ok, I waffled a bit about this, but I suspect this kind of thing works
best early in the release cycle, but after -rc1.

So I'd rather have done it earlier this week, but "this week" is
probably still better than "next merge window".

So I've pulled it,

               Linus
