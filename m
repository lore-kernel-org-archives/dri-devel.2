Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657CCC44501
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E46F410E5EA;
	Sun, 28 Jun 2026 11:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Og64u12+";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A75F10E277
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:15:42 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so1625930eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782479741; x=1783084541; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUZS8arJTb9jzjwmvDWy0scqNm3RC59q/slorQATQUw=;
 b=Og64u12+rIPguI0+oDD+dS59XZpDUBuu/JJaimYnBdeT+HyojpXHeqHDZ6jLpOy1WC
 hvl9S/vZ6ZEO+Y1dgg/nfyHtBWt9GKdEg286OlybpJxwDvTSkonDP5FYAdreLZ9wJDPv
 5pWB8t2wTtba7ZiTR5dHohUsO2OmTAms8CNyjk22s/E0phAva9ogb4AqHowsv/P0zFrp
 NrSmKVFiWUg9S8ujIjEgF2tTTZbzLhi0S7h7rE/MJPzbHw/9odqPsxbZE+Dn75wrTwgV
 jodt+LQ2+uTOGOQp+yfWZnk+n19LmZNX7fBjaLRgYxTI+aGK5mO6CLtP9qiUjwQt5wFz
 TzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782479741; x=1783084541;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aUZS8arJTb9jzjwmvDWy0scqNm3RC59q/slorQATQUw=;
 b=B+AciLHv4/ZbSZgwUVWRgGeRLmFcVk98nD6QzQS4TTJUsZvs8yS5/OCOW2Aacy9h7a
 Tf+PWiubU2bUqzPQOdVyrhxxpI/yJS6QO27xMvjiRwCH4RW7GqkfuzMpN1+pXvwmx3SY
 8XbBK8CeVN+l55li3l9RQdYeYz9SsD0jJj6LtqZ7rPoad1C6RmmJIVRWhKd/MRXXLmk7
 1+OherTEIY9pNZ+FM3LqYGwiEGZ9bCtf4q8Pd7LGI+6+QFzsYFmEtbxOUkvvvkOsuuOz
 U8ckqk87yy4nFNhyZo5B53ZkSbFOP+tZqJKbv9mYcZ0vH0RacY1I3sY7rkIC/4ouBpJ3
 Uy9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2Ew3Syjp/z7dUv/uO7OGrmxrCjC2zzqSJWb9aEPkYiHTiFuKHdP3XlI33zPzfza+IxcETpJNetSw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLGWt+XycIF7bgWY4IBsT6iWTLQTxieXXf+6dJQ+F6MW0KXWIp
 q7ke+wN5Cw8139QDUqa9SuZ36IrFEFz6PQBFVFHQnyQSvHH6Ub2aLmbm4LVTvTw=
X-Gm-Gg: AfdE7ckBT1dFTmwJ4PsxQ2//6FUtavwvxbf8N3Lt8TxsdncJUDTYZQ09fqdXNzv/RJD
 FcVSIJKne9/3cW2771TWkS0tTpcypPZr5/b3k9JTytEpOuje9NJ8a1FqVg1Uxptfj6wjDEszc9L
 A+eCaBqNceCg8H2QSwIGmxNMmDgKzqk2RUcizAOKTdLb8Gw2xDuaMjmgYOqGCuaWf2Daw6nstCn
 9H0te7pIAfIjExS9w1M7tUZJVjjIFvDwFhlF74gE9l26yHo0y7Jf8jwc5Va78VaV3W3tYBASDhU
 iLmS9Qqib7/b2nTdEtlgM5hTO12yQAaflt7Yfd9KQHcyoMMvyvbjP8o8E45vNbFNLMp6mz7LC18
 DJuZEyITOU3PnXS9ouBvkWZGQNGYh5mNMNJ9lZlfX0hf+kZz1XTKMbkOEEXCSM5d5hfBG44Cf0L
 Sy+ZPCGmbLigQyk84J9ywnWBngRz0IsNQ3bus9J6f+65F+7Qfd
X-Received: by 2002:a05:7300:2321:b0:30a:e52d:fb27 with SMTP id
 5a478bee46e88-30c84b84f6dmr6776480eec.11.1782479741405; 
 Fri, 26 Jun 2026 06:15:41 -0700 (PDT)
Received: from localhost ([186.158.238.108]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4c691dsm17366960eec.5.2026.06.26.06.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 06:15:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 10:15:34 -0300
Message-Id: <DJJ0BXFYH05I.3MV4GC91I0HTX@gmail.com>
Cc: <acourbot@nvida.com>, <nova-gpu@lists.linux.dev>,
 <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <ojeda@kernel.org>,
 <rust-for-linux@vgdm.kernel.org>
Subject: Re: [PATCH 0/7] drm/nova: replace `transmute` with `zerocopy`
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Pedro Yudi Honda"
 <niyudi.honda@usp.br>
X-Mailer: aerc 0.20.0
References: <20260625190553.7245-1-niyudi.honda@usp.br>
 <DJIGEANGKENH.3L3T55PFRGY3Q@kernel.org>
In-Reply-To: <DJIGEANGKENH.3L3T55PFRGY3Q@kernel.org>
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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

On Thu Jun 25, 2026 at 6:38 PM -03, Danilo Krummrich wrote:
> (Cc: Nicol=C3=A1s)
>
> On Thu Jun 25, 2026 at 9:05 PM CEST, Pedro Yudi Honda wrote:
>> This series follows the introduction of `zerocopy` to rust-next and
>> replaces `transmute` traits with `zerocopy` traits. These changes are
>> mechanical and don't alter functionality.
>
> Thanks for your contribution!
>
> Please note that this patch series does not apply to the development tree=
 of the
> Nova driver; patches for the Nova driver must be based on the drm-rust tr=
ee [1].
> Please see this related explanation [2].
>
> Also note that there's already a submission implementing a subset of this
> series. Nicol=C3=A1s mentioned to resend once the backmerge of Linus's tr=
ee into
> drm-rust-next has happened, please align with Nicol=C3=A1s and base your =
changes on
> top of his changes.

Hello,

I'll add Pedro to CC when I send the v2.=20

Thank you both!
Nicol=C3=A1s

>
> Thanks,
> Danilo
>
> [1] https://gitlab.freedesktop.org/drm/rust/kernel/-/tree/drm-rust-next
> [2] https://lore.kernel.org/nova-gpu/DJFVRMR67B0W.2AJBHU1PWDPFT@kernel.or=
g/
> [3] https://lore.kernel.org/nova-gpu/20260621143647.264770-1-nico.antinor=
i.7@gmail.com/

