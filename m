Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DD606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R2lzl+2w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D735C10E2B2;
	Mon, 26 Oct 2026 06:32:05 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE1210E2B2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:32:00 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so9271015e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792996319; x=1793601119; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GqcxNtiAZfNQOpaRDoKT3/3Dst2nVYU7A0CmkDZXaHQ=;
 b=R2lzl+2wJQnG67OalqfZptWUa0oSmXtLp4J+hJzAt7G6SnFpwprhhMP6yrA/gz5I8q
 TzyevPftwugKTdnONPxE/13wvxAaqAmbU/fX1u3HDELiFd4l+7/gn5m1JrVqRynx7+ZY
 6E8fyz2U1FxIdE0aFtlSWMtPSrKSsxw2F87u7urkZM8uMdaOw6JxjqTFhD/pO1cGwpmx
 AKO6P+Ld+l033tzjxaqlgDzn7PI+0t+l+7W1vZ3Vev25DPdhc16lY9CAv0RmsY9MkFVe
 bF3OQVhWSAKrQwvb8eyeslmhlNetJo27gEj2jEFXtP0SUcJQk0Bm56tjZf3v0AjaPMo/
 AE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792996319; x=1793601119;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GqcxNtiAZfNQOpaRDoKT3/3Dst2nVYU7A0CmkDZXaHQ=;
 b=tWg5GpdPOKNKRu5bqqZuDG9KswaHsBcegmZN0SHRBqH1kr492UUz6ImWTi/SdqpTGs
 Xa/BCyM9IOZJrC4tg86XtWZmKrnQNTymU79HxRp9zOWldQO5C1aUnzebhbWD/Zfs5NWf
 RwE+Gt8WbuBO08CJBEJ6wyPBxzw75OOB1yGn8usookVZzpjjxUtTmKHsr69kB7DEcX/2
 +FtVgw5rsMLM0Yx4diLkoKOxYrGraoXx8tgdlnC+IHJaWolisRf/K8jHf3upjGmvVdS7
 oHq1/WnjpUwj6mxn+ATEsHMo+rV1aJb9IMM4NEU1DlSxC6O8HOopCcFZhnV4T5BBIX0t
 TEzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKs1TW8B7KKPQND9xAn/47E/8FtgcaCMGieFXiaqgXA6rNOPcqnIN/lIkpRJBm1bnEzdQGG9QwG5E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTIFoALXoQgWDzS3kKIplXjW7CRuvzuRzIup+KU7BQWpT/V5iO
 C86RNFzTPrNSpxrPK9waNvQQKcmNndd6xY8LFnd+4BbtZ1IqJjy94wZVUzjBidtIUYnG7i1m
X-Gm-Gg: AYBFou2wOhPHmCk47z7aRtYgqIq/ZHkV1PwyJrGOYbo9hxNnyKyFH7/JetASmxShSHe
 259Ls888PLiC9xUYRbPgI6DywfZ1ikjQuo3be3wQ1maE+6U1oDrTi4bsGMXCmlPaUJkes9wuaEt
 ThSj9Y7a5z/hGZB5bOZtyq49mJta6xUyhuqHkYKlSAlV181+uN6q8WbcBmZ+XGli5Nyvw4Z/dm0
 dahXE8iVoFQrN9nMeS13uClp3owXcrM1TGdsc3LMJsBRRl0W1/ZTnRFrT9OWCwitn1zri+q8pSe
 crAFyJyIvMzIHJsAZUd5nh14R7DwFGSMeH4pplUJCGMiJhh47qvKL71hKA7yvUz3JfoWp162g+5
 j9CYPmLplnzEkZHmxRQx3DZM0mgfF/WjvdSQ/qjMkjLmFgx0kA9s3PmJGlzblJrGDYIZfaCsdsR
 YdKiMrlluEJSao00KfVMpruuHkxec69tPsI18qxDU/6S5NLMbcuz6yIWeWRA8OZyARsUgU6B8p6
 7uevwl88Gz8EQQWfLiq6PGKqBS2Hedi1aQibEfKdc1JAtaILQJH/A==
X-Received: by 2002:a05:600c:474a:b0:4a1:78c5:79f5 with SMTP id
 5b1f17b1804b1-4a35acb9afamr106677375e9.33.1792996318690; 
 Sun, 25 Oct 2026 23:31:58 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a58a293sm170484255e9.12.2026.10.25.23.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 23:31:58 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:31:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
Message-ID: <at7z2oubp02WQb1h@stanley.mountain>
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
 <at7pu4hldDTgZtXy@stanley.mountain>
 <CAGLmz9JaXM8s4BHQ2Cn5QQdBZpzDXmHyb-GQ_jXtj4Rz6SJOJQ@mail.gmail.com>
 <at7s7We7bxdmmmSM@stanley.mountain>
 <CAGLmz9+R5Wsd3i+7kLZXL-KP2bqdEmNUJTSKtZph_NSP92Jung@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGLmz9+R5Wsd3i+7kLZXL-KP2bqdEmNUJTSKtZph_NSP92Jung@mail.gmail.com>
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:46:48AM +0530, Himanshu Bakshi wrote:
> Hi Dan and Andy,
> 
> I have not found any call site for fbtft_init_dbg and just assumed
> that it might be useful later on as the driver develops. If you are
> considering removal of the macro, please let me know, I can send
> over a separate removal patch of the same.

Yes.  Please do.

(also no top posting)

regards,
dan carpenter

