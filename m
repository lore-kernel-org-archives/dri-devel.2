Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F3CCDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714A410F48C;
	Fri, 26 Jun 2026 07:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B0/j6nU6";
	dkim-atps=neutral
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C98B10E1B7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:07:10 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-80814edb536so20068667b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378429; cv=none;
 d=google.com; s=arc-20260327;
 b=GLJ5b974T2shRkcTv/IVrGEf2Lch1kfeySsy6oGlJRd3OC9pK6sQTN3l3PJGlH/8n5
 bwWiRCMCG9Cvj5f5EHqxHK9xUAC1E5apbhuD8kzR1t3854SNH4+bPRIQqsXO8VrFBqoL
 qIqwSjm2noGz35cN5R3GW7c2i5oXOMcuNqZKSWcCvb0MZXQsy88BDJ9LWtExc2CP0BdB
 dpTNUHpZMvYAfZvlrDT5IhF10GteYBfyPVWTD6j2/P2vet/RmFpd/pAHl+UXGGehJotT
 3XckItOsm3H+A6Wf4cPxGzDMG756yumevd9lQMyuw/GyhSwQzj6Ngyn5xkduRnUtcFqt
 CHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:references
 :in-reply-to:dkim-signature;
 bh=YvbDz6sWa3AWCmeTnS19savIdeLNARxTK6KFvXLsCYc=;
 fh=ttJ1Y66gnbCcCHVhCSpE8AgT10khfBkaIjRwOpJyAYU=;
 b=C+buXDjJ0mcEtqE5/igNFQx5BRFuR2U7sJgAfaBtNpsub7LN8RjvJ4+xrHra6IQTjs
 7/gSBi2nA0WC1q/oHqgctcGPPCDi9LI4OcE6nGoQvFMef6s5MfSPjWMbLy9XFWwimwKA
 Gt/LRHITvqz3YzdBkXpTr/esCVABAITQAIl2abqcrKbk28mc7U6aVh02+GHWGT6LYNOn
 qxa9/NOZuQzFFWCMJAIh2tuvAnFpW1I9DCmVCbgzP1fLmlobeNZpsZ3AKqHXpyl5fypE
 xkuZCRMgQy9Trld7YiOcHGHs8jm82xRi/eiPTHqgRFL512SolQ/eOV+al73rtJDJSOv7
 rZpQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782378429; x=1782983229; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:references
 :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=YvbDz6sWa3AWCmeTnS19savIdeLNARxTK6KFvXLsCYc=;
 b=B0/j6nU6uZgmY6TnWNhLekc3So9ev/KkCva+tQr3099QT7ki7/Y/YYvSy+oU6QEFzO
 pFZ+0IvjQBHx3g23+5urqoGvMrWxObrKQya3sMco2u6L8V7XLOV/ZsmKEiqDSWsk7M8D
 gT/oESHAl6QP4DPQTnCC+4n9qfXVsTiRce/s49OTeJsmRPwvRXfwbD1Q52az22IlNLiC
 yAQn83l3xhwtsUGfIAvHqp+TotJj++r6BjFaCR3Rfod1P0mZBMB64MA5uyq61tGhna1y
 1QgY2GeQYeEwzQo4EwABuINL9tntGButYPseVadxSerEli0S8r3QRoXMf4jZH+NIAUMi
 hEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782378429; x=1782983229;
 h=cc:to:subject:message-id:date:from:mime-version:references
 :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvbDz6sWa3AWCmeTnS19savIdeLNARxTK6KFvXLsCYc=;
 b=Gu/1bTML+0t5lOytmF6rrZWQSnjIpoAxMoHAcCI1PQkt1m9v4Ye11Dzu6Kmaz/Hcio
 E5DLvg/LGosMUVz0r98jy77lbBqdut50KIB4KxXOsem2gvxVXc74pfFKNFt6MYehvYzG
 qoD2zn6l9dkMM3VKog67IDnuIc/yi5DLXAaaOg7sszX+QMRYJJRYyA/rxn3SUYMU3qBG
 GtGJQxrSVFXObWNtnx3XKdKyUZex5TugnmGNDX2+jvWf9efkskQ/lrooczRMqrMzxaml
 qiZ7Nv5Lt/VYulMlLRhDAi8PgYgFOsQON8SVE5/oz/EDERMhEyp5Hn0Aud4ed2lSwNSe
 /EQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpzc1rC/gX88xP+GaPesUea0JHEEWTYsNQmOGlOaVKx+b1pZlOK8TZzGh+qPGGcF+bR9UCpcQeCsIY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRuS1Xn5uHzzbfRC/C9NXMrEEtOtmqtzTvP+ICQ9oaxAHik0FB
 zw3v7/e+1p+Qj9OQdyyU67mEveSBmyBw5g8L+5YLVNOI/Atd8k8dax/a4QE1l1MI8tx0ZwCHM0t
 uNfDHpPZ0QrPPwGtW1SFk99sgQoFjmdAsSFpvlVA=
