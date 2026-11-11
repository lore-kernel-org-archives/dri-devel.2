Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E255606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0364D89D39;
	Wed, 11 Nov 2026 09:37:18 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A330010F9A3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:55:30 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so1626011b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387330; x=1794992130;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kDDtfgXUqq2vWe9vI2nmZQX9n8pFv6185nZlpnia/WY=;
 b=h1Q3VfqBZtiJyXKMa3WMYlKU6hRHtuan+eAeffkUTtzbm2pcgjTin8o1PcKtVb7elf
 5B7M5NCP+XNhEZnwLBxkU8p4Dies2lE5pp5Rx1SNHaUnq4MaIsRK8pz7Q+xk2Hs9j3KY
 9Quye8LJ+Ti/Xt37qF0/dD4F5brvTeSn1qQr9P9viFsObRNzFjV17Bx+aIiVIL5iEo1m
 j4jTEYjIENN+7ZUzHPRwaoGUewkNxRI/IMkQjyKHyCeEDcqdipK7/IY8r3/7aDp3aR+K
 73OWgLbmWNNmtzmG0Ij6bLTGUXkx49lxWtFhBZ9qOvzQWgsF0Yaw8wUn1qGw+X8WfpxR
 tpVA==
X-Forwarded-Encrypted: i=1;
 AL+hErEy+UbsX+aWvTX62QUzLffHPUqsm0Ivr31VKxwJgrZKHxfkS44kBC5nXzg2zCKU89ZXhkek5UGxoKs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+LXg6mv+9vetGq80zXS0lpT8MXwVLug0/N6kgVffdJeCV26F/g
 3Sz6zIOxowsZVIUS7zyIlvNWjjKYoFYmNjvMBJXm1qEQE1mEj6/TCkRyxzNt3ETd
X-Gm-Gg: AYBFou1JQMi0E/PxQIIvqlbZRceoYb6dYRr9Y6Sob1WrRvzEPeaSdLeF/edcGmC2ClE
 PCHS6F57H5MsjkmQP6mfu/mA9WR7U86kSjOagPX83qupqtxmvvK3jwqeAX6pzXpjXoNdK4183z7
 2i9kH5LTKhMJoMlROVVKa+IIdI8ZpjM344pXw5whwkNd9sy4x9YQ2RyodVCFUqhmm/F4xrHJinf
 Gu6BAS63GQoC8Yp1e9PUBhX2cvpxlwrWQbnp4b8SaRbo3meZv/D/Qs/ErMLyaYdvz5Jd5qoW/5o
 rBWMEmcFoODg1SQ2Jl2jYlvhqmnRckPUF9a78x02/dUNRorBMvsViFidkLryfESPek90QCUOVND
 zGn0P3bqG+oSMNih9PgUnUR1aeQZ7JA0ySQjs2C5IaR1HA/wJazqJDRcjnw6B+N3dS3bv3vCMZm
 L1xWmOYs4t2hs8YycFZo2VerSkvqybo9T1MCV0e8O8YJ+glRjoWLRPOwdxO49+bXNpP+WiUv+Ta
 he/5WV+smgBiefOOKbEP6AaMigzCb6/skJwXr0Kwjn8v2ERuOBGgnYLd6n8fF9bmT+FfRNYUjNq
 FWOeGgu7A/n82M3eBXBR6vGZlpWZErhxxuocs3FEzzG0iv8y9z4FnWSiMbLnQbyko9lcqYxvs2P
 Wftm8ht4+eJ4R5pgoA8oSltB0eKIr3H/8ShP40q0vH6J/AXITkWMgMSDx+dJFFtQGxQ==
X-Received: by 2002:a05:6a00:e16:b0:89e:9d69:c0bc with SMTP id
 d2e1a72fcca58-8bc1d918e6amr1447513b3a.27.1794387330007; 
 Wed, 11 Nov 2026 00:55:30 -0800 (PST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com.
 [74.125.82.176]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaa1b27cdsm1810471b3a.19.2026.11.11.00.55.29
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 00:55:29 -0800 (PST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-37198ed3727so3669880eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:55:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErF3N9hUuh+vIQWcA4ORRuOvT+lAatuL+V595knyMQXOp1uQ/5NU4obpEdBQwB+YnfWm+H/z88WI3m4=@lists.freedesktop.org
X-Received: by 2002:a05:7300:bc86:b0:36c:a3ae:936e with SMTP id
 5a478bee46e88-37669a36d11mr3294547eec.5.1794387328621; Wed, 11 Nov 2026
 00:55:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110-sysfb-dirtyfb-v1-1-8571d455ccbe@telaak.dev>
 <215852e9-aafb-4ad2-93e8-afbadfd91fed@suse.de>
In-Reply-To: <215852e9-aafb-4ad2-93e8-afbadfd91fed@suse.de>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 11 Nov 2026 03:55:16 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ6rHjNGZ=5uuV_H=RyY9pceotPTzrnzMJ8hLCuwuz8PvA@mail.gmail.com>
X-Gm-Features: AclHuK-EsqBIwO9CGtat8AS-89hdImnJzEfTUQNfPyVgSSK9yYlt9MhNn6BdGfE
Message-ID: <CAPY4CJ6rHjNGZ=5uuV_H=RyY9pceotPTzrnzMJ8hLCuwuz8PvA@mail.gmail.com>
Subject: Re: [PATCH RFC] drm/sysfb: Copy damage outside the DIRTYFB ioctl
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 11 Nov 2026 09:37:13 +0000
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas,

Thanks for the quick review, and for explaining why the blocking
commit is required. That makes sense, so I=E2=80=99ll drop this patch and l=
ook
at handling it on the X side if it becomes a real problem.

Best regards,
Joseph
