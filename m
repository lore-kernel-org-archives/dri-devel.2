Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77628C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DD110E6B2;
	Mon, 29 Jun 2026 04:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PgdG4ZxS";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D52310E6B2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 04:39:34 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-137335bc3caso5768882c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 21:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782707973; x=1783312773; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tAkDY+MQvqYfr4IaXyrXZrjWk09q7w3/qlUx+mpeOiI=;
 b=PgdG4ZxSNWdcMdvFigUQbQauV7L9rLHhRbFoCN78nq3uiKHebUDBnWk3wAzOT4jyeZ
 vxq46mhhM0qGDqBl8s/RW7c9OsY21Lnyu+APW+altc8mmVHRYG59ktQiSuKAhbrXURoW
 0C8fTXbQqaJ44AMA0WBWzZeKiL0Xykm1WgNcNOSBmY6ShEISr65jlVGz1FqDGnmf0m4b
 bdeR+js8DXJUJOhdKs025c5tY3svFGcsCvqxJlTP088ZfTwV+59mX6wvzCtnYII4z9lm
 R1osf0AYU5Krqn090w0ZxO7hRa3kbsvoGeHoi+XoSeXYmco2WVkycuqkBHDpkN7oL08M
 CNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707973; x=1783312773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAkDY+MQvqYfr4IaXyrXZrjWk09q7w3/qlUx+mpeOiI=;
 b=ncV+zaBk3Qazyns9DmXmIPHbpA46Hd9JfZTymGAqtjniny0eQ0usm9NHdiUhDKuVVg
 IJfbZjB9fzHZCuxDqi/g1CTkKCDpOVvwVZo3YwQ4hPca9EZ5mKEUIj37uteWrIEhXJ3R
 4KLDv4vL1WQftpTK720Xhjjw6EsjEdhEyQEpOp2Y7Nr0CLdLfx+dv5T1kiQX6ypNMWBY
 sRyaTncpFD7oi4I88F7UJP2+B70cE47+wajTHfBnCjihdv0aPahG8De26foIn7lyMZD+
 3uoXDCbMInkx3yruOabiv2qiEKT9vFC4mj1JPA7NcmcOQ+x005LlzPRR28Bum4rs6DE3
 P8yw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rodwuvc3l+PFBBd5/5lFqwVAqV2YwgWyh72/mCMJSXEBG5hLFgil1Fp2iF4eoOsjqydnHL26/eTEX8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeDIGNfvmWHLhjaMT8j+Jna2Y9pKH3WKAXzTrfgXXG4EwFXD1S
 5XImJd9aFz2HpEDHM+rlCf8H3r5E3s9HTZRaSaIp8E4JNczTCp104TZA5s3JthRlt10=
X-Gm-Gg: AfdE7cnn84bJVsBS/iecAXnjy7CSceXFTat2Eux/NMAE7TmWL/gymjVk4INjbfA5Jgf
 CwSbs8WLH9E/y7wEOhj+QpvVQ9R3+x1TVhxgbxPdbh5trFBss+qL7z/27j1ZnlntpJ8pFXzqsxo
 i/yd74+jd3PpeNoJnmg7HGcIq7H9nRnng2qF6qEzrXm2ve242t1DKNb4WzgKjg+rauCnrUEH3Sr
 n27POpMpH8UiSiZJA07GTJgSFTMGgeSJfORgHx/HMqBdHfhlUi9l+gQPv2Ey09Z3HjTdcerMN9D
 U7v+nuj+GBygTNsC7zDW5yFyxgJMbQSsddu1GDu45Tucu81SjFdsFTjs5ZwDsaZizWmvutfLHBm
 49lb7SP6JYZsft+XN0Xq+RsijnsCeSM/QU5/W2QcXU7d2RVWmiHNO4o/W/az9z0a1UOD0GSGwTL
 2lH6B3zJ/2DSCg
X-Received: by 2002:a05:7300:5341:b0:307:d4e7:b177 with SMTP id
 5a478bee46e88-30c84f3cb8emr16773092eec.16.1782707972936; 
 Sun, 28 Jun 2026 21:39:32 -0700 (PDT)
Received: from localhost ([122.172.82.94]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30cac1b9751sm23319860eec.3.2026.06.28.21.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:39:31 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:09:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Trevor Chan <trev@trevrosa.dev>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 ojeda@kernel.org, a.hindborg@kernel.org, paul@paul-moore.com,
 aliceryhl@google.com, 
 airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, brauner@kernel.org,
 igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, 
 m.wilczynski@samsung.com, boqun@kernel.org, gary@garyguo.net, axboe@kernel.dk, 
 daniel.almeida@collabora.com, shankari.ak0208@gmail.com, lyude@redhat.com,
 j@jananu.net, 
 lossin@kernel.org, acourbot@nvidia.com, markus.probst@posteo.de, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
 david.m.ertman@intel.com, iweiny@kernel.org, leon@kernel.org,
 bjorn3_gh@protonmail.com, 
 tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz,
 ljs@kernel.org, 
 liam@infradead.org, bhelgaas@google.com, kwilczynski@kernel.org, 
 ptikhomirov@virtuozzo.com
Subject: Re: [PATCH v7] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
Message-ID: <xak7wil2w2wdnmkfh4e4ijhlgnudzuh5y3ltlo72454e52tocv@434kdjz2eupv>
References: <20260628100731.64885-1-trev@trevrosa.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628100731.64885-1-trev@trevrosa.dev>
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

On 28-06-26, 18:07, Trevor Chan wrote:
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 62e44676125d..84802f22b652 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -1043,9 +1043,9 @@ unsafe impl Sync for OPP {}
>  /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
>  unsafe impl AlwaysRefCounted for OPP {
>      #[inline]
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> -        unsafe { bindings::dev_pm_opp_get(self.0.get()) };
> +        unsafe { bindings::dev_pm_opp_get(obj.0.get()) };
>      }
>  
>      #[inline]

For OPP:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
