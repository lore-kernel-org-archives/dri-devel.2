Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30425606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 04:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FF14j15i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3812910E672;
	Fri, 30 Oct 2026 04:06:01 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A7E10E672
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:05:54 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so519848eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793333154; x=1793937954; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
 b=FF14j15iGK85HqdFC1VkxUamU3mUO6agfTrsZkmMyla0ntcR4ZBxDjVfCgvrT2TwgY
 mn4VXxMqE0uVQEPAHuimSEE4UfDEuTBA2O1XdBbe9l3qySI5meEmH2xer8bPMiYwGSMw
 eg3gIJ1nXYTX8PeAqVsGs8iCgi9HwvwV3jvjxwMqu1VlgB0wF678/Xjho/Kfzt+eSEcb
 ECBeuPwKrDowtNu9avF7+/8eMbQgh7uVHNmnoVu+dVxtL0N9zw4mdsPJzCFlrmiYdh23
 aVFE0YKIurSdKWiXWvL3sFzh4ppy+uhk/gvVe90CGMJK9wt+KZVpwNAeNVJqVoPvME8m
 fB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793333154; x=1793937954;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
 b=jAwzLxZkejcZm8C+UUDZ2rFRIQZVNiW88WGYkXGbjErLhJoAgsg2bFwoIeFemW6FJu
 iLBetTOlyiaZYi0VfVJcJv7EtMn9nVARYBeBEKqxWDn0Cg259/qqJb2fXB7BR9LHZl2f
 bS6eaWfyOASuGofd9fVkiFnMxKqYXX5hgaK6LuXY2TLd8vwWL609jwmpDP0kCNr0znTK
 GoUJVbqyksf6A1k282DAwdKPTHfIaq5jwlnfimQrcTh/Xn+40AshTsVjVqlnfsU//08f
 uF87o73Q6+w2fjdmRJ9YwDmMrpbwtyKejGK82943RbRTTgxjk85snBgQh2qQ0N1YdWKb
 M9wQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwj5EhgwV/PeCYJ6EZvcGM8F+fYB5M/0tJt1xgO6qHASzTXY8g2NO3hb3FAuPG189EltNBtySfZ5gk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIdfXYk0C1/0wsE7zNET7WsuR/LejSVlHy/7QKjtw0JEn468TK9
 FcebTRVTgdHJ2Hq+2zQdMw6s3i889zOHimgRSque/t29nZaLVKyoU1pQ7WEw2LqZNO0=
X-Gm-Gg: AYBFou1VSaHNwHK7yNV1XcC6u1G19zWuOA41UOYeSrvBLcv60ZiOoJagN8CadQBKLqN
 fVqB3vSxqhFCyQ0JOV7G2wtpYIMuY+ba1YWkU89vaSn4vXi83Tu/dDmxxvr1WY5PtwmP/mDmgqv
 iC2ywgpy84sytzW2q4Frl9YToRFs7ZAZyRve4hoypbDEvLTBgfsVB08tFd9EupB4vtrR/1PwiRn
 vTISLo3F1lgGlw1iwKs2ZFOze9PoKSNdb14f4Hjogn2rxSgFW/65e3Ptgy2/pm1AkaRfcBRV2O5
 6zpeu+u9duVqDTn/spQjqF0WkH5hAkPVUFVYnRE/OasV3svCu9LluNezO+VGmtkDBIDNCAzErNP
 tp+eKoZ+Qw2PEq3xrwEmRdZe7coAGYwlu0slFvccoyHht/gv81XojvGW+n0I/AWZJ+fksPUoWsZ
 eOlbTpi/k0TzX+L+TMf/jI4h7CUDgviVAi5v+mZVTn1yHftceNyUpAhrZLQCSpXUPDigKkoHCIf
 8Fj1qbBRlTzfHdQuiCPZwL/Ir0kg+HHXCsOauZ7WDKsxFUQRYUwh2323oEvnvcMk+SLBPrRY773
 HZr3doRw61ud5CbWwJ+1Ree+kwIlHYc=
X-Received: by 2002:a05:7301:53cb:b0:35c:e696:2d4a with SMTP id
 5a478bee46e88-36a423ea99dmr1772736eec.24.1793333153319; 
 Thu, 29 Oct 2026 21:05:53 -0700 (PDT)
Received: from localhost ([122.172.82.240]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4291e38fsm3512579eec.15.2026.10.29.21.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 21:05:52 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:35:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Message-ID: <auQXnep2xKpuNJOF@vireshk-B250M-D3H>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
 <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
 <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28-10-26, 16:39, Rafael J. Wysocki (Intel) wrote:
> I'd expect the driver core to pick up the series as a whole then, so
> please feel free to add
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
