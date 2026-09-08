Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEFEC79FAB
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D8D310EA28;
	Tue,  8 Sep 2026 07:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gp2dDLIf";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA58710E93B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 01:19:38 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-451a49abd8aso3795150fac.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 18:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788830376; x=1789435176; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C4iTZNJwexeZeeHQj3UOdA9eylxa0Qsx4P1q2zIlRJc=;
 b=Gp2dDLIfdAAVgbB372NCaDKv+Xx0PThSSqAgZ9ETfy4wV1bJnCizUw0ZnBcR5NAI0+
 2mzIDm9jD4kqCT5U12SoimcpYwhWjo9bu6FGhxCYIs2ba6BaqdPHvV3xlyJuub7kXg9W
 GHifqBA7CIp15vuFRxkAIeEbAWxK0CmY8d+i2jvqMFQIZTQiLQBzJY1Q2KZwsyGaL47M
 UXcW++mRghBF/aU72NC/HqgXEKIxyEKy8ksG65rbypwx8gNcaH4dL1xIcdIGHpzOp7FJ
 J+q828IkkYFsh/kIkUDybhfYzgJXbWCpHkrPsl8chxHoUUfNYSvPI7K66+bljHb2DOhF
 brlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788830376; x=1789435176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C4iTZNJwexeZeeHQj3UOdA9eylxa0Qsx4P1q2zIlRJc=;
 b=mzyesj5Nn1sj2hveJ+Td4TV8iI7rY9q6fMOcvRWrj1QHtIn5L7fjlRHfPy08PUi9eq
 ZYNQnl5P9ljUo+PnRtzAGkHuNmRTAnGxBdMYJBVAffJenhaDenPXY1pccKX3f/JygR7D
 DCCZl0f+0XS0g880vkNImO1aAXbx6rBvRvjIVoL+IdQ/Htwmun5wML+9hVhpsH5QFHNy
 7ILjscaJPRkWIp/IAwLxifeRXedmeLKW1sfVPxJedoavGXchZpQLcVnCz83/q7SYwztq
 9kKnUOT6mMIbpEDbuzwgtMWl/AYR9/GVfs42q6ua1bLGpC9+osMBnLnGw0dJYf/vqCi8
 bdEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyuQ6ml8Se4hMKs79le0r871n0Hi35ouHUEa0CBZOnfMSZgFmYaBGN5tNE5Fl8x1osYBGM2GcF92s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nW8BYCrjLfBHPOlED1pPK6ZJ/XTBglkjfvQ9AzM0rpAbWq8smQ
 H91GTMIGdnPaU08TlZe3DdyrkO7ZcAAXTaUKmlLQX2xcMHSyzVGpWHtx
X-Gm-Gg: AYBFou3hdzPV3ZiernYeBlJf3XKYskmVap0ACabahGc3yxVNKbDDqZIEFf30z0ajl3R
 O0PrWdrhhdCh9RbEWKlcz3/k9YdJ7Alr1TjxweFWeQ2aMV/7xZr8Gfx4KG7VZ1020eicMK4Mofv
 csstca90y2HdR7/wl7BTtBb27OTJd+dLYy3VwAEqo28qrbGmcH9+wuhpEu7yJkR4fLBF7YWxL50
 JCPZI/X0gHwLItiL086h1PyxkJ40WBize9nZp29cN8TmkdD6z+hV0wRXK7h9KbjQVecCwfaimDF
 jTEocSU8QVUTj0TDaGr/jjUWOUgRFvwslh+WMEqjwLGKZSnmhszj0sHF8wHDP0iVnrqnddvbDx2
 E5lMXyltZ5jgsdezaaHBgj5TZGda8BDJyy3xrOXpiNHYZScsI+XKb4fZDTyYpQnTUsFkXHXrnrr
 PUO6z8FZ7hk8wYtET2NWDXFbxa1PU19GOs4vxS28qWPMylBI7Bg4jJC8jA2t6nHlvnY6RzrB46t
 IhyqKoOdFeDFy+6Cg==
X-Received: by 2002:a05:6820:168f:b0:6b7:83c5:fdef with SMTP id
 006d021491bc7-6b783c66750mr12147449eaf.48.1788830376431; 
 Mon, 07 Sep 2026 18:19:36 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6dea11aeasm14793941eaf.14.2026.09.07.18.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 18:19:35 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, dev@lankhorst.se, mripard@kernel.org,
 nat@pixelcluster.dev, tj@kernel.org, mkoutny@suse.com, osalvador@suse.de,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-team@meta.com
Subject: Re: [PATCH v5 5/7] mm/page_counter: introduce an asynchronous drainer
Date: Mon,  7 Sep 2026 18:19:34 -0700
Message-ID: <20260908011934.1737458-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ap9HiQv7_9cyIe2e@linux.dev>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

On Mon, 7 Sep 2026 16:25:31 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

Hi Shakeel,

Thanks for your review on the series!

> On Mon, Aug 31, 2026 at 09:37:49AM -0700, Joshua Hahn wrote:
> > The existing percpu memcg stock drainer schedules a stock drain worker
> > per-cpu, one for every CPU containing the target memcg's stock.
> 
> But you are introducing remote draining. Why do you need async drainer at all?
> Just always drain synchronously.

I was trying to match parity with the existing code as much as possible.
But I see now that this series is a bit complicated because I'm trying
to do two things at once and mixing up the page_counter migration
and the scalable draining together.

In the next version I'll keep parity and only migrate to page_counter
and in a follow-up I'll address the drainers separately.

Thanks again!
Joshua
