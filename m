Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC39C55172
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9918C10F1E0;
	Fri, 31 Jul 2026 08:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="q4fi+c+8";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0E410F1E0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:48:28 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so645722a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 01:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785487708; cv=none;
 d=google.com; s=arc-20260327;
 b=Opw8BFwHcjAQ6GYPyo9OENOQRLol1lSNPU1Lb+GXc1mdwGaaifa0SJaVHLUevaLY04
 0qc3iaoYFNS9so+rQNqRZtUwkpnCsrKrCeBo8QnFfVuzJNJy/eXEFk+eLk8M6Yj2fB/f
 xAF4rCuxzmsoawt2FsHb8HGH16VtSujp5zhjjSPd2Euseg4WYqCETjojti1so2v/j6X8
 6b3e/6XAu09Hb9dK8WSmf65YikLkXnaKxMAdumMEsEhTvSJhtaEfI43SvN6QO085yjLC
 a7ILSXsnJCzmJ9iycMYB5QzC+YG/67DUgY90KPTtoEOFAA6y+htCjTvQczvzN6O7d+Yq
 n6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h3jMPa5VgDvbLXeDBYUoxxOk8uTLiKosABN7Ip5dVdw=;
 fh=Wvdve5Np6C38sx34CVAb7Vu7rx9l1diGTQTUCHxD8Mk=;
 b=Dy5YiC2822YOq9fWL0hGuOMhbgCb85cOBZHPpoxQhQ6lj9unAuRuBwW0MAMzDIv/A8
 3jaORQpf4ixjN2qJgCnkwSgQy/ABwRC/e0O7y0O3nkjgyTosrqEZshP3G7NBkuHFG2wf
 N04qqoFPSLHgN2uUc/rCeoWtNuW7TU193MsWFJkpasjbOCDWwweXhBowUQF/1QlBafht
 W2ZZqzTvbkC68w+VHWJVOkkgaBzsO8wSz5j3Ltuu368Ix7WvXgDrHANfj3pPrb42KEaf
 AoivacXu1UaJEWYzzlZ3Mhe+6iRmnmr8wNhA6aoIIJLhTT8mhKDxAgtltd4VCyH37O9C
 Mbmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785487708; x=1786092508; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h3jMPa5VgDvbLXeDBYUoxxOk8uTLiKosABN7Ip5dVdw=;
 b=q4fi+c+86FbvL/tcGMp5vg04OnUmvzHClq0XWVZwWYO6yJCrRhM6js16uuTt9pBtd8
 x6V7+5vIaH82TQ3WJNi33odVnbYeDJHDG3Htpf0PlfdggKSy8A11DZxWLkIyKfw47EZK
 8Gxdt4JmLtRMsOVYAGmMGJrFoYD2v70I+75J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785487708; x=1786092508;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h3jMPa5VgDvbLXeDBYUoxxOk8uTLiKosABN7Ip5dVdw=;
 b=dhnBplaTUSezPmWe3+gbR33rsjq+gCdFpu0fdFaKbIECOvjtcNeUEGn6rjR48KXpSb
 aV+J84qQV1YncGknVXqRlCd7veZP3GivLQtAchpeGwqvKFf+RijqgKCFnSnWyV39LiUt
 LytfkTJtox/4l/t/CJyJRPC5nKwKDX/QU3hEatIOTLWfexZD9q9+siEZHzJV2tdEB3fI
 wFvqYoJeHgyTUvDrD2vHHsV+m+KBaqfZ1bM7z6cmzLrHG48KYKPdLDekMNqDc95I1M/2
 yUVoCAlp3bbFlOkuh+QI/l48LlBDV0LcppxHD9ca/n+XQ1Zd1i0kmzbyPceE4zdaBLf0
 NFBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQ2rdBlrrX2LxCM/pr7ScdIVcxU8F2E6ckRQwVmFe5NxjSvVQTrbeJGqTe1Aotuhn3ZMk5RO4lK5M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyZ4AHg7MOsBfSaWB6dRX6xMq/phrxJ+3zFyVrf48wpLfC9g8K
 9YtCXONQSXIVgzBDRPMZSzL4DeOesMoA/TODSS9tQaSKlw5NB41EbgA4jcO54uVPG/s1ht7YmUW
 E2F/AF6Cip9KDqn5bCzzf2r21xmWpLIr8w7KvResPyA==
X-Gm-Gg: AR+sD10x/FCusR4qahaBj9kV3sQWhZAu7dREsdqZNq3jACoOrlkQiKKxhG6OaMUx7dr
 X4Z14/pofxwgEoBMGLugUTMsuvoS5Lm9nD58J4izUfUlE/DSxHdAnIFjOBeT2KmQHXxIiREIfyA
 DEqYzJp2yeCX/fqC9jtGxZCcGqWSntIKo5ut0yfnuwuYUwjDMm8/qMlHDSmzpJIwEa33LIII1ev
 PkLu3rAjWrgwoY/NBkZ+S10Yt91updfBv7mqEyXdmrLKRDIZwFz0MJTs+XXbVGzz0Ow/FWr296M
 TDQNnzDgQdgJIck3pCtsCzE96T34YjqQPkN7nnBlKN9/ZhPJeTxwUq7p9fBbJ2Cj7LEhoZc4ywg
 yjYk=
X-Received: by 2002:a17:90b:4c02:b0:37f:9cdf:f0ac with SMTP id
 98e67ed59e1d1-38fb1237e57mr1290285a91.27.1785487707766; Fri, 31 Jul 2026
 01:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260730182640.2808572-1-daniel@0x0f.com>
 <6bbf7e18-92b9-4d18-beb0-0c9812fc7ba8@gmx.de>
In-Reply-To: <6bbf7e18-92b9-4d18-beb0-0c9812fc7ba8@gmx.de>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 31 Jul 2026 17:48:16 +0900
X-Gm-Features: AUfX_myHmXENWSiZrV8wfENluDNOXYEjKLu94H2h-tWDNEhBG66nzEA7Iv6u8PQ
Message-ID: <CAFr9PX=JX_s+J+5twareTYC_U6SRGazXo0XDP6e4r2R4f+q3CA@mail.gmail.com>
Subject: Re: [PATCH 0/5] fbdev: tdfxfb: Make "unbooted" cards work
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Hi Helge,

On Fri, 31 Jul 2026 at 16:25, Helge Deller <deller@gmx.de> wrote:
> Nice work!
>
> Series applied to fbdev git tree.
>
> Thanks for doing this!
> Helge

Sashiko flagged up some things that are valid. Should I send a v2 or send fixes?

Cheers,

Daniel
