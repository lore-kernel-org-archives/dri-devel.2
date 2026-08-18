Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A955C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A1110ED0C;
	Wed, 19 Aug 2026 06:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="es0Zd4Nr";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FAED10E49D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:23:52 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2caf228a910so31575955ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787027032; x=1787631832; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YQFZsKhmESUwEHTXIf0erBhkQKCZAhCVRTJv5g8p+dw=;
 b=es0Zd4Nr8usB5u3LZcXwgf7+QzYwSHB+cr3v181GaMhFw+cUBFUoWgoQywx5ZMjTjg
 qSKcyjQ1B6L/pDNPYrcfU+IRzeVIP9j4fsp0R5OjlYnIgSU4kVg2Z8IsAxFQaceWh+EK
 qnQpZw/gpWIP5cKpNMzQ59mXe1UdMYdQ7PKZL7ofm+uOLLXwUC0PgbIRh2mEc4rted2h
 xbPlNgM2gVoKrjKr9KXnIJFAtuCK4yGy2tWGIKZ+vctVJzVFvpVzpdIHA6Ecu/iOcaF4
 TOCnIf5WwpMqxzPAWvz2hKOXctUOlYjl/Zhsc+394uGuzTNCrZRr5Zf9P83icpuZtXdV
 9hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787027032; x=1787631832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YQFZsKhmESUwEHTXIf0erBhkQKCZAhCVRTJv5g8p+dw=;
 b=Ty/UBrEnDPkQXKinEvJqLRTnXi9j/+BvIfRV8joUOM2nhmKSfh8BFl5/JvmpAEvyFJ
 W9130I9l52ByQlMGrnBxJLTb4KvKluvRLgh1foWPaHP6/tESLygJfEhWVicl12kggnm4
 2E6LITcPGL/8aF71r9aE6j5PeZGaoYvc0V4OM0eZ2amQWKdxeqr+5IqKhDiGEAEBDF3H
 /nnBfXKy+ifGzfxQC+a798yldMJRUB3NS4OeJUGfAVODU6/DQW/Q/GGc5aq85hIi5iDs
 FWRRyFRTw4MllqH1BCNlMadPt1REISQpcXzSqpjmhXdbnc9cz8TWVBPu4lrn/VRJflu4
 mMtg==
X-Gm-Message-State: AOJu0YyH1NDAcvYvv/Ld6lUyRroRwLBBwx4sa8pEYnjOdqHyjdHfF7rK
 gpuf614kLNcdbKu1D3k4S0EuyTfagio6xffW1u5Naioefg/TsjfyQLyg5yN04IJU8KDt
X-Gm-Gg: AR+sD11TcQZjNQbfNRlAugNrsn1uevDZE4J27a4kvBqZHua+Af6VMuP63buKKsxPZp5
 lZJ89O9gJ0LAjMEG0vFUi96R1lIChzZ4MRK2Oqvd2gEbbbcTYntDoGRZAQJ/abHJURrgCin3Rbd
 8FqF0Pv3/r3Ib1DnP+KnidgSSzzX9OZHGulw4vBKIsbZPXeA48zGnvOFqa4iZdnZpPfp16VNZ7h
 uOSqtJ5PQ7h0UDnw5lOaYGRPG/8ixeFCkMCyYsvaCcb7iGLDrPhHedQPHCvHnp0O2sTpsr0acLy
 N8d0otKHD3V6wQOsn9SWoKdQHDrwkPSDMy2Bbwe0D+v5mg5IaIfC7Yac2WxSJzKda7rS7xW3nnu
 0SwDOpIKx/1U7uC6D3vHeQ1VwrqKhvNDqtPH8KwFYChW+Adso0QhC1LRIU8+VPr85qqAEdJSO2+
 h0hL5KSi8EvJVcmCEgQrK/5en87DMoJydXb6NbZV55OM8w/Bvtl4Fuvg9IiYg=
X-Received: by 2002:a17:90b:3841:b0:380:f34a:6ff1 with SMTP id
 98e67ed59e1d1-3933b9483c7mr24865790a91.17.1787027031651; 
 Mon, 17 Aug 2026 21:23:51 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3954d3d2adcsm4439463a91.17.2026.08.17.21.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 21:23:51 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: triet.hoang.dev@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 markus.elfring@web.de, ogabbay@kernel.org, royalnet026@gmail.com,
 tomeu@tomeuvizoso.net
Subject: Re: [PATCH v5] drm/rocket: Check allocations before use
Date: Tue, 18 Aug 2026 11:23:48 +0700
Message-ID: <20260818042348.1584358-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818041505.1579320-2-triet.hoang.dev@gmail.com>
References: <20260818041505.1579320-2-triet.hoang.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

Hi Everyone,

Thanks for the detailed review. This is my first time contributing to the
kernel and using the mailing list, so I really appreciate your feedback.

The thread has become quite long, so I'll leave it here for now and wait
for feedback from Tomeu before making further changes.

> I have not run your patch, so no tag from me. If it would help, I can
> test it on RK3588 with three cores and again with two of them unbound,
> and check the single-core case with kmemleak.

I don't have the hardware to test these cases myself, so it would be very
helpful if you could run the patch (v5) and share any feedback. It would also
help me better understand the behavior of the driver and the testing
process.

Thanks again for taking the time to review and test it.

Regards,
Triet