X-Gm-Gg: AfdE7ckxGV2OXxSheT5OqRw8HIjdgHh3ADF/vwef7KmLO1Gqe+GZdNmnzT056mGlYPp
 nlcCpiIMQ8WHfFPZIgq5Du4S76WXVqAAjaEWz8tMaK+b3zVgPVNfMOaiBnkVa+++SbYUl/nTE5E
 +8iRPNCrnqOJC4HMdteudEq5gPJM+4xjGr/iCCnQCqRz2d+xST0uZtEF0d9Ogsp0+fybShctpyE
 ZEQZOvmcQS/a64ebnRRJavOGc3YcFgyP+wrj3qqcn/1xBAfsBvLFsV0YQ1/fh/HwQzxon0VCA==
X-Received: by 2002:a05:690c:f01:b0:7fd:fba1:1589 with SMTP id
 00721157ae682-80a6cd77157mr17457367b3.47.1782378429208; Thu, 25 Jun 2026
 02:07:09 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 02:07:08 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 02:07:08 -0700
In-Reply-To: <c1984f80-f8a8-4ee2-a087-c49ad3ad1e39@oss.qualcomm.com>
References: <20260624192700.5388-1-alhouseenyousef@gmail.com>
 <c1984f80-f8a8-4ee2-a087-c49ad3ad1e39@oss.qualcomm.com>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 02:07:08 -0700
X-Gm-Features: AVVi8CfXcO4Xqj0xfIbkRCaWdoxuKn4uA6lq950FpuO1Yg3xRaEV5QuIM4uxQ7M
Message-ID: <CAMuQ4bXSG5piN9nwLoTcAOCRoZppmJegcPwghikdbQWGuGS+sg@mail.gmail.com>
Subject: Re: [PATCH] misc: fastrpc: release pending invoke refs on rpmsg
 removal
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, 
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

Hi Konrad,

You're right. These touch related FastRPC lifetime and bounds paths,
and several of them depend on the same state cleanup. I grouped the
follow-up fixes I still think are valid into a small series, and I'll
keep any further FastRPC changes batched instead of sending more
standalone threads.

Thanks,
Yousef

On Thu, 25 Jun 2026 09:40:53 +0200, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
> On 6/24/26 9:27 PM, Yousef Alhouseen wrote:
> > fastrpc_rpmsg_remove() wakes pending invoke waiters when the rpmsg device
> > is removed, but it does not release the send references taken before each
> > request was submitted. Those references normally disappear only when a DSP
> > reply arrives, which cannot be relied on after endpoint removal.
> >
> > Walk the channel IDR during removal, mark in-flight contexts completed,
> > and schedule the send-reference put while waking waiters with -EPIPE. This
> > prevents disconnected channels from pinning invoke contexts indefinitely.
> >
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
>
> You sent ~10 patches to fastrpc as separate threads, do they have
> any sort of co-dependence? Can they be applied in random order?
>
> Generally if your changes are even vaguely related, it's best to
> send them in a single series, if only to reduce the possibility of
> a merge conflict
>
> Konrad
