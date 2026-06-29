Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72100C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D3910E77E;
	Mon, 29 Jun 2026 08:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iv+s7fJv";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A85B10E77E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:52:11 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-80e24970f1dso8871177b3.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 01:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782723130; cv=none;
 d=google.com; s=arc-20260327;
 b=MEgONb2AHfmt5yNhI6uqOEUYcYo/AMBYhI5PZHcujXDjqUKJl8GsYQkb5ugJoKc1fR
 9MBcK2y688V1IiuuENQ2Ka+RgkHPM2BqggUuvJbgrwe7uMifdICEdWHuADt69yVNyCTW
 +fOo4v8iCyv61Zu7oTldSb41Wrlk+2+Xs/RULOSnD5hTRcqgTU2EfFcNdWQBYaSI05qQ
 JmErBQFJ5DJlLIFyNFDWdZZ+DL0ZM1Y7H395Dp/irYkPz3fhADni9+UhpSvSqWvS4H0z
 go5xde9O/lq1r8imUzUxUVQIHoJKwZygTpgiWz5trW7I5moMXmfzDfv3n7+OmkXiN+7P
 3Bqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Q24aG9NkOoTB6HWBhLb/xRPsEmPyRkg3AgUHCrzNw7g=;
 fh=MQE9i51YDFHYDWJdmI0nKXJGZjFWyl+0LaRTweOyFAg=;
 b=GB5JkfHqbxiRChSt9RePK3srlX05IirSVBYu7KtyaNEsQOAT68aOYcGTI3l9/y6wKd
 9ADm3RVlYslpiXsvkFjLPlR96Va1yyVs5KqsygBg2S/E3jvTTJ5SaRrWf1LRDqfAGYYn
 XIhSb+x+znIQtr66uMIvFY0YAEhIeJ69NsQsaWkNxnx7Y6UnNJ1ZiZqTcS5ejHEEO2B6
 t0G2zdSMNJur2/x+WXAIlDxYVje/0rmBe0u9xBirJJXaeaknWGhxU9W5FeiVFCO6CiBB
 QsbaVzfucw9TIToTrWyqtS/+F9futRENjhEpU7ijarSHoAl06i5FJV4k06VAJoL9py3t
 1QyQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782723130; x=1783327930; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Q24aG9NkOoTB6HWBhLb/xRPsEmPyRkg3AgUHCrzNw7g=;
 b=Iv+s7fJvKOSQ9k/QW2h1SVyFHjMy387J6YzlebRk7+CRkIgg4yXiU0yyAV5XqqF6D1
 tpfP7Xd/AAgNTkwxi+E+OiGdYCS7eljJSFmlXul1B2i75Scwwv9eoJ/kVLQAvPJ0OPmL
 SgYe121hfTneU7oPVtWAvXRbQ69cCwA9RYBgUI1B3LzMRAUiG3o35k5r/i8WvguUpFAo
 iOBh8PmW7arPBSlGS5zJ/ULrVDwUEqmg/lY5uwwyCXTZOlL/mofkj7UB+54qriLul6Qk
 G9L/ytx9dyGUWDSS/+k0rge2jJ6ALS/Yj2ZDMKft3rrrTbR/yfsvjCY20BaW4XKpKkNj
 rVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782723130; x=1783327930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q24aG9NkOoTB6HWBhLb/xRPsEmPyRkg3AgUHCrzNw7g=;
 b=fuGlIyLv/PXBAtLEQf75ejXhUglfWuBdBiW3psPxuRTbOyj4DVIZyvdoAFNYmbCKkc
 ix081auwukbxsChfruSM0oPIyx9EaaXEvPgPb7y0II7brUVX+8oZtyB9Sq1sr5YBJwM+
 heDvJV1mRKCN7DFD4yWdRe1NfLUBcKiaf+3Nho3O8rJSrXRgrc8ZaJeRiikwqLrSoi6Y
 AUfEoStZAj8Gkbnr/oevOt43Z3ObzytRmu1fmrpnYyNvuMlkIDJPMbXZApIc7I5K4QZW
 +NWgj89qBIQiX7rkk7n+OFkT2b1VxZXcqK+x6kaPB+l8ziLM8I6BB4Jsm6f5wUgE2rc9
 Dmtg==
X-Forwarded-Encrypted: i=1;
 AHgh+RomGLNyNq9h+9uY6FKM2hvgO9oYc98zkqGtF0RD48goxSJNiTG2xH56yVDMNZnHDZYtEiET78IaAw4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzsq6ztrmQwWJ9dV4AJRMTMT7YCd+c2gMKWmKcF3YZQbqUGwavE
 ubrbVoLr79baNVzHcB+oQjVllwwJYiapBn+ARbwLvg0il4wYBjItxe6TneU1nHu8kd1nuQIr+Am
 OxFXgFmipE6o+KTu3mnSqSwJQBAY9pSo=
X-Gm-Gg: AfdE7cnTLwkyigQqHv/oP0YcSAFLmji1u7Pg3n8/FfJOhCk+qWmMxTDvm6J/Aug9DOH
 3A1IdEY/ezhR428dd2fv4xURNR+tBwo8ZCgf9B4G6CBdCIILvTypIJHZx/WyqqxMgybpj+uiWeN
 k5XXF9Fmep+eZbYG0mQXCl8tU13eZTJ8FtVCijvFLZYW2/rAvZqzlwke0esf6Q3NvTn6al0ndQm
 M2JMMvNwNXUiE6VZM9JelyrO39xQePL1mo7pXK8DLO3XMqQ9LVXQnKM4W621t4M6ZLKQBbewZOk
 0g8rWMaUMq0US/SNky/4+/o9+0mb
