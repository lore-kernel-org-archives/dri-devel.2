Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E43606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hlUurFJ0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B3A10EA50;
	Mon, 26 Oct 2026 06:02:34 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92FE10EA50
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:02:27 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so6662745e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792994546; x=1793599346; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3yaOxFuIZbizNooBA1VEmbpRjVSQUGZB/XbbboKN0bg=;
 b=hlUurFJ09I7h2wKngwVLWzSjeGJMtVym746+5ywtcvHbTa+J+wnxgQFux5llwJqXVK
 YMGuez3MLkMZHdC6jssDlmriQvy26H9rm1GjfwZUZUkoH+evfMRrQuSK+FVACo+203RE
 a1NJx1FFEwkouHRDJmh2QCVKvXCy+R+SAN+H2sOedFvhAFUxy3hyH0k/eG+cgLUzaPn9
 c1t/0YP76Yt8wsur9gCs3sjaozfGWdYr64EuXvcscXETVc9TPOQqCVapqKMnA/0RZ0o2
 pCwirBaleAX39AbMGuquwbc7IB7yPaxnleXUfzJcvwUmX0MjkqS0MjLDUiSAZUbZRGeo
 HFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792994546; x=1793599346;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3yaOxFuIZbizNooBA1VEmbpRjVSQUGZB/XbbboKN0bg=;
 b=KA7pcNd+yk0lDbztzCm2MX/2tbv4nvGMGbVRU/Q+keCy6qbfippp13jjQIG+R3Sh+j
 yz0v9sco52b7R67YFSWuhCB1Aek8azvhBog9RZ1uSSzBiB415HsCiQAG1kYcWrRy63ZW
 XhnxK5Xy9n/0mEt3T7gZWi5/8X3wysgrjTbvnkeJy3auW32AzuWp0QEofNfPuHxsZsg5
 ZQw2QsdJ19kxkQX92KSR1yEAX3qF2mkCkPTBE7FbbvEjaVh33uoLI49EfpdSkRtyjWY+
 dubHLfJ8qY0qOv2U3B4j5kRDeowCe74ZWur2csZAO1J6EjaqMQhsSzMU5CBVVVQOLIEu
 6Bxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF9+8BjloNCgT29C9NcAOycl08qIr26v38x7GFu/n+IUPCulqlVOVV5zCuVwcFec4mE6iPPoAjIec=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLNablT61Y+C9hYCxz5/mIEPlUmfrwpl0AmW24f4A67wRF3JcNc
 KQV29XUv9/ptYk23PKGlQlTfuYKcGU9Kz2F75v5LnAGNS0VJS5Z3gjyL
X-Gm-Gg: AYBFou1Le8tzRXV0UxQbT4loZ4RUYVQRZAHzd3mRUBCnIjtTqKdZCfGyOsdwVjDeMiC
 eo7y5IDXRt1kA+2F0hitxcs+fFG1h/Cl6YTgqODB1UKQ7B74/6GtX8suIjoOPnSTTXldOUT/ZLU
 KamT6mvUnV5cRBZGHchiztMLEXi6mbb8nOeRHadO5VutX2QLpEVXtbnItpg8jpbYADoL8rtCqB2
 gEAASJOxj95Puk5y18hQvsx7GGOH4bKXrSEdX+ksPnMMjn6cmtNRvyKApH+k7x/0iAkmvro9ZzR
 GmozgPDJCEL/Ok4G31RwjTf4BtHh5D6XtSxC91h5ZBZK1E12Vpe5uMGqBjRvoxsT1wHYEuYRj+p
 loWTSlXZ1eXr71EVxuVZGE372feNFAcCLxOOirC8bKdh9XAfcGxV9PN8K7D5P+I2iHfzMXWt/wI
 ooDIL4J8U2LcwRlx8t3p0jwOXcQBMLdqR4ehiNxhQF9hQ6Vs8xVVsjp9l3yKPYS4NAYPUckGUUc
 JPnw6kWg21jkewxuipZDhED76h0zDVCHXQC4UEIfQdeVlf+LzHf
X-Received: by 2002:a05:600c:4e8b:b0:4a2:180a:3417 with SMTP id
 5b1f17b1804b1-4a35ad01256mr111335215e9.1.1792994545819; 
 Sun, 25 Oct 2026 23:02:25 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm454920995e9.1.2026.10.25.23.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 23:02:25 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:02:21 +0300
From: Dan Carpenter <error27@gmail.com>
To: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
Message-ID: <at7s7We7bxdmmmSM@stanley.mountain>
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
 <at7pu4hldDTgZtXy@stanley.mountain>
 <CAGLmz9JaXM8s4BHQ2Cn5QQdBZpzDXmHyb-GQ_jXtj4Rz6SJOJQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGLmz9JaXM8s4BHQ2Cn5QQdBZpzDXmHyb-GQ_jXtj4Rz6SJOJQ@mail.gmail.com>
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

On Mon, Oct 26, 2026 at 11:23:21AM +0530, Himanshu Bakshi wrote:
> Hi Dan and Andy,
> 
> I have sent over the comment on the v1 message chain and
> also sent over the revised patch separately as v2, I will be glad
> if you will go through it.

The subject here says we are already discussing v2 so I'm confused.
You can go through my response and decide what still applies I guess...

regards,
dan carpenter

