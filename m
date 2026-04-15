Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F87F9D0FD
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 02:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8334310E141;
	Wed, 15 Apr 2026 02:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dtMt3YVu";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6761810E141
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 02:05:17 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-79a60975dc5so70878107b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 19:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776218716; cv=none;
 d=google.com; s=arc-20240605;
 b=lhtlkXyJlvOLjY5H6V1dD1ullDXIdlCNrP/5L85Q8Mx2ZNN+AunYjiRKOaVp5KDR6j
 t0A9FqXUcC/rBMJoezRzuHomxwTckFkQZibFByyfs8YkvMLlEU/VnWyPpfScx7zfYnow
 3kS5+xktzPaVFTHgIhc9ZXT+n/gMobRPPbvt1ZvoyAqa0gv2LdJR5HzMw3apW2bm9gQx
 gUsN4UwSnusQ3WkW8WyBcgjWbqy5JC5yk8sbigzWybO9T+05Hfy3hdytg0EB+XNp7yBH
 tqZG6IH3Xm875XAePl+RsVJTlR7dQ1hoCU75avCoig4FVfxFPllzE1HvVx0uS5aWuh38
 Yhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=//BODY+zI/RuPgA6LIbKfU/QsiOSH1O9Jbam+W9iapk=;
 fh=VNEGqRMEIK2I8iw7RDFDCZSG5hc3aCUj//ThO22xqtc=;
 b=loMI/5KnwwtKqBr9EFyayNSGTZb842QxGbbKtgj5wgo4w1bOz7WlR5TotV7EFsuQCG
 yEVD6BduQ8UXDEVd08v4v9YytibNu/Z0vmAqvZl2zZBqblS2+rfJXpjJTLzF+t8JisF7
 Z4oScUffGZ2Wrz0pctVWHi8B3HairxYrhL2dEbpcc2fkQORnxnVI6aQ0WXk6jZRzSpwN
 FMCUCBSKx/hm54WYx6oAX4sbLTT6xPxbNc/+Pti75cqGzchUL2JenZ9ZHlCAQ3BwtnFi
 MRGDNywSuv6KEWTBnxNz3U4Pyp+M/ghc8qkMk1lQyM6B06TWHXnvm0vSAED7BkTnWWtF
 V9UA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776218716; x=1776823516; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=//BODY+zI/RuPgA6LIbKfU/QsiOSH1O9Jbam+W9iapk=;
 b=dtMt3YVu2nXIToDS6oOqD7NjqnER4FJ/JLWnqMsLZX+JRx6TDBXXFJVUQDc6V91h/F
 TWFGLRySTtd7NAiOM+EhcefaogNLDsdPzub0z9siyM+5Ouo+hnF3GTxvlrP3prWRhPHL
 jAIYYVo78M7o9U7IrTTwCFfNEdEbe7UUjcKRl7RvNMs2ixFHhlkF5eVfdRbni9XbiEOz
 a3N3ExIKT2mzgeaYU+MAlVen2wacbcJB9n1i9lU68JCoKQxrT/rlB4zL8UCvC/RscT2z
 442yyfhkgZJ1i2/psj5i0lDDr888FT5/QfYzmACRnM9tiaX1JDEUecyu2OV0zk+OZrJE
 hgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776218716; x=1776823516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//BODY+zI/RuPgA6LIbKfU/QsiOSH1O9Jbam+W9iapk=;
 b=r+aVyI0LQnyvm0wHm/sSikT5JqrL0oe1fWfPRfpq/sRTDNIqc5qTdJctFA41Rynr/q
 0/8gUhL31ZGDTqJ+oBqXFeS+r49R3O7lwe+oYXhm4TFfjr/+YqNan+6ZZU6hYKiWawzH
 OZeaKwCu+SvuatLI2taUsj1j35kyLP1xPkccbc4EuBEpmibYamc8Vz1Ks2lWXDHRRc1v
 oS0FGKi4rttFgjw7V/BweSBgbQaS5I/zy4QdcP6jiaqGtYVfujXiGaSKq1eFH7S0FbJ/
 9mZ3sIWivbIkGaKd3w8kld7f+dhSjL4NTFRH1GWsI9EVOOoIm5ANJk9vukZE/PaAY08X
 6n2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8X6mWYsLWzbw2O/1riLpszqF8rTsb5bM4Q0OofbTC8zVCHAjfrQ/bDzNy1BabBjyZbH97UW2pNKM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMenO/lgGjLwVLn0R+Ox06MG13HeRVKiFso/qmvYW6JB9qmzm5
 JYSrgMryTFe549xbHR+y6xI/T2c56ZgrY8HAvPxWLLMjVIG04BlrYwefpsp7XmD0gbHDbNt5Dvk
 ibcnpm6kIm1pCg2T+2JOV4epoCp3urME=
X-Gm-Gg: AeBDiesSbqVwaNkMt5TmBelx5cDl46JaHI7FRNvbGpCmdp3qJH1vEDS3GY93YeNUTTz
 MvQftKmB0T9TN+TfLyJy7I+bWmxmuWODclj6ySucovJXWbRu2ZzwBE7gd6tM6ZkBm9QvbUTZ3To
 jYSjDkQNxiOUYrpKSRLj/uHqnXKDVrMo5VSjvzhule+I5tvi2hrHbrpO5VVtOkLWLlVea29CP3z
 USCbNePwolUZ5UDnh4bq4QyJtt0j7LCBd1cmDq+rO8/gp2aluiv/p+PxER5keZpgxwWd7VzEd7z
 CpgqSkfqYqNxJ7OEJRQO
X-Received: by 2002:a05:690e:1488:b0:651:be70:8661 with SMTP id
 956f58d0204a3-651be708b12mr11714648d50.67.1776218715884; Tue, 14 Apr 2026
 19:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260414121024.3142118-1-lgs201920130244@gmail.com>
 <4b7a0492-6ebb-e0a9-ca48-f2da6002d3e9@amd.com>
In-Reply-To: <4b7a0492-6ebb-e0a9-ca48-f2da6002d3e9@amd.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 15 Apr 2026 10:05:03 +0800
X-Gm-Features: AQROBzCYi4c4CkfhIjGAtD67f3EUwjXInr63HBlRDkKe5deoHv9cic-8YRXWHUg
Message-ID: <CANUHTR8ZBK8FVgc329=027FfyvbOVSN3+coZx+7B3x834dGY3w@mail.gmail.com>
Subject: Re: [PATCH] accel/amdxdna: fix IRQ vector leak in aie2_init()
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, George Yang <George.Yang@amd.com>, 
 Narendra Gutta <VenkataNarendraKumar.Gutta@amd.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Hello,

Thanks for reviewing.

On Wed, 15 Apr 2026 at 00:06, Lizhi Hou <lizhi.hou@amd.com> wrote:
>
>

>
> aie2_init enables device via pcim_enable_device(), which sets managed
> device. Thus the vectors are automatically cleanup. So NAK.
>
>
> Lizhi
>

Sorry, I missed that pcim_enable_device() already makes the device
managed, so the IRQ vectors are cleaned up automatically. Thanks for
pointing it out.

Best regards,
Guangshuo
