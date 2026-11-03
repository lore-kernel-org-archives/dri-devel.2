Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224F1606A339
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VZ6BsrnQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6C110E146;
	Tue,  3 Nov 2026 16:24:27 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F7B10E146
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:24:21 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a54bba0442so41255e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 08:24:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793723060; cv=none;
 d=google.com; s=arc-20260327;
 b=I7zCdeYNl+MqMWtTz+3METG2ufiVoYkA0WE84NURcGq9pLiXvbK/4fQrtXuK0jlnfs
 LwHjawwUPkN4mw1UHTgJePIDFnTFWDRESYJK03gEV030g42CKlaEiBmyF1tBVpVCCAAu
 yGmfq5am3zQs1NFJalV5X9rM7AIy9tYJw8tu5ALFBw+xeyLE/mZ2koPBfRzLKK4hxz19
 qJi2jV8n+m5XINpjGJBQkweanVMhBzeI5taNTQ1JVVmUaWhecDHGHnKlv+6FLw8EYzmX
 CrWNm8v5/QYI9A2qOm+p7xULb4BY4G+RZEef+tNRQnKldSTPm3zrsZng/anC6n+sBdRN
 CCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nWaM2FkmdisC7Xf7y0ibO+gkIMg0c2qSBatZ5U8CyUE=;
 fh=BI6/LBMFunPQKLNHFS48b+i36SDeohagCDz+u5nxM+Q=;
 b=JA3vbobueeKlzt2ELvnFl7QdNwe0d44x2ArUh+p31jrRxCcXlFRQjBmvx3AY4X3NjB
 Zl6DRNpsQDyWuxYMagaD9sDts6DsHFxjgKrKqnNce7Vpwo3arQJabZxuq3dbrLZDVCP/
 GS+ZE945pNyGZEtHBnFA2pqrV8bw84oqut60LEUQbwoRfFn7yK8XaF5ubZzRR4V7YhxI
 QhcMzJn9T5U4lDx7A4nnaDrnvCm4KlxIcm72XUCp72Y23qn55hoA5cuc0rBlh7Xb/JKg
 beE5YItz7IfmywkNQLtvVumFwSOUuazOoDknhxWeY0LvusdhXiMw13vCjuSLEqM6rqKK
 Of6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793723060; x=1794327860;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nWaM2FkmdisC7Xf7y0ibO+gkIMg0c2qSBatZ5U8CyUE=;
 b=VZ6BsrnQmy5aG8jfYx0kQrgslZX7gwZ7PJXPUIXF584lHv/hpp6NGcDBmDOQA7ZIJ6
 MTklrd+FLJD0bGwZHJy/a5LFzuRVnrm7v7lpzEQGCXtc0QgYAA6rPF76uuMlDsC9iojh
 xYvLvm6NnNZlXbLxNjWqAnALzDjojMW6wcPvSRTKr7YeNStNp0OCswn25anX+t6Tnkg1
 JZu9/p3OASyr0nkIe0uKF8TXe9e2QEY7EhgJhiwT7FF8poQyETk/y2t0OFOJZL/jcVYk
 hgkqJmUamUCAwzqKFctYSO47uv1MWi0XxXFNwLsMEptsob/8/2p0PvoPZE8FqtH2984w
 WPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793723060; x=1794327860;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nWaM2FkmdisC7Xf7y0ibO+gkIMg0c2qSBatZ5U8CyUE=;
 b=ia1CfoSfe37ah+b8K+dOYqKCbMndczQqxdlQ6JfhV8gIGMRG5scaGBwtMZR+bkHsNn
 82dajXSCZoQyNJ/HMpCFZS76Dmjsknn2d6oQ9eQup4SrnINr3OcKgz+asEh97jDgdGcC
 QoIZLKxm2x24n/bvgmfh6KytdTud6UBG6lkFjEWTqCFcFqDNKwicZKMVy88ZYtKf7Kz8
 C/VVxUllZHGyFYSrCkiHoLTI3HtyftEj4/O5FU+a1JC00Vh08nfDWhm/IyIUD+t/g9eC
 BtdqAIghCM4GzUAjG9ZyOBGGq9ceviWGKNnc7JqNTyCpgCwPecKaRbeinE4tXLN5pcDF
 hLRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSsNqMopX8DwsOMa5Xhup851zWYhg8KBST0PRGZz8PfxmVyRbS60UZQOMEAwtS/UHBA+8sh+Rf4Jw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9UGGZyBaXWqn423pqtwVM7m1Hv8hogjVruZrbHxz1nzpSmE45Y
 QajnMpVCAp/WabDGZgmNw+2so/P7ShbIUKwSopgYHjROrhfrkpfTpYeEtRpR9/M7udXZzcc/Dhp
 Aj5Ep3EhOGvZYW4YKy0fKsPq+k63ascF14k3D98Az
X-Gm-Gg: AYBFou1zoQU7cKej4YZsgPieQviZ2Z1uV1adqffFpYCizO2Mg8myW3avHQ+BgJ/Lh3i
 4sRRzSSYuJhHhnN5XrgV6D7ljgbtmP2cBaZFYNJ4Y3Yl3bnoUka0A0d94ON4OX0yebRlolQzt1n
 xngVi4X21MrN5pxgGQN6FEMwvCYjcYx9c4PILV8NaHVl/z9qpXpqyBdC4/M6gcWA/sR4rTouEmj
 GGEd7CTUFPXY92CLIbliM8HxcBPAA9gRRAyPSanweKF2lSQGc1gzEXSU4l9CMZ87KsL75gv1ayO
 2HEh4h7q8GzB2Loc0EUV2qZwXKNZ6gymcA6uFoh6DWjzVVQALpSgC+FWvmTIB7bwTaCz93dkmzG
 SdAt1KBYhnfRD8Nx4FCnTZoteEpGv7DLZVsBYZFULNTeURWmlp2LQ0C7KdS2GBuujzp3blnnLyQ
 7dcEihHCUA1Hlg+GGsyzPFUkU=
X-Received: by 2002:a05:600d:848e:10b0:4a1:eb11:489d with SMTP id
 5b1f17b1804b1-4b2e3792525mr718955e9.16.1793723059760; Tue, 03 Nov 2026
 08:24:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103155459.534792-1-sashal@kernel.org>
In-Reply-To: <20261103155459.534792-1-sashal@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 3 Nov 2026 08:24:06 -0800
X-Gm-Features: AclHuK_dqXVxHCWjDX7Q7eybw3sAcf-f-Ua-B2wyA1INBKZKvcYJncwSGXQwV3g
Message-ID: <CABdmKX10Ykk8qhZt9GjEm_vWz4Fx_WGjpvQLeSbohu4O2_8h9A@mail.gmail.com>
Subject: Re: [PATCH] selftests: dmabuf-heaps: print size_t with %zu
To: Sasha Levin <sashal@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 7:55=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On 32-bit architectures size_t is an unsigned int, and printing it with
> %ld warns:
>
>   dmabuf-heap.c:215:43: warning: format '%ld' expects argument of type 'l=
ong int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Wformat=
=3D]
>
> Use %zu.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
