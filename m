Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FA606A329
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b9U1Xy+3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B1710EC7C;
	Mon, 26 Oct 2026 08:36:51 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F42810E96F
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:17:00 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6faddda49e7so2282338eaf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792995419; cv=none;
 d=google.com; s=arc-20260327;
 b=qnXIAoO7f2tPMjci9puzAJp+tBvYecGDZJko2q2F2oLrhwpI9vTdkDOqDB1QJFnUay
 8NgAtu0gi+ujTFkyfGtTz9bBeQH3FiMR55IwBxgm/G6ZC8IN/BcfyYxe4A/aQoctzCl4
 ZwwD2KHBfDlNVoIq0XMa3UOR3ahXLVhdWAhvdYhZ3+QZSDAoEymkwsUgp/J0nK+6JtjD
 piVmSM50Fd6lVZNcKsi6dK35VwmjscpUCSKY5S9bvFdQjXlz+xhiqmX4YF9TiukNOjUg
 p4Lnzvyd6zK+tdaC32dAC8Fa5a8NW+hnvBlhaZHoq/CY9KvWchoOCrw1aDKeEUZ2EmuF
 MiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CR207ipMmlY7BwQvStdyeXJZUxi3TPn4ECTm9b7xJwk=;
 fh=YoV9VPgeLFkrntNwOf9NDT8Dq4AXdx9/z9Qi8N1gKHU=;
 b=ZQ6CzwqIWTD8i6nqiEw1G3scxWs+2a6JWc0qGidY1i/fuT9JPetb4qFB3kzQWrm4r5
 hxTQ9b8iXQDhg1u7MHGAbQAJSXHErOKrpwFyG/oLMV9NZN4kGWaUcOokRAiRTjP4mrwq
 LoYdm0JA2jvDpLfEUM84jVIBLC+xWoKhj6yu8Sw+dMgDGqLNBHgs0erPo6b0Ax+NU+BV
 j00r+KVItQ0bqcXt4zFxJbIpILvBoh2StToH2GTLQA1BnCzW45Mjala0ztW2hZlsMSC1
 ZsCQh2xhip73eoccLN1Jk7si+0dch8/62wN4VfYtdX57o0IXf7CYsAvaRowm6xfgyjjg
 4+Zg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792995419; x=1793600219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CR207ipMmlY7BwQvStdyeXJZUxi3TPn4ECTm9b7xJwk=;
 b=b9U1Xy+3MQ0AyTNZr0GsxwIybv9cqOeTTzaaH/JpIEf1dn9fykOyjfgqwi4qYRjVG6
 5JhA9rMI9nZRMaXhNHH0LEKwxZJBglR7gnQ7psIBaXWPumK8Mwd33IkvbAmw9mVdZ1ML
 os6M7UKFd3VfUT7QYHluj0EKu6X2LGL2JzPj5z/fKi7b90X+mj+MJXnyhtoRN8wQR6Co
 O/PIUO5/vJvQI05Lk+lR5bKh9uBRzSNX2wkeyrVhWxV0wFaI8qZTr/lqg/xwIaxT660z
 mJ3i1CYtEQCFgRFrJeGv1/sN58Tq6STOSfHgkKrPTyYi1eO+dJ66qrXSrhRWAHRiOIU+
 ZHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792995419; x=1793600219;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CR207ipMmlY7BwQvStdyeXJZUxi3TPn4ECTm9b7xJwk=;
 b=JSAp6Th4y6Vq6mugOaCAb9PelhISejt/1kz0aPkt1A29dRSKZtspWcP7MlyNUkQjQk
 ABasGJLIrF54jPsXFZc9yIZhie71cyBzEMuvdMJJeeBQrOIW1omJRLzUpfCu3ub83+fB
 IGbCsN/GG7iJtaWEkMJd0oFxkaPhwtu5kQvgVoctvPSxdEW5NMwp5bL3I9Z2u2nIBE2w
 eJ+a9iPhlQuKlTR3XxUk88MuSyAhnyJX4FD26D+RS2QeLxL7ZraIGuWTVNbYhYCKhv2A
 sgle7QXU9gxXDyi1ayUcU/aEZO6aZjUHeK2ztYL5AtZgUS+lWhjwdQsazd1vWbS8AAyE
 VKIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByoXIDnJNJh7RQq2kATW7uwyVWe+fKscvI1Jx5mgygCXnVZwouCjHXWtlCXWoISD/D61Dxx9bCom3c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJqTr+2zcAiPtcdeJUZndvovPSY1vbJv2Uhu8jRLUZjBR1hxBoQ
 Ps1xB93V/9tsUANFr7MR70m4a8uSlCUvaK9AZLE4vXue/vvD3kyI6aXoUYjj/6/ybyb3TJTvdb+
 rZ7zGPCzVhWy1r8EISRnHye9Uakzgk3I=
