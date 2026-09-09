Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3362EC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26ECA10EF0A;
	Wed,  9 Sep 2026 06:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n38kxCqH";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA72310E11B
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 03:54:53 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-7866d924eaaso3915835137.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 20:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788926092; cv=none;
 d=google.com; s=arc-20260327;
 b=mVj+xFER4STSKUACCrLV31WBXfX9vBanJftvRhjQqSa1ETR1dpstrgi/EVJulRLzIQ
 0yPMlLqDuLxet7rnBwZlYaAaq5gvfoFLwl76W+e8GbBRoK3tfQwDyFpO9LcKYPCnYaoC
 RjTHZFyduJXRtmzNnrnNAtK/MZ8w1xMxDtKDySQsoYI3eql+TC6JDoawSVMw6mjgyOyP
 c6EV9XQsmSvyy/2n+Fkk0CITPP+xH1A2jslijV1349KVjUE201/dQtF8J5JpPl5fEns9
 NR8TuvZ7WpfloGmMptX9JIPKkpheuLylBZ7R9obLA5ZLQHUBL9t7J5D3S0JM4ficjy+7
 ouPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MPGTaC2p1dCYluC1a64jwYOfjAgG43czB2zsAT3+z5I=;
 fh=kYG/Kue/VlEsA6owHv5h6l2JqGHCGrWpo0RZvM7G+5g=;
 b=q7m85fN2Gq8qANQ6w+13PIs2O8jFeGEaIAPT5OYma27oiO3oR3tTNp8OicTRpZhCdG
 nRqy3Ywa8F11De2plwqqmVhALbw94noR5gnGkEFfjqyoHotvgzm34bDJsBArVfPoisCx
 PoYwlfsou7l79NlCjfXngA6zzp/tXyVLWlbrGqWt0qFGiEZmHbH5pUv4PW1sxtHAkrHz
 P7alBavTG6ekUcXb1AxOEXcAFIihS848KKcIGu5TRlvm7CtVlvmO3vgijKrIFdBr9EwP
 UX9KkGVV8yBE9TvSB4D7abbjXm4y/wdfQWl9k7UH7W0OOIK50LbcbBI8sI18zZcaZJMU
 Gcuw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788926092; x=1789530892; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MPGTaC2p1dCYluC1a64jwYOfjAgG43czB2zsAT3+z5I=;
 b=n38kxCqHdd8AMuQPboO+V/W09F/qQRL2mczkYijsLyQRWgjaD82Qp8YVIZAnzAKD/Z
 7dXhiHAxDGcrjQFBSUKyadjjb3dW9ReNOuPWelRU8p+mjqqwn6XqCh9MYKaUqE+87qbF
 GMvz+EwSpAZZAgXW6B/P0bHQZyxammt+9ciKNKRY1ZXuqhRmK2QC4x+kyBpUMvWh6j02
 1lcwb/76W1FYw+/qdVNFG5VeV3EsDDk3HanI1ji/m7b3rNUMTeeuPyyM8lmnwHl7sAyk
 QNEf2jllqEZFGVQHcDgentW7AJ3hUJSkiVwgRfxgVbje7T9Gp78qyxLLmRtLXz27LnnP
 eqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788926092; x=1789530892;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MPGTaC2p1dCYluC1a64jwYOfjAgG43czB2zsAT3+z5I=;
 b=gB2dg1bF6HzHpOZTYJweSC0r2f/ANVas3U1Lv5Sx7aoITQbHzyD/gVvoUoCwxUnceN
 yT8sPVi19yNk/7bXU/y1AlqXB74ZE2z49S0T9dplUSPXzA+exGJHiDZtGPclLbnVKo9w
 xhl+3DdkevU8BvfgQkA6jwhsw+kGyNDFez7KF0+vuqj05DbrYpbhYpWbPqoPlg4FA9BG
 6ysOMEoz3Vp8n0Ge5S9h+eo7R2q1Ybg/MKYmIqMsimregaV+O+jn290xjHXmWiwQ24pa
 i7dFBss1tAdWIXBa0DdtBVVitYHaNGKHS9kxfHreiS11TSsbzIfo89TrRbmbg7CnuMZD
 axSw==
