Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8EC606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zbq5bxWy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D268D10E1FA;
	Fri, 20 Nov 2026 07:41:54 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0595210E159
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:41:48 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so3291355e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795160507; x=1795765307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vBrt0mozuLtvY7BO91id9yQTPz3DKVLN4yNObIuxwxI=;
 b=zbq5bxWy8bKwo39l6nWo7+vOJx9U00EHFKpkID0J4luuSclMmNLDie8vyx7MveCPsa
 gvQuybXD0TzpA/CCE4mldCOoKycVTxIaQhMaiUlLRgncQgIYMdnpcZaHLvHvYZ3UIWSc
 K/6a2VAZ7qKqIT+hI02gRvEjUR4peAncAUC3/NXs3BYZc3Z3GelNtd2yXhz+IU/8xxQI
 ZcyK6lB64/FQSg/d2ydyO8DiXrhbgYeq7vk9Bz7dF+w2h3sIQqWmR3hGxSXi08Kr97o0
 WzJLdhXfIJm2lCxspia3yaA2f3vwlwM1CmOpvvYZxI3i3RXgyEjkxmPwdr68m20PHpGF
 QYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160507; x=1795765307;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vBrt0mozuLtvY7BO91id9yQTPz3DKVLN4yNObIuxwxI=;
 b=VXsKUZlggRBchBMEd5zGan/KiBLnUMxZda0wJul+6Jj1WvsXfW+j1YD67eIWzEvE+E
 ZSwSpzbxAy1TcvD7P6UctkKC52sdXfFp+9cos7wpC15dsnJvZNRHujX3HOYtqZeQVmht
 4ZkgEBp/R/bj2BW3NUTzScpT80O5hI3LyQtGix2PeeXSuvR45wfcCxULML+dMJeq40pZ
 84qmVEEYZcyeAUanEQOI8alvsqA4iLPa+Y63TU6m8HbN0+hEKTWV2aNGM7eLNCtTy0k6
 tu6m4bwxTI3QOwHHa044kcn9kHC1kl7djjUHYW7LSievOs0tDIxLC7BtcIZYe04+kjvq
 T09A==
X-Gm-Message-State: APuU4Z+Kmz4OXUdX3JKq1BcVhXjlBkMfdUoikVKVsCwtG0a0EsGqR4ZV
 nuaNFRthfLq4fd7w67BkRuxiPMwyIqtxYm5W0jvAAYTlabHgOvkZ6jAF
X-Gm-Gg: AYBFou0rKN3inAV1zY+pMJG/Xg8EhSDaCM16z3LPT9dX4G9aiFPd+vHo68HoPv2upBw
 PFxezvfAZyfR3a5Z4UTu8+1+to+F3t5W+j5Lv9ToRANk9I3pLBfRzDg+qz+IDcixWh1ra2enCQe
 fqpHXhxKETgYHTAfNCpcUwyziT94InZQtuP2ARyENZT7Y/tuL2FplsvlS+WZyQkJK4cL2IBkXyZ
 40P9+4GIW6zhzkdv0sGZjI+KIbHGGOChDhnse3IQ4XNPuSOGJqFe1Ypjb0w+ZE1vCLi+hjwQYp3
 uypN3ZCyIZQdXlHokSnMEnCDNfJm+DsSTVPmNF+uNFYWnp9jh5pnSpQ6Zy48nePlFel1g5ZM7XA
 924pSiV//IGumKNqN40UYp+FOUOlnYdEkSgV7rzkgln89Ek+7/TpRA8WFchW41PacOq8z3b4gWX
 hDqlfi1mZ36sPMJ2RdK3HC7/CKiBHwsEk4t40aoRDfpQrxNRZVFe9GPpJwLb+2wDiT4easlbGSu
 3yWO/sxYl/UFLPuRUH+ilTWh4p8LScWRiqfG/Wq3ge7KRtvTm3FMctJijRFMlgeXMbIhj7+aPaD
 w456XobiaLVyQHgT70WERiA+2Hh4w2dgnQ==
X-Received: by 2002:a05:600c:4584:b0:4bb:6c71:b269 with SMTP id
 5b1f17b1804b1-4bb8881fbd2mr41170405e9.28.1795160507208; 
 Thu, 19 Nov 2026 23:41:47 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm71946305e9.6.2026.11.19.23.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:41:46 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Subject: Re: [PATCH] drm/vkms: fix empty gamma/degamma LUT divide-by-zero and
 plane format bounds
Date: Fri, 20 Nov 2026 08:41:40 +0100
Message-ID: <20261120074140.1041525-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20260919223509.3888763-1-benquike@gmail.com>
References: <20260919223509.3888763-1-benquike@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please split this; the changes are unrelated.
