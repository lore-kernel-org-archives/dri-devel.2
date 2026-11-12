Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B3606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=oCXnwWIU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA86112231;
	Thu, 12 Nov 2026 16:57:58 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D014112231
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:57:52 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3b12cb3c37bso2272659a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1794502671; x=1795107471; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hUnOVjFYHGFbt1mgqPXrl0v314IpNkEBO0y4IzTD0JQ=;
 b=oCXnwWIUP25I6/XWCtEr7iTD90z5xWiX2EQ155D4p87yRYrNGVgmdhOSey0VWLeiJW
 pGaxKvPhLexJ4U4h1vHifl67YagLnPIbYmJYbuje4YrjrUtcMb5i5yf+bBa0Eu215vvV
 7wUtfyHzadYEzImeVnOCPPrOF+TcA9kTbFeXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794502671; x=1795107471;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hUnOVjFYHGFbt1mgqPXrl0v314IpNkEBO0y4IzTD0JQ=;
 b=JaG2YFZ9KC1hIM1f0oobb9BNsrJOiRzoLpX6hTg8hyhwXGNR2KiAsk2BF4voUXsUw4
 4vG2Ov74YeuKTwWcfy33dHuo2xV8P0en8mhGaoFwQcqL8Sd0fDCgYAMitGpaDkijgug6
 q2dni6zMyxTqqTODh0sfpwtYhwKa3Pj+ZkzxNzmY6yxPWmyKBCpNXrraLbPCrv8HNGFg
 J+0/x9LFfcoQowl3sXoAKGRbekzilrNw/sOmUxUoDxwyNrT2iK/KRXrsHbJfbIfh17jQ
 YZDYSl7fEXRyLszdwW3uxtp56r/3Lumnc0Ly6/nMzDbPDaWr5lho253svlIKmoMS7iQD
 PaAA==
X-Forwarded-Encrypted: i=1;
 AL+hErFgaKce2MN2QTKYpfXHGWTYTliCnXlABobMXQFzXQN3bX9otGv6bO/HW2irwrffidy+iruD+xU6hbU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+sWnvOKXha6LXvbVnX5ZVNC+QT3uwH2n0OI6z60xxsc/VL9mkd
 StClQz/hiKu26rDSeAA0ShxshB+UwLEXp44L2DBxjGhWAXyzNRM9VEGOIRj2Q7hXzuo=
X-Gm-Gg: AYBFou2/ZAIwGefuzS8BQ3L5Iju1h9qXeDTxRkHDhoy4Es07nkintbArM9EmNJkA31n
 OyqG7EN/yg3ewftksASTCBMGOSJq+lraVbQyOqYzodEsM1+L7GFZ5yc7kjMpdfxEgvwcz0CkVSb
 1ilp7hIh23FLW8pT9qmTTxOOkGguSmd9mNZ+NMPS2Skgftj9puQ/N8paGjmaIRBE8roIwfNSODh
 8GaoGCXnhQQToi2YsDjsSuHjE9g1Qr83hSe/u8cce0PN2+ZEA5pPh/cRO3R4XbuKwsP5aY0OC0d
 eybjFCojomkPI+VzhDdxbKoTS1+YN/JPpX2WdH0bk64wrJQ7SSflSnWbKJ21SCZKDtHN6OlRGS1
 rt2vaF33c/eVK6zSA+rcqguwGUgnHUckTI0ysTNOeE/k64p0zxCG1++tbn4rT9bZCEOil+XpzS/
 VkvaY7IPZVMko9QJhQteJ/ONRNJn9f7K8cwePa5H7c2njEXDrluJ/p8orCK52Epo2eF+pkoFD5p
 skS2qmuXJm/VA3M9STrFMvj7Wvkc8VUo7lEPQvV9wwrrozw4oO3DK+76A766FxYUA7khxVDmTdn
 cWkLwsN0cvIVuOjnRE95LiIlH+vmrE+dxB91YgbQ0l440xSUFwhKwa9WjKMADuRd8nsmjKfWijH
 T7iq3TfpFL33R
X-Received: by 2002:a17:90a:c110:b0:3ac:d39d:ee4f with SMTP id
 98e67ed59e1d1-3b182f58538mr5387882a91.44.1794502671465; 
 Thu, 12 Nov 2026 08:57:51 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aed76745sm163431a91.16.2026.11.12.08.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:57:51 -0800 (PST)
Date: Fri, 13 Nov 2026 01:57:35 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Gyeyoung Baek <gye976@gmail.com>, Philipp Stanner <phasta@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] accel/rocket: Report NPU usage through fdinfo
Message-ID: <avXv7jGeaXOPeHCR@rock-5b-plus>
References: <20261103155338.1949294-1-sidong.yang@furiosa.ai>
 <a9f016ce-f086-412d-9ca6-6608a41840e5@ursulin.net>
 <33ccceef-3498-426a-ae7c-a8bafbb88992@igalia.com>
 <2ca12f1b-89f6-4069-aedf-4e5d645e8deb@ursulin.net>
 <au31m2jC9SmQ6iZh@rock-5b-plus>
 <fc21d057-be4a-4cea-ab92-0951c4eb7de2@ursulin.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc21d057-be4a-4cea-ab92-0951c4eb7de2@ursulin.net>
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

On Thu, Nov 12, 2026 at 01:46:37PM +0000, Tvrtko Ursulin wrote:
> I am neither Philipp nor Danilo but I would say go for it.

Thanks, I'll send v5 with drm_sched_entity_get_runtime().

Thanks,
Sidong
