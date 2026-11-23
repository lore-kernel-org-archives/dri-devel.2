Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C9606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6WwBuWc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D8D10EE4A;
	Mon, 23 Nov 2026 14:18:03 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9923E10EDA3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:22:39 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso1886840c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 04:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795436559; x=1796041359; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z2brmbtPSn0eJYb2F1hknHyThriPLBF9yzs2QocOyug=;
 b=t6WwBuWcGEOmEpYjA13Lkjuv763XcVkTCo4X8iskDVHxsqdvgGsE3j5mfzg0RUA1FO
 33fw+4T0lTuRIbJ1RTswGoSJBiBMaT7kglmfH+G2e7GlA6PDZ9rL5n2l2M++qKqrNM2b
 C21RUr4degxt/wec0M0u5N34jkGyuFWtnwoIIVwm3kYbO4IcX9jo6XVqNtseAa3h3IN2
 yF3aqolLkilGyVj8SlcptXdLbrEA4QfbxZUG+Qe8GrvM5Od80K6lEAcRXymelsewyqel
 u0xfSKKolu5UN4xrgyWZmxYT93o3NJT7EeA+j5U0hQo9UEmPBDiAj04/soB1LbQY7qIV
 Yqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795436559; x=1796041359;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z2brmbtPSn0eJYb2F1hknHyThriPLBF9yzs2QocOyug=;
 b=uHXdkUD5zXRHfNSPejokJNDCP1I/CM4P24l0xu0nZyY01jIvDXCOI2qt/WJ23oFUMm
 QeeWb2i9p4hope2eUwqFAVznnHcnYYMjiGqaQgPLy0I9v3+DtN8326TRRYUmBIAqUspb
 wn9lU6txgC7E5Zc14oIJs3cTj2YjfXGe0mirLlWOtokjokW+NvXJowQDC0wyzzxJLxAM
 QJUnBo/sXOFIEriHJp7/HcQIZYKsRumyQgSXkAXeItEEEZ2U5vw5Li6Bs9ZuTuiEkWN1
 b+a7gze/jrGK1WhPmB47KYnoBr5ROiji0VYqeai77dL/9Lu8WwyZjveHiWy2bYMzeRN0
 ndzw==
X-Forwarded-Encrypted: i=1;
 AL+hErGQRA9Z+3Hw5DE58LnQY2FMVMiivvzInlMPcm+6othjAur1gdIoONE8Q8zdOmbybO7UEBpS73X8Qi4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/bnSgxWdtVOkJgZii/TTomWCcGLqN7FYQB90dBlHvr7CJENIli
 bFwJpbmHNYzA5umrIwMGIxViVRAJIXzewmZ5xK5h7LkBAsiwQGRSvIwJ
X-Gm-Gg: AZFdTZfoxHMG97NoDktha5SIrxCtUvFoDrzcmqPhEHuKo9bBwwfQxOgRzR2SFUrHI/G
 iRvq2l2xBU42fM8imfZrPrwZTQaAy88T/WcV/eVZj64wiCYrnoi/Iz4callNejg5Q1kd1AemfSM
 7aT4n4IQ+YPUyVyJp2bx05/z04VGERKuZBFoi2sBp2Gc14mcv/k5T8Or5/ql7dJ7IvX+mw1Vj41
 BfOzHgpkLjJP6m2ile85iwh8QzjBFj7AI3NbXtMCEY0xcNjOKpHTNM3QwUCqndXpe6v7ORkgy2b
 1VpaDWzMdmMEe4VCKmvi9oiOANWTd/6a88iK39eCZhxPlR/nbtgQhC1J//RMpLjjj7OubNjp6J4
 IQcpO3Eh5M88xxXMVUl3p7YnrbNpB5VlXNN8o2pZbf6tGKee/mA09+bRdAHow6E6cRyughiaaI/
 zVsn1fxFKwcxVXhGdexFTramIVeauMS66+ZtGhO12N0CzeJpW7FkK2/cY/VUUSOG3iVIXJtqAkk
 imSuY8N3inIUoU7fZHUxCkAC41AhMJly5ocgQyq8q/8lTEvXC7Jkt1frN3uCTy32i4KU3XNBmKF
 PPaQktx4jZVMQuyMi5gobRkb4g==
X-Received: by 2002:a05:701b:450f:10b0:1a7:78a3:bda8 with SMTP id
 a92af1059eb24-1b56f87ae87mr4215314c88.27.1795436558585; 
 Mon, 23 Nov 2026 04:22:38 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c1142sm27463157c88.2.2026.11.23.04.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:22:38 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Document the union in dc_probe_status
Date: Mon, 23 Nov 2026 12:22:35 +0000
Message-ID: <179543655559.4100066.12937692101747026786@gmail.com>
In-Reply-To: <awO-665NEGdZtq1z@wyuan.org>
References: <20261121041427.1743954-1-takano32@gmail.com>
 <awO-665NEGdZtq1z@wyuan.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Weijie,

Thanks.  Moved the AI disclosure below the --- in each patch, so it stays out
of the commit message, and put it in the cover letter too.  Re-sent as v2, in
a new thread ("[PATCH v2 0/2] drm/amd/display: document two members of dc.h");
the diff is unchanged.

TAKANO

