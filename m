Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6080DCD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B828510F244;
	Thu, 18 Jun 2026 10:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pRw2Nqc4";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550CA10F244
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 10:39:42 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so675869f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781779181; x=1782383981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=B9XxsU4nXDbAmyfXiIossdiRMmk/XkYgvNEAKNkHFm0=;
 b=pRw2Nqc4HDOi1+13lb5ufCs8r7jf06dXgFW3J3VDwTSwLd2ndW6sdDO23/PpPEcN5E
 KAdN7b8xE5YsCKkOIjze6TxUivl+upNIJsDdFIyNmPvaSmVwjo62FL+SbhU3WLdfEI7i
 YlkkNUr5yzs4g8twnJ3f2Y5zwTeQSx54bMK9sZsNpJLCOubeV5Uo0XOM5Mw+kPeDTDlm
 ZJ4lqpJZS+2RvM9tyT8jviWy3ck8w0J1V0lKPyxg7CzDsdfSWLskkuTTb2zRNQ/AMdK0
 6kyxiOf7OFiyclBea2QvrZT6ymW85eH7qUJw5RoXLouB6zbiKoQSkW9oc9mLQ6EDyI3X
 +KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779181; x=1782383981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9XxsU4nXDbAmyfXiIossdiRMmk/XkYgvNEAKNkHFm0=;
 b=eO+FE1SJ0wtQGGUzz3R/cgJkimKSUyl7ob1zsZZh3QJUfhCiJxzL1ZTaeSOBDJVLEx
 W0wol+wzicut7T2/apHNNisi6FLKymn1W16h796JBUc1POfTAO00jcwhU+0NyQTT1gYl
 q9CtA17AHzhhbUxp1836gt+pmQVyR46cQs5pFt5Pm2wEu3RiANd/AnPELnllFWXPsCYw
 taWg/pldrj6+wBQUNB3/Aktqx/1Bzas6kdhh+uBA4TVnr//GuM2YV7BUbrUK0ghsNo6Z
 4QzmyNc6448H/FS5uOJWOjwJGeKjSm6JBFjppNaRyKWlHA6XvUpr//69PHpe4Z+Fvy+W
 HxwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/z7KtUcEmE2/KT18ZP+vCBbK+6t/y5hfC03Zf1HpyzlntZdB9C72Juo9++LNPufqZP5Y3sl+uEg1o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfEW6Epd34cJWaIjBSGZAzIs/L2iTQ0NZ9ecgiE3xoAtfQJUkV
 TBJBuQ1miNcSNHEu90YQqfOPkfvJM6PTpfL7V73xzdXH3kE3eEzKy3Zy
X-Gm-Gg: AfdE7cnuGFfPZs5lctjsG/eoVLketZYu8Ar9bkwWc3+DEpD5VDrb/IELa2uEScpd4+0
 ZKl4wQtQzt/9RBE20cqB74MOyT50XGRJ7AnI1wE+cefQKxnSWbBGNjawyVDoE75XminsqEFB9sY
 9PRVJCAkCW12cP3PY8uhQnO5waBmVFk9UjmeamizpRxYDtRWhplRYwsm4dHGwf1tmDU6PbtO3il
 XfhRNk96i7RcbuGWPC6IlJuHz8klqm9vW/oUepujNkRuXthB1WTtFAPmYyQ9bNv+RcVLsjQQq3w
 5NAgia88nv1iPukES6z9JzOJpvOD/0JsnXhdsRnY40MX3PrenpSuf0DHinZtExdNe7NUa0/o1fA
 u9lQBdHL1VtG24/WYAwcwYTikY7PUT+NzjB7F/IQN/X5/rFyJyZxa72EYs+yWZM8jmj0L9DZJp2
 h0r0o1HKULMdgctQ25SQ8EsKZx78NoreLoZYE9DHtIji/XHQPDobwUb5btx2d6U6SGQbJ5ncyv4
 C8nh0c=
X-Received: by 2002:a05:6000:40ce:b0:460:3210:434a with SMTP id
 ffacd0b85a97d-463ae35064cmr4719933f8f.43.1781779180580; 
 Thu, 18 Jun 2026 03:39:40 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm64727672f8f.11.2026.06.18.03.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:39:40 -0700 (PDT)
Message-ID: <985a6e85-3c01-4fa0-8610-9070817da99a@gmail.com>
Date: Thu, 18 Jun 2026 11:39:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] drm/vino: add DisplayLink DL3 dock skeleton and
 plaintext bring-up
To: Mike Lothian <mike@fireburn.co.uk>, dri-devel@lists.freedesktop.org
Cc: rust-for-linux@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260617151249.2937-2-mike@fireburn.co.uk>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260617151249.2937-2-mike@fireburn.co.uk>
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

Hi Mike,

On 6/17/26 16:12, Mike Lothian wrote:
> +	select DRM_GEM_SHMEM_HELPER
> +	select RUST_DRM_GEM_SHMEM_HELPER

You don't need to select DRM_GEM_SHMEM_HELPER here, it's already pulled
in by RUST_DRM_GEM_SHMEM_HELPER.

- Julian Braha