X-Gm-Message-State: AFuF++kByJxOVT+7jURnduC00d0OJv20cKDbdv+ExnXWKiYbKbVoaTaO
 tFknlAz3Ml7ZplCc8vut8URyZEsyhqKJVRY7kXiwdbjOr+FKxeaHuoyVor0IGE/yAr+o5sNxqvr
 uMSUopPIcCVQZxGwkvAn313Vjm6VpbLI=
X-Gm-Gg: AYBFou1mlrYEK2wsna5C7o4/b1qMtVUb00r6av7GAZtTZr7FxIFIOd6XeF5EAMqxHMo
 9yHVdpNYvnk+S4vHefz9WzIgVKIpMEbjKHhxPhWTlD40EEqvQJeKOfyN/xqKTqYWxhdxHXDhV3T
 W2ynjiDLn7JkbdBchEeOUYqhiG1IlD0DAu+e4STz47pe33iw3cLuJ5T8PsKz9HxnnadnzYb2/6f
 5djCQl0hmOs92U1CXuELXganqpVfTvrwn2Yup0BBzhk1DYEwYijxm1DN+347/Akdionh+b+KT98
 e6qAB+kQIdnRvWC45/jZyLQCo5aFyyuIx3+CD5V9sCh+Rcv61+Y8Qn65UzPl6HcYTonGs3riU7x
 NuIcwdr966WRC
X-Received: by 2002:a05:6102:5803:b0:785:a48a:e3b9 with SMTP id
 ada2fe7eead31-78a4a6a93d8mr14303200137.4.1788926092451; Tue, 08 Sep 2026
 20:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGehT5fQWOXgftdfmq+GDZf9wHJacQ_g93iKGRKvsY0Dm0r0Lg@mail.gmail.com>
 <ac5833e0-aebe-d60e-5fb8-782398451673@amd.com>
In-Reply-To: <ac5833e0-aebe-d60e-5fb8-782398451673@amd.com>
From: =?UTF-8?B?7JWI7Jqp7Zi4?= <nanhosoft@gmail.com>
Date: Wed, 9 Sep 2026 12:54:40 +0900
X-Gm-Features: AcwNN1UKuULrthe4KF7RupMHLdGzjCXobJ8lN7-FuTLgLMZMDD11sYV8k2gl1bk
Message-ID: <CAGehT5d=2FFKD4OiV3dNgt7vN=va_B=XvgQ7F3AZR+UQHMZGUQ@mail.gmail.com>
Subject: Re: [QUESTION] accel/amdxdna: AIE2 maps unspecified QoS priority to
 PRIORITY_HIGH, AIE4 to NORMAL
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

Thanks for clarifying.

Yongho

2026=EB=85=84 9=EC=9B=94 9=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 2:48, Li=
zhi Hou <lizhi.hou@amd.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> On 9/2/26 22:48, =EC=95=88=EC=9A=A9=ED=98=B8 wrote:
> > Hi,
> >
> > I was looking at the hardware-context priority path in amdxdna and
> > noticed a difference between AIE2 and AIE4. I'm wondering whether this
> > is intentional.
> >
> > In aie2_message.c, aie2_get_context_priority() maps a qos.priority
> > value that matches none of the AMDXDNA_QOS_*_PRIORITY constants to
> > PRIORITY_HIGH:
> >
> > ```
> >      default:
> >              return PRIORITY_HIGH;
> > ```
> >
> > The function also returns PRIORITY_HIGH unconditionally when
> > AIE2_PREEMPT is not enabled.
> >
> > The XRT/xdna shim zero-initializes amdxdna_qos_info and only sets
> > qos.priority when a priority is explicitly specified. Thus, with no
> > explicit priority, qos.priority reaches the kernel as 0. Since the
> > defined priority values start at 0x100, 0 takes the default branch and
> > the resulting firmware context priority is HIGH.
> >
> > For comparison, aie4_parse_priority_to_dev() in the out-of-tree
> > xdna-driver maps an unrecognized priority value to
> > AIE4_CONTEXT_PRIORITY_BAND_NORMAL.
> >
> > Is the AIE2 default intentionally HIGH, or should the fallback be
>
> This is by design. The firmware running on AIE2 and AIE4 are different
> and they would use different default priority.
>
> Lizhi
>
> > PRIORITY_NORMAL, consistent with AIE4? I'd be happy to send a patch if
> > the latter is intended.
> >
> > This is against current linux.git master and amd/xdna-driver main as of
> > 2026-09-02.
> >
> > Thanks,
> > Yongho Ahn
