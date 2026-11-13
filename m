Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E04606A88D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkpubr75
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B84710E654;
	Fri, 13 Nov 2026 00:59:14 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6C410E6D6
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:59:07 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1a2af4c8d00so38757c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794531546; x=1795136346; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
 b=kkpubr75a57EGUxxq1mYZUT42dul/FWSPvocw6KoZlTuAizxpjh8YdPmjLjCIPIVX1
 pr5mVdAi8gnEzrHQPSlZLAtrIyPCVMijIjfEW2P4Jsc69G7RlxjNoThPq9hPRXz8y6XP
 8am/kikmAMYFJZYjz1LW6Ryxiru46iB7s5OCYCCJjvgH0bjk4W4NFe3v0Bts/FD1h6P7
 qYOVhvAJc3dmDDhj8wukqailmiQK3sq3xheBmqZnMGJdkyKFbSHDvAvAbFfr8WtqxLdg
 rHGu6q70O9Nn+T+OJfDrPsLbdtMKzQ3uldU3qnEMhcW0E3dNu4LMfzA7jqHp1FtOFxFV
 nAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794531546; x=1795136346;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
 b=CF3WKPPAk2GTOX/obVGjBoClGa/xLIn31sqhbFHaPptfsx2kkjxGV5nLl+ROJ8W651
 MJOy6Pda0ptOf3boqfBzhhuSw+q4WySNuwkUMpYSuD1+4/tRKfKD7vdkr4k5FVxKVE83
 eGcfTdYbSAfKmYyG8D2scUXW20h/qgN/VsnqT9ZdemWyQpUY2p1KKwU6oOiRD4pcuiqG
 z+esxMO85SDgTXV/KP9Yp+bFRnW1LgJVFBxSSk9uHWk3/p9QUzeFCsPpl3UlfKf5d8NG
 MY19FpJjzmW04uY/QodwbFqnIOkzoLk2IXTwvHdaWZ1laHF8TI1+KR3nCInobJdH9j++
 mxbA==
X-Forwarded-Encrypted: i=1;
 AL+hErGrwRkWrmffttYJ59mwW24B2eho8Zw5dFrWx9FNoaGP2Cpj2R37DEyUPzEWJtkxnhQQcO9Zbt9zsO0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9vZJEihzLs6/CyITWZUSl4oWxoGbN3dud8QCzCQbKqSGA5GSWc
 kt7YSpqGYPfz1JHZlf79utPbRFu2vl0SbdLLdrcZX3Vy9iIScq9ohVoh
X-Gm-Gg: AYBFou3OqATONJxpNrkd9tvplJc1H8qOsTcTubUuStSefljrdqLelCGeo6RjmzqDgRs
 eqo+lroC1ZqrBqINqBjyVtVF1qhhquuw8lsRKq89zypbXrs6e1pyut+vGhgtzdcrRv8gRfq1A7n
 DsnYIX1vKvQVDjT3WKUtfMnPkRFAnfeyOG/gGsxkbHM9LrcUnzxfxgRwKeXeT8eZuY9/3owPGXI
 1fUzkRoBl/i7v5Zo/JrLcUTZmoiy/Wx2+bjuRCUxXwahkMMO9XbaovEQOTCCOg6npQC7nEiSS7s
 mHlrkdFhdzrkCBmox8inY/o2KRTIn7ETQjaYYGboKpWOuWHdNiPBO1ZivdwiwwzHeEOZDhA0xbN
 YPM2EkFS7wwqvMj3+ystcX2sKIfC8MxW24cF8OTWRK0kJdIwPgpvMkTsnX4OpILZ6ZW8EpP5J21
 vq8Ak/Jzr5F4vXZgQeJTHSf0rG5zN5CusY/E7vjV2LiSFhWzGx+V3HC3PWYCaXWM8EN3xnfFIEl
 Q9Rh1CJ585nFjv9f08/W4LRDspZJoVqxmzdqOZ/pZ8bUpsMyKQLs7ptWfEes8BLkgPiu2iDKZbC
 pwNpHXGvitbFavCxcRzqadXcINWBFU6iXJNQVDYiXt5We/VwgNPvfVBupbWdAfOZl6JbLXA=
X-Received: by 2002:a05:7023:a4b:20b0:149:1feb:6d9d with SMTP id
 a92af1059eb24-1b5030fb74emr1197809c88.19.1794531546379; 
 Thu, 12 Nov 2026 16:59:06 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50316e195sm2760431c88.8.2026.11.12.16.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 16:59:05 -0800 (PST)
Date: Thu, 12 Nov 2026 16:59:00 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: muzafferkadir@mainlining.org
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, David Heidelberg <david@ixit.cz>,
 phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-watchdog@vger.kernel.org,
 linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 10/11] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
Message-ID: <avZgzxJtnMceNQnJ@google.com>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
 <20261105-msm8952-initial-support-v8-10-311ae8e8f14b@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-msm8952-initial-support-v8-10-311ae8e8f14b@mainlining.org>
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 01:54:14PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> GT970 works with GT911 driver, document it to be
> used with GT911 compatible.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied, thank you.

-- 
Dmitry
