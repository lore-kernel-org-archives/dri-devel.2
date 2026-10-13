Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C6FCC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2FE10F663;
	Tue, 13 Oct 2026 09:28:16 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E436110F663
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:28:10 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48b02b1b4cfso3033752f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791883689; x=1792488489; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:cc:to:from
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SnFh6viEqDHD71Gzj13GpEJAmqICbT3oCU6mRB9umzk=;
 b=BFcFXk4Tc6QryIzm0YjTJO3Bqh+O9fxJ7+t3ZFAnxvsu+uOPXAgjxcuqCkVbGJOt7i
 sZSOrkUGlqOH3iC/IWLDD3NHKUFiNQBhwuxiKRt4ouxa1rp5mi7nivfYMj/jXSQRMTSZ
 B8qS0WoKVQqHlD2Ir0P/Bxt/Lxc3VHXxpenYeJyxqVGuztiJtZg9XNXbukWMv+BLwDkK
 1DBEZcMUB1Z2A1tFkhSy2NdLHqZet8LemnAF1SxwQpl5IpByjYtTuhTrxcxRyv27/2US
 txQ9RQmT2YmXkWwbrQWlSaS7tKUOUWgrJXtV0pe4Ig+VfVMg1qNf7S8TvEevS0nqEnjI
 aaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883689; x=1792488489;
 h=content-transfer-encoding:content-type:subject:cc:to:from
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SnFh6viEqDHD71Gzj13GpEJAmqICbT3oCU6mRB9umzk=;
 b=bvSizzLMG+c362JC4uhQFQQ5a9SdzfmrkFZZxdlNctYOdAPnD4K/w70q7GyBf/lWo/
 SORxH9+8MxR5zieFt7DCn+LeGGShxFyEqLrsFqKLPc7ghfkCd0KtW85OIyaLnkupbwwj
 fMBB3bFGrNDTNeE7aErkR54aWI6iVb/X1ZG5vE7ei4bcy4NlmN3+zKdB4YlaA/B9ksfB
 JyY8Lri5NxR7VS1lGtI+5Fg0vEgRJQfgSuJswerhddGObK/hdOocnm1oQrapDR5chUcb
 bXeP53BQXmQBkKNMfgDbBuak5GQVainY1q7mdkBMhNwzStye3YDXXCg2upBZd0AribLj
 e0DA==
X-Gm-Message-State: AFq9FYJLZWxQXlBVYI5IRrMgbxZnKIWzrjE+TZ2qloDaKaTpdwrgow2b
 Jq2t+isQ6b0s0Ox1EMJApJT7fr2Kqxdr5mcdtEbfAWxYcwV+K/xuLOsQdU32Zvon
X-Gm-Gg: AYBFou3SCksqx36IYYTTxigbD/yjt4v9WuD17x5bNLq5s16ohtbIjenXbl0W14SYa22
 iUnxFb7zf9XZBu6TJSPs4O0P7pgh10VEW4OEQHAlgvSEbekdOhWrKkiZZYpO75IpOkYRyN0MiIt
 JsGplfL/n4tF6Nlvqr83ei/GcPVEskmD1IGxqak6Pc2UkP9HvRzaW9QKt9HmMi3nGwylVy/9XAw
 P9ZllKiPfK8Yn7qhTSFd/rcu3qTZdOxgbqou6TwY5PIEHbxSBkykMB07xMlZ/4vMEVKNZfGNrES
 gE1y41QUiSCS5ziSBWAeFEc1nba4Yl4Hut5Hl50EEKR4MyV2zoUUwc93kAEh0/fCBEQoOoBkzdY
 k9y6dKu5+9aKrTEKwnJEXTTCeZz9wEqjU18r+pGm1rI6EDzBxQ28aCsa7qOMCSVms+xsURzOp7Y
 bHBdeJPOcFQ+BiZvjWOQgWpqe8uxwbMQhT+YH6axmwUZyIC4gYJkuUxT7ODs8Y5jC8Kgx/ALFFF
 +dvWNo=
X-Received: by 2002:adf:e005:0:20b0:48b:437:8fbb with SMTP id
 ffacd0b85a97d-48db948204amr17098950f8f.19.1791883688572; 
 Tue, 13 Oct 2026 02:28:08 -0700 (PDT)
Received: from [192.168.1.194] ([95.179.249.152])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd1843sm4133138f8f.56.2026.10.13.02.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 02:28:08 -0700 (PDT)
Message-ID: <045c22c4-3a3c-4fae-bf81-f4fde426ea2d@gmail.com>
Date: Tue, 13 Oct 2026 17:28:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
Subject: drm/vkms: question about the "Additional buffer formats" TODO item
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Dear Louis,

May I ask about the issue "Additional buffer formats. Low/high bpp RGB
formats would be interesting"? I'd like to try adding 10-bit formats only.
Could I take this task?

Thank you,
Oarora Etimis

