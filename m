Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E413606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxJCM5AZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B6D10F031;
	Sat, 14 Nov 2026 16:25:09 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44AF710E533
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:42:06 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3b0b133f64fso241515a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794591726; x=1795196526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FpGkmju9BUnM+mqL/GQPdh5gnkQG1dpskYcN9mPG4ng=;
 b=bxJCM5AZ/XgjqdcFm/QL8YWAuikCE0QzXifeuAeJD/JKk6kKFlGmYJFkN3HGYUyysB
 fEjJfg55O9MPOH3zZm0564rgsY8ueCtkxJQ7oktYqKFAjfDrWgs2P6HR6LSWybQhwzb0
 iVt+DnOfsSvQ9jhdoV0YW2ldzg34HrguuUYJSfhRPu6ADJl5+JzapDqF/nTckuwEJgrX
 I9sn5IdYVzG9ZtkjJHtgI+ifxLeQd1QQCDP5OlrXO0gR8s6wuPmyQtJKm+FZSfy3kW+B
 ClWPOZi2ygOAcvKbB9rAG9Iu6hvRlgE50gPVC0DQf5Lgrn03U4tYmJBkq7l5p/BIPhoZ
 RZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591726; x=1795196526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FpGkmju9BUnM+mqL/GQPdh5gnkQG1dpskYcN9mPG4ng=;
 b=Gfj2Fn9UXMEOHxZBO5P16rYJNB9xCde3mLOGok1k+6iFD88hwjnCpnIhuuo9tzO1nm
 DIt7t2B4JzE8AzZVF7knZg5AMKhwYUBqWpVsc0ufngTMHLnU+6wsXBNJcI+S3c/hP3c3
 +lp+lleK12s21eLXVoZc7oXho0/+uqCGOBKVz8QNOiEzFgMyoqadkKdz5sOXcsdrJhna
 9sVHyFRbM/0DPch84sGktFRWv70M9vfgfsNig0zaUCEz4Qb9Qus94ZgiKwqTVNLG+oUW
 Aj+NcA/SWnM1oaY2AWIHKRZ4t63nAOqT1Hju0ofcDmUG0gYNNUlrj6scOznyYN9yQhhi
 NlMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFzTLehl4HQJDHpOnAM2Xs35Zxw5vwINwXPMePdXkiAIQWdTPhD4o8gG2ZGE3ugkgzrbRmUpTXNSko=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Uu6/QrbwumhgvqSk+nFdle1NdTncWrmJCKJv1oLfckQzXTjrv
 Pd/7rB8eHMEivc/5QK2CCqHgv4FXEWp4kY5pVYgmuSyE7pPZWrEjKOa4
X-Gm-Gg: AYBFou2N0kXXdIJLmMQ00LOesfqv6wCpSd4N/OOmlXxFcUVtE1vYrU+T1QnjfylhaWj
 F0tF1go9w5613fHeKkMmCVabtCbDFALBrte8wHOGBMZOS6rsZahzy7O5ljozFFP69YQwplDTgOV
 eP3rm+h7QFmfZ7ci+L0D1qRhMtvd/EH7nRKvNu5m0NZ7wcGrIHOdsN6W4Srq+YS8AVjhHwndd80
 xg6Xz36eShLtjg1husyTiQEMe8i6NmIzI5m3WVGebsj0YcaS1XFHJozQHejAhpbRDO5X1hf/ktU
 RknRA1K9fdamRHz/LPwWXQn61VH2Gb4JEPHGNrCOCehVXAxECXxCkgFxsQ4kbcoSj0ugW5sPwxD
 odCPbiK5a/Wsmxqydt58YVSgtsSJ/oow/P1ixnuFBGndIEaaL+RuQRYU+HET5oc+ElAudMju/QP
 6zgCJbBei6EjpffrkctzDcAFv37H2U5A+Feb4a4Rp7BCgERICKmFI6XXBe+3RQPM0W6VGK4ftZ0
 tdbXgQTjBtlVYa7ybSKX2QMtAwivzKoyaUGHN9dSJ2BjbsKP4SpX0METTw/+Kq+gfQHz1XSDK0y
 r5P4RRl1h3+DawlTOvmW3EmgahSQA5GEVLlQP8q1QxOyhtpxkrtwdJ/FCKmcM+1GblqkKIKaf4l
 kfKU=
X-Received: by 2002:a17:90b:1b06:b0:3a4:c895:570 with SMTP id
 98e67ed59e1d1-3b1b0a0e7c9mr4853217a91.4.1794591725731; 
 Fri, 13 Nov 2026 09:42:05 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aeb17042sm5289222a91.6.2026.11.13.09.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:42:05 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: sashiko-bot@kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panthor: Fix unlocked pool->vm access in
 panthor_heap_create()
Date: Sat, 14 Nov 2026 02:41:49 +0900
Message-ID: <20261113174147.10568620-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-213309@kernel.org>
References: <sashiko-outbox-213309@kernel.org>
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

On Fri, 13 Nov 2026 17:29:57 +0000, sashiko-bot@kernel.org wrote:
> - [High] drm/panthor: use-after-free of pool->gpu_contexts in
>   panthor_heap_grow() [1]

That pre-existing issue is addressed by a separate patch I sent before
this one. It takes pool->lock and checks that the pool has not been
destroyed before panthor_heap_grow() and panthor_heap_return_chunk()
dereference pool->gpu_contexts:

  [PATCH] drm/panthor: Don't access gpu_contexts of a destroyed heap pool
  https://lore.kernel.org/all/20261113162648.110226253-1-arpe1618@gmail.com/

The two patches are independent and apply in either order.

Thanks,
Jiwoo Kim
