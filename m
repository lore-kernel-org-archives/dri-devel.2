Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B35C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C38C110E055;
	Wed,  2 Sep 2026 19:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CTDe2yLc";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC1C10E055
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 19:38:16 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-90cc372d6b2so18735666d6.3
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 12:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788377896; cv=none;
 d=google.com; s=arc-20260327;
 b=dwnzIsoLeYC4FL85Hd9qfDLSBCuPtaKHwyzCWcruwSYycI+QSlPWsxKH3781z0TlYo
 Ix3ICkG/lVkAQQ/7GupZHOCz3ZVdy+2mm+wHPeaXjLXbT4Rwth99x7LDDhHjkL3TzaP0
 SkrPt77KrM7PJlKcSIPs7CLOJhd+u+9wa7L/iA1QahwPPKmU85Q4Ekdt5cEBT5cGeHyx
 DfDnfAMF8DT8DZkwZgcUKg7pI7FefNqUywJDAcy6KkWxNDeUo7r+8jC1ZoIIxOg81lI7
 UibWlTGHgKg8paoeY4XKH8SVd5jE0WPbeeV3UQJhvdkAvr6Pupj1zgSqcld8bpzaQG2j
 8RFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qi6IviIPOnYguj19GkTxZ7dEwOM9cpzsCiuJk6eQ3R4=;
 fh=3hSaXqxEPDs96Q5ozhtuF9xJHuxwoszNHHB81DIYL6c=;
 b=jB8BacocovS2t3RsRi7+xVMMaH4VqKkV+B8PWFf1skEFUMI1wrykfa+W1q23UB72zO
 RFxhiYSjmaXc3qzwxgBWJ74f/wXz4gA+jVRyIaFjzKsfJCc5k/15clj6zMSHv4j2oUDW
 wfB/sCsVgjWezMPVWIt2NgC2M2RPifzKL/VkAhaet5Nqb94jRQ6TLR4cRxXcYK9yutbq
 GUZFeM3Yj7IwMvbmg+Skc95JyMFoDFw41dus7QBf2O6huYgo8gZSZJQO1wbWOvC0URYs
 at0R8jG1ZWH4wOT74T3XgBmmAxSBd6UowRU8EfOLYqM06XztGrT+GVCK3kGG6/TqjuJE
 T9sQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788377896; x=1788982696; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qi6IviIPOnYguj19GkTxZ7dEwOM9cpzsCiuJk6eQ3R4=;
 b=CTDe2yLctfQzq4JtYTUZWhmjkTjivM5J2RPUypDcnE3K1ygI/aF9CxoQ36uxIBFIbi
 rMjiwiaUajQtpXn/JV3TC2FtlyjpvslEDzf4d+QwaqRNa7vS9aX0Ls7ZUhwgVafJEn/c
 nkHXXD3nOb3/gEFWpwa4Ai7Gf7px/DQeolG3Lwq42WZz8ZGfWPyblIdpGnQZ0YNDFgwd
 F2JgfOEw+/GsuiSZR0fS9jel37IDnD0lmjQGEDgNEiKpPQWiJPWE8IZsbuprD5xPDY4p
 KBLRVtFuBLH0rCucDLXBsSTC2IuVHjg3Jv/bcPG0ExKbCd4GK8FVAAkLiZvKkPnIugM2
 LgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788377896; x=1788982696;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qi6IviIPOnYguj19GkTxZ7dEwOM9cpzsCiuJk6eQ3R4=;
 b=JUZ0HUCCPEv2Xk6xU83NPVMBCZInGhnJ+uegzuwg+z3U5a41Pvh2rjcQAgbC2IsPDo
 x8jfFX4Eo4J33+BFBvJRec2iF6bCIqpU7wFRLF6MwkoKh6K97OCnEsYS3MtJsetrMh4f
 hA5dXE+nSej6T8v6ya0r9994ohut6m/j8rfN1buwkBJFOP45z3n9Bos+i5Y12ix0U+YN
 RQJZkya9Y6pDi7sO/OitWeKAPesaxWYTCt3PERLnBYgx3b9awpPLzEvgHJmI66V2wsdb
 Wyet2LlrEcAoQwcVD/sK1cxQhiz8Mfn9Np4gPNVJc6lWWtf3+EP6Q2obqhFqY589ccHj
 ofYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzASpI+EfxyYzr/7CvKf2oF/8tPrEsrG+wxGdY7Gy9e3BOM81l0aVwUIplmWZYYuW9UJku+ZOEgokY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lrllW9IwiC1TZJzRLziQHPuaCfoxYwGfwjhq+KjA8OmOqL88ZL
 h3nT2UqKvJePYApiqOCxaZxKOsgQZd/sm4CTkc2/VVY/3K/xQvo8khVxnA3iX2atlWMuvtiKdd+
 eoxutTBUpkSyvXAOId0Mg+KAqnfand+s=
