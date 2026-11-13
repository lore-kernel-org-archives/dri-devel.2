Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E395606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F298C10F027;
	Fri, 13 Nov 2026 08:59:49 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B459310EAE2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:59:48 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-8b0d126f631so7452597b3.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794560387; x=1795165187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6PqsDYKvvtg9NUqTyhg/EMjPhf/F5IETSmS79IMwRJ4=;
 b=VrWDnVg/H8Za4z7hLaKKvk5EfnwvB5vauizxdOFXlSpl63VmWOvvqhX41MVWyzDcES
 UDE2FGALuV8HFREFfo3jtDPtpqnuup2PXtrQSFszOQa8kHg9fOCwf5E0r1Qq9jo3p4/y
 addWO7ZJFBy0F5WJS9qoQ2TcDVRf6VPfrAPBx3ImGQgL2WoWbTwfTIAafRr84lP/pB9l
 +3SxNB9bdGFfRFwlH5vHTL9bLQsFr1to/V6X/9TWOcKLGu5KVuxyaCZwZhPoYlBkKZz+
 EiodyJCsWKoC1jaCfm67CUkVWs0VDbat5a7RgTshuVttQmJd9SCzrNSI0I3GCrNTjPs0
 7Brw==
X-Gm-Message-State: APuU4Z9vez5lcfzJ0li+Q8AGe08MBv3C/9e3YZ3p9KrVlglLJ+4yYs7A
 EKnG9XAWfFxxg00RYrfZG5xCicjbyCsA6x3r+Ww2wR6dhfGW+31mVp7YNX4rFAlPE04=
X-Gm-Gg: AYBFou1lUJwRGQgh64FT4KeuzWITkTDOVZXYFCUbfWwL6a2wV/rGHvkGCtL5AczQ9k3
 vV01sZM2LDM8pIYUd62rdqNhJEAg46ERYizywODS98uBLPICHSfEGMvWNe8pg4T/caqzZWifojj
 LJ1Il6rPJYrl1LKDevX4J4GuiPh4egDUbubjVQfbUQfZg7l8Z2EUS5Ms0+P28RSjNaKvzKb1dQH
 yZBfJwzb5IwbmmR3Yhg/qnfcwATuIzHkMqit2Ii8zlsHwui3ZqAxZKVVZShSsxdna8pFCN8Ccyj
 yBBliWLRZgpSJ6mQdvZDaGtTeceEXjCPfIbJf8bDv1E3/AqTlk9UEUDBEr3YdSYfTSLgoecPTas
 GwWSbOgv5JMbBz4xvSQkOT7kSo7KeL7/I+xXrDAm9TKTv6LnZhoWpWgSzXewbmuxDL74LJE6kzh
 PvqhIXl6AHSuD/n8d10lFxwEL+GwO7xBgSG911t++ae2mC7gwZuJHtnPc6RqwMEYTnx86Po2kDz
 ATuv1awSM1C0RlQ2EIf+Em3QchN1TRYlDAdKfE6erPGHt+WUyudfkIHx3enWvXHWAWtchn8p6qb
 vxkbEIl8vD8zr6foY7DIQcisavUL80GaebSYFUOCKS+mFeeA9lO96KYAKpvF/IDjGoKobfaUxMR
 Ij5SCpJY0HIV7EHLVm4o5PHIw9nI6WwP0
X-Received: by 2002:a05:690c:931b:20b0:8b3:5b88:a21e with SMTP id
 00721157ae682-8b4aa326b56mr11455147b3.31.1794560387574; 
 Fri, 13 Nov 2026 00:59:47 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa7f1a0dsm15757237b3.1.2026.11.13.00.59.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 00:59:46 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: dri-devel@lists.freedesktop.org
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
Date: Fri, 13 Nov 2026 03:59:44 -0500
Message-ID: <20261113085944.62576-1-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 3:24 AM Patrik Jakobsson wrote:
> Clover Trail is not supported in gma500 so perhaps it's better to keep
> the SGX driver separated? You and Joseph should try to figure out how
> you want to do this together.

Agreed. With the SGX in its own render-only driver, it doesn't matter
which display driver sits next to it, so Clover Trail+ wouldn't need
gma500 at all.

Gabriel, this is how I'd see it, but I'm open to other ideas. The SGX5xx
cores have a lot in common: the MMU, the command and job model, the
parameter buffer, the PDS. powervr_sgx keeps a table of cores, so the
SGX535 on Poulsbo and Oaktrail, and later the SGX544MP2, could be
entries in it rather than separate drivers, and share that common part.
You've done the SGX535 work and know it far better than I do, so it
would make sense for you to maintain that core in the driver. I'd work
on the shared parts and on the multi-core support the SGX544MP2 needs.

The gma500 side of your series still stands either way: the dumb-buffer
size helper and the unpin underflow fix are good gma500 fixes on their
own. What would change is that gma500 hands the SGX over to the GPU
driver, the way the Cedarview patches in my series do, instead of
managing its MMU itself.

What do you think? Happy to go through the details here.

Joseph
