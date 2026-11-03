Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4C606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JstUnIh/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D8410E7C6;
	Tue,  3 Nov 2026 07:52:34 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4825E10E7C6
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:52:28 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so25575985e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 23:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793692346; x=1794297146; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6R7CNAZpahPnRPALzexY2OH6fEkMajMjI2gkDqsBlDU=;
 b=JstUnIh/M1ex9m7aEkRqfmAzfErpig5b3544+aKHbzY9CpnhpTdCl8bnQovEkUvBAl
 Tl24hiXTJcDC2YLzNjxA4TGIjRWH7O/bQ6321GzDCd14XUS/JYvm1SEQuzwRGJ8F7USe
 8Ty3BX2voZiib39GGnIU0u4i1qefPInvdU+v8JccMi3t+7tdV67RpseSUVH0/+GmLeXl
 P5yGZ3654sBcBIXefZNCg15tT1Uc4iBap4fr49RPyPgb5Xfj5kxHyPTgWiWWFVkL6ut1
 KzQZqivk3+KKbTMXopjzYfbNwvU05qOeKGpbUlhH03EU5QbWpSLsShJO2JyOgUq8ktwC
 xaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793692346; x=1794297146;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6R7CNAZpahPnRPALzexY2OH6fEkMajMjI2gkDqsBlDU=;
 b=cT7KCSpaDfh1TFZLRiWh2UYl2ZBUu61JWfWpB35gN7ZflNtkXsNqJrSTH5a5exQNCB
 VHb1JiBQ+N+xKSJqpNIRyZIXxT3YNP8ICgV/gn/VEMAM7YQfjpEhOPxSuD31UO4qxvMC
 oztZQZIOB4KXIQbSrLguKfeEhDOW7WNXRgA7iqpnuOX0OswQT41WDW67LqHtt9V5k7qg
 9jwi0/r1v47szPy6tB0A4PrkxZDS9m8hXvLBPzpPmhnza6csy5KkEpDf4axsz2VN8Gdv
 tKpmgEe6FKmX8BaafuQORLKEEGz1UOCjgW0DMlVqcm6jFHvo8FK9TICNPYkr0v2+i5YF
 pHWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5nWPmyyACohcrjTOEUYsUxcnFHHL7bDMWWr0lD7Ys1SvS6fZAGB/vDdJ4RFE+k7U1v7zfQHDNEqU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8qlr9lJDfF7VfiAUjDaTbG+x6m1CVIhmf9ZbmDlMVY3RZkL4hB
 uOeu01MKtpud9hYdVQ6OOaQcR7RMXnvqi527Odgd19Z+FvqqWnD//xiP
X-Gm-Gg: AYBFou3B59ydpZoPBYeL+Nw8W1whONgZZBUIV2zcYgyxntMJd2SVKFQWbwA4JNU/816
 vSMk1BB0bWMCAAWpP0N8MqCRKt9n0u8wszY8Wla32U5UqYLMDQ0h+/qmaxUtESfT2mP4LVhOFSO
 mZSiggePKJ5Ji6ZgRmwfHShRU+TixJLaPJS6N3cVpXtsq3J4iFao8qEn3Gew+5fTYlccNB2FGmo
 b/oSGe9+PbAJq4ysFh89G3Ie63gYY3zc02BMVHiVgEbSl2BVlZPIaChCISKKs2pvPRa+6D0tnX/
 Pz+M+VNq3OKCAATlxOBTt4KEb1RGETAUjnh+aDo28S20POMDa+U3qnqMC3D1pH4w/roCWceWIEj
 wipqfxGXQcAhg4292GnunyXOHEuuL4Pb0F1fIRVqvDLrn6aAiI7WPf9dbZgqNNTcoPZ4nSBpA/X
 Nh1gYaomQVvnXDkNbwDagjYoR79A0iLGYTbGpqsVG53JZmMPUz8hQ9WA8fh+V0LcmDet9ZoMuR7
 JaTELWZn0Mkj0V81kL7FktThrv1FKHiNpespTpA/MGZvo3BtYyWL9cSrFo2XIMMYNG/7YmLn167
 0nAIqGctmM0yP/golBjcBShEIQ12LZa9pmNZLyO2vtOcpM1jnWhq/9optQEa8JkUZbQq0wxU0Al
 /Azkz/VIIqxmgahB+jkWU7y86h9p5+H+lMiSwfahopyiw9q6LuLGQOg2H8QsQnn5G57eStWQTcT
 Tf7lrEPLNF1wY=
X-Received: by 2002:a05:600c:4e49:b0:4a4:6fdb:cc42 with SMTP id
 5b1f17b1804b1-4ac17b2c38bmr299232835e9.11.1793692346478; 
 Mon, 02 Nov 2026 23:52:26 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm37915295e9.9.2026.11.02.23.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:52:25 -0800 (PST)
Date: Tue, 3 Nov 2026 10:52:22 +0300
From: Dan Carpenter <error27@gmail.com>
To: Eric LI <eric.lee0305@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix space prohibited before that close
 parenthesis
Message-ID: <aumStg3EuhPbWkZu@stanley.mountain>
References: <20261031042315.1122699-1-eric.lee0305@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031042315.1122699-1-eric.lee0305@gmail.com>
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

I'm going to Ack this patch.  The other patches to silence this warning
introduced weird no-op macros but I feel like this patch does the right
thing.

Reviewed-by: Dan Carpenter <error27@gmail.com>

I don't really care if the patch gets merged or not, but in your heart
you will know that I approved it and hopefully that counts for
something.  :P

regards,
dan carpenter

