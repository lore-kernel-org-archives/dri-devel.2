Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1071C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905AD10F420;
	Thu,  9 Jul 2026 07:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="HaEE3nPf";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9AF10E52C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 23:42:56 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso31330a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1783467776; x=1784072576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NTsYOw6uHozsquujsNCqPDcOi1VuziUuLK4jzy115/c=;
 b=HaEE3nPfzYK8A6we1C/cLxDaf9Zr0uwk6MuGIRVZUfKUPwwld3UUyPHnA5GzTOD9qp
 iFNU8+tAtNxgILnApH8EiHyVZj15V89UshCtZFa8MHk7bl4w2+/mx+Jf2g4wY9QK18C7
 r4FckETGKGPhMw6pg1ktQMvJV6C/tNFwqCSL+JHCa77fLmuLd9A2stRJg1dijnFuWRyu
 FEC49nSq8xsck3XiANMLRbyB7pfE3MIq+d3ZfABqsyLlWHf4VU2pBGFGpeED4KJBAuve
 aj6idYJ6/qIxoC3nKywnZ8uf3ECgwGGfo9z6OPu1FGG8tqm3gsvsthXMcYTgdU7W1AIX
 7gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783467776; x=1784072576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NTsYOw6uHozsquujsNCqPDcOi1VuziUuLK4jzy115/c=;
 b=n0SS0emiQx91uH/wUlt7sY2faq6vq16RB85Asv4r0Hy47uAE25MGtypPeAGJME2vy3
 xmikugNM/rvmw82K88dEr06+tIcWX4J/8ZZfYVWux0V8zpO5PAjfT77sN+vQpSmwCv/p
 VL6wLOvsEFKdZGnp6PJ/EKvkvL3BSEQsiLUUAvoUBKm5Plt7Uh54PaCMl3p8YEnwvSxB
 7wqIvgQmvqNsCxkPjNCExnSzN6pTok/YmEcjKB9CjEHEzbr2ALoEmxbNqmFXtls6j+t4
 dEO6TakndsEJ6SmN4Ywt+oLKDZD/KHOfJQHztvhIHAygiR8Cg0LgDA4jyH3/X2Bc0aC4
 N+Kw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpnw+ijTXRSFnae9hCdIdjb4HC1Cb7nTd9i1d7uFnrONkFlSsTkhLFGNWvDZwZbw2wnxpu4f2zS298=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxV4oVeKwxZvwwakvjm3JvcyNdeEIz/VUfhdgTg4pMh2VVkRVf
 cdQxC0GsjfPGGF5Y3QTnZ48x1SSgtlui4pr6TLWdshwCNEohp5Dq7ZDvb8AlwVzgDhU=
X-Gm-Gg: AfdE7clRvahQWgvFmKUh0iBcQk/hRre8TtzZivWpuPw8eNGK36+ZBiqX0pgGKlcaoNT
 UofSTbVbn7YDEfANRto0j9uAAtM04xhT87I58q6cf8du6Z2F9iMpcFon3mBdKE/+pX8hrMS4V2/
 7x/9gdI4cjGtTjwT26Pep9sk7sBj3qr+wdNxOmODFZbvND8MnhsiKh3Snt98tqSdZO538v9jGqn
 A28HEzbtBNGuV+EEt+UJ3+nwgSKkuVvVymKmwTG4ZB5YwdjnAmAyzMvc+Pq7MPsFLGTEmI3jCWA
 eeFa6WAoZwU6/0+NgrraeXsAoBF8MTtkYl3v345fg1A04bEmhcM8dRhfX1AYiG5082G9ahE5SGL
 0Fc8WRJlcYpRt22Oo146TIWG1MZJY1W5k+mx7eI0Dh2QTbYXuQbilOovRyqhRZCcv3k3syS4qH7
 g=
X-Received: by 2002:a05:6a21:684:b0:3b5:6b5a:4f29 with SMTP id
 adf61e73a8af0-3c08ee38980mr7590280637.30.1783467775848; 
 Tue, 07 Jul 2026 16:42:55 -0700 (PDT)
Received: from arch-ideapad ([2804:7f0:3df:3dbf:fd10:7260:dc20:84b7])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ae6cd9sm13637822eec.31.2026.07.07.16.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 16:42:55 -0700 (PDT)
From: Ryan Oliveira <ryan.oliveiraf@usp.br>
X-Google-Original-From: Ryan Oliveira
To: ryan.oliveiraf@usp.br
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, kaikycintra@usp.br, simona@ffwll.ch
Subject: Re: [PATCH RESEND] drm/amdgpu: Unify vm_fault_interrupt_state logic
 for gmc v10 and v12_0
Date: Tue,  7 Jul 2026 20:42:21 -0300
Message-ID: <20260707234221.34738-1-ryan.oliveiraf@usp.br>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260616184209.18014-1-ryan.oliveiraf@usp.br>
References: <20260616184209.18014-1-ryan.oliveiraf@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi everyone,

Just a quick ping on this patch. Let me know if you need any changes or if there is anything I can do to help here.

Best regards,
Ryan O.
