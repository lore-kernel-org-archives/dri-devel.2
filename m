Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABE606A334
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 00:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB4810E083;
	Fri, 13 Nov 2026 00:58:45 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F0910E083
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:58:43 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-8b3a332105bso4332277b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794531523; x=1795136323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m4cNkNN0zPomANLU7iiqWZuUEPKCVypeIaShvu3dZqI=;
 b=VtPqGgtFhMZY7Bm2hBdzmhRcKOxHyQuIFGQbVqyfdRXFrleLrLpH4wC0g7InNObn37
 lx4Nk+dnMEZZw8nCRx8DQPJXMBsjMyw79uxNjeveK+l1ZRZYjBCo+J0jb2GZA/ONH/mx
 ZW5TNI6fLMYeUaluLVB4SYZ8hOoP4kWeDo7gWU7IkM6Ea5HGpQ+I4znJG558e7NjH707
 xRs4UlEry2L/86Zx0BY42ofIUa8v/3tnCAyt/ZNrYEX0Ln2qy7PvB78hIC4VXbyxqQQP
 VuuNriBVnLsMRLBZ8D+bp7inHAYiqaJe2OzGM500QGBAVOXncmPCYwbVILz8flP/4rYx
 wYkQ==
X-Gm-Message-State: APuU4Z+06ZHHVodtOQp+rOR+mDGA0i/7nj+DugiqJdYW2rgB7wMEDl8F
 XnLVSEiu4Is8cJS4AemEoMAZ1ORGFxjI1OmfBjA7PwUTTOJjvsxCTfIgcZnA3gKV41E=
X-Gm-Gg: AYBFou1Xexh2MaeLMHL76T3bW7U8tkCRVu/+RiiYsxpi8lTDq5b5xwF1QFLuZPw0tUw
 rNpc17O23tSEUMN9IzSBzESrFmTlo4YN8/zbM2qYrA5MTy2H9OgDvZ7VY4qsGsfblPg6LrYd5kv
 LXUATf8W/q9jVCOZ4rMbZ+MJIprhpD0aa38j9/vscquJRsE3Pq0w+r6SmFIQhvgf7Ku1FyAvK9T
 WecHAYkKpg5hS8xz4UvQfu494TGiM77MbhqvtYwPCJaIAC6GK13jmIAyYJG63dpaTkrKQRCi7vI
 jnNoNFvawqBHi6W1Qm3L0iLYuE52zA2pJo34ayVKjJp8MTLti+Wlhxn/A4usU2RB8ZKzbwu1UFX
 EMPrME4WpnDvbq6+9gUFwGkvoaZqw4hGCVNXeNVDdg9FwazBRvQbtKzrNhxmnS0JFWeb334+jJS
 ka6m3C68epmzD/geLFmoBEe8V7ImiHqt9cozyWfClq8Z1OW+HA4HzkiiVsOy36ki34r7ypXzse1
 npmlXPF1/K4FdAvjsLrVwCYTaQwchr6NYnPrKn/aO4jCEaukJs9rV/O4HW/qv8bQehhekplCaoC
 Hq66LvjPAMbiJ9NiDzHjVKbzOUCrnUwzIb+ByofbJu5nIQYBi0BJFIKC/ZWhDDVcpyThIGZiKFt
 0n75Dqy1uR1Yo6zTEvplqxGloq8LUUe1d
X-Received: by 2002:a05:690c:c1cf:20b0:8b0:bc8e:9d75 with SMTP id
 00721157ae682-8b4aa293277mr6343997b3.22.1794531522775; 
 Thu, 12 Nov 2026 16:58:42 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa9ec1cfsm8904017b3.39.2026.11.12.16.58.42
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 16:58:42 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: dri-devel@lists.freedesktop.org
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
Date: Thu, 12 Nov 2026 19:58:41 -0500
Message-ID: <20261112200219.6239-1-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAMeQTsb4+9NiSYzWVWxRt-_Q-t3E8qsC1jb6E_xD3ruGmao9Cw@mail.gmail.com>
References: <CAMeQTsb4+9NiSYzWVWxRt-_Q-t3E8qsC1jb6E_xD3ruGmao9Cw@mail.gmail.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 9:24 AM Patrik Jakobsson wrote:
> Alongside Poulsbo, the gma500 driver also supports Oaktrail (improved
> SGX535) and Cedarview (SGX545). It would be nice to support 3D on them
> as well.

Cedarview's SGX545 already runs 3D with a driver I've been writing:
powervr_sgx, a render-only DRM driver, plus a Mesa Gallium driver and
an open GPU microkernel, so no vendor firmware is involved.

It runs on both of the SGX545's platforms: the Atom CE5300, where the
SGX is a PCI function of its own outside gma500, and Cedarview, where
testers have it running on four machines so far. That is why it's a
separate driver; on Cedarview gma500 keeps display and hands the SGX
over as an auxiliary device.

The code is at https://github.com/The1TrueJoe/powervr_sgx

Gabriel, on your SGX544MP2 question: the driver keeps a table of
cores, so the SGX544 could be an entry there rather than another
driver. Happy to compare notes.

I'll post the kernel and Mesa RFCs together here soon, with you both
on Cc.

Joseph
