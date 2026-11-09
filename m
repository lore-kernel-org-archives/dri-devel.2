Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA642606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sH2YwJQx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B519E10F1CB;
	Mon,  9 Nov 2026 12:04:26 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B668E10F1C9
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:04:16 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-85d363fb73cso377214a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:04:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794225856; cv=none;
 d=google.com; s=arc-20260327;
 b=Il0Ynk8pEECCAc0++ftR8vKsXMO/oRqgYyPJLiDcV4ucdLXtXh+cUN+M0Fh/u5HjFu
 WJkpTowL+a7Z/XXIIXDQHEMrJ0+PF56SWZ/b2fah5yQsPnAQMR16uqfWeLUfEKrh704V
 VtsrEpOdStBngHaotNA5q9uO7/3WrfHUw9C5iQhI09LAoyTghIac7VUBxWISi0dRqMPt
 L4ElQD/pSRAoLelXuQXGep736D+9HPzlAJS8l+f6E6CTE7AMTSdSVxpuxLU2c/ADVrCI
 cija471O8uKFvD4r+R4EJcwIh/vlx61/28ffWoyF7m5g8ycHxdfggtksM/iNaVKauQoE
 2vPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4MXvg5vJ/kEt2tXj6TzaVD4BRpobTl9Uihp8vaVmD94=;
 fh=D42Wl65qZaiKzGAnB1OBOzqHBWWovZD+9BgtUBO4C9U=;
 b=U4wkb7OpFi6T+fsLqk8Rhfyjyii6nquvDlIM7R4JvXMTArXB7GsNek1ScrE8seKYX5
 4XeOgHZs1Lp+hfUH1H5jO8YjVdfsVV7YypHJJjiuhSlG//vVljbeKFIw2LhBfFJTITTR
 Dt3xpmFIzYygRUNnTwlLwBEl22LGHiM8jrRXCPVZqbNXhYlD9kyp5EpWXnGptDPHp5dz
 j3PXnC6m5d7Wcd2hICBssruB8vbAN74WUp8KzzewZXpXXnSE4dPNlZz1loJe+Fw9m4Bs
 qtsGBRJ/BIbYtBBcrpHoPZ6djgp7BNfcO/yCrkaT50Pt2Fw7KhL4XrS7nw3aLOBhBz9A
 ICHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794225856; x=1794830656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4MXvg5vJ/kEt2tXj6TzaVD4BRpobTl9Uihp8vaVmD94=;
 b=sH2YwJQxNYAddbc/0Z4cXPEbYIdMBU4e8hBQP1fUa57kXuV5LbLGLfJ4W2XKK5Xy9G
 kKLHUc1rSMz1S9BaU/PmUKNgDcxFEnhfDU9olHNbO/2eVOG5MEZWjSTUWuBJ5h4B72JE
 X4X5ufne5wZL8bALKUxIhREzV/jB8sOEVs94mvNmQKllcDFKZ3lUbmQ07LLlvetDAe0v
 MwePwWxcGPE20q2KKQb8i5l5JXjebtJ2m601OEZMMJ+0PxsTZWD9KNjABH+nPdkI4xGV
 bNY3fDTdTUHNP7b/2wvDC0rcTSv4dYli15oLNEn42ZxeKWuSeQ2Nh66hypAc40eino8h
 lkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794225856; x=1794830656;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4MXvg5vJ/kEt2tXj6TzaVD4BRpobTl9Uihp8vaVmD94=;
 b=Z4AjqN2jZ2n9wd4TggRjs/SXpdOdIUcf3gySh3CpGzF1+4icCzBkjfzPxFVpDr6up8
 NLDtfPZr53SJ7AAocPWnmE1Ze5rBM4XYV8p3MbbNqe+JwnBccF0iccxU8D2u+Q+KFeZQ
 DdJPOOM2caxlLHds5aQ+R607GR+6pIPzqhwRxUefPUqXcPFT1IWi9UYE6I7Yen3c3cng
 V9UPJ/M4+Nzl5/1g6s/JDtEPNX2RFfVZIFq8TxE26cPns7TgZnD++b4LDmCTa0pXNGzY
 XN08Y+TjSy6XZLRPPHmi1qO/Fw2f34m/SYWXuOge53ZSOWcLzk0RGWxbcKNg8XzqMz3a
 eVjA==
