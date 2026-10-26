Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149A606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PkUFjQUd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A989310E070;
	Mon, 26 Oct 2026 21:14:30 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7847010E070
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:14:24 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so29857165e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793049263; x=1793654063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rszKDmeyYp+Dq9ttmtnC0+XaYnbTJ3v9qyyrMyWHQC8=;
 b=PkUFjQUdHIFTkXa9Ys27N2aEYpL+fuGLRzali4pVGn2Qq02iXTNEo9wc4DOHQBHjGb
 qxPoGqNzStWtiSAAZOoRS1Xjo5Gy0P0ZNAmFV4KLG2Ls5MrcuAIxBoen/WjYHjxLzY6D
 NA1AHN/cN0dGdu7d9iRiihot7K8Xglg/HHLIQpkI+mitwCKSmGvW38XR/pBqKsE7rw+3
 44/jCb/f3OVfpxTanJ3Pg4R76XJ/M9ZsjibxjyqMNMjlYqNV534SbAbag0u30l0Is9tH
 eWzEFZcgjaepYtVeeNUdyFSPcqOvDUlnUG5qtpuSbP8stKyACkFKD4U6+QsFLu7QJh6Z
 z+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793049263; x=1793654063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rszKDmeyYp+Dq9ttmtnC0+XaYnbTJ3v9qyyrMyWHQC8=;
 b=OXXx21xygdaN+66vrq0mCSoVKGmp72hcrhtoXRdn+xb0IuQJzc9WWu0E8lsGJwYkht
 CWNHv+XwerrfhoNBgqRsPVs71U6pS2s4RXU+XTKTuHPPklD3DBZECAGW0ooUecSBagud
 +X6bpaL1fPDZSMqum/gTSsTjibJw0c4KQtBYsFyIvCL+G8S3RIqzUfh1AISHQLG8IxLe
 rSrsq9ejBU8Z5cyGp+wGq5XScjZLyjf/1HLHKIq4CkeyBbVDmQu4feobUgsv+g/qgsZ0
 dNXyF4au142nOAcTKIQe4W0lyaZZFMlezL/k2ruPXRRkngFriPTxQN3dr0XdKReufswA
 j24A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWlafWrjEZ5C1tbf41ER3jqszXXcPi6w6w+gy6DbGGC8qp4ZDYsk9KkW4K2xQlZcHxOvCBkxtay0U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL1Wx2oJWmYRsHa6VIWQ+CWJO4mz8zyh9g7secyFzBPgGo3y5c3
 ZfwpsFJ76uuK5aYRmef/4NwasOn0oRz09lMnWxCVeO1y/F+CelCqiRtD
X-Gm-Gg: AYBFou1rzcL3a9emK930naNmQoCTrPsdzAz9jmzWz/G7jWeJ63RnSoJ4D2CWaGsvs47
 8KfIB9ZMbTGD2xD+URwqJRKt9kw8uR4PBtqmMFxFsRTqpfHEKH9B3x5QPAA6+hXUYxo6r0iP7Zd
 4gbEc38cDNO2IouOrQntxJv6pJovP1H+Nfwob/05qCHEoWRygqVmpbBrSF76n3Gb1kMlt89SXz5
 mAtsY4SKMAROLzi5O1TPrLK1BsUMd/EpckVu0EqxINf/QuPpwSNaYkLYs/JIEw+aX6uO8i7+STp
 3hd23N6G1CWxp7GJXZdkEg5AIoESAqN8TQlV19ovToy4aQJehRNPC3VqgZrkWMJz0cGmkMCb6Nx
 fP9JBJU4yGZ0Bu+G3Zv9y8NnPK0CUSnWkh5nfqaR2cPEpoDZfjMUfne0YMXK45YLKQYQvX3AShf
 wwHwLZTds7/p9M+h0rbIvvOs/pHlxslOZUYcJbc9L0hhpwXAtLHjfGVtZ+7tIinmCcQoV8EfoDY
 TS1b5dP+y0GLP4zwmc7kye0O5LDRHLDv3OIUw1Y8ER6zo2g5bITGp5R6ZlhkQtow/7N
X-Received: by 2002:a05:600c:34d5:b0:4a0:2391:6540 with SMTP id
 5b1f17b1804b1-4a35aca2b53mr133051625e9.25.1793049262694; 
 Mon, 26 Oct 2026 14:14:22 -0700 (PDT)
Received: from fra-x8664.wind3.hub ([151.16.244.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a08dcbfsm145886715e9.2.2026.10.26.14.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:14:20 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau/clk: don't ignore RAM clock programming
 errors in nvkm_pstate_prog
Date: Mon, 26 Oct 2026 22:14:18 +0100
Message-ID: <20261026211418.351923-1-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260727152821.128432-1-postadelmaga@gmail.com>
References: <20260727152821.128432-1-postadelmaga@gmail.com>
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Lyude,

Gentle ping on these two.  The v3 of the cursor series is in v7.3 now,
thanks for picking it up - but these two don't show up in mainline or in
drm-misc-next, so I suspect they got lost after your review.

Both still apply on current mainline (one line of offset).  On
drm-misc-next 2/2 needs the v3 series to be there first, since its
context comes from "drm/nouveau/clk: don't use the pstate cursor after
the loop" - so either after the next backmerge, or I can rebase and
resend, whichever is less work for you.

Thanks,
Francesco
