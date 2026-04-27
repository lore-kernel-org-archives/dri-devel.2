Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52183FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A5010E2BC;
	Mon, 27 Apr 2026 15:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Gptgnqbr";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCA910E2BC
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 15:16:35 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so95912665e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777302994; cv=none;
 d=google.com; s=arc-20240605;
 b=Ko8emt3kJK3Q+1/j7sqzVXF9c+00UE6r6VFsD9d3D6w6PojmPSNHsTQu77iWfsf1kt
 WfV4j4maB37q163HRHZyuUjDFZFsV+chG5n6Uwxytz4OfwYgCbYYxpBr4b3o7zRM0WV5
 umSIQK8TXyLpRlAL7yepwT8X2asB7ArvB18Jc56cCzYTNKtnYaQH2+5NaQF897xh3/8X
 G74v4HD0q+Y80KzV9bVSqBkNXN1la1rzLLnOJjU2ykzyw48gKOI8MMcBuJmoIAscL/Xg
 5dLT/0VqGTzufZZS6xzQmRzrpFGLue4GIM9roAogrWbBsS4spHekrX4v6lrC+JuuFgG1
 +Pfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PJa9bMhGX9RVMYwyZBZa0XCG92DEldh3qRNrMqjc1p0=;
 fh=imcKPJOOhk8YbAI9ahjP/tMThpm5r22LIyvM7xzr0GA=;
 b=Ny+l5ANRCc4ow3K11OCM27gXpcOHSKW86wVJmE2zYpABOjtq2FNcDKzzTxGYeEA4zW
 tmRULT+okaLo8JbVa8bMjonCRGND6BKtZk9z1IvlBVvALwEkj4Gi7wQgQjtto3ENixau
 APzTRn+jgFkogSbyntP9V5SMzkun0Wlv/ILY8xyuv9JMN1PC6PO4F5l1/X4dccl5Vx5M
 8xnKR8LuYrU7Ljl52hKJnW9Rr18kBj6mSBb1WotB3WwIjxbRgmY4YY3sHbEuoak0RvMu
 vkBG2LxJ4de76qbi+1q/G8G0C9F5A0XxiWo6JejprFOpacqdHfI+9VWxC/wt3XHqItoj
 6XiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777302993; x=1777907793;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJa9bMhGX9RVMYwyZBZa0XCG92DEldh3qRNrMqjc1p0=;
 b=GptgnqbrhTUp5XkdgQd2pSh2ALAQz+sTsnPIjZJFAJMiQ67PeXRTECdJtjb4ISkFXb
 f/ux4jZiLpA/6u7rDlcGz8xQzPaYXUx4edWtRqDrqYfrDT1Efvk0wr53/LC0DBK7r+Jb
 moi+0EFAnh4af9cmxCoS+lvZJywFUoQjDSnpXGTF+UYECSYileaBdffVPv2586Zsd+zJ
 7hXxCxeFiI1el5aZOaODDIKf56tTB5gigLOxLM9MCJZ2lvNK5mlwWRy+pQZDEzGIVVgi
 d/so4k88gZqglmT524bnIAQKbqri/MTCvQFaLYDfMOLLALz3+DoO0JjZ0qXjErdhuwcK
 Dr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777302993; x=1777907793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PJa9bMhGX9RVMYwyZBZa0XCG92DEldh3qRNrMqjc1p0=;
 b=IaZbZHe9Zbmxo4CoWt3v7ls4trL713unKhfEuL+Q5uoqwfGZ9sm3MyyMJsrp0/86TF
 T1S3A9hgV733POSO6+7gQMIMQCjX9D0XtdGvtugjkLpzZ3+44Rve8wD6jazf9Zp4AA8K
 P/K6viRjaU1pOTF1Csg8Z1HCsSp7xAUA6E05lNnnplOBBL/EWssoWzltBxVnfDrzwjwk
 J00ixdhUwJTZOQWgE/TpEfwohs+JGz+dFOFmEr78DUt4SQfKZtm7eSFomxYDMYJx5TDG
 AbsmoDGCPrGYxiRCdaXn12Ld9LYptvHvoY1G1gpj39jZfZDwJxsk8kjnGm9QDwLvuqqf
 e9pA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fVOm7aGcQmiPNmZ6C94SlOY6WIMx3laHVnicQMXit/Zpj0Rob5cVob+qdwgurc4WSGo5HFZj7OTE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNIzf0uk8YZ0ANnqqmGMjo6RNxotLei34T7yrhtQ6GhC6u+6vP
 MU3P45LtNJo9P4h4vPMHhEn0l/jZrJ7TDBuSD9A9/VdZl7JRhknI2dSryGnbY0q7tRh4oEnt5kt
 NChr9dKfBrqU/W36UlPgF+Eeo8EEHwu3aCtSzJLzD
X-Gm-Gg: AeBDievsVs16zWKwlSsz8tWSBDlqGx+CvRMHLYs5WyVh8+3sRlWjcWSqGNKzq8F6uly
 NqyL8FlXy8WZ+EkeGRTeRX5WRujXxSu+3cQv/LKXUC7qinSyuE9k91HOb2ef227PtiNJZnr7qwK
 HubRzhgRr/CN6wsQO7x4eknQ5B55X/cIM+/bgDFdP54QLtKng3TFubuYUSYRARHsGCCJ5Q2hzEt
 Xp5KJMVcd7QtAkNcwCmSzrcYHlhhXD95+JdAADYBFFL5dgGjz6I7FoILvobievRBCTUt1pYOMjV
 CJMHrO/bdh63W21vOo4oR8zuFgybgYNx0gxXwS+Ra8LrEbu2/jCcLQhLyOw=
X-Received: by 2002:a05:600c:4707:b0:488:bfc3:efc with SMTP id
 5b1f17b1804b1-488fb6e8eb5mr595352905e9.0.1777302992997; Mon, 27 Apr 2026
 08:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-fix-filter-v1-1-b3b197c65daf@nvidia.com>
In-Reply-To: <20260423-fix-filter-v1-1-b3b197c65daf@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Apr 2026 17:16:19 +0200
X-Gm-Features: AVHnY4KAY2QwmGRnuhedbg-TBD-sFQ_NwPHSYpSKu7X_Afz8POA11i5FEeRnKEA
Message-ID: <CAH5fLgitiuCiSOLbU5f8uUxYNK6fr22wLuP69BSEHMoOY-Xi-w@mail.gmail.com>
Subject: Re: [PATCH] gpu: nova-core: simplify and_then with condition to filter
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Apr 23, 2026 at 9:11=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> This code is more simply expressed using Option::filter instead of the
> and_then with conditional.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
