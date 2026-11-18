Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA4606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=U5j7htA7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A59510FC1C;
	Wed, 18 Nov 2026 14:16:46 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DE410FD10
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:16:39 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so8137515e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 06:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1795011398;
 x=1795616198; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MdqhR0kVJ3J0QEzp2gzz2WlKt7WKbgkXmTTR9acvdhY=;
 b=U5j7htA7t62WB1xqdVmRe6x5A/KYhjD/PyrjmIbmaSzFjg0HCEUdoSIgl+XiQH2jOH
 K7E7xkF6b9isVqBc2g+sPlKR7tNvDsOBMgg/VBy/kRZYcTc30zgbb8zHkIhQD1gl7zJP
 +me9MokRaswXi6Nz6hikQnxgKiTRjc/t/7tkeFE9j6zOQdVfIJl/YgN8LHRtccmSh/3v
 TNAwQsG+G/DxSIRrBzHRbBtFjgDT3QaJDtudhfIW/5vv1DHTu9JAUI1LM/bEm8jc6req
 oAk8x+KPGvr5YltWuUxHVkIxtZ3hpCv84BJXWR+MIkf/RVael8qrksQMZ6Auh6E6A3pN
 UtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795011398; x=1795616198;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MdqhR0kVJ3J0QEzp2gzz2WlKt7WKbgkXmTTR9acvdhY=;
 b=jZdOgQ4vyH0GCFRdybUMXQ4Y0VNegGNHR66P6AqGIbvx4ROlPBQmFB8gt4Uz8OxuP0
 4S0IoTJrOBGMeqIJHehfxgpeVWQvc/3gD80/6AfWBhOD3Mbi5glU2qOdi7W4AYikAGSq
 Kejha+x4PedbcgOX1WUnDRe41UGPkkil1VQpP8Ll5M1XHr3GZ8I0deUD+otx8lqV2IR9
 0slWZHlIx1Dj0YTOJkApqaHvwwJJHm72OFGaJtJ7+FI+VfNR/UDnWON5WHG4sbDnvOIj
 1graxW1KvLLkhFL/SlredpeV3QF7z3diqhZnmL1CEq0Atb0AlRPt1o/OChLHShQBOtKL
 Adng==
X-Forwarded-Encrypted: i=1;
 AL+hErHJLzdgD9yb/FgJ7D0dQlZRcoszQnbQGwhgWQcpcq/zaHGPpSSB1BhVOx76d2Mr/MYQAHV3wKY0Jm8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+2YkuugPE2EURBIsoR2Fz4wyBV24d10ALMKhW3uR5/7pfCxbh7
 E0fGfcchmSp7m3cA2Qy2GqEiWrs0tAzWaNnEwoEoW260LpEUnVnfYIOQahilrwK4aLQ=
X-Gm-Gg: AYBFou0Wa1Sgo43UzmdcXhwIxWQ1jlPITali1ZWcjpO7wbWSekeicf5su/d9WDhFAkG
 ZUmmZgFN3dZtou8m4wR2M7fifNLhs+rHBdN9hGUPB8sHy8FoM2d9IFgkmS0BnHYoyKcrS8ZZa02
 DVEvxUFcj6+uMHEhCVyUJy4Z73CYAbpyjr2HkmfDW0qfBUTf0KFGsF3tS8cGBS+vh+ShplvxUqJ
 wChw21/ldzeTfZRq3eaofzC+nuSXkYZe5WPn3th5GjrPFQFdpASbBUUtyN7KA3TzC6ODFRRe1v1
 08MH1VV9vZPtDnLjOW0cqUWbTWgNdHTjTGKe1Fpe35xZI/SNY6TRd28AO2zeIeNS86vNDORlBac
 J3k2DNrCk0d8phAwDXEszMTXI2reyGJPOKaifjIMPp4J/gm4RYTzOo9yzaEd2JO9hI2JzA0etxB
 dxmrpelIWjEQuEyvv+gCP9aoSsUQ8l13J3/azWrPO2ZYpjSwgDbFvz4bLwH4EjRWKzZGcsYhyAi
 wKPQeiFWQeqQlXtt17PlU8DmR30WU3P88KGakkYrNMUSV2QX7WR5QOwURfe4RTR2WBYCll6ocbq
 pOSyrC6t+ZjD2I7oS9yt5jER6DE4cCLj9Y/DHyM+DrP2HRrij10ajzulOf1IlsD+UBatT5qwfaS
 QUmXWMy/nczPJsOgfsw0Jd+lmF7hClJP5fo+ZdAWpBmkw/0b2gw==
X-Received: by 2002:a05:600c:46ca:b0:4bb:65ed:b55c with SMTP id
 5b1f17b1804b1-4bb7da3a66amr49458675e9.33.1795011398213; 
 Wed, 18 Nov 2026 06:16:38 -0800 (PST)
Received: from alcachofa.home (cst-prg-52-235.cust.vodafone.cz.
 [46.135.52.235]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7843bd79sm146337145e9.14.2026.11.18.06.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:16:36 -0800 (PST)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Pan Chuang <panchuang@vivo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Subject: Re: (subset) [PATCH 2/2] accel: rocket: Remove redundant dev_err()
Date: Wed, 18 Nov 2026 15:15:24 +0100
Message-ID: <179501127061.337132.6165313563775004882.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710105937.409992-3-panchuang@vivo.com>
References: <20260710105937.409992-3-panchuang@vivo.com>
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 10 Jul 2026 18:59:36 +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.

Applied, thanks!

[2/2] accel: rocket: Remove redundant dev_err()
      commit: fb191ef6265557469d04c327ea91f0df19ac6c4f

Best regards,
-- 
Tomeu Vizoso <tomeu@tomeuvizoso.net>