X-Received: by 2002:a05:690c:4d46:b0:80c:85e5:873f with SMTP id
 00721157ae682-80c85e58a3cmr91884837b3.61.1782723129982; Mon, 29 Jun 2026
 01:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <aj5neetgYdu0QpcK@GRAPHRT> <20260629094419.6bb56d99@fedora-2.home>
 <CABPQNSa0-wqQTm0CzLFojWZLVY5OqQxWTXrpO=O4p8go52808Q@mail.gmail.com>
In-Reply-To: <CABPQNSa0-wqQTm0CzLFojWZLVY5OqQxWTXrpO=O4p8go52808Q@mail.gmail.com>
From: Erik Faye-Lund <kusmabite@gmail.com>
Date: Mon, 29 Jun 2026 10:51:32 +0200
X-Gm-Features: AVVi8Cf5m_RZPXcC8e-k50YPGdbuE1-CSqK1ujQU-qXEgiBfhg_pV5oHfBEqMOA
Message-ID: <CABPQNSbwC=VtjjQiDd6B9ExT4GhgJOGUu-_tTeZ8TvgqDDbqKQ@mail.gmail.com>
Subject: Re: [BUG] drm/panthor: intermittent freezes in Xorg xserver
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Marius Dinu <m95d+git@psihoexpert.ro>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>
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
Reply-To: kusmabite@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Silly me, I forgot to disable HTML email, so this one bounced for
some, resending. Sorry about the duplicate.

I wonder if you're experiencing the same issue as this?

https://gitlab.freedesktop.org/mesa/mesa/-/work_items/15116


On Mon, Jun 29, 2026 at 10:31=E2=80=AFAM Erik Faye-Lund <kusmabite@gmail.co=
m> wrote:
>
> I wonder if you're experiencing the same issue as this?
>
> https://gitlab.freedesktop.org/mesa/mesa/-/work_items/15116
>
> On Mon, Jun 29, 2026 at 10:24=E2=80=AFAM Boris Brezillon <boris.brezillon=
@collabora.com> wrote:
>>
>> On Fri, 26 Jun 2026 14:50:17 +0300
>> Marius Dinu <m95d+git@psihoexpert.ro> wrote:
>>
>> > Hi.
>> >
>> > The system is Radxa Rock 5 ITX, RK3588, 32GB RAM,
>> > mainline kernel v7.1.0 with panthor driver, mesa 26.0.7 with panfrost =
driver,
>> > xorg-server v21.1.22 accelerated by modesetting driver, x11perf v1.7.0=
.
>>
>> Are we sure that's a panthor issue? Also, is this a regression
>> introduced by the latest kernel version, or has it been like that from
>> the start?
>>
>> Also, would you mind opening an issue on [1]?
>>
>> >
>> > The most clean way to reproduce this bug:
>> > Form a console or ssh session, start Xorg in background, without a win=
dow
>> > manager, and then run x11perf on that display.
>> >
>> > Xorg :0 &
>> > x11perf -all -display :0
>> >
>> > The bug: weird intermittent performance issues in some of the tests.
>> > Examples:
>> >
>> >     1000 reps @  18.0799 msec (    55.3/sec): 10x10 rectangle outline
>> >     1000 reps @  18.0791 msec (    55.3/sec): 10x10 rectangle outline
>> >     1000 reps @  18.0790 msec (    55.3/sec): 10x10 rectangle outline
>> >     1000 reps @  18.0789 msec (    55.3/sec): 10x10 rectangle outline
>> >     1000 reps @   0.0287 msec ( 34800.0/sec): 10x10 rectangle outline
>> >     5000 trep @  14.4691 msec (    69.1/sec): 10x10 rectangle outline
>> >
>> >  5000000 reps @   0.0029 msec (345000.0/sec): 1-pixel solid circle
>> >  5000000 reps @   0.0009 msec (1100000.0/sec): 1-pixel solid circle
>> >  5000000 reps @   0.0012 msec (818000.0/sec): 1-pixel solid circle
>> >  5000000 reps @   0.0000 msec (20900000.0/sec): 1-pixel solid circle
>> >  5000000 reps @   0.0000 msec (32300000.0/sec): 1-pixel solid circle
>> > 25000000 trep @   0.0010 msec (979000.0/sec): 1-pixel solid circle
>> >
>> >     1000 reps @  31.6607 msec (    31.6/sec): Fill 10x10 trapezoid
>> >     1000 reps @  16.9012 msec (    59.2/sec): Fill 10x10 trapezoid
>> >     1000 reps @   0.0234 msec ( 42700.0/sec): Fill 10x10 trapezoid
>> >     1000 reps @   0.0272 msec ( 36700.0/sec): Fill 10x10 trapezoid
>> >     1000 reps @  32.1268 msec (    31.1/sec): Fill 10x10 trapezoid
>> >     5000 trep @  16.1479 msec (    61.9/sec): Fill 10x10 trapezoid
>> >
>> > There are no messages in kernel log or Xorg log.
>> >
>> > Visually, most of the tests runs fast as expected, but in some of the =
tests
>> > it gets "stuck" randomly. The test suddenly freezes while drawing the =
pattern.
>> > Then, after a while (a few seconds up to a couple of minutes), it gets
>> > unstuck by itself, draws a few more patterns extremely fast for less t=
han a
>> > second, and then it gets stuck again.
>>
>> It smells like a signalling issue. Can you check the CPU activity and
>> report any outstanding process? Can you maybe connect a gdb to the
>> x11perf to see where it's blocked, and post the backtrace here (or in
>> the gitlab issue)?
>>
>> Regards,
>>
>> Boris
>>
>> [1]https://gitlab.freedesktop.org/mesa/mesa
