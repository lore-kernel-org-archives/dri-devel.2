Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE49CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CACF10E460;
	Mon, 15 Jun 2026 14:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZSllM7GB";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C6910E483
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:12:35 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45fd45e596cso1914302f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781532754; x=1782137554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=mlAdfcI8Ecy0r7+Tva+ZUfaduQIk92FZmuqzn5uphhw=;
 b=ZSllM7GBzxKnXPZV6F83jEpSl/QS6KqNJcF1zMzy5MzvT1wpFm5y5gjZ9SuBNL5X2Q
 D5bWpcP8IdqXK8NUg2H4oVhLzrpjhgKdd0UfwKJxm7WDOvty0dE6tc6ta1MXlAskPG+R
 6eNaY+HSgDHcF3zTZPoGkbWMkLsyqP1ps8O6SeAdewokdipvT37i++jPeyvMTnYkwMmf
 zL78WW2dmLWPyzM1Dl20CM32IFXwod1m0phHqvA3qO70fRqDiuJLZGvyIfRC1swV2Jz5
 5eB4l3wfXsUttFALK8dMvP53Fd6RoZAh3F01qGcK1cIMRMFdn3b2Fsp1vyIJ+mCTkJzM
 sY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781532754; x=1782137554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlAdfcI8Ecy0r7+Tva+ZUfaduQIk92FZmuqzn5uphhw=;
 b=OoHlqtble6luyvIQVw81KWuRLF1Y2hps09w42zHnzzQuWSqLEaFq73oqNUY8KGqTBP
 QdbD2L4VA0UjrqGUateaYFgpyPiJFJjkwVb7JbtI6tMqsppxPTIf9RlIQ9p0ZyXHWP4T
 G1/F/GfcRsuzJPFEHAgL90uRwxXBgvFHgVza+s3id2BhNAykiiS95UqA64YD90gi9bJv
 fucr5MwvKJWvKFHU+sE0DlVt50iSq8N9TukimP5nkYPYFcxTEJ0CJjH273EYyZBUUoET
 A3QVDgmVZCkqpxobowX4RR44TGygOZbAqFheL5K5nT0k4SItctgbCNIDUbxvFbHu57IT
 z6Ag==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EGApl0VTrIBahi9OLaHA2QCdNP4F22YtPwac7KY5MT89xYHvV09hhZk2ImCyQ+PIlRTErq9Z9L58=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSn5jQKijYSVn1YAN0S7aDsn0iRJBUqV4jgRh2bpXwDbwvo8kU
 1wxJqFerfTFTEJQnCkvz7bhaqZvi6SZb2oshM3q8X87rygAveXykjGEJ
X-Gm-Gg: Acq92OFPbZaZ7lx8Ov/U20CUP4FrxzxMUQVrtPVGPpGbBmoJTyQfQ03p5S/xu7Ft8U/
 4f96ynucNYToy33DRfnCzCcn0Cd4hVErzpSa+urIfjPT7ZQdOR798IWAcLnsT6AvzrX8AIZiuT2
 pd6diVYAczJXJanf+Dc/EGjD3b0/t5UszBinCDbssMC109Gufze/howgzVKe7sEnIhfJRmKn4v4
 3yP9+r9nzOLzD2jsKFE5qmIhk6ZInCqMoI4k0SNegQX1JLnl6R8ofpyIoWFo21GozOOfGk4amqJ
 29FtHuFHeFpEqVkK1tYOIO9B6hodeVCiftd6kbGh38BfZ4ZhzFcNLe9e254ZAthZfFwg1Lyqnz9
 A2w5n0y8DkoXiMdRq3LSStphoI7cn6eQ5nbsHw++1aBttcilAkU04jW3APnkwZbI5nqzdz/9I2Z
 FYB/84B7AJdaLQ5P4hRp+oEtFl+X+Rf5it8MBAbzlHZufWnUBTJMK5SegXT+0APqe7FOt8kKw0l
 LLnEk5jH/pY7496dAA=
X-Received: by 2002:a05:6000:40c7:b0:460:737f:a090 with SMTP id
 ffacd0b85a97d-460737fa0e8mr16926549f8f.17.1781532753010; 
 Mon, 15 Jun 2026 07:12:33 -0700 (PDT)
Received: from [10.128.10.215] (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f264333sm35485398f8f.4.2026.06.15.07.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 07:12:32 -0700 (PDT)
Message-ID: <9a446f01-3608-47c0-b53c-323c15749705@gmail.com>
Date: Mon, 15 Jun 2026 15:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/v3d: add KUnit reproducer for the copy-query
 out-of-bounds write
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Melissa Wen <mwen@igalia.com>, Maira Canal <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260614131100.2525157-1-michael.bommarito@gmail.com>
 <20260614131100.2525157-3-michael.bommarito@gmail.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260614131100.2525157-3-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Michael,

On 6/14/26 14:11, Michael Bommarito wrote:

> +config DRM_V3D_COPY_QUERY_KUNIT_TEST
> +	bool "KUnit test for V3D CPU-job copy-query bounds"
> +	depends on DRM_V3D && KUNIT=y
> +	select DRM_KUNIT_TEST_HELPERS
> +	help
> +	  Builds a KUnit suite that drives the V3D CPU-job copy-timestamp-query
> +	  handler over a real shmem-backed BO to exercise the destination-buffer
> +	  bounds. Used to reproduce the copy-query out-of-bounds write under
> +	  KASAN. If in doubt, say N.
Could you hide this option from the Kconfig frontend
when KUNIT_ALL_TESTS is enabled?

E.g.:
bool "KUnit test for V3D CPU-job copy-query bounds" if !KUNIT_ALL_TESTS

From Documentation/dev-tools/kunit/style.rst:
"This Kconfig entry must:
<snip>
* be visible only if ``CONFIG_KUNIT_ALL_TESTS`` is not enabled."

- Julian Braha