X-Gm-Gg: AYBFou1d9FsqW2wfxTDURcxCDE8lrWkKMnl5SkK5s8iJIa4/cwDkF6CFzqmCPTrFp8C
 +MefivA2yUswsFnmtx2FQojdR613WCM3sbDgNkYiPu6dnjCZzvLlqw7mF3G5qNEWsltukYX5UNV
 sDuBI0qq3iEr9PwC1aMymuki9C7no3r0O5d5zOESiAeEe2HDFCy8q/DojazLD1u6tKV4twaCSFs
 fugSpYIfSi5/4fkusDsUSMdQO5YP0ipmjTawx/hedGRcc/D5+dpCQr18EqaodgJJaEdjX/v0n/1
 1yV581XjrNQOl6XI3dzMpsS/kY3HU55w3sPQ5lDiYdNk98nGh/86XSUhzD5jaK8geYoWwkf7GmC
 QZs4+oXy1lojO4IGYkEoQi7/h+OekJe3K/KKmhYA1c2ely81b3njvoRR9ThiHvyRpRYo+PbQ=
X-Received: by 2002:a05:6820:340d:20b0:6b7:46fc:1d8 with SMTP id
 006d021491bc7-70ba0ef0690mr1914182eaf.55.1792995419601; Sun, 25 Oct 2026
 23:16:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
 <at7pu4hldDTgZtXy@stanley.mountain>
 <CAGLmz9JaXM8s4BHQ2Cn5QQdBZpzDXmHyb-GQ_jXtj4Rz6SJOJQ@mail.gmail.com>
 <at7s7We7bxdmmmSM@stanley.mountain>
In-Reply-To: <at7s7We7bxdmmmSM@stanley.mountain>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 11:46:48 +0530
X-Gm-Features: AclHuK_st-Xa8oKg66mPkm3FdUxLxM8NWdOA-cYaAmfiphj913FwW3RJaID5D5c
Message-ID: <CAGLmz9+R5Wsd3i+7kLZXL-KP2bqdEmNUJTSKtZph_NSP92Jung@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
To: Dan Carpenter <error27@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dan and Andy,

I have not found any call site for fbtft_init_dbg and just assumed
that it might be useful later on as the driver develops. If you are
considering removal of the macro, please let me know, I can send
over a separate removal patch of the same.

I have also noticed that other helper macro just after this one
like fbtft_par_dbg and fbtft_par_dbg_hex have some minor style
issues too. If you want me to correct its style issue too, just let me
know.

Also, regarding the confusion of threads, I had sent over the patch
with a revised commit message as PATCH v2, which matches this
discussion's subject. (which I apologize for). And also sent over
the reply that I meant here in the original PATCH v1 email.

I hope you will forgive my incompetence,

Thanks and regards,
Himanshu Bakshi

On Mon, Oct 26, 2026 at 11:32=E2=80=AFAM Dan Carpenter <error27@gmail.com> =
wrote:
>
> On Mon, Oct 26, 2026 at 11:23:21AM +0530, Himanshu Bakshi wrote:
> > Hi Dan and Andy,
> >
> > I have sent over the comment on the v1 message chain and
> > also sent over the revised patch separately as v2, I will be glad
> > if you will go through it.
>
> The subject here says we are already discussing v2 so I'm confused.
> You can go through my response and decide what still applies I guess...
>
> regards,
> dan carpenter
>