X-Forwarded-Encrypted: i=1;
 AL+hErHykq3txtfVhjoWWjN9TSksuRRukaWPA3ZQx2lBwWPYB5uCg/e7WaSXmldkGVg9Km+WWH32o4hOljE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+mnxnbcp+EYM++7iZVhU3hYCqwnKwzktK6Sp2nCwlCfAcbrtv1
 ftqStnfpCPosnMfH0YV0JImUWJ6Uk8Xe4UmFcaLi8tq5lYALc7DI6u7JR0/k6f9AL80lxukpheP
 0VSPQOsRoOjJDEp2KLh3MlUWNmtQHpbs=
X-Gm-Gg: AYBFou3DDkiPqP6SDpBHaUV7sQUbVSG/pc+LLSsrzNtVZ+tP+gYkr7gCzBB2qPael62
 ZldiHVOX32UZbbf4sCYz3gy02eDKcxLBs5T2B2CDz4hSiJZpUhlyzvIVKHMHZ5XX97IJGhFgoEN
 7+zuCKZzKsA0B9pBHbTi1VR1j//wUos3m41D21kQMIgmKDMHFohRvXyynAYQ5950kvZrDTbDYT3
 VRP1TxhP48sYaMEraV+BgP1IYDFVXOBggZ8EuuoSuL9Qj8rFsFajRp67ewfVWAajP0VmCopGo2e
 zr1AuNjZaDKRv7+Iju4vTZd+gTUo7hGOFDFbt8v95vpDY8Y+ff9r1ZegwSOIfrQ3AZib970a83a
 Cu57tXLtwdbd6Ct4CkWqCgiswWQDTkr1n+2Y=
X-Received: by 2002:a05:6808:199e:b0:4f0:1b0b:4dae with SMTP id
 5614622812f47-568144bbc67mr2733770b6e.20.1794225855707; Mon, 09 Nov 2026
 04:04:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
 <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
 <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
 <CAFGNeajahc1Amwqg_hX43CfcJEq1E0xQK8Grv0sCukjT1TK0bA@mail.gmail.com>
 <f245aa61-ea8c-4d65-8801-f90a492d5dbd@suse.de>
 <CAFGNeagv2Lc0L_4r28k5N7Exh=pkNTESh3agUp+3NkLp0YF8VA@mail.gmail.com>
 <CAFGNeaghfuFwWMetu1D3+bnW++cC3VJo_8YcPZ8ToLO58jxwng@mail.gmail.com>
In-Reply-To: <CAFGNeaghfuFwWMetu1D3+bnW++cC3VJo_8YcPZ8ToLO58jxwng@mail.gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 9 Nov 2026 13:04:04 +0100
X-Gm-Features: AclHuK9jDelAJwncloA3g9Y7Tp49jCg2Ll0Tnkm9szhUCvVsl75UxzO90kp5Xgg
Message-ID: <CAMeQTsb6CESYugWG32JHiNOVVHUUqTY1JdKCCd4Wf0Uf3T9XFw@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Gabriel Gama <operatingsystemsdepression@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 11:47=E2=80=AFAM Gabriel Gama
<operatingsystemsdepression@gmail.com> wrote:
>
> Just a quick follow-up about Mesa, I'm still working on the OpenGL 2.1
> driver along with the kernel changes, hopefully I'll have something
> usable in the next few days.
> Also someone tested my 2D work on a different SGX535 device
> (OpenFrame, Z520), and it seems to work pretty well. Funny enough the
> CPU is still faster at some things like fills and console scrolling
> lol, but for copying framebuffer data the GPU was about 17.7x faster
> than the CPU, a hybrid system would really help.

I once wrote a 2D driver but scrapped it for this very reason, and
later versions of the platform (oaktrail and cedarview) dropped the 2D
engine altogether. So if you decide to go for a hybrid system I would
make the 2D part optional in case you want to support the later stuff.

One more thing that came to mind; IIRC the SGX needs a firmware to be
uploaded. Do you know if this is redistributable or not?

-Patrik

> He put the tests and code here:
> https://github.com/birdslikewires/openframe-kernel/tree/main/experiments/=
gma500-2d-engine
> The Mesa part isn't ready yet, but once it is I'll link it with the
> kernel patches for review.
> Also hopefully Gmail has updated my display name by now, lol, sorry
> for the previous display name.
