Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F83C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437A610E70E;
	Mon, 29 Jun 2026 07:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f55MKAY/";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D145710E395
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 05:55:41 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2c9b19bbaefso6917785ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782712541; x=1783317341; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKI4yMlcZvs6J82HVgvwX6K7+f1RH5e3pg8oR5A0QEk=;
 b=f55MKAY/YK84zfOb4fcPrigWEQ7URvXWD3xiLBhDGmOQrCro1d7Ewa1GI4SptCOoQG
 CiH98LUqdeaaPMi6VQZN5FGUQRwHaEcJIWhnV2BmET4/F99a1MCy/xmPDeO4GGUcS6Nx
 UMG2jBBwG3pvHsvb0TDhohpRe7jJdf1pi1NWkyAFnXic/SmnDj2+6wo96wnldvfRzHar
 s6kf723CqjYM7mulErMuNRuxNdl+bpiRgj3rk7ArRZH5hSLr2VKDFMvrsIbwDHmt4x4k
 sy4m6+GFwjoXdouAJvVryH3YD4ty0PRtrYLts9/NulsgXYuz6pkhI0LbwyzIAhL/BAlv
 evGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782712541; x=1783317341;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RKI4yMlcZvs6J82HVgvwX6K7+f1RH5e3pg8oR5A0QEk=;
 b=IGm+XlGwDdPY7dc79NVwWj9y+8qkl8s8S0Eel7Z49aPswTEmaswc601e5mVoO0ZO8P
 iPpQ0kmfrWkFBTmcZ4lYQSaS14cVHrCOf/JvKtc4Wph/IZ/6lk/nkZNJ7P8tNCeG/Jpq
 pSCLa+3YGwA8fMzyqxMbx4nMLC1cFY4vs7SfZ2bT9FXgJGqNgyCU6zfjJDFAOcJ8gBWz
 X5kHqwXUpAw1msaVSBwXe1oSNbPYpIkdLlvH2YPewGq/9QUgIfJtCT0O3NPzYPccIEPR
 I+0WKjwWfNsy8ca6BmyO2dsFLaXmJMWbeF482GgInMUE3+WP9vsPBIFTOqMLuKkgWjDq
 BAkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXZG6d2eqYnUnOU6iRhC4uHyKkXMkYvkMTRPiSdw1lD7NfN+QtOJ2dGY5l7UsQdEJelniahNqKeB4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxzl9DlAprrQIHIsmm4SIhLeQrbx7B5ORwsFhFQG8SCcspurP4u
 Kh2StuM36jpvnMd7f84fRVTtRtE5Fd4WSXxxXZt68WSm0PMGf7XAE5J9l4Q/CQ==
X-Gm-Gg: AfdE7cnIVz8VjA8yxPsEUr0NjtFCTrna+XCOXI2SxJ5YByl4kBn9XWB32S1kILVUETc
 +UQkqnmsAEH8jnNIYOmZKdYTCmC3dIgdw82JZ1UYSjPt4Sw7DN+ChNYLTTb3hbttSgPMZxB9h+V
 Y7OAJDYgi7iC8m/yT9+5lKGIfsIWbOzOtIR5R+cilnFPSnTfY5qmw540UFpCuOPP1I3kI0ghMeG
 QXvOjI0Tr1N4/wS2c+T+Q2c1pwlmfElZ8NM2LjNptdAn62iDNOfOwu0qcoFhkRskq2WF8/j1zsK
 YrVe+8vcYbxp9oXCvuis9DBFXPJzbREdqgIxC8KYD3yIfPxeQ1djVlqpQOnyvJbi1rzVpnVKz+v
 cijDcj4Na8cWXoH6ecUokRvWXQNfP6nQIdis2XNIig++LmfQpjk9OI0dIG8Tm3bLBjb2WIN8yNS
 8QxCdl7hx03RttO6Lp4BJjGY08/u96Qhd2Ko+noXArzeHGidfri9D6u3yJlEZ9cXiVOz0ngDgGl
 +ekcVaTVYL6JFii9UrYQtqnGg8TXwNz0Zc/r901
X-Received: by 2002:a17:902:cf03:b0:2c6:9f66:d57e with SMTP id
 d9443c01a7336-2c7fc8ab2a8mr155882785ad.36.1782712541250; 
 Sun, 28 Jun 2026 22:55:41 -0700 (PDT)
Received: from localhost ([143.248.188.236]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9d886668esm26211825ad.58.2026.06.28.22.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 22:55:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 05:55:34 +0000
Message-Id: <DJLAUOEDW6HT.39URSU30Z0HT9@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, =?utf-8?q?Nicol=C3=A1s_Antinori?=
 <nico.antinori.7@gmail.com>, "David Airlie" <airlied@gmail.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Simona Vetter" <simona@ffwll.ch>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Tamir Duberstein" <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Pedro Yudi Honda" <niyudi.honda@usp.br>, "SeungJong Ha"
 <engineer.jjhama@gmail.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.de>
Subject: Re: [PATCH 0/1] nova-core: Convert bindings to use zerocopy
From: "SeungJong Ha" <engineer.jjhama@gmail.com>
To: "Alistair Popple" <apopple@nvidia.com>, <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260629025220.1935622-1-apopple@nvidia.com>
In-Reply-To: <20260629025220.1935622-1-apopple@nvidia.com>
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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

On Mon Jun 29, 2026 at 2:52 AM UTC, Alistair Popple wrote:
> Given the inevitable conflicts that will arise from trying to merge sever=
al
> different series doing bits of the same thing I'm happy if someone wants =
to take
> this patch and the others and roll them into a single series. Alternative=
ly I am
> happy to take that on - hopefully Alex can provide some guidance here for=
 what
> would be preferred.

Agreed it should be one series. Happy to help or fold in my part --
whatever Alex prefers.

Best regards,
SeungJong

