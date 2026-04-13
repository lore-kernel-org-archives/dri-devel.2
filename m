Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547B9F34C5E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7AB210E4C4;
	Mon, 13 Apr 2026 15:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BwMtSO5Z";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A78F010E4C4
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:21:26 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8d68f702851so734697285a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776093686; x=1776698486; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBD/JgVsoz0ZuJmAgbQmjE5N4nkq2J8x1FpFUjapBN4=;
 b=BwMtSO5Zh+uRgetTbq/kvbpKQKkRYvzRSZzvjLu7gWltoNeCqZGjsRv9jcIoqjFhv5
 8QFwBwE/Jqn/QU3Lvzm2XuUiQcKoBl7hQNogdwHkC2ZFR0VBwOXK4E9kfxFEvInr5Qpu
 YdvyH6pzzBEleDvGc4OLlRpdBVkB7SW/sPf1kFSYvOk8ZnE/KL62K951M8qOaZ5SnvLt
 MyRrsWfjRs83v+jVJVz0MbyV45SWphJNZZZOCJD/1xoYYSZKyFO7cC28P3/j69DsvAFH
 x0cQF44dbnMneElfrPvR3IoO/cN1afvm6pCMgLEGjOpm/9t3A8lIn47kYlsnxm9E37Yf
 27dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776093686; x=1776698486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IBD/JgVsoz0ZuJmAgbQmjE5N4nkq2J8x1FpFUjapBN4=;
 b=nfrmWuTxc6YaW3NJB95EdY5Zf81JX5J107FuVrhyAyga7ixi7MVf67fcFE7EVSrEXj
 p3spz+tRTPdaUYNu6J9sUZbB6f5UX4uEcIR6EriIO5F9vrsxrDZHaK3d/2FagF5M0tBu
 lucsJNiXmmpHMiOZGdYbnnyNeF9aY/KYTv+4jG1mWfqnNi3tijUdgcXrxQUBlBwHa7ji
 uldXHj/nwD9AEF3Fb9tL4U2q2S3A3/S7IUq9U3tljryhTFtMvdYOILy2gHVbhe30ojt0
 ndPAvLwvmbow/jHryHdcIAuBJiyOY9kwWgZrC58Bp5y99xIBh5124nqkeVEOthVekfqZ
 7AAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xSK2yVQqQux0RUBkuj9CzNFo0E5nXlyM+kSTwIwe8+nx0zTJjBrirZObEo4F50Vl0yMpTo9TLXPo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGCxmNlBHF/f3DZVGaIKhpaoAg06MThGqbP4KKY4unC05+TF1t
 7v/jxq/Baw+PLxRjSy2/eJ3ZoKOpTBd80aQ300Y99PzENeq9+qFZrd25
X-Gm-Gg: AeBDies/o3NxBMjeLb5V4+b4uRQgXEXufxn4cpnExgCpIJmBeuStYQwch6d0HYFfFmw
 g3iqeIioSHDlGTrU+ShV4QESfJoveRcSg58VQt2Ndai0xJv3iJ4q0q0yXDnFnJ5MLYfWEbv/sgp
 cwqOnSQDXZThPLHoKptRiiAayza402MLLvopp8MeTjHwVjVBIQdgF5CxQ0ZYCn81SQge3lBMZSC
 +lNOXgDIjaAC7Ms6LrrZG1Eszuc1QgZkoC3QjcynZa3IXOqXqlDZfsVlO1dzPHz5jLdiBMFiUA+
 GHdZ0m/tMbpdkeE5NHzR+/jqQkb1v8es5GzcfmW4deEje8TR8vQwxGEuw8nOJiJCMOgXFfvUgVT
 v1TwBWj6gODwp3g8qccswyvSUvygNMGOZtrDpFUSF6yk3utH8ojX/6uc5OWDCBdJons9Ji07hRb
 edYd7EeHQJna+NMm32njQrDLpfaF0YDeevcpwaPsIXnUm2zKdTXP/CDABeIUD2i0IIdwWC+nXNR
 1d4Z3muFKmZp5Py5RxJ3ZOVqtbf
X-Received: by 2002:a05:620a:1a11:b0:8cd:b3dc:9d4e with SMTP id
 af79cd13be357-8ddcf1b8049mr2119875185a.32.1776093685356; 
 Mon, 13 Apr 2026 08:21:25 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb9351afasm864057385a.36.2026.04.13.08.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 08:21:25 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: mcanal@igalia.com,
	dri-devel@lists.freedesktop.org
Cc: itoral@igalia.com, stable@vger.kernel.org,
 Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH v2] drm/v3d: Limit ioctl extension chain depth to prevent
 infinite loop
Date: Mon, 13 Apr 2026 15:21:15 +0000
Message-Id: <20260413152115.3444105-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <80158c8c-a270-498b-b947-bc3276359d4b@igalia.com>
References: <80158c8c-a270-498b-b947-bc3276359d4b@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Maíra,

On 4/13/26 09:16, Maíra Canal wrote:
> How about checking if (!multisync.in_sync_count &&
> !multisync.out_sync_count)? After all, it doesn't make any sense to have
> an empty multisync.
>
> I believe this is better strategy than using a hard-coded max.

That check makes good semantic sense and directly closes the attack
vector - I agree an empty multisync isn't useful.

That said, I'd like to raise one thought before sending v3. The reason
xe and i915 added a general depth limit wasn't just to fix a specific
known loop - it was to make the extension walker generically robust as
the extension set grows. If a future extension is added that can also
tolerate a second visit without erroring out, the unbounded walk
vulnerability class reappears without a counter. Since the current
architectural maximum is 2 (one multisync + one CPU job extension),
capping the walk at 2 would reflect the real limit and provide that
safety net without being arbitrary.

Happy to go either way - just wanted to raise it before sending v3.
What do you think?

Best regards,
Ashutosh
