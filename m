Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C93606A332
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hHxp2EVS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA9F10F022;
	Sat, 14 Nov 2026 16:25:02 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D0410E6D4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:53:45 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-8b0ca1ebc8bso8516137b3.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794560024; x=1795164824; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HO2iTktnMunjpM6KA5L9CB7sspcyboWd7WJFcra5aOw=;
 b=hHxp2EVSzAs2CdsiF+PoMUJwR2W9jZQIB88+ByCgYBXRWxgPLRBQ1djsqt/7g8y/+l
 fHqcY3qDo+gHQlbkZik+h9OOCRMrGF5wn+a8/NJ0IcbsxU16Pv3aRF9XFPCgpN8vvq4D
 L9+8M7JL9in8CYbJEQp/BI0KkX4HnlaOCy+mnyRX1TC7gvNCIWZEzNh8FKWpGCkit2ew
 dP/rmkolH4aScqn/w1Po6Stas1YNtmawWe6+VTxJHfpY1qcbjREHdfSwTzB6W9z+Ii8L
 T2BsZdMpGSYkhiQPS+Xn0n+TzqKhuNupiBGl49l8WjKlO2q5XWp6K+8OAkQ1A2kO0JNy
 BZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794560024; x=1795164824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HO2iTktnMunjpM6KA5L9CB7sspcyboWd7WJFcra5aOw=;
 b=jyRfcswHg9p2YFgIedx255SFqGYyfTROWHHanhc4caPQ+phU2SsfxIuThlOsHwoATI
 w0/iPOmT+LqAEjgW51dQ0sQn+spC0wkH0qSkNjqam7Tk/E6M440lAzc7TQ4FcvYPs1uX
 Mbfiu2x+pzYJ39jq7MVeZP6TfvEbO1lsGYvFQ5e6pp2FXJQT+UOoLOgFHQOjMh0Z4Tne
 DHtH078ih2MHmbh0HLa7McF9yxVbqktS8Htkvie7ZMfRRrcFpxV5SgbYIdR+dUTx4cHe
 ws/5Q1c8ri7NQRgtPq868XU4d447FzIkuAtx1KA3NwgV1yb17srmSmJglblGeroQ6rAS
 URCg==
X-Forwarded-Encrypted: i=1;
 AL+hErEr6UHp7Bn4V+Nori/xOR3TxSBH74guiHrqMG1TrmDD58QjMzgBvgdqTVRrVuuIP6Qy7fbImbj5ci4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8HKJOntniBle27gsQQjVYGfxrYDnwDdrmHj2n2gRVVdENDvJgZ
 CGya2c5jKITwCEKo+YNmhRT+lk/+YDjuGsmn+1NQcdAwNMATWsa2O40r
X-Gm-Gg: AYBFou1yzS8ojgRntWq2uIC+0OtHrS69oe7NUNPc3WGXE3QD6XVayBxfl29un2AZouX
 7eHQRml4DRTM1L3fA684AlAZmK8qkcm1Bc+53QFhBAoG7txYT3UBo2ibknD6UxVpu5Yb8oBHSjR
 FlOq/zqAQmpaka6ExM2ccTmTyok+HKQ1CELTol/xr/R8H/g47joumPs4rbFYL2iVZjVNfFydHTr
 5VhPThz7BoLiBO7gT0KitUTWGEZnvcfAiZpnfc7pIUGx7vmVG3z5lIk4M0cIwco90hPWfGuP3Wn
 B3XmqDExsM24JGbC0PquJSCZVxQqgJ/gP4OEz4sSirry7B2rVSCJVkMUXJCGFt0U8gd4ECm5tfi
 27gwv5CEo0YEQGWRR/LkRtJpwLHPzdC7OvmFtsFKIJBnWY9tZ0ueFyMoapHkvifYdrnZNsihUgc
 dx4q8XVuiAMV6NdxuyHrd8ApN2CN0IxXKXeh2BZfUO7slyyd9Pf7rXTRGNQw+5M4twPgWwV20Mo
 9fEVTYh4loNWIR3VpRlirc+TGhULxs+jJfn2bgblToBCrt+FIB7Et+soRJF6e6X/Zt/0vK/f1zW
 UL47p2NpqjBDT72WdcNFGoklgn+Ax/o6r527nlPcCnROy0WwJLIPRttYnnIgxGLGl3jP4GEJwXM
 KhKWeC3E70E/NKuJgd/7bkpvmlJ9om87cfQW8
X-Received: by 2002:a05:690c:289:b0:8b3:5969:f245 with SMTP id
 00721157ae682-8b4aa0cf2a7mr13409257b3.4.1794560023638; 
 Fri, 13 Nov 2026 00:53:43 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f1bb0sm15290487b3.9.2026.11.13.00.53.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 00:53:43 -0800 (PST)
From: Joseph Telaak <jttelaak04@gmail.com>
X-Google-Original-From: Joseph Telaak <jttelaak@hotmail.com>
To: operatingsystemsdepression@gmail.com
Cc: patrik.r.jakobsson@gmail.com, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, Joseph Telaak <joseph@telaak.dev>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
Date: Fri, 13 Nov 2026 03:53:41 -0500
Message-ID: <20261113085341.61992-1-jttelaak@hotmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joseph Telaak <joseph@telaak.dev>

On Fri, Nov 13, 2026 at 3:24 AM Patrik Jakobsson wrote:
> Clover Trail is not supported in gma500 so perhaps it's better to keep
> the SGX driver separated? You and Joseph should try to figure out how
> you want to do this together.

Agreed. With the SGX in its own render-only driver, it doesn't matter
which display driver sits next to it, so Clover Trail+ wouldn't need
gma500 at all.

Gabriel, this is how I'd see it, but I'm open to other ideas. The SGX5xx
cores have a lot in common: the MMU, the command and job model, the
parameter buffer, the PDS. powervr_sgx keeps a table of cores, so the
SGX535 on Poulsbo and Oaktrail, and later the SGX544MP2, could be
entries in it rather than separate drivers, and share that common part.
You've done the SGX535 work and know it far better than I do, so it
would make sense for you to maintain that core in the driver. I'd work
on the shared parts and on the multi-core support the SGX544MP2 needs.

The gma500 side of your series still stands either way: the dumb-buffer
size helper and the unpin underflow fix are good gma500 fixes on their
own. What would change is that gma500 hands the SGX over to the GPU
driver, the way the Cedarview patches in my series do, instead of
managing its MMU itself.

What do you think? Happy to go through the details here.

Joseph
