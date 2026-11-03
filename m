Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD28606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UKQIHS6I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3728B10F6CA;
	Tue,  3 Nov 2026 16:06:11 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32AD910F6CA
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:06:05 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1b1ce85287aso2276112c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 08:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793721964; x=1794326764; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hSehECxM5OmeuNZLHLBGBNwYZB+YaKpkw0khTkFJZnw=;
 b=UKQIHS6IVGfgvNGJc+tBH6TTsIRX5SgJ1mGcwrD0ydp28PTMVFlZ29VLbTh5juch6u
 yJYbXGI6V3zoQmv1j/EFMkX5Y4Dii//sSQDhlfahW1oTxNQjw0+wetHhWrxyp+ogvR2a
 Hx2a7KtI3kuQdf4plIuhxIId+WlSisErCzgMa4dY2V2Ur0NKZEfLyfCltPvRNPHncQOo
 afm+prMza5dDg/BJ9ytOIQT1P7Mg7kI6X86zJ9EkAikJGncmm4DLIM4TT0vrHIBAjoud
 d4U74XdARwr6OZYNIRnJQwcNQdxsqOIAlMFdKv9YZ90bGghuVwn61RkglITPbIn8XUOi
 pcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721964; x=1794326764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hSehECxM5OmeuNZLHLBGBNwYZB+YaKpkw0khTkFJZnw=;
 b=rd0h8TpslgDW4HzwwrqmZXNvdxJ9G1HerQ96DyWxct4G4QKKwCj5izImwCJ9kN/PGK
 dKYWjCZC4DvOPJkqIC065SOHbYXZhjnRIMyfmFFtAy7EVNq01N83JQIpLSIDGcdOvAkR
 2BWTcL/ZeU9IdaTntgaL683s7QvLnBEiGNs9+7ppRa+J2lyGAOWRgh1/jC2BiIsfy9Ja
 NtAdhcwSSPmZSjL2w6/SZx49ObZpNT+mIZodPCczjApuGJoB9K9iJHJJRxwuWBTKNUMD
 tnz9i4Gh1C/mOAi8Hnd+AIPBUWtEywSUA0CI2bGKzyDv7nOYVQhruZCj0QHAE53soF98
 19MQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3Kfm+I2geOrBEOpGkb2Sp9pf2DG8ERGUltVPx41otJzYscw/F6O/oRbw6TMm3Dr909MPMWOX42Oc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9tNAY3B1QSKQYCxXBrf93c0YdXbijympOVK8iG5j+zeSg8Z/U/
 snWfJz5kRcHyspbSoR+5a7v55wkYSXKlHCccmQ+wBkCR6QF4IBkNA70=
X-Gm-Gg: AYBFou249P7I54/RqtnRQbChop8SyyMK4yBorfhl5LaqY5d0GI6F22sHegbMSwDqiiO
 I5EHrn9TkZdJiWYvMSQJ4frtDutSRyKRZprAOUCpsK+7MbqrPcl/JsNXclKBNNX2UBQmf/Wqjwy
 0G+chWhJSutcYHE4qiql55FYJIrQRUlnGmAK4qdVEXi2obsb986xsNtui07ayHcOtsQPtVVvRLh
 8enVRilrkHr/N4Otrl42AIIJBa+ej1UijM7cbzJOe7Twushded9Op8+vQUnr7RvwIgckJ//132u
 axv/6LMRUo6i3kb42qarD8OfQzJ4iYd8sY1gRGMEj7k/EgLLxPmiOjso2xqyNadtyB1ccynwGt4
 T2EWxXvasqhTDCEUN0MTZN/3i3vE0bBPqDYGJc8QQ0e0s15tSWG+BHjdSVOAE4QV0IL55jOxe9X
 paQNNfXrNQGE2pGGX6pJh85mk1DoacrTZE63Ul/wj0WY4zucvw8cNrjSSUM2oUEqbDnDE/jKJgV
 UOrKQEVrzcOlbzWTBDDewmnDHxmCNSnr+G/wmGODHpZvgQy4rEN0rCg2VpyalktzsqcYd2pSYHK
 hPum8kMMQ0G0yWbyUXcRq//xLWgOq797GiYpMDG5OCZZwsSXD2YmvKcQ9SmPEQ==
X-Received: by 2002:a05:7022:f20b:b0:136:c443:80e5 with SMTP id
 a92af1059eb24-1ac56d94b0amr21085882c88.6.1793721963966; 
 Tue, 03 Nov 2026 08:06:03 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.19.149])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm47910609c88.12.2026.11.03.08.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:06:03 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 christian.koenig@amd.com, dev@deq.rocks, dri-devel@lists.freedesktop.org,
 ed@aicharmers.com, kenneth.feng@amd.com, linux-kernel@vger.kernel.org,
 simona@ffwll.ch
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Date: Tue,  3 Nov 2026 11:05:53 -0500
Message-ID: <20261103160553.1431-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_NDJ7V=TQLOJ37msbmhwsVG+70mPKU3ns+xmAu9jxWwcg@mail.gmail.com>
References: <CADnq5_NDJ7V=TQLOJ37msbmhwsVG+70mPKU3ns+xmAu9jxWwcg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I forgot to remove the pptable check.  Can you try a simplified
> version of the patch?  I think all you need to do is delay the UCLK
> DPM enablement until late_init.  Something like the attached patch.
> 
> Alex

Also, i've tested this patch with the 5K patch, the UCLK then just never
gets initialized, so this patch is literally incompatible with 5K.

And also if ur wondering, what patch am i talking about you can see it here:
https://github.com/t2linux/linux-t2-patches/blob/main/7003-amdgpu-add-support-for-5K.patch

I still need to make combine patch (otherwise bad tearing in gnome/mutter), and i need to
enable 5K in EFI aswell to remove the shitty quirk to initialize display eariler than smu,
And make it usable with simpledrm.
