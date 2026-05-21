Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1ADCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0647310F659;
	Fri, 22 May 2026 14:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qkfseh/S";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6259410E18C
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:28:25 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-13643f6d1a9so160168c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 04:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779362904; x=1779967704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOrMn42JIi4qVYWDtDVlJUx7fmd1ReUe1tYeo+4md7U=;
 b=Qkfseh/S1wVnVj2RQ79tomAgQsTexxu1jv7bc4liWbcqzG9jSnvTfr6LjlK90gEcZ+
 kmrY9Ei9yvT3ZPkRS+dLm+beDFycS+Zof4mC9Ors6Pnr/j4/wY70te9YzhRhHQAH2HqD
 imZnRveSubIV9Oi+OB/oGfkdRPev7qXmBQbRpE4+FdzaD0tDd61dbB7zTEr9lZdQErNF
 dj5CxevCZi3jRFgGeE3AP8CMvfeXHL97U658bqOCyXzoZ7IXM7KQk8b27q7tXccZRB8R
 9B527XUsL+Y96xiGIStZ4Wdath4AT/u2yKr3rdN+bVFQvvxviuAgMFj1+dNCod8s+yUW
 n0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779362904; x=1779967704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MOrMn42JIi4qVYWDtDVlJUx7fmd1ReUe1tYeo+4md7U=;
 b=gw5o7mEwOOr6uVgO96Iv7vZR6kVHE9vVtOG3rxhtKbTZqIydSAKr6ZIpLJFhxH4ilC
 IJUW9MoGYcmwFy3QjweHvbgDw8wRvhA8ZNb+APEJMRWEAXYt3cA+HjS5BGAUvkk1qJw2
 N/D1r+nqcXGbogRcFmyUHrkqekH5lQrg6znQpZVfqyGjxER/Q/poXAFX1sL7z/gtH5Dz
 xANKRi7S9eaDyjWq3eBzxQvf8Z4hAh/wRduIG5ms/M7SMASooYj5dll+wQyB3yaFZr7t
 LjJlgQDCnABKApWDdZglvj/GE8/r2Cw5ehohmD6ljgNVsuH3pIxxOe+IvUVuZdG/eso8
 JnxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uIYYJptnGizskXXE90HHMxYu4kt9TGPWmUUlXpC14gcwb8VpoQ2m2gWTFFuU7TUPBZh0bUDplcX0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxu4WVPPiV8KsydY8bB9EBccPFio9J4pDbmHuHjPFyB7Jg9dRw1
 JroRtkl1WdvswT4ykN/WAYtTItaKkWPsA0Ty+wbf32aNnEWtF2GJqH1Z
X-Gm-Gg: Acq92OGbvC0dGuwb46hNvtE7EzZBTpc0FGOPHBpjBWeQkCT7GhuKr9af081JwLcxgJk
 HsY3UTsarUXpxYlaoEXzAxcgewjJ0QOhEml0AmOOQmeFPrzWE743EQjC8PP5pBpXNh+hya1uGLn
 nG1bF1H4+Bf9jsVPqzXKmlkzjHQCVMQUTegMG6kYTEsKaRh4eqWXoNLufXFree3FJav3PufxTqR
 NLK4mRYoMmWyQSfQklOw+MpZY50+LAKwuh1mh/f13RDTVzaaHUaSDUk9ChFRSse0IVlz7XRla9X
 fcsPH4aUolFPsldI61IEttuR4of4KpvhQmE83oGGrXuyBAmgUTgeJO5ZmLvMjAkddwWO/jThvxr
 MmkerSsegU5f2NF6txGvnuSKboOt77O2LvyuKpJW7rPUOTuQpIg5UQqibj5TNhh1P3NB1WnR2Ps
 SQ6i+kGAsdzD0M+CIQsUojlrxe3TbjWBRA58uyU4Nobg==
X-Received: by 2002:a05:7022:384b:b0:134:fea9:f106 with SMTP id
 a92af1059eb24-13632c34f37mr1180557c88.34.1779362904342; 
 Thu, 21 May 2026 04:28:24 -0700 (PDT)
Received: from wujing.localdomain ([74.48.213.230])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13652ac2afasm27839c88.14.2026.05.21.04.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 04:28:24 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: dev@lankhorst.se
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org, mkoutny@suse.com,
 mripard@kernel.org, natalie.vock@gmx.de, tj@kernel.org
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and throttling
Date: Thu, 21 May 2026 19:28:19 +0800
Message-ID: <20260521112819.62182-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <63878874-39d2-43d5-9fc3-68addf9ebbdd@lankhorst.se>
References: <63878874-39d2-43d5-9fc3-68addf9ebbdd@lankhorst.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:05 +0000
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

Hello Maarten,

On Thu, May 21, 2026 at 09:45 AM Maarten Lankhorst wrote:
> It's the approach I'm more worried about. I believe that it's
> better if we punish exceeding their high limit by preferentially
> evicting those.
> 
> It would make eviction run in 3 passes on the affected cgroup tree:
> - Round 1: Clients above their 'high' limit
> - Round 2: Clients above their 'low/min' limits
> - Round 3: Clients at or below their 'low' limit

Thank you for this concrete suggestion. This 3-pass eviction model is 
exactly what's needed to make the dmem soft limit effective.

It addresses the core problem of providing a viable "recovery action" when 
the limit is reached. By integrating these thresholds directly into the 
TTM/dmem eviction weight calculation, we can achieve a more natural 
over-subscription model.

I will rework the series for v2 to incorporate this hierarchy-aware 
eviction logic.

Kind regards,
~Qiliang
