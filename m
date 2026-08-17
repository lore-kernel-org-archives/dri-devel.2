Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5561FC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E5810EBEE;
	Wed, 19 Aug 2026 06:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hf7go0QT";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CF310E7CE
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 13:15:13 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so2907855b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786972513; x=1787577313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GyZCF5uP4B3rvD8O5xkX/N4jG8v6SQk6Acn1gYu2ozE=;
 b=hf7go0QTh6oqHq0uuPvklVBgOOyDzSU0A7V5u1IELFVE5uc32/FyCRk3m99kgIflAy
 9XXYL0Gejm0Pix3qHthavIzXNIa4N0jWxuTtb9ELX/0ZIKG9ABb+IzPVw7E4qaWMGwyj
 H9LvYM3KswOwn9lBl3A48oOC48swVPWUMCVc2syNne5LezggQPIodh2+kNfzF+ZGRQye
 my/oLkHbT5NlhOqQEpAyVWcznjzVWaO+4rwbWK6ECFUJh08/almkTAiGed29t8HKB9Ox
 DW0UoEwe86ZTOA3Su4FcelTjvGRhlSNakNgw5Nfju9solgHdYnYwxskdVu/thXmPYWsK
 avBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786972513; x=1787577313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GyZCF5uP4B3rvD8O5xkX/N4jG8v6SQk6Acn1gYu2ozE=;
 b=hO56t2WrrpvXMfkgKIsjiUZjQLm4QjbvT0IYkFD/7/jBHj6+HNUPIZ5bGhFo5gRa2P
 UWOjsufcXISt4kXRHXHYtEXseZ46TCMHibYNuJYGWA2xzhfX740lcUYon7m+eSiWGkYo
 lY8PPKsJTkA6SAaniZycjl48HtXMD1vQSliag7cZGSBvzHLo6isuUjrz8uJqT+aEbPbZ
 z5vmDDr1jawHbKJGVptE4D6t0KHSnJp8Pp0jkIRWXSCyx+zFXNXqtqIEkdkurax0GW1P
 SzzjLP+BmGDeNKHSwK5/522cu91PzjwupxflJoY26MTcoBx18fDFksP1MrEBN5feszLJ
 n+kQ==
X-Gm-Message-State: AOJu0Yzq0hL1Beek46dH1woFucQR4EEK8HcHed2Qm5nsvbsrjyOamXs9
 H0alWBysH3brfjKVaxrc5EjYUg1nM1Yf2FSRYATmJjE48OIIK/4cZGs=
X-Gm-Gg: AR+sD10uBoi5mhpxTkAchP7JMuH9XgA1iysOFeJwcqbu/BRAd0urD6xhjPj2cTwt9zE
 afSqFvUt5YxkqCf7T5pumdROjYYhWxUoq5yp1Y6U6YpliSVu2LnjMnjGrk8+NMHPRuaXRxqH3qB
 okyLXLJXutaaRaDik0PiiqJNMep1FVOPyhyF0HEKKPHb/fqCa+tJmLR95ryaNiMB+aNpOhYUI5C
 hsBxt7jCEXjflYtXZlkkak1F9x5imqXKO2SmkcDyPC20CVlF7/04Hx1R6gc855RMCCBxp23tWSb
 UDI35HMqqKTYmgEIS4qODWICrcE7OBmb4UL/chiQZ04x7vx0Yn2rSVKVpMk9JYu9Sw7NfZC3LAj
 gjhqTHBo0bSwqnvDtNqE55KeGuP/qu1tXQX4vRVDnluEmY2rKfYa83xb0OL4V434Fy+IQWwjaP1
 iDOM1GYa2eFlcfz46lW1nyhIk+kbcHt8FI8ZVoBJgCI5oabWzZb8ry96xxUPNDFHIFwa0Q8eVIl
 y9JYM6/7UTb+vW1Nrw9LyRR/4XMfnET4ifQByD9of+jPw2k0Gl/fKkvnymXAy7P62MkGad7PNn5
 0wMeS2Kq
X-Received: by 2002:a05:6a00:f07:b0:847:9c06:2bef with SMTP id
 d2e1a72fcca58-84fde3e691cmr27536209b3a.29.1786972513281; 
 Mon, 17 Aug 2026 06:15:13 -0700 (PDT)
Received: from
 codespaces-2db70c.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([207.46.224.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc20dasm273457b3a.46.2026.08.17.06.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:15:13 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
X-Google-Original-From: Triet Hoang <89897892+HMTCT@users.noreply.github.com>
To: royalnet026@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, triet.hoang.dev@gmail.com
Subject: Re: [PATCH v2] drm/rocket: Check allocations before use
Date: Mon, 17 Aug 2026 13:14:59 +0000
Message-ID: <20260817131459.49019-1-89897892+HMTCT@users.noreply.github.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817093009.22359-1-royalnet026@gmail.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

From: Triet Hoang <triet.hoang.dev@gmail.com>

Hi Igor,

Thanks for the suggestion. I agree that keeping the allocation in rocket_file_priv 
would make the ownership clearer. I will implement this idea as a seperate patch.

Best Regards,
Triet
