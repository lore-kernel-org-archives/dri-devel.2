Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A4606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=ILp+aPhX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6093112E75;
	Fri,  6 Nov 2026 15:44:20 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32583112E73
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:44:14 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ae1da332bcso363345a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 07:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1793979854; x=1794584654; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kdSQ6gbIkbrqZrODfVj2GaSXZ9iZOLx1/t0MWwXpq7k=;
 b=ILp+aPhX0Imo9I5F63+5pwIn4Wveiu6XZYv4CeDd8IODLK3xskM++cj0/0Gq4Mc5fV
 p3xaN2y8XzBkhmMqmTtJEjXU+K5C6aHJUzbGa5XV+b10tEy6A7BYXFjIEspsyp/Ls21B
 3QkXS/YrAp7l2e9BQt164V6n/BFyKYlIRhZx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793979854; x=1794584654;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kdSQ6gbIkbrqZrODfVj2GaSXZ9iZOLx1/t0MWwXpq7k=;
 b=zl0QQT9nagJ6jH6LtNpf9+8flwAfcNnbz/X/kNQLcWdgikOeDVhB5cszv2LRyNFVnW
 wU/II0vXYc2+wTQP4HQMXjbFsz0VIy5EhQhK1S2R9YQejQGk7rNudxOMv48FmBmOaRyz
 tYCx96KahK63LcKEWdO6vIlw4RYi9BYnJVxkDoKo8B2GfG7+2GAP0rf89QH3xO+JHxst
 zpzMBXM8RL9akYER9Uukxo+rHW36AqjspcX28ooqZd5qDVN7hPs+T9DTL4HLqz2zeadQ
 bFRwfE+GF1lKxMe5xx0EHVFALdDFKvJETm+MjZHn4MdJlAl5wLQYDv418gKr7qLxirm+
 OmjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGFTCzemykA5o/0CS2uhu0S0MYEub05BgaXhyvcXq56AD9cwFx2ed+qA/eyoUaK0kpwA2xr485nRoo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z85274axQpQC9zJjrRgsBrfHaVkhRRGTdYOwjvs6UQnmTKAb+iJ
 F/LJqhKefI+7hTLKLpGUzw/VDIAircs+Q+CH16vEB47f5k+tuxpOkzkZaFLbTBYX43Q=
X-Gm-Gg: AYBFou346HcaVf48+RlLYOomYWpeMP9A6Ig/ORk38TYYc3qAxI8nzTjtVQEfTKoIlP2
 IuHCGOD4tErMluMuZ2mLJMJhkgmRHHUo9mBE0DiveBxR85ZnqJzv0XKN+wKO5CsIQX/KKqjtzlb
 /Evc3hN7efhk9ocojytXW+xPx7MGOykJPnJOhUw9a+oG6I5p3KBoAsJ2RGMI1cBoYxEvv3K/3WY
 VgRw8zdTfFLIXJ/hqIUuhC/jQRimZ1u6mB1TeeUQfb+bDCnOWToEqvPK08+BmCbiy4Ff2oxZ2Db
 ajCRZcreI0MOI1OOrb6b7EuoqlUlqpOd0cdI1Yw9qoIoGRJG7AJkfkQAZd09UVQFo474u2AVrBo
 8THLWv2pAyJHhrAOMe9W2tB3k2Lb8N5CgZtVhHEqGuHTqASw1VEKfXGR9Q0ZH9Gn6OhQYCkHtUi
 e8YkVZYYP4zQBqFqBrldQtvf59tuy4esL10Y+tll0GTPk9fJ0bIRjo24GaY/hb5XqFtkj9Hyyaw
 j23+V7syOtXlc7BkFLwMGs5kMXvmRlXXqKhCaQSLUwWrAQpbI6BMfevOePk1/xuExwtktJIkfXc
 zGRq1IguBwNeYiaevx/akJgDG1zy9OQIIV62CPYJKvWqALHETzUaLZxksttwlTPzJm9izFgkMcO
 exKFvujBWsjw=
X-Received: by 2002:a17:90b:57ce:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3b0db6e584fmr2823135a91.30.1793979854271; 
 Fri, 06 Nov 2026 07:44:14 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b326add7sm8301270a91.8.2026.11.06.07.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 07:44:13 -0800 (PST)
Date: Sat, 7 Nov 2026 00:44:08 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Gyeyoung Baek <gye976@gmail.com>, Philipp Stanner <phasta@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] accel/rocket: Report NPU usage through fdinfo
Message-ID: <au31m2jC9SmQ6iZh@rock-5b-plus>
References: <20261103155338.1949294-1-sidong.yang@furiosa.ai>
 <a9f016ce-f086-412d-9ca6-6608a41840e5@ursulin.net>
 <33ccceef-3498-426a-ae7c-a8bafbb88992@igalia.com>
 <2ca12f1b-89f6-4069-aedf-4e5d645e8deb@ursulin.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca12f1b-89f6-4069-aedf-4e5d645e8deb@ursulin.net>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 11:04:29AM +0000, Tvrtko Ursulin wrote:
> It would just be adding u64 drm_sched_entity_get_runtime(entity).
> Nothing else would need to be exported and the implementation simply
> locks entity->stats and returns the runtime. As long as the caller knows
> they haven't destroyed the entity it is safe since entity holds a
> reference to the stats object.

Thanks for the suggestion. If Philipp and Danilo are fine with it, may I
add drm_sched_entity_get_runtime() and switch rocket to it in v5?

Thanks,
Sidong
