Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE14C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F33210E193;
	Wed, 19 Aug 2026 18:16:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UsCx6d2C";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CAA210E193
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:16:38 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so11919325e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787163397; x=1787768197; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=etwYCc0YG/dlWmj1ZdGEpwanMrLp6se5hTk1lCrdgCA=;
 b=UsCx6d2CB8OWz03/DLdKmXtuNYovkkx0gPv9cTI07M/EauDSQUPzVB+eoQywF3ee7L
 aZpTWT/BDXE9yQ4Av7oJDPres7yfhvjqjt4UGgxuNHNyxOonnYrMyO7Nl6DHhk4Az1Ch
 PmXWtbnRhaKaCFs/YLOfLccZPuoIhGZf1DUmgpddAnGhng3ou4K2yjZgkYvsEauawmZW
 Imb3ZTjCJytQDn5xzPzv3ZwzCP+CjRd940OjQIolijHP3BSD7h3igjMPZnxMmbx0WM+z
 9xvY1Z8w7URQI4XgP2DMzBZM5a+FMjl7yq24yMFjsdo7+rKQi/SZyVWv1hvrZuoNvixg
 VQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787163397; x=1787768197;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=etwYCc0YG/dlWmj1ZdGEpwanMrLp6se5hTk1lCrdgCA=;
 b=rPEbCK1rW3l7Cxc0H0sV5p6uqutOmMS9sqdxsgBolvy4DVhf5Y3vnBfVJddthUe689
 MQPck9zxU5wm6K8xG+aKKr2tW5+oewyJl8QnHxZ9OJlzy00TQ/x3JIU3KaJCZE/Zr47k
 bINI0JVJd4bFSLSee+PGT6TF+vhPQ+U1LYrTiNHbE9oOxXeGw5abPXR9PTR/5an+iyS5
 0FsN8+PXq4LtJyZVISNPvUwGlfn3566qUCkCuB4RP521QrPsazdbI34nkt2HMrKQldim
 Ra+F4Gnezw1PkI6H4LfyxTThteX0MyARFWQK8lZwPIW6uE7t8vK1pf4eblzZH8tft7jB
 eTrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMh2C0CuaXRK/QGlPXWY6qNVJwZcbPeFPDEHg8aVEWW/uJc9tamJENrBYkKT/PC3MNusSXQWH0XaM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuPrWYODa4G41s5wNRLpQMhc6a3oR4mHOFLeMYjgyBjGLsOxKZ
 9N2gh6i3560k6ReB2cd1aaTFF26L12HfNVESO4PW65eJQBna84xVqCJ6
X-Gm-Gg: AR+sD12WHPSlbPmIvY/p12Gwda6kUBVUL/XMQPNuZ1pdaJXdR+JsJy4nHqDA9GXDEIM
 SR4x4NNR93z4q7tnhs2byP9DqL8+IUP0E6A19imjVHQHYnDce6KBk1rt+28y/fONhwvKTcBBh6s
 +NqbxCROVRtlC0AzjPpwlUNGwCqBS4wdrKsYqUrHGhJniiTZyTrE2QU8QJtvN1Hx1yIFQxbtbcS
 1gnwFayF4Bd2Igd2vOPbLhuEfXwfQ7hYyFB56E/HLIBOgMvzpExUN/4JeHm1Erqa/o4eW3VMxCV
 SEAaYuCXZ11CPBj/ZO0YE8R0+QfOONiQmyVO72Gr71HPvu6sJkJDVC8hnhdHqIvpA+U1xfqfvRC
 RUkf+uNM0GpaIZFYWgNfSSj7J4e2QEENs/9Evr9zoqHCXG1GiAiRabxJxY05Nu6aSNeI0W4+M49
 mPE1YAyoUxpPclXayYwQ0TUdibcH0pl0ODt0R31eIUr44qQ+6x+XnsKlrH
X-Received: by 2002:a05:600c:3590:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-499aa14a75bmr129238445e9.2.1787163396476; 
 Wed, 19 Aug 2026 11:16:36 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e784b3sm67635045e9.3.2026.08.19.11.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:16:35 -0700 (PDT)
Date: Wed, 19 Aug 2026 21:16:32 +0300
From: Dan Carpenter <error27@gmail.com>
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: prefer scnprintf over sprintf in
 fbtft-core.c
Message-ID: <aoXzALsRLqyqro8X@stanley.mountain>
References: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c.ref@yahoo.pl>
 <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>
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

On Wed, Aug 19, 2026 at 06:44:44PM +0200, Tomasz Unger wrote:
> Using sprintf has potential for buffer overflows if the formatted
> string exceeds the destination buffer size. Replace it with
> scnprintf, passing sizeof() of the fixed-size stack buffers
> (text1[50] and text2[50]) so the write is always bounded.
> 
> In practice an overflow is very unlikely here: text1 only needs

I don't have a problem with the patch, because I think making the
code easy to audit is helpful.  However, change "unlikely" to
"impossible".

18446744073709551616  KiB buffer memory
123456789 123456789 123456789 1234567890

spi-4294967296.-4294967296 at -4294967296 MHz
123456789 123456789 123456789 123456789 1234567890

The other thing is that scnprintf() is only for if we care about
the return.  Otherwise default to snprintf().  It's just a more
traditional choice.

regards,
dan carpenter