X-Gm-Gg: AYBFou1ANQHyEORFv8J5CqgF1dWW/lOS/XXr6ZtAaS6FyPfjEU+MXCYh0mEZ7O8lIoU
 BlIf0kWddqmWumEcdKcPN2PD+54uKA9bmWD0CojBMcb6sNSC2YwFr/9IkwEHSSB9j1Z6cD9qJZo
 re9wTyRIEsfFFkDJ6+vnJ6YzdmLmGS1q045prV+NfVsM3yRQpf0odKCAnoyqiydE2MGunX+eXrM
 y0+Wk3H1ERSNW2jMIrJEGC7FaNKBa5INURCfg1S1v2X/MS6wjqFTMK0XpUQ7wCLcpDDaiF2GAc8
 2M0pEPErs8CPKEuCQZD8a8llxqjczSBsQyISNG04vC3tSewj1tf8i7IVXOejZOyxEpTVAh12RmH
 PenOVvp0qat3dFWqAI/sYU3JufmVVXHMWlffCZrfB
X-Received: by 2002:a05:6214:2123:b0:908:951f:415 with SMTP id
 6a1803df08f44-90ebb005390mr85498866d6.13.1788377895624; Wed, 02 Sep 2026
 12:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL373JA1ZANX.21L51RTEUQ2UG@kernel.org> <apZCTUYiN5FHCkCm@nvdebian.thelocal>
 <CAPM=9twQxnx5DDkjwXWi-vXM4kqUQQdPaL+=1ASS0tpf2GmnYw@mail.gmail.com>
 <apZbKc5xMQ1yTBTu@nvdebian.thelocal> <DL3SXIIA4FID.2V3K5YC91RM3V@kernel.org>
 <apetgjQ9zWpJATj3@nvdebian.thelocal> <apfJhtr6BpMosz1q@nvdebian.thelocal>
 <DL52TB47MFFY.CICXD0XQ3T5K@kernel.org>
In-Reply-To: <DL52TB47MFFY.CICXD0XQ3T5K@kernel.org>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 3 Sep 2026 05:38:03 +1000
X-Gm-Features: AcwNN1V_5ha_snCzThXD4CKKNnM_EsprQAGBXp8YrnRXkYcD_qK4vrhdwG6Bj_k
Message-ID: <CAPM=9tyXx=BVy9E6PZNwYwab0SWWpFOFgX2jktqPVumiqY2viw@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>, nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
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

On Thu, 3 Sept 2026 at 05:27, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Wed Sep 2, 2026 at 9:05 AM CEST, Alistair Popple wrote:
> > On 2026-09-02 at 15:21 +1000, Alistair Popple <apopple@nvidia.com> wrote...
> >> Ok, so just to double check are you happy with an accessor to return
> >> gsp_static_info as well?
> >
> > Still interested in your thoughts here though, just to avoid churn because I'll
> > probably pick the wrong answer :-)
>
> Yeah, exposing that for gpu_name() seems fine.

Though userspace doesn't probably need this, but we could I suppose.

Dave.
