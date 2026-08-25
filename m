Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7665C61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54CAE10EA38;
	Tue, 25 Aug 2026 12:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZg0WkzQ";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD48E10EA38
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:46:03 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c15b51ba80dso39194766b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787661962; x=1788266762; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZAN0remZKwTzPxuAENpiQH5fEVpl+tgiLHbVt5de6NI=;
 b=QZg0WkzQlz5rHbVbGAUqqcT5XvTmArV9Zipes9iJUgSqLVN+xnW4wd9ZcK4PLuqBXh
 ODqhjq6obG4sZ8h7auNyW+SHz/57Bkw2O1+JIJiEhdkmFO6ur9nOT5juSAN55/SAa88r
 0FMauMtamThdR2njevPu6rB6kaPCgnL/lGwAUEYo2FFfYQ/NQE+ZZL0nL2Isxkm9RT32
 HlO5nF0drZZ3tG5rYr95t2VhTA1FWaGJ4iiGaVNTJqViS7k6ws4708KVY5AvAk8UVnEP
 FltKExuENm3z1M0QS4FN0zY1eKd0zTk02eoYoWADsGCN3LtebOhQU0khXgUdG8+kDA+M
 stFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661962; x=1788266762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZAN0remZKwTzPxuAENpiQH5fEVpl+tgiLHbVt5de6NI=;
 b=OlLsrVpJ1u1NS5bf8ZElOGBSAg6UgaymXw8mmaNVq1JgBjeoDgrAANnzMAitt9W88k
 EPUuVM1VsjkYZ9FbcWNhWfdsb7kOWTlWiofvn82Yr1Hk7x49BmedBijTpYROhp4lkiTu
 6FjjdCH1eCxvZYcZW2PQK849amWK65OoBbsl7pasO0RFzMq6QY5H51bNEv6Joxpda6Kz
 S/F9xt6Ni7sry90zOqfFKlsxlJPKy4D9eIxBLhojnUA9ghMn3x8X6v9BfN0wGEO9PyYV
 nEYVEkJJcAwg5qdvpruzskMA4lPpOmyzY/KZdMLR0L+gr0GhwrCdHLUVqujkwD7NEk1j
 P+iw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0RbLNL9H1YkVvbVrrZeUhUUTW1dFv4Y5eatlQ/HkRSF7L0FgowS/QvXMCdDJeKjV94Y6dRZnV8eI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0KGI4fG/Qw18YoFjjGARhBvWbH6vwkDq87cuDaNOyl6k6FPCP
 kmfcH0jSMXdvDsdE35noKfoekHKfaGv1smaeft+BhfLt9kHhS77LnqII
X-Gm-Gg: AR+sD13iCZHpsJaijVxUphK7Ox75MEQ1MjUCwE8btQPCuFwWFGqWZY4aW+MhYuI+O7h
 +ubW+3lzmwacZPtvqcJ+sX+zUk6JpEk4aZTtBu69osUocWRLCtbdO7Sy1EmClz55ke8M0SNM2K9
 dB2Khl3OnuL9VUGrCDgpa20wuvuqk6N0311rwzbiSXWOdUlnm44STJLicrKKQKwg1mPIAhZdvAU
 ZcIPRARsl6GKEd66LYEdV02jdXItFoOZoKqemZREe5HpQQZNgrc0Ceu2wIoknLjX3yHTkpcSRUI
 SpqQRjUrWj/tnHwcoFzt6O7YZ43Jd4vMeLNO674eJWVe8+GzZptHBS4zT3yOWxhsSs3zhYe3DdS
 AUXvnngPMMjnf//1kMN9ts2mQ3cN0iyzhVeSZcTk2VF8ic+9vB6c4qMKZQDASR2tV8XLbQ521wo
 1szE0F4Ui6vFKvv/Fo7AZLbWJd5tJROC9si7XHJ118KFVIyGM0HGsLR6mNA76XI4a45AQILulLZ
 vXquUTqc30RpSdtY2m6oLxDeeDa/MFxEdyL
X-Received: by 2002:a17:907:d0e:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c246a65fe29mr2143386466b.4.1787661962050; 
 Tue, 25 Aug 2026 05:46:02 -0700 (PDT)
Received: from OrangePi5-Plus (178-223-53-162.dynamic.isp.telekom.rs.
 [178.223.53.162]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249629929dsm1824340566b.23.2026.08.25.05.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:46:00 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 03/13] accel/rocket: let the core suspend after a reset
Date: Tue, 25 Aug 2026 14:45:42 +0200
Message-ID: <20260825124544.11766-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAEWPSH5MVzoQMaFOEQ93+1pOPmcXCDNfuXsv5j-X8Lb1fy_hrg@mail.gmail.com>
References: <cover.1787568658.git.gahing@gahingwoo.com>
 <b5265e47492897d0ada844c2ff7f477bb715cd07.1787568944.git.gahing@gahingwoo.com>
 <CAEWPSH5MVzoQMaFOEQ93+1pOPmcXCDNfuXsv5j-X8Lb1fy_hrg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

My mail client wrapped the tag comment in the previous mail, which
would truncate the disclosure when the trailer is collected. Here it
is again, on one line:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2

Sorry for the noise.

Igor
