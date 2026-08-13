Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0251C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDFE10F256;
	Thu, 13 Aug 2026 09:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HdYmi2/X";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C4910E39D
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 05:50:48 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5b011edaf7dso1930874e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 22:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786600247; x=1787205047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V3JEh31WwDsNrUS7v93z2nbzGko9efY4jXQ8adxryQQ=;
 b=HdYmi2/X3OlyCGzG2N+DA6rD4A/+Agy7zGz/IqxTMfFi8ReNz/BSDtiuT5Az5HCSTX
 +O6KCO0EdaS7c197pXzvuyIg7YTpHtGWzRGp7wFOIiy6RVF09gqoT2bnAmJFgIX+egIe
 uY9UC/sVfr1Jxv1aj6n+TjWTkv5ZiIwr0byOgWgw3JmCSprhKVoQLhjxDFV2vZt4hc9d
 SxyR+rgNEjQak7dn8WbC8PfqtASYGB2ojXhfIyMFgtc0nV5OgUPbFuq/rDnZP+vIxG2v
 RUmimP1CDhMxUXZKVWXjrq7rXBWLSWpxR8L4ApGxGqTn1tnMfl1XLyZlcNFtOj/8p/yf
 a1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600247; x=1787205047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V3JEh31WwDsNrUS7v93z2nbzGko9efY4jXQ8adxryQQ=;
 b=ZwOR0FqfF+UDq8cPq2B8mKdOeYmcrngD13uyFT8WBBBm1DytcL4uazGI8MlnByQOgB
 DjUtmMzzebHTU9a11ISesnmjyAzLAWUjYaIp6gDDOk1mAin7Ob0f15UjSLkMP8fAzUQo
 g7KCWo+9zCGSXXs4Aq6bxCPDLFvv3TPsUZkPvZQrGxeBIyJzmOqwM7CVYuB9oLPbmkYI
 4aTp1/6HowTKdvvXyztiGa8y9+VZQpc/Ou83lK37lwdOGqMbmdeqKha1jLshLV5LKYAR
 MLnj/z65Z1fyRuRgxUpZGsw6aEBhz37veWhb/eV/g/CH9tBfqp1Hh+0v9gWS5J9AHTvp
 lMLA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcitKuw4SWRj1WMnLsOZd+KSHGFBDlVDVc3TEJiqGTluOTyoE5aThPsKr/9YfzENrbETD4vSDiw9Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtuUegsAeEf3mKiFZBAFNCWJcIDZOgAWXBliDfaTlDYwFzhFaI
 2pLdJNkaKCfNb9ptn5PlmpRq/zRJZ+LiOvDvX1o3t/YfaUP2119MdJMO
X-Gm-Gg: AR+sD12SWEyEdiXIOtqEKiH/yshvQ3dub2kPBJkTvkhaqnudADIzipAxBqq0P/Zsoje
 ThS+LrVCQDmmzXojjZgozWaGXoh1laFOafebbj29I2zcQNX/elT+x1vC1CmrOyQs+74kpNewupI
 Xf2LjXFAGUM8MYEDYtLxlaN1lcABlFpjXdVla5dTKm+71dgnd1gYOJd2XKRvOJh8fneLaRlDq2U
 nuVof2CGtX+toHcJgtHu0YySLaH+kUB7NORwspfwPl+GX/AQARWYTOLum1TFHhR4cX3HNzmYcC7
 0I4GLQoTQCca9FTa414ceQH5YkLRQKXOVvrgAslMwTiG2HB08fuJmIiRkHEseW67TjIZd/YVqq9
 Z1PMxOk9JB9n2B/31jHkZY/l9FdmuNtjUc+qbfZzXHPWqAJuvmbqWapNvAW01sn9z4EumbqRC51
 8kA6/Ch5OQHf4KDhCv+PxlS8opocDXK76qOBF8aRAZCJx2MTLIs6KaVP0W2M4jwO5eYpM=
X-Received: by 2002:a05:6512:2c8e:b0:5b3:e02:b398 with SMTP id
 2adb3069b0e04-5b453f9f805mr407533e87.44.1786600246595; 
 Wed, 12 Aug 2026 22:50:46 -0700 (PDT)
Received: from localhost ([95.190.110.153]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b4539e1866sm249783e87.6.2026.08.12.22.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:50:46 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
Date: Thu, 13 Aug 2026 12:50:44 +0700
Message-ID: <20260813055044.98486-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DKN35E0L9X9L.RSVUGPFWRV69@kernel.org>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <DKN35E0L9X9L.RSVUGPFWRV69@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

On Thu Aug 13, 2026, Danilo Krummrich wrote:
> I think those should use VVec.
> Let's move all the LogBuffer code into gsp/logbuffer.rs to keep gsp.rs clean.
> I think we can avoid this additional unsafe if we just create the retained dir
> right away in module_init().
> dev_dbg!() should be good enough.

All four make sense, thanks - v2 will have them. Creating the retained
directory in module_init() also removes the only reason retain() had to look
at DEBUGFS_ROOT, so the unsafe block goes away with it.

On Thu Aug 13, 2026, John Hubbard wrote:
> I'd *much* rather use a kernel parameter: keep_gsp_logs, instead of
> requiring a rebuild of the kernel.

Agreed, and it makes the patch smaller: with a module parameter the cfg gating
disappears and the code is simply always built. I used a Kconfig because of the
"the only Kconfig needed is for retaining the GSP log buffers after driver
unbind" remark in the earlier thread, which I took literally instead of asking.

That one needs a decision, though. The Rust module parameter abstraction has no
bool: rust/kernel/module_param.rs only instantiates param ops for i8..u64,
isize and usize, and rust/macros/module.rs panics on anything else. Nor is it
quite a one-liner to add, since bare bool parameters rely on
KERNEL_PARAM_OPS_FL_NOARG, which make_param_ops! cannot currently express.

I am happy to write that prerequisite patch, but it would pull this series into
rust/kernel review. So unless bool support is already in flight somewhere I
have not found, I propose v2 uses u8 for now and moves to bool once it exists.
Say the word if you would rather have it done properly first.

The re-test on top of the current tip is still owed; I will run it before v2
and report the result in its cover letter.

Thanks,
Vladislav
