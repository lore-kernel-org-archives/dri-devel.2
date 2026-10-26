Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BF60A2600
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xve4SU9L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB86210E9D1;
	Mon, 26 Oct 2026 05:48:56 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF2F010E9D1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:48:49 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so2560066f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792993728; x=1793598528; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RYAYmmDh2YKbl8OgItUgUWB8sbjY7eRAlNwNblYFtjE=;
 b=Xve4SU9Lj7wJTJuptyU6R/ZmKe5z0TbzAhoa1f0Q6uYKGpSUnN4rMpEcop7mSIuzct
 fVD/nm/Z56i4BCt9FXoB8GUCd5ex8r4xBK2mt4KvxoCPYK7jVrQWda0/R8Y+Wcl7k/wI
 xCblybc+dHqtxUXFxl0rw/tuScZwNBfccQJi670N2wBHJw3sXpeMHPeXMdeD7CW46etl
 soDu/CO5XrqvYM69GCTk3XqLjIMYPG/xt8G93OKyAEMVc732D5vngz4pUPPtnE/ELBen
 nUwsvOcmz77+6/yekgOXpLTKj8XTiIld1/wiHUnqs9SUTZ9YgZ6oYLXfhnHV8Qey6Q5u
 tiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792993728; x=1793598528;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RYAYmmDh2YKbl8OgItUgUWB8sbjY7eRAlNwNblYFtjE=;
 b=tg8HOYYuEkYWSop7+7vQe7OSbDVd2wqCh9ZBm8DV1WySX3qeIiAjlJA9A7Cy+eZJ8G
 phsNpSfeOmt3jAkYhEc4HzyRUcZv4er/i/xmuPUYf4du8BCG8ZR42PbosOFOUmBVWR3B
 AiLsBc5HDTiDTLZDmr6EswHg4i8Y+17ORwxZynCiCdVHcdM5mQkkoBGvNcOm8xzymNgY
 JlTpmL2kWnXZvgatJGW1LAYMHxluSF40fXEmr2LQuIop9uNonFm7LWxvOIqD4Sv5T7Ck
 uWO2WsDJL5n0KSEOIRLR3pfL1SUMmoY7qaCSlTavk1et4HiOwf0snfd+Mcii4o4wq6xM
 Rg4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBylxReGiHiIsRYf6vgXLbBQSRFO1LjOzYKadxO8dUE8+UrXocl0mt+KNp0r2AgGHe1edwSFgdGadfQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6DIroJOUnIwi8Kz+/LvReNhKZOM8jHHCFNfu6T+QX3nOdLQy7
 omhDZINTXYnhLDCxr8j5ZTrrZaMUM0CqHcRepezNPJAXGvDf0fQbzNgl
X-Gm-Gg: AYBFou1BjQHuFAmjGdaM4DgaMLYP/EeIqd/KfNLqFri7vRg9ANEVdO5X9SE5yuFWQZu
 smjOoRvAafB71Bh74aWYGWSaIp5X3LunMpbL5rzw9PUKieRfsaxXAc0O+Odj/46ZVSk8v+ULM6Z
 qpYvEpAJNsco4GTCNPSQxkjK0sosJ8fSQ+ydbWaVmWtkSLM0Fw5a8FW/sMwcn0LjVr2Nzjhe2ti
 D8kJh4CoIvpFwB0cr2AHlm1V0biCxEgwSAfmKVSVFccNw8lrooFwTxC9VS1qkbfOO/LSkhhqBp7
 ESHUIrHN8G2567VreO5MyYcxPJ+5vHcLnISo201XntcERGelJb7owyiQMFRPtD0n4R0n79ifS35
 cIqWL/+QBo3eejVsYQ8pwqkLa8NX6wqB6aiEP9ggV29sV+pzfCfcljetxv4gHmy7wi9YYi3ACQw
 GGRhKSNocHSpY7iGyygwEd9EsBLCUuDdIb97JEvZuv/icZQBNi6CgtaVVGb9dtkYRluYQ4ERepO
 8wbgBCVWNXAU4M54XHIBie4zJtkHUP1BOgWLKOOGuPB9eQrn2q1VUxfqR1UTWDuTLy2mbfedA==
X-Received: by 2002:a5d:6184:0:b0:48e:22fd:1ea3 with SMTP id
 ffacd0b85a97d-48e3eb93665mr8333616f8f.28.1792993728187; 
 Sun, 25 Oct 2026 22:48:48 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb9cesm14713554f8f.27.2026.10.25.22.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 22:48:47 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:48:43 +0300
From: Dan Carpenter <error27@gmail.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
Message-ID: <at7pu4hldDTgZtXy@stanley.mountain>
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
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
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 10:10:03PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> Hi Andy,
> 

We don't need this in a commit message.

Also I would prefer to delete these weirdo debug messages.  The
normal dev_dbg() messages are good enough.  Plus, is this even
used?

regards,
dan carpenter

